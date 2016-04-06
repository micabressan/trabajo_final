var target = getTargetPlayer();
if(target == -1) return console.log("취했니?"); // 플레이어의 타겟이 -1(없는번호)면
target.Kick("Bye"); //있는번호면 그 플레이어를 강퇴.