/*/
File: fn_vehicleAPSParams.sqf
Author:

	Quiksilver
	
Last modified:

	12/08/2019 A3 1.94 by Quiksilver
	
Description:

	-//SMOKE_BLINDSPOT
__________________________________________________/*/

if ((_this # 0) isEqualType '') exitWith {
	params ['_type','_vehicle'];
	private _return = TRUE;
	if (_type isEqualTo 'APS_BLINDSPOT') then {
		params ['','','_projectile'];
		if ((['mbt_01_base_f','mbt_02_base_f','mbt_03_base_f','mbt_04_base_f','afv_wheeled_01_base_f'] findIf {(_vehicle isKindOf _x)}) isNotEqualTo -1) then {
			_weaponDir = _vehicle weaponDirection ((weapons _vehicle) # 0);
			_deltaDir = (_projectile getDir _vehicle) - ((_weaponDir # 0) atan2 (_weaponDir # 1));
			if ((_deltaDir < 20) && (_deltaDir > -20)) then {
				_return = FALSE;
			};
		} else {
			if (((_vehicle getRelDir _projectile) > 160) && ((_vehicle getRelDir _projectile) < 200)) then {
				_return = FALSE;
			};
		};
	};
	if (_type isEqualTo 'SMOKE_BLINDSPOT') then {
		params ['','','_projectile'];
		if (isNull _projectile) then {
			_return = FALSE;
		} else {
			if ((['mbt_01_base_f','mbt_02_base_f','mbt_04_base_f','afv_wheeled_01_base_f'] findIf {(_vehicle isKindOf _x)}) isNotEqualTo -1) then {
				_weaponDir = _vehicle weaponDirection ((weapons _vehicle) # 0);
				_deltaDir = (_projectile getDir _vehicle) - ((_weaponDir # 0) atan2 (_weaponDir # 1));
				if ((_deltaDir < 20) && (_deltaDir > -20)) then {
					_return = FALSE;
				};
			} else {
				if (((_vehicle getRelDir _projectile) > 160) && ((_vehicle getRelDir _projectile) < 200)) then {
					if (!(_vehicle isKindOf 'mbt_03_base_f')) then {													// Kuma (MBT_03) has 360 degree smoke field
						_return = FALSE;
					};
				};
			};
		};
	};
	if (_type isEqualTo 'APS_VEHICLE') then {
		if (_vehicle isKindOf 'LandVehicle') then {
			_return = (([
				'mrap_03_base_f',
				'lt_01_base_f',
				'apc_wheeled_01_base_f',
				'apc_wheeled_02_base_f',
				'apc_wheeled_03_base_f',
				'afv_wheeled_01_base_f',
				'apc_tracked_01_base_f',
				'apc_tracked_02_base_f',
				'apc_tracked_03_base_f',
				'mbt_01_base_f',
				'mbt_02_base_f',
				'mbt_03_base_f',
				'mbt_04_base_f'
			] findIf {(_vehicle isKindOf _x)}) isNotEqualTo -1);
		} else {
			_return = FALSE;
		};
	};
	_return;
};
params ['_vehicle'];
_sideNumber = QS_hashmap_configfile getOrDefaultCall [
	format ['cfgvehicles_%1_sidenumber',toLowerANSI (typeOf _vehicle)],
	{getNumber ((configOf _vehicle) >> 'side')},
	TRUE
];
_designation = ['Афганит',localize 'STR_QS_Dialogs_075'] select (_sideNumber in [1,2]);
private _list = [
	(_vehicle isKindOf 'Tank'),							// QS_aps_enabled		- Is the system enabled for these vehicle types
	(_vehicle selectionPosition 'commander_gun'),		// QS_aps_sensorPos		- Where on the vehicle is the projectile sensor
	2,													// QS_aps_maxAmmo		- How much ammo in the magazine
	30,													// QS_aps_reloadTime	- Reload time
	50,													// QS_aps_minRange		- Minimum effective range
	-0.4,												// QS_aps_maxAngle		- Max angle the projectile can be detected at.
	25,													// QS_aps_interceptRange	- Intercept range for the projectile
	0.9,												// QS_aps_randomChance		- Chance that the system works (0-1)
	FALSE,												// QS_aps_disableBlindspot	- Is the APS blind spot disabled.
	_designation
];
if ((['mrap_03_base_f','lt_01_base_f'] findIf {(_vehicle isKindOf _x)}) isNotEqualTo -1) then {
	// Tier 0
	_list = [
		TRUE,												// QS_aps_enabled
		(_vehicle selectionPosition 'commander_gun'),		// QS_aps_sensorPos
		1,													// QS_aps_maxAmmo
		30,													// QS_aps_reloadTime
		50,													// QS_aps_minRange
		-0.5,												// QS_aps_maxAngle
		20,													// QS_aps_interceptRange
		0.75,												// QS_aps_randomChance
		FALSE,												// QS_aps_disableBlindspot
		_designation
	];
};
if ((['apc_wheeled_03_base_f','apc_wheeled_02_base_f','apc_wheeled_01_base_f','afv_wheeled_01_base_f'] findIf {(_vehicle isKindOf _x)}) isNotEqualTo -1) then {
	// Tier 1
	_list = [
		TRUE,												// QS_aps_enabled
		(_vehicle selectionPosition 'commander_gun'),		// QS_aps_sensorPos
		2,													// QS_aps_maxAmmo
		15,													// QS_aps_reloadTime
		50,													// QS_aps_minRange
		-0.5,												// QS_aps_maxAngle
		20,													// QS_aps_interceptRange
		0.8,												// QS_aps_randomChance
		FALSE,												// QS_aps_disableBlindspot
		_designation
	];
};
if ((['apc_tracked_01_base_f','apc_tracked_02_base_f','apc_tracked_03_base_f'] findIf {(_vehicle isKindOf _x)}) isNotEqualTo -1) then {
	// Tier 2
	_list = [
		TRUE,												// QS_aps_enabled
		(_vehicle selectionPosition 'commander_gun'),		// QS_aps_sensorPos
		3,													// QS_aps_maxAmmo
		10,													// QS_aps_reloadTime
		50,													// QS_aps_minRange
		-0.5,												// QS_aps_maxAngle
		20,													// QS_aps_interceptRange
		0.85,												// QS_aps_randomChance
		FALSE,												// QS_aps_disableBlindspot
		_designation
	];
};
if ((['mbt_02_base_f','mbt_03_base_f','mbt_01_base_f'] findIf {(_vehicle isKindOf _x)}) isNotEqualTo -1) then {
	// Tier 3
	_list = [
		TRUE,												// QS_aps_enabled
		(_vehicle selectionPosition 'commander_gun'),		// QS_aps_sensorPos
		4,													// QS_aps_maxAmmo
		7.5,												// QS_aps_reloadTime
		100,												// QS_aps_minRange
		-0.6,												// QS_aps_maxAngle
		25,													// QS_aps_interceptRange
		0.9,												// QS_aps_randomChance
		FALSE,												// QS_aps_disableBlindspot
		_designation
	];
};
if ((['mbt_04_base_f'] findIf {(_vehicle isKindOf _x)}) isNotEqualTo -1) then {
	// Tier 4
	_list = [
		TRUE,												// QS_aps_enabled
		(_vehicle selectionPosition 'commander_gun'),		// QS_aps_sensorPos
		8,													// QS_aps_maxAmmo
		4,													// QS_aps_reloadTime
		150,												// QS_aps_minRange
		-0.7,												// QS_aps_maxAngle
		25,													// QS_aps_interceptRange
		0.9,												// QS_aps_randomChance
		FALSE,												// QS_aps_disableBlindspot
		_designation
	];
};
{
	_vehicle setVariable _x;
} forEach [
	['QS_aps_params',_list,TRUE],
	['QS_aps_ammo',(_list # 2),TRUE],
	['QS_aps_reloadDelay',serverTime + 14,TRUE]
];
_list;