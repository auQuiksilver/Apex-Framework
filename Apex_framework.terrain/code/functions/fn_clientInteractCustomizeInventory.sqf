/*/
File: fn_clientInteractCustomizeInventory.sqf
Author:

	Quiksilver
	
Last Modified:

	25/11/2022 A3 2.10 by Quiksilver
	
Description:

	Customize an inventory
_________________________________________/*/

_cursorObject = missionNamespace getVariable ['QS_client_loadoutTarget',objNull];
if (
	(!alive _cursorObject) ||
	(!simulationEnabled _cursorObject) ||
	((player distance _cursorObject) > 10) ||
	((typeOf _cursorObject) in ['FlexibleTank_01_sand_F','FlexibleTank_01_forest_F'])
) exitWith {};
disableSerialization;
missionNamespace setVariable ['BIS_fnc_initCuratorAttributes_target',_cursorObject,FALSE];
uiNamespace setVariable ['RscAttributeInventory_selected',nil];
private _display = createDialog ['RscDisplayAttributesInventory',TRUE];
if (!isNull curatorCamera) exitWith {};
[_display,_cursorObject] spawn {
	disableSerialization;
	params ['_display','_entity'];
	50 cutText [localize 'STR_QS_Text_097','PLAIN DOWN',0.5];
	[2] spawn (missionNamespace getVariable 'QS_fnc_clientDisableUserInput');
	private _safetyTimeout = diag_tickTime + 10;
	waitUntil {
		((!(uiNamespace isNil 'RscAttributeInventory_selected')) || (diag_tickTime > _safetyTimeout))
	};
	if (diag_tickTime > _safetyTimeout) exitWith {};
	uiSleep 0.1;
	if (missionNamespace isNil 'QS_RscAttributeInventory_list') then {
		private _weaponAddons = missionnamespace getvariable ['RscAttrbuteInventory_weaponAddons',[]];
		_types = [
			['AssaultRifle','Shotgun','Rifle','SubmachineGun'],
			['MachineGun'],
			['SniperRifle'],
			['Launcher','MissileLauncher','RocketLauncher'],
			['Handgun'],
			['UnknownWeapon'],
			['AccessoryMuzzle','AccessoryPointer','AccessorySights','AccessoryBipod'],
			['Uniform'],
			['Vest'],
			['Backpack'],
			['Headgear','Glasses'],
			['Binocular','Compass','FirstAidKit','GPS','LaserDesignator','Map','Medikit','MineDetector','NVGoggles','Radio','Toolkit','Watch','UAVTerminal','Laserdesignator_02','Laserdesignator_03','Laserdesignator_01_khk_F','Laserdesignator_02_ghex_F']
		];
		private _list = [[],[],[],[],[],[],[],[],[],[],[],[]];
		(call (missionNamespace getVariable 'QS_data_restrictedGear')) params [
			['_restrictedWeapons',[]],
			['_restrictedMagazines',[]],
			['_restrictedItems',[]],
			['_restrictedBackpacks',[]]
		];
		_restrictedAll = _restrictedWeapons + _restrictedMagazines + _restrictedItems + _restrictedBackpacks;
		private _magazines = [];
		private _weapon = '';
		private _addon = '';
		private _addonList = '';
		private _addonID = '';
		private _weaponType = '';
		private _weaponTypeCategory = '';
		private _weaponTypeSpecific = '';
		private _weaponTypeID = -1;
		private _weaponCfg = '';
		private _weaponPublic = 0;
		private _addonListType = [];
		private _displayName = '';
		private _picture = '';
		private _item = '';
		private _itemName = '';
		private _displayNameShort = '';
		private _displayNameShortArray = [];
		private _type = 0;
		private _muzzle = '';
		private _magazinesList = '';
		private _magCfg = '';
		private _current = '';
		{
			_addon = toLowerANSI _x;
			_addonList = [[],[],[],[],[],[],[],[],[],[],[],[]];
			_addonID = _weaponAddons find _addon;
			if (_addonID < 0) then {
				{
					_weapon = toLowerANSI _x;
					if (!(_weapon in _restrictedAll)) then {
						_weaponType = (_weapon call bis_fnc_itemType);
						_weaponTypeCategory = _weaponType # 0;
						_weaponTypeSpecific = _weaponType # 1;
						_weaponTypeID = -1;
						{
							if (_weaponTypeSpecific in _x) exitwith {_weaponTypeID = _foreachindex;};
						} foreach _types;
						if (_weaponTypeCategory != "VehicleWeapon" && _weaponTypeID >= 0) then {
							_weaponCfg = configfile >> "cfgweapons" >> _weapon;
							_weaponPublic = getnumber (_weaponCfg >> "scope") isEqualTo 2;
							_addonListType = _addonList # _weaponTypeID;
							if (_weaponPublic) then {
								_displayName = gettext (_weaponCfg >> "displayName");
								_picture = gettext (_weaponCfg >> "picture");
								{
									_item = gettext (_x >> "item");
									_itemName = gettext (configfile >> "cfgweapons" >> _item >> "displayName");
									_displayName = _displayName + " + " + _itemName;
								} foreach ((_weaponCfg >> "linkeditems") call bis_fnc_returnchildren);
								_displayNameShort = _displayName;
								_displayNameShortArray = toarray _displayNameShort;
								if (count _displayNameShortArray > 41) then {
									_displayNameShortArray resize 41;
									_displayNameShort = tostring _displayNameShortArray + "...";
								};
								_type = if (getnumber (configfile >> "cfgweapons" >> _weapon >> "type") in [4096,131072]) then {1} else {0};
								_addonListType pushback [_displayName,_displayNameShort,_weapon,_picture,_type,false];
							};
							if (_weaponPublic || _weapon in ["throw","put"]) then {
								{
									_muzzle = if (_x isEqualTo "this") then {_weaponCfg} else {_weaponCfg >> _x};
									_magazinesList = getArray (_muzzle >> "magazines");
									{
										{
											_magazinesList append (getArray _x);
										} foreach  configProperties [configFile >> "CfgMagazineWells" >> _x, "isArray _x"];
									} foreach getArray (_muzzle >> "magazineWell");
									{
										_mag = toLowerANSI _x;
										if (!(_mag in _restrictedMagazines)) then {
											if ((_addonListType findIf {((_x # 2) == _mag)}) isEqualTo -1) then {
												_magCfg = configfile >> "cfgmagazines" >> _mag;
												if (getnumber (_magCfg >> "scope") isEqualTo 2) then {
													_displayName = gettext (_magCfg >> "displayName");
													_picture = gettext (_magCfg >> "picture");
													_addonListType pushback [_displayName,_displayName,_mag,_picture,2,_mag in _magazines];
													_magazines pushback _mag;
												};
											};
										};
									} foreach _magazinesList;
								} foreach getarray (_weaponCfg >> "muzzles");
							};
						};
					};
				} foreach (getarray (configfile >> "cfgpatches" >> _x >> "weapons"));
				{
					_weapon = toLowerANSI _x;
					if (!(_weapon in _restrictedAll)) then {
						_weaponType = _weapon call bis_fnc_itemType;
						_weaponTypeSpecific = _weaponType # 1;
						_weaponTypeID = -1;
						{
							if (_weaponTypeSpecific in _x) exitwith {_weaponTypeID = _foreachindex;};
						} foreach _types;
						if (_weaponTypeID >= 0) then {
							_weaponCfg = configfile >> "cfgvehicles" >> _weapon;
							if (getnumber (_weaponCfg >> "scope") isEqualTo 2) then {
								_displayName = gettext (_weaponCfg >> "displayName");
								_picture = gettext (_weaponCfg >> "picture");
								_addonListType = _addonList # _weaponTypeID;
								_addonListType pushback [_displayName,_displayName,_weapon,_picture,3,false];
							};
						};
					};
				} foreach getarray (configfile >> "cfgpatches" >> _x >> "units");
				_weaponAddons pushBack _addon;
				_weaponAddons pushBack _addonList;
			} else {
				_addonList = _weaponAddons select (_addonID + 1);
			};
			{
				_current = _list # _forEachIndex;
				_list set [_foreachindex,_current + (_x - _current)];
			} foreach _addonList;
		} foreach activatedAddons;
		
		private _element = [];
		{
			_element = _x;
			_element = _element select {(!( (_x # 2) in _restrictedAll )) };
			_list set [_forEachIndex,_element];
		} forEach _list;
		
		
		
		missionNamespace setVariable ['QS_RscAttributeInventory_list',_list,FALSE];
		missionnamespace setvariable ['QS_RscAttrbuteInventory_weaponAddons',_weaponAddons];
	};
	missionnamespace setvariable ['RscAttrbuteInventory_weaponAddons',(missionNamespace getVariable 'QS_RscAttrbuteInventory_weaponAddons')];
	uiNamespace setVariable ['RscAttributeInventory_list',(missionNamespace getVariable 'QS_RscAttributeInventory_list')];
	_cargo = [
		getWeaponCargo _entity,
		getMagazineCargo _entity,
		getItemCargo _entity,
		getBackpackCargo _entity
	];
	sleep 1;
	uiNamespace setVariable [
		'RscAttributeInventory_cargo',
		[
			(((getWeaponCargo _entity) # 0) + ((getMagazineCargo _entity) # 0) + ((getItemCargo _entity) # 0) + ((getBackpackCargo _entity) # 0)) apply {toLowerANSI _x},
			((getWeaponCargo _entity) # 1) + ((getMagazineCargo _entity) # 1) + ((getItemCargo _entity) # 1) + ((getBackpackCargo _entity) # 1)
		]
	];
	uiNamespace setVariable ['RscAttributeInventory_selected',0];
	playSound ['Click',FALSE];
	50 cutText [localize 'STR_QS_Text_098','PLAIN DOWN',1];
	titleFadeOut 3;
	if (userInputDisabled) then {
		disableUserInput FALSE;
	};
	uiNamespace setVariable ['QS_client_inventoryEdit_scripts',((uiNamespace getVariable ['QS_client_inventoryEdit_scripts',[]]) select {!isNull _x})];
	if ((uiNamespace getVariable ['QS_client_inventoryEdit_scripts',[]]) isEqualTo []) then {
		(uiNamespace getVariable ['QS_client_inventoryEdit_scripts',[]]) pushBack _thisScript;
		_ctrlGroup = ctrlParentControlsGroup (_display displayCtrl 23868);
		_ctrlProgress = _ctrlGroup controlsGroupCtrl 23868;
		_ctrlsGroupPos = (ctrlPosition _ctrlGroup) select [0,2];
		private _ctrlPos = ctrlPosition _ctrlProgress;
		_ctrlProgress ctrlShow FALSE;
		_ctrlProgress ctrlCommit 0;
		_ctrlFrame = _display ctrlCreate ['RscFrame',12357,_ctrlGroup];
		_ctrlFrame ctrlShow TRUE;
		_ctrlFrame ctrlSetPosition _ctrlPos;
		_ctrlFrame ctrlSetText '';
		_ctrlFrame ctrlSetBackgroundColor [0.5,0.5,0.5,1];
		_ctrlFrame ctrlSetTextColor [0.5,0.5,0.5,1];
		_ctrlFrame ctrlSetScale 1;
		_ctrlFrame ctrlCommit 0;
		_ctrlLoad3 = _display ctrlCreate ['RscProgress',12358,_ctrlGroup];
		_ctrlLoad3 ctrlShow TRUE;
		_ctrlLoad3 ctrlSetPosition _ctrlPos;
		_ctrlLoad3 ctrlSetText '';
		_ctrlLoad3 ctrlSetBackgroundColor [0.5,0.5,0.5,1];
		_ctrlLoad3 ctrlSetTextColor [1,1,1,1];
		_ctrlLoad3 ctrlSetScale 1;
		_ctrlLoad3 progressSetPosition ((loadAbs _entity) / (maxLoad _entity));
		_ctrlLoad3 ctrlCommit 0;
		_ctrlButtonOK = _display displayCtrl 1;
		_ctrlButtonOK ctrlRemoveAllEventHandlers 'ButtonClick';
		_ctrlButtonOK ctrlAddEventHandler ['ButtonClick',{['Confirm'] call (missionNamespace getVariable 'QS_fnc_clientMenuLoadout')}];
		_display displayRemoveAllEventHandlers 'Unload';
		private _objectPosition = getPosWorld _entity;
		private _cameraOn = cameraOn;
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
		private _timeout = -1;
		private _mass = 0;
		private _maxLoad = maxLoad _entity;
		private _loadAbs = loadAbs _entity;
		private _load = 0;
		private _class = '';
		private _value = 0;
		private _massMap = createHashMap;
		private _classMap = createHashMap;
		private _classType = -1;
		for '_i' from 0 to 1 step 0 do {
			(uiNamespace getVariable ['RscAttributeInventory_cargo',[ [],[] ]]) params ['_classes','_values'];
			_loadAbs = 0;
			{
				if (_x > 0) then {
					_class = _classes # _foreachindex;
					_value = abs _x;
					_classType = _classMap getOrDefault [_class,-1];
					if (_classType isEqualTo -1) then {
						if (getnumber (configfile >> 'cfgweapons' >> _class >> 'type') in [4096,131072]) then {
							_classType = 0;
						} else {
							if (isclass (configfile >> 'cfgmagazines' >> _class)) then {
								_classType = 1;
							} else {
								if (isclass (configfile >> 'cfgweapons' >> _class)) then {
									_classType = 2;
								} else {
									if (isclass (configfile >> 'cfgvehicles' >> _class)) then {
										_classType = 3;
									};
								};
							};
						};
						_classMap set [_class,_classType];
					};
					if (_classType isEqualTo 0) then {
						_mass = _massMap getOrDefault [_class,-1];
						if (_mass isEqualTo -1) then {
							_mass = getNumber (configFile >> 'CfgWeapons' >> _class >> 'ItemInfo' >> 'mass');
							_massMap set [_class,_mass];
						};
						_loadAbs = _loadAbs + (_mass * _value);
					};
					if (_classType isEqualTo 1) then {
						_mass = _massMap getOrDefault [_class,-1];
						if (_mass isEqualTo -1) then {
							_mass = getNumber (configFile >> 'CfgMagazines' >> _class >> 'mass');
							_massMap set [_class,_mass];
						};
						_loadAbs = _loadAbs + (_mass * _value);
					};
					if (_classType isEqualTo 2) then {
						_mass = _massMap getOrDefault [_class,-1];
						if (_mass isEqualTo -1) then {
							_mass = getNumber (configFile >> 'cfgweapons' >> _class >> 'WeaponSlotsInfo' >> 'mass');
							_massMap set [_class,_mass];
						};
						_loadAbs = _loadAbs + (_mass * _value);
					};
					if (_classType isEqualTo 3) then {
						_mass = _massMap getOrDefault [_class,-1];
						if (_mass isEqualTo -1) then {
							_mass = getNumber (configFile >> 'CfgVehicles' >> _class >> 'mass');
							_massMap set [_class,_mass];
						};
						_loadAbs = _loadAbs + (_mass * _value);
					};
				};
			} forEach _values;
			_load = _loadAbs / _maxLoad;
			if (_load > 1) then {
				if ((ctrlTextColor _ctrlLoad3) isNotEqualTo [1,0.3,0.3,1]) then {
					_ctrlLoad3 ctrlSetTextColor [1,0.3,0.3,1];
				};
			} else {
				if (_load > 0.95) then {
					if ((ctrlTextColor _ctrlLoad3) isNotEqualTo [0.3,1,0.3,1]) then {
						_ctrlLoad3 ctrlSetTextColor [0.3,1,0.3,1];
					};					
				} else {
					if ((ctrlTextColor _ctrlLoad3) isNotEqualTo [1,1,1,1]) then {
						_ctrlLoad3 ctrlSetTextColor [1,1,1,1];
					};
				};
			};
			_ctrlLoad3 progressSetPosition (_loadAbs / _maxLoad);
			if (
				([_entity,_objectPosition] call _cancel) ||
				(!dialog)
			) exitWith {
				sleep 0.1;
				waitUntil {
					closeDialog 2;
					(isNull _display)
				};
				{
					uiNamespace setVariable [_x,nil];
				} forEach [
					'RscAttributeInventory_list',
					'RscAttributeInventory_cargo',
					'RscAttributeInventory_selected',
					'RscAttributeInventory_loadBackpack',
					'RscAttributeInventory_loadMagazine',
					'RscAttributeInventory_loadWeapon'
				];
			};
			uiSleep 0.1;
		};
		ctrlDelete _ctrlFrame;
		ctrlDelete _ctrlLoad3;
		uiNamespace setVariable ['QS_client_inventoryEdit_script',scriptNull];
	};
};