/*/
File: fn_inAnyZone.sqf
Author:

	Quiksilver
	
Last Modified:

	3/04/2023 A3 2.12 by Quiksilver
	
Description:

	Is entity in any zone
____________________________________________/*/

params ['_entity'];
private _zones = _entity getVariable ['QS_unit_zones',[]];
if (_zones isEqualTo []) then {
	_zones = ['GET',_entity,QS_system_zones + QS_system_zonesLocal] call QS_fnc_zoneManager;
};
(_zones isNotEqualTo [])