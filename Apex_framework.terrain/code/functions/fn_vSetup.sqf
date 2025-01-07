/*/
File: fn_vSetup.sqf
Author:

	Quiksilver
	
Last Modified:

	4/12/2023 A3 2.14 by Quiksilver
	
Description:

	Server-side player-accessible vehicle setup
_____________________________________________________/*/

params ['_u',['_z',FALSE],['_wreckable',FALSE]];
_t = typeOf _u;
_t2 = toLowerANSI _t;
_isSimpleObject = isSimpleObject _u;
_u setVariable ['QS_vehicle',TRUE,(!isDedicated)];
if (_t2 isKindOf 'Heli_Light_01_base_F') then {
	for '_i' from 0 to 9 do {_u setObjectTextureGlobal [_i,'#(argb,8,8,3)color(0,0,0,0.6)'];};
};
if (_t2 isKindOf 'Plane_Fighter_03_base_F') then {
	if (_isSimpleObject || {(isNull (driver _u))}) then {
		_defaultTextures = QS_hashmap_configfile getOrDefaultCall [
			format ['cfgvehicles_%1_texturedefault',_t2],
			{(getArray ((configOf _u) >> 'TextureSources' >> 'Grey' >> 'textures'))},
			TRUE
		];
		{ 
			_u setObjectTextureGlobal [_forEachIndex,_x]; 
		} forEach _defaultTextures;
	};
};
if (_t2 isKindOf 'MBT_04_base_F') then {
	if (_isSimpleObject || {(isNull (driver _u))}) then {
		_defaultTextures = QS_hashmap_configfile getOrDefaultCall [
			format ['cfgvehicles_%1_texturedefault',_t2],
			{(getArray ((configOf _u) >> 'TextureSources' >> 'Grey' >> 'textures'))},
			TRUE
		];
		{ 
			_u setObjectTextureGlobal [_forEachIndex,_x]; 
		} forEach _defaultTextures;
	};
};
if (_t2 isKindOf 'MBT_02_railgun_base_F') then {
	if (_isSimpleObject || {(isNull (driver _u))}) then {
		_defaultTextures = QS_hashmap_configfile getOrDefaultCall [
			format ['cfgvehicles_%1_texturedefault',_t2],
			{(getArray ((configOf _u) >> 'TextureSources' >> 'Grey' >> 'textures'))},
			TRUE
		];
		{ 
			_u setObjectTextureGlobal [_forEachIndex,_x]; 
		} forEach _defaultTextures;
	};
};
if (_t2 isKindOf 'LT_01_base_F') then {
	if (_isSimpleObject || {(isNull (driver _u))}) then {
		_defaultTextures = QS_hashmap_configfile getOrDefaultCall [
			format ['cfgvehicles_%1_texturedefault',_t2],
			{(getArray ((configOf _u) >> 'TextureSources' >> 'Indep_Olive' >> 'textures'))},
			TRUE
		];
		{ 
			_u setObjectTextureGlobal [_forEachIndex,_x]; 
		} forEach _defaultTextures;
	};
};
if (_t2 isKindOf 'MRAP_03_base_F') then {
	if (_isSimpleObject || {(isNull (driver _u))}) then {
		{
			_u setObjectTextureGlobal _x;
		} forEach [
			[0,'\A3\soft_f_beta\mrap_03\data\mrap_03_ext_co.paa'],
			[1,'\A3\data_f\vehicles\turret_co.paa']
		];
	};
};
if (_t2 isKindOf 'APC_Tracked_03_base_F') then {
	if (_isSimpleObject || {(isNull (driver _u))}) then {
		{
			_u setObjectTextureGlobal _x;
		} forEach [
			[0,'media\images\vskins\fv720\apc_tracked_03_ext_blufor_co.paa'],
			[1,'media\images\vskins\fv720\apc_tracked_03_ext2_blufor_co.paa']
		];
	};
};
if (_t2 isKindOf 'MBT_03_base_F') then {
	if (_isSimpleObject || {(isNull (driver _u))}) then {
		{
			_u setObjectTextureGlobal _x;
		} forEach [
			[0,'media\images\vskins\mbt52\mbt_03_ext01_blufor_co.paa'],
			[1,'media\images\vskins\mbt52\mbt_03_ext02_blufor_co.paa'],
			[2,'media\images\vskins\mbt52\mbt_03_rcws_blufor_co.paa']
		];
	};
};
if (_t2 isKindOf 'APC_Wheeled_03_base_F') then {
	if (_isSimpleObject || {(isNull (driver _u))}) then {
		{
			_u setObjectTextureGlobal _x;
		} forEach [
			[0,'A3\Armor_F_Gamma\APC_Wheeled_03\Data\apc_wheeled_03_ext_co.paa'],
			[1,'A3\Armor_F_Gamma\APC_Wheeled_03\Data\apc_wheeled_03_ext2_co.paa'],
			[2,'A3\Armor_F_Gamma\APC_Wheeled_03\Data\rcws30_co.paa'],
			[3,'A3\Armor_F_Gamma\APC_Wheeled_03\Data\apc_wheeled_03_ext_alpha_co.paa']
		];
	};
};
if (_t2 isKindOf 'APC_Wheeled_02_base_F') then {
	if (_isSimpleObject || {(isNull (driver _u))}) then {
		{
			_u setObjectTextureGlobal _x;
		} forEach [
			[0,'media\images\vskins\mse3\nato\apc_wheeled_02_ext_01_blufor_co.paa'],
			[1,'media\images\vskins\mse3\nato\apc_wheeled_02_ext_02_blufor_co.paa'],
			[2,'a3\data_f\vehicles\turret_co.paa']
		];
	};
};
if (_t2 isKindOf 'MBT_02_base_F') then {
	if (_isSimpleObject || {(isNull (driver _u))}) then {
		{
			_u setObjectTextureGlobal _x;
		} forEach [
			[0,'media\images\vskins\t100\mbt_02_greengrey_body_co.paa'],
			[1,'media\images\vskins\t100\mbt_02_greengrey_turret_co.paa'],
			[2,'media\images\vskins\t100\mbt_02_greengrey_co.paa']
		];
	};
};
if (_t2 isKindOf 'Heli_light_03_base_F') then {
	if (_isSimpleObject || {(isNull (driver _u))}) then {
		_defaultTextures = QS_hashmap_configfile getOrDefaultCall [
			format ['cfgvehicles_%1_texturedefault',_t2],
			{(getArray ((configOf _u) >> 'TextureSources' >> 'Green' >> 'textures'))},
			TRUE
		];
		{ 
			_u setObjectTextureGlobal [_forEachIndex,_x]; 
		} forEach _defaultTextures;
	};
};
if (_t2 isKindOf 'Heli_Transport_04_base_F') then {
	if ((crew _u) isEqualTo []) then {
		_defaultTextures = QS_hashmap_configfile getOrDefaultCall [
			format ['cfgvehicles_%1_texturedefault',_t2],
			{(getArray ((configOf _u) >> 'TextureSources' >> 'Black' >> 'textures'))},
			TRUE
		];
		{ 
			_u setObjectTextureGlobal [_forEachIndex,_x];
		} forEach _defaultTextures;
	};
	if (_t2 isKindOf 'o_heli_transport_04_bench_f') then {
		_u animateSource ['Bench_default_hide',1];
		_u animateSource ['Bench_black_hide',0];
	};
};
if (_t2 in [
	'land_pod_heli_transport_04_ammo_f','land_pod_heli_transport_04_ammo_black_f',
	'land_pod_heli_transport_04_repair_f','land_pod_heli_transport_04_repair_black_f',
	'land_pod_heli_transport_04_box_f','land_pod_heli_transport_04_box_black_f',
	'land_pod_heli_transport_04_covered_f','land_pod_heli_transport_04_covered_black_f',
	'land_pod_heli_transport_04_medevac_f','land_pod_heli_transport_04_medevac_black_f',
	'land_pod_heli_transport_04_bench_f','land_pod_heli_transport_04_bench_black_f'
]) then {
	_defaultTextures = QS_hashmap_configfile getOrDefaultCall [
		format ['cfgvehicles_%1_texturedefault',_t2],
		{(getArray ((configOf _u) >> 'TextureSources' >> 'Black' >> 'textures'))},
		TRUE
	];
	{
		_u setObjectTextureGlobal [_forEachIndex,_x];
	} forEach _defaultTextures;
};
if (_t2 in ['o_sam_system_04_f','o_radar_system_02_f']) then {
	if (!_isSimpleObject) then {
		_u setVehicleRadar 1;
	};
	_defaultTextures = QS_hashmap_configfile getOrDefaultCall [
		format ['cfgvehicles_%1_texturedefault',_t2],
		{(getArray ((configOf _u) >> 'TextureSources' >> (['AridHex','JungleHex'] select (worldName in ['Tanoa','Enoch'])) >> 'textures'))},
		TRUE
	];
	{
		_u setObjectTextureGlobal [_forEachIndex,_x];
	} forEach _defaultTextures;
};
if (_t2 in ['b_sam_system_03_f','b_radar_system_01_f']) then {
	if (!_isSimpleObject) then {
		_u setVehicleRadar 1;
	};
	_defaultTextures = QS_hashmap_configfile getOrDefaultCall [
		format ['cfgvehicles_%1_texturedefault',_t2],
		{(getArray ((configOf _u) >> 'TextureSources' >> (['Desert','Olive'] select (worldName in ['Tanoa','Enoch'])) >> 'textures'))},
		TRUE
	];
	{
		_u setObjectTextureGlobal [_forEachIndex,_x];
	} forEach _defaultTextures;
};
if (_isSimpleObject) exitWith {};	// Simple Objects exit here - Actual vehicles continue
_u allowService 0;
_u allowCrewInImmobile [TRUE,TRUE];
_u setUnloadInCombat [TRUE,FALSE];
_u enableVehicleCargo TRUE;
_u enableRopeAttach TRUE;
_mass = QS_hashmap_configfile getOrDefaultCall [
	format ['cfgvehicles_%1_mass',_t2],
	{getMass _u},
	TRUE
];
_transportSoldier = QS_hashmap_configfile getOrDefaultCall [
	format ['cfgvehicles_%1_transportsoldier',_t2],
	{getNumber ((configOf _u) >> 'transportSoldier')},
	TRUE
];
_u setVariable ['QS_vehicle_isSuppliedFOB',nil,TRUE];
// Small stuff
if (
	((crew _u) isEqualTo []) &&
	{((_u emptyPositions '') isEqualTo 0)}
) then {
	if (_u isKindOf 'Reammobox_F') then {
		_u setVariable ['QS_logistics',TRUE,TRUE];
	};
	if (_u isKindOf 'ThingX') then {
		_u setVariable ['QS_logistics',TRUE,TRUE];
	};
};
// Land Vehicles
if (_u isKindOf 'LandVehicle') then {
	if (!(_u getVariable ['QS_logistics_wreck',FALSE])) then {
		_u setVariable ['QS_logistics_packable',TRUE,TRUE];
	};
	_u setConvoySeparation 50;
	_u forceFollowRoad TRUE;
	if (_u isKindOf 'AFV_Wheeled_01_base_F') then {
		_u animateSource ['showslathull',0,1];
	};
	if (_u isKindOf 'LSV_01_AT_base_F') then {
		for '_i' from 0 to 5 step 1 do {
			_u addMagazineTurret ['1Rnd_GAT_missiles',[0]];
		};
		for '_i' from 0 to 9 step 1 do {
			_u addMagazineTurret ['1Rnd_GAA_missiles',[0]];
		};
	};
	if (_u isKindOf 'b_truck_01_mover_f') then {
		_u setVariable ['QS_towing_maxTrain_1',4,TRUE];
	};
	if (_u isKindOf 'Offroad_01_base_F') then {
		if ((_u animationPhase 'HideBumper1') isNotEqualTo 1) then {
			_u animate ['HideBumper1',1];
		};
		if ((_u animationPhase 'HideBumper2') isNotEqualTo 0) then {
			_u animate ['HideBumper2',0];
		};
		if (_u isKindOf 'Offroad_01_repair_base_F') then {
			// Not ready yet, but we leave it in as something innocent for people to play with
			[
				'SET_VCARGO_SERVER',
				_u,
				([11] call QS_data_virtualCargoPresets)
			] call QS_fnc_virtualVehicleCargo;
			// 
			_u animate ['HideServices',0];
			_u animate ['HidePolice',1];
		};
		if (_t2 in ['b_gen_offroad_01_gen_f','b_gen_offroad_01_covered_f']) then {
			_u animate ['hidePolice',0,1];
			_u animate ['hideServices',1,1];	
		};
	};
	if (_u isKindOf 'SUV_01_base_F') then {
		_com = getCenterOfMass _u;
		_com set [2,-0.656];
		_u setCenterOfMass _com;
	};
	if (_t2 isKindOf 'APC_Wheeled_02_base_F') then {
		{
			_u animateSource _x;
		} forEach [
			['showTools',1,1],
			['showCanisters',1,1]
		];
	};
	if (_t2 isKindOf 'MBT_03_base_F') then {
		if (isNull (driver _u)) then {
			{
				_u animateSource _x;
			} forEach [
				['hidehull',1,1],
				['hideturret',1,1]
			];
		};
	};	
	if (([
		'b_apc_tracked_01_crv_f',
		'b_truck_01_mover_f',
		'offroad_01_base_f',
		'van_01_transport_base_f',
		'tractor_01_base_f',
		'quadbike_01_base_f',
		'ugv_01_base_f'
	] findIf { _t2 isKindOf _x }) isNotEqualTo -1) then {
		if (([
			'offroad_01_base_f',
			'van_01_transport_base_f'
		] findIf { _t2 isKindOf _x }) isNotEqualTo -1) then {
			_u setVariable ['QS_tow_veh',2,TRUE];
		} else {
			if (([
				'b_apc_tracked_01_crv_f',
				'b_truck_01_mover_f'
			] findIf { _t2 isKindOf _x }) isNotEqualTo -1) then {
				_u setVariable ['QS_tow_veh',5,TRUE];
			};
		};
		if (_u isKindOf 'b_apc_tracked_01_crv_f') then {
			// Not ready yet
			/*/
			[
				'SET_VCARGO_SERVER',
				_u,
				([10] call QS_data_virtualCargoPresets)
			] call QS_fnc_virtualVehicleCargo;
			/*/
			_u setVariable ['QS_vehicle_lift',41000,TRUE];
			if (missionNamespace getVariable ['QS_missionConfig_bobcatRecovery',FALSE]) then {
				_u setVariable ['QS_logistics_recoverEnabled',TRUE,TRUE];
			};
		};
		if (_u isKindOf 'Tractor_01_base_F') then {
			_u removeWeapon 'CarHorn';
			_u setVariable ['QS_vehicle_lift',21000,TRUE];
		};
		if (_u isKindOf 'Quadbike_01_base_F') then {
			_u setVariable ['QS_vehicle_lift',2000,TRUE];
		};
		if (
			(_u isKindOf 'ugv_01_base_f') &&
			{(!(_u isKindOf 'ugv_01_rcws_base_f'))}
		) then {
			_u setVariable ['QS_vehicle_lift',11000,TRUE];
		};
	};
	if (_t2 isKindOf 'Van_02_base_F') then {
		{
			_u animateSource _x;
		} forEach [
			['front_protective_frame_hide',0,1],
			['side_protective_frame_hide',0,1],
			/*/['ladder_hide',0,1],/*/
			['rearsteps_hide',0,1],
			/*/['roof_rack_hide',0,1],/*/
			/*/['spare_tyre_holder_hide',0,1],/*/
			/*/['spare_tyre_hide',0,1],/*/
			['sidesteps_hide',0,1]
		];
		if (_t2 isKindOf 'Van_02_medevac_base_F') then {
			_u animateSource ['reflective_tape_hide',0,1];
		};
	};
	if (
		(_u isKindOf 'ugv_01_base_f') &&
		{(!(_u isKindOf 'ugv_01_rcws_base_f'))}
	) then {
		// Unarmed Stomper UGV
		_u addEventHandler [
			'Deleted',
			{
				params ['_vehicle'];
				if ((attachedObjects _vehicle) isNotEqualTo []) then {
					{
						[0,_x] call QS_fnc_eventAttach;
						if (!isPlayer _x) then {
							_x setDamage [1,FALSE];
							deleteVehicle _x;
						};
					} forEach (attachedObjects _vehicle);
				};
			}
		];
		_u addEventHandler [
			'Killed',
			{
				params ['_vehicle'];
				if ((attachedObjects _vehicle) isNotEqualTo []) then {
					{
						[0,_x] call QS_fnc_eventAttach;
						if (!isPlayer _x) then {
							_x setDamage [1,FALSE];
							deleteVehicle _x;
						};
					} forEach (attachedObjects _vehicle);
				};
			}
		];
		_u setVariable ['QS_tow_veh',2,TRUE];
		_stretcher1 = createSimpleObject ['a3\props_f_orange\humanitarian\camps\stretcher_01_f.p3d',[0,0,0]];
		[1,_stretcher1,[_u,[0,-0.75,-0.7]]] call QS_fnc_eventAttach;
		_stretcher1 setVariable ['QS_attached',TRUE,TRUE];
		_stretcher2 = createSimpleObject ['a3\props_f_orange\humanitarian\camps\stretcher_01_f.p3d',[0,0,0]];
		[1,_stretcher2,[_u,[0.85,-0.75,-0.7]]] call QS_fnc_eventAttach;
		_stretcher2 setVariable ['QS_attached',TRUE,TRUE];
		_u spawn {
			params ['_u'];
			sleep 1;
			if ((crew _u) isEqualTo []) then {
				// Uncrewed stompers become Cargo Trailers
				if (isDedicated) then {
					[_u] call QS_fnc_createUGVTrailer;
				} else {
					[118,_u] remoteExec ['QS_fnc_remoteExec',2,FALSE];
				};
			};
		};
	};
};
// Ships/Boats
if (_u isKindOf 'Ship') then {
	if ((getMass _u) > 1000) then {
		clearWeaponCargoGlobal _u;
		clearMagazineCargoGlobal _u;
		clearItemCargoGlobal _u;
		clearBackpackCargoGlobal _u;
		{
			_u addItemCargoGlobal _x;
		} forEach [
			['G_B_Diving',_transportSoldier],
			['V_RebreatherB',_transportSoldier],
			['U_B_Wetsuit',_transportSoldier]
		];
	};
	if (
		(_u isKindOf 'Rubber_duck_base_F') ||
		(_u isKindOf 'Boat_Transport_02_base_F')
	) then {
		_u setVariable ['QS_vehicle_lift',21000,TRUE];
	};
};
// Aircraft
if (_u isKindOf 'Air') then {
	if (
		((getAllPylonsInfo _u) isNotEqualTo []) &&
		(missionNamespace getVariable ['QS_missionConfig_wrecks',TRUE])
	) then {
		_u setVariable ['QS_logistics_applyWreckChance',TRUE,TRUE];
	};
	_u setVehicleReceiveRemoteTargets TRUE;
	_u setVehicleReportOwnPosition TRUE;
	[_u,1,[]] call (missionNamespace getVariable 'QS_fnc_vehicleLoadouts');
	['setFeatureType',_u,2] remoteExec ['QS_fnc_remoteExecCmd',-2,_u];
	// Planes
	if (_u isKindOf 'Plane') then {
		_u addEventHandler ['Gear',{}];
		_u addEventHandler ['LandedTouchDown',{}];
		_u addEventHandler ['LandedStopped',{}];
		if (_u isKindOf 'I_Plane_Fighter_03_dynamicLoadout_F') then {
			_u disableTIEquipment TRUE;
			if (local _u) then {
				_u removeWeapon 'missiles_SCALPEL';
			} else {
				['removeWeapon',_u,'missiles_SCALPEL'] remoteExec ['QS_fnc_remoteExecCmd',_u,FALSE];
			};
		};
		if (_u isKindOf 'B_Plane_CAS_01_dynamicLoadout_F') then {
			_u disableTIEquipment TRUE;
			if (local _u) then {
				_u removeWeapon 'Missile_AGM_02_Plane_CAS_01_F';
			} else {
				['removeWeapon',_u,'Missile_AGM_02_Plane_CAS_01_F'] remoteExec ['QS_fnc_remoteExecCmd',_u,FALSE];
			};
		};
		if (_u isKindOf 'O_Plane_CAS_02_dynamicLoadout_F') then {
			_u disableTIEquipment TRUE;
			if (local _u) then {
				_u removeWeapon 'Missile_AGM_01_Plane_CAS_02_F';
			} else {
				['removeWeapon',_u,'Missile_AGM_01_Plane_CAS_02_F'] remoteExec ['QS_fnc_remoteExecCmd',_u,FALSE];
			};
		};
		if (_u isKindOf 'B_UAV_02_F') then {
			if (local _u) then {
				_u removeWeapon 'missiles_SCALPEL';
			} else {
				['removeWeapon',_u,'missiles_SCALPEL'] remoteExec ['QS_fnc_remoteExecCmd',_u,FALSE];
			};
		};
		if (
			(_t2 isKindOf 'VTOL_01_vehicle_base_F') ||
			(_t2 isKindOf 'VTOL_01_armed_base_F')
		) then {
			{ 
				_u setObjectTextureGlobal [_forEachIndex,_x]; 
			} forEach (getArray ((configOf _u) >> 'TextureSources' >> 'Blue' >> 'textures'));
		};
		// VTOL
		if ((_t2 isKindOf 'VTOL_01_base_F') || {(_t2 isKindOf 'VTOL_02_base_F')}) then {
			{
				_u addEventHandler _x;
			} forEach [
				['GetIn',{call (missionNamespace getVariable 'QS_fnc_clientEventGetIn')}],
				['GetOut',{call (missionNamespace getVariable 'QS_fnc_clientEventGetOut')}],
				['ControlsShifted',(missionNamespace getVariable 'QS_fnc_vEventControlsShifted')]
			];
			if (_t2 isKindOf 'VTOL_02_base_F') then {
				if (local _u) then {
					_u removeWeapon 'missiles_SCALPEL';
				} else {
					['removeWeapon',_u,'missiles_SCALPEL'] remoteExec ['QS_fnc_remoteExecCmd',_u,FALSE];
				};	
			};
			_u addBackpackCargoGlobal [QS_core_classNames_parachute,_transportSoldier];
			if (_t2 isKindOf 'VTOL_01_vehicle_base_F') then {
				_u addEventHandler [
					'Killed',
					{
						params ['_killed','_killer'];
						if ((getVehicleCargo _killed) isNotEqualTo []) then {
							(_this # 0) setVehicleCargo objNull;
						};
					}
				];
			};
		};
	};
	// Helicopters
	if (_u isKindOf 'Helicopter') then {
		if (
			isDedicated &&
			{((crew _u) isEqualTo [])}
		) then {
			_u allowDamage FALSE;
			_u setVariable ['QS_vehicle_activateLocked',TRUE,TRUE];
			_u lock 2;
			_u addEventHandler ['GetIn',{(_this # 0) allowDamage TRUE; (_this # 0) removeEventHandler [_thisEvent,_thisEventHandler];}];
			_u addEventHandler ['Local',{(_this # 0) allowDamage TRUE; (_this # 0) removeEventHandler [_thisEvent,_thisEventHandler];}];
			_u spawn {sleep 3; _this enableSimulationGlobal FALSE;};
		};
		_u setVariable ['QS_heli_spawnPosition',(position _u),FALSE];
		if (_t2 in ['b_t_uav_03_f']) then {
			clearItemCargoGlobal _u;
			_u addItemCargoGlobal [QS_core_classNames_demoCharge,2];
			if (local _u) then {
				_u removeWeapon 'missiles_SCALPEL';
			} else {
				['removeWeapon',_u,'missiles_SCALPEL'] remoteExec ['QS_fnc_remoteExecCmd',_u,FALSE];
			};	
		} else {
			clearItemCargoGlobal _u;
			_u addItemCargoGlobal [QS_core_classNames_demoCharge,2];
			_u setVariable ['QS_ST_drawEmptyVehicle',FALSE,TRUE];
			{
				_u addEventHandler _x;
			} forEach [
				['GetIn',{call (missionNamespace getVariable 'QS_fnc_clientEventGetIn')}],
				['GetOut',{call (missionNamespace getVariable 'QS_fnc_clientEventGetOut')}],
				['ControlsShifted',(missionNamespace getVariable 'QS_fnc_vEventControlsShifted')]
			];
		};
		if (_u isKindOf 'heli_transport_04_base_f') then {
			_u addEventHandler ['SeatSwitched',(missionNamespace getVariable 'QS_fnc_clientEventSeatSwitched')];
		};
		if (_t2 isKindOf 'Heli_Transport_01_base_F') then {
			_u setVariable ['turretL_locked',FALSE,TRUE];
			_u setVariable ['turretR_locked',FALSE,TRUE];
			_u animateDoor ['door_R',1];
			_u animateDoor ['door_L',1];
		};
		if (_t2 isKindOf 'Heli_Light_02_base_F') then {
			_u animateSource ['Doors',1,1];
			_u animateSource ['Doors',1,1];
		};
		if (_t2 isKindOf 'Heli_Transport_03_base_F') then {
			_u setVariable ['turretL_locked',FALSE,TRUE];
			_u setVariable ['turretR_locked',FALSE,TRUE];
		};
		if (_t2 isKindOf 'Heli_Light_01_base_F') then {
			_u setVariable ['QS_logistics_packable',TRUE,TRUE];
		};
	};
} else {
	_u setVehicleReportRemoteTargets TRUE;
};
// Containers/Storage
if ((['Cargo_base_F','Slingload_01_Base_F','Pod_Heli_Transport_04_base_F'] findIf { _u isKindOf _x }) isNotEqualTo -1) then {
	[_u] call QS_fnc_vSetupContainer;
};
// Services
if ((getAmmoCargo _u) > 0) then {
	_u setAmmoCargo 0;
	if (!(_u getVariable ['QS_logistics_deployable',FALSE])) then {
		_u setVariable ['QS_logistics_deployable',TRUE,TRUE];
	};
};
if ((getFuelCargo _u) > 0) then {
	_u setFuelCargo 0;
	if (!(_u getVariable ['QS_logistics_deployable',FALSE])) then {
		_u setVariable ['QS_logistics_deployable',TRUE,TRUE];
	};
	/*/
	_u addEventHandler [
		'Killed',
		{
			params ['_entity'];
			([_entity,'SAFE'] call QS_fnc_inZone) params ['_inSafezone','_safezoneLevel','_safezoneActive'];
			if (_inSafezone && _safezoneActive) exitWith {};
			if ((random 1) > 0.5) then {
				createVehicle [
					[
						'HelicopterExploSmall',
						(selectRandomWeighted ['HelicopterExploSmall',0.5,'HelicopterExploBig',1,'Bo_Mk82',0.1])
					] select ((getMass _entity) > 5000),
					(ASLToAGL (getPosASL _entity))
				];
			};
		}
	];
	/*/
};
if ((getRepairCargo _u) > 0) then {
	_u setRepairCargo 0;
	if (!(_u getVariable ['QS_logistics_deployable',FALSE])) then {
		_u setVariable ['QS_logistics_deployable',TRUE,TRUE];
	};
};
if ((QS_hashmap_configfile getOrDefaultCall [format ['cfgvehicles_%1_attendant',_t2],{getNumber ((configOf _u) >> 'attendant')},TRUE]) isEqualTo 1) then {
	_u setVariable ['QS_services_medical',TRUE,TRUE];
	if (!(_u getVariable ['QS_logistics_deployable',FALSE])) then {
		_u setVariable ['QS_logistics_deployable',TRUE,TRUE];
	};
	if (_transportSoldier > 0) then {
		if (_transportSoldier isEqualTo 4) then {
			_transportSoldier = 8;
		} else {
			_transportSoldier = round (_transportSoldier * 1.5);
		};
		if (_t2 isKindOf 'Van_02_medevac_base_F') then {
			_transportSoldier = 2;
		};
		_u setVariable ['QS_medicalVehicle_reviveTickets',_transportSoldier,TRUE];
	} else {
		if (!(_u isKindOf 'UAV_06_base_F')) then {
			_u setVariable ['QS_medicalVehicle_reviveTickets',4,TRUE];
		};
	};
};
// Misc Services/Logistics
if (_t2 in ['flexibletank_01_sand_f','flexibletank_01_forest_f']) then {
	_u setVariable ['QS_inventory_disabled',TRUE,TRUE];
	_u setVariable ['QS_lockedInventory',TRUE,TRUE];
};
if (_t2 in [
	'land_pod_heli_transport_04_ammo_f','land_pod_heli_transport_04_ammo_black_f',
	'land_pod_heli_transport_04_repair_f','land_pod_heli_transport_04_repair_black_f',
	'land_pod_heli_transport_04_box_f','land_pod_heli_transport_04_box_black_f',
	'land_pod_heli_transport_04_covered_f','land_pod_heli_transport_04_covered_black_f',
	'land_pod_heli_transport_04_medevac_f','land_pod_heli_transport_04_medevac_black_f',
	'land_pod_heli_transport_04_bench_f','land_pod_heli_transport_04_bench_black_f'
]) then {
	private _newmass = -1;
	if (_t2 in ['land_pod_heli_transport_04_ammo_black_f','land_pod_heli_transport_04_ammo_f']) then {
		_newmass = 8000;
	};
	if (_t2 in ['land_pod_heli_transport_04_box_black_f','land_pod_heli_transport_04_box_f']) then {
		_newmass = 7500;
	};
	if (_t2 in ['land_pod_heli_transport_04_fuel_black_f','land_pod_heli_transport_04_fuel_f']) then {
		_newmass = 8500;
	};
	if (_t2 in ['land_pod_heli_transport_04_medevac_black_f','land_pod_heli_transport_04_medevac_f']) then {
		_newmass = 3500;
	};
	if (_t2 in ['land_pod_heli_transport_04_repair_black_f','land_pod_heli_transport_04_repair_f']) then {
		_newmass = 7000;
	};
	if (_newMass isNotEqualTo -1) then {
		if (local _u) then {
			_u setMass _newMass;
		} else {
			['setMass',_u,_newMass] remoteExec ['QS_fnc_remoteExecCmd',_u,FALSE];
		};
	};
};
// Active protection system
if ((['LandVehicle','Air','Ship'] findIf { _u isKindOf _x }) isNotEqualTo -1) then {
	[_u] call (missionNamespace getVariable 'QS_fnc_vehicleAPSParams');
};
_u addEventHandler [
	'Deleted',
	{
		params ['_vehicle'];
		_attachedObjs = [_vehicle] call QS_fnc_getAllAttached;
		deleteVehicle _attachedObjs;
		if (_vehicle isKindOf 'Plane') then {
			if ((getVehicleCargo _vehicle) isNotEqualTo []) then {
				_vehicle setVehicleCargo objNull;
			};
		};
	}
];
// Other
if (!(_z)) then {
	if (isDedicated) then {
		_u setVariable ['QS_RD_vehicleRespawnable',TRUE,TRUE];
	};
	if (!(unitIsUav _u)) then {
		_u addEventHandler ['Killed',(missionNamespace getVariable 'QS_fnc_vKilled')];
	};
};
if (isDedicated) then {
	if (_t2 in (['load_cargo_1'] call QS_data_listVehicles)) then {
		_u addEventHandler ['CargoLoaded',{call QS_fnc_eventCargoLoaded}];
		_u addEventHandler ['CargoUnloaded',{call QS_fnc_eventCargoUnloaded}];
	};
	if (_wreckable) then {
		_vehicle setVariable ['QS_logistics_wreckable',TRUE,FALSE];
	};
	_u setVariable ['QS_transporter',nil,FALSE];
	_u addEventHandler [
		'Local',
		{
			params ['_vehicle','_isLocal'];
			if (_isLocal) then {
				_vehicle addEventHandler ['HandleDamage',{call QS_fnc_clientVehicleEventHandleDamage}];
				if (
					(lockedDriver _vehicle) &&
					(!(_vehicle getVariable ['QS_driver_disabled',FALSE]))
				) then {
					[_vehicle,FALSE] remoteExec ['lockDriver',0,FALSE];
				};
				if (
					(_vehicle getVariable ['QS_lockedInventory',FALSE]) &&
					(!(_vehicle getVariable ['QS_inventory_disabled',FALSE]))
				) then {
					[_vehicle,FALSE] remoteExec ['lockInventory',0,FALSE];
					_vehicle setVariable ['QS_lockedInventory',FALSE,TRUE];
				};
			} else {
				_vehicle removeAllEventHandlers 'HandleDamage';
			};
		}
	];
};
if ((locked _u) isNotEqualTo 2) then {
	_u lock 0;
};