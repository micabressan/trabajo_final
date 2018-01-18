func TestLog(t *testing.T) {
        t.Log("Hello\n")
        t.Log("Hello")
}

===== Expected output =====

--- PASS: vlog.TestLog (0.00 seconds)
	Hello	
	Hello
PASS

===== Actual Output =====

--- PASS: vlog.TestLog (0.00 seconds)
	Hello
	
	Hello
PASS