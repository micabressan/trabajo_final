  neighbors_number = 0
    # |x|-|-|
    # |x|c|-|
    # |x|-|-|

    neighbors_number += 1 if in_bound?(row-1,column) && @board[row-1][column] && @board[row-1][column].alive
    neighbors_number += 1 if in_bound?(row-1,column+1) && @board[row-1][column+1] && @board[row-1][column+1].alive
    neighbors_number += 1 if in_bound?(row-1,column-1) && @board[row-1][column-1] && @board[row-1][column-1].alive
    # |-|x|-|
    # |-|c|-|
    # |-|x|-|

    neighbors_number += 1 if in_bound?(row,column+1) && @board[row][column+1] && @board[row][column+1].alive
    neighbors_number += 1 if in_bound?(row,column-1) && @board[row][column-1] && @board[row][column-1].alive
    # |-|-|x|
    # |-|c|x|
    # |-|-|x|

    neighbors_number += 1 if in_bound?(row+1,column) && @board[row+1][column] && @board[row+1][column].alive
    neighbors_number += 1 if in_bound?(row+1,column+1) && @board[row+1][column+1] && @board[row+1][column+1].alive
    neighbors_number += 1 if in_bound?(row+1,column-1) && @board[row+1][column-1] && @board[row+1][column-1].alive

    neighbors_number