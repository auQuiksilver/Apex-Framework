/*/
File: fn_isValidCargoV.sqf
Author:

	Quiksilver
	
Last modified:

	11/10/2017 A3 1.76 by Quiksilver
	
Description:

	Is valid cargo vehicle
__________________________________________________/*/

params ['_parent','_child'];
private _c = FALSE;
if (isClass (configFile >> 'CfgVehicles' >> (typeOf _parent) >> 'VehicleTransport' >> 'Carrier')) then {
	if (vehicleCargoEnabled _parent) then {
		if ((_parent canVehicleCargo _child) isEqualTo [TRUE,TRUE]) then {
			_c = TRUE;
		};
	};
};
_c;