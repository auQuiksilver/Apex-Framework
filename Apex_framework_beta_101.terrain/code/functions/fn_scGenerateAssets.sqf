/*/
File: fn_scGenerateAssets.sqf
Author: 

	Quiksilver

Last Modified:

	28/05/2017 A3 1.70 by Quiksilver

Description:

	Generate Sector Assets
____________________________________________________________________________/*/

params ['_sectorPosition','_radius'];
private _assets = [];
_flagData = [];
_sectorAreaObjects = [];
_locationData = [];
_objectData = [];
_markerData = [];
_taskData = [];
_letters = ['A','B','C'];
_letter = format ['%1',(_letters select (count (missionNamespace getVariable 'QS_virtualSectors_data')))];
comment 'Flag';
_flag = createVehicle ['FlagPole_F',[-1000,-1000,0],[],0,'NONE'];
missionNamespace setVariable [
	'QS_analytics_entities_created',
	((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
	FALSE
];
_flag setPos _sectorPosition;
[
	_flag,
	EAST,
	((missionNamespace getVariable 'QS_virtualSectors_sidesFlagsTextures') select ((missionNamespace getVariable 'QS_virtualSectors_sides') find EAST)),
	FALSE,
	objNull,
	1
] call (missionNamespace getVariable 'QS_fnc_setFlag');
_flagData = [_flag,(flagTexture _flag),(flagSide _flag),(flagOwner _flag),(flagAnimationPhase _flag),''];
comment 'Sector Area Objects';
/*/ use this for modular
_sectorAreaObjects = [
	[
		(createSimpleObject ['a3\Modules_F_Curator\Multiplayer\surfaceSectorEast100m.p3d',[-1000,-1000,0]]),
		(createSimpleObject ['a3\Modules_F_Curator\Multiplayer\surfaceSectorEast200m.p3d',[-1000,-1000,0]])
	],
	[
		(createSimpleObject ['a3\Modules_F_Curator\Multiplayer\surfaceSectorWest100m.p3d',[-1000,-1000,0]]),
		(createSimpleObject ['a3\Modules_F_Curator\Multiplayer\surfaceSectorWest200m.p3d',[-1000,-1000,0]])
	]
];
missionNamespace setVariable [
	'QS_analytics_entities_created',
	((missionNamespace getVariable 'QS_analytics_entities_created') + 2),
	FALSE
];
{
	_x hideObjectGlobal TRUE;
	_x setPos _sectorPosition;
} forEach _sectorAreaObjects;
/*/
_sectorAreaObjects = (missionNamespace getVariable 'QS_virtualSectors_sectorObjects') select (count (missionNamespace getVariable 'QS_virtualSectors_data'));
{
	_x hideObjectGlobal TRUE;
	_x setPos _sectorPosition;
} forEach (_sectorAreaObjects select 0);
comment 'Locations';
_location = createLocation ['Name',[-1000,-1000,0],_radius,_radius];
missionNamespace setVariable [
	'QS_analytics_entities_created',
	((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
	FALSE
];
_location setText _letter;
_location setName _letter;
_location setSide EAST;
_location setRectangular FALSE;
_location setSize [50,50];
_location setPosition _sectorPosition;
_locationData pushBack _location;
missionNamespace setVariable [
	'QS_virtualSectors_locations',
	((missionNamespace getVariable 'QS_virtualSectors_locations') + [_location]),
	FALSE
];
comment 'Composition';
_composition = call (selectRandom (missionNamespace getVariable 'QS_sc_compositions_hq'));
_objectData = [_sectorPosition,(random 360),_composition,TRUE] call (missionNamespace getVariable 'QS_fnc_serverObjectsMapper');
if ((([(_sectorPosition select 0),(_sectorPosition select 1)] nearObjects ['House',(_radius * 0.5)]) select {(!((_x buildingPos -1) isEqualTo []))}) isEqualTo []) then {
	comment 'No buildings nearby, lets spawn some and add them to objectData array';
	private _buildingSpawnPositions = [[0,0,0]];
	private _spawnPosition = [0,0,0];
	private _buildingType = '';
	private _building = objNull;
	_buildingPool = [
		[
			"Land_i_Stone_HouseSmall_V2_F","Land_i_Stone_Shed_V1_F","Land_i_Stone_Shed_V2_F","Land_i_Stone_HouseSmall_V1_F",
			"Land_d_Stone_HouseBig_V1_F","Land_i_Stone_HouseBig_V1_F","Land_i_Stone_HouseBig_V2_F","Land_Slum_House02_F","Land_d_House_Small_01_V1_F","Land_u_House_Small_01_V1_F",
			"land_shed_08_grey_f","land_bunker_01_hq_f","land_shed_08_grey_f","land_bunker_01_hq_f"
		],
		[
			"land_shed_08_grey_f","land_bunker_01_hq_f","Land_Slum_03_F","Land_Slum_01_F","Land_Slum_02_F","Land_House_Small_03_F","Land_House_Native_01_F","Land_House_Native_02_F",
			"land_bunker_01_hq_f"
		]
	] select (worldName isEqualTo 'Tanoa');
	private _breakOut = FALSE;
	for '_x' from 0 to 2 step 1 do {
		_breakOut = FALSE;
		for '_x' from 0 to 10 step 1 do {
			_spawnPosition = [_sectorPosition,12,50,8,0,0.4,0] call (missionNamespace getVariable 'QS_fnc_findSafePos');
			if ((_spawnPosition distance2D _sectorPosition) < 100) then {
				if (({((_spawnPosition distance2D _x) < 20)} count _buildingSpawnPositions) isEqualTo 0) then {
					if ((([_spawnPosition select 0,_spawnPosition select 1] nearRoads 20) select {((_x isEqualType objNull) && (!((roadsConnectedTo _x) isEqualTo [])))}) isEqualTo []) then {
						_buildingType = selectRandom _buildingPool;
						_building = createVehicle [_buildingType,_spawnPosition,[],0,'NONE'];
						_building setDir (random 360);
						_building allowDamage FALSE;
						_objectData pushBack _building;
						_buildingSpawnPositions pushBack _spawnPosition;
						_breakOut = TRUE;
					};
					
				};
			};
			if (_breakOut) exitWith {};
		};
	};
};
comment 'Markers';
_marker = createMarker [(format ['QS_marker_virtualSectors_%1',(count (missionNamespace getVariable 'QS_virtualSectors_data'))]),[-1000,-1000,0]];
_marker setMarkerAlpha 0;
_marker setMarkerShape 'ELLIPSE';
_marker setMarkerBrush 'Solid';
_marker setMarkerColor 'ColorOPFOR';
_marker setMarkerText (toString [32,32,32]);
_marker setMarkerSize [100,100];
_marker setMarkerPos _sectorPosition;
_markerData pushBack _marker;
_marker2 = createMarker [(format ['QS_marker_virtualSectors_%1_ring_1',(count (missionNamespace getVariable 'QS_virtualSectors_data'))]),[-1000,-1000,0]];
_marker2 setMarkerAlpha 0;
_marker2 setMarkerShape 'ELLIPSE';
_marker2 setMarkerBrush 'Border';
_marker2 setMarkerColor 'ColorOPFOR';
_marker2 setMarkerText (toString [32,32,32]);
_marker2 setMarkerSize [50,50];
_marker2 setMarkerPos _sectorPosition;
_markerData pushBack _marker2;
_marker3 = createMarker [(format ['QS_marker_virtualSectors_%1_ring_2',(count (missionNamespace getVariable 'QS_virtualSectors_data'))]),[-1000,-1000,0]];
_marker3 setMarkerAlpha 0;
_marker3 setMarkerShape 'ELLIPSE';
_marker3 setMarkerBrush 'Border';
_marker3 setMarkerColor 'ColorOPFOR';
_marker3 setMarkerText (toString [32,32,32]);
_marker3 setMarkerSize [100,100];
_marker3 setMarkerPos _sectorPosition;
_markerData pushBack _marker3;
comment 'Task';
private _title = '';
if (_letter isEqualTo 'A') then {
	_title = 'Alpha';
};
if (_letter isEqualTo 'B') then {
	_title = 'Bravo';
};
if (_letter isEqualTo 'C') then {
	_title = 'Charlie';
};
_description = format ['Control %1 ( %2 ).<br/><br/>How to Capture:<br/><br/>Occupy the inner area to help capture and hold the zone.<br/><br/>Enemy within the outer area will slow down or even reverse your progress!<br/><br/>While it is necessary to hold the inner zone, it is also important to control and keep the enemy out of the larger zone.',_title,_letter];
_taskData pushBack ([
	(format ['QS_virtualSectors_%1_task',(count (missionNamespace getVariable 'QS_virtualSectors_data'))]),
	TRUE,
	[
		_description,
		_title,
		_letter
	],
	[(_sectorPosition select 0),(_sectorPosition select 1),((_sectorPosition select 2) + 8)],
	'CREATED',
	5,
	FALSE,
	TRUE,
	_letter,
	TRUE
] call (missionNamespace getVariable 'BIS_fnc_setTask'));
_assets = [_flagData,_sectorAreaObjects,_locationData,_objectData,_markerData,_taskData];
_assets;