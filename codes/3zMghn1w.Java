import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.net.SocketException;
import java.net.UnknownHostException;

public class Client {
	
	private static String nameUserForSend;
	private static String nameClient;
	private static DatagramSocket sock;
	
	public static void main(String arg[]){
		BufferedReader cin = new BufferedReader(new InputStreamReader(System.in));
		try {
			sock = new DatagramSocket();
			
			
			System.out.println("Введите ваше имя: ");
			
			nameClient = cin.readLine();
			nameClient = nameClient.replaceAll(" ", "_");
			String nameClientToConnect;
			nameClientToConnect = "&login: "+nameClient;
			
			byte[] buf = nameClientToConnect.getBytes("utf-8");
			
			DatagramPacket dp = new DatagramPacket(buf, buf.length, InetAddress.getByName("127.0.0.1"), 444);
			
			sock.send(dp);
			
			ClientListener clientListener = new ClientListener(sock);
			
			clientListener.start();
		
			addUserForSend(cin);
			
			while(true){
				if(nameUserForSend != null){
					System.out.println("Введите ваше сообщение: (Доступны все символы, кроме &, введите \\c для смены получателя сообщения)");
					String message = cin.readLine();
					if(!message.equals("\\c")){
							String packetMes = "&send: "+nameUserForSend+" "+nameClient+": "+message;
							byte[] packet = packetMes.getBytes("utf-8");
							dp = new DatagramPacket(packet, packet.length, InetAddress.getByName("127.0.0.1"), 444);
							sock.send(dp);
					}
					else {
						addUserForSend(cin);
					}
				}
				else addUserForSend(cin);
			}
			
		} catch (SocketException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			sock.close();
		}
	} 
	
	public static void addUserForSend(BufferedReader cin){
		try {
			System.out.println("Введите имя пользователя, которому хотите отправить сообщение: ");
			nameUserForSend = cin.readLine();
			nameUserForSend = nameUserForSend.replaceAll(" ", "_");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}