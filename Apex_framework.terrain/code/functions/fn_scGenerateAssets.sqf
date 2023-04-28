/*/
File: fn_scGenerateAssets.sqf
Author: 

	Quiksilver

Last Modified:

	18/08/2019 A3 1.94 by Quiksilver

Description:

	Generate Sector Assets
_______________________________________/*/

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
_sectorAreaObjects = (missionNamespace getVariable 'QS_virtualSectors_sectorObjects') select (count (missionNamespace getVariable ['QS_virtualSectors_data',[]]));
{
	_x hideObjectGlobal TRUE;
	_x setPos _sectorPosition;
} forEach (_sectorAreaObjects # 0);
comment 'Locations';
_location = createLocation ['Name',[-1000,-1000,0],_radius,_radius];
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
if ((([(_sectorPosition # 0),(_sectorPosition # 1)] nearObjects ['House',(_radius * 0.5)]) select {((_x buildingPos -1) isNotEqualTo [])}) isEqualTo []) then {
	comment 'No buildings nearby, lets spawn some and add them to objectData array';
	private _buildingSpawnPositions = [[0,0,0]];
	private _spawnPosition = [0,0,0];
	private _buildingType = '';
	private _building = objNull;
	private _buildingPool = [];
	if (worldName in ['Altis','Stratis','Malden']) then {
		_buildingPool = [
			'land_i_stone_housesmall_v2_f','land_i_stone_shed_v1_f','land_i_stone_shed_v2_f','land_i_stone_housesmall_v1_f',
			'land_d_stone_housebig_v1_f','land_i_stone_housebig_v1_f','land_i_stone_housebig_v2_f','land_slum_house02_f','land_d_house_small_01_v1_f','land_u_house_small_01_v1_f',
			'land_shed_08_grey_f','land_bunker_01_hq_f','land_shed_08_grey_f','land_bunker_01_hq_f'
		];
	};
	if (worldName in ['Tanoa']) then {
		_buildingPool = [
			'land_shed_08_grey_f','land_bunker_01_hq_f','Land_Slum_03_F','Land_Slum_01_F','Land_Slum_02_F','Land_House_Small_03_F','Land_House_Native_01_F','Land_House_Native_02_F',
			'land_bunker_01_hq_f'
		];	
	};
	if (worldName in ['Enoch']) then {
		_buildingPool = [
			'land_bunker_01_hq_f','land_shed_14_f','land_shed_13_f','land_camp_house_01_brown_f','land_houseruin_small_01_f','land_houseruin_small_04_f','land_barn_02_f'
		];
	};
	if (_buildingPool isEqualTo []) then {
		_buildingPool = (nearestObjects [_sectorPosition,['House'],_radius,TRUE]) select {(((count (_x buildingPos -1)) > 3) && (!isObjectHidden _x) && ((sizeOf (typeOf _x)) < 35))};
		_buildingPool = _buildingPool apply {typeOf _x};
	};
	private _breakOut = FALSE;
	for '_x' from 0 to 2 step 1 do {
		_breakOut = FALSE;
		for '_x' from 0 to 10 step 1 do {
			_spawnPosition = [_sectorPosition,12,50,8,0,0.4,0] call (missionNamespace getVariable 'QS_fnc_findSafePos');
			if ((_spawnPosition distance2D _sectorPosition) < 100) then {
				if ((_buildingSpawnPositions findIf {((_spawnPosition distance2D _x) < 20)}) isEqualTo -1) then {
					if ((([_spawnPosition # 0,_spawnPosition # 1] nearRoads 20) select {((_x isEqualType objNull) && ((roadsConnectedTo _x) isNotEqualTo []))}) isEqualTo []) then {
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
_marker setMarkerAlphaLocal 0;
_marker setMarkerShapeLocal 'ELLIPSE';
_marker setMarkerBrushLocal 'Solid';
_marker setMarkerColorLocal 'ColorOPFOR';
_marker setMarkerTextLocal (toString [32,32,32]);
_marker setMarkerSizeLocal [100,100];
_marker setMarkerPos _sectorPosition;
_markerData pushBack _marker;
_marker2 = createMarker [(format ['QS_marker_virtualSectors_%1_ring_1',(count (missionNamespace getVariable 'QS_virtualSectors_data'))]),[-1000,-1000,0]];
_marker2 setMarkerAlphaLocal 0;
_marker2 setMarkerShapeLocal 'ELLIPSE';
_marker2 setMarkerBrushLocal 'Border';
_marker2 setMarkerColorLocal 'ColorOPFOR';
_marker2 setMarkerTextLocal (toString [32,32,32]);
_marker2 setMarkerSizeLocal [50,50];
_marker2 setMarkerPos _sectorPosition;
_markerData pushBack _marker2;
_marker3 = createMarker [(format ['QS_marker_virtualSectors_%1_ring_2',(count (missionNamespace getVariable 'QS_virtualSectors_data'))]),[-1000,-1000,0]];
_marker3 setMarkerAlphaLocal 0;
_marker3 setMarkerShapeLocal 'ELLIPSE';
_marker3 setMarkerBrushLocal 'Border';
_marker3 setMarkerColorLocal 'ColorOPFOR';
_marker3 setMarkerTextLocal (toString [32,32,32]);
_marker3 setMarkerSizeLocal [100,100];
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
_description = format [
	'%3 %1 ( %2 ).<br/><br/>%4<br/><br/>%5<br/><br/>%6<br/><br/>%7',
	_title,
	_letter,
	localize 'STR_QS_Task_050',
	localize 'STR_QS_Task_051',
	localize 'STR_QS_Task_052',
	localize 'STR_QS_Task_053',
	localize 'STR_QS_Task_054'
];
_taskData pushBack ([
	(format ['QS_virtualSectors_%1_task',(count (missionNamespace getVariable 'QS_virtualSectors_data'))]),
	TRUE,
	[
		_description,
		_title,
		_letter
	],
	[(_sectorPosition # 0),(_sectorPosition # 1),((_sectorPosition # 2) + 8)],
	'CREATED',
	5,
	FALSE,
	TRUE,
	_letter,
	TRUE
] call (missionNamespace getVariable 'BIS_fnc_setTask'));
_taskData pushBack (format ['media\images\icons\%1_ca.paa',_letter]);
_taskData pushBack _title;
_assets = [_flagData,_sectorAreaObjects,_locationData,_objectData,_markerData,_taskData];
_assets;