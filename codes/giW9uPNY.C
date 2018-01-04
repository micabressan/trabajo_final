int for_more_lines(char **map, int columns, int lines)
{
	int i = 0;
	int j = 0;

	while (i != lines) {
		while (j != columns)
			check_dot(map, &i, &j);
		j = 0;
		i++;
	}
}

int check_dot(char **map, int *i, int *j)
{
	int res = 0;
	int size = 0;

	if (map[(*i)][(*j)] == '.') {
		while (res == 0) {
			res = check_square(map, (*i), (*j), size);
			size++;
		}
		size--;
		res = 0;
		if (size > square_t.sizemax) {
			square_t.sizemax = size - 1;
			square_t.y = (*i);
			square_t.x = (*j);
		}
		size = 0;
	}
	(*j)++;
}

int check_square(char **map, int i, int j, int size)
{
	int y = i;
	int x = j;

	while (y < i + size) {
		while (x < j + size) {
			if (map[y][x] == '.') {
				x++;
			} else if (map[y][x] == 'o') {
				return (1);
			}
		}
		x = j;
		y++;
	}
	return (0);
}

int print_square(char ***map)
{
	int i = 0;
	int x = square_t.x;
	int y = square_t.y;
	int sizemax = square_t.sizemax;

	while (y < sizemax + square_t.y) {
		while (x < sizemax + square_t.x) {
			(*map)[y][x] = 'x';
			x++;
		}
		x = square_t.x;
		y++;
	}
	while ((*map)[i] != NULL) {
		my_printf("%s", (*map)[i]);
		i++;
	}
}