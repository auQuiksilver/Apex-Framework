/*
File: fn_clientInteractWeaponSafety.sqf
Author:

	Quiksilver
	
Last Modified:

	30/03/2023 A3 2.12
	
Description:

	Weapon Safety interaction
_____________________________________________________________*/

if (
	(!weaponLowered QS_player) ||
	{((currentMuzzle QS_player) isNotEqualTo '')}
) then {
	50 cutText [localize 'STR_QS_Interact_106','PLAIN',0.2];
};
TRUE;