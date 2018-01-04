#include "windows.h"
#include "stdio.h"
#include "conio.h"
#include "stdint.h"

#define NUMBER_OF_MEANINGS 5
#define NUMBER_OF_THREADS 3000

BYTE asmOfNopFunction[2] =
{
    0x90,
    0xC3
};

int main()
{
    float createThreadTimings[NUMBER_OF_MEANINGS] = {0};
    HANDLE threadHandles[NUMBER_OF_THREADS];
    uint64_t qpf, start, stop;
    QueryPerformanceFrequency((LARGE_INTEGER*)&qpf);

    for(int currentMeaningOfSuspendedThreads = 0; currentMeaningOfSuspendedThreads < NUMBER_OF_MEANINGS; currentMeaningOfSuspendedThreads++)
    {
        QueryPerformanceCounter((LARGE_INTEGER*)&start);
        for(int currentThread = 0; currentThread < NUMBER_OF_THREADS; currentThread++)
        {
            threadHandles[currentThread] = CreateThread(0, 8, &asmOfNopFunction, 0, CREATE_SUSPENDED, 0);
            TerminateThread(threadHandles[currentThread], 0);
        }
        QueryPerformanceCounter((LARGE_INTEGER*)&stop);
        createThreadTimings[currentMeaningOfSuspendedThreads] += stop - start;
    }

    float accum;
    for(int i = 0; i < NUMBER_OF_MEANINGS; i++)
    {
        accum += createThreadTimings[i] /= (float)qpf;
    }
    printf("Average time for %i suspended threads is %.3f sec.\n", NUMBER_OF_THREADS, accum / NUMBER_OF_MEANINGS);

    memset(createThreadTimings, 0, NUMBER_OF_MEANINGS);
    for(int currentMeaningOfWorkingThreads = 0; currentMeaningOfWorkingThreads < NUMBER_OF_MEANINGS; currentMeaningOfWorkingThreads++)
    {
        QueryPerformanceCounter((LARGE_INTEGER*)&start);
        for(int currentThread = 0; currentThread < NUMBER_OF_THREADS; currentThread++)
        {
            threadHandles[currentThread] = CreateThread(0, 0, &asmOfNopFunction, 0, 0, 0);
            TerminateThread(threadHandles[currentThread], 0);
        }
        QueryPerformanceCounter((LARGE_INTEGER*)&stop);
        createThreadTimings[currentMeaningOfWorkingThreads] += stop - start;
    }

    accum = 0;
    for(int i = 0; i < NUMBER_OF_MEANINGS; i++)
    {
        accum += createThreadTimings[i] /= (float)qpf;
    }
    printf("Average time for %i common threads is %.3f sec.\n", NUMBER_OF_THREADS, accum / NUMBER_OF_MEANINGS);

    system("pause");

    return 0;
}