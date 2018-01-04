// Server.java

import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;

public class Server {
    public static final int TCP_PORT = 9000;

    public static void main(String[] args) {
       try {
           int clientCounter = 0;
           ServerSocket serverSocket = new ServerSocket(TCP_PORT);
           System.out.println("Server running...");

           while (true){
               Socket socket = serverSocket.accept();
               System.out.println("Client accepted: " + (++clientCounter));
               ServerThread serverThread = new ServerThread(socket, clientCounter);
           }
       } catch (IOException e) {
            e.printStackTrace();
        }
    }
}

// Client.java

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.*;
import java.io.*;
public class Klijent {
    public static final int TCP_PORT = 9000;

    public static void main(String[] args) {
        try {
            InetAddress address = InetAddress.getByName("127.0.0.1");
            try {
                Socket socket = new Socket(address, TCP_PORT);
                BufferedReader input = new BufferedReader(new InputStreamReader(socket.getInputStream()));

                PrintWriter output = new PrintWriter(new BufferedWriter(
                        new OutputStreamWriter(
                                socket.getOutputStream())
                ), true);

                System.out.println("[CLIENT]: " + "Ziv sam");
                output.println("Ziv sam");

                String response = input.readLine();
                System.out.println("[SERVER]: " + response);

                input.close();
                output.close();
                socket.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        } catch (UnknownHostException e) {
            e.printStackTrace();
        }
    }
}

// ServerThread.java

import java.io.*;
import java.net.Socket;

public class ServerThread extends Thread{

    private Socket socket;
    private int clientCounter;
    private BufferedReader input;
    private PrintWriter output;

    public ServerThread(Socket socket, int clientCounter) {
        try {
            this.socket = socket;
            this.clientCounter = clientCounter;

            input = new BufferedReader(
                    new InputStreamReader(
                            socket.getInputStream()
                    )
            );
            output = new PrintWriter(
                    new BufferedWriter(
                            new OutputStreamWriter(socket.getOutputStream())
                    )
            , true);
        } catch (IOException e) {
            e.printStackTrace();
        }
        start();
    }

    public void run(){
        try {
            String request = input.readLine();
            output.println("(" + clientCounter + ")");
            input.close();
            output.close();
            socket.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
}

// Prozor.java

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.Arrays;

public class Prozor extends JFrame implements ActionListener {

	private Container container;
	private JButton dugme1, dugme2, dugme3;
    private JProgressBar jProgressBar;
    private JTextField rec1, rec2, rec;

	private JPanel panel1, panel2, panel3;

    private Prozor(String imePrograma){
        super(imePrograma);
        setSize(500, 500);
        setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
        setVisible(true);
        setLayout(new GridLayout(3,1));

        // 1. Inicijalizuj sve komponente
        inicijalizujKomponente();
        // 2. Uzmi container - kompletan prozor
        container = getContentPane();
		// 3. Dodaj komponente u container
        dodajKomponente();

        new MojaNit(jProgressBar).run();
    }

    private void inicijalizujKomponente() {
        panel1 = new JPanel();
        panel1.setLayout(new GridLayout(2,1));

        jProgressBar = new JProgressBar(0, 100);

        dugme1 = new JButton("Zaustavi");
        dugme1.setSize(250, 100);
        dugme1.addActionListener(this);

        panel2 = new JPanel();
        panel2.setLayout(new GridLayout(2,2));

        dugme2 = new JButton("Anagram");
        dugme2.addActionListener(this);
        rec1 = new JTextField("");
        rec2 = new JTextField("");

        panel3 = new JPanel();
        panel3.setLayout(new GridLayout(2,1));

        rec = new JTextField();
        dugme3 = new JButton("Posalji poruku");
        dugme3.addActionListener(this);
    }

    private void dodajKomponente() {
        panel1.add(jProgressBar);
        panel1.add(dugme1);

        panel2.add(rec1);
        panel2.add(rec2);
        panel2.add(dugme2);

        panel3.add(rec);
        panel3.add(dugme3);

        container.add(panel1);
        container.add(panel2);
        container.add(panel3);
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        if(e.getActionCommand().equals("Zaustavi")){
            MojaNit.flag = false;
        }
        else if(e.getActionCommand().equals("Anagram"))
            resiAnagram();
        else if(e.getActionCommand().equals("Posalji poruku"))
           // Nedostaje funkcija
    }

    private void resiAnagram() {
        String prvaRec = rec1.getText().toLowerCase().replace(" ", ""),
                drugaRec = rec2.getText().toLowerCase().replace(" ", "");

        char[] prviNiz = prvaRec.toCharArray(), drugiNiz = drugaRec.toCharArray();

        Arrays.sort(prviNiz);
        Arrays.sort(drugiNiz);

        String novaPrvaRec = new String(prviNiz);
        String novaDrugaRec = new String(drugiNiz);

        if(novaPrvaRec.equals(novaDrugaRec)){
            System.out.println("Ove reči su anagrami!");
        }
    }

    public static void main(String[] args) {
        Prozor objekat1 = new Prozor("Ovo je naziv programa");
	}
}

// MojaNit.java

import javax.swing.*;

public class MojaNit implements Runnable{

    private JProgressBar jProgressBar;
    public static boolean flag;

    public MojaNit(JProgressBar jProgressBar){
        this.jProgressBar = jProgressBar;
        flag = true;
    }

    @Override
    public void run() {
        while (flag){
            for (int i=0;i<100;i++){
                if(flag){
                    try {
                        Thread.sleep(250);
                        jProgressBar.setValue(i);
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                }
            }
        }

    }
}