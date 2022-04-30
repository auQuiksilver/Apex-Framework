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

if (worldName in ['Tanoa','Lingor3']) then {
	_aaType = 'O_T_APC_Tracked_02_AA_ghex_F';
	_vehTypes = ['O_T_MRAP_02_gmg_ghex_F','O_T_MRAP_02_hmg_ghex_F','O_T_MBT_02_cannon_ghex_F','O_T_APC_Tracked_02_cannon_ghex_F','O_T_APC_Wheeled_02_rcws_v2_ghex_F'];
} else {
	_aaType = 'O_APC_Tracked_02_AA_F';
	_vehTypes = ['O_MRAP_02_gmg_F','O_MRAP_02_hmg_F','O_MBT_02_cannon_F','O_APC_Tracked_02_cannon_F','O_APC_Wheeled_02_rcws_v2_F'];
};
_enemiesArray = [];
if (isNull (_this select 0)) exitWith {};
_pos = getPos (_this select 0);

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
	_infteamPatrol setVariable ['QS_AI_GRP',TRUE,(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
	_infteamPatrol setVariable ['QS_AI_GRP_CONFIG',['GENERAL','INFANTRY',(count (units _infteamPatrol))],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
	_infteamPatrol setVariable ['QS_AI_GRP_DATA',[TRUE,diag_tickTime],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
	_infteamPatrol setVariable ['QS_GRP_HC',TRUE,FALSE];
};

/*/---------- SNIPER/*/

for '_x' from 0 to 1 step 1 do {
	_randomPos = [_pos,500,100,10] call (missionNamespace getVariable 'QS_fnc_findOverwatchPos');
	_smSniperTeam = [_randomPos,(random 360),EAST,'OI_SniperTeam_2',FALSE] call (missionNamespace getVariable 'QS_fnc_spawnGroup');
	[(units _smSniperTeam),4] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
	{
		_x setBehaviour 'COMBAT';
		_x setCombatMode 'RED';
		_x setUnitPos 'DOWN';
		0 = _enemiesArray pushBack _x;
		[_x] call (missionNamespace getVariable 'QS_fnc_setCollectible');
		_x setVehiclePosition [(getPosWorld _x),[],0,'NONE'];
	} count (units _smSniperTeam);
	_smSniperTeam setVariable ['QS_GRP_HC',TRUE,FALSE];
};
	
/*/---------- VEHICLE RANDOM/*/

_randomPos = ['RADIUS',_pos,300,'LAND',[],FALSE,[],[],TRUE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
_vehType = selectRandomWeighted ([2] call (missionNamespace getVariable 'QS_fnc_getAIMotorPool'));
_SMveh1 = createVehicle [_vehType,_randomPos,[],0,'NONE'];
missionNamespace setVariable ['QS_analytics_entities_created',((missionNamespace getVariable 'QS_analytics_entities_created') + 1),FALSE];
_SMveh1 allowCrewInImmobile TRUE;
[0,_SMveh1,EAST,1] call (missionNamespace getVariable 'QS_fnc_vSetup2');
_SMveh1 lock 3;
(missionNamespace getVariable 'QS_AI_vehicles') pushBack _SMveh1;
_SMveh1 addEventHandler ['GetOut',(missionNamespace getVariable 'QS_fnc_AIXDismountDisabled')];
_SMveh1 addEventHandler ['Killed',(missionNamespace getVariable 'QS_fnc_vKilled2')];
private _grp = createVehicleCrew _SMveh1;
if (!((side _grp) in [EAST,RESISTANCE])) then {
	_grp = createGroup [EAST,TRUE];
	{
		[_x] joinSilent _grp;
	} forEach (crew _SMveh1);
};
missionNamespace setVariable ['QS_analytics_entities_created',((missionNamespace getVariable 'QS_analytics_entities_created') + (count (crew _SMveh1))),FALSE];
{
	_x call (missionNamespace getVariable 'QS_fnc_unitSetup');
} forEach (units _grp);
[(units _grp),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
[_grp,_pos,250,[],TRUE] call (missionNamespace getVariable 'QS_fnc_taskPatrolVehicle');
_grp setVariable ['QS_AI_GRP',TRUE,(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
_grp setVariable ['QS_AI_GRP_CONFIG',['GENERAL','VEHICLE',(count (units _grp)),_SMveh1],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
_grp setVariable ['QS_AI_GRP_DATA',[TRUE,diag_tickTime],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
_grp setVariable ['QS_GRP_HC',TRUE,FALSE];
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
	_SMaa = createVehicle [_aaType,_randomPos,[],0,'NONE'];
	missionNamespace setVariable [
		'QS_analytics_entities_created',
		((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
		FALSE
	];
	if ((random 1) >= 0.333) then {
		_SMaa allowCrewInImmobile TRUE;
	};
	_SMaa lock 3;
	_SMaa addEventHandler ['GetOut',(missionNamespace getVariable 'QS_fnc_AIXDismountDisabled')];
	_SMaa addEventHandler ['Killed',(missionNamespace getVariable 'QS_fnc_vKilled2')];
	_grp = createVehicleCrew _SMaa;
	missionNamespace setVariable [
		'QS_analytics_entities_created',
		((missionNamespace getVariable 'QS_analytics_entities_created') + (count (crew _SMaa))),
		FALSE
	];
	{
		_x call (missionNamespace getVariable 'QS_fnc_unitSetup');
	} forEach (units _grp);
	[_grp,_pos,250,[],TRUE] call (missionNamespace getVariable 'QS_fnc_taskPatrolVehicle');
	
	_grp setVariable ['QS_AI_GRP',TRUE,(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
	_grp setVariable ['QS_AI_GRP_CONFIG',['GENERAL','VEHICLE',(count (units _grp)),_SMaa],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
	_grp setVariable ['QS_AI_GRP_DATA',[TRUE,diag_tickTime],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
	_grp setVariable ['QS_GRP_HC',TRUE,FALSE];
	{
		_x setVariable ['BIS_noCoreConversations',TRUE,FALSE];
		[_x] call (missionNamespace getVariable 'QS_fnc_setCollectible');
		0 = _enemiesArray pushBack _x;
	} count (units _grp);
	[0,_SMaa,EAST,1] call (missionNamespace getVariable 'QS_fnc_vSetup2');
	0 = _enemiesArray pushBack _SMaa;
	[(units _grp),4] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
};

if (worldName isEqualTo 'Tanoa') then {
	_unitTypes = [
		"O_T_Soldier_SL_F","O_T_Soldier_AR_F","O_T_Soldier_GL_F","O_T_Soldier_M_F","O_T_Soldier_AT_F","O_T_Soldier_AAT_F","O_T_Soldier_A_F","O_T_Medic_F",
		"O_T_Soldier_SL_F","O_T_Soldier_F","O_T_Soldier_LAT_F","O_T_Soldier_M_F","O_T_Soldier_TL_F","O_T_Soldier_AR_F","O_T_Soldier_A_F","O_T_Medic_F"
	];
} else {
	_unitTypes = [
		'O_soldierU_A_F','O_soldierU_AAR_F','O_soldierU_AR_F','O_soldierU_medic_F','O_engineer_U_F','O_soldierU_exp_F','O_SoldierU_GL_F',
		'O_Urban_HeavyGunner_F','O_soldierU_M_F','O_soldierU_AA_F','O_soldierU_AT_F','O_soldierU_F','O_soldierU_LAT_F','O_Urban_Sharpshooter_F',
		'O_SoldierU_SL_F','O_soldierU_TL_F'
	];
};
_garrisonGrp = createGroup [EAST,TRUE];
for '_x' from 0 to 11 step 1 do {
	_unitType = selectRandom _unitTypes;
	_unit = _garrisonGrp createUnit [_unitType,_pos,[],0,'FORM'];
	missionNamespace setVariable [
		'QS_analytics_entities_created',
		((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
		FALSE
	];
	0 = _enemiesArray pushBack _unit;
	_unit = _unit call (missionNamespace getVariable 'QS_fnc_unitSetup');
	[_unit] call (missionNamespace getVariable 'QS_fnc_setCollectible');
};
[_pos,150,(units _garrisonGrp),['House','Building']] spawn (missionNamespace getVariable 'QS_fnc_garrisonUnits');
[(units _garrisonGrp),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
_garrisonGrp setVariable ['QS_GRP_HC',TRUE,FALSE];
_enemiesArray;