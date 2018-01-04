// GetDownloadKeysByProjectIDOKCode is the HTTP code returned for type GetDownloadKeysByProjectIDOK
const GetDownloadKeysByProjectIDOKCode int = 200

/*GetDownloadKeysByProjectIDOK Download keys fetched

swagger:response getDownloadKeysByProjectIdOK
*/
type GetDownloadKeysByProjectIDOK struct {

	/*
	  In: Body
	*/
	Payload models.DownloadΚeys `json:"body,omitempty"`
}

// NewGetDownloadKeysByProjectIDOK creates GetDownloadKeysByProjectIDOK with default headers values
func NewGetDownloadKeysByProjectIDOK() *GetDownloadKeysByProjectIDOK {
	return &GetDownloadKeysByProjectIDOK{}
}

// WithPayload adds the payload to the get download keys by project Id o k response
func (o *GetDownloadKeysByProjectIDOK) WithPayload(payload models.DownloadΚeys) *GetDownloadKeysByProjectIDOK {
	o.Payload = payload
	return o
}