/*/
File: fn_clientInteractVehicleHealth.sqf
Author:
	
	Quiksilver
	
Last Modified:

	11/10/2023 A3 2.14 by Quiksilver

Description:

	Report vehicle state in a hint
__________________________________________/*/

private _vehicle = cameraOn;
if (_vehicle isKindOf 'CAManBase') then {
	_vehicle = cursorObject;
};
(needService _vehicle) params ['_repair','_refuel','_reammo'];
private _count = 0;
private _fullCount = 0;
private _totalCount = 0;
private _totalFullCount = 0;
{
	_fullCount = QS_hashmap_configfile getOrDefaultCall [
		format ['cfgmagazines_%1_count',toLowerANSI (_x # 0)],
		{getNumber (configFile >> 'CfgMagazines' >> (_x # 0) >> 'count')},
		TRUE
	];
	_totalCount = _totalCount + (_x # 1);
	_totalFullCount = _totalFullCount + _fullCount;
} forEach (magazinesAmmoFull [_vehicle,TRUE]);
_displayName = QS_hashmap_configfile getOrDefaultCall [
	format ['cfgvehicles_%1_displayname',toLowerANSI (typeOf _vehicle)],
	{getText ((configOf _vehicle) >> 'displayName')},
	TRUE
];
if (
	(_totalCount isEqualTo 0) ||
	(_totalFullCount isEqualTo 0)
) then {
	_totalCount = 1;
	_totalFullCount = 1;
};
private _text = format [
	'<t align="center" size="1.1">%5</t><br/><br/><t align="left">%6</t><t align="right">%1%4</t><br/><t align="left">%7</t><t align="right">%2%4</t><br/><t align="left">%8</t><t align="right">%3%4</t>   <br/><t align="left">%9</t><t align="right">%10</t>',
	ceil((1 - _repair) * 100),
	ceil((1 - _refuel) * 100),
	ceil((_totalCount / _totalFullCount) * 100),
	'%',
	(_vehicle getVariable ['QS_ST_customDN',_displayName]),
	localize 'STR_QS_Hints_170',
	localize 'STR_QS_Hints_171',
	localize 'STR_QS_Hints_172',
	localize 'STR_QS_Text_468',
	(['NO','YES'] select (waterDamaged _vehicle))
];
_apsParams = _vehicle getVariable ['QS_aps_params',[]];
if (
	(_apsParams isNotEqualTo []) &&
	{_apsParams # 0}
) then {
	_text = _text + format ['<br/><t align="left">%3</t><t align="right">%1 / %2</t>',_vehicle getVariable ['QS_aps_ammo',0],_apsParams # 2,localize 'STR_QS_Dialogs_075'];
};
[_text,TRUE,TRUE,localize 'STR_QS_Hints_169',TRUE] call QS_fnc_hint;