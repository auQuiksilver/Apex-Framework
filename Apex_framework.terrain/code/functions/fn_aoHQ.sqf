/*/
File: fn_aoHQ.sqf
Author: 

	Quiksilver

Last Modified:

	9/08/2022 A3 2.10 by Quiksilver

Description:

	Spawn AO HQ sub objective
____________________________________________________________________________/*/

params ['_pos'];
private _hqArray = missionNamespace getVariable 'QS_hqArray';
private _hqSelect = selectRandom _hqArray;
private _position1 = [0,0,0];
diag_log '***** DEBUG * Finding HQ position * 0 *';
for '_x' from 0 to 1 step 0 do {
	_position1 = ['RADIUS',_pos,((missionNamespace getVariable 'QS_aoSize') * 0.85),'LAND',[12.5,0,0.3,20,0,FALSE,objNull],FALSE,[],[],TRUE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
	if (!([_position1,25,8] call (missionNamespace getVariable 'QS_fnc_waterInRadius'))) exitWith {};
};
diag_log format ['***** DEBUG * Finding HQ position * %1 *',_position1];
missionNamespace setVariable ['QS_HQpos',_position1,TRUE];
private _roughPos1 = [(((missionNamespace getVariable 'QS_HQpos') # 0) - 150) + (random 300),(((missionNamespace getVariable 'QS_HQpos') # 1) - 150) + (random 300),0];
{
	_x setMarkerPosLocal _roughPos1;
} count ['QS_marker_hqMarker','QS_marker_hqCircle'];
missionNamespace setVariable ['QS_registeredPositions',((missionNamespace getVariable 'QS_registeredPositions') + [(missionNamespace getVariable 'QS_HQpos')]),TRUE];
missionNamespace setVariable [
	'QS_aoHQ',
	([(missionNamespace getVariable 'QS_HQpos'),0,(call _hqSelect),TRUE] call (missionNamespace getVariable 'QS_fnc_serverObjectsMapper')),
	FALSE
];
(missionNamespace getVariable 'QS_AI_regroupPositions') pushBack ['QS_ao_HQ',[EAST,RESISTANCE],_position1];
diag_log format ['***** QS * Used HQ Composition Index: %1 *****',_hqArray find _hqSelect];
{_x allowDamage FALSE;} count (missionNamespace getVariable 'QS_aoHQ');
private _boxArray = [(missionNamespace getVariable 'QS_HQpos')] call (missionNamespace getVariable 'QS_fnc_aoHQCache');
[(missionNamespace getVariable 'QS_AO_HQ_flag'),EAST,'',FALSE,objNull,1] call (missionNamespace getVariable 'QS_fnc_setFlag');
['REMOVE','ENEMY_HQ_0'] call QS_fnc_zoneManager;
['ADD',['ENEMY_HQ_0',TRUE,'NO_BUILD','RAD',2,[(missionNamespace getVariable ['QS_hqPos',[0,0,0]]),40],{},{},{TRUE},{},[WEST]]] call QS_fnc_zoneManager;
{
	(missionNamespace getVariable 'QS_aoHQ') pushBack _x;
} forEach _boxArray;
(missionNamespace getVariable 'QS_aoHQ');