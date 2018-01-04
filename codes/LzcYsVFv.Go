package main

import (
	"fmt"
	//"strings"
	//"time"

	"github.com/tebeka/selenium"
	"time"
)

const (
	seleniumPath    = "vendor/selenium-server-standalone-3.4.jar"
	geckoDriverPath = "vendor/geckodriver-v0.18.0-linux64"
	port            = 8080
)

func main() {
	opts := []selenium.ServiceOption{
		selenium.StartFrameBuffer(),
		selenium.GeckoDriver(geckoDriverPath),
		//selenium.Output(os.Stderr),
	}
	//selenium.SetDebug(true)
	service, err := selenium.NewSeleniumService(seleniumPath, port, opts...)
	if err != nil {
		panic(err)
	}
	defer service.Stop()

	caps := selenium.Capabilities{"browserName": "firefox", "firefox.page.settings.userAgent": "Mozilla/5.0 (iPhone; CPU iPhone OS 5_0 like Mac OS X)"}
	wd, err := selenium.NewRemote(caps, fmt.Sprintf("http://localhost:%d/wd/hub", port))
	if err != nil {
		panic(err)
	}
	defer wd.Quit()

	if err := wd.Get("https://vk.com/login"); err != nil {
		panic(err)
	}

	currentURL, err := wd.CurrentURL()
	if err != nil {
		panic(err)
	}
	fmt.Println("currentURL: ", currentURL)

	emailField, err := wd.FindElement(selenium.ByCSSSelector, "#email")
	if err != nil {
		panic(err)
	}

	if err := emailField.Clear(); err != nil {
		panic(err)
	}


	err = emailField.SendKeys("*@gmail.com")
	if err != nil {
		panic(err)
	}

	time.Sleep(500 * time.Millisecond)

	passField, err := wd.FindElement(selenium.ByCSSSelector, "#pass")
	if err != nil {
		panic(err)
	}

	if err := passField.Clear(); err != nil {
		panic(err)
	}

	err = passField.SendKeys("*")
	if err != nil {
		panic(err)
	}

	time.Sleep(500 * time.Millisecond)

	var output string
	for {
		output, err = passField.GetAttribute("value")
		if err != nil {
			panic(err)
		}
		if output != "Waiting for remote server..." {
			break
		}
		time.Sleep(time.Millisecond * 100)
	}
	fmt.Println("output: ", output)

	btn, err := wd.FindElement(selenium.ByCSSSelector, "#login_button")
	if err != nil {
		panic(err)
	}
	if err := btn.Submit(); err != nil {
		panic(err)
	}

	time.Sleep(1500 * time.Millisecond)

	if err := wd.Get("https://oauth.vk.com/authorize?client_id=5614546&scope=photos,audio,video,docs,notes,pages,status,offers,questions,wall,groups,messages,email,notifications,stats,ads,offline,docs,pages,stats,notifications&response_type=token&redirect_uri=http://oauth.vk.com/blank.html&display=page"); err != nil {
		panic(err)
	}

	permissionAccess, err := wd.FindElement(selenium.ByCSSSelector, ".flat_button.fl_r.button_indent")
	if err != nil {
		panic(err)
	}
	if err := permissionAccess.Click(); err != nil {
		panic(err)
	}

	//time.Sleep(1500 * time.Millisecond)

	/*var permissionAccessText string
	for {
		permissionAccessText, err = permissionAccess.Text()
		if err != nil {
			panic(err)
		}
		if permissionAccessText != "Waiting for remote server..." {
			break
		}
		time.Sleep(time.Millisecond * 100)
	}
	fmt.Println("permissionAccessText: ", permissionAccessText)*/

	time.Sleep(500 * time.Millisecond)

	currentUrlAfterLogin, err := wd.CurrentURL()
	if err != nil {
		panic(err)
	}
	fmt.Println("currentUrlAfterLogin: ", currentUrlAfterLogin)

	/*hello, err := wd.FindElement(selenium.ByCSSSelector, ".page_name")
	if err != nil {
		panic(err)
	}

	var helloOutput string
	for {
		helloOutput, err = hello.Text()
		if err != nil {
			panic(err)
		}
		if helloOutput != "Waiting for remote server..." {
			break
		}
		time.Sleep(time.Millisecond * 100)
	}
	fmt.Println("helloOutput: ", helloOutput)*/
}