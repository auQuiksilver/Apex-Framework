/*/
File: fn_AIXVehicleUnstuck.sqf
Author:

	Quiksilver
	
Last modified:

	27/08/2018 A3 1.84 by Quiksilver
	
Description:

	Attempt to unstuck stuck vehicles
__________________________________________________/*/

params [
	['_vehicle',objNull],
	['_grp',grpNull],
	['_type','']
];
if (
	(isNull _vehicle) ||
	{(isNull _grp)} ||
	{(_vehicle getVariable ['QS_AI_V_disableStuckCheck',FALSE])}
) exitWith {};
if (_type isEqualTo '') then {
	_type = ['LAND','SHIP'] select (_vehicle isKindOf 'Ship');
};
if (_type isEqualTo 'LAND') exitWith {
	if (((vectorUp _vehicle) select 2) < 0.1) then {
		if (_vehicle isKindOf 'LandVehicle') then {
			private _toggleSimulation = FALSE;
			if (!simulationEnabled _vehicle) then {
				_toggleSimulation = TRUE;
				_vehicle enableDynamicSimulation FALSE;
				_vehicle enableSimulation TRUE;
			};
			_position = getPosATL _vehicle;
			_vehicle setPos [(random -100),(random -100),(random 100)];
			_vehicle setVectorUp (surfaceNormal _position);
			_vehicle setDamage (damage _vehicle);
			_vehicle setVehiclePosition [_position,[],0,'NONE'];
			if (_toggleSimulation) then {
				_vehicle enableDynamicSimulation TRUE;
			};
			_grp addVehicle _vehicle;
			(units _grp) allowGetIn TRUE;
			(units _grp) orderGetIn TRUE;
		};
	};
	if (alive (driver _vehicle)) then {
		if ((_vehicle getVariable ['QS_AI_V_stuckCheck',[]]) isEqualTo []) then {
			_vehicle setVariable ['QS_AI_V_stuckCheck',[diag_tickTime,(getPosATL _vehicle),-1],FALSE];
		} else {
			if (diag_tickTime > ((_vehicle getVariable ['QS_AI_V_stuckCheck',[-1,[0,0,0],-1]]) select 0)) then {
				if ((_vehicle distance2D ((_vehicle getVariable ['QS_AI_V_stuckCheck',[-1,[0,0,0],-1]]) select 1)) < 5) then {
					if (((_vehicle getVariable ['QS_AI_V_stuckCheck',[-1,[0,0,0],-1]]) select 2) > 2) then {
						if ((allPlayers inAreaArray [(getPosATL _vehicle),300,300,0,FALSE]) isEqualTo []) then {
							_vehicle setVariable ['QS_AI_V_stuckCheck',[(diag_tickTime + 30),(getPosATL _vehicle),-1],FALSE];
							_nearestRoad = [((_vehicle getVariable ['QS_AI_V_stuckCheck',[-1,[0,0,0],-1]]) select 1),125] call (missionNamespace getVariable 'QS_fnc_nearestRoad');
							if (!isNull _nearestRoad) then {
								_vehicle setVehiclePosition [_nearestRoad,[],0,'NONE'];
								_vehicle setDir (_nearestRoad getDir ((roadsConnectedTo _nearestRoad) select 0));
								if ((fuel _vehicle) isEqualTo 0) then {
									_vehicle setFuel 1;
								};
							} else {
								_vehicle setVehiclePosition [_vehicle,[],15,'NONE'];
							};
							_grp addVehicle _vehicle;
							(units _grp) allowGetIn TRUE;
							(units _grp) orderGetIn TRUE;
						};
					} else {
						_vehicle setVariable ['QS_AI_V_stuckCheck',[(diag_tickTime + 30),(getPosATL _vehicle),((((_vehicle getVariable ['QS_AI_V_stuckCheck',[-1,[0,0,0],-1]]) select 2) + 1) min 3)],FALSE];
					};
				} else {
					_vehicle setVariable ['QS_AI_V_stuckCheck',[(diag_tickTime + 30),(getPosATL _vehicle),((((_vehicle getVariable ['QS_AI_V_stuckCheck',[-1,[0,0,0],-1]]) select 2) - 1) max -1)],FALSE];
				};
			};
		};
	};
};
if (_type isEqualTo 'SHIP') exitWith {
	if (canMove _vehicle) then {
		if ((_vehicle getVariable ['QS_AI_V_stuckCheck',[]]) isEqualTo []) then {
			_vehicle setVariable ['QS_AI_V_stuckCheck',[diag_tickTime,(getPosASL _vehicle),-1],FALSE];
		} else {
			if (diag_tickTime > ((_vehicle getVariable ['QS_AI_V_stuckCheck',[-1,[0,0,0],-1]]) select 0)) then {
				if ((_vehicle distance2D ((_vehicle getVariable ['QS_AI_V_stuckCheck',[-1,[0,0,0],-1]]) select 1)) < 5) then {
					if (((_vehicle getVariable ['QS_AI_V_stuckCheck',[-1,[0,0,0],-1]]) select 2) > 2) then {
						if ((allPlayers inAreaArray [(getPosASL _vehicle),300,300,0,FALSE]) isEqualTo []) then {
							_vehicle setVariable ['QS_AI_V_stuckCheck',[(diag_tickTime + 30),(getPosASL _vehicle),-1],FALSE];
							if (!alive (driver _vehicle)) then {
								if (((units _grp) findIf {(alive _x)}) isNotEqualTo -1) then {
									(((units _grp) select {(alive _x)}) select 0) action ['moveToDriver',_vehicle];
								};
							};
							_vehicle spawn {
								for '_x' from 0 to 4 step 1 do {
									_this setVelocityModelSpace [0,-10,1];
									if (surfaceIsWater (_this getRelPos [25,0])) exitWith {};
									uiSleep 1;
								};
							};
						};
					} else {
						_vehicle setVariable ['QS_AI_V_stuckCheck',[(diag_tickTime + 30),(getPosASL _vehicle),((((_vehicle getVariable ['QS_AI_V_stuckCheck',[-1,[0,0,0],-1]]) select 2) + 1) min 3)],FALSE];
					};
				} else {
					_vehicle setVariable ['QS_AI_V_stuckCheck',[(diag_tickTime + 30),(getPosASL _vehicle),((((_vehicle getVariable ['QS_AI_V_stuckCheck',[-1,[0,0,0],-1]]) select 2) - 1) max -1)],FALSE];
				};
			};
		};
	};
};
if (_type isEqualTo 'HELI') exitWith {
	if ((_vehicle getHit 'tail_rotor_hit') > 0) then {
		_vehicle setHit ['tail_rotor_hit',0,TRUE];
	};
};