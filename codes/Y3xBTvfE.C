#include <fcntl.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define BUFFSIZE 512


void main(){

	int fd;
	ssize_t rres;
	char buf[BUFFSIZE];

	if (fd = open("fifo_x", O_RDONLY) < 0){
		perror("open")
	}

	while(rres = read(fd, buf, BUFFSIZE) > 0) {

		if (write(STDOUT_FILENO, buf, n) != n) { 
			exit(1);
		}
	}
	close(fd);
}