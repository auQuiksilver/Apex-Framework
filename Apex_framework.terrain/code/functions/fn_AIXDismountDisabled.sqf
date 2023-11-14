/*/
File: fn_AIXDismountDisabled.sqf
Author:

	Quiksilver
	
Last modified:

	18/11/2017 A3 1.76 by Quiksilver
	
Description:

	AI Dismount disabled vehicle
__________________________________________________/*/

params ['_vehicle','','_unit',''];
if (!(canMove _vehicle)) then {
	_movePos = _vehicle getRelPos [(20 + (random 20)),(150 + (random 60))];
	if (!(surfaceIsWater _movePos)) then {
		doStop _unit;
		_unit doMove _movePos;
	};
	_unit setUnitPos (selectRandom ['Up','Middle']);
};