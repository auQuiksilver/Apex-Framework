/*
File: fn_secureIntelUAV.sqf
Author:

	Quiksilver
	
Last Modified:

	11/02/2016 A3 1.54 by Quiksilver
	
Description:

	Secure Intel from a crashed UAV
	
To do:
	
	Check for "swimInDepth" issues when transferring to Headless Client
___________________________________________________________*/

scriptName 'Side Mission - Secure Intel UAV';
if (worldName in ['Enoch']) exitWith {};
private [
	'_inset','_max','_safePos','_testPos','_uav','_dummyObj','_index','_timeEnd','_uavOnGround','_diverTypes','_diverType','_unit','_enemiesArray',
	'_fuzzyPos','_briefing','_enemiesCheckDelay','_foundPos','_checkPos','_QS_fnc_radPos','_signalPulseCheckDelay','_val','_safePosATL','_endTimeBroadcastDelay',
	'_text','_uavTypes','_arrayToSend'
];
_diverTypes = ['O_diver_F','O_diver_exp_F','O_diver_TL_F','I_diver_F','I_diver_exp_F','I_diver_TL_F'];
_inset = 2000;
_max = worldSize - (_inset * 2);
_safePos = [];
_index = 0;

_QS_fnc_radPos = {
	private['_pos','_exit','_posX','_posY'];
	params ['_center','_radius','_angle','_isWater'];
	_center = _this # 0;
	_radius = _this # 1;
	_angle = _this # 2;
	_isWater = _this # 3;
	_exit = FALSE;
	for '_x' from 0 to 1 step 0 do {
		_posX = (_radius * (sin _angle));
		_posY = (_radius * (cos _angle));
		_pos = [_posX + (_center # 0),_posY + (_center # 1),0];
		if (_isWater) then {
			if (surfaceIsWater [_pos # 0,_pos # 1]) then {_exit = true} else {_radius = _radius - 1};
		} else {
			if (!surfaceIsWater [_pos # 0,_pos # 1]) then {_exit = true} else {_radius = _radius - 1};
		};
		if (_radius isEqualTo 0) then {_pos = _center;_exit = true};
		if (_exit) exitWith {};
	};
	_pos;
};
for '_x' from 0 to 1 step 0 do {
	_testPos = [_inset + (random _max),_inset + (random _max),0];
	if (surfaceIsWater _testPos) then {
		if (((ASLToATL _testPos) # 2) < 75) then {
			if (((ASLToATL _testPos) # 2) > 13) then {
				if (((missionNamespace getVariable 'QS_uavMission_usedPositions') findIf {((_testPos distance2D _x) < 300)}) isEqualTo -1) then {
					if (missionNamespace getVariable 'QS_module_fob_enabled') then {
						if ((_testPos distance (markerPos 'QS_marker_module_fob')) > 1000) then {
							_safePos = _testPos isFlatEmpty [5,0,1,5,2,FALSE,objNull];
						};
					} else {
						_safePos = _testPos isFlatEmpty [5,0,1,5,2,FALSE,objNull];
					};
				};
			};
		};
	};
	if (_safePos isNotEqualTo []) exitWith {};
	sleep 0.1;
};
missionNamespace setVariable [
	'QS_uavMission_usedPositions',
	((missionNamespace getVariable 'QS_uavMission_usedPositions') + [_safePos]),
	FALSE
];
_safePosATL = [(_safePos # 0),(_safePos # 1),(getTerrainHeightASL _safePos)];
_uavTypes = ['O_T_UAV_04_CAS_F','O_UAV_02_F','O_T_UAV_04_CAS_F'];
private _uavType = selectRandom _uavTypes;
_uav = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _uavType,_uavType],[0,0,0],[],0,'NONE'];
_uav setVariable ['QS_uav_protected',TRUE,TRUE];
_uav setVariable ['QS_hidden',TRUE,TRUE];
_uav setDamage 0.75;
_uav allowDamage FALSE;
_uav enableRopeAttach FALSE;
_uav enableVehicleCargo FALSE;
_uav setFuel 0;
_uav setVehicleAmmo 0;
(allUnits # 0) action ['LandGearUp',_uav];
_uav setPosASL _safePos;
for '_x' from 0 to 2 step 1 do {
	_uav setVariable ['QS_secureable',TRUE,TRUE];
};
_uavOnGround = FALSE;
//_timeEnd = time + 1800;
_timeEnd = serverTime + 1800;
_enemiesCheckDelay = time + 30;
_signalPulseCheckDelay = time + 20;
_endTimeBroadcastDelay = time + 30;
_foundPos = FALSE;
_fuzzyPos = [((_safePos # 0) - 300) + (random 600),((_safePos # 1) - 300) + (random 600),0];
'QS_marker_sideMarker' setMarkerTextLocal (format ['%1 %2',(toString [32,32,32]),localize 'STR_QS_Marker_042']);
{
	_x setMarkerPosLocal _fuzzyPos;
	_x setMarkerAlpha 1;
} count ['QS_marker_sideMarker','QS_marker_sideCircle'];	
[
	'QS_IA_TASK_SM_0',
	TRUE,
	[
		(format [
			'%2 %1. %3',
			worldName,
			localize 'STR_QS_Task_107',
			localize 'STR_QS_Task_108'
		]),
		localize 'STR_QS_Task_109',
		localize 'STR_QS_Task_109'
	],
	(markerPos 'QS_marker_sideMarker'),
	'CREATED',
	5,
	FALSE,
	TRUE,
	'download',
	TRUE
] call (missionNamespace getVariable 'BIS_fnc_setTask');
['QS_IA_TASK_SM_0',TRUE,_timeEnd] call (missionNamespace getVariable 'QS_fnc_taskSetTimer');
['NewSideMission',[localize 'STR_QS_Notif_111']] remoteExec ['QS_fnc_showNotification',-2,FALSE];



_enemiesArray = [_safePos] call (missionNamespace getVariable 'QS_fnc_smEnemyDivers');
private _patrolRoute = [];

for '_x' from 0 to 1 step 0 do {
	if (_uav getVariable 'QS_secured') exitWith {
		{
			_x setMarkerPosLocal [-5000,-5000,0];
			_x setMarkerAlpha 0;
		} count ['QS_marker_sideMarker','QS_marker_sideCircle'];
		[1,_safePos] spawn (missionNamespace getVariable 'QS_fnc_smDebrief');
		_uav setDamage 1;
		sleep 300;
		{
			if (_x isEqualType objNull) then {
				0 = (missionNamespace getVariable 'QS_garbageCollector') pushBack [_x,'NOW_DISCREET',0];
			};
		} count _enemiesArray;
		if (!isNull _uav) then {
			deleteVehicle _uav;
		};
	};
	if ((serverTime > _timeEnd) || {(!alive _uav)}) exitWith {
		{
			_x setMarkerPosLocal [-5000,-5000,0];
			_x setMarkerAlpha 0;
		} count ['QS_marker_sideMarker','QS_marker_sideCircle'];
		[0,_safePos] spawn (missionNamespace getVariable 'QS_fnc_smDebrief');
		_uav setDamage [1,FALSE];
		sleep 180;
		{
			if (_x isEqualType objNull) then {
				0 = (missionNamespace getVariable 'QS_garbageCollector') pushBack [_x,'NOW_DISCREET',0];
			};
		} count _enemiesArray;
		if (!isNull _uav) then {
			deleteVehicle _uav;
		};
	};
	if (time > _signalPulseCheckDelay) then {
		_arrayToSend = [];
		{
			if ((_x distance _safePosATL) < 500) then {
				0 = _arrayToSend pushBack (owner _x);
			};
		} count allPlayers;
		if (_arrayToSend isNotEqualTo []) then {
			[0,_safePosATL,300] remoteExec ['QS_fnc_signalStrength',_arrayToSend,FALSE];
		};
		_signalPulseCheckDelay = time + 15;
	};
	if (!(_uavOnGround)) then {
		if (isTouchingGround _uav) then {
			_uavOnGround = TRUE;
			_grp = createGroup [EAST,TRUE];
			for '_x' from 0 to 1 step 1 do {
				_diverType = selectRandom _diverTypes;
				_unit = _grp createUnit [QS_core_units_map getOrDefault [toLowerANSI _diverType,_diverType],(getPosWorld _uav),[],0,'NONE'];
				0 = _enemiesArray pushBack _unit;
				_unit swimInDepth (getTerrainHeightASL _safePos);
				_unit enableStamina FALSE;
				_unit setVariable ['QS_hidden',TRUE,TRUE];
				{
					if ((toLowerANSI _x) in QS_core_classNames_grenades) then {
						_unit removeMagazine _x;
					};
				} forEach (magazines _unit);
			};
			_grp setFormDir (random 360);
			_grp setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
			[(units _grp),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
		};
	};
	if (time > _enemiesCheckDelay) then {
		if (({((_x isKindOf 'CAManBase') && (alive _x))} count _enemiesArray) < 10) then {
			_foundPos = FALSE;
			for '_x' from 0 to 1 step 0 do {
				_checkPos = _safePos getPos [(150 + (random 400)),(random 360)];
				if (surfaceIsWater _checkPos) then {
					if (([_checkPos,150,[WEST,CIVILIAN],allPlayers,0] call (missionNamespace getVariable 'QS_fnc_serverDetector')) isEqualTo []) then {
						_foundPos = TRUE;
					};
				};
				if (_foundPos) exitWith {};
			};
			_grp = createGroup [EAST,TRUE];
			for '_x' from 0 to 1 step 1 do {
				_diverType = selectRandom _diverTypes;
				_unit = _grp createUnit [QS_core_units_map getOrDefault [toLowerANSI _diverType,_diverType],_checkPos,[],0,'FORM'];
				_unit enableStamina FALSE;
				_unit setVariable ['QS_hidden',TRUE,TRUE];
				_enemiesArray pushBack _unit;
				_unit swimInDepth (getTerrainHeightASL _safePos);
				{
					if ((toLowerANSI _x) in QS_core_classNames_grenades) then {
						_unit removeMagazine _x;
					};
				} forEach (magazines _unit);
			};
			[(units _grp),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');	
			for '_x' from 0 to 2 step 1 do {
				_relPos = [_safePos,(100 + (random 200)),(random 360),TRUE] call _QS_fnc_radPos;
				_patrolRoute pushBack [_relPos # 0,_relPos # 1,(getTerrainHeightASL (getPosWorld ((units _grp) # 0)))];
			};
			_patrolRoute pushBack [((getPosWorld _unit) # 0),((getPosWorld _unit) # 1),(getTerrainHeightASL (getPosWorld ((units _grp) # 0)))];
			_grp setVariable ['QS_AI_GRP_TASK',['PATROL',_patrolRoute,serverTime,-1],QS_system_AI_owners];
			_grp setVariable ['QS_AI_GRP_PATROLINDEX',0,QS_system_AI_owners];
			_grp setVariable ['QS_AI_GRP_CONFIG',['GENERAL','DIVER',(count (units _grp))],QS_system_AI_owners];
			_grp setVariable ['QS_AI_GRP_DATA',[],QS_system_AI_owners];
			_grp setVariable ['QS_AI_GRP',TRUE,QS_system_AI_owners];
			_grp setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
		};
		_enemiesCheckDelay = time + 30;
	};
	sleep 3;
};