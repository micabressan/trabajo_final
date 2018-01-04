function zzzBlaaaa()
i,s,S=1,"spell",GetSpellName; 
f="Kick"; 
n,r=S(i,"spell") repeat 
if strfind(n,f)~=nil then 
    m=format("Spell %d: %s %s",i,n,r); 
    DEFAULT_CHAT_FRAME:AddMessage(m); 
end 
i=i+1; n,r=S(i,"spell") 
until n==nil
swapIfBashCooldown(i)
end

function swapIfBashCooldown(spellID)
if GetSpellCooldown(spellID, "spell")>0 then 
WeaponSwap("xxx", "yyy")
else
WeaponSwap("xxx", "yyy")
 ; end
end