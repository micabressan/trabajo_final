function SWGuard_OnEnterVehicle( unit )
	unit:SendChatMessage( 12, 0, "Naice! I'm on a vehicle now!" );
end

function SWGuard_OnExitVehicle( unit )
	unit:SendChatMessage( 12, 0, "Aw I got booted :(" );
end

function Horsey_OnFirstPassengerEntered( vehicle, passenger )
	vehicle:SendChatMessage( 12, 0, "Finally someone!" );
end

function Horsey_OnVehicleFull( vehicle )
	vehicle:SendChatMessage( 12, 0, "Now I feel full :S" );
end

function Horsey_OnLastPassengerLeft( vehicle, passenger )
	vehicle:SendChatMessage( 12, 0, "So ronery..." );
end

RegisterUnitEvent( 68, 24, "SWGuard_OnEnterVehicle" );
RegisterUnitEvent( 68, 25, "SWGuard_OnExitVehicle" );
RegisterUnitEvent( 28605, 26, "Horsey_OnFirstPassengerEntered" );
RegisterUnitEvent( 28605, 27, "Horsey_OnVehicleFull" );
RegisterUnitEvent( 28605, 28, "Horsey_OnLastPassengerLeft" );