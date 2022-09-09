/*/
File: fn_isValidCargoV.sqf
Author:

	Quiksilver
	
Last modified:

	4/09/2022 A3 2.10 by Quiksilver
	
Description:

	Is valid cargo vehicle
__________________________________________________/*/

params ['_parent','_child'];
(
	(vehicleCargoEnabled _parent) &&
	{((_parent canVehicleCargo _child) isEqualTo [TRUE,TRUE])} &&
	{(isClass (configFile >> 'CfgVehicles' >> (typeOf _parent) >> 'VehicleTransport' >> 'Carrier'))}
);