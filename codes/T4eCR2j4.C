/*************************************************************************
 * Copyright (c) 2004 Altera Corporation, San Jose, California, USA.      *
 * All rights reserved. All use of this software and documentation is     *
 * subject to the License Agreement located at the end of this file below.*
 **************************************************************************
 * Description:                                                           *
 * The following is a simple hello world program running MicroC/OS-II.The *
 * purpose of the design is to be a very simple application that just     *
 * demonstrates MicroC/OS-II running on NIOS II.The design doesn't account*
 * for issues such as checking system call return codes. etc.             *
 *                                                                        *
 * Requirements:                                                          *
 *   -Supported Example Hardware Platforms                                *
 *     Standard                                                           *
 *     Full Featured                                                      *
 *     Low Cost                                                           *
 *   -Supported Development Boards                                        *
 *     Nios II Development Board, Stratix II Edition                      *
 *     Nios Development Board, Stratix Professional Edition               *
 *     Nios Development Board, Stratix Edition                            *
 *     Nios Development Board, Cyclone Edition                            *
 *   -System Library Settings                                             *
 *     RTOS Type - MicroC/OS-II                                           *
 *     Periodic System Timer                                              *
 *   -Know Issues                                                         *
 *     If this design is run on the ISS, terminal output will take several*
 *     minutes per iteration.                                             *
 **************************************************************************/
 
#include "includes.h"
#include <stdio.h>
#include "system.h"
#include "io.h"
#include "sys/alt_timestamp.h"
#include "alt_types.h"
#include "definitions.h"
#include <sys/alt_alarm.h>
 
/* Definition of Task Stacks */
#define   TASK_STACKSIZE       2048
OS_STK task1_stk[TASK_STACKSIZE];
OS_STK task2_stk[TASK_STACKSIZE];
OS_STK task3_stk[TASK_STACKSIZE];
OS_STK task4_stk[TASK_STACKSIZE];
OS_STK task5_stk[TASK_STACKSIZE];
 
/* Definition of Task Priorities */
 
#define TASK1_PRIORITY      1
#define TASK2_PRIORITY      2
#define TASK3_PRIORITY      3
#define TASK4_PRIORITY      4
#define TASK5_PRIORITY      5
 
OS_EVENT *SWBox1;
 
alt_alarm alarm;
int alarm_on = 0;
int error_on = 0;
int error_was = 0;
 
void clear_hex(int offset) {
    for (int i = 0; i < 6; ++i) {
        if (i == offset)
            continue;
        IOWR(HEX_BASE, i, SEGA | SEGB | SEGD | SEGE | SEGC | SEGF);
 
    }
}
 
alt_u32 alarm_proc_st0(void* context) {
    clear_hex(0);
    IOWR((int* )context, 0, ONE);
    alarm_on = 0;
    return 0;
}
 
alt_u32 alarm_proc_st1(void* context) {
    clear_hex(1);
    IOWR((int* )context, 1, TWO);
    alarm_on = 0;
    return 0;
}
 
alt_u32 alarm_proc_st2(void* context) {
 
    clear_hex(2);
    IOWR((int* )context, 2, THREE);
    alarm_on = 0;
    return 0;
}
 
alt_u32 alarm_proc_st3(void* context) {
 
    clear_hex(3);
    IOWR((int* )context, 3, FOUR);
    alarm_on = 0;
    return 0;
}
 
alt_u32 alarm_proc_st4(void* context) {
 
    clear_hex(4);
    IOWR((int* )context, 4, FIVE);
    alarm_on = 0;
    return 0;
}
  
struct data {
    volatile int sw;
    volatile int state;
};
 
//int sw = 0; // indicates curr slider
 
/* Prints "Hello World" and sleeps for three seconds */
void task1(void* pdata) {
    struct data data1;
    struct data *datarec;
    INT8U err;
    int T1SEC = alt_ticks_per_second();
    int T2SEC = 2 * alt_ticks_per_second();
    int time;
 
    while (1) {
 
        data1.sw = IORD(SW_SLIDERS_BASE, 0);
        datarec = OSMboxPend(SWBox1, 0, &err);
 
        //printf("%d", err);
        if (err == OS_NO_ERR) {
            data1.state = datarec->state;
        } else {
            data1.state = -1;
        }
 
        if (data1.sw != 0)
            time = alt_nticks(); // czas kiedy ostatni raz wszystkie switche byly
 
        switch (data1.state) {
        case -1:
            //wylaczone switche, ustawienie hex na same zera
            IOWR(LEDS_BASE, 0, 0);
            IOWR(TASK22_0_BASE, 0, data1.state);
 
            if (alt_nticks() - time >= T2SEC) {
                clear_hex(-1);
            }
            //zmiana stanu po T2SEC sekundach od wlaczenia ktoregos ze switchy
            if ((data1.sw == SW0)) {
                data1.state = 0;
 
            } else if ((data1.sw == SW1)) {
                data1.state = 1;
 
            } else if ((data1.sw == SW2)) {
                data1.state = 2;
 
            } else if ((data1.sw == SW3)) {
                data1.state = 3;
 
            } else if ((data1.sw == SW4)) {
                data1.state = 4;
            } else if ((data1.sw != 0 && data1.sw != 1 && data1.sw != 2
                    && data1.sw != 4 && data1.sw != 8 && data1.sw != 16)) {
                data1.state = 5;
                error_on = 1;
            }
            break;
        case 0:
            //temp 10, sw == 1
            IOWR(LEDS_BASE, 0, 1);
//          if (alarm_on != 1) {
//              alt_alarm_stop(&alarm);
//              if (error_was) {
//                  alt_alarm_start(&alarm, T1SEC * 3, alarm_proc_st0,
//                  HEX_BASE);
//                  error_was = 0;
//              } else {
//                  alt_alarm_start(&alarm, T1SEC, alarm_proc_st0, HEX_BASE);
//              }
//              alarm_on = 1;
//          }
            clear_hex(0);
            IOWR(HEX_BASE, 0, ONE);
            //zmiana stanu po T2SEC sekundach od wl/wyl ktoregos ze switchy
            if ((data1.sw == 0)) {
                // wylaczone switche, ustawiamy state=-1
                data1.state = -1;
            } else if ((data1.sw != SW0)) {
                // wlaczone sa wiecej niz 1 switch, ustawiamy state=5
                data1.state = 5;
                error_on = 1;
            }
            break;
 
        }
 
        OSMboxPostOpt(SWBox1, &data1, OS_POST_OPT_BROADCAST);
 
        OSTimeDlyHMSM(0, 0, 0, 10);
    }
}
void task2(void* pdata) {
    struct data data1;
    struct data *datarec;
    INT8U err;
    int T1SEC = alt_ticks_per_second();
    while (1) {
        datarec = OSMboxPend(SWBox1, 0, &err);
//      printf("%d", err);
        if (err == OS_NO_ERR) {
            data1.state = datarec->state;
            data1.sw = datarec->sw;
        } else {
            data1.state = -1;
        }
 
        switch (data1.state) {
        case 1:
            //temp 20, sw == 2
 
            IOWR(LEDS_BASE, 0, 0);
            clear_hex(1);
            IOWR(TASK22_0_BASE, 0, data1.state);
 
//          IOWR(LEDS_BASE, 0, 2);
//          if (alarm_on != 2) {
//              alt_alarm_stop(&alarm);
//              if (error_was) {
//                  alt_alarm_start(&alarm, T1SEC * 3, alarm_proc_st1,
//                  HEX_BASE);
//                  error_was = 0;
//              } else {
//                  alt_alarm_start(&alarm, T1SEC, alarm_proc_st1, HEX_BASE);
//              }
//              alarm_on = 2;
//          }
 
            if ((data1.sw == 0)) {
                // wylaczone switche
                data1.state = -1;
            } else if ((data1.sw != SW1)) {
                //wlaczone sa wiecej niz 1 switch
                data1.state = 5;
                error_on = 1;
            }
            break;
        case 5:
            //error
            IOWR(LEDS_BASE, 0, 0);
            clear_hex(1);
//          IOWR(LEDS_BASE, 0, 32);
//          if (error_on) {
//              OSTimeDlyHMSM(0, 0, 2, 0);
//              error_on = 0;
//          }
//
//          for (int i = 3; i < 6; ++i) {
//              IOWR(HEX_BASE, i,
//                      SEGA | SEGB | SEGD | SEGE | SEGG | SEGC | SEGF);
//          }
//          IOWR(HEX_BASE, 2, E);
//          IOWR(HEX_BASE, 1, R);
//          IOWR(HEX_BASE, 0, R);
 
            IOWR(TASK22_0_BASE, 0, data1.state);
 
            if ((data1.sw == SW0)) {
                error_was = 1;
                data1.state = 0;
            } else if ((data1.sw == SW1)) {
                error_was = 1;
                data1.state = 1;
            } else if ((data1.sw == SW2)) {
                error_was = 1;
                data1.state = 2;
            } else if ((data1.sw == SW3)) {
                error_was = 1;
                data1.state = 3;
            } else if ((data1.sw == SW4)) {
                error_was = 1;
                data1.state = 4;
            } else if ((data1.sw == 0)) {
                error_was = 1;
                data1.state = -1;
            }
            break;
        }
 
        OSMboxPostOpt(SWBox1, &data1, OS_POST_OPT_BROADCAST);
 
        OSTimeDlyHMSM(0, 0, 0, 10);
 
    }
}
void task3(void* pdata) {
    struct data data1;
    struct data *datarec;
    INT8U err;
    int T1SEC = alt_ticks_per_second();
    while (1) {
        datarec = OSMboxPend(SWBox1, 0, &err);
        //      printf("%d", err);
        if (err == OS_NO_ERR) {
            data1.state = datarec->state;
            data1.sw = datarec->sw;
        } else {
            data1.state = -1;
        }
 
        switch (data1.state) {
        case 2:
            //temp 30, sw == 4
            IOWR(LEDS_BASE, 0, 4);
            clear_hex(2);
            IOWR(HEX_BASE, 2, THREE);
            IOWR(TASK22_0_BASE, 0, data1.state);
 
//          if (alarm_on != 3) {
//              alt_alarm_stop(&alarm);
//              if (error_was) {
//                  alt_alarm_start(&alarm, T1SEC * 3, alarm_proc_st2,
//                  HEX_BASE);
//                  error_was = 0;
//              } else {
//                  alt_alarm_start(&alarm, T1SEC, alarm_proc_st2, HEX_BASE);
//              }
//              alarm_on = 3;
//          }
 
            if ((data1.sw == 0)) {
                // wylaczone switche
                data1.state = -1;
            } else if ((data1.sw != SW2)) {
                //wlaczone sa wiecej niz 1 switch
                data1.state = 5;
                error_on = 1;
            }
            break;
        }
        OSMboxPostOpt(SWBox1, &data1, OS_POST_OPT_BROADCAST);
 
        OSTimeDlyHMSM(0, 0, 0, 10);
 
    }
 
}
void task4(void* pdata) {
    struct data data1;
    struct data *datarec;
    INT8U err;
    int T1SEC = alt_ticks_per_second();
    while (1) {
        datarec = OSMboxPend(SWBox1, 0, &err);
        //      printf("%d", err);
        if (err == OS_NO_ERR) {
            data1.state = datarec->state;
            data1.sw = datarec->sw;
        } else {
            data1.state = -1;
        }
 
        switch (data1.state) {
        case 3:
            //temp 40, sw == 8
            IOWR(LEDS_BASE, 0, 8);
            clear_hex(3);
            IOWR(HEX_BASE, 3, FOUR);
            IOWR(TASK22_0_BASE, 0, data1.state);
//          if (alarm_on != 4) {
//              alt_alarm_stop(&alarm);
//              if (error_was) {
//                  alt_alarm_start(&alarm, T1SEC * 3, alarm_proc_st3,
//                  HEX_BASE);
//                  error_was = 0;
//              } else {
//                  alt_alarm_start(&alarm, T1SEC, alarm_proc_st3, HEX_BASE);
//              }
//              alarm_on = 4;
//          }
            if ((data1.sw == 0)) {
                // wylaczone switche
                data1.state = -1;
            } else if ((data1.sw != SW3)) {
                //wlaczone sa wiecej niz 1 switch
                data1.state = 5;
                error_on = 1;
            }
            break;
        }
 
        OSMboxPostOpt(SWBox1, &data1, OS_POST_OPT_BROADCAST);
 
        OSTimeDlyHMSM(0, 0, 0, 10);
 
    }
 
}
/* Prints "Hello World" and sleeps for three seconds */
void task5(void* pdata) {
    struct data data1;
    struct data *datarec;
    INT8U err;
    int T1SEC = alt_ticks_per_second();
    while (1) {
        datarec = OSMboxPend(SWBox1, 0, &err);
        //      printf("%d", err);
        if (err == OS_NO_ERR) {
            data1.state = datarec->state;
            data1.sw = datarec->sw;
        } else {
            data1.state = -1;
        }
 
        switch (data1.state) {
        case 4:
            //temp 50, sw == 16
            IOWR(LEDS_BASE, 0, 16);
            clear_hex(4);
            IOWR(HEX_BASE, 4, FIVE);
            IOWR(TASK22_0_BASE, 0, data1.state);
//          if (alarm_on != 5) {
//              alt_alarm_stop(&alarm);
//              if (error_was) {
//                  alt_alarm_start(&alarm, T1SEC * 3, alarm_proc_st4,
//                  HEX_BASE);
//                  error_was = 0;
//              } else {
//                  alt_alarm_start(&alarm, T1SEC, alarm_proc_st4, HEX_BASE);
//              }
//              alarm_on = 5;
//          }
            if ((data1.sw == 0)) {
                // wylaczone switche
                data1.state = -1;
            } else if ((data1.sw != SW4)) {
                //wlaczone sa wiecej niz 1 switch
                data1.state = 5;
                error_on = 1;
            }
            break;
        }
 
        OSMboxPostOpt(SWBox1, &data1, OS_POST_OPT_BROADCAST);
 
        OSTimeDlyHMSM(0, 0, 0, 10);
 
    }
}
/* The main function creates two task and starts multi-tasking */
int main(void) {
 
    SWBox1 = OSMboxCreate((void*) 0);
 
    OSTaskCreateExt(task1,
    NULL, (void *) &task1_stk[TASK_STACKSIZE - 1],
    TASK1_PRIORITY,
    TASK1_PRIORITY, task1_stk,
    TASK_STACKSIZE,
    NULL, 0);
 
    OSTaskCreateExt(task2,
    NULL, (void *) &task2_stk[TASK_STACKSIZE - 1],
    TASK2_PRIORITY,
    TASK2_PRIORITY, task2_stk,
    TASK_STACKSIZE,
    NULL, 0);
 
    OSTaskCreateExt(task3,
    NULL, (void *) &task3_stk[TASK_STACKSIZE - 1],
    TASK3_PRIORITY,
    TASK3_PRIORITY, task3_stk,
    TASK_STACKSIZE,
    NULL, 0);
 
    OSTaskCreateExt(task4,
    NULL, (void *) &task4_stk[TASK_STACKSIZE - 1],
    TASK4_PRIORITY,
    TASK4_PRIORITY, task4_stk,
    TASK_STACKSIZE,
    NULL, 0);
 
    OSTaskCreateExt(task5,
    NULL, (void *) &task5_stk[TASK_STACKSIZE - 1],
    TASK5_PRIORITY,
    TASK5_PRIORITY, task5_stk,
    TASK_STACKSIZE,
    NULL, 0);
 
    struct data data1;
    data1.state = -1;
    data1.sw = 0;
    OSMboxPostOpt(SWBox1, &data1, OS_POST_OPT_BROADCAST);
 
    // Starte
    OSStart();
    return 0;
}