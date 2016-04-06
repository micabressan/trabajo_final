#include <math.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "cab202_graphics.h"
#include "cab202_timers.h"
#include "cab202_sprites.h"
 
sprite_id alien[10];
sprite_id player;
timer_id tim;
sprite_id bullet;
int spot;
 
bool shoot = false;

void info() {
        int x = screen_width()/2;
        draw_string(x - 5, screen_height() -1, "Level: 1" );
        draw_string(0, screen_height()-2, "Georgina Hine (n8872597)");
        draw_string(screen_width() - 9, screen_height() - 2, "Lives:");
        draw_string(screen_width()-18, screen_height() - 2, "Score:"); 
        draw_line(0, screen_height() - 3, screen_width(), screen_height() - 3, '-');
 
        show_screen();
}
 
void setup() {
        setup_screen();
        player = create_sprite(screen_width()/2, screen_height() - 5, 1, 1, "S");
        player->dy = 0;
        player->dx = 0;
 
        bullet = create_sprite(-1, -1, 1, 1, "*");
        bullet->dy = 0;
        bullet->dx = 0;
 
for (int i = 0; i < 3; i++) {
                alien[i] = create_sprite(4+4*i, 0, 1, 1, "@");
        }
for (int j = 0; j < 4; j++) {
                alien[j+3] = create_sprite(2+4*j, 3, 1, 1, "@");
        }
for (int k = 0; k < 3; k++) {
                alien[k+7] = create_sprite(4+4*k, 6, 1, 1, "@");
        }      
for (int r = 0; r < 10; r++) {
        alien[r]->dx = 0.1;
        alien[r]->dy = 0;
}
 
 
        tim = create_timer(25);
}
 
void draws() {
        clear_screen();
        draw_sprite(bullet);
        draw_sprite(player);
        for (int i = 0; i < 10; i++) {
                draw_sprite(alien[i]);
        }
        show_screen();
}
 
void check_input() {
        int key = get_char();
        if (key == 'a'){
                player->dx = -1;
               
        }
        else if (key == 'd'){
                player->dx = 1;
               
        }
        else if (key == 's'){
                bullet->y = screen_height() - 5;
                bullet->dy = -1;
                spot = player->x;
                shoot = true;
        }      
        else {
                player->dx = 0;
                player->dy = 0;
 
        }
       
       
 
        while (get_char() != -1) {
 
        }
}
 
void update_state() {
        //Check if we've hit the boundaries
        if (player->x + player->dx < 0 || player->x + player->dx >= screen_width()){
                player->dx = 0;
                player->dy = 0;
        }
       
        //Move player
        player->x += player->dx;
        player->y +=player->dy;
 
        //Reset move vector
        player->dx = 0;
        player->dy = 0;
       
       
 
        if (shot == true) {
                bullet->y += bullet->dy;
                bullet->x = spot;
 
        }
        else {
			bullet->dy = 0;
        }
 
        for (int i = 0; i < 10; i++) {
                if (alien[i]->x + alien[i]->dx > screen_width() - 1) {
                        alien[i]->x = -1;
                }
        }
 
        for (int r = 0; r < 10; r++) {
                alien[r]->x += alien[r]->dx ;
                alien[r]->y += alien[r]->dy;
        }
 
       
}      
 
 
 
 
int main() {
        setup();
       
        draws();
        info();
 
        while (1) {
 
                if (timer_expired(tim)){
                        check_input();
                        update_state();
 
                        draws();
                        info();
                        reset_timer(tim);              
                }
        }
}