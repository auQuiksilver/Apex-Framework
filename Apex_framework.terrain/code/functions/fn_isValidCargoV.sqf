/*/
File: fn_isValidCargoV.sqf
Author:

	Quiksilver
	
Last modified:

	22/12/2022 A3 2.10 by Quiksilver
	
Description:

	Is valid cargo vehicle
__________________________________________________/*/

params ['_parent','_child'];
(
	(vehicleCargoEnabled _parent) &&
	{(([_parent,_child] call QS_fnc_canVehicleCargo) isEqualTo [TRUE,TRUE])} &&
	{((ropeAttachedObjects _child) isEqualTo [])} &&
	{
		_isClass = QS_hashmap_configfile getOrDefaultCall [
			format ['cfgvehicles_%1_carrier',toLowerANSI (typeOf _parent)],
			{isClass ((configOf _parent) >> 'VehicleTransport' >> 'Carrier')},
			TRUE
		];
		_isClass
	}
);