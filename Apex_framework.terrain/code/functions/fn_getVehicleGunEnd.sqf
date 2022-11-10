/*/
File: fn_getVehicleGunEnd.sqf
Author:

	Quiksilver
	
Last Modified:

	30/10/2022 A3 2.10 by Quiksilver
	
Description:

	Returns selection position(s)
____________________________________________/*/

params [
	['_vehicle',objNull],
	['_type',0]
];
if (isNull _vehicle) exitWith {[0,0,0]};
if (_type isEqualTo 0) exitWith {
	// Return gun end
	private _point = _vehicle selectionPosition ['konec hlavne','memory'];
	if (_point isEqualTo [0,0,0]) then {
		diag_log format ['* DEBUG * Getting Gun-End position for %1 %2 * To do: Optimise this *',typeOf _vehicle,_this];
		_point = (_vehicle selectionPosition [(getText (configFile >> 'CfgVehicles' >> (typeOf _vehicle) >> 'CargoTurret' >> 'gunEnd')),'memory']);
	};
	_point;
};
if (_type isEqualTo 1) exitWith {
	// Return gun beg
	private _point = _vehicle selectionPosition ['usti hlavne','memory'];
	if (_point isEqualTo [0,0,0]) then {
		diag_log format ['* DEBUG * Getting Gun-End position for %1 %2 * To do: Optimise this *',typeOf _vehicle,_this];
		_point = (_vehicle selectionPosition [(getText (configFile >> 'CfgVehicles' >> (typeOf _vehicle) >> 'CargoTurret' >> 'gunBeg')),'memory']);
	};
	_point;
};
if (_type isEqualTo 2) exitWith {
	// Return gun end and gun beg
	private _point1 = _vehicle selectionPosition ['konec hlavne','memory'];
	if (_point1 isEqualTo [0,0,0]) then {
		diag_log format ['* DEBUG * Getting Gun-End position for %1 %2 * To do: Optimise this *',typeOf _vehicle,_this];
		_point1 = (_vehicle selectionPosition [(getText (configFile >> 'CfgVehicles' >> (typeOf _vehicle) >> 'CargoTurret' >> 'gunEnd')),'memory']);
	};
	private _point2 = _vehicle selectionPosition ['usti hlavne','memory'];
	if (_point2 isEqualTo [0,0,0]) then {
		diag_log format ['* DEBUG * Getting Gun-End position for %1 %2 * To do: Optimise this *',typeOf _vehicle,_this];
		_point2 = (_vehicle selectionPosition [(getText (configFile >> 'CfgVehicles' >> (typeOf _vehicle) >> 'CargoTurret' >> 'gunBeg')),'memory']);
	};
	[_point2,_point1]		// gun beg,gun end
};
[0,0,0]