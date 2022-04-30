/*
File: fn_hcCore.sqf
Author:

	Quiksilver
	
Last modified:

	7/10/2018 A3 1.84 by Quiksilver
	
Description:

	Headless Client Core Script
__________________________________________________*/

if (hasInterface) exitWith {};
disableRemoteSensors FALSE;
enableEnvironment [FALSE,FALSE];
setViewDistance 1200;
setObjectViewDistance 1200;
setTerrainGrid 50;
setShadowDistance 0;
private _timeNow = time;
private _serverTime = serverTime;
private _tickTimeNow = diag_tickTime;
private _loopSleep = 3;
private _QS_worldName = worldName;
private _QS_worldSize = worldSize;
_baseMarker = markerPos 'QS_marker_base_marker';
/*/Dynamic Simulation/*/
private _QS_module_dynSim = TRUE;
private _QS_module_dynSim_delay = 30;
private _QS_module_dynSim_checkDelay = _timeNow + _QS_module_dynSim_delay;
{
	(_x select 0) setDynamicSimulationDistance (_x select 1);
} forEach [
	['GROUP',([1250,1000] select (_QS_worldName isEqualTo 'Tanoa'))],
	['VEHICLE',([1000,750] select (_QS_worldName isEqualTo 'Tanoa'))],
	['EMPTYVEHICLE',([250,125] select (_QS_worldName isEqualTo 'Tanoa'))],
	['PROP',([100,50] select (_QS_worldName isEqualTo 'Tanoa'))]
];
'ISMOVING' setDynamicSimulationDistanceCoef 1.5;
enableDynamicSimulationSystem _QS_module_dynSim;
/*/Clean Groups/*/
private _cleanGroups = TRUE;
private _cleanGroups_delay = 60;
private _cleanGroups_checkDelay = _timeNow + _cleanGroups_delay;
private _fpsCheckDelay = 0;
private _fps = 50;

for '_x' from 0 to 1 step 0 do {
	_timeNow = time;
	_tickTimeNow = diag_tickTime;
	/*/Report/*/
	if (_tickTimeNow > _fpsCheckDelay) then {
		_fps = round diag_fps;
		diag_log format ['Headless Client FPS: %1 * Time: %2 * Active Scripts: %3 * Active SQF Scripts: %4 *',_fps,(round _tickTimeNow),diag_activeScripts,diag_activeSQFScripts];
		_fpsCheckDelay = _tickTimeNow + 15;
	};
	/*/Groups cleaner/*/
	if (_cleanGroups) then {
		if (_tickTimeNow > _cleanGroups_checkDelay) then {
			{
				if (local _x) then {
					if (((units _x) findIf {(alive _x)}) isEqualTo -1) then {
						deleteGroup _x;
					};
				};
			} count allGroups;
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
													if (!((typeOf _x) isEqualTo 'test_EmptyObjectForFireBig')) then {
														if (!(_x getVariable ['QS_dynSim_ignore',FALSE])) then {
															_x enableDynamicSimulation TRUE;
														};
													};
												} else {
													if (dynamicSimulationEnabled _x) then {
														_x enableDynamicSimulation FALSE;
													};
												};
											};
										};
									};
								} else {
									if ((isPlayer _x) || {(unitIsUAV _x)}) then {
										if (!(canTriggerDynamicSimulation _x)) then {
											_x triggerDynamicSimulation TRUE;
										};
										if (dynamicSimulationEnabled _x) then {
											_x enableDynamicSimulation FALSE;
										};
									};
								};
							};
						} else {
							if (_x isEqualType grpNull) then {
								if (local _x) then {
									if (!(dynamicSimulationEnabled _x)) then {
										if (!((vehicle (leader _x)) isKindOf 'Air')) then {
											if (!(_x getVariable ['QS_dynSim_ignore',FALSE])) then {
												_x enableDynamicSimulation TRUE;
											};
										};
									};
									if (!(isGroupDeletedWhenEmpty _x)) then {
										_x deleteGroupWhenEmpty TRUE;
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
		if (!(missionNamespace getVariable ['QS_server_dynSim',FALSE])) then {
			_QS_module_dynSim = FALSE;
			if (dynamicSimulationSystemEnabled) then {
				{
					if (dynamicSimulationEnabled _x) then {
						_x enableDynamicSimulation FALSE;
					};
				} forEach (allUnits + allUnitsUav + vehicles + allGroups);
				enableDynamicSimulationSystem FALSE;
			};
		};
	} else {
		if (missionNamespace getVariable ['QS_server_dynSim',FALSE]) then {
			_QS_module_dynSim = TRUE;
			if (!(dynamicSimulationSystemEnabled)) then {
				enableDynamicSimulationSystem TRUE;
			};
		};
	};
	uiSleep _loopSleep;
};