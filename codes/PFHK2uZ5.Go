func Karovd(m string) (r string) {
    for _,v := range m {
        a := 0
        if v > 96 {
            a += 32
            v -= 32
        }
        b := "                                                                 AXJE.UIDC TNM RL POY K    "[v]
        if b != '.' {
            b += byte(a)
        }
        r += string(b)
    }
    return
}