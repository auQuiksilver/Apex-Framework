/*/
File: fn_getCompatiblePylonMags.sqf
Author:

	Quiksilver
	
Last Modified:
	
	18/02/2018 A3 1.80 by Quiksilver
	
Description:

	Get Compatible Pylon Magazines, filtered
____________________________________________________/*/

params [
	['_type',0],
	['_vehicle',objNull,[objNull,'']],
	['_pylon',0]
];
if (_type isEqualTo 0) exitWith {
	_airToGroundMissiles = [
		'pylonmissile_1rnd_lg_scalpel',
		'pylonmissile_missile_agm_02_x1',
		'pylonmissile_missile_agm_02_x2',
		'pylonmissile_missile_agm_kh25_int_x1',
		'pylonmissile_missile_agm_kh25_x1',
		'pylonrack_12rnd_pg_missiles',
		'pylonrack_1rnd_lg_scalpel',
		'pylonrack_1rnd_missile_agm_01_f',
		'pylonrack_1rnd_missile_agm_02_f',
		'pylonrack_3rnd_lg_scalpel',
		'pylonrack_3rnd_missile_agm_02_f',
		'pylonrack_4rnd_lg_scalpel',
		'pylonrack_missile_agm_02_x1',
		'pylonrack_missile_agm_02_x2',
		'pylonmissile_1rnd_mk82_f'
	];
	private _compatiblePylonMagazines = _vehicle getCompatiblePylonMagazines _pylon;
	private _pylonMagazines = [];
	private _isHeli = _vehicle isKindOf 'Helicopter';
	{
		_pylonMagazines = _x;
		_pylonMagazines = _pylonMagazines select {((!((toLower _x) in _airToGroundMissiles)) && (!(['cluster',_x,FALSE] call (missionNamespace getVariable 'QS_fnc_inString'))))};
		if (_isHeli) then {
			_pylonMagazines = _pylonMagazines select {(!(['aa',(getText (configFile >> 'CfgMagazines' >> _x >> 'ammo')),FALSE] call (missionNamespace getVariable 'QS_fnc_inString')))};
		};
		_compatiblePylonMagazines set [_forEachIndex,_pylonMagazines];
	} forEach _compatiblePylonMagazines;
	_compatiblePylonMagazines;
};
[]