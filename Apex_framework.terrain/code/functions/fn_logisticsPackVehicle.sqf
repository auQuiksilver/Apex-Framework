/*/
File: fn_logisticsPackVehicle.sqf
Author:
	
	Quiksilver
	
Last Modified:

	9/11/2023 A3 2.14 by Quiksilver
	
Description:

	Pack/Unpack vehicles
	
Notes:

	In the future do we want it to be only pack/unpack when within base areas? 
	Could encourage players to build forward bases as an "unpack point"
______________________________________________________/*/

params ['_mode','_args'];
if (_mode isEqualTo 0) then {
	// Unpack
	_args params ['_cursorObject','_profileName'];
	_entity = ((attachedObjects _cursorObject) select {(_x getVariable ['QS_logistics_packed',FALSE])}) # 0;
	_pos = (getPosASL _cursorObject) vectorAdd [0,0,1];
	//_vectors = [vectorDir _cursorObject,vectorUp _cursorObject];
	_vectors = [vectorDir _cursorObject,[0,0,1]];
	_displayName = QS_hashmap_configfile getOrDefaultCall [
		format ['cfgvehicles_%1_displayname',toLowerANSI (typeOf _entity)],
		{(getText ((configOf _entity) >> 'displayName'))},
		TRUE
	];
	_dn = _entity getVariable ['QS_ST_customDN',_displayName];
	(format [localize 'STR_QS_Chat_181',_profileName,_dn,mapGridPosition _cursorObject]) remoteExec ['systemChat',-2];
	_cursorObject setPosASL [-1000,-1000,200];
	_entity setPosASL [-1000,-1000,(1000 + (random 1000))];
	[0,_entity] call QS_fnc_eventAttach;
	_entity setPosASL [-1000,-1000,(1000 + (random 1000))];
	if ((_cursorObject getVariable ['QS_logistics_cargoMarker','']) isNotEqualTo '') then {
		deleteMarker (_cursorObject getVariable ['QS_logistics_cargoMarker','']);
	};
	_cursorObject removeAllEventHandlers 'Deleted';
	deleteVehicle _cursorObject;
	sleep (diag_deltaTime * 3);
	_entity setVelocity [0,0,0];
	_entity setVectorDirAndUp _vectors;
	_entity setPosASL _pos;
	_timeout = diag_tickTime + 5;
	waitUntil {
		_entity hideObjectGlobal FALSE;			// Also potentially need to unhide attached objects
		sleep 1;
		((!isObjectHidden _entity) || (diag_tickTime > _timeout))
	};
	{
		_entity setVariable _x;	
	} forEach [
		['QS_logistics_cargoParent',objNull,TRUE],
		['QS_logistics_packed',FALSE,TRUE]
	];
	_entity awake TRUE;
	if (local _entity) then {
		_entity allowDamage TRUE;
	} else {
		[_entity,TRUE] remoteExec ['allowDamage',_entity,FALSE];	
	};
	if ((_entity getVariable ['QS_logistics_packedEHs',[]]) isNotEqualTo []) then {
		{
			_entity removeEventHandler _x;
		} forEach (_entity getVariable ['QS_logistics_packedEHs',[]]);
		_entity setVariable ['QS_logistics_packedEHs',[],FALSE];
	};
	if ((_entity getVariable ['QS_logistics_packedHiddenObjs',[]]) isNotEqualTo []) then {
		{
			_x hideObjectGlobal FALSE;
		} forEach (_entity getVariable ['QS_logistics_packedHiddenObjs',[]]);
		_entity setVariable ['QS_logistics_packedHiddenObjs',[],FALSE];
	};
	private _waterDamaged = waterDamaged _entity;
	if ((_entity getVariable ['QS_logistics_packedDmg',[]]) isNotEqualTo []) then {
		{
			if (
				_waterDamaged &&
				{(_x in ['hitengine','hitengine1','hitengine2','hitengine3','hitengine4'])}
			) then {
				_entity setHitPointDamage [_x,0];
				sleep (diag_deltaTime * 3);
			};
			_entity setHitPointDamage [_x,(_entity getVariable ['QS_logistics_packedDmg',[]]) # _forEachIndex];
		} forEach ((getAllHitPointsDamage _entity) # 0);
		_entity setVariable ['QS_logistics_packedDmg',[],FALSE];
	};
};
if (_mode isEqualTo 1) then {
	// Pack
	_args params ['_cursorObject','_profileName'];
	_displayName = QS_hashmap_configfile getOrDefaultCall [
		format ['cfgvehicles_%1_displayname',toLowerANSI (typeOf _cursorObject)],
		{(getText ((configOf _cursorObject) >> 'displayName'))},
		TRUE
	];
	_dn = _cursorObject getVariable ['QS_ST_customDN',_displayName];
	_pos = (getPosASL _cursorObject) vectorAdd [0,0,1];
	//_vectors = [vectorDir _cursorObject,vectorUp _cursorObject];
	_vectors = [vectorDir _cursorObject,[0,0,1]];
	_type = [_cursorObject] call QS_fnc_getContainerType;
	_entity = createVehicle [_type,[-1000,-1000,(200 + (random 200))]];
	_entity enableDynamicSimulation FALSE;
	[1,_cursorObject,[_entity,[0,0,-100]]] call QS_fnc_eventAttach;
	{
		_cursorObject setVariable _x;	
	} forEach [
		['QS_logistics_cargoParent',_entity,TRUE],
		['QS_logistics_packed',TRUE,TRUE],
		['QS_logistics_packedDmg',((getAllHitPointsDamage _cursorObject) # 2),FALSE],
		['QS_logistics_packedWtrDmg',waterDamaged _cursorObject,FALSE]
	];
	{
		_entity setVariable _x;	
	} forEach [
		['QS_dynSim_ignore',TRUE,TRUE],
		['QS_logistics_isCargoParent',TRUE,TRUE],
		['QS_logistics_cargoChild',_cursorObject,TRUE],
		['QS_logistics_disableCargo',TRUE,TRUE],
		['QS_logistics',TRUE,TRUE],
		['QS_ST_customDN',_dn,TRUE],
		['QS_ST_showDisplayName',TRUE,TRUE]
	];
	_entity setMaxLoad 0;
	_entity setVectorDirAndUp _vectors;
	_entity setPosASL _pos;
	private _packedMass = 2500;
	if (_cursorObject isKindOf 'Wheeled_APC_F') then {
		_packedMass = 4999;
	};
	if (_cursorObject isKindOf 'Tank') then {
		_packedMass = 9999;		// Do we need an exception for Nyx tankette?
	};
	if (_cursorObject getVariable ['QS_logistics_wreck',FALSE]) then {
		_packedMass = 2500;		// Wrecks should be transportable by most helis
	};
	_entity setMass _packedMass;
	[_entity,FALSE] remoteExec ['allowDamage',_entity,FALSE];
	[_entity,_packedMass] remoteExec ['setMass',_entity,FALSE];
	(format [localize 'STR_QS_Chat_180',_profileName,_dn,mapGridPosition _entity]) remoteExec ['systemChat',-2];
	if ((crew _cursorObject) isNotEqualTo []) then {
		{
			if (unitIsUav _x) then {
				deleteVehicle _x;
			} else {
				_x moveOut _cursorObject;
			};
		} forEach (crew _cursorObject);
	};
	waitUntil {
		_cursorObject hideObjectGlobal TRUE;		// Also potentially need to hide object on attached objects
		sleep 1;
		(isObjectHidden _cursorObject)
	};
	_entity awake TRUE;
	_cursorObject spawn {
		_t = diag_tickTime + 5;
		waitUntil {
			sleep 0.25;
			((local _this) || {(_this setOwner 2)} || {(diag_tickTime > _t)})
		};
	};
	_cursorObject allowDamage FALSE;
	if (isEngineOn _cursorObject) then {
		_cursorObject engineOn FALSE;
	};
	if (isLightOn _cursorObject) then {
		_cursorObject setPilotLight FALSE;	
	};
	[
		[_cursorObject],
		{
			params ['_cursorObject'];
			if (!isNull (assignedGroup _cursorObject)) then {
				(assignedGroup _cursorObject) leaveVehicle _cursorObject;
			};
		}
	] remoteExec ['call',0,FALSE];
	_vIndex = (serverNamespace getVariable 'QS_v_Monitor') findIf { _cursorObject isEqualTo (_x # 0) };
	if (_vIndex isEqualTo -1) then {
		(serverNamespace getVariable 'QS_v_Monitor') pushBack [
			_cursorObject,
			-1,
			FALSE,
			{},
			typeOf _cursorObject,
			[0,0,0],
			0,
			FALSE,
			-1,
			-1,
			1000,
			1000,
			0,		
			-1,
			FALSE,
			0,
			{TRUE},
			FALSE,
			TRUE,
			[_pos,_vectors],
			[FALSE,'','',''],
			0,
			{FALSE}
		];
	};
	_marker = createMarker [str systemTime,_entity];
	_marker setMarkerTypeLocal 'mil_dot';
	_marker setMarkerShapeLocal 'Icon';
	_marker setMarkerColorLocal 'ColorUNKNOWN';
	_marker setMarkerSizeLocal [0.5,0.5];
	_marker setMarkerTextLocal (format ['%1',_dn]);
	_marker setMarkerAlpha 0.35;
	{
		_entity setVariable _x;
	} forEach [
		['QS_logistics_cargoMarker',_marker,FALSE],
		['QS_logistics_cargoPackPos',(_pos vectorAdd [0,0,1]),FALSE]
	];
	//_customCargoCapacity = _vehicle getVariable ['QS_customCargoCapacity',[]];
	sleep 1;
	if (_cursorObject getVariable ['Utility_Offroad_Beacons',FALSE]) then {
		_vehicle setVariable ['Utility_Offroad_Beacons',FALSE,TRUE];
	};
	_allAttached = ([_cursorObject] call QS_fnc_getAllAttached) select {!isObjectHidden _x};
	{
		_x hideObjectGlobal TRUE;
	} forEach _allAttached;
	_cursorObject setVariable ['QS_logistics_packedHiddenObjs',_allAttached,FALSE];
	_cursorObject setVariable ['QS_logistics_packedEHs',[],FALSE];
	private _packedEHs = [];
	{
		_packedEHs pushBack [_x # 0,(_cursorObject addEventHandler _x)];
	} forEach [
		[
			'HandleDamage',
			{
				if (isDamageAllowed (_this # 0)) then {
					(_this # 0) allowDamage FALSE;
				};
				([(_this # 0) getHit (_this # 1),damage (_this # 0)] select ((_this # 1) isEqualTo ''))
			}
		],
		[
			'Deleted',
			{
				params ['_cursorObject'];
				_attachedObjs = [_cursorObject] call QS_fnc_getAllAttached;
				deleteVehicle _attachedObjs;
				_cargoParent = _cursorObject getVariable ['QS_logistics_cargoParent',objNull];
				if (!isNull _cargoParent) then {
					if (!isNull (isVehicleCargo _cargoParent)) then {
						objNull setVehicleCargo _cargoParent;	
					};
					deleteVehicle _cargoParent;
				};
			}
		],
		[
			'Killed',
			{
				params ['_cursorObject'];
				_attachedObjs = [_cursorObject] call QS_fnc_getAllAttached;
				deleteVehicle _attachedObjs;
				_cargoParent = _cursorObject getVariable ['QS_logistics_cargoParent',objNull];
				if (!isNull _cargoParent) then {
					if (!isNull (isVehicleCargo _cargoParent)) then {
						objNull setVehicleCargo _cargoParent;	
					};
					deleteVehicle _cargoParent;
				};
			}
		]
	];
	_cursorObject setVariable ['QS_logistics_packedEHs',_packedEHs,FALSE];
	{
		_entity addEventHandler _x;	
	} forEach [
		[
			'Deleted',
			{
				params ['_container'];
				// Delete all attached
				if ((attachedObjects _container) isNotEqualTo []) then {
					_entity = ((attachedObjects _container) select {(_x getVariable ['QS_logistics_packed',FALSE])}) # 0;
					if (!isNil '_entity') then {
						if (!isNull _entity) then {
							deleteVehicle ([_entity] call QS_fnc_getAllAttached);
							deleteVehicle _entity;
						};
					};
				};
				if ((_container getVariable ['QS_logistics_cargoMarker','']) isNotEqualTo '') then {
					deleteMarker (_container getVariable ['QS_logistics_cargoMarker','']);
				};
			}
		],
		[
			'Killed',
			{
				params ['_container'];
				// Delete all attached
				if ((attachedObjects _container) isNotEqualTo []) then {
					_entity = ((attachedObjects _container) select {(_x getVariable ['QS_logistics_packed',FALSE])}) # 0;
					if (!isNil '_entity') then {
						if (!isNull _entity) then {
							deleteVehicle ([_entity] call QS_fnc_getAllAttached);
							deleteVehicle _entity;
						};
					};
				};
				if ((_container getVariable ['QS_logistics_cargoMarker','']) isNotEqualTo '') then {
					deleteMarker (_container getVariable ['QS_logistics_cargoMarker','']);
				};
				deleteVehicle _container;
			}
		],
		[
			'Local',
			{
				params ['_entity','_isLocal'];
				if (_isLocal) then {
					
				} else {
					[_entity,FALSE] remoteExec ['allowDamage',_entity,FALSE];
				};
			}
		]
	];
};