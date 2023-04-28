/*/
File: fn_getVehicleGunEnd.sqf
Author:

	Quiksilver
	
Last Modified:

	22/12/2022 A3 2.10 by Quiksilver
	
Description:

	Returns selection position(s)
____________________________________________/*/

params [
	['_vehicle',objNull],
	['_type',0]
];
if (isNull _vehicle) exitWith {[0,0,0]};
private _selection = '';
if (_type isEqualTo 0) exitWith {
	// Return gun end
	private _point = _vehicle selectionPosition ['konec hlavne','memory'];
	if (_point isEqualTo [0,0,0]) then {
		_selection = QS_hashmap_configfile getOrDefaultCall [
			format ['cfgvehicles_%1_gunend',toLowerANSI (typeOf _vehicle)],
			{getText ((configOf _vehicle) >> 'CargoTurret' >> 'gunEnd')},
			TRUE
		];
		_point = (_vehicle selectionPosition [_selection,'memory']);
	};
	_point;
};
if (_type isEqualTo 1) exitWith {
	// Return gun beg
	private _point = _vehicle selectionPosition ['usti hlavne','memory'];
	if (_point isEqualTo [0,0,0]) then {
		_selection = QS_hashmap_configfile getOrDefaultCall [
			format ['cfgvehicles_%1_gunbeg',toLowerANSI (typeOf _vehicle)],
			{getText ((configOf _vehicle) >> 'CargoTurret' >> 'gunBeg')},
			TRUE
		];
		_point = (_vehicle selectionPosition [_selection,'memory']);
	};
	_point;
};
if (_type isEqualTo 2) exitWith {
	// Return gun end and gun beg
	private _point1 = _vehicle selectionPosition ['konec hlavne','memory'];
	if (_point1 isEqualTo [0,0,0]) then {
		_selection = QS_hashmap_configfile getOrDefaultCall [
			format ['cfgvehicles_%1_gunend',toLowerANSI (typeOf _vehicle)],
			{getText ((configOf _vehicle) >> 'CargoTurret' >> 'gunEnd')},
			TRUE
		];
		_point1 = (_vehicle selectionPosition [_selection,'memory']);
	};
	private _point2 = _vehicle selectionPosition ['usti hlavne','memory'];
	if (_point2 isEqualTo [0,0,0]) then {
		_selection = QS_hashmap_configfile getOrDefaultCall [
			format ['cfgvehicles_%1_gunbeg',toLowerANSI (typeOf _vehicle)],
			{getText ((configOf _vehicle) >> 'CargoTurret' >> 'gunBeg')},
			TRUE
		];
		_point2 = (_vehicle selectionPosition [_selection,'memory']);
	};
	[_point2,_point1]		// gun beg,gun end
};
[0,0,0]