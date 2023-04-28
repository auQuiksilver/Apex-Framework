/*
File: fn_aoForestCamp.sqf
Author: 

	Quiksilver

Last Modified:

	22/08/2022 A3 2.10 by Quiksilver

Description:

	AO Forest Camp
_________________________________________________*/

params ['_centerpos'];
diag_log '****************************************************';
diag_log '***** AO COMPOSITION ***** Spawning jungle camp ****';
diag_log '****************************************************';
_hqPos = missionNamespace getVariable ['QS_HQpos',[0,0,0]];
_baseMarker = markerPos 'QS_marker_base_marker';
private _position = _hqPos;
for '_x' from 0 to 99 step 1 do {
	_position = ['RADIUS',_centerpos,((missionNamespace getVariable 'QS_aoSize') * 1),'LAND',[1,0,-1,-1,0,FALSE,objNull],FALSE,[_centerpos,300,'(1 + forest) * (1 - houses)',15,3],[],FALSE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
	if (
		((_position distance2D _baseMarker) > 500) &&
		{((_position distance2D _hqPos) > 150)} &&
		{(([_position,20] call (missionNamespace getVariable 'QS_fnc_areaGradient')) < 10)} &&
		{(!(surfaceIsWater _position))} &&
		{((((_position select [0,2]) nearRoads 50) select {((_x isEqualType objNull) && ((roadsConnectedTo _x) isNotEqualTo []))}) isEqualTo [])} &&
		{(((missionNamespace getVariable 'QS_registeredPositions') inAreaArray [_position,50,50,0,FALSE]) isEqualTo [])}
	) exitWith {};
};
if (surfaceIsWater _position) exitWith {
	missionNamespace setVariable ['QS_enemyJungleCamp_array',[],FALSE];
	[]
};
private _return = [_position,(random 360),([] call (missionNamespace getVariable 'QS_data_forestCamp'))] call (missionNamespace getVariable 'QS_fnc_serverObjectsMapper');
missionNamespace setVariable ['QS_registeredPositions',((missionNamespace getVariable 'QS_registeredPositions') + [_position]),FALSE];
{
	if (((getPosATL _x) # 2) > 0.05) then {
		_x setPosATL [((getPosATL _x) # 0),((getPosATL _x) # 1),0];
	};
} count _return;
private _sentryTypes = ['forest_camp_1'] call QS_data_listUnits;
if (worldName isEqualTo 'Tanoa') then {
	_sentryTypes = ['forest_camp_2'] call QS_data_listUnits;
};
if (worldName isEqualTo 'Enoch') then {
	_sentryTypes = ['forest_camp_3'] call QS_data_listUnits;
};
private _patrolGroup = [_position,(random 360),RESISTANCE,selectRandomWeighted _sentryTypes,FALSE] call (missionNamespace getVariable 'QS_fnc_spawnGroup');
[(units _patrolGroup),2] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
{
	[_x] call (missionNamespace getVariable 'QS_fnc_setCollectible');
	0 = _return pushBack _x;
	if ((random 1) > 0.5) then {
		_x setUnitPos 'Middle';
		_x enableAIFeature ['PATH',FALSE];
		_x enableAIFeature ['COVER',FALSE];
	};
} count (units _patrolGroup);
_patrolGroup setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
for '_x' from 0 to 1 step 1 do {
	_patrolGroup = [_position,(random 360),RESISTANCE,selectRandomWeighted _sentryTypes,FALSE] call (missionNamespace getVariable 'QS_fnc_spawnGroup');
	[(units _patrolGroup),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
	_patrolGroup enableAttack FALSE;
	_patrolGroup setVariable ['QS_AI_GRP_TASK',['GUARD',_position,serverTime,-1],QS_system_AI_owners];
	_patrolGroup setVariable ['QS_AI_GRP_PATROLINDEX',0,QS_system_AI_owners];
	_patrolGroup setVariable ['QS_AI_GRP',TRUE,QS_system_AI_owners];
	_patrolGroup setVariable ['QS_AI_GRP_CONFIG',['GENERAL','INFANTRY',(count (units _patrolGroup))],QS_system_AI_owners];
	_patrolGroup setVariable ['QS_AI_GRP_DATA',[TRUE,serverTime,20,'CAMP'],QS_system_AI_owners];
	_patrolGroup setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
	{
		[_x] call (missionNamespace getVariable 'QS_fnc_setCollectible');
		_return pushBack _x;
	} forEach (units _patrolGroup);
};
missionNamespace setVariable ['QS_enemyJungleCamp_array',_return,FALSE];
_return;