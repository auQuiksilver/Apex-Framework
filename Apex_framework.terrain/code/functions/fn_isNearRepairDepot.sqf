/*/
File: fn_isNearRepairDepot.sqf
Author: 

	Quiksilver

Last Modified:

	31/10/2022 A3 2.10 by Quiksilver

Description:

	Is near repair depot
__________________________________________/*/

params ['_origin',['_radius',12]];
private _return = FALSE;
if ((_origin isEqualType objNull) && {(isNull _origin)}) exitWith {
	_return;
};
_cameraOn = cameraOn;
private _list = _origin nearSupplies _radius;		//===== Alt syntax appears not to work:   _origin nearSupplies ['Land_RepairDepot_01_base_F',_radius];
if (_list isNotEqualTo []) then {
	{
		if (
			((_cameraOn distance2D _x) < _radius) &&
			{(!isSimpleObject _x)} &&
			{(_x isKindOf 'Land_RepairDepot_01_base_F')} &&
			{(!(_x getVariable ['QS_repairdepot_disable',FALSE]))} &&
			{((getRepairCargo _x) > 0)}
		) exitWith {
			if ((getRepairCargo _x) > 0) then {
				[88,_x] remoteExec ['QS_fnc_remoteExec',_x,FALSE];
			};
			_return = TRUE;
		};
	} forEach _list;
};
if (_return) exitWith {_return};
_list = nearestObjects [_origin,[],_radius,TRUE];
if (_list isNotEqualTo []) then {
	{
		if (
			((_cameraOn distance2D _x) < _radius) &&
			{(!isNull _x)} &&
			{(isSimpleObject _x)} &&
			{((toLowerANSI ((getModelInfo _x) # 1)) in [
				'a3\structures_f_tank\military\repairdepot\repairdepot_01_civ_f.p3d',
				'a3\structures_f_tank\military\repairdepot\repairdepot_01_green_f.p3d',
				'a3\structures_f_tank\military\repairdepot\repairdepot_01_tan_f.p3d'
			])} &&
			{(!(_x getVariable ['QS_repairdepot_disable',FALSE]))}
		) exitWith {
			_return = TRUE;
		};
	} forEach _list;
};
_return;