/*/
File: fn_serverSetAISkill.sqf
Author:

	Quiksilver
	
Last Modified:

	9/12/2022 A3 2.10 by Quiksilver
	
Description:

	AI Skills
_______________________________________________/*/

params [['_unitsArray',[]],['_skillLevel',1]];
if ((_unitsArray isEqualTo []) || (!(_skillLevel in [0,1,2,3,4]))) exitWith {};
private _aimingAccuracyDefault = 	[0.15,0.17] select ((count allPlayers) > 20);
private _aimingAccuracy = 			[_aimingAccuracyDefault,0.14] select ((random 1) > 0.5);
private _aimingShake = 				random [0.55,0.6,0.65];
private _aimingSpeed = 				random [0.4,0.45,0.5];
private _commanding = 				1;
private _courage = 					1;
private _endurance = 				1;
private _general = 					1;
private _reloadSpeed = 				random [0.5,0.55,0.6];
private _spotDistance = 			random [0.55,0.6,0.65];
private _spotTime = 				random [0.55,0.6,0.65];
private _fleeing = 					0;
if (worldName isEqualTo 'Tanoa') then {
	_aimingAccuracyDefault = [0.1,0.13] select ((count allPlayers) > 20);
	// no skill
	if (_skillLevel isEqualTo 0) then {
		_aimingAccuracy = 	0;
		_aimingShake = 		0;
		_aimingSpeed = 		0;
		_commanding = 		0;
		_courage = 			0;
		_endurance = 		0;
		_general = 			0;
		_reloadSpeed = 		0;
		_spotDistance = 	0;
		_spotTime = 		0;
		_fleeing = 			0;
	};
	// normal skill
	if (_skillLevel isEqualTo 1) then {
		_aimingAccuracy = 	[_aimingAccuracyDefault,0.12] select ((random 1) > 0.5);
		_aimingShake = 		random [0.45,0.5,0.55];
		_aimingSpeed = 		random [0.3,0.35,0.4];
		_commanding = 		1;
		_courage = 			1;
		_endurance = 		1;
		_general = 			1;
		_reloadSpeed = 		random [0.45,0.5,0.55];
		_spotDistance = 	random [0.25,0.3,0.35];
		_spotTime = 		random [0.45,0.5,0.55];
		_fleeing = 			0;
	};
	// hard skill
	if (_skillLevel isEqualTo 2) then {
		_aimingAccuracy = 	[_aimingAccuracyDefault,0.12] select ((random 1) > 0.5);
		_aimingShake = 		random [0.6,0.65,0.7];
		_aimingSpeed = 		random [0.35,0.4,0.45];
		_commanding = 		1;
		_courage = 			1;
		_endurance = 		1;
		_general = 			1;
		_reloadSpeed = 		random [0.8,0.85,0.9];
		_spotDistance = 	random [0.45,0.5,0.55];
		_spotTime = 		random [0.45,0.5,0.55];
		_fleeing = 			0;
	};
	// very hard skill
	if (_skillLevel isEqualTo 3) then {
		_aimingAccuracy = 	[_aimingAccuracyDefault,0.2] select ((random 1) > 0.5);
		_aimingShake = 		random [0.7,0.75,0.8];
		_aimingSpeed = 		random [0.5,0.55,0.6];
		_commanding = 		1;
		_courage = 			1;
		_endurance = 		1;
		_general = 			1;
		_reloadSpeed = 		1;
		_spotDistance = 	random [0.75,0.8,0.85];
		_spotTime = 		random [0.65,0.7,0.75];
		_fleeing = 			0;
	};
	// max skill
	if (_skillLevel isEqualTo 4) then {
		_aimingAccuracy = 	1;
		_aimingShake = 		1;
		_aimingSpeed = 		1;
		_commanding = 		1;
		_courage = 			1;
		_endurance = 		1;
		_general = 			1;
		_reloadSpeed = 		1;
		_spotDistance = 	1;
		_spotTime = 		1;
		_fleeing = 			0;
	};
} else {
	_aimingAccuracyDefault = [0.15,0.17] select ((count allPlayers) > 20);
	// no skill
	if (_skillLevel isEqualTo 0) then {
		_aimingAccuracy = 	0;
		_aimingShake = 		0;
		_aimingSpeed = 		0;
		_commanding = 		0;
		_courage = 			0;
		_endurance = 		0;
		_general = 			0;
		_reloadSpeed = 		0;
		_spotDistance = 	0;
		_spotTime = 		0;
		_fleeing = 			0;
	};
	// normal skill
	if (_skillLevel isEqualTo 1) then {
		_aimingAccuracy = 	[_aimingAccuracyDefault,0.14] select ((random 1) > 0.5);
		_aimingShake = 		random [0.55,0.6,0.65];
		_aimingSpeed = 		random [0.4,0.45,0.5];
		_commanding = 		1;
		_courage = 			1;
		_endurance = 		1;
		_general = 			1;
		_reloadSpeed = 		random [0.5,0.55,0.6];
		_spotDistance = 	random [0.55,0.6,0.65];
		_spotTime = 		random [0.55,0.6,0.65];
		_fleeing = 			0;
	};
	// hard skill
	if (_skillLevel isEqualTo 2) then {
		_aimingAccuracy = 	[_aimingAccuracyDefault,0.14] select ((random 1) > 0.5);
		_aimingShake = 		random [0.6,0.65,0.7];
		_aimingSpeed = 		random [0.5,0.55,0.6];
		_commanding = 		1;
		_courage = 			1;
		_endurance = 		1;
		_general = 			1;
		_reloadSpeed = 		random [0.8,0.85,0.9];
		_spotDistance = 	random [0.65,0.7,0.75];
		_spotTime = 		random [0.65,0.7,0.75];
		_fleeing = 			0;
	};
	// very hard skill
	if (_skillLevel isEqualTo 3) then {
		_aimingAccuracy = 	[_aimingAccuracyDefault,0.2] select ((random 1) > 0.5);
		_aimingShake = 		random [0.7,0.75,0.8];
		_aimingSpeed = 		random [0.5,0.55,0.6];
		_commanding = 		1;
		_courage = 			1;
		_endurance = 		1;
		_general = 			1;
		_reloadSpeed = 		1;
		_spotDistance = 	random [0.8,0.85,0.9];
		_spotTime = 		random [0.65,0.7,0.75];
		_fleeing = 			0;
	};
	// max skill
	if (_skillLevel isEqualTo 4) then {
		_aimingAccuracy = 	1;
		_aimingShake = 		1;
		_aimingSpeed = 		1;
		_commanding = 		1;
		_courage = 			1;
		_endurance = 		1;
		_general = 			1;
		_reloadSpeed = 		1;
		_spotDistance = 	1;
		_spotTime = 		1;
		_fleeing = 			0;
	};
};
private _unit = objNull;
private _skills = [];
{
	_unit = _x;
	_unit setSkill 0.5;
	_unit allowFleeing _fleeing;
	_skills = [];
	{
		_unit setSkill _x;
		_skills pushBack _x;
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
	_unit setVariable ['QS_AI_unit_skill',_skills,FALSE];
} forEach _unitsArray;