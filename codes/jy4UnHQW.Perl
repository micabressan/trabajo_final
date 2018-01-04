Wait=3,second
erstEinsatz:
%setzen%=1
Jump=goldSetzen

farbCheck:

Wait=500
CurColor=1119,804^cursorColor

##########################
# Kugel unter dem Becher?#
##########################
<IF=%cursorColor%=2308019>


#	beenden - button drücken
MousePos=1370,881
Wait=10
MouseClickLeft
Wait=5,second
Jump=erstEinsatz
</IF>


#	beenden - button drücken
MousePos=1370,881
Wait=10
MouseClickLeft

Calc={%setzen%*2},setzen


##########################
# 		Gold setzen      #
##########################
goldSetzen:
<LOOP=%setzen%>
	Wait=90
	
	#	erhöhen - Button anklicken
    MousePos=1203,870
	Wait=10
	MouseClickLeft
	

</LOOP>


##########################
# 	   Los druecken      #
##########################

Wait=1,second

#	Los - Button anklicken
MousePos=1374,892
Wait=10
MouseClickLeft


##########################
# 	  Becher klicken     #
##########################

Wait=1,second

#	mittlerer Becher anklicken
MousePos=1119,804
Wait=10
MouseClickLeft


Wait=2,second

Jump=farbCheck