/*
File: fn_smEnemyGuer.sqf
Author: 

	Quiksilver
	
Last modified:

	28/09/2017 A3 1.76 by Quiksilver

Description:

___________________________________________*/

/*/---------- CONFIG/*/

private [
	"_x","_pos","_flatPos","_randomPos","_unitsArray","_enemiesArray","_infteamPatrol","_SMvehPatrol","_SMveh","_SMaaPatrol","_SMaa","_IRGsniperGroup","_grp",
	'_unitType','_unit','_garrisonGrp','_unitTypes','_aaType'
];

_infTeams = ["OG_InfSentry","OG_InfSquad","OG_InfSquad_Weapons","OG_InfTeam","OG_InfTeam_AT","OG_ReconSentry","OG_SniperTeam_M"];
_vehTypes = ["O_G_Offroad_01_armed_F"];
_aaType = 'O_APC_Tracked_02_AA_F';
_enemiesArray = [];
_x = 0;
_pos = getPosATL (_this # 0);

/*/---------- INFANTRY RANDOM/*/

for '_x' from 0 to (2 + (random 1)) do {
	_randomPos = ['RADIUS',_pos,300,'LAND',[],FALSE,[],[],TRUE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
	_infTeam = selectRandom _infTeams;
	_infteamPatrol = [_randomPos,(random 360),EAST,_infTeam,FALSE] call (missionNamespace getVariable 'QS_fnc_spawnGroup');
	[_infteamPatrol,_pos, 100,TRUE] call (missionNamespace getVariable 'QS_fnc_taskPatrol');
	[(units _infteamPatrol),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
	{
		[_x] call (missionNamespace getVariable 'QS_fnc_setCollectible');
		0 = _enemiesArray pushBack _x;
		_x setVehiclePosition [(getPosWorld _x),[],0,'NONE'];
	} count (units _infteamPatrol);
	_infteamPatrol setVariable ['QS_AI_GRP',TRUE,QS_system_AI_owners];
	_infteamPatrol setVariable ['QS_AI_GRP_CONFIG',['GENERAL','INFANTRY',(count (units _infteamPatrol))],QS_system_AI_owners];
	_infteamPatrol setVariable ['QS_AI_GRP_DATA',[TRUE,serverTime],QS_system_AI_owners];
	_infteamPatrol setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
};

/*/---------- SNIPER/*/

for '_x' from 0 to 2 do {
	_randomPos = [_pos,600,100,20] call (missionNamespace getVariable 'QS_fnc_findOverwatchPos');
	_IRGsniperGroup = [_randomPos,(random 360),EAST,'OG_SniperTeam_M',FALSE] call (missionNamespace getVariable 'QS_fnc_spawnGroup');
	{
		_x setBehaviour 'COMBAT';
		_x setCombatMode 'RED';
		_x setUnitPos 'Middle';
		_x commandWatch _pos;
		0 = _enemiesArray pushBack _x;
		[_x] call (missionNamespace getVariable 'QS_fnc_setCollectible');
		_x setVehiclePosition [(getPosWorld _x),[],0,'NONE'];
	} count (units _IRGsniperGroup);
	_IRGsniperGroup setFormDir (_randomPos getDir _pos);
	[(units _IRGsniperGroup),4] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
	_IRGsniperGroup setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
};

/*/---------- VEHICLES	/*/
	
for '_x' from 0 to 2 do {
	_randomPos = ['RADIUS',_pos,300,'LAND',[],FALSE,[],[],TRUE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
	_SMveh = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI 'O_G_Offroad_01_armed_F','O_G_Offroad_01_armed_F'],_randomPos,[],0,'NONE'];
	_SMveh lock 3;
	_SMveh allowCrewInImmobile [TRUE,TRUE];
	_SMveh addEventHandler ['Killed',(missionNamespace getVariable 'QS_fnc_vKilled2')];
	[0,_SMveh,EAST,1] call (missionNamespace getVariable 'QS_fnc_vSetup2');
	(missionNamespace getVariable 'QS_AI_vehicles') pushBack _SMveh;
	_SMveh addEventHandler ['GetOut',(missionNamespace getVariable 'QS_fnc_AIXDismountDisabled')];
	_grp = createVehicleCrew _SMveh;
	[_grp,_pos,250,[],TRUE] call (missionNamespace getVariable 'QS_fnc_taskPatrolVehicle');
	[(units _grp),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
	{
		_x call (missionNamespace getVariable 'QS_fnc_unitSetup');
		_x setVariable ['BIS_noCoreConversations',TRUE,FALSE];
		0 = _enemiesArray pushBack _x;
	} forEach (units _grp);
	_grp setVariable ['QS_AI_GRP',TRUE,QS_system_AI_owners];
	_grp setVariable ['QS_AI_GRP_CONFIG',['GENERAL','VEHICLE',(count (units _grp)),_SMveh],QS_system_AI_owners];
	_grp setVariable ['QS_AI_GRP_DATA',[TRUE,serverTime],QS_system_AI_owners];
	_grp setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
	_enemiesArray pushBack _SMveh;
};

/*/---------- VEHICLE AA/*/

if ((count allPlayers) > 25) then {
	for '_x' from 0 to 1 do {
		_randomPos = ['RADIUS',_pos,300,'LAND',[],FALSE,[],[],TRUE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
		_SMaa = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _aaType,_aaType],_randomPos,[],0,'NONE'];
		_SMaa allowCrewInImmobile [TRUE,TRUE];
		_SMaa addEventHandler ['GetOut',(missionNamespace getVariable 'QS_fnc_AIXDismountDisabled')];
		_SMaa addEventHandler ['Killed',(missionNamespace getVariable 'QS_fnc_vKilled2')];
		_grp = createVehicleCrew _SMaa;
		_SMaa lock 3;
		[_grp,_pos,250,[],TRUE] call (missionNamespace getVariable 'QS_fnc_taskPatrolVehicle');
		{
			_x setVariable ['BIS_noCoreConversations',TRUE,FALSE];
			[_x] call (missionNamespace getVariable 'QS_fnc_setCollectible');
			0 = _enemiesArray pushBack _x;
		} count (units _grp);
		_enemiesArray pushBack _SMaa;
		_grp setVariable ['QS_AI_GRP',TRUE,QS_system_AI_owners];
		_grp setVariable ['QS_AI_GRP_CONFIG',['GENERAL','VEHICLE',(count (units _grp)),_SMaa],QS_system_AI_owners];
		_grp setVariable ['QS_AI_GRP_DATA',[TRUE,serverTime],QS_system_AI_owners];
		_grp setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
		[(units _grp),2] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
	};
};

/*/---------- GARRISON FORTIFICATIONS/*/
if (worldName isEqualTo 'Tanoa') then {
	_unitTypes = [
		"I_C_Soldier_Bandit_4_F","I_C_Soldier_Bandit_3_F","I_C_Soldier_Bandit_7_F","I_C_Soldier_Bandit_5_F","I_C_Soldier_Bandit_6_F","I_C_Soldier_Bandit_2_F",
		"I_C_Soldier_Bandit_8_F","I_C_Soldier_Bandit_1_F","I_C_Soldier_Bandit_4_F","I_C_Soldier_Bandit_3_F","I_C_Soldier_Bandit_5_F","I_C_Soldier_Bandit_1_F",
		"I_C_Soldier_Bandit_6_F","I_C_Soldier_Bandit_2_F","I_C_Soldier_Bandit_7_F","I_C_Soldier_Bandit_8_F","I_C_Soldier_Para_2_F","I_C_Soldier_Para_4_F",
		"I_C_Soldier_Para_6_F","I_C_Soldier_Para_1_F","I_C_Soldier_Para_7_F","I_C_Soldier_Para_5_F","I_C_Soldier_Para_8_F","I_C_Soldier_Para_3_F",
		"I_C_Soldier_Para_2_F","I_C_Soldier_Para_4_F","I_C_Soldier_Para_1_F","I_C_Soldier_Para_3_F","I_C_Soldier_Para_6_F","I_C_Soldier_Para_5_F",
		"I_C_Soldier_Para_7_F","I_C_Soldier_Para_8_F"
	];
} else {
	_unitTypes = [
		"O_G_engineer_F","O_G_medic_F","O_G_Soldier_A_F","O_G_Soldier_AR_F","O_G_Soldier_exp_F","O_G_Soldier_F","O_G_Soldier_F",
		"O_G_Soldier_GL_F","O_G_Soldier_LAT_F","O_G_Soldier_lite_F","O_G_Soldier_M_F","O_G_Soldier_SL_F","O_G_Soldier_TL_F",
		"O_G_Sharpshooter_F","O_G_Soldier_AR_F"
	];
};
_garrisonGrp = createGroup [EAST,TRUE];
for '_x' from 0 to 7 step 1 do {
	_unitType = selectRandom _unitTypes;
	_unit = _garrisonGrp createUnit [QS_core_units_map getOrDefault [toLowerANSI _unitType,_unitType],_pos,[],0,'FORM'];
	0 = _enemiesArray pushBack _unit;
	_unit = _unit call (missionNamespace getVariable 'QS_fnc_unitSetup');
	[_unit] call (missionNamespace getVariable 'QS_fnc_setCollectible');
};
[_pos,100,(units _garrisonGrp),['House','Building']] spawn (missionNamespace getVariable 'QS_fnc_garrisonUnits');
[(units _garrisonGrp),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
_garrisonGrp setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
_enemiesArray;