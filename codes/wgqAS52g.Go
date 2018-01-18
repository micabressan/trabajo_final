func TestPanic(t *testing.T) {
   defer func() { recover() }()
   go func() { panic("unrecoverable, bwa ha ha!") }()
}