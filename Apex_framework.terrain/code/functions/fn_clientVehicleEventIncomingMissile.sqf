/*
File: fn_clientVehicleEventIncomingMissile.sqf
Author:
	
	Quiksilver
	
Last Modified:

	24/08/2022 A3 2.10 by Quiksilver

Description:

	Event Incoming Missile
__________________________________________________________*/

params ['_vehicle','_ammo','_shooter','_instigator','_projectile'];
if (!isNull _projectile) then {
	if (((missionNamespace getVariable 'QS_vehicle_incomingMissiles') findIf {(_projectile isEqualTo (_x # 0))}) isEqualTo -1) then {
		missionNamespace setVariable ['QS_vehicle_incomingMissiles',((missionNamespace getVariable 'QS_vehicle_incomingMissiles') select {(!isNull (_x # 0))}),FALSE];
		missionNamespace setVariable ['QS_vehicle_incomingMissiles',((missionNamespace getVariable 'QS_vehicle_incomingMissiles') + [[_projectile,_shooter]]),FALSE];
	};
	if (!(_projectile in (missionNamespace getVariable 'QS_draw2D_projectiles'))) then {
		missionNamespace setVariable [
			'QS_draw2D_projectiles',
			((missionNamespace getVariable 'QS_draw2D_projectiles') + [_projectile]),
			FALSE
		];
	};
	if (!(_projectile in (missionNamespace getVariable 'QS_draw3D_projectiles'))) then {
		missionNamespace setVariable [
			'QS_draw3D_projectiles',
			((missionNamespace getVariable 'QS_draw3D_projectiles') + [_projectile]),
			FALSE
		];
	};
	if ((missionNamespace getVariable ['QS_missionConfig_APS',3]) in [2,3]) then {
		if (_vehicle isKindOf 'LandVehicle') then {
			if (!local _shooter) then {
				if (((vehicle _shooter) isKindOf 'Man') || {((vehicle _shooter) isKindOf 'LandVehicle')} || {((vehicle _shooter) isKindOf 'StaticWeapon')}) then {
					[94,['HANDLE',['AT',_projectile,_shooter,_shooter,getPosATL (vehicle _shooter),TRUE]]] remoteExecCall ['QS_fnc_remoteExec',_shooter,FALSE];
				};
			} else {
				['HANDLE',['AT',_projectile,_shooter,_shooter,getPosATL (vehicle _shooter),TRUE]] call (missionNamespace getVariable 'QS_fnc_clientProjectileManager');	
			};
		};
	};
};
private _cfgRadar = _vehicle getVariable ['QS_vehicle_radarType',-2];
if (_cfgRadar isEqualTo -2) then {
	_cfgRadar = getNumber (configFile >> 'CfgVehicles' >> (typeOf _vehicle) >> 'radarType');
	_vehicle setVariable ['QS_vehicle_radarType',_cfgRadar,FALSE];
};
if (diag_tickTime < (player getVariable ['QS_incomingMissile_active',-1])) exitWith {};
player setVariable ['QS_incomingMissile_active',diag_tickTime + 3,FALSE];
if (!(
	(_vehicle isKindOf 'Air') && 
	(player isEqualTo (driver _vehicle)) && 
	(!((toLowerANSI (typeOf _vehicle)) in ['i_c_plane_civil_01_f','c_plane_civil_01_racing_f','c_plane_civil_01_f']))
)) then {
	playSoundUI ['missile_warning_1',radioVolume max 0.1,1,false];
};
if (_vehicle isKindOf 'LandVehicle') then {
	_soundPath = [(str missionConfigFile), 0, -15] call (missionNamespace getVariable 'BIS_fnc_trimString');
	_soundToPlay = _soundPath + "media\audio\locking_2.wss";
	playSound3D [_soundToPlay, _vehicle, FALSE, getPosASL _vehicle, 10, 1, 50];
};
if (_vehicle isKindOf 'Air') then {
	if (player getVariable ['QS_RD_earplugs',FALSE]) then {
		playSoundUI ['missile_warning_1',radioVolume max 0.1,1,false];
	};
};
private _relDir = _vehicle getRelDir _shooter;
private _relDirText = '';
if ((_relDir > 337.5) || {(_relDir <= 22.5)}) then {
	_relDirText = '( Front )';
} else {
	if ((_relDir > 22.5) && (_relDir <= 67.5)) then {
		_relDirText = '( Front Right )';
	} else {
		if ((_relDir > 67.5) && (_relDir <= 112.5)) then {
			_relDirText = '( Right )';
		} else {
			if ((_relDir > 112.5) && (_relDir <= 157.5)) then {
				_relDirText = '( Rear Right )';
			} else {
				if ((_relDir > 157.5) && (_relDir <= 202.5)) then {
					_relDirText = '( Rear )';
				} else {
					if ((_relDir > 202.5) && (_relDir <= 247.5)) then {
						_relDirText = '( Rear Left )';
					} else {
						if ((_relDir > 247.5) && (_relDir <= 292.5)) then {
							_relDirText = '( Left )';
						} else {
							if ((_relDir > 292.5) && (_relDir <= 337.5)) then {
								_relDirText = '( Front Left )';
							};
						};
					};
				};
			};
		};
	};
};
50 cutText [(format ['Incoming missile! Bearing %1 %2',(round (_vehicle getDir _shooter)),_relDirText]),'PLAIN',0.5];