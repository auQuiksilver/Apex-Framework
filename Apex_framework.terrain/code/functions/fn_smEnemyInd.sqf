/*
File: fn_smEnemyInd.sqf
Author: 

	Quiksilver
	
Last modified:

	28/09/2017 A3 1.76 by Quiksilver

Description:

	
___________________________________________*/

/*/--------- CONFIG/*/

private [
	"_x","_pos","_flatPos","_randomPos","_unitsArray","_enemiesArray","_infteamPatrol","_SMvehPatrol","_SMveh",
	"_SMaaPatrol","_SMaa","_indSniperTeam","_infTeams","_infTeam","_vehTypes","_vehType",'_u1','_u2','_u3','_grp',
	'_unitType','_unit','_garrisonGrp','_unitTypes','_aaType'
];
_enemiesArray = [];
_x = 0;
_pos = getPosATL QS_sideObj;
_infTeams = ["HAF_InfTeam","HAF_InfTeam_AA","HAF_InfTeam_AT","HAF_InfSentry","HAF_InfSquad"];
_vehTypes = ["I_APC_Wheeled_03_cannon_F","I_APC_tracked_03_cannon_F","I_MBT_03_cannon_F","I_MRAP_03_gmg_F","I_MRAP_03_hmg_F"];
_aaType = 'O_APC_Tracked_02_AA_F';

/*/---------- INFANTRY/*/

for "_x" from 0 to (2 + (random 1)) do {
	_randomPos = ['RADIUS',_pos,300,'LAND',[],FALSE,[],[],TRUE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
	_infTeam = selectRandom _infTeams;
	_infteamPatrol = [_randomPos,(random 360),RESISTANCE,_infTeam,FALSE] call (missionNamespace getVariable 'QS_fnc_spawnGroup');
	[_infteamPatrol,_pos, 100,TRUE] call (missionNamespace getVariable 'QS_fnc_taskPatrol');
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

for "_x" from 0 to 1 do {
	_randomPos = [_pos, 500, 100, 20] call (missionNamespace getVariable 'QS_fnc_findOverwatchPos');
	_indSniperTeam = [_randomPos,(random 360),RESISTANCE,'HAF_SniperTeam',FALSE] call (missionNamespace getVariable 'QS_fnc_spawnGroup');
	{
		_x setBehaviour 'COMBAT';
		_x setCombatMode 'RED';
		_x setUnitPos 'Down';
		_x setVehiclePosition [(getPosWorld _x),[],0,'NONE'];
		[_x] call (missionNamespace getVariable 'QS_fnc_setCollectible');
		0 = _enemiesArray pushBack _x;
	} count (units _indSniperTeam);
	[(units _indSniperTeam),4] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
	_indSniperTeam setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
};

/*/---------- RANDOM VEHICLE/*/

_SMvehPatrol = createGroup [RESISTANCE,TRUE];
_randomPos = ['RADIUS',_pos,300,'LAND',[],FALSE,[],[],TRUE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
_vehType = selectRandom _vehTypes;
_SMveh = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _vehType,_vehType],_randomPos,[],0,'NONE'];
_u1 = _SMvehPatrol createUnit [QS_core_units_map getOrDefault [toLowerANSI 'i_engineer_f','i_engineer_f'],_randomPos,[],0,'NONE'];
_u2 = _SMvehPatrol createUnit [QS_core_units_map getOrDefault [toLowerANSI 'i_engineer_f','i_engineer_f'],_randomPos,[],0,'NONE'];
_u3 = _SMvehPatrol createUnit [QS_core_units_map getOrDefault [toLowerANSI 'i_engineer_f','i_engineer_f'],_randomPos,[],0,'NONE'];
_u1 = _u1 call (missionNamespace getVariable 'QS_fnc_unitSetup');
_u2 = _u2 call (missionNamespace getVariable 'QS_fnc_unitSetup');
_u3 = _u3 call (missionNamespace getVariable 'QS_fnc_unitSetup');
_u1 assignAsDriver _SMveh;
_u2 assignAsGunner _SMveh;
_u3 assignAsCommander _SMveh;

_u1 moveInDriver _SMveh;
_u2 moveInGunner _SMveh;
_u3 moveInCommander _SMveh;
(missionNamespace getVariable 'QS_AI_vehicles') pushBack _SMveh;
_SMveh lock 3;
[0,_SMveh,EAST,1] call (missionNamespace getVariable 'QS_fnc_vSetup2');
_SMveh addEventHandler ['GetOut',(missionNamespace getVariable 'QS_fnc_AIXDismountDisabled')];
_SMveh addEventHandler ['Killed',(missionNamespace getVariable 'QS_fnc_vKilled2')];
[_SMvehPatrol,_pos,250,[],TRUE] call (missionNamespace getVariable 'QS_fnc_taskPatrolVehicle');
[(units _SMvehPatrol),2] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
if (random 1 >= 0.333) then {
	_SMveh allowCrewInImmobile [TRUE,TRUE];
};
{
	_x setVariable ['BIS_noCoreConversations',TRUE,FALSE];
	0 = _enemiesArray pushBack _x;
	[_x] call (missionNamespace getVariable 'QS_fnc_setCollectible');
} count (units _SMvehPatrol);
_SMvehPatrol setVariable ['QS_AI_GRP',TRUE,QS_system_AI_owners];
_SMvehPatrol setVariable ['QS_AI_GRP_CONFIG',['GENERAL','VEHICLE',(count (units _SMvehPatrol)),_SMveh],QS_system_AI_owners];
_SMvehPatrol setVariable ['QS_AI_GRP_DATA',[TRUE,serverTime],QS_system_AI_owners];
_SMvehPatrol setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
_enemiesArray pushBack _SMveh;

/*/---------- AA VEHICLE/*/

if ((count allPlayers) > 25) then {
	for '_x' from 0 to 1 step 1 do {
		_randomPos = ['RADIUS',_pos,300,'LAND',[],FALSE,[],[],TRUE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
		_SMaa = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _aaType,_aaType],_randomPos,[],0,'NONE'];
		_grp = createVehicleCrew _SMaa;
		(missionNamespace getVariable 'QS_AI_vehicles') pushBack _SMaa;
		_SMaa lock 3;
		_SMaa addEventHandler ['GetOut',(missionNamespace getVariable 'QS_fnc_AIXDismountDisabled')];
		_SMaa addEventHandler ['Killed',(missionNamespace getVariable 'QS_fnc_vKilled2')];
		[_grp,_pos,250,[],TRUE] call (missionNamespace getVariable 'QS_fnc_taskPatrolVehicle');
		[(units _grp),4] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
		if (random 1 >= 0.25) then {
			_SMaa allowCrewInImmobile [TRUE,TRUE];
		};
		{
			_x call (missionNamespace getVariable 'QS_fnc_unitSetup');
			_x setVariable ['BIS_noCoreConversations',TRUE,FALSE];
			0 = _enemiesArray pushBack _x;
		} forEach (units _grp);
		_grp setVariable ['QS_AI_GRP',TRUE,QS_system_AI_owners];
		_grp setVariable ['QS_AI_GRP_CONFIG',['GENERAL','VEHICLE',(count (units _grp)),_SMaa],QS_system_AI_owners];
		_grp setVariable ['QS_AI_GRP_DATA',[TRUE,serverTime],QS_system_AI_owners];
		_grp setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
		_enemiesArray pushBack _SMaa;
	};
};

/*/---------- GARRISON FORTIFICATIONS/*/

_unitTypes = [
	"I_engineer_F","I_medic_F","I_Soldier_A_F","I_Soldier_AR_F","I_Soldier_exp_F","I_Soldier_F",
	"I_Soldier_GL_F","I_Soldier_LAT_F","I_Soldier_lite_F","I_Soldier_M_F","I_Soldier_SL_F","I_Soldier_TL_F",
	"I_Soldier_AR_F"
];
_garrisonGrp = createGroup [RESISTANCE,TRUE];
for '_x' from 0 to 7 step 1 do {
	_unitType = selectRandom _unitTypes;
	_unit = _garrisonGrp createUnit [QS_core_units_map getOrDefault [toLowerANSI _unitType,_unitType],_pos,[],0,'FORM'];
	0 = _enemiesArray pushBack _unit;
	_unit = _unit call (missionNamespace getVariable 'QS_fnc_unitSetup');
	[_unit] call (missionNamespace getVariable 'QS_fnc_setCollectible');
};
_garrisonGrp setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
[_pos,100,(units _garrisonGrp),['House','Building']] spawn (missionNamespace getVariable 'QS_fnc_garrisonUnits');
[(units _garrisonGrp),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
_enemiesArray;