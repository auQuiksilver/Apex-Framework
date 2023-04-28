/*
File: fn_easterEggs.sqf
Author:
	
	Quiksilver
	
Last Modified:

	10/04/2018 A3 1.82 by Quiksilver
	
Description:

	Easter eggs
_____________________________________________________*/

private [
	'_vtypes','_vtype','_pos','_airEggs','_flatPos','_accepted','_spawnPos','_easterEgg','_airEgg1','_airEgg2','_airEgg3','_airEgg4','_world','_airPosArray',
	'_baseMarker'
];
_vtypes = ['easter_eggs_1'] call QS_data_listVehicles;
if (!(missionNamespace getVariable ['QS_armedAirEnabled',TRUE])) then {
	_vtypes = ['easter_eggs_2'] call QS_data_listVehicles;
};
_baseMarker = markerPos 'QS_marker_base_marker';
_world = worldName;
for '_x' from 0 to 3 step 1 do {
	_vtype = selectRandom _vtypes;
	for '_x' from 0 to 29 step 1 do {
		_spawnPos = ['WORLD',-1,-1,'LAND',[],TRUE,[],[],TRUE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
		if (((_spawnPos select [0,2]) nearRoads 30) isEqualTo []) exitWith {};
	};
	_spawnPos set [2,0];
	_easterEgg = createSimpleObject [QS_core_vehicles_map getOrDefault [toLowerANSI _vtype,_vtype],(ATLToASL _spawnPos)];
	_easterEgg setDir (random 360);
	_easterEgg setVectorUp (surfaceNormal _spawnPos);
	for '_x' from 0 to 2 step 1 do {
		_easterEgg setVariable ['QS_vehicle_prop',TRUE,TRUE];
		_easterEgg setVariable ['QS_vehicle_easterEgg',TRUE,TRUE];
	};
};