#include <stdio.h>
#include <stdlib.h>
#include <math.h>

const float PI = 3.14;

typedef struct{
    int id;
    float x;
    float y;
    float Radius;
    float Area;
    float Perimiter;
} circle;

int main()
{
    int Selection;
    int id;
    int FirstId, SecondId;
    float x, y, rad;
    do
    {
        FILE *file;
        file = fopen("circles.txt","r");
        int character=0,lines=0;
        if(file == NULL)
        {
            printf("-----------\nNOTE: You currently don't have any circles in your file, consider adding some.\n-----------\n");
        }
        else
        {
            while(!feof(file))
            {
                character = fgetc(file);
                if(character == '\n')
                {
                    lines++;
                }
            }
        }
        circle Circle[lines];
        fclose(file);
        file = fopen("circles.txt", "r");
        for (int i=0; i<lines; i++)
        {
            fscanf(file, "%d %f %f %f", &Circle[i].id, &Circle[i].x, &Circle[i].y, &Circle[i].Radius);
            Circle[i].Area = PI * Circle[i].Radius * Circle[i].Radius;
            Circle[i].Perimiter = 2 * PI*Circle[i].Radius;
        }
        fclose(file);

        printf("What would you like to do?\n\n");
        printf("Please select of of the options below:\n");
        printf("1) Printing out all the circles in the file.\n");
        printf("2) Adding a new circle to the file.\n");
        printf("3) Sorting circles in the file by descending area.\n");
        printf("4) Finding and printing out the circle in the file  with the area.\n");
        printf("5) Finding and printing the circle in the file with the smallest area.\n");
        printf("6) Choose two circles, in order to check if they intersect.\n");
        printf("7) Enter circle and check which circles cointain it.\n");
        printf("\n0) Exit.\n\n");

        scanf("%d", &Selection);

        switch(Selection)
        {
            case 1:
                if(lines==0)
                {
                    printf("\nIn order to use this operation, you must have circles in your text file. Please add some.\n\n");
                    break;
                }
                else
                {
                    file = fopen("circles.txt", "r");
                    for(int i=0;i<lines;i++)
                    {
                        printf("[%d, (%.2f, %.2f), %.2f],\n",Circle[i].id,Circle[i].x,Circle[i].y,Circle[i].Radius);
                    }
                    fclose(file);
                    break;
                }

            case 2:
                printf("Enter X coordinate for circle.\n");
                scanf("%f", &x);
                printf("Enter Y coordinate for circle.\n");
                scanf("%f", &y);
                printf("Enter radius of the circle.\n");
                scanf("%f", &rad);

                file = fopen("circles.txt", "a");

                if(lines == 0)
                    id = 1;
                else
                {
                    int LastId = Circle[0].id;
                    for(int i=1; i<lines; i++)
                    {
                        if(LastId < Circle[i].id)
                            LastId = Circle[i].id;
                    }
                    id = ++LastId;
                }

                fprintf(file,"%d %.2f %.2f %.2f\n", id, x, y, rad);
                fclose(file);
                break;

            case 3:
                if(lines==0)
                {
                    printf("\nIn order to use this operation, you must have circles in your text file. Please add some.\n\n");
                    break;
                }
                else
                {
                    circle Temp;
                    for(int i=0; i<lines; i++)
                    {
                        for(int j = i+1; j<lines; j++)
                        {
                            if(Circle[i].Area < Circle[j].Area)
                            {
                                Temp = Circle[i];
                                Circle[i] = Circle[j];
                                Circle[j] = Temp;
                            }
                        }
                    }
                    file = fopen("circles.txt", "w");
                    for(int i=0; i<lines; i++)
                        fprintf(file,"%d %.2f %.2f %.2f\n", Circle[i].id, Circle[i].x, Circle[i].y, Circle[i].Radius);
                    fclose(file);
                    break;
                }

            case 4:
                if(lines==0)
                {
                    printf("\nIn order to use this operation, you must have circles in your text file. Please add some.\n\n");
                    break;
                }
                else
                {
                    file = fopen("circles.txt", "r");
                    for(int i=0; i<lines; i++)
                    {
                        printf("[%d, (%.2f, %.2f), %.2f, %.2f],\n", Circle[i].id, Circle[i].x, Circle[i].y, Circle[i].Radius, Circle[i].Area);
                    }
                    fclose(file);
                    break;
                }

            case 5:
                if(lines==0)
                {
                    printf("\nIn order to use this operation, you must have circles in your text file. Please add some.\n\n");
                    break;
                }
                else
                {
                    float SmallerArea = Circle[0].Area;
                    int last;
                    for(int i=0; i<lines; i++)
                    {
                        if(SmallerArea > Circle[i].Area)
                        {
                            SmallerArea = Circle[i].Area;
                            last = i;
                        }
                    }
                    printf("[%d, (%.2f, %.2f), %.2f],\n", Circle[last].id, Circle[last].x, Circle[last].y, Circle[last].Radius);
                    break;
                }

            case 6:
                printf("Enter first circle ID.\n");
                scanf("%d", &FirstId);
                printf("Enter second circle ID.\n");
                scanf("%d", &SecondId);

                int Match1, Match2, k1, k2, Intersect;

                for(int i=0; i<lines; i++)
                {
                    if(FirstId == Circle[i].id)
                    {
                        k1 = i;
                        Match1 = k1;
                        i = lines;
                    }
                    else if(i==lines-1)
                    {
                        printf("No circle with that id.\n");
                        break;
                    }
                }
                for(int i=0; i<lines; i++)
                {
                    if(SecondId == Circle[i].id)
                    {
                        k2 = i;
                        Match2 = k2;
                        i = lines;
                    }
                    else if(i==lines-1)
                    {
                        printf("No circle with that id.\n");
                        break;
                    }
                }
                float d = sqrt(pow((Circle[Match2].x - Circle[Match1].x), 2) + pow((Circle[Match2].y - Circle[Match1].y), 2));
                if(d > (Circle[Match1].Radius + Circle[Match2].Radius))
                    Intersect = 0;
                else if(d < abs(Circle[Match1].Radius - Circle[Match2].Radius))
                    Intersect = 0;
                else
                    Intersect = 1;

                if(Intersect==1)
                {
                    printf("Those two circles intersect.\n");
                    break;
                }
                else
                {
                    printf("Those two circles do not intersect.\n");
                    break;
                }

            case 7:
                printf("Enter X, Y, and Radius of desired circle.\n");
                float qx, qy, qr;
                int exist = 0;
                scanf("%f %f %f", &qx, &qy, &qr);
                for (int i=0; i<lines; i++)
                {
                    float d = sqrt(pow((Circle[i].x - qx), 2) + pow((Circle[i].y - qy), 2));
                    if (Circle[i].Radius>(d+qr))
                    {
                        printf("Circle (%.2f, %.2f,), %.2f is contained in:\n", qx, qy, qr);
                        printf("[%d, (%.2f, %.2f,), %.2f] \n", Circle[i].id, Circle[i].x, Circle[i].y, Circle[i].Radius);
                        exist = 1;
                    }
                }
                if(!exist)
                    printf("There are no circles which contain the one you entered.");
                break;

            case 0: break;

            default:
                printf("\nYou messed something up, try again :)\n\n");
                break;
        }

    } while(Selection !=0);


    return 0;
}