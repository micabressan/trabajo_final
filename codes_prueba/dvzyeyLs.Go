conn, err := conn.DialTimeout(...)
if err != nil {
	fmt.Printf("ERROR: tcp/ip connection failed: %v", err)
	return
}
defer conn.Close()
doShitWithConn(conn)