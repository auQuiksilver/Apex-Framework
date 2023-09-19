/*
File: fn_clientMenuHangar.sqf
Author:
	
	Quiksilver
	
Last Modified:

	20/12/2022 A3 2.10 by Quiksilver

Description:

	Hangar Menu
	
Notes:

	Jets DLC consideration, some players don't have
______________________________________*/

disableSerialization;
params ['_type1'];
if (_type1 isEqualTo 'onLoad') exitWith {
	params ['','_display1'];
	_ownedDLCs = (getDLCs 1) + [0];
	QS_pylons_data = call (missionNamespace getVariable 'QS_data_planeLoadouts');
	_customPylonPresets = (missionNamespace getVariable ['QS_missionConfig_pylonPresets',0]) isEqualTo 1;
	_validHangarTypes = QS_pylons_data apply { toLowerANSI (_x # 0) };
	_hangarTarget = uiNamespace getVariable ['QS_client_menuHangar_target',objNull];
	_targetType = toLowerANSI (typeOf _hangarTarget);
	_spawnDisabled = cameraOn isEqualTo _hangarTarget;
	if (
		(!alive _hangarTarget) ||
		{(!local _hangarTarget) && (_spawnDisabled)} ||
		{((!(_targetType in _validHangarTypes)) && _customPylonPresets)}
	) exitWith {closeDialog 2;};
	_idc_lb_asset = 1804;
	_idc_lb_loadout = 1812;
	if (_spawnDisabled) then {
		// Assume DLC for current vehicle is owned
		QS_pylons_data = QS_pylons_data select {
			((toLowerANSI (_x # 0)) isEqualTo _targetType)
		};
	} else {
		// Ensure only assets in owned DLCs get shown
		QS_pylons_data = QS_pylons_data select {
			((((_x # 1) # 0) # 6) in _ownedDLCs)
		};
	};
	if (!(_customPylonPresets)) then {
		QS_pylons_data = [];
		private _list = [];
		_presets = (configOf _hangarTarget) >> 'Components' >> 'TransportPylonsComponent' >> 'Presets'; 
		private _configClass = configNull;
		private _configName = '';
		private _displayName = '';
		private _tooltip = '';
		private _element = [];
		private _pylons = [];
		private _pylonsLoadout = [];
		_count = count _presets;
		for '_i' from 0 to (_count - 1) step 1 do {
			_configClass = _presets select _i;
			_configName = configName _configClass;
			_displayName = getText (_presets >> _configName >> 'displayName');
			_pylons = getArray (_presets >> _configName >> 'attachment');
			_pylonsLoadout = [];
			{
				_pylonsLoadout pushBack [_forEachIndex + 1,'',[-1],_x,-1,''];
			} forEach _pylons;
			_element = [
				_configName,
				_displayName,
				_pylonsLoadout,
				{TRUE},
				0,
				0,
				0
			];
			_list pushBack _element;
		};
		QS_pylons_data = [
			[
				_targetType,
				_list
			]
		];
	};
	private _dn = '';
	{
		_dn = QS_hashmap_configfile getOrDefaultCall [
			format ['cfgvehicles_%1_displayname',toLowerANSI (_x # 0)],
			{getText (configFile >> 'CfgVehicles' >> (_x # 0) >> 'displayName')},
			TRUE
		];
		lbAdd [_idc_lb_asset,format ['%1',_dn]];
	} forEach QS_pylons_data;
	private _data_loadout = [];
	private _data_loadouts = [];
	{
		uiNamespace setVariable _x;
	} forEach [
		['QS_client_menuHangar_selectedIndex',-1],
		['QS_client_menuHangar_selectedIndex2',-1],
		['QS_client_menuHangar_selectedType',''],
		['QS_client_menuHangar_selectedLoadoutData','']
	];
	private _selectedIndex = -1;
	private _selectedIndex2 = -1;
	private _dataIndex = -1;
	private _loadoutData = [];
	for '_z' from 0 to 1 step 0 do {
		uiSleep diag_deltaTime;
		_selectedIndex = lbCurSel (_display1 displayCtrl _idc_lb_asset);
		if (
			(_selectedIndex isNotEqualTo -1) &&
			{(_selectedIndex isNotEqualTo (uiNamespace getVariable ['QS_client_menuHangar_selectedIndex',-1]))}
		) then {
			uiNamespace setVariable ['QS_client_menuHangar_selectedIndex',_selectedIndex];
			uiNamespace setVariable ['QS_client_menuHangar_selectedType',((QS_pylons_data # _selectedIndex) # 0)];
			_data_loadout = [];
			_dataIndex = QS_pylons_data findIf {(_x # 0) isEqualTo ((QS_pylons_data # _selectedIndex) # 0)};
			if (_dataIndex isNotEqualTo -1) then {
				lbClear _idc_lb_loadout;
				{
					lbAdd [_idc_lb_loadout,format ['%1',_x # 0]];
					lbSetTooltip [_idc_lb_loadout, _forEachIndex, _x # 1];
				} forEach ((QS_pylons_data # _dataIndex) # 1);
			};
		};
		_selectedIndex2 = lbCurSel (_display1 displayCtrl _idc_lb_loadout);
		if (
			(_selectedIndex2 isNotEqualTo -1) &&
			{(_selectedIndex2 isNotEqualTo (uiNamespace getVariable ['QS_client_menuHangar_selectedIndex2',-1]))}
		) then {
			uiNamespace setVariable ['QS_client_menuHangar_selectedIndex2',_selectedIndex2];
			_loadoutData = ((QS_pylons_data # _dataIndex) # 1) # _selectedIndex2;
			uiNamespace setVariable ['QS_client_menuHangar_selectedLoadoutData',_loadoutData];
		};
		if (isNull _display1) exitWith {};
	};
	uiNamespace setVariable ['QS_client_menuHangar_target',objNull];
};
if (_type1 isEqualTo 'onUnload') exitWith {
	uiNamespace setVariable ['QS_client_menuHangar_target',objNull];
};
if (_type1 isEqualTo 'Select') exitWith {
	0 spawn {
		private _vehicle = uiNamespace getVariable ['QS_client_menuHangar_target',objNull];
		_loadoutData = uiNamespace getVariable ['QS_client_menuHangar_selectedLoadoutData',[]];
		_pylonData = _loadoutData # 2;
		waitUntil {
			closeDialog 2;
			(!dialog)
		};
		if (((vectorMagnitude (velocity _vehicle)) * 3.6) > 1) then {
			50 cutText [localize 'STR_QS_Text_285','PLAIN DOWN',0.333];
		};
		_onCompleted = [
			[_vehicle,_loadoutData],
			{
				params ['_vehicle','_loadoutData'];
				[105,_vehicle,_loadoutData] remoteExec ['QS_fnc_remoteExec',0,FALSE];
				50 cutText [localize 'STR_QS_Text_296','PLAIN DOWN',0.333];
			}
		];
		_onCancelled = [
			[_vehicle],
			{
				params ['_vehicle'];
				(
					(((vectorMagnitude (velocity _vehicle)) * 3.6) > 1) ||
					{(!alive _vehicle)} ||
					{(cameraOn isNotEqualTo _vehicle)} ||
					{(dialog)}
				)
			}
		];
		[localize 'STR_QS_Text_295',10,0,[[],{FALSE}],_onCancelled,_onCompleted,[[],{FALSE}],TRUE] spawn (missionNamespace getVariable 'QS_fnc_clientProgressVisualization');
	};
};