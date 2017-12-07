/*/
File: fn_scAISkill.sqf
Author:

	Quiksilver
	
Last modified:

	10/05/2017 ArmA 3 1.70 by Quiksilver
	
Description:

	Set AI Skill
__________________________________________________/*/

params ['_e0','_e1'];
private [
	'_units','_skill','_aimingAccuracy','_aimingShake','_aimingSpeed','_commanding','_courage','_endurance','_general','_reloadSpeed','_spotDistance','_spotTime','_fleeing',
	'_aimingAccuracyDefault','_playerCount','_e0Type','_unit'
];
/*/_playerCount = count allPlayers;/*/
_aimingAccuracyDefault = 0.14;

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
	_spotDistance = 0;
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
	_aimingShake = 0.5;
	_aimingSpeed = 0.333;
	_commanding = 0.5;
	_courage = 0.5;
	_endurance = 0.5;
	_general = 0.5;
	_reloadSpeed = 0.5;
	_spotDistance = 0.4;
	_spotTime = 0.5;
	_fleeing = 0;
};

/*/===================================== NORMAL/*/

if (_e1 isEqualTo 2) then {
	if ((random 1) > 0.5) then {
		_aimingAccuracy = 0.16;
	} else {
		_aimingAccuracy = _aimingAccuracyDefault;
	};
	_aimingShake = 0.65;
	_aimingSpeed = 0.4;
	_commanding = 1;
	_courage = 1;
	_endurance = 1;
	_general = 1;
	_reloadSpeed = 0.85;
	_spotDistance = 0.75;
	_spotTime = 0.6;
	_fleeing = 0;
};

/*/===================================== HARD/*/

if (_e1 isEqualTo 3) then {
	if ((random 1) > 0.5) then {
		_aimingAccuracy = 0.333;
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
	_spotDistance = 0.8;
	_spotTime = 0.7;
	_fleeing = 0;
};

/*/===================================== SUPER/*/

if (_e1 isEqualTo 4) then {
	if ((random 1) > 0.5) then {
		_aimingAccuracy = 1;
	} else {
		_aimingAccuracy = _aimingAccuracyDefault;
	};
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