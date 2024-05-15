/*/
File: fn_vehicleGetCost.sqf
Author:
	
	Quiksilver
	
Last Modified:

	2/12/2023 A3 2.14 by Quiksilver
	
Description:

	Vehicle Cost getter
______________________________________________________/*/

params ['_class'];
private _cost = 0;
private _minCost = 0;
if (_class isEqualType objNull) then {
	_class = toLowerANSI (typeOf _class);	
};
_class = QS_core_vehicles_map getOrDefault [toLowerANSI _class,_class];
_cost = QS_hashmap_vehicleCostTable getOrDefault [toLowerANSI _class,-1];
if (_cost isEqualTo -1) then {
	private _defaultTable = call QS_data_vehicleCostTableDefault;
	{
		if (_class isKindOf (_x # 0)) exitWith {
			_cost = _x # 1;
		};
	} forEach _defaultTable;
};
(_cost max _minCost)