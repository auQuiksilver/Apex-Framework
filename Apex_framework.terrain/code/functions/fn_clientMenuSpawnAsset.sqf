removeAllUserActionEventHandlers ['User5','activate'];
addUserActionEventHandler ['User5','activate',{
	createDialog 'QS_RD_client_dialog_menu_assetSpawner';
	
}];
QS_fnc_clientMenuSpawnAsset = {
	disableSerialization;
	params ['_mode3'];
	if (_mode3 isEqualTo 'onLoad') exitWith {
		params ['','_display'];
		uiNamespace setVariable ['QS_client_menuSpawnAsset_display',_display];
		getCursorObjectParams params ['_cursorObject','_cursorSelections','_cursorDistance'];
		private _useCursorObject = localNamespace getVariable ['QS_client_menuSpawnAsset_useCursorObject',FALSE];
		
		private _spawnInfo = [ AGLToASL (player getRelPos [10,0]),getDir player];
		
		comment "private _spawnInfo = localNamespace getVariable ['QS_client_menuSpawnAsset_spawnInfo',[ AGLToASL (player getRelPos [10,0]),getDir player]];";
		_sideID = [(player getVariable ['QS_unit_side',WEST])] call BIS_fnc_sideID;
		if (
			_useCursorObject &&
			{(isNull (_cursorObject getVariable ['QS_vehicleSpawnPad',objNull]))}
		) exitWith {
			closeDialog 2;
		};
		if (_useCursorObject) then {
			_spawnInfo = [getPosASL (_cursorObject getVariable ['QS_vehicleSpawnPad',objNull]),getDir (_cursorObject getVariable ['QS_vehicleSpawnPad',objNull])];	
		};
		localNamespace setVariable ['QS_client_menuSpawnAsset_spawnInfo',_spawnInfo];
		comment '
			Get available assets for pad
			Are we using Budget?
		';
		QS_managed_spawnedVehicles_public = QS_managed_spawnedVehicles_public select {alive _x};
		if ((count QS_managed_spawnedVehicles_public) >= QS_managed_spawnedVehicles_maxCap) exitWith {
			comment 'Vehicle spawner global cap exceeded';
			closeDialog 2;
			50 cutText [
				(format [localize 'STR_QS_Text_488',QS_managed_spawnedVehicles_maxCap]),
				'PLAIN DOWN',
				1	
			];
		};
		_lbIDC = 1804;
		_ctrlTitle = _display displayCtrl 1802;
		_ctrlSelect = _display displayCtrl 1810;
		_ctrlExit = _display displayCtrl 1811;
		_ctrlListbox = _display displayCtrl _lbIDC;
		_ctrlModel = _display displayCtrl 100;
		_ctrlSelect ctrlEnable FALSE;
		_ctrlExit ctrlEnable TRUE;
		private _list = [];
		_vehicle_data = [
			['b_quadbike_01_f',2,{}],
			['b_mrap_01_f',3,{}],
			['b_lsv_01_armed_f',2,{}],
			['b_truck_01_covered_f',1,{}],
			['b_truck_01_flatbed_f',1,{}],
			['b_apc_wheeled_01_cannon_f',1,{}],
			['b_mbt_01_tusk_f',1,{}]
		];
		_vehicle_table = createHashMapFromArray (_vehicle_data apply { [_x # 0,[_x # 0] call QS_fnc_vehicleGetCost] });
		_vehicles = _vehicle_data apply {_x # 0};
		private _vType = '';
		{
			_vType = QS_core_vehicles_map getOrDefault [toLowerANSI _x,_x];
			lbAdd [_lbIDC,format ['[%2] %1',(getText (configFile >> 'CfgVehicles' >> _vType >> 'displayName')),_vehicle_table getOrDefault [_x,999]]];
			_list pushback [
				_lbIDC,
				_vType,
				(getText (configFile >> 'CfgVehicles' >> _vType >> 'displayName')),
				(getText (configFile >> 'CfgVehicles' >> _vType >> 'model')),
				(getNumber (configFile >> 'CfgVehicles' >> _vType >> 'modelScale')),
				(getNumber (configFile >> 'CfgVehicles' >> _vType >> 'side'))
			];
		} forEach _vehicles;
		if (_list isNotEqualTo []) then {
			lbSetCurSel [_lbIDC,0];
		};
		private _selectedIndex = -1;
		private _selectedName = '';
		uiNamespace setVariable ['QS_client_menuSpawnAsset_object',objNull];
		uiNamespace setVariable ['QS_client_menuSpawnAsset_selectedIndex',-1];
		uiNamespace setVariable ['QS_client_menuSpawnAsset_selectedData',[]];
		private _emptyModel = "\A3\Weapons_F\empty.p3d";
		private _modelScale = 1;
		_modelScaleBase = 0.075;
		_modelVector = [[0.0301068,0.0430097,0],[-0.0024624,-0.00172368,0.0524139]];
		_cancel = {
			(
				!dialog
			)
		};
		systemchat 'enter loop';
		for '_z' from 0 to 1 step 0 do {
			uiSleep diag_deltaTime;
			if (_selectedIndex isNotEqualTo (lbCurSel (_display displayCtrl _lbIDC))) then {
				_selectedIndex = lbCurSel (_display displayCtrl _lbIDC);
				uiNamespace setVariable ['QS_client_menuSpawnAsset_selectedIndex',_selectedIndex];
				if (_selectedIndex isNotEqualTo -1) then {
					uiNamespace setVariable ['QS_client_menuSpawnAsset_selectedData',_vehicle_data # _selectedIndex];
					_ctrlModel ctrlSetModel ((_list # _selectedIndex) # 3);
					_modelScale = ((_list # _selectedIndex) # 4);
					if (_modelScale isEqualTo 0) then {_modelScale = 1;};
					_ctrlModel ctrlsetmodelscale (_modelScaleBase * _modelScale);
					_ctrlModel ctrlsetmodeldirandup _modelVector;
					_ctrlModel ctrlsetposition [0.75,1,0.75];
					_ctrlModel ctrlCommit 0;
				} else {
					uiNamespace setVariable ['QS_client_menuSpawnAsset_selectedData',[]];
					_ctrlModel ctrlSetModel _emptyModel;
					_ctrlModel ctrlCommit 0;
				};
			};
			if (call _cancel) exitWith {closeDialog 2};
		};
		uiNamespace setVariable ['QS_client_menuSpawnAsset_object',objNull];
		uiNamespace setVariable ['QS_client_menuSpawnAsset_selectedIndex',-1];
		uiNamespace setVariable ['QS_client_menuSpawnAsset_selectedData',[]];
		systemchat 'exit loop';
	};
	if (_mode3 isEqualTo 'onUnload') exitWith {

	};
	if (_mode3 isEqualTo 'Button_1') exitWith {
		if (diag_tickTime < (uiNamespace getVariable ['QS_genericButtonCooldown',-1])) exitWith {
			50 cutText [localize 'STR_QS_Text_371','PLAIN DOWN',0.25];
		};
		uiNamespace setVariable ['QS_genericButtonCooldown',diag_tickTime + 1];
		systemchat 'button 1';
		closeDialog 2;
	};
	if (_mode3 isEqualTo 'Button_2') exitWith {
		_spawnInfo = localNamespace getVariable ['QS_client_menuSpawnAsset_spawnInfo',[AGLToASL (player getRelPos [10,0]),getDir player]];
		if (diag_tickTime < (uiNamespace getVariable ['QS_genericButtonCooldown',-1])) exitWith {
			50 cutText [localize 'STR_QS_Text_371','PLAIN DOWN',0.25];
		};
		uiNamespace setVariable ['QS_genericButtonCooldown',diag_tickTime + 1];
		_position = ASLToAGL (_spawnInfo # 0);
		_safeRadius = 2.5;
		private _obstructionList = nearestObjects [_position,['LandVehicle','Air','Ship','StaticWeapon','Cargo_base_F','Reammobox_F','Slingload_base_F'], 50, FALSE];
		_obstructionList = _obstructionList select {
			_distance = _position distance _x;
			_radius = ((0 boundingBoxReal _x) # 2);
			(((_position distance _x) - ((0 boundingBoxReal _x) # 2)) < _safeRadius)
		};
		if (_obstructionList isNotEqualTo []) exitWith {
			private _text = '';
			{
				if (_forEachIndex isNotEqualTo 0) then {
					_text = _text + ', ';
				};
				_text = _text + _x;
			} forEach (_obstructionList apply { (_x getVariable ['QS_ST_customDN',(getText ((configOf _x) >> 'displayName'))]) });
			50 cutText [format [localize 'STR_QS_Text_487',_text],'PLAIN DOWN',0.5];
		};
		_enemySides = QS_player call QS_fnc_enemySides;
		(QS_player getVariable ['QS_inzone',[]]) params ['_inSafezone','_safezoneLevel','_safezoneActive'];
		if (
			(
				(!(_inSafezone)) ||
				(_inSafezone && _safezoneActive && (_safezoneLevel < 2))
			) &&
			(((flatten (_enemySides apply {units _x})) inAreaArray [QS_player,QS_enemyInterruptAction_radius,QS_enemyInterruptAction_radius,0,FALSE,-1]) isNotEqualTo [])
		) exitWith {
			50 cutText [localize 'STR_QS_Text_489','PLAIN DOWN',0.5];
			FALSE;
		};
		_data = uiNamespace getVariable ['QS_client_menuSpawnAsset_selectedData',[]];
		systemchat str _data;
		[123,objNull,_data,_spawnInfo # 0,_spawnInfo # 1] remoteExec ['QS_fnc_remoteExec',2,FALSE];
		closeDialog 2;
	};
};