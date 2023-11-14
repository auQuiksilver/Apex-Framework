/*/
File: fn_smEnemyEast.sqf
Author: 

	Quiksilver
	
Last modified:

	8/03/2018 A3 1.80 by Quiksilver

Description:

	-
___________________________________________/*/

/*/---------- CONFIG/*/

private [
	'_vehTypes','_vehType','_pos','_unit1','_unit2','_unit3','_flatPos',
	'_randomPos','_enemiesArray','_infteamPatrol','_SMvehPatrol','_SMveh','_SMaaPatrol','_SMaa',
	'_smSniperTeam','_grp','_unitTypes','_unitType','_garrisonGrp','_unit','_aaType'
];
_infTypes = [
	'OIA_InfSquad',3,
	'OIA_InfTeam',2,
	'OIA_ARTeam',2,
	'OIA_InfTeam_LAT',2,
	'OIA_InfAssault',2,
	'OIA_InfTeam_AA',1,
	'OIA_InfTeam_AT',1,
	'OIA_InfTeam_HAT',1
];
_aaType = 'O_APC_Tracked_02_AA_F';
_vehTypes = ['O_MRAP_02_gmg_F','O_MRAP_02_hmg_F','O_MBT_02_cannon_F','O_APC_Tracked_02_cannon_F','O_APC_Wheeled_02_rcws_v2_F'];
_enemiesArray = [];
if (isNull (_this # 0)) exitWith {};
_pos = getPosATL (_this # 0);

/*/---------- INFANTRY RANDOM/*/

for '_x' from 0 to (round (1 + (random 2))) step 1 do {
	_randomPos = ['RADIUS',_pos,300,'LAND',[],FALSE,[],[],TRUE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
	_infteamPatrol = [_randomPos,(random 360),EAST,(selectRandomWeighted _infTypes),FALSE,grpNull,TRUE,TRUE] call (missionNamespace getVariable 'QS_fnc_spawnGroup');
	[_infteamPatrol,_pos,100,TRUE] call (missionNamespace getVariable 'QS_fnc_taskPatrol');
	[(units _infteamPatrol),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
	{
		[_x] call (missionNamespace getVariable 'QS_fnc_setCollectible');
		_x setVehiclePosition [(getPosWorld _x),[],0,'NONE'];
		0 = _enemiesArray pushBack _x;
	} count (units _infteamPatrol);
	_infteamPatrol setVariable ['QS_AI_GRP',TRUE,QS_system_AI_owners];
	_infteamPatrol setVariable ['QS_AI_GRP_CONFIG',['GENERAL','INFANTRY',(count (units _infteamPatrol))],QS_system_AI_owners];
	_infteamPatrol setVariable ['QS_AI_GRP_DATA',[TRUE,serverTime],QS_system_AI_owners];
	_infteamPatrol setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
};

/*/---------- SNIPER/*/

for '_x' from 0 to 1 step 1 do {
	_randomPos = [_pos,500,100,10] call (missionNamespace getVariable 'QS_fnc_findOverwatchPos');
	_smSniperTeam = [_randomPos,(random 360),EAST,'OI_SniperTeam_2',FALSE] call (missionNamespace getVariable 'QS_fnc_spawnGroup');
	[(units _smSniperTeam),4] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
	{
		_x setBehaviour 'COMBAT';
		_x setCombatMode 'RED';
		_x setUnitPos 'Down';
		0 = _enemiesArray pushBack _x;
		[_x] call (missionNamespace getVariable 'QS_fnc_setCollectible');
		_x setVehiclePosition [(getPosWorld _x),[],0,'NONE'];
	} count (units _smSniperTeam);
	_smSniperTeam setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
};
	
/*/---------- VEHICLE RANDOM/*/

_randomPos = ['RADIUS',_pos,300,'LAND',[],FALSE,[],[],TRUE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
_vehType = selectRandomWeighted ([2] call (missionNamespace getVariable 'QS_fnc_getAIMotorPool'));
_SMveh1 = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _vehType,_vehType],_randomPos,[],0,'NONE'];
_SMveh1 allowCrewInImmobile [TRUE,TRUE];
[0,_SMveh1,EAST,1] call (missionNamespace getVariable 'QS_fnc_vSetup2');
_SMveh1 lock 3;
(missionNamespace getVariable 'QS_AI_vehicles') pushBack _SMveh1;
_SMveh1 addEventHandler ['GetOut',(missionNamespace getVariable 'QS_fnc_AIXDismountDisabled')];
_SMveh1 addEventHandler ['Killed',(missionNamespace getVariable 'QS_fnc_vKilled2')];
private _grp = createVehicleCrew _SMveh1;
if (!((side _grp) in [EAST,RESISTANCE])) then {
	_grp = createGroup [EAST,TRUE];
	(crew _SMveh1) joinSilent _grp;
};
{
	_x call (missionNamespace getVariable 'QS_fnc_unitSetup');
} forEach (units _grp);
[(units _grp),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
[_grp,_pos,250,[],TRUE] call (missionNamespace getVariable 'QS_fnc_taskPatrolVehicle');
_grp setVariable ['QS_AI_GRP',TRUE,QS_system_AI_owners];
_grp setVariable ['QS_AI_GRP_CONFIG',['GENERAL','VEHICLE',(count (units _grp)),_SMveh1],QS_system_AI_owners];
_grp setVariable ['QS_AI_GRP_DATA',[TRUE,serverTime],QS_system_AI_owners];
_grp setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
_enemiesArray pushBack _SMveh1;
{
	_x setVariable ['BIS_noCoreConversations',TRUE,FALSE];
	[_x] call (missionNamespace getVariable 'QS_fnc_setCollectible');
	0 = _enemiesArray pushBack _x;
} count (units _grp);

/*/---------- VEHICLE AA/*/

if ((count allPlayers) > 25) then {
	_SMaaPatrol = createGroup [EAST,TRUE];
	_randomPos = ['RADIUS',_pos,300,'LAND',[],FALSE,[],[],TRUE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
	_SMaa = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _aaType,_aaType],_randomPos,[],0,'NONE'];
	if ((random 1) >= 0.333) then {
		_SMaa allowCrewInImmobile [TRUE,TRUE];
	};
	_SMaa lock 3;
	_SMaa addEventHandler ['GetOut',(missionNamespace getVariable 'QS_fnc_AIXDismountDisabled')];
	_SMaa addEventHandler ['Killed',(missionNamespace getVariable 'QS_fnc_vKilled2')];
	_grp = createVehicleCrew _SMaa;
	{
		_x call (missionNamespace getVariable 'QS_fnc_unitSetup');
	} forEach (units _grp);
	[_grp,_pos,250,[],TRUE] call (missionNamespace getVariable 'QS_fnc_taskPatrolVehicle');
	
	_grp setVariable ['QS_AI_GRP',TRUE,QS_system_AI_owners];
	_grp setVariable ['QS_AI_GRP_CONFIG',['GENERAL','VEHICLE',(count (units _grp)),_SMaa],QS_system_AI_owners];
	_grp setVariable ['QS_AI_GRP_DATA',[TRUE,serverTime],QS_system_AI_owners];
	_grp setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
	{
		_x setVariable ['BIS_noCoreConversations',TRUE,FALSE];
		[_x] call (missionNamespace getVariable 'QS_fnc_setCollectible');
		0 = _enemiesArray pushBack _x;
	} count (units _grp);
	[0,_SMaa,EAST,1] call (missionNamespace getVariable 'QS_fnc_vSetup2');
	0 = _enemiesArray pushBack _SMaa;
	[(units _grp),4] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
};
_unitTypes = [
	'O_soldierU_A_F','O_soldierU_AAR_F','O_soldierU_AR_F','O_soldierU_medic_F','O_engineer_U_F','O_soldierU_exp_F','O_SoldierU_GL_F',
	'O_Urban_HeavyGunner_F','O_soldierU_M_F','O_soldierU_AA_F','O_soldierU_AT_F','O_soldierU_F','O_soldierU_LAT_F','O_Urban_Sharpshooter_F',
	'O_SoldierU_SL_F','O_soldierU_TL_F'
];
_garrisonGrp = createGroup [EAST,TRUE];
for '_x' from 0 to 11 step 1 do {
	_unitType = selectRandom _unitTypes;
	_unit = _garrisonGrp createUnit [QS_core_units_map getOrDefault [toLowerANSI _unitType,_unitType],_pos,[],0,'FORM'];
	0 = _enemiesArray pushBack _unit;
	_unit = _unit call (missionNamespace getVariable 'QS_fnc_unitSetup');
	[_unit] call (missionNamespace getVariable 'QS_fnc_setCollectible');
};
[_pos,150,(units _garrisonGrp),['House','Building']] spawn (missionNamespace getVariable 'QS_fnc_garrisonUnits');
[(units _garrisonGrp),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
_garrisonGrp setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
_enemiesArray;