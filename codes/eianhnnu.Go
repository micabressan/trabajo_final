func theLoShuSquarePartI(y int) (r [3][3]int) {
    s := "492357816"
    for i,c := range s {
        r[i/3][i%3] = ((int(c) + 1964 - y) % 9 + 9) % 9 + 1
    }
    return
}