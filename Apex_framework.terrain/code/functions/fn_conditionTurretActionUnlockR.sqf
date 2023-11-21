/*
File: fn_conditionTurretActionUnlockR.sqf
Author:

	Quiksilver
	
Last modified:

	19/11/2023 A3 2.14 by Quiksilver
	
Description:

	Add action condition for pilot control of UH80 turrets
_______________________________________________________________*/

(
	(cameraOn getVariable ['QS_turretR_locked',FALSE]) &&
	{(((['turret_safety_1'] call QS_data_listVehicles) findIf { cameraOn isKindOf _x }) isNotEqualTo -1)}
)