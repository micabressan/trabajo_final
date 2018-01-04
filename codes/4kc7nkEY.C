#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>


struct student {
    char *info;
    int age;
};


struct student *student_new_with_age(int age) {
    struct student *s = (struct student*)malloc (1*sizeof (struct student));
    s->info = (char*) malloc(4096 * sizeof(char));
    s->age = age;
    return s;
}


void student_delete(struct student *s) {
    free(s->info);
    free(s);
}


void student_dump(struct student *s) {
    printf("student: valid [%d] info [%s] age %d\n", student_is_valid(s), s->info, s->age);
}


bool student_is_valid(struct student *s) {
    return s->info != NULL && s->age > 18;
}


int main() {
    struct student *s = student_new_with_age(10);
    student_delete(s);

    return 0;
}