/*/
File: fn_clientEventEachFrame.sqf
Author: 

	Quiksilver
	
Last modified:

	19/06/2019 A3 1.94 by Quiksilver
	
Description:

	Each Frame
______________________________________________/*/

if ((missionNamespace getVariable ['QS_projectile_manager',[]]) isEqualTo []) then {
	removeMissionEventHandler [_thisEvent,_thisEventHandler];
	missionNamespace setVariable ['QS_projectile_manager_PFH',-1,FALSE];
} else {
	{
		if (!isNull (_x # 1)) then {
			_x call (missionNamespace getVariable 'QS_fnc_clientProjectileManager');
		} else {
			(missionNamespace getVariable ['QS_projectile_manager',[]]) deleteAt _forEachIndex;
		};
	} forEach (missionNamespace getVariable ['QS_projectile_manager',[]]);
};