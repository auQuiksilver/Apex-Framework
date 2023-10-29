/*/
File: fn_eventAttach.sqf
Author:
	
	Quiksilver
	
Last Modified:

	26/10/2023 A3 2.14 by Quiksilver
	
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

_mode1 = param [0,0];
if (_mode1 isEqualTo 0) exitWith {
	_child1 = param [1,objNull];
	_parent1 = attachedTo _child1;
	detach _child1;
	if (!isNull _parent1) then {
		if (
			(_parent1 isKindOf 'LandVehicle') ||
			(_parent1 isKindOf 'Ship')
		) then {
			[_parent1,TRUE,TRUE] call QS_fnc_updateCenterOfMass;
		};
	};
};
if (_mode1 isEqualTo 1) exitWith {
	_child1 = param [1,objNull];
	_attachParams1 = param [2,[]];
	_parent1 = _attachParams1 # 0;
	_child1 attachTo _attachParams1;
	if (!isNull _parent1) then {
		if (
			(_parent1 isKindOf 'LandVehicle') ||
			(_parent1 isKindOf 'Ship')
		) then {
			[_parent1,TRUE,TRUE] call QS_fnc_updateCenterOfMass;
		};
	};
};