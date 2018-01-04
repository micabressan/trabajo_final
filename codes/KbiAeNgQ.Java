import java.util.Scanner;

public class Main {

    public static void main(String[] args) {
        Scanner in = new Scanner(System.in);
        int Month = 12;
        int Date = 28;
        int Hours = 15;
        int Minutes = 42;
        System.out.println("До ЕГЭ осталось Месяцев: "+(17-Month)+ " Дней: "+(31-Date)+ " Часов: "+ (24-Hours-1)+ " Минут: "+ (60-Minutes));

    }
}