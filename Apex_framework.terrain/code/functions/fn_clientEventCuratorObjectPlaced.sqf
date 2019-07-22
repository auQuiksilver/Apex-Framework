/*/
File: fn_clientEventCuratorObjectPlaced.sqf
Author:

	Quiksilver
	
Last modified:

	13/03/2018 A3 1.80 by Quiksilver
	
Description:

	Event Curator Object Placed
__________________________________________________/*/

params ['_module','_object'];
_type = typeOf _object;
_typeL = toLower _type;
if (_object isKindOf 'Man') exitWith {
	_side = side (group _object);
	if ((_side getFriend WEST) < 0.6) then {
		[_object] call (missionNamespace getVariable 'QS_fnc_setCollectible');
	};
	_object disableAI 'AUTOCOMBAT';
	_object disableAI 'COVER';
	(group _object) setSpeedMode 'FULL';
	if (_side isEqualTo CIVILIAN) then {
		if (_typeL in [
			'c_man_p_fugitive_f','c_man_p_shorts_1_f','c_man_p_fugitive_f_afro','c_man_p_shorts_1_f_afro',
			'c_man_p_fugitive_f_asia','c_man_p_shorts_1_f_asia','c_man_p_fugitive_f_euro','c_man_p_shorts_1_f_euro'
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
			};
			[[_object],1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
			_QS_unit_side = side _object;
			if (['recon',_type,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) then {
				_object enableStamina FALSE;
				_object enableFatigue FALSE;
				_object setAnimSpeedCoef 1.1;
			};
			[[_object]] spawn (missionNamespace getVariable 'QS_fnc_serverTracers');
			if (['recon',_type,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) then {
				if ((side _object) isEqualTo EAST) then {
					_object addHeadgear 'H_HelmetSpecO_blk';
				};
				if ((random 1) > 0.5) then {
					_object addPrimaryWeaponItem (selectRandom ['optic_Nightstalker','optic_tws']);
				};
			};
			if ((['O_V_',_type,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) || {(['O_V_',_type,FALSE] call (missionNamespace getVariable 'QS_fnc_inString'))}) then {
				_object enableStamina FALSE;
				_object enableFatigue FALSE;
				_object setAnimSpeedCoef 1.25;
				[[_object],3] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
			};
		};
	};
	if (_typeL in ['c_soldier_vr_f','b_soldier_vr_f','o_soldier_vr_f','i_soldier_vr_f','b_protagonist_vr_f','o_protagonist_vr_f','i_protagonist_vr_f']) then {
		50 cutText [(format ['Object %1 not configured for this scenario',(getText (configFile >> 'CfgVehicles' >> _type >> 'displayName'))]),'PLAIN'];
		[17,_object] remoteExec ['QS_fnc_remoteExec',2,FALSE];
	};
};
if (_typeL in [
		'box_ind_ammo_f','box_t_east_ammo_f','box_east_ammo_f','box_nato_ammo_f','box_syndicate_ammo_f','box_ind_wps_f','box_t_east_wps_f','box_east_wps_f',
		'box_t_nato_wps_f','box_nato_wps_f','box_syndicate_wps_f','box_aaf_equip_f','box_csat_equip_f','box_nato_equip_f','box_ied_exp_f','box_ind_ammoord_f',
		'box_east_ammoord_f','box_nato_ammoord_f','box_ind_grenades_f','box_east_grenades_f','box_nato_grenades_f','box_ind_wpslaunch_f','box_east_wpslaunch_f',
		'box_nato_wpslaunch_f','box_syndicate_wpslaunch_f','box_ind_wpsspecial_f','box_t_east_wpsspecial_f','box_east_wpsspecial_f','box_t_nato_wpsspecial_f',
		'box_nato_wpsspecial_f','box_gen_equip_f','box_ind_support_f','box_east_support_f','box_nato_support_f','box_aaf_uniforms_f','box_csat_uniforms_f',
		'box_nato_uniforms_f','flexibletank_01_forest_f','flexibletank_01_sand_f','land_plasticcase_01_large_f','land_plasticcase_01_medium_f','land_plasticcase_01_small_f',
		'land_metalcase_01_large_f','land_metalcase_01_medium_f','land_metalcase_01_small_f'
	]) then {
	_object setVariable ['QS_RD_draggable',TRUE,TRUE];
	[_object,1,nil] call (missionNamespace getVariable 'QS_fnc_customInventory');
};
if (_typeL in [
	'b_slingload_01_repair_f','b_slingload_01_medevac_f','b_slingload_01_fuel_f','b_slingload_01_ammo_f','b_slingload_01_cargo_f',
	'land_pod_heli_transport_04_medevac_f','land_pod_heli_transport_04_covered_f','land_pod_heli_transport_04_ammo_f','land_pod_heli_transport_04_box_f','land_pod_heli_transport_04_repair_f',
	'land_pod_heli_transport_04_medevac_black_f','land_pod_heli_transport_04_covered_black_f','land_pod_heli_transport_04_ammo_black_f','land_pod_heli_transport_04_box_black_f','land_pod_heli_transport_04_repair_black_f',
	'land_pod_heli_transport_04_fuel_f','land_pod_heli_transport_04_fuel_black_f',
	'land_pod_heli_transport_04_bench_f','land_pod_heli_transport_04_bench_black_f',
	'box_nato_ammoveh_f','box_ind_ammoveh_f','box_east_ammoveh_f',
	'b_cargonet_01_ammo_f','o_cargonet_01_ammo_f','i_cargonet_01_ammo_f','c_idap_cargonet_01_supplies_f','i_e_cargonet_01_ammo_f',
	'cargonet_01_box_f',
	'cargonet_01_barrels_f',
	'b_supplycrate_f','o_supplycrate_f','i_supplycrate_f','c_t_supplycrate_f','c_supplycrate_f','ig_supplycrate_f','c_idap_supplycrate_f',
	'land_device_slingloadable_f',
	'land_cargobox_v1_f',
	'land_cargo10_yellow_f','land_cargo10_white_f','land_cargo10_sand_f','land_cargo10_red_f','land_cargo10_orange_f','land_cargo10_military_green_f','land_cargo10_light_green_f','land_cargo10_light_blue_f','land_cargo10_grey_f','land_cargo10_cyan_f','land_cargo10_brick_red_f','land_cargo10_blue_f',
	'land_cargo20_yellow_f','land_cargo20_white_f','land_cargo20_sand_f','land_cargo20_red_f','land_cargo20_orange_f','land_cargo20_military_green_f','land_cargo20_light_green_f','land_cargo20_light_blue_f','land_cargo20_grey_f','land_cargo20_cyan_f','land_cargo20_brick_red_f','land_cargo20_blue_f',
	'land_watertank_f',
	'land_cargo10_idap_f','land_cargo20_idap_f','land_paperbox_01_small_stacked_f','land_waterbottle_01_stack_f',
	'land_destroyer_01_boat_rack_01_f'
]) then {
	_object setVariable ['QS_ropeAttached',FALSE,TRUE];
	if (_typeL in ['land_destroyer_01_boat_rack_01_f']) then {
		_object allowDamage FALSE;
		[91] remoteExec ['QS_fnc_remoteExec',0,FALSE];
	};
};
if ((_object isKindOf 'LandVehicle') || {(_object isKindOf 'Air')} || {(_object isKindOf 'Ship')} || {(_object isKindOf 'Reammobox_F')}) exitWith {
	if (_typeL in ['b_t_vtol_01_vehicle_f','b_t_vtol_01_vehicle_blue_f','b_t_vtol_01_vehicle_olive_f','b_t_vtol_01_armed_blue_f','b_t_vtol_01_armed_f','b_t_vtol_01_armed_olive_f']) then {
		{ 
			_object setObjectTextureGlobal [_forEachIndex,_x]; 
		} forEach (getArray (configFile >> 'CfgVehicles' >> _typeL >> 'TextureSources' >> 'Blue' >> 'textures'));
	};
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
		if (_typeL in ['b_heli_light_01_armed_f','b_heli_attack_01_f','o_heli_light_02_f','o_heli_light_02_v2_f','i_heli_light_03_f','o_heli_attack_02_f','o_heli_attack_02_black_f','o_heli_light_02_dynamicloadout_f','o_heli_attack_02_dynamicloadout_black_f','o_heli_attack_02_dynamicloadout_black_f','i_heli_light_03_dynamicloadout_f','i_e_heli_light_03_dynamicloadout_f','b_heli_attack_01_dynamicloadout_f','b_heli_light_01_dynamicloadout_f']) then {
			if (!(missionNamespace getVariable 'QS_armedAirEnabled')) then {
				50 cutText ['Armed aircraft currently disabled','PLAIN DOWN',1];
				[17,_object] remoteExec ['QS_fnc_remoteExec',2,FALSE];
			};
		};
	};
	if (_object isKindOf 'Plane') then {
		if (_typeL isEqualTo 'i_c_plane_civil_01_f') then {
			_object setVariable ['QS_ST_customDN','Q-51 Mosquito',TRUE];
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
	if (_object isKindOf 'Land_RepairDepot_01_base_F') then {
		_object setRepairCargo 0;
		_object setAmmoCargo 0;
		_object setFuelCargo 0;
	};
	if (alive _object) then {
		if (((crew _object) isEqualTo []) || {(!(((crew _object) findIf {((side _x) in [WEST])}) isEqualTo -1))}) then {
			[_object] call (missionNamespace getVariable 'QS_fnc_vSetup');
			[47,_object] remoteExec ['QS_fnc_remoteExec',2,FALSE];
		};
	};
};
if (isNull _object) exitWith {};
if (['Module',_type,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) then {
	if (_typeL in [
		'modulepostprocess_f','moduleskiptime_f','moduletimemultiplier_f','moduleweather_f',
		'modulebootcampstage_f','modulehint_f','modulediary_f','modulecountdown_f','moduleendmission_f',
		'modulerespawntickets_f','modulemissionname_f','modulerespawninventory_f','modulerespawnpositionwest_f',
		'modulerespawnpositionciv_f','modulerespawnpositionguer_f','modulerespawnpositioneast_f','modulevehiclerespawnpositionwest_f',
		'modulevehiclerespawnpositionciv_f','modulevehiclerespawnpositionguer_f','modulevehiclerespawnpositioneast_f',
		'moduleobjectiveattackdefend_f','moduleobjectivesector_f','moduleobjectiveracecp_f','moduleobjectiveracefinish_f',
		'moduleobjectiveracestart_f','moduleanimalsbutterflies_f'
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
	if (_typeL in ['land_pillboxbunker_01_rectangle_f','land_pillboxbunker_01_big_f','land_pillboxbunker_01_hex_f']) then {
		_object setVectorUp [0,0,1];
	};
};
if (_object isKindOf 'House') then {
	if (_typeL in ['land_cargo_tower_v4_f']) then {
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