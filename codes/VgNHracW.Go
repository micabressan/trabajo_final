package main

import (
	"syslog"
	"flag"
	"bytes"
	"os"
)

var facility = flag.String("f", "local1", "What facility that logs should use")
var bufsize = flag.Int("b", 8192, "Size of stdin read buffer")
var stdin = flag.Bool("0", false, "Read from stdin?")
var prefix = flag.Bool("p", false, "Prefixes for each log, uses the rest of the arguments") 

func main() {
	flag.Parse()
	Syslog, _ := syslog.New(syslog.LOG_NOTICE, *facility)
	defer Syslog.Close()
	if *stdin {
		var err os.Error
		var nr int
		buf := make([]byte, *bufsize)
		bufPrefix := &bytes.Buffer{}
		if *prefix {
			for _, arg := range flag.Args() {
        	                bufPrefix.WriteString(arg + " ")
	                }
		}
		for {
			if bufPrefix.Len() > 0 {
				copy(buf, bufPrefix.Bytes())
				nr, err = os.Stdin.Read(buf[bufPrefix.Len():])
			} else {
				nr, err = os.Stdin.Read(buf[:])
			}
			if err != nil || nr == 0 {
				break
			}
			Syslog.Write(buf[:nr-1+bufPrefix.Len()])
		}
	} else {
		buf := &bytes.Buffer{}
		for _, arg := range flag.Args() {
			buf.WriteString(arg + " ")
		}
		Syslog.Write(buf.Bytes())
	}
}


//Usage in Apache
//CustomLog "|syslog-pipe -0 -p -f=httpd your-site -" vhost_combined
//ErrorLog "|syslog-pipe -0 -p -f=httpd your-site"

//It's possible to create quite easy syslog-rules that splits this up.

//ErrorLog should be fixed in 2.3+