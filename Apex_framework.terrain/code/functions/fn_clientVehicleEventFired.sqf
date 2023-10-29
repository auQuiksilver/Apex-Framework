/*
File: fn_clientVehicleEventFired.sqf
Author:
	
	Quiksilver
	
Last Modified:

	27/10/2023 A3 2.14 by Quiksilver

Description:

	Event Fired
__________________________________________________________*/

params ['_vehicle','_weapon','_muzzle','_mode','_ammo','_magazine','_projectile','_gunner'];
if (
	(local _vehicle) &&
	{(_weapon in (['heavy_cannons_1',0] call QS_data_listOther))} &&
	{(((vectorMagnitude (velocity _vehicle)) * 3.6) < 80)} &&
	{isTouchingGround _vehicle}
) then {
	_force = (getMass _vehicle) * (random [6,8,10]);
	_vehicleDir = getDir _vehicle;
	_weaponDir = (_vehicle weaponDirection _weapon);
	_deg = (_weaponDir # 0) atan2 (_weaponDir # 1);
	_multiplier = 0.1 max (abs ([_deg,_vehicleDir] call BIS_fnc_getAngleDelta) / 45) min 1;
	_vehicle addForce [_weaponDir vectorMultiply -(_force * _multiplier),getCenterOfMass _vehicle];
};
if (_vehicle isKindOf 'LandVehicle') then {
	if (player isEqualTo (_vehicle turretUnit [0])) then {
		_cursorTarget = cursorTarget;
		_cursorObject = cursorObject;
		if (
			((player getVariable ['QS_tto',0]) > 0) &&
			((!isNull (effectiveCommander _cursorTarget)) || {(!isNull (effectiveCommander _cursorObject))}) &&
			((isPlayer (effectiveCommander _cursorTarget)) || {(isPlayer (effectiveCommander _cursorObject))})
		) then {
			if (local _vehicle) then {
				deleteVehicle _projectile;
			};
			([QS_player,'SAFE'] call QS_fnc_inZone) params ['_inSafezone','_safezoneLevel','_safezoneActive'];
			if (_inSafezone && _safezoneActive && (_safezoneLevel > 1)) then {
				[17,_vehicle] remoteExec ['QS_fnc_remoteExec',2,FALSE];
				50 cutText [localize 'STR_QS_Text_199','PLAIN'];
			};
		};
	};
	if (player isEqualTo (_vehicle turretUnit [1])) then {
		_cursorTarget = cursorTarget;
		_cursorObject = cursorObject;
		if (
			((player getVariable ['QS_tto',0]) > 0) &&
			((!isNull (effectiveCommander _cursorTarget)) || {(!isNull (effectiveCommander _cursorObject))}) &&
			((isPlayer (effectiveCommander _cursorTarget)) || {(isPlayer (effectiveCommander _cursorObject))})
		) then {
			if (local _vehicle) then {
				deleteVehicle _projectile;
			};
			([QS_player,'SAFE'] call QS_fnc_inZone) params ['_inSafezone','_safezoneLevel','_safezoneActive'];
			if (_inSafezone && _safezoneActive && (_safezoneLevel > 1)) then {
				deleteVehicle _vehicle;
				50 cutText [localize 'STR_QS_Text_199','PLAIN'];
			};
		};
	};
};