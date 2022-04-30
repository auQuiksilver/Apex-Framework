/*
File: fn_vTowing.sqf
Author:

	Quiksilver
	
Last Modified:

	20/03/2016 A3 1.56 by Quiksilver
	
Description:

	-
__________________________________________________________________*/

private [
	'_vehicle','_vel','_velPost','_getMass','_getCMass','_towedVehicle'
];
_vehicle = _this select 0;
_towedVehicle = _this select 1;
_getMass = getMass _vehicle;
_getCMass = getCenterOfMass _vehicle;
_vehicle setMass (_getMass + (getMass _towedVehicle));
_vehicle setCenterOfMass [(_getCMass select 0),-1,((_getCMass select 2) * 0.95)];
for '_x' from 0 to 1 step 0 do {
	if (!(_vehicle getVariable 'QS_ropeAttached')) exitWith {};
	uiSleep 0.1;
};
_vehicle setMass _getMass;
_vehicle setCenterOfMass _getCMass;