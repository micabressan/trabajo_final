import java.util.ArrayList;

public class HelloWorld{

     public static void main(String []args){
        ArrayList<String>id = new ArrayList<String>();
        ArrayList<String>version = new ArrayList<String>();
        String jsonStart = "{ 'entries':[ ";
        String jsonEnd = "]}";
        String body="";
        for(int d=0;d<3;d++){
            id.add(""+d);
            version.add("0"+d);
            
            String idPart =  " {'id':"+id.get(d);
            String versionPart = ", 'version': '"+version.get(d)+"'}";
            if(d!=3-1){
                versionPart+=",";
            }
            body+=idPart+versionPart;
            
            
        }
        
        System.out.println(jsonStart+body+jsonEnd);
        
     }
}