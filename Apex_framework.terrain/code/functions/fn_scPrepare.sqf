/*/
File: fn_scPrepare.sqf
Author: 

	Quiksilver

Last Modified:

	3/10/2017 A3 1.76 by Quiksilver

Description:

	Prepare SC mission
	
To Do:

	We need a loopback method incase things fail at any step of the way.
____________________________________________________________________________/*/

diag_log '***** SC INIT * 1 *****';
params ['_module_fob_enabled','_scAreaPolygon'];
comment 'Select number of sectors';
private _numberOfSectors = 3;
_worldName = worldName;
comment 'Generate positions';
private _sectorPositions = [];
for '_x' from 0 to 1 step 0 do {
	_sectorPositions = [_numberOfSectors,_module_fob_enabled,_scAreaPolygon] call (missionNamespace getVariable 'QS_fnc_scGeneratePositions');
	if ((count _sectorPositions) isEqualTo _numberOfSectors) exitWith {};
};
missionNamespace setVariable [
	'QS_virtualSectors_regionUsedPositions',
	((missionNamespace getVariable 'QS_virtualSectors_regionUsedPositions') + [(markerPos 'QS_marker_aoMarker')]),
	FALSE
];
diag_log '***** SC INIT * 2 *****';
private _sectorPosition = [0,0,0];
private _sectorAssets = [];
private _conversionRate = 0;
private _communications = [];
missionNamespace setVariable ['QS_virtualSectors_locations',[],FALSE];
for '_x' from 0 to (_numberOfSectors - 1) step 1 do {
	comment 'Generate sector assets';
	_sectorPosition = _sectorPositions # _x;
	missionNamespace setVariable [
		'QS_virtualSectors_regionUsedPositions',
		((missionNamespace getVariable 'QS_virtualSectors_regionUsedPositions') + [_sectorPosition]),
		FALSE
	];
	_sectorAssets = [_sectorPosition,100] call (missionNamespace getVariable 'QS_fnc_scGenerateAssets');
	_communications pushBack _sectorAssets;
	comment 'Dynamic sector configure';
	_increment = 5;
	_minConversionTime = 180;	comment 'default 300';
	_interruptMultiplier = 1;	comment 'dev default = 2';
	_areaOrRadiusConvert = 50;
	_areaOrRadiusInterrupt = 100;
	_sidesOwnedBy = [EAST,RESISTANCE];
	_sidesCanConvert = [WEST];
	_sidesCanInterrupt = [EAST,RESISTANCE];
	_conversionValue = _minConversionTime;
	_conversionValuePrior = _minConversionTime;
	_conversionAlgorithm = {};
	_importance = 0;
	_sectorAssets params [
		'_flagData',
		'_sectorAreaObjects',
		'_locationData',
		'_objectData',
		'_markerData',
		'_taskData'
	];
	_initFunction = {};
	_manageFunction = {};
	_exitFunction = {};
	_conversionRate = 0;
	_isBeingInterrupted = FALSE;
	comment 'Register sector';
	diag_log '***** SC INIT * 3 *****';
	[
		'ADD',
		[
			(format ['QS_virtualSectors_%1',(count (missionNamespace getVariable 'QS_virtualSectors_data'))]),
			TRUE,
			-1,
			_increment,
			_minConversionTime,
			_interruptMultiplier,
			'ELLIPSE',
			_sectorPosition,
			_areaOrRadiusConvert,
			_areaOrRadiusInterrupt,
			_sidesOwnedBy,
			_sidesCanConvert,
			_sidesCanInterrupt,
			_conversionValue,
			_conversionValuePrior,
			_conversionAlgorithm,
			_importance,
			_flagData,
			_sectorAreaObjects,
			_locationData,
			_objectData,
			_markerData,
			_taskData,
			_initFunction,
			_manageFunction,
			_exitFunction,
			_conversionRate,
			_isBeingInterrupted
		]
	] call (missionNamespace getVariable 'QS_fnc_sc');
};
diag_log '***** SC INIT * 4 *****';
comment 'Create AO Mortar Pit';
if (((count allPlayers) > 20) || {((random 1) > 0.75)}) then {
	private _mortarPit = [(missionNamespace getVariable 'QS_AOpos')] call (missionNamespace getVariable 'QS_fnc_aoMortarPit');
	if (_mortarPit isNotEqualTo []) then {
		{
			if (_x isEqualType objNull) then {
				(missionNamespace getVariable 'QS_virtualSectors_entities') pushBack _x;
			};
		} forEach _mortarPit;
	};
};
comment 'Mortar markers';


comment 'Create AO AA Sites';
private _aaArray = [];
private _aaTypes = ['O_APC_Tracked_02_AA_F','O_APC_Tracked_02_AA_F','O_APC_Tracked_02_AA_F','B_APC_Tracked_01_AA_F','O_APC_Tracked_02_AA_F'];
private _aaCount = 1;
if (((count allPlayers) > 20) || {((random 1) > 0.75)}) then {
	_aaCount = 1;
	if ((count allPlayers) > 40) then {
		_aaCount = 2;
	};
	for '_x' from 1 to _aaCount step 1 do {
		_aaArray = [(missionNamespace getVariable 'QS_AOpos'),(selectRandom _aaTypes)] call (missionNamespace getVariable 'QS_fnc_aoFortifiedAA');
		if (_aaArray isNotEqualTo []) then {
			{
				(missionNamespace getVariable 'QS_virtualSectors_entities') pushBack _x;
			} forEach _aaArray;
		};
	};
};
comment 'Create sub objectives';
private _subObj = [];
private _subObjectives = [];
_subObjectives pushBack [1,'VEHICLE'];
_subObjectives pushBack (selectRandomWeighted [[1,'INTEL'],0.5,[1,'GEAR'],0.5]);
if ((random 1) > 0.5) then {
	_subObjectives pushBack [1,'JAMMER'];
};
{
	_subObj = _x call (missionNamespace getVariable 'QS_fnc_scSubObjective');
	if (_subObj isNotEqualTo []) then {
		(missionNamespace getVariable 'QS_virtualSectors_subObjectives') pushBack _subObj;
	};
} forEach _subObjectives;
comment 'Illumination';
if (([0,0,0] getEnvSoundController 'night') isEqualTo 1) then {
	0 spawn {
		[0,(missionNamespace getVariable 'QS_AOpos'),400,3] call (missionNamespace getVariable 'QS_fnc_aoFires');
		sleep 3;
		[1,(missionNamespace getVariable 'QS_AOpos'),400,3] call (missionNamespace getVariable 'QS_fnc_aoFires');
	};
};
comment 'Random vehicles';
[] call (missionNamespace getVariable 'QS_fnc_aoRandomVehicles');
comment 'Civilians';
_nearestLocations = nearestLocations [(missionNamespace getVariable 'QS_AOpos'),['NameVillage','NameCity','NameCityCapital'],((missionNamespace getVariable 'QS_aoSize') * 1.1)];
if (_nearestLocations isNotEqualTo []) then {
	_nearestLocation = _nearestLocations # 0;
	if ((missionNamespace getVariable ['QS_missionConfig_AmbCiv',1]) isNotEqualTo 0) then {
		missionNamespace setVariable [
			'QS_primaryObjective_civilians',
			([(locationPosition _nearestLocation),250,'FOOT',10,FALSE] call (missionNamespace getVariable 'QS_fnc_spawnAmbientCivilians')),
			FALSE
		];
	};
};
comment 'Animals';
if ((missionNamespace getVariable ['QS_missionConfig_AmbAnim',1]) isNotEqualTo 0) then {
	for '_x' from 0 to 2 step 1 do {
		[
			(['RADIUS',(missionNamespace getVariable 'QS_AOpos'),((missionNamespace getVariable 'QS_aoSize') * 1.1),'LAND',[],FALSE,[],[],TRUE] call (missionNamespace getVariable 'QS_fnc_findRandomPos')),
			(selectRandomWeighted ['SHEEP',3,'GOAT',2,'HEN',1]),
			(round (2 + (random 3)))
		] call (missionNamespace getVariable 'QS_fnc_aoAnimals');
	};
};

'respawn_east' setMarkerPos (missionNamespace getVariable 'QS_AOpos');

comment 'UXOs';
if ((random 1) > 0.5) then {
	missionNamespace setVariable [
		'QS_ao_UXOs',
		([(missionNamespace getVariable 'QS_AOpos'),(missionNamespace getVariable 'QS_aoSize'),(10 + (round (random 10))),[]] call (missionNamespace getVariable 'QS_fnc_aoCreateUXOfield')),
		FALSE
	];
};
comment 'Briefing';
[1,_communications] call (missionNamespace getVariable 'QS_fnc_scBrief');
comment 'Finish prepare';
missionNamespace setVariable ['QS_virtualSectors_active',TRUE,TRUE];
missionNamespace setVariable ['QS_virtualSectors_positions',(missionNamespace getVariable 'QS_virtualSectors_positions'),TRUE];
missionNamespace setVariable ['QS_virtualSectors_AI_triggerInit',TRUE,FALSE];
missionNamespace setVariable ['QS_missionStatus_canShow',TRUE,TRUE];