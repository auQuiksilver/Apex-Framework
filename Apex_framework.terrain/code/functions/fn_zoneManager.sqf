/*
File: fn_zoneManager.sqf
Author: 

	Quiksilver

Last Modified:

	20/09/2023 A3 2.14 by Quiksilver

Description:

	Zone Manager
	
Notes:

	In the future, manage entities within zones so multiple units (remote-controlled, etc) can be handled
	
	QS_myMarker = createMarker ["QS_marker_wreckRecovery",(getPos (allPlayers # 0))];
	QS_myMarker setMarkerPos (getPos (allPlayers # 0));
	
	['ADD',['ID_WRECK_01',TRUE,'SAFE','RAD',1,[markerPos 'QS_marker_base_marker',500],{systemChat 'zone 1 in';},{systemChat 'zone 1 out';},{TRUE}]] call QS_fnc_zoneManager;

	['ADD',['ID_WRECK_01',TRUE,'WRECK_RECOVER','RAD',1,[markerPos 'QS_marker_wreckRecovery',30],{},{},{TRUE},{},[WEST]]] call QS_fnc_zoneManager;

	['_id','_zoneActive','_zoneType','_type','_level','_areaParams','_codeEntry','_codeExit','_codeCondition','_codeEval','_zoneSides'];
Default Zones:

	Base safezone (high sec)
	Speed limited zones (high sec)
	Infantry spawn vehicle removal (high sec)
	FOB (low sec)
	Ships (low sec)
______________________________________*/

params ['_mode'];
if (_mode isEqualTo 'EVAL') exitWith {
	params ['','_entity'];
	_zones = QS_system_zones + QS_system_zonesLocal;
	_old = if (_entity isEqualType objNull) then {
		(_entity getVariable ['QS_unit_zones',[]])
	} else {
		[]
	};
	_current = ['GET',_entity,_zones] call QS_fnc_zoneManager;
	if (
		(_old isNotEqualTo _current) &&
		{(_entity isEqualType objNull)}
	) then {
		_current = ['SET',_entity,_old,_current,_zones] call QS_fnc_zoneManager;
	};
	if (
		(_current isNotEqualTo []) &&
		{(_entity isEqualType objNull)}
	) then {
		{
			_entity call (_x # 9);
		} forEach _current;
	};
};
//comment 'Current zone';
if (_mode isEqualTo 'GET') exitWith {
	params ['','_entity','_zones'];
	private _currentZones = [];
	private _currentZoneTypes = [];
	{
		_x params ['_id','_zoneActive','_zoneType','_type','_level','_areaParams','_codeEntry','_codeExit','_codeCondition','_codeEval','_zoneSides'];
		if (
			(
				([_id,_zoneActive,_zoneType,_type,_level,_areaParams,_codeEntry,_codeExit,_codeCondition,_codeEval,_zoneSides,_entity] call _codeCondition) &&
				{(
					(_currentZoneTypes isEqualTo []) ||
					((_currentZoneTypes findIf { (((_x # 1) isEqualTo _zoneType) && ((_x # 0) >= _level)) }) isEqualTo -1)
				)} &&
				{_zoneActive}
			) &&
			{(
				(
					(_type isEqualTo 'RAD') &&
					{(
						(((_areaParams # 0) isEqualTypeAny [objNull,[]]) && {((_entity distance (_areaParams # 0)) < (_areaParams # 1))}) ||
						{(((_areaParams # 0) isEqualType '') && {((_entity distance (markerPos (_areaParams # 0))) < (_areaParams # 1))})}
					)}
				) ||
				{(
					(_type isEqualTo 'AREA') &&
					{(_entity inArea _areaParams)}
				)} ||
				{(
					(_type isEqualTo 'POLY') &&
					{((_entity isEqualType objNull) && {(_entity inPolygon (_areaParams # 0))})} &&
					{((_areaParams # 1) isEqualTo -1) || {(((getPosASL _entity) # 2) < (_areaParams # 1))}}
				)} ||
				{(
					(_type isEqualTo 'CUSTOM') &&
					{((_entity isEqualType objNull) && {(_entity call _areaParams)})}
				)}
			)}
		) then {
			_currentZoneTypes pushBack [_level,_zoneType];
			_currentZones pushBack [_id,_zoneActive,_zoneType,_type,_level,_areaParams,_codeEntry,_codeExit,_codeCondition,_codeEval,_zoneSides];			
		};
	} forEach _zones;
	_currentZones;
};
if (_mode isEqualTo 'SET') exitWith {
	params ['','_entity','_oldzones','_currentzones'];
	//comment 'an oldzone is not in currentzones, leaving zone';
	{
		_x params ['_id','_zoneActive','_zoneType','_type','_level','_areaParams','_codeEntry','_codeExit','_codeCondition','_codeEval','_zoneSides'];
		if ((_currentzones findIf { ((_x # 0) isEqualTo _id) }) isEqualTo -1) then {
			[_id,_zoneActive,_zoneType,_type,_level,_areaParams,_codeEntry,_codeExit,_codeCondition,_codeEval,_zoneSides] call _codeExit;
		};
	} forEach _oldzones;
	
	//comment 'a currentzone is not in oldzones, entering zone';
	{
		_x params ['_id','_zoneActive','_zoneType','_type','_level','_areaParams','_codeEntry','_codeExit','_codeCondition','_codeEval','_zoneSides'];
		if ((_oldzones findIf { ((_x # 0) isEqualTo _id) }) isEqualTo -1) then {
			[_id,_zoneActive,_zoneType,_type,_level,_areaParams,_codeEntry,_codeExit,_codeCondition,_codeEval,_zoneSides] call _codeEntry;
		};
	} forEach _currentzones;
	
	//comment 'set current state';
	if (_entity isEqualType objNull) then {
		_entity setVariable ['QS_unit_zones',_currentzones,FALSE];
	};
	_currentzones;
};
// CLIENT ZONES
if (_mode isEqualTo 'ADD_LOCAL') exitWith {
	//comment 'Add if doesnt exist, otherwise set';
	params ['','_sz'];
	_id = _sz # 0;
	_index = QS_system_zonesLocal findIf { ((_x # 0) isEqualTo _id) };
	if (_index isEqualTo -1) then {
		QS_system_zonesLocal pushBack _sz;
	} else {
		QS_system_zonesLocal set [_index,_sz];
	};
};
if (_mode isEqualTo 'REMOVE_LOCAL') exitWith {
	params ['','_id'];
	_index = QS_system_zonesLocal findIf { ((_x # 0) isEqualTo _id) };
	if (_index isNotEqualTo -1) then {
		QS_system_zonesLocal deleteAt _index;
	};
};
if (_mode isEqualTo 'TOGGLE_STATE_LOCAL') exitWith {
	params ['','_id',['_toggle',TRUE]];
	_index = QS_system_zonesLocal findIf { ((_x # 0) isEqualTo _id) };
	if (_index isNotEqualTo -1) then {
		_element = QS_system_zonesLocal # _index;
		_element set [1,_toggle];
		QS_system_zonesLocal set [_index,_element];
	};
};
// GLOBAL ZONES
if (_mode isEqualTo 'ADD') exitWith {
	//comment 'Add if doesnt exist, otherwise set';
	params ['','_sz'];
	_id = _sz # 0;
	_index = QS_system_zones findIf { ((_x # 0) isEqualTo _id) };
	if (_index isEqualTo -1) then {
		QS_system_zones pushBack _sz;
	} else {
		QS_system_zones set [_index,_sz];
	};
	['PROP'] call QS_fnc_zoneManager;
};
if (_mode isEqualTo 'REMOVE') exitWith {
	params ['','_id'];
	_index = QS_system_zones findIf { ((_x # 0) isEqualTo _id) };
	if (_index isNotEqualTo -1) then {
		QS_system_zones deleteAt _index;
		['PROP'] call QS_fnc_zoneManager;
	};
};
if (_mode isEqualTo 'TOGGLE_STATE') exitWith {
	params ['','_id',['_toggle',TRUE]];
	_index = QS_system_zones findIf { ((_x # 0) isEqualTo _id) };
	if (_index isNotEqualTo -1) then {
		_element = QS_system_zones # _index;
		_element set [1,_toggle];
		QS_system_zones set [_index,_element];
		['PROP'] call QS_fnc_zoneManager;
	};
};
if (_mode isEqualTo 'PROP') exitWith {
	missionNamespace setVariable ['QS_system_zones',QS_system_zones,TRUE];
};
if (_mode isEqualTo 'INIT') exitWith {
	missionNamespace setVariable ['QS_system_zones',[],FALSE];
	['PROP'] call QS_fnc_zoneManager;
};