#include "Global.h"
#include "Button.h"
#include "Popup.h"

// Gombok
Button* play_btn;
Button* options_btn;
Button* level_btn;
Button* exit_btn;

///TODO: move these to states.h
bool* running_ptr;
State* state_ptr;
bool* can_cliclk_ptr;

// Kilepes a jatekbol
void quit(){
    *running_ptr = false;
}

// Valtas az opciok menupontra - meg nincs kesz
void state_options(){
    //*state_ptr = options;
    pp_add("Soon...", 60);
}

// Jatek inditasa
void state_play(){
    *can_cliclk_ptr = false;
    *state_ptr = game;
}

// Palya kezelo menupontra lepes
void state_level(){
    *can_cliclk_ptr = false;
    *state_ptr = loadlvl;
}

// Inicializalas
void init_menu(bool* running, State* state, bool* can_click){
    play_btn = btn_init(720/2, 400/4, btn_width, btn_height, "PLAY", state_play);
    options_btn = btn_init(720/2, 2*400/4, btn_width, btn_height, "OPTIONS", state_options);
    level_btn = btn_init(720/2, 3*400/4, btn_width, btn_height, "LEVEL", state_level);
    exit_btn = btn_init(720/2, 400, btn_width, btn_height, "EXIT", quit);

    running_ptr = running;
    state_ptr = state;
    can_cliclk_ptr = can_click;
}

// Felszabaditas
void cleanup_menu(){
    btn_destroy(play_btn);
    btn_destroy(options_btn);
    btn_destroy(level_btn);
    btn_destroy(exit_btn);
}

// Update - gombokra megnezni a kattintast
void update_menu(SDL_Event event, bool rdy_clck){
    if(event.type == SDL_MOUSEBUTTONDOWN && rdy_clck){
        btn_click(play_btn);
        btn_click(options_btn);
        btn_click(level_btn);
        btn_click(exit_btn);
    }
}

///TODO: navigate with keys
void keys();

// Menu rajzolas - gombok
void draw_menu(SDL_Surface* screen){
    filledCircleRGBA(screen, WIDTH / 2, HEIGHT / 2, 2 * WIDTH, 0, 0, 0, 255);

    btn_show(screen, play_btn);
    btn_show(screen, options_btn);
    btn_show(screen, level_btn);
    btn_show(screen, exit_btn);
}