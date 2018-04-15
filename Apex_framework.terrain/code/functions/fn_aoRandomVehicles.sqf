/*/
File: fn_aoRandomVehicles.sqf
Author: 

	Quiksilver

Last Modified:

	2/10/2017 A3 1.76 by Quiksilver

Description:

	Spawn a few random vehicles in the AO
____________________________________________________________________________/*/

_centerPos = missionNamespace getVariable 'QS_AOpos';
_centerRadius = missionNamespace getVariable 'QS_aoSize';
private _spawnPosition = [0,0,0];
private _vehicle = objNull;
private _vehicleType = '';
private _vehicleTypesWeighted = [
	'C_Hatchback_01_F',0.1,
	'C_Offroad_02_unarmed_F',0.5,
	//'C_Offroad_01_F',0.3,			// bugged by Bohemia, spawns floating above ground. we could do a workaround but, meh ... Re-enable once they fix it
	'C_SUV_01_F',0.1,
	'C_Van_01_transport_F',0.3,
	'C_Van_02_transport_F',0.3,
	'C_Truck_02_transport_F',0.2,
	'C_Truck_02_covered_F',0.2,
	'B_G_Offroad_01_armed_F',0.4,
	'B_G_Offroad_01_F',0.3,
	'B_G_Van_02_transport_F',0.3,
	//'B_G_Offroad_01_AT_F',0.3,		// bugged by Bohemia, spawns floating above ground. we could do a workaround but, meh ... Re-enable once they fix it
	'I_C_Offroad_02_LMG_F',0.3,
	'I_C_Offroad_02_AT_F',0.3
];
for '_x' from 0 to 2 step 1 do {
	_spawnPosition = ['RADIUS',_centerPos,_centerRadius,'LAND',[],TRUE,[],[],FALSE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
	if ((_spawnPosition distance2D _centerPos) <= _centerRadius) then {
		if (((_spawnPosition select [0,2]) nearRoads 15) isEqualTo []) then {
			_spawnPosition set [2,0];
			_vehicle = createSimpleObject [(selectRandomWeighted _vehicleTypesWeighted),(ATLToASL _spawnPosition)];
			missionNamespace setVariable ['QS_analytics_entities_created',((missionNamespace getVariable 'QS_analytics_entities_created') + 1),FALSE];
			_vehicle setDir (random 360);
			_vehicle setVectorUp (surfaceNormal _spawnPosition);
			_vehicle setVariable ['QS_vehicle_prop',TRUE,TRUE];
			_vehicle setVariable ['QS_vehicle_easterEgg',TRUE,TRUE];
			(missionNamespace getVariable 'QS_ao_civVehicles') pushBack _vehicle;
		};
	};
};