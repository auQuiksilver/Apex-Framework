/*/
File: fn_aoPrepare.sqf
Author: 

	Quiksilver

Last modified: 

	10/04/2018 A3 1.82 by Quiksilver

Description:

	Prepare AO
______________________________________________/*/

params ['_ao'];
private ['_aoHQ','_aoRadioTower','_aoMinefield','_enemyArray','_minefield','_result'];
_QS_AOpos = _ao select 1;
private _aoArray = [];
private _isHCEnabled = FALSE;

/*/====================================================================== HEADLESS CLIENT VALIDATION/*/

if (missionNamespace getVariable 'QS_HC_Active') then {
	_isHCEnabled = TRUE;
};

/*/======================================================================= SET CURRENT AO/*/

missionNamespace setVariable ['QS_classic_AOData',_ao,TRUE];
missionNamespace setVariable ['QS_aoDisplayName',(_ao select 0),TRUE];

/*/======================================================================= SET CURRENT AO SIZE/*/

private _playerCount = count allPlayers;
private _aoSize = 800;
if (worldName isEqualTo 'Altis') then {
	if (_playerCount > 10) then {
		if (_playerCount > 20) then {
			if (_playerCount > 30) then {
				if (_playerCount > 40) then {
					if (_playerCount > 50) then {
						_aoSize = 1000;
					} else {
						_aoSize = 900;
					};
				} else {
					_aoSize = 800;
				};
			} else {
				_aoSize = 700;
			};
		} else {
			_aoSize = 600;
		};
	} else {
		_aoSize = 500;
	};
} else {
	if (_playerCount > 10) then {
		if (_playerCount > 20) then {
			if (_playerCount > 30) then {
				if (_playerCount > 40) then {
					if (_playerCount > 50) then {
						_aoSize = 800;
					} else {
						_aoSize = 750;
					};
				} else {
					_aoSize = 700;
				};
			} else {
				_aoSize = 650;
			};
		} else {
			_aoSize = 600;
		};
	} else {
		_aoSize = 500;
	};
};
missionNamespace setVariable ['QS_aoSize',_aoSize,TRUE];
'QS_marker_aoCircle' setMarkerSize [_aoSize,_aoSize];

diag_log '****************************************************';
diag_log '***** AO PREPARE ******* 1 *************************';
diag_log '****************************************************';

/*/======================================================================= HEADQUARTERS/*/

[_QS_AOpos] call (missionNamespace getVariable 'QS_fnc_aoHQ');

/*/======================================================================= CUSTOMIZATIONS/*/

_result = [(_ao select 0)] call (missionNamespace getVariable 'QS_fnc_aoCustomize');
/*/if (_result isEqualType scriptNull) exitWith {};/*/

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
{
	_subObjectiveData pushBack (_x call (missionNamespace getVariable 'QS_fnc_aoSubObjectives'));
} forEach _subObjectiveList;
missionNamespace setVariable ['QS_classic_subObjectiveData',_subObjectiveData,FALSE];

/*/======================================================================= CIVILIANS/*/

_nearestLocations = nearestLocations [_QS_AOpos,['NameVillage','NameCity','NameCityCapital'],(_aoSize * 1.1)];
if (!(_nearestLocations isEqualTo [])) then {
	_nearestLocation = _nearestLocations select 0;
	missionNamespace setVariable [
		'QS_primaryObjective_civilians',
		([(locationPosition _nearestLocation),300,'FOOT',10,FALSE] call (missionNamespace getVariable 'QS_fnc_spawnAmbientCivilians')),
		FALSE
	];
	comment 'Random vehicles';
	[] call (missionNamespace getVariable 'QS_fnc_aoRandomVehicles');
};

/*/======================================================================= ANIMAL SITE/*/

for '_x' from 0 to 2 step 1 do {
	[
		(['RADIUS',_QS_AOpos,(_aoSize * 1.1),'LAND',[],FALSE,[],[],TRUE] call (missionNamespace getVariable 'QS_fnc_findRandomPos')),
		(selectRandomWeighted ['SHEEP',3,'GOAT',2,'HEN',1]),
		(round (3 + (random 3)))
	] call (missionNamespace getVariable 'QS_fnc_aoAnimals');
};
diag_log '****************************************************';
diag_log '***** AO PREPARE ******* 6 *************************';
diag_log '****************************************************';

/*/======================================================================= JUNGLE CAMP/*/

if ((random 1) > 0.5) then {
	[_QS_AOpos] call (missionNamespace getVariable 'QS_fnc_aoForestCamp');
};

/*/======================================================================= UXOs/*/

if ((random 1) > 0) then {
	missionNamespace setVariable [
		'QS_ao_UXOs',
		([_QS_AOpos,_aoSize,(10 + (round (random 10))),[]] call (missionNamespace getVariable 'QS_fnc_aoCreateUXOfield')),
		FALSE
	];
};

/*/======================================================================= OTHER SUBS/*/

comment 'Create other objectives';
_subObj = (selectRandomWeighted [[1,'INTEL'],0.5,[1,'GEAR'],0.5]) call (missionNamespace getVariable 'QS_fnc_scSubObjective');
(missionNamespace getVariable 'QS_classic_subObjectives') pushBack _subObj;

/*/======================================================================= FIRES/*/

diag_log '****************************************************';
diag_log '***** AO PREPARE ******* 7 *************************';
diag_log '****************************************************';

if (!(sunOrMoon isEqualTo 1)) then {
	[0,(missionNamespace getVariable 'QS_AOpos'),300,3] call (missionNamespace getVariable 'QS_fnc_aoFires');
	[1,(missionNamespace getVariable 'QS_AOpos'),300,3] call (missionNamespace getVariable 'QS_fnc_aoFires');
};

/*/======================================================================= BRIEFING/*/

diag_log '****************************************************';
diag_log '***** AO PREPARE ******* 8 *************************';
diag_log '****************************************************';

['BRIEF',(_ao select 0),_QS_AOpos] call (missionNamespace getVariable 'QS_fnc_aoBriefing');

/*/======================================================================= TRIGGER INIT/*/

missionNamespace setVariable ['QS_classic_AI_triggerInit',TRUE,FALSE];
missionNamespace setVariable ['QS_classic_AI_active',TRUE,FALSE];

/*/======================================================================= RETURN/*/

_aoArray;