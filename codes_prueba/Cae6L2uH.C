/**
 * Splits the input from the user at the terminator into different statements.
 * @param in_buf
 * @return
 */
struct statement *split_statements(char *in_buf) {
    char *buf_copy = strdup(in_buf);
    char *save_ptr;
    char *token = strtok_r(buf_copy, ";|&", &save_ptr);
    int delimiter_at = 0;
    struct statement *first;
    struct statement *next = malloc(sizeof(struct statement));
    first = next;
    do {
        read_statements(token, next);
        delimiter_at += strlen(token);
        next->terminator = strlen(in_buf) > delimiter_at ? in_buf[delimiter_at++] : ';';
        token = strtok_r(NULL, ";|&", &save_ptr);
        if (token != NULL) {
            struct statement *cur = next;
            next = malloc(sizeof(struct statement));
            cur->next = next;
        }
    } while (token != NULL);
    return first;
}