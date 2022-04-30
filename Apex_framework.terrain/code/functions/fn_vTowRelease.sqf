/*/
File: fn_vTowRelease.sqf
Author:
	
	Quiksilver
	
Last Modified:

	20/03/2016 A3 1.56 by Quiksilver
	
Description:

	Release towed vehicle
_____________________________________________________________/*/

params ['_vehicle'];
_towedVehicle = objNull;
_attachedObjects = attachedObjects _vehicle;
{
	if (_x getVariable ['QS_ropeAttached',FALSE]) exitWith {
		_towedVehicle = _x;
	};
} count _attachedObjects;
if (isNull _towedVehicle) exitWith {
	player removeAction (missionNamespace getVariable 'QS_action_towRelease');
	_vehicle setVariable ['QS_ropeAttached',FALSE,TRUE];
};
if (_towedVehicle call (missionNamespace getVariable 'QS_fnc_isBoundingBoxIntersected')) exitWith {
	(missionNamespace getVariable 'QS_managed_hints') pushBack [5,FALSE,5,-1,'Obstructions detected! Please release elsewhere.',[],-1];
};
_line01 = lineIntersectsSurfaces [(AGLToASL (_vehicle modelToWorld [2,0,0])),(AGLToASL (_vehicle modelToWorld [2,-17,0])),_vehicle,_towedVehicle];
if (!(_line01 isEqualTo [])) exitWith {
	(missionNamespace getVariable 'QS_managed_hints') pushBack [5,FALSE,5,-1,'Obstructions detected! Please release elsewhere.',[],-1];
};
_line02 = lineIntersectsSurfaces [(AGLToASL (_vehicle modelToWorld [-2,0,0])),(AGLToASL (_vehicle modelToWorld [-1.5,-17,0])),_vehicle,_towedVehicle];
if (!(_line02 isEqualTo [])) exitWith {
	(missionNamespace getVariable 'QS_managed_hints') pushBack [5,FALSE,5,-1,'Obstructions detected! Please release elsewhere.',[],-1];
};
_line03 = lineIntersectsSurfaces [(AGLToASL (_vehicle modelToWorld [0,0,0])),(AGLToASL (_vehicle modelToWorld [0,-17,0])),_vehicle,_towedVehicle];
if (!(_line03 isEqualTo [])) exitWith {
	(missionNamespace getVariable 'QS_managed_hints') pushBack [5,FALSE,5,-1,'Obstructions detected! Please release elsewhere.',[],-1];
};
player removeAction (missionNamespace getVariable 'QS_action_towRelease');
_vehicle setVariable ['QS_ropeAttached',FALSE,TRUE];