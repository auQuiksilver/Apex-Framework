/*/
File: fn_artillery.sqf
Author:

	Quiksilver
	
Last modified:

	29/12/2022 A3 2.10 by Quiksilver
	
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
		_arty setPosASL (AGLToASL _pos);
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
		_arty enableVehicleCargo FALSE;
		_arty setFuel 0;
		_arty allowService 0;
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
		if ((missionNamespace getVariable ['QS_missionConfig_arty',0]) isEqualTo 2) then {
			[2] call QS_fnc_artillery;
		};
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
			['sideChat',[WEST,'HQ'],(format ['%1 %2',_dn,localize 'STR_QS_Chat_024'])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
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

if (_type isEqualTo 2) exitWith {
	_arty = missionNamespace getVariable ['QS_arty',objnull];
	if (
		(!alive _arty)
	) exitWith {};
	_arty lock 2;
	_arty enableDynamicSimulation FALSE;
	_arty setVariable ['QS_dynSim_ignore',TRUE,TRUE];
	_arty setVariable ['QS_interaction_disabled',TRUE,TRUE];
	_arty setVariable ['QS_fireSupport',TRUE,TRUE];
	private _crewType = QS_core_units_map getOrDefault ['b_crew_f','b_crew_f'];
	if (_crewType isEqualTo '') then {
		_crewType = 'b_crew_f';
	};
	_grp = createGroup [WEST,TRUE];
	_crewman = _grp createUnit [_crewType,getPosASL _arty,[],0,'NONE'];
	_crewman allowDamage FALSE;
	_crewman assignAsGunner _arty;
	_crewman moveInGunner _arty;
	_crewman setVariable ['QS_fireSupport',TRUE,TRUE];
	_crewman setVariable ['QS_curator_disableEditability',TRUE,FALSE];
	_grp setGroupIdGlobal [localize 'STR_QS_Notif_098'];
	_grp enableDynamicSimulation FALSE;
	_grp setVariable ['QS_dynSim_ignore',TRUE,TRUE];
	_grp setVariable ['QS_fireSupport',TRUE,TRUE];
	_grp setVariable ['QS_curator_disableEditability',TRUE,FALSE];
	_arty setVariable ['QS_fireSupport_msgCooldown',diag_tickTime + 60,FALSE];
	_arty addEventHandler [
		'Fired',
		{
			params ['_vehicle'];
			if (!isNull (_this # 6)) then {
				if ((toLowerANSI (_this # 5)) in ['8rnd_82mm_mo_shells','12rnd_230mm_rockets','32rnd_155mm_mo_shells','4rnd_155mm_mo_guided','2rnd_155mm_mo_lg','magazine_shipcannon_120mm_he_shells_x32','magazine_shipcannon_120mm_he_guided_shells_x2','magazine_shipcannon_120mm_he_lg_shells_x2','magazine_missiles_cruise_01_x18']) then {
					if ((toLowerANSI (_this # 5)) in ['8rnd_82mm_mo_shells']) then {
						(_this # 6) addEventHandler ['Explode',{(_this + [0]) spawn (missionNamespace getVariable 'QS_fnc_craterEffect')}];
					} else {
						(_this # 6) addEventHandler ['Explode',{(_this + [1]) spawn (missionNamespace getVariable 'QS_fnc_craterEffect')}];
					};
				};
			};
			if (diag_tickTime > (_vehicle getVariable ['QS_fireSupport_msgCooldown',-1])) then {
				_vehicle setVariable ['QS_fireSupport_msgCooldown',diag_tickTime + 60,FALSE];
				_firingMessages = [
					localize 'STR_QS_Chat_174',
					localize 'STR_QS_Chat_175'
				];
				['sideChat',[WEST,'BLU'],(selectRandom _firingMessages)] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
			};
			_vehicle setVehicleAmmo 1;
		}
	];
};