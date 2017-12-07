/*/
File: fn_getNearestBuilding.sqf
Author:

	Quiksilver

Last Modified:

	21/10/2017 A3 1.76 by Quiksilver
	
Description:

	Return nearest building and number of building positions
________________________________________________________/*/

_position = getPosATL (_this select 0);
_radius = param [1,100];
private _building = objNull;
private _return = [objNull,0];
_buildingClass = ['House','Building'];
_buildings = nearestObjects [_position,_buildingClass,_radius];
if (_buildings isEqualTo []) then {
	_building = nearestBuilding _position;
} else {
	_building = _buildings select 0;
	/*/get closest building/*/
};
if (!isNull _building) then {
	_buildingPositions = [_building,(_building buildingPos -1)] call (missionNamespace getVariable 'QS_fnc_customBuildingPositions');
	_i = (count _buildingPositions) - 1;
	_return = [_building,_i];
};
_return;