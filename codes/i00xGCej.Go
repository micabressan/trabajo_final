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
.
.
.
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
.
.
.
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
.
.
.
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