/*
File: fn_serverUnitConfigure.sqf
Author:
	
	Quiksilver
	
Last Modified:
	
	13/10/2015 ArmA 3 1.52
	
Description:

	Recruitable Unit Config
________________________________________________*/

private ['_unit','_unitType','_grp'];
_unit = _this select 0;
_unitType = typeOf _unit;
_grp = group _unit;
_grp setBehaviour 'CARELESS';
_grp setVariable ['QS_RD_group_noHC',TRUE,FALSE];
[(units _grp),4] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
_unit enableStamina FALSE;
_unit addEventHandler ['HandleScore',{FALSE}];
for '_x' from 0 to 2 step 1 do {
	_unit setVariable ['QS_RD_interactable',TRUE,TRUE];
	_unit setVariable ['QS_RD_interacted',FALSE,TRUE];
	_unit setVariable ['QS_RD_recruitable',TRUE,TRUE];
	_unit setVariable ['QS_RD_recruited',FALSE,TRUE];
	_unit setVariable ['QS_RD_dismissable',TRUE,TRUE];
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

/*/
_unit addEventHandler [
	'HandleDamage',
	{
		params ['_unit','_selectionName','_damage','_source','_projectile','_hitPartIndex','_instigator'];
		if (isBurning _unit) exitWith {_damage};
		private ['_scale','_oldDamage'];
		if (!(_selectionName isEqualTo '?')) then {
			_oldDamage = if (_selectionName isEqualTo '') then [{damage _unit},{_unit getHit _selectionName}];
			_damage = ((_damage - _oldDamage) * 0.5) + _oldDamage;
		};
		if (!((vehicle _unit) isKindOf 'Man')) exitWith {_damage};
		if (_damage > 0.97) exitWith {
			if (!((lifeState _unit) isEqualTo 'INCAPACITATED')) then {
				_unit allowDamage FALSE;
				_unit setUnconscious TRUE;
			};
			_damage;
		};
		_damage;
	}
];
/*/
TRUE;