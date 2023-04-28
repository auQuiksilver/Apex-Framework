/*/
File: fn_clientVehicleEventCargoUnloaded.sqf
Author:

	Quiksilver
	
Last Modified:

	18/04/2022 2.08 by Quiksilver
	
Description:

	Cargo Unloaded event
_______________________________________________________/*/

params ['_parentVehicle','_cargoVehicle'];
[_parentVehicle,TRUE,TRUE] call QS_fnc_updateCenterOfMass;