/*
File: fn_searchNearbyBuilding.sqf
Author:

	Quiksilver
	
Last Modified:

	28/05/2022 A3 2.10 by Quiksilver
	
Description:

	search a building
	
	https://community.bistudio.com/wiki/moveTo
	https://community.bistudio.com/wiki/moveToCompleted
	https://community.bistudio.com/wiki/moveToFailed
	https://community.bistudio.com/wiki/Category:Command_Group:_Unit_Control

	This function needs a bit of work, dont necessarily want to have it be a "guns up" search or at fast pace.
	
	_QS_script = [_grp,[_targetBuilding,(count (_targetBuilding buildingPos -1))]] spawn (missionNamespace getVariable 'QS_fnc_searchNearbyBuilding');
_______________________________________________________________*/

params [
	['_grp',grpNull],
	['_buildingData',[objNull,0]],
	['_timeout',180],
	['_AISystem',TRUE]
];
_buildingData params [
	['_building',objNull],
	['_buildingPositionsCount',0]
];
if (isNull _building) then {
	_buildingData = [_leader,100] call (missionNamespace getVariable 'QS_fnc_getNearestBuilding');
	_buildingData params [
		['_building',objNull],
		['_buildingPositionsCount',0]
	];
};
if (
	(isNull _building) || 
	{(_buildingPositionsCount isEqualTo 0)}
) exitWith {};
private _buildingPositions = [_building,_building buildingPos -1] call (missionNamespace getVariable 'QS_fnc_customBuildingPositions');
_buildingPositionsCount = count _buildingPositions;
private _leader = leader _grp;
private _startPos = getPosATL _leader;
private _behaviour = behaviour _leader;
_grp setBehaviour 'AWARE';
_grp setFormation 'DIAMOND';
private _attackEnabled = attackEnabled _grp;
if (_attackEnabled) then {
	_grp enableAttack FALSE;
};
private _unit = objNull;
{
	_unit = _x;
	{
		_grp forgetTarget _x;
		_unit forgetTarget _x;
	} forEach (_unit targets [TRUE,0]);
	{
		_unit enableAIFeature [_x,FALSE];
	} forEach ['COVER','SUPPRESSION'];
	_unit forceSpeed 24;
	_unit setAnimSpeedCoef 1.2;
	_unit enableStamina FALSE;
	_unit enableFatigue FALSE;
} count (units _grp);
_grp move (getPosATL _building);
_grp setFormDir (_leader getDir _building);
doStop (units _grp);
uiSleep 0.1;
(units _grp) doMove (selectRandom _buildingPositions);
private _size = (sizeOf (typeOf _building)) * 2;
_duration = diag_tickTime + _timeout;
for '_x' from 0 to 1 step 0 do {
	if (
		(diag_tickTime > _duration) ||
		{(!alive _building)} ||
		{(_AISystem && {(!(_building in (missionNamespace getVariable ['QS_AI_hostileBuildings',[]])))})}
	) exitWith {};
	_aliveUnits = [];
	{
		_unit = _x;
		if (alive _unit) then {
			if ((({((lifeState _x) in ['HEALTHY','INJURED'])} count (units (group _x))) > 1) && (_unit isNotEqualTo (leader (group _unit)))) then {
				_aliveUnits pushBack _unit;
			} else {
				if (({((lifeState _x) in ['HEALTHY','INJURED'])} count (units (group _unit))) < 2) then {
					_aliveUnits pushBack _unit;
				};
			};
		};
	} forEach (units _grp);
	if (_aliveUnits isEqualTo []) exitWith {};
	_leader = leader _grp;
	{
		_unit = _x;
		if ((_unit distance2D _building) > _size) then {
			if (alive (getAttackTarget _unit)) then {
				_unit forgetTarget (getAttackTarget _unit);
			};
			doStop _unit;
			sleep 0.01;
			_unit doMove (selectRandom _buildingPositions);
		} else {
			if (unitReady _unit) then {
				doStop _unit;
				sleep 0.01;
				if ((random 1) > 0.5) then {
					_unit doMove (_buildingPositions # _buildingPositionsCount);
					if ((_unit distance2D _building) < _size) then {
						_buildingPositionsCount = _buildingPositionsCount - 1;
					};
				} else {
					_unit doMove (selectRandom _buildingPositions);
				};
			};
			if (_buildingPositionsCount < 0) exitWith {};
		};
	} forEach _aliveUnits;
	if (_buildingPositionsCount < 0) exitWith {};
	uiSleep 10;
};
_leader = leader _grp;
{
	if (alive _x) then {
		resetSubgroupDirection _x;
		doStop _x;
		_x enableAIFeature ['COVER',TRUE];
		_x enableAIFeature ['SUPPRESSION',TRUE];
		_x forceSpeed -1;
		_x doFollow _leader;
		_x setAnimSpeedCoef 1;
	};
} forEach (units _grp);
doStop _leader;
_leader doMove _startPos;
_grp setFormDir (_leader getDir _building);
_grp setBehaviour _behaviour;
_grp enableAttack _attackEnabled;