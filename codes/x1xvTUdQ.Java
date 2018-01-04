package testprelievo.TestPrelievo.it;

public class ContoCorrente {
    private String numeroConto;
    private String nominativo;
    private double giacenza;
    private String pin;
    
    public ContoCorrente(String numeroConto,String nominativo,double giacenza,String pin){
         this.numeroConto = numeroConto;
         this.nominativo = nominativo.toUpperCase();
         this.giacenza = giacenza;
         this.pin = pin;
    }
    
    public ContoCorrente(){
         this.numeroConto = "92154319";
         this.nominativo = "rossi marco".toUpperCase();
         this.giacenza = 1500.00;
         this.pin = "123456";
    }
    
    public String getNumeroConto(){
        return numeroConto;
    }
    
    public String getNominativo(){
        return nominativo;
    }
    
    public void SetPrelievo(double prelievo){
        this.giacenza -= prelievo;
    }
    
    public void Setversamento(double versamento){
        this.giacenza += versamento;
    }
    
    public double getGiacenza(){
        return giacenza;
    }
    
    public void printDati(){
        System.out.println("\tCONTO CORRENTE INTESTATO A: " + this.getNominativo() +"\n"+
                            "\tNUMERO CONTO: " + this.getNumeroConto() + " SALDO ATTUALE: "
                           + this.getGiacenza());
    }
}