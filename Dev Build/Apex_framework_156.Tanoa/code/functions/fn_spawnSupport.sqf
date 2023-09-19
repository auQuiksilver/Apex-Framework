/*/
File: fn_spawnSupport.sqf
Author:

	Quiksilver
	
Last Modified:

	8/07/2022 A3 2.10 by Quiksilver
	
Description:

	Spawn support vehicle
_________________________________________/*/

params ['_type','_mobile','_data'];
private _return = [];
private _vehicle = objNull;
private _unit = objNull;
private _grp = grpNull;
private _position = [0,0,0];
private _vehicleType = '';
if (_type isEqualTo 'REPAIR') then {
	_data params ['_roads'];
	if (_mobile) then {
		_vTypes = [
			'o_truck_03_repair_f',0.666,
			'o_truck_03_repair_f',0.666
		];
		_roads = _roads call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
		_roadIndex = _roads findIf {(((_x select [0,2]) nearEntities ['AllVehicles',8]) isEqualTo [])};
		if (_roadIndex isEqualTo -1) exitWith {};
		_grp = createGroup [EAST,TRUE];
		_roadPosition = _roads # _roadIndex;
		_vehicleType = selectRandomWeighted _vTypes;
		_vehicle = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _vehicleType,_vehicleType],_roadPosition,[],0,'NONE'];
		_vehicle setDir (random 360);
		_vehicle lock 3;
		(missionNamespace getVariable 'QS_AI_vehicles') pushBack _vehicle;
		_return pushBack _vehicle;
		clearMagazineCargoGlobal _vehicle;
		clearWeaponCargoGlobal _vehicle;
		clearItemCargoGlobal _vehicle;
		clearBackpackCargoGlobal _vehicle;
		_vehicle enableRopeAttach FALSE;
		_vehicle enableVehicleCargo FALSE;
		_vehicle allowCrewInImmobile [TRUE,TRUE];
		/*/_vehicle forceFollowRoad TRUE;/*/
		_vehicle setConvoySeparation 50;
		_vehicle setUnloadInCombat [FALSE,FALSE];
		_vehicle limitSpeed (random [30,40,50]);
		[0,_vehicle,EAST] call (missionNamespace getVariable 'QS_fnc_vSetup2');
		_vehicle addEventHandler ['GetOut',(missionNamespace getVariable 'QS_fnc_AIXDismountDisabled')];
		_vehicle addEventHandler ['Killed',(missionNamespace getVariable 'QS_fnc_vKilled2')];
		_vehicle setVariable ['QS_service_disabled',TRUE,TRUE];
		createVehicleCrew _vehicle;
		(crew _vehicle) joinSilent _grp;
		[_grp,(getPosATL _vehicle),-1,_roads,TRUE] call (missionNamespace getVariable 'QS_fnc_taskPatrolVehicle');
		_grp setVariable ['QS_AI_GRP',TRUE,QS_system_AI_owners];
		_grp setVariable ['QS_AI_GRP_CONFIG',['SUPPORT','SERVICES',(count (units _grp)),_vehicle],QS_system_AI_owners];
		_grp setVariable ['QS_AI_GRP_DATA',[TRUE,serverTime],QS_system_AI_owners];
		[(units _grp),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
		{
			_x call (missionNamespace getVariable 'QS_fnc_unitSetup');
			_return pushBack _x;
		} forEach (crew _vehicle);
	} else {
		_type = [
			'land_repairdepot_01_green_f',
			'land_repairdepot_01_tan_f'
		] select (worldName in ['Tanoa','Lingor3','Enoch']);
		// spawn beside road segment
	};
};
if (_type isEqualTo 'MEDICAL') then {
	_data params ['_roads'];
	// spawn near HQ
	if (_mobile) then {
		_vTypes = selectRandom ['o_truck_03_medical_f'];
		_roads = _roads call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
		_roadIndex = _roads findIf {(((_x select [0,2]) nearEntities ['AllVehicles',8]) isEqualTo [])};
		if (_roadIndex isEqualTo -1) exitWith {};
		_grp = createGroup [EAST,TRUE];
		_roadPosition = _roads # _roadIndex;
		_vehicle = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _vTypes,_vTypes],_roadPosition,[],0,'NONE'];
		_vehicle setDir (random 360);
		_vehicle lock 3;
		(missionNamespace getVariable 'QS_AI_vehicles') pushBack _vehicle;
		_return pushBack _vehicle;
		clearMagazineCargoGlobal _vehicle;
		clearWeaponCargoGlobal _vehicle;
		clearItemCargoGlobal _vehicle;
		clearBackpackCargoGlobal _vehicle;
		_vehicle enableRopeAttach FALSE;
		_vehicle enableVehicleCargo FALSE;
		_vehicle allowCrewInImmobile [TRUE,TRUE];
		/*/_vehicle forceFollowRoad TRUE;/*/
		_vehicle setConvoySeparation 50;
		_vehicle setUnloadInCombat [FALSE,FALSE];
		_vehicle limitSpeed (random [30,40,50]);
		[0,_vehicle,EAST] call (missionNamespace getVariable 'QS_fnc_vSetup2');
		_vehicle addEventHandler ['GetOut',(missionNamespace getVariable 'QS_fnc_AIXDismountDisabled')];
		_vehicle addEventHandler ['Killed',(missionNamespace getVariable 'QS_fnc_vKilled2')];
		createVehicleCrew _vehicle;
		(crew _vehicle) joinSilent _grp;
		[_grp,(getPosATL _vehicle),-1,_roads,TRUE] call (missionNamespace getVariable 'QS_fnc_taskPatrolVehicle');
		_grp setVariable ['QS_AI_GRP',TRUE,QS_system_AI_owners];
		_grp setVariable ['QS_AI_GRP_CONFIG',['SUPPORT','SERVICES',(count (units _grp)),_vehicle],QS_system_AI_owners];
		_grp setVariable ['QS_AI_GRP_DATA',[TRUE,serverTime],QS_system_AI_owners];
		[(units _grp),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
		{
			_x call (missionNamespace getVariable 'QS_fnc_unitSetup');
			_return pushBack _x;
		} forEach (crew _vehicle);
	} else {
		_vTypes = 'land_pod_heli_transport_04_medevac_f';
	};
};
_return;