/*
File: fn_setFlag.sqf
Author: 

	Quiksilver

Last Modified:

	15/04/2017 A3 1.68 by Quiksilver

Description:

	Set flag state
____________________________________________________________________________*/

params [
	['_flag',objNull],
	['_side',sideUnknown],
	['_texture',''],
	['_setSide',FALSE],
	['_owner',objNull],
	['_animationPhase',1]
];
if (isNull _flag) exitWith {};		// To Do: Check also for isKindOf "FlagCarrier" or whatever it is
if (_texture isEqualTo '') then {
	_sides = [EAST,WEST,RESISTANCE,CIVILIAN,sideUnknown];
	_texture = (missionNamespace getVariable 'QS_module_fob_flag_textures') select (_sides find _side);
};
if ((flagTexture _flag) isNotEqualTo _texture) then {
	_flag setFlagTexture _texture;
};
if (_setSide) then {
	if ((flagSide _flag) isNotEqualTo _side) then {
		_flag setFlagSide _side;
	};
};
if (!isNull _owner) then {
	if ((flagOwner _flag) isNotEqualTo _owner) then {
		_flag setFlagOwner _owner;
	};
};
if ((flagAnimationPhase _flag) isNotEqualTo _animationPhase) then {
	[_flag,_animationPhase,FALSE] call (missionNamespace getVariable 'BIS_fnc_animateFlag');
};