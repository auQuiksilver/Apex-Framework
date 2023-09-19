/*
File: fn_terrainGradAngle.sqf
Author:

	Quiksilver (credit: Petr Ondracek for BIS_fnc_terrainGradAngle)
	
Last modified:

	30/07/2016 A3 1.62 by Quiksilver
	
Description:

	Terrain Gradient Angle
__________________________________________________________________________*/

_pos0 = param [0,objNull,[objNull,[]]];
_delta = param [1,1.0,[0]];
_dir = param [2,0,[0]];
if (_pos0 isEqualType objNull) then {_pos0 = getPosASL _pos0};
if ((count _pos0) isEqualTo 2) then {
	_pos0 = [(_pos0 # 0),(_pos0 # 1),(getTerrainHeightASL _pos0)];
};
private _pos1 = _pos0 getPos [_delta,_dir]; 
_pos0 = getTerrainHeightASL [(_pos0 # 0),(_pos0 # 1)];
_pos1 = getTerrainHeightASL [(_pos1 # 0),(_pos1 # 1)];
(atan((_pos1-_pos0)/_delta));