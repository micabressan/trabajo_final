alias wbar {
  if ($dialog(wbar)) { dialog -x wbar }
  dialog -m wbar wbar
  Unset %Linez.Wallopz
}

alias DCX_wbar {
}
dialog wbar {
  title ""
  size 2 2 300 50
  option dbu
}
alias NWStart {
  .timer 1 1 xdid -a wbar 1 0 0 +c 6 0 0 0 $color(1) $color(1) $Time(h:nnt) $chr(9) + 0 -1 0 $color(1) °Epimêtheus Script° $chr(9) + 0 -1 0 $color(1) By: morbid $chr(9) + 0 -1 0 $color(1) °Epimêtheus Script°
  .timer 1 2 xdid -a wbar 1 0 0 +c 6 0 0 0 $color(1) $color(1) $Time(h:nnt) $chr(9) + 0 -1 0 $color(1) °Epimêtheus Script° $chr(9) + 0 -1 0 $color(1) By: morbid $chr(9) + 0 -1 0 $color(1) °Coded By: morbid and WraithRIOT°
  .timer 1 2 xdid -a wbar 1 0 0 +c 6 0 0 0 $color(1) $color(1) $Time(h:nnt) $chr(9) + 0 -1 0 $color(1) °Epimêtheus Script° $chr(9) + 0 -1 0 $color(1) By: morbid $chr(9) + 0 -1 0 $color(1) °I have run this script %startup times.°
  .timer 1 2 xdid -a wbar 1 0 0 +c 6 0 0 0 $color(1) $color(1) $Time(h:nnt) $chr(9) + 0 -1 0 $color(1) °Epimêtheus Script° $chr(9) + 0 -1 0 $color(1) By: morbid $chr(9) + 0 -1 0 $color(1) °Loaded in: $+ $calc(($ticks - %start.inic) / 1000) $+ seconds° | unset %start.inic | unset %starts °
  .timer 1 2 xdid -a wbar 1 0 0 +c 6 0 0 0 $color(1) $color(1) $Time(h:nnt) $chr(9) + 0 -1 0 $color(1) °Epimêtheus Script° $chr(9) + 0 -1 0 $color(1) By: morbid $chr(9) + 0 -1 0 $color(1)  $read $mircdir\text\wj.txt
  Set %Linez.Wallopz 5
}
on *:dialog:wbar:init:*: {
  dcx Mark $dname DCX_wbar
  xdialog -q $dname +r cross
  xdialog -c $dname 1 listview 0 0 1880 130 report fullrow grid
  xdid -t $dname 1 +c 0 100 °Event Time° $chr(9) +c 0 100 °Server° $chr(9) +c 0 120 °Type° $chr(9) +l 0 1400 °Message°
  xdid -w $dname 1 +nh 0 icons\cpanel.ico
  xdid -w $dname 1 +nh 0 icons\hdn.ico
  xdid -w $dname 1 +nh 0 icons\site.ico
  xdid -w $dname 1 +nh 0 icons\mode.ico
  xdid -w $dname 1 +nh 0 icons\status.ico
  xdid -w $dname 1 +nh 0 icons\morbid.ico
  xdid -f wbar 1 +a ansi 10 Times New Roman
  .timer 1 0 xdock -m $dialog($dname).hwnd +b
  .timer 1 1 NWStart
}
#SNote On
on *:SNOTICE:*: {
  if ($4 == from) && ($2 !== Global) { .xdid -a wbar 1 0 0 +ck 0 0 0 0 $color(4) $color(1) $time(hh:nn:ss tt) $chr(9) +ck 0 0 $color(4) $color(1) $server $chr(9) +ck 0 0 $color(4) $color(1) $2 $chr(9) +ck 0 0 $color(4) $color(1) $strip($5-) | Inc %Linez.Wallopz | xdid -V wbar 1 %Linez.Wallopz }
  elseif ($4 == from) && ($2 == Global) { .xdid -a wbar 1 0 0 +ck 0 0 0 0 $color(4) $color(1) $time(hh:nn:ss tt) $chr(9) +ck 0 0 $color(4) $color(1) $server $chr(9) +ck 0 0 $color(4) $color(1) GLOBALOPS $chr(9) +ck 0 0 $color(4) $color(1) $strip($5-) | Inc %Linez.Wallopz | xdid -V wbar 1 %Linez.Wallopz }
  elseif ($4 == Client) { .xdid -a wbar 1 0 0 +ck 0 0 0 0 $color(4) $color(1) $time(hh:nn:ss tt) $chr(9) +ck 0 0 $color(4) $color(1) $server $chr(9) +ck 0 0 $color(4) $color(1) $5 $chr(9) +ck 0 0 $color(4) $color(1) $strip($6-) | Inc %Linez.Wallopz | xdid -V wbar 1 %Linez.Wallopz }
  elseif ($8 == forced) && ($12 == nickname) { .xdid -a wbar 1 0 0 +ck 0 0 0 0 $color(4) $color(1) $time(hh:nn:ss tt) $chr(9) +ck 0 0 $color(4) $color(1) $server $chr(9) +ck 0 0 $color(4) $color(1) SVSNICK $chr(9) +ck 0 0 $color(4) $color(1) $strip($4) -> $strip($14) | Inc %Linez.Wallopz | xdid -V wbar 1 %Linez.Wallopz }
  elseif ($7 == changed) && ($8 == his/her) && ($9 == nickname) { .xdid -a wbar 1 0 0 +ck 0 0 0 0 $color(4) $color(1) $time(hh:nn:ss tt) $chr(9) +ck 0 0 $color(4) $color(1) $server $chr(9) +ck 0 0 $color(4) $color(1) NICK $chr(9) +ck 0 0 $color(4) $color(1) $strip($4) -> $strip($11) | Inc %Linez.Wallopz | xdid -V wbar 1 %Linez.Wallopz }
  else { .xdid -a wbar 1 0 0 +ck 0 0 0 0 $color(4) $color(1) $time(hh:nn:ss tt) $chr(9) +ck 0 0 $color(4) $color(1) $server $chr(9) +ck 0 0 $color(4) $color(1) SNOTICE $chr(9) +ck 0 0 $color(4) $color(1) $2- | Inc %Linez.Wallopz | xdid -V wbar 1 %Linez.Wallopz }
}
on *:WALLOPS:*: { .xdid -a wbar 1 0 0 +ck 0 0 0 0 $color(15) $color(12) $time(hh:nn:ss tt) $chr(9) +ck 0 0 $color(15) $color(12) $server $chr(9) +ck 0 0 $color(15) $color(12) WALLOPS $chr(9) +ck 0 0 $color(15) $color(12) $1- | Inc %Linez.Wallopz | xdid -V wbar 1 %Linez.Wallopz }
on *:CONNECT: { .xdid -a wbar 1 0 0 +ck 0 0 0 0 $color(15) $color(1) $time(hh:nn:ss tt) $chr(9) +ck 0 0 $color(15) $color(1) $server $chr(9) +ck 0 0 $color(15) $color(1) Connection $chr(9) +ck 0 0 $color(15) $color(1) Connected | Inc %Linez.Wallopz | xdid -V wbar 1 %Linez.wallopz }
Raw 381:*:{ .xdid -a wbar 1 0 0 +c 5 0 0 0 $color(1) $color(1) $time(hh:nn:ss tt) $chr(9) + 0 -1 0 $color(1) $server $chr(9) + 0 -1 0 $color(1) Admin $chr(9) +c 0 -1 0 $color(1) You are now a server Administrator | Inc %Linez.Wallopz  | xdid -V wbar 1 %Linez.wallopz }
On *:Text:*:*:{
  If ($Nick != That-Bot) {
    If ($Active != $Chan) {
      If ($nick == OperServ) { Halt }
      If ($me Isin $1-) || ($Regex($1-,Will) >= 1) { .xdid -a wbar 1 0 0 +c 2 0 0 0 $color(1) $color(1) $time(hh:nn:ss tt) $chr(9) + 0 -1 0 $color(1) $server $chr(9) + 0 -1 0 $color(1) Nick Caller $chr(9) +c 0 -1 0 $color(1) $Nick said your name on $chan with Message $strip($1-) | Inc %Linez.Wallopz  | xdid -V wbar 1 %Linez.wallopz }
    }
  }
}
on *:DISCONNECT: { .xdid -a wbar 1 0 0 +c 1 0 0 0 $color(1) $color(1) $time(hh:nn:ss tt) $chr(9) + 0 -1 0 $color(1) $server $chr(9) + 0 -1 0 $color(1) Connection Status $chr(9) +c 0 -1 0 $color(1) Disconnected | Inc %Linez.Wallopz  | xdid -V wbar 1 %Linez.Wallopz }
#Snote End