package imgproc

//#cgo pkg-config: GraphicsMagickWand
//#cgo linux pkg-config: opencv
////XXX it is possible that some of cgo Warning flags are in conflict with cgo generated code.
//// If that is the case, then remove appropriate -W... flags here.
//// You can use -Wno-... format if problematic flag is implied with other flags (e.g. -Wall or -Wextra).
//#cgo CPPFLAGS: -Wall -Wextra -Wpedantic -Wno-unused-parameter -Wno-unused-variable -Wstrict-overflow=5 -Wshadow -Wcast-qual -Wpointer-arith -Werror
//#include <wand/magick_wand.h>
//#include <opencv/cv.h>
//#include <opencv2/imgproc/imgproc_c.h>
//#include <opencv2/core/core_c.h>
//
//#include "imgproc-encode.h"
//#include "fix_c_signals.h"
//
//
// void gm_init() {
//	InitializeMagick(NULL);
//      cgo_fix_signals();
//}
import "C"
import (
	"errors"
	"fmt"
	"image"
	"log"
	"log/syslog"
	"logger"
	"math"
	"os"
	"unsafe"
	//"image/draw"

	"common"
	"proto"
)

var (
	Log *logger.KoalaLogger // Global logger
	BUG func(value interface{})
)

func RGBA2Gray(rgba []byte) []byte {
	channels := 4
	rgbaLen := len(rgba)
	grayLen := rgbaLen / channels
	gray := make([]byte, grayLen)
	for i := 0; i < grayLen; i++ {
		b := float32(rgba[i*channels])
		g := float32(rgba[i*channels+1])
		r := float32(rgba[i*channels+2])
		//a := float32(rgba[i*channels+3]) / 255.00

		gr := 0.299*r + 0.587*g + 0.114*b
		//gr = a*gr + 255*(1-a)
		gray[i] = byte(gr)
	}
	return gray
}

func EncodingLevels(ce proto.EncodingType) uint {
	var bits float64 = 4
	switch ce {
	case proto.Encoding1Bit:
		bits = 1
	case proto.Encoding4Bit:
		bits = 4
	}
	return uint(math.Pow(2, bits))
}

func EncodingNoColors(ce proto.EncodingType, noColorChans uint) uint {
	return uint(math.Pow(float64(EncodingLevels(ce)), float64(noColorChans)))
}

func EncodeImage(inImage []byte, outEncoding proto.EncodingType) []byte {
	if outEncoding == proto.Encoding4Bit {
		return CEightToFourBit(inImage)
	} else if outEncoding == proto.Encoding1Bit {
		return CEightToOneBit(inImage)
	}
	return nil
}

func CEightToFourBit(inImage []byte) []byte {
	var encodedImage []byte

	inImageLen := len(inImage)
	//pad extra to fit
	extra := inImageLen % 2

	encodedLen := (inImageLen + extra) / 2
	encodedImage = make([]byte, encodedLen)
	if extra > 0 {
		inImage = append(inImage, make([]byte, extra)...)
		inImageLen += extra
	}
	C.encode_eight_to_four((*C.uint8_t)(&encodedImage[0]),
		(*C.uint8_t)(&inImage[0]), (C.uint32_t)(inImageLen))
	return encodedImage
}

func CEightToOneBit(inImage []byte) []byte {
	var encodedImage []byte
	inImageLen := len(inImage)
	//pad extra to fit
	extra := inImageLen % 8

	encodedLen := (inImageLen + extra) / 8 //XXX Round up
	encodedImage = make([]byte, encodedLen)
	if extra > 0 {
		inImage = append(inImage, make([]byte, extra)...)
		inImageLen += extra
	}
	C.encode_eight_to_one((*C.uint8_t)(&encodedImage[0]),
		(*C.uint8_t)(&inImage[0]), (C.uint32_t)(inImageLen))
	return encodedImage
}

//Sometimes we need to test results of encoding.
//Folowing functions do the oposite of EncodeImage.

func CFourToEightBit(FourBitImage []byte) (eightBitImage []byte) {
	fourBitLen := len(FourBitImage)
	eightLen := 2 * fourBitLen
	eightBitImage = make([]byte, eightLen)
	C.decode_four_to_eight((*C.uint8_t)(&eightBitImage[0]),
		(*C.uint8_t)(&FourBitImage[0]), (C.uint32_t)(eightLen))
	return
}

func COneToEightBit(OneBitImage []byte) (eightBitImage []byte) {
	OneBitLen := len(OneBitImage)
	eightLen := 8 * OneBitLen
	eightBitImage = make([]byte, eightLen)
	C.decode_one_to_eight((*C.uint8_t)(&eightBitImage[0]),
		(*C.uint8_t)(&OneBitImage[0]), (C.uint32_t)(eightLen))
	return
}

//Cut out small  IMAGE
func CutRectangle(rrect image.Rectangle, inImage image.Image) (image.Image, error) {
	var rectImage image.Image
	if inImage == nil {
		return nil, fmt.Errorf("no image")
	}
	if rrect == inImage.Bounds() {
		//Optimization
		return inImage, nil
	}
	/*cut rectangle image out of rectangle view*/

	//Select Image type
	switch inImage.(type) {
	case *image.Gray:
		rectImage = image.NewGray(rrect.Sub(rrect.Min))
	case *image.RGBA:
		rectImage = image.NewRGBA(rrect.Sub(rrect.Min))
	default:
		return nil, errors.New("Unknown image format")
	}
	//draw.Draw(rectImage, rectImage.Bounds(), inImage, rrect.Min)
	fmt.Fprintf(os.Stderr, "----- rectImage.Bounds: %+v\n", rectImage.Bounds())
	err := CvDrawOn(rectImage, rectImage.Bounds(), inImage, rrect.Min)
	if err != nil {
		return nil, err
	}

	return rectImage, nil
}

//OpenCV
func cvInspect(cvImage *C.IplImage) {
	if cvImage == nil || cvImage.imageData == nil {
		fmt.Println("bad image")
		return
	}
	tmp := C.GoBytes(unsafe.Pointer(cvImage.imageData), 40)
	fmt.Println(cvImage.width, cvImage.height, tmp)
}

//TODO GM functions can also profit if they would use this function for error checking.
func checkGoImage(inImage image.Image) error {
	inRect := inImage.Bounds()
	if inRect.Min.X != 0 || inRect.Min.Y != 0 || inRect.Max.X <= 0 || inRect.Max.Y <= 0 {
		return fmt.Errorf("cvFromGoImage: input Go image dimensions problem")
	}
	switch tmpIn := inImage.(type) {
	case *image.RGBA:
		if tmpIn.Stride < 4*inRect.Max.X {
			return fmt.Errorf("checkGoImage: inImage.Stride size problem.")
		}
		if tmpIn.Pix == nil || tmpIn.Stride*inRect.Max.Y != len(tmpIn.Pix) {
			return fmt.Errorf("checkGoImage: inImage.Pix buffer size problem.")
		}
	case *image.Gray:
		if tmpIn.Stride < inRect.Max.X {
			return fmt.Errorf("checkGoImage: inImage.Stride size problem.")
		}
		if tmpIn.Pix == nil || tmpIn.Stride*inRect.Max.Y != len(tmpIn.Pix) {
			return fmt.Errorf("checkGoImage: inImage.Pix buffer size problem.")
		}
	}
	return nil
}

func checkCvImage(cvImage *C.IplImage, expectedChans int) error {
	var (
		cvImageData *C.uchar
		cvStep      C.int
		cvSize      C.CvSize
	)
	C.cvGetRawData(unsafe.Pointer(cvImage), &cvImageData, &cvStep, &cvSize)

	if cvImageData == nil {
		return fmt.Errorf("checkCvImage: pixData == nil")
	}
	if cvSize.width <= 0 || cvSize.height <= 0 {
		return fmt.Errorf("checkCvImage: cvSize.width <= 0 || cvSize.height <= 0")
	}

	if cvSize.width*cvImage.nChannels > cvStep {
		return fmt.Errorf("checkCvImage: cvStep problem")
	}

	if expectedChans != 0 {
		if int(cvImage.nChannels) != expectedChans {
			return fmt.Errorf("checkCvImage: nChannels problem")
		}
	}
	return nil
}

func cvFromGoImage(inImage image.Image) (*C.IplImage, error) {
	var cvImage *C.IplImage
	inRect := inImage.Bounds()
	if err := checkGoImage(inImage); err != nil {
		return nil, err
	}

	w := inRect.Max.X
	h := inRect.Max.Y
	switch tmpIn := inImage.(type) {
	case *image.RGBA:
		tmpCv := C.cvCreateImageHeader(C.cvSize(C.int(w), C.int(h)), C.IPL_DEPTH_8U, 4)
		if tmpCv == nil {
			return nil, fmt.Errorf("cvFromGoImage: OpenCv header creation fail")
		}
		C.cvSetData(unsafe.Pointer(tmpCv), unsafe.Pointer(&tmpIn.Pix[0]), C.int(tmpIn.Stride))
		cvImage = C.cvCloneImage(tmpCv)
		C.cvReleaseImageHeader(&tmpCv)
	case *image.Gray:
		tmpCv := C.cvCreateImageHeader(C.cvSize(C.int(w), C.int(h)), C.IPL_DEPTH_8U, 1)
		if tmpCv == nil {
			return nil, fmt.Errorf("cvFromGoImage: OpenCv header creation fail")
		}
		C.cvSetData(unsafe.Pointer(tmpCv), unsafe.Pointer(&tmpIn.Pix[0]), C.int(tmpIn.Stride))
		cvImage = C.cvCloneImage(tmpCv)
		C.cvReleaseImageHeader(&tmpCv)
	default:
		return nil, fmt.Errorf("cvFromGoImage: Unsupported format %T", tmpIn)
	}
	return cvImage, nil
}

func cvToGoImage(cvImage *C.IplImage, goImage image.Image) error {
	var (
		cvImageData *C.uchar
		cvStep      C.int
		cvSize      C.CvSize
	)

	C.cvGetRawData(unsafe.Pointer(cvImage), &cvImageData, &cvStep, &cvSize)
	goRect := image.Rect(0, 0, int(cvSize.width), int(cvSize.height))
	switch tmpImage := goImage.(type) {
	case *image.RGBA:
		if err := checkCvImage(cvImage, 4); err != nil {
			return err
		}
		tmpImage.Pix = C.GoBytes(unsafe.Pointer(cvImageData), cvStep*cvSize.height)
		tmpImage.Stride = int(cvStep)
		tmpImage.Rect = goRect
	case *image.Gray:
		if err := checkCvImage(cvImage, 1); err != nil {
			return err
		}
		tmpImage.Pix = C.GoBytes(unsafe.Pointer(cvImageData), cvStep*cvSize.height)
		tmpImage.Stride = int(cvStep)
		tmpImage.Rect = goRect
	default:
		return fmt.Errorf("cvToGoImage: Unsupported format %T", tmpImage)
	}
	return nil
}

func cvFromGoImageNoCopy(inImage image.Image) (cvImage *C.IplImage, err error) {
	inRect := inImage.Bounds()
	if err := checkGoImage(inImage); err != nil {
		return nil, err
	}
	w := inRect.Max.X
	h := inRect.Max.Y
	switch tmpIn := inImage.(type) {
	case *image.RGBA:
		cvImage = C.cvCreateImageHeader(C.cvSize(C.int(w), C.int(h)), C.IPL_DEPTH_8U, 4)
		if cvImage == nil {
			return nil, fmt.Errorf("cvFromGoImageNoCopy: OpenCv header creation fail")
		}
		C.cvSetData(unsafe.Pointer(cvImage), unsafe.Pointer(&tmpIn.Pix[0]), C.int(tmpIn.Stride))
	case *image.Gray:
		cvImage = C.cvCreateImageHeader(C.cvSize(C.int(w), C.int(h)), C.IPL_DEPTH_8U, 1)
		if cvImage == nil {
			return nil, fmt.Errorf("cvFromGoImageNoCopy: OpenCv header creation fail")
		}
		C.cvSetData(unsafe.Pointer(cvImage), unsafe.Pointer(&tmpIn.Pix[0]), C.int(tmpIn.Stride))
	default:
		err = fmt.Errorf("cvFromGoImageNoCopy: Unsupported format %T", tmpIn)
	}
	return
}

func cvToGoImageNoCopy(cvImage *C.IplImage, pix []byte, goImage image.Image) error {
	var (
		cvImageData *C.uchar
		cvStep      C.int
		cvSize      C.CvSize
	)

	C.cvGetRawData(unsafe.Pointer(cvImage), &cvImageData, &cvStep, &cvSize)
	/* pix shild be the same buffer as one used by cvimage*/
	if unsafe.Pointer(&pix[0]) != unsafe.Pointer(cvImageData) {
		return fmt.Errorf("cvToGoImageNoCopy: pix slice shuld the same buffer as the one used by by OpenCv cvImage.")
	}

	if int(cvSize.height*cvStep) != len(pix) {
		return fmt.Errorf("cvToGoImageNoCopy: pix slice has wrong size")
	}

	goRect := image.Rect(0, 0, int(cvSize.width), int(cvSize.height))
	switch tmpImage := goImage.(type) {
	case *image.RGBA:
		if err := checkCvImage(cvImage, 4); err != nil {
			return err
		}

		tmpImage.Pix = pix
		tmpImage.Stride = int(cvStep)
		tmpImage.Rect = goRect
	case *image.Gray:
		if err := checkCvImage(cvImage, 1); err != nil {
			return err
		}

		tmpImage.Pix = pix
		tmpImage.Stride = int(cvStep)
		tmpImage.Rect = goRect
	default:
		return fmt.Errorf("cvToGoImageNoCopy: Unsupported format %T", tmpImage)
	}
	return nil
}

func CvTranspose(inImage image.Image) (image.Image, error) {
	var (
		outImage   image.Image
		cvOutImage *C.IplImage
		err        error
	)

	cvIn, err := cvFromGoImageNoCopy(inImage)
	defer C.cvReleaseImageHeader(&cvIn)
	if err != nil {
		return nil, err
	}
	//Output in same format as input
	outRect := inImage.Bounds()
	outRect.Max.X, outRect.Max.Y = outRect.Max.Y, outRect.Max.X
	switch tmpIn := inImage.(type) {
	case *image.RGBA:
		outImage = image.NewRGBA(outRect)
	case *image.Gray:
		outImage = image.NewGray(outRect)
	default:
		return nil, fmt.Errorf("CvTranspose: Unsupported format %T", tmpIn)
	}

	cvOutImage, err = cvFromGoImageNoCopy(outImage)
	defer C.cvReleaseImageHeader(&cvOutImage)
	if err != nil {
		return nil, err
	}

	C.cvTranspose(unsafe.Pointer(cvIn), unsafe.Pointer(cvOutImage))
	return outImage, nil
}

type CvFlipType int

const (
	CvFlipX  CvFlipType = 0
	CvFlipY  CvFlipType = 1
	CvFlipXY CvFlipType = -1
)

func CvFlip(inImage image.Image, flipCode CvFlipType) (image.Image, error) {
	var (
		outImage   image.Image
		cvIn       *C.IplImage
		cvOutImage *C.IplImage
		err        error
	)

	cvIn, err = cvFromGoImageNoCopy(inImage)
	defer C.cvReleaseImageHeader(&cvIn)
	if err != nil {
		return nil, err
	}

	outRect := inImage.Bounds()
	switch tmpIn := inImage.(type) {
	case *image.RGBA:
		outImage = image.NewRGBA(outRect)
	case *image.Gray:
		outImage = image.NewGray(outRect)
	default:
		return nil, fmt.Errorf("CvFlip: Unsupported format %T", tmpIn)
	}
	cvOutImage, err = cvFromGoImageNoCopy(outImage)
	defer C.cvReleaseImageHeader(&cvOutImage)
	if err != nil {
		return nil, err
	}

	C.cvFlip(unsafe.Pointer(cvIn), unsafe.Pointer(cvOutImage), C.int(flipCode))
	return outImage, nil
}

type CvOrtoRotation int

const (
	CvOrtoRotation0 CvOrtoRotation = iota
	CvOrtoRotation90
	CvOrtoRotation180
	CvOrtoRotation270
)

func CvRotateOrtoghonal(inImage image.Image, rotation CvOrtoRotation) (image.Image, error) {
	var (
		outImage   image.Image
		cvIn       *C.IplImage
		cvOutImage *C.IplImage
		err        error
	)

	cvIn, err = cvFromGoImageNoCopy(inImage)
	defer C.cvReleaseImageHeader(&cvIn)
	if err != nil {
		return nil, err
	}

	outW := inImage.Bounds().Max.X
	outH := inImage.Bounds().Max.Y
	if rotation == CvOrtoRotation90 || rotation == CvOrtoRotation270 {
		outW, outH = outH, outW
	}
	outRect := image.Rect(0, 0, outW, outH)
	switch tmpIn := inImage.(type) {
	case *image.RGBA:
		outImage = image.NewRGBA(outRect)
	case *image.Gray:
		outImage = image.NewGray(outRect)
	default:
		return nil, fmt.Errorf("CvRotateOrtoghonal: Unsupported format %T", tmpIn)
	}
	cvOutImage, err = cvFromGoImageNoCopy(outImage)
	defer C.cvReleaseImageHeader(&cvOutImage)
	if err != nil {
		return nil, err
	}

	if rotation == CvOrtoRotation90 || rotation == CvOrtoRotation270 {
		C.cvTranspose(unsafe.Pointer(cvIn), unsafe.Pointer(cvOutImage))
	}

	switch rotation {
	case CvOrtoRotation0:
		C.cvCopy(unsafe.Pointer(cvIn), unsafe.Pointer(cvOutImage), nil)
	case CvOrtoRotation90:
		C.cvFlip(unsafe.Pointer(cvOutImage), nil, C.int(CvFlipY))
	case CvOrtoRotation180:
		C.cvFlip(unsafe.Pointer(cvIn),
			unsafe.Pointer(cvOutImage), C.int(CvFlipXY))
	case CvOrtoRotation270:
		C.cvFlip(unsafe.Pointer(cvOutImage), nil, C.int(CvFlipX))
	default:
		return nil, fmt.Errorf("CvRotateOrtoghonal unknown rotation %d", rotation)
	}

	return outImage, nil
}

func CvToGrayImage(inImage image.Image) (*image.Gray, error) {
	var (
		outImage   *image.Gray
		cvOutImage *C.IplImage
		cvIn       *C.IplImage
		cvtCode    C.int
		err        error
	)

	cvIn, err = cvFromGoImageNoCopy(inImage)
	defer C.cvReleaseImageHeader(&cvIn)
	if err != nil {
		return nil, err
	}

	switch tmpIn := inImage.(type) {
	case *image.RGBA:
		//BGR is default CV order. Also WebKit produces BGRA images in reality.
		//cvtCode = C.CV_BGR2GRAY
		cvtCode = C.CV_RGB2GRAY
	case *image.Gray:
		img, err := CvCopy(tmpIn)
		return img.(*image.Gray), err
	default:
		return nil, fmt.Errorf("CvToGrayImage: Unsupported input format %T", tmpIn)
	}

	outImage = image.NewGray(inImage.Bounds())
	cvOutImage, err = cvFromGoImageNoCopy(outImage)
	defer C.cvReleaseImageHeader(&cvOutImage)
	if err != nil {
		return nil, err
	}

	//convert here
	C.cvCvtColor(unsafe.Pointer(cvIn), unsafe.Pointer(cvOutImage), cvtCode)

	return outImage, nil
}

func CvToRGBAImage(inImage image.Image) (*image.RGBA, error) {
	var (
		outImage   *image.RGBA
		cvOutImage *C.IplImage
		cvIn       *C.IplImage
		cvtCode    C.int
		err        error
	)

	cvIn, err = cvFromGoImageNoCopy(inImage)
	defer C.cvReleaseImageHeader(&cvIn)
	if err != nil {
		return nil, err
	}

	switch tmpIn := inImage.(type) {
	case *image.RGBA:
		img, err := CvCopy(tmpIn)
		return img.(*image.RGBA), err
	case *image.Gray:
		//BGR is default CV order. Also WebKit produces BGRA images in reality.
		//cvtCode = C.CV_GRAY2BGR
		cvtCode = C.CV_GRAY2RGB
	default:
		return nil, fmt.Errorf("CvToGrayImage: Unsupported input format %T", tmpIn)
	}

	outImage = image.NewRGBA(inImage.Bounds())
	cvOutImage, err = cvFromGoImageNoCopy(outImage)
	defer C.cvReleaseImageHeader(&cvOutImage)
	if err != nil {
		return nil, err
	}

	//convert here
	C.cvCvtColor(unsafe.Pointer(cvIn), unsafe.Pointer(cvOutImage), cvtCode)

	return outImage, nil
}

// Equalizes the histogram of a grayscale image, to increase the level range. In short it increases contrast.
// To do the same thing for RGB image we need to convert image rom RGB into one of the color space which separates intensity values from color (like HSV/HSL, YUV, YCrCb).
// We do this to increase contrast and preserve color tone at the same time.
//http://stackoverflow.com/questions/15007304/histogram-equalization-not-working-on-color-image-opencv
func CvEqualizeHist(inImage image.Image) (image.Image, error) {
	var (
		outImage   image.Image
		cvIn       *C.IplImage
		cvOutImage *C.IplImage
		err        error
	)

	cvIn, err = cvFromGoImageNoCopy(inImage)
	defer C.cvReleaseImageHeader(&cvIn)
	if err != nil {
		return nil, err
	}

	switch tmpIn := inImage.(type) {
	case *image.RGBA:
		outImage = image.NewRGBA(inImage.Bounds())
	case *image.Gray:
		outImage = image.NewGray(inImage.Bounds())
	default:
		return nil, fmt.Errorf("CvEqulizeHist: Unsupported input format %T", tmpIn)
	}

	cvOutImage, err = cvFromGoImageNoCopy(outImage)
	defer C.cvReleaseImageHeader(&cvOutImage)
	if err != nil {
		return nil, err
	}

	switch outImage.(type) {
	case *image.RGBA:
		ycrcb := C.cvCreateImage(C.cvGetSize(unsafe.Pointer(cvIn)), C.IPL_DEPTH_8U, 3)
		y := C.cvCreateImage(C.cvGetSize(unsafe.Pointer(cvIn)), C.IPL_DEPTH_8U, 1)
		//cr := C.cvCreateImage(C.cvGetSize(unsafe.Pointer(cvIn)), C.IPL_DEPTH_8U, 1)
		//cb := C.cvCreateImage(C.cvGetSize(unsafe.Pointer(cvIn)), C.IPL_DEPTH_8U, 1)
		// convert to YCrCb
		C.cvCvtColor(unsafe.Pointer(cvIn), unsafe.Pointer(ycrcb), C.CV_RGB2YCrCb)
		// split channels
		C.cvSplit(unsafe.Pointer(ycrcb), unsafe.Pointer(y), nil /*unsafe.Pointer(cr)*/, nil /*unsafe.Pointer(cb)*/, nil)
		// Equalize brightness intensity component.
		C.cvEqualizeHist(unsafe.Pointer(y), unsafe.Pointer(y))
		// merge YCrCb image back together
		C.cvMerge(unsafe.Pointer(y), nil /*unsafe.Pointer(cr)*/, nil /*unsafe.Pointer(cb)*/, nil, unsafe.Pointer(ycrcb))
		//back to RGBA
		C.cvCvtColor(unsafe.Pointer(ycrcb), unsafe.Pointer(cvOutImage), C.CV_YCrCb2RGB)
		C.cvReleaseImage(&ycrcb)
		C.cvReleaseImage(&y)
		//C.cvReleaseImage(&cr)
		//C.cvReleaseImage(&cb)
	case *image.Gray:
		C.cvEqualizeHist(unsafe.Pointer(cvIn), unsafe.Pointer(cvOutImage))
	}
	return outImage, nil
}

//finds region to fit in to src and dest image,
//decision parameters are destRect
// CvDrawOn uses this to modify regions
func cvFitRegions(destBounds image.Rectangle, destRect *image.Rectangle, srcBounds image.Rectangle, srcStart image.Point) (image.Rectangle, error) {
	// First sanity check
	if srcStart.X > srcBounds.Max.X || srcStart.Y > srcBounds.Max.Y {
		return image.Rectangle{}, errors.New("starting point outside source rectangle bounds")
	}
	if srcStart.X < 0 {
		srcStart.X = 0
	}
	if srcStart.Y < 0 {
		srcStart.Y = 0
	}
	if destRect.Min.X < 0 {
		destRect.Min.X = 0
	}
	if destRect.Min.Y < 0 {
		destRect.Min.Y = 0
	}
	//check dest bounds
	if destRect.Max.X > destBounds.Max.X {
		destRect.Max.X = destBounds.Max.X
	}
	if destRect.Max.Y > destBounds.Max.Y {
		destRect.Max.Y = destBounds.Max.Y
	}

	destRectW := destRect.Dx()
	destRectH := destRect.Dy()
	srcRect := image.Rectangle{Min: srcStart, Max: srcStart.Add(image.Pt(destRectW, destRectH))}

	//check src bounds
	if srcRect.Max.X > srcBounds.Max.X {
		srcRect.Max.X = srcBounds.Max.X
		destRectW = srcRect.Dx()
		destRect.Max.X = destRect.Min.X + destRectW
	}
	if srcRect.Max.Y > srcBounds.Max.Y {
		srcRect.Max.Y = srcBounds.Max.Y
		destRectH = srcRect.Dy()
		destRect.Max.Y = destRect.Min.Y + destRectH
	}

	if destRect.Max.X <= destRect.Min.X || destRect.Max.Y <= destRect.Min.Y {
		return srcRect, fmt.Errorf("cvFitRegions: Modified destination region is not valid %+v", destRect)
	}
	if srcRect.Max.X <= srcRect.Min.X || srcRect.Max.Y <= srcRect.Min.Y {
		return srcRect, fmt.Errorf("cvFitRegions: Source region not valid %+v", srcRect)
	}
	return srcRect, nil
}

func CvDrawOn(dest image.Image, destRect image.Rectangle, src image.Image, srcStart image.Point) error {
	var (
		cvSrc, cvDest *C.IplImage
		srcRect       image.Rectangle
		err           error
	)

	srcRect, err = cvFitRegions(dest.Bounds(), &destRect, src.Bounds(), srcStart)
	if err != nil {
		return err
	}

	// check if src image needs conversion
	switch tmpIn := dest.(type) {
	case *image.RGBA:
		switch tmpIn := src.(type) {
		case *image.RGBA:
			// live it like it is
		case *image.Gray:
			src, err = CvToRGBAImage(tmpIn)
			if err != nil {
				return nil
			}
		default:
			return fmt.Errorf("CvDrawOn: Unsupported 'src' format %T", tmpIn)
		}
	case *image.Gray:
		switch tmpIn := src.(type) {
		case *image.RGBA:
			src, err = CvToGrayImage(tmpIn)
			if err != nil {
				return nil
			}
		case *image.Gray:
			//leave it like it is
		default:
			return fmt.Errorf("CvDrawOn: Unsupported 'src' format %T", tmpIn)
		}
	default:
		return fmt.Errorf("CvDrawOn: Unsupported 'dest' format %T", tmpIn)
	}

	cvDest, err = cvFromGoImageNoCopy(dest)
	defer C.cvReleaseImageHeader(&cvDest)
	if err != nil {
		return err
	}

	cvSrc, err = cvFromGoImageNoCopy(src)
	defer C.cvReleaseImageHeader(&cvSrc)
	if err != nil {
		return err
	}

	var srcRoiRect C.CvRect = C.cvRect(C.int(srcRect.Min.X), C.int(srcRect.Min.Y),
		C.int(srcRect.Dx()), C.int(srcRect.Dy()))
	var destRoiRect C.CvRect = C.cvRect(C.int(destRect.Min.X), C.int(destRect.Min.Y),
		C.int(destRect.Dx()), C.int(destRect.Dy()))

	C.cvSetImageROI(cvSrc, srcRoiRect)
	C.cvSetImageROI(cvDest, destRoiRect)

	C.cvCopy(unsafe.Pointer(cvSrc), unsafe.Pointer(cvDest), nil)

	C.cvResetImageROI(cvSrc)
	C.cvResetImageROI(cvDest)

	return nil
}

func CvCopy(in image.Image) (image.Image, error) {
	var img image.Image
	switch tmp := in.(type) {
	case *image.Gray:
		img = image.NewGray(tmp.Bounds())
	case *image.RGBA:
		img = image.NewRGBA(tmp.Bounds())
	default:
		return nil, errors.New("unlnown image format")
	}
	err := CvDrawOn(img, img.Bounds(), in, image.ZP)
	if err != nil {
		return nil, err
	}
	return img, nil
}

//CvResixe is wrapper around
// http://docs.opencv.org/modules/imgproc/doc/geometric_transformations.html?highlight=resize#resize
//void cvResize(const CvArr* src, CvArr* dst, int interpolation=CV_INTER_LINEAR )
type CvInterpolation int

const (
	CvInterNN       CvInterpolation = C.CV_INTER_NN       //a nearest-neighbor interpolation
	CvInterLinear   CvInterpolation = C.CV_INTER_LINEAR   //a bilinear interpolation (used by default)
	CvInterArea     CvInterpolation = C.CV_INTER_AREA     //resampling using pixel area relation. It may be a preferred method for image decimation, as it gives moire’-free results. But when the image is zoomed, it is similar to the INTER_NEAREST method.
	CvInterCubic    CvInterpolation = C.CV_INTER_CUBIC    //a bicubic interpolation over 4x4 pixel neighborhood
	CvInterLanczos4 CvInterpolation = C.CV_INTER_LANCZOS4 // Lanczos interpolation over 8x8 pixel neighborhood
)

func CvResize(src image.Image, destSize image.Rectangle, interpolation CvInterpolation) (image.Image, error) {
	var (
		out image.Image
	)

	if destSize.Max.X <= 0 || destSize.Max.Y <= 0 {
		return nil, fmt.Errorf("CvResize: Bad resized image size %+v", destSize)
	}

	switch tmpIn := src.(type) {
	case *image.RGBA:
		out = image.NewRGBA(destSize)
	case *image.Gray:
		out = image.NewGray(destSize)
	default:
		return nil, fmt.Errorf("CvResize: Unsupported format %T", tmpIn)
	}

	cvOut, err := cvFromGoImageNoCopy(out)
	defer C.cvReleaseImageHeader(&cvOut)
	if err != nil {
		return nil, err
	}

	cvSrc, err := cvFromGoImageNoCopy(src)
	defer C.cvReleaseImageHeader(&cvSrc)
	if err != nil {
		return nil, err
	}

	C.cvResize(unsafe.Pointer(cvSrc), unsafe.Pointer(cvOut), C.int(interpolation))

	return out, nil
}

//GraphicsMagick helper functions

func GMInit() {
	C.gm_init()
}

func gmFromGoImage(inImage image.Image) (gmImage *C.Image, err error) {
	var (
		excp        C.ExceptionInfo
		formatStr   *C.char
		storageType C.StorageType
	)

	C.GetExceptionInfo(&excp)
	switch tmpIn := inImage.(type) {
	case *image.RGBA:
		formatStr = C.CString("RGBA")
		defer C.free(unsafe.Pointer(formatStr))
		storageType = C.CharPixel
		gmImage = C.ConstituteImage(C.ulong(tmpIn.Rect.Max.X), C.ulong(tmpIn.Rect.Max.Y),
			formatStr, storageType, unsafe.Pointer(&tmpIn.Pix[0]), &excp)
		C.CatchException(&excp)
	case *image.Gray:
		formatStr = C.CString("I")
		defer C.free(unsafe.Pointer(formatStr))
		storageType = C.CharPixel
		gmImage = C.ConstituteImage(C.ulong(tmpIn.Rect.Max.X), C.ulong(tmpIn.Rect.Max.Y),
			formatStr, storageType, unsafe.Pointer(&tmpIn.Pix[0]), &excp)
		C.CatchException(&excp)
	default:
		err = fmt.Errorf("gmFromGoImage: Unsupported format %T", tmpIn)
	}
	return
}

func gmToGoImage(gmImage *C.Image, goImage image.Image) error {
	var (
		excp      C.ExceptionInfo
		formatStr *C.char
	)
	C.GetExceptionInfo(&excp)
	goRect := image.Rect(0, 0, int(gmImage.columns), int(gmImage.rows))
	switch tmpImage := goImage.(type) {
	case *image.RGBA:
		formatStr = C.CString("RGBA")
		defer C.free(unsafe.Pointer(formatStr))
		storageType := (C.StorageType)(C.CharPixel)
		buff := make([]byte, int(gmImage.columns*gmImage.rows*4))
		C.DispatchImage(gmImage, C.long(0), C.long(0), gmImage.columns, gmImage.rows,
			formatStr, storageType, unsafe.Pointer(&buff[0]), &excp)
		C.CatchException(&excp)
		tmpImage.Pix = buff
		tmpImage.Stride = int(gmImage.columns) * 4
		tmpImage.Rect = goRect
	case *image.Gray:
		formatStr = C.CString("I")
		defer C.free(unsafe.Pointer(formatStr))
		storageType := (C.StorageType)(C.CharPixel)
		buff := make([]byte, int(gmImage.columns*gmImage.rows))
		C.DispatchImage(gmImage, C.long(0), C.long(0), gmImage.columns, gmImage.rows,
			formatStr, storageType, unsafe.Pointer(&buff[0]), &excp)
		C.CatchException(&excp)
		tmpImage.Pix = buff
		tmpImage.Stride = int(gmImage.columns)
		tmpImage.Rect = goRect
	default:
		return fmt.Errorf("gmToGoImage: Unsupported format %T", tmpImage)
	}
	return nil
}

// floid steinberg dithering
func GmFloydSteinbergDither(inImage image.Image, numLevels uint, mesureError bool) (image.Image, error) {
	var (
		excp          C.ExceptionInfo
		inGmImage     *C.Image
		outImage      image.Image
		quantize_info *C.QuantizeInfo
		err           error
	)
	inGmImage, err = gmFromGoImage(inImage)
	if err != nil {
		return nil, err
	}
	defer C.DestroyImage(inGmImage)
	C.GetExceptionInfo(&excp)

	quantize_info = C.CloneQuantizeInfo((*C.QuantizeInfo)(nil))
	defer C.DestroyQuantizeInfo(quantize_info)
	// http://www.graphicsmagick.org/quantize.html
	// http://www.graphicsmagick.org/api/types.html#quantizeinfo
	quantize_info.number_colors = C.ulong(numLevels)
	quantize_info.tree_depth = 0
	//quantize_info.colorspace = C.RGBColorspace//inGmImage.colorspace
	quantize_info.measure_error = 0
	if mesureError {
		quantize_info.measure_error = 1
	}
	quantize_info.dither = 1 // select Floyd Steinberg
	C.QuantizeImage(quantize_info, inGmImage)

	C.CatchException(&excp)
	//Output in same format as input
	switch tmpIn := inImage.(type) {
	case *image.RGBA:
		outImage = &image.RGBA{}
	case *image.Gray:
		outImage = &image.Gray{}
	default:
		return nil, fmt.Errorf("GmOrderdDither: Unsupported format %T", tmpIn)
	}
	gmToGoImage(inGmImage, outImage)
	return outImage, nil
}

// orderd ditheing
func GmOrderdDither(inImage image.Image) (image.Image, error) {
	var (
		excp      C.ExceptionInfo
		inGmImage *C.Image
		outImage  image.Image
		err       error
	)
	inGmImage, err = gmFromGoImage(inImage)
	if err != nil {
		return nil, err
	}
	defer C.DestroyImage(inGmImage)
	C.GetExceptionInfo(&excp)
	C.OrderedDitherImage(inGmImage)
	C.CatchException(&excp)
	//Output in same format as input
	switch tmpIn := inImage.(type) {
	case *image.RGBA:
		outImage = &image.RGBA{}
	case *image.Gray:
		outImage = &image.Gray{}
	default:
		return nil, fmt.Errorf("GmOrderdDither: Unsupported format %T", tmpIn)
	}
	gmToGoImage(inGmImage, outImage)
	return outImage, nil
}

func GmToGrayImage(inImage image.Image) (*image.Gray, error) { //XXX tests, live-view
	inGmImage, err := gmFromGoImage(inImage)
	if err != nil {
		return nil, err
	}
	defer C.DestroyImage(inGmImage)
	grayImage := &image.Gray{}
	gmToGoImage(inGmImage, grayImage)
	return grayImage, nil
}

func GmRotateImage(inImage image.Image, degrees float64) (image.Image, error) { //XXX  tests
	var (
		excp           C.ExceptionInfo
		inGmImage      *C.Image
		rotatedGmImage *C.Image
		rotatedImage   image.Image
		err            error
	)

	C.GetExceptionInfo(&excp)
	inGmImage, err = gmFromGoImage(inImage)
	if err != nil {
		return nil, err
	}
	defer C.DestroyImage(inGmImage)
	//Rotate using graphics magick
	rotatedGmImage = C.RotateImage(inGmImage, C.double(degrees), &excp)
	defer C.DestroyImage(rotatedGmImage)
	C.CatchException(&excp)

	//Output in same format as input
	switch tmpIn := inImage.(type) {
	case *image.RGBA:
		rotatedImage = &image.RGBA{}
	case *image.Gray:
		rotatedImage = &image.Gray{}
	default:
		return nil, fmt.Errorf("GmRotateImage: Unsupported format %T", tmpIn)
	}
	gmToGoImage(rotatedGmImage, rotatedImage)

	return rotatedImage, nil
}

type GmCompositeOperator C.CompositeOperator

const (
	GmUndefinedCompositeOp GmCompositeOperator = iota
	GmOverCompositeOp
	GmInCompositeOp
	GmOutCompositeOp
	GmAtopCompositeOp
	GmXorCompositeOp
	GmPlusCompositeOp
	GmMinusCompositeOp
	GmAddCompositeOp
	GmSubtractCompositeOp
	GmDifferenceCompositeOp
	GmMultiply
	GmBumpmapCompositeOp
	GmCopyCompositeOp
	GmCopyRedCompositeOp
	GmCopyGreenCompositeOp
	GmCopyBlueCompositeOp
	GmCopyOpacityCompositeOp
	GmClearCompositeOp
	GmDissolveCompositeOp
	GmDisplaceCompositeOp
	GmModulateCompositeOp
	GmThresholdCompositeOp
	GmNoCompositeOp
	GmDarkenCompositeOp
	GmLightenCompositeOp
	GmHueCompositeOp
	GmSaturateCompositeOp
	GmColorizeCompositeOp
	GmLuminizeCompositeOp
	GmScreenCompositeOp
	GmOverlayCompositeOp
	GmCopyCyanCompositeOp
	GmCopyMagentaCompositeOp
	GmCopyYellowCompositeOp
	GmCopyBlackCompositeOp
	GmDivideCompositeOp
)

func GmCompositeImage(canvas image.Image, operator GmCompositeOperator, composite image.Image, offset image.Point) error { //XXX live-view
	var (
		gmCanvas    *C.Image
		gmComposite *C.Image
		err         error
	)

	gmCanvas, err = gmFromGoImage(canvas) //XXX takes time of 2.5 ms for 600X800 Gray image
	if err != nil {
		return err
	}
	defer C.DestroyImage(gmCanvas)
	gmComposite, err = gmFromGoImage(composite) //XXX takes time of 2.5 ms for 600X800 Gray image
	if err != nil {
		return err
	}
	defer C.DestroyImage(gmComposite)
	offsetX := C.long(offset.X)
	offsetY := C.long(offset.Y)
	cOk := C.CompositeImage(gmCanvas, C.CompositeOperator(operator),
		gmComposite, offsetX, offsetY) //XXX takes time of 0.7 ms for two 600x800 Gray images
	if uint(cOk) == 0 {
		return errors.New("Gm C.CompositeImage fail")
	}
	//Output in same format as input
	switch tmpIn := canvas.(type) {
	case *image.RGBA:
		tmp := &image.RGBA{}
		gmToGoImage(gmCanvas, tmp)
		tmpIn.Pix = tmp.Pix
		tmpIn.Stride = tmp.Stride
		tmpIn.Rect = tmp.Rect
	case *image.Gray:
		tmp := &image.Gray{}
		gmToGoImage(gmCanvas, tmp) //XXX Takes time of about 1ms to generate 600x800 Gray image
		tmpIn.Pix = tmp.Pix
		tmpIn.Stride = tmp.Stride
		tmpIn.Rect = tmp.Rect
	default:
		return fmt.Errorf("GmCompositImage: Unsupported format %T", tmpIn)
	}
	return nil
}

func GmMapImage(img image.Image, mapImg image.Image, dither bool) error {
	var (
		gmImg     *C.Image
		gmMapImg  *C.Image
		numDither C.uint = 0
		err       error
	)

	gmImg, err = gmFromGoImage(img)
	if err != nil {
		return err
	}
	defer C.DestroyImage(gmImg)
	gmMapImg, err = gmFromGoImage(mapImg)
	if err != nil {
		return err
	}
	defer C.DestroyImage(gmMapImg)
	if dither {
		numDither = 1
	}
	cOk := C.MapImage(gmImg, gmMapImg, numDither)
	if uint(cOk) == 0 {
		return errors.New("Gm C.GmMapImage fail")
	}
	//Output in same format as input
	switch tmpIn := img.(type) {
	case *image.RGBA:
		tmp := &image.RGBA{}
		gmToGoImage(gmImg, tmp)
		tmpIn.Pix = tmp.Pix
		tmpIn.Stride = tmp.Stride
		tmpIn.Rect = tmp.Rect
	case *image.Gray:
		tmp := &image.Gray{}
		gmToGoImage(gmImg, tmp) //XXX Takes time of about 1ms to generate 600x800 Gray image
		tmpIn.Pix = tmp.Pix
		tmpIn.Stride = tmp.Stride
		tmpIn.Rect = tmp.Rect
	default:
		return fmt.Errorf("GmMapImage: Unsupported format %T", tmpIn)
	}
	return nil
}

func init() {
	log.SetFlags(log.Ldate | log.Ltime | log.Lmicroseconds)
	Log = logger.New(common.Config.Global.DeploymentName, log.Ldate|log.Ltime|log.Lmicroseconds, syslog.LOG_DEBUG)
	Log.AddTag("engine")
	//Log.AddTag(common.Config.Global.DeploymentKey[:8])
	BUG = common.BUG
	//init GraphicsMagick
	GMInit()
}