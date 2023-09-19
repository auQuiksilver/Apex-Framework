/*/
File: fn_isNearVehicleRally.sqf
Author:

	Quiksilver
	
Last Modified:

	22/05/2023 A3 2.12 by Quiksilver
	
Description:

	Is vehicle rally nearby
___________________________________________________/*/

params ['_origin',['_rallyRadius',100]];
if (_origin isEqualType objNull) then {
	_origin = getPosASL _origin;
};
((((QS_system_vehicleRallyPoints apply { _x # 0 }) select {alive _x}) inAreaArray [ASLToAGL _origin,_rallyRadius,_rallyRadius,0,FALSE]) isNotEqualTo [])