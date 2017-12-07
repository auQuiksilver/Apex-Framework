/*/
File: fn_aoEnemy.sqf
Author:

	Quiksilver
	
Last modified:

	8/10/2017 A3 1.76 by Quiksilver
	
Description:

	AO Enemies
	
	[_QS_AOpos,FALSE,_ao,_minefield] call (missionNamespace getVariable 'QS_fnc_aoEnemy');
__________________________________________________________________/*/

diag_log '****************************************************';
diag_log '***** AO ENEMY ***** fn_aoEnemy START *****';
diag_log '****************************************************';
params ['_pos','_isHCEnabled','_aoData','_enemiesArray'];
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
_playerCount = count allPlayers;
_playerThreshold = 30;
_QS_new = FALSE;
_requestArray = [];
_isArmedAirEnabled = missionNamespace getVariable ['QS_armedAirEnabled',TRUE];
_infTypes = [
	"OIA_InfSentry",
	"OIA_InfSquad","OIA_InfSquad","OIA_InfSquad",
	"OIA_InfTeam","OIA_InfTeam","OIA_InfTeam",
	"OIA_InfAssault","OIA_InfAssault",
	"OIA_InfTeam_AA","OIA_InfTeam_AA",
	"OIA_InfTeam_AT","OIA_InfTeam_AT",
	"OI_reconPatrol",
	"OI_reconSentry",
	"OIA_ReconSquad",
	"OIA_InfTeam_LAT","OIA_InfTeam_LAT"
];
if (worldName isEqualTo 'Tanoa') then {
	_staticTypes = ['O_HMG_01_high_F'];/*/O_HMG_01_F/*/
	_airTypes = ["i_heli_light_03_dynamicloadout_f","O_Heli_Light_02_dynamicLoadout_F","O_Heli_Light_02_v2_F"];
	_engineerType = 'O_T_Engineer_F';
	_infUrbanTypes = ["OIA_InfTeam","OIA_InfTeam"];
	_aaTypes = ['O_T_APC_Tracked_02_AA_ghex_F'];
	_mrapTypes = ["O_T_MRAP_02_gmg_ghex_F",'O_T_MRAP_02_hmg_ghex_F','O_T_LSV_02_armed_F'];
	if (_playerCount >= _playerThreshold) then {
		if (_isArmedAirEnabled) then {
			_vehTypes = [
				"O_T_APC_Tracked_02_cannon_ghex_F","O_T_APC_Wheeled_02_rcws_ghex_F","O_T_APC_Tracked_02_cannon_ghex_F",
				"I_APC_Wheeled_03_cannon_F","I_APC_tracked_03_cannon_F",'B_APC_Tracked_01_rcws_F','O_T_MBT_02_cannon_ghex_F',"I_APC_Wheeled_03_cannon_F",'I_MBT_03_cannon_F'
			];
		} else {
			_vehTypes = [
				"O_T_APC_Tracked_02_cannon_ghex_F","O_T_APC_Wheeled_02_rcws_ghex_F","O_T_APC_Tracked_02_cannon_ghex_F","O_T_APC_Tracked_02_cannon_ghex_F","O_T_APC_Wheeled_02_rcws_ghex_F","O_T_APC_Tracked_02_cannon_ghex_F",
				"I_APC_Wheeled_03_cannon_F","I_APC_tracked_03_cannon_F",'B_APC_Tracked_01_rcws_F','O_T_MBT_02_cannon_ghex_F',"I_APC_Wheeled_03_cannon_F",'I_MBT_03_cannon_F'
			];		
		};
	} else {
		if (_isArmedAirEnabled) then {
			_vehTypes = [
				"O_T_APC_Tracked_02_cannon_ghex_F","O_T_APC_Wheeled_02_rcws_ghex_F",
				"I_APC_Wheeled_03_cannon_F",'I_MRAP_03_hmg_F'
			];
		} else {
			_vehTypes = [
				"O_T_APC_Tracked_02_cannon_ghex_F","O_T_APC_Wheeled_02_rcws_ghex_F",
				"I_APC_Wheeled_03_cannon_F",'I_MRAP_03_hmg_F'
			];
		};
	};
	_mortGunnerType = "O_T_Support_Mort_F";
	_pilotType = "O_T_Helipilot_F";
	_jtacType = "O_T_Recon_JTAC_F";
	_officerType = 'O_T_Officer_F';
} else {
	_staticTypes = ['O_HMG_01_high_F'];/*/O_HMG_01_F/*/
	_airTypes = ["i_heli_light_03_dynamicloadout_f","O_Heli_Light_02_dynamicLoadout_F","O_Heli_Light_02_v2_F",'O_Heli_Attack_02_dynamicLoadout_black_F','O_Heli_Attack_02_dynamicLoadout_F'];
	_engineerType = 'O_engineer_F';
	_infUrbanTypes = ["OIA_InfTeam","OIA_InfTeam"];
	_aaTypes = ['O_APC_Tracked_02_AA_F','O_APC_Tracked_02_AA_F','O_APC_Tracked_02_AA_F','B_APC_Tracked_01_AA_F','O_APC_Tracked_02_AA_F'];
	_mrapTypes = ['O_MRAP_02_gmg_F','O_MRAP_02_hmg_F'];
	if (_playerCount >= _playerThreshold) then {
		if (_isArmedAirEnabled) then {
			_vehTypes = [
				"O_MBT_02_cannon_F","O_APC_Tracked_02_cannon_F","O_APC_Wheeled_02_rcws_F","O_APC_Tracked_02_cannon_F","I_APC_Wheeled_03_cannon_F",
				"I_APC_tracked_03_cannon_F","I_MBT_03_cannon_F",'B_APC_Tracked_01_rcws_F','O_MBT_02_cannon_F',"I_APC_tracked_03_cannon_F"
			];
		} else {
			_vehTypes = [
				"O_MBT_02_cannon_F","O_APC_Tracked_02_cannon_F","O_APC_Wheeled_02_rcws_F","O_APC_Tracked_02_cannon_F","I_APC_Wheeled_03_cannon_F","O_APC_Wheeled_02_rcws_F","O_APC_Tracked_02_cannon_F","I_APC_Wheeled_03_cannon_F",
				"I_APC_tracked_03_cannon_F","I_MBT_03_cannon_F",'B_APC_Tracked_01_rcws_F','O_MBT_02_cannon_F',"I_APC_tracked_03_cannon_F"
			];	
		};
	} else {
		if (_isArmedAirEnabled) then {
			_vehTypes = [
				"O_MBT_02_cannon_F","O_APC_Tracked_02_cannon_F","O_APC_Wheeled_02_rcws_F","O_APC_Tracked_02_cannon_F","I_APC_Wheeled_03_cannon_F",
				"I_APC_tracked_03_cannon_F","I_MBT_03_cannon_F",'B_APC_Tracked_01_rcws_F','O_MBT_02_cannon_F',"I_APC_tracked_03_cannon_F"
			];
		} else {
			_vehTypes = [
				"O_MBT_02_cannon_F","O_APC_Tracked_02_cannon_F","O_APC_Wheeled_02_rcws_F","O_APC_Tracked_02_cannon_F","I_APC_Wheeled_03_cannon_F","O_APC_Wheeled_02_rcws_F","O_APC_Tracked_02_cannon_F","I_APC_Wheeled_03_cannon_F",
				"I_APC_tracked_03_cannon_F","I_MBT_03_cannon_F",'B_APC_Tracked_01_rcws_F','O_MBT_02_cannon_F',"I_APC_tracked_03_cannon_F"
			];
		};
	};
	_mortGunnerType = "O_support_MG_F";
	_pilotType = "O_Helipilot_F";
	_jtacType = "O_recon_JTAC_F";
	_officerType = 'O_officer_F';
};
_basePos = markerPos 'QS_marker_base_marker';
_aoSize = missionNamespace getVariable ['QS_aoSize',750];
_QS_HQpos = missionNamespace getVariable 'QS_HQpos';
_centerPos = _pos;
_centerRadius = _aoSize;
_roadPositionsValid = ((_pos nearRoads _aoSize) select {((_x isEqualType objNull) && (!((roadsConnectedTo _x) isEqualTo [])))}) apply {(getPosATL _x)};
_allowVehicles = ((count _roadPositionsValid) > 40);
diag_log format ['***** AO ENEMY * NEAR ROADS COUNT: %1 *****',(count _roadPositionsValid)];

/*/=============================================================== AA VEHICLE/*/

diag_log '****************************************************';
diag_log '***** AO ENEMY ***** Spawning AA *****';
diag_log '****************************************************';

if (_playerCount > 20) then {
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
			_randomPos = ['RADIUS',_pos,(_aoSize * 0.85),'LAND',[],TRUE,[],[],TRUE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
			/*/0 = _requestArray pushBack ['CREATE','PRIMARY','PATROL','VEHICLE',EAST,_emptySpawnPos,_pos,'O_APC_Tracked_02_AA_F'];/*/
			_aa = createVehicle [(selectRandom _aaTypes),[(_randomPos select 0),(_randomPos select 1),0.25],[],0,'NONE'];
			missionNamespace setVariable [
				'QS_analytics_entities_created',
				((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
				FALSE
			];
			_aa allowCrewInImmobile TRUE;
			_aa enableRopeAttach FALSE;
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
			_aa addEventHandler [
				'Killed',
				{
					params ['_killed','_killer'];
					private ['_name','_objType','_killerType','_killerDisplayName','_objDisplayName'];
					_objType = typeOf _killed;
					if (isPlayer _killer) then {
						if ((vehicle _killer) isKindOf 'Air') then {
							_killerType = typeOf (vehicle _killer);
							_killerDisplayName = getText (configFile >> 'CfgVehicles' >> _killerType >> 'displayName');
							_objDisplayName = getText (configFile >> 'CfgVehicles' >> _objType >> 'displayName');
							_name = name _killer;
							['sideChat',[WEST,'BLU'],(format ['%1 has destroyed a(n) %2 with a %3!',_name,_objDisplayName,_killerDisplayName])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
						};
					};
				}
			];
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
				[_aaGroup,_pos,(_aoSize / 2.5)] call (missionNamespace getVariable 'QS_fnc_taskPatrol');
			};
			[(units _aaGroup),4] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
			_aa lock 3;
			/*/_aaGroup setVariable ['QS_AI_Groups',['QS_PATROL',_pos],FALSE];/*/
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
		for '_x' from 1 to _aaCount step 1 do {
			_aaArray = [_pos,(selectRandom _aaTypes)] call (missionNamespace getVariable 'QS_fnc_aoFortifiedAA');
			if (!(_aaArray isEqualTo [])) then {
				{
					0 = _enemiesArray pushBack _x;
				} count _aaArray;
			};
		};
	};
};

/*/=============================================================== INFANTRY PATROLS RANDOM/*/

if (_playerCount > 35) then {
	if (_allowVehicles) then {
		_grpCount = 10;
	} else {
		_grpCount = 12;
	};
} else {
	if (_allowVehicles) then {
		_grpCount = 7;
	} else {
		_grpCount = 9;
	};
};

diag_log '****************************************************';
diag_log '***** AO ENEMY ***** Spawning infantry patrols *****';
diag_log '****************************************************';

for '_x' from 0 to _grpCount step 1 do {
	if ((random 1) > 0.5) then {
		_randomPos = ['RADIUS',_pos,_aoSize,'LAND',[1.5,0,0.5,3,0,FALSE,objNull],TRUE,[],[],TRUE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
	} else {
		_randomPos = ['RADIUS',_pos,(_aoSize * 0.75),'LAND',[1.5,0,0.5,3,0,FALSE,objNull],TRUE,[],[],TRUE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
	};
	_infType = selectRandom _infTypes;
	/*/0 = _requestArray pushBack ['CREATE','PRIMARY','PATROL','INFANTRY',EAST,_randomPos,_pos,_infType];/*/
	_patrolGroup = [_randomPos,(random 360),EAST,_infType,FALSE] call (missionNamespace getVariable 'QS_fnc_spawnGroup');
	[_patrolGroup,_randomPos,125,TRUE] call (missionNamespace getVariable 'QS_fnc_taskPatrol');
	[(units _patrolGroup),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
	{
		[_x] call (missionNamespace getVariable 'QS_fnc_setCollectible');
		_x setVehiclePosition [(getPosWorld _x), [], 0, 'CAN_COLLIDE'];
		0 = _enemiesArray pushBack _x;
	} count (units _patrolGroup);
	
	if ((count (waypoints _patrolGroup)) > 1) then {
		_randomWaypoint = selectRandom (waypoints _patrolGroup);
		_randomWaypointPos = ['RADIUS',_randomPos,200,'LAND',[1,0,-1,-1,0,FALSE,objNull],FALSE,[_randomPos,300,'(1 + forest)',15,3],[],FALSE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');	/*/'(1 + forest) * (1 - houses)'/*/
		if ((_randomWaypointPos distance2D _randomPos) < 1000) then {
			_randomWaypoint setWaypointPosition [_randomWaypointPos,0];
		};
	};
	_patrolGroup setVariable ['QS_AI_GRP',TRUE,(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
	_patrolGroup setVariable ['QS_AI_GRP_CONFIG',['GENERAL','INFANTRY',(count (units _patrolGroup))],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
	_patrolGroup setVariable ['QS_AI_GRP_DATA',[TRUE,diag_tickTime],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
	/*/_patrolGroup setVariable ['QS_AI_Groups',['QS_PATROL',_pos],FALSE];/*/
};

/*/=============================================================== STATIC WEAPONS/*/

diag_log '****************************************************';
diag_log '***** AO ENEMY ***** Spawning static weapons *****';
diag_log '****************************************************';

private _staticUnits = [];
_staticGroup = createGroup [RESISTANCE,TRUE];
for '_x' from 0 to 2 do {
	_randomPos = [_pos,(_aoSize * 0.5),10,10] call (missionNamespace getVariable 'QS_fnc_findOverwatchPos');
	_staticType = selectRandom _staticTypes;
	/*/0 = _requestArray pushBack ['CREATE','PRIMARY','STATIC','INFANTRY',EAST,_randomPos,_pos,_staticType];/*/
	_static = createVehicle [_staticType,_randomPos,[],0,'NONE'];
	missionNamespace setVariable [
		'QS_analytics_entities_created',
		((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
		FALSE
	];
	_static setVectorUp (surfaceNormal _randomPos);
	_static setVelocity [0,0,0];
	[_static] call (missionNamespace getVariable 'QS_fnc_downgradeVehicleWeapons');
	_unit1 = _staticGroup createUnit [_mortGunnerType,_randomPos,[],0,'NONE'];
	missionNamespace setVariable [
		'QS_analytics_entities_created',
		((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
		FALSE
	];
	_unit1 = _unit1 call (missionNamespace getVariable 'QS_fnc_unitSetup');
	_unit1 assignAsGunner _static; 
	_unit1 moveInGunner _static;
	_staticUnits pushBack _unit1;
	_unit1 setVariable ['QS_staticGunnerVehicle',_static,FALSE];
	_unit1 addEventHandler [
		'Killed',
		{
			_killed = _this select 0;
			if (!isNull _killed) then {
				if (!isNull (_killed getVariable 'QS_staticGunnerVehicle')) then {
					(_killed getVariable 'QS_staticGunnerVehicle') setDamage 1;
				};
			};
		}
	];
	_static addEventHandler [
		'GetOut',
		{
			(_this select 2) setDamage 1;
			(_this select 0) setDamage 1;
		}
	];
	_staticGroup setBehaviour 'AWARE';
	_staticGroup setCombatMode 'RED';
	if ((random 1) > 0.5) then {
		_dirToCenter = _randomPos getDir _pos;
		_static setDir _dirToCenter;
		_staticGroup setFormDir _dirToCenter;
		_unit1 doWatch _pos;
	} else {
		_dirToCenter = _randomPos getDir _basePos;
		_static setDir _dirToCenter;
		_staticGroup setFormDir _dirToCenter;
		_unit1 doWatch _basePos;
	};
	_static lock 3;
	for '_x' from 0 to 2 step 1 do {
		_static setVectorUp [0,0,1];
	};
	[(units _staticGroup),2] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
	{
		0 = _enemiesArray pushBack _x;
	} count (units _staticGroup);
	0 = _enemiesArray pushBack _static;
};
_staticGroup2 = createGroup [RESISTANCE,TRUE];
{
	[_x] joinSilent _staticGroup2;
} count _staticUnits;

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
	_randomPos = [_pos,(_aoSize * 0.8),25,10] call (missionNamespace getVariable 'QS_fnc_findOverwatchPos');
	_infUrbanType = selectRandom _infUrbanTypes;
	/*/0 = _requestArray pushBack ['CREATE','PRIMARY','PATROL_OVERWATCH','INFANTRY',EAST,_randomPos,_pos,_infUrbanType];/*/
	_overwatchGroup = [_randomPos,(random 360),EAST,_infUrbanType,FALSE] call (missionNamespace getVariable 'QS_fnc_spawnGroup');
	[(units _overwatchGroup),2] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
	if ((random 1) > 0.5) then {
		[_overwatchGroup,_randomPos,65,TRUE] call (missionNamespace getVariable 'QS_fnc_taskPatrol');
	} else {
		if ((random 1) > 0.5) then {
			_overwatchGroup setFormDir (random 360);
		} else {
			_overwatchGroup setFormDir (_randomPos getDir _pos);
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
	/*/_overwatchGroup setVariable ['QS_AI_Groups',['QS_PATROL',_randomPos],FALSE];/*/
};

/*/=============================================================== MRAP/*/

diag_log '****************************************************';
diag_log '***** AO ENEMY ***** Spawning MRAPS *****';
diag_log '****************************************************';

if (_allowVehicles) then {
	for '_x' from 0 to 1 step 1 do {
		_AOmrapGroup = createGroup [EAST,TRUE];
		/*/_randomPos = ['RADIUS',_pos,_aoSize,'LAND',[],TRUE,[],[],TRUE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');/*/
		_randomPos = selectRandom _roadPositionsValid;
		_mrapType = selectRandom _mrapTypes;
		_AOmrap = createVehicle [_mrapType,_randomPos,[],0,'NONE'];
		missionNamespace setVariable [
			'QS_analytics_entities_created',
			((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
			FALSE
		];
		_AOmrap allowDamage FALSE;
		_AOmrap enableRopeAttach FALSE;
		_AOmrap enableVehicleCargo FALSE;
		if ((random 1) >= 0.3) then {_AOmrap allowCrewInImmobile TRUE;};
		_AOmrap setUnloadInCombat [TRUE,FALSE];
		/*/_AOmrap forceFollowRoad TRUE;/*/
		_AOmrap setConvoySeparation 50;
		_AOmrap limitSpeed 30;
		clearMagazineCargoGlobal _AOmrap;
		clearWeaponCargoGlobal _AOmrap;
		clearItemCargoGlobal _AOmrap;
		clearBackpackCargoGlobal _AOmrap;
		[_AOmrap] call (missionNamespace getVariable 'QS_fnc_downgradeVehicleWeapons');
		_AOmrap spawn {sleep 3; _this allowDamage TRUE;};
		_AOmrap setVectorUp (surfaceNormal _randomPos);
		_AOmrap addEventHandler [
			'Killed',
			{
				params ['_killed','_killer'];
				private ['_name','_objType','_killerType','_killerDisplayName','_objDisplayName'];
				_objType = typeOf _killed;
				if (isPlayer _killer) then {
					if ((vehicle _killer) isKindOf 'Air') then {
						_killerType = typeOf (vehicle _killer);
						_killerDisplayName = getText (configFile >> 'CfgVehicles' >> _killerType >> 'displayName');
						_objDisplayName = getText (configFile >> 'CfgVehicles' >> _objType >> 'displayName');
						_name = name _killer;
						['sideChat',[WEST,'BLU'],(format ['%1 has destroyed a(n) %2 with a %3!',_name,_objDisplayName,_killerDisplayName])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
					};
				};
			}
		];
		_AOmrap addEventHandler ['GetOut',(missionNamespace getVariable 'QS_fnc_AIXDismountDisabled')];
		_unit1 = _AOmrapGroup createUnit [_engineerType,_randomPos,[],0,'NONE'];
		missionNamespace setVariable [
			'QS_analytics_entities_created',
			((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
			FALSE
		];
		_unit1 = _unit1 call (missionNamespace getVariable 'QS_fnc_unitSetup');
		_unit1 assignAsDriver _AOmrap;
		_unit1 moveInDriver _AOmrap;
		_unit2 = _AOmrapGroup createUnit [_engineerType,_randomPos,[],0,'NONE'];
		missionNamespace setVariable [
			'QS_analytics_entities_created',
			((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
			FALSE
		];
		_unit2 = _unit2 call (missionNamespace getVariable 'QS_fnc_unitSetup');
		_unit2 assignAsGunner _AOmrap;
		_unit2 moveInGunner _AOmrap;
		_unit3 = _AOmrapGroup createUnit [_engineerType,_randomPos,[],0,'NONE'];
		missionNamespace setVariable [
			'QS_analytics_entities_created',
			((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
			FALSE
		];
		_unit3 = _unit3 call (missionNamespace getVariable 'QS_fnc_unitSetup');
		_unit3 assignAsCargo _AOmrap;
		_unit3 moveInCargo _AOmrap;
		_AOmrapGroup addVehicle _AOmrap;
		[_AOmrapGroup,_randomPos,_aoSize,_roadPositionsValid,TRUE] call (missionNamespace getVariable 'QS_fnc_taskPatrolVehicle');
		_AOmrap lock 3;
		{
			_x setVariable ['BIS_noCoreConversations',TRUE,FALSE];
			0 = _enemiesArray pushBack _x;
		} count (units _AOmrapGroup);
		[(units _AOmrapGroup),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
		_unit2 setSkill ['aimingAccuracy',0.1];
		_AOmrapGroup allowFleeing 0;
		0 = _enemiesArray pushBack _AOmrap;
		_AOmrapGroup setVariable ['QS_AI_GRP',TRUE,(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
		_AOmrapGroup setVariable ['QS_AI_GRP_CONFIG',['GENERAL','VEHICLE',(count (units _AOmrapGroup)),_AOmrap],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
		_AOmrapGroup setVariable ['QS_AI_GRP_DATA',[TRUE,diag_tickTime],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
		/*/_AOmrapGroup setVariable ['QS_AI_Groups',['QS_PATROL',_pos],FALSE];/*/
	};
};

/*/=============================================================== GROUND VEHICLE RANDOM/*/

diag_log '****************************************************';
diag_log '***** AO ENEMY ***** Spawning Armored Vehicles *****';
diag_log '****************************************************';

if (_allowVehicles) then {
	_vehCount = 0;
	if (_playerCount > 10) then {
		_vehCount = 1;
		if (_playerCount > 20) then {
			_vehCount = 2;
			if (_playerCount > 40) then {
				if ((random 1) > 0.5) then {
					_vehCount = 2;
				} else {
					_vehCount = 2;
				};
			};
		};
	};
	for '_x' from 0 to _vehCount step 1 do {
		_AOvehGroup = createGroup [EAST,TRUE];
		/*/_randomPos = ['RADIUS',_pos,_aoSize,'LAND',[],TRUE,[],[],TRUE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');/*/
		_vehType = selectRandom _vehTypes;
		_randomPos = selectRandom _roadPositionsValid;
		_AOveh = createVehicle [_vehType,[(_randomPos select 0),(_randomPos select 1),0.25],[],0,'NONE'];
		missionNamespace setVariable [
			'QS_analytics_entities_created',
			((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
			FALSE
		];
		_AOveh allowDamage FALSE;
		_AOveh limitSpeed 30;
		clearMagazineCargoGlobal _AOveh;
		clearWeaponCargoGlobal _AOveh;
		clearItemCargoGlobal _AOveh;
		clearBackpackCargoGlobal _AOveh;
		_AOveh setUnloadInCombat [TRUE,FALSE];
		if (_AOveh isKindOf 'B_APC_Tracked_01_rcws_F') then {
			{
				_AOveh setObjectTextureGlobal _x;
			} forEach [
				[0,'A3\armor_f_beta\apc_tracked_01\data\apc_tracked_01_body_indp_co.paa'],
				[1,'A3\armor_f_beta\apc_tracked_01\data\apc_tracked_01_body_indp_co.paa'],
				[2,'A3\armor_f_beta\apc_tracked_01\data\apc_tracked_01_body_indp_co.paa']			
			];
		};
		_AOveh addEventHandler ['GetOut',(missionNamespace getVariable 'QS_fnc_AIXDismountDisabled')];
		_AOveh enableRopeAttach FALSE;
		_AOveh enableVehicleCargo FALSE;
		if (random 1 >= 0.25) then {_AOveh allowCrewInImmobile TRUE;};
		/*/_AOveh forceFollowRoad TRUE;/*/
		_AOveh setConvoySeparation 50;
		[_AOveh] spawn {sleep 10; (_this select 0) allowDamage TRUE;};
		_AOveh setVectorUp (surfaceNormal _randomPos);
		[_AOveh] call (missionNamespace getVariable 'QS_fnc_downgradeVehicleWeapons');
		_AOveh addEventHandler [
			'Killed',
			{
				params ['_killed','_killer'];
				private ['_name','_objType','_killerType','_killerDisplayName','_objDisplayName'];
				_objType = typeOf _killed;
				if (isPlayer _killer) then {
					if ((vehicle _killer) isKindOf 'Air') then {
						_killerType = typeOf (vehicle _killer);
						_killerDisplayName = getText (configFile >> 'CfgVehicles' >> _killerType >> 'displayName');
						_objDisplayName = getText (configFile >> 'CfgVehicles' >> _objType >> 'displayName');
						_name = name _killer;
						['sideChat',[WEST,'BLU'],(format ['%1 has destroyed a(n) %2 with a %3!',_name,_objDisplayName,_killerDisplayName])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
					};
				};
			}
		];
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
		_unit3 = _AOvehGroup createUnit [_engineerType,_randomPos,[],0,'NONE'];
		missionNamespace setVariable [
			'QS_analytics_entities_created',
			((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
			FALSE
		];
		_unit3 = _unit3 call (missionNamespace getVariable 'QS_fnc_unitSetup');
		_unit3 assignAsCommander _AOveh;
		_unit3 moveInCommander _AOveh;
		_AOvehGroup addVehicle _AOveh;
		[_AOvehGroup,_randomPos,_aoSize,_roadPositionsValid,TRUE] call (missionNamespace getVariable 'QS_fnc_taskPatrolVehicle');
		_AOveh lock 3;
		[(units _AOvehGroup),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
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
		/*/_AOvehGroup setVariable ['QS_AI_Groups',['QS_PATROL',_pos],FALSE];/*/
	};
};
	
/*/=============================================================== HELICOPTER - Handled elsewhere now/*/

/*/
diag_log '****************************************************';
diag_log '***** AO ENEMY ***** Spawning Helicopter *****';
diag_log '****************************************************';

if (worldName in ['Altis','Tanoa','Takistan','Chernarus','Sahrani','Malden']) then {
	if ((random 1) > 0) then {
		_airGroup = createGroup [EAST,TRUE];
		_randomPos = ['RADIUS',_pos,_aoSize,'LAND',[],FALSE,[],[],TRUE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
		if (_playerCount > 20) then {
			_airTypes = if (worldName isEqualTo 'Tanoa') then [
				{['O_Heli_Light_02_dynamicLoadout_F','O_Heli_Light_02_v2_F','i_heli_light_03_dynamicloadout_f']},
				{['O_Heli_Light_02_dynamicLoadout_F','O_Heli_Light_02_v2_F','i_heli_light_03_dynamicloadout_f','O_Heli_Attack_02_dynamicLoadout_black_F','O_Heli_Attack_02_dynamicLoadout_F']}
			];
		} else {
			_airTypes = if (worldName isEqualTo 'Tanoa') then [
				{['O_Heli_Light_02_dynamicLoadout_F','O_Heli_Light_02_v2_F','i_heli_light_03_dynamicloadout_f']},
				{['O_Heli_Light_02_dynamicLoadout_F','O_Heli_Light_02_v2_F','i_heli_light_03_dynamicloadout_f','O_Heli_Attack_02_dynamicLoadout_black_F','O_Heli_Attack_02_dynamicLoadout_F']}
			];
		};
		_airType = selectRandom _airTypes;
		_air = createVehicle [_airType,[_randomPos select 0,_randomPos select 1,1000],[],0,'NONE'];
		missionNamespace setVariable [
			'QS_analytics_entities_created',
			((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
			FALSE
		];
		_air engineOn TRUE;
		[_air,1,[]] call (missionNamespace getVariable 'QS_fnc_vehicleLoadouts');
		clearMagazineCargoGlobal _air;
		clearWeaponCargoGlobal _air;
		clearItemCargoGlobal _air;
		clearBackpackCargoGlobal _air;
		_air setPos [_randomPos select 0,_randomPos select 1,300];
		_air enableRopeAttach FALSE;
		_air spawn {
			for '_x' from 0 to 149 step 1 do {
				_this setVelocity [0,0,0];
				sleep 0.1;
			};
		};
		_unit1 = _airGroup createUnit [_pilotType,_randomPos,[],0,'NONE'];
		missionNamespace setVariable [
			'QS_analytics_entities_created',
			((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
			FALSE
		];
		_unit1 = _unit1 call (missionNamespace getVariable 'QS_fnc_unitSetup');
		_unit1 assignAsDriver _air;
		_unit1 moveInDriver _air;
		_airGroup addVehicle _air;
		if (!((typeOf _air) in ['O_Heli_Light_02_dynamicLoadout_F','O_Heli_Light_02_v2_F'])) then {
			_unit2 = _airGroup createUnit [_pilotType,_randomPos,[],0,'NONE'];
			missionNamespace setVariable [
				'QS_analytics_entities_created',
				((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
				FALSE
			];
			_unit2 = _unit2 call (missionNamespace getVariable 'QS_fnc_unitSetup');
			
			_unit2 assignAsTurret [_air,[0]];
			_unit2 moveInTurret [_air,[0]];
		};
		
		if ((toLower _airType) isEqualTo 'i_heli_light_03_dynamicloadout_f') then {
			_unit = _airGroup createUnit [(['O_Soldier_AR_F','O_T_Soldier_AR_F'] select (worldName isEqualTo 'Tanoa')),[0,0,0],[],0,'NONE'];
			_unit addBackpack 'B_AssaultPack_blk';
			[_unit,'MMG_01_hex_ARCO_LP_F',3] call (missionNamespace getVariable 'BIS_fnc_addWeapon');
			_unit moveInCargo [_air,0];
			_enemiesArray pushBack _unit;
			_unit = _airGroup createUnit [(['O_Soldier_AR_F','O_T_Soldier_AR_F'] select (worldName isEqualTo 'Tanoa')),[0,0,0],[],0,'NONE'];
			_unit addBackpack 'B_AssaultPack_blk';
			[_unit,'MMG_01_hex_ARCO_LP_F',3] call (missionNamespace getVariable 'BIS_fnc_addWeapon');
			_unit moveInCargo [_air,1];
			_enemiesArray pushBack _unit;
			missionNamespace setVariable [
				'QS_analytics_entities_created',
				((missionNamespace getVariable 'QS_analytics_entities_created') + 2),
				FALSE
			];
			if (!(sunOrMoon isEqualTo 1)) then {
				(_air turretUnit [0]) action ['SearchlightOn',_air];
			};
		};
		_increment = (random 90);
		_radialPatrolPositions = [];
		for '_x' from 0 to 3 step 1 do {
			_position = _centerPos getPos [(_centerRadius * (selectRandom [1.5,2])),_increment];
			_position set [2,50];
			_radialPatrolPositions pushBack _position;
			_increment = _increment + (random 90);
		};
		_airGroup setVariable ['QS_AI_GRP',TRUE,FALSE];
		_airGroup setVariable ['QS_AI_GRP_CONFIG',['GENERAL','HELI',(count (units _airGroup)),_air],FALSE];
		_airGroup setVariable ['QS_AI_GRP_DATA',[],FALSE];
		_airGroup setVariable ['QS_AI_GRP_TASK',['PATROL_AIR',_radialPatrolPositions,diag_tickTime,-1],FALSE];
		_airGroup setVariable ['QS_AI_GRP_PATROLINDEX',0,FALSE];	
		[(units _airGroup),4] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
		_airGroup setCombatMode 'RED';
		_airGroup enableAttack TRUE;
		_air lock 3;
		{
			_x setVariable ['BIS_noCoreConversations',TRUE,FALSE];
			0 = _enemiesArray pushBack _x;
		} count (units _airGroup);
		0 = _enemiesArray pushBack _air;
	};
};
/*/

/*/=============================================================== SNIPERS/*/

diag_log '****************************************************';
diag_log '***** AO ENEMY ***** Spawning Snipers *****';
diag_log '****************************************************';

for '_x' from 0 to 2 do {
	_randomPos = [_pos,(_aoSize * 1.5),(_aoSize / 2),10] call (missionNamespace getVariable 'QS_fnc_findOverwatchPos');
	_sniperGroup = [_randomPos,(random 360),EAST,'OI_SniperTeam',FALSE] call (missionNamespace getVariable 'QS_fnc_spawnGroup');
	_sniperGroup setBehaviour 'COMBAT';
	_sniperGroup setCombatMode 'RED';
	[(units _sniperGroup),(selectRandom [3,4])] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
	_dirToCenter = _randomPos getDir _pos;
	_sniperGroup setFormDir _dirToCenter;
	{
		_x setVehiclePosition [(getPosWorld _x),[],0,'CAN_COLLIDE'];
		[_x] call (missionNamespace getVariable 'QS_fnc_setCollectible');
		_x doWatch _pos; 
		0 = _enemiesArray pushBack _x;
	} count (units _sniperGroup);
};

/*/=============================================================== JTACs/*/
missionNamespace setVariable ['jtacEASTGroup',(createGroup [EAST,TRUE]),FALSE];
for '_x' from 1 to 2 do {
	_randomPos = [_pos,600,300,10] call (missionNamespace getVariable 'QS_fnc_findOverwatchPos');
	_jtac = (missionNamespace getVariable 'jtacEASTGroup') createUnit [_jtacType,_randomPos,[],0,'NONE'];
	missionNamespace setVariable [
		'QS_analytics_entities_created',
		((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
		FALSE
	];
	_jtac doWatch _pos;
	_jtac = _jtac call (missionNamespace getVariable 'QS_fnc_unitSetup');
	(missionNamespace getVariable 'jtacEASTGroup') setBehaviour 'STEALTH';
	(missionNamespace getVariable 'jtacEASTGroup') setCombatMode 'YELLOW';
	(missionNamespace getVariable 'jtacEASTGroup') setSpeedMode 'LIMITED';
	_jtac selectWeapon 'Laserdesignator_02';
	_jtac disableAI 'PATH';
};
{
	[_x] call (missionNamespace getVariable 'QS_fnc_setCollectible');
	_x setUnitPosWeak 'MIDDLE';
	0 = _enemiesArray pushBack _x;
	_x setVehiclePosition [(getPosWorld _x),[],0,'CAN_COLLIDE'];
	_x disableAI 'PATH';
	_x setRank 'COLONEL';
} count (units (missionNamespace getVariable 'jtacEASTGroup'));
[(units (missionNamespace getVariable 'jtacEASTGroup')),3] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');

/*/=============================================================== AO MORTAR PIT/*/

if ((random 1) > 0.5) then {
	diag_log '****************************************************';
	diag_log '***** AO ENEMY ***** Spawning Mortar Pit *****';
	diag_log '****************************************************';
	_mortarPit = [_pos] call (missionNamespace getVariable 'QS_fnc_aoMortarPit');
	if (!(_mortarPit isEqualTo [])) then {
		{
			0 = _enemiesArray pushBack _x;
		} count _mortarPit;
	};
	/*/WIP spawn mortar pit guards/*/
};

/*/=============================================================== ENEMIES IN BUILDINGS/*/

diag_log '****************************************************';
diag_log '***** AO ENEMY ***** Spawning Enemies in buildings *****';
diag_log '****************************************************';

_town = _pos nearObjects ['House',_aoSize];
if ((count _town) > 6) then {
	if (worldName isEqualTo 'Tanoa') then {
		_indArray = [
			"I_C_Soldier_Para_1_F","I_C_Soldier_Para_2_F","I_C_Soldier_Para_3_F","I_C_Soldier_Para_4_F","I_C_Soldier_Para_5_F","I_C_Soldier_Para_6_F",
			"I_C_Soldier_Para_7_F","I_C_Soldier_Para_8_F"
		];	
	} else {
		_indArray = [
			"O_soldierU_A_F","O_soldierU_AAR_F","O_soldierU_AR_F","O_soldierU_medic_F","O_engineer_U_F","O_soldierU_exp_F","O_SoldierU_GL_F",
			"O_Urban_HeavyGunner_F","O_soldierU_M_F","O_soldierU_AT_F","O_soldierU_F","O_soldierU_LAT_F","O_Urban_Sharpshooter_F",
			"O_SoldierU_SL_F","O_soldierU_TL_F","O_G_engineer_F","O_G_medic_F","O_G_Soldier_A_F","O_G_Soldier_AR_F","O_G_Soldier_exp_F","O_G_Soldier_F","O_G_Soldier_F",
			"O_G_Soldier_GL_F","O_G_Soldier_LAT_F","O_G_Soldier_lite_F","O_G_Soldier_M_F","O_G_Soldier_SL_F","O_G_Soldier_TL_F",
			"O_G_Sharpshooter_F","O_G_Soldier_AR_F"
		];
	};
	_AOgarrisonGroup = createGroup [RESISTANCE,TRUE];
	_toGarrison = [];
	for '_x' from 0 to 26 step 1 do {
		_randomUnit = selectRandom _indArray;
		_unit = _AOgarrisonGroup createUnit [_randomUnit,_pos,[],0,'NONE'];
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
	[_toGarrison,2] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
};
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
[_pos,(_aoSize / 1.5),_toGarrison,['House']] spawn (missionNamespace getVariable 'QS_fnc_garrisonUnits');
{
	if (!isNull _x) then {
		[_x] joinSilent _resistanceGrp;
	};
} count _toGarrison;
{
	if (!isNull _x) then {
		_x forceSpeed 0;
	};
} count (units _resistanceGrp);
/*/=============================================================== ENEMIES IN HQ BUILDINGS/*/
if (worldName isEqualTo 'Tanoa') then {
	_indArray = [
		"O_V_Soldier_Exp_ghex_F","O_V_Soldier_ghex_F","O_V_Soldier_JTAC_ghex_F",'O_V_Soldier_LAT_ghex_F','O_V_Soldier_M_ghex_F',
		'O_V_Soldier_Medic_ghex_F','O_V_Soldier_TL_ghex_F'
	];
} else {
	_indArray = [
		"O_V_Soldier_Exp_hex_F","O_V_Soldier_hex_F","O_V_Soldier_JTAC_hex_F",'O_V_Soldier_LAT_hex_F','O_V_Soldier_M_hex_F',
		'O_V_Soldier_Medic_hex_F','O_V_Soldier_TL_hex_F'
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
_QS_HQpos set [2,0];
[_QS_HQpos,60,_toGarrison,[]] spawn (missionNamespace getVariable 'QS_fnc_garrisonUnits');
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
	if (!(_boatArray isEqualTo [])) then {
		{
			0 = _enemiesArray pushBack _x;
		} count _boatArray;
	};
};

/*/=============================================================== HQ GUARDS/*/

diag_log '****************************************************';
diag_log '***** AO ENEMY ***** Spawning HQ Guards *****';
diag_log '****************************************************';

_randomPos = ['RADIUS',_QS_HQpos,50,'LAND',[],FALSE,[],[0,40,'O_soldier_F'],TRUE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
_infUrbanType = selectRandom _infUrbanTypes;
_hqGroup1 = [_randomPos,(random 360),EAST,_infUrbanType,FALSE] call (missionNamespace getVariable 'QS_fnc_spawnGroup');
[_hqGroup1,_QS_HQpos,70,TRUE] call (missionNamespace getVariable 'QS_fnc_taskPatrol');
[(units _hqGroup1),2] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
_hqGroup1 setVariable ['QS_AI_GRP',TRUE,(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
_hqGroup1 setVariable ['QS_AI_GRP_CONFIG',['GENERAL','INFANTRY',(count (units _hqGroup1))],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
_hqGroup1 setVariable ['QS_AI_GRP_DATA',[TRUE,diag_tickTime],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
/*/_hqGroup1 setVariable ['QS_AI_Groups',['QS_DEFEND',QS_HQpos],FALSE];/*/
{
	_x setVehiclePosition [(getPosWorld _x),[],0,'CAN_COLLIDE'];
	[_x] call (missionNamespace getVariable 'QS_fnc_setCollectible');
	0 = _enemiesArray pushBack _x;
} count (units _hqGroup1);
_randomPos = ['RADIUS',_QS_HQpos,50,'LAND',[],FALSE,[],[0,40,'O_soldier_F'],TRUE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
_hqGroup2 = [_randomPos,(random 360),EAST,_infUrbanType,FALSE] call (missionNamespace getVariable 'QS_fnc_spawnGroup');
[_hqGroup2,_QS_HQpos,70,TRUE] call (missionNamespace getVariable 'QS_fnc_taskPatrol');
[(units _hqGroup2),2] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
_hqGroup2 setVariable ['QS_AI_GRP',TRUE,(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
_hqGroup2 setVariable ['QS_AI_GRP_CONFIG',['GENERAL','INFANTRY',(count (units _hqGroup2))],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
_hqGroup2 setVariable ['QS_AI_GRP_DATA',[TRUE,diag_tickTime],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
/*/_hqGroup2 setVariable ['QS_AI_Groups',['QS_DEFEND',QS_HQpos],FALSE];/*/
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
[_commander] spawn {sleep 15; (_this select 0) allowDamage TRUE;};
[_QS_HQpos,40,(units (missionNamespace getVariable 'csatHQGroup')),[]] spawn (missionNamespace getVariable 'QS_fnc_garrisonUnits');
/*/csatHQGroup setVariable ['QS_AI_Groups',['QS_COMMAND',QS_HQpos],FALSE];/*/
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
if (_QS_new) exitWith {_requestArray;};
missionNamespace setVariable ['QS_classic_AI_enemy_0',_enemiesArray,FALSE];
diag_log '****************************************************';
diag_log '***** AO ENEMY ***** fn_aoEnemy END ****************';
diag_log '****************************************************';