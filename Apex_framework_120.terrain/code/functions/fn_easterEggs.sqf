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
if (worldName in ['Tanoa','Lingor3']) then {
	_vtypes = [
		'B_Heli_Light_01_dynamicLoadout_F','C_Heli_Light_01_civil_F','O_Heli_Transport_04_F',
		'O_Heli_Attack_02_black_F','O_Heli_Light_02_dynamicLoadout_F','O_Heli_Light_02_unarmed_F',
		'i_e_heli_light_03_dynamicloadout_f','I_Heli_light_03_unarmed_F','I_APC_Wheeled_03_cannon_F','I_APC_tracked_03_cannon_F',
		'B_APC_Tracked_01_AA_F','B_MBT_01_cannon_F','I_MBT_03_cannon_F','O_T_APC_Wheeled_02_rcws_v2_ghex_F','I_LT_01_AT_F','I_LT_01_scout_F','I_LT_01_cannon_F','I_LT_01_AA_F',
		'O_T_MBT_04_cannon_F','C_Tractor_01_F'
	];
	if (!(missionNamespace getVariable ['QS_armedAirEnabled',TRUE])) then {
		_vtypes = [
			'C_Heli_Light_01_civil_F','O_Heli_Transport_04_F',
			'O_Heli_Light_02_unarmed_F','I_Heli_light_03_unarmed_F','I_APC_Wheeled_03_cannon_F','I_APC_tracked_03_cannon_F',
			'B_APC_Tracked_01_AA_F','B_MBT_01_cannon_F','I_MBT_03_cannon_F','O_T_APC_Wheeled_02_rcws_v2_ghex_F','I_LT_01_AT_F','I_LT_01_scout_F','I_LT_01_cannon_F','I_LT_01_AA_F',
			'O_T_MBT_04_cannon_F','C_Tractor_01_F'
		];
	};
} else {
	_vtypes = [
		'B_Heli_Light_01_dynamicLoadout_F','C_Heli_Light_01_civil_F','O_Heli_Transport_04_F','B_Heli_Attack_01_dynamicLoadout_F',
		'O_Heli_Attack_02_black_F','O_Heli_Light_02_dynamicLoadout_F','O_Heli_Light_02_unarmed_F',
		'I_Heli_light_03_dynamicLoadout_F','I_Heli_light_03_unarmed_F','I_APC_Wheeled_03_cannon_F','I_APC_tracked_03_cannon_F',
		'B_APC_Tracked_01_AA_F','B_MBT_01_cannon_F','I_MBT_03_cannon_F','O_APC_Wheeled_02_rcws_v2_F','I_LT_01_AT_F','I_LT_01_scout_F','I_LT_01_cannon_F','I_LT_01_AA_F',
		'O_MBT_04_cannon_F','C_Tractor_01_F'
	];
	if (!(missionNamespace getVariable ['QS_armedAirEnabled',TRUE])) then {
		_vtypes = [
			'C_Heli_Light_01_civil_F','O_Heli_Transport_04_F',
			'O_Heli_Light_02_unarmed_F','I_Heli_light_03_unarmed_F','I_APC_Wheeled_03_cannon_F','I_APC_tracked_03_cannon_F',
			'B_APC_Tracked_01_AA_F','B_MBT_01_cannon_F','I_MBT_03_cannon_F','O_APC_Wheeled_02_rcws_v2_F','I_LT_01_AT_F','I_LT_01_scout_F','I_LT_01_cannon_F','I_LT_01_AA_F',
			'O_MBT_04_cannon_F','C_Tractor_01_F'
		];
	};
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
	_easterEgg = createSimpleObject [_vtype,(ATLToASL _spawnPos)];
	missionNamespace setVariable [
		'QS_analytics_entities_created',
		((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
		FALSE
	];
	_easterEgg setDir (random 360);
	_easterEgg setVectorUp (surfaceNormal _spawnPos);
	for '_x' from 0 to 2 step 1 do {
		_easterEgg setVariable ['QS_vehicle_prop',TRUE,TRUE];
		_easterEgg setVariable ['QS_vehicle_easterEgg',TRUE,TRUE];
	};
};