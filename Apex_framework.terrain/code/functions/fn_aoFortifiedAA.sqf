/*/
File: fn_aoFortifiedAA.sqf
Author: 

	Quiksilver

Last Modified:

	21/08/2022 A3 2.10 by Quiksilver

Description:

	Fortified AA Site
________________________________________________/*/
params ['_pos'];
_minRadius = (missionNamespace getVariable 'QS_aoSize') * 0.666;
private _newPos = _pos getPos [(_minRadius / 1.5),((markerPos 'QS_marker_base_marker') getDir _pos)];
private _multiplier = 0.75;
private _position = [worldSize,worldSize,0];
for '_x' from 0 to 29 step 1 do {
	_position = ['RADIUS',_newPos,(_minRadius * _multiplier),'LAND',[7,0,0.3,7.5,0,FALSE,objNull],FALSE,[],[],FALSE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
	if (
		(((missionNamespace getVariable 'QS_registeredPositions') inAreaArray [_position,75,75,0,FALSE]) isEqualTo []) && 
		{((((_position select [0,2]) nearRoads 25) select {((_x isEqualType objNull) && ((roadsConnectedTo _x) isNotEqualTo []))}) isEqualTo [])} && 
		{(!((toLowerANSI(surfaceType _position)) in ['#gdtasphalt']))} && 
		{(!([_position,30,8] call (missionNamespace getVariable 'QS_fnc_waterInRadius')))}
	) exitWith {};
	_multiplier = _multiplier + 0.05;
};
if (((_position distance2D _pos) > 3000) || {(_position isEqualTo [])}) exitWith {[]};
missionNamespace setVariable ['QS_registeredPositions',((missionNamespace getVariable 'QS_registeredPositions') + [_position]),FALSE];
private _return = [_position,(_position getDir (markerPos 'QS_marker_base_marker')),(call (missionNamespace getVariable 'QS_data_fortifiedAA')),TRUE] call (missionNamespace getVariable 'QS_fnc_serverObjectsMapper');
_return;