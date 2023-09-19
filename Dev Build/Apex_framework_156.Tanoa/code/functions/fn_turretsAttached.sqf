/*/
File: fn_turretsAttached.sqf
Author:
	
	Quiksilver
	
Last Modified:

	8/04/2023 A3 2.12 by Quiksilver
	
Description:

	Return list of AI turrets attached to a parent object.
_______________________________________/*/

params ['_entity'];
_attached = attachedObjects _entity;
_attached = _attached select {
	(
		(unitIsUav _x) &&
		{(alive _x)} &&
		{(simulationEnabled _x)} &&
		{(_x getVariable ['QS_uav_toggleEnabled',TRUE])} &&
		{(!isObjectHidden _x)}
	)
};
_attached;