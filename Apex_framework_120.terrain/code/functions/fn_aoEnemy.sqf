/*/
File: fn_aoEnemy.sqf
Author:

	Quiksilver
	
Last modified:

	24/10/2018 A3 1.84 by Quiksilver
	
Description:

	AO Enemies
______________________________________________/*/

diag_log '****************************************************';
diag_log '***** AO ENEMY ***** fn_aoEnemy START *****';
diag_log '****************************************************';
params ['_pos','_isHCEnabled','_aoData','_terrainData'];
private [
	'_randomPos','_patrolGroup','_jtac','_AOvehGroup','_AOveh','_AOmrapGroup','_AOmrap',
	'_spawnPos','_overwatchGroup','_staticGroup','_static','_aaGroup','_aa','_airGroup','_air','_sniperGroup',
	'_staticDir','_unit1','_unit2','_unit3','_dirToCenter','_basePos','_infTypes','_infType','_infUrbanTypes','_infUrbanType',
	'_mrapTypes','_mrapType','_vehTypes','_vehType','_airTypes','_airType','_staticTypes','_staticType','_hqGroup1','_hqGroup2',
	'_mortar1','_mortar2','_emptySpawnPos','_mortarGunner1','_mortarGunner2','_aaCount','_QS_new',
	'_unit','_grpCount','_AOgarrisonGroup','_indArray','_town','_AOgarrisonGroup2','_aoSize','_toGarrison','_aaTypes','_resistanceGrp',
	'_boatArray','_aaArray','_QS_HQpos','_mortarPit','_vehCount','_officerType','_engineerType','_mortGunnerType','_pilotType','_jtacType',
	'_randomWaypoint','_randomWaypointPos','_allowVehicles','_roadPositionsValid','_playerCount','_playerThreshold',
	'_isArmedAirEnabled','_centerPos','_centerRadius','_increment','_radialPatrolPositions'
];
private _enemiesArray = [];
_playerCount = count allPlayers;
_playerThreshold = round (random [15,20,25]);
_QS_new = FALSE;
_requestArray = [];
_isArmedAirEnabled = missionNamespace getVariable ['QS_armedAirEnabled',TRUE];
_infTypes = [
	'OIA_InfSentry',1,
	'OIA_InfSquad',4,
	'OIA_InfTeam',2,
	'OIA_InfAssault',2,
	'OIA_InfTeam_AA',3,
	'OIA_InfTeam_AT',2,
	'OIA_InfTeam_HAT',2,
	'OI_reconPatrol',1,
	'OIA_ReconSquad',1,
	'OIA_InfTeam_LAT',2,
	'OIA_ARTeam',1
];
_infUrbanTypes = [
	'OIA_ARTeam',0.333,
	'OIA_InfTeam_AT',0.333,
	'OIA_InfTeam_LAT',0.333
];
if (worldName in ['Tanoa','Lingor3']) then {
	_staticTypes = ['O_HMG_01_high_F'];
	_airTypes = ['i_e_heli_light_03_dynamicloadout_f','O_Heli_Light_02_dynamicLoadout_F'];
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
				'I_MBT_03_cannon_F'
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
				'I_MBT_03_cannon_F'
			];		
		};
	} else {
		if (_isArmedAirEnabled) then {
			_vehTypes = [
				'O_T_APC_Tracked_02_cannon_ghex_F',
				'O_T_APC_Wheeled_02_rcws_v2_ghex_F',
				'I_APC_Wheeled_03_cannon_F',
				'I_MRAP_03_hmg_F',
				'B_APC_Tracked_01_rcws_F',
				'I_APC_tracked_03_cannon_F'
			];
		} else {
			_vehTypes = [
				'O_T_APC_Tracked_02_cannon_ghex_F',
				'O_T_APC_Wheeled_02_rcws_v2_ghex_F',
				'I_APC_Wheeled_03_cannon_F',
				'I_MRAP_03_hmg_F',
				'B_APC_Tracked_01_rcws_F',
				'I_APC_tracked_03_cannon_F'
			];
		};
	};
	_mortGunnerType = 'O_T_Support_Mort_F';
	_pilotType = 'O_T_Helipilot_F';
	_jtacType = 'O_T_Recon_JTAC_F';
	_officerType = 'O_T_Officer_F';
} else {
	_staticTypes = ['O_HMG_01_high_F'];/*/O_HMG_01_F/*/
	_airTypes = ['i_heli_light_03_dynamicloadout_f','O_Heli_Light_02_dynamicLoadout_F','O_Heli_Attack_02_dynamicLoadout_black_F','O_Heli_Attack_02_dynamicLoadout_F'];
	_engineerType = 'O_engineer_F';
	_aaTypes = ['O_APC_Tracked_02_AA_F','O_APC_Tracked_02_AA_F','O_APC_Tracked_02_AA_F','B_APC_Tracked_01_AA_F','O_APC_Tracked_02_AA_F'];
	_mrapTypes = ['O_MRAP_02_gmg_F','O_MRAP_02_hmg_F'];
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
				'I_APC_tracked_03_cannon_F'
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
				'I_APC_tracked_03_cannon_F'
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
				'I_APC_tracked_03_cannon_F'
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
				'I_APC_tracked_03_cannon_F'
			];
		};
	};
	_mortGunnerType = 'O_support_MG_F';
	_pilotType = 'O_Helipilot_F';
	_jtacType = 'O_recon_JTAC_F';
	_officerType = 'O_officer_F';
};
_basePos = markerPos 'QS_marker_base_marker';
_aoSize = missionNamespace getVariable ['QS_aoSize',750];
_QS_HQpos = missionNamespace getVariable 'QS_HQpos';
_centerPos = _pos;
_centerRadius = _aoSize;
_roadPositionsValid = (((_centerPos select [0,2]) nearRoads _centerRadius) select {((_x isEqualType objNull) && ((roadsConnectedTo _x) isNotEqualTo []))}) apply {(getPosATL _x)};
_allowVehicles = (count (_terrainData select 1)) > 40;
if (_allowVehicles) then {
	_roadPositionsValid = _roadPositionsValid call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
};
diag_log format ['***** AO ENEMY * NEAR ROADS COUNT: %1 *****',(count _roadPositionsValid)];

/*/=============================================================== AA VEHICLE/*/

diag_log '****************************************************';
diag_log '***** AO ENEMY ***** Spawning AA *****';
diag_log '****************************************************';

if (_playerCount > 0) then {
	if ((random 1) > 0.5) then {
		if ((random 1) > 0.5) then {
			_aaCount = 1;
		} else {
			_aaCount = 2;
		};
	} else {
		if ((random 1) > 0.5) then {
			_aaCount = 1;
		} else {
			_aaCount = 2;
		};
	};
	if ((random 1) > 2) then {
		for '_x' from 1 to _aaCount step 1 do {
			_randomPos = ['RADIUS',_centerPos,(_aoSize * 0.85),'LAND',[],TRUE,[],[],TRUE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
			_aa = createVehicle [(selectRandom _aaTypes),[(_randomPos select 0),(_randomPos select 1),0.25],[],0,'NONE'];
			missionNamespace setVariable [
				'QS_analytics_entities_created',
				((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
				FALSE
			];
			_aa allowCrewInImmobile TRUE;
			_aa enableRopeAttach FALSE;
			_aa enableVehicleCargo FALSE;
			[0,_aa,EAST] call (missionNamespace getVariable 'QS_fnc_vSetup2');
			(missionNamespace getVariable 'QS_AI_vehicles') pushBack _aa;
			clearMagazineCargoGlobal _aa;
			clearWeaponCargoGlobal _aa;
			clearItemCargoGlobal _aa;
			clearBackpackCargoGlobal _aa;
			if (_aa isKindOf 'B_APC_Tracked_01_AA_F') then {
				{
					_aa setObjectTextureGlobal _x;
				} forEach [
					[0,'A3\armor_f_beta\apc_tracked_01\data\apc_tracked_01_aa_body_opfor_co.paa'],
					[1,'A3\armor_f_beta\apc_tracked_01\data\apc_tracked_01_aa_body_opfor_co.paa'],
					[2,'A3\armor_f_beta\apc_tracked_01\data\apc_tracked_01_aa_tower_opfor_co.paa']
				];
			};
			_aa allowDamage FALSE;
			[_aa] spawn {sleep 10; (_this select 0) allowDamage TRUE;};
			_aa addEventHandler ['Killed',(missionNamespace getVariable 'QS_fnc_vKilled2')];
			_aaGroup = createGroup [EAST,TRUE];
			_unit1 = _aaGroup createUnit [_engineerType,_randomPos,[],0,'NONE'];
			missionNamespace setVariable [
				'QS_analytics_entities_created',
				((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
				FALSE
			];
			_unit1 = _unit1 call (missionNamespace getVariable 'QS_fnc_unitSetup');
			_unit1 assignAsDriver _aa; 
			_unit1 moveInDriver _aa;
			_unit2 = _aaGroup createUnit [_engineerType,_randomPos,[],0,'NONE'];
			missionNamespace setVariable [
				'QS_analytics_entities_created',
				((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
				FALSE
			];
			_unit2 = _unit2 call (missionNamespace getVariable 'QS_fnc_unitSetup');
			_unit2 assignAsGunner _aa; 
			_unit2 moveInGunner _aa;
			_unit3 = _aaGroup createUnit [_engineerType,_randomPos,[],0,'NONE'];
			missionNamespace setVariable [
				'QS_analytics_entities_created',
				((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
				FALSE
			];
			_unit3 = _unit3 call (missionNamespace getVariable 'QS_fnc_unitSetup');
			_unit3 assignAsCommander _aa; 
			_unit3 moveInCommander _aa;
			_aaGroup addVehicle _aa;
			if ((random 1) > 0.5) then {
				[_aaGroup,_centerPos,(_aoSize / 2.5)] call (missionNamespace getVariable 'QS_fnc_taskPatrol');
			};
			[(units _aaGroup),4] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
			_aa lock 3;
			{
				[_x] call (missionNamespace getVariable 'QS_fnc_setCollectible');
				0 = _enemiesArray pushBack _x;
			} count (units _aaGroup);
			0 = _enemiesArray pushBack _aa;
		};
	} else {
		diag_log '****************************************************';
		diag_log '***** AO ENEMY ***** Spawning Fortified AA *****';
		diag_log '****************************************************';
		_aaCount = 2;
		for '_x' from 1 to _aaCount step 1 do {
			_aaArray = [_centerPos,(selectRandom _aaTypes)] call (missionNamespace getVariable 'QS_fnc_aoFortifiedAA');
			if (_aaArray isNotEqualTo []) then {
				{
					0 = _enemiesArray pushBack _x;
				} count _aaArray;
			};
		};
	};
};

/*/=============================================================== INFANTRY PATROLS RANDOM/*/
	
diag_log '****************************************************';
diag_log '***** AO ENEMY ***** Spawning infantry patrols *****';
diag_log '****************************************************';
_grpCount = 8;
if (_playerCount > 10) then {_grpCount = [12,10] select _allowVehicles;};
if (_playerCount > 20) then {_grpCount = [12,10] select _allowVehicles;};
if (_playerCount > 30) then {_grpCount = [15,13] select _allowVehicles;};
if (_playerCount > 40) then {_grpCount = [15,13] select _allowVehicles;};
if (_playerCount > 50) then {_grpCount = [15,13] select _allowVehicles;};
if (worldName isEqualTo 'Altis') then {
	if (_playerCount > 10) then {_grpCount = [12,10] select _allowVehicles;};
	if (_playerCount > 20) then {_grpCount = [12,10] select _allowVehicles;};
	if (_playerCount > 30) then {_grpCount = [15,13] select _allowVehicles;};
	if (_playerCount > 40) then {_grpCount = [15,13] select _allowVehicles;};
	if (_playerCount > 50) then {_grpCount = [15,13] select _allowVehicles;};
};
if (worldName in ['Tanoa','Lingor3']) then {
	if (_playerCount > 10) then {_grpCount = [10,8] select _allowVehicles;};
	if (_playerCount > 20) then {_grpCount = [10,8] select _allowVehicles;};
	if (_playerCount > 30) then {_grpCount = [13,11] select _allowVehicles;};
	if (_playerCount > 40) then {_grpCount = [13,11] select _allowVehicles;};
	if (_playerCount > 50) then {_grpCount = [13,11] select _allowVehicles;};
};
if (worldName isEqualTo 'Malden') then {
	if (_playerCount > 10) then {_grpCount = [10,8] select _allowVehicles;};
	if (_playerCount > 20) then {_grpCount = [10,8] select _allowVehicles;};
	if (_playerCount > 30) then {_grpCount = [13,11] select _allowVehicles;};
	if (_playerCount > 40) then {_grpCount = [13,11] select _allowVehicles;};
	if (_playerCount > 50) then {_grpCount = [13,11] select _allowVehicles;};
};
_placeTypes = [
	'(1 + houses)',3,
	'(1 + forest)',1,
	'(1 + forest) * (1 + houses)',1,
	'(1 + meadow)',3
];
private _placeType = '';
private _patrolRoute = [];
private _forestPositions = _terrainData select 8;
private _nearForestPositions = [];
private _nearForestPosition = [0,0,0];
private _forestPositionIndex = -1;
for '_x' from 0 to (_grpCount - 1) step 1 do {
	if ((random 1) > 0.5) then {
		_randomPos = ['RADIUS',_centerPos,_aoSize,'LAND',[1.5,0,0.5,3,0,FALSE,objNull],TRUE,[_centerPos,_aoSize,(selectRandomWeighted _placeTypes),15,3],[],TRUE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
	} else {
		_randomPos = ['RADIUS',_centerPos,(_aoSize * 0.75),'LAND',[1.5,0,0.5,3,0,FALSE,objNull],TRUE,[_centerPos,_aoSize,(selectRandomWeighted _placeTypes),15,3],[],TRUE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
	};
	_patrolGroup = [_randomPos,(random 360),EAST,(selectRandomWeighted _infTypes),FALSE,grpNull,TRUE] call (missionNamespace getVariable 'QS_fnc_spawnGroup');
	[_patrolGroup,_randomPos,125,TRUE] call (missionNamespace getVariable 'QS_fnc_taskPatrol');
	[(units _patrolGroup),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
	{
		[_x] call (missionNamespace getVariable 'QS_fnc_setCollectible');
		_x setVehiclePosition [(getPosWorld _x), [], 0, 'CAN_COLLIDE'];
		0 = _enemiesArray pushBack _x;
	} count (units _patrolGroup);
	_nearForestPositions = _forestPositions select {((_x distance2D _randomPos) < 300)};
	if (_nearForestPositions isNotEqualTo []) then {
		_nearForestPosition = selectRandom _nearForestPositions;
		_forestPositionIndex = _forestPositions find _nearForestPosition;
		_forestPositions set [_forestPositionIndex,FALSE];
		_forestPositions deleteAt _forestPositionIndex;
		_patrolRoute = (_patrolGroup getVariable 'QS_AI_GRP_TASK') select 1;
		_patrolRoute pushBack _nearForestPosition;
		_patrolRoute = _patrolRoute call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
		_patrolGroup setVariable ['QS_AI_GRP_TASK',[((_patrolGroup getVariable 'QS_AI_GRP_TASK') select 0),_patrolRoute,((_patrolGroup getVariable 'QS_AI_GRP_TASK') select 2),((_patrolGroup getVariable 'QS_AI_GRP_TASK') select 3)],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
	};
	_patrolGroup setVariable ['QS_AI_GRP',TRUE,(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
	_patrolGroup setVariable ['QS_AI_GRP_CONFIG',['GENERAL','INFANTRY',(count (units _patrolGroup))],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
	_patrolGroup setVariable ['QS_AI_GRP_DATA',[TRUE,diag_tickTime],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
};

/*/=============================================================== STATIC WEAPONS/*/

diag_log '****************************************************';
diag_log '***** AO ENEMY ***** Spawning static weapons *****';
diag_log '****************************************************';
for '_x' from 0 to 49 step 1 do {
	_randomPos = ['RADIUS',_centerPos,(_aoSize * 0.85),'LAND',[5,0,0.3,5,0,FALSE,objNull],FALSE,[],[],TRUE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
	if (
		(((missionNamespace getVariable 'QS_registeredPositions') findIf {((_randomPos distance2D _x) < 50)}) isEqualTo -1) && 
		((((_randomPos select [0,2]) nearRoads 25) select {((_x isEqualType objNull) && ((roadsConnectedTo _x) isNotEqualTo []))}) isEqualTo [])
	) exitWith {};
};
_list = [
	["Land_Mil_WallBig_4m_F",[-0.354004,-0.0078125,11.045],0,270.632],
	["Land_Mil_WallBig_4m_F",[-0.0952148,0.0634766,11.082],0,0],
	["I_E_HMG_02_high_F",[-2.18506,-2.04688,10.4124],0,234.27],
	["I_E_HMG_02_high_F",[-1.84229,2.15332,10.4124],0,309.028],
	["I_E_HMG_02_high_F",[2.16064,1.62402,10.4124],0,42.212],
	["I_E_HMG_02_high_F",[1.96973,-2.24854,10.4124],0,139.225]
];
_tower = createVehicle ['CargoPlaftorm_01_green_F',[0,0,0]];
_tower setPosASL _randomPos;
_tower addEventHandler [
	'Deleted',
	{
		params ['_tower'];
		{
			deleteVehicle _x;
		} forEach (_tower getVariable ['QS_entity_assocEntities',[]]);
	}
];
_tower addEventHandler [
	'Killed',
	{
		params ['_tower'];
		{
			deleteVehicle _x;
		} forEach (_tower getVariable ['QS_entity_assocEntities',[]]);
	}
];
_tower setVectorUp [0,0,1];
sleep 0.5;
_enemiesArray pushBack _tower;
private _object = objNull;
private _offset = 5;
private _attachPos = [0,0,0];
_tower setVariable ['QS_entity_assocEntities',[],FALSE];
_towerGrp = createGroup [EAST,TRUE];
{
	_object = createVehicle [_x # 0,[0,0,0]];
	_object allowDamage FALSE;
	_attachPos = _x # 1;
	_attachPos set [2,(_attachPos # 2) - _offset];
	_object attachTo [_tower,_attachPos];
	_object setDir ((getDir _tower) + (_x # 3));
	_object spawn {sleep 1; detach _this;};
	_tower setVariable ['QS_entity_assocEntities',((_tower getVariable ['QS_entity_assocEntities',[]]) + [_object]),FALSE];
	_enemiesArray pushBack _object;
	if (_object isKindOf 'StaticWeapon') then {
		if (_playerCount < 30) then {
			[_object] call (missionNamespace getVariable 'QS_fnc_downgradeVehicleWeapons');
		} else {
			if ((random 1) > 0.666) then {
				[_object] call (missionNamespace getVariable 'QS_fnc_downgradeVehicleWeapons');
			};
		};
		_grp = createVehicleCrew _object;
		(units _grp) joinSilent _towerGrp;
		(gunner _object) addEventHandler [
			'Hit',
			{
				params ['_unit','_source','_damage','_instigator'];
				if (!isNull _source) then {
					_unit reveal [_source,4];
					(group _unit) reveal [_source,4];
				};
				if (!isNull _instigator) then {
					_unit reveal [_instigator,4];
					(group _unit) reveal [_instigator,4];
				};
			}
		];
		(gunner _object) addEventHandler [
			'Killed',
			{
				_killed = _this # 0;
				if (!isNull _killed) then {
					if (!isNull (_killed getVariable 'QS_staticGunnerVehicle')) then {
						(_killed getVariable 'QS_staticGunnerVehicle') setDamage 1;
					};
				};
			}
		];
		_object addEventHandler [
			'GetOut',
			{
				(_this # 2) setDamage 1;
				(_this # 0) setDamage 1;
			}
		];
		_object addEventHandler [
			'Deleted',
			{
				params ['_object'];
			}
		];
		_object lock 3;
		_enemiesArray pushBack (gunner _object);
		(gunner _object) setVariable ['QS_staticGunnerVehicle',_object,FALSE];
		_object enableDynamicSimulation TRUE;
		(gunner _object) enableDynamicSimulation TRUE;
	} else {
		_object enableSimulationGlobal FALSE;
	};
} forEach _list;
[(units _towerGrp),3] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
_towerGrp setCombatMode 'RED';
_towerGrp setBehaviourStrong 'COMBAT';
_towerGrp enableAttack TRUE;

/*/=============================================================== INFANTRY OVERWATCH/*/

diag_log '****************************************************';
diag_log '***** AO ENEMY ***** Spawning infantry overwatch *****';
diag_log '****************************************************';

_grpCount = 3;
if (_playerCount > 15) then {
	_grpCount = 4;
	if (_playerCount > 30) then {
		_grpCount = 5;
	};
};
for '_x' from 0 to _grpCount step 1 do {
	private _watchPos = selectRandom [(AGLToASL _centerPos),(AGLToASL _QS_HQpos)];
	_randomPos = [_watchPos,(_aoSize * 0.8),25,10,[[objNull,'VIEW'],(0.1 max (random 1))]] call (missionNamespace getVariable 'QS_fnc_findOverwatchPos');
	_infUrbanType = selectRandomWeighted _infUrbanTypes;
	_overwatchGroup = [_randomPos,(random 360),EAST,_infUrbanType,FALSE] call (missionNamespace getVariable 'QS_fnc_spawnGroup');
	[(units _overwatchGroup),2] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
	if ((random 1) > 0.5) then {
		[_overwatchGroup,_randomPos,65,TRUE] call (missionNamespace getVariable 'QS_fnc_taskPatrol');
	} else {
		if ((random 1) > 0.5) then {
			_overwatchGroup setFormDir (random 360);
		} else {
			_overwatchGroup setFormDir (_randomPos getDir _watchPos);
		};
		{_x setUnitPosWeak 'Middle';} count (units _overwatchGroup);
	};
	{
		_x setVehiclePosition [(getPosWorld _x),[],0,'CAN_COLLIDE'];
		[_x] call (missionNamespace getVariable 'QS_fnc_setCollectible');
		0 = _enemiesArray pushBack _x;
	} count (units _overwatchGroup);
	_overwatchGroup setVariable ['QS_AI_GRP',TRUE,(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
	_overwatchGroup setVariable ['QS_AI_GRP_CONFIG',['GENERAL','INFANTRY',(count (units _overwatchGroup))],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
	_overwatchGroup setVariable ['QS_AI_GRP_DATA',[TRUE,diag_tickTime],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
};

/*/=============================================================== GROUND VEHICLE RANDOM/*/

diag_log '****************************************************';
diag_log '***** AO ENEMY ***** Spawning Armored Vehicles *****';
diag_log '****************************************************';

_vehCount = [1,2] select _allowVehicles;
if (_playerCount > 10) then {
	_vehCount = [2,3] select _allowVehicles;
};
if (_playerCount > 20) then {
	_vehCount = [2,3] select _allowVehicles;
};
if (_playerCount > 30) then {
	_vehCount = [3,4] select _allowVehicles;
};
if (_playerCount > 40) then {
	_vehCount = [4,5] select _allowVehicles;
};	
if (_playerCount > 50) then {
	_vehCount = [4,5] select _allowVehicles;
};
for '_x' from 0 to (_vehCount - 1) step 1 do {
	_AOvehGroup = createGroup [EAST,TRUE];
	if (_allowVehicles) then {
		_randomPos = selectRandom _roadPositionsValid;
	} else {
		_randomPos = [_centerPos,0,_aoSize,2.5,0,0.4,0] call (missionNamespace getVariable 'QS_fnc_findSafePos');
	};
	_AOveh = createVehicle [(selectRandomWeighted ([([0,7] select _allowVehicles)] call (missionNamespace getVariable 'QS_fnc_getAIMotorPool'))),[(_randomPos select 0),(_randomPos select 1),0.25],[],0,'NONE'];
	missionNamespace setVariable ['QS_analytics_entities_created',((missionNamespace getVariable 'QS_analytics_entities_created') + 1),FALSE];
	_AOveh allowDamage FALSE;
	_AOveh limitSpeed (random [30,40,50]);
	(missionNamespace getVariable 'QS_AI_vehicles') pushBack _AOveh;
	clearMagazineCargoGlobal _AOveh;
	clearWeaponCargoGlobal _AOveh;
	clearItemCargoGlobal _AOveh;
	clearBackpackCargoGlobal _AOveh;
	_AOveh setUnloadInCombat [TRUE,FALSE];
	[0,_AOveh,EAST] call (missionNamespace getVariable 'QS_fnc_vSetup2');
	_AOveh addEventHandler ['GetOut',(missionNamespace getVariable 'QS_fnc_AIXDismountDisabled')];
	_AOveh enableRopeAttach FALSE;
	_AOveh enableVehicleCargo FALSE;
	if (random 1 >= 0.25) then {_AOveh allowCrewInImmobile TRUE;};
	/*/_AOveh forceFollowRoad TRUE;/*/
	_AOveh setConvoySeparation 50;
	[_AOveh] spawn {sleep 5; (_this select 0) allowDamage TRUE;};
	_AOveh setVectorUp (surfaceNormal _randomPos);
	if (_playerCount < 30) then {
		[_AOveh] call (missionNamespace getVariable 'QS_fnc_downgradeVehicleWeapons');
	} else {
		if ((random 1) > 0.5) then {
			[_AOveh] call (missionNamespace getVariable 'QS_fnc_downgradeVehicleWeapons');
		};
	};
	_AOveh addEventHandler ['Killed',(missionNamespace getVariable 'QS_fnc_vKilled2')];
	_unit1 = _AOvehGroup createUnit [_engineerType,_randomPos,[],0,'NONE'];
	missionNamespace setVariable [
		'QS_analytics_entities_created',
		((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
		FALSE
	];
	_unit1 = _unit1 call (missionNamespace getVariable 'QS_fnc_unitSetup');
	_unit1 assignAsDriver _AOveh;
	_unit1 moveInDriver _AOveh;
	_unit2 = _AOvehGroup createUnit [_engineerType,_randomPos,[],0,'NONE'];
	missionNamespace setVariable [
		'QS_analytics_entities_created',
		((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
		FALSE
	];
	_unit2 = _unit2 call (missionNamespace getVariable 'QS_fnc_unitSetup');
	_unit2 assignAsGunner _AOveh;
	_unit2 moveInGunner _AOveh;
	if ((_AOveh emptyPositions 'commander') isEqualTo 1) then {
		_unit3 = _AOvehGroup createUnit [_engineerType,_randomPos,[],0,'NONE'];
		missionNamespace setVariable [
			'QS_analytics_entities_created',
			((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
			FALSE
		];
		_unit3 = _unit3 call (missionNamespace getVariable 'QS_fnc_unitSetup');
		_unit3 assignAsCommander _AOveh;
		_unit3 moveInCommander _AOveh;
	};
	_AOvehGroup addVehicle _AOveh;
	[_AOvehGroup,_randomPos,_aoSize,_roadPositionsValid,TRUE] call (missionNamespace getVariable 'QS_fnc_taskPatrolVehicle');
	_AOveh lock 3;
	if (_AOveh isKindOf 'mbt_04_base_f') then {
		[(units _AOvehGroup),3] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
	} else {
		[(units _AOvehGroup),2] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
	};
	{
		_x setVariable ['BIS_noCoreConversations',TRUE,FALSE];
		0 = _enemiesArray pushBack _x;
	} count (units _AOvehGroup);
	_unit2 setSkill ['aimingAccuracy',0.1];
	_AOvehGroup allowFleeing 0;
	0 = _enemiesArray pushBack _AOveh;
	_AOvehGroup setVariable ['QS_AI_GRP',TRUE,(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
	_AOvehGroup setVariable ['QS_AI_GRP_CONFIG',['GENERAL','VEHICLE',(count (units _AOvehGroup)),_AOveh],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
	_AOvehGroup setVariable ['QS_AI_GRP_DATA',[TRUE,diag_tickTime],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
};

/*/===== Spawning Support vehicle/*/

if (_allowVehicles) then {
	private _supportData = [];
	private _supportEntities = [];
	private _supportElement = [];
	private _supportEntity = objNull;
	_supportData pushBack ['REPAIR',TRUE,[_roadPositionsValid]];
	if ((random 1) > 0.5) then {
		_supportData pushBack ['MEDICAL',TRUE,[_roadPositionsValid]];
	};
	{
		_supportElement = _x;
		_supportEntities = _supportElement call (missionNamespace getVariable 'QS_fnc_spawnSupport');
		{
			_supportEntity = _x;
			_enemiesArray pushBack _supportEntity;
		} forEach _supportEntities;
	} forEach _supportData;
};

/*/=============================================================== SNIPERS/*/

diag_log '****************************************************';
diag_log '***** AO ENEMY ***** Spawning Snipers *****';
diag_log '****************************************************';

for '_x' from 0 to ([1,2] select (_playerCount > 30)) step 1 do {
	private _watchPos = selectRandom [(AGLToASL _centerPos),(AGLToASL _QS_HQpos)];
	_randomPos = [_watchPos,(_aoSize * 1.25),(_aoSize / 2),10,[[objNull,'VIEW'],0.75]] call (missionNamespace getVariable 'QS_fnc_findOverwatchPos');
	_sniperGroup = [_randomPos,(random 360),EAST,'OI_SniperTeam_2',FALSE] call (missionNamespace getVariable 'QS_fnc_spawnGroup');
	_sniperGroup setBehaviour 'COMBAT';
	_sniperGroup setCombatMode 'RED';
	[(units _sniperGroup),(selectRandom [3,4])] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
	_dirToCenter = _randomPos getDir _watchPos;
	_sniperGroup setFormDir _dirToCenter;
	if ((random 1) > 0.333) then {
		{
			_x setUnitPos 'DOWN';
		} forEach (units _sniperGroup);
	} else {
		{
			_x setUnitPosWeak 'DOWN';
		} forEach (units _sniperGroup);	
	};
	{
		_x setVehiclePosition [(getPosWorld _x),[],0,'CAN_COLLIDE'];
		[_x] call (missionNamespace getVariable 'QS_fnc_setCollectible');
		_x doWatch (ASLToAGL _watchPos); 
		0 = _enemiesArray pushBack _x;
	} count (units _sniperGroup);
};

/*/=============================================================== AO MORTAR PIT/*/

if ((random 1) > 0.5) then {
	diag_log '****************************************************';
	diag_log '***** AO ENEMY ***** Spawning Mortar Pit *****';
	diag_log '****************************************************';
	_mortarPit = [_centerPos] call (missionNamespace getVariable 'QS_fnc_aoMortarPit');
	if (_mortarPit isNotEqualTo []) then {
		{
			0 = _enemiesArray pushBack _x;
		} count _mortarPit;
	};
};

/*/=============================================================== ENEMIES IN BUILDINGS/*/

diag_log '****************************************************';
diag_log '***** AO ENEMY ***** Spawning Enemies in buildings *';
diag_log '****************************************************';
_toGarrison = [];
if ((count (_terrainData select 4)) > 6) then {
	if (worldName in ['Tanoa','Lingor3']) then {
		_indArray = [
			"i_c_soldier_para_1_f","i_c_soldier_para_2_f","i_c_soldier_para_3_f","i_c_soldier_para_4_f","i_c_soldier_para_5_f","i_c_soldier_para_6_f",
			"i_c_soldier_para_7_f","i_c_soldier_para_8_f"
		];	
	} else {
		_indArray = [
			"o_soldieru_a_f","o_soldieru_aar_f","o_soldieru_ar_f","o_soldieru_medic_f","o_engineer_u_f","o_soldieru_exp_f","o_soldieru_gl_f",
			"o_urban_heavygunner_f","o_soldieru_m_f","o_soldieru_at_f","o_soldieru_f","o_soldieru_lat_f","o_urban_sharpshooter_f",
			"o_soldieru_sl_f","o_soldieru_tl_f","o_g_engineer_f","o_g_medic_f","o_g_soldier_a_f","o_g_soldier_ar_f","o_g_soldier_exp_f","o_g_soldier_f","o_g_soldier_f",
			"o_g_soldier_gl_f","o_g_soldier_lat_f","o_g_soldier_lite_f","o_g_soldier_m_f","o_g_soldier_sl_f","o_g_soldier_tl_f",
			"o_g_sharpshooter_f","o_g_soldier_ar_f"
		];
	};
	_AOgarrisonGroup = createGroup [RESISTANCE,TRUE];
	_toGarrison = [];
	for '_x' from 0 to 26 step 1 do {
		_randomUnit = selectRandom _indArray;
		_unit = _AOgarrisonGroup createUnit [_randomUnit,_centerPos,[],0,'NONE'];
		missionNamespace setVariable ['QS_analytics_entities_created',((missionNamespace getVariable 'QS_analytics_entities_created') + 1),FALSE];
		_unit = _unit call (missionNamespace getVariable 'QS_fnc_unitSetup');
		0 = _enemiesArray pushBack _unit;
		0 = _toGarrison pushBack _unit;
		[_unit] call (missionNamespace getVariable 'QS_fnc_setCollectible');
	};
	[_toGarrison,2] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
};
_QS_HQpos set [2,0];
_resistanceGrp = createGroup [RESISTANCE,TRUE];
_unit = _resistanceGrp createUnit ['I_C_Soldier_Para_1_F',_QS_HQpos,[],0,'NONE'];
missionNamespace setVariable [
	'QS_analytics_entities_created',
	((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
	FALSE
];
_unit = _unit call (missionNamespace getVariable 'QS_fnc_unitSetup');
_enemiesArray pushBack _unit;
_toGarrison pushBack _unit;
if (_toGarrison isNotEqualTo []) then {
	[_centerPos,(_aoSize / 1.5),_toGarrison,['House']] call (missionNamespace getVariable 'QS_fnc_garrisonUnits');
	{
		if (!isNull _x) then {
			[_x] joinSilent _resistanceGrp;
		};
	} count _toGarrison;
};
/*/=============================================================== ENEMIES IN HQ BUILDINGS/*/
if (worldName in ['Tanoa','Lingor3']) then {
	_indArray = [
		'o_soldieru_ar_f','o_soldieru_medic_f','o_engineer_u_f','o_soldieru_exp_f','o_soldieru_gl_f',
		'o_urban_heavygunner_f','o_soldieru_m_f','o_soldieru_aa_f','o_soldieru_at_f','o_soldieru_lat_f','o_urban_sharpshooter_f'
	];
} else {
	_indArray = [
		'o_soldieru_ar_f','o_soldieru_medic_f','o_engineer_u_f','o_soldieru_exp_f','o_soldieru_gl_f',
		'o_urban_heavygunner_f','o_soldieru_m_f','o_soldieru_aa_f','o_soldieru_at_f','o_soldieru_lat_f','o_urban_sharpshooter_f'
	];
};
_AOgarrisonGroup2 = createGroup [RESISTANCE,TRUE];
_toGarrison = [];
for '_x' from 0 to 8 step 1 do {
	_randomUnit = selectRandom _indArray;
	_unit = _AOgarrisonGroup2 createUnit [_randomUnit,_QS_HQpos,[],0,'NONE'];
	missionNamespace setVariable [
		'QS_analytics_entities_created',
		((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
		FALSE
	];
	_unit = _unit call (missionNamespace getVariable 'QS_fnc_unitSetup');
	0 = _enemiesArray pushBack _unit;
	0 = _toGarrison pushBack _unit;
	[_unit] call (missionNamespace getVariable 'QS_fnc_setCollectible');
};
[_QS_HQpos,60,_toGarrison,[]] call (missionNamespace getVariable 'QS_fnc_garrisonUnits');
[_toGarrison,2] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
{
	_x setDamage 0;
} count _toGarrison;

/*/=============================================================== BOAT PATROL/*/

diag_log '****************************************************';
diag_log '***** AO ENEMY ***** Spawning Boat Patrol *****';
diag_log '****************************************************';
if (((missionNamespace getVariable ['QS_classic_AOData',[]]) select 4) isEqualTo 1) then {
	_boatArray = [];
	_boatArray = [(missionNamespace getVariable 'QS_AOpos')] call (missionNamespace getVariable 'QS_fnc_aoBoatPatrol');
	if (_boatArray isNotEqualTo []) then {
		{
			0 = _enemiesArray pushBack _x;
		} count _boatArray;
	};
};

/*/=============================================================== HQ GUARDS/*/

diag_log '****************************************************';
diag_log '***** AO ENEMY ***** Spawning HQ Guards *****';
diag_log '****************************************************';

_randomPos = ['RADIUS',_QS_HQpos,50,'LAND',[],FALSE,[],[0,40,'O_soldier_F'],FALSE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
_infUrbanType = selectRandomWeighted _infUrbanTypes;
_hqGroup1 = [_randomPos,(random 360),EAST,_infUrbanType,FALSE] call (missionNamespace getVariable 'QS_fnc_spawnGroup');
[_hqGroup1,_QS_HQpos,70,TRUE] call (missionNamespace getVariable 'QS_fnc_taskPatrol');
[(units _hqGroup1),2] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
_hqGroup1 setVariable ['QS_AI_GRP',TRUE,(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
_hqGroup1 setVariable ['QS_AI_GRP_CONFIG',['GENERAL','INFANTRY',(count (units _hqGroup1))],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
_hqGroup1 setVariable ['QS_AI_GRP_DATA',[TRUE,diag_tickTime],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
{
	_x setVehiclePosition [(getPosWorld _x),[],0,'CAN_COLLIDE'];
	[_x] call (missionNamespace getVariable 'QS_fnc_setCollectible');
	0 = _enemiesArray pushBack _x;
} count (units _hqGroup1);
_infUrbanType = selectRandomWeighted _infUrbanTypes;
_randomPos = ['RADIUS',_QS_HQpos,50,'LAND',[],FALSE,[],[0,40,'O_soldier_F'],FALSE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
_hqGroup2 = [_randomPos,(random 360),EAST,_infUrbanType,FALSE] call (missionNamespace getVariable 'QS_fnc_spawnGroup');
[_hqGroup2,_QS_HQpos,70,TRUE] call (missionNamespace getVariable 'QS_fnc_taskPatrol');
[(units _hqGroup2),2] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
_hqGroup2 setVariable ['QS_AI_GRP',TRUE,(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
_hqGroup2 setVariable ['QS_AI_GRP_CONFIG',['GENERAL','INFANTRY',(count (units _hqGroup2))],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
_hqGroup2 setVariable ['QS_AI_GRP_DATA',[TRUE,diag_tickTime],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
{
	[_x] call (missionNamespace getVariable 'QS_fnc_setCollectible');
	0 = _enemiesArray pushBack _x;
} count (units _hqGroup2);
missionNamespace setVariable ['csatHQGroup',(createGroup [EAST,TRUE]),FALSE];
missionNamespace setVariable [
	'QS_csatCommander',
	((missionNamespace getVariable 'csatHQGroup') createUnit [_officerType,_QS_HQpos,[],0,'NONE']),
	TRUE
];
missionNamespace setVariable [
	'QS_analytics_entities_created',
	((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
	FALSE
];
_commander = missionNamespace getVariable 'QS_csatCommander';
_commander allowDamage FALSE;
_commander enableStamina FALSE;
_commander disableAI 'COVER';
_commander disableAI 'AUTOCOMBAT';
//_commander spawn {sleep 5; _this allowDamage TRUE;};
[_QS_HQpos,40,(units (missionNamespace getVariable 'csatHQGroup')),[]] call (missionNamespace getVariable 'QS_fnc_garrisonUnits');
[(units (missionNamespace getVariable 'csatHQGroup')),3] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
_commander disableAI 'PATH';
_commander spawn {
	sleep 3;
	_this setUnitPos (selectRandom ['Middle','Down']);
};
(missionNamespace getVariable 'csatHQGroup') setFormDir (random 360);
missionNamespace setVariable ['QS_commanderAlive',TRUE,FALSE];
for '_x' from 0 to 2 step 1 do {
	_commander setVariable ['QS_surrenderable',TRUE,TRUE];
};
if ((random 1) > 0.666) then {
	_commander setVariable ['QS_collectible_tooth',TRUE,TRUE];
};
_commander addEventHandler [
	'Killed',
	{
		params ['_killed','_killer'];
		missionNamespace setVariable ['QS_commanderAlive',FALSE,FALSE];
		['QS_IA_TASK_AO_2'] call (missionNamespace getVariable 'BIS_fnc_deleteTask');
		{
			_x setMarkerPos (missionNamespace getVariable 'QS_HQpos');
		} forEach [
			'QS_marker_hqMarker',
			'QS_marker_hqCircle'
		];
		['CompletedSub',['CSAT Commander killed!']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
		if (!isNull _killer) then {
			if (isPlayer _killer) then {
				_name = name _killer;
				_text = format ['%1 has killed the CSAT Commander',_name];
				['sideChat',[WEST,'HQ'],_text] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
			};
		};
	}
];
{
	0 = _enemiesArray pushBack _x;
} count (units (missionNamespace getVariable 'csatHQGroup'));
{
	(missionNamespace getVariable 'QS_classic_AI_enemy_0') pushBack _x;
} forEach _enemiesArray;
//missionNamespace setVariable ['QS_classic_AI_enemy_0',_enemiesArray,FALSE];
diag_log '****************************************************';
diag_log '***** AO ENEMY ***** fn_aoEnemy END ****************';
diag_log '****************************************************';