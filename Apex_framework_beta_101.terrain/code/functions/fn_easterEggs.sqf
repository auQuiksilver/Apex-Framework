/*
File: fn_easterEggs.sqf
Author:
	
	Quiksilver
	
Last Modified:

	19/12/2016 A3 1.66 by Quiksilver
	
Description:

	Easter eggs
_____________________________________________________*/

private [
	'_vtypes','_vtype','_pos','_airEggs','_flatPos','_accepted','_spawnPos','_easterEgg','_airEgg1','_airEgg2','_airEgg3','_airEgg4','_world','_airPosArray',
	'_baseMarker'
];
if (worldName isEqualTo 'Tanoa') then {
	_vtypes = [
		'B_Heli_Light_01_dynamicLoadout_F','C_Heli_Light_01_civil_F','O_Heli_Transport_04_F',
		'O_Heli_Attack_02_black_F','O_Heli_Light_02_dynamicLoadout_F','O_Heli_Light_02_unarmed_F',
		'I_Heli_light_03_dynamicLoadout_F','I_Heli_light_03_unarmed_F','I_APC_Wheeled_03_cannon_F','I_APC_tracked_03_cannon_F',
		'B_APC_Tracked_01_AA_F','B_MBT_01_cannon_F','I_MBT_03_cannon_F','I_MBT_03_cannon_F'
	];
	if (!(missionNamespace getVariable ['QS_armedAirEnabled',TRUE])) then {
		_vtypes = [
			'C_Heli_Light_01_civil_F','O_Heli_Transport_04_F',
			'O_Heli_Light_02_unarmed_F','I_Heli_light_03_unarmed_F','I_APC_Wheeled_03_cannon_F','I_APC_tracked_03_cannon_F',
			'B_APC_Tracked_01_AA_F','B_MBT_01_cannon_F','I_MBT_03_cannon_F','I_MBT_03_cannon_F'
		];
	};
} else {
	_vtypes = [
		'B_Heli_Light_01_dynamicLoadout_F','C_Heli_Light_01_civil_F','O_Heli_Transport_04_F','B_Heli_Attack_01_dynamicLoadout_F',
		'O_Heli_Attack_02_black_F','O_Heli_Light_02_dynamicLoadout_F','O_Heli_Light_02_unarmed_F',
		'I_Heli_light_03_dynamicLoadout_F','I_Heli_light_03_unarmed_F','I_APC_Wheeled_03_cannon_F','I_APC_tracked_03_cannon_F',
		'B_APC_Tracked_01_AA_F','B_MBT_01_cannon_F','I_MBT_03_cannon_F','I_MBT_03_cannon_F'
	];
	if (!(missionNamespace getVariable ['QS_armedAirEnabled',TRUE])) then {
		_vtypes = [
			'C_Heli_Light_01_civil_F','O_Heli_Transport_04_F',
			'O_Heli_Light_02_unarmed_F','I_Heli_light_03_unarmed_F','I_APC_Wheeled_03_cannon_F','I_APC_tracked_03_cannon_F',
			'B_APC_Tracked_01_AA_F','B_MBT_01_cannon_F','I_MBT_03_cannon_F','I_MBT_03_cannon_F'
		];
	};
};
_baseMarker = markerPos 'QS_marker_base_marker';
_world = worldName;
for '_x' from 0 to 3 step 1 do {
	_vtype = selectRandom _vtypes;
	_spawnPos = ['WORLD',-1,-1,'LAND',[],TRUE,[],[],TRUE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
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
if (worldName isEqualTo 'Altis') then {
	_airPosArray = [
		[11450.4,11452.3,0.00144768],
		[9129.82,21569.9,0.00144577],
		[27104.1,24918.6,0.00151443],
		[20864.5,7288.63,0.00141716]
	];
} else {
	if (worldName isEqualTo 'Tanoa') then {
		_airPosArray = [
			[2154.59,3457.78,0.00143909],	/*/ Bala airstrip /*/
			[11735.3,3131.85,0.00143862],	/*/ Saint-George airstrip /*/
			[11687.7,13113.8,0.00143909],	/*/ La Rochelle Aerodrome /*/
			[2217.02,13391.1,0.00143909]	/*/ Tuvanaka Airbase /*/
		];
	};
};
/*/
if (missionNamespace getVariable ['QS_armedAirEnabled',TRUE]) then {
	_airEggs = [
		'I_Plane_Fighter_03_AA_F','c_plane_civil_01_f','I_Plane_Fighter_03_dynamicLoadout_F','B_Plane_CAS_01_dynamicLoadout_F','O_Plane_CAS_02_dynamicLoadout_F','c_plane_civil_01_f','c_plane_civil_01_f','i_c_plane_civil_01_f'
	];
	if (isNil {missionNamespace getVariable 'QS_airEgg'}) then {
		missionNamespace setVariable ['QS_airEgg',objNull,FALSE];
	};
	if (!(_airPosArray isEqualTo [])) then {
		if ((random 1) > 0.666) then {
			if ((isNull (missionNamespace getVariable 'QS_airEgg')) || {(!alive (missionNamespace getVariable 'QS_airEgg'))}) then {
				_airEggType = selectRandom _airEggs;
				_airEggPos = selectRandom _airPosArray;
				missionNamespace setVariable [
					'QS_airEgg',
					(createVehicle [_airEggType,_airEggPos,[],0,'NONE']),
					FALSE
				];
				missionNamespace setVariable [
					'QS_analytics_entities_created',
					((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
					FALSE
				];
				[(missionNamespace getVariable 'QS_airEgg'),1,[]] call (missionNamespace getVariable 'QS_fnc_vehicleLoadouts');
				(missionNamespace getVariable 'QS_airEgg') setDir (random 360);
				[(missionNamespace getVariable 'QS_airEgg')] call (missionNamespace getVariable 'QS_fnc_vSetup');
				
				if ((toLower (typeOf (missionNamespace getVariable 'QS_airEgg'))) in ['c_plane_civil_01_f','i_c_plane_civil_01_f']) then {
					[(missionNamespace getVariable 'QS_airEgg')] call (missionNamespace getVariable 'QS_fnc_Q51');
				};
			};
		};
	} else {
		diag_log '***** fn_easterEggs ***** no positions available for plane *****';
	};
};
/*/