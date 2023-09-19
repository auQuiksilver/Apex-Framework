/*
File: fn_clientEventKeyDown2.sqf
Author:
	
	Quiksilver
	
Last Modified:

	3/02/2023 A3 2.12 by Quiksilver

Description:

	Carry Key Down
______________________________________________*/

params ['','_key','_shift','_ctrl','_alt'];
_object = missionNamespace getVariable ['QS_logistics_localTarget',objNull];
if (
	(!isNull _object) &&
	{(_object in (attachedObjects player))}
) then {
	_simulation = QS_hashmap_configfile getOrDefaultCall [
		format ['cfgvehicles_%1_simulation',toLowerANSI (typeOf _object)],
		{(toLowerANSI (getText ((configOf _object) >> 'simulation')))},
		TRUE
	];
	if (_key in (actionKeys 'turretElevationUp')) then {
		_azimuth = _object getVariable ['QS_logistics_azi',0];
		_object setDir _azimuth;
		_azimuth = _azimuth + ([1,5] select (uiNamespace getVariable ['QS_uiaction_turbo',FALSE]));
		if (_azimuth <= 0) then {
			_azimuth = 360;
		};
		if (_azimuth > 360) then {
			_azimuth = 0;
		};
		_object setVariable ['QS_logistics_azi',_azimuth];
	} else {
		_sim1 = ['house'];
		_followRotation = !(_object isKindOf 'StaticWeapon') && !(_simulation in _sim1);
		if (_key in (actionKeys 'turretElevationDown')) then {
			_azimuth = _object getVariable ['QS_logistics_azi',0];
			_object setDir _azimuth;
			_azimuth = _azimuth - ([1,5] select (uiNamespace getVariable ['QS_uiaction_turbo',FALSE]));
			if (_azimuth <= 0) then {
				_azimuth = 360;
			};
			if (_azimuth > 360) then {
				_azimuth = 0;
			};
			_object setVariable ['QS_logistics_azi',_azimuth];
		} else {
			if (_key in (actionKeys 'gunElevUp')) then {
				call (missionNamespace getVariable 'QS_fnc_clientInGameUIPrevAction');
				// Elevation up
			} else {
				if (_key in (actionKeys 'gunElevDown')) then {
					call (missionNamespace getVariable 'QS_fnc_clientInGameUINextAction');
					// Elevation down
				};
			};
		};
	};
};