/*
File: fn_clientInteractCargoManifest.sqf
Author:

	Quiksilver
	
Last Modified:

	7/04/2023 A3 2.12 by Quiksilver
	
Description:

	Quick Summary of Vehicle Cargo
__________________________________________*/

private _vehicle = cameraOn;
if (_vehicle isKindOf 'CAManBase') then {
	_vehicle = cursorObject;
};
if (!alive _vehicle) exitWith {};
private _filtered = [];
{
	if (!isSimpleObject _x) then {
		_filtered pushBackUnique _x;
	};
} forEach ((getVehicleCargo _vehicle) + (attachedObjects _vehicle));
if (_filtered isEqualTo []) exitWith {
	(localize 'STR_QS_Hints_185') call QS_fnc_hint;
};
private _obj = objNull;
private _displayName = QS_hashmap_configfile getOrDefaultCall [
	format ['cfgvehicles_%1_displayname',toLowerANSI (typeOf _vehicle)],
	{getText ((configOf _vehicle) >> 'displayName')},
	TRUE
];
private _text = format ['<t align="center" size="1.1">%1</t><br/><br/>',(_vehicle getVariable ['QS_ST_customDN',_displayName])];
_text = _text + format ['<t align="center" size="0.75">%1</t><br/><br/>',[localize 'STR_QS_Hints_187',localize 'STR_QS_Hints_186'] select (lockedInventory _vehicle)];
_text = _text + format ['<t align="left">%1</t><t align="right">%2</t><br/>',localize 'STR_QS_Hints_182',localize 'STR_QS_Hints_183'];
_text = _text + '<t align="left">_</t><t align="right">_</t><br/>';
{
	_obj = _x;
	_displayName = QS_hashmap_configfile getOrDefaultCall [
		format ['cfgvehicles_%1_displayname',toLowerANSI (typeOf _obj)],
		{getText ((configOf _obj) >> 'displayName')},
		TRUE
	];
	_text = _text + (format ['<t align="left">%1</t><t align="right">%2%3</t><br/>',(_obj getVariable ['QS_ST_customDN',_displayName]),parseNumber (((loadAbs _obj / ((maxLoad _obj) max 1)) * 100) toFixed 0),'%']);
} forEach _filtered;
[_text,TRUE,TRUE,localize 'STR_QS_Hints_184',TRUE] call QS_fnc_hint;