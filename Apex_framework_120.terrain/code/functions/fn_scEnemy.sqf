/*/
File: fn_scEnemy.sqf
Author: 

	Quiksilver

Last Modified:

	20/04/2018 A3 1.82 by Quiksilver

Description:

	SC Enemy
____________________________________________________________________________/*/

scriptName 'QS SC Spawn Enemy';
params ['_QS_module_virtualSectors_vehiclesEnabled'];
private [
	'_centerPos','_staticTypes','_grpCount','_airTypes','_engineerType','_infUrbanTypes','_aaTypes','_mrapTypes','_playerThreshold','_vehTypes','_isArmedAirEnabled','_mortGunnerType',
	'_pilotType','_jtacType','_officerType','_infantryGroupType','_randomPos','_radialIncrement','_radialOffset','_radialStart','_radialPatrolPositions',
	'_patrolPosition','_grp','_entityArray','_side','_maxRadialPatrolInfantry','_spawnedRadialPatrolInfantry','_roadsValid','_allowVehicles','_spawnedPatrolVehicles',
	'_maxPatrolVehicles','_roadsValidCopy','_roadsValidPositions','_maxSniperTeams','_spawnedSniperTeams','_positionASL','_position','_allowedGarrison','_areaHouses',
	'_areaBuildingPositions','_house','_countAreaBuildingPositions','_areaBuildingPositionIndex','_indUnitTypes','_unit','_boatArray','_boatPatrolEnabled',
	'_maxStaticWeapons','_spawnedStaticWeapons','_staticWeaponPositions','_countStaticWeaponPositions','_staticWeaponsEnabled','_staticSpawned','_allBuildingPositions',
	'_areaHousesWithPositions','_increment','_air','_airType','_arrayHelicopters','_arrayInfPatrols','_arrayVehicles','_arrayGarrison','_arrayBoat','_arraySniper','_randomRoadPosition',
	'_randomRoad','_vehicleRoadPatrolPositions'
];
_isHCActive = missionNamespace getVariable ['QS_HC_Active',FALSE];
_centerPos = missionNamespace getVariable 'QS_AOpos';
_centerPos set [2,0];
_centerRadius = missionNamespace getVariable 'QS_aoSize';
_worldName = worldName;
_worldSize = worldSize;
_entityArray = [];
_randomPos = [0,0,0];
_radialIncrement = 45;
_radialOffset = 0;
_radialStart = 0;
_radialPatrolPositions = [];
_patrolPosition = [0,0,0];
_playerCount = count allPlayers;
_playerThreshold = 30;
_roadsValidCopy = [];
_unit = objNull;
_roadsValid = ((_centerPos select [0,2]) nearRoads _centerRadius) select {((_x isEqualType objNull) && (!((roadsConnectedTo _x) isEqualTo [])))};
_allowVehicles = _QS_module_virtualSectors_vehiclesEnabled;
if (_allowVehicles) then {
	_roadsValid = _roadsValid call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
	_roadsValidCopy = _roadsValid;
	_roadsValidPositions = _roadsValid apply {(getPosATL _x)};
};
comment 'Do unscheduled';
_fnc_getBuildingPositions = {
	params ['_centerPos','_centerRadius'];
	private _areaHouses = nearestObjects [_centerPos,['House','Building'],_centerRadius,TRUE];
	_areaHouses = _areaHouses + ((allSimpleObjects []) select {((_x distance2D _centerPos) <= _centerRadius)});
	_areaHousesWithPositions = _areaHouses select {(!((_x buildingPos -1) isEqualTo []))};
	_areaHousesWithPositions;
};
_areaHousesWithPositions = [_centerPos,_centerRadius] call _fnc_getBuildingPositions;
_allowedGarrison = (count _areaHousesWithPositions) > 6;
_staticWeaponsEnabled = FALSE;
_maxStaticWeapons = 0;
_spawnedStaticWeapons = 0;
_staticWeaponPositions = [];
_countStaticWeaponPositions = 0;
if (_allowedGarrison) then {
	_house = objNull;
	_areaBuildingPositions = [];
	private _index = 0;
	{
		_house = _x;
		if (_house isEqualType objNull) then {
			{
				0 = _areaBuildingPositions pushBack _x;
			} forEach (_house buildingPos -1);
		};
		_index = _forEachIndex;
	} forEach _areaHousesWithPositions;
	_countAreaBuildingPositions = count _areaBuildingPositions;
	_areaBuildingPositions = _areaBuildingPositions call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
	_areaBuildingPositionIndex = 0;
	_staticWeaponPositions = _areaBuildingPositions select {
		(((_x select 2) > 5) && (([objNull,'GEOM',objNull] checkVisibility [(AGLToASL _x),[((AGLToASL _x) select 0),((AGLToASL _x) select 1),(((AGLToASL _x) select 2) + 50)]]) isEqualTo 1))
	};
	_countStaticWeaponPositions = count _staticWeaponPositions;
	if (_countStaticWeaponPositions > 0) then {
		_staticWeaponsEnabled = TRUE;
	};
	_allBuildingPositions = [];
};
_maxRadialPatrolInfantry = 0;
_spawnedRadialPatrolInfantry = 0;
_maxSniperTeams = 0;
_spawnedSniperTeams = 0;
_maxBuildingInfantry = 0;
_spawnedBuildingInfantry = 0;
_maxPatrolVehicles = 0;
_spawnedPatrolVehicles = 0;
_boatPatrolEnabled = TRUE;
_isArmedAirEnabled = missionNamespace getVariable ['QS_armedAirEnabled',TRUE];
_grpCount = -1;
_grp = grpNull;
_side = EAST;
_infantryGroupType = '';
_infantryGroupTypes = [
	'OIA_InfSentry',1,
	'OIA_InfSquad',3,
	'OIA_InfTeam',4,
	'OIA_InfTeam_LAT',3,
	'OIA_InfAssault',2,
	'OIA_InfTeam_AA',2,
	'OIA_InfTeam_AT',2,
	'OIA_ARTeam',2,
	'OIA_InfTeam_HAT',2
];
if (_worldName in ['Tanoa','Enoch']) then {
	_staticTypes = ['O_HMG_01_high_F'];
	_airTypes = ['i_e_heli_light_03_dynamicloadout_f','O_Heli_Light_02_dynamicLoadout_F','O_Heli_Light_02_v2_F'];
	_engineerType = 'O_T_Engineer_F';
	_aaTypes = ['O_T_APC_Tracked_02_AA_ghex_F'];
	_mrapTypes = ['O_T_MRAP_02_gmg_ghex_F','O_T_MRAP_02_hmg_ghex_F','O_T_LSV_02_armed_F'];
	if (_playerCount >= _playerThreshold) then {
		if (_isArmedAirEnabled) then {
			_vehTypes = [
				'O_T_APC_Tracked_02_cannon_ghex_F',
				'O_T_APC_Wheeled_02_rcws_v2_ghex_F',
				'O_T_APC_Tracked_02_cannon_ghex_F',
				'I_APC_Wheeled_03_cannon_F',
				'I_APC_tracked_03_cannon_F',
				'B_APC_Tracked_01_rcws_F',
				'O_T_MBT_02_cannon_ghex_F',
				'I_APC_Wheeled_03_cannon_F',
				'I_MBT_03_cannon_F',
				'O_T_MRAP_02_gmg_ghex_F',
				'O_T_MRAP_02_hmg_ghex_F',
				'O_T_LSV_02_armed_F',
				'O_T_MRAP_02_gmg_ghex_F',
				'O_T_MRAP_02_hmg_ghex_F',
				'O_T_LSV_02_armed_F'
			];
		} else {
			_vehTypes = [
				'O_T_APC_Tracked_02_cannon_ghex_F',
				'O_T_APC_Wheeled_02_rcws_v2_ghex_F',
				'O_T_APC_Tracked_02_cannon_ghex_F',
				'O_T_APC_Tracked_02_cannon_ghex_F',
				'O_T_APC_Wheeled_02_rcws_v2_ghex_F',
				'O_T_APC_Tracked_02_cannon_ghex_F',
				'I_APC_Wheeled_03_cannon_F',
				'I_APC_tracked_03_cannon_F',
				'B_APC_Tracked_01_rcws_F',
				'O_T_MBT_02_cannon_ghex_F',
				'I_APC_Wheeled_03_cannon_F',
				'I_MBT_03_cannon_F',
				'O_T_MRAP_02_gmg_ghex_F',
				'O_T_MRAP_02_hmg_ghex_F',
				'O_T_LSV_02_armed_F',
				'O_T_MRAP_02_gmg_ghex_F',
				'O_T_MRAP_02_hmg_ghex_F',
				'O_T_LSV_02_armed_F'
			];		
		};
	} else {
		if (_isArmedAirEnabled) then {
			_vehTypes = [
				'O_T_APC_Tracked_02_cannon_ghex_F',
				'O_T_APC_Wheeled_02_rcws_v2_ghex_F',
				'I_APC_Wheeled_03_cannon_F',
				'I_MRAP_03_hmg_F'
			];
		} else {
			_vehTypes = [
				'O_T_APC_Tracked_02_cannon_ghex_F',
				'O_T_APC_Wheeled_02_rcws_v2_ghex_F',
				'I_APC_Wheeled_03_cannon_F',
				'I_MRAP_03_hmg_F'
			];
		};
	};
	_mortGunnerType = 'O_T_Support_Mort_F';
	_pilotType = 'O_T_Helipilot_F';
	_jtacType = 'O_T_Recon_JTAC_F';
	_officerType = 'O_T_Officer_F';
} else {
	_staticTypes = ['O_HMG_01_high_F'];
	_airTypes = ['i_heli_light_03_dynamicloadout_f','O_Heli_Light_02_dynamicLoadout_F','O_Heli_Light_02_v2_F','O_Heli_Attack_02_dynamicLoadout_black_F','O_Heli_Attack_02_dynamicLoadout_F'];
	_engineerType = 'O_engineer_F';
	_aaTypes = ['O_APC_Tracked_02_AA_F','O_APC_Tracked_02_AA_F','O_APC_Tracked_02_AA_F','B_APC_Tracked_01_AA_F','O_APC_Tracked_02_AA_F'];
	_mrapTypes = ['O_MRAP_02_gmg_F','O_MRAP_02_hmg_F','O_LSV_02_armed_F'];
	if (_playerCount >= _playerThreshold) then {
		if (_isArmedAirEnabled) then {
			_vehTypes = [
				'O_MBT_02_cannon_F',
				'O_APC_Tracked_02_cannon_F',
				'O_APC_Wheeled_02_rcws_v2_F',
				'O_APC_Tracked_02_cannon_F',
				'I_APC_Wheeled_03_cannon_F',
				'I_APC_tracked_03_cannon_F',
				'I_MBT_03_cannon_F',
				'B_APC_Tracked_01_rcws_F',
				'O_MBT_02_cannon_F',
				'I_APC_tracked_03_cannon_F',
				'O_MRAP_02_gmg_F',
				'O_MRAP_02_hmg_F',
				'O_LSV_02_armed_F',
				'O_MRAP_02_gmg_F',
				'O_MRAP_02_hmg_F',
				'O_LSV_02_armed_F'
			];
		} else {
			_vehTypes = [
				'O_MBT_02_cannon_F',
				'O_APC_Tracked_02_cannon_F',
				'O_APC_Wheeled_02_rcws_v2_F',
				'O_APC_Tracked_02_cannon_F',
				'I_APC_Wheeled_03_cannon_F',
				'O_APC_Wheeled_02_rcws_v2_F',
				'O_APC_Tracked_02_cannon_F',
				'I_APC_Wheeled_03_cannon_F',
				'I_APC_tracked_03_cannon_F',
				'I_MBT_03_cannon_F',
				'B_APC_Tracked_01_rcws_F',
				'O_MBT_02_cannon_F',
				'I_APC_tracked_03_cannon_F',
				'O_MRAP_02_gmg_F',
				'O_MRAP_02_hmg_F',
				'O_LSV_02_armed_F',
				'O_MRAP_02_gmg_F',
				'O_MRAP_02_hmg_F',
				'O_LSV_02_armed_F'
			];	
		};
	} else {
		if (_isArmedAirEnabled) then {
			_vehTypes = [
				'O_MBT_02_cannon_F',
				'O_APC_Tracked_02_cannon_F',
				'O_APC_Wheeled_02_rcws_v2_F',
				'O_APC_Tracked_02_cannon_F',
				'I_APC_Wheeled_03_cannon_F',
				'I_APC_tracked_03_cannon_F',
				'I_MBT_03_cannon_F',
				'B_APC_Tracked_01_rcws_F',
				'O_MBT_02_cannon_F',
				'I_APC_tracked_03_cannon_F',
				'O_MRAP_02_gmg_F',
				'O_MRAP_02_hmg_F',
				'O_LSV_02_armed_F',
				'O_MRAP_02_gmg_F',
				'O_MRAP_02_hmg_F',
				'O_LSV_02_armed_F'
			];
		} else {
			_vehTypes = [
				'O_MBT_02_cannon_F',
				'O_APC_Tracked_02_cannon_F',
				'O_APC_Wheeled_02_rcws_v2_F',
				'O_APC_Tracked_02_cannon_F',
				'I_APC_Wheeled_03_cannon_F',
				'O_APC_Wheeled_02_rcws_v2_F',
				'O_APC_Tracked_02_cannon_F',
				'I_APC_Wheeled_03_cannon_F',
				'I_APC_tracked_03_cannon_F',
				'I_MBT_03_cannon_F',
				'B_APC_Tracked_01_rcws_F',
				'O_MBT_02_cannon_F',
				'I_APC_tracked_03_cannon_F',
				'O_MRAP_02_gmg_F',
				'O_MRAP_02_hmg_F',
				'O_LSV_02_armed_F',
				'O_MRAP_02_gmg_F',
				'O_MRAP_02_hmg_F',
				'O_LSV_02_armed_F'
			];
		};
	};
	_mortGunnerType = 'O_support_MG_F';
	_pilotType = 'O_Helipilot_F';
	_jtacType = 'O_recon_JTAC_F';
	_officerType = 'O_officer_F';
};

diag_log '****************************************************';
diag_log '***** SC ENEMY ***** Spawning Helicopter ***********';
diag_log '****************************************************';

_arrayHelicopters = [];
_grp = createGroup [_side,TRUE];
_randomPos = ['RADIUS',_centerPos,_centerRadius,'LAND',[],FALSE,[],[],TRUE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
if (_playerCount > 20) then {
	_airTypes = if (_worldName isEqualTo 'Tanoa') then [
		{['O_Heli_Light_02_dynamicLoadout_F','i_e_heli_light_03_dynamicloadout_f']},
		{['O_Heli_Light_02_dynamicLoadout_F','i_heli_light_03_dynamicloadout_f','O_Heli_Attack_02_dynamicLoadout_black_F','O_Heli_Attack_02_dynamicLoadout_F']}
	];
} else {
	_airTypes = if (_worldName isEqualTo 'Tanoa') then [
		{['O_Heli_Light_02_dynamicLoadout_F','i_e_heli_light_03_dynamicloadout_f']},
		{['O_Heli_Light_02_dynamicLoadout_F','i_heli_light_03_dynamicloadout_f','O_Heli_Attack_02_dynamicLoadout_black_F','O_Heli_Attack_02_dynamicLoadout_F']}
	];
};
_airType = selectRandom _airTypes;
_air = createVehicle [_airType,[(_randomPos select 0),(_randomPos select 1),1000],[],0,'NONE'];
missionNamespace setVariable [
	'QS_analytics_entities_created',
	((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
	FALSE
];
_air engineOn TRUE;
_air addEventHandler [
	'GetOut',
	{
		(_this select 2) setDamage 1;
	}
];
[_air,([1,2] select ((random 1) > 0.5)),[]] call (missionNamespace getVariable 'QS_fnc_vehicleLoadouts');
clearMagazineCargoGlobal _air;
clearWeaponCargoGlobal _air;
clearItemCargoGlobal _air;
clearBackpackCargoGlobal _air;
_air setPos [(_randomPos select 0),(_randomPos select 1),300];
_air enableRopeAttach FALSE;
_air setVariable ['QS_dynSim_ignore',TRUE,TRUE];
_air spawn {
	for '_x' from 0 to 149 step 1 do {
		_this setVelocity [0,0,0];
		uiSleep 0.1;
	};
};
_grp addVehicle _air;
_unit = _grp createUnit [_pilotType,_randomPos,[],0,'NONE'];
missionNamespace setVariable [
	'QS_analytics_entities_created',
	((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
	FALSE
];
_unit = _unit call (missionNamespace getVariable 'QS_fnc_unitSetup');
_unit assignAsDriver _air;
_unit moveInDriver _air;
(missionNamespace getVariable 'QS_AI_supportProviders_CASHELI') pushBack (effectiveCommander _air);
if (!((typeOf _air) in ['O_Heli_Light_02_v2_F','O_Heli_Light_02_dynamicLoadout_F'])) then {
	_unit = _grp createUnit [_pilotType,_randomPos,[],0,'NONE'];
	missionNamespace setVariable [
		'QS_analytics_entities_created',
		((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
		FALSE
	];
	_unit = _unit call (missionNamespace getVariable 'QS_fnc_unitSetup');
	_unit assignAsTurret [_air,[0]];
	_unit moveInTurret [_air,[0]];
	/*/
	_unit assignAsGunner _air;
	_unit moveInGunner _air;
	/*/
};
if ((toLower _airType) in ['i_heli_light_03_dynamicloadout_f','i_e_heli_light_03_dynamicloadout_f']) then {
	_unit = _grp createUnit [(['O_Soldier_AR_F','O_T_Soldier_AR_F'] select (_worldName in ['Tanoa','Enoch'])),[0,0,0],[],0,'NONE'];
	_unit addBackpack 'B_AssaultPack_blk';
	[_unit,'MMG_01_hex_ARCO_LP_F',4] call (missionNamespace getVariable 'QS_fnc_addWeapon');
	_unit addPrimaryWeaponItem 'optic_lrps';
	_unit moveInCargo [_air,0];
	_entityArray pushBack _unit;
	_unit = _grp createUnit [(['O_Soldier_AR_F','O_T_Soldier_AR_F'] select (_worldName in ['Tanoa','Enoch'])),[0,0,0],[],0,'NONE'];
	_unit addBackpack 'B_AssaultPack_blk';
	[_unit,'MMG_01_hex_ARCO_LP_F',4] call (missionNamespace getVariable 'QS_fnc_addWeapon');
	_unit addPrimaryWeaponItem 'optic_lrps';
	_unit moveInCargo [_air,1];
	_entityArray pushBack _unit;
	missionNamespace setVariable ['QS_analytics_entities_created',((missionNamespace getVariable 'QS_analytics_entities_created') + 2),FALSE];
	if (!(sunOrMoon isEqualTo 1)) then {
		(_air turretUnit [0]) action ['SearchlightOn',_air];
	};
};
[(units _grp),4] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
_grp setBehaviourStrong 'AWARE';
_grp setCombatMode 'RED';
_grp addVehicle _air;
_grp enableAttack TRUE;
_air lock 3;
_air setVehicleReceiveRemoteTargets TRUE;
_air setVehicleReportRemoteTargets TRUE;
_air enableDynamicSimulation FALSE;
['setFeatureType',_air,2] remoteExec ['QS_fnc_remoteExecCmd',-2,_air];
{
	_x setVariable ['QS_dynSim_ignore',TRUE,TRUE];
	_x enableDynamicSimulation FALSE;
	_x setVariable ['BIS_noCoreConversations',TRUE,FALSE];
	_x setVehicleReceiveRemoteTargets TRUE;
	_x setVehicleReportRemoteTargets TRUE;
	0 = _arrayHelicopters pushBack _x;
	0 = _entityArray pushBack _x;
} count (units _grp);
_entityArray pushBack _air;
_arrayHelicopters pushBack _air;
_increment = (random 90);
_radialPatrolPositions = [];
for '_x' from 0 to 3 step 1 do {
	_position = _centerPos getPos [(_centerRadius * (selectRandom [1.5,2])),_increment];
	_position set [2,50];
	_radialPatrolPositions pushBack _position;
	_increment = _increment + (random 90);
};
_grp setVariable ['QS_AI_GRP',TRUE,FALSE];
_grp setVariable ['QS_AI_GRP_CONFIG',['SC','AIR_PATROL_HELI',(count (units _grp)),_air],FALSE];
_grp setVariable ['QS_AI_GRP_DATA',[],FALSE];
_grp setVariable ['QS_AI_GRP_TASK',['PATROL_AIR',_radialPatrolPositions,diag_tickTime,-1],FALSE];
_grp setVariable ['QS_AI_GRP_PATROLINDEX',0,FALSE];
_grp move (_radialPatrolPositions select 0);

diag_log '****************************************************';
diag_log '***** SC ENEMY ***** Spawning infantry patrols *****';
diag_log '****************************************************';

_spawnedRadialPatrolInfantry = 0;
if (_playerCount >= 0) then {_maxRadialPatrolInfantry = 16;};
if (_playerCount > 10) then {_maxRadialPatrolInfantry = 24;};
if (_playerCount > 20) then {_maxRadialPatrolInfantry = 32;};
if (_playerCount > 30) then {_maxRadialPatrolInfantry = 40;};
if (_playerCount > 40) then {_maxRadialPatrolInfantry = 48;};
if (_playerCount > 50) then {_maxRadialPatrolInfantry = 56;};
_arrayInfPatrols = [];
for '_x' from 0 to 1 step 0 do {
	if (_spawnedRadialPatrolInfantry >= _maxRadialPatrolInfantry) exitWith {};
	_randomPos = ['RADIUS',_centerPos,_centerRadius,'LAND',[1.5,0,0.5,3,0,FALSE,objNull],TRUE,[],[],TRUE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
	_infantryGroupType = selectRandomWeighted _infantryGroupTypes;
	_grp = [_randomPos,(random 360),_side,_infantryGroupType,FALSE,grpNull,TRUE,TRUE] call (missionNamespace getVariable 'QS_fnc_spawnGroup');
	[(units _grp),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
	{
		[_x] call (missionNamespace getVariable 'QS_fnc_setCollectible');
		_x setVehiclePosition [(getPosWorld _x),[],0,'CAN_COLLIDE'];
		_x setVariable ['QS_AI_UNIT_enabled',TRUE,FALSE];
		_spawnedRadialPatrolInfantry = _spawnedRadialPatrolInfantry + 1;
		_x allowDamage FALSE;
		_x call (missionNamespace getVariable 'QS_fnc_unitSetup');
		0 = _arrayInfPatrols pushBack _x;
		0 = _entityArray pushBack _x;
	} forEach (units _grp);
	comment 'Radial positions';
	_radialStart = round (random 360);
	_radialOffset = _centerRadius * (0.4 + (random 0.7));
	_radialPatrolPositions = [];
	_patrolPosition = _centerPos getPos [_radialOffset,_radialStart];
	if (!surfaceIsWater _patrolPosition) then {
		_radialPatrolPositions pushBack _patrolPosition;
	};
	for '_x' from 0 to 6 step 1 do {
		_radialStart = _radialStart + _radialIncrement;
		_patrolPosition = _centerPos getPos [_radialOffset,_radialStart];
		if (!surfaceIsWater _patrolPosition) then {
			_radialPatrolPositions pushBack _patrolPosition;
		};
	};
	if (!(_radialPatrolPositions isEqualTo [])) then {
		_radialPatrolPositions = _radialPatrolPositions call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
		comment 'Initial movement';
		_grp move (_radialPatrolPositions select 0);
		_grp setFormDir (_randomPos getDir (_radialPatrolPositions select 0));
	};
	_grp setSpeedMode 'NORMAL';
	_grp setBehaviour 'SAFE';
	_grp setCombatMode 'YELLOW';
	_grp setFormation 'WEDGE';
	_grp setVariable ['QS_AI_GRP',TRUE,(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
	_grp setVariable ['QS_AI_GRP_CONFIG',['SC','INF_PATROL_RADIAL',(count (units _grp))],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
	_grp setVariable ['QS_AI_GRP_DATA',[],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
	_grp setVariable ['QS_AI_GRP_TASK',['PATROL',_radialPatrolPositions,diag_tickTime,-1],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
	_grp setVariable ['QS_AI_GRP_PATROLINDEX',0,(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
	if (_isHCActive) then {
		_grp setVariable ['QS_grp_HC',TRUE,(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
	};
};

_arrayVehicles = [];

diag_log '****************************************************';
diag_log '***** SC ENEMY ***** Spawning vehicle patrols ******';
diag_log '****************************************************';

if (_playerCount >= 0) then {_maxPatrolVehicles = 1;};
if (_playerCount > 10) then {_maxPatrolVehicles = 2;};
if (_playerCount > 20) then {_maxPatrolVehicles = 2;};
if (_playerCount > 30) then {_maxPatrolVehicles = 3;};
if (_playerCount > 40) then {_maxPatrolVehicles = 3;};
if (_playerCount > 50) then {_maxPatrolVehicles = 4;};
for '_x' from 0 to 1 step 0 do {
	if (_spawnedPatrolVehicles >= _maxPatrolVehicles) exitWith {};
	if (_allowVehicles) then {
		_randomRoad = selectRandom _roadsValidCopy;	
		_randomRoadPosition = getPosATL _randomRoad;
	} else {
		_randomRoadPosition = [_centerPos,50,_centerRadius,2.5,0,0.4,0] call (missionNamespace getVariable 'QS_fnc_findSafePos');
	};
	if ((_randomRoadPosition nearEntities [['AllVehicles'],6]) isEqualTo []) then {
		if (_allowVehicles) then {
			_roadsValidCopy deleteAt (_roadsValidCopy find _randomRoad);
		};
		_vehicleType = selectRandomWeighted ([1] call (missionNamespace getVariable 'QS_fnc_getAIMotorPool'));
		_vehicle = createVehicle [_vehicleType,[(_randomRoadPosition select 0),(_randomRoadPosition select 1),((_randomRoadPosition select 2) + 5)],[],0,'NONE'];
		_spawnedPatrolVehicles = _spawnedPatrolVehicles + 1;
		missionNamespace setVariable [
			'QS_analytics_entities_created',
			((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
			FALSE
		];	
		_arrayVehicles pushBack _vehicle;
		_entityArray pushBack _vehicle;
		(missionNamespace getVariable 'QS_AI_vehicles') pushBack _vehicle;
		_vehicle lock 2;
		_vehicle allowDamage FALSE;
		_vehicle enableRopeAttach FALSE;
		_vehicle enableVehicleCargo FALSE;
		_vehicle forceFollowRoad TRUE;
		_vehicle setConvoySeparation 50;
		_vehicle addEventHandler ['Killed',(missionNamespace getVariable 'QS_fnc_vKilled2')];
		_vehicle allowCrewInImmobile TRUE;
		_vehicle setUnloadInCombat [TRUE,FALSE];
		[0,_vehicle,EAST,1] call (missionNamespace getVariable 'QS_fnc_vSetup2');
		_vehicle addEventHandler [
			'GetOut',
			{
				(_this select 2) setDamage 1;
				(_this select 0) setDamage 1;
			}
		];
		clearMagazineCargoGlobal _vehicle;
		clearWeaponCargoGlobal _vehicle;
		clearItemCargoGlobal _vehicle;
		clearBackpackCargoGlobal _vehicle;
		[_vehicle] call (missionNamespace getVariable 'QS_fnc_downgradeVehicleWeapons');
		if ((toLower _vehicleType) in ['b_apc_tracked_01_rcws_f','b_t_apc_tracked_01_rcws_f']) then {
			_grp = createGroup [_side,TRUE];
			_unit = _grp createUnit [_engineerType,_randomRoadPosition,[],0,'NONE'];
			_unit = _unit call (missionNamespace getVariable 'QS_fnc_unitSetup');
			_unit assignAsDriver _vehicle;
			_unit moveInDriver _vehicle;
			_unit = _grp createUnit [_engineerType,_randomRoadPosition,[],0,'NONE'];
			_unit = _unit call (missionNamespace getVariable 'QS_fnc_unitSetup');
			_unit assignAsGunner _vehicle;
			_unit moveInGunner _vehicle;
			_unit = _grp createUnit [_engineerType,_randomRoadPosition,[],0,'NONE'];
			_unit = _unit call (missionNamespace getVariable 'QS_fnc_unitSetup');
			_unit assignAsCommander _vehicle;
			_unit moveInCommander _vehicle;
		} else {
			_grp = createVehicleCrew _vehicle;
		};
		if (_allowVehicles) then {
			_vehicle setDir (_randomRoadPosition getDir (position ((roadsConnectedTo _randomRoad) select 0)));
		} else {
			_vehicle setDir (random 360);
		};
		_vehicle setVectorUp (surfaceNormal _randomRoadPosition);
		_vehicle setVehiclePosition [_randomRoadPosition,[],0,'NONE'];
		_grp addVehicle _vehicle;
		[(units _grp),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
		{
			missionNamespace setVariable [
				'QS_analytics_entities_created',
				((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
				FALSE
			];
			_x setVariable ['QS_AI_UNIT_enabled',TRUE,FALSE];
			_x setVariable ['BIS_noCoreConversations',TRUE,FALSE];
			_x setSpeaker 'NoVoice';
			_x allowDamage FALSE;
			_x call (missionNamespace getVariable 'QS_fnc_unitSetup');
			0 = _arrayVehicles pushBack _x;
			0 = _entityArray pushBack _x;
		} forEach (units _grp);
		/*/
		if (!isNull (gunner _vehicle)) then {
			(gunner _vehicle) setSkill 0.1;
			(gunner _vehicle) setSkill ['aimingAccuracy',(random [0.05,0.06,0.08])];
		};
		if (!isNull (commander _vehicle)) then {
			(commander _vehicle) setSkill 0.1;
			(commander _vehicle) setSkill ['aimingAccuracy',(random [0.05,0.06,0.08])];
		};
		/*/
		if (_allowVehicles) then {
			_vehicleRoadPatrolPositions = [];
			_vehicleRoadPatrolPositions pushBack (selectRandom _roadsValidPositions);
			for '_x' from 0 to 2 step 1 do {
				_vehicleRoadPatrolPositions pushBack (selectRandom (_roadsValidPositions select {((_x distance2D (_vehicleRoadPatrolPositions select ((count _vehicleRoadPatrolPositions) - 1))) > 35)}));
			};
			_grp setVariable ['QS_AI_GRP_TASK',['PATROL_VEH',_vehicleRoadPatrolPositions,diag_tickTime,-1],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
			_grp setVariable ['QS_AI_GRP_PATROLINDEX',0,(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
		} else {
			[_grp,_centerPos,_centerRadius,[],TRUE] call (missionNamespace getVariable 'QS_fnc_taskPatrolVehicle');
		};			
		_grp setSpeedMode 'LIMITED';
		_grp setBehaviour 'SAFE';
		_grp setCombatMode 'YELLOW';
		_grp setFormation 'COLUMN';
		_grp setVariable ['QS_AI_GRP',TRUE,(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
		_grp setVariable ['QS_AI_GRP_CONFIG',['SC','VEH_PATROL',(count (units _grp)),_vehicle],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
		_grp setVariable ['QS_AI_GRP_DATA',[],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
		if (_isHCActive) then {
			_grp setVariable ['QS_grp_HC',TRUE,(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
		};
		if (_allowVehicles) then {
			if (!(_vehicleRoadPatrolPositions isEqualTo [])) then {
				_grp setFormDir (_randomRoadPosition getDir (_vehicleRoadPatrolPositions select 0));
				_grp move (_vehicleRoadPatrolPositions select 0);
			};
		};
	};
};
if (_allowVehicles) then {
	private _supportData = [];
	private _supportEntities = [];
	private _supportElement = [];
	private _supportEntity = objNull;
	_supportData pushBack ['REPAIR',TRUE,[_roadsValidPositions]];
	if ((random 1) > 0.5) then {
		_supportData pushBack ['MEDICAL',TRUE,[_roadsValidPositions]];
	};
	{
		_supportElement = _x;
		_supportEntities = _supportElement call (missionNamespace getVariable 'QS_fnc_spawnSupport');
		{
			_supportEntity = _x;
			_entityArray pushBack _supportEntity;
		} forEach _supportEntities;
	} forEach _supportData;
};
_arrayGarrison = [];
if (_allowedGarrison) then {
	diag_log '****************************************************';
	diag_log '***** SC ENEMY ***** Garrisoned Enemies ************';
	diag_log '****************************************************';
	
	if (_playerCount >= 0) then {_maxBuildingInfantry = 8;};
	if (_playerCount > 10) then {_maxBuildingInfantry = 12;};
	if (_playerCount > 20) then {_maxBuildingInfantry = 16;};
	if (_playerCount > 30) then {_maxBuildingInfantry = 20;};
	if (_playerCount > 40) then {_maxBuildingInfantry = 24;};
	if (_playerCount > 50) then {_maxBuildingInfantry = 28;};
	if (_maxBuildingInfantry > _countAreaBuildingPositions) then {
		_maxBuildingInfantry = _countAreaBuildingPositions;
	};	
	if (_playerCount >= 0) then {_maxStaticWeapons = 1;};
	if (_playerCount > 10) then {_maxStaticWeapons = 1;};
	if (_playerCount > 20) then {_maxStaticWeapons = 2;};
	if (_playerCount > 30) then {_maxStaticWeapons = 2;};
	if (_playerCount > 40) then {_maxStaticWeapons = 3;};
	if (_playerCount > 50) then {_maxStaticWeapons = 3;};
	if (_worldName isEqualTo 'Tanoa') then {
		_indUnitTypes = [
			"I_C_Soldier_Para_1_F","I_C_Soldier_Para_2_F","I_C_Soldier_Para_3_F","I_C_Soldier_Para_4_F","I_C_Soldier_Para_5_F","I_C_Soldier_Para_6_F",
			"I_C_Soldier_Para_7_F","I_C_Soldier_Para_8_F"
		];
	} else {
		_indUnitTypes = [
			"O_soldierU_A_F","O_soldierU_AAR_F","O_soldierU_AR_F","O_soldierU_medic_F","O_engineer_U_F","O_soldierU_exp_F","O_SoldierU_GL_F",
			"O_Urban_HeavyGunner_F","O_soldierU_M_F","O_soldierU_AT_F","O_soldierU_F","O_soldierU_LAT_F","O_Urban_Sharpshooter_F",
			"O_SoldierU_SL_F","O_soldierU_TL_F","O_G_engineer_F","O_G_medic_F","O_G_Soldier_A_F","O_G_Soldier_AR_F","O_G_Soldier_exp_F","O_G_Soldier_F","O_G_Soldier_F",
			"O_G_Soldier_GL_F","O_G_Soldier_LAT_F","O_G_Soldier_lite_F","O_G_Soldier_M_F","O_G_Soldier_SL_F","O_G_Soldier_TL_F",
			"O_G_Sharpshooter_F","O_G_Soldier_AR_F"
		];
	};
	_grp = createGroup [RESISTANCE,TRUE];
	_areaBuildingPositionIndex = 0;
	for '_x' from 0 to 1 step 0 do {
		if (_spawnedBuildingInfantry >= _maxBuildingInfantry) exitWith {};
		_unit = _grp createUnit [(selectRandom _indUnitTypes),[0,0,0],[],0,'NONE'];
		missionNamespace setVariable [
			'QS_analytics_entities_created',
			((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
			FALSE
		];
		_unit disableAI 'PATH';
		_unit disableAI 'AUTOCOMBAT';
		_unit disableAI 'COVER';
		_unit disableAI 'SUPPRESSION';
		_unit allowDamage FALSE;
		_unit setCustomAimCoef 0.5;
		_unit setUnitRecoilCoefficient 0.5;
		[_unit] call (missionNamespace getVariable 'QS_fnc_setCollectible');
		_unit = _unit call (missionNamespace getVariable 'QS_fnc_unitSetup');
		_staticSpawned = FALSE;
		if (_staticWeaponsEnabled) then {
			if ((_areaBuildingPositions select _areaBuildingPositionIndex) in _staticWeaponPositions) then {
				if (_spawnedStaticWeapons < _maxStaticWeapons) then {
					_spawnedStaticWeapons = _spawnedStaticWeapons + 1;
					_vehicle = createVehicle [(selectRandom _staticTypes),[0,0,0],[],0,'NONE'];
					_vehicle setVectorUp [0,0,1];
					_vehicle setPos (_areaBuildingPositions select _areaBuildingPositionIndex);
					_entityArray pushBack _vehicle;
					_arrayGarrison pushBack _vehicle;
					_vehicle lock 3;
					_vehicle enableWeaponDisassembly FALSE;
					[_vehicle] call (missionNamespace getVariable 'QS_fnc_downgradeVehicleWeapons');
					_vehicle addEventHandler [
						'GetOut',
						{
							(_this select 2) setDamage 1;
							(_this select 0) setDamage 1;
						}
					];
					_unit assignAsGunner _vehicle;
					_unit moveInGunner _vehicle;
					_grp addVehicle _vehicle;
					_staticSpawned = TRUE;
				};
			};
		};
		if (!(_staticSpawned)) then {
			_unit setUnitPosWeak (selectRandom ['UP','UP','MIDDLE']);
			_unit setPos (selectRandom _areaBuildingPositions);
			comment '_unit setPos (_areaBuildingPositions select _areaBuildingPositionIndex);';
		};
		_unit setVariable ['QS_unitGarrisoned',TRUE,FALSE];
		_entityArray pushBack _unit;
		_arrayGarrison pushBack _unit;
		_spawnedBuildingInfantry = _spawnedBuildingInfantry + 1;
		_areaBuildingPositionIndex = _areaBuildingPositionIndex + 1;
	};
	_grp enableAttack FALSE;
	_grp setFormDir ((leader _grp) getDir _centerPos);
	[(units _grp),2] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
	{
		if ((vehicle _x) isKindOf 'StaticWeapon') then {
			_x setSkill ['aimingAccuracy',(random [0.05,0.1,0.125])];
		};
	} forEach (units _grp);
	_grp setVariable ['QS_AI_GRP',TRUE,(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
	_grp setVariable ['QS_AI_GRP_CONFIG',['SC','BLDG_GARRISON',(count (units _grp))],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
	_grp setVariable ['QS_AI_GRP_DATA',[],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
	_grp setVariable ['QS_AI_GRP_TASK',['BLDG_GARRISON',[],diag_tickTime,-1],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
	if (_isHCActive) then {
		_grp setVariable ['QS_grp_HC',TRUE,(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
	};
};

diag_log '****************************************************';
diag_log '***** SC ENEMY ***** Spawning Boat Patrol **********';
diag_log '****************************************************';

_arrayBoat = [];
if (_boatPatrolEnabled) then {
	if ([_centerPos,(_centerRadius * 1.25),8] call (missionNamespace getVariable 'QS_fnc_waterInRadius')) then {
		_boatArray = [];
		_boatArray = [(missionNamespace getVariable 'QS_AOpos')] call (missionNamespace getVariable 'QS_fnc_aoBoatPatrol');
		if (!(_boatArray isEqualTo [])) then {
			{
				0 = _arrayBoat pushBack _x;
				0 = _entityArray pushBack _x;
			} count _boatArray;
		};
	};
};

diag_log '****************************************************';
diag_log '***** SC ENEMY ***** Spawning sniper groups ********';
diag_log '****************************************************';

if (_playerCount >= 0) then {_maxSniperTeams = 1;};
if (_playerCount > 10) then {_maxSniperTeams = 1;};
if (_playerCount > 20) then {_maxSniperTeams = 2;};
if (_playerCount > 30) then {_maxSniperTeams = 2;};
if (_playerCount > 40) then {_maxSniperTeams = 2;};
if (_playerCount > 50) then {_maxSniperTeams = 3;};
_arraySniper = [];
for '_x' from 0 to 1 step 0 do {
	if (_spawnedSniperTeams >= _maxSniperTeams) exitWith {};
	_spawnedSniperTeams = _spawnedSniperTeams + 1;
	_position = selectRandom (missionNamespace getVariable 'QS_virtualSectors_positions');
	_position = _position getPos [(random 5),(random 360)];
	_positionASL = AGLToASL _position;
	_positionASL set [2,((_positionASL select 2) + 1)];
	for '_x' from 0 to 9 step 1 do {
		_randomPos = [_position,500,25,7.5,[[objNull,'VIEW',objNull],0.75]] call (missionNamespace getVariable 'QS_fnc_findOverwatchPos');
		if ((([_randomPos select 0,_randomPos select 1] nearRoads 20) select {((_x isEqualType objNull) && (!((roadsConnectedTo _x) isEqualTo [])))}) isEqualTo []) exitWith {};
	};
	_grp = [_randomPos,(random 360),_side,'OI_SniperTeam',FALSE] call (missionNamespace getVariable 'QS_fnc_spawnGroup');
	_grp setBehaviour (selectRandom ['STEALTH','COMBAT','STEALTH']);
	_grp setCombatMode 'RED';
	[(units _grp),(selectRandom [3,4])] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
	_dirToCenter = _randomPos getDir _position;
	_grp setFormDir _dirToCenter;
	{
		_x setVehiclePosition [(getPosWorld _x),[],0,'CAN_COLLIDE'];
		[_x] call (missionNamespace getVariable 'QS_fnc_setCollectible');
		_x call (missionNamespace getVariable 'QS_fnc_unitSetup');
		_x setVariable ['QS_AI_UNIT_enabled',TRUE,FALSE];
		_x doWatch _position; 
		_x setUnitPos 'DOWN';
		_x addEventHandler [
			'FiredMan',
			{
				params ['_unit'];
				if ((needReload _unit) isEqualTo 1) then {
					_unit setVehicleAmmo 1;
					reload _unit;
				};
			}
		];
		0 = _arraySniper pushBack _x;
		0 = _entityArray pushBack _x;
	} forEach (units _grp);
	_grp setVariable ['QS_AI_GRP',TRUE,(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
	_grp setVariable ['QS_AI_GRP_CONFIG',['SC','SNIPER_TEAM',(count (units _grp))],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
	_grp setVariable ['QS_AI_GRP_DATA',[],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
	_grp setVariable ['QS_AI_GRP_TASK',['SNIPER_TEAM',[],diag_tickTime,-1],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
	if (_isHCActive) then {
		_grp setVariable ['QS_grp_HC',TRUE,(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
	};
};
missionNamespace setVariable ['QS_virtualSectors_enemy_0',_entityArray,(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
missionNamespace setVariable ['QS_virtualSectors_enemy_1',[_arrayHelicopters,_arrayInfPatrols,_arrayVehicles,_arrayGarrison,_arrayBoat,_arraySniper],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
if (canSuspend) then {
	uiSleep 1;
};
{
	if (!isDamageAllowed _x) then {
		_x allowDamage TRUE;
	};
} forEach _entityArray;
_entityArray;