func Authenticate() {
	client := &http.Client{}
	AuthDocData := url.Values{}
	AuthDocData.Set("numeroDocumento", "numeroDocumento")
	var AuthReq, _ = http.NewRequest(
		"POST",
		"http://www.copel.com/AgenciaWeb/autenticar/autenticarDoc.do",
		strings.NewReader(AuthDocData.Encode()))
	res, _ := client.Do(AuthReq)
	JSESSIONIDKey, JSESSIONIDValue := ParseCookie(res.Header["Set-Cookie"][0])
	// HashKey, HashValue := ParseCookie(res.Header["Set-Cookie"][1])

	fmt.Println("\n\n\n")

	LoginData := url.Values{}
	LoginData.Set("senha", "senha")
	var LoginReq, _ = http.NewRequest(
		"POST",
		"http://www.copel.com/AgenciaWeb/autenticar/validarSenha.do",
		strings.NewReader(LoginData.Encode()))

	cookie := http.Cookie{Name: JSESSIONIDKey, Value: JSESSIONIDValue}

	LoginReq.AddCookie(&cookie)
	// LoginReq.Header.Set("Cookie", strings.Join(res.Header["Set-Cookie"], " "))
	fmt.Println(LoginReq.Cookies())
	fmt.Println("\n\n\n")
	// var req, _ = http.PostForm(
	// 	"http://www.copel.com/AgenciaWeb/autenticar/validarSenha.do",
	// 	url.Values{"senha": {"senha"}})
	login, _ := client.Do(LoginReq)
	fmt.Println(login.Header)
	body, _ := ioutil.ReadAll(login.Body)
	login.Body.Close()
	fmt.Println(string(body))
}

func ParseCookie(Cookie string) (string, string) {
	value := strings.Split(Cookie, "=")
	return value[0], value[1]
}