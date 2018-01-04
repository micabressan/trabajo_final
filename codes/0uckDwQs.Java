
import java.util.Scanner;

public class StoneGame{
  public static void main(String[] args){
     
     int userPick = 0;
     int stone = 21;
     int currentValue = 21;
     
     
     Scanner input = new Scanner(System.in);
     
      do
      {
        
        System.out.println("No. of Stones Remaining: " + stone);
       
        currentValue = stone - userPick;
        
                
       do
       {
          System.out.print("User picks: ");
          userPick = input.nextInt();
          
          if (userPick == 1)
          {
            stone = stone - 1;
          }
          else if (userPick == 2)
          {
            stone = stone - 2;
          }
          else if (userPick == 3)
          {
            stone = stone - 3;
          }
          else if ( {
         System.out.println("Computer picks: " );
          }          
          else if (stone == 0 || currentValue == 0){
           System.out.println("Game Over");
          }
          else
          {
            System.out.println("invalid choice");
          }
                     
        }while(userPick > 3 || userPick < 1);
          
          
      }while (stone > 0);
        
        
        
      if (currentValue > 17){
           currentValue = 17;
        } else if (currentValue > 13){
            currentValue = 13;
        } else if (currentValue > 9) {
            currentValue = 9;
        } else if (currentValue > 5){
            currentValue = 5;
        } else if (currentValue > 1) {
            currentValue = 1;
        } else {
            currentValue = 10000;
        }
  }
}