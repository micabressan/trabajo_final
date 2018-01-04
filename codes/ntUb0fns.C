#include <stdio.h>
#include <string.h>
#include <ctype.h>

void reverse (char *s, size_t len);

int main(void) {
    char s[100000],c;
    size_t len, count, i, j, t;

    scanf("%lu", &t);
    while ( (c = getchar()) != '\n' && c != EOF); //flushing stdin

    while (t--) { 

        fgets(s, 100000, stdin);
        len = strlen(s);

        if (len > 0 && (s[--len] == '\n'))
            s[len] = 0;

        reverse(s,len);
        // now reverse the substrings that are seperated by spaces

        j = 0;
        i = 0;
        while (i < len) {
            count = 0;

            for (; !isspace(s[i]) && i < len && s[i] != '\0'; i++, count++);

            if (count > 0) 
                reverse (s+j, count);

            while (isspace(s[i])) 
                i++;

            j=i;
        }

        puts(s);

    }
    return 0;
}

void reverse(char *s, size_t len) {
    char *p, *q, temp;

    for (p = s, q = s+len-1; p <= q; p++, q--) {
        temp = *p;
        *p = *q;
        *q = temp;
    }
}