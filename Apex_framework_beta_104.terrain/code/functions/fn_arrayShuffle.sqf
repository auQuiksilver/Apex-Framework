/*
	Author: 
		Nelson Duarte, optimised by Killzone_Kid
	
	Description:
		This returns a new array with randomized order of elements from input array
	
	Parameters:
		_this: ARRAY
	
	Returns:
		ARRAY
	
	Example:
	[1, 2, 3] call BIS_fnc_arrayShuffle
	Returns: [2, 3, 1] (For example)
*/

_this = +_this;
private _cnt = count _this;
for '_i' from 1 to _cnt do {
	_this pushBack (_this deleteAt floor random _cnt);
};
_this;