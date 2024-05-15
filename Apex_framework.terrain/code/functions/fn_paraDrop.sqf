/*
@filename: fn_paraDrop.sqf
Author:

	Quiksilver
	
Last modified:

	13/10/2023 A3 2.14 by Quiksilver
	
Description:

	Para Drop
__________________________________________________*/

scriptName 'QS Paradrop';
private ['_v','_openHeight','_t','_p','_ugvTypes'];
_v = _this # 0;
_openHeight = _this # 1;
_ugvTypes = ['O_UGV_01_rcws_F','I_UGV_01_rcws_F'];
_t = time + 120;
waitUntil {
	sleep 0.25;
	(!alive _v) ||
	(isNull _v) ||
	(((getPosATL _v) # 2) < _openHeight)
};
_p = createVehicle ['O_Parachute_02_F',(getPosATL _v),[],0,'FLY'];
[1,_v,[_p,[0,1.25,1.5]]] call QS_fnc_eventAttach;
waitUntil {
	sleep 0.25;
	(isTouchingGround _v) ||
	(((getPos _v) # 2) < 2) ||
	(!alive _v) ||
	(isNull _v) ||
	(time > _t)
};
[0,_v] call QS_fnc_eventAttach;
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
	_p = _this # 0;
	sleep 5;
	if (!isNull _p) then {
		deleteVehicle _p;
	};
};