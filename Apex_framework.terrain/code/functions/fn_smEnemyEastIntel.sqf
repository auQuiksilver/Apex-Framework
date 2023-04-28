/*
File: fn_smEnemyEastIntel.sqf
Author: 

	Quiksilver
	
Last modified:

	28/09/2017 A3 1.76 by Quiksilver

Description:

	
___________________________________________*/

/*/---------- CONFIG/*/

private ["_infTypes","_infType","_vehTypes","_vehType","_pos","_flatPos","_randomPos","_unitsArray","_enemiesArray","_infteamPatrol","_SMvehPatrol","_SMveh","_SMaaPatrol","_SMaa",'_grp'];

_pos = _this # 0;
_enemiesArray = [];
_x = 0;
_infTypes = ['OIA_InfTeam','OIA_InfTeam_AT','OIA_InfTeam_AA','OI_reconPatrol','OG_InfAssault'];
_vehTypes = ['O_MRAP_02_gmg_F','O_MRAP_02_hmg_F','I_MRAP_03_gmg_F','I_MRAP_03_hmg_F','O_G_Offroad_01_armed_F','o_apc_wheeled_02_rcws_v2_f'];

/*/---------- INFANTRY/*/

for "_x" from 0 to (1 + (random 1)) step 1 do {
	_randomPos = ['RADIUS',_pos,300,'LAND',[],FALSE,[],[],TRUE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
	_infType = selectRandom _infTypes;
	_infteamPatrol = [_randomPos,(random 360),EAST,_infType,FALSE] call (missionNamespace getVariable 'QS_fnc_spawnGroup');
	[_infteamPatrol,_pos,100,TRUE] call (missionNamespace getVariable 'QS_fnc_taskPatrol');
	[(units _infteamPatrol),2] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
	{
		[_x] call (missionNamespace getVariable 'QS_fnc_setCollectible');
		_x setVehiclePosition [(getPosWorld _x),[],0,'NONE'];
		0 = _enemiesArray pushBack _x;
	} count (units _infteamPatrol);
	_infteamPatrol setVariable ['QS_AI_GRP',TRUE,QS_system_AI_owners];
	_infteamPatrol setVariable ['QS_AI_GRP_CONFIG',['GENERAL','INFANTRY',(count (units _infteamPatrol))],QS_system_AI_owners];
	_infteamPatrol setVariable ['QS_AI_GRP_DATA',[TRUE,serverTime],QS_system_AI_owners];
};

/*/---------- RANDOM VEHICLE/*/

_randomPos = ['RADIUS',_pos,300,'LAND',[],FALSE,[],[],TRUE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
_vehType = selectRandom _vehTypes;
_SMveh = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _vehType,_vehType],_randomPos,[],0,'NONE'];
_SMveh lock 3;
[0,_SMveh,EAST,1] call (missionNamespace getVariable 'QS_fnc_vSetup2');
_SMveh addEventHandler ['GetOut',(missionNamespace getVariable 'QS_fnc_AIXDismountDisabled')];
_SMveh addEventHandler ['Killed',(missionNamespace getVariable 'QS_fnc_vKilled2')];
if ((random 1) >= 0.333) then {
	_SMveh allowCrewInImmobile [TRUE,TRUE];
};
(missionNamespace getVariable 'QS_AI_vehicles') pushBack _SMveh;
_grp = createVehicleCrew _SMveh;
[_grp,_pos,250,[],TRUE] call (missionNamespace getVariable 'QS_fnc_taskPatrolVehicle');

_grp setVariable ['QS_AI_GRP',TRUE,QS_system_AI_owners];
_grp setVariable ['QS_AI_GRP_CONFIG',['GENERAL','VEHICLE',(count (units _grp)),_SMveh],QS_system_AI_owners];
_grp setVariable ['QS_AI_GRP_DATA',[TRUE,serverTime],QS_system_AI_owners];

[(units _grp),2] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
{
	_x call (missionNamespace getVariable 'QS_fnc_unitSetup');
	_x setVariable ['BIS_noCoreConversations',TRUE,FALSE];
	0 = _enemiesArray pushBack _x;
} forEach (units _grp);
0 = _enemiesArray pushBack _SMveh;
_enemiesArray;