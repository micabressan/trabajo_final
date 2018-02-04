local modelname="DeLoreanTimeMachine"
pcall(function() workspace.Base.CFrame=CFrame.new(0,-2,0) end)
print(modelname.."_LOADED")
local plr=game:service("ii_Sandstorm")["BackFlame"]
local char=plr.Character
local T=char.Torso
local c=function(f) coroutine.resume(coroutine.create(f)) end
local pc=pcall
pc(function() workspace:findFirstChild(modelname):remove() end)
local mouse=nil
local pi=math.pi
local rd=math.rad
local sn=math.sin
local cs=math.cos
local rn=math.random
local ti=table.insert
local tr=table.remove
local inf=math.huge
local cn=CFrame.new
local vc=Vector3.new
local ca=CFrame.Angles
local delorean=Instance.new("Model", workspace) delorean.Name=modelname
local screengui=Instance.new("ScreenGui") screengui.Name=modelname
part=function(par, a, c, s, col, t, cf, ms)
local p=Instance.new("Part", par) pcall(function() p.TopSurface="Smooth" p.BottomSurface="Smooth" p.formFactor="Custom" p.Anchored=a p.CanCollide=c p.Size=s p.BrickColor=BrickColor.new(col) p.Transparency=t p.CFrame=cf or cn()  end)
local m=Instance.new("BlockMesh", p) pcall(function() m.Scale=ms or Vector3.new(1, 1, 1) end)
return p
end
cylinder=function(par, a, c, s, col, t, cf, ms)
local p=Instance.new("Part", par) pcall(function() p.TopSurface="Smooth" p.BottomSurface="Smooth" p.formFactor="Custom" p.Anchored=a p.CanCollide=c p.Size=s p.BrickColor=BrickColor.new(col) p.Transparency=t p.CFrame=cf or cn()  end)
local m=Instance.new("CylinderMesh", p) pcall(function() m.Scale=ms or Vector3.new(1, 1, 1) end)
return p
end
wedge=function(par, a, c, s, col, t, cf, ms)
local p=Instance.new("Part", par) pcall(function() p.TopSurface="Smooth" p.BottomSurface="Smooth" p.formFactor="Custom" p.Anchored=a p.CanCollide=c p.Size=s p.BrickColor=BrickColor.new(col) p.Transparency=t p.CFrame=cf or cn()  end)
local m=Instance.new("SpecialMesh", p) pcall(function() m.Scale=ms or Vector3.new(1, 1, 1) m.MeshType="Wedge" end)
return p
end
gui=function(ins, par, bc, bg, tc, fs, text, t, s, pos)
local g=Instance.new(ins, par)  g.BorderColor=BrickColor.new(bc) g.BackgroundColor=BrickColor.new(bg) g.TextColor=BrickColor.new(tc) g.FontSize=fs g.Font="ArialBold" g.Text=text g.BackgroundTransparency=t g.Size=s g.Position=pos 
return g
end
weld=function(par, p1, cf)
local w=Instance.new("Weld", par) pcall(function() w.Part0=w.Parent or par w.Part1=p1 w.C1=cf or cn() end)
return w
end
mesh=function(ins, par, s, t, id, tid, of)
pcall(function() for i, v in pairs(par:children()) do if v:isA("BlockMesh") or v:isA("CylinderMesh") or v:isA("SpecialMesh") then v:remove() end end end)
local m=Instance.new(ins, par) pcall(function() m.Scale=s or Vector3.new(1, 1, 1) m.Offset=of or Vector3.new() m.MeshId=id or "" m.TextureId=tid or "" m.MeshType=t end)
return m
end
sound=function(parent, id, pitch, volume)
local s=Instance.new("Sound", parent) pcall(function() s.SoundId=id s.Volume=volume or 1 s.Pitch=pitch or 1 end)
return s
end
function stick(from, to)
local stickW=weld(from, to, to.CFrame:inverse()*from.CFrame)
stickW.C0=from.CFrame:inverse()*from.CFrame
return stickW
end
bp=Instance.new("BodyPosition") bp.D=200 bp.maxForce=vc(inf,inf,inf)
base=part(delorean, false, true, vc(5, .5, 14), "Really Really red", 0, cn(0, 200, 0))
wait()
bp.Parent=base
bp.position=(T.CFrame+T.CFrame.lookVector*20).p
base.Name="BASE"
bc=part(delorean, false, true, vc(7, .5, 6), "Really Really red")
bcw=weld(bc, base, cn())
bf=part(delorean, false, true, vc(7, .5, 2), "Really Really red")
bfw=weld(bf, base, cn(0, 0, -7))
local bb=part(delorean, false, true, vc(7, .5, 2), "Really Really red")
local bbw=weld(bb, base, cn(0, 0, 7))
local bf2=part(delorean, false, true, vc(6.8, 1, 1.5), "Really Really red")
local bf2w=weld(bf2, bf, cn(0, .5, 0))
local bc2=part(delorean, false, true, vc(5, 1, 5), "Really Really red")
local bc2w=weld(bc2, base, cn(0, .75, -4.5))
local bf3=part(delorean, false, true, vc(7, .5, 3), "Really Really red")
local bf3w=weld(bf3, bf2, cn(0, .5, -.5))
local enginesmoke=cylinder(delorean, false, true, vc(.5, 2, .5), "Really red")
local enginesmokew=weld(enginesmoke, bb, cn(2, 0, .75)*ca(-rd(90), 0, 0))
local enginesmoke=cylinder(delorean, false, true, vc(.5, 2, .5), "Really red")
local enginesmokew=weld(enginesmoke, bb, cn(-2, 0, .75)*ca(-rd(90), 0, 0))
local bf4=part(delorean, false, true, vc(7, .7, 3.5), "Really red")
local bf4w=weld(bf4, bf3, cn(0, .6, .75))
local bf5=part(delorean, false, true, vc(6, .7, 3), "Really red")
local bf5w=weld(bf5, bf4, cn(0, 0, 3))
local mprt=part(delorean, false, true, vc(7, 1, .5), "Really red", 0, cn(), vc(1, .1, 1))
local mprtw=weld(mprt, bf4, cn(0, -.3, -2))
local mprt=part(delorean, false, true, vc(7, 1, .35), "Really red", 0, cn(), vc(1, .1, 1))
local mprtw=weld(mprt, bf4, cn(0, .3, -1.9))
local mprt=part(delorean, false, true, vc(.2, .65, .5), "Really red", 0, cn(), vc(1, 1, 1))
local mprtw=weld(mprt, bf4, cn(3.4, -.03, -1.9)*ca(rd(15), 0, 0))
local mprt=part(delorean, false, true, vc(.2, .65, .5), "Really red", 0, cn(), vc(1, 1, 1))
local mprtw=weld(mprt, bf4, cn(-3.4, -.03, -1.9)*ca(rd(15), 0, 0))
local dmc=part(delorean, false, true, vc(2, .65, .5), "Really Really red", 0, cn(), vc(1, 1, 1))
local dmcw=weld(dmc, bf4, cn(0, -.03, -1.9)*ca(rd(15), 0, 0))
decal=Instance.new("Decal", dmc)
decal.Texture="http://www.roblox.com/asset/?id=28924870"
decal.Face="Front"
local prt=part(delorean, false, true, vc(.5, 2, 1), "Really Really red")
local prtw=weld(prt, bc, cn(3.25, 1.25, -2.5)*ca(0, 0, 0))
local w=wedge(delorean, false, false, vc(.5, 1, .5), "Really Really red")
local w2=weld(w, prt, cn(0, -.5, .75)*ca(0,pi,0))
local prt=part(delorean, false, true, vc(.5, 2, 1), "Really Really red")
local prtw=weld(prt, bc, cn(3.25, 1.25, -3)*ca(rd(-45), 0, 0))
local prt=part(delorean, false, true, vc(.5, 2, 1), "Really Really red")
local prtw=weld(prt, bc, cn(-3.25, 1.25, -2.5)*ca(0, 0, 0))
local w=wedge(delorean, false, false, vc(.5, 1, .5), "Really Really red")
local w2=weld(w, prt, cn(0, -.5, .75)*ca(0,pi,0))
local prt=part(delorean, false, true, vc(.5, 2, 1), "Really Really red")
local prtw=weld(prt, bc, cn(-3.25, 1.25, -3)*ca(rd(-45), 0, 0))
local prt=part(delorean, false, true, vc(.5, 2, 1), "Really Really red")
local prtw=weld(prt, bc, cn(3.25, 1.25, 2.5)*ca(0, 0, 0))
local prt2=part(delorean, false, true, vc(.5, 2.2, 1.5), "Really Really red")
local prt2w=weld(prt2, prt, cn(-.25, 1.85, .25)*ca(0, 0, rd(10)))
local w=wedge(delorean, false, false, vc(.5, 2, 1), "Really Really red")
local w2=weld(w, prt, cn(0, 0, -1))
local prt=part(delorean, false, true, vc(.5, 2, 1), "Really Really red")
local prtw=weld(prt, bc, cn(3.25, 1.25, 3)*ca(rd(45), 0, 0))
local prt=part(delorean, false, true, vc(.5, 2, 1), "Really Really red")
local prtw=weld(prt, bc, cn(-3.25, 1.25, 2.5)*ca(0, 0, 0))
local prt2=part(delorean, false, true, vc(.5, 2.2, 1.5), "Really Really red")
local prt2w=weld(prt2, prt, cn(.25, 1.85, .25)*ca(0, 0, rd(-10)))
local w=wedge(delorean, false, false, vc(.5, 2, 1), "Really Really red")
local w2=weld(w, prt, cn(0, 0, -1))
local prt=part(delorean, false, true, vc(.5, 2, 1), "Really Really red")
local prtw=weld(prt, bc, cn(-3.25, 1.25, 3)*ca(rd(45), 0, 0))
local main=part(delorean, false, true, vc(6, .5, 1.5), "Really Really red")
local mainw=weld(main, base, cn(0, 4, 2.75))
local stand=part(delorean, false, true, vc(.5, .5, 5.5), "Really Really red")
local standw=weld(stand, base, cn(3,3,5.5)*ca(rd(22),rd(5),0))
local stand=part(delorean, false, true, vc(.5, .5, 5.5), "Really Really red")
local standw=weld(stand, base, cn(-3,3,5.5)*ca(rd(22),rd(-5),0))
local backprt=part(delorean, false, true, vc(6, 2, .5), "Really red")
local backprt=weld(backprt, base, cn(0, 3, 2))
local window=part(delorean, false, true, vc(5, 2.5, .25), "Really red", .5)
local windoww=weld(window, base, cn(0, 3, -1.25)*ca(rd(45), 0, 0))
local border=part(delorean, false, false, vc(5, .5, .5), "Really Really red")
local borderw=weld(border, window, cn(0, 1.5, 0))
local border=part(delorean, false, false, vc(.5, 3, .5), "Really Really red")
local borderw=weld(border, window, cn(2.5, 0, 0)*ca(0, 0, rd(10)))
local border=part(delorean, false, false, vc(.5, 3, .5), "Really Really red")
local borderw=weld(border, window, cn(-2.5, 0, 0)*ca(0, 0, rd(-10)))
local prt=weld()
local mainjoint=part(delorean, false, true, vc(2, .5, 2), "Really Really red")
local mainjointw=weld(mainjoint, base, cn(0, 4, 1))
local seat=part(delorean, false, false, vc(2, .5, 2), "Really red")
local seatw=weld(seat, base, cn(1.5, .25, 1))
local backseat=part(delorean, false, false, vc(2, 2, .5), "Really red")
local backseatw=weld(backseat, seat, cn(0, 1, 1)*ca(rd(10), 0, 0))
local headseat=part(delorean, false, false, vc(1.5, 1.25, .5), "Really red")
local headseatw=weld(headseat, seat, cn(0, 2.5, 1.15))
local seat=part(delorean, false, false, vc(2, .5, 2), "Really red")
local seatw=weld(seat, base, cn(-1.5, .25, 1))
local backseat=part(delorean, false, false, vc(2, 2, .5), "Really red")
local backseatw=weld(backseat, seat, cn(0, 1, 1)*ca(rd(10), 0, 0))
local headseat=part(delorean, false, false, vc(1.5, 1.25, .5), "Really red")
local headseatw=weld(headseat, seat, cn(0, 2.5, 1.15))
local line=part(delorean, false, false, vc(1, 1, 14), "Really red")
local linew=weld(line, base, cn(0, .5, 0))
local back=part(delorean, false, true, vc(5, 1.5, 6), "Really Really red")
local backw=weld(back, base, cn(0, 1, 5))
local bb33s=part(delorean, false, true, vc(7, 1.5, 2), "Really Really red")
local bb33sw=weld(bb33s, base, cn(0, 1, 7))
local bbs=part(delorean, false, true, vc(7, .5, 1), "Really Really red")
local bbsw=weld(bbs, base, cn(0, .25, 8.25)*ca(-rd(35), 0, 0))
local bbs=part(delorean, false, true, vc(7, 1.5, .5), "Really Really red")
local bbsw=weld(bbs, base, cn(0, 1, 8.25))
local bb3s=part(delorean, false, true, vc(7, .5, .5), "Really red")
local bb3sw=weld(bb3s, bb33s, cn(0, 1, 1.25))
local bb3s=part(delorean, false, true, vc(7, .5, 6), "Really Really red")
local bb3sw=weld(bb3s, bb33s, cn(0, 1, -2))
decal=Instance.new("Decal", bb3s)
decal.Texture="http://www.roblox.com/asset/?id=27893351"
decal.Face="Top"
rocket=wedge(delorean, false, true, vc(2,2,4), "Really red")
rocketw=weld(rocket, bb3s, cn(2,1,1.5))
r2=wedge(delorean, false, true, vc(2,1,2), "Really Really red")
r2w=weld(r2,rocket,cn(0,0,2.5)*ca(pi/2,pi,0))
rocket=wedge(delorean, false, true, vc(2,2,4), "Really red")
rocketw=weld(rocket, bb3s, cn(-2,1,1.5))
r2=wedge(delorean, false, true, vc(2,1,2), "Really Really red")
r2w=weld(r2,rocket,cn(0,0,2.5)*ca(pi/2,pi,0))
pp=part(delorean, false, true, vc(2,1,5), "Really red")
ppw=weld(pp,bb3s,cn(0,.5,0))
reactor=part(delorean, false, true, vc(2,1.5,2), "Really red")
reactorw=weld(reactor,pp,cn(0,-.25,1.5))
reactorm=mesh("SpecialMesh", reactor, vc(.4,.1,.4), "FileMesh", "http://www.roblox.com/Asset/?id=10207677")
cyl=cylinder(delorean,false,true,vc(.8,1.5,.8),"White")
cylw=weld(cyl,reactor,cn(0,1.5,0))
decal=Instance.new("Decal", cyl)
decal.Texture="http://www.roblox.com/asset/?id=37389443"
decal.Face="Front"
decal=Instance.new("Decal", cyl)
decal.Texture="http://www.roblox.com/asset/?id=37389443"
decal.Face="Back"
decal=Instance.new("Decal", cyl)
decal.Texture="http://www.roblox.com/asset/?id=37389443"
decal.Face="Right"
decal=Instance.new("Decal", cyl)
decal.Texture="http://www.roblox.com/asset/?id=37389319"
decal.Face="Left"
cyl2=cylinder(delorean,false,true,vc(.5,.5,.5),"Really Really red")
cyl2w=weld(cyl2,cyl,cn(0,.75,0))
but=part(delorean,false,true,vc(.4,.3,1),"Bright red")
butw=weld(but,cyl,cn(0,-.5,.5))
local wed=wedge(delorean, false, true, vc(7, .5, 3), "Really Really red")
local wedw=weld(wed, bf2, cn(0, 0, -.5)*ca(0, 0, pi))
local trunk=wedge(delorean, false, true, vc(7, .5, 6.35), "Really Really red")
local trunkw=weld(trunk, bf4, cn(0, .6, 1.5))
--TIRE
local prts=6
local rad=1.6
local tfr=cylinder(delorean, false, true, vc(2.5, 1, 2.5), "Really red")
local tfrw=weld(tfr, base, cn(3,.25,-4.5)*ca(0,0,pi/2))
local met=cylinder(delorean, false, true, vc(1.5, 1.1, 1.5), "Really Really red")
local metw=weld(met, tfr, cn())
for i=0,pi,pi/prts do
local p=part(delorean, false, false, vc(1.1,1.1,.5), "Really Really red")
p.CFrame=tfr.CFrame*cn(rad*sn(i), 0, rad*cs(i))
p.CFrame=CFrame.new(p.CFrame.p, tfr.CFrame.p)
stick(p, base)
end
local tfl=cylinder(delorean, false, true, vc(2.5, 1, 2.5), "Really red")
local tflw=weld(tfl, base, cn(-3,.25,-4.5)*ca(0,0,pi/2))
local met=cylinder(delorean, false, true, vc(1.5, 1.1, 1.5), "Really Really red")
local metw=weld(met, tfl, cn())
for i=0,pi,pi/prts do
local p=part(delorean, false, false, vc(1.1,1.1,.5), "Really Really red")
p.CFrame=tfl.CFrame*cn(rad*sn(i), 0, rad*cs(i))
p.CFrame=CFrame.new(p.CFrame.p, tfl.CFrame.p)
stick(p, base)
end
local tbr=cylinder(delorean, false, true, vc(2.5, 1, 2.5), "Really red")
local tbrw=weld(tbr, base, cn(3,.25,4.5)*ca(0,0,pi/2))
local met=cylinder(delorean, false, true, vc(1.5, 1.1, 1.5), "Really Really red")
local metw=weld(met, tbr, cn())
for i=0,pi,pi/prts do
local p=part(delorean, false, false, vc(1.1,1.1,.5), "Really Really red")
p.CFrame=tbr.CFrame*cn(rad*sn(i), 0, rad*cs(i))
p.CFrame=CFrame.new(p.CFrame.p, tbr.CFrame.p)
stick(p, base)
end
local tbl=cylinder(delorean, false, true, vc(2.5, 1, 2.5), "Really red")
local tblw=weld(tbl, base, cn(-3,.25,4.5)*ca(0,0,pi/2))
local met=cylinder(delorean, false, true, vc(1.5, 1.1, 1.5), "Really Really red")
local metw=weld(met, tbl, cn())
for i=0,pi,pi/prts do
local p=part(delorean, false, false, vc(1.1,1.1,.5), "Really Really red")
p.CFrame=tbl.CFrame*cn(rad*sn(i), 0, rad*cs(i))
p.CFrame=CFrame.new(p.CFrame.p, tbl.CFrame.p)
stick(p, base)
end
atfr=function(cf)
tfrw.C1=cn(3,.25,-4.5)*ca(0,0,pi/2)*cf
end
atfl=function(cf)
tflw.C1=cn(-3,.25,-4.5)*ca(0,0,pi/2)*cf
end
atbr=function(cf)
tblw.C1=cn(3,.25,4.5)*ca(0,0,pi/2)*cf
end
atbl=function(cf)
tblw.C1=cn(-3,.25,4.5)*ca(0,0,pi/2)*cf
end
local trunkw=weld(trunk, bf4, cn(0, .6, 1.25))
--SEATS
--DOOR
local DoorRight=Instance.new("Model", delorean)
local djr=part(DoorRight, false, false, vc(1, 1, 1), "Really Really red", 1)
local djrw=weld(djr, mainjoint, cn(1,0,0)*ca(0,0,0))
local dp=part(DoorRight, false, true, vc(2, .5, 2), "Really Really red")
local dpw=weld(dp, djr, cn(1, 0, 0))
local dp2=part(DoorRight, false, true, vc(.5, .5, 3.25), "Really Really red")
local dp2w=weld(dp2, dp, cn(1, -1, -2)*ca(rd(-45),rd(-10),0))
local dp3=part(DoorRight, false, true, vc(.5, 2.2, .5), "Really Really red")
local dp3w=weld(dp3, dp, cn(1, -.85, .75)*ca(0, 0, rd(15)))
local dw=wedge(DoorRight, false, true, vc(.5, 2, 1), "Really Really red")
local dww=weld(dw, dp, cn(1.25, -2.75, .5)*ca(pi,0,0))
local dw=wedge(DoorRight, false, true, vc(.5,1,.5), "Really Really red")
local dww=weld(dw, dp, cn(1.25, -3.25, -2.75)*ca(pi, pi, 0))
local dp4=part(DoorRight, false, true, vc(.5,1,.5), "Really Really red")
local dp4w=weld(dp4, dp, cn(1.25, -2.25, -2.75))
local dp5=part(DoorRight, false, true, vc(.5,2,2.5), "Really Really red")
local dp5w=weld(dp5, dp, cn(1.25, -2.75, -1.25))
local dwindow=wedge(DoorRight, false, true, vc(.25, 2, 2), "Really Really red", .5)
local dwindoww=weld(dwindow, dp, cn(1, -1, -1.75)*ca(0, 0, rd(15)))
local dwindow=part(DoorRight, false, true, vc(.25, 2, 1.5), "Really Really red", .5)
local dwindoww=weld(dwindow, dp, cn(1, -1, 0)*ca(0, 0, rd(15)))
local glass=part(DoorRight, false, true, vc(1, .5, .2), "Really Really red")
local glassw=weld(glass, dp, cn(1.5, -1.5, -2)*ca(0, rd(-35), 0))
local actr=false
local debr=false
function clickr()
if actr==false then
if debr==false then
debr=true
for i=0, 1, .1 do
djrw.C1=cn(1,0,0)*ca(0,0,rd(90)*i)
wait()
end
debr=false
actr=true
end
elseif actr==true then
if debr==false then
debr=true
for i=1, 0, -.1 do
djrw.C1=cn(1,0,0)*ca(0,0,rd(90)*i)
wait()
end
debr=false
actr=false
end
end
end
for i, v in pairs(DoorRight:children()) do
local cdetector=Instance.new("ClickDetector", v)
cdetector.MouseClick:connect(clickr)
end
local DoorLeft=Instance.new("Model", delorean)
local djl=part(DoorLeft, false, false, vc(1, 1, 1), "Really Really red", 1)
local djlw=weld(djl, mainjoint, cn(-1,0,0))
local dp=part(DoorLeft, false, true, vc(2, .5, 2), "Really Really red")
local dpw=weld(dp, djl, cn(-1, 0, 0))
local dp2=part(DoorLeft, false, true, vc(.5, .5, 3.25), "Really Really red")
local dp2w=weld(dp2, dp, cn(-1, -1, -2)*ca(rd(-45),rd(10),0))
local dp3=part(DoorLeft, false, true, vc(.5, 2.2, .5), "Really Really red")
local dp3w=weld(dp3, dp, cn(-1, -.85, .75)*ca(0, 0, rd(-15)))
local dw=wedge(DoorLeft, false, true, vc(.5, 2, 1), "Really Really red")
local dww=weld(dw, dp, cn(-1.25, -2.75, .5)*ca(pi,0,0))
local dw=wedge(DoorLeft, false, true, vc(.5,1,.5), "Really Really red")
local dww=weld(dw, dp, cn(-1.25, -3.25, -2.75)*ca(pi, pi, 0))
local dp4=part(DoorLeft, false, true, vc(.5,1,.5), "Really Really red")
local dp4w=weld(dp4, dp, cn(-1.25, -2.25, -2.75))
local dp5=part(DoorLeft, false, true, vc(.5,2,2.5), "Really Really red")
local dp5w=weld(dp5, dp, cn(-1.25, -2.75, -1.25))
local dwindow=wedge(DoorLeft, false, true, vc(.25, 2, 2), "Really Really red", .5)
local dwindoww=weld(dwindow, dp, cn(-1, -1, -1.75)*ca(0, 0, rd(-15)))
local dwindow=part(DoorLeft, false, true, vc(.25, 2, 1.5), "Really Really red", .5)
local dwindoww=weld(dwindow, dp, cn(-1, -1, 0)*ca(0, 0, rd(-15)))
local glass=part(DoorLeft, false, true, vc(1, .5, .2), "Really Really red")
local glassw=weld(glass, dp, cn(-1.5, -1.5, -2)*ca(0, rd(35), 0))
local actl=false
local debl=false
function clickl()
if actl==false then
if debl==false then
debl=true
for i=0, 1, .1 do
djlw.C1=cn(-1,0,0)*ca(0,0,rd(-90)*i)
wait()
end
debl=false
actl=true
end
elseif actl==true then
if debl==false then
debl=true
for i=1, 0, -.1 do
djlw.C1=cn(-1,0,0)*ca(0,0,rd(-90)*i)
wait()
end
debl=false
actl=false
end
end
end
for i, v in pairs(DoorLeft:children()) do
local cdetector=Instance.new("ClickDetector", v)
cdetector.MouseClick:connect(clickl)
end
local bf=Instance.new("BodyForce")
local bav=Instance.new("BodyAngularVelocity") bav.angularvelocity=vc(0,0,0) bav.maxTorque=vc(math.huge,math.huge,math.huge)
local vs=Instance.new("VehicleSeat", delorean)
vs.HeadsUpDisplay=false
vs.CanCollide=false
vs.Transparency=1
vs.Size=Vector3.new(2, .5, 2)
weld(vs, base, cn(-1.5, 0, 1))
local ps=Instance.new("VehicleSeat", delorean)
ps.HeadsUpDisplay=false
ps.CanCollide=false
ps.Size=Vector3.new(2, .5, 2)
ps.Transparency=1
weld(ps, base, cn(1.5, 0, 1))
torsos={}
ps.ChildAdded:connect(function(w)
if w.Name=="SeatWeld" then
torso=w.Part1
if torso then
        for i, v2 in pairs(torso.Parent:children()) do
                if v2:isA("BasePart") then
                        for i, v3 in pairs(v2:children()) do
                                if v3:isA("CFrameValue") then
                                        v3:remove() 
                                end
                        end
                end
        end
end
table.insert(torsos, torso)
w.C1=w.C1*CFrame.new(0, 0, .5)
end
end)
running=false
vs.ChildAdded:connect(function(w)
if w.Name=="SeatWeld" then
torso=w.Part1
w.C1=w.C1*CFrame.new(0, 0, .5)
if torso then
        for i, v2 in pairs(torso.Parent:children()) do
                if v2:isA("BasePart") then
                        for i, v3 in pairs(v2:children()) do
                                if v3:isA("CFrameValue") then
                                        v3:remove() 
                                end
                        end
                end
        end
table.insert(torsos, torso)
local player=game.Players:getPlayerFromCharacter(torso.Parent)
screengui=Instance.new("ScreenGui", player.PlayerGui) screengui.Name=modelname
speedometer=gui("TextLabel", screengui, "Really red", "Really red", "Really Really red", "Size48", "0", 1, UDim2.new(0, 100, 0, 100), UDim2.new(0, 50, .85, 0))
hourlabel=gui("TextLabel", screengui, "Really red", "Really red", "Really Really red", "Size48", "HH", 1, UDim2.new(0, 100, 0, 50), UDim2.new(.7, 0, .8, 0))
minutelabel=gui("TextLabel", hourlabel, "Really red", "Really red", "Really Really red", "Size48", "MM", 1, UDim2.new(1, 0, 1, 0), UDim2.new(1, 0, 0, 0))
secondlabel=gui("TextLabel", minutelabel, "Really red", "Really red", "Really Really red", "Size48", "SS", 1, UDim2.new(1, 0, 1, 0), UDim2.new(1, 0, 0, 0))
hourbox=gui("TextBox", hourlabel, "Really red", "Really red", "Really red", "Size48", "24", 1, UDim2.new(1, 0, 1, 0), UDim2.new(0, 0, 1, 0))
minutebox=gui("TextBox", minutelabel, "Really red", "Really red", "Really red", "Size48", "00", 1, UDim2.new(1, 0, 1, 0), UDim2.new(0, 0, 1, 0))
secondbox=gui("TextBox", secondlabel, "Really red", "Really red", "Really red", "Size48", "00", 1, UDim2.new(1, 0, 1, 0), UDim2.new(0, 0, 1, 0))
running=true
run()
end
end
end)
vs.ChildRemoved:connect(function(w)
if w.Name=="SeatWeld" then
torso=w.Part1
if torso then
for i, v in pairs(torsos) do
        if v==torso then
                table.remove(torsos,i)
        end
end
local player=game.Players:getPlayerFromCharacter(torso.Parent)
player.PlayerGui[modelname]:remove()
running=false
end
end
end)
ps.ChildRemoved:connect(function(w)
if w.Name=="SeatWeld" then
torso=w.Part1
if torso then
for i, v in pairs(torsos) do
        if v==torso then
                table.remove(torsos,i)
        end
end
end
end
end)
c(function()wait(.5) bp:remove()end)
function makelightning(from, to, thick, col)
local magnitude=(from.p-to.p).magnitude
local distance=(from.p+to.p)/2
local pattern=part(workspace, true, false, vc(.2, .2, magnitude), "White", 1, cn(distance, from.p))
local fromPosProx=from.p
for i=1, 4 do
local fromPosProx2=fromPosProx
local random=vc(rn(-1, 1), rn(-1, 1), rn(-1, 1))
local findSize=pattern.Size.z/3
local findOffSet=pattern.CFrame.lookVector*-1
local compute=i*findSize*findOffSet
local newfromPos=from.p
local newEndPos=cn(random+compute+newfromPos).p
local magnitude=(fromPosProx2-newEndPos).magnitude
local distance=(fromPosProx2+newEndPos)/2
local lightning=part(workspace, true, false, vc(1, 1, 1), col or "Bright yellow", 0, cn(distance, fromPosProx2), vc(thick, thick, magnitude))
fromPosProx=newEndPos
game.Debris:addItem(lightning, .5)
end 
pattern:remove()
end
function play(soundid, pitch, volume)
local sound=sound(workspace, soundid, pitch, volume)
sound:play()
c(function() wait(5) sound:remove() end)
end
trm=Instance.new("Model", delorean)
function trail(prt, cf, thick, col)
local old=(prt.CFrame*(cf or cn())).p
local trail=part(trm, true, false, vc(1, 1, 1), col or "White", 0, cn(old)*ca(rn(-360, 360),rn(-360, 360),rn(-360, 360)), vc(thick, thick, thick))
c(function()
for i=1, 0, -.001 do pc(function() trail.Mesh.Scale=trail.Mesh.Scale*vc(i, i, i) end) wait() end
trail:remove()
end)
end
Targets={}
timedeb=false
num=0
maxnum=400
origin=0
function stick(from, to)
local stickW=weld(from, to, to.CFrame:inverse()*from.CFrame)
stickW.C0=from.CFrame:inverse()*from.CFrame
return stickW
end
local bp=Instance.new("BodyPosition") bp.D=100 bp.maxForce=vc(inf,inf,inf)
timedeb=false
function run()
num=0
c(function()
for i, v in pairs(workspace:children()) do
        if v:isA("Model") then
                for i, v2 in pairs(v:children()) do
                        if v2:isA("BasePart") then
                                for i, v3 in pairs(v2:children()) do
                                        if v3:isA("CFrameValue") then
                                                v3:remove() 
                                        end
                                end
                        end
                end
        end
end
timedeb=true
while true do
--TimeContinium-----------------------------
if num<=0 and timedeb==true then
        for i, v in pairs(workspace:children()) do
                if v:isA("BasePart") then
                        if v.Anchored==false then
                                table.insert(Targets, v)
                                local Origin = Instance.new("CFrameValue")
                                Origin.Parent = v
                                Origin.Name = "Origin CFrame"
                                Origin.Value = v.CFrame
                        end
                end
                for i, t in pairs(torsos) do
                        if v:isA("Model") and v~=t.Parent and v~=delorean then
                                for i, v2 in pairs(v:children()) do
                                        if v2:isA("BasePart") then
                                                table.insert(Targets, v2)
                                                local Origin = Instance.new("CFrameValue")
                                                Origin.Parent = v2
                                                Origin.Name = "Origin CFrame"
                                                Origin.Value = v2.CFrame
                                        end
                                end
                        end
                end
        end
---------
while num<maxnum and timedeb==true do ---print(num)
        for i, v in pairs(workspace:children()) do
                if v:isA("BasePart") and v:findFirstChild("Origin CFrame")==nil then
                        if v.Anchored==false then
                                table.insert(Targets, v)
                                local Origin = Instance.new("CFrameValue")
                                Origin.Parent = v
                                Origin.Name = "Origin CFrame"
                                Origin.Value = v.CFrame
                        end
                end
                for i, t in pairs(torsos) do
                        if v:isA("Model") and v~=t.Parent and v~=delorean then
                                for i, v2 in pairs(v:children()) do
                                        if v2:isA("BasePart") and v2:findFirstChild("Origin CFrame")==nil then
                                                table.insert(Targets, v2)
                                                local Origin = Instance.new("CFrameValue")
                                                Origin.Parent = v2
                                                Origin.Name = "Origin CFrame"
                                                Origin.Value = v2.CFrame
                                        end
                                end
                        end
                end
        end
for i, v in pairs(Targets) do
local History = Instance.new("CFrameValue") 
History.Parent = v 
History.Name = num
History.Value = v.CFrame 
end 
num = num + 1 
wait()
end
end
wait()
end
end)
while running do
local speed=base.Velocity.magnitude
speedometer.Text=math.floor(speed)
if speed>65 and speed<88 then play("http://www.roblox.com/asset/?id=2800815", 1, .5)
makelightning(base.CFrame*CFrame.new(0,0,10), base.CFrame*CFrame.new(rn(-10,10),rn(-10,10),rn(-2,10)), 1)
trail(tbr,cn(-1.5, 0, -10),2.5,"Bright orange")
trail(tbl,cn(-1.9, 0, -10),2.5,"Bright orange")
end
if speed>88 and speed<90 then play("http://roblox.com/asset/?id=10209481")
local trm2=trm:clone() trm2.Parent=workspace
origin=base.Position
print(origin)
game.Debris:addItem(trm2, 5)
bp.position=vc(0,0,-99999)
bp.Parent=base
timedeb=false
c(function()
for i=0,1,.005 do
game.Lighting.TimeOfDay=math.floor(hourbox.Text*i)..":"..math.floor(minutebox.Text*i)..":"..math.floor(secondbox.Text*i)
wait()
end
end)
while num > 0 do --print(num)
wait()
num = num - 1
for i, v in pairs(Targets) do
v.Anchored=true
local History = v:findFirstChild(num)
if History ~= nil then
v.CFrame = History.Value
History:remove()
end
end
end
for i, v in pairs(Targets) do
local Origin = v:findFirstChild("Origin CFrame")
if Origin ~= nil then
v.CFrame = Origin.Value
v:makeJoints()
Origin:remove()
end
end
for i, v in pairs(Targets) do
v.Anchored=false
end
play("http://www.roblox.com/asset/?id=2101148", 1, 1)
exp=Instance.new("Explosion", workspace)
exp.BlastPressure=0
exp.Position=origin
Targets = {}
timedeb=true
bp.position=origin
origin=0
base.Velocity=vc(0,0,0)
bf.force=base.CFrame.lookVector*0
wait(1)
bp:remove()
end
if vs.Steer==0 then bav.angularvelocity=vc(0,0,0) atfr(ca(0, 0, 0)) atfl(ca(0, 0, 0)) end
if vs.Steer==1 then atfr(ca(rd(-25), 0, 0)) atfl(ca(rd(-25), 0, 0)) end
if vs.Steer==-1 then atfr(ca(rd(25), 0, 0)) atfl(ca(rd(25), 0, 0)) end
if vs.Throttle==1 then bav.Parent=base bf.Parent=base
if vs.Steer==1 then bav.angularvelocity=vc(0,-2,0) end
if vs.Steer==-1 then bav.angularvelocity=vc(0,2,0) end
bf.force=base.CFrame.lookVector*40000
end
if vs.Throttle==0 then bav.Parent=base bf.Parent=base
bf.force=base.CFrame.lookVector*0
end
if vs.Throttle==-1 then bav.Parent=base bf.Parent=base
if vs.Steer==1 then bav.angularvelocity=vc(0,2,0) end
if vs.Steer==-1 then bav.angularvelocity=vc(0,-2,0) end
bf.force=base.CFrame.lookVector*-40000
end
wait()
end
end