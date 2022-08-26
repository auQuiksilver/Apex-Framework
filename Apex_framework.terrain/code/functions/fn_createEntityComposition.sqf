/*/
File: fn_createEntityComposition.sqf
Author:

	Quiksilver
	
Last modified:

	9/06/2019 A3 1.94 by Quiksilver
	
Description:

	Create World Composition
____________________________________________________/*/

params ['_composition'];
private _return = [];
{
	_entity = objNull;
	_array = _x;
	_array params [
		'_type',
		'_model',
		'_pos',
		'_vectorDirAndUp',
		'_damageAllowed',
		'_simulationEnabled',
		'_simpleObject',
		'_args',
		'_code'
	];
	if (_simpleObject isNotEqualTo 0) then {
		_entity = createSimpleObject [([_type,_model] select (_simpleObject isEqualTo 2)),[-500,-500,0]];
		_entity setVectorDirAndUp _vectorDirAndUp;
		_entity setPosWorld _pos;
	} else {
		_entity = createVehicle [_type,[-500,-500,0],[],0,'CAN_COLLIDE'];
		if (_simulationEnabled isEqualTo 1) then {
			if (!(simulationEnabled _entity)) then {
				_entity enableSimulationGlobal TRUE;
			};
		} else {
			if (simulationEnabled _entity) then {
				_entity enableSimulationGlobal FALSE;
			};
		};
		if (_damageAllowed isEqualTo 1) then {
			if (!(isDamageAllowed _entity)) then {
				_entity allowDamage TRUE;
			};
		} else {
			if (isDamageAllowed _entity) then {
				_entity allowDamage FALSE;
			};
		};
		_entity setPosWorld _pos;
		_entity setVectorDirAndUp _vectorDirAndUp;
	};
	if (!isNull _entity) then {
		[_entity] call _code;
	};
	_return pushBack _entity;
} forEach _composition;
_return;