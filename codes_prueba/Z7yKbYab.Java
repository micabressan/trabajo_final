/////ClientHandler

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.net.Socket;

public class ClientHandler extends Thread {
	
	 	private BufferedReader clientInput = null; 
	    private PrintStream clientOutput = null;
	    private Socket soketZaKomunikaciju;
	    private String username;
	    private Boolean uploadUtoku = false; 
	    private Boolean fileNameInput = false;
	    Korisnik korisnik = null;
	    String password;
	    String opcija;
	    boolean isLoggedIn = false;
	    String message;
	    String fileName;
	    boolean isValid = false;
	    PrintWriter printWriter = null;
	File f;
	public ClientHandler(Socket soket) {
		soketZaKomunikaciju = soket;
	}
	
	 private static String generisiImeFajla(int count) {
	        String ALPHA_NUMERIC_STRING = "ABCDEFGHIJKLMNOPQRSTUVWXYZ" +
	                                      "abcdefghijklmnopqrstuvwxyz" +
	                                      "0123456789";
	        StringBuilder builder = new StringBuilder();
	        while (count-- != 0) {
	            int character = (int)(Math.random()*ALPHA_NUMERIC_STRING.length());
	            builder.append(ALPHA_NUMERIC_STRING.charAt(character));
	        }
	        return builder.toString();
	    }
	
	
	 @Override
		public void run() {
			
			try {
				

	            clientInput = new BufferedReader(new InputStreamReader(soketZaKomunikaciju.getInputStream()));
	            clientOutput = new PrintStream(soketZaKomunikaciju.getOutputStream());

	            
	            

	            do {
	                     clientOutput.println("===========================================================");
	                     clientOutput.println("Izaberite opciju:");
	                     clientOutput.println("1. Registruj se.");
	                     clientOutput.println("2. Prijavi se.");
	                     clientOutput.println("0. Kraj");
	                     clientOutput.println("===========================================================");

	                     message = clientInput.readLine();
	                     
	                     
	                     if (message.equals("1")) {
	                         clientOutput.println("Unestite korisnicko ime:");
	                         username = clientInput.readLine();
	                         
	                         clientOutput.println("Unesite vasu lozinku");
	                         password = clientInput.readLine();
	                         
	                         if (Server.registrujNovogKorisnika(username, password)) {
	                             clientOutput.println("Uspesno ste se registrovali. Mozete se ulogovati sa unetim kredencijalima");
	                             
	                            
	                             
	                             
	                             } else {
	                             clientOutput.println("Korisnicko ime " + username + " je vec registrovano");
	                         }
	                     } else if (message.equals("2")) {
	                         clientOutput.println("Unestite korisnicko ime:");
	                         username = clientInput.readLine();
	                         
	                         clientOutput.println("Unesite vasu lozinku");
	                         password = clientInput.readLine();
	                         
	                         if (Server.prijaviKorisnika(username, password)) {
	                             clientOutput.println("DOBRODOSLI! Uspesno ste se prijavili na sistem");
	                             isLoggedIn = true;
	                             korisnik = Server.dohvatiKorisnika(username, password);
	                         } else {
	                             clientOutput.println("Uneti kredencijali su neispravni");
	                         }
	                     
	                     } else if (message.equals("0")) {
	                    	clientOutput.println("Dovidjenja");
	                         break;
	                     } else {
	                         clientOutput.println("Uneta nepostojeca opcija");
	                     }
	                 
	                 
	                 
	            
	             
	                
	                
	                     if(isLoggedIn) {
	                    
	                
	                    isValid = true;
	                    clientOutput.println(">>> Dobrodosli " +username);
	                    clientOutput.println("A. Za upload unesite ***up");
	                    clientOutput.println("   Za prekid uploada unesite ***eof");
	                    clientOutput.println("B. Za download unesite ***dn");
	                    clientOutput.println("C. Za izlazak unesite ***quit");}
	                
	            }while(!isValid);
	            
	            // Ovde je definisano primanje poruka od korisnika

	           
	            
	            while(true) {

	                message = clientInput.readLine();

	                // ako poruka sadrzi niz karaktera koji ukazuju na izlaz, izlazi se iz petlje, korisnik se izbacuje
	                // iz liste  usera na serveru 

	                if (message.startsWith("***quit")) {
	                    break;
	                } else if (message.startsWith("***up")) {  // kreiram fajl
	                    System.out.println("Krece upload");
	                    fileName = generisiImeFajla(10);
	                    clientOutput.println("Ime fajla je: " + fileName);
	                    uploadUtoku = true;
	                    FileWriter fileWriter = new FileWriter(fileName);
	                    printWriter = new PrintWriter(fileWriter);
	                } else if (message.startsWith("***eof")) {  // zatvaram fajl
	                	
	                	
	                	if (message.length() > 500) {
	                        clientOutput.println("Maksimalna velicina fajla je 500 karaktera.");
	                        } else {
	                    System.out.println("Upload zavrsen");
	                    uploadUtoku = false;
	                    printWriter.flush();
	                    printWriter.close();
	                    clientOutput.println("Fajl " + fileName + " je uspesno snimljen");
	                    fileName = null;
	                    }
	                } else if (message.startsWith("***dn")) {  // upisujem u fajl
	                    System.out.println("Krece download");
	                    clientOutput.println("Unesite ime fajla: ");
	                    fileNameInput = true;
	                } else {
	                    if (uploadUtoku) {
	                        printWriter.println(message);
	                    } else if (fileNameInput) {
	                        fileName = message;
	                        clientOutput.println("Trazim fajl: " + fileName);
	                        fileNameInput = false;
	                        //File file = new File(fileName);
	                        if (new File(fileName).exists()) {
	                            clientOutput.println("Pronadjen fajl: " + fileName);
	                            // Ako nadjem fajl pocinjem slanje
	                            clientOutput.println("---BOF---");
	                            clientOutput.println(fileName);
	                            BufferedReader br = null;
	                            try{
	                                br = new BufferedReader(new FileReader(fileName));

	                                
	                                String contentLine = br.readLine();
	                                while (contentLine != null) {
	                                    clientOutput.println(contentLine);
	                                    contentLine = br.readLine();
	                                }
	                            }
	                            catch (IOException ioe)
	                            {
	                                ioe.printStackTrace();
	                            }
	                            finally
	                            {
	                                try {
	                                    if (br != null)
	                                        br.close();
	                                }
	                                catch (IOException ioe)
	                                {
	                                    ioe.printStackTrace();
	                                }
	                            }
	                            clientOutput.println("---EOF---");
	                           
	                        } else {
	                            clientOutput.println("NIJE pronadjen fajl: " + fileName);
	                        }
	                    } else {
	                        System.out.println("[" + username + "]: " + message);
	                    }
	                }
	                
	                
	            }

	            
	            clientOutput.println(">>> Dovidjenja " +username);





	           

	            soketZaKomunikaciju.close();

	            // Ovde je obradjen izuzetak u slucaju da korisnik nasilno napusti chat. U smislu da ne otkuca ***quit nego da samo ugasi
	            // klijentsku aplikaciju. Ili da mu nestane struje npr.

	        }
			 catch (Exception e) {
				
			}
		}

	}
///////////////////// KLASA Korisnik
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


import java.util.HashMap;


public class Korisnik {
    private String username;
    private String password;
    private HashMap<String, String> files;

    public Korisnik(String username, String password) {
        this.username = username;
        this.password = password;
        this.files = new HashMap<>();
    }
    
    public boolean dodajNoviFajl(String kodFajla, String sadrzajFajla) {
        if (files.containsKey(kodFajla)) {
            return false;
        }
        
        files.put(kodFajla, sadrzajFajla);
        return true;
    }

    public String dohvatiFajl(String kodFajla) {
        if (files.containsKey(kodFajla)) {
            return files.get(kodFajla);
        }
        
        return null;
    }
    
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    

    
    
    
}
/////////////// Server



import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import java.nio.file.FileSystems;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.LinkedList;

public class Server {
	 public static LinkedList<Korisnik> registrovaniKorisnici = new LinkedList<>();
	
	 public static Korisnik dohvatiKorisnika(String username, String password) {
	        for (Korisnik korisnik : registrovaniKorisnici) {
	            if (korisnik.getUsername().equals(username)) {
	                if (korisnik.getPassword().equals(password)) {
	                    return korisnik;
	                }
	            }
	        }
	        
	        return null;
	    }
	    
	 
	    public static boolean registrujNovogKorisnika(String username, String password) {
	    	
	        for (Korisnik korisnik : registrovaniKorisnici) {
	            if (korisnik.getUsername().equals(username)) {
	                return false;
	            }
	        }
	        
	        Korisnik kor = new Korisnik(username, password);
	        registrovaniKorisnici.add(kor);
	        
	        return true;
	    }
	    /*
	        Prijavljivanje korisnika na server.
	    
	        Proverava unetog korisnickog imena i lozinke.
	        Rezultat metode je uspesnost prijavljivanje.
	    
	    */
	    public static boolean prijaviKorisnika(String username, String password) {
	        for (Korisnik korisnik : registrovaniKorisnici) {
	            if (korisnik.getUsername().equals(username)) {
	                if (korisnik.getPassword().equals(password)) {
	                    return true;
	                }
	            }
	        }
	        
	        return false;
	    }
	    

	public static void main(String[] args) {
		
		
	
		int port = 5555;
        ServerSocket serverSoket;
        Socket soketZaKomunikaciju;
        
        try {
        	 
       
            serverSoket = new ServerSocket(port);
            
        
            
            while (true) {
            	
            	System.out.println("Cekam na konekciju...");
                soketZaKomunikaciju = serverSoket.accept();
                System.out.println("Doslo je do konekcije!");
                
                ClientHandler klijent = new ClientHandler(soketZaKomunikaciju);
                
                
              
                

                

                klijent.start();
            }
		} catch (IOException e) {
			 System.out.println("Greska prilikom pokretanja servera!");
		}
	}

}
///////////////////Client

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintStream;
import java.net.Socket;
import java.net.UnknownHostException;

public class Client implements Runnable{
	
	
    static private PrintStream serverOutput = null;
    static private BufferedReader unosSaTastature = null;
		
 
	public static void main(String[] args) {
		
		try {
			 

            Socket soketZaKomunikaciju = new Socket("localhost", 5555);

           

            BufferedReader serverInput = new BufferedReader(new InputStreamReader(soketZaKomunikaciju.getInputStream()));
            serverOutput = new PrintStream(soketZaKomunikaciju.getOutputStream());

            unosSaTastature = new BufferedReader(new InputStreamReader(System.in));

            
            
            new Thread(new Client()).start();
            
            String input;
            
         // Dokle god stizu poruke, iste se ispisuju na strani klijenta
            // Ako dodje poruka koja pocinje sa >>> Dovidjenja, a to je u slucaju da smo mi uneli ***quit, zatvara se
            // soket za komunikaciju

            while(true) {
                input = serverInput.readLine();
                System.out.println(input);

                if(input.startsWith(">>> Dovidjenja")) {
                    break;
                }
            }
            
         // Zatvaranje soketa u slucaju kada napustamo 

            soketZaKomunikaciju.close();

            
		} catch (UnknownHostException e) {
			System.out.println("UNKNOWN HOST!");
			
		}catch (IOException e) {
			System.out.println("SERVER IS DOWN!!!");
		}
		

	}

	@Override
	public void run() {
		  try {

	            String message;

	            while(true) {

	                message = unosSaTastature.readLine();
	                serverOutput.println(message);

	              

	                if(message.equals("***quit")) {
	                    break;
	                }
	            }

	        } catch (IOException e) {
	           
	            e.printStackTrace();
	        }
		
	}

}