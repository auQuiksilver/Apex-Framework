/*
File: fn_msgToStaff.sqf
Author: 

	Quiksilver

Last Modified:

	10/09/2016 A3 1.62 by Quiksilver

Description:

	Message To Staff
____________________________________________________________________________*/

if (!((getPlayerUID player) in (['ALL'] call (missionNamespace getVariable 'QS_fnc_whitelist')))) exitWith {};
private [
	'_array','_element1','_element2','_element3','_element4','_object'
];
_array = _this # 1;
_message = _array # 0;
_object = _array # 1;
_type = _array # 2;
systemChat str _message;
[str _message] call (missionNamespace getVariable 'QS_fnc_hint');
if (isNull _object) exitWith {};
if (_type isEqualTo 1) then {
	if (missionNamespace isNil 'QS_kiddieActions') then {
		missionNamespace setVariable ['QS_kiddieActions',[],FALSE];
	};
	QS_kiddieAction2 = player addAction [
		format ['(%2) %3 %1',(name _object),localize 'STR_QS_Utility_002',localize 'STR_QS_Interact_092'],
		(missionNamespace getVariable 'QS_fnc_actionEjectSuspect'),
		[_object,'KICK'],
		99
	];
	player setUserActionText [QS_kiddieAction2,((player actionParams QS_kiddieAction2) # 0),(format ["<t size='3'>%1</t>",((player actionParams QS_kiddieAction2) # 0)])];
	QS_kiddieAction3 = player addAction [
		format ['(%1) Manual enforcement (do nothing)',localize 'STR_QS_Utility_002',localize 'STR_QS_Interact_093'],
		{
			{player removeAction _x;} count (missionNamespace getVariable 'QS_kiddieActions');
			systemChat (localize 'STR_QS_Chat_143');
			(missionNamespace getVariable 'QS_managed_hints') pushBack [3,FALSE,5,-1,localize 'STR_QS_Hints_126',[],-1];
		},
		[],
		98
	];
	player setUserActionText [QS_kiddieAction3,((player actionParams QS_kiddieAction3) # 0),(format ["<t size='3'>%1</t>",((player actionParams QS_kiddieAction3) # 0)])];
	/*/0 = QS_kiddieActions pushBack QS_kiddieAction1;/*/
	0 = QS_kiddieActions pushBack QS_kiddieAction2;
	0 = QS_kiddieActions pushBack QS_kiddieAction3;
};