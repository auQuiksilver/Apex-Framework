/*/
File: fn_clientMenuUnloadCargo.sqf
Author:
	
	Quiksilver
	
Last Modified:

	30/10/2023 A3 2.14 by Quiksilver

Description:

	Cargo Unload menu
	
Notes:

	Display different info based on what type of object it is
	
	if (maxLoad == 0) then dont show load/maxLoad
	
	Show a ctrl model to the side
_________________________________________________/*/

disableSerialization;
params ['_mode3'];
if ((getPlayerUID player) in (missionNamespace getVariable ['QS_blacklist_logistics',[]])) exitWith {
	50 cutText [localize 'STR_QS_Text_388','PLAIN',0.3];
};
if (_mode3 isEqualTo 'onLoad') exitWith {
	params ['','_display'];
	uiNamespace setVariable ['QS_client_menuUnloadCargo_display',_display];
	_lbIDC = 1804;
	_ctrlTitle = _display displayCtrl 1802;
	_ctrlSelect = _display displayCtrl 1810;
	_ctrlExit = _display displayCtrl 1811;
	_ctrlListbox = _display displayCtrl _lbIDC;
	_ctrlModel = _display displayCtrl 100;
	_vehicle = uiNamespace getVariable ['QS_menuUnloadCargo_target',cursorObject];
	uiNamespace setVariable ['QS_menuUnloadCargo_target',nil];
	_vehiclePos = getPosWorld _vehicle;
	private _inVehicle = cameraOn isEqualTo _vehicle;
	if (_inVehicle) then {
		_attachedObjects1 = getVehicleCargo _vehicle;
	};
	uiNamespace setVariable ['QS_client_menuUnloadCargo_target',_vehicle];
	private _dn = '';
	private _list = [];
	private _attachedObjects1 = (attachedObjects _vehicle) select {
		(
			(!isNull _x) &&
			{((typeOf _x) isNotEqualTo '')} &&
			{!(isSimpleObject _x)} &&
			{(!((toLowerANSI (typeOf _x)) in ['#lightpoint']))} &&
			{(!(_x isKindOf 'Logic'))}
		)
	};
	_attached = _attachedObjects1 apply {
		[
			_x,
			(_x getVariable ['QS_ST_customDN',QS_hashmap_configfile getOrDefaultCall [format ['cfgvehicles_%1_displayname',toLowerANSI (typeOf _x)],{(getText ((configOf _x) >> 'displayName'))},TRUE]]),
			(loadAbs _x),
			(maxLoad _x)
		]
	};
	private _dn = '';
	private _virtualAttached = [];
	private _virtualCargo = _vehicle getVariable ['QS_virtualCargo',[]];
	if (
		(!_inVehicle) && 
		(_virtualCargo isNotEqualTo [])
	) then {
		{
			if ((_x # 1) > 0) then {
				_dn = QS_hashmap_configfile getOrDefaultCall [
					format ['cfgvehicles_%1_displayname',toLowerANSI ((_x # 0) # 0)],
					{(getText (configFile >> 'CfgVehicles' >> ((_x # 0) # 0) >> 'displayName'))},
					TRUE
				];
				if ((toLowerANSI ((_x # 0) # 0)) isEqualTo 'areamarker_01_f') then {
					_dn = localize 'STR_QS_Text_486';		// vehicle spawn pad
				};
				_virtualAttached pushBack [((_x # 0) # 0),_dn,_x # 1];
			};
		} forEach _virtualCargo;
	};
	if (_attached isNotEqualTo []) then {
		{
			lbAdd [_lbIDC,format [(['%1','%1 (%2 / %3)'] select ((maxLoad (_x # 0)) > 0)),_x # 1,_x # 2,_x # 3]];
			_list pushback [_lbIDC,format [(['%1','%1 (%2 / %3)'] select ((maxLoad (_x # 0)) > 0)),_x # 1,_x # 2,_x # 3]];
		} forEach _attached;
	};
	if (_virtualAttached isNotEqualTo []) then {
		{
			lbAdd [_lbIDC,format ['[%2] %1',_x # 1,_x # 2]];
			_list pushback [_lbIDC,format ['[%2] %1',_x # 1,_x # 2]];
		} forEach _virtualAttached;
	};
	if (_list isNotEqualTo []) then {
		lbSetCurSel [_lbIDC,0];
	};
	uiNamespace setVariable ['QS_client_menuUnloadCargo_objects',((_attached apply {_x # 0}) + (_virtualAttached apply {_x # 0}))];
	_cancel = {
		params ['_vehicle','_vehiclePos'];
		(
			!dialog ||
			{(!alive _vehicle)} ||
			{(((getPosWorld _vehicle) distance _vehiclePos) > 5)} ||
			{((lockedInventory _vehicle) && (isNull (objectParent (missionNamespace getvariable ['QS_player',objNull]))))} ||
			{(_vehicle getVariable ['QS_lockedInventory',FALSE])}
		)
	};
	private _selectedIndex = -1;
	private _selectedName = '';
	uiNamespace setVariable ['QS_client_menuUnloadCargo_object',objNull];
	uiNamespace setVariable ['QS_client_menuUnloadCargo_selectedIndex',-1];
	_EH_ID = addMissionEventHandler [
		'Draw3D',
		{
			if (
				((uiNamespace getVariable ['QS_client_menuUnloadCargo_object',objNull]) isEqualType objNull) &&
				{(!isNull (uiNamespace getVariable ['QS_client_menuUnloadCargo_object',objNull]))}
			) then {
				_object = uiNamespace getVariable ['QS_client_menuUnloadCargo_object',objNull];
				if (!isObjectHidden _object) then {
					if ((worldToScreen (_object modelToWorldVisual [0,0,0])) isNotEqualTo []) then {
						_displayName = QS_hashmap_configfile getOrDefaultCall [
							format ['cfgvehicles_%1_displayname',toLowerANSI (typeOf _object)],
							{(getText ((configOf _object) >> 'displayName'))},
							TRUE
						];
						drawIcon3D [
							'',
							[0.5,0.5,0.5,1],
							(_object modelToWorldVisual [0,0,0]),
							1,
							1,
							0,
							(_object getVariable ['QS_ST_customDN',_displayName]),
							2,
							0.03,
							'RobotoCondensedBold',
							'center',
							FALSE,
							0,
							-0.05
						];
					};
				};
			};
		}
	];
	
	private _menuObject = objNull;
	private _emptyModel = "\A3\Weapons_F\empty.p3d";
	private _objectModel = _emptyModel;
	private _modelScale = 1;
	_modelScaleBase = 0.075;
	_modelVector = [[0.0301068,0.0430097,0],[-0.0024624,-0.00172368,0.0524139]];
	
	for '_z' from 0 to 1 step 0 do {
		uiSleep diag_deltaTime;
		if (
			((attachedObjects _vehicle) isNotEqualTo _attachedObjects1) ||
			{(_virtualCargo isNotEqualTo (_vehicle getVariable ['QS_virtualCargo',[]]))}
		) then {
			_list = [];
			_attachedObjects1 = (attachedObjects _vehicle) select {
				(
					(!isNull _x) &&
					{((typeOf _x) isNotEqualTo '')} &&
					{!(isSimpleObject _x)} &&
					{(!((toLowerANSI (typeOf _x)) in ['#lightpoint']))}
				)
			};
			if (_inVehicle) then {
				_attachedObjects1 = getVehicleCargo _vehicle;
			};
			_attached = _attachedObjects1 apply {
				[
					_x,
					(_x getVariable ['QS_ST_customDN',QS_hashmap_configfile getOrDefaultCall [format ['cfgvehicles_%1_displayname',toLowerANSI (typeOf _x)],{(getText ((configOf _x) >> 'displayName'))},TRUE]]),
					(loadAbs _x),
					(maxLoad _x)
				]
			};
			_virtualCargo = _vehicle getVariable ['QS_virtualCargo',[]];
			_virtualAttached = [];
			if ((!_inVehicle) && (_virtualCargo isNotEqualTo [])) then {
				{
					if ((_x # 1) > 0) then {
						_dn = QS_hashmap_configfile getOrDefaultCall [
							format ['cfgvehicles_%1_displayname',toLowerANSI ((_x # 0) # 0)],
							{(getText (configFile >> 'CfgVehicles' >> ((_x # 0) # 0) >> 'displayName'))},
							TRUE
						];
						_virtualAttached pushBack [((_x # 0) # 0),_dn,_x # 1];
					};
				} forEach _virtualCargo;
			};
			lbClear _lbIDC;
			if (_attached isNotEqualTo []) then {
				{
					lbAdd [_lbIDC,format [(['%1','%1 (%2 / %3)'] select ((maxLoad (_x # 0)) > 0)),_x # 1,_x # 2,_x # 3]];
					_list pushBack (format [(['%1','%1 (%2 / %3)'] select ((maxLoad (_x # 0)) > 0)),_x # 1,_x # 2,_x # 3]);
				} forEach _attached;
			};
			if (_virtualAttached isNotEqualTo []) then {
				{
					lbAdd [_lbIDC,format ['%1 (%2)',_x # 1,_x # 2]];
					_list pushBack (format ['%1 (%2)',_x # 1,_x # 2,_x # 3]);
				} forEach _virtualAttached;
			};
			if (_list isEqualTo []) then {
				closeDialog 2;
			};
			uiNamespace setVariable ['QS_client_menuUnloadCargo_objects',((_attached apply {_x # 0}) + (_virtualAttached apply {_x # 0}))];
			if ((count _list) > _selectedIndex) then {
				lbSetCurSel [_lbIDC,_selectedIndex];
			} else {
				lbSetCurSel [_lbIDC,((count _list) - 1)];
			};
			uiNamespace setVariable ['QS_client_menuUnloadCargo_selectedIndex',_selectedIndex];
			if (_selectedIndex isNotEqualTo -1) then {
				uiNamespace setVariable ['QS_client_menuUnloadCargo_object',(((_attached + _virtualAttached) # _selectedIndex) # 0)];
			} else {
				uiNamespace setVariable ['QS_client_menuUnloadCargo_object',objNull];
			};
		};
		if (_selectedIndex isNotEqualTo (lbCurSel (_display displayCtrl _lbIDC))) then {
			_selectedIndex = lbCurSel (_display displayCtrl _lbIDC);
			uiNamespace setVariable ['QS_client_menuUnloadCargo_selectedIndex',_selectedIndex];
			if (_selectedIndex isNotEqualTo -1) then {
				_menuObject = (((_attached + _virtualAttached) # _selectedIndex) # 0);
				uiNamespace setVariable ['QS_client_menuUnloadCargo_object',_menuObject];
				_objectModel = _emptyModel;
				_modelScale = 1;
				if (_menuObject isEqualType '') then {
					_objectModel = getText (configFile >> 'CfgVehicles' >> _menuObject >> 'model');
					_modelScale = getNumber (configFile >> 'CfgVehicles' >> _menuObject >> 'modelScale');
				} else {
					if (_menuObject isEqualType objNull) then {
						_objectModel = getText ((configOf _menuObject) >> 'model');
						_modelScale = getNumber ((configOf _menuObject) >> 'modelScale');
					};
				};
				_ctrlModel ctrlSetModel _objectModel;
				if (_modelScale isEqualTo 0) then {_modelScale = 1;};
				_ctrlModel ctrlsetmodelscale (_modelScaleBase * _modelScale);
				_ctrlModel ctrlsetmodeldirandup _modelVector;
				_ctrlModel ctrlsetposition [0.75,1,0.75];
				_ctrlModel ctrlCommit 0;
			} else {
				uiNamespace setVariable ['QS_client_menuUnloadCargo_object',objNull];
				_ctrlModel ctrlSetModel _emptyModel;
				_ctrlModel ctrlCommit 0;
			};
		};
		_ctrlSelect ctrlEnable (
			(_selectedIndex isNotEqualTo -1) && 
			(cameraOn isKindOf 'CAManBase') &&
			((uiNamespace getVariable ['QS_client_menuUnloadCargo_object',objNull]) isEqualType objNull)
		);
		_ctrlExit ctrlEnable (
			(_selectedIndex isNotEqualTo -1) && 
			((!surfaceIsWater (getPosWorld _vehicle)) || (_vehicle getVariable ['QS_logistics_deployNearWater',FALSE]))
		);
		if ([_vehicle,_vehiclePos] call _cancel) exitWith {closeDialog 2};
	};
	removeMissionEventHandler ['Draw3D',_EH_ID];
	uiNamespace setVariable ['QS_client_menuUnloadCargo_display',displayNull];
};
if (_mode3 isEqualTo 'onUnload') exitWith {


};
if (_mode3 isEqualTo 'Unload_1') exitWith {
	comment 'Unload to carry';
	if (diag_tickTime < (uiNamespace getVariable ['QS_genericButtonCooldown',-1])) exitWith {
		50 cutText [localize 'STR_QS_Text_371','PLAIN DOWN',0.25];
	};
	uiNamespace setVariable ['QS_genericButtonCooldown',diag_tickTime + 1];
	_vehicle = uiNamespace getVariable ['QS_client_menuUnloadCargo_target',objNull];
	_attached = uiNamespace getVariable ['QS_client_menuUnloadCargo_objects',[]];
	_selectedIndex = uiNamespace getVariable ['QS_client_menuUnloadCargo_selectedIndex',-1];
	_requestedObject = uiNamespace getVariable ['QS_client_menuUnloadCargo_object',objNull];
	if (_requestedObject isEqualType '') exitWith {
		50 cutText [localize 'STR_QS_Text_335','PLAIN DOWN',0.25];
	};
	if (
		(!alive _vehicle) ||
		{(_attached isEqualTo [])} ||
		{(_selectedIndex isEqualTo -1)} ||
		{(!(cameraOn isKindOf 'CAManBase'))}
	) exitWith {};
	([QS_player,'SAFE'] call QS_fnc_inZone) params ['_inBuildRestrictedZone','_zoneLevel','_zoneActive'];
	if (
		(_requestedObject isEqualType '') &&
		_inBuildRestrictedZone && 
		_zoneActive
	) exitWith {
		50 cutText [localize 'STR_QS_Text_403','PLAIN DOWN',0.5];
	};
	([QS_player,'NO_BUILD'] call QS_fnc_inZone) params ['_inBuildRestrictedZone','_zoneLevel','_zoneActive'];
	if (
		(_requestedObject isEqualType '') &&
		_inBuildRestrictedZone && 
		_zoneActive
	) exitWith {
		50 cutText [localize 'STR_QS_Text_403','PLAIN DOWN',0.5];
	};
	if (_requestedObject isEqualType '') exitWith {
		['GET_CLIENT',_vehicle,_requestedObject] call QS_fnc_virtualVehicleCargo;
	};
	if (isNull _requestedObject) exitWith {};
	[_requestedObject,1] call QS_fnc_clientInteractUnloadCargo;
	if (dialog) then {closeDialog 2;};
};
if (_mode3 isEqualTo 'Unload_2') exitWith {
	params ['','',['_placementMode',1]];
	comment 'Unload to ground';
	if (diag_tickTime < (uiNamespace getVariable ['QS_genericButtonCooldown',-1])) exitWith {
		50 cutText [localize 'STR_QS_Text_371','PLAIN DOWN',0.25];
	};
	uiNamespace setVariable ['QS_genericButtonCooldown',diag_tickTime + 1];
	_vehicle = uiNamespace getVariable ['QS_client_menuUnloadCargo_target',objNull];
	_attached = uiNamespace getVariable ['QS_client_menuUnloadCargo_objects',[]];
	_selectedIndex = uiNamespace getVariable ['QS_client_menuUnloadCargo_selectedIndex',-1];
	_requestedObject = uiNamespace getVariable ['QS_client_menuUnloadCargo_object',objNull];
	if (
		(!alive _vehicle) ||
		{(_attached isEqualTo [])} ||
		{(_selectedIndex isEqualTo -1)}
	) exitWith {};
	if (cameraOn isEqualTo _vehicle) exitWith {
		if (
			(_requestedObject isEqualType objNull) &&
			{(_requestedObject in (getVehicleCargo _vehicle))}
		) then {
			objNull setVehicleCargo _requestedObject;
		};
	};
	if (_placementMode isEqualTo 1) exitWith {
		[cameraOn,_requestedObject,TRUE,FALSE,TRUE,TRUE,FALSE,TRUE,_vehicle] call QS_fnc_unloadCargoPlacementMode;
	};
	([QS_player,'SAFE'] call QS_fnc_inZone) params ['_inBuildRestrictedZone','_zoneLevel','_zoneActive'];
	if (
		(_requestedObject isEqualType '') &&
		_inBuildRestrictedZone && 
		_zoneActive
	) exitWith {
		50 cutText [localize 'STR_QS_Text_403','PLAIN DOWN',0.5];
	};
	([QS_player,'NO_BUILD'] call QS_fnc_inZone) params ['_inBuildRestrictedZone','_zoneLevel','_zoneActive'];
	if (
		(_requestedObject isEqualType '') &&
		_inBuildRestrictedZone && 
		_zoneActive
	) exitWith {
		50 cutText [localize 'STR_QS_Text_403','PLAIN DOWN',0.5];
	};
	if (_requestedObject isEqualType '') exitWith {
		['GET_CLIENT',_vehicle,_requestedObject,(uiNamespace getVariable ['QS_targetBoundingBox_ASLPos',[0,0,0]]),(uiNamespace getVariable 'QS_targetBoundingBox_vectors')] call QS_fnc_virtualVehicleCargo;
	};
	if (local _requestedObject) then {
		if (!isNull (isVehicleCargo _requestedObject)) then {
			objNull setVehicleCargo _requestedObject;
		} else {
			[0,_requestedObject] call QS_fnc_eventAttach;
			if (isObjectHidden _requestedObject) then {
				[71,_requestedObject,FALSE] remoteExec ['QS_fnc_remoteExec',2,FALSE];
			};
		};
		if (isNull (objectParent QS_player)) then {
			_timeout = diag_tickTime + 5;
			waitUntil {((isNull (attachedTo _requestedObject)) || (diag_tickTime > _timeout))};
			_requestedObject setVectorDirAndUp (uiNamespace getVariable 'QS_targetBoundingBox_vectors');
			_requestedObject setPosASL (uiNamespace getVariable ['QS_targetBoundingBox_ASLPos',[0,0,0]]);
		};
	} else {
		[45,_vehicle,_requestedObject,(uiNamespace getVariable 'QS_targetBoundingBox_vectors'),(uiNamespace getVariable ['QS_targetBoundingBox_ASLPos',[0,0,0]]),clientOwner] remoteExec ['QS_fnc_remoteExec',0,FALSE];
	};
	missionNamespace setVariable ['QS_targetBoundingBox_placementMode',FALSE,FALSE];
};