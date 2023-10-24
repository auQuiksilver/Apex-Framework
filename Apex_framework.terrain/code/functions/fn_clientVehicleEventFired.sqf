/*
File: fn_clientVehicleEventFired.sqf
Author:
	
	Quiksilver
	
Last Modified:

	24/10/2023 A3 2.14 by Quiksilver

Description:

	Event Fired
__________________________________________________________*/

params ['_vehicle','_weapon','_muzzle','_mode','_ammo','_magazine','_projectile','_gunner'];
if (
	(local _vehicle) &&
	{(_weapon in ['cannon_120mm_long','cannon_125mm','cannon_railgun','cannon_125mm_advanced','cannon_120mm'])} &&
	{(((vectorMagnitude (velocity _vehicle)) * 3.6) > 3)} &&
	{(((vectorMagnitude (velocity _vehicle)) * 3.6) < 80)} &&
	{isTouchingGround _vehicle}
) then {
	if (local _vehicle) then {
		_vehicle addForce [(_vehicle weaponDirection _weapon) vectorMultiply -((getMass _vehicle) * 10),getCenterOfMass _vehicle];
	} else {
		['addForce',_vehicle,[(_vehicle weaponDirection _weapon) vectorMultiply -((getMass _vehicle) * 10),getCenterOfMass _vehicle]] remoteExecCall ['QS_fnc_remoteExecCmd',_vehicle,FALSE];
	};
};
if (_vehicle isKindOf 'LandVehicle') then {
	if (player isEqualTo (_vehicle turretUnit [0])) then {
		_cursorTarget = cursorTarget;
		_cursorObject = cursorObject;
		if ((!isNull (effectiveCommander _cursorTarget)) || {(!isNull (effectiveCommander _cursorObject))}) then {
			if ((isPlayer (effectiveCommander _cursorTarget)) || {(isPlayer (effectiveCommander _cursorObject))}) then {
				if ((player getVariable ['QS_tto',0]) > 0) then {
					deleteVehicle _projectile;
					([QS_player,'SAFE'] call QS_fnc_inZone) params ['_inSafezone','_safezoneLevel','_safezoneActive'];
					if (_inSafezone && _safezoneActive && (_safezoneLevel > 1)) then {
						[17,_vehicle] remoteExec ['QS_fnc_remoteExec',2,FALSE];
						50 cutText [localize 'STR_QS_Text_199','PLAIN'];
					};
				};
			};
		};
	};
	if (player isEqualTo (_vehicle turretUnit [1])) then {
		_cursorTarget = cursorTarget;
		_cursorObject = cursorObject;
		if ((!isNull (effectiveCommander _cursorTarget)) || {(!isNull (effectiveCommander _cursorObject))}) then {
			if ((isPlayer (effectiveCommander _cursorTarget)) || {(isPlayer (effectiveCommander _cursorObject))}) then {
				if ((player getVariable ['QS_tto',0]) > 0) then {
					deleteVehicle _projectile;
					([QS_player,'SAFE'] call QS_fnc_inZone) params ['_inSafezone','_safezoneLevel','_safezoneActive'];
					if (_inSafezone && _safezoneActive && (_safezoneLevel > 1)) then {
						deleteVehicle _vehicle;
						50 cutText [localize 'STR_QS_Text_199','PLAIN'];
					};
				};
			};
		};
	};
};