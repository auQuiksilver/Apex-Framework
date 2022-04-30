/*/
File: fn_aoMortarPit.sqf
Author: 

	Quiksilver

Last Modified:

	8/10/2017 A3 1.76 by Quiksilver

Description:

	Spawn mortar pit in the AO
____________________________________________________________________________/*/

params ['_pos'];
private ['_position','_return','_aoSize','_sentryType','_multiplier'];
_aoSize = missionNamespace getVariable 'QS_aoSize';
_multiplier = 0.75;
for '_x' from 0 to 11 step 1 do {
	_position = ['RADIUS',_pos,(_aoSize * _multiplier),'LAND',[10,0,0.3,10,0,FALSE,objNull],FALSE,[],[],FALSE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
	if ((((missionNamespace getVariable 'QS_registeredPositions') findIf {((_position distance2D _x) < 100)}) isEqualTo -1) && ((((_position select [0,2]) nearRoads 25) select {((_x isEqualType objNull) && (!((roadsConnectedTo _x) isEqualTo [])))}) isEqualTo []) && (!((toLower(surfaceType _position)) in ['#gdtasphalt'])) && (!([_position,20,8] call (missionNamespace getVariable 'QS_fnc_waterInRadius')))) exitWith {};
	_multiplier = _multiplier + 0.1;
};
if (((_position distance2D _pos) > (_aoSize * 3)) || {(_position isEqualTo [])}) exitWith {[]};
_return = [_position,(random 360),([] call (missionNamespace getVariable 'QS_data_mortarPit')),TRUE] call (missionNamespace getVariable 'QS_fnc_serverObjectsMapper');
{
	if (_x isEqualType objNull) then {
		if (_x isKindOf 'StaticWeapon') then {
			0 = (missionNamespace getVariable 'QS_virtualSectors_aoMortars') pushBack _x;
			if (!isNull (gunner _x)) then {
				(gunner _x) setVariable ['QS_AI_UNIT_regroup_disable',TRUE,FALSE];
				_return pushBack (gunner _x);
			};
		};
	};
} forEach _return;
_position set [2,0];
missionNamespace setVariable ['QS_registeredPositions',((missionNamespace getVariable 'QS_registeredPositions') + [_position]),FALSE];
if ((missionNamespace getVariable 'QS_mission_aoType') isEqualTo 'SC') then {
	_uncertaintyPos = [((_position select 0) + (100 - (random 200))),((_position select 1) + (100 - (random 200))),0];
	_marker1 = createMarker ['QS_marker_virtualSectors_mtr_0',[-1000,-1000,0]];
	_marker1 setMarkerAlphaLocal 0;
	_marker1 setMarkerShapeLocal 'ICON';
	_marker1 setMarkerTypeLocal 'mil_dot';
	_marker1 setMarkerColorLocal 'ColorOPFOR';
	_marker1 setMarkerTextLocal (toString [32,32,32]);
	_marker1 setMarkerSizeLocal [0.5,0.5];
	_marker1 setMarkerPos _uncertaintyPos;
	(missionNamespace getVariable 'QS_virtualSectors_siteMarkers') pushBack _marker1;
	_marker2 = createMarker ['QS_marker_virtualSectors_mtr_00',[-1000,-1000,0]];
	_marker2 setMarkerAlphaLocal 0;
	_marker2 setMarkerShapeLocal 'ELLIPSE';
	_marker2 setMarkerBrushLocal 'Border';
	_marker2 setMarkerColorLocal 'ColorOPFOR';
	_marker2 setMarkerTextLocal (toString [32,32,32]);
	_marker2 setMarkerSizeLocal [100,100];
	_marker2 setMarkerPos _uncertaintyPos;
	(missionNamespace getVariable 'QS_virtualSectors_siteMarkers') pushBack _marker2;
};
_sentryType = 'HAF_InfSentry';
if (worldName isEqualTo 'Tanoa') then {
	_sentryType = 'IG_InfSentry';
};
_patrolGroup = [_position,(random 360),RESISTANCE,_sentryType,FALSE] call (missionNamespace getVariable 'QS_fnc_spawnGroup');
[(units _patrolGroup),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
_patrolGroup setFormation 'FILE';
{
	[_x] call (missionNamespace getVariable 'QS_fnc_setCollectible');
	_position set [2,1];
	_x setVehiclePosition [(getPosWorld (_return select 0)),[],0,'NONE'];
	0 = _return pushBack _x;
} forEach (units _patrolGroup);
_return;