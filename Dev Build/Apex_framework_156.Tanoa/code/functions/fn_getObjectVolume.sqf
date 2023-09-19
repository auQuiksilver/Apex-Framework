/*
File: fn_getObjectVolume.sqf
Author: 

	Quiksilver
	
Last modified:

	27/05/2023 A3 2.12 by Quiksilver
	
Description:

	Get Volume of an objects bounding box
___________________________________________________*/

params ['_object'];
if (isNull _object) exitWith {0};
if ((_object getVariable ['QS_logistics_objvol',-1]) isNotEqualTo -1) exitWith {(_object getVariable ['QS_logistics_objvol',-1])};
(0 boundingBoxReal _object) params ['_min','_max',''];
(_max vectorDiff _min) params ['_dimX','_dimY','_dimZ'];
(abs (_dimX * _dimY * _dimZ))