/* Напишите функцию bitcount со следующим прототипом на Си:

int bitcount(STYPE value);
Где STYPE — это некоторый целый знаковый тип. Кроме того, определен тип
 UTYPE — это некоторый целый беззнаковый тип того же размера, что и STYPE.

Функция возвращает число единичных бит, установленных в значении параметра value.

Используйте битовые операции для обработки параметра функции.

Отрицательные числа представляются в дополнительном коде.

Не используйте sizeof, не используйте константы, зависящие от размера типов. 
Не используйте 64-битные типы в процессе вычислений (если только STYPE не 64-битный).

Не используйте GCC __builtin функции.

Для того, чтобы определить типы STYPE и UTYPE в своей программе для тестирования, 
можно использовать typedef следующим образом:

typedef int STYPE;
typedef unsigned int UTYPE;
Соблюдайте рекомендованный стиль форматирования программ. */

#include <stdio.h>
#include <inttypes.h>
// typedef int STYPE;
// typedef unsigned int UTYPE;

int bitcount(STYPE value) {
    int res = 0;
    int ifmin = 0;
    UTYPE opposite;
    if (value < 0) {
        opposite = ~value;
        ifmin = 1;
    } else {
        opposite = value;
    }
    while (opposite) {
        res += opposite&1;
        opposite >>= 1;
    }
    if (ifmin) {
        return -res + bitcount(~(0U) >> 1) + 1;
    }
    return res;
}

/* int main() {
    int n;
    scanf("%d", &n);
    printf("%d\n", bitcount(n));
} */