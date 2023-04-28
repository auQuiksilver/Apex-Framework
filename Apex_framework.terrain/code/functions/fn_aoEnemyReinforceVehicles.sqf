/*/
File: fn_aoEnemyReinforceVehicles.sqf
Author:

	Quiksilver
	
Last modified:

	25/03/2018 A3 1.82 by Quiksilver
	
Description:

	Enemy reinforce AO
__________________________________________________/*/

params ['_pos'];
_worldName = worldName;
_worldSize = worldSize;
_allPlayers = allPlayers;
private _QS_array = [];
private _minDist = 1200;
private _maxDist = 3000;
private _fn_blacklist = {TRUE};
private _nearRoads = [];
_baseMarker = markerPos 'QS_marker_base_marker';
if (_worldName isEqualTo 'Tanoa') then {
	_minDist = 1200;
	_maxDist = 2400;
	_fn_blacklist = {
		private _c = TRUE;
		{
			if ((_this distance2D (_x # 0)) < (_x # 1)) exitWith {
				_c = FALSE;
			};
		} count [
			[[13415.7,5194.57,0.00172806],350],
			[[12897.9,5442.16,0.00107098],175],
			[[2257.59,1664.31,0.00162601],90],
			[[3681.47,9377.08,0.00176811],400],
			[[11440.4,14422,0.0013628],275]
		];
		_c;
	};
};

/*/================================================ FIND POSITION/*/
private _roadsValid = [];
_validRoadSurfaces = ['#gdtreddirt','#gdtasphalt','#gdtsoil','#gdtconcrete'];
private _base = markerPos 'QS_marker_base_marker';
private _foundSpawnPos = FALSE;
private _spawnPosDefault = missionNamespace getVariable 'QS_aoPos';
private _roadRoadValid = [0,0,0];
for '_x' from 0 to 499 step 1 do {
	_roadRoadValid = [0,0,0];
	_spawnPosDefault = [_pos,_minDist,_maxDist,5,0,0.5,0] call (missionNamespace getVariable 'QS_fnc_findSafePos');
	if (
		((_allPlayers inAreaArray [_spawnPosDefault,250,250,0,FALSE]) isEqualTo []) &&
		{(_spawnPosDefault call _fn_blacklist)} &&
		((_spawnPosDefault distance2D _baseMarker) > 500) &&
		{(!([_spawnPosDefault,_pos,25] call (missionNamespace getVariable 'QS_fnc_waterIntersect')))}
	) then {
		_nearRoads = ((_spawnPosDefault select [0,2]) nearRoads 250) select {((_x isEqualType objNull) && ((roadsConnectedTo _x) isNotEqualTo []))};
		if (_nearRoads isNotEqualTo []) then {
			{
				if ((toLowerANSI (surfaceType (getPosATL _x))) in _validRoadSurfaces) then {
					_roadsValid pushBack (getPosATL _x);
				};
			} forEach _nearRoads;
			if (_roadsValid isNotEqualTo []) then {
				_roadRoadValid = selectRandom _roadsValid;
			};
		};
	};
	if (_roadRoadValid isNotEqualTo [0,0,0]) exitWith {};
};
if (_roadRoadValid isEqualTo [0,0,0]) then {
	_roadRoadValid = _spawnPosDefault;
};

/*/================================================ SELECT + SPAWN UNITS/*/

private _reinforceGroup = createGroup [EAST,TRUE];
private _motorPool = 0;
if (worldName isEqualTo 'Stratis') then {
	_motorPool = 8;
};
_vType = selectRandomWeighted ([_motorPool] call (missionNamespace getVariable 'QS_fnc_getAIMotorPool'));
_v = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _vType,_vType],_roadRoadValid,[],0,'NONE'];
_v setVariable ['QS_dynSim_ignore',TRUE,FALSE];
_v allowCrewInImmobile [TRUE,TRUE];
_v setUnloadInCombat [TRUE,FALSE];
_v enableRopeAttach FALSE;
_v enableVehicleCargo FALSE;
//_v forceFollowRoad TRUE;
_v setConvoySeparation 50;
_v limitSpeed (50 + (random [10,20,30]));
[0,_v,EAST,1] call (missionNamespace getVariable 'QS_fnc_vSetup2');
clearMagazineCargoGlobal _v;
clearWeaponCargoGlobal _v;
clearItemCargoGlobal _v;
clearBackpackCargoGlobal _v;
_v lock 2;
private _vCrewGroup = createVehicleCrew _v;
if (!((side _vCrewGroup) in [EAST,RESISTANCE])) then {
	_vCrewGroup = createGroup [EAST,TRUE];
	(crew _v) joinSilent _vCrewGroup;
};
(missionNamespace getVariable 'QS_AI_vehicles') pushBack _v;
_vCrewGroup setVariable ['QS_dynSim_ignore',TRUE,TRUE];
_vCrewGroup addVehicle _v;
_v addEventHandler ['Killed',(missionNamespace getVariable 'QS_fnc_vKilled2')];
_v addEventHandler ['GetOut',(missionNamespace getVariable 'QS_fnc_AIXDismountDisabled')];
_QS_array pushBack _v;
{
	_x setVariable ['QS_dynSim_ignore',TRUE,TRUE];
	_x call (missionNamespace getVariable 'QS_fnc_unitSetup');
	_x setVariable ['BIS_noCoreConversations',TRUE,FALSE];
	_QS_array pushBack _x;
} forEach (crew _v);
[(units _vCrewGroup),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
(gunner _v) setSkill ['aimingAccuracy',0.08];
(gunner _v) doWatch (missionNamespace getVariable 'QS_HQpos');
if ((random 1) > 0.5) then {
	if (
		(alive (commander _v)) &&
		(alive (gunner _v))
	) then {
		_v deleteVehicleCrew (commander _v);		// commander guns are quite strong, reduce their frequency
	};
};
if (alive (commander _v)) then {
	(commander _v) doWatch (missionNamespace getVariable 'QS_HQpos');
};
(driver _v) doMove ((missionNamespace getVariable 'QS_HQpos') getPos [50 + (random 50),random 360]);
_vCrewGroup setVariable ['QS_AI_GRP_CONFIG',['GENERAL','VEHICLE',(count (units _vCrewGroup)),_v],QS_system_AI_owners];
_vCrewGroup setVariable ['QS_AI_GRP_DATA',[TRUE,serverTime],QS_system_AI_owners];
_vCrewGroup setVariable [
	'QS_AI_GRP_TASK',
	[
		'PATROL',
		[
			((missionNamespace getVariable 'QS_HQpos') getPos [(50 + (random 50)),(random 360)]),
			((missionNamespace getVariable 'QS_HQpos') getPos [(50 + (random 50)),(random 360)]),
			((missionNamespace getVariable 'QS_HQpos') getPos [(50 + (random 50)),(random 360)])
		],
		serverTime,
		-1
	],
	FALSE
];
_vCrewGroup setVariable ['QS_AI_GRP_PATROLINDEX',0,FALSE];
_vCrewGroup setVariable ['QS_AI_GRP',TRUE,QS_system_AI_owners];
{
	_x enableStamina FALSE;
	_x enableFatigue FALSE;
	//_x enableAIFeature ['AUTOCOMBAT',FALSE];
	_x enableAIFeature ['COVER',FALSE];
} forEach (units _vCrewGroup);
_vCrewGroup enableAttack TRUE;
_insertHeliTypes = (['classic_reinforcevslinger_2'] call QS_data_listVehicles) call QS_fnc_arrayShuffle;
private _insertHeliType = ['classic_reinforcevslinger_1'] call QS_data_listVehicles;
_slingableTypes = ['classic_reinforcevslingable_1'] call QS_data_listVehicles;

if ((random 1) > 0.5) then {
	private _insertIndex = _insertHeliTypes findIf { _x canSlingLoad _vType };
	if (_insertIndex isNotEqualTo -1) then {
		_insertHeliType = _insertHeliTypes # _insertIndex;
	};
};
if (
	((toLowerANSI _vType) in _slingableTypes) &&
	{(diag_fps > 15)} &&
	{(_allPlayers isNotEqualTo [])} &&
	{((random 1) > 0.5)} &&
	{(missionNamespace getVariable ['QS_AI_insertHeli_enabled',FALSE])} &&
	{(({(alive _x)} count (missionNamespace getVariable ['QS_AI_insertHeli_helis',[]])) < (missionNamespace getVariable ['QS_AI_insertHeli_maxHelis',3]))} &&
	{(diag_tickTime > ((missionNamespace getVariable ['QS_AI_insertHeli_lastEvent',-1]) + (missionNamespace getVariable ['QS_AI_insertHeli_cooldown',600])))} &&
	{((missionNamespace getVariable ['QS_AI_insertHeli_spawnedAO',0]) < (missionNamespace getVariable ['QS_AI_insertHeli_maxAO',3]))} &&
	{(([4,EAST,(missionNamespace getVariable 'QS_aoPos'),1500] call (missionNamespace getVariable 'QS_fnc_AIGetKnownEnemies')) <= 1)} &&
	{(([3,EAST,(missionNamespace getVariable 'QS_aoPos'),2000] call (missionNamespace getVariable 'QS_fnc_AIGetKnownEnemies')) <= 1)}
) then {
	missionNamespace setVariable ['QS_AI_insertHeli_spawnedAO',((missionNamespace getVariable 'QS_AI_insertHeli_spawnedAO') + 1),FALSE];
	missionNamespace setVariable ['QS_AI_insertHeli_lastEvent',diag_tickTime,FALSE];
	_v enableRopeAttach TRUE;
	_v enableVehicleCargo TRUE;
	[
		_pos,
		_v,
		_insertHeliType,
		EAST
	] spawn (missionNamespace getVariable 'QS_fnc_AIXHeliInsertVehicle');
};
_QS_array;