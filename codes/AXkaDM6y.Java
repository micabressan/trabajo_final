 String ime;
    String prezime;
    int brind;
    double prosek;
    
    
    public static void main(String[] args) {
        Scanner s=new Scanner(System.in);
        Scanner i=new Scanner(System.in);
        Scanner l=new Scanner(System.in);
        Student t=new Student();
        Ucenik u=new Ucenik();
        t.ime = "Nemanja";
        t.prezime = "Stojanovic";
        t.brind = 15;
        System.out.println("Unesite prvi ocenu:");
        int a = s.nextInt();
        System.out.println("Unesite drugu ocenu:");
        int b = s.nextInt();
        System.out.println("Unesite trecu ocenu:");
        int c = s.nextInt();
        t.prosek = (a+b+c)/3;
        System.out.println("Podatci o studentu su:"+t.ime+" "+t.prezime+" "+t.brind+" "+t.prosek);
        
        u.ime = "Nikola";
        u.prezime = "Nikolic";
        u.brknjiz = 17;
        u.prosek = 8.50;
        System.out.println("Podatci o uceniku su:"+u.ime+" "+u.prezime+" "+u.brknjiz+" "+u.prosek);
        
        System.out.println("Da li zelite unos ili prikaz podataka:\n1- unos\n2- prikaz");
        int d = s.nextInt();
        System.out.println("1-student\n2-ucenik");
        int e = s.nextInt();
        
        if(d==1 && d==1){
            Student q = new Student();
            System.out.println("Unesite ime studenta:");
            q.ime = i.nextLine();
            System.out.println("Unesite prezime studenta:");
            q.prezime = i.nextLine();
            System.out.println("Unesi broj indeksa:");
            q.brind = i.nextInt();
             System.out.println("Unesite prvi ocenu:");
        int prva = i.nextInt();
        System.out.println("Unesite drugu ocenu:");
        int druga = i.nextInt();
        System.out.println("Unesite trecu ocenu:");
        int treca = i.nextInt();
        q.prosek = (prva+druga+treca)/3;
         System.out.println("Podatci o studentu su:"+q.ime+" "+q.prezime+" "+q.brind+" "+q.prosek);
            
        }
        
        if(d==2 && e==1){
        System.out.println("Podatci o studentu su:"+t.ime+" "+t.prezime+" "+t.brind+" "+t.prosek);
        }
        
        if(d==2 && e==2){
        System.out.println("Podatci o uceniku su:"+u.ime+" "+u.prezime+" "+u.brknjiz+" "+u.prosek);
        }
           if(d==1 && d==1){
            Ucenik k = new Ucenik();
            System.out.println("Unesite ime ucenika:");
            k.ime = i.nextLine();
            System.out.println("Unesite prezime ucenika:");
            k.prezime = i.nextLine();
            System.out.println("Unesi broj knjizice:");
            k.brknjiz = i.nextInt();
             System.out.println("Unesite prvi ocenu:");
        int prvaa = i.nextInt();
        System.out.println("Unesite drugu ocenu:");
        int drugaa = i.nextInt();
        System.out.println("Unesite trecu ocenu:");
        int trecaa = i.nextInt();
        k.prosek = (prvaa+drugaa+trecaa)/3;
         System.out.println("Podatci o studentu su:"+k.ime+" "+k.prezime+" "+k.brknjiz+" "+k.prosek);
            
        }
            if(d==2 && e==1){
        System.out.println("Podatci o studentu su:"+t.ime+" "+t.prezime+" "+t.brind+" "+t.prosek);
        }
        
        if(d==2 && e==2){
        System.out.println("Podatci o uceniku su:"+u.ime+" "+u.prezime+" "+u.brknjiz+" "+u.prosek);
        }
          
      }
           
            
        }