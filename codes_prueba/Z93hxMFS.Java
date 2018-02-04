

import java.util.Scanner;

public class Naloga1 {
    
    public static int index, funRepeat, run;
    public static String tempCommand;
    public static boolean commandCondition;
    
    public static void main(String[] args) 
    { 
        index = 0;
        funRepeat = 0;
        run = -1;
        String tempCommand = "";
        Stack stack[] = new Stack[42];

        for(int i = 0; i < 42; i++)
        {
            stack[i] = new Stack(64);
        }
        Stack stackold = new Stack(64);

        Scanner scanner = new Scanner(System.in);
        while(scanner.hasNextLine())
        {
            String line = scanner.nextLine();
            
            Scanner lineScanner = new Scanner(line);
            while(lineScanner.hasNext())
            {
                String command = (String) scanner.next();
                runCommand(stack, command);
            }
            System.out.println("assad");
        }
        System.exit(0);
    }
    
    public static void runCommand(Stack stack[], String command)
    {
        if(command.toCharArray()[0] == '?')
        {
            if(!stack[0].getAllowed())
            {
                return;
            }
            if(funRepeat == 0)
            {
                command = command.substring(1, command.length());
            }
        }
        if(funRepeat != 0)
        {
            tempCommand = command;
            command = "fun";
        }
        else
        {
            index = 0;
        }
        switch (command) 
        {
            case "echo": 
                stack[index].echo();
                break;
            case "pop": 
                stack[index].pop();
                break;
            case "dup": 
                stack[index].dup();
                break;
            case "dup2": 
                stack[index].dup2();
                break;
            case "swap": 
                stack[index].swap();
                break;
            case "char": 
                stack[index].character();
                break;
            case "even": 
                stack[index].even();
                break;
            case "odd": 
                stack[index].odd();
                break;
            case "!": 
                stack[index].facul();
                break;
            case "len": 
                stack[index].len();
                break;
            case "<>": 
                stack[index].gratherOrSmaller();
                break;
            case "<": 
                stack[index].lessThan();
                break;
            case "==": 
                stack[index].equal();
                break;
            case "<=": 
                stack[index].lessOrEqual();
                break;
            case ">": 
                stack[index].gratherThan();
                break;
            case ">=": 
                stack[index].gratherOrEqual();
                break;
            case "+": 
                stack[index].addition();
                break;
            case "-": 
                stack[index].subtraction();
                break;
            case "*": 
                stack[index].multiplication();
                break;
            case "/": 
                stack[index].division();
                break;
            case "%": 
                stack[index].remainderAtDivision();
                break;
            case ".": 
                stack[index].concate();
                break;
            case "rnd": 
                stack[index].rnd();
                break;
            case "then": 
                stack[index].then();
                break;
            case "else": 
                stack[index].els();
                break;
            case "print": 
                index = Integer.parseInt(stack[0].pop());
                stack[index].print();
                break;
            case "clear": 
                index = Integer.parseInt(stack[0].pop());
                stack[index].clear();
                break;
            case "run": 
                index = Integer.parseInt(stack[0].pop());
                run = stack[index].getTop();
                String commands[] = new String[run+1];
                for(int i = stack[index].getTop(); i >= 0; i--)
                {
                    commands[i] = stack[index].pop();
                }
                for(int i = 0; i < commands.length; i++)
                {
                    stack[index].push(commands[i]);
                }
                for(int i = 0; i < commands.length; i++)
                {
                    runCommand(stack, commands[i]);
                    run--;
                }
                break;
            case "loop": 
                index = Integer.parseInt(stack[0].pop());
                int indexTemp = index;
                int loop = Integer.parseInt(stack[0].pop());
                for(int l = 0; l < loop; l++)
                {
                    run = stack[indexTemp].getTop();
                    String commandsLoop[] = new String[run+1];
                    for(int i = stack[indexTemp].getTop(); i >= 0; i--)
                    {
                        commandsLoop[i] = stack[indexTemp].pop();
                    }
                    for(int i = 0; i < commandsLoop.length; i++)
                    {
                        runCommand(stack, commandsLoop[i]);
                    }
                    for(int i = 0; i < commandsLoop.length; i++)
                    {
                        stack[indexTemp].push(commandsLoop[i]);
                    }
                }
                break;
            case "fun":
                if(funRepeat == 0)
                {
                    index = Integer.parseInt(stack[0].pop());
                    funRepeat = Integer.parseInt(stack[0].pop());
                }
                else
                {
                    stack[index].push(tempCommand);
                    funRepeat--;
                }
                break;
            case "move": 
                index = Integer.parseInt(stack[0].pop());
                int moveRepeat = Integer.parseInt(stack[0].pop());
                for(int i = 0; i < moveRepeat; i++)
                {
                    stack[index].push(stack[0].pop());
                }
                break;
            case "reverse": 
                index = Integer.parseInt(stack[0].pop());
                stack[index].reverse();
                break;
            case "preorder": 
                index = Integer.parseInt(stack[0].pop());
                stack[index].nekaj();
                break;
            case "postorder":                    
                index = Integer.parseInt(stack[0].pop());
                stack[index].nekaj();
                break;
            default:
                stack[index].push(command);
                break;
        }
    }
}

class  Stack
{
    static final int DEFAULT_CAPACITY=64;
    private String[] stackArray;
    private int maxSize;
    private int top;
    boolean allowed;

    public Stack(int s){
        maxSize = s;
        stackArray = new String[maxSize];
        top = -1;
        allowed = true;
    }
    
    public boolean getAllowed()
    {
        return allowed;
    }
    
    public int getTop()
    {
        return top;
    }
    
    public boolean isEmpty()
    {
        return top == -1;
    }

    public void push (String j){
        if(top == DEFAULT_CAPACITY)
        {
            return;
        }
        stackArray[++top] = j;
    }

    public String peek()
    {
        return stackArray[top];
    }
    
    public void echo(){
        if(top != -1)
        {
            System.out.println(peek());
        }
        else
        {
            System.out.println();
        }
    }
    
    public String pop (){
        return stackArray[top--];
    }

    public void dup(){
        push(peek());
    }
    
    public void dup2()
    {
        String topTemp = pop();
        String secondTopTemp = peek();
        push(topTemp);
        push(secondTopTemp);
        push(topTemp);
    }
    
    public void swap(){
        String topTemp = pop();
        String secondTopTemp = pop();
        push(topTemp);
        push(secondTopTemp);
    }

    public void character(){
        int topTemp = Integer.parseInt(pop());
        char charVal = (char) topTemp;
        push(charVal+"");
    }

    

    public void even()
    {
        String topValue = pop();
        int topNumber = Integer.parseInt(topValue);
        int division = topNumber % 2;
        if (division == 0)
        {
            push("1");
        }
        else 
        {
            push("0");
        }
    }

    public void odd()
    {
        String topValue = pop();
        int topNumber = Integer.parseInt(topValue);
        int division = topNumber % 2;
        if (division == 1)
        {
            push("1");
        }
        else 
        {
            push("0");
        }
    }

    public void facul()
    {
        int topNumber = Integer.parseInt(pop());
        int value = 1;
        for(int i = 1; i <= topNumber; i++)
        {
            value *= i;
        }
        push(value + "");
    }

    public void len()
    {
        int length = pop().length();
        push(length + "");
    }

    public void gratherOrSmaller()
    {
        int topNumber = Integer.parseInt(pop());
        int secTopNumber = Integer.parseInt(pop());
        if(topNumber == secTopNumber)
        {
            push("0");
        }
        else
        {
            push("1");
        }
    }

    public void lessThan()
    {
        int topNumber = Integer.parseInt(pop());
        int secTopNumber = Integer.parseInt(pop());
        if(topNumber < secTopNumber)
        {
            push("1");
        }
        else
        {
            push("0");
        }
    }

    public void lessOrEqual()
    {
        int topNumber = Integer.parseInt(pop());
        int secTopNumber = Integer.parseInt(pop());
        if(topNumber <= secTopNumber)
        {
            push("1");
        }
        else
        {
            push("0");
        }
    }

    public void equal()
    {
        int topNumber = Integer.parseInt(pop());
        int secTopNumber = Integer.parseInt(pop());
        if(topNumber == secTopNumber)
        {
            push("1");
        }
        else
        {
            push("0");
        }
    }

    public void gratherThan()
    {
        int topNumber = Integer.parseInt(pop());
        int secTopNumber = Integer.parseInt(pop());
        if(topNumber > secTopNumber)
        {
            push("1");
        }
        else
        {
            push("0");
        }
    }

    public void gratherOrEqual()
    {
        int topNumber = Integer.parseInt(pop());
        int secTopNumber = Integer.parseInt(pop());
        if(topNumber >= secTopNumber)
        {
            push("1");
        }
        else
        {
            push("0");
        }
    }


    public void addition()
    {
        int topNumber = Integer.parseInt(pop());
        int secTopNumber = Integer.parseInt(pop());
        int sum = secTopNumber + topNumber;
        push(sum + "");
    }

    public void subtraction()
    {
        int topNumber = Integer.parseInt(pop());
        int secTopNumber = Integer.parseInt(pop());
        int sum = secTopNumber - topNumber;
        push(sum + "");
    }

    public void multiplication()
    {
        int topNumber = Integer.parseInt(pop());
        int secTopNumber = Integer.parseInt(pop());
        int product = secTopNumber * topNumber;
        push(product + "");
    }

    public void division()
    {
        int topNumber = Integer.parseInt(pop());
        int secTopNumber = Integer.parseInt(pop());
        int quotinent = secTopNumber / topNumber;
        push(quotinent + "");
    }

    public void remainderAtDivision()
    {
        int topNumber = Integer.parseInt(pop());
        int secTopNumber = Integer.parseInt(pop());
        int remainder = secTopNumber % topNumber;
        push(remainder + "");
    }


    public void concate()
    {
        String top = pop();
        String secTop = pop();
        push(top + "" + secTop);
    }

    public void rnd(){
        int max = Integer.parseInt(pop());
        int min = Integer.parseInt(pop());
        int rnd = min + (int)(Math.random() * ((max - min) + 1));
        push(rnd + "");
    }

    public void then(){
        int topElement = Integer.parseInt(pop());
        if (topElement != 0)
        {
            allowed = true;
        }
        else
        {
            allowed = false;
        }
    }
    
    public void els()
    {
        allowed = !allowed;
    }
    
    public void ifCondition()
    {
        
    }
    
    public void print()
    {
        String[] tempStackArray = new String[top+1];
        while(!isEmpty())
        {
            tempStackArray[top] = pop();
        }
        for(String s : tempStackArray)
        {
            System.out.print(s + " ");
            push(s);
        }
        clear();
        System.out.println();
    }
    
    public void clear()
    {
        top = -1;
    }
    
    public void reverse()
    {
        String tempStackArray[] = new String[top+1];
        while(!isEmpty())
        {
            tempStackArray[top] = pop();
        }
        for(int i = tempStackArray.length-1; i >= 0; i--)
        {
            push(tempStackArray[i]);
        }
        
    }
    
    public void nekaj(){}
}