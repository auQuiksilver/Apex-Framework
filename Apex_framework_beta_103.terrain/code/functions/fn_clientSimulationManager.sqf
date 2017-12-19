/*/
File: fn_clientSimulationManager.sqf
Author:

	Quiksilver
	
Last Modified:

	6/12/2017 A3 1.78 by Quiksilver
	
Description:

	Client Simulation Manager
________________________________________________/*/

if (
	(player getUnitTrait 'uavhacker') ||
	{(player getUnitTrait 'QS_trait_pilot')} ||
	{(player getUnitTrait 'QS_trait_CAS')} ||
	{(['pilot',(typeOf player),FALSE] call (missionNamespace getVariable 'QS_fnc_inString'))}
) exitWith {
	missionNamespace setVariable ['QS_client_dynSim',FALSE,FALSE];
};
scriptName 'QS Simulation Manager';
{
	missionNamespace setVariable _x;
} forEach [
	['QS_client_dynSim',(profileNamespace getVariable ['QS_client_dynSim',FALSE]),FALSE],
	['QS_client_dynSim_dist_unit',(profileNamespace getVariable ['QS_client_dynSim_dist_unit',1000]),FALSE],
	['QS_client_dynSim_dist_vehicle',(profileNamespace getVariable ['QS_client_dynSim_dist_vehicle',1000]),FALSE],
	['QS_client_dynSim_dist_vehicleEmpty',(profileNamespace getVariable ['QS_client_dynSim_dist_vehicleEmpty',250]),FALSE],
	['QS_client_dynSim_dist_prop',(profileNamespace getVariable ['QS_client_dynSim_dist_prop',150]),FALSE],
	['QS_client_dynSim_coef_moving',(profileNamespace getVariable ['QS_client_dynSim_coef_moving',1.25]),FALSE],
	['QS_client_dynSim_coef_terrainIntersect',(profileNamespace getVariable ['QS_client_dynSim_coef_terrainIntersect',0.75]),FALSE],
	['QS_client_dynSim_hideEntity',TRUE,FALSE],
	['QS_client_dynSim_hideEntity_dist',1000,FALSE]
];
private _threadSleep = 2;
private _tickTime = diag_tickTime;
private _positionCamera = getPosWorld player;
private _objectParent = objectParent player;
private _runMoveDist = 25;
private _cameraView = cameraView;
private _entity = objNull;
private _entitiesParams = [[],[],TRUE,FALSE];
private _entities = entities _entitiesParams;
private _entitiesRemove = [];
private _entitiesAdd = [];
private _disable_distance = 1000;
private _disable_distance_unit = (missionNamespace getVariable ['QS_client_dynSim_dist_unit',1250]) max 1000;
private _disable_distance_vehicle = (missionNamespace getVariable ['QS_client_dynSim_dist_vehicle',1250]) max 1000;
private _disable_distance_vehicleEmpty = (missionNamespace getVariable ['QS_client_dynSim_dist_vehicleEmpty',250]) max 200;
private _disable_distance_prop = (missionNamespace getVariable ['QS_client_dynSim_dist_prop',150]) max 100;
private _disable_coef_moving = (missionNamespace getVariable ['QS_client_dynSim_coef_moving',1.25]) max 1;
private _disable_coef_terrainIntersect = (missionNamespace getVariable ['QS_client_dynSim_coef_terrainIntersect',0.75]) max 0.5;
private _disable_hideEntity = missionNamespace getVariable ['QS_client_dynSim_hideEntity',FALSE];
private _distance_hideEntity = (missionNamespace getVariable ['QS_client_dynSim_hideEntity_dist',1000]) max 750;
private _entitySleep = 0.001;
private _velocityThreshold = 0.1;
private _isMoving = FALSE;
private _hideEntity = FALSE;
private _isSimpleObject = isSimpleObject player;
private _coolDownDelay = 10;
private _entityEHs = [];
private _distanceToEntity = 1000;
private _updateEntitiesDelay = 5;
private _updateEntitesCheckDelay = _tickTime + _updateEntitiesDelay;
private _runDelay = 30;
private _runCheckDelay = _tickTime + _runDelay;
_eventKilled = {
	params ['_entity','_killer','_instigator','_useEffects'];
	if (!simulationEnabled _entity) then {
		_entity enableSimulation TRUE;
		if (missionNamespace getVariable ['QS_client_dynSim_hideEntity',FALSE]) then {
			if (isObjectHidden _entity) then {
				_entity hideObject FALSE;
			};
		};
		if (!isNil {_entity getVariable 'QS_sim_EHs'}) then {
			{
				_entity removeEventHandler _x;
			} forEach (_entity getVariable ['QS_sim_EHs',[]]);
			_entity setVariable ['QS_sim_EHs',nil,FALSE];
		};
		_entity setVariable ['QS_sim_entityCoolDown',(diag_tickTime + 10),FALSE];
	};
};
_eventLocal = {
	params ['_entity','_local'];
	if (_local) then {
		if (!simulationEnabled _entity) then {
			_entity enableSimulation TRUE;
			if (missionNamespace getVariable ['QS_client_dynSim_hideEntity',FALSE]) then {
				if (isObjectHidden _entity) then {
					_entity hideObject FALSE;
				};
			};
			if (!isNil {_entity getVariable 'QS_sim_EHs'}) then {
				{
					_entity removeEventHandler _x;
				} forEach (_entity getVariable ['QS_sim_EHs',[]]);
				_entity setVariable ['QS_sim_EHs',nil,FALSE];
			};
			_entity setVariable ['QS_sim_entityCoolDown',(diag_tickTime + 10),FALSE];
		};
	};
};
_eventExplosion = {
	params ['_entity','_damage'];
	if (local _entity) then {
		if (!simulationEnabled _entity) then {
			_entity enableSimulation TRUE;
			if (missionNamespace getVariable ['QS_client_dynSim_hideEntity',FALSE]) then {
				if (isObjectHidden _entity) then {
					_entity hideObject FALSE;
				};
			};
			if (!isNil {_entity getVariable 'QS_sim_EHs'}) then {
				{
					_entity removeEventHandler _x;
				} forEach (_entity getVariable ['QS_sim_EHs',[]]);
				_entity setVariable ['QS_sim_EHs',nil,FALSE];
			};
			_entity setVariable ['QS_sim_entityCoolDown',(diag_tickTime + 10),FALSE];
		};
	};
};
_eventGetIn = {
	params ['_entity','_position','_unit','_turret'];
	if (isPlayer _unit) then {
		if (!simulationEnabled _entity) then {
			_entity enableSimulation TRUE;
			if (missionNamespace getVariable ['QS_client_dynSim_hideEntity',FALSE]) then {
				if (isObjectHidden _entity) then {
					_entity hideObject FALSE;
				};
			};
			if (!isNil {_entity getVariable 'QS_sim_EHs'}) then {
				{
					_entity removeEventHandler _x;
				} forEach (_entity getVariable ['QS_sim_EHs',[]]);
				_entity setVariable ['QS_sim_EHs',nil,FALSE];
			};
			_entity setVariable ['QS_sim_entityCoolDown',(diag_tickTime + 10),FALSE];
		};
	};
};
private _maxAltASL = 300;
private _isActive = FALSE;
private _posPlayerATL = getPosATL player;
private _isTerrainIntersect = FALSE;
private _entity_distance = -1;
for '_x' from 0 to 1 step 0 do {
	_tickTime = diag_tickTime;
	_objectParent = objectParent player;
	if (_isActive) then {
		if ((_objectParent isKindOf 'Air') || {(((getPosASL player) select 2) > _maxAltASL)} || {(!(isNull curatorCamera))}) then {
			_isActive = FALSE;
			_entities = (entities _entitiesParams) + (allMissionObjects 'WeaponHolder');
			{
				_entity = _x;
				if (!isNil {_entity getVariable 'QS_sim_entityCoolDown'}) then {
					if ((!(simulationEnabled _entity)) || {(isObjectHidden _entity)}) then {
						if (!isNil {_entity getVariable 'QS_sim_EHs'}) then {
							{
								_entity removeEventHandler _x;
							} forEach (_entity getVariable ['QS_sim_EHs',[]]);
							_entity setVariable ['QS_sim_EHs',nil,FALSE];
						};
						_entity setVariable ['QS_sim_entityCoolDown',(_tickTime + _coolDownDelay),FALSE];
						_entity enableSimulation TRUE;
						if (_disable_hideEntity) then {
							if (isObjectHidden _entity) then {
								_entity hideObject FALSE;
							};
						};
					};
				};
			} forEach _entities;
		} else {
			if ((_tickTime > _runCheckDelay) || {(((positionCameraToWorld [0,0,0]) distance2D _positionCamera) > _runMoveDist)} || {(player getVariable ['QS_client_playerViewChanged',FALSE])}) then {
				if (player getVariable ['QS_client_playerViewChanged',FALSE]) then {
					player setVariable ['QS_client_playerViewChanged',FALSE,FALSE];
				};
				_positionCamera = positionCameraToWorld [0,0,0];
				_entities = (entities _entitiesParams) + (allMissionObjects 'WeaponHolder');
				_posPlayerATL = _positionCamera;
				_posPlayerATL set [2,((_posPlayerATL select 2) + 10)];
				{
					_entity = _x;
					if (!isPlayer _x) then {
						if (local _entity) then {
							if (!(simulationEnabled _entity)) then {
								_entity enableSimulation TRUE;
								if (_disable_hideEntity) then {
									if (isObjectHidden _entity) then {
										_entity hideObject FALSE;
									};
								};
							};
						} else {
							if (((_entity isKindOf 'AllVehicles') && (!(_entity isKindOf 'Air'))) || {(_entity isKindOf 'CAManBase')} || {(_entity isKindOf 'Thing')} || {(_entity isKindOf 'WeaponHolder')} || {(_entity isKindOf 'Reammobox_F')}) then {
								if (isNil {_entity getVariable 'QS_sim_entityCoolDown'}) then {
									if (isNil {_entity getVariable 'QS_dynSim_ignore'}) then {
										_entity setVariable ['QS_sim_entityCoolDown',-1,FALSE];
									};
								};
								_isMoving = (vectorMagnitude (velocity _entity)) > _velocityThreshold;
								if ((_isMoving) || ((!(_isMoving)) && ((!isNil {_entity getVariable 'QS_sim_entityCoolDown'}) && (_tickTime > (_entity getVariable ['QS_sim_entityCoolDown',(_tickTime + 1)]))))) then {
									if ((_entity isKindOf 'WeaponHolder') || {(_entity isKindOf 'Reammobox_F')}) then {
										if (_isMoving) then {
											_disable_distance = _disable_distance_prop * _disable_coef_moving;
										} else {
											_disable_distance = _disable_distance_prop;
										};
									} else {
										_isTerrainIntersect = terrainIntersect [_posPlayerATL,(_entity modelToWorld [0,10,0])];
										if (_entity isKindOf 'CAManBase') then {
											if (_isMoving) then {
												_disable_distance = _disable_distance_unit * _disable_coef_moving;
											} else {
												_disable_distance = _disable_distance_unit;
											};
											if (_isTerrainIntersect) then {
												_disable_distance = _disable_distance * _disable_coef_terrainIntersect;
											};
										} else {
											if (_entity isKindOf 'AllVehicles') then {
												_disable_distance = [_disable_distance_vehicle,_disable_distance_vehicleEmpty] select (({(alive _x)} count (crew _entity)) isEqualTo 0);
												if (_isMoving) then {
													_disable_distance = _disable_distance * _disable_coef_moving;
												};
												if (_isTerrainIntersect) then {
													_disable_distance = _disable_distance * _disable_coef_terrainIntersect;
												};
											};
										};
									};
									_entity_distance = _positionCamera distance2D _entity;
									if (_entity_distance > _disable_distance) then {
										if (simulationEnabled _entity) then {
											if (isNil {_entity getVariable 'QS_sim_EHs'}) then {
												_entityEHs = [];
												{
													_entityEHs pushBack [(_x select 0),(_entity addEventHandler _x)];
												} forEach [
													['Killed',_eventKilled],
													['Local',_eventLocal],
													['Explosion',_eventExplosion],
													['GetIn',_eventGetIn]
												];
												_entity setVariable ['QS_sim_EHs',_entityEHs,FALSE];
											};
											_entity setVariable ['QS_sim_entityCoolDown',(_tickTime + _coolDownDelay),FALSE];
											if (isNull (ropeAttachedTo _entity)) then {
												_entity enableSimulation FALSE;
												if (_disable_hideEntity) then {
													if (_entity_distance > _distance_hideEntity) then {
														if (!(isObjectHidden _entity)) then {
															_entity hideObject TRUE;
														};
													};
												};
											};
										};
									} else {
										if ((!(simulationEnabled _entity)) || {(isObjectHidden _entity)})then {
											if (!isNil {_entity getVariable 'QS_sim_EHs'}) then {
												{
													_entity removeEventHandler _x;
												} forEach (_entity getVariable ['QS_sim_EHs',[]]);
												_entity setVariable ['QS_sim_EHs',nil,FALSE];
											};
											_entity setVariable ['QS_sim_entityCoolDown',(_tickTime + _coolDownDelay),FALSE];
											_entity enableSimulation TRUE;
											if (_disable_hideEntity) then {
												if (isObjectHidden _entity) then {
													_entity hideObject FALSE;
												};
											};
										};
									};
								};
							};
						};
					};
					uiSleep _entitySleep;
				} forEach _entities;
				_runCheckDelay = _tickTime + _runDelay;
			};
		};
	} else {
		if ((!(_objectParent isKindOf 'Air')) && (((getPosASL player) select 2) <= _maxAltASL) && (isNull curatorCamera)) then {
			_isActive = TRUE;
		};
	};
	if (!(missionNamespace getVariable ['QS_options_dynSim',FALSE])) exitWith {
		_entities = (entities _entitiesParams) + (allMissionObjects 'WeaponHolder');
		{
			_entity = _x;
			if (!isNil {_entity getVariable 'QS_sim_entityCoolDown'}) then {
				if ((!(simulationEnabled _entity)) || {(isObjectHidden _entity)}) then {
					if (!isNil {_entity getVariable 'QS_sim_EHs'}) then {
						{
							_entity removeEventHandler _x;
						} forEach (_entity getVariable ['QS_sim_EHs',[]]);
						_entity setVariable ['QS_sim_EHs',nil,FALSE];
					};
					_entity setVariable ['QS_sim_entityCoolDown',nil,FALSE];
					_entity enableSimulation TRUE;
					if (_disable_hideEntity) then {
						if (isObjectHidden _entity) then {
							_entity hideObject FALSE;
						};
					};
				};
			};
		} forEach _entities;
	};
	uiSleep _threadSleep;
};