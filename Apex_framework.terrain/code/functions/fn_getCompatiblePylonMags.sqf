/*/
File: fn_getCompatiblePylonMags.sqf
Author:

	Quiksilver
	
Last Modified:
	
	15/05/2023 A3 2.12 by Quiksilver
	
Description:

	Get Compatible Pylon Magazines, filtered
____________________________________________________/*/

params [
	['_type',0],
	['_vehicle',objNull,[objNull,'']],
	['_pylon',0]
];
if (_type isEqualTo 0) exitWith {
	_airToGroundMissiles = ['air_to_ground_missiles_1'] call QS_data_listItems;
	private _compatiblePylonMagazines = _vehicle getCompatiblePylonMagazines _pylon;
	private _pylonMagazines = [];
	private _isHeli = _vehicle isKindOf 'Helicopter';
	private _ammoText = '';
	if (_pylon isNotEqualTo 0) then {
		_compatiblePylonMagazines = _compatiblePylonMagazines select {
			_ammoText = QS_hashmap_configfile getOrDefaultCall [
				format ['cfgmagazines_%1_ammo',toLowerANSI _x],
				{getText (configFile >> 'CfgMagazines' >> _x >> 'ammo')},
				TRUE
			];
			(
				(!((toLowerANSI _x) in _airToGroundMissiles)) &&
				(!(['cluster',_x,FALSE] call (missionNamespace getVariable 'QS_fnc_inString'))) &&
				(
					(!_isHeli) ||
					(
						_isHeli &&
						(!(['aa',_ammoText,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')))
					)
				)
			)
		};
	} else {
		{
			_pylonMagazines = _x;
			_pylonMagazines = _pylonMagazines select {
				_ammoText = QS_hashmap_configfile getOrDefaultCall [
					format ['cfgmagazines_%1_ammo',toLowerANSI _x],
					{getText (configFile >> 'CfgMagazines' >> _x >> 'ammo')},
					TRUE
				];
				(
					(!((toLowerANSI _x) in _airToGroundMissiles)) &&
					(!(['cluster',_x,FALSE] call (missionNamespace getVariable 'QS_fnc_inString'))) &&
					(
						(!_isHeli) ||
						(
							_isHeli &&
							(!(['aa',_ammoText,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')))
						)
					)
				)
			};
			_compatiblePylonMagazines set [_forEachIndex,_pylonMagazines];
		} forEach _compatiblePylonMagazines;
	};
	_compatiblePylonMagazines
};
[]