/*/
File: fn_serverSetAISkill.sqf
Author:

	Quiksilver
	
Last Modified:

	17/01/2017 A3 1.80 by Quiksilver
	
Description:

	Server Set AI Skill
_______________________________________________/*/

params ['_e0','_e1'];
private ['_aimingAccuracy','_aimingShake','_aimingSpeed','_commanding','_courage','_endurance','_general','_reloadSpeed','_spotDistance','_spotTime','_fleeing','_aimingAccuracyDefault','_unit'];
_aimingAccuracyDefault = [0.12,0.14] select ((count allPlayers) > 20);
if (worldName isEqualTo 'Altis') then {
	_aimingAccuracyDefault = [0.13,0.15] select ((count allPlayers) > 20);
};

/*/===================================== STUPID/*/

if (_e1 isEqualTo 0) then {
	if ((random 1) > 0.5) then {
		_aimingAccuracy = 0;
	} else {
		_aimingAccuracy = _aimingAccuracyDefault;
	};
	_aimingShake = 0;
	_aimingSpeed = 0;
	_commanding = 0;
	_courage = 0;
	_endurance = 0;
	_general = 0;
	_reloadSpeed = 0;
	_spotDistance = [0,0] select (worldName isEqualTo 'Altis');
	_spotTime = 0;
	_fleeing = 0;
};

/*/===================================== EASY/*/

if (_e1 isEqualTo 1) then {
	if ((random 1) > 0.5) then {
		_aimingAccuracy = 0.12;
	} else {
		_aimingAccuracy = _aimingAccuracyDefault;
	};
	_aimingShake = 0.6;
	_aimingSpeed = 0.4;
	_commanding = 0.5;
	_courage = 0.5;
	_endurance = 0.5;
	_general = 0.5;
	_reloadSpeed = 0.5;
	_spotDistance = [0.3,0.5] select (worldName isEqualTo 'Altis');
	_spotTime = 0.5;
	_fleeing = 0;
};

/*/===================================== NORMAL/*/

if (_e1 isEqualTo 2) then {
	if ((random 1) > 0.5) then {
		_aimingAccuracy = 0.12;
	} else {
		_aimingAccuracy = _aimingAccuracyDefault;
	};
	_aimingShake = 0.65;
	_aimingSpeed = 0.45;
	_commanding = 1;
	_courage = 1;
	_endurance = 1;
	_general = 1;
	_reloadSpeed = 0.85;
	_spotDistance = [0.5,0.6] select (worldName isEqualTo 'Altis');
	_spotTime = 0.5;
	_fleeing = 0;
};

/*/===================================== HARD/*/

if (_e1 isEqualTo 3) then {
	if ((random 1) > 0.5) then {
		_aimingAccuracy = 0.2;
	} else {
		_aimingAccuracy = _aimingAccuracyDefault;
	};
	_aimingShake = 0.75;
	_aimingSpeed = 0.55;
	_commanding = 1;
	_courage = 1;
	_endurance = 1;
	_general = 1;
	_reloadSpeed = 1;
	_spotDistance = [0.8,0.85] select (worldName isEqualTo 'Altis');
	_spotTime = 0.7;
	_fleeing = 0;
};

/*/===================================== SUPER/*/

if (_e1 isEqualTo 4) then {
	_aimingAccuracy = 1;
	_aimingShake = 1;
	_aimingSpeed = 1;
	_commanding = 1;
	_courage = 1;
	_endurance = 1;
	_general = 1;
	_reloadSpeed = 1;
	_spotDistance = 1;
	_spotTime = 1;
	_fleeing = 0;
};

/*/===================================== APPLY SELECTED/*/

{
	_unit = _x;
	_unit setSkill 0.1;
	_unit allowFleeing _fleeing;
	{
		_unit setSkill _x;
	} forEach [
		['aimingAccuracy',_aimingAccuracy],
		['aimingShake',_aimingShake],
		['aimingSpeed',_aimingSpeed],
		['commanding',_commanding],
		['courage',_courage],
		['endurance',_endurance],
		['general',_general],
		['reloadSpeed',_reloadSpeed],
		['spotDistance',_spotDistance],
		['spotTime',_spotTime]
	];
} forEach _e0;