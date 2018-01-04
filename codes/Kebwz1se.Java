import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;

import javax.naming.Context;

public class ClientListener extends Thread{
	DatagramSocket sock = null;
	public void run(){
		byte[] buf = new byte[65536];
		DatagramPacket incoming = new DatagramPacket(buf,buf.length);
		while(true){
			try {
				sock.receive(incoming);
				byte[] data = incoming.getData();
				String anwser = new String(data, 0, incoming.getLength(), "utf-8");
				System.out.println(anwser);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	public ClientListener(DatagramSocket sock){
		this.sock = sock;
	}
}