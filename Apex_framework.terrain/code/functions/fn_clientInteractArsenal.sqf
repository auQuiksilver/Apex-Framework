/*/
File: fn_clientInteractArsenal.sqf
Author:

	Quiksilver
	
Last Modified:

	28/02/2018 A3 1.80 by Quiksilver
	
Description:

	Arsenal
_____________________________________________________________/*/

if ((missionNamespace getVariable ['QS_missionConfig_Arsenal',0]) isEqualTo 0) then {
	['Open',TRUE] call (missionNamespace getVariable 'BIS_fnc_arsenal');
};
if ((missionNamespace getVariable ['QS_missionConfig_Arsenal',0]) in [1,2]) then {
	[] spawn (missionNamespace getVariable 'BIS_fnc_arsenal');
};
TRUE;