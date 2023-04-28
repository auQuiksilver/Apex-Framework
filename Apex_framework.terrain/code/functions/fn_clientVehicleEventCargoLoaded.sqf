/*/
File: fn_clientVehicleEventCargoLoaded.sqf
Author:

	Quiksilver
	
Last Modified:

	18/04/2022 2.08 by Quiksilver
	
Description:

	Cargo Loaded event
_______________________________________________________/*/

params ['_parentVehicle','_cargoVehicle'];
if ((ropes _cargoVehicle) isNotEqualTo []) then {
	['ropeDestroy',ropes _cargoVehicle] remoteExecCall ['QS_fnc_remoteExecCmd',_cargoVehicle,FALSE];
};
[_parentVehicle,TRUE,TRUE] call QS_fnc_updateCenterOfMass;