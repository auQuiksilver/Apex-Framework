/*/
File: fn_clientSimulationManager.sqf
Author:

	Quiksilver
	
Last Modified:

	16/10/2022 A3 2.10 by Quiksilver
	
Description:

	Client Simulation Manager
________________________________________________/*/

scriptName 'QS Simulation Manager';
waitUntil {
	((serverTime > 180) || (!(missionNamespace getVariable ['QS_options_dynSim',FALSE])))		// Let server setup complete first
};
if (
	(!(missionNamespace getVariable ['QS_options_dynSim',FALSE])) ||
	((['uavhacker','QS_trait_fighterPilot','QS_trait_pilot','QS_trait_CAS','QS_trait_HQ'] findIf { player getUnitTrait _x }) isNotEqualTo -1)
) exitWith {
	missionNamespace setVariable ['QS_client_dynSim',FALSE,FALSE];
};
_true = TRUE;
_false = FALSE;
{
	missionNamespace setVariable _x;
} forEach [
	['QS_client_dynSim',(missionProfileNamespace getVariable ['QS_client_dynSim',_false]),_false],
	['QS_client_dynSim_dist_unit',(missionProfileNamespace getVariable ['QS_client_dynSim_dist_unit',1000]),_false],
	['QS_client_dynSim_dist_vehicle',(missionProfileNamespace getVariable ['QS_client_dynSim_dist_vehicle',1500]),_false],
	['QS_client_dynSim_dist_vehicleEmpty',(missionProfileNamespace getVariable ['QS_client_dynSim_dist_vehicleEmpty',500]),_false],
	['QS_client_dynSim_dist_prop',(missionProfileNamespace getVariable ['QS_client_dynSim_dist_prop',300]),_false],
	['QS_client_dynSim_coef_terrainIntersect',(missionProfileNamespace getVariable ['QS_client_dynSim_coef_terrainIntersect',0.75]),_false],
	['QS_client_dynSim_hideEntity',_true,_false],
	['QS_client_dynSim_hideEntity_dist',[1500,1000] select (worldName in ['Tanoa','Stratis']),_false]
];
private _tickTime = diag_tickTime;
private _positionCamera = getPosWorld player;
private _objectParent = objectParent player;
private _cameraOn = cameraOn;
private _runMoveDist = 25;
private _cameraOffset = [0,10,0];
private _entityPos = [0,0,0];
private _entityTerrainOffset = [0,0,10];
private _entity = objNull;
private _entitiesParams = [['LandVehicle','Ship','StaticWeapon','Reammobox_F'],[],_true,_false];
private _entities = entities _entitiesParams;
private _disable_distance = 1000;
private _disable_distance_unit = (missionNamespace getVariable ['QS_client_dynSim_dist_unit',1250]) max 1000;
private _disable_distance_vehicle = (missionNamespace getVariable ['QS_client_dynSim_dist_vehicle',1250]) max 1000;
private _disable_distance_vehicleEmpty = (missionNamespace getVariable ['QS_client_dynSim_dist_vehicleEmpty',500]) max 250;
private _disable_distance_prop = (missionNamespace getVariable ['QS_client_dynSim_dist_prop',300]) max 100;
private _disable_coef_terrainIntersect = (missionNamespace getVariable ['QS_client_dynSim_coef_terrainIntersect',0.75]) max 0.5;
private _disable_hideEntity = missionNamespace getVariable ['QS_client_dynSim_hideEntity',_false];
private _distance_hideEntity = (missionNamespace getVariable ['QS_client_dynSim_hideEntity_dist',1000]) max 750;
private _entitySleep = 0.001;
private _entityEHs = [];
private _runDelay = 15;
private _runCheckDelay = _tickTime + _runDelay;
private _maxAltASL = 300;
private _isActive = _false;
_eventKilled = {
	params ['_entity','','',''];
	if (
		(!simulationEnabled _entity) ||
		(isObjectHidden _entity)
	) then {
		_entity setVariable ['QS_sim_entityManaged',FALSE,FALSE];
		_entity enableSimulation TRUE;
		if (missionNamespace getVariable ['QS_client_dynSim_hideEntity',FALSE]) then {
			if (isObjectHidden _entity) then {
				_entity hideObject FALSE;
			};
		};
		if ((_entity getVariable ['QS_sim_EHs',[]]) isNotEqualTo []) then {
			{
				_entity removeEventHandler _x;
			} forEach (_entity getVariable ['QS_sim_EHs',[]]);
			_entity setVariable ['QS_sim_EHs',[],FALSE];
		};
	};
};
_eventLocal = {
	params ['_entity','_local'];
	if (_local) then {
		if (
			(!simulationEnabled _entity) ||
			(isObjectHidden _entity)
		) then {
			_entity setVariable ['QS_sim_entityManaged',FALSE,FALSE];
			_entity enableSimulation TRUE;
			if (missionNamespace getVariable ['QS_client_dynSim_hideEntity',FALSE]) then {
				if (isObjectHidden _entity) then {
					_entity hideObject FALSE;
				};
			};
			if ((_entity getVariable ['QS_sim_EHs',[]]) isNotEqualTo []) then {
				{
					_entity removeEventHandler _x;
				} forEach (_entity getVariable ['QS_sim_EHs',[]]);
				_entity setVariable ['QS_sim_EHs',[],FALSE];
			};
		};
	};
};
_eventExplosion = {
	params ['_entity',''];
	if (
		(!simulationEnabled _entity) ||
		(isObjectHidden _entity)
	) then {
		_entity setVariable ['QS_sim_entityManaged',FALSE,FALSE];
		_entity enableSimulation TRUE;
		if (missionNamespace getVariable ['QS_client_dynSim_hideEntity',FALSE]) then {
			if (isObjectHidden _entity) then {
				_entity hideObject FALSE;
			};
		};
		if ((_entity getVariable ['QS_sim_EHs',[]]) isNotEqualTo []) then {
			{
				_entity removeEventHandler _x;
			} forEach (_entity getVariable ['QS_sim_EHs',[]]);
			_entity setVariable ['QS_sim_EHs',[],FALSE];
		};
	};
};
_eventGetIn = {
	params ['_entity','','_unit',''];
	if (
		(!simulationEnabled _entity) ||
		(isObjectHidden _entity)
	) then {
		_entity setVariable ['QS_sim_entityManaged',FALSE,FALSE];
		_entity enableSimulation TRUE;
		if (missionNamespace getVariable ['QS_client_dynSim_hideEntity',FALSE]) then {
			if (isObjectHidden _entity) then {
				_entity hideObject FALSE;
			};
		};
		if ((_entity getVariable ['QS_sim_EHs',[]]) isNotEqualTo []) then {
			{
				_entity removeEventHandler _x;
			} forEach (_entity getVariable ['QS_sim_EHs',[]]);
			_entity setVariable ['QS_sim_EHs',[],FALSE];
		};
	};
};
_eventDammaged = {
	params ['_entity','','','','','',''];
	if (
		(!simulationEnabled _entity) ||
		(isObjectHidden _entity)
	) then {
		_entity setVariable ['QS_sim_entityManaged',FALSE,FALSE];
		_entity enableSimulation TRUE;
		if (missionNamespace getVariable ['QS_client_dynSim_hideEntity',FALSE]) then {
			if (isObjectHidden _entity) then {
				_entity hideObject FALSE;
			};
		};
		if ((_entity getVariable ['QS_sim_EHs',[]]) isNotEqualTo []) then {
			{
				_entity removeEventHandler _x;
			} forEach (_entity getVariable ['QS_sim_EHs',[]]);
			_entity setVariable ['QS_sim_EHs',[],FALSE];
		};
	};
};
for '_i' from 0 to 1 step 0 do {
	_tickTime = diag_tickTime;
	_objectParent = objectParent player;
	_cameraOn = cameraOn;
	if (_isActive) then {
		if (
			(_objectParent isKindOf 'Air') ||
			{(_cameraOn isKindOf 'Air')} ||
			{(((getPosASL _cameraOn) # 2) > _maxAltASL)} || 
			{(!(isNull curatorCamera))}
		) then {
			_isActive = _false;
			_entities = (entities _entitiesParams) + ('WeaponHolderSimulated' allObjects 1);
			{
				_entity = _x;
				if (
					(_entity getVariable ['QS_sim_entityManaged',_false]) &&
					{((!(simulationEnabled _entity)) || {(isObjectHidden _entity)})}
				) then {
					if ((_entity getVariable ['QS_sim_EHs',[]]) isNotEqualTo []) then {
						{
							_entity removeEventHandler _x;
						} forEach (_entity getVariable ['QS_sim_EHs',[]]);
						_entity setVariable ['QS_sim_EHs',[],_false];
					};
					_entity setVariable ['QS_sim_entityManaged',_false,_false];
					_entity enableSimulation _true;
					if (
						_disable_hideEntity &&
						(isObjectHidden _entity)
					) then {
						_entity hideObject _false;
					};
				};
				uiSleep 0.01;
			} forEach _entities;
		} else {
			if (
				(_tickTime > _runCheckDelay) || 
				{(((positionCameraToWorld _cameraOffset) distance2D _positionCamera) > _runMoveDist)} || 
				{(uiNamespace getVariable ['QS_client_playerViewChanged',_false])}
			) then {
				if (uiNamespace getVariable ['QS_client_playerViewChanged',_false]) then {
					uiNamespace setVariable ['QS_client_playerViewChanged',_false];
				};
				_positionCamera = positionCameraToWorld _cameraOffset;
				_entities = (entities _entitiesParams) + ('WeaponHolderSimulated' allObjects 1);
				{
					_entity = _x;
					if (!isNull _entity) then {
						if (local _entity) then {
							if (!(simulationEnabled _entity)) then {
								_entity setVariable ['QS_sim_entityManaged',_false,_false];
								_entity enableSimulation _true;
							};
							if (
								_disable_hideEntity &&
								(isObjectHidden _entity)
							) then {
								_entity hideObject _false;
							};
						} else {
							if ((['LandVehicle','StaticWeapon','Reammobox_F','Ship'] findIf { _entity isKindOf _x }) isNotEqualTo -1) then {
								_entityPos = _entity getVariable ['QS_sim_pos',[-5000,-5000,0]];
								if (_entityPos isEqualTo [-5000,-5000,0]) then {
									_entityPos = getPosATL _entity;
								};
							} else {
								_entityPos = getPosATL _entity;
							};
							if (
								(_entity isKindOf 'GroundWeaponHolder') ||
								{((_entity isKindOf 'Reammobox_F') && ((sizeOf (typeOf _entity)) < 5))}
							) then {
								_disable_distance = _disable_distance_prop;
							} else {
								_disable_distance = [_disable_distance_vehicle,_disable_distance_vehicleEmpty] select (((crew _entity) findIf {(alive _x)}) isEqualTo -1);
								if (terrainIntersect [_positionCamera,(_entityPos vectorAdd _entityTerrainOffset)]) then {
									_disable_distance = _disable_distance * _disable_coef_terrainIntersect;
								};
							};
							if (
								((_positionCamera distance2D _entityPos) > _disable_distance) && 
								{
									(
										(isNull (isVehicleCargo _entity)) && 
										{(isNull (ropeAttachedTo _entity))} && 
										{(isNull (attachedTo _entity))}
									)
								}
							) then {
								if (
									(simulationEnabled _entity) &&
									{(!(_entity getVariable ['QS_dynSim_ignore',_false]))}
								) then {
									if ((_entity getVariable ['QS_sim_EHs',[]]) isEqualTo []) then {
										_entityEHs = [];
										{
											_entityEHs pushBack [(_x # 0),(_entity addEventHandler _x)];
										} forEach [
											['Killed',_eventKilled],
											['Local',_eventLocal],
											['Explosion',_eventExplosion],
											['GetIn',_eventGetIn],
											['Dammaged',_eventDammaged]
										];
										_entity setVariable ['QS_sim_EHs',_entityEHs,_false];
									};
									_entity setVariable ['QS_sim_entityManaged',_true,_false];
									_entity enableSimulation _false;
									if (
										(_disable_hideEntity) &&
										{((_positionCamera distance2D _entityPos) > _distance_hideEntity)} &&
										{(!(isObjectHidden _entity))}
									) then {
										_entity hideObject _true;
									};
								};
							} else {
								if (
									(_entity getVariable ['QS_sim_entityManaged',_false]) &&
									{((!(simulationEnabled _entity)) || {(isObjectHidden _entity)})}
								) then {
									if ((_entity getVariable ['QS_sim_EHs',[]]) isNotEqualTo []) then {
										{
											_entity removeEventHandler _x;
										} forEach (_entity getVariable ['QS_sim_EHs',[]]);
										_entity setVariable ['QS_sim_EHs',[],_false];
									};
									_entity setVariable ['QS_sim_entityManaged',_false,_false];
									_entity enableSimulation _true;
									if (
										_disable_hideEntity &&
										(isObjectHidden _entity)
									) then {
										_entity hideObject _false;
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
		if (
			(!(_objectParent isKindOf 'Air')) && 
			{(!(_cameraOn isKindOf 'Air'))} &&
			{(((getPosASL _cameraOn) # 2) <= _maxAltASL)} &&
			{(isNull curatorCamera)}
		) then {
			_isActive = _true;
		};
	};
	if ((['uavhacker','QS_trait_fighterPilot','QS_trait_pilot','QS_trait_CAS','QS_trait_HQ'] findIf { player getUnitTrait _x }) isNotEqualTo -1) then {
		_entities = (entities _entitiesParams) + ('WeaponHolderSimulated' allObjects 1);
		{
			_entity = _x;
			if (
				(_entity getVariable ['QS_sim_entityManaged',_false]) &&
				{((!(simulationEnabled _entity)) || {(isObjectHidden _entity)})}
			) then {
				if ((_entity getVariable ['QS_sim_EHs',[]]) isNotEqualTo []) then {
					{
						_entity removeEventHandler _x;
					} forEach (_entity getVariable ['QS_sim_EHs',[]]);
					_entity setVariable ['QS_sim_EHs',[],_false];
				};
				_entity setVariable ['QS_sim_entityManaged',_false,_false];
				_entity enableSimulation _true;
				if (_disable_hideEntity) then {
					if (isObjectHidden _entity) then {
						_entity hideObject _false;
					};
				};
			};
		} forEach _entities;
		(missionNamespace getVariable 'QS_managed_hints') pushBack [5,TRUE,5,-1,localize 'STR_QS_Hints_100',[],-1,TRUE,localize 'STR_QS_Hints_102',FALSE];
		waitUntil {
			uiSleep 5;
			((['uavhacker','QS_trait_fighterPilot','QS_trait_pilot','QS_trait_CAS','QS_trait_HQ'] findIf { player getUnitTrait _x }) isEqualTo -1)
		};
		(missionNamespace getVariable 'QS_managed_hints') pushBack [5,TRUE,5,-1,localize 'STR_QS_Hints_101',[],-1,TRUE,localize 'STR_QS_Hints_102',FALSE];
	};
	if (!(missionNamespace getVariable ['QS_options_dynSim',_false])) exitWith {
		_entities = (entities _entitiesParams) + ('WeaponHolderSimulated' allObjects 1);
		{
			_entity = _x;
			if (
				(_entity getVariable ['QS_sim_entityManaged',_false]) &&
				{((!(simulationEnabled _entity)) || {(isObjectHidden _entity)})}
			) then {
				if ((_entity getVariable ['QS_sim_EHs',[]]) isNotEqualTo []) then {
					{
						_entity removeEventHandler _x;
					} forEach (_entity getVariable ['QS_sim_EHs',[]]);
					_entity setVariable ['QS_sim_EHs',[],_false];
				};
				_entity setVariable ['QS_sim_entityManaged',_false,_false];
				_entity enableSimulation _true;
				if (_disable_hideEntity) then {
					if (isObjectHidden _entity) then {
						_entity hideObject _false;
					};
				};
			};
		} forEach _entities;
	};
	uiSleep 3;
};