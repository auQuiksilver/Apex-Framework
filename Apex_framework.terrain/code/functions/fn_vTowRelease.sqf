/*/
File: fn_vTowRelease.sqf
Author:
	
	Quiksilver
	
Last Modified:

	1/02/2023 A3 2.12 by Quiksilver
	
Description:

	Release towed vehicle
_____________________________________________________________/*/

params ['_vehicle'];
private _towedVehicle = objNull;
_attachedObjects = attachedObjects _vehicle;
{
	if (_x getVariable ['QS_attached',FALSE]) exitWith {
		_towedVehicle = _x;
	};
} count _attachedObjects;
if (isNull _towedVehicle) exitWith {
	player removeAction (missionNamespace getVariable 'QS_action_towRelease');
};
if (_towedVehicle call (missionNamespace getVariable 'QS_fnc_isBoundingBoxIntersected')) exitWith {
	(missionNamespace getVariable 'QS_managed_hints') pushBack [5,FALSE,5,-1,localize 'STR_QS_Hints_140',[],-1];
};
_line01 = lineIntersectsSurfaces [(AGLToASL (_vehicle modelToWorld [2,0,0])),(AGLToASL (_vehicle modelToWorld [2,-17,0])),_vehicle,_towedVehicle];
if (_line01 isNotEqualTo []) exitWith {
	(missionNamespace getVariable 'QS_managed_hints') pushBack [5,FALSE,5,-1,localize 'STR_QS_Hints_140',[],-1];
};
_line02 = lineIntersectsSurfaces [(AGLToASL (_vehicle modelToWorld [-2,0,0])),(AGLToASL (_vehicle modelToWorld [-1.5,-17,0])),_vehicle,_towedVehicle];
if (_line02 isNotEqualTo []) exitWith {
	(missionNamespace getVariable 'QS_managed_hints') pushBack [5,FALSE,5,-1,localize 'STR_QS_Hints_140',[],-1];
};
_line03 = lineIntersectsSurfaces [(AGLToASL (_vehicle modelToWorld [0,0,0])),(AGLToASL (_vehicle modelToWorld [0,-17,0])),_vehicle,_towedVehicle];
if (_line03 isNotEqualTo []) exitWith {
	(missionNamespace getVariable 'QS_managed_hints') pushBack [5,FALSE,5,-1,localize 'STR_QS_Hints_140',[],-1];
};
[0,_towedVehicle] call QS_fnc_eventAttach;
player removeAction (missionNamespace getVariable 'QS_action_towRelease');