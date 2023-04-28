/*/
File: fn_isTurretInAttached.sqf
Author:
	
	Quiksilver
	
Last Modified:

	8/04/2023 A3 2.12 by Quiksilver
	
Description:

	Is there an AI turret in entities attached to parent entity
________________________________________/*/

params ['_entity'];
_attached = attachedObjects _entity;
private _return = FALSE;
{
	if (
		(alive _x) &&
		{(unitIsUav _x)} &&
		{(!isObjectHidden _x)} &&
		{(simulationEnabled _x)} &&
		{(_x getVariable ['QS_uav_toggleEnabled',TRUE])}
	) exitWith {
		_return = TRUE;
	};
} forEach _attached;
_return;