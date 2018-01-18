func TestPanic(t *testing.T) {
   go func() { panic("unrecoverable, bwa ha ha!") }()
}