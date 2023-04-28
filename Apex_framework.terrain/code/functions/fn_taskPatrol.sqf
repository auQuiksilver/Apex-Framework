/*/
File: fn_taskPatrol.sqf
Author:

	Quiksilver
	
Last modified:

	22/08/2022 A3 1.76 by Quiksilver
	
Description:

	AI Patrol
__________________________________________________/*/

params ['_grp','_pos','_maxDist',['_QS_new',FALSE]];
private _isWaterPatrol = FALSE;
private _waterMode = 0;
private _grpVehicle = objectParent (leader _grp);
if (!isNil '_grpvehicle') then {
	if (_grpVehicle isKindOf 'Ship') then {
		_isWaterPatrol = TRUE;
		_waterMode = 2;
	} else {
		if (['wet',(uniform ((units _grp) # 0)),FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) then {
			_isWaterPatrol = TRUE;
			_waterMode = 2;
		};
	};
};
//_grp enableAttack TRUE;
{
	_x enableStamina FALSE;
	_x enableFatigue FALSE;
} count (units _grp);
private _prevPos = _pos;
if (!(_prevPos isEqualType [])) exitWith {diag_log '***** DEBUG ***** fn_taskPatrol ***** pos is not a valid type *****';};
if (!((count _prevPos) >= 2)) exitWith {diag_log '***** DEBUG ***** fn_taskPatrol ***** pos does not have enough values *****';};
private _combatModes = ['WHITE','YELLOW','RED'];
private _behaviours = ['SAFE','AWARE','COMBAT'];
private _grpBehaviour = 'SAFE';
private _patrolRoute = [_pos];
private _exit = FALSE;
private _grpWPFormations = selectRandom (['STAG COLUMN','WEDGE','ECH LEFT','ECH RIGHT','VEE','LINE','FILE','DIAMOND']);
private _grpWPSpeed = 'LIMITED';
private _grpWPType = 'MOVE';
private _grpWPCombatMode = selectRandom _combatModes;
private _newPos = _pos;
for '_x' from 0 to (2 + (selectRandom [1,2])) step 1 do {
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
		_newPos = _newPos vectorAdd [0,0,1];
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
			_newPos = _newPos vectorAdd [0,0,1];
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
	_grp setVariable ['QS_AI_GRP_TASK',['PATROL',_patrolRoute,-1,-1],QS_system_AI_owners];
	_grp setVariable ['QS_AI_GRP_PATROLINDEX',0,QS_system_AI_owners];
} else {
	if (surfaceIsWater _pos) then {

	} else {
		_pos = _pos vectorAdd [0,0,1.5];
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