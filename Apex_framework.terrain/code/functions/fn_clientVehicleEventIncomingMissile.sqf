/*
File: fn_clientVehicleEventIncomingMissile.sqf
Author:
	
	Quiksilver
	
Last Modified:

	27/01/2023 A3 2.12 by Quiksilver

Description:

	Event Incoming Missile
__________________________________________________________*/

params ['_vehicle','_ammo','_shooter','_instigator','_projectile'];
if (!isNull _projectile) then {
	if (((missionNamespace getVariable ['QS_vehicle_incomingMissiles',[]]) findIf {(_projectile isEqualTo (_x # 0))}) isEqualTo -1) then {
		missionNamespace setVariable ['QS_vehicle_incomingMissiles',((missionNamespace getVariable 'QS_vehicle_incomingMissiles') select {(!isNull (_x # 0))}),FALSE];
		missionNamespace setVariable ['QS_vehicle_incomingMissiles',((missionNamespace getVariable 'QS_vehicle_incomingMissiles') + [[_projectile,_shooter]]),FALSE];
	};
	if (!(_projectile in (missionNamespace getVariable 'QS_draw2D_projectiles'))) then {
		missionNamespace setVariable ['QS_draw2D_projectiles',((missionNamespace getVariable 'QS_draw2D_projectiles') + [_projectile]),FALSE];
	};
	if (!(_projectile in (missionNamespace getVariable 'QS_draw3D_projectiles'))) then {
		missionNamespace setVariable ['QS_draw3D_projectiles',((missionNamespace getVariable 'QS_draw3D_projectiles') + [_projectile]),FALSE];
	};
	if ((missionNamespace getVariable ['QS_missionConfig_APS',3]) in [2,3]) then {
		if (_vehicle isKindOf 'LandVehicle') then {
			if (!local _shooter) then {
				if (((vehicle _shooter) isKindOf 'CAManBase') || {((vehicle _shooter) isKindOf 'LandVehicle')} || {((vehicle _shooter) isKindOf 'StaticWeapon')}) then {
					[94,['HANDLE',['AT',_projectile,_shooter,_shooter,getPosATL (vehicle _shooter),TRUE]]] remoteExecCall ['QS_fnc_remoteExec',_shooter,FALSE];
				};
			} else {
				['HANDLE',['AT',_projectile,_shooter,_shooter,getPosATL (vehicle _shooter),TRUE]] call (missionNamespace getVariable 'QS_fnc_clientProjectileManager');	
			};
		};
	};
};
private _text = '';
private _passiveResult = '';
if (local _vehicle) then {
	if (
		((_vehicle animationSourcePhase 'showcamonethull') isEqualTo 1) ||
		{(_vehicle getVariable ['QS_vehicle_stealth',FALSE])} ||
		{((toLowerANSI (typeOf _vehicle)) in (['stealth_aircraft_1'] call QS_data_listVehicles))}
	) then {
		if ((_projectile distance _vehicle) > 300) then {
			if ((random 1) > 0.666) then {
				['setMissileTarget',_projectile,objNull] remoteExec ['QS_fnc_remoteExecCmd',_instigator,FALSE];
				_passiveResult = localize 'STR_QS_Text_383';
			};
		};
	};
};
if (
	(local _vehicle) &&
	{((random 1) < ([_vehicle,_shooter,_projectile] call QS_fnc_vehicleGetPassiveStealth))} &&
	{((_projectile distance _vehicle) > (_vehicle getVariable ['QS_vehicle_passiveStealth_minDist',100]))} &&
	{((!alive _shooter) || ((alive _shooter) && (!(_shooter getVariable ['QS_vehicle_passiveStealth_ignore',FALSE]))))}
) then {
	[_projectile,_instigator,_vehicle] spawn {
		params ['_projectile','_instigator','_vehicle'];
		uiSleep (0.1 + (random 1.5));
		['setMissileTarget',_projectile,objNull] remoteExec ['QS_fnc_remoteExecCmd',_instigator,FALSE];
		['forgetTarget',(group _instigator),_vehicle] remoteExec ['QS_fnc_remoteExecCmd',_instigator,FALSE];
	};
	_passiveResult = localize 'STR_QS_Text_383';
};
if (diag_tickTime < (player getVariable ['QS_incomingMissile_active',-1])) exitWith {};
player setVariable ['QS_incomingMissile_active',diag_tickTime + 2,FALSE];
if (!(
	(_vehicle isKindOf 'Air') && 
	(player isEqualTo (driver _vehicle)) && 
	(!((toLowerANSI (typeOf _vehicle)) in (['civil_aircraft_1'] call QS_data_listVehicles)))
)) then {
	playSoundUI ['missile_warning_1',0.25,1,FALSE];
};
if (_vehicle isKindOf 'LandVehicle') then {
	playSound3D [getMissionPath 'media\audio\locking_2.wss',_vehicle,FALSE,getPosASL _vehicle,5,1,50,0,FALSE];
};
if (
	(_vehicle isKindOf 'Air') &&
	{(soundVolume isEqualTo (getAudioOptionVolumes # 5))}
) then {
	playSoundUI ['missile_warning_1',0.25,1,FALSE];
};
private _relDir = _vehicle getRelDir _shooter;
private _relDirText = '';
if ((_relDir > 337.5) || {(_relDir <= 22.5)}) then {
	_relDirText = format ['( %1 )',localize 'STR_QS_Text_297'];
} else {
	if ((_relDir > 22.5) && (_relDir <= 67.5)) then {
		_relDirText = format ['( %1 )',localize 'STR_QS_Text_298'];
	} else {
		if ((_relDir > 67.5) && (_relDir <= 112.5)) then {
			_relDirText = format ['( %1 )',localize 'STR_QS_Text_299'];
		} else {
			if ((_relDir > 112.5) && (_relDir <= 157.5)) then {
				_relDirText = format ['( %1 )',localize 'STR_QS_Text_300'];
			} else {
				if ((_relDir > 157.5) && (_relDir <= 202.5)) then {
					_relDirText = format ['( %1 )',localize 'STR_QS_Text_301'];
				} else {
					if ((_relDir > 202.5) && (_relDir <= 247.5)) then {
						_relDirText = format ['( %1 )',localize 'STR_QS_Text_302'];
					} else {
						if ((_relDir > 247.5) && (_relDir <= 292.5)) then {
							_relDirText = format ['( %1 )',localize 'STR_QS_Text_303'];
						} else {
							if ((_relDir > 292.5) && (_relDir <= 337.5)) then {
								_relDirText = format ['( %1 )',localize 'STR_QS_Text_304'];
							};
						};
					};
				};
			};
		};
	};
};
private _magazines = [];
private _muzzle = '';
_ammo = toLowerANSI _ammo;
private _ammo2 = '';
private _missileDisplayName = '';
if (_shooter isKindOf 'CAManBase') then {
	_muzzle = (_shooter weaponState (currentMuzzle _shooter)) # 1;
	_magazines = QS_hashmap_configfile getOrDefaultCall [
		format ['cfgweapons_%1_magazines',toLowerANSI _muzzle],
		{getArray (configFile >> 'CfgWeapons' >> _muzzle >> 'magazines')},
		TRUE
	];
	_ammo2 = '';
	_missileDisplayName = '';
	{
		_ammo2 = QS_hashmap_configfile getOrDefaultCall [
			format ['cfgmagazines_%1_ammo',toLowerANSI _x],
			{getText (configFile >> 'CfgMagazines' >> _x >> 'ammo')},
			TRUE
		];
		if ((toLowerANSI _ammo2) isEqualTo _ammo) exitWith {
			_missileDisplayName = QS_hashmap_configfile getOrDefaultCall [
				format ['cfgmagazines_%1_displayname',toLowerANSI _x],
				{getText (configFile >> 'CfgMagazines' >> _x >> 'displayName')},
				TRUE
			];
		};
	} forEach _magazines;
} else {
	_missileDisplayName = QS_hashmap_configfile getOrDefault [format ['cfgammo_%1_displayname',_ammo],''];
	if (_missileDisplayName isEqualTo '') then {
		_magazines = (magazinesAllTurrets _shooter) apply {_x # 0};
		{
			
			_ammo2 = QS_hashmap_configfile getOrDefaultCall [
				format ['cfgmagazines_%1_ammo',toLowerANSI _x],
				{getText (configFile >> 'CfgMagazines' >> _x >> 'ammo')},
				TRUE
			];
			if ((toLowerANSI _ammo2) isEqualTo _ammo) exitWith {
				_missileDisplayName = QS_hashmap_configfile getOrDefaultCall [
					format ['cfgmagazines_%1_displayname',toLowerANSI _x],
					{getText (configFile >> 'CfgMagazines' >> _x >> 'displayName')},
					TRUE
				];
			};
		} forEach _magazines;
		QS_hashmap_configfile set [format ['cfgammo_%1_displayname',_ammo],_missileDisplayName];
	};
};
_text = format ['%1 %2 %3<br/><br/>%4',localize 'STR_QS_Text_200',(round (_vehicle getDir _shooter)),_relDirText,_missileDisplayName];
if (_passiveResult isNotEqualTo '') then {
	_text = _text + (format ['<br/><br/>%1',_passiveResult]);
};
50 cutText [_text,'PLAIN DOWN',0.666,TRUE,TRUE];