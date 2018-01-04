local p = game:service'Players'.ii-Sandstorm
local c = p.Character
local bp = p.Backpack
pcall(function() _G.mm:Remove() end)
pcall(function() bp.RMTank:Remove() end)
it = Instance.new
v3=Vector3.new
bc=BrickColor.new 
c3=Color3.new 
cn=CFrame.new 
ca=CFrame.Angles
ti=table.insert 
tr=table.remove 
rn=math.random 
rd=math.rad 
mf=math.floor
asset = "http://www.roblox.com/asset/?id="
ds = {}
ds.Claw = "10681506"
ds.Ring = "3270017"
ds.Crack = "49173398" 
ds.Cloud = "1095708" 
ds.Spike = "1033714" 
ds.Rock = "1290033" 
ds.Crown = "1323306"
ds.Hood = "16952952"
ds.Slash = "10209645"
ds.Slash2 = "46760716"
ds.MadFace = "2235131"
ds.BanditMask = "20637493"
ds.Hood2 = "25211365"
ds.HoodT2 = "64240784"
ds.Axe = "12768042"
ds.AxeT = "12768034"
ds.Fist = "65322375"
ds.Tree1 = "1090398"
ds.Vine = "13108500"
ds.VineT = "17585271"
ds.TreeTexture = "2861779" 
ds.Tug = "31173820" -- sound
ds.Fire = "2693346" --"2760979" 
ds.Hit = "2801263"
ds.BulletHole = "64291961"
ds.Camo = "4268107"
table.foreach(ds,function(a,b)
if tonumber(b:sub(1,3)) then
ds[a] = asset .. b game:service'ContentProvider':Preload(ds[a]) 
end
end)
q = function(f)
coroutine.resume(coroutine.create(function()
f()
end))
end 
ft = function(tablez,item)
for i=1,#tablez do
if tablez[i] == item then
return i
end
end 
return nil 
end
pa = function(pa,pn,sh,x,y,z,c,a,tr,re,bc2) 
local fp=nil 
if sh ~= "Wedge" and sh ~= "CornerWedge" and sh ~= "VehicleSeat" and sh ~= "Seat" then 
fp=it("Part",pa) 
fp.Shape=sh 
fp.formFactor="Custom" 
elseif sh == "Wedge" then 
fp=it("WedgePart",pa) 
fp.formFactor="Custom"
elseif sh == "CornerWedge" then 
fp=it("CornerWedgePart",pa) 
elseif sh == "VehicleSeat" then 
fp=it("VehicleSeat",pa) 
elseif sh == "Seat" then 
fp=it("Seat",pa) 
end 
fp.Size=v3(x,y,z) 
fp.Friction = 2 
fp.CanCollide=c 
fp.Anchored=false 
fp.BrickColor=bc(bc2) 
fp.Transparency=tr 
fp.Reflectance=re 
fp.BottomSurface=0 
fp.Name=pn 
fp.Locked = true
--fp.FrontSurface="Hinge"
fp.TopSurface=0 
fp.CFrame = cn(-9000,9000,-9000)
fp:BreakJoints() 
fp.Anchored = a 
return fp 
end 
weld = function(pa,p0,p1,x,y,z,a,b,c) 
local fw=it("Weld",pa) 
fw.Part0=p0 
fw.Part1=p1 
fw.C0=cn(x,y,z) *ca(a,b,c) 
return fw 
end
fade = function(prt,incr) 
q(function() 
for i=prt.Transparency,1,incr do 
prt.Transparency=i 
wait() 
end
prt:Remove''
end) 
end
stick = function(hit2,hit) 
local weld=it("Weld") 
weld.Part0=hit2 
weld.Part1=hit 
local HitPos=hit2.Position 
local CJ=cn(HitPos) 
local C0=hit2.CFrame:inverse() *CJ 
local C1=hit.CFrame:inverse() * CJ 
weld.C0=C0 
weld.C1=C1 
weld.Parent=hit2
end 
ray = function(Pos, Dir,xxz) 
local xxz2=c 
if xxz ~= nil then 
xxz2=nil 
end 
return workspace:FindPartOnRay(Ray.new(Pos, Dir.unit *999),xxz2)
end 
ft2 = function(tablez,item) 
for i=1,#tablez do 
if tablez[i][1] == item then 
return i 
end 
end 
return nil 
end
Trail = function(ob,times,waitz,col,thickz,ofz) 
q(function() 
local oldpos=(ob.CFrame *ofz).p 
for i=1,times do 
local obp=(ob.CFrame *ofz).p 
local mag=(oldpos - obp).magnitude 
local tr=pa(ob,"trail","Block",0,0,0,false,false,0.5,0.15,col) 
tr.Anchored=true 
tr.CFrame=cn(oldpos,obp) 
tr.CFrame=tr.CFrame + tr.CFrame.lookVector* (mag/2) 
local trm=it("CylinderMesh",tr) 
trm.Scale=v3(5*thickz,mag*5,5*thickz) 
q(function() 
for i=5*thickz,0,-5*thickz/10 do 
trm.Scale=v3(i,mag*5,i) 
wait() 
end 
tr:Remove'' 
end) 
tr.CFrame=tr.CFrame *ca(rd(90),0,0) 
oldpos=obp wait(waitz) 
end 
end) 
end
qi = function(ttz) 
local qii = it(ttz[1],ttz[2]) 
table.foreach(ttz,function(oi,oi2) 
if oi ~= 1 and oi ~= 2 then 
qii[oi] = oi2 
end 
end) 
return qii 
end
de = function(it,ti) game:service'Debris':AddItem(it,ti) end
GlowMesh = function(anch,meshid2,rootz,mv3,colzz,adjus,l1,l2,l3) q(function()
local spi=pa(rootz,"","Block",1,1,1,false,false,l1,0,colzz) local spim=it("SpecialMesh",spi) if meshid2:lower()=="sphere" then spim.MeshType="Sphere" elseif meshid2:lower()=="block" then spim.MeshType="Brick" else spim.MeshType="FileMesh" spim.MeshId=meshid2 end
if anch then local spiw=qi({"Weld",spi,Part0=rootz,Part1=spi}) spiw.C0 =spiw.C0 *adjus else spi.Anchored=true spi.CFrame=adjus end 
for i=l1,l2,l1 do spi.Transparency=i spim.Scale=mv3*(i+0.3) wait() end spi:Remove'' end) 
end
DetectSurface = function(pos, part)
local surface = nil
local pospos = part.CFrame
local pos2 = pospos:pointToObjectSpace(pos)
local siz = part.Size
local shaep = part.Shape
if shaep == Enum.PartType.Ball or shaep == Enum.PartType.Cylinder then
surface = {"Anything", cn(pospos.p, pos)*cn(0, 0, -(pospos.p - pos).magnitude+0.12)*ca(rd(-90), 0, 0)}
else
if pos2.Y > ((siz.Y/2)-0.01) then
surface = {"Top", ca(0, 0, 0)}
elseif pos2.Y < -((siz.Y/2)-0.01) then
surface = {"Bottom", ca(-math.pi, 0, 0)}
elseif pos2.X > ((siz.X/2)-0.01) then
surface = {"Right", ca(0, 0, rd(-90))}
elseif pos2.X < -((siz.X/2)-0.01) then
surface = {"Left", ca(0, 0, rd(90))}
elseif pos2.Z > ((siz.Z/2)-0.01) then
surface = {"Back", ca(rd(90), 0, 0)}
elseif pos2.Z < -((siz.Z/2)-0.01) then
surface = {"Front", ca(rd(-90), 0, 0)}
end end
return surface
end
BulletHole = function(HitPos,HitObj,sc)
local Surface = DetectSurface(HitPos, HitObj)
local C = cn(HitPos) * ca(HitObj.CFrame:toEulerAnglesXYZ()) * Surface[2]
if Surface[1] == "Anything" then C = Surface[2] end
local bl = pa(workspace,"","Block",sc,0,sc,false,true,1,0,"") qi({"Decal",bl,Face="Top",Texture=ds.BulletHole})
bl.CFrame = C*cn(0,-0.1,0) if not HitObj.Anchored then bl.Anchored = false stick(bl,HitObj) bl.ChildRemoved:connect(function() bl:Remove() end) end de(bl,5) 
end
so = function(id,par,vol,pit) q(function()
local sou = qi({"Sound",par or workspace,Volume=vol/1.5 or 0.75,Pitch=pit or 1,SoundId=id})
wait() sou:play() wait(2) sou:Remove() end) end
GetRegion = function(p0,p1,f,f2) 
q(function()
for i,v in pairs(workspace:FindPartsInRegion3(Region3.new(p0,p1),c,100) ) do 
if v.Parent:findFirstChild("H") == nil and v.Name == "Torso" and v.Parent:findFirstChild("Humanoid") and v.Parent.Humanoid.Health > 0 and v.Parent:findFirstChild("Torso") then 
q(function() 
f(v.Parent) 
end) 
elseif f2 and v.Parent.Parent:findFirstChild("Humanoid") == nil then 
f2(v) 
end 
end
end) 
end 
FindGround = function(pos) 
local ax,ay,az = pos:toEulerAnglesXYZ()
local bhit,bpos=ray(pos.p,pos.p - (pos.p + v3(0,200,0)))
if bhit and bpos then 
return cn(bpos)*ca(ax,ay,az) 
end 
return nil 
end
MakeCrater = function(pos,sc,tyms,debz) 
q(function() 
if not debz then 
debz = 5 
end 
local bhit,bpos=ray(pos,pos - (pos + v3(0,200,0)))
if bhit and bpos then
for i=1,tyms do 
q(function()
local gr = pa(misc,"","Block",rn(5,13)/10*sc,0.25*sc,rn(4,10)/10*sc,true,true,bhit.Transparency,bhit.Reflectance,bhit.BrickColor.Name) 
gr.Material = bhit.Material 
gr.TopSurface = bhit.TopSurface
gr.CFrame = cn(bpos+v3(rn(-12,12)/10*sc,0,rn(-12,12)/10*sc))*ca(rd(rn(-40,40)),rd(rn(-360,360)),rd(rn(-40,40))) 
wait(debz) 
fade(gr,0.1)
end) 
end
end 
end)
end
MakeCrack = function(pos,sc,debz) 
q(function() 
if not debz then 
debz = 5 
end 
local bhit,bpos=ray(pos,pos - (pos + v3(0,10,0)))
if bhit and bpos then
local cr = pa(misc,"","Block",sc,0,sc,false,true,1,0,"") cr.CFrame = cn(bpos)
local dec=qi({"Decal",cr,Face="Top",Texture=ds.Crack}) de(cr,debz)
end 
end)
end
f1 = function(cff,hit2,hit)
local HitPos=cff.p 
local CJ=cn(HitPos) 
local C0=cff:inverse() *CJ 
local C1=hit.CFrame:inverse() * CJ 
return C0,C1
end 
a = {}
a.insw={}
function cleanweld(wexx,namzi) 
local tn=ft2(a.insw,wexx) 
if tn==nil then return end 
if namzi=="p0" then 
a.insw[tn][2]["p0x"],a.insw[tn][2]["p0y"],a.insw[tn][2]["p0z"]=0,0,0 elseif namzi=="p1" then
a.insw[tn][2]["p1x"],a.insw[tn][2]["p1y"],a.insw[tn][2]["p1z"]=0,0,0 elseif namzi=="a0" then
a.insw[tn][2]["a0x"],a.insw[tn][2]["a0y"],a.insw[tn][2]["a0z"]=0,0,0 elseif namzi=="a1" then
a.insw[tn][2]["a1x"],a.insw[tn][2]["a1y"],a.insw[tn][2]["a1z"]=0,0,0 
end
end
function c2(wexx,smmx,c0orc1,aa,bb,cc,xx,yy,zz) 
q(function() 
c1(wexx,smmx,c0orc1,aa,bb,cc,xx,yy,zz) 
end) 
end
a.Welding=0 
function c1(wexx,smmx,c0orc1,aa,bb,cc,xx,yy,zz)
if ft2(a.insw,wexx)==nil then 
ti(a.insw,{wexx,{}}) 
local tn=ft2(a.insw,wexx) 
a.insw[tn][2]["p0x"],a.insw[tn][2]["p0y"],a.insw[tn][2]["p0z"]=wexx.C0.x,wexx.C0.y,wexx.C0.z 
a.insw[tn][2]["p1x"],a.insw[tn][2]["p1y"],a.insw[tn][2]["p1z"]=wexx.C1.x,wexx.C1.y,wexx.C1.z 
a.insw[tn][2]["a0x"],a.insw[tn][2]["a0y"],a.insw[tn][2]["a0z"]=wexx.C0:toEulerAnglesXYZ()
a.insw[tn][2]["a1x"],a.insw[tn][2]["a1y"],a.insw[tn][2]["a1z"]=wexx.C1:toEulerAnglesXYZ() 
end 
local tn=ft2(a.insw,wexx) 
local xx2,yy2,zz2=0,0,0 
local x2,y2,z2=0,0,0 
if c0orc1==0 then 
xx2,yy2,zz2=a.insw[tn][2]["a0x"],a.insw[tn][2]["a0y"],a.insw[tn][2]["a0z"] 
x2,y2,z2=a.insw[tn][2]["p0x"],a.insw[tn][2]["p0y"],a.insw[tn][2]["p0z"] 
elseif c0orc1==1 then 
xx2,yy2,zz2=a.insw[tn][2]["a1x"],a.insw[tn][2]["a1y"],a.insw[tn][2]["a1z"] 
x2,y2,z2=a.insw[tn][2]["p1x"],a.insw[tn][2]["p1y"],a.insw[tn][2]["p1z"] 
else 
xx2,yy2,zz2=a.insw[tn][2]["a1x"],a.insw[tn][2]["a1y"],a.insw[tn][2]["a1z"]
x2,y2,z2=a.insw[tn][2]["p0x"],a.insw[tn][2]["p0y"],a.insw[tn][2]["p0z"] 
end a.Welding=a.Welding + 1 
local twa=1 
if smmx >= 1 then 
else 
for i=smmx,0.8,smmx do 
twa = 1 
if c0orc1==0 then 
wexx.C0=cn(x2-(((x2-aa)/twa)*i),y2-(((y2-bb)/twa)*i),z2-(((z2-cc)/twa)*i)) *ca(xx2-(((xx2-rd(xx))/twa)*i),yy2-(((yy2-rd(yy))/twa)*i),zz2-(((zz2-rd(zz))/twa)*i)) 
elseif c0orc1==1 then 
wexx.C1=cn(x2-(((x2-aa)/twa)*i),y2-(((y2-bb)/twa)*i),z2-(((z2-cc)/twa)*i)) *ca(xx2-(((xx2-rd(xx))/twa)*i),yy2-(((yy2-rd(yy))/twa)*i),zz2-(((zz2-rd(zz))/twa)*i)) 
else local x,y,z = wexx.C0:toEulerAnglesXYZ()
wexx.C0=cn(x2-(((x2-aa)/twa)*i),y2-(((y2-bb)/twa)*i),z2-(((z2-cc)/twa)*i))*ca(x,y,z)
wexx.C1=cn(wexx.C1.x,wexx.C1.y,wexx.C1.z)*ca(xx2-(((xx2-rd(xx))/twa)*i),yy2-(((yy2-rd(yy))/twa)*i),zz2-(((zz2-rd(zz))/twa)*i))
end 
if fu then 
q(fu) 
end 
wait() 
end 
for i=0.8,1,smmx*0.45 do 
twa = 1 
if c0orc1==0 then 
wexx.C0=cn(x2-(((x2-aa)/twa)*i),y2-(((y2-bb)/twa)*i),z2-(((z2-cc)/twa)*i)) *ca(xx2-(((xx2-rd(xx))/twa)*i),yy2-(((yy2-rd(yy))/twa)*i),zz2-(((zz2-rd(zz))/twa)*i)) 
elseif c0orc1==1 then 
wexx.C1=cn(x2-(((x2-aa)/twa)*i),y2-(((y2-bb)/twa)*i),z2-(((z2-cc)/twa)*i)) *ca(xx2-(((xx2-rd(xx))/twa)*i),yy2-(((yy2-rd(yy))/twa)*i),zz2-(((zz2-rd(zz))/twa)*i)) 
else local x,y,z = wexx.C0:toEulerAnglesXYZ()
wexx.C0=cn(x2-(((x2-aa)/twa)*i),y2-(((y2-bb)/twa)*i),z2-(((z2-cc)/twa)*i))*ca(x,y,z)
wexx.C1=cn(wexx.C1.x,wexx.C1.y,wexx.C1.z)*ca(xx2-(((xx2-rd(xx))/twa)*i),yy2-(((yy2-rd(yy))/twa)*i),zz2-(((zz2-rd(zz))/twa)*i))
end
wait() 
end 
end 
local i=1 
if c0orc1==0 then 
wexx.C0=cn(x2-(((x2-aa)/twa)*i),y2-(((y2-bb)/twa)*i),z2-(((z2-cc)/twa)*i)) *ca(xx2-(((xx2-rd(xx))/twa)*i),yy2-(((yy2-rd(yy))/twa)*i),zz2-(((zz2-rd(zz))/twa)*i)) 
elseif c0orc1==1 then 
wexx.C1=cn(x2-(((x2-aa)/twa)*i),y2-(((y2-bb)/twa)*i),z2-(((z2-cc)/twa)*i)) *ca(xx2-(((xx2-rd(xx))/twa)*i),yy2-(((yy2-rd(yy))/twa)*i),zz2-(((zz2-rd(zz))/twa)*i)) 
else local x,y,z = wexx.C0:toEulerAnglesXYZ()
wexx.C0=cn(x2-(((x2-aa)/twa)*i),y2-(((y2-bb)/twa)*i),z2-(((z2-cc)/twa)*i))*ca(x,y,z)
wexx.C1=cn(wexx.C1.x,wexx.C1.y,wexx.C1.z)*ca(xx2-(((xx2-rd(xx))/twa)*i),yy2-(((yy2-rd(yy))/twa)*i),zz2-(((zz2-rd(zz))/twa)*i))
end 
a.Welding=a.Welding - 1 
local tn=ft2(a.insw,wexx)
if c0orc1==0 then 
a.insw[tn][2]["p0x"],a.insw[tn][2]["p0y"],a.insw[tn][2]["p0z"]=x2-(((x2-aa)/twa)*i),y2-(((y2-bb)/twa)*i),z2-(((z2-cc)/twa)*i)
a.insw[tn][2]["a0x"],a.insw[tn][2]["a0y"],a.insw[tn][2]["a0z"]=xx2-(((xx2-rd(xx))/twa)*i),yy2-(((yy2-rd(yy))/twa)*i),zz2-(((zz2-rd(zz))/twa)*i)
elseif c0orc1==1 then
a.insw[tn][2]["p1x"],a.insw[tn][2]["p1y"],a.insw[tn][2]["p1z"]=x2-(((x2-aa)/twa)*i),y2-(((y2-bb)/twa)*i),z2-(((z2-cc)/twa)*i)
a.insw[tn][2]["a1x"],a.insw[tn][2]["a1y"],a.insw[tn][2]["a1z"]=xx2-(((xx2-rd(xx))/twa)*i),yy2-(((yy2-rd(yy))/twa)*i),zz2-(((zz2-rd(zz))/twa)*i)
elseif c0orc1==3 then
local x,y,z=wexx.C0.x,wexx.C0.y,wexx.C0.z 
a.insw[tn][2]["p0x"],a.insw[tn][2]["p0y"],a.insw[tn][2]["p0z"]=x2-(((x2-aa)/twa)*i),y2-(((y2-bb)/twa)*i),z2-(((z2-cc)/twa)*i)
local x,y,z=wexx.C1:toEulerAnglesXYZ()
a.insw[tn][2]["a1x"],a.insw[tn][2]["a1y"],a.insw[tn][2]["a1z"]=xx2-(((xx2-rd(xx))/twa)*i),yy2-(((yy2-rd(yy))/twa)*i),zz2-(((zz2-rd(zz))/twa)*i)
end 
end 
gunshot = function(speed,sc,dmg,cff) q(function()
local bb = pa(workspace,"","Block",0.2*sc,0.3*sc,0.2*sc,true,true,0,0.1,"Black") qi({"CylinderMesh",bb})
bb.CFrame = cff*ca(rd(rn(-1000,1000)/1500),rd(rn(-1000,1000)/1500),rd(rn(-1000,1000)/1500))
so(ds.Fire,bb,0.3,1) wait() for i=1,50 do 
bhit,bpos=ray(bb.Position,bb.Position - (bb.CFrame *cn(0,-1,0)).p)
if bhit and bpos and (bpos - bb.Position).magnitude < speed then break end
bb.CFrame=bb.CFrame*cn(0,speed,0)*ca(rd(-0.2),0,0)
wait()
end bb.CFrame=bb.CFrame*cn(0,(bpos-bb.Position).magnitude,0)
if not bhit.Anchored then 
if bhit.Parent:findFirstChild("Humanoid") then local h = bhit.Parent.Humanoid h.Health=h.Health-dmg so(ds.Hit,bhit,0.3,1) end 
else end bb:Remove()
if bhit.Parent:findFirstChild("Humanoid") == nil then BulletHole(bpos,bhit,0.7*sc) end
end) end
_G.mm = qi({"Model",workspace,Name="RMTank"})
local mm = _G.mm
engine=pa(mm,"","Block",14,3,20,true,false,0,0,"Bright blue") it('BlockMesh',engine)
engine.CFrame = c.Torso.CFrame*cn(0,0,-20)
front=pa(mm,"","Wedge",14,3,3,true,false,0,0,"Bright blue")
qi({"Weld",front,Part0=engine,Part1=front,C0=cn(0,0,-11.5)*ca(rd(180),rd(180),0)})
front2=pa(mm,"","Wedge",14,2,6,true,false,0,0,"Bright blue")
qi({"Weld",front,Part0=engine,Part1=front2,C0=cn(0,2.5,-10)})
back=pa(mm,"","Wedge",14,5,6,true,false,0,0,"Bright blue")
qi({"Weld",front,Part0=engine,Part1=back,C0=cn(0,1,13)*ca(rd(180),rd(0),0)})
body2=pa(mm,"","Block",14,2,17,true,false,0,0,"Bright blue") it('BlockMesh',body2)
qi({"Weld",body2,Part0=engine,Part1=body2,C0=cn(0,2.5,1.5)})
body3=pa(mm,"","Wedge",14,1,8,true,false,0,0,"Bright blue") 
qi({"Weld",body2,Part0=engine,Part1=body3,C0=cn(0,4,12)})
lbody=pa(mm,"","Block",2.3,3,24,true,false,0,0,"Bright blue") it('BlockMesh',lbody)
qi({"Weld",body2,Part0=engine,Part1=lbody,C0=cn(8.1,2.5,1.5)})
rbody=pa(mm,"","Block",2.3,3,24,true,false,0,0,"Bright blue") it('BlockMesh',rbody)
qi({"Weld",body2,Part0=engine,Part1=rbody,C0=cn(-8.1,2.5,1.5)})
lb=pa(mm,"","Block",2.25,0.4,18,true,false,0,0,"Black") it('BlockMesh',lb)
qi({"Weld",body2,Part0=engine,Part1=lb,C0=cn(8,-2.5,1.5)})
rb=pa(mm,"","Block",2.25,0.4,18,true,false,0,0,"Black") it('BlockMesh',lb)
qi({"Weld",body2,Part0=engine,Part1=rb,C0=cn(-8,-2.5,1.5)})
spi=pa(mm,"","Block",5,3,5,true,false,0,0,"Bright blue") it('CylinderMesh',spi)
spiw = qi({"Weld",body2,Part0=engine,Part1=spi,C0=cn(0,5,5)})
spi2=pa(mm,"","Block",12,3,12,true,false,0,0,"Bright blue") it('BlockMesh',spi2)
qi({"Weld",body2,Part0=spi,Part1=spi2,C0=cn(0,1,0)})
spi6=pa(mm,"","Wedge",12,3,2,true,false,0,0,"Bright blue") it('BlockMesh',spi2)
qi({"Weld",body2,Part0=spi2,Part1=spi6,C0=cn(0,0,7)*ca(rd(180),rd(0),0)})
spi3=pa(mm,"","Wedge",3,6,4,true,false,0,0,"Bright blue") 
qi({"Weld",body2,Part0=spi2,Part1=spi3,C0=cn(-3,0,-8)*ca(0,0,rd(90))})
spi4=pa(mm,"","Wedge",3,6,4,true,false,0,0,"Bright blue") 
qi({"Weld",body2,Part0=spi2,Part1=spi4,C0=cn(3,0,-8)*ca(0,0,rd(-90))})
tilt=pa(mm,"","Block",5,3,5,true,false,0,0,"Bright blue") it('CylinderMesh',tilt)
tiltw=qi({"Weld",body2,Part0=spi2,Part1=tilt,C0=cn(0,0.5,-8.5)*ca(0,0,rd(90))})
can=pa(mm,"","Block",2,20,2,true,false,0,0,"Bright blue") it('CylinderMesh',can)
canw=qi({"Weld",body2,Part0=tilt,Part1=can,C0=cn(0,0,-11)*ca(rd(-90),0,0)})
can2=pa(mm,"","Block",3.4,1.5,3.4,true,false,0,0,"Bright blue") it('CylinderMesh',can2)
qi({"Weld",body2,Part0=can,Part1=can2,C0=cn(0,-4,0)})
can5=pa(mm,"","Block",2.4,1.5,2.4,true,false,0,0,"Bright blue") it('CylinderMesh',can5)
qi({"Weld",body2,Part0=can,Part1=can5,C0=cn(0,9,0)})
can3=pa(mm,"","Block",2.5,10,2.5,true,false,0,0,"Bright blue") it('CylinderMesh',can3)
qi({"Weld",body2,Part0=can,Part1=can3,C0=cn(0,-5,0)})
can4=pa(mm,"","Block",3,4,3,true,false,0,0,"Bright blue") it('CylinderMesh',can4)
qi({"Weld",body2,Part0=can,Part1=can4,C0=cn(0,1,0)})
hol=pa(mm,"","Block",1.75,0,1.75,true,false,0,0,"Really black") it('CylinderMesh',hol)
qi({"Weld",body2,Part0=can,Part1=hol,C0=cn(0,10,0)})
smo = qi({"Smoke",hol,RiseVelocity=25,Size=8,Color=BrickColor.new("White").Color,Opacity=0.1,Enabled=false})
hol2=pa(mm,"","Block",0,0,0,true,false,0,0,"Really black") it('CylinderMesh',hol2).Scale=v3(5,0.2,5)*5
qi({"Weld",body2,Part0=spi2,Part1=hol2,C0=cn(0,1.5,4)})
cap=pa(mm,"","Block",5.1,0,5.1,true,false,0,0,"Brick blue") it('CylinderMesh',cap)
capw = qi({"Weld",body2,Part0=hol2,Part1=cap,C0=cn(0,0.1,2.5),C1=cn(0,0,2.5)})
aaa=pa(mm,"","Block",3,0.5,0.5,true,false,0,0,"Brick blue") 
qi({"Weld",body2,Part0=hol2,Part1=aaa,C0=cn(0,0,2.5)})
aaa2=pa(mm,"","Block",5,0.5,5,true,false,0,0,"Bright blue") it('CylinderMesh',aaa2)
aaa2w=qi({"Weld",body2,Part0=spi2,Part1=aaa2,C0=cn(-3.4,1.7,-4.6)*ca(0,rd(35),0)})
lb.Friction = 0.045
rb.Friction = 0.045
for x=-5,5,10/3 do 
aaax=pa(mm,"","Block",2,3.5,2,true,false,0,0,"") 
qi({"Weld",body2,Part0=spi2,Part1=aaax,C0=cn(x,0,7.5)*ca(rd(80),0,0)}) it('CylinderMesh',aaax)
end
for x=-1,1 do 
aaa=pa(mm,"","Block",x~=0 and 3 or 2,3,0.5,true,false,0,0,"Bright blue") 
qi({"Weld",body2,Part0=aaa2,Part1=aaa,C0=cn(x*2,1.6,x~=0 and -1 or -2)*ca(0,rd(-45*x),0)})
if x==0 then
ball=pa(mm,"","Block",0,0,0,true,false,0,0,"Bright blue") qi({"SpecialMesh",ball,MeshType="Sphere",Scale=v3(1.7,1,1)*7})
ballw=qi({"Weld",body2,Part0=aaa,Part1=ball,C0=cn(0,1.5,0)})
gun1=pa(mm,"","Block",0.5,2,0.5,true,false,0,0,"Bright blue") it('CylinderMesh',gun1)
qi({"Weld",body2,Part0=ball,Part1=gun1,C0=cn(-0.4,0,-1)*ca(rd(-90),0,0)})
gun2=pa(mm,"","Block",0.5,2,0.5,true,false,0,0,"Bright blue") it('CylinderMesh',gun2)
qi({"Weld",body2,Part0=ball,Part1=gun2,C0=cn(0.4,0,-1)*ca(rd(-90),0,0)})
for i,v in pairs({gun1,gun2}) do 
gunhol=pa(mm,"","Block",0.3,0,0.3,true,false,0,0,"Really black") it('CylinderMesh',gunhol)
qi({"Weld",body2,Part0=v,Part1=gunhol,C0=cn(0,0.92,0)})
end
seat2=pa(mm,"","VehicleSeat",2,0.5,2,true,false,0,0,"Bright blue") it('CylinderMesh',seat2)
seat2w=qi({"Weld",body2,Part0=aaa2,Part1=seat2,C0=cn(0,0.5,0)})
seat2.HeadsUpDisplay=false
q(function()
local guntilt = 0
for i,v in pairs({aaa2,ball,seat2}) do 
local gcd = qi({"ClickDetector",v,MaxActivationDistance=8})
gcd.MouseClick:connect(function()
gunshot(10,1,5,gun1.CFrame*cn(0,1+(rn(0,2000)/600),0))
gunshot(10,1,5,gun2.CFrame*cn(0,1+(rn(0,2000)/600),0))
end)
end
while true do if rn(1,8) == 1 then wait() else wait(0.0345) end 
aaa2w.C1=aaa2w.C1*ca(0,rd(seat2.Steer*6),0)
if seat2.Throttle == 1 and guntilt<112 then guntilt = guntilt+4
elseif seat2.Throttle == -1 and guntilt>-48 then guntilt=guntilt-4
--elseif seat2.Throttle==0 then if guntilt > 0 then guntilt=guntilt-4 elseif guntilt<0 then guntilt=guntilt+4 end
end
ballw.C1=ca(rd(-guntilt),0,0)
end
end)
end
end
for x=-1,1,2 do
for z=-1,1,2 do 
whe=pa(mm,"","Block",4,2,4,true,false,0,0,"Black") qi({"CylinderMesh",whe})
qi({"Weld",whe,Part0=engine,Part1=whe,C0=cn(x*8,0.8,(z*11.5)+1.5)*ca(0,0,rd(90))})
ss=pa(mm,"","Block",2.25,0.3,5,true,false,0,0,"Black") 
qi({"Weld",body2,Part0=engine,Part1=ss,C0=cn(x*8,-1.5,(z*11.2)+1.5)*ca(rd(-23*z),0,0)})
ss=pa(mm,"","Block",2.25,2,0.3,true,false,0,0,"Black") 
qi({"Weld",body2,Part0=engine,Part1=ss,C0=cn(x*8,0.4,(z*13.4)+1.5)})
ss=pa(mm,"","Wedge",2.3,3,3,true,false,0,0,"Bright blue") 
local trolo = z == 1 and 180 or 0
qi({"Weld",body2,Part0=engine,Part1=ss,C0=cn(x*8.1,2.5,(z*13.5)+1.5)*ca(0,rd(trolo),0)})
end end 
local form = 4*4
for x=-1,1,2 do 
for z=form/2,-form/2,-form/3 do 
whe=pa(mm,"","Block",4,2,4,true,false,0,0,"Black") qi({"CylinderMesh",whe})
qi({"Weld",whe,Part0=engine,Part1=whe,C0=cn(8*x,-0.5,(z*0.9)+1.5)*ca(0,0,rd(90))})
end
end
for i,p in pairs(mm:children()) do if p.BrickColor.Name=="Bright blue" then 
for i,s in pairs({"Back","Front","Bottom","Top","Left","Right"}) do 
--qi({"Texture",p,Face=s,Texture=ds.Camo,StudsPerTileU=0,StudsPerTileV=0})
end
end end 
game.Lighting.Ambient=Color3.new(1,1,1)
local bin = qi({"HopperBin",bp,Name="RMTank"})
t = {}
t.Vault = "Closed"
t.Steer = ""
t.Steer2 = ""
t.Steering=""
t.Tilt = 0
t.Move = ""
t.Fire = false
ks = {}
TheWeld = nil
Seated = false
TankSpeed=16
bv = qi({"BodyVelocity",engine}) bv.maxForce=v3(0,0,0)
bav = qi({"BodyAngularVelocity",engine}) bav.maxTorque=v3(0,0,0)
bin.Selected:connect(function(mouse)
mouse.KeyDown:connect(function(k) k = k:lower() ks[k]=false
if k == "g" and t.Vault~="moving" then if t.Vault=="Closed" then
t.Vault = "moving" for i=0,-110,-10 do capw.C1=cn(0,0,2.5)*ca(rd(i),0,0) wait(0.034) end t.Vault="Opened" else
t.Vault = "moving" for i=-110,0,10 do capw.C1=cn(0,0,2.5)*ca(rd(i),0,0) wait(0.034) end t.Vault="Closed" end 
elseif k == "h" and t.Steer=="" then t.Steer = "Left" repeat spiw.C1=spiw.C1*ca(0,rd(-2),0) wait(0.034) until ks[k] t.Steer = ""
elseif k == "k" and t.Steer=="" then t.Steer = "Right" repeat spiw.C1=spiw.C1*ca(0,rd(2),0) wait(0.034) until ks[k] t.Steer = ""
elseif k == "u" and t.Steer2=="" then t.Steer2 = "Up" repeat t.Tilt=t.Tilt+1.5 tiltw.C1=ca(0,rd(t.Tilt),0) wait(0.034) until t.Tilt>=90 or ks[k] t.Steer2 = ""
elseif k == "j" and t.Steer2=="" then t.Steer2 = "Down" repeat t.Tilt=t.Tilt-1.5 tiltw.C1=ca(0,rd(t.Tilt),0) wait(0.034) until t.Tilt<=-12 or ks[k] t.Steer2 = ""
elseif k == "z" and t.Vault=="Opened" and Seated and TheWeld then Seated = false TheWeld:Remove() c.Humanoid.PlatformStand = false c.Torso.CFrame = hol2.CFrame*cn(0,4,0) mm.Parent = workspace
elseif k == "w" and Seated and t.Move == "" then t.Move = "Forward" bv.maxForce=v3(1/0,0,1/0) repeat bv.velocity=engine.CFrame.lookVector*TankSpeed wait() until ks[k] bv.maxForce=v3(0,0,0) t.Move = ""
elseif k == "s" and Seated and t.Move == "" then t.Move = "Backward" bv.maxForce=v3(1/0,0,1/0) repeat bv.velocity=engine.CFrame.lookVector*(-TankSpeed/1.2) wait() until ks[k] bv.maxForce=v3(0,0,0) t.Move = ""
elseif k == "a" and Seated and t.Steering=="" then t.Steering="Left" bav.maxTorque=v3(0,1/0,0) bav.angularvelocity=v3(0,0.8,0) repeat wait() until ks[k] bav.maxTorque=v3(0,0,0) t.Steering = ""
elseif k == "d" and Seated and t.Steering=="" then t.Steering="Right" bav.maxTorque=v3(0,1/0,0) bav.angularvelocity=v3(0,-0.8,0) repeat wait() until ks[k] bav.maxTorque=v3(0,0,0) t.Steering = ""
elseif k == "f" and not t.Fire then t.Fire = true
q(function() 
GlowMesh(false,ds.Ring,hol,v3(7,7,7),'New Yeller',hol.CFrame*cn(0,0,0)*ca(rd(90),0,0),0.1,1,0.13)
local speed = 8 local cff = hol.CFrame*cn(0,2,0) local dmg = 25 
local bb = pa(mm,"","Block",2,2,2,true,true,0,0.2,"Black") qi({"CylinderMesh",bb})
local bb2 = pa(mm,"","Block",0,0,0,true,true,0,0.2,"Black") qi({"SpecialMesh",bb2,MeshType="Sphere",Scale=v3(2,3,2)*5})
bb.CFrame = cff*ca(rd(rn(-1000,1000)/1500),rd(rn(-1000,1000)/1500),rd(rn(-1000,1000)/1500))
so(ds.Fire,bb,0.3,1) wait() for i=1,50 do bb2.CFrame = bb.CFrame*cn(0,-5,0)
bhit,bpos=ray(bb.Position,bb.Position - (bb.CFrame *cn(0,-1,0)).p)
if bhit and bpos and (bpos - bb.Position).magnitude < speed then break end
bb.CFrame=bb.CFrame*cn(0,speed,0)*ca(0,0,rd(0.2)) bb2.CFrame=bb.CFrame*cn(0,1,0)
wait()
end bb.CFrame=bb.CFrame*cn(0,(bpos-bb.Position).magnitude,0)
bb:Remove() bb2:Remove()
for i=1,3 do 
GlowMesh(false,"Sphere",hol,v3(rn(10,20),rn(10,20),rn(10,20)),'New Yeller',bb.CFrame*cn(rn(-3,3),rn(-3,3),rn(-3,3))*ca(rd(rn(-360,360)),rd(rn(-360,360)),rd(rn(-360,360))),0.1,1,0.1) end
local rr = 10 GetRegion(bb.Position-v3(rr,rr,rr),bb.Position+v3(rr,rr,rr),function(v) if v.Name~="Torso" then return end v.Humanoid.Health=b.Humanoid.Health-dmg end,function(v) if v.Anchored or v:GetMass()>500 then return end v:BreakJoints() v.Velocity=cn(bb.Position,v.Position).lookVector*rn(70,120) end)
end)
smo.Enabled = true for i=0,-3,-1 do canw.C1=cn(0,-i/1.3,0) wait(0.033) end for i=-3,0,1 do canw.C1=cn(0,-i/1.3,0) wait(0.033) end 
smo.Enabled = false t.Fire = false
end
end)
mouse.KeyUp:connect(function(k) k=k:lower() ks[k]=true 
end)
end)
hol2.Touched:connect(function(hit) if hit.Parent ~= c or Seated or t.Vault~="Opened" then return end 
_G.mm.Parent = c Seated = true 
local hu = c.Humanoid hu.PlatformStand = true wait()
TheWeld = qi({"Weld",engine,Part0=engine,Part1=c.Torso,C0=cn(0,1.5,2)*ca(rd(90),0,0)})
end)