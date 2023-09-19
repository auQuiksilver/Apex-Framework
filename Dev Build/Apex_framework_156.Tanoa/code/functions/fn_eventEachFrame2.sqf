/*/
File: fn_eventEachFrame2.sqf
Author:

	Quiksilver
	
Last modified:

	17/01/2019 A3 1.98 by Quiksilver
	
Description:

	Event Each Frame 2 - Projectile Management
__________________________________________________/*/

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