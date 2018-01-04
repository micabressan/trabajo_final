public class Classe {
// ############# Tela inicial da Classe #################### //
          
        private Conta conta;

        public Classe() {
             this.conta = new Conta();
        }

        public void sacar(int valorSaque) {
            if ((conta.getSaldo())<=valorSaque) {
                this.conta.getSaldo() = getSaldo - valorSaque; //O getSaldo() é da classe "Classe" ou do objeto conta? // >>>>>>> O getSado() é Classe "Conta"
            } else {
                System.out.println("oi?");   
            }
        }

        public static void main(String[] args) {
            System.out.println("============================================="); 
            System.out.println("Olá Bem vindo à sua conta!");
            System.out.println("Quanto você quer sacar?");
            valorSaque = ler.nextInt();
        }
}