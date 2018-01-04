#include <stdlib.h>
#include <stdio.h>
#include <math.h>

struct dot {
    double x, y;
};

int orA (struct dot a, struct dot b, struct dot c);
int orA (struct dot a, struct dot b, struct dot c){
    double temp = (b.x - a.x) * (c.y - b.y) - (c.x - b.x) * (b.y - a.y);

    if(temp > 0)
        return 1;
    else if (temp < 0)
        return -1;
    else
        return 0;
}

int main (void){
    struct dot *dots, *answer;
    int dotCount, ansSize = -1, i, j, k, isCH, notNull, temp;

    scanf("%d", &dotCount);

    dots = (struct dot*)malloc(dotCount * sizeof(struct dot));
    for(i = 0; i < dotCount; i++)
        scanf("%lf %lf", &dots[i].x, &dots[i].y);

    answer = (struct dot*)malloc(dotCount * sizeof(struct dot));
    for(i = 0; i < dotCount - 1; i++){
        for(j = i + 1; j < dotCount; j++){ // внутри этого цикла i и j это все возможные пары точек т.е. все возможные отрезки
            if(dots[i].x == dots[j].x && dots[i].y == dots[j].y)
                continue;
            isCH = 1;
            notNull = 0;

            for(k = 0; k < dotCount; k++){ // а вот здесь мы проверяем, что все остальные точки по одну сторону от прямой которая проходит через отрезок (возможно лежит на прямой)
                if(k == i || k == j)
                    continue;

                temp = orA(dots[i], dots[j], dots[k]);

                if(!notNull)
                    notNull = temp;
                if(notNull != 0 && notNull != temp){
                    isCH = 0;
                    break;
                }
            }

            if(isCH){ // добавляем ответ
                temp = 1;
                for(k = 0; k < ansSize; k++)
                    if(answer[k].x == dots[i].x && answer[k].y == dots[i].y)
                        temp = 0;
                if(temp)
                    ansSize += 1, answer[ansSize].x = dots[i].x, answer[ansSize].y = dots[i].y;
                temp = 1;
                for(k = 0; k < ansSize; k++)
                    if(answer[k].x == dots[j].x && answer[k].y == dots[j].y)
                        temp = 0;
                if(temp)
                    ansSize += 1, answer[ansSize].x = dots[j].x, answer[ansSize].y = dots[j].y;
            }
        }
    }

    for(k = 0; k < ansSize; k++)
                printf("%lf, %lf\n", answer[k].x, answer[k].y);

    return 0;
}