/*/
File: fn_aoPrepare.sqf
Author: 

	Quiksilver

Last modified: 

	10/11/2022 A3 2.10 by Quiksilver

Description:

	Prepare AO
______________________________________________/*/

params ['_ao'];
_QS_AOpos = _ao # 2;
private _aoArray = [];

/*/======================================================================= SET CURRENT AO/*/

missionNamespace setVariable ['QS_classic_AOData',_ao,TRUE];
missionNamespace setVariable ['QS_aoDisplayName',(_ao # 1),TRUE];

/*/======================================================================= SET CURRENT AO SIZE/*/

private _playerCount = count allPlayers;
_bigTerrain = worldName in ['Altis'];
private _aoSize = [350,400] select _bigTerrain;
if (_playerCount > 10) then {
	_aoSize = [400,450] select _bigTerrain;
};
if (_playerCount > 20) then {
	_aoSize = [450,500] select _bigTerrain;
};
if (_playerCount > 30) then {
	_aoSize = [500,550] select _bigTerrain;
};
if (_playerCount > 40) then {
	_aoSize = [550,600] select _bigTerrain;
};
if (_playerCount > 50) then {
	_aoSize = [600,650] select _bigTerrain;
};
if (_playerCount > 60) then {
	_aoSize = [650,700] select _bigTerrain;
};
if (worldName isEqualTo 'Stratis') then {
	_aoSize = 350;
};
missionNamespace setVariable ['QS_aoSize',_aoSize,TRUE];
'QS_marker_aoCircle' setMarkerSizeLocal [_aoSize,_aoSize];

diag_log '****************************************************';
diag_log '***** AO PREPARE ******* 1 *************************';
diag_log '****************************************************';

/*/===== GET URBAN STATE/*/

private _requiredBuildings = 8;
if (worldName in ['Tanoa']) then {
	_requiredBuildings = 8;
};
if (worldName in ['Stratis']) then {
	_requiredBuildings = 6;
};
private _result = (count ((nearestObjects [_QS_AOpos,['House'],_aoSize * 0.9,TRUE]) select {((!isObjectHidden _x) && ((sizeOf (typeOf _x)) > 10))})) >= _requiredBuildings;
{
	missionNamespace setVariable _x;
} forEach [
	['QS_ao_urbanSpawn',_result,FALSE],
	['QS_ao_urbanSpawn_data',[],FALSE],
	['QS_ao_urbanSpawn_nodes',[],FALSE],
	['QS_ao_terrainIsSettlement',_result,FALSE],
	['QS_ao_objsUsedTerrainBldgs',0,FALSE]
];

/*/======================================================================= HEADQUARTERS/*/

if (!(worldName in ['Stratis'])) then {
	[_QS_AOpos] call (missionNamespace getVariable 'QS_fnc_aoHQ');
} else {
	_flag = createVehicle ['FlagPole_F',_QS_AOpos];
	QS_aoHQ = [_flag];
	_flag setDir (random 360);
	[_flag,EAST,'',FALSE,objNull,1] call (missionNamespace getVariable 'QS_fnc_setFlag');
	missionNamespace setVariable ['QS_AO_HQ_flag',_flag,FALSE];
	missionNamespace setVariable ['QS_hqPos',_QS_AOpos,FALSE];
};
'respawn_east' setMarkerPos _QS_AOpos;

/*/======================================================================= CUSTOMIZATIONS/*/

diag_log str (_ao # 0);
_result = [(_ao # 0)] call (missionNamespace getVariable 'QS_fnc_aoCustomize');

diag_log '****************************************************';
diag_log '***** AO PREPARE ******* 4 *************************';
diag_log '****************************************************';
_subObjectiveList = [
	[1,'ENEMYPOP'],
	[1,'RADIOTOWER']
];
if ((random 1) > 0.5) then {
	_subObjectiveList pushBack [1,'JAMMER'];
};
_subObjectiveData = [];
private _subObjectiveData_1 = [];
{
	_subObjectiveData_1 = _x call (missionNamespace getVariable 'QS_fnc_aoSubObjectives');
	if (_subObjectiveData_1 isNotEqualTo []) then {
		_subObjectiveData pushBack _subObjectiveData_1;
	};
} forEach _subObjectiveList;
missionNamespace setVariable ['QS_classic_subObjectiveData',_subObjectiveData,FALSE];

/*/======================================================================= CIVILIANS/*/

_nearestLocations = nearestLocations [_QS_AOpos,['NameVillage','NameCity','NameCityCapital'],(_aoSize * 1.1)];
if (_nearestLocations isNotEqualTo []) then {
	_nearestLocation = _nearestLocations # 0;
	if ((missionNamespace getVariable ['QS_missionConfig_AmbCiv',1]) isNotEqualTo 0) then {
		missionNamespace setVariable [
			'QS_primaryObjective_civilians',
			([(locationPosition _nearestLocation),300,'FOOT',([10,5] select ((count allPlayers) > 40)),FALSE] call (missionNamespace getVariable 'QS_fnc_spawnAmbientCivilians')),
			FALSE
		];
	};
	//comment 'Random vehicles';
	if (!(worldName in ['Stratis'])) then {
		call (missionNamespace getVariable 'QS_fnc_aoRandomVehicles');
	};
};

/*/======================================================================= ANIMAL SITE/*/

if ((missionNamespace getVariable ['QS_missionConfig_AmbAnim',1]) isNotEqualTo 0) then {
	for '_x' from 0 to 2 step 1 do {
		[
			(['RADIUS',_QS_AOpos,(_aoSize * 1.1),'LAND',[],FALSE,[[0,0,0],150,'meadow + hills + forest + trees',30,10],[],TRUE] call (missionNamespace getVariable 'QS_fnc_findRandomPos')),
			(selectRandomWeighted ['SHEEP',3,'GOAT',2,'HEN',1]),
			(round (3 + (random 3)))
		] call (missionNamespace getVariable 'QS_fnc_aoAnimals');
	};
};
diag_log '****************************************************';
diag_log '***** AO PREPARE ******* 6 *************************';
diag_log '****************************************************';

/*/======================================================================= JUNGLE CAMP/*/

if ((random 1) > 0.666) then {
	[_QS_AOpos] call (missionNamespace getVariable 'QS_fnc_aoForestCamp');
};

/*/======================================================================= UXOs/*/

if ((random 1) > 0.666) then {
	missionNamespace setVariable [
		'QS_ao_UXOs',
		([_QS_AOpos,_aoSize,(10 + (round (random 10))),[]] call (missionNamespace getVariable 'QS_fnc_aoCreateUXOfield')),
		FALSE
	];
};

/*/======================================================================= OTHER SUBS/*/

//comment 'Create other objectives';
if (!(worldName in ['Stratis'])) then {
	_subObj = (selectRandomWeighted [[1,'INTEL'],0.5,[1,'GEAR'],0.5]) call (missionNamespace getVariable 'QS_fnc_scSubObjective');
	(missionNamespace getVariable 'QS_classic_subObjectives') pushBack _subObj;
};

/*/======================================================================= FIRES/*/

diag_log '****************************************************';
diag_log '***** AO PREPARE ******* 7 *************************';
diag_log '****************************************************';

if (([0,0,0] getEnvSoundController 'night') isEqualTo 1) then {
	0 spawn {
		[0,(missionNamespace getVariable 'QS_AOpos'),400,3] call (missionNamespace getVariable 'QS_fnc_aoFires');
		sleep 3;
		[1,(missionNamespace getVariable 'QS_AOpos'),400,3] call (missionNamespace getVariable 'QS_fnc_aoFires');
	};
};

/*/======================================================================= BRIEFING/*/

diag_log '****************************************************';
diag_log '***** AO PREPARE ******* 8 *************************';
diag_log '****************************************************';

['BRIEF',(_ao # 1),_QS_AOpos] call (missionNamespace getVariable 'QS_fnc_aoBriefing');

/*/======================================================================= TRIGGER INIT/*/

missionNamespace setVariable ['QS_classic_AI_triggerInit',TRUE,FALSE];
missionNamespace setVariable ['QS_classic_AI_active',TRUE,FALSE];

/*/======================================================================= RETURN/*/

_aoArray;