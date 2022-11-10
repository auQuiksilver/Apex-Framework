/*/
File: fn_localObjects.sqf
Author:

	Quiksilver
	
Last Modified:

	27/10/2022 A3 2.10 by Quiksilver
	
Description:

	Local Objects
_______________________________________________/*/

params ['_type'];
if (_type isEqualTo 'BASE') exitWith {
	if (!(missionNamespace getVariable ['QS_objects_local_base',FALSE])) then {
		missionNamespace setVariable ['QS_objects_local_base',TRUE,FALSE];
		0 spawn {
			_composition = call (compileScript ['code\config\QS_data_missionobjects.sqf']);
			private _array = [];
			private _entity = objNull;
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
					'_clientOnly',
					'_args',
					'_code'
				];
				if (_clientOnly isEqualTo 1) then {
					if (_simpleObject isNotEqualTo 0) then {
						_entity = createSimpleObject [([_type,_model] select (_simpleObject isEqualTo 2)),[-500,-500,0],TRUE];
						_entity setVectorDirAndUp _vectorDirAndUp;
						_entity setPosWorld _pos;
					};
					if (!isNull _entity) then {
						[_entity] call _code;
					};
				};
			} forEach _composition;
		};
	};
};