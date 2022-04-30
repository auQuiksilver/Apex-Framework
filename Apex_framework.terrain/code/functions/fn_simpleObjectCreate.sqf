/*
File: fn_simpleObjectCreate.sqf
Author: 

	Quiksilver
	
Last modified:

	29/11/2016 ArmA 1.64 by Quiksilver
	
Description:

	Create Simple Object
__________________________________________________________________*/

/*
	Author: Jiri Wainar

	Description:
	Creates non-simulated framerate and network performance friendly object - a simple object - and applies different adjustments to fake non-existing physX and engine interactions. The adjustments need either to be stored in the object config or provided as the function input, otherwise they need to be done manually.

	Simple objects cannot be destroyed and do not interact with the environment. They are usefull for creation low performance demanding static compositions (walls, rocks, wrecks, ...) and/or environments where shooting and collisions are not expected.

	Parameter(s):
	0: STRING - classname of the object to be created. This is preffered way if the asset config definition contains the adjustment data or the data are not needed (most objects do not need adjustments).
	   or
	   ARRAY - creation data array; can be obtained by scanning the normal simulated object on scene with bis_fnc_simpleObjectData and then either added to the asset config or used straight away in the bis_fnc_createSimpleObject function.
	1: ARRAY - position; ASL coordinates if classname is known, World coordinates if using p3d only
	2: SCALAR - direction  (default: 0)
	3: BOOL - aligned to terrain (default: true); true: aligned to terrain, false: horizontal placement
	4: BOOL - force super-simple object (default: false); true: super-simple object will be force, no type info or re-texturing is available, false: super-simple object is used unless re-texturing is possible

	Returns:
	OBJECT - a simple object or objNull if creation failed

	Example:
	_simpleObject:object = [_class:string,_position:array(,_direction:scalar,_aligned:bool)] call bis_fnc_createSimpleObject;
	_simpleObject:object = [_model:string,_position:array(,_direction:scalar,_aligned:bool)] call bis_fnc_createSimpleObject;
	_simpleObject:object = [_data:array,_position:array(,_direction:scalar,_aligned:bool)] call bis_fnc_createSimpleObject;

	See also:
	* bis_fnc_createSimpleObject
	* bis_fnc_replaceWithSimpleObject
	* bis_fnc_simpleObjectData
	* bis_fnc_exportCfgVehiclesSimpleObjectData
	* bis_fnc_diagMacrosSimpleObjectData
*/

params
[
	["_input","",["",[]]],
	["_pos",[],[[]]],
	["_dir",0,[123]],
	["_aligned",true,[true]],
	["_forceSuperSimple",false,[true]]
];

if (_input isEqualType "" && {_input == ""}) exitWith {["[x] Simple object input is corrupted!"] call bis_fnc_error; objNull};
if (_input isEqualType [] && {count _input == 0}) exitWith {["[x] Simple object input is corrupted!"] call bis_fnc_error; objNull};
if (count _pos == 0) exitWith {["[x] Simple object position is mandatory (%1)!",_input] call bis_fnc_error; objNull};

/*--------------------------------------------------------------------------------------------------

	get data

--------------------------------------------------------------------------------------------------*/
private _data = if (_input isEqualType []) then
{
	_input
}
else
{
	[_input] call QS_fnc_simpleObjectData;
};

if (count _data == 0) exitWith {["[x] Simple object data could not be retrieved (%1)!",_input] call bis_fnc_error; objNull};


/*--------------------------------------------------------------------------------------------------

	create simple object

--------------------------------------------------------------------------------------------------*/
//get class & model
_data params
[
	["_class","",[""]],
	["_p3d","",[""]]
];

if (_class == "" && {_p3d == ""}) exitWith {["[x] Simple object data are corrupted, class or p3d is required (%1)!",_input] call bis_fnc_error; objNull};

private _superSimple = _class == "" || {_forceSuperSimple};

//create simple object
private _object = if (_superSimple) then
{
	//World coords are used
	missionNamespace setVariable [
		'QS_analytics_entities_created',
		((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
		FALSE
	];
	createSimpleObject [_p3d,_pos];
}
else
{
	//ASL coords are used; fixed later by ASL to World offset
	missionNamespace setVariable [
		'QS_analytics_entities_created',
		((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
		FALSE
	];
	createSimpleObject [_class,_pos];
};

if (isNull _object) exitWith {["[x] Simple object creation failed (%1)!",_input] call bis_fnc_error; objNull};

//update direction
_object setDir _dir;

/*--------------------------------------------------------------------------------------------------

	fix simple object vertical offset, animations and selections

--------------------------------------------------------------------------------------------------*/
if (_superSimple) then
{
	[_object,_data] call QS_fnc_simpleObjectAdjust;
};

//align to terrain
if (_aligned) then
{
	_object setVectorUp (surfaceNormal _pos);
}
else
{
	_object setVectorUp [0,0,1];
};

/*--------------------------------------------------------------------------------------------------

	return simple object

--------------------------------------------------------------------------------------------------*/
_object;