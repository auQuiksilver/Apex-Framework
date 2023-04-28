/*
File: fn_serverUnitConfigure.sqf
Author:
	
	Quiksilver
	
Last Modified:
	
	3/11/2022 A3 2.10 by Quiksilver
	
Description:

	Recruitable Unit Config
________________________________________________*/

params ['_unit'];
_unitType = typeOf _unit;
_grp = group _unit;
_grp setBehaviour 'CARELESS';
[(units _grp),4] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
_unit enableStamina FALSE;
_unit addEventHandler ['HandleScore',{FALSE}];
_grp setVariable ['QS_HComm_grp',FALSE,TRUE];
{
	_unit setVariable _x;
} forEach [
	['QS_RD_spawnPos',getPosASL _unit,TRUE],
	['QS_RD_interactable',TRUE,TRUE],
	['QS_RD_recruitable',TRUE,TRUE],
	['QS_RD_recruited',FALSE,TRUE],
	['QS_RD_dismissable',TRUE,TRUE]
];
_unit addPrimaryWeaponItem (selectRandom ['optic_erco_blk_f','optic_dms']);
[_unit,_grp] call (missionNamespace getVariable 'QS_fnc_AISetTracers');
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
			missionNamespace setVariable ['QS_analytics_entities_deleted',((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),FALSE];
			deleteVehicle _killed;
		};
	}
];
TRUE;