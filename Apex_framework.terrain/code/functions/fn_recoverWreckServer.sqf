/*
File: fn_recoverWreckServer.sqf
Author:
	
	Quiksilver
	
Last Modified:

	30/03/2023 2.12 by Quiksilver

Description:

	Wreck Recovery
____________________________________________*/

params ['_entity','_profileName','_uid'];
private _vIndex = (serverNamespace getVariable 'QS_v_Monitor') findIf { _entity isEqualTo (_x # 0) };
private _element = (serverNamespace getVariable 'QS_v_Monitor') # _vIndex;
private _replaceAsset = FALSE;
private _managed = FALSE;
(_entity getVariable ['QS_wreck_info',[]]) params ['_wreckState','_vehicleType','_wreckType','_vehicleDisplayName'];
if (_vIndex isNotEqualTo -1) then {
	_managed = TRUE;
	_element = (serverNamespace getVariable 'QS_v_Monitor') # _vIndex;
	_element set [17,FALSE];
	_wreckInfo = _element # 20;
	_wreckInfo params ['_wreckState','_vehicleType','_wreckType','_vehicleDisplayName'];
	if ((typeOf _entity) isKindOf _vehicleType) then {
		_replaceAsset = FALSE;
	};
	if ((typeOf _entity) isKindOf _wreckType) then {
		_replaceAsset = TRUE;
	};
	_wreckState = FALSE;
	_element set [20,[_wreckState,_vehicleType,_wreckType,_vehicleDisplayName]];
	if (_replaceAsset) then {
		//_entityVectors = [vectorDir _entity,vectorUp _entity];
		_entityVectors = [vectorDir _entity,[0,0,1]];
		_entityPos = (getPosASL _entity) vectorAdd [0,0,1];
		_oldEntity = _entity;
		if (!isNull (ropeAttachedTo _oldEntity)) then {
			{
				ropeDestroy _x;
			} forEach (ropes (ropeAttachedTo _oldEntity));
		};
		{ropeDestroy _x} forEach (ropes _oldEntity);
		deleteVehicle (attachedObjects _oldEntity);
		if (!isNull (isVehicleCargo _oldEntity)) then {
			objNull setVehicleCargo _oldEntity;
		};
		_entity = createVehicle [_vehicleType,[-500,-500,500],[],100,'CAN_COLLIDE'];
		_entity setVectorDirAndUp _entityVectors;
		if (_managed) then {
			_element = (serverNamespace getVariable 'QS_v_Monitor') # _vIndex;
			_element set [0,_entity];
		};
		deleteVehicle _oldEntity;
		[_entity,_entityPos] spawn {
			params ['_entity','_entityPos'];
			sleep 0.5;
			_entity setPosASL (_entityPos vectorAdd [0,0,1]);
			_entity awake TRUE;
			playSound3D [
				'A3\Sounds_F\sfx\ui\vehicles\vehicle_repair.wss',
				_entity,
				FALSE,
				(getPosASL _entity),
				1,
				1,
				15
			];
			sleep 0.5;
			_entity setDamage [0,FALSE];
		};
	} else {
		_entity setDamage [0,FALSE];
		['setFuel',_entity,1] remoteExec ['QS_fnc_remoteExecCmd',_entity,FALSE];
		[_entity,TRUE] remoteExec ['allowDamage',_entity,FALSE];
	};
} else {
	if ((typeOf _entity) isKindOf _vehicleType) then {
		_replaceAsset = FALSE;
	};
	if ((typeOf _entity) isKindOf _wreckType) then {
		_replaceAsset = TRUE;
	};
	if (_replaceAsset) then {
		//_entityVectors = [vectorDir _entity,vectorUp _entity];
		_entityVectors = [vectorDir _entity,[0,0,1]];
		_entityPos = (getPosASL _entity) vectorAdd [0,0,1];
		_oldEntity = _entity;
		if (!isNull (ropeAttachedTo _oldEntity)) then {
			{
				ropeDestroy _x;
			} forEach (ropes (ropeAttachedTo _oldEntity));
		};
		{ropeDestroy _x} forEach (ropes _oldEntity);
		deleteVehicle (attachedObjects _oldEntity);
		if (!isNull (isVehicleCargo _oldEntity)) then {
			objNull setVehicleCargo _oldEntity;
		};
		_entity = createVehicle [_vehicleType,[-500,-500,500],[],100,'CAN_COLLIDE'];
		_entity setVectorDirAndUp _entityVectors;
		if (_managed) then {
			_element = (serverNamespace getVariable 'QS_v_Monitor') # _vIndex;
			_element set [0,_entity];
		};
		//(str [_oldEntity,_entity,_vehicleType]) remoteExec ['systemChat',-2];
		deleteVehicle _oldEntity;
		[_entity,_entityPos] spawn {
			params ['_entity','_entityPos'];
			sleep 0.5;
			_entity setPosASL (_entityPos vectorAdd [0,0,1]);
			_entity awake TRUE;
			playSound3D [
				'A3\Sounds_F\sfx\ui\vehicles\vehicle_repair.wss',
				_entity,
				FALSE,
				(getPosASL _entity),
				1,
				1,
				15
			];
			sleep 0.5;
			_entity setDamage [0,FALSE];
		};
	} else {
		_entity setDamage [0,FALSE];
		['setFuel',_entity,1] remoteExec ['QS_fnc_remoteExecCmd',_entity,FALSE];
		[_entity,TRUE] remoteExec ['allowDamage',_entity,FALSE];
	};
};
if (_managed) then {
	(serverNamespace getVariable 'QS_v_Monitor') set [_vIndex,_element];
};
if ((_entity getVariable ['QS_wreck_handlers',[]]) isNotEqualTo []) then {
	{
		_entity removeEventHandler _x;
	} forEach (_entity getVariable ['QS_wreck_handlers',[]]);
	_entity setVariable ['QS_wreck_handlers',[],FALSE];
};
_isLogistics = ((['Air','LandVehicle','Ship'] findIf { (_entity isKindOf _x) }) isEqualTo -1) || ((getMass _entity) <= 1000);
_marker = _entity getVariable ['QS_wreck_marker',''];
if (_marker isNotEqualTo '') then {
	deleteMarker _marker;
};
[_entity,0] call (missionNamespace getVariable 'QS_fnc_vehicleAddSmokeEffect');
_text = format [localize 'STR_QS_Text_477',_vehicleDisplayName,_profileName,mapGridPosition _entity];
['systemChat',_text] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
{
	_entity setVariable _x;
} forEach [
	['QS_logistics_wreck',FALSE,TRUE],
	['QS_wreck_handlers',[],FALSE],
	['QS_logistics',_isLogistics,TRUE],
	['QS_logistics_dragDisabled',TRUE,TRUE],
	['QS_ST_customDN',_vehicleDisplayName,TRUE],
	['QS_wreck_marker','',FALSE]
];
['OFF',_entity] call QS_fnc_wreckSetMaterials;
[_entity] call QS_fnc_vSetup;