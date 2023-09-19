/*/
File: fn_inZone.sqf
Author:

	Quiksilver
	
Last Modified:

	14/04/2023 A3 2.12 by Quiksilver
	
Description:

	Is entity in a safezone
____________________________________________/*/

params ['_entity',['_zoneType','SAFE',['',[]]],['_simpleReturn',FALSE]];
private _return = [FALSE,0,TRUE,[]];
private _zones = if (_entity isEqualType objNull) then {
	(_entity getVariable ['QS_unit_zones',[]])
} else {
	[]
};
if (_zones isEqualTo []) then {
	_zones = ['GET',_entity,QS_system_zones + QS_system_zonesLocal] call QS_fnc_zoneManager;
};
if (_zones isNotEqualTo []) then {
	{
		if (
			((_zoneType isEqualType '') && {((_x # 2) isEqualTo _zoneType)}) ||
			((_zoneType isEqualType []) && {((_x # 2) in _zoneType)})
		) then {
			if (!(_return # 0)) then {
				_return set [0,TRUE];
			};
			if ((_x # 4) > (_return # 1)) then {
				_return set [1,_x # 4];
			};
			_return set [2,_x # 1];
			if ((_zoneType isEqualType '') && {(_zoneType isEqualTo 'SPEED')}) then {
				_return set [3,((_x # 5) # 0)];
			};
		};
	} forEach _zones;
};
if (_simpleReturn) exitWith {
	((_return # 0) && (_return # 2))
};
_return;