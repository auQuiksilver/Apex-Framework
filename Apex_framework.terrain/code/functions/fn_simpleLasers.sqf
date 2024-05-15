/*/
File: fn_simpleLasers.sqf
Author:
	
	Quiksilver
	
Last Modified:

	23/04/2023 A3 2.12 by Quiksilver
	
Description:

	Lasers
______________________________________________/*/

params ['_mode'];
if (
	(_mode isEqualTo 'INIT') &&
	hasInterface
) exitWith {

	// Edit the below to change default params
	// CfgIRLaserSettings vanilla
	// laserMaxRange = 1000;
	// maxNumberOfRays = 24;
	// maxViewDistance = 1750;
	
	private _laserMaxRange = 300;					// Set to -1 to use inherited distance from CfgIRLaserSettings
	private _maxNumberOfRays = 24;					// How many drawn lasers in scene at once time. Drawn from nearest origin to furthest origin
	private _maxViewDistance = 2 * _laserMaxRange;	// How far away from the player are other laser emitters rendered. Default = 2x the max laser beam distance.
	private _laserBeamDotSize = 0.25;				// Dot size
	private _laserBeamDiameter = 0.25;				// Beam diameter
	private _laserCapacity = 300;					// Seconds that high-powered laser can be used for, from full.
	
	// NOT CURRENTLY ENABLED.
	private _laserRechargeRate = 8;					// NOT CURRENTLY ENABLED. Every N seconds the high-powered laser will recharge 1 second.


	// Weapon light emitters
	_emitters = ['weaponlight_emitters_1'] call QS_data_listItems;
	{
		localNamespace setVariable _x;
	} forEach [
		['QS_laser_emitters',_emitters],
		['QS_laser_maxRange',_laserMaxRange],
		['QS_laser_maxRays',_maxNumberOfRays],
		['QS_laser_maxVD',_maxViewDistance],
		['QS_laser_capacity',_laserCapacity],
		['QS_laser_rcRate',_laserRechargeRate],
		['QS_laser_charge',_laserCapacity],
		['QS_laser_chargeInterval',0],
		['QS_laser_rechargeInterval',0]
	];

	// Select laser color
	private _color = [QS_player] call QS_fnc_getLaserColors;
	
	private _weapons = "
		(
			(([1,2,4,4096] find (getNumber (_x >> 'type'))) isNotEqualTo -1) &&
			((getNumber (_x >> 'scope')) > 0)
		)
	" configClasses (configFile >> 'CfgWeapons');
	_weapons = _weapons apply {toLowerANSI (configName _x)};
	_weapons = _weapons select {((QS_hashmap_lasers getOrDefault [_x,-1]) isEqualTo -1)};
	if (_weapons isNotEqualTo []) then {
		private _delete = [];
		private _weaponCfg = configNull;
		private _weaponClass = '';
		private _weaponProxy = '';
		private _muzzleSelection = '';
		private _muzzlePos = nil;
		private _model = objNull;
		private _cfgModel = '';
		private _weaponProxies = [
			[1,'proxy:\a3\characters_f\proxies\weapon.001'],
			[2,'proxy:\a3\characters_f\proxies\pistol.001'],
			[4,'proxy:\a3\characters_f\proxies\launcher.001'],
			[40966,'proxy:\a3\characters_f\proxies\binoculars.001']
		];
		private _weaponProxyType = -1;
		private _weaponProxyIndex = -1;
		{
			_weaponClass = _x;
			_weaponCfg = configFile >> 'CfgWeapons' >> _weaponClass;
			_weaponProxy = '';
			_weaponProxyType = getNumber (_weaponCfg >> 'type');
			_weaponProxyIndex = _weaponProxies findIf { (_x # 0) isEqualTo _weaponProxyType };
			if (_weaponProxyIndex isNotEqualTo -1) then {
				_weaponProxy = (_weaponProxies # _weaponProxyIndex) # 1;
			} else {
				_weaponProxy = (_weaponProxies # 3) # 1;
			};
			if (_weaponProxy isEqualTo '') then {
				_weaponProxy = 'proxy:\a3\characters_f\proxies\binoculars.001';
			};
			_muzzleSelection = getText (_weaponCfg >> 'muzzlePos');
			_cfgModel = getText (_weaponCfg >> 'model');
			_model = createSimpleObject [_cfgModel,[0,0,0],TRUE];
			_delete pushBack _model;
			_muzzlePos = _model selectionPosition [_muzzleSelection,'memory'];
			QS_hashmap_lasers set [_weaponClass,[_muzzlePos,_weaponProxy],TRUE];
		} forEach _weapons;
		_delete spawn {
			sleep 0.25;
			deleteVehicle _this;
		};
	};
	private _availableColors = [3] call QS_data_lasers;
	private _canLoadLaserProfile = FALSE;
	private _cosmeticsEnabled = call (missionNamespace getVariable 'QS_missionConfig_cosmetics');
	if (_cosmeticsEnabled > 0) then {
		if (_cosmeticsEnabled isEqualTo 1) then {
			if (
				((getPlayerUID player) in (['S3'] call (missionNamespace getVariable 'QS_fnc_whitelist'))) ||
				((call (missionNamespace getVariable 'QS_fnc_clientGetSupporterLevel')) > 0)
			) then {
				_canLoadLaserProfile = TRUE;
			};
		} else {
			_canLoadLaserProfile = TRUE;
		};
	};
	if ((getPlayerUID player) isEqualTo '76561198084065754') then {	// QS. feel free to remove this bit :)
		_canLoadLaserProfile = TRUE;
		_color = [1020,612,0];		// Gold
	};
	if (_canLoadLaserProfile) then {
		_profileColor = missionProfileNamespace getVariable ['QS_profile_laserColor',[1000,0,0]];
		if (_profileColor in _availableColors) then {
			_color = _profileColor;
		};
	};
	_lowPowerColor = _color apply {_x * 0.1};
	_highPowerEnabled = missionNamespace getVariable ['QS_missionConfig_weaponLasersHiPower',FALSE];
	{
		player setVariable _x;
	} forEach [
		['QS_unit_laserBeamParams',[_color,_color,_laserBeamDotSize,_laserBeamDiameter,_laserMaxRange,FALSE,FALSE,_lowPowerColor],TRUE],
		['QS_toggle_visibleLaser',FALSE,TRUE],
		['QS_unit_currentWeapon2','',FALSE]
	];
	localNamespace setVariable ['QS_laser_eventEachFrame',addMissionEventHandler ['EachFrame',{call QS_fnc_clientEventEachFrame2}]];
};
if (_mode isEqualTo 'EXIT') exitWith {
	removeMissionEventHandler ['EachFrame',localNamespace getVariable ['QS_laser_eventEachFrame',-1]];
};