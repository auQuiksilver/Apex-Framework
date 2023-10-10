/*/
File: fn_isNearVehicleRally.sqf
Author:

	Quiksilver
	
Last Modified:

	9/10/2023 A3 2.14 by Quiksilver
	
Description:

	Is vehicle rally nearby
___________________________________________________/*/

params ['_origin',['_rallyRadius',100]];
((((QS_system_vehicleRallyPoints apply { _x # 0 }) select {alive _x}) inAreaArray [_origin,_rallyRadius,_rallyRadius,0,FALSE]) isNotEqualTo [])