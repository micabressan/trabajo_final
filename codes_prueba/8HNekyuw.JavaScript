var board;

board = '<table class="chess-table">';

for (var i = 9; i >= 0; i--) {
    if (i == 0 || i == 9) {
        board += '<tr><td class="chess-table-td nobr"></td>';
    }
    else {
        board += '<tr><td class="chess-table-td nobr">' + i + '</td>';
    }

    for (var j = 0; j < 8; j++) {
        if (i == 0 || i == 9) {
            board += '<td class="chess-table-td nobr">' + letter(j) + '</td>';
        }
        else {
            if (i == 2 || i == 7) {
                if (i == 2) {
                    board += '<td class="chess-table-td">п</td>';
                }
                else {
                    board += '<td class="chess-table-td">п</td>';
                }
            }
            else {
                if (i == 1 || i == 8) {
                    board += '<td class="chess-table-td">' + figur(j) + '</td>';
                }
                else {
                    board += '<td class="chess-table-td"></td>';
                }
            }
        }
    }


    if (i == 0 || i == 9) {
        board += '<td class="chess-table-td nobr"></td></tr>';
    }
    else {
        board += '<td class="chess-table-td nobr">' + i + '</td></tr>';
    }
    
}

board += '</table>';

document.write(board);

/* Функции */

function letter(num) {
    if (num == 0) {
        return 'A';
    }
    if (num == 1) {
        return 'B';
    }
    if (num == 2) {
        return 'C';
    }
    if (num == 3) {
        return 'D';
    }
    if (num == 4) {
        return 'E';
    }
    if (num == 5) {
        return 'F';
    }
    if (num == 6) {
        return 'G';
    }
    if (num == 7) {
        return 'H';
    }
}

function figur(num) {
    if (num == 0 || num == 7) {
        return 'л';
    }
    if (num == 1 || num == 6) {
        return 'кн';
    }
    if (num == 2 || num == 5) {
        return 'сл';
    }
    if (num == 3) {
        return 'ф';
    }
    if (num == 4) {
        return 'к';
    }
}