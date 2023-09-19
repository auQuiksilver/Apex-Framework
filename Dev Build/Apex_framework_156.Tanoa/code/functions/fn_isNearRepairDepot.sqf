/*/
File: fn_isNearRepairDepot.sqf
Author: 

	Quiksilver

Last Modified:

	2/06/2023 A3 2.12 by Quiksilver

Description:

	Is near repair depot
__________________________________________/*/

params ['_origin',['_radius',12]];
private _return3 = FALSE;
if ((_origin isEqualType objNull) && {(isNull _origin)}) exitWith {
	_return3;
};
_cameraOn = cameraOn;
private _list = _origin nearSupplies _radius;
if (_list isNotEqualTo []) then {
	{
		if (
			((_cameraOn distance2D _x) < _radius) &&
			{(!isSimpleObject _x)} &&
			{(_x isKindOf 'Land_RepairDepot_01_base_F')} &&
			{(!(_x getVariable ['QS_repairdepot_disable',FALSE]))}
		) exitWith {
			if ((getRepairCargo _x) > 0) then {
				[88,_x] remoteExec ['QS_fnc_remoteExec',_x,FALSE];
			};
			_return3 = TRUE;
		};
	} forEach _list;
};
if (_return3) exitWith {_return3};
_list = nearestObjects [_origin,[],_radius,TRUE];
if (_list isNotEqualTo []) then {
	{
		if (
			((_cameraOn distance2D _x) < _radius) &&
			{(!isNull _x)} &&
			{(isSimpleObject _x)} &&
			{((toLowerANSI ((getModelInfo _x) # 1)) in (['repair_depot_models_1'] call QS_data_listVehicles))} &&
			{(!(_x getVariable ['QS_repairdepot_disable',FALSE]))}
		) exitWith {
			_return3 = TRUE;
		};
	} forEach _list;
};
_return3;