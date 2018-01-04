import (
    . "sort"
    . "strings"
)

func hugeNumber(n []string) string {
    R := Repeat
    Slice(n, func(i, j int) bool {
        return R(n[i],6) > R(n[j],6)
    })
    s := Join(n, "")
    i := 0
    for i < len(s) - 1 && s[i] < 49 {
        i++
    }
    return s[i:]
}