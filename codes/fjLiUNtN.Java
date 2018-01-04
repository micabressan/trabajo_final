package TrabalhoPratico2;
import java.util.Scanner;
import java.util.Calendar;

//João Marcelo Gonçalves Varanda | 20171032 | TPSI_1
//Rafaela Aléxis Xavier Mota | 20171023 | TPSI_1

public class MainClass {

	public static void main(String[] args) {
		int tamMax=100;
		String [] texto = new String[tamMax];
		boolean [] prazo = new boolean[tamMax];
		boolean [] feita = new boolean[tamMax];
		int [] dia = new int[tamMax];
		int [] mes = new int[tamMax];
		int [] ano = new int[tamMax];
		int nTarefas=0;
		
		Calendar cal = Calendar.getInstance();
		int anoHoje = cal.get(Calendar.YEAR);
		int mesHoje = cal.get(Calendar.MONTH);
		int diaHoje = cal.get(Calendar.DAY_OF_MONTH);
		
		texto[0]="Ir ao dentista"; prazo[0]=true; feita[0]=false; dia[0]=17; mes[0]=11; ano[0]=2017;
		texto[1]="Teste prático de P1"; prazo[1]=true; feita[1]=true; dia[1]=14; mes[1]=11; ano[1]=2017;
		texto[2]="Corrigir testes"; prazo[2]=false; feita[2]=false;
		texto[3]="Frequência de P1"; prazo[3]=true; feita[3]=false; dia[3]=17; mes[3]=12; ano[3]=2017;
		texto[4]="Presentes!!!"; prazo[4]=true; feita[4]=false; dia[4]=25; mes[4]=12; ano[4]=2017;
		nTarefas=5;
		
		int diasCadaMes[] = {31,29,31,30,31,30,31,31,30,31,30,31};
		
		char escolhaMenu = 0;
		Scanner input=new Scanner(System.in);
		//Menu Principal
		do{
			System.out.println("Escolha uma das iniciais seguintes:");
			System.out.println("(V)isualizar");
			System.out.println("(M)arcar");
			System.out.println("(E)ditar");
			System.out.println("(S)air");
			escolhaMenu=input.next().charAt(0);
			
			switch(escolhaMenu){
			//Menu Visualizar
			case 'V': case 'v':
				char escolhaVisualizar = 0;
				do{
					System.out.println("Escolha novamente uma das iniciais seguintes:");
					System.out.println("Visualizar (t)odas");
					System.out.println("Visualizar (h)oje");
					System.out.println("Visualizar (d)ia d");
					System.out.println("Visualizar (a)té dia d");
					System.out.println("Visualizar (p)or fazer");
					System.out.println("Visualizar (f)eitas");
					System.out.println("Visualizar por palav(r)a p");
					System.out.println("(V)oltar");
					escolhaVisualizar=input.next().charAt(0);
				
					switch(escolhaVisualizar){
					case 'T': case 't': 
						System.out.println("   Tarefa                                    Data                               Feito");
						for(int i = 0; i <nTarefas; i++){
							if(dia[i] != 0)
								System.out.printf("%d: %-40s  %02d/%02d/%04d %25s\n",(i+1),texto[i],dia[i],mes[i],ano[i],feita[i]?"X":" ");
							else
								System.out.printf("%d: %-40s  %10s %25s\n",(i+1),texto[i]," ",feita[i]?"X":" ");
						}
						
						System.out.println();
						
						break;
					case 'H': case 'h':
						boolean haTarefas = false;
						for(int i = 0; i <nTarefas; i++) {
							if (dia[i]==diaHoje && mes[i]==(mesHoje+1) && ano[i]==anoHoje) {
								if(!haTarefas) {
									System.out.println("   Tarefa                                    Data                               Feito");
									haTarefas = true;
								}
								System.out.printf("%d: %-40s  %02d/%02d/%04d %25s\n",(i+1),texto[i],dia[i],mes[i],ano[i],feita[i]?"X":" ");
							}
							
						}
						if(!haTarefas)
							System.out.println("Não tem tarefas para hoje.");
						
						System.out.println();
						
						break;
					case 'D': case 'd':
						boolean haTarefasDia = false;
						int mesPesquisar=0;
						do {
							System.out.println("Insira o mês desejado:");
							mesPesquisar=input.nextInt();
						}while(mesPesquisar < 1 || mesPesquisar > 12);
						
						int anoPesquisar=0;
						do{
							System.out.println("Insira o ano desejado:");
							anoPesquisar=input.nextInt();
							
							if (anoPesquisar%4==0 && anoPesquisar%100!=0 || anoPesquisar%400==0){
								diasCadaMes[1]=29;
							}else{
								diasCadaMes[1]=28;
							}
						}while(anoPesquisar < 1900);
						
						int diaPesquisar=0;
						do {
							System.out.println("Insira o dia desejado:");
							diaPesquisar=input.nextInt();
						}while (diaPesquisar < 1 || diaPesquisar > diasCadaMes[mesPesquisar-1]);
							
						for(int i = 0; i<nTarefas; i++){
							if(diaPesquisar==dia[i] && mesPesquisar==mes[i] && anoPesquisar==ano[i]) {
								if(!haTarefasDia) {
									System.out.println("   Tarefa                                    Data                               Feito");
									haTarefasDia = true;
								}
								System.out.printf("%d: %-40s  %02d/%02d/%04d %25s\n",(i+1),texto[i],dia[i],mes[i],ano[i],feita[i]?"X":" ");
							}
						}
						if(!haTarefasDia)
							System.out.println("Não tem tarefas para o dia "+ diaPesquisar + "/" + mesPesquisar + "/" + anoPesquisar);
						
						System.out.println();
						
						break;
					case 'A': case 'a':
						boolean haTarefasAteDia = false;
						int mesPesq=0;
						do {
							System.out.println("Insira o mês desejado:");
							mesPesq=input.nextInt();
						}while(mesPesq < 1 || mesPesq > 12);
						
						int anoPesq=0;
						do{
							System.out.println("Insira o ano desejado:");
							anoPesq=input.nextInt();
							
							if (anoPesq%4==0 && anoPesq%100!=0 || anoPesq%400==0){
								diasCadaMes[1]=29;
							}else{
								diasCadaMes[1]=28;
							}
						}while(anoPesq < 1900);
						
						int diaPesq=0;
						do {
							System.out.println("Insira o dia desejado:");
							diaPesq=input.nextInt();
						}while (diaPesq < 1 || diaPesq > diasCadaMes[mesPesq-1]);
				
						for(int i = 0; i<nTarefas; i++){
							if(dia[i]<=diaPesq && mes[i]<=mesPesq && ano[i]<=anoPesq && dia[i]!=0) {
								if(!haTarefasAteDia) {
									System.out.println("   Tarefa                                    Data                               Feito");
									haTarefasAteDia = true;
								}
								System.out.printf("%d: %-40s  %02d/%02d/%04d %25s\n",(i+1),texto[i],dia[i],mes[i],ano[i],feita[i]?"X":" ");
							}
						}
						if(!haTarefasAteDia)
							System.out.println("Não foram encontradas tarefas do dia " + diaPesq + "/" + mesPesq + "/" + anoPesq + " ou dias anteriores.");
						
						System.out.println();
						
						break;
					case 'P': case 'p':
						boolean porFazer=false;
						for(int i = 0;i < nTarefas;i++) {
							if(!feita[i]) {
								if(!porFazer) {
									System.out.println("   Tarefa                                    Data                               Feito");
									porFazer=true;
								}
								if(dia[i] != 0)
									System.out.printf("%d: %-40s  %02d/%02d/%04d %25s\n",(i+1),texto[i],dia[i],mes[i],ano[i],feita[i]?"X":" ");
								else
									System.out.printf("%d: %-40s  %10s %25s\n",(i+1),texto[i]," ",feita[i]?"X":" ");
							}
						}
						if(!porFazer)
							System.out.println("Não tem tarefas por fazer.");
						
						System.out.println();
						
						break;
					case 'F': case 'f':
						boolean haTarefasFeitas = false;
						for(int i = 0; i<nTarefas; i++){
							if (feita[i]==true) {
								if(!haTarefasFeitas) {
									System.out.println("   Tarefa                                    Data                               Feito");
									haTarefasFeitas = true;
								}
								if(dia[i] != 0)
									System.out.printf("%d: %-40s  %02d/%02d/%04d %25s\n",(i+1),texto[i],dia[i],mes[i],ano[i],feita[i]?"X":" ");
								else
									System.out.printf("%d: %-40s  %10s %25s\n",(i+1),texto[i]," ",feita[i]?"X":" ");
							}
						}	
						if(!haTarefasFeitas)
							System.out.println("Não tem nenhuma tarefa feita.");
						
						System.out.println();
						
						break;
					case 'R': case 'r':
						System.out.println("Insira o nome da tarefa a pesquisar:");
						String tarefaPesquisar = input.next();
						input.nextLine();
						boolean encontraPalavra=true, porPalavra=false;
						for (int i = 0;i < nTarefas; i++) {
							for (int j = 0;j < texto[i].length(); j++) {
								encontraPalavra=true;
								for (int k = 0;k < tarefaPesquisar.length(); k++) {
									if((j+k) < texto[i].length()) {
										if (texto[i].toUpperCase().charAt(j+k) != tarefaPesquisar.toUpperCase().charAt(k)) { //ERRO
											encontraPalavra=false;
											break;
										}
									}else {
										encontraPalavra=false;
									}
								}
								
								if(encontraPalavra)
									break;
							}
							
							if(encontraPalavra) {
								if(!porPalavra) {
									System.out.println("   Tarefa                                    Data                               Feito");
									porPalavra=true;
								}
								System.out.printf("%d: %-40s  %02d/%02d/%04d %25s\n",(i+1),texto[i],dia[i],mes[i],ano[i],feita[i]?"X":" ");
							}
						}
						
						if(!porPalavra)
							System.out.println("Não foi encontrado nada relativamente a sua pesquisa.");
						
						System.out.println();
						
						break;
					case 'V': case 'v':
						break;
					default: System.out.println("Opção inválida!");
					}
				}while(escolhaVisualizar!='V' && escolhaVisualizar!='v');
				break;
				
			//Menu Marcar
			case 'M': case 'm':
				char escolhaMarcar = 0;
				do{
					System.out.println("Escolha novamente uma das iniciais seguintes:");
					System.out.println("Marcar como (f)eita");
					System.out.println("Marcar (t)odas");
					System.out.println("Marcar todas (n)o dia d");
					System.out.println("Marcar todas (a)té dia d");
					System.out.println("(D)esmarcar todas");
					System.out.println("(V)oltar");
					escolhaMarcar=input.next().charAt(0);
					
					switch(escolhaMarcar) {
					case 'F': case 'f':
						System.out.println("Escolha o número da tarefa:");
						int numeroTarefa=input.nextInt();
						boolean marcaFeita=false;
						for(int i = 0; i < nTarefas; i++) {
							if(i+1 == numeroTarefa && !feita[i]) {
								feita[i]=true;
								if(!marcaFeita) {
									System.out.println("   Tarefa                                    Data                               Feito");
									marcaFeita=true;
								}
								if(dia[i] != 0)
									System.out.printf("%d: %-40s  %02d/%02d/%04d %25s\n",(i+1),texto[i],dia[i],mes[i],ano[i],feita[i]?"X":" ");
								else
									System.out.printf("%d: %-40s  %10s %25s\n",(i+1),texto[i]," ",feita[i]?"X":" ");
							}
						}
						if(!marcaFeita)
							System.out.println("Esta tarefa já se encontra feita.");
						
						System.out.println();
						
						break;
					case 'T': case 't':
						boolean marcaTodas=false;
						for(int i = 0;i < nTarefas; i++) {
							feita[i]=true;
							if(!marcaTodas) {
								System.out.println("Todas as tarefas foram marcadas como feitas com êxito.");
								System.out.println("   Tarefa                                    Data                               Feito");
								marcaTodas=true;
							}
							if(dia[i] != 0)
								System.out.printf("%d: %-40s  %02d/%02d/%04d %25s\n",(i+1),texto[i],dia[i],mes[i],ano[i],feita[i]?"X":" ");
							else
								System.out.printf("%d: %-40s  %10s %25s\n",(i+1),texto[i]," ",feita[i]?"X":" ");
						}
						
						System.out.println();
							
						break;
					case 'N': case 'n':
						boolean marcaNoDia=false;
						int mesPesquisar=0;
						do {
							System.out.println("Insira o mês desejado:");
							mesPesquisar=input.nextInt();
						}while(mesPesquisar < 1 || mesPesquisar > 12);
						
						int anoPesquisar=0;
						do{
							System.out.println("Insira o ano desejado:");
							anoPesquisar=input.nextInt();
							
							if (anoPesquisar%4==0 && anoPesquisar%100!=0 || anoPesquisar%400==0){
								diasCadaMes[1]=29;
							}else{
								diasCadaMes[1]=28;
							}
						}while(anoPesquisar < 1900);
						
						int diaPesquisar=0;
						do {
							System.out.println("Insira o dia desejado:");
							diaPesquisar=input.nextInt();
						}while (diaPesquisar < 1 || diaPesquisar > diasCadaMes[mesPesquisar-1]);
						
						for(int i = 0;i < nTarefas; i++) {
							if(diaPesquisar==dia[i] && mesPesquisar==mes[i] && anoPesquisar==ano[i]) {
								feita[i]=true;
								if(!marcaNoDia) {
									System.out.println("   Tarefa                                    Data                               Feito");
									marcaNoDia=true;
								}
								System.out.printf("%d: %-40s  %02d/%02d/%04d %25s\n",(i+1),texto[i],dia[i],mes[i],ano[i],feita[i]?"X":" ");
							}
						}
						if(!marcaNoDia)
							System.out.println("Não foram encontradas tarefas do dia " + diaPesquisar + "/" + mesPesquisar + "/" + anoPesquisar + " ou já se encontram todas feitas.");
						
						System.out.println();
						
						break;
					case 'A': case 'a':
						boolean marcaAteDia=false;
						int mesPsq=0;
						do {
							System.out.println("Insira o mês desejado:");
							mesPsq=input.nextInt();
						}while(mesPsq < 1 || mesPsq > 12);
						
						int anoPsq=0;
						do {
							System.out.println("Insira o ano desejado:");
							anoPsq=input.nextInt();
							
							if (anoPsq%4==0 && anoPsq%100!=0 || anoPsq%400==0){
								diasCadaMes[1]=29;
							}else{
								diasCadaMes[1]=28;
							}
						}while(anoPsq < 1900);
						
						int diaPsq=0;
						do {
							System.out.println("Insira o dia desejado:");
							diaPsq=input.nextInt();
						}while(diaPsq < 1 || diaPsq > diasCadaMes[mesPsq-1]);
						
						for(int i = 0;i < nTarefas;i++) {
							if(dia[i]<=diaPsq && mesPsq == mes[i] && anoPsq == ano[i] && dia[i]!=0) {
								feita[i]=true;
								if(!marcaAteDia) {
									System.out.println("Todas as tarefas até ao dia " + diaPsq + " foram marcadas com êxito.");
									System.out.println("   Tarefa                                    Data                               Feito");
									marcaAteDia=true;
								}
								System.out.printf("%d: %-40s  %02d/%02d/%04d %25s\n",(i+1),texto[i],dia[i],mes[i],ano[i],feita[i]?"X":" ");
							}
						}
						if(!marcaAteDia)
							System.out.println("Não foram encontradas tarefas do dia " + diaPsq + "/" + mesPsq + "/" + anoPsq + " ou dias anteriores.");
						
						System.out.println();
							
						break;
					case 'D': case 'd':
						boolean desmarcaTodas=false;
						for(int i = 0;i < nTarefas;i++) {
							feita[i]=false;
							if(!desmarcaTodas) {
								System.out.println("Todas as tarefas foram desmarcadas como feitas com êxito.");
								System.out.println("   Tarefa                                    Data                               Feito");
								desmarcaTodas=true;
							}
							if(dia[i] != 0)
								System.out.printf("%d: %-40s  %02d/%02d/%04d %25s\n",(i+1),texto[i],dia[i],mes[i],ano[i],feita[i]?"X":" ");
							else
								System.out.printf("%d: %-40s  %10s %25s\n",(i+1),texto[i]," ",feita[i]?"X":" ");
						}
						
						System.out.println();
						
						break;
					case 'V': case 'v':
						break;
					default: System.out.println("Opção inválida!");
					}
				}while(escolhaMarcar!='V' && escolhaMarcar!='v');
				break;
				
			//Menu Editar
            case 'E': case 'e':
            	char escolhaEditar = 0;
                do{
                    System.out.println("Escolha novamente uma das iniciais seguintes:");
                    System.out.println("(A)dicionar tarefa");
                    System.out.println("Adicionar (t)arefa na posição n");
                    System.out.println("Apagar tarefa na (p)osição n");
                    System.out.println("Apagar (f)eitas");
                    System.out.println("(M)over tarefa da posição n para a m");
                    System.out.println("(J)untar tarefas");
                    System.out.println("(E)ditar tarefa");
                    System.out.println("(V)oltar");
                    escolhaEditar = input.next().charAt(0);
                    input.nextLine();
                   
                    int posicaoTarefaN = 0;
                    int posicaoTarefaM = 0;
                    switch(escolhaEditar) {
                    case 'A': case 'a':
                        if(nTarefas < tamMax) {
                            char temData = 0;
                           
                            System.out.println("Qual a tarefa?:");
                            texto[nTarefas] = input.nextLine();
                   
                            System.out.println("A tarefa tem data? s/n");
                            temData = input.next().charAt(0);
                            input.nextLine();
                   
                            if(temData == 's' || temData == 'S') {
                                do {
                                    System.out.println("Qual é o mês?:");
                                    mes[nTarefas] = input.nextInt();
                                }while(mes[nTarefas] < 1 || mes[nTarefas] > 12);
                   
                                do{
                                    System.out.println("Qual é o ano?:");
                                    ano[nTarefas] = input.nextInt();
                                   
                                    if (ano[nTarefas]%4==0 && ano[nTarefas]%100!=0 || ano[nTarefas]%400==0){
                                        diasCadaMes[1]=29;
                                    }else{
                                        diasCadaMes[1]=28;
                                    }
                                }while(ano[nTarefas] < 1900);
                               
                                do {
                                    System.out.println("Qual é o dia?:");
                                    dia[nTarefas] = input.nextInt();
                                }while(dia[nTarefas] < 1 || dia[nTarefas] > diasCadaMes[mes[nTarefas]-1]);
                            }
                   
                            System.out.println("A tarefa foi guardada.");
                   
                            nTarefas+=1;
                            
                            System.out.println("   Tarefa                                    Data                               Feito");
	                     	for(int i = 0; i < nTarefas; i++){
	                     		if(dia[i] != 0)
	                     			System.out.printf("%d: %-40s  %02d/%02d/%04d %25s\n",(i+1),texto[i],dia[i],mes[i],ano[i],feita[i]?"X":" ");
	                     		else
	                                 System.out.printf("%d: %-40s  %10s %25s\n",(i+1),texto[i]," ",feita[i]?"X":" ");
	                     	}
                        }else {
                            System.out.println("Chegou ao limite de tarefas.");
                        }
                        
                        System.out.println();
                        
                        break;
                    case 'T': case 't':
                        if(nTarefas < tamMax) {
                            char temData = 0;
                   
                            do {
                                System.out.println("Qual é a posição onde quer guardar a tarefa?:");
                                posicaoTarefaN = input.nextInt();
                                input.nextLine();
                            }while(posicaoTarefaN < 1 || posicaoTarefaN > 100);
                   
                            if(posicaoTarefaN < nTarefas) {
                                for(int i = nTarefas; i >= posicaoTarefaN; i--) {
                                    texto[i] = texto[i-1];
                                    prazo[i] = prazo[i-1];
                                    feita[i] = feita[i-1];
                                    dia[i] = dia[i-1];
                                    mes[i] = mes[i-1];
                                    ano[i] = ano[i-1];
                                }
                   
                                texto[posicaoTarefaN-1] = "";
                                prazo[posicaoTarefaN-1] = true;
                                feita[posicaoTarefaN-1] = false;
                                dia[posicaoTarefaN-1] = 0;
                                mes[posicaoTarefaN-1] = 0;
                                ano[posicaoTarefaN-1] = 0;
                            }else {
                                System.out.println("Não é possivel guardar nessa posição, vai ser guardada na posição "+(nTarefas+1));
                                posicaoTarefaN = (nTarefas+1);
                            }
                   
                            System.out.println("Qual a tarefa?:");
                            texto[posicaoTarefaN-1] = input.nextLine();
                   
                            System.out.println("A tarefa tem data? s/n");
                            temData = input.next().charAt(0);
                            input.nextLine();
                   
                            if(temData == 's' || temData == 'S') {
                                do {
                                    System.out.println("Qual é o mês?:");
                                    mes[posicaoTarefaN-1] = input.nextInt();
                                }while(mes[posicaoTarefaN-1] < 1 || mes[posicaoTarefaN-1] > 12);
                   
                                do {
                                    System.out.println("Qual é o ano?:");
                                    ano[posicaoTarefaN-1] = input.nextInt();
                                   
                                    if (ano[posicaoTarefaN-1]%4==0 && ano[posicaoTarefaN-1]%100!=0 || ano[posicaoTarefaN-1]%400==0){
                                        diasCadaMes[1]=29;
                                    }else{
                                        diasCadaMes[1]=28;
                                    }
                                }while(ano[posicaoTarefaN-1] < 1900);
                               
                                do {
                                    System.out.println("Qual é o dia?:");
                                    dia[posicaoTarefaN-1] = input.nextInt();
                                }while(dia[posicaoTarefaN-1] < 1 || dia[posicaoTarefaN-1] > diasCadaMes[mes[posicaoTarefaN-1]-1]);
                            }
                   
                            System.out.println("A tarefa foi guardada.");
                   
                            nTarefas+=1;
                            
                            System.out.println("   Tarefa                                    Data                               Feito");
	                     	for(int i = 0; i < nTarefas; i++){
	                     		if(dia[i] != 0)
	                     			System.out.printf("%d: %-40s  %02d/%02d/%04d %25s\n",(i+1),texto[i],dia[i],mes[i],ano[i],feita[i]?"X":" ");
	                     		else
	                                 System.out.printf("%d: %-40s  %10s %25s\n",(i+1),texto[i]," ",feita[i]?"X":" ");
	                     	}
                        }else {
                            System.out.println("Chegou ao limite de tarefas.");
                        }
                        
                        System.out.println();
                        
                        break;
                    case 'P': case 'p':
	                    if(nTarefas > 0) {
	                        do {
	                            System.out.println("Qual é a posição da tarefa que quer apagar?:");
	                            posicaoTarefaN = input.nextInt();
	                        }while(posicaoTarefaN < 1 || posicaoTarefaN > nTarefas);
	                   
	                        System.out.println("A tarefa "+texto[posicaoTarefaN-1]+" foi apagada.");
	                   
	                        for(int i = posicaoTarefaN; i < nTarefas; i++) {
	                            texto[i-1] = texto[i];
	                            prazo[i-1] = prazo[i];
	                            feita[i-1] = feita[i];
	                            dia[i-1] = dia[i];
	                            mes[i-1] = mes[i];
	                            ano[i-1] = ano[i];
	                        }
	                        
	                        nTarefas-=1;
	                        
	                        System.out.println("   Tarefa                                    Data                               Feito");
	                     	for(int i = 0; i < nTarefas; i++){
	                     		if(dia[i] != 0)
	                     			System.out.printf("%d: %-40s  %02d/%02d/%04d %25s\n",(i+1),texto[i],dia[i],mes[i],ano[i],feita[i]?"X":" ");
	                     		else
	                     			System.out.printf("%d: %-40s  %10s %25s\n",(i+1),texto[i]," ",feita[i]?"X":" ");
	                     	}
	                    }else {
	                    	System.out.println("Não tem tarefas guardadas.");
	                    }
	                    
	                    System.out.println();
	                    
                        break;
                    case 'F': case 'f':
                    	if(nTarefas > 0) {
                    		int posicaoDestinoTarefa = 0;
                    		int contTarefasApagadas = 0;
	                        
                    		for(int i = 0; i < nTarefas; i++) {
	                        	if(!feita[i] && posicaoDestinoTarefa < nTarefas) {
	                        		if(posicaoDestinoTarefa!=i) {
		                        		contTarefasApagadas++;
		                        			
		                        		texto[posicaoDestinoTarefa]=texto[i];
		                        		prazo[posicaoDestinoTarefa]=prazo[i];
		                        		feita[posicaoDestinoTarefa]=feita[i];
			        	                dia[posicaoDestinoTarefa]=dia[i];
			        	                mes[posicaoDestinoTarefa]=mes[i];
			        	                ano[posicaoDestinoTarefa]=ano[i];
		                        			
	                        		}
		        	                    	
		        	                   posicaoDestinoTarefa++;
		        	                    
	                        	}
	                        		
	                        }
	                        
                    		if(contTarefasApagadas == 0) {
                    			System.out.println("Não há tarefas feitas.");
	                        }else {
	                        	System.out.println("Foram apagadas "+contTarefasApagadas+" tarefas.");
	                        	nTarefas-=contTarefasApagadas;
	                        	System.out.println("   Tarefa                                    Data                               Feito");
	                            for(int i = 0; i < nTarefas; i++){
	                            	 if(dia[i] != 0)
	                            		 System.out.printf("%d: %-40s  %02d/%02d/%04d %25s\n",(i+1),texto[i],dia[i],mes[i],ano[i],feita[i]?"X":" ");
	                            	 else
	                                     System.out.printf("%d: %-40s  %10s %25s\n",(i+1),texto[i]," ",feita[i]?"X":" ");
	                            }
	                        }
                    	}else {
	                    	System.out.println("Não tem tarefas guardadas.");
	                    }
                        
                    	System.out.println();
                    	
                        break;
                    case 'M': case 'm':
                    	if(nTarefas > 0) {
                    		do {
                        		System.out.println("Indique a posição da tarefa que quer mover:");
                        	    posicaoTarefaN = input.nextInt();
                        	}while(posicaoTarefaN > nTarefas);
                        	    
                        	do {
                        		System.out.println("Indique para que posição quer mover a tarefa:");
                        	    posicaoTarefaM = input.nextInt();
                        	}while(posicaoTarefaM > nTarefas);
                        	    
                        	String textoTemp = texto[posicaoTarefaN-1];
                        	boolean prazoTemp = prazo[posicaoTarefaN-1];
                        	boolean feitaTemp = feita[posicaoTarefaN-1];
                        	int diaTemp = dia[posicaoTarefaN-1];
                        	int mesTemp = mes[posicaoTarefaN-1];
                        	int anoTemp = ano[posicaoTarefaN-1];
                        	    
                        	if(posicaoTarefaN < posicaoTarefaM) {
                        		for(int i = (posicaoTarefaN-1); i <= (posicaoTarefaM-1); i++) {
                        			if(i!=(posicaoTarefaM-1)) {
                        				texto[i] = texto[i+1];
    	                    	    	prazo[i] = prazo[i+1];
    	                    	    	feita[i] = feita[i+1];
    	                    	    	dia[i] = dia[i+1];
    	                    	    	mes[i] = mes[i+1];
    	                    	    	ano[i] = ano[i+1];
    	                    	    }else {
    	                    	    	texto[i] = textoTemp;
    	                    	    	prazo[i] = prazoTemp;
    	                    	    	feita[i] = feitaTemp;
    	                    	    	dia[i] = diaTemp;
    	                    	    	mes[i] = mesTemp;
    	                    	    	ano[i] = anoTemp;
    	                    	    }
                        		}
                        	}else {
                        		for(int i = (posicaoTarefaN-1); i >= (posicaoTarefaM-1); i--) {
                        			if(i!=(posicaoTarefaM-1)) {
    	                    	    	texto[i] = texto[i-1];
    	                    	    	prazo[i] = prazo[i-1];
    	                    	    	feita[i] = feita[i-1];
    	                    	    	dia[i] = dia[i-1];
    	                    	    	mes[i] = mes[i-1];
    	                    	    	ano[i] = ano[i-1];
    	                    	    }else {
    	                    	    	texto[i] = textoTemp;
    	                    	    	prazo[i] = prazoTemp;
    	                    	    	feita[i] = feitaTemp;
    	                    	    	dia[i] = diaTemp;
    	                    	    	mes[i] = mesTemp;
    	                    	    	ano[i] = anoTemp;
    	                    	    }
                        		}
                        	}
                        	    
                        	System.out.println("A tarefa foi movida.");
                        	System.out.println("   Tarefa                                    Data                               Feito");
                         	for(int i = 0; i < nTarefas; i++){
                         		if(dia[i] != 0)
                         			System.out.printf("%d: %-40s  %02d/%02d/%04d %25s\n",(i+1),texto[i],dia[i],mes[i],ano[i],feita[i]?"X":" ");
                         		else
                         			System.out.printf("%d: %-40s  %10s %25s\n",(i+1),texto[i]," ",feita[i]?"X":" ");
                         	}
                    	}else {
                    		System.out.println("Não tem tarefas guardadas.");
                    	}
                    	 
                     	System.out.println();
                     	
                        break;
                    case 'J': case 'j':
                    	if(nTarefas > 0) {
                    		do {
    	                    	System.out.println("Qual é a posição da primeira tarefa que quer juntar?:");
    	                    	posicaoTarefaN = input.nextInt();
                        	}while(posicaoTarefaN > nTarefas);
                        		
                        	do {
                        		System.out.println("Qual é a posição da segunda tarefa que quer juntar?:");
                        		posicaoTarefaM = input.nextInt();
                        	}while(posicaoTarefaM > nTarefas);
                        		
                        	posicaoTarefaN--;
                        	posicaoTarefaM--;
                        		
                        	String textoTarefaJunta = texto[posicaoTarefaN]+", "+texto[posicaoTarefaM];
                        	boolean prazoTarefaJunta = prazo[posicaoTarefaN];
                        	boolean feitaTarefaJunta = false;
                        	if(feita[posicaoTarefaN] && feita[posicaoTarefaM]){
                        		feitaTarefaJunta = true;
                        	}
                        	int diaTarefaJunta = 0;
                        	int mesTarefaJunta = 0;
                        	int anoTarefaJunta = 0;
                        	if(dia[posicaoTarefaN] == 0) {
                        		diaTarefaJunta = dia[posicaoTarefaM];
                        		mesTarefaJunta = mes[posicaoTarefaM];
                        		anoTarefaJunta = ano[posicaoTarefaM];
                        	}else if(dia[posicaoTarefaM] == 0) {
                        		diaTarefaJunta = dia[posicaoTarefaN];
                        		mesTarefaJunta = mes[posicaoTarefaN];
                        		anoTarefaJunta = ano[posicaoTarefaN];
                        	}else {
    	                    	if(ano[posicaoTarefaN] < ano[posicaoTarefaM]) {
    	                    		diaTarefaJunta = dia[posicaoTarefaN];
    	                    		mesTarefaJunta = mes[posicaoTarefaN];
    	                    		anoTarefaJunta = ano[posicaoTarefaN];
    	                    	}else if(ano[posicaoTarefaN] == ano[posicaoTarefaM]) {
    	                    		if(mes[posicaoTarefaN] < mes[posicaoTarefaM]) {
    	                    			diaTarefaJunta = dia[posicaoTarefaN];
    	                        		mesTarefaJunta = mes[posicaoTarefaN];
    	                        		anoTarefaJunta = ano[posicaoTarefaN];
    	                    		}else if(mes[posicaoTarefaN] == mes[posicaoTarefaM]) {
    	                    			if(dia[posicaoTarefaN] < dia[posicaoTarefaM]) {
    	                    				diaTarefaJunta = dia[posicaoTarefaN];
    	                            		mesTarefaJunta = mes[posicaoTarefaN];
    	                            		anoTarefaJunta = ano[posicaoTarefaN];
    	                    			}else if(dia[posicaoTarefaN] == dia[posicaoTarefaM]) {
    	                    				diaTarefaJunta = dia[posicaoTarefaN];
    	                            		mesTarefaJunta = mes[posicaoTarefaN];
    	                            		anoTarefaJunta = ano[posicaoTarefaN];
    	                    			}else {
    	                    				diaTarefaJunta = dia[posicaoTarefaM];
    	                            		mesTarefaJunta = mes[posicaoTarefaM];
    	                            		anoTarefaJunta = ano[posicaoTarefaM];
    	                    			}
    	                    		}else {
    	                    			diaTarefaJunta = dia[posicaoTarefaM];
    	                        		mesTarefaJunta = mes[posicaoTarefaM];
    	                        		anoTarefaJunta = ano[posicaoTarefaM];
    	                    		}
    	                    	}else {
    	                    		diaTarefaJunta = dia[posicaoTarefaM];
    	                    		mesTarefaJunta = mes[posicaoTarefaM];
    	                    		anoTarefaJunta = ano[posicaoTarefaM];
    	                    	}
                        	}
                        		
                        	nTarefas--;
                        		
                        	if(posicaoTarefaN < posicaoTarefaM) {
    	                    	texto[posicaoTarefaN] = textoTarefaJunta;
    		        	    	prazo[posicaoTarefaN] = prazoTarefaJunta;
    		        	    	feita[posicaoTarefaN] = feitaTarefaJunta;
    		        	    	dia[posicaoTarefaN] = diaTarefaJunta;
    		        	    	mes[posicaoTarefaN] = mesTarefaJunta;
    		        	    	ano[posicaoTarefaN] = anoTarefaJunta;
    		        	    			
    		        	    	for(int i=posicaoTarefaM; i<nTarefas; i++) {
    		        	    		texto[i] = texto[i+1];
                        	    	prazo[i] = prazo[i+1];
                        	    	feita[i] = feita[i+1];
                        	    	dia[i] = dia[i+1];
                        	    	mes[i] = mes[i+1];
                        	    	ano[i] = ano[i+1];
    		        	    	}
                        	}else {
                        		texto[posicaoTarefaM] = textoTarefaJunta;
    		        	    	prazo[posicaoTarefaM] = prazoTarefaJunta;
    		        	    	feita[posicaoTarefaM] = feitaTarefaJunta;
    		        	    	dia[posicaoTarefaM] = diaTarefaJunta;
    		        	    	mes[posicaoTarefaM] = mesTarefaJunta;
    		        	    	ano[posicaoTarefaM] = anoTarefaJunta;
    		        	    			
    		        	    	for(int i=posicaoTarefaN; i<nTarefas; i++) {
    		        	    		texto[i] = texto[i+1];
                        	    	prazo[i] = prazo[i+1];
                        	    	feita[i] = feita[i+1];
                        	    	dia[i] = dia[i+1];
                        	    	mes[i] = mes[i+1];
                        	    	ano[i] = ano[i+1];
    		        	    	}
                        	}
                        		
                        	System.out.println("As tarefas foram juntadas.");
                        	System.out.println("   Tarefa                                    Data                               Feito");
                        	for(int i = 0; i < nTarefas; i++){
                        		if(dia[i] != 0)
                        			System.out.printf("%d: %-40s  %02d/%02d/%04d %25s\n",(i+1),texto[i],dia[i],mes[i],ano[i],feita[i]?"X":" ");
                        		else
                                    System.out.printf("%d: %-40s  %10s %25s\n",(i+1),texto[i]," ",feita[i]?"X":" ");
                            }
                    	}else {
                    		System.out.println("Não tem tarefas guardadas.");
                    	}
                    	
                    	System.out.println();
                            
                        break;
                    case 'E': case 'e':
                        if(nTarefas > 0) {
                        	char escolhaEditarTarefa = 0;
                            do {
                                System.out.println("Escolha novamente uma das iniciais seguintes:");
                                System.out.println("(E)ditar Texto");
                                System.out.println("(R)emover/Adicionar data");
                                System.out.println("Editar (d)ata");
                                System.out.println("(V)oltar");
                                escolhaEditarTarefa = input.next().charAt(0);
                                input.nextLine();
                       
                                int posicaoTarefa = 0;
                                switch(escolhaEditarTarefa) {
                                case 'E': case 'e':
                                	if(nTarefas > 0) {
                                		do {
        	                                System.out.println("Qual é a posição da tarefa que pertende mudar?:");
        	                                posicaoTarefa = input.nextInt();
                                    	}while(posicaoTarefa > nTarefas);
                                    	input.nextLine();
                                    		
                                    	posicaoTarefa--;
                                    		
                                    	String novoTexto = "";
                                    	System.out.println("Escreva o novo texto:");
                                    	novoTexto = input.nextLine();
                                    		
                                    	texto[posicaoTarefa] = novoTexto;
                                    		
                                    	System.out.println("O texto foi alterado.");
                                    	System.out.println("   Tarefa                                    Data                               Feito");
                                    	for(int i = 0; i < nTarefas; i++){
                                    		if(dia[i] != 0)
                                    			System.out.printf("%d: %-40s  %02d/%02d/%04d %25s\n",(i+1),texto[i],dia[i],mes[i],ano[i],feita[i]?"X":" ");
                                    		else
                                                System.out.printf("%d: %-40s  %10s %25s\n",(i+1),texto[i]," ",feita[i]?"X":" ");
                                    	}
                                	}else {
                                		System.out.println("Não tem tarefas guardadas.");
                                	}
                                	
                                	System.out.println();
                                		
                                    break;
                                case 'R': case 'r':
                                	if(nTarefas > 0) {
                                		do {
                                    		System.out.println("Qual é a posição da tarefa que pertende mudar?:");
        	                                posicaoTarefa = input.nextInt();
                                    	}while(posicaoTarefa > nTarefas);
                                    	input.nextLine();
                                    		
                                    	posicaoTarefa--;
                                    		
                                    	char adicionarRemoverData = 0;
                                    	if(dia[posicaoTarefa]==0) {
                                    		System.out.println("Pretende adicionar uma data? s/n");
                                    		adicionarRemoverData = input.next().charAt(0);
                                    		if(adicionarRemoverData == 's' || adicionarRemoverData == 'S') {
                                    			do {	
                                    				System.out.println("Qual é o mês?:");
                                    				mes[posicaoTarefa] = input.nextInt();
                                    			}while(mes[posicaoTarefa] < 1 || mes[posicaoTarefa] > 12);
                                       
                                    			do {
                                    				System.out.println("Qual é o ano?:");
                                    				ano[posicaoTarefa] = input.nextInt();
                                    					
                                    				if (ano[posicaoTarefa]%4==0 && ano[posicaoTarefa]%100!=0 || ano[posicaoTarefa]%400==0){
                                    					diasCadaMes[1]=29;
                                                    }else{
                                                        diasCadaMes[1]=28;
                                                    }
                                    			}while(ano[posicaoTarefa] < 1900);
                                                   
                                                do {
                                                    System.out.println("Qual é o dia?:");
                                                    dia[posicaoTarefa] = input.nextInt();
                                                }while(dia[posicaoTarefa] < 1 || dia[posicaoTarefa] > diasCadaMes[mes[posicaoTarefa]-1]);
                                                 
                                                System.out.println("A data foi adicionada.");
                                                System.out.println("   Tarefa                                    Data                               Feito");
                                         		for(int i = 0; i < nTarefas; i++){
                                         			if(dia[i] != 0)
                                         				System.out.printf("%d: %-40s  %02d/%02d/%04d %25s\n",(i+1),texto[i],dia[i],mes[i],ano[i],feita[i]?"X":" ");
                                         			else
                                                     	System.out.printf("%d: %-40s  %10s %25s\n",(i+1),texto[i]," ",feita[i]?"X":" ");
                                         		}
                                    		}else {
                                    			System.out.println("Não foi adicionada uma data.");
                                    		}
                                    			
                                    	}else {
                                    		System.out.println("Pretende remover a data? s/n");
                                    		adicionarRemoverData = input.next().charAt(0);
                                    			
                                    		if(adicionarRemoverData == 's' || adicionarRemoverData == 'S') {
                                    			dia[posicaoTarefa] = 0;
                                    			mes[posicaoTarefa] = 0;
                                    			ano[posicaoTarefa] = 0;
                                    				
                                    			System.out.println("A data foi removida.");
                                    			System.out.println("   Tarefa                                    Data                               Feito");
                                            	for(int i = 0; i < nTarefas; i++){
                                            		if(dia[i] != 0)
                                            			System.out.printf("%d: %-40s  %02d/%02d/%04d %25s\n",(i+1),texto[i],dia[i],mes[i],ano[i],feita[i]?"X":" ");
                                            		else
                                                        System.out.printf("%d: %-40s  %10s %25s\n",(i+1),texto[i]," ",feita[i]?"X":" ");
                                            		}
                                    		}else {
                                    			System.out.println("A data não foi removida.");
                                    		}
                                    	}
                                	}else {
                                		System.out.println("Não tem tarefas guardadas.");
                                	}
                                	
                                	System.out.println();
                                	
                                    break;
                                case 'D': case 'd':
                                	if(nTarefas > 0) {
                                		do {
        	                                System.out.println("Qual é a posição da tarefa que pertende mudar?:");
        	                                posicaoTarefa = input.nextInt();
                                    	}while(posicaoTarefa > nTarefas);
                                    	input.nextLine();
                                    		
                                    	posicaoTarefa--;
                                    		
                                    	do {	
                            				System.out.println("Qual é o mês?:");
                            				mes[posicaoTarefa] = input.nextInt();
                            			}while(mes[posicaoTarefa] < 1 || mes[posicaoTarefa] > 12);
                               
                            			do {
                            				System.out.println("Qual é o ano?:");
                            				ano[posicaoTarefa] = input.nextInt();
                            					
                            				if (ano[posicaoTarefa]%4==0 && ano[posicaoTarefa]%100!=0 || ano[posicaoTarefa]%400==0){
                            					diasCadaMes[1]=29;
                                            }else{
                                                diasCadaMes[1]=28;
                                            }
                            			}while(ano[posicaoTarefa] < 1900);
                                           
                                        do {
                                            System.out.println("Qual é o dia?:");
                                            dia[posicaoTarefa] = input.nextInt();
                                        }while(dia[posicaoTarefa] < 1 || dia[posicaoTarefa] > diasCadaMes[mes[posicaoTarefa]-1]);
                                    		
                                        System.out.println("A data foi alterada.");
                                        System.out.println("   Tarefa                                    Data                               Feito");
                                 		for(int i = 0; i < nTarefas; i++){
                                 			if(dia[i] != 0)
                                 				System.out.printf("%d: %-40s  %02d/%02d/%04d %25s\n",(i+1),texto[i],dia[i],mes[i],ano[i],feita[i]?"X":" ");
                                 			else
                                             	System.out.printf("%d: %-40s  %10s %25s\n",(i+1),texto[i]," ",feita[i]?"X":" ");
                                 		}
                                	}else {
                                		System.out.println("Não tem tarefas guardadas.");
                                	}
                             		
                             		System.out.println();
                             		
                                    break;
                                case 'V': case 'v':
                                    break;
                                default: System.out.println("Opção Inválida!");
                                }
                            }while(escolhaEditarTarefa!='V' && escolhaEditarTarefa!='v');
                        }else {
                        	System.out.println("Não tem tarefas guardadas.");
                        }
                        break;
                    case 'V': case 'v':
                        break;
                    default: System.out.println("Opção Inválida!");
                    }
                }while(escolhaEditar!='V' && escolhaEditar!='v');
                break;
            default: System.out.println("Opção Inválida!");
            }
        }while (escolhaMenu!='S' && escolhaMenu!='s');
       
        input.close();
        
    }
 
}