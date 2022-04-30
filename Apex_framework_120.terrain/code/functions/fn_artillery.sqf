/*/
File: fn_artillery.sqf
Author:

	Quiksilver
	
Last modified:

	16/08/2018 A3 1.84 by Quiksilver
	
Description:

	-
__________________________________________________/*/

private ['_type','_pos','_dir','_v','_va','_dn','_ammo'];
_type = _this select 0;
_ammo = [
	[0.3,0.50],
	[0.60,0.50],
	[0.90,0.75]
];
_va = [
	['B_MBT_01_arty_F','B_MBT_01_mlrs_F'],
	['B_T_MBT_01_arty_F','B_T_MBT_01_mlrs_F']
] select (worldName in ['Tanoa','Enoch']);
if (_type isEqualTo 0) exitWith {
	if ((!isNil {missionNamespace getVariable 'QS_arty'}) && (!isNull (missionNamespace getVariable 'QS_arty'))) exitWith {};
	if (!((missionNamespace getVariable ['QS_missionConfig_arty',0]) isEqualTo 0)) then {
		_pos = markerPos 'QS_marker_airbaseArtillery';
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
		} else {
			_dir = markerDir 'QS_marker_airbaseArtillery';
		};
		missionNamespace setVariable [
			'QS_arty',
			(createVehicle [(selectRandom _va),[0,0,1000],[],0,'NONE']),
			TRUE
		];
		missionNamespace setVariable [
			'QS_analytics_entities_created',
			((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
			FALSE
		];
		_arty = missionNamespace getVariable 'QS_arty';
		_arty allowDamage FALSE;
		_arty setDir _dir;
		_arty setPos _pos;
		_arty setVariable ['QS_cleanup_protected',TRUE,TRUE];
		_arty setVariable ['QS_inventory_disabled',TRUE,TRUE];
		_arty lockInventory TRUE;
		if (_arty isKindOf 'B_MBT_01_arty_F') then {
			{
				_arty removeMagazineTurret [_x,[0]];
			} forEach (_arty magazinesTurret [0]);
			{
				_arty removeMagazineTurret [_x,[0,0]];
			} forEach (_arty magazinesTurret [0,0]);
			for '_x' from 0 to 3 step 1 do {
				_arty addMagazineTurret ['2Rnd_155mm_Mo_guided',[0]];
			};
			if (local _arty) then {
				/*/_arty setVehicleAmmo ((_ammo select (missionNamespace getVariable 'QS_artilleryUnlock')) select (_va find (typeOf (missionNamespace getVariable 'QS_arty'))));/*/		/*/12 shells/*/
			} else {
				['setVehicleAmmo',_arty,((_ammo select (missionNamespace getVariable 'QS_artilleryUnlock')) select (_va find (typeOf _arty)))] remoteExec ['QS_fnc_remoteExecCmd',_arty,FALSE];
			};
			_arty lockTurret [[0,0],TRUE];
		};
		if ((_arty isKindOf 'B_MBT_01_mlrs_F') || (_arty isKindOf 'B_T_MBT_01_mlrs_F')) then {
			if (local _arty) then {
				_arty setVehicleAmmo ((_ammo select (missionNamespace getVariable 'QS_artilleryUnlock')) select (_va find (typeOf _arty)));		/*/4 shells/*/
			} else {
				['setVehicleAmmo',_arty,((_ammo select (missionNamespace getVariable 'QS_artilleryUnlock')) select (_va find (typeOf _arty)))] remoteExec ['QS_fnc_remoteExecCmd',_arty,FALSE];
			};
		};
		clearWeaponCargoGlobal _arty;
		clearItemCargoGlobal _arty;
		clearMagazineCargoGlobal _arty;
		clearBackpackCargoGlobal _arty;
		if (local _arty) then {
			_arty setFuel 0;
		} else {
			['setFuel',_arty,0] remoteExec ['QS_fnc_remoteExecCmd',_arty,FALSE];
		};
		_arty lockDriver TRUE;
		_arty setVariable ['QS_curator_disableEditability',TRUE,FALSE];
		_arty addEventHandler [
			'Fired',
			{
				if ((missionNamespace getVariable 'QS_artyShells') < 2) then {
					missionNamespace setVariable [
						'QS_analytics_entities_deleted',
						((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),
						FALSE
					];
					deleteVehicle (_this select 6);
					if (local (missionNamespace getVariable 'QS_arty')) then {
						(missionNamespace getVariable 'QS_arty') lockTurret [[0],TRUE];
						['lockTurret',(missionNamespace getVariable 'QS_arty'),[[0],TRUE]] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
						['lock',(missionNamespace getVariable 'QS_arty'),TRUE] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
					} else {
						['lockTurret',(missionNamespace getVariable 'QS_arty'),[[0],TRUE]] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
						['lock',(missionNamespace getVariable 'QS_arty'),TRUE] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
					};
					[24,(missionNamespace getVariable 'QS_arty'),0] remoteExec ['QS_fnc_remoteExec',0,FALSE];
					if ((count (crew (missionNamespace getVariable 'QS_arty'))) > 0) then {
						private _unit = objNull;
						{
							_unit = _x;
							if (alive _unit) then {
								[[],{50 cutText ['The artillery has depleted its allowed shells, no more can be fired until the AO is completed!','PLAIN DOWN',1];}] remoteExec ['call',_unit,FALSE];
							};
							moveOut _unit;
						} count (crew (missionNamespace getVariable 'QS_arty'));
					};
					['lockTurret',(missionNamespace getVariable 'QS_arty'),[[0],TRUE]] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
					['lock',(missionNamespace getVariable 'QS_arty'),TRUE] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
					missionNamespace setVariable ['QS_artyDepleted',[0],TRUE];
				} else {
					missionNamespace setVariable [
						'QS_artyShells',
						((missionNamespace getVariable 'QS_artyShells') - 1),
						TRUE
					];
				};
			}
		];
		[1] call (missionNamespace getVariable 'QS_fnc_artillery');
	};
};
if (_type isEqualTo 1) exitWith {
	if (!((missionNamespace getVariable ['QS_missionConfig_arty',0]) isEqualTo 0)) then {
		if (!isNull (missionNamespace getVariable 'QS_arty')) then {
			if (alive (missionNamespace getVariable 'QS_arty')) then {
				['lock',(missionNamespace getVariable 'QS_arty'),FALSE] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
				_dn = getText (configFile >> 'CfgVehicles' >> (typeOf (missionNamespace getVariable 'QS_arty')) >> 'displayName');
				['sideChat',[WEST,'HQ'],(format ['The %1 has been re-armed!',_dn])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
				if ((missionNamespace getVariable 'QS_arty') isKindOf 'B_MBT_01_arty_F') then {
					[
						[(missionNamespace getVariable 'QS_arty')],
						{
							for '_x' from 0 to 3 step 1 do {
								(_this select 0) removeMagazineTurret ['2Rnd_155mm_Mo_guided',[0]];
							};
							for '_x' from 0 to 3 step 1 do {
								(_this select 0) addMagazineTurret ['2Rnd_155mm_Mo_guided',[0]];
							};
						}
					] remoteExec ['call',(missionNamespace getVariable 'QS_arty'),FALSE];
					missionNamespace setVariable ['QS_artyShells',8,TRUE];
				};
				if ((missionNamespace getVariable 'QS_arty') isKindOf 'B_MBT_01_mlrs_F') then {
					if (local (missionNamespace getVariable 'QS_arty')) then {
						(missionNamespace getVariable 'QS_arty') setVehicleAmmo ((_ammo select (missionNamespace getVariable 'QS_artilleryUnlock')) select (_va find (typeOf (missionNamespace getVariable 'QS_arty'))));			/*/4 shells/*/
					} else {
						['setVehicleAmmo',(missionNamespace getVariable 'QS_arty'),((_ammo select (missionNamespace getVariable 'QS_artilleryUnlock')) select (_va find (typeOf (missionNamespace getVariable 'QS_arty'))))] remoteExec ['QS_fnc_remoteExecCmd',(missionNamespace getVariable 'QS_arty'),FALSE];
					};
					missionNamespace setVariable ['QS_artyShells',4,TRUE];
				};
			} else {
				missionNamespace setVariable ['QS_arty',nil,FALSE];
				[0] call (missionNamespace getVariable 'QS_fnc_artillery');
			};
		} else {
			missionNamespace setVariable ['QS_arty',nil,FALSE];
			[0] call (missionNamespace getVariable 'QS_fnc_artillery');
		};
		if (local (missionNamespace getVariable 'QS_arty')) then {
			(missionNamespace getVariable 'QS_arty') lockTurret [[0],FALSE];
			['lockTurret',(missionNamespace getVariable 'QS_arty'),[[0],FALSE]] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
		} else {
			['lockTurret',(missionNamespace getVariable 'QS_arty'),[[0],FALSE]] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
		};
		['lockTurret',(missionNamespace getVariable 'QS_arty'),[[0],FALSE]] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
		['lock',(missionNamespace getVariable 'QS_arty'),FALSE] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
		[24,(missionNamespace getVariable 'QS_arty'),1] remoteExec ['QS_fnc_remoteExec',0,FALSE];
		missionNamespace setVariable ['QS_artyDepleted',[1],TRUE];
	};
	if (!((missionNamespace getVariable ['QS_missionConfig_destroyerEnabled',0]) isEqualTo 0)) then {
		if (!((missionNamespace getVariable ['QS_missionConfig_destroyerArtillery',0]) isEqualTo 0)) then {
			_turrets = (missionNamespace getVariable 'QS_destroyerObject') getVariable ['QS_destroyer_turrets',[]];
			if (!(_turrets isEqualTo [])) then {
				private _turret = objNull;
				{
					_turret = _x;
					['setVehicleAmmo',_turret,1] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
				} forEach _turrets;
			};
		};
	};
};