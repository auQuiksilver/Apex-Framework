/*
File: fn_clientMenuLoadout.sqf
Author:
	
	Quiksilver
	
Last Modified:

	25/11/2022 A3 2.10 by Quiksilver

Description:

	Loadout Save/Load
	
To Do:

	- Test change to save count
_____________________________________*/

params ['_mode3'];
if (_mode3 isEqualTo 'init') exitWith {
	params ['',['_cursorObject',objNull]];
	if (alive _cursorObject) then {
		missionNamespace setVariable ['QS_client_loadoutTarget',_cursorObject,FALSE];
		createDialog ['QS_RD_client_dialog_menu_inventory1',TRUE];
	};
};
private _buttonCooldown = 0.5;
private _saveLimit = 10;
if ((getPlayerUID player) in (['S3'] call (missionNamespace getVariable ['QS_fnc_whitelist',{[]}]))) then {
	_saveLimit = 20;
};
if (_mode3 isEqualTo 'onLoad') exitWith {
	disableSerialization;
	private _saveLimit = 10;
	if ((getPlayerUID player) in (['S3'] call (missionNamespace getVariable ['QS_fnc_whitelist',{[]}]))) then {
		_saveLimit = 20;
	};
	_display = [findDisplay 19000];
	uiNamespace setVariable ['QS_client_menuLoadout_display',[_display # 0]];
	_idc = 1804;
	private _saveText = '';
	private _loadText = '';
	private _editText = '';
	((_display # 0) displayCtrl 1802) ctrlSetText (localize 'STR_QS_Dialogs_077');
	((_display # 0) displayCtrl 1812) ctrlSetText (localize 'STR_QS_Dialogs_078');
	((_display # 0) displayCtrl 1810) ctrlSetText (localize 'STR_QS_Dialogs_079');
	((_display # 0) displayCtrl 1811) ctrlSetText (localize 'STR_QS_Dialogs_080');
	((_display # 0) displayCtrl 1816) progressSetPosition 0;
	private _object = missionNamespace getVariable ['QS_client_loadoutTarget',objNull];
	_maxLoad = maxLoad _object;
	_objectPosition = getPosWorld _object;
	_objectDisplayName = QS_hashmap_configfile getOrDefaultCall [
		format ['cfgvehicles_%1_displayname',toLowerANSI (typeOf _object)],
		{getText ((configOf _object) >> 'displayName')},
		TRUE
	];
	_cancel = {
		params ['_object','_objectPosition'];
		(
			(!alive _object) ||
			{(!simulationEnabled _object)} ||
			{(((getPosWorld _object) distance _objectPosition) > 1)} ||
			{(!isNull (attachedTo _object))} ||
			{(!isNull (isVehicleCargo _object))} ||
			{(!isNull (ropeAttachedTo _object))} ||
			{((cameraOn distance _objectPosition) > 50)}
		)
	};
	private _data = missionProfileNamespace getVariable ['QS_client_inventories',[]];
	_data sort TRUE;
	if (_data isNotEqualTo []) then {
		{
			lbAdd [_idc,format ['[%1] %2',_x # 0,(_x # 1)]];
			lbSetColor [_idc,_forEachIndex, ([[0.5,0.5,0.5,0.4],[1,1,1,0.8]] select ((_x # 0) <= _maxLoad)) ];
		} forEach _data;
	};
	((_display # 0) displayCtrl 1813) ctrlSetText format [localize 'STR_QS_Dialogs_081',(count _data) + 1];
	uiNamespace setVariable ['QS_client_menuLoadout_selectedIndex',-1];
	uiNamespace setVariable ['QS_client_menuLoadout_selectedText',''];
	uiNamespace setVariable ['QS_client_menuLoadout_update',FALSE];
	private _selectedIndex = -1;
	private _selectedName = '';
	private _namesList = _data apply {_x # 1};
	private _saveCount = count _data;
	private _charLimit = 25;
	for '_i' from 0 to 1 step 0 do {
		uiSleep diag_deltaTime;
		if (uiNamespace getVariable ['QS_client_menuLoadout_update',FALSE]) then {
			uiNamespace setVariable ['QS_client_menuLoadout_update',FALSE];
			_data = missionProfileNamespace getVariable ['QS_client_inventories',[]];
			_data sort TRUE;
			lbClear _idc;
			if (_data isNotEqualTo []) then {
				uiSleep 0.05;
				{
					lbAdd [_idc,format ['[%1] %2',_x # 0,(_x # 1)]];
					lbSetColor [_idc,_forEachIndex, ([[0.5,0.5,0.5,0.4],[1,1,1,0.8]] select ((_x # 0) <= _maxLoad)) ];
				} forEach _data;
			};
			uiSleep 0.05;
			_saveCount = count _data;
			_namesList = _data apply {_x # 1};
			
			if (uiNamespace getVariable ['QS_client_menuLoadout_deleted',FALSE]) then {
				uiNamespace setVariable ['QS_client_menuLoadout_deleted',FALSE];
				if ((count _data) > 0) then {
					((_display # 0) displayCtrl 1804) lbSetCurSel 0;
				};
			};
		};
		_selectedIndex = lbCurSel ((_display # 0) displayCtrl 1804);
		uiNamespace setVariable ['QS_client_menuLoadout_selectedIndex',_selectedIndex];
		
		_saveText = format [localize 'STR_QS_Dialogs_082',_saveCount,_saveLimit];
		if ((ctrlText ((_display # 0) displayCtrl 1812)) isNotEqualTo _saveText) then {
			((_display # 0) displayCtrl 1812) ctrlSetText _saveText;
		};
		_loadText = format ['%1 (%2 / %3)',_objectDisplayName,loadAbs _object,_maxLoad];
		if ((ctrlText ((_display # 0) displayCtrl 1818)) isNotEqualTo _loadText) then {
			((_display # 0) displayCtrl 1818) ctrlSetText _loadText;
		};
		_editText = ctrlText ((_display # 0) displayCtrl 1813);
		if ((count _editText) > _charLimit) then {
			_editText = _editText select [0,_charLimit];
			((_display # 0) displayCtrl 1813) ctrlSetText _editText;
			50 cutText [format [localize 'STR_QS_Text_287',_charLimit],'PLAIN DOWN',0.333];
		};
		if ((progressPosition ((_display # 0) displayCtrl 1816)) isNotEqualTo ((load _object) min 1)) then {
			((_display # 0) displayCtrl 1816) progressSetPosition ((load _object) min 1);
		};
		if (
			(_selectedIndex > -1) && 
			{(_selectedIndex < _saveCount)}
		) then {
			_selectedName = (_data # _selectedIndex) # 1;
			if (!(ctrlEnabled ((_display # 0) displayCtrl 1810))) then {
				((_display # 0) displayCtrl 1810) ctrlEnable TRUE;
			};
			if (!(ctrlEnabled ((_display # 0) displayCtrl 1811))) then {
				((_display # 0) displayCtrl 1811) ctrlEnable TRUE;
			};
			if (
				((ctrlText ((_display # 0) displayCtrl 1813)) isNotEqualTo '') &&
				{(((ctrlText ((_display # 0) displayCtrl 1813)) select [0,1]) isNotEqualTo ' ')} &&
				{((_saveCount < _saveLimit) || {((!isNil '_selectedName') && {(_editText in _namesList)})})}
			) then {
				if (!(ctrlEnabled ((_display # 0) displayCtrl 1812))) then {
					((_display # 0) displayCtrl 1812) ctrlEnable TRUE;
				};
			} else {
				if (ctrlEnabled ((_display # 0) displayCtrl 1812)) then {
					((_display # 0) displayCtrl 1812) ctrlEnable FALSE;
				};
			};
			if (!isNil '_selectedName') then {
				if ((uiNamespace getVariable ['QS_client_menuLoadout_selectedText','']) isNotEqualTo _selectedName) then {
					((_display # 0) displayCtrl 1813) ctrlSetText _selectedName;
					uiNamespace setVariable ['QS_client_menuLoadout_selectedText',_selectedName];
				};
			};
		} else {
			if (ctrlEnabled ((_display # 0) displayCtrl 1810)) then {
				((_display # 0) displayCtrl 1810) ctrlEnable FALSE;
			};
			if (ctrlEnabled ((_display # 0) displayCtrl 1811)) then {
				((_display # 0) displayCtrl 1811) ctrlEnable FALSE;
			};
			if (
				((ctrlText ((_display # 0) displayCtrl 1813)) isNotEqualTo '') &&
				{( ( (ctrlText ((_display # 0) displayCtrl 1813)) select [0,1]) isNotEqualTo ' ')} &&
				{(_saveCount < _saveLimit)}
			) then {
				if (!(ctrlEnabled ((_display # 0) displayCtrl 1812))) then {
					((_display # 0) displayCtrl 1812) ctrlEnable TRUE;
				};
			} else {
				if (ctrlEnabled ((_display # 0) displayCtrl 1812)) then {
					((_display # 0) displayCtrl 1812) ctrlEnable FALSE;
				};
			};
			uiNamespace setVariable ['QS_client_menuLoadout_selectedText',''];		
		};
		if (
			(isNull (_display # 0)) ||
			([_object,_objectPosition] call _cancel)
		) exitWith {};
	};
	uiNamespace setVariable ['QS_client_menuLoadout_selectedText',''];
	uiNamespace setVariable ['QS_client_menuLoadout_selectedIndex',-1];
	uiNamespace setVariable ['QS_client_menuLoadout_display',displayNull];
};
if (_mode3 isEqualTo 'onUnload') exitWith {

};
if ((uiNamespace getVariable ['QS_client_menuLoadout_cooldown',-1]) > diag_tickTime) exitWith {
	50 cutText [localize 'STR_QS_Text_288','PLAIN DOWN',0.333];
};
uiNamespace setVariable ['QS_client_menuLoadout_cooldown',diag_tickTime + _buttonCooldown];
if (_mode3 isEqualTo 'Save') exitWith {
	params ['','_ctrl'];
	_display = uiNamespace getVariable ['QS_client_menuLoadout_display',[displayNull]];
	private _savedText = ctrlText ((_display # 0) displayCtrl 1813);
	if (
		(_savedText isNotEqualTo '') &&
		((_savedText select [0,1]) isNotEqualTo ' ')
	) then {
		_object = missionNamespace getVariable ['QS_client_loadoutTarget',objNull];
		_cargo = [
			getWeaponCargo _object,
			getMagazineCargo _object,
			getItemCargo _object,
			getBackpackCargo _object
		];
		if (!((loadAbs _object) > (maxLoad _object))) then {
			private _data = missionProfileNamespace getVariable ['QS_client_inventories',[]];
			private _saveCount = count _data;
			private _set = FALSE;
			private _success = FALSE;
			{
				if ((_x # 1) == _savedText) then {
					_success = TRUE;
					_set = TRUE;
					_data set [_forEachIndex,[round (loadAbs _object),_savedText,round (maxLoad _object),_cargo]];
				};
			} forEach _data;
			if (!(_set)) then {
				if (_saveCount < _saveLimit) then {
					_success = TRUE;
					_data pushBack [round (loadAbs _object),_savedText,round (maxLoad _object),_cargo];
				} else {
					50 cutText [localize 'STR_QS_Text_289','PLAIN DOWN',0.333];
				};
			};
			if (_success) then {
				50 cutText [(format [localize 'STR_QS_Text_290',_savedText]),'PLAIN DOWN',0.333];
				if ((['LandVehicle','Air','Ship','StaticWeapon'] findIf { _object isKindOf _x }) isEqualTo -1) then {
					_object setVariable ['QS_ST_customDN',_savedText,TRUE];
					_object setVariable ['QS_ST_showDisplayName',TRUE,TRUE];
				};
				_data sort FALSE;
				missionProfileNamespace setVariable ['QS_client_inventories',_data];
				saveMissionProfileNamespace;
				uiNamespace setVariable ['QS_client_menuLoadout_update',TRUE];
			};
		} else {
			50 cutText [(format [localize 'STR_QS_Text_291',loadAbs _object,maxLoad _object]),'PLAIN DOWN',0.333];
		};
	} else {
		50 cutText [localize 'STR_QS_Text_292','PLAIN DOWN',0.333];
	};
};
if (_mode3 isEqualTo 'Load') exitWith {
	params ['','_ctrl'];
	_display = uiNamespace getVariable ['QS_client_menuLoadout_display',[displayNull]];
	private _data = missionProfileNamespace getVariable ['QS_client_inventories',[]];
	_selectedIndex = lbCurSel ((_display # 0) displayCtrl 1804);
	if (_selectedIndex isNotEqualTo -1) then {
		_savedData = _data # _selectedIndex;
		_savedData params ['_load','_name','_maxLoad','_cargo'];
		_object = missionNamespace getVariable ['QS_client_loadoutTarget',objNull];
		if ((['LandVehicle','Air','Ship','StaticWeapon'] findIf { _object isKindOf _x }) isEqualTo -1) then {
			_object setVariable ['QS_ST_customDN',_name,TRUE];
			_object setVariable ['QS_ST_showDisplayName',TRUE,TRUE];
		};
		_maxLoad = maxLoad _object;
		if (_load <= _maxLoad) then {
			clearWeaponCargoGlobal _object;
			clearMagazineCargoGlobal _object;
			clearItemCargoGlobal _object;
			clearBackpackCargoGlobal _object;
			_cargo params ['_weaponCargo','_magazineCargo','_itemCargo','_backpackCargo'];
			_weaponCargo params ['_weaponCargoClasses','_weaponCargoCounts'];
			_magazineCargo params ['_magazineCargoClasses','_magazineCargoCounts'];
			_itemCargo params ['_itemCargoClasses','_itemCargoCounts'];
			_backpackCargo params ['_backpackCargoClasses','_backpackCargoCounts'];
			(call (missionNamespace getVariable 'QS_data_restrictedGear')) params [
				['_restrictedWeapons',[]],
				['_restrictedMagazines',[]],
				['_restrictedItems',[]],
				['_restrictedBackpacks',[]]
			];
			if (_weaponCargoClasses isNotEqualTo []) then {
				{
					if (!((toLowerANSI _x) in _restrictedWeapons)) then {
						_object addWeaponCargoGlobal [_x,_weaponCargoCounts # _forEachIndex];
					} else {
						systemChat (format [localize 'STR_QS_Chat_164',_x]);
					};
					if ((loadAbs _object) >= _maxLoad) exitWith {};
				} forEach _weaponCargoClasses;
			};
			if ((loadAbs _object) >= _maxLoad) exitWith {};
			if (_magazineCargoClasses isNotEqualTo []) then {
				{
					if (!((toLowerANSI _x) in _restrictedMagazines)) then {
						_object addMagazineCargoGlobal [_x,_magazineCargoCounts # _forEachIndex];
					} else {
						systemChat (format [localize 'STR_QS_Chat_164',_x]);
					};
					if ((loadAbs _object) >= _maxLoad) exitWith {};
				} forEach _magazineCargoClasses;
			};
			if ((loadAbs _object) >= _maxLoad) exitWith {};
			if (_itemCargoClasses isNotEqualTo []) then {
				{
					if (!((toLowerANSI _x) in _restrictedItems)) then {
						_object addItemCargoGlobal [_x,_itemCargoCounts # _forEachIndex];
					} else {
						systemChat (format [localize 'STR_QS_Chat_164',_x]);
					};
					if ((loadAbs _object) >= _maxLoad) exitWith {};
				} forEach _itemCargoClasses;
			};
			if ((loadAbs _object) >= _maxLoad) exitWith {};
			if (_backpackCargoClasses isNotEqualTo []) then {
				{
					if (!((toLowerANSI _x) in _restrictedBackpacks)) then {
						_object addBackpackCargoGlobal [_x,_backpackCargoCounts # _forEachIndex];
					} else {
						systemChat (format [localize 'STR_QS_Chat_164',_x]);
					};
					if ((loadAbs _object) >= _maxLoad) exitWith {};
				} forEach _backpackCargoClasses;
			};
			50 cutText [(format [localize 'STR_QS_Text_293',_name]),'PLAIN DOWN',0.333];
		} else {
			50 cutText [localize 'STR_QS_Text_294','PLAIN DOWN',0.333];
		};
	};
};
if (_mode3 isEqualTo 'Delete') exitWith {
	params ['','_ctrl'];
	_display = uiNamespace getVariable ['QS_client_menuLoadout_display',[displayNull]];
	private _data = missionProfileNamespace getVariable ['QS_client_inventories',[]];
	_selectedIndex = lbCurSel ((_display # 0) displayCtrl 1804);
	if (_selectedIndex isNotEqualTo -1) then {
		_savedData = _data # _selectedIndex;
		_data set [_selectedIndex,-1];
		_data deleteAt _selectedIndex;
		_data sort FALSE;
		missionProfileNamespace setVariable ['QS_client_inventories',_data];
		saveMissionProfileNamespace;
		uiNamespace setVariable ['QS_client_menuLoadout_update',TRUE];
		uiNamespace setVariable ['QS_client_menuLoadout_deleted',TRUE];
	};
};
if (_mode3 isEqualTo 'Edit') exitWith {
	0 spawn {
		waitUntil {
			closeDialog 2;
			!dialog
		};
		call (missionNamespace getVariable 'QS_fnc_clientInteractCustomizeInventory');
	};
};
if (_mode3 isEqualTo 'Confirm') exitWith {
	_entity = missionNamespace getVariable ['QS_client_loadoutTarget',objNull];
	if (alive _entity) then {
		_classes = (uiNamespace getVariable ['RscAttributeInventory_cargo',[[],[]]]) # 0;
		_values = (uiNamespace getVariable ['RscAttributeInventory_cargo',[[],[]]]) # 1;
		[_entity,_classes,_values] spawn {
			params ['_entity','_classes','_values'];
			clearweaponcargoglobal _entity;
			clearmagazinecargoglobal _entity;
			clearbackpackcargoglobal _entity;
			clearitemcargoglobal _entity;
			private _maxLoad = maxLoad _entity;
			private _speculativeLoad = loadAbs _entity;
			private _mass = 0;
			private _value = 0;
			private _itemsToLoad = [];
			private _magazinesToLoad = [];
			private _weaponsToLoad = [];
			private _backpacksToLoad = [];
			private _a = 0;
			{
				_a = 0;
				if (_x > 0) then {
					_class = _classes # _foreachindex;
					_value = abs _x;
					switch TRUE do {
						case (getnumber (configfile >> 'cfgweapons' >> _class >> 'type') in [4096,131072]): {
							_mass = QS_hashmap_configfile getOrDefaultCall [
								format ['cfgweapons_%1_iteminfo_mass',toLowerANSI _class],
								{getNumber (configFile >> 'CfgWeapons' >> _class >> 'ItemInfo' >> 'mass')},
								TRUE
							];
							if ((_speculativeLoad + _mass) <= _maxLoad) then {
								for '_z' from 1 to _value step 1 do {
									_a = _a + 1;
									_speculativeLoad = _speculativeLoad + _mass;
									if (_speculativeLoad >= _maxLoad) exitWith {};
								};
								if (_speculativeLoad > _maxLoad) then {
									_a = _a - 1;
								};
								_itemsToLoad pushBack [_class,_a];
							};
						};
						case (isclass (configfile >> 'cfgmagazines' >> _class)): {
							_mass = QS_hashmap_configfile getOrDefaultCall [
								format ['cfgmagazines_%1_mass',toLowerANSI _class],
								{getNumber (configFile >> 'CfgMagazines' >> _class >> 'mass')},
								TRUE
							];
							if ((_speculativeLoad + _mass) <= _maxLoad) then {
								for '_z' from 1 to _value step 1 do {
									_a = _a + 1;
									_speculativeLoad = _speculativeLoad + _mass;
									if (_speculativeLoad >= _maxLoad) exitWith {};
								};
								if (_speculativeLoad > _maxLoad) then {
									_a = _a - 1;
								};
								_magazinesToLoad pushBack [_class,_a];
							};
						};
						case (isclass (configfile >> 'cfgweapons' >> _class)): {
							_mass = QS_hashmap_configfile getOrDefaultCall [
								format ['cfgweapons_%1_weaponslotsinfo_mass',toLowerANSI _class],
								{getNumber (configFile >> 'cfgweapons' >> _class >> 'WeaponSlotsInfo' >> 'mass')},
								TRUE
							];
							if ((_speculativeLoad + _mass) <= _maxLoad) then {
								for '_z' from 1 to _value step 1 do {
									_a = _a + 1;
									_speculativeLoad = _speculativeLoad + _mass;
									if (_speculativeLoad >= _maxLoad) exitWith {};
								};
								if (_speculativeLoad > _maxLoad) then {
									_a = _a - 1;
								};
								_weaponsToLoad pushBack [_class,_a];
							};
						};
						case (isclass (configfile >> 'cfgvehicles' >> _class)): {
							_mass = QS_hashmap_configfile getOrDefaultCall [
								format ['cfgvehicles_%1_mass',toLowerANSI _class],
								{getNumber (configFile >> 'CfgVehicles' >> _class >> 'mass')},
								TRUE
							];
							if ((_speculativeLoad + _mass) <= _maxLoad) then {
								for '_z' from 1 to _value step 1 do {
									_a = _a + 1;
									_speculativeLoad = _speculativeLoad + _mass;
									if (_speculativeLoad >= _maxLoad) exitWith {};
								};
								if (_speculativeLoad > _maxLoad) then {
									_a = _a - 1;
								};
								_backpacksToLoad pushBack [_class,_a];
							};
						};
					};
				};
				if (_speculativeLoad >= _maxLoad) exitWith {};
			} forEach _values;
			{
				_entity addItemCargoGlobal _x;
			} forEach _itemsToLoad;
			{
				_entity addMagazineCargoGlobal _x;
			} forEach _magazinesToLoad;
			{
				_entity addWeaponCargoGlobal _x;
			} forEach _weaponsToLoad;
			{
				_entity addBackpackCargoGlobal _x;
			} forEach _backpacksToLoad;
		};
	};
};