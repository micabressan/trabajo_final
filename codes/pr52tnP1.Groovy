import java.util.Random

p1 = 500
p2 = 500
threads = 1


def giveTasks(int workers, int tasks){
    int[] taskArray = new int[workers+1]
    taskArray[0] = 0
    for (i = 1; i<=Math.min(workers,tasks); i++) {
        taskArray[i]=taskArray[i-1]+tasks/workers+Math.max(tasks%workers-i+1,0)
    }
    
    return taskArray
}

class Matrix{
    public int[][] table
    public Matrix(int p1, int p2){
        table = new int[p1][p2]
    }
    public Matrix(int[][] matrix){
        table = matrix
    }
}

def createMatrix(int lines, int columns){
 int[][] matrix = new int[lines][columns]
 Random rn = new Random()
 for(i=0; i<lines;i++)
    for(j=0;j<columns;j++)
        matrix[i][j]=rn.nextInt(100)
 return matrix
}

Matrix matrix1 = new Matrix(createMatrix(p1,p2))
Matrix matrix2 = new Matrix(createMatrix(p2,p1))
Matrix matrix = new Matrix(p1,p2)


int[] taskArray = giveTasks(threads, p1)

def queue = []
int tn = 0

for (int i = 1; i < threads + 1; i++) {
    int start = taskArray[i-1]
    int stop = taskArray[i]

    def thread = Thread.start {
        for (int job = start; job < stop; job++) { //line for matrix1
            int sum = 0
            for (int j = 0; j < p1; j++) {
                for (int k = 0; k < p1; k++)
                    sum += matrix1.table[job][k] + matrix2.table[k][j]
                matrix.table[job][j] = sum
            }
        }
        tn += 1
        println "Thread " + tn + "finished"
        println "start: " + start +" stop: "+ stop
    }

    queue << thread
}
queue*.join()
matrix.table.each { println it }