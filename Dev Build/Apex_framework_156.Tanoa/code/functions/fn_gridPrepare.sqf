/*/
File: fn_grid.sqf
Author: 

	Quiksilver

Last Modified:

	22/11/2017 A3 1.76 by Quiksilver

Description:

	[0,'Lifou',[[7140.09,7833.54,0],[7346.88,7796.61,0],[7532.94,8112.1,0],[7178.48,8220.29,0],[7014.28,8044.51,0]],[],[],0,0,0,0,0,0,0,0,0,0]
____________________________________________________________________________/*/

params [['_aoState',1],['_aoDisplayName',''],['_aoPolygon',[]],['_aoGridMarkers',[]],['_a',[]],['_b',0],['_c',0],['_d',0],['_e',0],['_f',0],['_g',0],['_h',0],['_i',0],['_j',0],['_k',0]];
_players = allPlayers;
_playersCount = count _players;
diag_log format ['***** DEBUG ***** GRID AO PREPARING * %1 *****',_this];
missionNamespace setVariable ['QS_grid_aoCentroid',(_aoPolygon call (missionNamespace getVariable 'QS_fnc_geomPolygonCentroid')),TRUE];
missionNamespace setVariable ['QS_aoPos',(missionNamespace getVariable ['QS_grid_aoCentroid',[0,0,0]]),TRUE];
missionNamespace setVariable ['QS_grid_aoProps',[],FALSE];
missionNamespace setVariable ['QS_grid_aoData',_this,QS_system_AI_owners];
_aoPos = missionNamespace getVariable 'QS_aoPos';
private _aoSize = 0;
private _centroid = missionNamespace getVariable ['QS_grid_aoCentroid',[0,0,0]];
{
	if ((_x distance2D _centroid) > _aoSize) then {
		_aoSize = _x distance2D _centroid;
	};
} forEach _aoPolygon;
missionNamespace setVariable ['QS_aoSize',_aoSize,TRUE];
//comment 'Get AO terrain data (roads, buildings, building count ,etc)';
diag_log format ['Getting terrain data START %1',diag_tickTime];
_terrainData = [0,_aoPos,_aoSize,_this] call (missionNamespace getVariable 'QS_fnc_aoGetTerrainData');
diag_log format ['Getting terrain data END %1',diag_tickTime];
private _gridObjectives = [];
private _gridObjective = [];
private _usedObjectives = [];
private _currentObjectives = [
	['GRID_MARKERS',_this,_aoPos,_aoSize,_terrainData,_playersCount],
	['SITE_TUNNEL',_this,_aoPos,_aoSize,_terrainData,_playersCount],
	['SITE_IG',_this,_aoPos,_aoSize,_terrainData,_playersCount],
	['INTEL',_this,_aoPos,_aoSize,_terrainData,_playersCount]
];
if ((random 1) > 0.5) then {
	_currentObjectives pushBack ['SITE_IDAP',_this,_aoPos,_aoSize,_terrainData,_playersCount];
};
if (_playersCount > 3) then {
	if ((random 1) > 0.5) then {
		_currentObjectives pushBack ['MORTAR_DELAYED',_this,_aoPos,_aoSize,_terrainData,_playersCount];
	};
};
{
	_gridObjective = _x call (missionNamespace getVariable 'QS_fnc_gridObjectives');
	if (_gridObjective isNotEqualTo []) then {
		_usedObjectives pushBack (_x # 0);
		_gridObjectives pushBack _gridObjective;
	};
} forEach _currentObjectives;
missionNamespace setVariable ['QS_grid_objectivesData',_gridObjectives,FALSE];
//comment 'Illumination';
if (([0,0,0] getEnvSoundController 'night') isEqualTo 1) then {
	_aoPos spawn {
		[0,_this,400,3] call (missionNamespace getVariable 'QS_fnc_aoFires');
		sleep 3;
		[1,_this,400,3] call (missionNamespace getVariable 'QS_fnc_aoFires');
	};
};

'respawn_east' setMarkerPos _aoPos;

//comment 'Civ vehicles';
if (!isNil {_terrainData # 1}) then {
	if ((count (_terrainData # 1)) > 15) then {
		[] call (missionNamespace getVariable 'QS_fnc_aoRandomVehicles');
	};
};
//comment 'UXO field';
if ((random 1) > 0.333) then {
	missionNamespace setVariable [
		'QS_ao_UXOs',
		([_aoPos,_aoSize,(10 + (round (random 5))),[]] call (missionNamespace getVariable 'QS_fnc_aoCreateUXOfield')),
		FALSE
	];
};

//comment 'Briefing';
[1,_usedObjectives,_aoGridMarkers] call (missionNamespace getVariable 'QS_fnc_gridBrief');
missionNamespace setVariable ['QS_grid_civCasualties',FALSE,TRUE];
missionNamespace setVariable ['QS_grid_AI_triggerInit',TRUE,TRUE];
missionNamespace setVariable ['QS_grid_active',TRUE,TRUE];
missionNamespace setVariable ['QS_TEST_GRID',FALSE,FALSE];
diag_log '***** QS ***** Grid prepare complete *****';
TRUE;