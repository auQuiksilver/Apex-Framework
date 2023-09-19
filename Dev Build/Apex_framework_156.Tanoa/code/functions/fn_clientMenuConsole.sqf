/*
File: fn_clientMenuConsole.sqf
Author:
	
	Quiksilver
	
Last Modified:

	28/04/2016 A3 1.58 by Quiksilver

Description:

	Client Menu Console
__________________________________________________________*/

if (!((getPlayerUID player) in (['DEVELOPER'] call (missionNamespace getVariable 'QS_fnc_whitelist')))) exitWith {closeDialog 0;};
private ['_type','_display','_index','_QS_input','_QS_buttonAction','_QS_buttonCtrl'];
_type = _this # 0;
if (_type isEqualTo 'onLoad') exitWith {
	disableSerialization;
	_display = _this # 1;
	(_display displayCtrl 1001) ctrlSetText (localize 'STR_QS_Menu_014');
	(_display displayCtrl 1003) ctrlSetText (localize 'STR_QS_Menu_015');
	/*/Editbox/*/
	(_display displayCtrl 1004) ctrlSetText (missionProfileNamespace getVariable ['RscDebugConsole_expression','']);
	
	/*/B1/*/
	(_display displayCtrl 1005) ctrlEnable FALSE;
	(_display displayCtrl 1005) ctrlSetText (localize 'STR_QS_Menu_016');
	(_display displayCtrl 1005) ctrlSetToolTip (localize 'STR_QS_Menu_017');
	_QS_buttonCtrl = (_display displayCtrl 1005);
	_QS_buttonAction = '["B1"] call (missionNamespace getVariable "QS_fnc_clientMenuConsole");';
	_QS_buttonCtrl buttonSetAction _QS_buttonAction;
	
	/*/B2/*/
	(_display displayCtrl 1006) ctrlEnable FALSE;
	(_display displayCtrl 1006) ctrlSetText (localize 'STR_QS_Menu_018');
	(_display displayCtrl 1006) ctrlSetToolTip (localize 'STR_QS_Menu_019');
	_QS_buttonCtrl = (_display displayCtrl 1006);
	_QS_buttonAction = '["B2"] call (missionNamespace getVariable "QS_fnc_clientMenuConsole");';
	_QS_buttonCtrl buttonSetAction _QS_buttonAction;
	
	/*/B3/*/
	(_display displayCtrl 1007) ctrlSetText (localize 'STR_QS_Menu_020');
	(_display displayCtrl 1007) ctrlSetToolTip (localize 'STR_QS_Menu_021');
	_QS_buttonCtrl = (_display displayCtrl 1007);
	_QS_buttonAction = '["B3"] call (missionNamespace getVariable "QS_fnc_clientMenuConsole");';
	_QS_buttonCtrl buttonSetAction _QS_buttonAction;
	
	/*/B4/*/
	(_display displayCtrl 1008) ctrlSetText (localize 'STR_QS_Menu_022');
	(_display displayCtrl 1008) ctrlSetToolTip (localize 'STR_QS_Menu_023');
	_QS_buttonCtrl = (_display displayCtrl 1008);
	_QS_buttonAction = '["B4"] call (missionNamespace getVariable "QS_fnc_clientMenuConsole");';
	_QS_buttonCtrl buttonSetAction _QS_buttonAction; 
	
	/*/B5/*/
	(_display displayCtrl 1009) ctrlSetText (localize 'STR_QS_Menu_024');
	(_display displayCtrl 1009) ctrlSetToolTip (localize 'STR_QS_Menu_025');
	_QS_buttonCtrl = (_display displayCtrl 1009);
	_QS_buttonAction = '["B5"] call (missionNamespace getVariable "QS_fnc_clientMenuConsole");';
	_QS_buttonCtrl buttonSetAction _QS_buttonAction;
	
	/*/CB1/*/
	if (!isMultiplayer) then {(_display displayCtrl 1011) ctrlEnable FALSE;};
	(_display displayCtrl 1011) ctrlSetToolTip (localize 'STR_QS_Menu_026');
	(_display displayCtrl 1813) cbSetChecked FALSE;
	
	ctrlSetFocus (_display displayCtrl 1004);
};
if (_type isEqualTo 'onUnload') exitWith {
	disableSerialization;
	_QS_input = ctrlText ((findDisplay 15000) displayCtrl 1004);
	/*/missionProfileNamespace setVariable ['RscDebugConsole_expression',_QS_input];/*/
	/*/saveMissionProfileNamespace;/*/
	closeDialog 0;
};
if (_type in ['B1','B2','B3']) then {
	disableSerialization;
	_QS_input = ctrlText ((findDisplay 15000) displayCtrl 1004);
	missionProfileNamespace setVariable ['RscDebugConsole_expression',_QS_input];
	saveMissionProfileNamespace;
};
if (_type isEqualTo 'B1') exitWith {
	if (_QS_input isNotEqualTo '') then {
		//comment 'Exec on server';
		[22,[],_QS_input,0,player,(getPlayerUID player),profileName,profileNameSteam,clientOwner,2] remoteExec ['QS_fnc_remoteExec',2,FALSE];
	};
};
if (_type isEqualTo 'B2') exitWith {
	if (_QS_input isNotEqualTo '') then {
		//comment 'Exec on global';
		[22,[],_QS_input,0,player,(getPlayerUID player),profileName,profileNameSteam,clientOwner,0] remoteExec ['QS_fnc_remoteExec',2,FALSE];
	};
};
if (_type isEqualTo 'B3') exitWith {
	if (_QS_input isNotEqualTo '') then {
		//comment 'Exec local';
		[22,[],_QS_input,0,player,(getPlayerUID player),profileName,profileNameSteam,clientOwner,clientOwner] remoteExec ['QS_fnc_remoteExec',2,FALSE];
	};
};
if (_type isEqualTo 'B4') exitWith {
	[] spawn (missionNamespace getVariable 'BIS_fnc_help');
};
if (_type isEqualTo 'B5') exitWith {
	[] spawn (missionNamespace getVariable 'BIS_fnc_configViewer');
};
if (_type isEqualTo 'RxCheckbox') exitWith {
	disableSerialization;
	if ((_this # 2) isEqualTo 1) then {
		((findDisplay 15000) displayCtrl 1005) ctrlEnable TRUE;
		((findDisplay 15000) displayCtrl 1006) ctrlEnable TRUE;
	} else {
		if ((_this # 2) isEqualTo 0) then {
			((findDisplay 15000) displayCtrl 1005) ctrlEnable FALSE;
			((findDisplay 15000) displayCtrl 1006) ctrlEnable FALSE;
		};
	};
};