import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.net.SocketException;
import java.net.UnknownHostException;

public class Server {
	private static DatagramSocket soc;
	public static void main(String arg[]) throws IOException{
		try {
			soc = new DatagramSocket(444, InetAddress.getByName("127.0.0.1"));
			DatagramPacket dp;
			try {
				byte[] buffer = new byte[65536];
				DatagramPacket incoming = new DatagramPacket(buffer, buffer.length);
				System.out.println("Сервер запущен");
				while(true){
					soc.receive(incoming);
					byte[] data = incoming.getData();
					String str = new String(data, 0, incoming.getLength(), "utf-8");
					if(str.startsWith("&login:")){
						checkUserForAdd(str, incoming);
					}
					else if(str.startsWith("&send:")) {			
						String[] sp = str.split(" ", 3);
						if(checkUser(sp[1])){
							byte[] dataout = sp[2].getBytes("utf-8");
							dp = new DatagramPacket(dataout, dataout.length, InetAddress.getByName(ClientList.getUserAddress(sp[1])), ClientList.getUserPort(sp[1]));
							soc.send(dp);
						}
					}else if(str.startsWith("&remove:")){
						String[] sp = str.split(" ", 2);
						ClientList.removeUser(sp[1]);
					}
				}
			} catch (UnknownHostException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		    
		} catch (SocketException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			soc.close();
		}
	}
	
	public static Boolean checkUser(String name){
		if(ClientList.checkUser(name))
			return true;
		else return false;
	}
	
	public static void checkUserForAdd(String message, DatagramPacket incoming){
		String[] sp = message.split(" ", 2);
		System.out.println("Порт пользователя:"+Integer.toString(incoming.getPort()));
		if(!ClientList.checkUser(sp[1]))
			addUser(sp[1], incoming.getAddress().getHostAddress(), incoming.getPort());
		else System.out.println("Данный пользователь уже существует!");
	}
	
	public static void addUser(String name, String host, Integer port){
		ClientList.addUser(name, host, port);
	}
}