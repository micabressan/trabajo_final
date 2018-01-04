import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.Scanner;

/**
 * Created by wojciechmatyja on 03.12.2017.
 */
public class Matrix {

    private int size;

    private int elements[][];

    public Matrix(int size) {
        this.size = size;
        elements = new int[size][size];
        for (int i = 0; i < size; i++) {
            for (int j = 0; j < size; j++) {
                elements[i][j] = Utils.randInt(0, 100);
            }
        }
    }

    public Matrix(int elements[][]) {
        this.elements = elements;
        this.size = elements.length;
    }

    /**
     * Provided file should be trimmed and be in format like:
     * 75 84
     * 55 82
     * @param fileName
     */
    public Matrix(String fileName) throws FileNotFoundException {
        readFromFile(fileName);
    }

    public Matrix add(Matrix anotherMatrix) {
        wrongSizeError(anotherMatrix, "You cannot add matrices with different sizes.");
        int temporaryElements[][] = new int[size][size];
        for (int i = 0; i < size; i++) {
            for (int j = 0; j < size; j++) {
                temporaryElements[i][j] += anotherMatrix.elements[i][j];
            }
        }
        return new Matrix(temporaryElements);
    }


    public Matrix subtract(Matrix anotherMatrix) {
        wrongSizeError(anotherMatrix, "You cannot subtract matrices with different sizes.");
        int temporaryElements[][] = new int[size][size];
        for (int i = 0; i < size; i++) {
            for (int j = 0; j < size; j++) {
                temporaryElements[i][j] -= anotherMatrix.elements[i][j];
            }
        }
        return new Matrix(temporaryElements);
    }

    public Matrix multiply(Matrix anotherMatrix) {
        wrongSizeError(anotherMatrix, "You cannot multiply matrices with different sizes.");
        int temporaryElements[][] = new int[size][size];
        for (int i = 0; i < size; i++) {
            for (int j = 0; j < size; j++) {
                for (int k = 0; k < size; k++) {
                    temporaryElements[i][j] += elements[i][k] * anotherMatrix.elements[k][j];
                }
            }
        }
        return new Matrix(temporaryElements);
    }

    private void wrongSizeError(Matrix anotherMatrix, String s) {
        if (anotherMatrix.size != size) {
            throw new IllegalArgumentException(s);
        }
    }

    private void readFromFile(String fileName) throws FileNotFoundException {
        Scanner input = new Scanner(new File(fileName));
        while(input.hasNextLine()) {
            input.nextLine();
            size++;
        }
        System.out.println(size);
        this.elements = new int[size][size];
        input.close();
        input = new Scanner(new File(fileName));
        for (int i = 0; i < size; i++) {
            for (int j = 0; j < size; j++) {
                if (input.hasNextInt()) {
                    elements[i][j] = input.nextInt();
                }
            }
        }
    }

    public void writeToFile(String fileName) throws IOException {
        PrintWriter writer = new PrintWriter(fileName + ".txt", "UTF-8");
        for (int i = 0; i < size; i++) {
            for (int j = 0; j < size; j++) {
                writer.print(elements[i][j]);
                if (j != size - 1) {
                    writer.print(' ');
                }
            }
            writer.println();
        }
        writer.close();
    }

    public void print() {
        for (int i = 0; i < size; i++) {
            System.out.println(Arrays.toString(this.elements[i]));
        }
        System.out.println();

    }
}