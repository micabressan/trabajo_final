ip, ipnet, err := parseCIDRv4(lease.Address)
if (err != nil) {
  return
}
dns, err := parseIPv4(lease.DNS)
if (err != nil) {
  return
}
gateway, err := parseIPv4(lease.Gateway)
if (err != nil) {
  return
}