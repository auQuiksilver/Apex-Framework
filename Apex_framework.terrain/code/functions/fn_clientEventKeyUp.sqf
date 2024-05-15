/*
File: fn_clientEventKeyUp.sqf
Author:
	
	Quiksilver
	
Last Modified:

	24/02/2023 A3 2.12 by Quiksilver

Description:

	Client Event KeyUp
__________________________________________________________*/

params ['','_key','_shift','_ctrl','_alt'];
private _c = FALSE;
/*/
if !(uiNamespace isNil 'BIS_dynamicGroups_keyDownTime') then {
	uiNamespace setVariable ['BIS_dynamicGroups_keyDownTime',nil];
};
if (
	(_key in (actionKeys 'TeamSwitch')) &&
	{(!_shift)} &&
	{(!_ctrl)} &&
	{(uiNamespace isNil 'BIS_dynamicGroups_ignoreInterfaceOpening')}
) then {
	if ((isNull (findDisplay 60490)) && {missionNamespace getVariable ['BIS_dynamicGroups_allowInterface',TRUE]}) then {
		(call (missionNamespace getVariable 'BIS_fnc_displayMission')) createDisplay 'RscDisplayDynamicGroups';
	} else {
		if (uiNamespace isNil 'BIS_dynamicGroups_hasFocus') then {
			(['GetDisplay'] call (uiNamespace getVariable ['RscDisplayDynamicGroups_script',{}])) closeDisplay 2;
		};			
	};
	_c = TRUE;
};
/*/
if (
	(_key in (actionKeys 'GetOver')) &&
	{(isNull (objectParent QS_player))}
) then {
	if (uiNamespace getVariable ['QS_ui_getincargo_activate',TRUE]) then {
		uiNamespace setVariable ['QS_ui_getincargo_activate',FALSE];
	};
};
if (((actionKeys 'User20') isEqualTo []) && {(_key isEqualTo 219)}) then {
	['OUT'] call QS_fnc_clientMenuActionContext;
};
_c;