package icloud

//https://github.com/picklepete/pyicloud/blob/master/pyicloud/base.py

import (
	"github.com/dyy18/istreamdatago/util"
	"net/http"
	"strings"
	"os"
	"encoding/json"
	"fmt"
)

const (
	home_endpoint = "https://www.icloud.com"
	setup_endpoint = "https://p12-setup.icloud.com/setup/ws/1"
	push_endpoint = "https://p12-pushws.icloud.com"

	iclouddir = "/icloud"
)

type iCloudService struct {
	Discovery string
	Client_Id string
	User map[string]string
	Params map[string]string

	Home_Endpoint string
	Setup_Endpoint string
	Push_Endpoint string
	Base_Login_Url string
	Base_Validate_Url string
	Base_System_Url string
	Base_Webauth_Url string

	Client *http.Client
	Req *http.Request
}

func (iS *iCloudService) Init(apple_id string, password string, cookie_directory string) {
	//Hardcode!
	cookie_directory = nil
	iS.Discovery = nil
	iS.Client_Id = strings.ToUpper(util.GenUuid())
	iS.User["apple_id"] = apple_id
	iS.User["password"] = password
	iS.Home_Endpoint = home_endpoint
	iS.Setup_Endpoint = setup_endpoint
	iS.Push_Endpoint = push_endpoint
	iS.Base_Login_Url = iS.Setup_Endpoint + "/login"
	iS.Base_Validate_Url = iS.Setup_Endpoint + "/validate"
	iS.Base_System_Url = iS.Home_Endpoint + "/system/version.json"
	iS.Base_Webauth_Url = iS.Push_Endpoint + "/refreshWebAuth"

	if cookie_directory != nil {
		// TODO cookie dir
	} else {
		os.Mkdir(iclouddir, 1)
		cookie_directory = iclouddir
	}
	iS.Client = &http.Client{}
	iS.Req = &http.Request{}
	iS.Req.Header.Add("host", "setup.icloud.com")
	iS.Req.Header.Add("origin", iS.Home_Endpoint)
	iS.Req.Header.Add("referer", iS.Home_Endpoint + "/")
	iS.Req.Header.Add("User-Agent", "Opera/9.52 (X11; Linux i686; U; en)")

	iS.Params = make(map[string]string)

	iS.Authenticate()
}


func (iS *iCloudService) RefreshValidate() {
	req, err := iS.Client.Get(iS.Base_Validate_Url)
	if err != nil {
		panic(err.Error())
	}
	var data interface{}
	resp := json.Unmarshal(req.Body(), &data)
	fmt.Print(data)
	resp.

}

func (iS *iCloudService) Authenticate() {
	iS.RefreshValidate()
}