/*
File: fn_getLaserColors.sqf
Author:
	
	Quiksilver
	
Last Modified:

	14/04/2023 A3 2.12 by Quiksilver

Description:

	Get Laser Colors
___________________________________________*/

params ['_unit'];
private _col = [1000,0,0];		// RED
if ((missionNamespace getVariable ['QS_missionConfig_weaponLasersForced',[-1,-1,-1]]) isNotEqualTo [-1,-1,-1]) exitWith {
	missionNamespace getVariable ['QS_missionConfig_weaponLasersForced',[0,0,0]]
};
_col;