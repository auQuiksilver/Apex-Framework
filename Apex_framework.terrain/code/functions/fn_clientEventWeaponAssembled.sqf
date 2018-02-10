/*/
File: fn_clientEventWeaponAssembled.sqf
Author: 

	Quiksilver
	
Last modified:

	19/01/2018 A3 1.80 by Quiksilver
	
Description:

	Weapon Assembled Event
___________________________________________________________________/*/

params ['_player','_weapon'];
[_player,_weapon] spawn {
	params ['_player','_weapon'];
	_t = diag_tickTime + 2;
	waitUntil {
		uiSleep 0.1;
		((!isNull _weapon) || {(diag_tickTime > _t)})
	};
	if (!isNull _weapon) then {
		if (alive _weapon) then {
			if ((_weapon isKindOf 'StaticWeapon') || {(_weapon isKindOf 'StaticMortar')}) then {
				_weapon setVariable ['QS_RD_draggable',TRUE,TRUE];
				_weapon setVariable ['QS_ropeAttached',FALSE,TRUE];
				_weapon enableVehicleCargo TRUE;
				if (_weapon isKindOf 'StaticWeapon') then {
					player setVariable [
						'QS_client_assembledWeapons',
						((player getVariable 'QS_client_assembledWeapons') + [_weapon]),
						FALSE
					];
				};
				if (_weapon isKindOf 'StaticMortar') then {
					private _array = [];
					private _mortarMagsToRemove = 1;
					{
						_magazineType = _x select 0;
						_turret = _x select 1;
						if ((toLower _magazineType) in ['8rnd_82mm_mo_flare_white','8rnd_82mm_mo_smoke_white']) then {
							_array pushBack [_magazineType,_turret];
						} else {
							if ((toLower _magazineType) in ['8rnd_82mm_mo_shells']) then {
								if (_mortarMagsToRemove > 0) then {
									_mortarMagsToRemove = _mortarMagsToRemove - 1;
									_array pushBack [_magazineType,_turret];
								};
							};
						};
					} forEach (magazinesAllTurrets _weapon);
					if (!(_array isEqualTo [])) then {
						{
							_weapon removeMagazineTurret _x;
						} forEach _array;
					};
				};
			} else {
				if (unitIsUAV _weapon) then {
					_weapon setVehicleReportRemoteTargets FALSE;
					_weapon setVehicleReceiveRemoteTargets FALSE;
					player setVariable [
						'QS_client_assembledWeapons',
						((player getVariable 'QS_client_assembledWeapons') + [_weapon]),
						FALSE
					];
				};
			};
		};
	};
};