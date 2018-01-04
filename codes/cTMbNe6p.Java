public class Solutions {
    public static void main(String[] args) {

        Scanner input = new Scanner(System.in);
        int number = input.nextInt();
        int[] arr = IntStream.rangeClosed(1, number).toArray();
        int sum = IntStream.of(arr)
                .map(Solutions::countOnes)
                .sum();
        System.out.println(sum);
    }

    private static int countOnes(int number) {
        int result = 0;
        while (number != 0) {
            int a = number % 10;
            number /= 10;
            if (a == 1) {
                result++;
            }
        }
        return result;
    }
}