/*
podlaczenie u mnie leciało tak:
LCD => port A
RS => pin0
EN => pin1
D4-D7 => pin4-pin7

klawiatura mala => port B piny 0-3

klawiatura mala => trzeba zewrzec piny w zlaczu JP3 i wtedy obslugiwana jest jedna kolumna klawiatury
*/


#define F_CPU 1000000UL
 
#include <avr/io.h>
#include <avr/delay.h>
#include <avr/interrupt.h>
#include <stdint.h>
#include <math.h>
 
// MODES
#define MODE_MENU           0
#define MODE_TIME           1
#define MODE_TIMER          2
#define MODE_COUNTDOWN      3
 
// MENUS
#define MENU_COUNT          3
 
#define MENU_TIME           0
#define MENU_TIMER          1
#define MENU_COUNTDOWN      2
 
// TIMEZONES
#define TIMEZONE_COUNT      3
 
#define TIMEZONE_WARSAW     0
#define TIMEZONE_PARIS      1
#define TIMEZONE_NEWYORK    2
 
// BUTTONS
#define BUTTON_NONE        -1
#define BUTTON_OK           0
#define BUTTON_DOWN         1
#define BUTTON_UP           2
#define BUTTON_MENU         3
 
// KEYBOARD
#define KEYBOARD            PORTB
#define KEYBOARD_PIN        DDRB
 
// LCD
#define LCD_RS              0
#define LCD_EN              1
#define LCD                 PORTA
#define LCD_PIN             DDRA
 
#define LCD_CMD             (uint8_t)0
#define LCD_DATA            (uint8_t)1
 
#define _nop()              asm volatile("nop")
 
// GLOBALS
volatile uint16_t now               = 43200; // 12:00:00
volatile uint16_t timer             = 0;
volatile uint8_t interrupts_count   = 0;
 
volatile uint8_t timer_started      = 0;
volatile uint8_t countdown_started  = 0;
volatile uint8_t has_to_update      = 1;
 
uint8_t current_lcd_line            = 0;
uint8_t current_mode                = 0;
uint8_t current_menu                = 0;
uint8_t current_timezone            = 0;
uint8_t lcd_buffer[32];
 
const uint8_t MENU[][14] = {
    "> CZAS",
    "> STOPER",
    "> CZASOMIERZ"
};
 
const uint8_t TIMEZONE[][10] = {
    "WARSZAWA",
    "PARYZ",
    "NOWY JORK"
};
 
 
void lcd_send(const uint8_t data, const uint8_t type) {
    if (type == 0) {
        LCD &= ~_BV(LCD_RS);    // rejestr
    }
    else if (type == 1) {
        LCD |= _BV(LCD_RS);     // dane
    }
 
    LCD |= _BV(LCD_EN);
    LCD = (LCD & 0x0F) | (data & 0xF0);
    LCD &= ~_BV(LCD_EN);
 
    _nop();
 
    LCD |= _BV(LCD_EN);
    LCD = (LCD & 0x0F) | (data << 4);
    LCD &= ~_BV(LCD_EN);
 
    _delay_ms(2);
}
 
void lcd_clear() {
    lcd_send(0b00000001, LCD_CMD); // clear
    current_lcd_line = 0;
}
 
uint8_t is_pressed(uint8_t key) {
    return bit_is_clear(PINB, key);
}
 
void init_lcd() {
    LCD_PIN = 0xFF;
    LCD = 0;
 
    _delay_ms(20);
 
    lcd_send(0b00000010, LCD_CMD);
    lcd_send(0b00101000, LCD_CMD);
    lcd_send(0b00001100, LCD_CMD);
    lcd_send(0b00000001, LCD_CMD);
 
    _delay_ms(20);
}
 
void init_keyboard() {
    KEYBOARD_PIN = 0x00;
    KEYBOARD = 0x0F;
}
 
void init_time_interrupt() {
    TCCR0 |= (1 << CS02) | (1 << CS00);
    TIMSK |= (1 << TOIE0);
    sei();
}
 
void lcd_new_line() {
    lcd_send(0xC0, LCD_CMD);
    current_lcd_line = 1;
}
 
void lcd_string(const uint8_t* data) {
    uint8_t i = 0;
 
    while (data[i]) {
 
        if (i > 15 && current_lcd_line == 0) {
            lcd_new_line();
        }
 
        lcd_send(data[i], LCD_DATA);
        i++;
    }
}
 
ISR(TIMER0_OVF_vect) {
 
    interrupts_count++;
 
    // 10 interrupts * 100ms = ~1 second
    if (interrupts_count > 10) {
        on_tick();
        interrupts_count = 0;
    }
   
    TCNT0 = 255 - 100; // ~ 100ms
}
 
void on_tick() {
 
    now++;
 
    if (current_mode == MODE_TIMER && timer_started == 1) {
        timer++;
    } else if (current_mode == MODE_COUNTDOWN && countdown_started == 1) {
        timer--;
    }
 
    if (current_mode != MODE_MENU) {
        has_to_update = 1;
    }
}
 
void update_time() {
    uint8_t hours = (uint8_t)floor(now / (3600));
 
    uint8_t divisor_for_minutes = (uint8_t)(now % (3600));
    uint8_t minutes = floor(divisor_for_minutes / 60);
 
    uint8_t divisor_for_seconds = (uint8_t)(divisor_for_minutes % 60);
    uint8_t seconds = (uint8_t)ceil(divisor_for_seconds);
   
    if (current_timezone == TIMEZONE_NEWYORK) {
        hours -= 5;
    }
 
    sprintf(lcd_buffer, "%.2d:%.2d:%.2d", hours, minutes, seconds);
 
    lcd_clear();
    lcd_string(TIMEZONE[current_timezone]);
    lcd_new_line();
    lcd_string(lcd_buffer);
 
    has_to_update = 0;
}
 
void display_menu() {
 
    lcd_clear();
    lcd_string("Wybierz opcje:");
    lcd_new_line();
    lcd_string(MENU[current_menu]);
 
    has_to_update = 0;
}
 
void update_timer() {
 
    sprintf(lcd_buffer, "Stoper: %.2ds", timer);
 
    lcd_clear();
    lcd_string(lcd_buffer);
 
    has_to_update = 0;
}
 
void update_countdown() {
 
    sprintf(lcd_buffer, "Czasomierz: %.2ds", timer);
 
    lcd_clear();
    lcd_string(lcd_buffer);
 
    has_to_update = 0;
}
 
void change_mode() {
    switch (current_menu) {
        case MENU_TIME:
            current_mode = MODE_TIME;
            break;
 
        case MENU_TIMER:
            timer = 0;
            current_mode = MODE_TIMER;
            break;
 
        case MENU_COUNTDOWN:
            timer = 0;
            current_mode = MODE_COUNTDOWN;
            break;
    }
}
 
void go_to_menu() {
    current_mode = MODE_MENU;
    current_menu = MENU_TIME;
    has_to_update = 1;
}
 
void on_update() {
    switch (current_mode) {
        case MODE_MENU:
            display_menu();
            break;
 
        case MODE_TIME:
            update_time();
            break;
 
        case MODE_TIMER:
            update_timer();
            break;
 
        case MODE_COUNTDOWN:
            update_countdown();
            break;
    }
}
 
int8_t check_pressed_key() {
    uint8_t key = 0;
    while (key < 4) {
        if (is_pressed(key)) {
            return key;
        }
    }
    return -1;
}
 
void on_keypress(const int8_t key) {
    switch (key) {
        case BUTTON_OK:
            switch (current_mode) {
                case MODE_MENU:
                    change_mode();
                    break;
                case MODE_TIMER:
                    timer_started = timer_started == 0 ? 1 : 0;
                    break;
                case MODE_COUNTDOWN:
                    countdown_started = countdown_started == 0 ? 1 : 0;
                    break;
            }
            break;
 
        case BUTTON_DOWN:
            switch (current_mode) {
                case MODE_MENU:
                    if (current_menu > MENU_COUNT) {
                        current_menu--;
                    }
                    break;
 
                case MODE_TIME:
                    if (current_timezone > TIMEZONE_COUNT) {
                        current_timezone--;
                    }
                    break;
 
                case MODE_COUNTDOWN:
                case MODE_TIMER:
                    if (timer > 0) {
                        timer--;
                    }
                    break;
            }
            break;
 
        case BUTTON_UP:
            switch (current_mode) {
                case MODE_MENU:
                    if (current_menu < MENU_COUNT) {
                        current_menu++;
                    }
                    break;
 
                case MODE_TIME:
                    if (current_timezone < TIMEZONE_COUNT) {
                        current_timezone++;
                    }
                    break;
 
                case MODE_COUNTDOWN:
                case MODE_TIMER:
                    timer++;
                    break;
            }
            break;
 
        case BUTTON_MENU:
            go_to_menu();
            break;
 
        case BUTTON_NONE:
            // exit without handling.
            return;
    }
 
    // tell to update and wait for key debounce.
    has_to_update = 1;
    _delay_ms(300);
}
 
int main() {
 
    init_lcd();
    init_keyboard();
    init_time_interrupt();
 
    while (1) {
 
        if (has_to_update == 1) {
            on_update();
        }
 
        int8_t key = check_pressed_key();
        on_keypress(key);
 
        _delay_ms(10);
    }
}