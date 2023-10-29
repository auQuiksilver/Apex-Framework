/*/
File: fn_getAllAttached.sqf
Author:

	Quiksilver
	
Last Modified:
	
	28/10/2023 A3 2.14 by Quiksilver
	
Description:

	Get All Attached including sub-attached
____________________________________________________/*/

params ['_obj'];
private _attachedObjs = attachedObjects _obj;
{
	_attachedObjs = _attachedObjs + ([_x] call QS_fnc_getAllAttached);
} forEach _attachedObjs;
_attachedObjs;