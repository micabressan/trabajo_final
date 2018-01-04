public class Main {
    public static void main(String[] args) {

        Scanner sc = new Scanner(System.in);
        System.out.println("Enter number N:");
        int n = sc.nextInt();
        for (int i = 0; i < n - 1; i++) {
            System.out.print("#");
            System.out.print(" ");
        }
        System.out.println("#");

        int empty = 2;
        int inside = n*2-1-6;

        for (int row = 0; row < (n - 2) / 2; row++) {

            for (int i = 0; i < empty; i++) {
                System.out.print(" ");
            }
            System.out.print("#");
            for (int i = 0; i < inside; i++) {
                System.out.print(" ");
            }
            System.out.print("#");
            System.out.println();

            empty += 2;
            inside -= 4;
        }
        for (int i = 0; i < 1; i++) {
            for (int j = 0; j < (n * 2 - 1) / 2; j++) {
                System.out.print(" ");
            }

            System.out.print("#");
            for (int j = 0; j < (n * 2 - 1) / 2; j++) {
                System.out.print(" ");
            }
            System.out.println();
        }

        for (int row = 0; row < (n - 2) / 2; row++) {
            empty -= 2;
            inside += 4;
            for (int i = 0; i < empty; i++) {
                System.out.print(" ");
            }
            System.out.print("#");
            for (int i = 0; i < inside; i++) {
                System.out.print(" ");
            }
            System.out.print("#");
            System.out.println();
        }
        for (int i = 0; i < n - 1; i++) {
            System.out.print("#");
            System.out.print(" ");
        }
        System.out.println("#");


    }
}