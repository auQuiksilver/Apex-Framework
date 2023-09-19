/*/
File: fn_isNearServiceCargo.sqf
Author: 

	Quiksilver

Last Modified:

	26/03/2023 A3 2.12 by Quiksilver

Description:

	Is near service vehicle
	
Notes:

	Reammo
	Repair
	Refuel
	Recover
__________________________________________/*/

params ['_vehicle',['_radius',15],['_requireCursorTarget',FALSE]];
private _return = [];
if (
	(_vehicle isEqualType objNull) && 
	{(isNull _vehicle)}
) exitWith {
	_return;
};
private _cursorTargets = [cursorTarget,cursorObject,getCursorObjectParams # 0] select {!isNull _x};
_radius = _radius max (sizeOf (typeOf _vehicle));
private _list = (_vehicle nearEntities _radius) - [_vehicle];
private _attachedObjects = attachedObjects _vehicle;
private _ropeAttached = ropeAttachedObjects _vehicle;
private _entityOmniModels = ['repair_depot_models_1'] call QS_data_listVehicles;
private _entityOmniKinds = ['services_recover_1'] call QS_data_listVehicles;
private _entType = '';
if (_list isNotEqualTo []) then {
	{
		if (
			(alive _x) &&
			{(!isObjectHidden _x)} &&
			{((_vehicle distance2D _x) < _radius)} &&
			{((!(_requireCursorTarget)) || (_requireCursorTarget && (_x in _cursorTargets)))} &&
			{(!(_x in _attachedObjects))} &&
			{(!(_x in _ropeAttached))} &&
			{(!(_x getVariable ['QS_logistics_wreck',FALSE]))} &&
			{(!(_x getVariable ['QS_service_disabled',FALSE]))}			// For things like enemy service vehicles
		) then {
			_entType = typeOf _x;
			if (
				((getAmmoCargo _x) > -1) ||
				{
					((_x getVariable ['QS_vehicle_reammocargo',-1]) > 0)
				}
			) then {
				_return pushBackUnique [_x,'reammo'];
				if ((getAmmoCargo _x) > 0) then {
					['setAmmoCargo',_x,0] remoteExec ['QS_fnc_remoteExecCmd',_x,FALSE];
				};
			};
			if (
				((getRepairCargo _x) > -1) ||
				{
					((_x getVariable ['QS_vehicle_repaircargo',-1]) > 0)
				}
			) then {
				_return pushBackUnique [_x,'repair'];
				if ((getRepairCargo _x) > 0) then {
					['setRepairCargo',_x,0] remoteExec ['QS_fnc_remoteExecCmd',_x,FALSE];
				};
			};
			if (
				((getFuelCargo _x) > -1) ||
				{
					((_x getVariable ['QS_vehicle_refuelcargo',-1]) > 0)
				}
			) then {
				_return pushBackUnique [_x,'refuel'];
				if ((getFuelCargo _x) > 0) then {
					['setFuelCargo',_x,0] remoteExec ['QS_fnc_remoteExecCmd',_x,FALSE];
				};
			};
			if ((_x getVariable ['QS_vehicle_recovercargo',-1]) > 0) then {
				_return pushBackUnique [_x,'recover'];
			};
			if (
				((toLowerANSI ((getModelInfo _x) # 1)) in _entityOmniModels) ||
				((_entityOmniKinds findIf { _entType isKindOf _x }) isNotEqualTo -1)
			) then {
				_return pushBackUnique [_x,'reammo'];
				_return pushBackUnique [_x,'refuel'];
				_return pushBackUnique [_x,'repair'];
				_return pushBackUnique [_x,'recover'];
			};
		};
	} forEach _list;
};
_list = nearestObjects [_vehicle,[],_radius,TRUE];
if (_list isNotEqualTo []) then {
	_omniModels = ['services_all_1'] call QS_data_listVehicles;
	_reammoModels = (['services_reammo_1'] call QS_data_listVehicles) + _omniModels;
	_repairModels = (['services_repair_1'] call QS_data_listVehicles) + _omniModels;
	_refuelModels = (['services_refuel_1'] call QS_data_listVehicles) + _omniModels;
	_recoverModels = [];
	{
		if (
			(!isNull _x) &&
			{(isSimpleObject _x)} &&
			{(!isObjectHidden _x)} &&
			{((_vehicle distance2D _x) < _radius)} &&
			{((!(_requireCursorTarget)) || (_requireCursorTarget && (_x in _cursorTargets)))} &&
			{(!(_x in _attachedObjects))} &&
			{(!(_x in _ropeAttached))} &&
			{(!(_x getVariable ['QS_service_disabled',FALSE]))}
		) then {
			if ((toLowerANSI ((getModelInfo _x) # 1)) in _reammoModels) then {
				_return pushBackUnique [_x,'reammo'];
			};
			if ((toLowerANSI ((getModelInfo _x) # 1)) in _repairModels) then {
				_return pushBackUnique [_x,'repair'];
			};
			if ((toLowerANSI ((getModelInfo _x) # 1)) in _refuelModels) then {
				_return pushBackUnique [_x,'refuel'];
			};
			if ((toLowerANSI ((getModelInfo _x) # 1)) in _recoverModels) then {
				_return pushBackUnique [_x,'recover'];
			};
		};
	} forEach _list;
};
// Terrain Fuel pumps
_list = nearestTerrainObjects [_vehicle,[],_radius,FALSE,TRUE];
if (_list isNotEqualTo []) then {
	{
		if (
			(!isNull _x) &&
			{((getFuelCargo _x) > 0)} &&
			{((_vehicle distance2D _x) < _radius)} &&
			{((allowedService _x) isEqualTo 0)} &&
			{((!(_requireCursorTarget)) || (_requireCursorTarget && (_x in _cursorTargets)))}
		) then {
			_return pushBackUnique [_x,'refuel'];
		};
	} forEach _list;
};
// Support for old/obsolete service markers
_markerData = [
	[['QS_marker_veh_baseservice_01','QS_marker_veh_fieldservice_01','QS_marker_veh_fieldservice_02','QS_marker_veh_fieldservice_03'],['LandVehicle']],
	[['QS_marker_veh_baseservice_02','QS_marker_veh_fieldservice_04'],['Helicopter']],
	[['QS_marker_veh_baseservice_03','QS_marker_veh_fieldservice_04'],['Plane']],
	[['QS_marker_boats_1','QS_marker_boats_2'],['Ship']]
];
{
	_x params ['_markers','_kinds'];
	if (
		((_kinds findIf { _vehicle isKindOf _x }) isNotEqualTo -1) &&
		{((_markers findIf { ((_vehicle distance2D (markerPos _x)) < _radius) }) isNotEqualTo -1)}
	) then {
		_return pushBackUnique [objNull,'reammo'];
		_return pushBackUnique [objNull,'repair'];
		_return pushBackUnique [objNull,'refuel'];
	};
} forEach _markerData;
// Static Ship support
if (_cursorTargets isNotEqualTo []) then {
	{
		if (
			(((missionNamespace getVariable ['QS_missionConfig_carrierEnabled',0]) isNotEqualTo 0) && {(['INPOLYGON',_x] call QS_fnc_carrier)}) || 
			{(((missionNamespace getVariable ['QS_missionConfig_destroyerEnabled',0]) isNotEqualTo 0) && {(['INPOLYGON',_x] call QS_fnc_destroyer)})}
		) then {
			_return pushBackUnique [objNull,'reammo'];
			_return pushBackUnique [objNull,'repair'];
			_return pushBackUnique [objNull,'refuel'];
		};
	} forEach _cursorTargets;
};
_return;