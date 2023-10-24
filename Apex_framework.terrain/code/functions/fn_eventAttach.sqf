/*/
File: fn_eventAttach.sqf
Author:
	
	Quiksilver
	
Last Modified:

	13/10/2023 A3 2.14 by Quiksilver
	
Description:

	Attach/Detach Scripted Event Handler
	
Notes:

	https://community.bistudio.com/wiki/attachTo
	https://community.bistudio.com/wiki/detach
	https://community.bistudio.com/wiki/attachedTo
	https://community.bistudio.com/wiki/attachedObjects
	https://community.bistudio.com/wiki/getRelPos

Example:

	Detach: [0, _child] call QS_fnc_eventAttach;
	Attach: [1, _child, [_parent,[0,0,0]]] call QS_fnc_eventAttach;
______________________________________________________/*/

_mode = param [0,0];
if (_mode isEqualTo 0) exitWith {
	_child = param [1,objNull];
	_parent = attachedTo _child;
	detach _child;
	if (!isNull _parent) then {
		if (
			(_parent isKindOf 'LandVehicle') ||
			(_parent isKindOf 'Ship')
		) then {
			[_parent,TRUE,TRUE] call QS_fnc_updateCenterOfMass;
		};
	};
};
if (_mode isEqualTo 1) exitWith {
	_child = param [1,objNull];
	_attachParams = param [2,[]];
	_parent = _attachParams # 0;
	_child attachTo _attachParams;
	if (!isNull _parent) then {
		if (
			(_parent isKindOf 'LandVehicle') ||
			(_parent isKindOf 'Ship')
		) then {
			[_parent,TRUE,TRUE] call QS_fnc_updateCenterOfMass;
		};
	};
};