/*/
File: fn_virtualVehicleCargo.sqf
Author:
	
	Quiksilver
	
Last Modified:

	9/11/2023 A3 2.14 by Quiksilver
	
Description:

	Virtual Vehicle Cargo
______________________________________________________/*/
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
	if (diag_tickTime < (_parent getVariable ['QS_logistics_dupeCooldown',-1])) exitWith {};
	_parent setVariable ['QS_logistics_dupeCooldown',diag_tickTime + 0.5,FALSE];
	playSound3D [
		'A3\Sounds_F\sfx\ui\vehicles\vehicle_rearm.wss',
		_parent,
		FALSE,
		(getPosASL _parent),
		1,
		1,
		15
	];
	[24,['HANDLE',['SET_SERVER',_parent,_child,clientOwner,getPlayerUID player]]] remoteExec ['QS_fnc_remoteExec',2,FALSE];
};
if (_type isEqualTo 'DISASSEMBLE') exitWith {
	params ['','_child'];
	if (isNull _child) exitWith {
		systemChat 'child does not exist';
	};
	_parent = _child getVariable ['QS_virtualCargoParent',objNull];
	if (isNull _parent) exitWith {
		systemChat 'parent does not exist';
	};
	private _cargoCapacity = [_parent,0] call QS_fnc_getCargoCapacity;
	private _currentLoad = [_parent,0] call QS_fnc_getCargoVolume;
	_cargoCapacity params ['_cargoMaxCapacity','_cargoMaxMass','_cargoMaxCoef'];
	_currentLoad params ['_currentCargoVolume','_currentCargoMass'];
	_newCargoVolume = [_child] call QS_fnc_getObjectVolume;
	_text = format [
		'<t align="center">%6: %1 / %2<t/><br/><t align="center">%5: %3 / %4<t/>',
		round _currentCargoMass,
		round _cargoMaxMass,
		parseNumber (_currentCargoVolume toFixed 2),
		round _cargoMaxCapacity,
		localize 'STR_QS_Utility_031',
		localize 'STR_QS_Utility_032'
	];
	50 cutText [_text,'PLAIN DOWN',0.666, TRUE, TRUE];
	if ((_currentCargoVolume + _newCargoVolume) > _cargoMaxCapacity) exitWith {
		50 cutText [localize 'STR_QS_Text_464','PLAIN DOWN',0.333];
		FALSE
	};
	private _result = [format ['%1 %2',localize 'STR_QS_Interact_130',getText ((configOf _child) >> 'displayName')],localize 'STR_QS_Interact_142',localize 'STR_QS_Interact_143',localize 'STR_QS_Interact_144',(findDisplay 46),FALSE,FALSE] call (missionNamespace getVariable 'BIS_fnc_guiMessage'); 
	if (_result) then {
		['SET_CLIENT',_parent,_child] call QS_fnc_virtualVehicleCargo;
	};
	TRUE;
};
if (_type isEqualTo 'GET_CLIENT') exitWith {
	params ['','_parent','_childType','_placementPos','_placementAzi'];
	if (isNull _parent) exitWith {};
	if (diag_tickTime < (_parent getVariable ['QS_logistics_dupeCooldown',-1])) exitWith {};
	_parent setVariable ['QS_logistics_dupeCooldown',diag_tickTime + 0.5,FALSE];
	_childType = toLowerANSI _childType;
	if (
		(_parent getVariable ['QS_logistics_deployed',FALSE]) &&
		{(((flatten ([EAST,RESISTANCE] apply {units _x})) inAreaArray [_parent,QS_enemyInterruptAction_radius,QS_enemyInterruptAction_radius,0,FALSE,-1]) isNotEqualTo [])}
	) exitWith {
		systemChat (localize 'STR_QS_Chat_178');
	};
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
	[24,['HANDLE',['GET_SERVER',_parent,_childType,clientOwner,_placementPos,_placementAzi,QS_player,getPlayerUID player]]] remoteExec ['QS_fnc_remoteExec',2,FALSE];
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
	if (isNull _parent) exitWith {};
	if (diag_tickTime < (_parent getVariable ['QS_logistics_dupeCooldown',-1])) exitWith {};
	_parent setVariable ['QS_logistics_dupeCooldown',diag_tickTime + 0.5,FALSE];
	[24,[_parent,_virtualCargo]] remoteExec ['QS_fnc_remoteExec',2,FALSE];
};
if (_type isEqualTo 'SET_SERVER') exitWith {
	params ['','_parent','_child',['_clientOwner',2],['_uid','']];
	if (
		(!alive _parent) ||
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
	if (['IS_MANAGED_BASE',_parent] call QS_fnc_baseHandle) then {
		[
			'HANDLE',
			[
				'PROP_REMOVE',
				_parent,
				_child
			]
		] call QS_fnc_baseHandle;
	};
	if ((attachedObjects _child) isNotEqualTo []) then {
		{
			_x removeAllEventHandlers 'Deleted';
			deleteVehicle _x;
		} forEach (attachedObjects _child);
	};
	_child removeAllEventHandlers 'Deleted';
	deleteVehicle _child;
};
if (_type isEqualTo 'GET_SERVER') exitWith {
	params ['','_parent','_childType','_clientOwner','_placementPos','_placementAzi','_player',['_uid','']];
	_parentIndex = QS_system_virtualCargo findIf { _parent isEqualTo (_x # 0) };
	if (
		(_parentIndex isEqualTo -1) ||
		{(diag_tickTime < (_parent getVariable ['QS_logistics_dupeCooldown',-1]))}
	) exitWith {};
	_parent setVariable ['QS_logistics_dupeCooldown',diag_tickTime + 0.5,FALSE];
	QS_system_builtObjects = QS_system_builtObjects select {!isNull _x};
	if ((count QS_system_builtObjects) >= (missionNamespace getVariable ['QS_missionConfig_maxBuild',300])) exitWith {
		_text = format ['Global built objects cap exceeded ( %1 )',(missionNamespace getVariable ['QS_missionConfig_maxBuild',300])];
		_text remoteExec ['systemChat',_player,FALSE];
	};
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
	private _child = objNull;
	if (_childType isKindOf 'CAManBase') then {
		_child = (createGroup [(_player getVariable ['QS_unit_side',WEST]),TRUE]) createUnit [QS_core_units_map getOrDefault [toLowerANSI _childType,_childType],[0,0,0],[],0,'CAN_COLLIDE'];
	} else {
		if (_isSimpleObject isEqualTo 1) then {
			_child = createSimpleObject [QS_core_vehicles_map getOrDefault [toLowerANSI _childType,_childType],_placementPos,FALSE];
		} else {
			_child = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _childType,_childType],[0,0,0]];
		};	
	};
	if (isNull _child) exitWith {
		diag_log '***** QS DEBUG ***** VIRTUAL VEHICLE CARGO * child is null object 176';
	};
	_child allowDamage (_damageAllowed isEqualTo 1);
	_child enableSimulationGlobal (_simulationEnabled isEqualTo 1);
	_child enableDynamicSimulation (_simulationEnabled isEqualTo 1);
	if (_damage > 0) then {
		_child setDamage [_damage,FALSE];
	};
	_child setVectorDirAndUp _placementAzi;
	_child setPosASL _placementPos;
	[_child,_childType,_parent] call QS_fnc_propCustomCode;
	playSound3D [
		'A3\Sounds_F\sfx\ui\vehicles\vehicle_rearm.wss',
		_child,
		FALSE,
		(getPosASL _child),
		1,
		1,
		15
	];
	if (['IS_MANAGED_BASE',_parent] call QS_fnc_baseHandle) then {
		[
			'HANDLE',
			[
				'PROP_ADD',
				_parent,
				_child
			]
		] call QS_fnc_baseHandle;
	};
	_count = _count - 1;
	if (_count <= 0) then {
		_virtualCargo deleteAt _virtualCargoIndex;
	} else {
		_virtualCargo set [_virtualCargoIndex,[[_childType,_isSimpleObject,_damageAllowed,_simulationEnabled,_boundingRadius,_damage],_count]];
	};
	_parent setVariable ['QS_virtualCargo',_virtualCargo,TRUE];
	{
		_child setVariable _x;
	} forEach [
		['QS_virtualCargoParent',_parent,TRUE],
		['QS_virtualChild_time',serverTime,TRUE],
		['QS_logistics_virtual',TRUE,TRUE],
		['QS_logistics_owner',_clientOwner,TRUE],
		['QS_logistics_creatorUID',_uid,TRUE]
	];
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
};
if (_type isEqualTo 'READ_CLIENT') exitWith {
	params ['','_parent'];
	(_parent getVariable ['QS_virtualCargo',[]])
};