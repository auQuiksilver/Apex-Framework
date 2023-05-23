/*
File: fn_virtualVehicleCargo.sqf
Author:

	Quiksilver
	
Last Modified:

	26/04/2023 A3 2.12 by Quiksilver
	
Description:

	Handle virtualized vehicle cargo
________________________________________________*/

params ['_type'];
if (_type isEqualTo 'HANDLE') exitWith {
	(uiNamespace getVariable ['QS_virtualCargo_handler',[]]) pushBack (_this # 1);
	if ((uiNamespace getVariable ['QS_virtualCargo_PFH',-1]) isEqualTo -1) then {
		uiNamespace setVariable ['QS_virtualCargo_PFH',(addMissionEventHandler ['EachFrame',{
			if ((uiNamespace getVariable ['QS_virtualCargo_handler',[]]) isEqualTo []) then {
				removeMissionEventHandler [_thisEvent,_thisEventHandler];
				uiNamespace setVariable ['QS_virtualCargo_PFH',-1];
			} else {
				((uiNamespace getVariable ['QS_virtualCargo_handler',[]]) deleteAt 0) call (missionNamespace getVariable 'QS_fnc_virtualVehicleCargo');
			};
			QS_system_virtualCargo = QS_system_virtualCargo select {
				_vcargo = _x # 1;
				(
					(alive (_x # 0)) && 
					((_vcargo findIf { (_x # 1) > 0 }) isNotEqualTo -1)
				)
			};
		}])];
	};
};
if (_type isEqualTo 'SET_CLIENT') exitWith {
	params ['','_parent','_child'];
	if (
		(!alive _parent) ||
		{(!alive _child)} ||
		{(_parent isEqualTo _child)}
	) exitWith {};
	comment 'client request to set vehicle cargo';
	playSound3D [
		'A3\Sounds_F\sfx\ui\vehicles\vehicle_rearm.wss',
		_parent,
		FALSE,
		(getPosASL _parent),
		1,
		1,
		15
	];
	[24,['HANDLE',['SET_SERVER',_parent,_child,clientOwner]]] remoteExec ['QS_fnc_remoteExec',2,FALSE];
};
if (_type isEqualTo 'GET_CLIENT') exitWith {
	comment 'client request to get vehicle cargo';
	params ['','_parent','_childType','_placementPos','_placementAzi'];
	_childType = toLowerANSI _childType;
	playSound3D [
		'A3\Sounds_F\sfx\ui\vehicles\vehicle_rearm.wss',
		_parent,
		FALSE,
		(getPosASL _parent),
		1,
		1,
		15
	];
	if (
		(_parent getVariable ['QS_terrain_leveler',FALSE]) &&
		{(!(QS_player getUnitTrait 'engineer'))}
	) exitWith {
		50 cutText [localize 'STR_QS_Text_456','PLAIN DOWN',0.333];
	};
	[24,['HANDLE',['GET_SERVER',_parent,_childType,clientOwner,_placementPos,_placementAzi]]] remoteExec ['QS_fnc_remoteExec',2,FALSE];
};
if (_type isEqualTo 'SET_VCARGO_SERVER') exitWith {
	params ['','_parent','_virtualCargo'];
	if (!alive _parent) exitWith {};
	private _parentIndex = QS_system_virtualCargo findIf { _parent isEqualTo (_x # 0) };
	if (_parentIndex isEqualTo -1) then {
		QS_system_virtualCargo pushBack [_parent,_virtualCargo];
	} else {
		QS_system_virtualCargo set [_parentIndex,[_parent,_virtualCargo]];
	};
	_parent setVariable ['QS_virtualCargo',_virtualCargo,TRUE];
};
if (_type isEqualTo 'SET_VCARGO_CLIENT') exitWith {
	params ['','_parent','_virtualCargo'];
	[24,[_parent,_virtualCargo]] remoteExec ['QS_fnc_remoteExec',2,FALSE];
};
if (_type isEqualTo 'SET_SERVER') exitWith {
	params ['','_parent','_child','_clientOwner'];
	if (
		(!alive _parent) ||
		{(!alive _child)} ||
		{(_parent isEqualTo _child)} ||
		{(diag_tickTime < (_parent getVariable ['QS_logistics_dupeCooldown',-1]))}
	) exitWith {};
	_parent setVariable ['QS_logistics_dupeCooldown',diag_tickTime + 0.5,FALSE];
	private _parentIndex = QS_system_virtualCargo findIf { _parent isEqualTo (_x # 0) };
	if (_parentIndex isEqualTo -1) then {
		_parentIndex = QS_system_virtualCargo pushBack [_parent,[]];
	};
	_parentData = QS_system_virtualCargo # _parentIndex;
	_parentData params ['','_virtualCargo'];
	comment 'validate new cargo';
	_childType = toLowerANSI (typeOf _child);
	_simpleObject = [0,1] select (isSimpleObject _child);
	_damageAllowed = [0,1] select (isDamageAllowed _child);
	_simulationEnabled = [0,1] select (simulationEnabled _child);
	_boundingRadius = (0 boundingBoxReal _child) # 2;
	_damage = damage _child;
	private _virtualCargoIndex = _virtualCargo findIf { (_childType isEqualTo ((_x # 0) # 0)) };
	if (_virtualCargoIndex isEqualTo -1) then {
		_virtualCargoIndex = _virtualCargo pushBack [[_childType,_simpleObject,_damageAllowed,_simulationEnabled,_boundingRadius,_damage],0];
	};
	_count = (_virtualCargo # _virtualCargoIndex) # 1;
	_virtualCargo set [_virtualCargoIndex,[[_childType,_simpleObject,_damageAllowed,_simulationEnabled,_boundingRadius,_damage],_count + 1]];
	QS_system_virtualCargo set [_parentIndex,[_parent,_virtualCargo]];
	_parent setVariable ['QS_virtualCargo',_virtualCargo,TRUE];
	if (_child in QS_system_builtObjects) then {
		QS_system_builtObjects deleteAt (QS_system_builtObjects find _child);
	};
	deleteVehicle _child;
	QS_system_builtObjects = QS_system_builtObjects select {!isNull _x};
	_parentIndex2 = QS_logistics_deployedAssets findIf { (_x # 0) isEqualTo _parent };
	private _assetIndex = -1;
	if (_parentIndex2 isNotEqualTo -1) then {
		_assets = (QS_logistics_deployedAssets # _parentIndex2) # 1;
		_assetIndex = _assets find _child;
		if (_assetIndex isNotEqualTo -1) then {
			_assets deleteAt _assetIndex;
			QS_logistics_deployedAssets set [_parentIndex2,[_parent,_assets,((QS_logistics_deployedAssets # _parentIndex2) # 2)]];
		};
	};
	deleteVehicle _child;
};
if (_type isEqualTo 'GET_SERVER') exitWith {
	params ['','_parent','_childType','_clientOwner','_placementPos','_placementAzi'];
	_parentIndex = QS_system_virtualCargo findIf { _parent isEqualTo (_x # 0) };
	if (
		(_parentIndex isEqualTo -1) ||
		{(diag_tickTime < (_parent getVariable ['QS_logistics_dupeCooldown',-1]))}
	) exitWith {};
	_parent setVariable ['QS_logistics_dupeCooldown',diag_tickTime + 0.5,FALSE];
	_parentData = QS_system_virtualCargo # _parentIndex;
	_parentData params ['','_virtualCargo'];
	_childType = toLowerANSI _childType;
	private _virtualCargoIndex = _virtualCargo findIf { (_childType isEqualTo ((_x # 0) # 0)) };
	if (_virtualCargoIndex isEqualTo -1) exitWith {};
	_cargoData = _virtualCargo # _virtualCargoIndex;
	(_cargoData # 0) params ['','_isSimpleObject','_damageAllowed','_simulationEnabled','_boundingRadius','_damage'];
	private _count = _cargoData # 1;
	if (_count isEqualTo 0) exitWith {
		_virtualCargo deleteAt _virtualCargoIndex;
		QS_system_virtualCargo set [_parentIndex,[_parent,_virtualCargo]];
		_parent setVariable ['QS_virtualCargo',_virtualCargo,TRUE];
	};
	QS_system_builtObjects = QS_system_builtObjects select {!isNull _x};
	_child = if (_isSimpleObject isEqualTo 1) then {
		(createSimpleObject [_childType,[0,0,0],FALSE])
	} else {
		(createVehicle [_childType,[0,0,0]])
	};
	_simulation = QS_hashmap_configfile getOrDefaultCall [
		format ['cfgvehicles_%1_simulation',toLowerANSI (typeOf _child)],
		{toLowerANSI (getText ((configOf _child) >> 'simulation'))},
		TRUE
	];
	_child enableSimulationGlobal (_simulationEnabled isEqualTo 1);
	_child enableDynamicSimulation (_simulationEnabled isEqualTo 1);
	_child setVectorDirAndUp _placementAzi;
	_child setPosASL _placementPos;
	[_child,_childType] call QS_fnc_propCustomCode;
	playSound3D [
		'A3\Sounds_F\sfx\ui\vehicles\vehicle_rearm.wss',
		_child,
		FALSE,
		(getPosASL _child),
		1,
		1,
		15
	];
	_count = _count - 1;
	if (_count <= 0) then {
		_virtualCargo deleteAt _virtualCargoIndex;
	} else {
		_virtualCargo set [_virtualCargoIndex,[[_childType,_isSimpleObject,_damageAllowed,_simulationEnabled,_boundingRadius,_damage],_count]];
	};
	comment 'only update if it spawned successfully';
	_parent setVariable ['QS_virtualCargo',_virtualCargo,TRUE];
	QS_system_virtualCargo set [_parentIndex,[_parent,_virtualCargo]];
	QS_system_builtObjects pushBack _child;
	QS_system_builtThings pushBack _child;
	missionNamespace setVariable ['QS_system_builtThings',QS_system_builtThings select {!isNull _x},TRUE];
	_parentIndex2 = QS_logistics_deployedAssets findIf { (_x # 0) isEqualTo _parent };
	if (_parentIndex2 isNotEqualTo -1) then {
		_assets = (QS_logistics_deployedAssets # _parentIndex2) # 1;
		_assets pushBackUnique _child;
		QS_logistics_deployedAssets set [_parentIndex2,[_parent,_assets,((QS_logistics_deployedAssets # _parentIndex2) # 2)]];
	} else {
		QS_logistics_deployedAssets pushBack [_parent,[_child],''];
	};
	if (_child isKindOf 'CargoPlatform_01_base_F') then {
		[_child,TRUE,TRUE] call QS_fnc_logisticsPlatformSnap;
	};
	if ((toLowerANSI _simulation) in ['house']) then {
		_child addEventHandler [
			'Deleted',
			{
				params ['_entity'];
				(0 boundingBoxReal _entity) params ['','','_radius'];
				_nearObjects = nearestObjects [_entity,[],_radius * 3,TRUE];
				if (_nearObjects isNotEqualTo []) then {
					[
						_nearObjects,
						{
							{
								if (local _x) then {
									_x awake TRUE;
								};
							} forEach _this;
						}
					] remoteExec ['call',0,FALSE];
				};
			}
		];
		_child addEventHandler [
			'Killed',
			{
				params ['_entity'];
				(0 boundingBoxReal _entity) params ['','','_radius'];
				_nearObjects = nearestObjects [_entity,[],_radius * 3,TRUE];
				if (_nearObjects isNotEqualTo []) then {
					[
						_nearObjects,
						{
							{
								if (local _x) then {
									_x awake TRUE;
								};
							} forEach _this;
						}
					] remoteExec ['call',0,FALSE];
				};
			}
		];
	} else {
		_child setVariable ['QS_bb',TRUE,TRUE];
		if ((toLowerANSI _simulation) in ['thingx']) then {
			_child setVariable ['QS_logistics',TRUE,TRUE];
			_child setVariable ['QS_logistics_immovable',FALSE,TRUE];
		};
	};
};
if (_type isEqualTo 'READ_CLIENT') exitWith {
	params ['','_parent'];
	(_parent getVariable ['QS_virtualCargo',[]])
};