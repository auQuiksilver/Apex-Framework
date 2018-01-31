/*
File: fn_clientEventCuratorObjectPlaced.sqf
Author:

	Quiksilver
	
Last modified:

	17/01/2017 A3 1.66 by Quiksilver
	
Description:

	Event Curator Object Placed
__________________________________________________*/

params ['_module','_object'];
private ['_side','_type'];
_type = typeOf _object;
_typeL = toLower _type;
if (_object isKindOf 'Man') exitWith {
	_side = side _object;
	if ((_side getFriend WEST) < 0.6) then {
		[_object] call (missionNamespace getVariable 'QS_fnc_setCollectible');
	};
	_object disableAI 'AUTOCOMBAT';
	_object disableAI 'COVER';
	(group _object) setSpeedMode 'FULL';
	if (_side isEqualTo CIVILIAN) then {
		if (_type in [
			'C_man_p_fugitive_F','C_man_p_shorts_1_F','C_man_p_fugitive_F_afro','C_man_p_shorts_1_F_afro',
			'C_man_p_fugitive_F_asia','C_man_p_shorts_1_F_asia','C_man_p_fugitive_F_euro','C_man_p_shorts_1_F_euro'
		]) then {
			[_object] call (missionNamespace getVariable 'QS_fnc_setCollectible');
			(group _object) setBehaviour 'CARELESS';
			_object disableAI 'COVER';
			_object addEventHandler [
				'Killed',
				{
					_killer = _this select 1;
					if (!isNull _killer) then {
						if (isPlayer _killer) then {
							_text = format ['Fugitive killed by %1!',(name _killer)];
							['sideChat',[WEST,'HQ'],_text] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
						};
					};
				}
			];
			if (['afro',_type,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) then {
				_object enableStamina FALSE;
				_object enableFatigue FALSE;
				_object setAnimSpeedCoef 1.3;
			};
			if ((_object distance (markerPos 'QS_marker_gitmo')) < 20) then {
				_object forceAddUniform 'U_C_WorkerCoveralls';
				removeHeadgear _object;
				0 = [_object] spawn {
					uiSleep 1; 
					(_this select 0) setObjectTextureGlobal [0,'#(rgb,8,8,3)color(1,0.1,0,1)'];
				};
				_object setVariable ['QS_unit_isPrisoner',TRUE,TRUE];
			};
		} else {
			_object addEventHandler [
				'Killed',
				{
					_killer = _this select 1;
					if (!isNull _killer) then {
						if (isPlayer _killer) then {
							_text = format ['%1 has murdered a civilian!',(name _killer)];
							['systemChat',_text] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
						};
					};
				}
			];
		};
		_object setSkill 0;
		_object allowFleeing 0;
		{
			_object disableAI _x;
		} forEach [
			'TARGET',
			'AUTOTARGET',
			'SUPPRESSION',
			'AIMINGERROR'
		];
	} else {
		if (_side in [EAST,WEST,RESISTANCE]) then {
			if (_side in [EAST,RESISTANCE]) then {
				_object call (missionNamespace getVariable 'QS_fnc_unitSetup');
				_object setVariable ['QS_surrenderable',TRUE,TRUE];
			};
			_object enableStamina FALSE;
			_object enableFatigue FALSE;
			private ['_QS_unitSide','_QS_magazinesUnit','_QS_testMag','_QS_primaryWeaponMag'];
			[[_object],1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
			_QS_unitSide = side _object;
			_QS_magazinesUnit = magazines _object;
			if (['recon',_type,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) then {
				_object enableStamina FALSE;
				_object enableFatigue FALSE;
				_object setAnimSpeedCoef 1.1;
			};
			[[_object]] spawn (missionNamespace getVariable 'QS_fnc_serverTracers');
			if ((random 1) > 0.333) then {
				if (({(_x in ['optic_Aco','optic_ACO_grn'])} count (primaryWeaponItems _object)) > 0) then {
					_object addPrimaryWeaponItem 'optic_Arco';
				};
			};
			if (_type in [
				'I_C_Soldier_Para_4_F','I_C_Soldier_Bandit_3_F','I_G_Soldier_AR_F','I_Soldier_AR_F','B_CTRG_Soldier_AR_tna_F',
				'B_G_Soldier_AR_F','B_soldier_AR_F','B_HeavyGunner_F','B_T_Soldier_AR_F','O_Soldier_AR_F','O_HeavyGunner_F',
				'O_soldierU_AR_F','O_Urban_HeavyGunner_F','O_T_Soldier_AR_F','O_G_Soldier_AR_F'	
			]) then {
				_object addPrimaryWeaponItem (selectRandom ['optic_Hamr','optic_MRCO','optic_DMS','optic_Holosight','optic_ERCO_blk_F','optic_ERCO_khk_F','optic_ERCO_snd_F','optic_KHS_old']);
			};
			if (['recon',_type,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) then {
				if ((side _object) isEqualTo EAST) then {
					_object addHeadgear 'H_HelmetSpecO_blk';
				};
				if ((random 1) > 0.5) then {
					_object addPrimaryWeaponItem (selectRandom ['optic_Nightstalker','optic_tws']);
				};
			};
			if (['O_V_',_type,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) then {
				_object enableStamina FALSE;
				_object enableFatigue FALSE;
				_object setAnimSpeedCoef 1.25;
			};
			if (['officer',_type,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) then {
				if ((side _object) in [EAST,RESISTANCE]) then {
					_object setVariable ['QS_surrenderable',TRUE,TRUE];
				};
			};
		};
	};
	if (_type in ['C_Soldier_VR_F','B_Soldier_VR_F','O_Soldier_VR_F','I_Soldier_VR_F','B_Protagonist_VR_F','O_Protagonist_VR_F','I_Protagonist_VR_F']) then {
		50 cutText [(format ['Object %1 not configured for this scenario',(getText (configFile >> 'CfgVehicles' >> _type >> 'displayName'))]),'PLAIN'];
		[17,_object] remoteExec ['QS_fnc_remoteExec',2,FALSE];
	};
};
if (_typeL in [
		"box_ind_ammo_f","box_t_east_ammo_f","box_east_ammo_f","box_nato_ammo_f","box_syndicate_ammo_f","box_ind_wps_f","box_t_east_wps_f","box_east_wps_f",
		"box_t_nato_wps_f","box_nato_wps_f","box_syndicate_wps_f","box_aaf_equip_f","box_csat_equip_f","box_nato_equip_f","box_ied_exp_f","box_ind_ammoord_f",
		"box_east_ammoord_f","box_nato_ammoord_f","box_ind_grenades_f","box_east_grenades_f","box_nato_grenades_f","box_ind_wpslaunch_f","box_east_wpslaunch_f",
		"box_nato_wpslaunch_f","box_syndicate_wpslaunch_f","box_ind_wpsspecial_f","box_t_east_wpsspecial_f","box_east_wpsspecial_f","box_t_nato_wpsspecial_f",
		"box_nato_wpsspecial_f","box_gen_equip_f","box_ind_support_f","box_east_support_f","box_nato_support_f","box_aaf_uniforms_f","box_csat_uniforms_f",
		"box_nato_uniforms_f","flexibletank_01_forest_f","flexibletank_01_sand_f","land_plasticcase_01_large_f","land_plasticcase_01_medium_f","land_plasticcase_01_small_f",
		"land_metalcase_01_large_f","land_metalcase_01_medium_f","land_metalcase_01_small_f"
	]) then {
	_object setVariable ['QS_RD_draggable',TRUE,TRUE];
	[_object,1,nil] call (missionNamespace getVariable 'QS_fnc_customInventory');
};
if (_typeL in [
	"b_slingload_01_repair_f","b_slingload_01_medevac_f","b_slingload_01_fuel_f","b_slingload_01_ammo_f","b_slingload_01_cargo_f",
	"land_pod_heli_transport_04_medevac_f","land_pod_heli_transport_04_covered_f","land_pod_heli_transport_04_ammo_f","land_pod_heli_transport_04_box_f","land_pod_heli_transport_04_repair_f",
	"land_pod_heli_transport_04_medevac_black_f","land_pod_heli_transport_04_covered_black_f","land_pod_heli_transport_04_ammo_black_f","land_pod_heli_transport_04_box_black_f","land_pod_heli_transport_04_repair_black_f",
	"land_pod_heli_transport_04_fuel_f","land_pod_heli_transport_04_fuel_black_f",
	"land_pod_heli_transport_04_bench_f","land_pod_heli_transport_04_bench_black_f",
	"box_nato_ammoveh_f","box_ind_ammoveh_f","box_east_ammoveh_f",
	"b_cargonet_01_ammo_f","o_cargonet_01_ammo_f","i_cargonet_01_ammo_f","c_idap_cargonet_01_supplies_f",
	"cargonet_01_box_f",
	"cargonet_01_barrels_f",
	"b_supplycrate_f","o_supplycrate_f","i_supplycrate_f","c_t_supplycrate_f","c_supplycrate_f","ig_supplycrate_f","c_idap_supplycrate_f",
	"land_device_slingloadable_f",
	"land_cargobox_v1_f",
	"land_cargo10_yellow_f","land_cargo10_white_f","land_cargo10_sand_f","land_cargo10_red_f","land_cargo10_orange_f","land_cargo10_military_green_f","land_cargo10_light_green_f","land_cargo10_light_blue_f","land_cargo10_grey_f","land_cargo10_cyan_f","land_cargo10_brick_red_f","land_cargo10_blue_f",
	"land_cargo20_yellow_f","land_cargo20_white_f","land_cargo20_sand_f","land_cargo20_red_f","land_cargo20_orange_f","land_cargo20_military_green_f","land_cargo20_light_green_f","land_cargo20_light_blue_f","land_cargo20_grey_f","land_cargo20_cyan_f","land_cargo20_brick_red_f","land_cargo20_blue_f",
	"land_watertank_f",
	"land_cargo10_idap_f","land_cargo20_idap_f",'land_paperbox_01_small_stacked_f','land_waterbottle_01_stack_f'
	]) then {
	_object setVariable ['QS_ropeAttached',FALSE,TRUE];
};
if ((_object isKindOf 'LandVehicle') || {(_object isKindOf 'Air')} || {(_object isKindOf 'Ship')} || {(_object isKindOf 'Reammobox_F')}) exitWith {
	_object setFuel (0.4 + (random 0.45));
	_object setUnloadInCombat [FALSE,FALSE];
	if ((random 1) > 0.333) then {
		_object allowCrewInImmobile TRUE;
	};
	if ((_object isKindOf 'LandVehicle') || {(_object isKindOf 'Ship')}) then {
		if (_object isKindOf 'LandVehicle') then {
			_object setConvoySeparation 50;
			_object forceFollowRoad TRUE;
		} else {
			_object forceSpeed (getNumber (configFile >> 'CfgVehicles' >> _type >> 'maxSpeed'));
		};
	};
	[_object,1,[]] call (missionNamespace getVariable 'QS_fnc_vehicleLoadouts');
	if (_object isKindOf 'Helicopter') then {
		if ((toLower _type) in ["b_heli_light_01_armed_f","b_heli_attack_01_f","o_heli_light_02_f","o_heli_light_02_v2_f","i_heli_light_03_f","o_heli_attack_02_f","o_heli_attack_02_black_f",'o_heli_light_02_dynamicloadout_f','o_heli_attack_02_dynamicloadout_black_f','o_heli_attack_02_dynamicloadout_black_f','i_heli_light_03_dynamicloadout_f','b_heli_attack_01_dynamicloadout_f','b_heli_light_01_dynamicloadout_f']) then {
			if (!(missionNamespace getVariable 'QS_armedAirEnabled')) then {
				50 cutText ['Armed aircraft currently disabled','PLAIN DOWN',1];
				[17,_object] remoteExec ['QS_fnc_remoteExec',2,FALSE];
			};
		};
	};
	if (_object isKindOf 'Plane') then {
		if ((toLower (typeOf _object)) isEqualTo 'i_c_plane_civil_01_f') then {
			{
				_object addWeaponTurret _x;
			} forEach [
				['CMFlareLauncher',[-1]],
				['M134_minigun',[-1]]
			];
			{
				_object addMagazineTurret _x;
			} forEach [
				['60Rnd_CMFlare_Chaff_Magazine',[-1]],
				['60Rnd_CMFlare_Chaff_Magazine',[-1]],
				['60Rnd_CMFlare_Chaff_Magazine',[-1]],
				['60Rnd_CMFlare_Chaff_Magazine',[-1]],
				['60Rnd_CMFlare_Chaff_Magazine',[-1]],
				['5000Rnd_762x51_Yellow_Belt',[-1]],
				['5000Rnd_762x51_Yellow_Belt',[-1]],
				['5000Rnd_762x51_Yellow_Belt',[-1]],
				['60Rnd_40mm_GPR_Tracer_Red_shells',[-1]]
			];
		};
		if (!(missionNamespace getVariable 'QS_armedAirEnabled')) then {
			50 cutText ['Armed aircraft currently disabled','PLAIN DOWN',1];
			[17,_object] remoteExec ['QS_fnc_remoteExec',2,FALSE];
		};
	};
	if (!isNull _object) then {
		[47,_object] remoteExec ['QS_fnc_remoteExec',2,FALSE];
	};
};
if (isNull _object) exitWith {};
if (['Module',_type,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) then {
	if (_type in [
		'ModulePostprocess_F','ModuleSkiptime_F','ModuleTimeMultiplier_F','ModuleWeather_F',
		'ModuleBootcampStage_F','ModuleHint_F','ModuleDiary_F','ModuleCountdown_F','ModuleEndMission_F',
		'ModuleRespawnTickets_F','ModuleMissionName_F','ModuleRespawnInventory_F','ModuleRespawnPositionWest_F',
		'ModuleRespawnPositionCiv_F','ModuleRespawnPositionGuer_F','ModuleRespawnPositionEast_F','ModuleVehicleRespawnPositionWest_F',
		'ModuleVehicleRespawnPositionCiv_F','ModuleVehicleRespawnPositionGuer_F','ModuleVehicleRespawnPositionEast_F',
		'ModuleObjectiveAttackDefend_F','ModuleObjectiveSector_F','ModuleObjectiveRaceCP_F','ModuleObjectiveRaceFinish_F',
		'ModuleObjectiveRaceStart_F','ModuleAnimalsButterflies_F'
	]) then {
		[17,_object] remoteExec ['QS_fnc_remoteExec',2,FALSE];
		closeDialog 0;
		50 cutText [format ['Module %1 not configured for this scenario',(getText (configFile >> 'CfgVehicles' >> _type >> 'displayName'))],'PLAIN'];
	} else {
		_module setVariable [
			'QS_curator_modules',
			((_module getVariable 'QS_curator_modules') + [_object]),
			TRUE
		];
	};
};
if (_object isKindOf 'Building') then {
	if (_type in ['Land_PillboxBunker_01_rectangle_F','Land_PillboxBunker_01_big_F','Land_PillboxBunker_01_hex_F']) then {
		_object setVectorUp [0,0,1];
	};
};
if (_object isKindOf 'House') then {
	if ((typeOf _object) in ['Land_Cargo_Tower_V4_F']) then {
		_object allowDamage FALSE;
	};
	_object setVariable ['QS_curator_spawnedObj',TRUE,TRUE];
};
if (!(
	(_x isKindOf 'Man') ||
	{(_x isKindOf 'Air')} ||
	{(_x isKindOf 'LandVehicle')} ||
	{(_x isKindOf 'Reammobox_F')} ||
	{(_x isKindOf 'Ship')} ||
	{(_x isKindOf 'StaticWeapon')}
)) then {
	_object setVariable ['QS_curator_spawnedObj',TRUE,TRUE];
};