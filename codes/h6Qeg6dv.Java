public class Board {
		private int[][] array;
		
		public Board(int[][] board){
			array = board;
		}
		
		public Board Step(int[][] board, int x, int y, int color){
			Board newBoard = new Board(board);
			int[][] tempArray = newBoard.array;
			tempArray[x][y] = color;
		}
	}