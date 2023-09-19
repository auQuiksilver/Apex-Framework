/*/
File: fn_getNearestBuilding.sqf
Author:

	Quiksilver

Last Modified:

	1/06/2022 A3 2.10 by Quiksilver
	
Description:

	Return nearest building and number of building positions
________________________________________________________/*/

params [
	'_position',
	['_radius',100]
];
private _buildings = [];
private _building = objNull;
private _return = [objNull,0];
private _exit = FALSE;
private _i = 0;
if ( (missionNamespace getVariable ['QS_AI_hostileBuildings',[]]) isNotEqualTo [] ) then {
	_hostileBuildings = missionNamespace getVariable ['QS_AI_hostileBuildings',[]];
	{
		if ((!(isObjectHidden _x)) && ((_position distance2D _x) < _radius)) exitWith {
			_exit = TRUE;
			_building = _x;
			_i = (count ([_building,(_building buildingPos -1)] call (missionNamespace getVariable 'QS_fnc_customBuildingPositions'))) - 1;
		};
	} forEach _hostileBuildings;
};
if (_exit) exitWith {
	[_building,_i]
};
_buildingClass = ['House','Building'];
_buildings = (nearestObjects [_position,_buildingClass,_radius,TRUE]) select {(((_x buildingPos -1) isNotEqualTo []) && (!(isObjectHidden _x)))};
if (_buildings isEqualTo []) then {
	_building = nearestBuilding _position;
	if (isObjectHidden _building) then {
		_building = objNull;
	};
} else {
	_building = _buildings # 0;
};
if (!isNull _building) then {
	_buildingPositions = [_building,(_building buildingPos -1)] call (missionNamespace getVariable 'QS_fnc_customBuildingPositions');
	_i = (count _buildingPositions) - 1;
	_return = [_building,_i];
};
_return;