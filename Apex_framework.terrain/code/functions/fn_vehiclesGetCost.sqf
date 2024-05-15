/*/
File: fn_vehiclesGetCost.sqf
Author:
	
	Quiksilver
	
Last Modified:

	2/12/2023 A3 2.14 by Quiksilver
	
Description:

	Vehicle Cost getter
______________________________________________________/*/

params ['_list'];
private _totalCost = 0;
{
	_totalCost = _totalCost + ([_x] call QS_fnc_vehicleGetCost);
} forEach _list;
_totalCost;