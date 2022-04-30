/*/
File: fn_aoFortifiedAA.sqf
Author: 

	Quiksilver

Last Modified:

	1/05/2017 A3 1.68 by Quiksilver

Description:

	Fortified AA Site
____________________________________________________________________________/*/
params ['_pos','_type'];
private ['_position','_return','_newPos','_multiplier'];
_minRadius = (missionNamespace getVariable 'QS_aoSize') * 0.666;
_newPos = _pos getPos [(_minRadius / 1.5),((markerPos 'QS_marker_base_marker') getDir _pos)];
_multiplier = 0.75;
for '_x' from 0 to 29 step 1 do {
	_position = ['RADIUS',_newPos,(_minRadius * _multiplier),'LAND',[7,0,0.3,7.5,0,FALSE,objNull],FALSE,[],[],FALSE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
	if ((((missionNamespace getVariable 'QS_registeredPositions') findIf {((_position distance2D _x) < 75)}) isEqualTo -1) && ((((_position select [0,2]) nearRoads 25) select {((_x isEqualType objNull) && ((roadsConnectedTo _x) isNotEqualTo []))}) isEqualTo []) && (!((toLower(surfaceType _position)) in ['#gdtasphalt'])) && (!([_position,30,8] call (missionNamespace getVariable 'QS_fnc_waterInRadius')))) exitWith {};
	_multiplier = _multiplier + 0.05;
};
if (((_position distance2D _pos) > 3000) || {(_position isEqualTo [])}) exitWith {[]};
missionNamespace setVariable ['QS_registeredPositions',((missionNamespace getVariable 'QS_registeredPositions') + [_position]),FALSE];
_return = [_position,(_position getDir (markerPos 'QS_marker_base_marker')),(call (missionNamespace getVariable 'QS_data_fortifiedAA')),TRUE] call (missionNamespace getVariable 'QS_fnc_serverObjectsMapper');
_return;