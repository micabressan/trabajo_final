function ulx.psay( calling_ply, target_ply, message )
	ulx.fancyLog( { target_ply, calling_ply }, "#P to #P: " .. message, calling_ply, target_ply )
  for k,v in pairs(player.GetAll()) do
    if v:CheckGroup("mod") or v:IsAdmin() and !calling_ply:CheckGroup("mod") then
      v:ChatPrint("ADMINS:"..calling_ply:Nick().." said("..message..") to"..target_ply)
    end
  end
end