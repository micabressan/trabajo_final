minigame =
{
	Data={},
	RANKS='<b>%s</b> matou <b>%d</b> ratos.',
	RANKM='<b>%s</b> sobreviveu <b>%d</b> vezes.',
	New=function(player)
		return
		{
			name=player,
			shamank=0,
			surv=0
		}
	end,
	Win=function(p)
		tfm.exec.setPlayerScore(p,5,true)
	end,
	Rank=function(mode)
		local db=minigame.Data
		local tb={}
		local str_rank=""
		if mode=='S' then
			str=minigame.RANKS
			for k,v in pairs(db) do
				tb[#tb+1]=v
			end
			table.sort(tb,function(a,b) return a.shamank>b.shamank end)
			for i=1,math.min(10,#tb) do
				n=tb[i].name
				s=tb[i].shamank
				str_rank=str_rank..(str:format(n,s))..'\n'
			end
		elseif mode=='M' then
			str=minigame.RANKM
			for k,v in pairs(db) do
				tb[#tb+1]=v
			end
			table.sort(tb,function(a,b) return a.surv>b.surv end)
			for i=1,math.min(10,#tb) do
				n=tb[i].name
				s=tb[i].surv
				str_rank=str_rank..(str:format(n,s))..'\n'
			end
		end
		return str_rank
	end,
	Nshaman=function()
		players={}
		for k,v in pairs(tfm.get.room.playerList) do
			players[#players+1]=v
		end
		table.sort(players,function(a,b) return a.score>b.score end)
		shaman=players[1].playerName
		tfm.exec.setShaman(shaman)
		return shaman
	end,
	Start=function(m)
		tfm.exec.newGame(m[math.random(#m)])
	end
}

eventNewPlayer=function(p)
	New=minigame.New(p)
	if not minigame.Data[p] then minigame.Data[p]=New end
	tfm.exec.setPlayerScore(p,0)
end

eventLoop=function(a,b)
	if math.ceil(b/1000)==1 then
		for k,v in pairs(tfm.get.room.playerList) do
			if not v.isDead and v~=minigame.Shaman then
				minigame.Data[k].surv=minigame.Data[k].surv+1
				minigame.Win(k)
			end
		end
		tfm.exec.setPlayerScore(minigame.Shaman,0)
		minigame.Start(minigame.m)
	end
end

eventChatCommand=function(p,c)
	cl=c:lower()
	if cl=="rank" then
		ranks="<p align='Center'><b>Shaman</b></p>\n"
		rankm="<p align='Center'><b>Ratos</b></p>\n"
		ui.addPopup(0,0,ranks..minigame.Rank('S'),p,20,50)
		ui.addPopup(1,0,rankm..minigame.Rank('M'),p,250,50)
	end
end

eventPlayerDied=function(p)
	if minigame.Shaman then
		if p~=minigame.Shaman then
			minigame.Data[minigame.Shaman].shamank=minigame.Data[minigame.Shaman].shamank+1
		end
	end
	if p==minigame.Shaman then
		tfm.exec.setPlayerScore(p,0)
		minigame.Start(minigame.m)
		for k,v in pairs(tfm.get.room.playerList) do
			if not v.isDead then
				minigame.Data[k].surv=minigame.Data[k].surv+1
				minigame.Win(k)
			end
		end
	end
end

eventNewGame=function()
	minigame.Shaman=minigame.Nshaman()
	tfm.exec.giveMeep(minigame.Shaman)
end

minigame.m={276534,279689,280120,280159,281431,281479,281492,281649,289932,289964,290388,290546,290725,290865,290971,290974,291399,291643,292592,292672,292678,293222,293487,295988,296033,299123,300404,302224,304198,304482,305748,305753,306106,306360,306382,307925,307930,311496,333020,390383,390386,390649,390657,391057,391643,391664,391738,392616,392646,393406,395246,397066,459284,464787,478116,479091,481676,489470,489829,490248,492283,495880,500312,521931,540495,573817,697561,741041,787131,793117,797964,799141,802958,802975,803074,811211,848697,852617,866256,908739,937383,958881,1026249,1277941,1388662,1463332,1492805,1514928,1515058,1519483,1522692,1525486,1528388,1533333,1533374,1539148,1543937,1545834,1659906,1661909,1754355,1794873,1794907,1812056,2408376,2526952,2732060,2842113,2939549,2964900,3061252,3067251,3107377,3146721,3175437,3322939,3400319,3419948,3473722,3480467,3540608,3549404,3550350,3579303,3587860,3620709,3699989,4329532,4543602,4705798,4842994,4934730,4978958,5175883,5239078,5498543,5514055,5583170,5651376,5727516,5734549,5915934,5964714}
tfm.exec.disableAutoNewGame(true)
tfm.exec.disableAfkDeath(true)
tfm.exec.disableAutoShaman(true)
tfm.exec.disableAutoScore(true)
tfm.exec.disableAllShamanSkills(true)
minigame.Start(minigame.m)
table.foreach(tfm.get.room.playerList,eventNewPlayer)