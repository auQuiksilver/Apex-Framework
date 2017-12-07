/*
@filename: fn_paraDrop.sqf
Author:

	Quiksilver
	
Last modified:

	29/12/2015 ArmA 3 1.54 by Quiksilver
	
Description:

	Para Drop
__________________________________________________*/

scriptName 'QS Paradrop';
private ['_v','_openHeight','_t','_p','_ugvTypes'];
_v = _this select 0;
_openHeight = _this select 1;
_ugvTypes = ['O_UGV_01_rcws_F','I_UGV_01_rcws_F'];
_t = time + 120;
waitUntil {
	sleep 0.25;
	(!alive _v) ||
	(isNull _v) ||
	(((getPosATL _v) select 2) < _openHeight)
};
_p = createVehicle ['O_Parachute_02_F',(getPosATL _v),[],0,'FLY'];
missionNamespace setVariable [
	'QS_analytics_entities_created',
	((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
	FALSE
];
_v attachTo [_p,[0,1.25,1.5]];
waitUntil {
	sleep 0.25;
	(isTouchingGround _v) ||
	(((getPos _v) select 2) < 2) ||
	(!alive _v) ||
	(isNull _v) ||
	(time > _t)
};
detach _v;
if ((!((typeOf _v) in _ugvTypes))) then {
	if (isNull (driver _v)) then {
		if ((count (crew _v)) > 0) then {
			{
				if (!isNull _x) then {
					if (alive _x) then {
						_x leaveVehicle _v;
						moveOut _x;
						_x leaveVehicle _v;
					};
				};
			} count (crew _v);
		};
	};
};
[_p] spawn {
	_p = _this select 0;
	sleep 5;
	if (!isNull _p) then {
		missionNamespace setVariable [
			'QS_analytics_entities_deleted',
			((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),
			FALSE
		];
		deleteVehicle _p;
	};
};