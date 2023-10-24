/*/
File: fn_vehicleAddSmokeEffect.sqf
Author:

	Quiksilver
	
Last modified:

	6/04/2023 A3 2.12 by Quiksilver
	
Description:

	Smoke Effect
____________________________________________________/*/

params ['_vehicle',['_mode',0],['_modelPos',[0,0,0]]];
if (_mode isEqualTo 0) exitWith {
	if (!isNull (_vehicle getVariable ['QS_effect_smoke',objNull])) then {
		_smoke = _vehicle getVariable ['QS_effect_smoke',objNull];
		deleteVehicle _smoke;
		if ((_vehicle getVariable ['QS_effect_smoke_event',-1]) isNotEqualTo -1) then {
			_vehicle removeEventHandler ['Deleted',(_vehicle getVariable ['QS_effect_smoke_event',-1])];
			_vehicle setVariable ['QS_effect_smoke_event',-1,FALSE];
		};
		if ((_vehicle getVariable ['QS_effect_smoke_event2',-1]) isNotEqualTo -1) then {
			_vehicle removeEventHandler ['Killed',(_vehicle getVariable ['QS_effect_smoke_event2',-1])];
			_vehicle setVariable ['QS_effect_smoke_event2',-1,FALSE];
		};
		_vehicle setVariable ['QS_effect_smoke',objNull,FALSE];
		QS_global_wreckSmokes = QS_global_wreckSmokes select {!isNull _x};
	};
};
if (_mode isEqualTo 1) exitWith {
	if (
		(isNull (_vehicle getVariable ['QS_effect_smoke',objNull]))
	) then {
		QS_global_wreckSmokes = QS_global_wreckSmokes select {!isNull _x};
		if ((count QS_global_wreckSmokes) > 10) then {
			deleteVehicle (QS_global_wreckSmokes # 0);
		};
		_smoke = createVehicle ['test_EmptyObjectForSmoke',[0,0,0]];
		[1,_smoke,[_vehicle,_modelPos]] call QS_fnc_eventAttach;
		_vehicle setVariable ['QS_effect_smoke',_smoke,TRUE];
		_event = _vehicle addEventHandler ['Deleted',{
			params ['_entity'];
			if (!isNull (_entity getVariable ['QS_effect_smoke',objNull])) then {
				deleteVehicle (_entity getVariable ['QS_effect_smoke',objNull]);
			};
		}];
		_event2 = _vehicle addEventHandler ['Killed',{
			params ['_entity'];
			if (!isNull (_entity getVariable ['QS_effect_smoke',objNull])) then {
				deleteVehicle (_entity getVariable ['QS_effect_smoke',objNull]);
			};
		}];
		_smoke setVariable ['attached',TRUE,TRUE];
		_vehicle setVariable ['QS_effect_smoke_event',_event,FALSE];
		_vehicle setVariable ['QS_effect_smoke_event2',_event2,FALSE];
		QS_global_wreckSmokes pushBack _smoke;
		QS_global_wreckSmokes = QS_global_wreckSmokes select {!isNull _x};
	};
};
