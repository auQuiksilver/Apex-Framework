/*/
File: fn_clientInteractArsenal.sqf
Author:

	Quiksilver
	
Last Modified:

	6/05/2018 A3 1.82 by Quiksilver
	
Description:

	Arsenal
_____________________________________________________________/*/

if ((missionNamespace getVariable ['QS_missionConfig_Arsenal',0]) isEqualTo 3) exitWith {
	['Open',TRUE] call (missionNamespace getVariable 'BIS_fnc_arsenal');
};
['Open',[nil,player,player]] call (missionNamespace getVariable 'BIS_fnc_arsenal');
TRUE;