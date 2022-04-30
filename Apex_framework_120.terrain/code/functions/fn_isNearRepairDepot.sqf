/*/
File: fn_isNearRepairDepot.sqf
Author: 

	Quiksilver

Last Modified:

	14/04/2018 A3 1.82 by Quiksilver

Description:

	Is near repair depot
__________________________________________/*/

params ['_origin'];
private _return = FALSE;
if ((_origin isEqualType objNull) && {(isNull _origin)}) exitWith {
	_return;
};
_cameraOn = cameraOn;
_radius = 12;
private _list = _origin nearSupplies _radius;		//===== Alt syntax appears not to work:   _origin nearSupplies ['Land_RepairDepot_01_base_F',_radius];
if (_list isNotEqualTo []) then {
	{
		if ((_cameraOn distance2D _x) < _radius) then {
			if (!isSimpleObject _x) then {
				if (_x isKindOf 'Land_RepairDepot_01_base_F') then {
					if (!(_x getVariable ['QS_repairdepot_disable',FALSE])) then {
						if ((getRepairCargo _x) > 0) then {
							0 = [88,_x] remoteExec ['QS_fnc_remoteExec',_x,FALSE];
						};
						_return = TRUE;
					} else {
					
					};
				};
			};
		};
		if (_return) exitWith {};
	} forEach _list;
};
if (_return) exitWith {_return};
_list = nearestObjects [_origin,[],_radius,TRUE];
if (_list isNotEqualTo []) then {
	{
		if ((_cameraOn distance2D _x) < _radius) then {
			if (!isNull _x) then {
				if (isSimpleObject _x) then {
					if ((toLower ((getModelInfo _x) # 1)) in [
						'a3\structures_f_tank\military\repairdepot\repairdepot_01_civ_f.p3d',
						'a3\structures_f_tank\military\repairdepot\repairdepot_01_green_f.p3d',
						'a3\structures_f_tank\military\repairdepot\repairdepot_01_tan_f.p3d'
					]) then {
						if (!(_x getVariable ['QS_repairdepot_disable',FALSE])) then {
							_return = TRUE;
						};
					};
				};
			};
		};
		if (_return) exitWith {};
	} forEach _list;
};
_return;