package main

//https://github.com/picklepete/pyicloud/blob/master/pyicloud/base.py

import (
	"encoding/json"
	"fmt"
	"github.com/dyy18/istreamdatago/util"
	"net/http"
	"os"
	"strings"
	"net/url"
	"io/ioutil"

	"crypto"
	"crypto/sha1"
	"encoding/base64"
)

const (
	home_endpoint  = "https://www.icloud.com"
	setup_endpoint = "https://p12-setup.icloud.com/setup/ws/1"
	push_endpoint  = "https://p12-pushws.icloud.com"

	iclouddir = "/icloud"
)

type iCloudService struct {
	Discovery string
	Client_Id string
	User      map[string]string
	Params    url.Values

	Home_Endpoint     string
	Setup_Endpoint    string
	Push_Endpoint     string
	Base_Login_Url    string
	Base_Validate_Url string
	Base_System_Url   string
	Base_Webauth_Url  string

	Client *http.Client
	Req    *http.Request
}

func (iS *iCloudService) Init(apple_id string, password string, cookie_directory string) {
	//Hardcode!
	cookie_directory = ""
	iS.Discovery = ""
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

	if cookie_directory != "" {
		// TODO cookie dir
	} else {
		os.Remove(iclouddir)
		os.Mkdir(iclouddir, 1)
		cookie_directory = iclouddir
	}
	iS.Client = &http.Client{}
	iS.Req = &http.Request{}
	iS.Req.Header.Add("host", "setup.icloud.com")
	iS.Req.Header.Add("origin", iS.Home_Endpoint)
	iS.Req.Header.Add("referer", iS.Home_Endpoint+"/")
	iS.Req.Header.Add("User-Agent", "Opera/9.52 (X11; Linux i686; U; en)")


	//iS.Authenticate()
}

func (iS *iCloudService) RefreshValidate() {
	req, err := iS.Client.Get(iS.Base_Validate_Url + iS.Params.Encode())
	if err != nil {
		panic(err.Error())
	}
	var data map[string]map[string]string
	err = json.NewDecoder(req.Body).Decode(&data)
	if err != nil {
		panic(err.Error())
	}
	fmt.Print(data)

	contents, err := ioutil.ReadAll(req.Body)
	if err != nil {
		fmt.Printf("%s", err)
	}

	cont := string(contents)

	if strings.Contains(cont, "dsInfo") {
		dsid := data["dsInfo"]["dsid"]
		iS.Params.Add("dsid", dsid)
	}

	var instance string
	if strings.Contains(cont, "instance") {
		instance = data[instance]
	} else {
		//uuid.uuid4().hex.encode('utf-8')
		instance = util.GenUuid()

	}

	bv := []byte(iS.User["apple_id"] + instance)

	hasher := sha1.New()
	hasher.Write(bv)
	sha := base64.URLEncoding.EncodeToString(hasher.Sum(nil))
 	// TODO utf 8

	sha = strings.ToUpper(sha)

	iS.Params.Add("id", sha)

	client_Id := strings.ToUpper(util.GenUuid())

	iS.Params.Add("clientBuildNumber", "14E45")

	iS.Params.Add("clientId", client_Id)
	
	/*
	sha = hashlib.sha1(
            self.user.get('apple_id').encode('utf-8') + instance
        )
        self.params.update({'id': sha.hexdigest().upper()})

        clientId = str(uuid.uuid1()).upper()
        self.params.update({
            'clientBuildNumber': '14E45',
            'clientId': clientId,
        })
	 */


}



func (iS *iCloudService) Authenticate() {
	iS.RefreshValidate()
}


func main() {

}