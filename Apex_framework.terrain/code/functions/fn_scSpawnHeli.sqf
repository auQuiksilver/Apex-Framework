/*/
File: fn_scSpawnHeli.sqf
Author:

	Quiksilver
	
Last modified:

	22/07/2019 A3 1.94 by Quiksilver
	
Description:

	Spawn Heli Patrol
__________________________________________________/*/

params ['_type'];
private [
	'_centerPos','_centerRadius','_arrayHelicopters','_grp','_side','_randomPos','_pilotType','_worldSize','_air','_airType','_airTypes','_playerCount','_unit','_increment',
	'_radialPatrolPositions','_position'
];
_centerPos = missionNamespace getVariable 'QS_AOpos';
_centerRadius = missionNamespace getVariable 'QS_aoSize';
_worldName = worldName;
_worldSize = worldSize;
if (_worldName isEqualTo 'Tanoa') then {
	_pilotType = "O_T_Helipilot_F";
} else {
	_pilotType = "O_Helipilot_F";
};
_side = EAST;
_arrayHelicopters = [];
_grp = createGroup [_side,TRUE];
_playerCount = count allPlayers;
for '_x' from 0 to 1 step 0 do {
	_randomPos = [(random _worldSize),(random _worldSize),1000];
	if ((allPlayers inAreaArray [_randomPos,2000,2000,0,FALSE]) isEqualTo []) exitWith {};
};
if (_playerCount > 20) then {
	if (_playerCount > 40) then {
		if (_worldName in ['Tanoa','Enoch']) then {
			_airType = selectRandomWeighted [
				'o_heli_light_02_dynamicloadout_f',1,
				'i_e_heli_light_03_dynamicloadout_f',1,
				'o_heli_attack_02_dynamicloadout_f',0.25
			];
		} else {
			_airType = selectRandomWeighted [
				'o_heli_light_02_dynamicloadout_f',1,
				'i_heli_light_03_dynamicloadout_f',1,
				'o_heli_attack_02_dynamicloadout_f',([0,0.75] select (_worldName isEqualTo 'Altis'))
			];
		};
	} else {
		if (_worldName in ['Tanoa','Enoch']) then {
			_airType = selectRandomWeighted [
				'o_heli_light_02_dynamicloadout_f',1,
				'i_e_heli_light_03_dynamicloadout_f',1,
				'o_heli_attack_02_dynamicloadout_f',0.1
			];		
		} else {
			_airType = selectRandomWeighted [
				'o_heli_light_02_dynamicloadout_f',1,
				'i_heli_light_03_dynamicloadout_f',1,
				'o_heli_attack_02_dynamicloadout_f',([0,0.25] select (_worldName isEqualTo 'Altis'))
			];		
		};
	};
} else {
	if (_worldName in ['Tanoa','Enoch']) then {
		_airType = selectRandomWeighted [
			'o_heli_light_02_dynamicloadout_f',1,
			'i_e_heli_light_03_dynamicloadout_f',1,
			'o_heli_attack_02_dynamicloadout_f',0
		];
	} else {
		_airType = selectRandomWeighted [
			'o_heli_light_02_dynamicloadout_f',1,
			'i_heli_light_03_dynamicloadout_f',1,
			'o_heli_attack_02_dynamicloadout_f',0
		];
	};
};
_air = createVehicle [_airType,[(_randomPos # 0),(_randomPos # 1),1000],[],0,'FLY'];
missionNamespace setVariable [
	'QS_analytics_entities_created',
	((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
	FALSE
];
[_air,2,[]] call (missionNamespace getVariable 'QS_fnc_vehicleLoadouts');
_air engineOn TRUE;
_air addEventHandler [
	'GetOut',
	{
		(_this select 2) setDamage 1;
	}
];
_air addEventHandler ['Killed',(missionNamespace getVariable 'QS_fnc_vKilled2')];
_air addEventHandler ['IncomingMissile',(missionNamespace getVariable 'QS_fnc_AIXMissileCountermeasure')];
_air setVariable ['QS_dynSim_ignore',TRUE,TRUE];
clearMagazineCargoGlobal _air;
clearWeaponCargoGlobal _air;
clearItemCargoGlobal _air;
clearBackpackCargoGlobal _air;
_air setPos [(_randomPos select 0),(_randomPos select 1),300];
_air enableRopeAttach FALSE;
['setFeatureType',_air,2] remoteExec ['QS_fnc_remoteExecCmd',-2,_air];
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
removeAllWeapons _unit;
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
};
if ((toLower _airType) in ['i_heli_light_03_dynamicloadout_f','i_e_heli_light_03_dynamicloadout_f']) then {
	_unit = _grp createUnit [(['O_Soldier_AR_F','O_T_Soldier_AR_F'] select (_worldName in ['Tanoa','Enoch'])),[0,0,0],[],0,'NONE'];
	_unit addBackpack 'B_AssaultPack_blk';
	[_unit,'MMG_01_hex_ARCO_LP_F',4] call (missionNamespace getVariable 'QS_fnc_addWeapon');
	_unit addPrimaryWeaponItem 'optic_lrps';
	_unit moveInCargo [_air,0];
	_unit selectWeapon (primaryWeapon _unit);
	_unit = _grp createUnit [(['O_Soldier_AR_F','O_T_Soldier_AR_F'] select (_worldName isEqualTo ['Tanoa','Enoch'])),[0,0,0],[],0,'NONE'];
	_unit addBackpack 'B_AssaultPack_blk';
	[_unit,'MMG_01_hex_ARCO_LP_F',4] call (missionNamespace getVariable 'QS_fnc_addWeapon');
	_unit addPrimaryWeaponItem 'optic_lrps';
	_unit moveInCargo [_air,1];
	_unit selectWeapon (primaryWeapon _unit);
	if (!(sunOrMoon isEqualTo 1)) then {
		(_air turretUnit [0]) action ['SearchlightOn',_air];
	};
	missionNamespace setVariable ['QS_analytics_entities_created',((missionNamespace getVariable 'QS_analytics_entities_created') + 2),FALSE];
} else {
	{
		_x disableAI 'LIGHTS';
	} forEach (crew _air);
	_air setCollisionLight FALSE;
};
[(units _grp),4] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
_grp setBehaviour 'AWARE';
_grp setCombatMode 'RED';
_grp enableAttack TRUE;
_air lock 3;
_air setVehicleReceiveRemoteTargets TRUE;
_air setVehicleReportRemoteTargets TRUE;
_air setVariable ['QS_dynSim_ignore',TRUE,TRUE];
_air enableDynamicSimulation FALSE;
_grp setVariable ['QS_dynSim_ignore',TRUE,TRUE];
_grp enableDynamicSimulation FALSE;
_grp addVehicle _air;
{
	_x setVariable ['QS_dynSim_ignore',TRUE,TRUE];
	_x enableDynamicSimulation FALSE;
} forEach (units _grp);
(missionNamespace getVariable 'QS_AI_supportProviders_CASHELI') pushBack (effectiveCommander _air);
(missionNamespace getVariable 'QS_AI_supportProviders_INTEL') pushBack (effectiveCommander _air);
{
	_x setVariable ['BIS_noCoreConversations',TRUE,FALSE];
	_x setVehicleReceiveRemoteTargets TRUE;
	_x setVehicleReportRemoteTargets TRUE;
	0 = _arrayHelicopters pushBack _x;
} count (units _grp);
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
_grp setVariable ['QS_AI_GRP_CONFIG',['AO','AIR_PATROL_HELI',(count (units _grp)),_air],FALSE];
_grp setVariable ['QS_AI_GRP_DATA',[],FALSE];
_grp setVariable ['QS_AI_GRP_TASK',['PATROL_AIR',_radialPatrolPositions,diag_tickTime,-1],FALSE];
_grp setVariable ['QS_AI_GRP_PATROLINDEX',0,FALSE];
_grp move (_radialPatrolPositions select 0);
_arrayHelicopters;