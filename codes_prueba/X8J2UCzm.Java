import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.Deque;
import java.util.LinkedList;

public class Slang {

    public static Deque<Value> stack= new LinkedList<>();

    public static void main(String[] args) {

        AtomScanner sc = null;

        System.out.println("yolo");

        try {
            sc = new AtomScanner(System.in);
        } catch (LexerException ex) {
            System.out.println(ex);
            return;
        }

        System.out.println("yolo1");


        while (sc.hasNext()) {


            if (sc.hasNextString()) {
                stack.offer(new StringElem(sc.nextString()));
                System.out.println("STRING: " + sc.nextString());
            }
            else if (sc.hasNextInteger()) {
                stack.offer(new IntElem(sc.nextInteger()));
                System.out.println("INTEGER: " + sc.nextInteger());
            }
            else if (sc.hasNextAtom()) {
                handleAtom(sc.nextAtom());
                System.out.println("ATOM: " + sc.nextAtom());
            }
            else {
                System.out.println("UNKNOWN: " + sc.next());
            }
        }
    }

    private static void handleAtom(String atom){

        switch (atom) {
            case ".s":
                System.out.println("-- Top of Stack:");
                while(!stack.isEmpty()){
                    Value temp=stack.poll();

                    System.out.println(temp.toS());
                }
                System.out.println("-- Bottom");
                break;
            case "prin":
                Value temp=stack.poll();

                System.out.print(temp.toS());
                break;
            case "print":
                Value tempp=stack.poll();

                System.out.println(tempp.toS());
                break;
            case "sub":
                Value sub=stack.poll();
                Value min=stack.poll();

                stack.offer(new IntElem(sub.toI()-min.toI()));
                break;
            case "add":
                Value sum1=stack.poll();
                Value sum2=stack.poll();

                stack.offer(new IntElem(sum1.toI()+sum2.toI()));
                break;
            case "mul":
                Value mul1=stack.poll();
                Value mul2=stack.poll();

                stack.offer(new IntElem(mul1.toI()*mul2.toI()));
                break;
            case "div":
                Value zaehler=stack.poll();
                Value nenner=stack.poll();

                stack.offer(new IntElem(zaehler.toI()/nenner.toI()));
                break;
            case "mod":
                Value mod1=stack.poll();
                Value mod2=stack.poll();

                stack.offer(new IntElem(mod1.toI()%mod2.toI()));
                break;
            case "read":

                break;
            case "write":

                break;
            case "ask":

                break;
            case "askn":

                break;
            case "append":
                Value append1=stack.poll();
                Value append2=stack.poll();

                stack.offer(new StringElem(append1.toS()+append2.toS()));
                break;
            case "skip-to":

                break;
            case "skip-n":
                Value skipn1=stack.poll();
                Value skipn2=stack.poll();

                stack.offer(new StringElem(skipn2.toS().substring(skipn2.toI())));
                break;
            case "trunc":
                Value trunc1=stack.poll();
                Value trunc2=stack.poll();

                stack.offer(new StringElem(trunc2.toS().substring(0,trunc2.toI())));
                break;
            case "copy-to":

                break;
            case "dup":
                stack.offer(stack.peek());
                break;
            case "pop":
                stack.poll();
                break;
            default:
                System.out.println("Kein gueltiges Atom");
        }

    }



}

class StringElem implements Value{
    private String string;

    public StringElem(String string){
        this.string=string;
    }

    public String toS(){
        return this.string;
    }

    public int toI(){
        return Integer.parseInt(this.string);
    }
}

class IntElem implements Value{
    private int integer;

    public IntElem(int integer){
        this.integer=integer;
    }

    public String toS(){
        return Integer.toString(this.integer);
    }

    public int toI(){
        return this.integer;
    }
}