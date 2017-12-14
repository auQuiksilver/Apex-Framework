/*
File: fn_simpleObjectAdjust.sqf
Author: 

	Quiksilver
	
Last modified:

	2911/2016 ArmA 1.64 by Quiksilver
	
Description:

	Adjust Simple Object
__________________________________________________________________*/

/*
	Author: Jiri Wainar

	Description:
	Adjust simple object vertical position, animations and selection according to provided data.

	Remarks:
	Function is automatically called by bis_fnc_createSimpleObject. In case both adjustment data and class are being used, data has higher priority and only undefined parts are filled from config.

	Parameter(s):
	0: OBJECT - simple object that will be adjusted
	1: ARRAY - adjustment data
	   or
	   STRING - classname that is used to determine adjustment data

	Returns:
	-

	Example:
	[_simpleObject:object(,_data:array/string)] call BIS_fnc_adjustSimpleObject;

	See also:
	* bis_fnc_createSimpleObject
	* bis_fnc_replaceWithSimpleObject
	* bis_fnc_simpleObjectData
	* bis_fnc_exportCfgVehiclesSimpleObjectData
	* bis_fnc_diagMacrosSimpleObjectData

*/

params
[
	["_object",objNull,[objNull]],
	["_data",[],["",[]]]
];

if (_data isEqualType "") then {_data = [_data] call QS_fnc_simpleObjectData;};

//temp hotfix for testing !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//_data = + ["B_MRAP_01_hmg_F","a3\soft_f\mrap_01\mrap_01_hmg_f.p3d",1,2.58154,[["damagehide",0],["damagehidevez",0],["damagehidehlaven",0],["wheel_1_1_destruct",0],["wheel_1_2_destruct",0],["wheel_1_3_destruct",0],["wheel_1_4_destruct",0],["wheel_2_1_destruct",0],["wheel_2_2_destruct",0],["wheel_2_3_destruct",0],["wheel_2_4_destruct",0],["wheel_1_1_destruct_unhide",0],["wheel_1_2_destruct_unhide",0],["wheel_1_3_destruct_unhide",0],["wheel_1_4_destruct_unhide",0],["wheel_2_1_destruct_unhide",0],["wheel_2_2_destruct_unhide",0],["wheel_2_3_destruct_unhide",0],["wheel_2_4_destruct_unhide",0],["wheel_1_3_damage",0],["wheel_1_4_damage",0],["wheel_2_3_damage",0],["wheel_2_4_damage",0],["wheel_1_3_damper_damage_backanim",0],["wheel_1_4_damper_damage_backanim",0],["wheel_2_3_damper_damage_backanim",0],["wheel_2_4_damper_damage_backanim",0],["glass1_destruct",0],["glass2_destruct",0],["glass3_destruct",0],["glass4_destruct",0],["glass5_destruct",0],["glass6_destruct",0],["fuel",1],["wheel_1_1",0],["wheel_2_1",0],["wheel_1_2",0],["wheel_2_2",0],["wheel_1_1_damper",0.4957],["wheel_2_1_damper",0.5271],["wheel_1_2_damper",0.482],["wheel_2_2_damper",0.5366],["daylights",0],["pedal_thrust",0],["pedal_brake",1],["wheel_1_1_damage",0],["wheel_1_2_damage",0],["wheel_2_1_damage",0],["wheel_2_2_damage",0],["wheel_1_1_damper_damage_backanim",0],["wheel_1_2_damper_damage_backanim",0],["wheel_2_1_damper_damage_backanim",0],["wheel_2_2_damper_damage_backanim",0],["drivingwheel",0],["steering_1_1",0],["steering_2_1",0],["indicatorspeed",0],["indicatorfuel",1],["indicatorrpm",0],["indicatortemp",0],["indicatortemp_move",0],["indicatortemp2",0],["indicatortemp2_move",0],["reverse_light",0],["door_lf",0],["door_rf",0],["door_lb",0],["door_rb",0],["mainturret",0],["maingun",0],["damagehlaven",0],["mg_muzzle",0],["zaslehrot",0]],["clan","zasleh","light_l","light_r","light_r2","light_l2","zadni svetlo","brzdove svetlo","podsvit pristroju","poskozeni"],-0.0240173,["a3\soft_f\mrap_01\data\mrap_01_base_co.paa","a3\soft_f\mrap_01\data\mrap_01_adds_co.paa","a3\data_f\vehicles\turret_co.paa"]];

private _class 	  	 = _data param [0, "", [""]];
private _reversed 	 = _data param [2, -1, [123]];
private _offset	  	 = _data param [3, 0, [123]];
private _animate  	 = _data param [4, [], [[]]];
private _hide 	  	 = _data param [5, [], [[]]];
private _offsetWorld = _data param [6, 0, [123]];
private _textures 	 = _data param [7, [], [[]]];

//animate
{
	//["[ ] anim: %1 | state: %2",_x select 0, _x select 1] call bis_fnc_logFormat; sleep 1;

	_object animate [_x select 0, _x select 1, true];
}
forEach _animate;

//adjust vertical placement
private _pos = getPosWorld _object;
private _posVert = _pos select 2;

if (_class != "") then
{
	_pos set [2,_posVert + _offset];
	_object setPosWorld _pos;
};

//hide selections
{
	//["[ ][%1] hiding selection: %2",_object,_x] call bis_fnc_logFormat; sleep 1;

	_object hideSelection [_x, true];
}
forEach _hide;

//apply textures
{
	_object setObjectTextureGlobal [_forEachIndex,_x];
}
forEach _textures;

//flip simple object if necessary
private _vectorDir = vectorDirVisual _object;

if (_reversed == 1) then
{
	_object setVectorDir [-(_vectorDir select 0),-(_vectorDir select 1),-(_vectorDir select 2)];
}
else
{
	_object setVectorDir [(_vectorDir select 0),(_vectorDir select 1),(_vectorDir select 2)];
};