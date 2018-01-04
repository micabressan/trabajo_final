function alordAttackLoop()
	skyCheck() -- Where is everyone? _zulah.flying / _enemy.flying / _zulah.indoors
-----------------------------------------------------------------------------------
	if table.contains(_enemy.defs, "shield") then
		myCommandList.baleqCom = "manifest gale "..myTargetList[1]
	else
-----------------------------------------------------------------------------------	
		if _enemy.pressure > 5 then
			if _zulah.safeMode then 
		 		cecho("\n<purple> --- SAFETY BOOM ---")
			else				
				myCommandList.baleqCom = "aero compression "..myTargetList[1]
			end
		else
-----------------------------------------------------------------------------------
			if _zulah.alord.forceAsphyxiation and not table.contains(_enemy.affs, "asphyxiation") then
				myCommandList.baleqCom = "aero asphyxiate "..myTargetList[1]
			else		
-----------------------------------------------------------------------------------
				if _zulah.alord.forceTension and affstrack.score.tension == 0 then
					myCommandList.baleqCom = "aero tension "..myTargetList[1]
				else
----------------------------------------------------------------------------------------------------------------
--- MAIN SECTION
----------------------------------------------------------------------------------------------------------------
					if _zulah.alord.forceUpdraft and _enemy.flying and _zulah.flying and _enemy.pressure > 2 then
						myCommandList.baleqCom = "manifest updraft "..myTargetList[1]
					else				
						if _zulah.alord.forceUpdraft and not _enemy.flying and not _zulah.flying and not _zulah.indoors then
							myCommandList.baleqCom = "manifest updraft "..myTargetList[1]
						else
---------------------------------------------------
							if affstrack.score.manaleech > 60 and affstrack.score.deadening > 60 then
								myCommandList.baleqCom = "aero pressure "..myTargetList[1]
							elseif affstrack.score.disloyalty > 60 and affstrack.score.deadening > 60 then
								myCommandList.baleqCom = "aero pressure "..myTargetList[1]
							elseif affstrack.score.manaleech > 60 and affstrack.score.disloyalty > 60 then
								myCommandList.baleqCom = "aero pressure "..myTargetList[1]
							else
----------------------------------------------------------------------------------------------------------------
-- All 3 Smoke Affs False 
----------------------------------------------------------------------------------------------------------------
								if affstrack.score.manaleech < 60 and not _zulah.alord.zephyrRelapse then
									myCommandList.baleqCom = "manifest zephyr "..myTargetList[1]
								else
----------------------------------------------------------------------------------------------------------------					
									if affstrack.score.disloyalty < 60 and not _zulah.alord.scourRelapse then
										myCommandList.baleqCom = "aero scour "..myTargetList[1]
									else
----------------------------------------------------------------------------------------------------------------
										if affstrack.score.deadening < 60 and not _zulah.alord.strangleRelapse then	
											myCommandList.baleqCom = "aero strangle "..myTargetList[1]				
										else
----------------------------------------------------------------------------------------------------------------
-- All 3 Smoke Affs True 
----------------------------------------------------------------------------------------------------------------
											if _zulah.alord.forceUpdraft and not _enemy.flying and not _zulah.flying and not _zulah.indoors then
												myCommandList.baleqCom = "manifest updraft "..myTargetList[1]
											else
												myCommandList.baleqCom = "aero pressure "..myTargetList[1]
											end
----------------------------------------------------------------------------------------------------------------
-- END MAIN
----------------------------------------------------------------------------------------------------------------
										end	-- Deadening(Strangle) check	
----------------------------------------------------------------------------------------------------------------
									end -- Disloyalty(Scour) check	
----------------------------------------------------------------------------------------------------------------
								end -- Deadening(Strangle) check	
------------------------------------------------------------------------------
							end -- Manaleech(Zephyr) check				
------------------------------------------------------------------------------
						end -- Check for 2 affs and pressure for +3 pressure			
------------------------------------------------------------------------------
					end -- Pressure|Updraft check			
------------------------------------------------------------------------------
				end -- Tension check
------------------------------------------------------------------------------
			end -- Asphyxiation check
------------------------------------------------------------------------------
		end -- Compression check
------------------------------------------------------------------------------
	end -- Shield check
-------------------------------------------------------------------------------------------------		
	if _enemy.flying and not _zulah.flying then 
		if _zulah.alord.forceSkyhammer then
			myCommandList.baleqCom = "manifest skyhammer"
		else
			myCommandList.baleqCom = "manifest lightning "..myTargetList[1].."+aero tension "..myTargetList[1]
		end
	else
		if _zulah.alord.needLightning then
			myCommandList.baleqCom = "manifest lightning "..myTargetList[1].."+aero tension "..myTargetList[1]
		else
			myCommandList.baleqCom = "assess "..myTargetList[1].."+gauge "..myTargetList[1].."+"..myCommandList.baleqCom
		end
	end
--------------------------------------------------------------------------------------------------	
end