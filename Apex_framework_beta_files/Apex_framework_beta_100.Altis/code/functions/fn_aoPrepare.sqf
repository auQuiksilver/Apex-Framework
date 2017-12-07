/*
File: fn_aoPrepare.sqf
Author: 

	Quiksilver

Last modified: 

	20/08/2016 A3 1.62 by Quiksilver

Description:

	Prepare AO
______________________________________________*/

private ['_ao','_QS_AOpos','_aoArray','_aoHQ','_aoRadioTower','_aoMinefield','_enemyArray','_isHCEnabled','_minefield','_result'];

_ao = _this select 0;
_QS_AOpos = _ao select 1;
_aoArray = [];
_isHCEnabled = FALSE;

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

/*/======================================================================= RADIOTOWER/*/

diag_log '****************************************************';
diag_log '***** AO PREPARE ******* 2 *************************';
diag_log '****************************************************';

[_QS_AOpos] call (missionNamespace getVariable 'QS_fnc_aoRadiotower');

/*/======================================================================= MINEFIELD/*/

diag_log '****************************************************';
diag_log '***** AO PREPARE ******* 3 *************************';
diag_log '****************************************************';

if ((random 1) > 0.666) then {
	_minefield = [] call (missionNamespace getVariable 'QS_fnc_aoMinefield');
} else {
	_minefield = [];
};

/*/======================================================================= CUSTOMIZATIONS/*/

_result = [(_ao select 0)] call (missionNamespace getVariable 'QS_fnc_aoCustomize');
/*/if (_result isEqualType scriptNull) exitWith {};/*/

diag_log '****************************************************';
diag_log '***** AO PREPARE ******* 4 *************************';
diag_log '****************************************************';

/*/======================================================================= FORCE PROTECTION/*/

/*/
if (!(_isHCEnabled)) then {
	[_QS_AOpos,FALSE,_ao,_minefield] call (missionNamespace getVariable 'QS_fnc_aoEnemy');
} else {
	if ((count (missionNamespace getVariable 'QS_headlessClients')) > 0) then {
		diag_log '***** SERVER ***** HC spawning AO enemy *****';
		[_QS_AOpos,TRUE,_ao,_minefield] remoteExec ['QS_fnc_aoEnemy',((missionNamespace getVariable 'QS_headlessClients') select 0),FALSE];
	} else {
		_isHCEnabled = FALSE;
		[_QS_AOpos,FALSE,_ao,_minefield] call (missionNamespace getVariable 'QS_fnc_aoEnemy');
	};
};
/*/

diag_log '****************************************************';
diag_log '***** AO PREPARE ******* 5 *************************';
diag_log '****************************************************';

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
		(['RADIUS',_QS_AOpos,((missionNamespace getVariable 'QS_aoSize') * 1.25),'LAND',[],FALSE,[],[],TRUE] call (missionNamespace getVariable 'QS_fnc_findRandomPos')),
		(selectRandom ['SHEEP','GOAT','SHEEP','GOAT','HEN','SHEEP']),
		(round (3 + (random 3)))
	] call (missionNamespace getVariable 'QS_fnc_aoAnimals');
};
diag_log '****************************************************';
diag_log '***** AO PREPARE ******* 6 *************************';
diag_log '****************************************************';

/*/======================================================================= JUNGLE CAMP/*/

if (worldName isEqualTo 'Tanoa') then {
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
private _subObj = [];
{
	_subObj = _x call (missionNamespace getVariable 'QS_fnc_scSubObjective');
	if (!(_subObj isEqualTo [])) then {
		(missionNamespace getVariable 'QS_classic_subObjectives') pushBack _subObj;
	};
} forEach [
	[1,'INTEL'],
	[1,'GEAR']
];

/*/======================================================================= FIRES/*/

diag_log '****************************************************';
diag_log '***** AO PREPARE ******* 7 *************************';
diag_log '****************************************************';

if (!(sunOrMoon isEqualTo 1)) then {
	[1,(missionNamespace getVariable 'QS_AOpos'),250,3] call (missionNamespace getVariable 'QS_fnc_aoFires');
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