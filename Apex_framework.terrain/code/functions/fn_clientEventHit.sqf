/*/
File: fn_clientEventHit.sqf
Author:

	Quiksilver
	
Last modified:

	27/04/2022 A3 2.08 by Quiksilver
	
Description:

	-
__________________________________________________/*/

params [
	['_unit',objNull],
	['_causedBy',objNull],
	['_dmg',0],
	['_instigator',objNull]
];
private _vehicleCausedBy = vehicle _causedBy;
private _vehicleUnit = vehicle _unit;
if (
	(isNull _causedBy) ||
	{((!isPlayer _causedBy) && (!isPlayer _instigator) && (!(unitIsUAV _vehicleCausedBy)))} ||
	{((crew _vehicleCausedBy) isEqualTo [])} ||
	{(_unit in [_causedBy,_instigator])} ||
	{(_vehicleUnit isEqualTo _vehicleCausedBy)} ||
	{((rating _unit) < 0)} ||
	{(time < 30)} ||
	{((_unit getVariable ['QS_tto',0]) > 3)} ||
	{(!((lifeState _unit) in ['HEALTHY','INJURED']))} ||
	{(['U_O',(uniform _unit),FALSE] call (missionNamespace getVariable 'QS_fnc_inString'))} ||
	{((!isNull _instigator) && (_instigator in (missionNamespace getVariable ['QS_robocop_excluded',[]])))} ||
	{((!isNull _instigator) && ((side (group _instigator)) in ((_unit getVariable ['QS_unit_side',WEST]) call (missionNamespace getVariable 'QS_fnc_enemySides'))))} ||
	{((missionNamespace getVariable ['QS_robocop_busy',FALSE]) && ((count _this) <= 4))}
) exitWith {
	if (
		(alive _instigator) &&
		{(!isPlayer _instigator)} &&
		{((side (group _instigator)) isEqualTo (_unit getVariable ['QS_unit_side',WEST]))} &&
		{(_dmg > 0.25)}
	) then {
		[17,_instigator] remoteExec ['QS_fnc_remoteExec',2,FALSE];
	};
};
if (
	(diag_tickTime < (uiNamespace getVariable ['QS_robocop_timeout',-1])) ||
	{(missionNamespace getVariable ['QS_robocop_busy',FALSE])}
) exitWith {};
missionNamespace setVariable ['QS_robocop_busy',TRUE,FALSE];
uiNamespace setVariable ['QS_robocop_timeout',diag_tickTime + 3];
private _isUAV = unitIsUAV _vehicleCausedBy;
if (_isUAV) then {
	_instigator = (UAVControl _vehicleCausedBy) # 0;
} else {
	if (isNull _instigator) then {
		_instigator = _causedBy;
	};
};
if (isNull _instigator) exitWith {
	missionNamespace setVariable ['QS_robocop_busy',FALSE,FALSE];
	uiNamespace setVariable ['QS_robocop_timeout',diag_tickTime + 3];
};
private _how = 'weapon';
private _text = '';
private _posUnit = getPosATL _unit;
private _posInstigator = getPosATL _instigator;
private _uid1 = getPlayerUID _instigator;
private _name1 = name _instigator;
private _isAircraft = FALSE;
private _isVehicle = FALSE;
private _isStatic = FALSE;
private _objectParent = objectParent _instigator;
if (unitIsUAV _vehicleCausedBy) then {
	_objectParent = _vehicleCausedBy;
};
private _isObjectParent = !isNull _objectParent;
private _isPilot = !isNull _vehicleCausedBy && ((_instigator isEqualTo (currentPilot _vehicleCausedBy)) || {(_instigator isEqualTo (driver _vehicleCausedBy))});
private _list = [];
private _exclusions = [];
private _reportEnabled = TRUE;
private _isNearRoad = FALSE;
private _nearestRoad = objNull;
private _isClose = (_posUnit distance2D _posInstigator) < 15;
private _role = _instigator getVariable ['QS_unit_role_displayName','Unknown Role'];
private _vehicleType = typeOf _vehicleCausedBy;
private _vehicleRoleText = '';
private _vehicleCausedByType = missionNamespace getVariable [format ['QS_ST_iconVehicleDN#%1',_vehicleType],''];
if (_vehicleCausedByType isEqualTo '') then {
	_vehicleCausedByType = getText (configFile >> 'CfgVehicles' >> _vehicleType >> 'displayName');
};
_text = format ['You were hit by %1 [%2]',_name1,_role];
if (_vehicleCausedBy isKindOf 'Man') then {
	_text = _text + (format [', likely with a(n) %1',getText (configFile >> 'CfgWeapons' >> (currentWeapon _vehicleCausedBy) >> 'displayName')]);
};
if (_isObjectParent) then {
	if (_objectParent isKindOf 'Air') then {
		_isAircraft = TRUE;
	};
	if ((_objectParent isKindOf 'LandVehicle') || {(_objectParent isKindOf 'Ship')}) then {
		_isVehicle = TRUE;
	};
	if (_objectParent isKindOf 'StaticWeapon') then {
		_isStatic = TRUE;
	};
} else {
	
};
if (_isUAV) then {
	_text = format [
		'You were hit by %1 [%2], controlling a(n) %3.',
		_name1,
		_role,
		missionNamespace getVariable [format ['QS_ST_iconVehicleDN#%1',_vehicleType],'<Unknown vehicle type>']
	];
};
if (_isAircraft && _isPilot && _isClose) then {
	_text = format [
		'You were hit by %1 [%2], pilot of a(n) %3.',
		_name1,
		_role,
		missionNamespace getVariable [format ['QS_ST_iconVehicleDN#%1',_vehicleType],'<Unknown vehicle type>']
	];
	_list = nearestObjects [_posUnit,[],50,TRUE];
	_exclusions = [
		'land_runway_edgelight_blue_f','land_flush_light_green_f','land_flush_light_red_f','land_flush_light_yellow_f','runway_edgelight_blue_F',
		'flush_light_green_f','flush_light_red_f','flush_light_yellow_f','land_tenthangar_v1_f','tenthangar_v1_f','land_helipadsquare_f',
		'land_helipadcivil_f','land_helipadrescue_f','land_helipadcircle_f','land_helipadempty_f','helipadsquare_f','helipadcivil_f','helipadrescue_f',
		'helipadcircle_f','helipadempty_f'
	];
	{
		if (
			((toLower (typeOf _x)) in _exclusions) || 
			{(['runway',((getModelInfo _x) # 1),FALSE] call (missionNamespace getVariable 'QS_fnc_inString'))} ||
			{(['helipad',((getModelInfo _x) # 1),FALSE] call (missionNamespace getVariable 'QS_fnc_inString'))}
		) exitWith {
			_reportEnabled = FALSE;
		};
	} forEach _list;
};
if (_isVehicle && _isPilot && _isClose) then {
	_vehicleRoleText = 'driver';
	_nearestRoad = [_posUnit,15,FALSE] call (missionNamespace getVariable 'QS_fnc_nearestRoad');
	if (!isPlayer (driver _vehicleCausedBy)) then {
		if (isPlayer (effectiveCommander _vehicleCausedBy)) then {
			_vehicleRoleText = 'commander';
			_instigator = effectiveCommander _vehicleCausedBy;
			_uid1 = getPlayerUID _instigator;
			_name1 = name _instigator;
			_role = _instigator getVariable ['QS_unit_role_displayName','Unknown Role'];
		};
	};
	_text = format [
		'You were hit by %1 [%2], %3 of a(n) %4.',
		_name1,
		_role,
		_vehicleRoleText,
		missionNamespace getVariable [format ['QS_ST_iconVehicleDN#%1',_vehicleType],'<Unknown vehicle type>']
	];
	if (!isNull _nearestRoad) then {
		if (((getRoadInfo _nearestRoad) # 0) in ['ROAD','MAIN ROAD','TRACK']) then {
			_reportEnabled = FALSE;
		};
	};
};
if (_isStatic) then {
	_text = format [
		'You were hit by %1 [%2], using a(n) Static %3.',
		_name1,
		_role,
		missionNamespace getVariable [format ['QS_ST_iconVehicleDN#%1',_vehicleType],'<Unknown vehicle type>']
	];
};
(missionNamespace getVariable 'QS_managed_hints') pushBack [1,TRUE,10,-1,_text,[],(serverTime + 15),TRUE,'Robocop',TRUE];
if (!_reportEnabled) exitWith {
	missionNamespace setVariable ['QS_robocop_busy',FALSE,FALSE];
	uiNamespace setVariable ['QS_robocop_timeout',diag_tickTime + 3];
};
[_instigator,_uid1,_name1,_causedBy,_posUnit] spawn {
	params ['_instigator','_uid1','_name1','_causedBy','_posUnit'];
	uiSleep 10;
	waitUntil {
		uiSleep 0.1;
		((lifeState player) in ['HEALTHY','INJURED'])
	};
	private _optionAvailable = FALSE;
	if ((missionNamespace getVariable 'QS_sub_actions') isNotEqualTo []) then {
		{
			player removeAction _x;
		} count (missionNamespace getVariable 'QS_sub_actions');
		missionNamespace setVariable ['QS_sub_actions',[],FALSE];
	};
	QS_sub_actions01 = player addAction [
		'(ROBOCOP) Do not report the incident',
		(missionNamespace getVariable 'QS_fnc_atReport'),
		[2,'',objNull,[0,0,0],''],
		95,
		TRUE,
		TRUE
	];
	player setUserActionText [QS_sub_actions01,((player actionParams QS_sub_actions01) # 0),(format ["<t size='3'>%1</t>",((player actionParams QS_sub_actions01) # 0)])];
	QS_sub_actions pushBack QS_sub_actions01;
	QS_sub_actions02 = player addAction [
		format ['(ROBOCOP) Report %1',_name1],
		(missionNamespace getVariable 'QS_fnc_atReport'),
		[1,_uid1,_causedBy,_posUnit,_name1],
		94,
		TRUE,
		TRUE
	];
	player setUserActionText [QS_sub_actions02,((player actionParams QS_sub_actions02) select 0),(format ["<t size='3'>%1</t>",((player actionParams QS_sub_actions02) select 0)])];
	QS_sub_actions pushBack QS_sub_actions02;
	0 spawn {
		private _ti = diag_tickTime + 30;
		private _tr = 0;
		_image = "media\images\general\robocop.jpg";
		while {((missionNamespace getVariable 'QS_sub_actions') isNotEqualTo [])} do {
			_tr = _ti - diag_tickTime;
			[(format ['<t size="1.1">ROBOCOP<t/><br/><img size="7" image="%2"/><br/><br/>In your Action Menu (SCROLL MENU), you have the option to anonymously report the incident. This option is available for %1 seconds.',(round _tr),_image])] call (missionNamespace getVariable 'QS_fnc_hint');
			uiSleep 0.5;
			if ((missionNamespace getVariable 'QS_sub_actions') isEqualTo []) exitWith {};
			if (diag_tickTime >= _ti) exitWith {[''] call (missionNamespace getVariable 'QS_fnc_hint');};
		};
		[''] call (missionNamespace getVariable 'QS_fnc_hint');
		if ((missionNamespace getVariable 'QS_sub_actions') isNotEqualTo []) then {
			{player removeAction _x;} forEach (missionNamespace getVariable 'QS_sub_actions');
			missionNamespace setVariable ['QS_sub_actions',[],FALSE];
		};
		missionNamespace setVariable ['QS_robocop_busy',FALSE,FALSE];
		uiNamespace setVariable ['QS_robocop_timeout',diag_tickTime + 1];
	};
};