public static void main(String []args){
PalindromeHelper myPalindrome = new PalindromeHelper(); //creating object
ReversePoemHelper myReversePoem = new ReversePoemHelper(); //creating object
AdoptAPetHelper myAdoptAPet = new AdoptAPetHelper(); //creating object
int choice ; // variable to hold user choice
while(true){ // loops until case 4 in switch executes
System.out.println("select 1. Palindrome Tester \t2. Reverse Poem \t3. Adopt-A-Pet \t4. exit");
choice = new Scanner(System.in).nextInt(); // user input for choice
switch(choice){
case 1 : myPalindrome.isPalindrome(); break;
case 2 : myReversePoem.readFileLoadStack(); break;
case 3 : myAdoptAPet.displayMenu(); break;
default : System.out.println("quitting! bye bye!"); System.exit(0);
// when other than 1,2,3 selected default case executes bye quitting the program
}
}
  
}
}

class PalindromeHelper{
public void isPalindrome(){
// write your implementation here
}
}

class ReversePoemHelper{
public void readFileLoadStack(){
// write your implementation here
}
}

class AdoptAPetHelper{
public void displayMenu(){
// write your implementation here
}