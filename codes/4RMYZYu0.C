//readera ti
#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>

int main()
{
		int fd = open("namedPipe", O_RDONLY);
		char c;	
		while(read(fd, &c, 1))
			write(STDOUT_FILENO, &c, 1);
		write(STDOUT_FILENO, "\n", 1);

	return 0;
}