package monte;
import java.util.*;

public class Monte {
    public static void main(String[] args) {
        Random r = new Random(); int licznik = 0;
        for (int i = 0; i < 100; i++) {
            double x = r.nextDouble(), y = r.nextDouble();
            if (y <= Math.pow(x, 2))  licznik++;
        } System.out.println(licznik / 100.0);        
    }
}