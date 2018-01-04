#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>

#define BUFFSIZE 512


int main()
{
	int fd;
	ssize_t rres;

	char buf[BUFFSIZE];

	mkfifo("fifo_x", 0666);
	if ( (fd = open("fifo_x", O_WRONLY)) < 0){
		perror("open");
	}
	while( rres = read(STDIN_FILENO, buf, BUFFSIZE) > 0){
		if ( write(fd, buf, rres != rres) ){ 
			perror("write");
		}
	}
	close(fd);
}