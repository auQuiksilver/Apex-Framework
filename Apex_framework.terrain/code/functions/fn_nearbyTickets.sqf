/*/
File: fn_nearbyTickets.sqf
Author:

	Quiksilver
	
Last Modified:

	25/04/2023 A3 2.12 by Quiksilver
	
Description:

	Nearby Respawn Tickets for resupply
_____________________________________________________________________/*/

params [['_radius',30]];
private _target = objNull;
_list = QS_player nearEntities [['Air','LandVehicle','Ship','Reammobox_F','ThingX'],_radius];
{
	if (
		(alive _x) &&
		{((_x getVariable ['QS_medicalVehicle_reviveTickets',-1]) isNotEqualTo -1)} &&
		{(_x isNil 'QS_vehicle_isSuppliedFOB')}
	) exitWith {
		_target = _x;
	};
} forEach _list;
_target;