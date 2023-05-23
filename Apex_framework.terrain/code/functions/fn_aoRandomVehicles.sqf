/*/
File: fn_aoRandomVehicles.sqf
Author: 

	Quiksilver

Last Modified:

	20/08/2022 A3 2.10 by Quiksilver

Description:

	Spawn a few random vehicles in the AO
____________________________________________________________________________/*/

_centerPos = missionNamespace getVariable 'QS_AOpos';
_centerRadius = missionNamespace getVariable 'QS_aoSize';
private _spawnPosition = [0,0,0];
private _vehicle = objNull;
private _vehicleType = '';
private _vehicleTypesWeighted = ['classic_aorandomvehicles_1'] call QS_data_listVehicles;
private _max = 3;
private _count = 0;
_registeredPositions = missionNamespace getVariable ['QS_registeredPositions',[[0,0,0]]];
for '_i' from 0 to 14 step 1 do {
	_vehicleType = selectRandomWeighted _vehicleTypesWeighted;
	_spawnPosition = ['RADIUS',_centerPos,_centerRadius,'LAND',[],TRUE,[],[0,30,_vehicleType],FALSE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
	if ((_registeredPositions inAreaArray [_spawnPosition,30,30,0,FALSE]) isEqualTo []) then {
		if (((_spawnPosition select [0,2]) nearRoads 15) isEqualTo []) then {
			_count = _count + 1;
			_spawnPosition set [2,0];
			_vehicle = createSimpleObject [QS_core_vehicles_map getOrDefault [toLowerANSI _vehicleType,_vehicleType],ATLToASL _spawnPosition];
			_vehicle setDir (random 360);
			_vehicle setVectorUp (surfaceNormal _spawnPosition);
			_vehicle setVariable ['QS_vehicle_prop',TRUE,TRUE];
			_vehicle setVariable ['QS_vehicle_easterEgg',TRUE,TRUE];
			(missionNamespace getVariable 'QS_ao_civVehicles') pushBack _vehicle;
		};
	};
	if (_count >= _max) exitWith {};
};