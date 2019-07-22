/*/
File: fn_clientEventHit.sqf
Author:

	Quiksilver
	
Last modified:

	18/12/2018 A3 1.88 by Quiksilver
	
Description:

	-
__________________________________________________/*/

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
	{((_unit getVariable ['QS_tto',0]) > 3)} ||
	{(!((lifeState _unit) in ['HEALTHY','INJURED']))} ||
	{(['U_O',(uniform _unit),FALSE] call (missionNamespace getVariable 'QS_fnc_inString'))} ||
	{((!isNull _instigator) && ((side (group _instigator)) in ((_unit getVariable ['QS_unit_side',WEST]) call (missionNamespace getVariable 'QS_fnc_enemySides'))))} ||
	{((missionNamespace getVariable 'QS_sub_sd') && ((count _this) <= 4))}
) exitWith {
	if (!isNull _instigator) then {
		if (alive _instigator) then {
			if (!isPlayer _instigator) then {
				if ((side (group _instigator)) isEqualTo (_unit getVariable ['QS_unit_side',WEST])) then {
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
if (diag_tickTime < (uiNamespace getVariable ['QS_robocop_timeout',-1])) exitWith {};
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
_vTypeL = toLower _vType;
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
	(missionNamespace getVariable 'QS_managed_hints') pushBack [1,TRUE,10,-1,_text,[],(serverTime + 20),TRUE,'Robocop',TRUE];
};
if (_v isKindOf 'StaticWeapon') then {
	_gunnerVehicles = [
		'b_g_mortar_01_f','b_hmg_01_f','b_hmg_01_high_f','b_hmg_01_a_f','b_gmg_01_f','b_gmg_01_high_f','b_gmg_01_a_f','b_mortar_01_f','b_static_aa_f','b_static_at_f','b_t_hmg_01_f','b_t_gmg_01_f','b_t_mortar_01_f',
		'b_t_static_aa_f','b_t_static_at_f','o_hmg_01_f','o_hmg_01_high_f','o_hmg_01_a_f','o_gmg_01_f','o_gmg_01_high_f','o_gmg_01_a_f','o_mortar_01_f','o_static_aa_f','o_static_at_f','o_g_mortar_01_f','i_hmg_01_f',
		'i_hmg_01_high_f','i_hmg_01_a_f','i_gmg_01_f','i_gmg_01_high_f','i_gmg_01_a_f','i_mortar_01_f','i_static_aa_f','i_static_at_f','i_g_mortar_01_f'
	];
	if (!isNull (gunner _v)) then {
		if (isPlayer (gunner _v)) then {
			_causedBy1 = gunner _v;
			_n1 = name _causedBy1;
			_uid1 = getPlayerUID _causedBy1;
			_text = format ['You were wounded by %1, operating a(n) %2 Static Weapon',_n1,_vtxt];
			(missionNamespace getVariable 'QS_managed_hints') pushBack [1,TRUE,10,-1,_text,[],(serverTime + 20),TRUE,'Robocop',TRUE];
		};
	};
};

if ((_v isKindOf 'LandVehicle') || {(_v isKindOf 'Ship')}) then {
	_gunnerVehicles = [
		'b_g_offroad_01_armed_f','b_mrap_01_gmg_f','b_mrap_01_hmg_f','b_lsv_01_armed_f','b_t_mrap_01_gmg_f','b_t_mrap_01_hmg_f','b_t_lsv_01_armed_f','o_mrap_02_gmg_f',
		'o_mrap_02_hmg_f','o_lsv_02_armed_f','b_apc_wheeled_01_cannon_f','b_apc_tracked_01_crv_f','b_apc_tracked_01_rcws_f','b_t_apc_wheeled_01_cannon_f','b_t_apc_tracked_01_crv_f',
		'b_t_apc_tracked_01_rcws_f','o_apc_tracked_02_cannon_f','o_apc_wheeled_02_rcws_f','o_apc_wheeled_02_rcws_v2_f','o_t_apc_tracked_02_cannon_ghex_f','o_t_apc_wheeled_02_rcws_v2_ghex_f',
		'o_t_apc_wheeled_02_rcws_ghex_f','o_t_mrap_02_gmg_ghex_f','o_t_mrap_02_hmg_ghex_f','o_t_lsv_02_armed_f','o_g_offroad_01_armed_f','i_apc_wheeled_03_cannon_f','i_apc_tracked_03_cannon_f',
		'i_mrap_03_gmg_f','i_mrap_03_hmg_f','i_g_offroad_01_armed_f',
		'b_mbt_01_cannon_f','b_t_mbt_01_cannon_f','b_mbt_01_mlrs_f','b_t_mbt_01_mlrs_f','b_lsv_01_armed_black_f','b_lsv_01_armed_olive_f','b_lsv_01_armed_sand_f','b_t_lsv_01_armed_black_f',
		'b_t_lsv_01_armed_ctrg_f','b_t_lsv_01_armed_olive_f','b_t_lsv_01_armed_sand_f','o_lsv_02_armed_arid_f','o_lsv_02_armed_black_f','o_lsv_02_armed_ghex_f','o_lsv_02_armed_viper_f',
		'b_g_offroad_01_at_f','b_lsv_01_at_f','b_t_lsv_01_at_f','o_lsv_02_at_f','o_t_lsv_02_at_f',
		'o_g_offroad_01_at_f','i_g_offroad_01_at_f','i_c_offroad_02_lmg_f','i_c_offroad_02_at_f',
		'i_lt_01_aa_f','i_lt_01_at_f','i_lt_01_cannon_f','i_truck_02_mrl_f','b_afv_wheeled_01_cannon_f','b_t_afv_wheeled_01_cannon_f'
	];
	_gunnerCommanderVehicles = [
		'b_boat_armed_01_minigun_f','b_t_boat_armed_01_minigun_f','o_boat_armed_01_hmg_f','i_boat_armed_01_minigun_f','b_mbt_01_arty_f','b_t_mbt_01_arty_f','b_mbt_01_tusk_f',
		'b_t_mbt_01_tusk_f','o_mbt_02_cannon_f','o_mbt_02_arty_f','o_t_mbt_02_arty_ghex_f','o_t_mbt_02_cannon_ghex_f','o_t_boat_armed_01_hmg_f','i_mbt_03_cannon_f',
		'b_afv_wheeled_01_up_cannon_f','b_t_afv_wheeled_01_up_cannon_f','o_mbt_04_cannon_f','o_mbt_04_command_f','o_t_mbt_04_cannon_f','o_t_mbt_04_command_f'
	];
	if ((_vTypeL in _gunnerVehicles) || {(_vTypeL in _gunnerCommanderVehicles)}) then {
		if (_vTypeL in _gunnerVehicles) then {
			if ((_posObject distance2D _posCausedBy) > 15) then {
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
				(missionNamespace getVariable 'QS_managed_hints') pushBack [1,TRUE,10,-1,_text,[],(serverTime + 20),TRUE,'Robocop',TRUE];
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
				(missionNamespace getVariable 'QS_managed_hints') pushBack [1,TRUE,10,-1,_text,[],(serverTime + 20),TRUE,'Robocop',TRUE];
			};
		};
		if (_vTypeL in _gunnerCommanderVehicles) then {
			if ((_posObject distance2D _posCausedBy) > 15) then {
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
				(missionNamespace getVariable 'QS_managed_hints') pushBack [1,TRUE,10,-1,_text,[],(serverTime + 20),TRUE,'Robocop',TRUE];
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
				(missionNamespace getVariable 'QS_managed_hints') pushBack [1,TRUE,10,-1,_text,[],(serverTime + 20),TRUE,'Robocop',TRUE];
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
			(missionNamespace getVariable 'QS_managed_hints') pushBack [1,TRUE,10,-1,_text,[],(serverTime + 20),TRUE,'Robocop',TRUE];
		} else {	
			if (!isNull (driver _v)) then {
				if (isPlayer (driver _v)) then {
					_causedBy1 = driver _v;
					_n1 = name _causedBy1;
					_uid1 = getPlayerUID _causedBy1;
					_text = format ['You were wounded, likely by %1, driving a(n) %2',_n1,_vtxt];
					(missionNamespace getVariable 'QS_managed_hints') pushBack [1,TRUE,10,-1,_text,[],(serverTime + 20),TRUE,'Robocop',TRUE];
				};
			};
		};
	};
	if ((_posCausedBy distance2D _posObject) < 10) then {
		_list = ((_posCausedBy select [0,2]) nearRoads 15) select {(((getModelInfo _x) select 1) isEqualTo '')};
		if ((!(_list isEqualTo [])) || {(isOnRoad _v)} || {(!isNull (roadAt _v))}) then {
			_causedBy1 = objNull;
		};
	};
};

if (_v isKindOf 'Air') then {
	_turretVehicles = [
		'b_ctrg_heli_transport_01_sand_f','b_ctrg_heli_transport_01_tropic_f','b_heli_transport_03_f','b_heli_transport_01_f','b_heli_transport_01_camo_f','b_heli_transport_03_black_f'
	];
	_gunnerVehicles = [
		'b_heli_attack_01_f','o_heli_attack_02_f','o_heli_attack_02_black_f','o_t_vtol_02_infantry_f','o_t_vtol_02_infantry_ghex_f','o_t_vtol_02_infantry_dynamicloadout_f','o_t_vtol_02_vehicle_dynamicloadout_f',
		'o_t_vtol_02_infantry_grey_f','o_t_vtol_02_infantry_hex_f','o_t_vtol_02_vehicle_f','o_t_vtol_02_vehicle_ghex_f',
		'o_t_vtol_02_vehicle_grey_f','o_t_vtol_02_vehicle_hex_f','b_t_vtol_01_armed_blue_f','b_t_vtol_01_armed_f','b_t_vtol_01_armed_olive_f','o_heli_attack_02_dynamicloadout_black_f','o_heli_attack_02_dynamicloadout_f',
		'b_heli_attack_01_dynamicloadout_f'
	];
	_driverGunnerVehicles = [
		'o_heli_light_02_f','o_heli_light_02_v2_f','i_heli_light_03_f','b_heli_light_01_armed_f','o_plane_cas_02_dynamicloadout_f','b_plane_cas_01_f','o_plane_cas_02_dynamicloadout_f','b_plane_cas_01_dynamicloadout_f',
		'i_plane_fighter_03_aa_f','i_plane_fighter_03_cas_f','i_plane_fighter_03_dynamicloadout_f','b_plane_fighter_01_f','b_plane_fighter_01_stealth_f','o_heli_light_02_dynamicloadout_f',
		'i_heli_light_03_dynamicloadout_f','b_heli_light_01_dynamicloadout_f','i_e_heli_light_03_dynamicloadout_f'
	];
	if (_vTypeL in _turretVehicles) then {
		if ((_posObject distance2D _posCausedBy) > 12) then {
			_relDirTo = _causedBy getRelDir _unit;
			if ((_relDirTo <= 180) && (_relDirTo >= 0)) then {
				if (!isNull (_v turretUnit [2])) then {
					if (isPlayer (_v turretUnit [2])) then {
						_causedBy3 = _v turretUnit [2];
						_n3 = name _causedBy3;
						_uid3 = getPlayerUID _causedBy3;
						_text = format ['You were wounded by %1, operating the RIGHT turret of a(n) %2.',_n3,_vtxt];
						(missionNamespace getVariable 'QS_managed_hints') pushBack [1,TRUE,10,-1,_text,[],(serverTime + 20),TRUE,'Robocop',TRUE];
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
							(missionNamespace getVariable 'QS_managed_hints') pushBack [1,TRUE,10,-1,_text,[],(serverTime + 20),TRUE,'Robocop',TRUE];
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
			(missionNamespace getVariable 'QS_managed_hints') pushBack [1,TRUE,12,-1,_text,[],(serverTime + 20),TRUE,'Robocop',TRUE];
		};
	};
	
	if (_vTypeL in _gunnerVehicles) then {
		if ((_posObject distance2D _posCausedBy) > 15) then {
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
			(missionNamespace getVariable 'QS_managed_hints') pushBack [1,TRUE,10,-1,_text,[],(serverTime + 20),TRUE,'Robocop',TRUE];
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
			(missionNamespace getVariable 'QS_managed_hints') pushBack [1,TRUE,10,-1,_text,[],(serverTime + 20),TRUE,'Robocop',TRUE];
		};
	};
	
	if (_vTypeL in _driverGunnerVehicles) then {
		_causedBy1 = driver _v;
		_n1 = name _causedBy1;
		_uid1 = getPlayerUID _causedBy1;
		_text = format ['You were wounded by %1, in a(n) %2.',_n1,_vtxt];
		(missionNamespace getVariable 'QS_managed_hints') pushBack [1,TRUE,10,-1,_text,[],(serverTime + 20),TRUE,'Robocop',TRUE];
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
			(missionNamespace getVariable 'QS_managed_hints') pushBack [1,TRUE,10,-1,_text,[],(serverTime + 20),TRUE,'Robocop',TRUE];
		};
	};
	if (!(_vTypeL in _turretVehicles) && (!(_vTypeL in _gunnerVehicles)) && (!(_vTypeL in _driverGunnerVehicles)) && (!(unitIsUAV _v))) then {
		if (!isNull (driver _v)) then {
			if (isPlayer (driver _v)) then {
				_causedBy1 = driver _v;
				_n1 = name _causedBy1;
				_uid1 = getPlayerUID _causedBy1;
			} else {
				_n1 = '[AI]';
			};
			_text = format ['You were wounded by %1, pilot of a(n) %2.',_n1,_vtxt];
			(missionNamespace getVariable 'QS_managed_hints') pushBack [1,TRUE,10,-1,_text,[],(serverTime + 20),TRUE,'Robocop',TRUE];
		};
	};
	
	if ((_posCausedBy distance2D _posObject) < 15) then {
		_exclusionFound = FALSE;
		if (_v isKindOf 'Helicopter') then {
			_list = nearestObjects [_posCausedBy,[],20,TRUE];
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
			_list = nearestObjects [_posCausedBy,[],20,TRUE];
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
			0 spawn {
				private ['_ti','_tr'];
				_ti = time + 40;
				_image = "media\images\general\robocop.jpg";
				while {(!((missionNamespace getVariable 'QS_sub_actions') isEqualTo []))} do {
					_tr = (_ti - time);
					[(format ['<t size="1.1">ROBOCOP<t/><br/><img size="7" image="%2"/><br/><br/>In your Action Menu (SCROLL MENU), you have the option to anonymously report the incident. This option is available for %1 seconds.',(round _tr),_image])] call (missionNamespace getVariable 'QS_fnc_hint');
					uiSleep 0.5;
					if ((missionNamespace getVariable 'QS_sub_actions') isEqualTo []) exitWith {};
					if (time >= _ti) exitWith {[''] call (missionNamespace getVariable 'QS_fnc_hint');};
				};
				[''] call (missionNamespace getVariable 'QS_fnc_hint');
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