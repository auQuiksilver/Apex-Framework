/*/
File: fn_clientInteractArsenal.sqf
Author:

	Quiksilver
	
Last Modified:

	9/10/2023 A3 2.14 by Quiksilver
	
Description:

	Arsenal
_____________________________________________/*/

params ['','','','_unit'];
(QS_player getVariable ['QS_inzone',[]]) params ['_inSafezone','_safezoneLevel','_safezoneActive'];
_enemySides = QS_player call QS_fnc_enemySides;
if (
	(
		(!(_inSafezone)) ||
		(_inSafezone && _safezoneActive && (_safezoneLevel < 2))
	) &&
	(((flatten (_enemySides apply {units _x})) inAreaArray [QS_player,QS_enemyInterruptAction_radius,QS_enemyInterruptAction_radius,0,FALSE,-1]) isNotEqualTo [])
) exitWith {
	50 cutText [localize 'STR_QS_Text_454','PLAIN DOWN',0.5];
	FALSE;
};
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