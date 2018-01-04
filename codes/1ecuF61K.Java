
public class Main {

    public static boolean canvas[][]= {{Boolean.FALSE, Boolean.FALSE, Boolean.FALSE, Boolean.TRUE, Boolean.FALSE},{Boolean.FALSE, Boolean.FALSE, Boolean.TRUE, Boolean.FALSE, Boolean.FALSE},{Boolean.FALSE, Boolean.FALSE, Boolean.FALSE, Boolean.FALSE, Boolean.FALSE},{Boolean.FALSE, Boolean.FALSE ,Boolean.FALSE, Boolean.FALSE, Boolean.FALSE},{Boolean.FALSE, Boolean.FALSE ,Boolean.FALSE, Boolean.FALSE, Boolean.FALSE}};


    public static void main(String[] args) {
        ImageGenerator interfejs = new ImageGenerator();
        interfejs.setCanvas(canvas);
        interfejs.maxUndoRedoRepeatCommands(5);
        try
        {
            Thread.sleep(500);
            interfejs.setInitialPosition(0,0);
            Thread.sleep(500);
            interfejs.up(1);
            Thread.sleep(1000);
            interfejs.right(4);
            Thread.sleep(1000);
            interfejs.undo(1);
            Thread.sleep(1000);
            interfejs.undo(1);
            Thread.sleep(1000);
            interfejs.redo(2);
            interfejs.redo(2);
        }
        catch(InterruptedException ex)
        {
            Thread.currentThread().interrupt();
        }
    }
}