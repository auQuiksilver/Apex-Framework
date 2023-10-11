/*/
File: fn_AIXMissileCountermeasure.sqf
Author:

	Quiksilver
	
Last Modified:

	14/1/2023 A3 2.10 by Quiksilver
	
Description:

	Missile countermeasures for AI
_________________________________________________/*/

params ['_vehicle','','_shooter','_instigator','_projectile'];
if (alive (effectiveCommander _vehicle)) then {
	if (
		(_vehicle isKindOf 'Air') &&
		{(!isNull _projectile)} &&
		{(isNull (objectParent _instigator))} &&
		{((_vehicle distance _shooter) > 1000)} &&
		{((!((vehicle _shooter) isKindOf 'CAManBase')) && (!((vehicle _shooter) isKindOf 'Static')))} &&
		{((random 1) > ([0.75,0.5] select ((count allPlayers) > 15)))}
	) then {
		(group (effectiveCommander _vehicle)) reveal [_shooter,4];
		(group (effectiveCommander _vehicle)) reveal [vehicle _shooter,4];
		if ((random 1) > 0.5) then {
			[_projectile,objNull] remoteExec ['setMissileTarget',_shooter,FALSE];
			(driver _vehicle) spawn {
				scriptName 'QS Incoming Missile Flares';
				_this forceWeaponFire ['CMFlareLauncher','AIBurst'];
				sleep 1;
				_this forceWeaponFire ['CMFlareLauncher','AIBurst'];
				sleep 1;
				_this forceWeaponFire ['CMFlareLauncher','AIBurst'];
			};
		} else {
			[_vehicle,_shooter,_projectile] spawn {
				params ['_vehicle','_shooter','_projectile'];
				_timeout = diag_tickTime + 15;
				waitUntil {
					uiSleep 0.1;
					(((_projectile distance _vehicle) < 150) || {(isNull _projectile)} || {(diag_tickTime >= _timeout)})
				};
				if (!isNull _projectile) then {
					if (diag_tickTime < _timeout) then {
						(driver _vehicle) spawn {
							scriptName 'QS Incoming Missile Flares';
							_this forceWeaponFire ['CMFlareLauncher','AIBurst'];
							sleep 1;
							_this forceWeaponFire ['CMFlareLauncher','AIBurst'];
							sleep 1;
							_this forceWeaponFire ['CMFlareLauncher','AIBurst'];
						};
						[_projectile,objNull] remoteExecCall ['setMissileTarget',_shooter,FALSE];
					};
				};
			};
		};
	};
	if (_vehicle isKindOf 'LandVehicle') then {
		if (alive (effectiveCommander _vehicle)) then {
			if (_vehicle isKindOf 'mbt_04_base_f') then {
				(crew _vehicle) doWatch (getPosATL _shooter);
			};
			if (_vehicle isKindOf 'Tank') then {
				_grp = group (effectiveCommander _vehicle);
				if (!isNull _grp) then {
					{
						_grp reveal _x;
					} forEach [
						[_shooter,4],
						[vehicle _shooter,4],
						[_instigator,4],
						[vehicle _instigator,4]
					];
				};
			};
		};
	};
};
