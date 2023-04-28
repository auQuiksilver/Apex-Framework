/*/
File: fn_logisticsMovementDisallowed.sqf
Author:

	Quiksilver
	
Last Modified:

	13/02/2023 A3 2.12 by Quiksilver
	
Description:

	Disallow movement (carry/drag/load) of an object if this function returns true
	
	For instance a player should not be able to pick up a Sandbag (Fortification) if there is another player taking cover behind it
___________________________________________/*/

params ['_object',['_mode',0],['_unitRadius',-1]];
_simulation = QS_hashmap_configfile getOrDefaultCall [
	format ['cfgvehicles_%1_simulation',toLowerANSI (typeOf _object)],
	{toLowerANSI (getText ((configOf _object) >> 'simulation'))},
	TRUE
];
(0 boundingBoxReal _object) params ['_p1','_p2','_radius'];
if (_unitRadius isEqualTo -1) then {
	_unitRadius = (selectMax [(abs ((_p2 # 0) - (_p1 # 0))),(abs ((_p2 # 1) - (_p1 # 1))),(abs ((_p2 # 2) - (_p1 # 2)))]) * 3;
};
if (_mode isEqualTo 0) exitWith {
	(
		(_simulation in ['house']) &&
		{(isNull (attachedTo _object))} &&
		{(isNull (isVehicleCargo _object))} &&
		{((((_object nearEntities ['CAManBase',_unitRadius]) select {alive _x}) - [cameraOn]) isNotEqualTo [])}
	)
};
if (_mode isEqualTo 1) exitWith {
	(
		(!(_object getVariable ['QS_logistics',FALSE])) ||
		{(!simulationEnabled _object)}
	)
};