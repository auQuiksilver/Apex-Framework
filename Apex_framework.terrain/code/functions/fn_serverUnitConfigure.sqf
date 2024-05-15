/*
File: fn_serverUnitConfigure.sqf
Author:
	
	Quiksilver
	
Last Modified:
	
	26/05/2023 A3 2.12 by Quiksilver
	
Description:

	Recruitable Unit Config
________________________________________________*/

params [['_unit',objNull],['_recruitable',TRUE]];
if (!alive _unit) exitwith {};
_unitType = typeOf _unit;
_grp = group _unit;
[(units _grp),4] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
_unit enableStamina FALSE;
_unit enableFatigue FALSE;
_unit addEventHandler ['HandleScore',{FALSE}];
_grp setVariable ['QS_HComm_grp',FALSE,TRUE];
_unit setVariable ['QS_RD_spawnPos',getPosASL _unit,TRUE];
if (_recruitable) then {
	_grp setBehaviour 'CARELESS';
	{
		_unit setVariable _x;
	} forEach [
		['QS_RD_interactable',TRUE,TRUE],
		['QS_RD_recruitable',TRUE,TRUE],
		['QS_RD_recruited',FALSE,TRUE],
		['QS_RD_dismissable',TRUE,TRUE]
	];
	{
		_unit enableAIFeature [_x,FALSE];
	} forEach [
		'FSM',
		'TEAMSWITCH',
		'AIMINGERROR',
		'SUPPRESSION',
		'TARGET',
		'AUTOTARGET',
		'MOVE'
	];
} else {
	_unit setVariable ['QS_lockedInventory',TRUE,TRUE];
	_grp setBehaviour 'AWARE';
	_grp setCombatMode 'RED';
	// To Do: Improve this
	{
		_unit enableAIFeature [_x,FALSE];
	} forEach [
		'AIMINGERROR',
		'SUPPRESSION',
		'PATH'
	];
};
_unit call QS_fnc_unitSetup;
[_unit,_grp] call (missionNamespace getVariable 'QS_fnc_AISetTracers');
if (_unit getUnitTrait 'medic') then {
	_unit setVariable ['QS_unit_role','medic',TRUE];
	_unit setVariable ['QS_ST_customDN',localize 'STR_QS_Text_376',TRUE];
};
_unit setName ['AI','AI','AI'];
_unit addRating (0 - (rating _unit));
_unit addEventHandler [
	'Killed',
	{
		params ['_killed','_killer'];
		if ((_killed distance2D (markerPos 'QS_marker_base_marker')) < 500) then {
			deleteVehicle _killed;
		};
	}
];
TRUE;