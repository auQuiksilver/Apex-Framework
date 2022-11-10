/*/
File: fn_getRadialPositions.sqf
Author:

	Quiksilver
	
Last Modified:

	5/11/2022 A3 2.10 by Quiksilver
	
Description:

	Get radial positions around a reference position
__________________________________________/*/

params [['_origin',objNull],['_radius',100],['_number',3],['_direction',0],['_reverse',FALSE]];
private _radialPositions = [];
_radius = _radius max 25;
_number = _number max 2;
_increment = 360 / _number;
for '_i' from 0 to (_number - 1) step 1 do {
	_radialPositions pushBack (_origin getPos [_radius,_direction + _increment]);
	_direction = _direction + _increment;
};
if (_reverse) then {
	reverse _radialPositions;
};
_radialPositions;