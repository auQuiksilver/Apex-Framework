/*/
File: fn_setVehicleCargo.sqf
Author:

	Quiksilver
	
Last Modified:
	
	19/04/2023 A3 2.12 by Quiksilver
	
Description:

	Can Vehicle Cargo
____________________________________________________/*/

params ['_parent','_child'];
private _result = _parent setVehicleCargo _child;
if (!_result) then {
	private _attachPoint = [TRUE,_parent,_child,-1] call QS_fnc_getCustomAttachPoint;
	if (_attachPoint isNotEqualTo -1) then {
		_result = TRUE;
		[1,_child,[_parent,_attachPoint # 0]] call QS_fnc_eventAttach;
		if (local _child) then {
			_child setDir (_attachPoint # 1);
		} else {
			['setDir',_child,(_attachPoint # 1)] remoteExec ['QS_fnc_remoteExecCmd',_child,FALSE];
		};
	};
};
_result;