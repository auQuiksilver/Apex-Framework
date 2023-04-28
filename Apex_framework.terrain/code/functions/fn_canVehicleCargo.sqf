/*/
File: fn_getDoor.sqf
Author:

	Quiksilver
	
Last Modified:
	
	19/04/2023 A3 2.12 by Quiksilver
	
Description:

	Can Vehicle Cargo
____________________________________________________/*/

params ['_parent','_child'];
private _result = _parent canVehicleCargo _child;
_result params ['_canCurrent','_canEmpty'];
if (!_canEmpty) then {
	private _attachPoint = [TRUE,_parent,_child,-1] call QS_fnc_getCustomAttachPoint;
	if (_attachPoint isNotEqualTo -1) then {
		_result = [
			(((attachedObjects _parent) select {!isSimpleObject _x}) isEqualTo []),		// Only allow custom if the parent is empty, could be improved in the future
			TRUE
		];
	};
};
_result;