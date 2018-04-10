/*/
File: fn_enemySides.sqf
Author:

	Quiksilver

Last Modified:

	17/03/2018 A3 1.82 by Quiksilver
	
Description:

	Returns sides enemy to the given side / object
________________________________________________________/*/

_side = param [0, objNull];
if (_side isEqualType objNull) then {_side = side (group _side);};
([EAST,WEST,RESISTANCE,CIVILIAN] select {((_side getFriend _x) < 0.6)});