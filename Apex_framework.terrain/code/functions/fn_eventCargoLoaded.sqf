/*
File: fn_eventCargoLoaded.sqf
Author:

	Quiksilver
	
Last modified:

	28/01/2023 A3 2.12 by Quiksilver
	
Description:

	Server Cargo Loaded event
__________________________________________________*/


params ['_parent','_child',['_isCustom',FALSE]];
if (!isNull _parent) then {
	if (local _parent) then {
		if (_isCustom) then {
			_parent setMass ((getMass _parent) + (getMass _child));
		};
	} else {
		[_parent,objNull] remoteExec ['QS_fnc_eventCargoLoaded',_parent,FALSE];
	};
	if (
		(_parent isKindOf 'Truck_01_flatbed_base_F') &&
		{(_child isKindOf 'Cargo10_base_F')}
	) then {
		['setDir',_child,270] remoteExec ['QS_fnc_remoteExecCmd',[_child,_parent],FALSE];
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
			_child setVariable ['cargo_isDamageAllowed',isDamageAllowed _child,TRUE];
			_child allowDamage FALSE;
		};
	} else {
		[objNull,_child] remoteExec ['QS_fnc_eventCargoLoaded',_child,FALSE];
	};
};
[_parent,TRUE,TRUE] call QS_fnc_updateCenterOfMass;