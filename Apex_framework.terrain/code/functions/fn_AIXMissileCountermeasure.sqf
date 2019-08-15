/*/
File: fn_AIXMissileCountermeasure.sqf
Author:

	Quiksilver
	
Last Modified:

	19/05/2019 A3 1.92 by Quiksilver
	
Description:

	Extra missile countermeasures for AI
_________________________________________________/*/

params ['_vehicle','_ammo','_shooter','_instigator'];
if (alive (effectiveCommander _vehicle)) then {
	if (_vehicle isKindOf 'Air') then {
		if ((_vehicle distance _shooter) > 500) then {
			private _projectile = nearestObject [_shooter,_ammo];
			if (!isNull _projectile) then {
				(group (effectiveCommander _vehicle)) reveal [_shooter,4];
				(group (effectiveCommander _vehicle)) reveal [vehicle _shooter,4];
				if ((random 1) > 0.5) then {
					[_projectile,objNull] remoteExec ['setMissileTarget',_shooter,FALSE];
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
								[_projectile,objNull] remoteExecCall ['setMissileTarget',_shooter,FALSE];
							};
						};
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
