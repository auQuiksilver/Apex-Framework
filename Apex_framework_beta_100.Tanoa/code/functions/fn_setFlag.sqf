/*
File: fn_setFlag.sqf
Author: 

	Quiksilver

Last Modified:

	15/04/2017 A3 1.68 by Quiksilver

Description:

	Set flag state
____________________________________________________________________________*/

params ['_flag','_side','_texture','_setSide','_owner','_animationPhase'];
if (_texture isEqualTo '') then {
	_sides = [EAST,WEST,RESISTANCE,CIVILIAN,sideUnknown];
	_texture = (missionNamespace getVariable 'QS_module_fob_flag_textures') select (_sides find _side);
};
if (!((flagTexture _flag) isEqualTo _texture)) then {
	_flag setFlagTexture _texture;
};
if (_setSide) then {
	if (!((flagSide _flag) isEqualTo _side)) then {
		_flag setFlagSide _side;
	};
};
if (!isNull _owner) then {
	if (!((flagOwner _flag) isEqualTo _owner)) then {
		_flag setFlagOwner _owner;
	};
};
if (!((flagAnimationPhase _flag) isEqualTo _animationPhase)) then {
	[_flag,_animationPhase,FALSE] call (missionNamespace getVariable 'BIS_fnc_animateFlag');
};