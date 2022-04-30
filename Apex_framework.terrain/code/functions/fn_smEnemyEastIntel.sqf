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

_pos = _this select 0;
_enemiesArray = [];
_x = 0;
_infTypes = ["OIA_InfTeam","OIA_InfTeam_AT","OIA_InfTeam_AA","OI_reconPatrol",'OG_InfAssault'];
if (worldName isEqualTo 'Tanoa') then {
	_vehTypes = ["O_T_MRAP_02_gmg_ghex_F","O_T_MRAP_02_hmg_ghex_F","O_T_LSV_02_armed_F","I_MRAP_03_hmg_F","I_MRAP_03_gmg_F",'o_t_apc_wheeled_02_rcws_v2_ghex_f'];
} else {
	_vehTypes = ['O_MRAP_02_gmg_F','O_MRAP_02_hmg_F','I_MRAP_03_gmg_F','I_MRAP_03_hmg_F','O_G_Offroad_01_armed_F','o_apc_wheeled_02_rcws_v2_f'];
};

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
	_infteamPatrol setVariable ['QS_AI_GRP',TRUE,(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
	_infteamPatrol setVariable ['QS_AI_GRP_CONFIG',['GENERAL','INFANTRY',(count (units _infteamPatrol))],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
	_infteamPatrol setVariable ['QS_AI_GRP_DATA',[TRUE,diag_tickTime],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
};

/*/---------- RANDOM VEHICLE/*/

_randomPos = ['RADIUS',_pos,300,'LAND',[],FALSE,[],[],TRUE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
_vehType = selectRandom _vehTypes;
_SMveh = createVehicle [_vehType,_randomPos,[],0,'NONE'];
missionNamespace setVariable [
	'QS_analytics_entities_created',
	((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
	FALSE
];
_SMveh lock 3;
[0,_SMveh,EAST,1] call (missionNamespace getVariable 'QS_fnc_vSetup2');
_SMveh addEventHandler ['GetOut',(missionNamespace getVariable 'QS_fnc_AIXDismountDisabled')];
_SMveh addEventHandler ['Killed',(missionNamespace getVariable 'QS_fnc_vKilled2')];
if ((random 1) >= 0.333) then {
	_SMveh allowCrewInImmobile TRUE;
};
(missionNamespace getVariable 'QS_AI_vehicles') pushBack _SMveh;
_grp = createVehicleCrew _SMveh;
missionNamespace setVariable [
	'QS_analytics_entities_created',
	((missionNamespace getVariable 'QS_analytics_entities_created') + (count (crew _SMveh))),
	FALSE
];
[_grp,_pos,250,[],TRUE] call (missionNamespace getVariable 'QS_fnc_taskPatrolVehicle');

_grp setVariable ['QS_AI_GRP',TRUE,(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
_grp setVariable ['QS_AI_GRP_CONFIG',['GENERAL','VEHICLE',(count (units _grp)),_SMveh],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
_grp setVariable ['QS_AI_GRP_DATA',[TRUE,diag_tickTime],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];

[(units _grp),2] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
{
	_x call (missionNamespace getVariable 'QS_fnc_unitSetup');
	_x setVariable ['BIS_noCoreConversations',TRUE,FALSE];
	0 = _enemiesArray pushBack _x;
} forEach (units _grp);
0 = _enemiesArray pushBack _SMveh;
if (missionNamespace getVariable ['QS_HC_Active',FALSE]) then {
	{
		if (_x isKindOf 'Man') then {
			_grp = group _x;
			if (isNil {_grp getVariable 'QS_grp_HC'}) then {
				_grp setVariable ['QS_grp_HC',TRUE,FALSE];
			};
		};
	} forEach _enemiesArray;
};
_enemiesArray;