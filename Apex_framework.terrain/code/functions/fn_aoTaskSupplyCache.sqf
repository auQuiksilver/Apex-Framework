/*/
File: fn_aoTaskSupplyCache.sqf
Author:

	Quiksilver

Last Modified:

	18/03/2026 A3 2.14 by Quiksilver

Description:

	Destroy Enemy Supply Cache task

Flow:

	Find a position within the AO
	Spawn a destructible supply cache (ammo crate)
	Spawn a guard squad around the cache
	Notify players and assign task
	Wait for players to destroy the cache

States:

	0 - Cleanup
	1 - Create
	2 - Check (active)

Returns:

	-1  : Still active (state 2 polling)
	[]  : Cleanup complete (state 0)
	[case,state,data] : State transition

____________________________________________________________________________/*/

params ['_case','_state','_data'];
private _return = -1;

if (_state isEqualTo 0) then {
	//comment 'Clean up mission';
	private _cache = _data # 0;
	private _guardGroup = _data # 1;
	if (!isNull _cache) then {
		QS_garbageCollector pushBack [_cache,'NOW_DISCREET',0];
	};
	if (!isNull _guardGroup) then {
		{
			if (alive _x) then {
				QS_garbageCollector pushBack [_x,'NOW_DISCREET',0];
			};
		} count (units _guardGroup);
	};
	missionNamespace setVariable ['QS_supplyCache_obj',objNull,FALSE];
	_return = [];
};

if (_state isEqualTo 1) then {
	//comment 'Create mission';
	private _aoPos = markerPos 'QS_marker_aoMarker';
	private _worldSize = worldSize;
	if (_aoPos inPolygon [
		[0,0,0],
		[_worldSize,0,0],
		[_worldSize,_worldSize,0],
		[0,_worldSize,0]
	]) then {
		private _aoSize = missionNamespace getVariable ['QS_aoSize',500];
		private _baseMarker = markerPos 'QS_marker_base_marker';
		private _hqPos = missionNamespace getVariable ['QS_HQpos',[0,0,0]];
		private _position = [0,0,0];
		for '_i' from 0 to 29 step 1 do {
			_position = ['RADIUS',_aoPos,(_aoSize * 0.75),'LAND',[],FALSE,[],[],TRUE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
			if (
				((_position distance2D _baseMarker) > 500) &&
				{((_position distance2D _hqPos) > 150)} &&
				{(((missionNamespace getVariable 'QS_registeredPositions') inAreaArray [_position,40,40,0,FALSE]) isEqualTo [])} &&
				{(!(surfaceIsWater _position))} &&
				{(!([_position,30,8] call (missionNamespace getVariable 'QS_fnc_waterInRadius')))}
			) exitWith {};
		};
		missionNamespace setVariable ['QS_registeredPositions',((missionNamespace getVariable 'QS_registeredPositions') + [_position]),FALSE];
		private _cacheType = selectRandom ['Box_East_AmmoOrd_F','Box_East_Ammo_F','Box_East_Grenades_F'];
		private _cache = createVehicle [_cacheType,_position,[],0,'NONE'];
		_cache setDir (random 360);
		_cache allowDamage TRUE;
		_cache addEventHandler [
			'Killed',
			{
				params ['_killed','_killer','_instigator'];
				if (!isNull _instigator) then {
					if (isPlayer _instigator) then {
						['sideChat',[WEST,'HQ'],(format [localize 'STR_QS_Chat_184',(name _instigator)])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
					};
				};
			}
		];
		missionNamespace setVariable ['QS_supplyCache_obj',_cache,FALSE];
		//comment 'Spawn guard squad';
		private _guardTypes = ['ao_hvt_guards_1'] call QS_data_listUnits;
		private _guardCount = round (2 + (random 3));
		private _guardGroup = createGroup [EAST,TRUE];
		private _guardUnit = objNull;
		private _guardType = '';
		for '_i' from 0 to _guardCount step 1 do {
			_guardType = selectRandom _guardTypes;
			_guardUnit = _guardGroup createUnit [QS_core_units_map getOrDefault [toLowerANSI _guardType,_guardType],_position,[],12,'NONE'];
			_guardUnit = _guardUnit call (missionNamespace getVariable 'QS_fnc_unitSetup');
			_guardUnit setUnitPos (selectRandom ['Up','Middle']);
		};
		_guardGroup setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
		[units _guardGroup,1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
		//comment 'Notify players and assign task';
		['ST_SUPPLY_CACHE',[localize 'STR_QS_Notif_160',localize 'STR_QS_Notif_161']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
		[
			'QS_IA_TASK_AO_3',
			TRUE,
			[
				localize 'STR_QS_Task_118',
				localize 'STR_QS_Task_119',
				localize 'STR_QS_Task_119'
			],
			[_cache,TRUE],
			'CREATED',
			5,
			FALSE,
			TRUE,
			'Destroy',
			TRUE
		] call (missionNamespace getVariable 'BIS_fnc_setTask');
		_return = [
			_case,
			2,
			[_cache,_guardGroup]
		];
	};
};

if (_state isEqualTo 2) then {
	//comment 'Check mission state';
	private _cache = _data # 0;
	if ((!alive _cache) || {(isNull _cache)}) exitWith {
		//comment 'Mission success';
		['ST_SUPPLY_CACHE',[localize 'STR_QS_Notif_160',localize 'STR_QS_Notif_162']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
		['QS_IA_TASK_AO_3'] call (missionNamespace getVariable 'BIS_fnc_deleteTask');
		if (missionNamespace getVariable ['QS_virtualSectors_active',FALSE]) then {
			private ['_QS_virtualSectors_scoreSides','_scoreEast','_scoreToRemove'];
			_QS_virtualSectors_scoreSides = missionNamespace getVariable ['QS_virtualSectors_scoreSides',[0,0,0,0,0]];
			_scoreEast = _QS_virtualSectors_scoreSides # 0;
			if (_scoreEast > ((missionNamespace getVariable ['QS_virtualSectors_scoreWin',300]) * 0.1)) then {
				_scoreToRemove = (missionNamespace getVariable ['QS_virtualSectors_scoreWin',300]) * (missionNamespace getVariable ['QS_virtualSectors_bonusCoef_smallTask',0.05]);
				_QS_virtualSectors_scoreSides set [0,((_QS_virtualSectors_scoreSides # 0) - _scoreToRemove)];
				missionNamespace setVariable ['QS_virtualSectors_scoreSides',_QS_virtualSectors_scoreSides,FALSE];
			};
		};
		_return = [_case,0,[_data # 0,_data # 1]];
	};
};

_return;
