package main

import (
	"fmt"
	"github.com/tebeka/selenium"
	"github.com/tebeka/selenium/sauce"
	"github.com/blang/semver"
	"net"
	"flag"
	"log"
	"time"
	"errors"
	"github.com/tebeka/selenium/firefox"
	"math/rand"
)

const (
	vkAuthUrl string = "https://oauth.vk.com/authorize?client_id=5614546&scope=photos,audio,video,docs,notes,pages,status,offers,questions,wall,groups,messages,email,notifications,stats,ads,offline,docs,pages,stats,notifications&response_type=token&redirect_uri=http://oauth.vk.com/blank.html&display=page"
)

var (
	firefoxBinarySelenium3 = flag.String("firefox_binary_for_selenium3", "vendor/firefox-nightly/firefox", "The name of the Firefox binary for Selenium 3 tests or the path to it. If the name does not contain directory separators, the PATH will be searched.")
	geckoDriverPath = flag.String("geckodriver_path", "vendor/geckodriver-v0.18.0-linux64", "The path to the geckodriver binary. If empty of the file is not present, the Geckodriver tests will not be run.")
	startFrameBuffer = flag.Bool("start_frame_buffer", true, "If true, start an Xvfb subprocess and run the browsers in that X server.")

	vkLoginUrl = flag.String("vk_login_url", "https://vk.com/login", "Vk Login Url, default: https://vk.com/login")
	emailSelector = flag.String("email_selector", "#email", "Email Selector, default: #email")
	passSelector = flag.String("pass_selector", "#pass", "Email Selector, default: #pass")
	loginButtonSelector = flag.String("login_button_selector", "#login_button", "Pass Selector, default: #login_button")
	pageNameSelector = flag.String("page_name_selector", ".page_name", "Page name Selector, default: .page_name")

	vkUserEmail = flag.String("vk_user_email", "*@gmail.com", "Usage for email input")
	vkUserPass = flag.String("vk_user_pass", "*", "Usage for pass input")

	caps selenium.Capabilities
	service *selenium.Service
	wd selenium.WebDriver

	vkUserInfo VkUserInfo
)

type config struct {
	addr, browser, path string
	sauce               *sauce.Capabilities
	seleniumVersion     semver.Version
	serviceOptions      []selenium.ServiceOption
}

type VkUserInfo struct {
	email, password string
}

func main() {
	var err error

	fmt.Println("Start script...")

	// Парсим заполненные ключи из командной строки
	flag.Parse()

	// загружаем данные фэйка для получения токена по нему
	loadVkUserInfo()

	// загружаем все для Firefox драйвера
	loadFirefoxDriver(*geckoDriverPath, config{
		path: *firefoxBinarySelenium3,
	})

	/*if err = checkUserAgent(); err != nil {
		time.Sleep(time.Second * 1000)
		return
	}*/

	// Проходим авторизацию в вк
	if err = authVk(); err != nil {
		log.Fatalln(err)
		//log.Println(err)
	}
}

func loadVkUserInfo() {
	vkUserInfo.email = *vkUserEmail
	vkUserInfo.password = *vkUserPass
}

func authVk() (error) {
	var err error

	// Отложенное закрытие драйвера и сервиса.
	defer service.Stop()
	defer wd.Quit()

	// Переходим на форму авторизации
	if err = loadVkLoginPage(); err != nil {
		return err
	}

	if err = printCurrentUrl(); err != nil {
		return err
	}

	// Заполняем поле email
	if err = fillEmail(); err != nil {
		return err
	}

	time.Sleep(500 * time.Millisecond)

	// Заполняем поле pass
	if err = fillPassword(); err != nil {
		return err
	}

	time.Sleep(500 * time.Millisecond)

	//return errors.New("before submitForm")
	//log.Fatalln("before submitForm")

	// Сабмитим форму авторизации пользователя вк
	if err = submitForm(); err != nil {
		return err
	}

	time.Sleep(1500 * time.Millisecond)

	//return errors.New("after submitForm")
	//log.Fatalln("after submitForm")

	if err = checkLoginSuccess(); err != nil {
		return err
	}

	// Переходим на страницу (получения токена)|(привязку приложения к профилю и получение токена)
	if err = loadAuthVkPage(); err != nil {
		return err
	}

	time.Sleep(1500 * time.Millisecond)

	if err = loadAuthToken(); err != nil {
		return err
	}

	return nil
}

func loadAuthToken() (error) {
	var (
		err error
		acceptButton selenium.WebElement
		currentUrl string
	)

	for i := 0; i < 5; i++ {
		acceptButton, err = wd.FindElement(selenium.ByCSSSelector, ".flat_button.fl_r.button_indent")
		if err != nil {
			err = errors.New("WebDriver can not acceptButton, returned error: " + err.Error())
			time.Sleep(1 * time.Second)
			continue
		}

		break
	}

	if err != nil {

	}

	if err == nil {
		if err = acceptButton.Click(); err != nil {
			return err
		} else if err = printCurrentUrl(); err != nil {
			return err
		}

		return nil
	} else if err = printCurrentUrl(); err != nil {
		return err
	}

	return nil
}

func loadVkLoginPage() (error) {
	var err error

	if err = wd.Get(*vkLoginUrl); err != nil {
		//log.Fatalf("WebDriver can not Get(someUrl) returned error: %v", err)
		return errors.New("WebDriver can not Get(someUrl) returned error: " + err.Error())
	}

	if err = setPageLoadTimeout(); err != nil {
		//log.Fatalln(err)
		return err
	}

	return nil
}

func printCurrentUrl() (error) {
	currentURL, err := wd.CurrentURL()
	if err != nil {
		//log.Fatalln("WebDriver can not CurrentURL() returned error: %v", err)
		return errors.New("WebDriver can not CurrentURL() returned error: " + err.Error())
	}

	log.Println("currentURL: ", currentURL)

	return nil
}

func getCurrentUrl() (string, error) {
	currentURL, err := wd.CurrentURL()
	if err != nil {
		return "", errors.New("WebDriver can not CurrentURL() returned error: " + err.Error())
	}

	return currentURL, nil
}

func fillEmail() (error) {
	emailField, err := wd.FindElement(selenium.ByCSSSelector, *emailSelector)
	if err != nil {
		//log.Fatalf("WebDriver can not FindElement, returned error: %v", err)
		return errors.New("WebDriver can not FindElement, returned error: " + err.Error())
	}

	if err := emailField.Clear(); err != nil {
		//log.Fatalf("WebDriver can not Clear emailField, returned error: %v", err)
		return errors.New("WebDriver can not Clear emailField, returned error: " + err.Error())
	}

	err = emailField.SendKeys(vkUserInfo.email)
	if err != nil {
		//log.Fatalf("WebDriver can not SendKeys to emailField, returned error: %v", err)
		return errors.New("WebDriver can not SendKeys to emailField, returned error: " + err.Error())
	}

	return nil
}

func fillPassword() (error) {
	passField, err := wd.FindElement(selenium.ByCSSSelector, *passSelector)
	if err != nil {
		//log.Fatalf("WebDriver can not FindElement, returned error: %v", err)
		return errors.New("WebDriver can not FindElement, returned error: " + err.Error())
	}

	if err := passField.Clear(); err != nil {
		//log.Fatalf("WebDriver can not Clear passField, returned error: %v", err)
		return errors.New("WebDriver can not Clear passField, returned error: " + err.Error())
	}

	err = passField.SendKeys(vkUserInfo.password)
	if err != nil {
		//log.Fatalf("WebDriver can not SendKeys to passField, returned error: %v", err)
		return errors.New("WebDriver can not SendKeys to passField, returned error: " + err.Error())
	}

	//printPassInputValue(passField)

	return nil
}

func submitForm() (error) {
	btn, err := wd.FindElement(selenium.ByCSSSelector, *loginButtonSelector)
	if err != nil {
		//log.Fatalln(err)
		return err
	}

	if err := btn.Click(); err != nil {
		//log.Fatalln(err)
		return err
	}

	return nil
}

func checkLoginSuccess() (error) {
	log.Println("start checkLoginSuccess")

	var (
		err error
		pageName selenium.WebElement
		pageNameText string
	)

	for i := 0; i < 5; i++ {
		pageName, err = wd.FindElement(selenium.ByCSSSelector, *pageNameSelector)
		if err != nil {
			time.Sleep(1 * time.Second)
			continue
		}

		break
	}

	for i := 0; i < 5; i++ {
		pageNameText, err = pageName.Text()
		if err != nil {
			continue
		}
		if pageNameText != "Waiting for remote server..." {
			break
		}
		time.Sleep(1 * time.Second)
	}

	if err != nil {
		return err
	}

	log.Println(pageNameText)

	return nil
}

func loadAuthVkPage() (error) {
	var err error

	if err = wd.Get(vkAuthUrl); err != nil {
		//log.Fatalln(err)
		return err
	}

	/*if err = setPageLoadTimeout(); err != nil {
		//log.Fatalln(err)
		return err
	}*/

	return nil
}

func printPassInputValue(passField selenium.WebElement) {
	var output string
	for {
		output, err := passField.GetAttribute("value")
		if err != nil {
			log.Fatalln(err)
		}
		if output != "Waiting for remote server..." {
			break
		}
		time.Sleep(time.Millisecond * 100)
	}
	fmt.Println("output: ", output)
}

func setPageLoadTimeout() (error) {
	if err := wd.SetPageLoadTimeout(1 * time.Second); err != nil {
		//log.Fatalf("wd.SetImplicitWaitTimeout() returned error: %v", err)
		return errors.New("wd.SetImplicitWaitTimeout() returned error: " + err.Error())
	}

	return nil
}

func loadFirefoxDriver(webDriverPath string, c config) {
	c.browser = "firefox"

	if *startFrameBuffer {
		c.serviceOptions = append(c.serviceOptions, selenium.StartFrameBuffer())
	}

	port, err := pickUnusedPort()
	if err != nil {
		log.Fatalf("pickUnusedPort() returned error: %v", err)
	}
	c.addr = fmt.Sprintf("http://127.0.0.1:%d", port)

	/*if s, err := os.Stat(c.path); err != nil || !s.Mode().IsRegular() {
		if path, err := exec.LookPath(c.path); err == nil {
			c.path = path
		} else {
			t.Skipf("Skipping Firefox tests because binary %q not found", c.path)
		}
	}*/

	/*if testing.Verbose() {
		SetDebug(true)
		c.serviceOptions = append(c.serviceOptions, Output(os.Stderr))
	}*/

	service, err = selenium.NewGeckoDriverService(webDriverPath, port, c.serviceOptions...)
	if err != nil {
		log.Fatalln(err)
	}
	//defer service.Stop()

	wd, err = selenium.NewRemote(getFirefoxCapabilities(), c.addr)
	if err != nil {
		log.Fatalln(err)
	}
	//defer wd.Quit()



	/*runFirefoxSubTests(t, c)

	if err := s.Stop(); err != nil {
		t.Fatalf("Error stopping the Selenium service: %v", err)
	}*/
}

func getFirefoxCapabilities() (selenium.Capabilities) {
	caps = selenium.Capabilities{"browserName": "firefox"}

	f, ok := caps[firefox.CapabilitiesKey].(firefox.Capabilities)
	if !ok || f.Prefs == nil {
		f.Prefs = make(map[string]interface{})
	}

	f.Prefs["general.useragent.override"] = getRandomUserAgent()
	caps.AddFirefox(f)

	return caps
}

func getRandomUserAgent() (string) {

	userAgentList := map[int]string{
		0: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.93 Safari/537.36",
		1: "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/535.11 (KHTML, like Gecko) Ubuntu/11.10 Chromium/27.0.1453.93 Chrome/27.0.1453.93 Safari/537.36",
		2: "Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.94 Safari/537.36",

		3: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:21.0) Gecko/20100101 Firefox/21.0",
		4: "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:21.0) Gecko/20130331 Firefox/21.0",
		5: "Mozilla/5.0 (Windows NT 6.2; WOW64; rv:21.0) Gecko/20100101 Firefox/21.0",
	}

	randomKey := randomInt(0, len(userAgentList) - 1);

	return userAgentList[randomKey]
}

func randomInt(min, max int) int {
	rand.Seed(time.Now().Unix())
	return rand.Intn(max - min) + min
}

func pickUnusedPort() (int, error) {
	addr, err := net.ResolveTCPAddr("tcp", "127.0.0.1:0")
	if err != nil {
		return 0, err
	}

	l, err := net.ListenTCP("tcp", addr)
	if err != nil {
		return 0, err
	}
	port := l.Addr().(*net.TCPAddr).Port
	if err := l.Close(); err != nil {
		return 0, err
	}
	return port, nil
}


func checkUserAgent() (error) {
	var err error

	if err = wd.Get("http://www.useragentstring.com/"); err != nil {
		//log.Fatalf("WebDriver can not Get(someUrl) returned error: %v", err)
		return errors.New("WebDriver can not Get(someUrl) returned error: " + err.Error())
	}

	if err = setPageLoadTimeout(); err != nil {
		return err
	}

	userAgentField, err := wd.FindElement(selenium.ByCSSSelector, "#uas_textfeld")
	if err != nil {
		//log.Fatalf("WebDriver can not FindElement, returned error: %v", err)
		return errors.New("WebDriver can not userAgentField, returned error: " + err.Error())
	}

	var userAgentFieldText string
	for {
		userAgentFieldText, err = userAgentField.Text()
		if err != nil {
			return err
		}
		if userAgentFieldText != "Waiting for remote server..." {
			break
		}
		time.Sleep(time.Millisecond * 100)
	}

	fmt.Println("userAgentFieldText: ", userAgentFieldText)

	return nil
}