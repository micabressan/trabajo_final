import javax.swing.*;
import java.awt.*;

public class ImageGenerator implements ImageGeneratorConfigurationInterface, ImageGeneratorInterface{

    private int colNum, maxUndoCommands;
    final int UP=1, DOWN=2, RIGHT=3, LEFT=4;
    private boolean grid[][];
    private int currentPos[] = {0, 0}, oldPos[]={0,0};
    private JFrame window;
    History historia;
    JTextArea gridArea;

    public class History{
        public int logRedo[][];
        public int logUndo[][];
        public int logRepeat[][];
        public boolean startingGrid[][];

        public void logGrid(boolean[][] asdf) {
            startingGrid = null;
            startingGrid = asdf;
        }

        public void createLog(){
            logRepeat = new int[maxUndoCommands][4];
            logUndo = new int[maxUndoCommands][4];
            logRedo = new int[maxUndoCommands][4];
        }

        public void add(int position[], int dir, int steps){
            for (int i=maxUndoCommands-2; i>-1; i--){
                for (int j=0; j<4; j++){
                    logRepeat[i+1][j]=logRepeat[i][j];
                }
            }
            logRepeat[0][0]=position[0];
            logRepeat[0][1]=position[1];
            logRepeat[0][2]=dir;
            logRepeat[0][3]=steps;
            logUndo=logRepeat;
        }

        public void removeFromLogUndo(){
            for (int i=0; i<maxUndoCommands-1; i++){
                for (int j=0; j<4; j++){
                    logUndo[i][j]=logUndo[i+1][j];
                }
            }
        }

        public void removeFromLogRedo(){
            for (int i=0; i<maxUndoCommands-1; i++){
                for (int j=0; j<4; j++){
                    logRedo[i][j]=logRedo[i+1][j];
                }
            }
        }

        public void addToLogRedo(int position[], int dir, int steps){
            for (int i=maxUndoCommands-2; i>-1; i--){
                for (int j=0; j<4; j++){
                    logRedo[i+1][j]=logRedo[i][j];
                }
            }
            logRedo[0][0]=position[0];
            logRedo[0][1]=position[1];
            logRedo[0][2]=dir;
            logRedo[0][3]=steps;
        }

        public void print(){
            for (int i=maxUndoCommands-1; i>-1; i--){
                for (int j=0; j<4; j++){
                    System.out.print(logRedo[i][j]);
                }
                System.out.print("\n");
            }
        }
    }

    public void setCanvas(boolean[][] canvas) {
        grid = null;
        grid = canvas;
        historia.logGrid(grid);
        colNum = canvas[1].length;
        drawBoard();
    }

    public void setInitialPosition(int col, int row) {
        currentPos[0] = col;
        currentPos[1] = row;
        grid[currentPos[0]][currentPos[1]] = Boolean.TRUE;
        drawBoard();
    }

    public void maxUndoRedoRepeatCommands(int commands) {
        maxUndoCommands = commands;
        historia.createLog();
    }

    public void up(int steps) {
        historia.add(currentPos, UP, steps);
        historia.print();
        for(int i=currentPos[0]; i<=currentPos[0]+steps; i++){
            grid[i][currentPos[1]] = Boolean.TRUE;
        }
        currentPos[0] = currentPos[0]+steps;
        drawBoard();
    }

    public void down(int steps) {
        historia.add(currentPos, DOWN, steps);
        historia.print();
        for(int i=currentPos[0]; i>=currentPos[0]-steps; i--){
            grid[i][currentPos[1]] = Boolean.TRUE;
        }
        currentPos[0] = currentPos[0]-steps;
        drawBoard();
    }

    public void right(int steps) {
        historia.add(currentPos, RIGHT, steps);
        historia.print();
        for(int i=currentPos[1]; i<=currentPos[1]+steps; i++){
            grid[currentPos[0]][i] = Boolean.TRUE;
        }
        currentPos[1] = currentPos[1]+steps;
        drawBoard();
    }

    public void left(int steps) {
        historia.add(currentPos, LEFT, steps);
        historia.print();
        for(int i=currentPos[1]; i>=currentPos[1]-steps; i--){
            grid[currentPos[0]][i] = Boolean.TRUE;
        }
        currentPos[1] = currentPos[1]-steps;
        drawBoard();
    }

    public void repeat(int commands) {
        for (int i=commands-1; i>-1; i--){
            if (historia.logRepeat[commands-1][2] == UP){
                up(historia.logRepeat[commands-1][3]);
            } else if (historia.logRepeat[commands-1][2] == DOWN){
                down(historia.logRepeat[commands-1][3]);
            } else if (historia.logRepeat[commands-1][2] == RIGHT){
                right(historia.logRepeat[commands-1][3]);
            } else if (historia.logRepeat[commands-1][2] == LEFT){
                left(historia.logRepeat[commands-1][3]);
            }
        }
    }

    public void undo(int commands) {
        for (int n=0; n<commands; n++){
            oldPos[0] = historia.logUndo[n][0];
            oldPos[1] = historia.logUndo[n][1];
            if (historia.logUndo[n][2] == UP){
                for(int i=oldPos[0]+1; i<=currentPos[0] ; i++) {
                    grid[i][currentPos[1]] = Boolean.FALSE;// | startingGrid[i][currentPos[1]];
                }
                historia.addToLogRedo(oldPos, UP, currentPos[0]-oldPos[0]);
                System.out.print("Byl ruch w gore\n");
            }else if (historia.logUndo[n][2] == DOWN){
                for(int i=oldPos[0]-1; i>=currentPos[0] ; i--) {
                    grid[i][currentPos[1]] = Boolean.FALSE;// | startingGrid[i][currentPos[1]];
                }
                historia.addToLogRedo(oldPos, DOWN, oldPos[0]-currentPos[0]);
                System.out.print("Byl ruch w dol\n");
            }else if (historia.logUndo[n][2] == RIGHT){
                for(int i=oldPos[1]+1; i<=currentPos[1] ; i++) {
                    grid[currentPos[0]][i] = Boolean.FALSE;// | historia.startingGrid[currentPos[0]][i]);
                }
                historia.addToLogRedo(oldPos, RIGHT, currentPos[1]-oldPos[1]);
                System.out.print("Byl ruch w prawo\n");
            }else if(historia.logUndo[n][2] == LEFT){
                for(int i=oldPos[1]-1; i>=currentPos[1] ; i--) {
                    grid[currentPos[0]][i] = Boolean.FALSE;// | startingGrid[currentPos[0]][i];
                }
                historia.addToLogRedo(oldPos, LEFT, oldPos[1]-currentPos[1]);
                System.out.print("Byl ruch w lewo\n");
            }
            currentPos[0] = oldPos[0];
            currentPos[1] = oldPos[1];
            historia.removeFromLogUndo();
            drawBoard();
        }
    }

    public void redo(int commands) {
        for (int n=0; n<commands; n++){
            if (historia.logRedo[0][2] == UP){ //byl w gore
                up(historia.logRedo[0][3]);
                System.out.print("Redo up\n");
            }else if (historia.logRedo[0][2] == DOWN){ //byl w dol
                down(historia.logRedo[0][3]);
            }else if (historia.logRedo[0][2] == RIGHT){ //byl w prawo
                right(historia.logRedo[0][3]);
                System.out.print("Redo right\n");
            }else if(historia.logRedo[0][2] == LEFT){ //byl w lewo
                left(historia.logRedo[0][3]);
            }
            historia.removeFromLogRedo();
            drawBoard();
        }
    }

    public void drawBoard(){
        gridArea.setText(null);
        for (int i=colNum-1; i>-1; i--){
            for (int j=0; j<colNum; j++){
                gridArea.setVisible(true);
                if (historia.startingGrid[i][j] == Boolean.TRUE){
                    gridArea.append("1");
                } else {
                    gridArea.append("0");
                }
            }
            gridArea.append("\n");
        }
        System.out.print("Rysuje\n");
    }

    public ImageGenerator(){
        window = new JFrame("Pedzel");
        historia = new History();
        window.getContentPane().setLayout(new FlowLayout(FlowLayout.CENTER));
        window.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        gridArea = new JTextArea();
        window.getContentPane().add(gridArea);
        window.pack();
        window.setSize(600, 600);
        window.setVisible(true);
    }
}