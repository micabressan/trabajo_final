func AuthServer_AddUser(dn string, password string) {
	var pass []string
	pass[0] = password

	var req = ldap.NewAddRequest(dn)
	req.Attribute("userPassword", pass)
}