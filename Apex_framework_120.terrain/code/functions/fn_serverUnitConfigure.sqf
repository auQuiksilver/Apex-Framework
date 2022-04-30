/*
File: fn_serverUnitConfigure.sqf
Author:
	
	Quiksilver
	
Last Modified:
	
	22/07/2019 A3 1.94 by Quiksilver
	
Description:

	Recruitable Unit Config
________________________________________________*/

private ['_unit','_unitType','_grp'];
_unit = _this select 0;
_unitType = typeOf _unit;
_grp = group _unit;
_grp setBehaviour 'CARELESS';
[(units _grp),4] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
_unit enableStamina FALSE;
_unit addEventHandler ['HandleScore',{FALSE}];
_grp setVariable ['QS_HComm_grp',FALSE,TRUE];
_grp setVariable ['QS_GRP_HC',FALSE,FALSE];
_unit setVariable ['QS_RD_interactable',TRUE,TRUE];
_unit setVariable ['QS_RD_recruitable',TRUE,TRUE];
_unit setVariable ['QS_RD_recruited',FALSE,TRUE];
_unit setVariable ['QS_RD_dismissable',TRUE,TRUE];
_unit setVariable ['QS_GRP_HC',FALSE,FALSE];
_unit addPrimaryWeaponItem (selectRandom ['optic_erco_blk_f','optic_dms']);
if (_unit getUnitTrait 'medic') then {
	
};
if (_unit getUnitTrait 'engineer') then {

};
{
	_unit disableAI _x;
} count [
	'FSM',
	'TEAMSWITCH',
	'AIMINGERROR',
	'SUPPRESSION',
	'TARGET',
	'AUTOTARGET',
	'MOVE'
];
_unit addRating (0 - (rating player));
_unit addEventHandler [
	'Killed',
	{
		params ['_killed','_killer'];
		if ((_killed distance2D (markerPos 'QS_marker_base_marker')) < 500) then {
			missionNamespace setVariable [
				'QS_analytics_entities_deleted',
				((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),
				FALSE
			];
			deleteVehicle _killed;
		};
	}
];
TRUE;