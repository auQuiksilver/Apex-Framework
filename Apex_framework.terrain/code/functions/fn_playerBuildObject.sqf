/*/
File: fn_playerBuildObject.sqf
Author: 

	Quiksilver
	
Last modified:

	22/05/2023 A3 2.12 by Quiksilver
	
Description:

	Build object
______________________________________________/*/

params ['_class','_sim','_posASL','_vectors','_budget'];
private _object = objNull;
if (_sim isEqualTo 1) then {
	_object = createSimpleObject [_class,_posASL,FALSE];
};
if (_sim isEqualTo 2) then {
	_object = createVehicle [_class,[0,0,0]];
	_object setPosASL _posASL;
};
_object allowDamage FALSE;
_object setVectorDirAndUp _vectors;
_object;