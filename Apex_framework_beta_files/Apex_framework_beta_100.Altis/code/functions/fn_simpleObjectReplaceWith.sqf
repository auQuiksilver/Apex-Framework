/*
File: fn_simpleObjectReplaceWith.sqf
Author: 

	Quiksilver
	
Last modified:

	2911/2016 ArmA 1.64 by Quiksilver
	
Description:

	Replace with Simple Object
__________________________________________________________________*/

/*
	Author: Jiri Wainar

	Description:
	Replaces object with simple object. Object must not contain any crew and must be placed on ground.

	Remarks:
	* Useful if you do not have access to simple object adjustment data - e.g. in case of unsupported/discontinued asset.
	* All official assets have the adjustment data defined in config.
	* Use with caution as this technique is not very clean - should not be used for many objects and definatelly not in MP games.

	Parameter(s):
	0: OBJECT - object that will be replaced by simple object
	1: BOOL - force super-simple object (default: false); true: super-simple object will be force, no type info or re-texturing is available, false: super-simple object is used unless re-texturing is possible

	Returns:
	OBJECT - simple object that replaced the simulated object

	Example:
	[_object:object] call BIS_fnc_replaceWithSimpleObject;

	See also:
	* bis_fnc_createSimpleObject
	* bis_fnc_replaceWithSimpleObject
	* bis_fnc_simpleObjectData
	* bis_fnc_exportCfgVehiclesSimpleObjectData
	* bis_fnc_diagMacrosSimpleObjectData
*/

params
[
	["_template",objNull,[objNull]],
	["_forceSuperSimple",false,[true]]
];

if (isNull _template || {count crew _template > 0}) exitWith {["[x] Template object (%1) must not be NULL and must not contain any crew!",_template] call bis_fnc_error;};

if (isSimpleObject _template) exitWith {["[x] Function was executed on simple object!"] call bis_fnc_error;};

private _class = typeOf _template;

if (_class == "") exitWith {["[x] Cannot retrieve classname!"] call bis_fnc_error;};

//scan simulated object
private _data = [_template] call QS_fnc_simpleObjectData;

//get world position, dir and vector up
//private _pos = getPosASL _template; _pos set [2, (_pos select 2) - (_data select 3)];
private _pos = getPosWorld _template;
private _dir = getDir _template;
private _vectorUp = vectorUp _template;

//delete simulated object
missionNamespace setVariable [
	'QS_analytics_entities_deleted',
	((missionNamespace getVariable ['QS_analytics_entities_deleted',0]) + 1),
	FALSE
];
deleteVehicle _template;

//create simple object
private _object = [_data,_pos,_dir,false,_forceSuperSimple] call QS_fnc_simpleObjectCreate;

//set position (to negate built-in auto-adjusting)
_object setPosWorld _pos;

//set vector up
_object setVectorUp _vectorUp;

_object;