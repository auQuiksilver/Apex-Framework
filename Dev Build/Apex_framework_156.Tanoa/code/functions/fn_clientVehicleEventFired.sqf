/*
File: fn_clientVehicleEventFired.sqf
Author:
	
	Quiksilver
	
Last Modified:

	6/07/2016 A3 1.62 by Quiksilver

Description:

	Event Fired
__________________________________________________________*/

params ['_vehicle','_weapon','_muzzle','_mode','_ammo','_magazine','_projectile','_gunner'];
if (_vehicle isKindOf 'LandVehicle') then {
	if (player isEqualTo (_vehicle turretUnit [0])) then {
		_cursorTarget = cursorTarget;
		_cursorObject = cursorObject;
		if ((!isNull (effectiveCommander _cursorTarget)) || {(!isNull (effectiveCommander _cursorObject))}) then {
			if ((isPlayer (effectiveCommander _cursorTarget)) || {(isPlayer (effectiveCommander _cursorObject))}) then {
				deleteVehicle _projectile;
				if (!isNil {player getVariable 'QS_tto'}) then {
					if ((player getVariable 'QS_tto') > 0) then {
						([QS_player,'SAFE'] call QS_fnc_inZone) params ['_inSafezone','_safezoneLevel','_safezoneActive'];
						if (_inSafezone && _safezoneActive && (_safezoneLevel > 1)) then {
							[17,_vehicle] remoteExec ['QS_fnc_remoteExec',2,FALSE];
							50 cutText [localize 'STR_QS_Text_199','PLAIN'];
						};
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
				deleteVehicle _projectile;
				if (!isNil {player getVariable 'QS_tto'}) then {
					if ((player getVariable 'QS_tto') > 0) then {
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
};