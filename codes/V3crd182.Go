func ReadCookie(w http.ResponseWriter, r *http.Request) {
        c, err := r.Cookie("ithinkidroppedacookie")
        if err != nil {
                w.Write([]byte("error in reading cookie : " + err.Error() + "\n"))
        } else {
                value := c.Value
                w.Write([]byte("cookie has : " + value + "\n"))
        }
}