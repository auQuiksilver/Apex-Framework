/*/
File: fn_taskPatrol.sqf
Author:

	Quiksilver
	
Last modified:

	17/10/2017 A3 1.76 by Quiksilver
	
Description:

	AI Patrol
__________________________________________________/*/

params ['_grp','_pos','_maxDist',['_QS_new',FALSE]];
private [
	'_grpBehaviour','_grpWPFormations','_grpWPSpeed','_grpWPType','_grpWPCombatMode','_prevPos','_wp','_newPos','_n',
	'_combatModes','_foundPos','_behaviours','_patrolRoute','_QS_new','_grpVehicle','_isWaterPatrol','_exit','_waterMode'
];
_isWaterPatrol = FALSE;
_waterMode = 0;
_grpVehicle = objectParent (leader _grp);
if (!isNil '_grpvehicle') then {
	if (_grpVehicle isKindOf 'Ship') then {
		_isWaterPatrol = TRUE;
		_waterMode = 2;
	} else {
		if (['wet',(uniform ((units _grp) select 0)),FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) then {
			_isWaterPatrol = TRUE;
			_waterMode = 2;
		};
	};
};
_grp setBehaviour 'SAFE';
_grp enableAttack TRUE;
{
	_x enableStamina FALSE;
	_x enableFatigue FALSE;
} count (units _grp);
_prevPos = _pos;
if (!(_prevPos isEqualType [])) exitWith {diag_log '***** DEBUG ***** fn_taskPatrol ***** pos is not a valid type *****';};
if (!((count _prevPos) >= 2)) exitWith {diag_log '***** DEBUG ***** fn_taskPatrol ***** pos does not have enough values *****';};
_combatModes = ['WHITE','YELLOW','RED'];
_behaviours = ['SAFE','AWARE','COMBAT'];
_patrolRoute = [_pos];
_exit = FALSE;
for '_x' from 0 to (2 + (floor (random 2))) step 1 do {
	for '_x' from 0 to 99 step 1 do {
		_newPos = [_prevPos,50,_maxDist,0.1,_waterMode,0.75,0] call (missionNamespace getVariable 'QS_fnc_findSafePos');
		if ((_newPos distance2D _prevPos) < (_maxDist + 100)) then {
			if (_isWaterPatrol) then {
				if (surfaceIsWater _newPos) then {
					if ((getTerrainHeightASL _newPos) < -5) then {
						_exit = TRUE;
					};
				};
			} else {
				if (!(surfaceIsWater _newPos)) then {
					_exit = TRUE;
				};			
			};
		};
		if (_exit) exitWith {};
	};
	_prevPos = _newPos;
	if (_QS_new) then {
		_newPos set [2,((_newPos select 2) + 1)];
		_patrolRoute pushBack _newPos;
	} else {
		if ((random 1) > 0.2) then {
			_grpBehaviour = 'SAFE';
		} else {
			_grpBehaviour = selectRandom _behaviours;
		};
		_grpWPFormations = selectRandom (['STAG COLUMN','WEDGE','ECH LEFT','ECH RIGHT','VEE','LINE','FILE','DIAMOND']);
		_grpWPSpeed = 'LIMITED';
		_grpWPType = 'MOVE';
		_grpWPCombatMode = selectRandom _combatModes;
		if (surfaceIsWater _newPos) then {
		
		} else {
			_newPos set [2,((_newPos select 2) + 1)];
		};
		[
			_grp,
			_newPos,
			30,
			_grpWPType,
			_grpBehaviour,
			_grpWPCombatMode,
			_grpWPFormations,
			_grpWPSpeed,
			(10 + (random 50)),
			objNull,
			[],
			[],
			'',
			'',
			'',
			FALSE,
			FALSE,
			FALSE
		] call (missionNamespace getVariable 'QS_fnc_taskSetSingleWaypoint');
	};
};
if (_QS_new) then {
	_grp setVariable ['QS_AI_GRP_TASK',['PATROL',_patrolRoute,-1,-1],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
	_grp setVariable ['QS_AI_GRP_PATROLINDEX',0,(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
} else {
	if (surfaceIsWater _pos) then {

	} else {
		_pos set [2,((_pos select 2) + 1.5)];
	};
	[
		_grp,
		_pos,
		30,
		'CYCLE',
		'UNCHANGED',
		'UNCHANGED',
		'UNCHANGED',
		'UNCHANGED',
		(10 + (random 50)),
		objNull,
		[],
		[],
		'',
		'',
		'',
		FALSE,
		FALSE,
		FALSE
	] call (missionNamespace getVariable 'QS_fnc_taskSetSingleWaypoint');
};
TRUE;