/*/
File: fn_vTowable.sqf
Author:

	Quiksilver
	
Last modified:

	3/02/2023 A3 2.10 by Quiksilver
	
Description:

	Check if target is towable
__________________________________________________/*/
params ['_vehicle'];
if (
	(!isNull (ropeAttachedTo _vehicle)) ||
	{(!isNull (isVehicleCargo _vehicle))} ||
	{(!isNull (attachedTo _vehicle))} || 
	{((ropes _vehicle) isNotEqualTo [])}
) exitWith {FALSE};
_vehiclePos = getPos _vehicle;
_vehicleRearDir = ((getDir _vehicle) + 180) mod 360;
_vehicleHalfLength = ((0 boundingBoxReal _vehicle) # 1) # 1;
_findPos = [
	(_vehiclePos # 0) + 2 * _vehicleHalfLength * sin _vehicleRearDir,
	(_vehiclePos # 1) + 2 * _vehicleHalfLength * cos _vehicleRearDir,
	_vehiclePos # 2
];
_towableCargoObjects = ['towable_objects_3'] call QS_data_listVehicles;
_list1 = nearestObjects [_findPos,_towableCargoObjects,(2 * _vehicleHalfLength),TRUE];
_list2 = _findPos nearEntities [['LandVehicle','Ship','Air','Reammobox_F','StaticWeapon'],(2 * _vehicleHalfLength)];
(((_list1 + _list2) select {
	(
		(alive _x) && 
		{(simulationEnabled _x)} &&
		{(_x isNotEqualTo _vehicle)} && 
		{(!(_x in (attachedObjects _vehicle)))} &&
		{(!isObjectHidden _x)} &&
		{(isNull (ropeAttachedTo _x))} &&
		{(isNull (isVehicleCargo _x))} &&
		{(isNull (attachedTo _x))} &&
		{((ropes _x) isEqualTo [])} &&
		{([TRUE,_vehicle,_x] call QS_fnc_getCustomAttachPoint) isNotEqualTo [[0,-10,0],0]}
	)
}) isNotEqualTo []);