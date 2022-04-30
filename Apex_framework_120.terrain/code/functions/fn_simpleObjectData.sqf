/*
File: fn_simpleObjectData.sqf
Author: 

	Quiksilver
	
Last modified:

	2911/2016 ArmA 1.64 by Quiksilver
	
Description:

	Get Simple Object Data
__________________________________________________________________*/

/*
	Author: Jiri Wainar

	Description:
	Get complete data needed for simple object creation.

	Parameter(s):
	0: STRING - classname of the object; data are retrieved from the config definition.
	   or
	   OBJECT - existing object or simple object that will be scanned; if it is a simple object '_reversed' attribute cannot be retrieved
	   or
	   STRING - path to the p3d; verifies and fixes model path format and returns it in an array (index 1). It has very limited functionality in this mode as no data can actually be retrieved from model path.

	Returns:
   	0: _class:string - asset CfgVehicles config class (default: "")
   	1: _model:string - path to the vehicle p3d model; needs to start without backslash and must end with the proper file extension ".p3d" (default: "")
   	2: _reversed:scalar - some objects, usually vehicles, are reveresed in p3d (default: 0); valid values are 0: no change, 1: reverse, -1: unknown (behaves as 0)
   	3: _verticalOffset:scalar - fix for non-existant physX; usually needed only for vehicles (default: 0)
   	4: _animationsAdjustments:array - animation that need to be animated to given state (default: []); every element has this format: [_animationName:string,_animationState:scalar]
   	5: _selectionsToHide:array - all listed selection will be hidden (default: [])
   	6: _verticalOffsetWorld:scalar - vertical offset in World coordinates; similar to ASL but refers to object [0,0,0], not its land contacts
   	7. _textures:array - textures applied to object

	Example:
	_data:array = [_vehicle:object] call BIS_fnc_simpleObjectData;
	_data:array = [_class:string] call BIS_fnc_simpleObjectData;

	See also:
	* bis_fnc_createSimpleObject
	* bis_fnc_replaceWithSimpleObject
	* bis_fnc_simpleObjectData
	* bis_fnc_exportCfgVehiclesSimpleObjectData
	* bis_fnc_diagMacrosSimpleObjectData
*/

#define SELECTIONS_TO_HIDE		["fireanim","brakelights","clan","dashboard","showdamage","damage","backlights","offlight","redlight","whitelight","hrotorstill","hrotormove","vrotorstill","vrotormove","rotorstill","rotormove"]
#define RETURN_VALUES			[_class,_model,_reversed,_verticalOffset,_animationsAdjustments,_selectionsToHide,_verticalOffsetWorld,_textures]
#define ROUND_DECIMALS(input,accuracy)	round((1/accuracy)*(input))*accuracy;

params
[
	["_input","",["",objNull]]
];

//set defaults
private _class = "";
private _model = "";
private _reversed = -1;
private _verticalOffset = 0;
private _verticalOffsetWorld = 0;
private _animationsAdjustments = [];
private _selectionsToHide = [];
private _textures = [];

if (_input isEqualType "" && {_input == ""}) exitWith {["[x] Input string (classname) cannot be an empty string!"] call bis_fnc_error; RETURN_VALUES};
if (_input isEqualType "" && {!isClass(configFile >> "CfgVehicles" >> _input)}) exitWith {["[x] Input string is not a valid classname!"] call bis_fnc_error; RETURN_VALUES};
if (_input isEqualType objNull && {isNull _input}) exitWith {["[x] Template object cannot be NULL!"] call bis_fnc_error; RETURN_VALUES};

if (_input isEqualType objNull) then
{
	//get class and model
	_class = typeOf _input;
	_model = (getModelInfo _input) select 1;

	//read config to get reversed state; doesn't work for simple object as they do not have config class
	if (_class != "" && {isNumber(configfile >> "CfgVehicles" >> _class >> "reversed")}) then {_reversed = getNumber(configfile >> "CfgVehicles" >> _class >> "reversed")};

	//calculate vertical offset fix
	_verticalOffset = ROUND_DECIMALS(((getPosWorld _input) select 2) - ((getPosASL _input) select 2) - ((getPosATL _input) select 2), 0.001);

	//get vertical turret animations
	private _turrets = if (_class != "") then {_class call bis_fnc_getTurrets} else {[]};

	//adjust animations on turrets to fix the turret elevation
	{
		private _anim = toLower _x;
		private _animState = ROUND_DECIMALS(_input animationPhase _anim, 0.01);

		//exclude animation with 'proxy' source
		private _source = getText(configfile >> "CfgVehicles" >> _class >> "AnimationSources" >> _anim >> "source");
		if (_source != "proxy" && {_source != "user"}) then
		{
			_animationsAdjustments pushBack [_anim,_animState];
		};
	}
	forEach (animationNames _input);

	//get object textures
	if (!isSimpleObject _input) then
	{
		_textures = getObjectTextures _input;
	};

	//hide unwanted selections
	_selectionsToHide = SELECTIONS_TO_HIDE arrayIntersect (selectionNames _input);

	if (_class != "") then
	{
		//process muzzle flashes
		private _muzzle = "";

		{
			_muzzle = toLower getText(_x >> "selectionFireAnim");
			if (_muzzle != "") then {_selectionsToHide pushBackUnique _muzzle;};
		}
		forEach _turrets;

		//process reflectors
		private _reflectors = configfile >> "CfgVehicles" >> _class >> "Reflectors";
		private _reflectorsCount = count _reflectors;

		if (_reflectorsCount > 0) then
		{
			for "_i" from 0 to (_reflectorsCount - 1) do
			{
				private _selection = toLower getText ((_reflectors select _i) >> "selection");
				if (_selection != "") then {_selectionsToHide pushBackUnique _selection};
			};
		};

		//process rotors and other selections
		{
			private _rotors = configfile >> "CfgVehicles" >> _class >> _x;

			if (!isNull _rotors) then
			{
				private _selection = toLower getText _rotors;
				if (_selection != "") then {_selectionsToHide pushBackUnique _selection};
			};
		}
		forEach
		[
			"selectionVRotorMove","selectionHRotorMove",
			"selectionBackLights","selectionBrakeLights",
			"selectionClan",
			"selectionDashboard",
			"selectionFireAnim",
			"selectionShowDamage"
		];
	};
}
else
{
	_class = _input;
	_model = getText(configfile >> "CfgVehicles" >> _class >> "model");
	_reversed = getNumber(configfile >> "CfgVehicles" >> _class >> "reversed");
	_textures = getArray(configfile >> "CfgVehicles" >> _class >> "hiddenSelectionsTextures");
	_verticalOffset = getNumber(configfile >> "CfgVehicles" >> _class >> "SimpleObject" >> "verticalOffset");
	_animationsAdjustments = getArray(configfile >> "CfgVehicles" >> _class >> "SimpleObject" >> "animate");
	_selectionsToHide = getArray(configfile >> "CfgVehicles" >> _class >> "SimpleObject" >> "hide");
	_verticalOffsetWorld = getNumber(configfile >> "CfgVehicles" >> _class >> "SimpleObject" >> "verticalOffsetWorld");

	//fix model path
	if (_model select [0,1] == "\") then
	{
		_model = _model select [1];
	};

	//add missing '.p3d' extension
	if ((_model select [count _model - 4,4]) != ".p3d") then
	{
		_model = _model + ".p3d";
	};
};

//["[ ] %1",RETURN_VALUES] call bis_fnc_logFormat;

RETURN_VALUES