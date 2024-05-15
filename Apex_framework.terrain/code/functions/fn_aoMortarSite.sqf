/*/
File: fn_aoMortarSite.sqf
Author: 

	Quiksilver

Last Modified:

	28/12/2022 A3 2.10 by Quiksilver

Description:

	AO Mortar Site
___________________________________________________/*/

_aoPos = missionNamespace getVariable 'QS_aoPos';
_aoSize = missionNamespace getVariable 'QS_aoSize';
private _multiplier = 0.75;
private _spawnPos = [0,0,0];
private _allPlayers = allPlayers;
for '_x' from 0 to 19 step 1 do {
	_spawnPos = ['RADIUS',_aoPos,(_aoSize * _multiplier),'LAND',[8,0,0.1,5,0,FALSE,objNull],FALSE,[],[],FALSE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
	if (
		(((missionNamespace getVariable 'QS_registeredPositions') inAreaArray [_spawnPos,100,100,0,FALSE]) isEqualTo []) &&
		{((((_spawnPos select [0,2]) nearRoads 15) select {((_x isEqualType objNull) && ((roadsConnectedTo _x) isNotEqualTo []))}) isEqualTo [])} &&
		{(!((toLowerANSI(surfaceType _spawnPos)) in ['#gdtasphalt']))} &&
		{(!([_spawnPos,20,8] call (missionNamespace getVariable 'QS_fnc_waterInRadius')))} &&
		{((_allPlayers inAreaArray [_spawnPos,300,300,0,FALSE]) isEqualTo [])} &&
		{(([_spawnPos,6] call (missionNamespace getVariable 'QS_fnc_areaGradient')) < 5)}
	) exitWith {};
	_multiplier = _multiplier + 0.1;
};
if (((_spawnPos distance2D _aoPos) > (_aoSize * 3)) || {(_spawnPos isEqualTo [])}) exitWith {[]};
private _composition = [_spawnPos,(random 360),(call (missionNamespace getVariable 'QS_data_siteMortar')),TRUE] call (missionNamespace getVariable 'QS_fnc_serverObjectsMapper');
private _mortar = objNull;
private _gunner = objNull;
{
	if (_x isKindOf 'StaticMortar') exitWith {
		_mortar = _x;
	};
} forEach _composition;
_composition pushBack _mortar;
_spawnPos set [2,0];
_gunnerGrp = createGroup [EAST,TRUE];
createVehicleCrew _mortar;
_gunner = gunner _mortar;
_gunner setVariable ['QS_AI_UNIT_regroup_disable',TRUE,FALSE];
_gunner addEventHandler [
	'Killed',
	{
		params ['_killed','_killer','_instigator','_useEffects'];
		(vehicle _killed) setDamage [1,TRUE];
		if (!isNull _instigator) then {
			if (isPlayer _instigator) then {
				_text = format ['%1 ( %2 ) %3',(name _instigator),(groupId (group _instigator)),localize 'STR_QS_Chat_080'];
				_text remoteExec ['systemChat',-2,FALSE];
			};
		};
	}
];
_gunner addEventHandler [
	'GetOutMan',
	{
		(_this # 0) setDamage [1,TRUE];
		(_this # 2) setDamage [1,TRUE];
	}
];
_mortar addEventHandler [
	'Killed',
	{
		{
			_x setMarkerAlpha 0;
		} forEach [
			'QS_marker_grid_mtrMkr',
			'QS_marker_grid_mtrCircle'
		];
		['GRID_UPDATE',[localize 'STR_QS_Notif_008',localize 'STR_QS_Notif_009']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
	}
];
_gunner call (missionNamespace getVariable 'QS_fnc_unitSetup');
_gunner addEventHandler [
	'FiredMan',
	{
		if ((toLowerANSI (_this # 5)) in ['8rnd_82mm_mo_shells','12rnd_230mm_rockets','32rnd_155mm_mo_shells','4rnd_155mm_mo_guided','2rnd_155mm_mo_lg']) then {
			if ((toLowerANSI (_this # 5)) in ['8rnd_82mm_mo_shells']) then {
				(_this # 6) addEventHandler ['Explode',{(_this + [0]) spawn (missionNamespace getVariable 'QS_fnc_craterEffect')}];
			} else {
				(_this # 6) addEventHandler ['Explode',{(_this + [1]) spawn (missionNamespace getVariable 'QS_fnc_craterEffect')}];
			};
		};
		if (missionNamespace isNil 'QS_enemy_mortarFireMessage') then {
			missionNamespace setVariable ['QS_enemy_mortarFireMessage',diag_tickTime,FALSE];
		};
		(vehicle (_this # 0)) setVehicleAmmo 1;
		if ((missionNamespace getVariable 'QS_enemy_mortarFireMessage') > (diag_tickTime - 300)) exitWith {};
		missionNamespace setVariable ['QS_enemy_mortarFireMessage',diag_tickTime,FALSE];
		['sideChat',[WEST,'HQ'],localize 'STR_QS_Chat_007'] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
	}
];
_gunner addEventHandler [
	'HandleRating',
	{
		params ['_unit','_rating'];
		if ((rating _unit) < 0) then {
			_unit addRating (0 - (rating _unit));
		};
	}
];
_gunner setVariable ['QS_dynSim_ignore',TRUE,TRUE];
_gunner enableDynamicSimulation FALSE;
missionNamespace setVariable ['QS_AI_supportProviders_MTR',((missionNamespace getVariable 'QS_AI_supportProviders_MTR') + [_gunner]),QS_system_AI_owners];
_mortar lock 3;
_mortar enableWeaponDisassembly FALSE;
_mortar setVariable ['QS_hidden',TRUE,TRUE];
_gunner setVariable ['QS_hidden',TRUE,TRUE];
[_gunner] joinSilent _gunnerGrp;
_gunnerGrp addVehicle _mortar;
_gunnerGrp setVariable ['QS_AI_GRP_CONFIG',['SUPPORT','MORTAR',_mortar],FALSE];
_gunnerGrp setVariable ['QS_AI_GRP_DATA',[TRUE,serverTime],FALSE];
_gunnerGrp setVariable ['QS_AI_GRP_TASK',['SUPPORT','MORTAR',serverTime,-1],FALSE];
_gunnerGrp setVariable ['QS_AI_GRP',TRUE,FALSE];
_composition pushBack _gunner;
_patrolGrp = [_spawnPos,(random 360),EAST,(selectRandom ['OG_ReconSentry','OG_SniperTeam_M']),FALSE] call (missionNamespace getVariable 'QS_fnc_spawnGroup');
[(units _patrolGrp),2] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
_patrolGroup setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
{
	_x call (missionNamespace getVariable 'QS_fnc_unitSetup');
	_x setVehiclePosition [(getPosWorld _x),[],10,'NONE'];
	_composition pushBack _x;
} forEach (units _patrolGrp);
_patrolGrp setVariable ['QS_AI_GRP_TASK',['DEFEND',_spawnPos,serverTime,-1],QS_system_AI_owners];
_patrolGrp setVariable ['QS_AI_GRP_PATROLINDEX',0,QS_system_AI_owners];
_patrolGrp setVariable ['QS_AI_GRP_CONFIG',['GENERAL','INFANTRY',(count (units _patrolGrp))],QS_system_AI_owners];
_patrolGrp setVariable ['QS_AI_GRP_DATA',[TRUE,serverTime],QS_system_AI_owners];
_patrolGrp setVariable ['QS_AI_GRP',TRUE,QS_system_AI_owners];
_truckPos = [_spawnPos,10,25,5,0,0.5,0] call (missionNamespace getVariable 'QS_fnc_findSafePos');
private _truckType = '';
if ((_truckPos distance2D _spawnPos) < 30) then {
	_truckPos set [2,0];
	_truckTypes = ['mortarsite_trucktypes_1'] call QS_data_listVehicles;
	_truckType = selectRandom _truckTypes;
	_truck = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _truckType,_truckType],[-500,-500,50],[],25,'NONE'];
	_truck setDir (random 360);
	_truck setVectorUp (surfaceNormal _truckPos);
	_truck setVehiclePosition [(AGLToASL _truckPos),[],0,'NONE'];
	_truck lock 2;
	_truck setVariable ['QS_dynSim_ignore',TRUE,FALSE];
	_truck enableDynamicSimulation FALSE;
	_truck spawn {
		uiSleep 5;
		_this addEventHandler [
			'HandleDamage',
			{
				(_this # 0) removeEventHandler [_thisEvent,_thisEventHandler];
				(_this # 0) enableSimulationGlobal TRUE;
				(_this # 0) setVariable ['QS_dynSim_ignore',FALSE,FALSE];
				(_this # 0) enableDynamicSimulation TRUE;
			}
		];
		_this enableSimulationGlobal FALSE;
	};
	_composition pushBack _truck;
};
_uncertainPos = [
	((_spawnPos # 0) + 100 - (random 200)),
	((_spawnPos # 1) + 100 - (random 200)),
	0
];
['GRID_UPDATE',[localize 'STR_QS_Notif_008',localize 'STR_QS_Notif_010']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
{
	_x setMarkerPosLocal _uncertainPos;
	_x setMarkerAlpha 0.75;
} forEach [
	'QS_marker_grid_mtrMkr',
	'QS_marker_grid_mtrCircle'
];
missionNamespace setVariable ['QS_grid_IGstaticComposition',_composition,FALSE];