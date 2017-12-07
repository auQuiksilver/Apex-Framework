/*
File: fn_AIunitEventFired_1.sqf
Author:

	Quiksilver
	
Last modified:

	14/07/2016 A3 1.62 by Quiksilver
	
Description:

	AI Unit Event Fired
	
_unit = _this select 0;

_unit setVariable ['QS_AI_UNIT_EVENT_FIRED',time,FALSE];

params ['_unit','_weapon','_muzzle','_mode','_ammo','_magazine','_projectile'];

_unit setVariable ['QS_AI_unit_suppressiveFire',0,FALSE];
__________________________________________________*/

_unit = _this select 0;
_unit forceWeaponFire [(_this select 2),'FullAuto'];
if (isNil {_unit getVariable 'QS_AI_unit_suppressiveFire'}) then {
	_unit setVariable ['QS_AI_unit_suppressiveFire',0,FALSE];
} else {
	if (time > (_unit getVariable 'QS_AI_unit_suppressiveFire')) then {
		_unit setVariable ['QS_AI_unit_suppressiveFire',(time + 20),FALSE];
		_unit doSuppressiveFire (assignedTarget _unit);
	};
};