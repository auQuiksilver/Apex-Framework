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
_array = _this select 1;
_message = _array select 0;
_object = _array select 1;
_type = _array select 2;
systemChat str _message;
[str _message] call (missionNamespace getVariable 'QS_fnc_hint');
if (isNull _object) exitWith {};
if (_type isEqualTo 1) then {
	if (isNil {missionNamespace getVariable 'QS_kiddieActions'}) then {
		missionNamespace setVariable ['QS_kiddieActions',[],FALSE];
	};
	QS_kiddieAction2 = player addAction [
		format ['(ROBOCOP) Kick %1',(name _object)],
		(missionNamespace getVariable 'QS_fnc_actionEjectSuspect'),
		[_object,'KICK'],
		99
	];
	player setUserActionText [QS_kiddieAction2,((player actionParams QS_kiddieAction2) select 0),(format ["<t size='3'>%1</t>",((player actionParams QS_kiddieAction2) select 0)])];
	QS_kiddieAction3 = player addAction [
		'(ROBOCOP) Manual enforcement (do nothing)',
		{
			{player removeAction _x;} count (missionNamespace getVariable 'QS_kiddieActions');
			systemChat 'No action taken.';
			(missionNamespace getVariable 'QS_managed_hints') pushBack [3,FALSE,5,-1,'No action taken.',[],-1];
		},
		[],
		98
	];
	player setUserActionText [QS_kiddieAction3,((player actionParams QS_kiddieAction3) select 0),(format ["<t size='3'>%1</t>",((player actionParams QS_kiddieAction3) select 0)])];
	/*/0 = QS_kiddieActions pushBack QS_kiddieAction1;/*/
	0 = QS_kiddieActions pushBack QS_kiddieAction2;
	0 = QS_kiddieActions pushBack QS_kiddieAction3;
};