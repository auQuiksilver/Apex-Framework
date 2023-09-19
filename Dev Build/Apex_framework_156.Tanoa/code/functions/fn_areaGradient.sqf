/*
File: fn_areaGradient.sqf
Author: 

	Quiksilver

Last Modified:

	14/01/2019 A3 1.88 by Quiksilver

Description:

	Area Gradient
________________________________________________*/

params ['_position','_area'];
private _return = 0;
private _array_gradient = [];
{
	0 = _array_gradient pushBack ([_position,_area,_x] call (missionNamespace getVariable 'QS_fnc_terrainGradAngle'));
} count [0,45,90,135,180,225,270,315];
{
	if (_x < 0) then {
		_return = _return + (0 - _x);
	} else {
		_return = _return + _x;
	};
} forEach _array_gradient;
(_return / (count _array_gradient));