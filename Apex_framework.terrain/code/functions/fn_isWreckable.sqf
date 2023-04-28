/*
File: fn_isWreckable.sqf
Author:
	
	Quiksilver
	
Last Modified:

	25/03/2023 A3 2.12 by Quiksilver

Description:

	Is vehicle wreckable
_____________________________________________*/

params ['_vehicle',['_canWreck',FALSE]];
private _return = _canWreck;
if (!_return) then {
	_return = _vehicle getVariable ['QS_logistics_wreckable',FALSE];
};
_return;