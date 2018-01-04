while((interupt%3) == 0) {
                      Lcd_Out(1, 5, "ime");
                      Lcd_Out(2, 1, "index");
              }
              
              Lcd_Cmd(_LCD_CLEAR);
              
              while((interupt%3) == 1) {
                      Lcd_Out(1,1, "ime");

                      Delay_ms(23);
                      Lcd_Out(2,1, "index");

                      Delay_ms(23);
                      Lcd_Cmd(_LCD_CLEAR);
              }
              while((interupt%3)==2){
                     Lcd_Cmd(_LCD_CLEAR);
              }