/*/
File: fn_aoHQ.sqf
Author: 

	Quiksilver

Last Modified:

	8/11/2017 A3 1.76 by Quiksilver

Description:

	Spawn AO HQ sub objective
____________________________________________________________________________/*/

private [
	'_pos','_hqSelect','_hqArray','_roughPos1','_boxArray','_position1'
];
_pos = _this select 0;
_hqArray = missionNamespace getVariable 'QS_hqArray';
_hqSelect = selectRandom _hqArray;
_hqIndex = _hqArray find _hqSelect;
for '_x' from 0 to 49 step 1 do {
	_position1 = ['RADIUS',_pos,((missionNamespace getVariable 'QS_aoSize') * 0.75),'LAND',[12.5,0,0.3,20,0,FALSE,objNull],FALSE,[],[],TRUE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
	if (!([_position1,25,8] call (missionNamespace getVariable 'QS_fnc_waterInRadius'))) exitWith {};
};
missionNamespace setVariable ['QS_HQpos',_position1,TRUE];
_roughPos1 = [(((missionNamespace getVariable 'QS_HQpos') select 0) - 150) + (random 300),(((missionNamespace getVariable 'QS_HQpos') select 1) - 150) + (random 300),0];
{
	_x setMarkerPos _roughPos1;
} count ['QS_marker_hqMarker','QS_marker_hqCircle'];
missionNamespace setVariable ['QS_registeredPositions',((missionNamespace getVariable 'QS_registeredPositions') + [(missionNamespace getVariable 'QS_HQpos')]),FALSE];
missionNamespace setVariable [
	'QS_aoHQ',
	([(missionNamespace getVariable 'QS_HQpos'),0,(call _hqSelect),TRUE] call (missionNamespace getVariable 'QS_fnc_serverObjectsMapper')),
	FALSE
];
diag_log format ['***** QS * Used HQ Composition Index: %1 *****',_hqIndex];
{_x allowDamage FALSE;} count (missionNamespace getVariable 'QS_aoHQ');
_boxArray = [(missionNamespace getVariable 'QS_HQpos')] call (missionNamespace getVariable 'QS_fnc_aoHQCache');
[(missionNamespace getVariable 'QS_AO_HQ_flag'),EAST,'',FALSE,objNull,1] call (missionNamespace getVariable 'QS_fnc_setFlag');
{
	0 = (missionNamespace getVariable 'QS_aoHQ') pushBack _x;
} count _boxArray;
(missionNamespace getVariable 'QS_aoHQ');