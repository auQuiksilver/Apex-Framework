/*/
File: fn_clientInteractArsenal.sqf
Author:

	Quiksilver
	
Last Modified:

	6/05/2018 A3 1.82 by Quiksilver
	
Description:

	Arsenal
_____________________________________________________________/*/

params ['','','','_unit'];
if ((missionNamespace getVariable ['QS_missionConfig_Arsenal',0]) isEqualTo 3) then {
	if (_unit isNotEqualTo player) then {
		[_unit] call (missionNamespace getVariable 'QS_fnc_clientArsenal');
	};
	missionNamespace setVariable ['BIS_fnc_arsenal_target',_unit,FALSE];
	['Open',TRUE] call (missionNamespace getVariable 'BIS_fnc_arsenal');
} else {
	['Open',[nil,_unit,_unit]] call (missionNamespace getVariable 'BIS_fnc_arsenal');
};
TRUE;