/*/
File: fn_artillery.sqf
Author:

	Quiksilver
	
Last modified:

	01/05/2023 A3 2.10 by Quiksilver
	
Description:

	-
__________________________________________________/*/

private _type = _this # 0;

// Ammo Config (Vanilla assets)
_ammo_MLRS = 6;			// Default 6. How many MLRS rockets per AO.
_ammo_Scorcher = 6;		// Default 6. How many Laser-Guided scorcher magazines per AO (2 shells per magazine).

// INIT / SPAWN
if (_type isEqualTo 0) exitWith {
	if (alive (missionNamespace getVariable ['QS_arty',objnull])) exitWith {};
	if ((missionNamespace getVariable ['QS_missionConfig_arty',0]) isNotEqualTo 0) then {
		private _pos = markerPos ['QS_marker_airbaseArtillery',TRUE];
		private _dir = markerDir 'QS_marker_airbaseArtillery';
		if ((missionNamespace getVariable ['QS_missionConfig_baseLayout',0]) isEqualTo 0) then {
			if (worldName isEqualTo 'Altis') then {
				_dir = 134;
			};
			if (worldName isEqualTo 'Tanoa') then {
				_dir = 77.8;
			};
			if (worldName isEqualTo 'Malden') then {
				_dir = 269.346;
			};
			if (worldName isEqualTo 'Enoch') then {
				_dir = 313.506;
			};
			if (worldName isEqualTo 'Stratis') then {
				_dir = 107;
			};
		};
		_artyType = selectRandom (['base_artillery_1'] call QS_data_listVehicles);
		_arty = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _artyType,_artyType],[0,0,1000],[],0,'NONE'];
		_arty allowDamage FALSE;
		_arty setDir _dir;
		_arty setPos _pos;
		missionNamespace setVariable ['QS_arty',_arty,TRUE];
		// M4 Scorcher
		if (_artyType isKindOf 'B_MBT_01_arty_F') then {
			_arty lockTurret [[0,0],TRUE];
			// Remove all gunner magazines
			{
				_arty removeMagazineTurret [_x,[0]];
			} forEach (_arty magazinesTurret [0]);
			// Remove all commander magazines
			{
				_arty removeMagazineTurret [_x,[0,0]];
			} forEach (_arty magazinesTurret [0,0]);
			// Add back selected gunner magazines
			for '_i' from 0 to (_ammo_Scorcher - 1) step 1 do {
				_arty addMagazineTurret ['2Rnd_155mm_Mo_guided',[0]];
			};
		};
		// M5 MLRS
		if (_artyType isKindOf 'B_MBT_01_mlrs_F') then {
			_arty setMagazineTurretAmmo ['12Rnd_230mm_rockets',_ammo_MLRS,[0]];
		};
		clearWeaponCargoGlobal _arty;
		clearItemCargoGlobal _arty;
		clearMagazineCargoGlobal _arty;
		clearBackpackCargoGlobal _arty;
		_arty lockDriver TRUE;
		_arty enableRopeAttach FALSE;
		_arty setFuel 0;
		_arty allowCrewInImmobile [TRUE,TRUE];
		{
			_arty setVariable _x;
		} forEach [
			['QS_services_reammo_disabled',TRUE,TRUE],
			['QS_cleanup_protected',TRUE,TRUE],
			['QS_inventory_disabled',TRUE,TRUE],
			['QS_curator_disableEditability',TRUE,FALSE],
			['QS_driver_disabled',TRUE,TRUE]
		];
	};
};
// REARM
if (_type isEqualTo 1) exitWith {
	if ((missionNamespace getVariable ['QS_missionConfig_arty',0]) isNotEqualTo 0) then {
		_arty = missionNamespace getVariable ['QS_arty',objNull];
		if (alive _arty) then {
			private _dn = QS_hashmap_configfile getOrDefaultCall [
				format ['cfgvehicles_%1_displayname',toLowerANSI (typeOf _arty)],
				{getText ((configOf _arty) >> 'displayName')},
				TRUE
			];
			// Server-wide Rearm message
			['sideChat',[WEST,'HQ'],(format [localize 'STR_QS_Chat_024',_dn])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
			// M4 Scorcher
			if (_arty isKindOf 'B_MBT_01_arty_F') then {
				['setVehicleAmmo',_arty,1] remoteExec ['QS_fnc_remoteExecCmd',_arty,FALSE];
			};
			// M5 MLRS
			if (_arty isKindOf 'B_MBT_01_mlrs_F') then {
				[
					[_arty,_ammo_MLRS],
					{      
						if ((_this # 0) turretLocal [0]) then {
							(_this # 0) setMagazineTurretAmmo ['12Rnd_230mm_rockets',(_this # 1),[0]];
						};
					}
				] remoteExec ['call',0,FALSE];
			};
		} else {
			// Artillery destroyed somehow, respawn it
			[0] call (missionNamespace getVariable 'QS_fnc_artillery');
		};
	};
	// REARM SHIP TURRETS
	if ((missionNamespace getVariable ['QS_missionConfig_destroyerEnabled',0]) isNotEqualTo 0) then {
		if ((missionNamespace getVariable ['QS_missionConfig_destroyerArtillery',0]) isNotEqualTo 0) then {
			_turrets = (missionNamespace getVariable 'QS_destroyerObject') getVariable ['QS_destroyer_turrets',[]];
			if (_turrets isNotEqualTo []) then {
				private _turret = objNull;
				{
					_turret = _x;
					['setVehicleAmmo',_turret,1] remoteExec ['QS_fnc_remoteExecCmd',_turret,FALSE];
				} forEach _turrets;
			};
		};
	};
};