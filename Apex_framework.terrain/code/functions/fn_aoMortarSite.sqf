/*/
File: fn_aoMortarSite.sqf
Author: 

	Quiksilver

Last Modified:

	29/11/2017 A3 1.78 by Quiksilver

Description:

	AO Mortar Site
____________________________________________________________________________/*/

_aoPos = missionNamespace getVariable 'QS_aoPos';
_aoSize = missionNamespace getVariable 'QS_aoSize';
private _multiplier = 0.75;
private _spawnPos = [0,0,0];
private _allPlayers = allPlayers;
private _positionFound = FALSE;
for '_x' from 0 to 19 step 1 do {
	_spawnPos = ['RADIUS',_aoPos,(_aoSize * _multiplier),'LAND',[8,0,0.1,5,0,FALSE,objNull],FALSE,[],[],FALSE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
	if (((missionNamespace getVariable 'QS_registeredPositions') findIf {((_spawnPos distance2D _x) < 100)}) isEqualTo -1) then {
		if ((((_spawnPos select [0,2]) nearRoads 15) select {((_x isEqualType objNull) && (!((roadsConnectedTo _x) isEqualTo [])))}) isEqualTo []) then {
			if (!((toLower(surfaceType _spawnPos)) in ['#gdtasphalt'])) then {
				if (!([_spawnPos,20,8] call (missionNamespace getVariable 'QS_fnc_waterInRadius'))) then {
					if ((_allPlayers findIf {((_x distance2D _spawnPos) < 300)}) isEqualTo -1) then {
						if (([_spawnPos,6] call (missionNamespace getVariable 'QS_fnc_areaGradient')) < 5) then {
							_positionFound = TRUE;
						};
					};
				};
			};
		};
	};
	if (_positionFound) exitWith {};
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
				_text = format ['%1 ( %2 ) killed a Mk.6 Mortar gunner',(name _instigator),(groupId (group _instigator))];
				_text remoteExec ['systemChat',-2,FALSE];
			};
		};
	}
];
_gunner addEventHandler [
	'GetOutMan',
	{
		(_this select 0) setDamage [1,TRUE];
		(_this select 2) setDamage [1,TRUE];
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
		['GRID_UPDATE',['Area Of Operations','Enemy mortar destroyed']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
	}
];
_gunner call (missionNamespace getVariable 'QS_fnc_unitSetup');
_gunner addEventHandler [
	'FiredMan',
	{
		if (isNil {missionNamespace getVariable 'QS_enemy_mortarFireMessage'}) then {
			missionNamespace setVariable ['QS_enemy_mortarFireMessage',diag_tickTime,FALSE];
		};
		(vehicle (_this select 0)) setVehicleAmmo 1;
		if ((missionNamespace getVariable 'QS_enemy_mortarFireMessage') > (diag_tickTime - 300)) exitWith {};
		missionNamespace setVariable ['QS_enemy_mortarFireMessage',diag_tickTime,FALSE];
		['sideChat',[WEST,'HQ'],'Enemy mortars are firing!'] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
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
(missionNamespace getVariable 'QS_AI_supportProviders_MTR') pushBack _gunner;
_mortar lock 3;
_mortar enableWeaponDisassembly FALSE;
_mortar setVariable ['QS_hidden',TRUE,TRUE];
_gunner setVariable ['QS_hidden',TRUE,TRUE];
[_gunner] joinSilent _gunnerGrp;
_gunnerGrp addVehicle _mortar;
_gunnerGrp setVariable ['QS_AI_GRP_CONFIG',['SUPPORT','MORTAR',_mortar],FALSE];
_gunnerGrp setVariable ['QS_AI_GRP_DATA',[TRUE,diag_tickTime],FALSE];
_gunnerGrp setVariable ['QS_AI_GRP_TASK',['SUPPORT','MORTAR',diag_tickTime,-1],FALSE];
_gunnerGrp setVariable ['QS_AI_GRP',TRUE,FALSE];
_composition pushBack _gunner;
_patrolGrp = [_spawnPos,(random 360),EAST,(selectRandom ['OG_ReconSentry','OG_SniperTeam_M']),FALSE] call (missionNamespace getVariable 'QS_fnc_spawnGroup');
[(units _patrolGrp),2] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
{
	_x call (missionNamespace getVariable 'QS_fnc_unitSetup');
	_x setVehiclePosition [(getPosWorld _x),[],10,'NONE'];
	_composition pushBack _x;
} forEach (units _patrolGrp);
_patrolGrp setVariable ['QS_AI_GRP_TASK',['DEFEND',_spawnPos,diag_tickTime,-1],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
_patrolGrp setVariable ['QS_AI_GRP_PATROLINDEX',0,(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
_patrolGrp setVariable ['QS_AI_GRP_CONFIG',['GENERAL','INFANTRY',(count (units _patrolGrp))],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
_patrolGrp setVariable ['QS_AI_GRP_DATA',[TRUE,diag_tickTime],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
_patrolGrp setVariable ['QS_AI_GRP',TRUE,(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
_truckPos = [_spawnPos,10,25,5,0,0.5,0] call (missionNamespace getVariable 'QS_fnc_findSafePos');
if ((_truckPos distance2D _spawnPos) < 30) then {
	_truckPos set [2,0];
	_truckTypes = [
		'O_G_Offroad_01_F',
		'O_G_Van_01_transport_F',
		'I_C_Van_01_transport_F',
		'C_Truck_02_transport_F'
	];
	_truck = createVehicle [(selectRandom _truckTypes),[-500,-500,50],[],25,'NONE'];
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
				(_this select 0) removeEventHandler ['HandleDamage',_thisEventHandler];
				(_this select 0) enableSimulationGlobal TRUE;
				(_this select 0) setVariable ['QS_dynSim_ignore',FALSE,FALSE];
				(_this select 0) enableDynamicSimulation TRUE;
			}
		];
		_this enableSimulationGlobal FALSE;
	};
	_composition pushBack _truck;
};
_uncertainPos = [
	((_spawnPos select 0) + 100 - (random 200)),
	((_spawnPos select 1) + 100 - (random 200)),
	0
];
['GRID_UPDATE',['Area Of Operations','Enemy mortar online']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
{
	_x setMarkerPosLocal _uncertainPos;
	_x setMarkerAlpha 0.75;
} forEach [
	'QS_marker_grid_mtrMkr',
	'QS_marker_grid_mtrCircle'
];
missionNamespace setVariable ['QS_grid_IGstaticComposition',_composition,FALSE];