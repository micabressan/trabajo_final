func flipForBalance(s string) (r int) {
    c := 0
    for _,p := range s {
        c += int(p - 40)*2 - 1
        if c > 0 {
            r++
            c = -1
        }
    }
    return r - c / 2
}