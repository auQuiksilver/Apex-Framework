/*/
File: fn_clientHolster.sqf
Author:
	
	Quiksilver
	
Last Modified:

	8/11/2017 A3 1.76 by Quiksilver

Description:

	Client Holster Weapon
__________________________________________________________/*/

if (diag_tickTime > (player getVariable ['QS_RD_holstering',-1])) then {
	player setVariable ['QS_RD_holstering',(diag_tickTime + 1),FALSE];
	if (((attachedObjects player) isEqualTo []) || {(((attachedObjects player) findIf {((!isNull _x) && (!(_x isKindOf 'Sign_Sphere10cm_F')))}) isEqualTo -1)}) then {
		if (!((currentWeapon player) isEqualTo '')) then {
			player setVariable ['QS_RD_holsteredWeapon',(currentWeapon player),FALSE];
			player action ['SwitchWeapon',player,player,100];
		} else {
			if (!((player getVariable ['QS_RD_holsteredWeapon','']) isEqualTo '')) then {
				player selectWeapon (player getVariable ['QS_RD_holsteredWeapon',(primaryWeapon player)]);
			};
		};
	};
};