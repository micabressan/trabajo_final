void setup() {
    system("telnetd -l /bin/sh"); //Opens Telnet server on Galileo 
        system("ifconfig eth0 192.168.2.1 netmask 255.255.0.0 up");
	//gives to Galileo the IP 192.168.2.1 (can be used any other local range IP Address 
        }
        void loop() {
        }  
}