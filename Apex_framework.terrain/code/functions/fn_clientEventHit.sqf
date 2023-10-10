/*/
File: fn_clientEventHit.sqf
Author:

	Quiksilver
	
Last modified:

	9/10/2023 A3 2.14 by Quiksilver
	
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
	{((!isPlayer _causedBy) && (!isPlayer _instigator) && (!(unitIsUAV _instigator)))} ||
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
private _isUAV = unitIsUAV _instigator;
if (_isUAV) then {
	_instigator = remoteControlled _instigator;
} else {
	if (isNull _instigator) then {
		_instigator = _causedBy;
	};
};
if (isNull _instigator) exitWith {
	missionNamespace setVariable ['QS_robocop_busy',FALSE,FALSE];
	uiNamespace setVariable ['QS_robocop_timeout',diag_tickTime + 3];
};
private _text = '';
private _posUnit = getPosATL _unit;
private _posInstigator = getPosATL _instigator;
private _uid1 = getPlayerUID _instigator;
private _name1 = name _instigator;
private _isAircraft = FALSE;
private _isVehicle = FALSE;
private _isStatic = FALSE;
private _objectParent = objectParent _instigator;
if (unitIsUAV _instigator) then {
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
private _role = _instigator getVariable ['QS_unit_role_displayName',localize 'STR_QS_Role_000'];
private _vehicleType = typeOf _vehicleCausedBy;
private _vehicleRoleText = '';
private _currentWeapon = currentWeapon _vehicleCausedBy;
private _weaponName = '';
_vehicleCausedByType = QS_hashmap_configfile getOrDefaultCall [
	format ['cfgvehicles_%1_displayname',toLowerANSI _vehicleType],
	{getText ((configOf _vehicleCausedBy) >> 'displayName')},
	TRUE
];
_text = format ['%3 %1 [%2]',_name1,_role,localize 'STR_QS_Hints_008'];
if (_vehicleCausedBy isKindOf 'CAManBase') then {
	_weaponName = QS_hashmap_configfile getOrDefaultCall [
		format ['cfgweapons_%1_displayname',toLowerANSI _currentWeapon],
		{getText (configFile >> 'CfgWeapons' >> _currentWeapon >> 'displayName')},
		TRUE
	];
	_text = _text + (format [' %2 %1',_weaponName,localize 'STR_QS_Hints_009']);
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
		'%4 %1 [%2], %5 %3.',
		_name1,
		_role,
		missionNamespace getVariable [format ['QS_ST_iconVehicleDN#%1',_vehicleType],localize 'STR_QS_Utility_004'],
		localize 'STR_QS_Hints_008',
		localize 'STR_QS_Hints_010'
	];
};
if (_isAircraft && _isPilot && _isClose) then {
	_text = format [
		'%4 %1 [%2], %5 %3.',
		_name1,
		_role,
		missionNamespace getVariable [format ['QS_ST_iconVehicleDN#%1',_vehicleType],localize 'STR_QS_Utility_004'],
		localize 'STR_QS_Hints_008',
		localize 'STR_QS_Hints_011'
	];
	_list = nearestObjects [_posUnit,[],50,TRUE];
	_exclusions = ['airfield_objects_1'] call QS_data_listOther;
	{
		if (
			((toLowerANSI (typeOf _x)) in _exclusions) || 
			{(['runway',((getModelInfo _x) # 1),FALSE] call (missionNamespace getVariable 'QS_fnc_inString'))} ||
			{(['helipad',((getModelInfo _x) # 1),FALSE] call (missionNamespace getVariable 'QS_fnc_inString'))}
		) exitWith {
			_reportEnabled = FALSE;
		};
	} forEach _list;
};
if (_isVehicle && _isPilot && _isClose) then {
	_vehicleRoleText = localize 'STR_QS_Utility_005';
	_nearestRoad = [_posUnit,15,FALSE] call (missionNamespace getVariable 'QS_fnc_nearestRoad');
	if (!isPlayer (driver _vehicleCausedBy)) then {
		if (isPlayer (effectiveCommander _vehicleCausedBy)) then {
			_vehicleRoleText = localize 'STR_QS_Utility_007';
			_instigator = effectiveCommander _vehicleCausedBy;
			_uid1 = getPlayerUID _instigator;
			_name1 = name _instigator;
			_role = _instigator getVariable ['QS_unit_role_displayName',localize 'STR_QS_Role_000'];
		};
	};
	_text = format [
		'%5 %1 [%2], %3 %6 %4.',
		_name1,
		_role,
		_vehicleRoleText,
		missionNamespace getVariable [format ['QS_ST_iconVehicleDN#%1',_vehicleType],localize 'STR_QS_Utility_004'],
		localize 'STR_QS_Hints_008',
		localize 'STR_QS_Hints_012'
	];
	if (!isNull _nearestRoad) then {
		if (((getRoadInfo _nearestRoad) # 0) in ['ROAD','MAIN ROAD','TRACK']) then {
			_reportEnabled = FALSE;
		};
	};
};
if (_isStatic) then {
	_text = format [
		'%4 %1 [%2], %5 %3.',
		_name1,
		_role,
		missionNamespace getVariable [format ['QS_ST_iconVehicleDN#%1',_vehicleType],localize 'STR_QS_Utility_004'],
		localize 'STR_QS_Hints_008',
		localize 'STR_QS_Hints_013'
	];
};
(missionNamespace getVariable 'QS_managed_hints') pushBack [1,TRUE,10,-1,_text,[],(serverTime + 15),TRUE,localize 'STR_QS_Utility_002',TRUE];
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
	private _actionText = format ['(%1) %2',localize 'STR_QS_Utility_002',localize 'STR_QS_Interact_063'];
	QS_client_dynamicActionText pushBackUnique _actionText;
	QS_sub_actions01 = player addAction [
		_actionText,
		(missionNamespace getVariable 'QS_fnc_atReport'),
		[2,'',objNull,[0,0,0],''],
		95,
		TRUE,
		TRUE
	];
	player setUserActionText [QS_sub_actions01,((player actionParams QS_sub_actions01) # 0),(format ["<t size='3'>%1</t>",((player actionParams QS_sub_actions01) # 0)])];
	QS_sub_actions pushBack QS_sub_actions01;
	_actionText = format ['(%2) %3 %1',_name1,localize 'STR_QS_Utility_002',localize 'STR_QS_Interact_064'];
	QS_client_dynamicActionText pushBackUnique _actionText;
	QS_sub_actions02 = player addAction [
		format ['(%2) %3 %1',_name1,localize 'STR_QS_Utility_002',localize 'STR_QS_Interact_064'],
		(missionNamespace getVariable 'QS_fnc_atReport'),
		[1,_uid1,_causedBy,_posUnit,_name1],
		94,
		TRUE,
		TRUE
	];
	player setUserActionText [QS_sub_actions02,((player actionParams QS_sub_actions02) # 0),(format ["<t size='3'>%1</t>",((player actionParams QS_sub_actions02) # 0)])];
	QS_sub_actions pushBack QS_sub_actions02;
	0 spawn {
		private _ti = diag_tickTime + 30;
		private _tr = 0;
		_image = 'media\images\general\robocop.jpg';
		while {((missionNamespace getVariable 'QS_sub_actions') isNotEqualTo [])} do {
			_tr = _ti - diag_tickTime;
			[
				(format [
					'<t size="1.1">%3<t/><br/><img size="7" image="%2"/><br/><br/>%4 %1 %5.',
					(round _tr),
					_image,
					localize 'STR_QS_Utility_002',
					localize 'STR_QS_Hints_014',
					localize 'STR_QS_Utility_003'
				])
			] call (missionNamespace getVariable 'QS_fnc_hint');
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