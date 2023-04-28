/*/
File: fn_clientEventCuratorObjectPlaced.sqf
Author:

	Quiksilver
	
Last modified:

	9/04/2023 A3 2.12 by Quiksilver
	
Description:

	Event Curator Object Placed
__________________________________________________/*/

params ['_module','_object'];
_type = typeOf _object;
_typeL = toLowerANSI _type;
if (
	(uiNamespace getVariable ['QS_uiaction_alt',FALSE]) &&
	(!isNull curatorCamera)
) then {
	_object setDir (curatorCamera getDirVisual _object);
	_object setVectorUp (surfaceNormal (getPosWorld _object));
};
if ((missionNamespace getVariable ['QS_server_fps',100]) < 15) then {
	50 cutText [format ["%2 %1",missionNamespace getVariable ['QS_server_fps',100],localize 'STR_QS_Text_006'],'PLAIN DOWN',0.25,TRUE,TRUE];
};
if ((getAmmoCargo _object) > 0) then {
	_object setAmmoCargo 0;
};
if ((getFuelCargo _object) > 0) then {
	_object setFuelCargo 0;
};
if ((getRepairCargo _object) > 0) then {
	_object setRepairCargo 0;
};
if (_object isKindOf 'FlagCarrier') then {
	_object setVariable ['QS_zeus',TRUE,TRUE];
};
_simulation = QS_hashmap_configfile getOrDefaultCall [
	format ['cfgvehicles_%1_simulation',toLowerANSI (typeOf _object)],
	{(toLowerANSI (getText ((configOf _object) >> 'simulation')))},
	TRUE
];
_displayName = QS_hashmap_configfile getOrDefaultCall [
	format ['cfgvehicles_%1_displayname',toLowerANSI (typeOf _object)],
	{(getText ((configOf _object) >> 'displayname'))},
	TRUE
];
if ((toLowerANSI _simulation) in ['thingx']) then {
	_object setVariable ['QS_logistics',TRUE,TRUE];
};
if (
	((toLowerANSI _simulation) in ['helicopterrtd']) &&
	{((getMass _object) < 500)}
) then {
	_object setVariable ['QS_logistics',TRUE,TRUE];
};
if (_object isKindOf 'Man') exitWith {
	_object setVariable [format ['QS_zeus_%1',getPlayerUID player],TRUE,FALSE];
	_side = side (group _object);
	if ((_side getFriend WEST) < 0.6) then {
		[_object] call (missionNamespace getVariable 'QS_fnc_setCollectible');
	};
	//_object enableAIFeature ['AUTOCOMBAT',FALSE];
	//_object enableAIFeature ['COVER',FALSE];
	(group _object) setSpeedMode 'FULL';
	if (_object getUnitTrait 'medic') then {
		_object setVariable ['QS_unit_role','medic',TRUE];
		_object setVariable ['QS_ST_customDN',localize 'STR_QS_Text_376',TRUE];
	};
	if (_side isEqualTo CIVILIAN) then {
		if (_typeL in (['civilians_fugitives'] call QS_data_listUnits)) then {
			if (diag_tickTime > (_module getVariable ['QS_zeusMission_execCooldown',-1])) then {
				_module setVariable ['QS_zeusMission_execCooldown',diag_tickTime + 3,FALSE];
				['CAPTURE_MAN',_object] call (missionNamespace getVariable 'QS_fnc_zeusMission');
			};
			for '_i' from 0 to 1 step 1 do {
				_object setVariable ['QS_surrenderable',TRUE,TRUE];
			};
			(group _object) setBehaviourStrong 'CARELESS';
			_object enableAIFeature ['COVER',FALSE];
			_object addEventHandler [
				'Killed',
				{
					_killer = _this # 1;
					if (!isNull _killer) then {
						if (isPlayer _killer) then {
							_text = format [localize 'STR_QS_Chat_028',(name _killer)];
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
				[_object] spawn {
					uiSleep 1; 
					(_this # 0) setObjectTextureGlobal [0,'#(rgb,8,8,3)color(1,0.1,0,1)'];
				};
			};
		} else {
			_object addEventHandler [
				'Killed',
				{
					_killer = _this # 1;
					if (!isNull _killer) then {
						if (isPlayer _killer) then {
							_text = format ['%1 %2',(name _killer),localize 'STR_QS_Chat_088'];
							['systemChat',_text] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
						};
					};
				}
			];
		};
		_object setSkill 0;
		_object allowFleeing 0;
		{
			_object enableAIFeature [_x,FALSE];
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
			if ((side _object) in [WEST]) then {
				_object setVariable ['QS_RD_recruitable',TRUE,TRUE];
				if (_typeL in (['b_autoriflemen_1'] call QS_data_listUnits)) then {
					_weapons = ['lightmachineguns_1'] call QS_data_listItems;
					if ((backpack _object) isEqualTo '') then {
						_object addBackpack 'b_kitbag_rgr';
					};
					_object removeWeapon (handgunWeapon _object);
					_object removeWeapon (primaryWeapon _object);
					{
						_object removeMagazine _x;
					} forEach (magazines _object);
					[_object,(selectRandomWeighted _weapons),8] call (missionNamespace getVariable 'QS_fnc_addWeapon');
					_object addPrimaryWeaponItem (selectRandom (['optics_long_1'] call QS_data_listItems));
				} else {
					_object addPrimaryWeaponItem (selectRandom (['optics_normal_1'] call QS_data_listItems));
				};
			};
			[_object,group _object] call (missionNamespace getVariable 'QS_fnc_AISetTracers');
			[[_object],1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
			_QS_unit_side = side _object;
			if (['recon',_type,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) then {
				_object enableStamina FALSE;
				_object enableFatigue FALSE;
				_object setAnimSpeedCoef 1.1;
			};
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
	if (_typeL in (['vr_entities_1'] call QS_data_listUnits)) then {
		50 cutText [(format ['%1 - %2',_displayName,localize 'STR_QS_Text_007']),'PLAIN'];
		[17,_object] remoteExec ['QS_fnc_remoteExec',2,FALSE];
	};
};
if (_typeL in (['draggable_boxes_1'] call QS_data_listVehicles)) then {
	_object setVariable ['QS_RD_draggable',TRUE,TRUE];
	[_object,1,nil] call (missionNamespace getVariable 'QS_fnc_customInventory');
};
if (_typeL in (['towable_objects_1'] call QS_data_listVehicles)) then {
	if (_typeL in ['land_destroyer_01_boat_rack_01_f']) then {
		_object allowDamage FALSE;
		[91] remoteExec ['QS_fnc_remoteExec',0,FALSE];
	};
};

if ((['LandVehicle','Air','Ship','Reammobox_F','Cargo10_base_F'] findIf { _object isKindOf _x }) isNotEqualTo -1) exitWith {
	_object setVariable ['QS_vehicle_massdef',[getMass _object,getCenterOfMass _object],TRUE];
	if (_typeL in ['b_t_vtol_01_vehicle_f','b_t_vtol_01_vehicle_blue_f','b_t_vtol_01_vehicle_olive_f','b_t_vtol_01_armed_blue_f','b_t_vtol_01_armed_f','b_t_vtol_01_armed_olive_f']) then {
		{ 
			_object setObjectTextureGlobal [_forEachIndex,_x]; 
		} forEach (getArray ((configOf _object) >> 'TextureSources' >> 'Blue' >> 'textures'));
	};
	_object setFuel (0.4 + (random 0.45));
	_object setUnloadInCombat [FALSE,FALSE];
	_object allowCrewInImmobile [TRUE,TRUE];
	if ((_object isKindOf 'LandVehicle') || {(_object isKindOf 'Ship')}) then {
		if (_object isKindOf 'LandVehicle') then {
			_object setConvoySeparation 50;
			_object forceFollowRoad TRUE;
		} else {
			_speed = QS_hashmap_configfile getOrDefaultCall [
				format ['cfgvehicles_%1_maxspeed',toLowerANSI _type],
				{getNumber ((configOf _object) >> 'maxSpeed')},
				TRUE
			];
			_object forceSpeed _speed;
		};
	};
	[_object,1,[]] call (missionNamespace getVariable 'QS_fnc_vehicleLoadouts');
	if (
		(_object isKindOf 'Helicopter') &&
		{(_typeL in (['armed_heli_types_1'] call QS_data_listVehicles))} &&
		{(!(missionNamespace getVariable ['QS_armedAirEnabled',TRUE]))}
	) then {
		50 cutText [localize 'STR_QS_Text_008','PLAIN DOWN',1];
		[17,_object] remoteExec ['QS_fnc_remoteExec',2,FALSE];
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
			50 cutText [localize 'STR_QS_Text_008','PLAIN DOWN',1];
			[17,_object] remoteExec ['QS_fnc_remoteExec',2,FALSE];
		};
	};
	if (_object isKindOf 'Land_RepairDepot_01_base_F') then {
		_object setRepairCargo 0;
		_object setAmmoCargo 0;
		_object setFuelCargo 0;
	};
	
	if (
		((crew _object) isEqualTo []) || 
		{(((crew _object) findIf {((side _x) in [WEST])}) isNotEqualTo -1)}
	) then {
		[47,_object] remoteExec ['QS_fnc_remoteExec',2,FALSE];
	};
};
if (isNull _object) exitWith {};
if (['Module',_type,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) then {
	if (_typeL in (['zeus_modules_blocked_1'] call QS_data_listOther)) then {
		[17,_object] remoteExec ['QS_fnc_remoteExec',2,FALSE];
		closeDialog 0;
		50 cutText [format ['%1 - %2',_displayName,localize 'STR_QS_Text_009'],'PLAIN'];
	} else {
		_module setVariable ['QS_curator_modules',((_module getVariable ['QS_curator_modules',[]]) + [_object]),TRUE];
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

if ((['LandVehicle','Air','Ship','Reammobox_F','Man','StaticWeapon','ThingX'] findIf { _object isKindOf _x }) isEqualTo -1) then {
	// Houses, props and fortifications
	_object setVariable ['QS_curator_spawnedObj',TRUE,TRUE];
};