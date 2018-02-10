/*
File: fn_clientEventKeyUp.sqf
Author:
	
	Quiksilver
	
Last Modified:

	20/06/2017 A3 1.70 by Quiksilver

Description:

	Client Event Key  Up
__________________________________________________________*/

_key = _this select 1;
private _c = FALSE;
uiNamespace setVariable ['BIS_dynamicGroups_keyDownTime',nil];
if (_key in (actionKeys 'TeamSwitch')) then {
	if (!(_this select 2)) then {
		if (!(_this select 3)) then {
			if (isNil {uiNamespace getVariable 'BIS_dynamicGroups_ignoreInterfaceOpening'}) then {
				if ((isNull (findDisplay 60490)) && {missionNamespace getVariable ['BIS_dynamicGroups_allowInterface',TRUE]}) then {
					([] call (missionNamespace getVariable 'BIS_fnc_displayMission')) createDisplay 'RscDisplayDynamicGroups';
				} else {
					if (isNil {uiNamespace getVariable 'BIS_dynamicGroups_hasFocus'}) then {
						(['GetDisplay'] call (uiNamespace getVariable ['RscDisplayDynamicGroups_script',{}])) closeDisplay 2;
					};			
				};
				_c = TRUE;
			};
		};
	};
};
_c;