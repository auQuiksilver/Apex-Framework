/*
File: fn_clientEventHit.sqf
Author:

	Quiksilver
	
Last modified:

	25/02/2017 A3 1.66 by Quiksilver
	
Description:

	-
	
Notes:

	Most of this function is obsolete, since introduction of _instigator param in Arma 3 v1.65
	
	(most of this function is just determining instigator
	
	https://community.bistudio.com/wiki/Arma_3:_Event_Handlers#Hit
__________________________________________________*/

params [['_unit',objNull],['_causedBy',objNull],['_dmg',0],['_instigator',objNull]];
private _vu = vehicle _unit;
private _v = vehicle _causedBy;
if (
	(isNull _causedBy) ||
	{((!isPlayer _causedBy) && (!(unitIsUAV _causedBy)))} ||
	{((crew _causedBy) isEqualTo [])} ||
	{(_unit isEqualTo _causedBy)} ||
	{(_vu isEqualTo _v)} ||
	{((rating _unit) < 0)} ||
	{((player getVariable 'QS_tto') > 3)} ||
	{(!((lifeState player) in ['HEALTHY','INJURED']))} ||
	{(['U_O',(uniform player),FALSE] call (missionNamespace getVariable 'QS_fnc_inString'))} ||
	{((missionNamespace getVariable 'QS_sub_sd') && ((count _this) <= 4))}
) exitWith {
	if (!isNull _instigator) then {
		if (alive _instigator) then {
			if (!isPlayer _instigator) then {
				if ((side _instigator) isEqualTo WEST) then {
					if (_dmg > 0.25) then {
						[17,_instigator] remoteExec ['QS_fnc_remoteExec',2,FALSE];
					};
				};
			};
		};
	};
};
private [
	'_val','_obj','_turretVehicles','_posObject','_causedBy1','_causedBy2','_causedBy3',
	'_uid1','_uid2','_uid3','_n1','_n2','_n3','_currentWeapon1','_currentWeaponText','_posCausedBy','_gunnerVehicles',
	'_gunnerCommanderVehicles','_driverGunnerVehicles','_planeVehicles','_relDirTo','_hitVal',
	'_hitConstraint','_list','_exclusions','_exclusionFound','_exit'
];
_exit = FALSE;
missionNamespace setVariable ['QS_sub_sd',TRUE,FALSE];
if (((count _this) > 4) && (time < (missionNamespace getVariable ['QS_sub_ramDetection',0]))) exitWith {};
if ((count _this) > 4) then {
	missionNamespace setVariable ['QS_sub_ramDetection',(time + 30),FALSE];
};
private _text = '';
_causedBy1 = objNull;
_causedBy2 = objNull;
_causedBy3 = objNull;
_uid1 = '';
_uid2 = '';
_uid3 = '';
_n1 = '';
_n2 = '';
_n3 = '';
scopeName 'main';
_vType = typeOf _v;
_vtxt = getText (configFile >> 'CfgVehicles' >> _vType >> 'displayName');
_posObject = getPosATL _unit;
_posCausedBy = getPosATL _causedBy;
if (_v isKindOf 'Man') then {
	_causedBy1 = _causedBy;
	_uid1 = getPlayerUID _causedBy1;
	_n1 = name _causedBy1;
	_currentWeapon1 = currentWeapon _causedBy1;
	_currentWeaponText = getText (configFile >> 'CfgWeapons' >> _currentWeapon1 >> 'displayName');
	_text = format ['You were wounded by %1, a %2, likely with a %3',_n1,_vtxt,_currentWeaponText];
	(missionNamespace getVariable 'QS_managed_hints') pushBack [1,TRUE,10,-1,_text,[],(serverTime + 20)];
};

if (_v isKindOf 'StaticWeapon') then {
	_gunnerVehicles = [
		"B_G_Mortar_01_F","B_HMG_01_F","B_HMG_01_high_F","B_HMG_01_A_F","B_GMG_01_F","B_GMG_01_high_F","B_GMG_01_A_F","B_Mortar_01_F","B_static_AA_F","B_static_AT_F","B_T_HMG_01_F","B_T_GMG_01_F","B_T_Mortar_01_F",
		"B_T_Static_AA_F","B_T_Static_AT_F","O_HMG_01_F","O_HMG_01_high_F","O_HMG_01_A_F","O_GMG_01_F","O_GMG_01_high_F","O_GMG_01_A_F","O_Mortar_01_F","O_static_AA_F","O_static_AT_F","O_G_Mortar_01_F","I_HMG_01_F",
		"I_HMG_01_high_F","I_HMG_01_A_F","I_GMG_01_F","I_GMG_01_high_F","I_GMG_01_A_F","I_Mortar_01_F","I_static_AA_F","I_static_AT_F","I_G_Mortar_01_F"
	];
	if (!isNull (gunner _v)) then {
		if (isPlayer (gunner _v)) then {
			_causedBy1 = gunner _v;
			_n1 = name _causedBy1;
			_uid1 = getPlayerUID _causedBy1;
			_text = format ['You were wounded by %1, operating a(n) %2 Static Weapon',_n1,_vtxt];
			(missionNamespace getVariable 'QS_managed_hints') pushBack [1,TRUE,10,-1,_text,[],(serverTime + 20)];
		};
	};
};

if ((_v isKindOf 'LandVehicle') || {(_v isKindOf 'Ship')}) then {
	_gunnerVehicles = [
		"B_G_Offroad_01_armed_F","B_MRAP_01_gmg_F","B_MRAP_01_hmg_F","B_LSV_01_armed_F","B_T_MRAP_01_gmg_F","B_T_MRAP_01_hmg_F","B_T_LSV_01_armed_F","O_MRAP_02_gmg_F",
		"O_MRAP_02_hmg_F","O_LSV_02_armed_F","B_APC_Wheeled_01_cannon_F","B_APC_Tracked_01_CRV_F","B_APC_Tracked_01_rcws_F","B_T_APC_Wheeled_01_cannon_F","B_T_APC_Tracked_01_CRV_F",
		"B_T_APC_Tracked_01_rcws_F","O_APC_Tracked_02_cannon_F","O_APC_Wheeled_02_rcws_F","O_T_APC_Tracked_02_cannon_ghex_F","O_T_APC_Wheeled_02_rcws_ghex_F","O_T_MRAP_02_gmg_ghex_F",
		"O_T_MRAP_02_hmg_ghex_F","O_T_LSV_02_armed_F","O_G_Offroad_01_armed_F","I_APC_Wheeled_03_cannon_F","I_APC_tracked_03_cannon_F","I_MRAP_03_gmg_F","I_MRAP_03_hmg_F","I_G_Offroad_01_armed_F",
		"B_MBT_01_cannon_F","B_T_MBT_01_cannon_F","B_MBT_01_mlrs_F","B_T_MBT_01_mlrs_F","B_LSV_01_armed_black_F","B_LSV_01_armed_olive_F","B_LSV_01_armed_sand_F","B_T_LSV_01_armed_black_F",
		"B_T_LSV_01_armed_CTRG_F","B_T_LSV_01_armed_olive_F","B_T_LSV_01_armed_sand_F","O_LSV_02_armed_arid_F","O_LSV_02_armed_black_F","O_LSV_02_armed_ghex_F","O_LSV_02_armed_viper_F"
	];
	_gunnerCommanderVehicles = [
		"B_Boat_Armed_01_minigun_F","B_T_Boat_Armed_01_minigun_F","O_Boat_Armed_01_hmg_F","I_Boat_Armed_01_minigun_F","B_MBT_01_arty_F","B_T_MBT_01_arty_F","B_MBT_01_TUSK_F",
		"B_T_MBT_01_TUSK_F","O_MBT_02_cannon_F","O_MBT_02_arty_F","O_T_MBT_02_arty_ghex_F","O_T_MBT_02_cannon_ghex_F","O_T_Boat_Armed_01_hmg_F","I_MBT_03_cannon_F"
	];
	if ((_vType in _gunnerVehicles) || {(_vType in _gunnerCommanderVehicles)}) then {
		if (_vType in _gunnerVehicles) then {
			if ((_posObject distance _posCausedBy) > 15) then {
				if (!isNull (gunner _v)) then {
					if (isPlayer (gunner _v)) then {
						_causedBy2 = gunner _v;
						_n2 = name _causedBy2;
						_uid2 = getPlayerUID _causedBy2;
					} else {
						_n2 = '[AI]';
					};
				} else {
					_n2 = '[N/A]';
				};
				_text = format ['You were wounded by %1, the gunner of a(n) %2.',_n2,_vtxt];
				(missionNamespace getVariable 'QS_managed_hints') pushBack [1,TRUE,10,-1,_text,[],(serverTime + 20)];
			} else {
				if (!isNull (driver _v)) then {
					if (isPlayer (driver _v)) then {
						_causedBy1 = driver _v;
						_n1 = name _causedBy1;
						_uid1 = getPlayerUID _causedBy1;
					} else {
						_n1 = '[AI]';
					};
				} else {
					_n1 = '[N/A]';
				};
				if (!isNull (gunner _v)) then {
					if (isPlayer (gunner _v)) then {
						_causedBy2 = gunner _v;
						_n2 = name _causedBy2;
						_uid1 = getPlayerUID _causedBy2;
					} else {
						_n2 = '[AI]';
					};
				} else {
					_n2 = '[N/A]'; 
				};
				_text = parseText format ['You were wounded by a(n):<br/> %1.<br/> The crew consists of:<br/> %2 (Driver)<br/> %3 (Gunner)',_vtxt,_n1,_n2];
				(missionNamespace getVariable 'QS_managed_hints') pushBack [1,TRUE,10,-1,_text,[],(serverTime + 20)];
			};
		};
		if (_vType in _gunnerCommanderVehicles) then {
			if ((_posObject distance _posCausedBy) > 15) then {
				if (!isNull (gunner _v)) then {
					if (isPlayer (gunner _v)) then {
						_causedBy2 = gunner _v;
						_n2 = name _causedBy2;
						_uid2 = getPlayerUID _causedBy2;
					} else {
						_n2 = '[AI]';
					};
				} else {
					_n2 = '[N/A]';
				};
				if (!isNull (commander _v)) then {
					if (isPlayer (commander _v)) then {
						_causedBy3 = commander _v;
						_n3 = name _causedBy3;
						_uid3 = getPlayerUID _causedBy3;
					} else {
						_n3 = '[AI]';
					};
				} else {
					_n3 = '[N/A]';
				};
				_text = parseText format ['You were wounded by a(n):<br/> %1. <br/> Its crew consists of:<br/> %2 (Gunner)<br/> %3 (Commander)',_vtxt,_n2,_n3];
				(missionNamespace getVariable 'QS_managed_hints') pushBack [1,TRUE,10,-1,_text,[],(serverTime + 20)];
			} else {
				if (!isNull (driver _v)) then {
					if (isPlayer (driver _v)) then {
						_causedBy1 = driver _v;
						_n1 = name _causedBy1;
						_uid1 = getPlayerUID _causedBy1;
					} else {
						_n1 = '[AI]';
					};
				} else {
					_n1 = '[N/A]';
				};
				if (!isNull (gunner _v)) then {
					if (isPlayer (gunner _v)) then {
						_causedBy2 = gunner _v;
						_n2 = name _causedBy2;
						_uid2 = getPlayerUID _causedBy2;
					} else {
						_n2 = '[AI]';
					};
				} else {
					_n2 = '[N/A]';
				};
				if (!isNull (commander _v)) then {
					if (isPlayer (commander _v)) then {
						_causedBy3 = commander _v;
						_n3 = name _causedBy3;
						_uid3 = getPlayerUID _causedBy3;
					} else {
						_n3 = '[AI]';
					};
				} else {
					_n3 = '[N/A]';
				};
				_text = parseText format ['You were wounded by a(n):<br/> %1.<br/> Its crew consists of:<br/> %2 (Driver)<br/> %3 (Gunner)<br/> %4 (Commander)',_vtxt,_n1,_n2,_n3];
				(missionNamespace getVariable 'QS_managed_hints') pushBack [1,TRUE,10,-1,_text,[],(serverTime + 20)];
			};
		};
	} else {
		if (unitIsUAV _v) then {
			if (isUavConnected _v) then {
				_causedBy1 = (UAVControl _v) select 0;
				_n1 = name _causedBy1;
				_uid1 = getPlayerUID _causedBy1;
			};
			_text = parseText format ['You were wounded by a %1, being controlled by %2',_vtxt,_n1];
			(missionNamespace getVariable 'QS_managed_hints') pushBack [1,TRUE,10,-1,_text,[],(serverTime + 20)];
		} else {	
			if (!isNull (driver _v)) then {
				if (isPlayer (driver _v)) then {
					_causedBy1 = driver _v;
					_n1 = name _causedBy1;
					_uid1 = getPlayerUID _causedBy1;
					_text = format ['You were wounded, likely by %1, driving a(n) %2',_n1,_vtxt];
					(missionNamespace getVariable 'QS_managed_hints') pushBack [1,TRUE,10,-1,_text,[],(serverTime + 20)];
				};
			};
		};
	};
	if ((_posCausedBy distance _posObject) < 10) then {
		_list = (_posCausedBy nearRoads 15) select {(((getModelInfo _x) select 1) isEqualTo '')};
		if (!(_list isEqualTo [])) then {
			_causedBy1 = objNull;
		};
	};
};

if (_v isKindOf 'Air') then {
	_turretVehicles = [
		"B_CTRG_Heli_Transport_01_sand_F","B_CTRG_Heli_Transport_01_tropic_F","B_Heli_Transport_03_F","B_Heli_Transport_01_F","B_Heli_Transport_01_camo_F","B_Heli_Transport_03_black_F"
	];
	_gunnerVehicles = [
		'B_Heli_Attack_01_F','O_Heli_Attack_02_F','O_Heli_Attack_02_black_F',"O_T_VTOL_02_infantry_F","O_T_VTOL_02_infantry_ghex_F","O_T_VTOL_02_infantry_dynamicLoadout_F","O_T_VTOL_02_vehicle_dynamicLoadout_F",
		"O_T_VTOL_02_infantry_grey_F","O_T_VTOL_02_infantry_hex_F","O_T_VTOL_02_vehicle_F","O_T_VTOL_02_vehicle_ghex_F",
		"O_T_VTOL_02_vehicle_grey_F","O_T_VTOL_02_vehicle_hex_F",'B_T_VTOL_01_armed_blue_F','B_T_VTOL_01_armed_F','B_T_VTOL_01_armed_olive_F','O_Heli_Attack_02_dynamicLoadout_black_F','O_Heli_Attack_02_dynamicLoadout_F',
		'B_Heli_Attack_01_dynamicLoadout_F'
	];
	_driverGunnerVehicles = [
		'O_Heli_Light_02_F','O_Heli_Light_02_v2_F','I_Heli_light_03_F','B_Heli_Light_01_armed_F','O_Plane_CAS_02_dynamicLoadout_F','B_Plane_CAS_01_F','O_Plane_CAS_02_dynamicLoadout_F','B_Plane_CAS_01_dynamicLoadout_F',
		'I_Plane_Fighter_03_AA_F','I_Plane_Fighter_03_CAS_F','I_Plane_Fighter_03_dynamicLoadout_F','B_Plane_Fighter_01_F','B_Plane_Fighter_01_Stealth_F','O_Heli_Light_02_dynamicLoadout_F',
		'I_Heli_light_03_dynamicLoadout_F','B_Heli_Light_01_dynamicLoadout_F'
	];
	if (_vType in _turretVehicles) then {
		if ((_posObject distance _posCausedBy) > 12) then {
			_relDirTo = _causedBy getRelDir _unit;
			if ((_relDirTo <= 180) && (_relDirTo >= 0)) then {
				if (!isNull (_v turretUnit [2])) then {
					if (isPlayer (_v turretUnit [2])) then {
						_causedBy3 = _v turretUnit [2];
						_n3 = name _causedBy3;
						_uid3 = getPlayerUID _causedBy3;
						_text = format ['You were wounded by %1, operating the RIGHT turret of a(n) %2.',_n3,_vtxt];
						(missionNamespace getVariable 'QS_managed_hints') pushBack [1,TRUE,10,-1,_text,[],(serverTime + 20)];
					} else {
						_n3 = '[AI]';
					};
				} else {
					_n3 = '[N/A]';
				};
			} else {
				if ((_relDirTo >= 180) && (_relDirTo <= 360)) then {
					if (!isNull (_v turretUnit [1])) then {
						if (isPlayer (_v turretUnit [1])) then {
							_causedBy2 = _v turretUnit [1];
							_n2 = name _causedBy2;
							_uid2 = getPlayerUID _causedBy2;
							_text = format ['You were wounded by %1, operating the LEFT turret of a(n) %2.',_n2,_vtxt];
							(missionNamespace getVariable 'QS_managed_hints') pushBack [1,TRUE,10,-1,_text,[],(serverTime + 20)];
						} else {
							_n2 = '[AI]';
						};
					} else {
						_n2 = '[N/A]';
					};
				} else {
					breakTo 'main';
					_exit = TRUE;
				};
			};
		} else {
			if (!isNull (driver _v)) then {
				if (isPlayer (driver _v)) then {
					_causedBy1 = driver _v;
					_n1 = name _causedBy1;
					_uid1 = getPlayerUID _causedBy1;
				} else {
					_n1 = '[AI]';
				};
			} else {
				_n1 = '[N/A]';
			};
			if (!isNull (_v turretUnit [1])) then {
				if (isPlayer (_v turretUnit [1])) then {
					_causedBy2 = _v turretUnit [1];
					_n2 = name _causedBy2;
					_uid2 = getPlayerUID _causedBy2;
				} else {
					_n2 = '[AI]';
				};
			} else {
				_n2 = '[N/A]';
			};
			if (!isNull (_v turretUnit [2])) then {
				if (isPlayer (_v turretUnit [2])) then {
					_causedBy3 = _v turretUnit [2];
					_n3 = name _causedBy3;
					_uid3 = getPlayerUID _causedBy3;
				} else {
					_n3 = '[AI]';
				};
			} else {
				_n3 = '[N/A]';
			};
			_text = parseText format ['You were wounded by a(n):<br/> %1.<br/> Its crew consists of:<br/>%2 (Pilot). <br/>%3 (Left Turret). <br/>%4 (Right Turret).',_vtxt,_n1,_n2,_n3];
			(missionNamespace getVariable 'QS_managed_hints') pushBack [1,TRUE,12,-1,_text,[],(serverTime + 20)];
		};
	};
	
	if (_vType in _gunnerVehicles) then {
		if ((_posObject distance _posCausedBy) > 15) then {
			if (!isNull (gunner _v)) then {
				if (isPlayer (gunner _v)) then {
					_causedBy2 = gunner _v;
					_n2 = name _causedBy2;
					_uid2 = getPlayerUID _causedBy2;
				} else {
					_n2 = '[AI]';
				};
			} else {
				_n2 = '[N/A]';
			};
			_text = format ['You were wounded by %1, Gunner of a(n) %2.',_n1,_vtxt];
			(missionNamespace getVariable 'QS_managed_hints') pushBack [1,TRUE,10,-1,_text,[],(serverTime + 20)];
		} else {
			if (!isNull (driver _v)) then {
				if (isPlayer (driver _v)) then {
					_causedBy1 = driver _v;
					_n1 = name _causedBy1;
					_uid1 = getPlayerUID _causedBy1;
				} else {
					_n1 = '[AI]';
				};
			} else {
				_n1 = '[N/A]';
			};
			if (!isNull (gunner _v)) then {
				if (isPlayer (gunner _v)) then {
					_causedBy2 = gunner _v;
					_n2 = name _causedBy2;
					_uid1 = getPlayerUID _causedBy2;
				} else {
					_n2 = '[AI]';
				};
			} else {
				_n2 = '[N/A]';
			};
			_text = parseText format ['You were wounded by a(n):<br/> %1. <br/>Its crew consists of:<br/> %2 (Pilot) <br/>%3 (Gunner)',_vtxt,_n1,_n2];
			(missionNamespace getVariable 'QS_managed_hints') pushBack [1,TRUE,10,-1,_text,[],(serverTime + 20)];
		};
	};
	
	if (_vType in _driverGunnerVehicles) then {
		_causedBy1 = driver _v;
		_n1 = name _causedBy1;
		_uid1 = getPlayerUID _causedBy1;
		_text = format ['You were wounded by %1, in a(n) %2.',_n1,_vtxt];
		(missionNamespace getVariable 'QS_managed_hints') pushBack [1,TRUE,10,-1,_text,[],(serverTime + 20)];
	};
	if (unitIsUAV _v) then {
		if (isUavConnected _v) then {
			if (!isNull (driver _v)) then {
				if (isPlayer (driver _v)) then {
					_causedBy1 = driver _v;
					_n1 = name _causedBy1;
					_uid1 = getPlayerUID _causedBy1;
				} else {
					_n1 = '[AI]';
				};
			} else {
				_n1 = '[N/A]';
			};
			if (!isNull (gunner _v)) then {
				if (isPlayer (gunner _v)) then {
					_causedBy2 = gunner _v;
					_n2 = name _causedBy2;
					_uid2 = getPlayerUID _causedBy2;
				} else {
					_n2 = '[AI]';
				};
			} else {
				_n2 = '[N/A]';
			};
			_causedBy1 = (UAVControl _v) select 0;
			_n1 = name _causedBy1;
			_uid1 = getPlayerUID _causedBy1;
			_n3 = '[N/A]';
			if (isManualFire _v) then {
				_mf = '[ON]';
			} else {
				_mf = '[OFF]';
			};
			_text = parseText format ['You were wounded by a(n):<br/> %1.<br/> Its crew consists of:<br/> %2 (Driver)<br/> %3 (Gunner)<br/> Manual-Fire is %4',_vtxt,_n1,_n2,_mf];
			(missionNamespace getVariable 'QS_managed_hints') pushBack [1,TRUE,10,-1,_text,[],(serverTime + 20)];
		};
	};
	if (!(_vType in _turretVehicles) && (!(_vType in _gunnerVehicles)) && (!(_vType in _driverGunnerVehicles)) && (!(unitIsUAV _v))) then {
		if (!isNull (driver _v)) then {
			if (isPlayer (driver _v)) then {
				_causedBy1 = driver _v;
				_n1 = name _causedBy1;
				_uid1 = getPlayerUID _causedBy1;
			} else {
				_n1 = '[AI]';
			};
			_text = format ['You were wounded by %1, pilot of a(n) %2.',_n1,_vtxt];
			(missionNamespace getVariable 'QS_managed_hints') pushBack [1,TRUE,10,-1,_text,[],(serverTime + 20)];
		};
	};
	
	if ((_posCausedBy distance _posObject) < 15) then {
		_exclusionFound = FALSE;
		if (_v isKindOf 'Helicopter') then {
			_list = nearestObjects [_posCausedBy,['House','Building'],20];
			if (!(_list isEqualTo [])) then {
				_exclusions = ['land_helipadsquare_f','land_helipadcivil_f','land_helipadrescue_f','land_helipadcircle_f','land_helipadempty_f','helipadsquare_f','helipadcivil_f','helipadrescue_f','helipadcircle_f','helipadempty_f'];
				{
					if (((toLower (typeOf _x)) in _exclusions) || {(['helipad',((getModelInfo _x) select 1),FALSE] call (missionNamespace getVariable 'QS_fnc_inString'))}) exitWith {
						_causedBy1 = objNull;
					};
				} forEach _list;
				if (_exclusionFound) then {
					_causedBy1 = objNull;
				};
			};
		};
		if (_v isKindOf 'Plane') then {
			_list = nearestObjects [_posCausedBy,['House','Building'],20];
			if (!(_list isEqualTo [])) then {
				_exclusions = ['land_runway_edgelight_blue_f','land_flush_light_green_f','land_flush_light_red_f','land_flush_light_yellow_f','runway_edgelight_blue_F','flush_light_green_f','flush_light_red_f','flush_light_yellow_f','land_tenthangar_v1_f','tenthangar_v1_f'];
				{
					if (((toLower (typeOf _x)) in _exclusions) || {(['runway',((getModelInfo _x) select 1),FALSE] call (missionNamespace getVariable 'QS_fnc_inString'))}) exitWith {
						_exclusionFound = TRUE;
					};
				} forEach _list;
				if (_exclusionFound) then {
					_causedBy1 = objNull;
				};
			};
		};
	};
};

if (_exit) exitWith {
	0 spawn {
		uiSleep 10;
		missionNamespace setVariable ['QS_sub_sd',FALSE,FALSE];
	};
};

[_n1,_causedBy1,_uid1,_n2,_causedBy2,_uid2,_n3,_causedBy3,_uid3,_posObject] spawn {
	params ['_n1','_causedBy1','_uid1','_n2','_causedBy2','_uid2','_n3','_causedBy3','_uid3','_posObject'];
	uiSleep 10;
	waitUntil {
		uiSleep 0.1;
		((lifeState player) in ['HEALTHY','INJURED'])
	};
	private _optionAvailable = FALSE;
	if ((!isNull _causedBy1) || {(!isNull _causedBy2)} || {(!isNull _causedBy3)}) then {
		_optionAvailable = TRUE;
		if (!((missionNamespace getVariable 'QS_sub_actions') isEqualTo [])) then {
			{
				player removeAction _x;
			} count (missionNamespace getVariable 'QS_sub_actions');
			missionNamespace setVariable ['QS_sub_actions',[],FALSE];
		};
		QS_sub_actions01 = player addAction [
			'(ROBOCOP) Do not report the incident',
			(missionNamespace getVariable 'QS_fnc_atReport'),
			[2,'',objNull,[0,0,0],''],
			95,
			TRUE,
			TRUE
		];
		player setUserActionText [QS_sub_actions01,((player actionParams QS_sub_actions01) select 0),(format ["<t size='3'>%1</t>",((player actionParams QS_sub_actions01) select 0)])];
		0 = QS_sub_actions pushBack QS_sub_actions01;
		if (!isNull _causedBy1) then {
			QS_sub_actions02 = player addAction [
				format ['(ROBOCOP) Report %1',_n1],
				(missionNamespace getVariable 'QS_fnc_atReport'),
				[1,_uid1,_causedBy1,_posObject,_n1],
				94,
				TRUE,
				TRUE
			];
			player setUserActionText [QS_sub_actions02,((player actionParams QS_sub_actions02) select 0),(format ["<t size='3'>%1</t>",((player actionParams QS_sub_actions02) select 0)])];
			0 = QS_sub_actions pushBack QS_sub_actions02;
		};
		if (!isNull _causedBy2) then {
			QS_sub_actions03 = player addAction [
				format ['(ROBOCOP) Report %1',_n2],
				(missionNamespace getVariable 'QS_fnc_atReport'),
				[1,_uid2,_causedBy2,_posObject,_n2],
				93,
				TRUE,
				TRUE
			];
			player setUserActionText [QS_sub_actions03,((player actionParams QS_sub_actions03) select 0),(format ["<t size='3'>%1</t>",((player actionParams QS_sub_actions03) select 0)])];
			0 = QS_sub_actions pushBack QS_sub_actions03;
		};
		if (!isNull _causedBy3) then {
			QS_sub_actions04 = player addAction [
				format ['(ROBOCOP) Report %1',_n3],
				(missionNamespace getVariable 'QS_fnc_atReport'),
				[1,_uid3,_causedBy3,_posObject,_n3],
				92,
				TRUE,
				TRUE
			];
			player setUserActionText [QS_sub_actions04,((player actionParams QS_sub_actions04) select 0),(format ["<t size='3'>%1</t>",((player actionParams QS_sub_actions04) select 0)])];
			0 = QS_sub_actions pushBack QS_sub_actions04;
		};
		if (_optionAvailable) then {
			TRUE spawn {
				private ['_ti','_tr'];
				_ti = time + 40;
				_image = "media\images\general\robocop.jpg";
				while {(!((missionNamespace getVariable 'QS_sub_actions') isEqualTo []))} do {
					_tr = (_ti - time);
					hintSilent parseText format ['<t size="1.1">ROBOCOP<t/><br/><img size="7" image="%2"/><br/><br/>In your Action Menu (SCROLL MENU), you have the option to anonymously report the incident. This option is available for %1 seconds.',(round _tr),_image];					
					uiSleep 0.5;
					if ((missionNamespace getVariable 'QS_sub_actions') isEqualTo []) exitWith {};
					if (time >= _ti) exitWith {hintSilent '';};
				};
				hintSilent '';
				if (!((missionNamespace getVariable 'QS_sub_actions') isEqualTo [])) then {
					{player removeAction _x;} count (missionNamespace getVariable 'QS_sub_actions');
					missionNamespace setVariable ['QS_sub_actions',[],FALSE];
				};
				missionNamespace setVariable ['QS_sub_sd',FALSE,FALSE];
			};
		};
	} else {
		missionNamespace setVariable ['QS_sub_sd',FALSE,FALSE];
	};
};