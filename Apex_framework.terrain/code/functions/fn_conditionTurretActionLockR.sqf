/*
File: fn_conditionTurretActionLockR.sqf
Author:

	Quiksilver
	
Last modified:

	16/09/2022 A3 2.10 by Quiksilver
	
Description:

	Add action condition for pilot control of UH80 turrets
_______________________________________________________________*/

(
	((typeOf (vehicle player)) in [
		"B_Heli_Transport_01_camo_F",
		"B_Heli_Transport_01_F",
		"B_Heli_Transport_03_F",
		"B_CTRG_Heli_Transport_01_sand_F",
		"B_CTRG_Heli_Transport_01_tropic_F"
	]) && 
	(!((vehicle player) getVariable ["QS_turretR_locked",FALSE]))
)