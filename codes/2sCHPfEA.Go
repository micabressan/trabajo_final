package main

import (
	"fmt"
	"math/rand"
	"time"
)

type board struct {
	COLS                int   // size of the field: COLS*COLS
	data                []int // 0 -> unoccpuied, 1 -> player one, -1 -> player two
	evaluedCombinations int   // just out of interest, keep track of the number of evaluated end-positions
}

// TODO: use array instead, wtf
type position struct {
	col int
	row int
}

func (b *board) set(player int, p position) {
	col := p.col
	row := p.row
	if player < -1 || player > 1 {
		panic("player must be one or minus one.")
	}
	if col >= b.COLS || col < 0 || row >= b.COLS || row < 0 {
		panic("board index out of range.")
	}
	if player != 0 && b.data[col+row*b.COLS] != 0 {
		panic("field is already occupied.")
	}
	b.data[col+row*b.COLS] = player
}

func (b *board) get(col int, row int) int {
	if col >= b.COLS || col < 0 || row >= b.COLS || row < 0 {
		panic("board index out of range.")
	}
	return b.data[col+row*b.COLS]
}

func (b *board) print() {
	fmt.Println()
	for row := 0; row < b.COLS; row++ {
		for col := 0; col < b.COLS; col++ {
			switch val := b.get(col, row); val {
			case 0:
				fmt.Printf(" _ ")
			case 1:
				fmt.Printf(" X ")
			case -1:
				fmt.Printf(" O ")
			default:
				panic("fields of the board should be -1, 0 or 1")
			}
		}
		fmt.Println()
	}
}

func (b *board) freeFields() []position {
	free := make([]position, 0)
	for row := 0; row < b.COLS; row++ {
		for col := 0; col < b.COLS; col++ {
			if b.get(col, row) == 0 {
				free = append(free, position{col: col, row: row})
			}
		}
	}
	return free
}

func getEnemyPlayer(player int) int {
	return -player
}

func getPlayerString(player int) string {
	if player == 1 {
		return "X"
	} else {
		return "O"
	}
}

func (b *board) rate(player int, depth int) int {
	// just assume it's a 3x3 board for now because I'm lazy
	if b.COLS != 3 {
		panic("non tic-tac-toe not yet implemented.")
	}
	var winner int
	for i := 0; i < 3; i++ {
		if first := b.get(0, i); first != 0 && first == b.get(1, i) && b.get(1, i) == b.get(2, i) { // verticals
			winner = first
			break
		}
		if first := b.get(i, 0); first != 0 && first == b.get(i, 1) && b.get(i, 1) == b.get(i, 2) { // horizontals
			winner = first
			break
		}
	}

	if first := b.get(0, 0); first != 0 && first == b.get(1, 1) && b.get(1, 1) == b.get(2, 2) { // diagonals
		winner = first
	} else if first := b.get(2, 0); first != 0 && b.get(2, 0) == b.get(1, 1) && b.get(1, 1) == b.get(0, 2) {
		winner = first
	}

	switch winner {
	case player:
		return 9 - depth // is at least one since maxDepth should be <= 9
	case getEnemyPlayer(player):
		return -9 + depth // is at most -one since maxDepth should be <= 9
	default:
		return 0
	}
}

/* inds optimal move if the maxDepth is equal to the maximum depth of the game tree (for tic-tac-toe: 9)
* if you want that the function picks a random moves in case of several equally good ones, make
  sure to seed rand
*/
func (b *board) solve(player int, currentDepth int, maxDepth int) (score int, p position) {
	if currentDepth == 0 {
		b.evaluedCombinations = 0
	}

	possibleMoves := b.freeFields()
	if score := b.rate(player, currentDepth); score != 0 || currentDepth == maxDepth || len(possibleMoves) == 0 { // end of recursion
		b.evaluedCombinations++
		return score, position{-1, -1}
	}

	bestScore := -256
	var bestPosIndices []int
	for i := 0; i < len(possibleMoves); i++ {
		b.set(player, possibleMoves[i]) // apply move
		score, _ := b.solve(-player, currentDepth+1, maxDepth)
		score = -score // negamax: biggest loss for opponent is biggest gain for current Player; zero sum game
		if score > bestScore {
			bestScore = score
			bestPosIndices = make([]int, 0)
			bestPosIndices = append(bestPosIndices, i)
		} else if score == bestScore {
			bestPosIndices = append(bestPosIndices, i)
		}
		b.set(0, possibleMoves[i]) // un-apply move
	}

	if n := len(bestPosIndices); n > 1 {
		randIndex := bestPosIndices[rand.Intn(n)]
		return bestScore, possibleMoves[randIndex]
	} else if n == 1 {
		return bestScore, possibleMoves[bestPosIndices[0]]
	} else { // no move found, should not happen but whatever
		return bestScore, position{-1, -1}
	}
}

func userMove(b *board, player int) position {
	var move position
	for {
		move = position{-1, -1}
		for move.col > 2 || move.col < 0 {
			fmt.Printf("\n\nPlayer %s, enter column [0,2]: ", getPlayerString(player))
			fmt.Scan(&move.col)
		}
		for move.row > 2 || move.row < 0 {
			fmt.Printf("Enter row [0,2]: ")
			fmt.Scan(&move.row)
		}
		free := b.freeFields()
		for _, field := range free { // check if valid move
			if field.row == move.row && field.col == move.col {
				goto END // lol
			}
		}
	}
END:
	return move
}

func main() {
	rand.Seed(time.Now().Unix())
	tictac := board{COLS: 3, data: make([]int, 3*3)}

	maxDepth := -1
	opponents := [9]string{"Rob Pike", "an average Reddit poster", "a typical Melanchat User", "your Mom", "a cute black Cat", "a 'muh type theory' Enthusiast",
		"a partially decomposed dead whale", "Master Foo", "Master Pai Mei"}
	for maxDepth < 1 || maxDepth > 9 {
		fmt.Printf("Select player strength [1, 9]; (1 = %s, 9 = %s): ", opponents[0], opponents[8])
		fmt.Scan(&maxDepth)
	}

	player := 0xdead // 1 is the user, -1 the computer
	for player != -1 && player != 1 {
		fmt.Printf("Do you want to start? (1 = yes, -1 = no: ")
		fmt.Scan(&player)
	}

	for i := 0; i < 9; i++ {
		if player == 1 {
			tictac.set(player, userMove(&tictac, player))
		} else {
			_, move := tictac.solve(player, 0, maxDepth)
			fmt.Printf("\n\nAfter carefully considering %d positions, %s was suddenly overcome by a feeling of enlightenment and made a move.",
				tictac.evaluedCombinations,
				opponents[maxDepth-1])
			tictac.set(player, move)
		}
		tictac.print()

		// check if the current move won the game
		if win := tictac.rate(player, 0); win > 0 {
			winner := getPlayerString(player)
			if player == -1 { // if computer player, use shitty names
				winner = opponents[maxDepth-1]
			}
			fmt.Println("Player", winner, "won.")
			break
		}
		player = getEnemyPlayer(player)
	}
}