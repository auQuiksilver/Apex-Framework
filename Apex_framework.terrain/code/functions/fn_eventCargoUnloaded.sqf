/*
File: fn_eventCargoUnloaded.sqf
Author:

	Quiksilver
	
Last modified:

	28/01/2023 A3 2.12 by Quiksilver
	
Description:

	Server Cargo Unloaded
__________________________________________________*/

params ['_parent','_child',['_isCustom',FALSE]];
if (!isNull _parent) then {
	if (local _parent) then {
		if (_isCustom) then {
			_parent setMass ((getMass _parent) - (getMass _child));
		};
	} else {
		[_parent,objNull] remoteExec ['QS_fnc_eventCargoUnloaded',_parent,FALSE];
	};
};
if (!isNull _child) then {
	if (local _child) then {
		if (isEngineOn _child) then {
			_child engineOn FALSE;
		};
		if (
			(_child isKindOf 'StaticWeapon') ||
			{(_child isKindOf 'Reammobox_F')}
		) then {
			_child allowDamage (_child getVariable ['cargo_isDamageAllowed',TRUE]);
		};
	} else {
		[objNull,_child] remoteExec ['QS_fnc_eventCargoUnloaded',_child,FALSE];
	};
};
[_parent,TRUE,TRUE] call QS_fnc_updateCenterOfMass;