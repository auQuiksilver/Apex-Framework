/*
File: fn_hcCore.sqf
Author:

	Quiksilver
	
Last modified:

	17/11/2022 A3 2.10 by Quiksilver
	
Description:

	Headless Client Core Script
	
Notes:

	0 - Server - Group is available for HC (setvariable 0)
	1 - HC - HC requests Group transfer (setvariable 1)
	2 - Server - Server accepts request, sends relevant data/states (setvariable 2)
	3 - HC - HC receives states, indicates transfer readiness (setvariable 3)
	4 - Server - Transfer group (setvariable 4)
__________________________________________________*/

if (hasInterface) exitWith {};
_true = TRUE;
_false = FALSE;
disableRemoteSensors _false;
enableEnvironment [_false,_false,0];
setViewDistance 2000;
setObjectViewDistance 2000;
setTerrainGrid 50;
setShadowDistance 0;
private _timeNow = time;
private _serverTime = serverTime;
private _tickTimeNow = diag_tickTime;
private _loopSleep = 3;
private _QS_worldName = worldName;
private _QS_worldSize = worldSize;
private _smallTerrains = ['Tanoa','Stratis'];
_baseMarker = markerPos 'QS_marker_base_marker';
/*/Dynamic Simulation/*/
private _QS_module_dynSim = _true;
private _QS_module_dynSim_delay = 30;
private _QS_module_dynSim_checkDelay = _timeNow + _QS_module_dynSim_delay;
{
	(_x # 0) setDynamicSimulationDistance (_x # 1);
} forEach [
	['GROUP',([1250,1000] select (_QS_worldName in _smallTerrains))],
	['VEHICLE',([1000,750] select (_QS_worldName in _smallTerrains))],
	['EMPTYVEHICLE',([250,125] select (_QS_worldName in _smallTerrains))],
	['PROP',([100,50] select (_QS_worldName in _smallTerrains))]
];
'ISMOVING' setDynamicSimulationDistanceCoef 1.5;
enableDynamicSimulationSystem _QS_module_dynSim;
/*/Clean Groups/*/
private _cleanGroups = _true;
private _cleanGroups_delay = 60;
private _cleanGroups_checkDelay = _timeNow + _cleanGroups_delay;
private _fpsCheckDelay = 0;
private _fps = 50;
private _updateGroups = _true;
private _updateGroups_delay = 5;
private _updateGroups_checkDelay = _tickTimeNow + _updateGroups_delay;
private _HC_localUnitsCount = 0;
private _localUnits = [];
private _remoteGroup = grpNull;
private _remoteGroups = [];
private _exit = _false;
private _clientOwner = clientOwner;
private _managed_flares = [];
QS_garbageCollector = [];
QS_managed_flares = [];
for '_x' from 0 to 1 step 0 do {
	_timeNow = time;
	_tickTimeNow = diag_tickTime;
	/*/Report/*/
	if (_tickTimeNow > _fpsCheckDelay) then {
		_fps = round diag_fps;
		diag_log format ['Headless Client FPS: %1 * Frame-Time: %2 * Active Scripts: %3 * Active SQF Scripts: %4 *',_fps,diag_deltaTime,diag_activeScripts,diag_activeSQFScripts];
		if ((missionNamespace getVariable ['QS_mission_aoType','CLASSIC']) in ['CLASSIC','SC','GRID']) then {
				if (canTriggerDynamicSimulation player) then {
					player triggerDynamicSimulation _false;
				};
				if ((player distance2D (missionNamespace getVariable ['QS_aoPos',[0,0,0]])) > 10) then {
					player setPosATL (missionNamespace getVariable ['QS_aoPos',[0,0,0]]);
				};
		};
		_fpsCheckDelay = _tickTimeNow + 15;
	};
	/*/Groups cleaner/*/
	if (QS_garbageCollector isNotEqualTo []) then {
		QS_garbageCollector = [];
	};
	_managed_flares = (missionNamespace getVariable ['QS_managed_flares',[]]) select {!isNull (_x # 0)};
	if (_managed_flares isNotEqualTo []) then {
		{
			if (_QS_uiTime > (_x # 1)) then {
				deleteVehicle (_x # 0);
			};
		} forEach _managed_flares;
	};
	if (_cleanGroups) then {
		if (_tickTimeNow > _cleanGroups_checkDelay) then {
			/*/
			{
				if (local _x) then {
					if (((units _x) findIf {(alive _x)}) isEqualTo -1) then {
						deleteGroup _x;
					};
				};
			} forEach allGroups;
			/*/
			_cleanGroups_checkDelay = _tickTimeNow + _cleanGroups_delay;
		};
	};
	/*/===== Module Dynamic Simulation/*/

	if (_QS_module_dynSim) then {
		if (_timeNow > _QS_module_dynSim_checkDelay) then {
			if (dynamicSimulationSystemEnabled) then {
				{
					if (!isNull _x) then {
						if (_x isEqualType objNull) then {
							if (alive _x) then {
								if (local _x) then {
									if (!(unitIsUAV _x)) then {
										if (!(dynamicSimulationEnabled _x)) then {
											if (((_x distance2D [0,0,0]) > 1000) && ((_x distance2D _baseMarker) > 750)) then {
												if ((!((vehicle _x) isKindOf 'Air')) && (!(_x isKindOf 'Air'))) then {
													if ((typeOf _x) isNotEqualTo 'test_EmptyObjectForFireBig') then {
														if (!(_x getVariable ['QS_dynSim_ignore',_false])) then {
															_x enableDynamicSimulation _true;
														};
													};
												} else {
													if (dynamicSimulationEnabled _x) then {
														_x enableDynamicSimulation _false;
													};
												};
											};
										};
									};
								} else {
									if ((isPlayer _x) || {(unitIsUAV _x)}) then {
										if (!(_x isKindOf 'HeadlessClient_F')) then {
											if (!(canTriggerDynamicSimulation _x)) then {
												_x triggerDynamicSimulation _true;
											};
											if (dynamicSimulationEnabled _x) then {
												_x enableDynamicSimulation _false;
											};
										} else {
											if (canTriggerDynamicSimulation _x) then {
												_x triggerDynamicSimulation _false;
											};
										};
									};
								};
							};
						} else {
							if (_x isEqualType grpNull) then {
								if (local _x) then {
									if (!(dynamicSimulationEnabled _x)) then {
										if (!((vehicle (leader _x)) isKindOf 'Air')) then {
											if (!(_x getVariable ['QS_dynSim_ignore',_false])) then {
												_x enableDynamicSimulation _true;
											};
										};
									};
									if (!(isGroupDeletedWhenEmpty _x)) then {
										_x deleteGroupWhenEmpty _true;
									};
								};
							};
						};
					};
					sleep 0.003;
				} forEach (allUnits + allUnitsUav + vehicles + allGroups);
			};
			_QS_module_dynSim_checkDelay = _timeNow + _QS_module_dynSim_delay;
		};
		if (!(missionNamespace getVariable ['QS_server_dynSim',_false])) then {
			_QS_module_dynSim = _false;
			if (dynamicSimulationSystemEnabled) then {
				{
					if (dynamicSimulationEnabled _x) then {
						_x enableDynamicSimulation _false;
					};
				} forEach (allUnits + allUnitsUav + vehicles + allGroups);
				enableDynamicSimulationSystem _false;
			};
		};
	} else {
		if (missionNamespace getVariable ['QS_server_dynSim',_false]) then {
			_QS_module_dynSim = _true;
			if (!(dynamicSimulationSystemEnabled)) then {
				enableDynamicSimulationSystem _true;
			};
		};
	};
	uiSleep _loopSleep;
};