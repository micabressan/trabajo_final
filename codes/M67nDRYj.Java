public class validace {
    
	   
    public static Boolean validate(String x) {
        // tohle muze vyhodit vyjimku kdyz String nebude mit length 11
        try {
            // vem ze stringu prvni 3 znaky (pozice 0,1,2)
            String ownerCode = x.substring(0, 3);
            System.out.println("owner code: " + ownerCode);


            String productGroupCode = x.substring(3, 4);
            System.out.println("product group code: " + productGroupCode);

            String productNumber = x.substring(4, 11);
            System.out.println("product number: " + productNumber);

            String check = x.substring(10, 11);
            System.out.println("check: " + check);
            
            // projdi vsechny znaky v ownerCode a checkni jestli jsou spravne
            for(int i = 0; i < ownerCode.length(); i++) {
                // vem znak na indexu i
                char c = ownerCode.charAt(i);
                
                // preved ho na integer (aby sel jednodusse porovnavat s ostatnima
                // pomoci < a > operatoru
                int charCode = (int) c;
                
                // jestli je charCode mensi nez hodnota znaku 'A' (v cisle)
                // tak je tam blbej znak (to samy pro Z)
                // kdybys nevedel proc, tak si pogoogli ASCII tabulku
                if(charCode < (int) 'A' || charCode > (int) 'Z') {
                    System.out.println("neplatny znak: " + c);
                    return false;
                }
            }
                
            
        }
        catch(IndexOutOfBoundsException e) {
            return false;
        }
        
        return false;
        
        
        
        for(int i = 0; i < productGroupCode.length(); i++) {
        	char a = productGroupCode.charAt(i);
        	int charCode = (int) a ;
        	
        	if(????????) {
        		System.out.println("neplatná skupna : ");
        		return false;
        	}
        	
        	
        	
        
        
        for(int i = 0; i < productCode.length; i++) {
        	
        	int result = Integer.parseInt(productCode);
        	
        
        	 if(productCode < 6 || productCode > 6) {
        		 System.out.println("nesprávny počet číšel: " );
        		 return false;
        	
        }
        
    } 
    
    

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        
        
        // tady to asi budes muset nejak nacist do promenny
        // (idealne celej ten string)
        String x = "CSIU2000820";
        
        System.out.println("validate: " + validate(x));
        
        
    }
    
}