/*/
File: fn_scSpawnHeli.sqf
Author:

	Quiksilver
	
Last modified:

	7/06/2022 A3 2.10 by Quiksilver
	
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
_pilotType = "O_Helipilot_F";
_side = EAST;
_arrayHelicopters = [];
_grp = createGroup [_side,TRUE];
_playerCount = count allPlayers;
for '_x' from 0 to 1 step 0 do {
	sleep diag_deltaTime;
	_randomPos = [(random _worldSize),(random _worldSize),1000];
	if ((allPlayers inAreaArray [_randomPos,2000,2000,0,FALSE]) isEqualTo []) exitWith {};
};
if (_playerCount > 20) then {
	if (_playerCount > 40) then {
		if (_worldName in ['Tanoa','Enoch']) then {
			_airType = selectRandomWeighted [
				'o_heli_light_02_dynamicloadout_f',1,
				'i_e_heli_light_03_dynamicloadout_f',1,
				'o_heli_attack_02_dynamicloadout_f',0.125
			];
		} else {
			_airType = selectRandomWeighted [
				'o_heli_light_02_dynamicloadout_f',1,
				'i_heli_light_03_dynamicloadout_f',1,
				'o_heli_attack_02_dynamicloadout_f',([0,0.25] select (_worldName isEqualTo 'Altis'))
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
_air = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _airType,_airType],(_randomPos vectorAdd [0,0,1000]),[],0,'FLY'];
[_air,(selectRandomWeighted [2,0.5,3,0.5]),[]] call (missionNamespace getVariable 'QS_fnc_vehicleLoadouts');
_air engineOn TRUE;
_air addEventHandler ['GetOut',{(_this # 2) setDamage 1;}];
_air addEventHandler ['Killed',(missionNamespace getVariable 'QS_fnc_vKilled2')];
_air addEventHandler ['IncomingMissile',(missionNamespace getVariable 'QS_fnc_AIXMissileCountermeasure')];
_air setVariable ['QS_dynSim_ignore',TRUE,TRUE];
clearMagazineCargoGlobal _air;
clearWeaponCargoGlobal _air;
clearItemCargoGlobal _air;
clearBackpackCargoGlobal _air;
_air setPos (_randomPos vectorAdd [0,0,300]);
_air enableRopeAttach FALSE;
['setFeatureType',_air,2] remoteExec ['QS_fnc_remoteExecCmd',-2,_air];
_unit = _grp createUnit [QS_core_units_map getOrDefault [toLowerANSI _pilotType,_pilotType],_randomPos,[],0,'NONE'];
_unit = _unit call (missionNamespace getVariable 'QS_fnc_unitSetup');
_unit assignAsDriver _air;
_unit moveInDriver _air;
removeAllWeapons _unit;
if (!((toLowerANSI _airType) in ['o_heli_light_02_v2_f','o_heli_light_02_dynamicloadout_f'])) then {
	_unit = _grp createUnit [QS_core_units_map getOrDefault [toLowerANSI _pilotType,_pilotType],_randomPos,[],0,'NONE'];
	_unit = _unit call (missionNamespace getVariable 'QS_fnc_unitSetup');
	_unit assignAsTurret [_air,[0]];
	_unit moveInTurret [_air,[0]];
};
_air setVehiclePosition [(getPosWorld _air),[],0,'FLY'];
if ((toLowerANSI _airType) in ['i_heli_light_03_dynamicloadout_f','i_e_heli_light_03_dynamicloadout_f']) then {
	_unit = _grp createUnit [QS_core_units_map getOrDefault [toLowerANSI 'o_soldier_ar_f','o_soldier_ar_f'],[0,0,0],[],0,'NONE'];
	_unit addBackpack 'B_AssaultPack_blk';
	[_unit,'MMG_01_hex_ARCO_LP_F',4] call (missionNamespace getVariable 'QS_fnc_addWeapon');
	_unit addPrimaryWeaponItem 'optic_lrps';
	_unit moveInCargo [_air,0];
	_unit selectWeapon (primaryWeapon _unit);
	_unit = _grp createUnit [QS_core_units_map getOrDefault [toLowerANSI 'o_soldier_ar_f','o_soldier_ar_f'],[0,0,0],[],0,'NONE'];
	_unit addBackpack 'B_AssaultPack_blk';
	[_unit,'MMG_01_hex_ARCO_LP_F',4] call (missionNamespace getVariable 'QS_fnc_addWeapon');
	_unit addPrimaryWeaponItem 'optic_lrps';
	_unit moveInCargo [_air,1];
	_unit selectWeapon (primaryWeapon _unit);
	if (([0,0,0] getEnvSoundController 'night') isEqualTo 1) then {
		(_air turretUnit [0]) action ['SearchlightOn',_air];
	};
} else {
	{
		_x enableAIFeature ['LIGHTS',FALSE];
	} forEach (crew _air);
	_air setCollisionLight FALSE;
};
[(units _grp),4] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
_grp setBehaviourStrong 'AWARE';
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
_grp setGroupIdGlobal ['Close Air Support (Heli)'];
_grp addEventHandler ['EnemyDetected',{call (missionNamespace getVariable 'QS_fnc_AIGroupEventEnemyDetected2')}];
{
	_x setVariable ['QS_dynSim_ignore',TRUE,TRUE];
	_x enableDynamicSimulation FALSE;
} forEach (units _grp);
missionNamespace setVariable ['QS_AI_supportProviders_CASHELI',((missionNamespace getVariable 'QS_AI_supportProviders_CASHELI') + [effectiveCommander _air]),QS_system_AI_owners];
missionNamespace setVariable ['QS_AI_supportProviders_INTEL',((missionNamespace getVariable 'QS_AI_supportProviders_INTEL') + [effectiveCommander _air]),QS_system_AI_owners];
{
	_x enableAIFeature ['RADIOPROTOCOL',FALSE];
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
_grp setVariable ['QS_AI_GRP_TASK',['PATROL_AIR',_radialPatrolPositions,serverTime,-1],FALSE];
_grp setVariable ['QS_AI_GRP_PATROLINDEX',0,FALSE];
_grp move (_radialPatrolPositions # 0);
_arrayHelicopters;