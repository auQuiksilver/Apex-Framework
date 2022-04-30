/*
File: fn_searchNearbyBuilding.sqf
Author:

	Quiksilver
	
Last Modified:

	11/05/2017 A3 1.70 by Quiksilver
	
Description:

	search a building
	
	https://community.bistudio.com/wiki/moveTo
	https://community.bistudio.com/wiki/moveToCompleted
	https://community.bistudio.com/wiki/moveToFailed
	https://community.bistudio.com/wiki/Category:Command_Group:_Unit_Control

	This function needs a bit of work, dont necessarily want to have it be a "guns up" search or at fast pace.
_______________________________________________________________*/
private [
	'_grp','_leader','_behaviour','_array','_building','_indices','_count','_gunits','_t','_buildingExits','_buildingExit',
	'_startPos','_stamina','_attackEnabled','_size'
];
_grp = _this select 0;
_grp lockWP TRUE;
_leader = leader _grp;
_startPos = getPos _leader;
_behaviour = behaviour _leader;
_grp setBehaviour 'AWARE';
_stamina = isStaminaEnabled _leader;
_attackEnabled = attackEnabled _grp;
if (attackEnabled _grp) then {
	_grp enableAttack FALSE;
};
private _unit = objNull;
{
	_unit = _x;
	{
		_unit forgetTarget _x;
	} forEach (_unit targets [TRUE,0]);
	_unit disableAI 'AUTOCOMBAT';
	_unit disableAI 'COVER';
	_unit disableAI 'SUPPRESSION';
	_unit disableAI 'TARGET';
	_unit forceSpeed 24;
	_unit setAnimSpeedCoef 1.2;
	_unit enableStamina FALSE;
	_unit enableFatigue FALSE;
} count (units _grp);
if ((count _this) > 1) then {
	_array = _this select 1;
} else {
	_array = [_leader,100] call (missionNamespace getVariable 'QS_fnc_getNearestBuilding');
};
if (_array isEqualTo []) exitWith {};
_building = _array select 0;
_indices = _array select 1;
_grp setFormDir (_leader getDir _building);
if ((_leader distance _building) > 500) exitWith {
	_grp lockWP FALSE;
};
_buildingExits = [];
_index = 0;
for '_x' from 0 to 12 step 1 do {
	_buildingExit = _building buildingExit _index;
	if (!(_buildingExit isEqualTo [0,0,0])) then {
		_buildingExits pushBack _buildingExit;
	};
	_index = _index + 1;
};
doStop _leader;
_leader commandMove (selectRandom _buildingExits);
{
	if (!(_x isEqualTo _leader)) then {
		_x commandMove (selectRandom (_building buildingPos -1));
	};
} forEach (units _grp);
_size = sizeOf (typeOf _building);
_duration = diag_tickTime + 300;
for '_x' from 0 to 1 step 0 do {
	if (diag_tickTime > _duration) exitWith {};
	_aliveUnits = [];
	{
		_unit = _x;
		if ((random 1) > 0.75) then {
			if (((vectorMagnitude (velocity _unit)) * 3.6) < 1) then {
				{
					_unit forgetTarget _x;
				} forEach (_unit targets [TRUE,0]);
			};
		};
		if (alive _unit) then {
			if ((({(alive _x)} count (units (group _x))) > 1) && (!(_unit isEqualTo (leader (group _unit))))) then {
				_aliveUnits pushBack _unit;
			} else {
				if (({(alive _x)} count (units (group _unit))) < 2) then {
					_aliveUnits pushBack _unit;
				};
			};
		};
	} forEach (units _grp);
	if (_aliveUnits isEqualTo []) exitWith {};
	
	{
		if (((unitReady _x) && ((_x distance2D _building) < _size)) || {(weaponLowered _x)} || {(moveToCompleted _x)} || {(moveToFailed _x)}) then {
			doStop _x;
			_x doMove (_building buildingPos _indices);
			_indices = _indices - 1;
		};
		if (_indices < 0) exitWith {};
	} forEach _aliveUnits;
	if (_indices < 0) exitWith {};
	uiSleep 10;
};
_leader = leader _grp;
{
	if (alive _x) then {
		resetSubgroupDirection _x;
		doStop _x;
		_x enableAI 'COVER';
		_x enableAI 'SUPPRESSION';
		_x enableAI 'TARGET';
		_x forceSpeed -1;
		_x commandFollow _leader;
		_x setAnimSpeedCoef 1;
		_x enableStamina _stamina;
	};
} forEach (units _grp);
doStop _leader;
_leader commandMove _startPos;
_grp setFormDir (_leader getDir _building);
_grp setBehaviour _behaviour;
_grp enableAttack _attackEnabled;
_grp lockWP FALSE;