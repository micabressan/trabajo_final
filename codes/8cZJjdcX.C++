{$CLEO}
0000:

:Sbiv1
wait 0
0ADC:   test_cheat "1"
jf @Sbiv2
0687: clear_actor $PLAYER_ACTOR task

:Sbiv2
0ADC:   test_cheat "2"
jf @Sbiv3
00A0: store_actor $PLAYER_ACTOR position_to 0@ 1@ 2@
0972: put_actor $PLAYER_ACTOR at 0@ 1@ 2@ no_offset

:Sbiv3
0ADC:   test_cheat "3"
jf @Sbiv4
0812: AS_actor $PLAYER_ACTOR perform_animation "LRGIRL_IDLELOOP" IFP "LOWRIDER" framedelta 4.0 loopA 0 lockX 1 lockY 1 lockF 1 time 1

:Sbiv4
0ADC:   test_cheat "4"
jf @Sbiv1
0792: disembark_instantly_actor $PLAYER_ACTOR
jump @Sbiv1