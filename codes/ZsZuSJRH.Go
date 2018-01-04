
func hugeNumber(N []string) (n string) {
    l := 0
    for _,v := range N {
        l += len(v)
    }
    k := len(N)
    
    O := make([][]string, l+1)
    O[0] = append(N, "")
    
    for _,t := range O {
        if t!=nil {
            for j,p := range t[:k] {
                n := t[k]+p
                l := len(n)
                o := O[l]
                if o==nil || o[k]<n {
                    o = make([]string, k+1)
                    copy(o, t)
                    o[k] = n
                    o[j] = ""
                }
                O[l] = o
            }
            n = t[k]
        }
    }
    for n>"0" && n[0]==48 {
        n = n[1:]
    }
    return
}