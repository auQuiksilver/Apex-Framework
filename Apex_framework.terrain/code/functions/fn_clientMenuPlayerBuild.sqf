/*
File: fn_clientMenuPlayerBuild.sqf
Author:
	
	Quiksilver
	
Last Modified:

	11/10/2023 A3 2.12 by Quiksilver

Description:

	Player Quick Build menu
_____________________________________*/

disableSerialization;
params ['_mode'];
if (_mode isEqualTo 'onLoad') exitWith {
	(QS_player getVariable ['QS_inzone',[]]) params ['_inSafezone','_safezoneLevel','_safezoneActive'];
	if (_inSafezone && _safezoneActive && (_safezoneLevel > 1)) exitWith {
		(findDisplay 22000) closeDisplay 2;
		50 cutText [localize 'STR_QS_Text_403','PLAIN DOWN',0.5];
	};
	_display = findDisplay 22000;
	QS_EH_playerBuildKeyUp = _display displayAddEventHandler [
		'KeyUp',
		{
			params ['_display','_key','_shift','_ctrl','_alt'];
			if (_key isEqualTo 219) exitWith {
				_display displayRemoveEventHandler [_thisEvent,_thisEventHandler];
				(findDisplay 22000) closeDisplay 2;
				['OUT'] call QS_fnc_clientMenuActionContext;
			};
		}
	];
	uiNamespace setVariable ['QS_client_menuPlayerBuild_display',_display];
	_lbIDC = 1804;
	_ctrlTitle = _display displayCtrl 1802;
	_ctrlSelect = _display displayCtrl 1810;
	_ctrlExit = _display displayCtrl 1811;
	_ctrlListbox = _display displayCtrl _lbIDC;
	_ctrlModel = _display displayCtrl 100;
	_ctrlTitle ctrlSetText (localize 'STR_QS_Dialogs_086');
	private _data = QS_data_playerBuildables;
	_data = _data select { (call (_x # 3)) };
	private _listcount = 0;
	{
		_ctrlListbox lbAdd (format ['[%2] %1 %3',(getText (configFile >> 'CfgVehicles' >> (_x # 1) >> 'displayName')),str (_x # 0)]);
		_listcount = _listcount + 1;
	} forEach _data;
	if (_listcount > 0) then {
		_ctrlListbox lbSetCurSel 0;
	};
	_cancel = {
		(QS_player getVariable ['QS_inzone',[]]) params ['_inSafezone','_safezoneLevel','_safezoneActive'];
		(
			(isNull (findDisplay 22000)) ||
			(!((lifeState QS_player) in ['HEALTHY','INJURED'])) ||
			(!isNull (objectParent QS_player)) ||
			(_inSafezone && _safezoneActive && (_safezoneLevel > 1))
		)
	};
	{
		uiNamespace setVariable _x;
	} forEach [
		['QS_client_menuPlayerBuild_data',_data],
		['QS_client_menuPlayerBuild_class',(_data # (lbCurSel _ctrlListbox)) # 1],
		['QS_client_menuPlayerBuild_selectedIndex',-1],
		['QS_client_menuPlayerBuild_sim',-1],
		['QS_client_menuPlayerBuild_cost',1]
	];
	_ctrlExit ctrlEnable FALSE;
	_ctrlExit ctrlSetText '';
	
	private _localProp = objNull;
	private _propCostIndex = 0;
	private _propCost = 0;
	private _propsTotalCost = 0;
	_totalPropCount = count QS_list_playerBuildables;
	_localProps = QS_list_playerBuildables select {local _x};
	if (_localProps isNotEqualTo []) then {
		{
			_localProp = _x;
			_propCostIndex = _data findIf { ((toLowerANSI (typeOf _localProp)) isEqualTo (_x # 1)) };
			_propCost = if (_propCostIndex isNotEqualTo -1) then {((_data # _propCostIndex) # 0)} else {1};
			_propsTotalCost = _propsTotalCost + _propCost;
		} forEach _localProps;
	};
	_buildLimit = [QS_player] call QS_fnc_getPlayerBuildBudget;
	if (_propsTotalCost >= _buildLimit) then {
		_ctrlSelect ctrlEnable FALSE;
		_ctrlSelect ctrlSetText (format [localize 'STR_QS_Dialogs_087',_buildLimit]);
		_ctrlSelect ctrlSetTooltip (format [localize 'STR_QS_Dialogs_087',_buildLimit]);
		_ctrlSelect ctrlCommit 0;
	};
	if (_totalPropCount >= QS_missionConfig_maxPlayerBuildables) then {
		_ctrlSelect ctrlEnable FALSE;
		_ctrlSelect ctrlSetText (format [localize 'STR_QS_Menu_197',QS_missionConfig_maxPlayerBuildables]);
		_ctrlSelect ctrlSetTooltip (format [localize 'STR_QS_Menu_197',QS_missionConfig_maxPlayerBuildables]);
		_ctrlSelect ctrlCommit 0;
	};
	
	private _selectEnabled = ctrlEnabled _ctrlSelect;
	
	_ctrlExit ctrlSetText (format [localize 'STR_QS_Menu_200',_propsTotalCost,_buildLimit]);

	private _emptyModel = "\A3\Weapons_F\empty.p3d";
	private _objectModel = _emptyModel;
	private _modelScale = 1;
	_modelScaleBase = 0.075;
	_modelVector = [[0.0301068,0.0430097,0],[-0.0024624,-0.00172368,0.0524139]];
	
	private _selectedIndex = -1;
	
	for '_z' from 0 to 1 step 0 do {
		if (call _cancel) exitWith {};
		if (_selectedIndex isNotEqualTo (lbCurSel _ctrlListbox)) then {
			_selectedIndex = lbCurSel _ctrlListbox;
			if (_selectedIndex isNotEqualTo -1) then {
				{
					uiNamespace setVariable _x;
				} forEach [
					['QS_client_menuPlayerBuild_selectedIndex',_selectedIndex],
					['QS_client_menuPlayerBuild_cost',(_data # _selectedIndex) # 0],
					['QS_client_menuPlayerBuild_class',((_data # _selectedIndex) # 1)],
					['QS_client_menuPlayerBuild_sim',(_data # _selectedIndex) # 2]
				];
				_objectModel = getText (configFile >> 'CfgVehicles' >> ((_data # _selectedIndex) # 1) >> 'model');
				_modelScale = getNumber (configFile >> 'CfgVehicles' >> ((_data # _selectedIndex) # 1) >> 'modelScale');
				_ctrlModel ctrlSetModel _objectModel;
				if (_modelScale isEqualTo 0) then {_modelScale = 1;};
				_ctrlModel ctrlsetmodelscale (_modelScaleBase * _modelScale);
				_ctrlModel ctrlsetmodeldirandup _modelVector;
				_ctrlModel ctrlsetposition [0.75,1,0.75];
				_ctrlModel ctrlCommit 0;
			} else {
				_ctrlModel ctrlSetModel _emptyModel;
				_ctrlModel ctrlCommit 0;
			};
		};
		_propsTotalCost = 0;
		_localProps = QS_list_playerBuildables select {local _x};
		if (_localProps isNotEqualTo []) then {
			{
				_localProp = _x;
				_propCostIndex = _data findIf { ((toLowerANSI (typeOf _localProp)) isEqualTo (_x # 1)) };
				_propCost = if (_propCostIndex isNotEqualTo -1) then {((_data # _propCostIndex) # 0)} else {1};
				_propsTotalCost = _propsTotalCost + _propCost;
			} forEach _localProps;
		};
		_ctrlExit ctrlSetText (format [localize 'STR_QS_Menu_200',_propsTotalCost,_buildLimit]);
		if (_selectEnabled) then {
			if (ctrlEnabled _ctrlSelect) then {
				if (
					((_propsTotalCost + (uiNamespace getVariable ['QS_client_menuPlayerBuild_cost',1])) > _buildLimit) ||
					{((count QS_list_playerBuildables) >= QS_missionConfig_maxPlayerBuildables)} ||
					{(missionNamespace getVariable ['QS_targetBoundingBox_placementMode',FALSE])}
				) then {
					_ctrlSelect ctrlEnable FALSE;
				};
			} else {
				if (
					((_propsTotalCost + (uiNamespace getVariable ['QS_client_menuPlayerBuild_cost',1])) <= _buildLimit) &&
					{((count QS_list_playerBuildables) < QS_missionConfig_maxPlayerBuildables)} &&
					{(!(missionNamespace getVariable ['QS_targetBoundingBox_placementMode',FALSE]))}
				) then {
					_ctrlSelect ctrlEnable TRUE;
				};
			};
		};
		uiSleep (diag_deltaTime * 3);
	};
	uiNamespace setVariable ['QS_client_menuPlayerBuild_class',''];
};
if (_mode isEqualTo 'onUnload') exitWith {
	(findDisplay 22000) displayRemoveEventHandler ['KeyUp',QS_EH_playerBuildKeyUp];
};
if (_mode isEqualTo 'Button_1') exitWith {
	if (diag_tickTime < (uiNamespace getVariable ['QS_genericButtonCooldown',-1])) exitWith {
		50 cutText [localize 'STR_QS_Text_371','PLAIN DOWN',0.25];
	};
	uiNamespace setVariable ['QS_genericButtonCooldown',diag_tickTime + 1];
	localNamespace setVariable ['QS_logistics_playerBuild',TRUE];
	(QS_player getVariable ['QS_inzone',[]]) params ['_inSafezone','_safezoneLevel','_safezoneActive'];
	if (_inSafezone && _safezoneActive && (_safezoneLevel > 1)) exitWith {
		(findDisplay 22000) closeDisplay 2;
		50 cutText [localize 'STR_QS_Text_403','PLAIN DOWN',0.5];
	};
	if ((getPlayerUID player) in (missionNamespace getVariable ['QS_blacklist_logistics',[]])) exitWith {
		50 cutText [localize 'STR_QS_Text_388','PLAIN',0.3];
	};
	_data = uiNamespace getVariable ['QS_client_menuPlayerBuild_data',[]];
	_objectCost = uiNamespace getVariable ['QS_client_menuPlayerBuild_cost',1];
	_buildLimit = [QS_player] call QS_fnc_getPlayerBuildBudget;
	private _localProp = objNull;
	private _propCostIndex = 0;
	private _propCost = 0;
	private _propsTotalCost = 0;
	_totalPropCount = count QS_list_playerBuildables;
	_localProps = QS_list_playerBuildables select {local _x};
	if (_localProps isNotEqualTo []) then {
		{
			_localProp = _x;
			_propCostIndex = _data findIf { ((toLowerANSI (typeOf _localProp)) isEqualTo (_x # 1)) };
			_propCost = if (_propCostIndex isNotEqualTo -1) then {((_data # _propCostIndex) # 0)} else {1};
			_propsTotalCost = _propsTotalCost + _propCost;
		} forEach _localProps;
	};
	_totalPropCount = count QS_list_playerBuildables;
	if ((_propsTotalCost + _objectCost) > _buildLimit) exitWith {50 cutText [localize 'STR_QS_Text_457','PLAIN DOWN',0.333];};
	if (_totalPropCount >= QS_missionConfig_maxPlayerBuildables) exitWith {50 cutText [localize 'STR_QS_Text_458','PLAIN DOWN',0.333];};
	_class = uiNamespace getVariable ['QS_client_menuPlayerBuild_class',''];
	if (_class isNotEqualTo '') then {
		[QS_player,_class,TRUE] call QS_fnc_unloadCargoPlacementMode;
	};
	(findDisplay 22000) closeDisplay 2;
	['OUT'] call QS_fnc_clientMenuActionContext;
};
if (_mode isEqualTo 'Button_2') exitWith {
	if (diag_tickTime < (uiNamespace getVariable ['QS_genericButtonCooldown',-1])) exitWith {
		50 cutText [localize 'STR_QS_Text_371','PLAIN DOWN',0.25];
	};
	uiNamespace setVariable ['QS_genericButtonCooldown',diag_tickTime + 1];
	(QS_player getVariable ['QS_inzone',[]]) params ['_inSafezone','_safezoneLevel','_safezoneActive'];
	if (_inSafezone && _safezoneActive && (_safezoneLevel > 1)) exitWith {
		(findDisplay 22000) closeDisplay 2;
		50 cutText [localize 'STR_QS_Text_403','PLAIN DOWN',0.5];
	};
};