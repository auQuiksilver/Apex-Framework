/*/
File: fn_clientInteractCustomizeInventory.sqf
Author:

	Quiksilver
	
Last Modified:

	13/05/2017 A3 1.70 by Quiksilver
	
Description:

	-
_____________________________________________________________/*/

_cursorObject = cursorObject;
if (isNull _cursorObject) exitWith {};
if ((player distance _cursorObject) > 10) exitWith {};
if (!alive _cursorObject) exitWith {};
if ((typeOf _cursorObject) in ['FlexibleTank_01_sand_F','FlexibleTank_01_forest_F']) exitWith {};
missionNamespace setVariable ['BIS_fnc_initCuratorAttributes_target',_cursorObject,FALSE];
uiNamespace setVariable ['RscAttributeInventory_list',nil];
createDialog 'RscDisplayAttributesInventory';
if (!isNull (getAssignedCuratorLogic player)) exitWith {};
[_cursorObject] spawn {
	_entity = _this select 0;
	50 cutText ['Please wait ...','PLAIN',1];
	[5] spawn (missionNamespace getVariable 'QS_fnc_clientDisableUserInput');
	waitUntil {
		uiSleep 1;
		(!isNil {uiNamespace getVariable 'RscAttributeInventory_list'})
	};
	uiSleep 1;
	_weaponAddons = missionnamespace getvariable ['RscAttrbuteInventory_weaponAddons',[]];
	_types = [
		['AssaultRifle','Shotgun','Rifle','SubmachineGun'],
		["MachineGun"],
		["SniperRifle"],
		["Launcher","MissileLauncher","RocketLauncher"],
		["Handgun"],
		["UnknownWeapon"],
		["AccessoryMuzzle","AccessoryPointer","AccessorySights","AccessoryBipod"],
		["Uniform"],
		["Vest"],
		["Backpack"],
		["Headgear","Glasses"],
		["Binocular","Compass","FirstAidKit","GPS","LaserDesignator","Map","Medikit","MineDetector","NVGoggles","Radio","Toolkit","Watch","UAVTerminal",'Laserdesignator_02','Laserdesignator_03','Laserdesignator_01_khk_F','Laserdesignator_02_ghex_F']
	];
	_typeMagazine = _types find 'Magazine';
	_list = [[],[],[],[],[],[],[],[],[],[],[],[]];
	_magazines = [];
	_blacklistedStuff = [
	
	
	
	];
	{
		_addon = tolower _x;
		_addonList = [[],[],[],[],[],[],[],[],[],[],[],[]];
		_addonID = _weaponAddons find _addon;
		if (_addonID < 0) then {
			{
				_weapon = tolower _x;
				_weaponType = (_weapon call bis_fnc_itemType);
				_weaponTypeCategory = _weaponType select 0;
				_weaponTypeSpecific = _weaponType select 1;
				_weaponTypeID = -1;
				{
					if (_weaponTypeSpecific in _x) exitwith {_weaponTypeID = _foreachindex;};
				} foreach _types;
				if (_weaponTypeCategory != "VehicleWeapon" && _weaponTypeID >= 0) then {
					_weaponCfg = configfile >> "cfgweapons" >> _weapon;
					_weaponPublic = getnumber (_weaponCfg >> "scope") isEqualTo 2;
					_addonListType = _addonList select _weaponTypeID;
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
							_muzzle = if (_x == "this") then {_weaponCfg} else {_weaponCfg >> _x};
							_magazinesList = getArray (_muzzle >> "magazines");
							// Add magazines from magazine wells
							{
								{
									_magazinesList append (getArray _x);
								} foreach  configProperties [configFile >> "CfgMagazineWells" >> _x, "isArray _x"];
							} foreach getArray (_muzzle >> "magazineWell");
							{
								_mag = tolower _x;
								if ((_addonListType findIf {((_x select 2) == _mag)}) isEqualTo -1) then {
									_magCfg = configfile >> "cfgmagazines" >> _mag;
									if (getnumber (_magCfg >> "scope") isEqualTo 2) then {
										_displayName = gettext (_magCfg >> "displayName");
										_picture = gettext (_magCfg >> "picture");
										_addonListType pushback [_displayName,_displayName,_mag,_picture,2,_mag in _magazines];
										_magazines pushback _mag;
									};
								};
							} foreach _magazinesList;
						} foreach getarray (_weaponCfg >> "muzzles");
					};
				};
			} foreach getarray (configfile >> "cfgpatches" >> _x >> "weapons");
			{
				_weapon = tolower _x;
				_weaponType = _weapon call bis_fnc_itemType;
				_weaponTypeSpecific = _weaponType select 1;
				_weaponTypeID = -1;
				{
					if (_weaponTypeSpecific in _x) exitwith {_weaponTypeID = _foreachindex;};
				} foreach _types;
				if (_weaponTypeID >= 0) then {
					_weaponCfg = configfile >> "cfgvehicles" >> _weapon;
					if (getnumber (_weaponCfg >> "scope") isEqualTo 2) then {
						_displayName = gettext (_weaponCfg >> "displayName");
						_picture = gettext (_weaponCfg >> "picture");
						_addonListType = _addonList select _weaponTypeID;
						_addonListType pushback [_displayName,_displayName,_weapon,_picture,3,false];
					};
				};
			} foreach getarray (configfile >> "cfgpatches" >> _x >> "units");
			_weaponAddons set [count _weaponAddons,_addon];
			_weaponAddons set [count _weaponAddons,_addonList];
		} else {
			_addonList = _weaponAddons select (_addonID + 1);
		};
		{
			_current = _list select _foreachindex;
			_list set [_foreachindex,_current + (_x - _current)];
		} foreach _addonList;
	} foreach activatedAddons;
	missionnamespace setvariable ['RscAttrbuteInventory_weaponAddons',_weaponAddons];
	uiNamespace setVariable ['RscAttributeInventory_list',_list];
	_cargo = [
		getWeaponCargo _entity,
		getMagazineCargo _entity,
		getItemCargo _entity,
		getBackpackCargo _entity
	];
	_virtualCargo = [
		_entity call (missionNamespace getVariable 'BIS_fnc_getVirtualWeaponCargo'),
		_entity call (missionNamespace getVariable 'BIS_fnc_getVirtualMagazineCargo'),
		_entity call (missionNamespace getVariable 'BIS_fnc_getVirtualItemCargo'),
		_entity call (missionNamespace getVariable 'BIS_fnc_getVirtualBackpackCargo')
	];
	{
		_xCargo = _cargo select _foreachindex;
		{
			_index = (_xCargo select 0) find _x;
			if (_index < 0) then {
				(_xCargo select 0) set [count (_xCargo select 0),_x];
				(_xCargo select 1) set [count (_xCargo select 1),-1];
			} else {
				(_xCargo select 1) set [_index,-1];
			};
		} foreach _x;
	} foreach _virtualCargo;
	RscAttributeInventory_cargo = [[],[]];
	{
		RscAttributeInventory_cargo set [0,(RscAttributeInventory_cargo select 0) + (_x select 0)];
		RscAttributeInventory_cargo set [1,(RscAttributeInventory_cargo select 1) + (_x select 1)];
	} foreach _cargo;
	RscAttributeInventory_selected = 0;
	playSound ['Click',FALSE];
	50 cutText ['Initialization complete, select tab above','PLAIN',1];
	titleFadeOut 3;
	if (userInputDisabled) then {
		disableUserInput FALSE;
	};
	private _index = 0;
	private _cfgTransportMaxBackpacks = [(configFile >> 'CfgVehicles' >> (typeof _entity)),'transportMaxBackpacks',-1] call (missionNamespace getVariable 'BIS_fnc_returnConfigEntry');
	private _cfgTransportMaxMagazines = [(configFile >> 'CfgVehicles' >> (typeof _entity)),'transportMaxMagazines',-1] call (missionNamespace getVariable 'BIS_fnc_returnConfigEntry');
	private _cfgTransportMaxWeapons = [(configFile >> 'CfgVehicles' >> (typeof _entity)),'transportMaxWeapons',-1] call (missionNamespace getVariable 'BIS_fnc_returnConfigEntry');
	if (_cfgTransportMaxBackpacks isEqualTo -1) then {
		_cfgTransportMaxBackpacks = 2;
	};
	if (_cfgTransportMaxMagazines isEqualTo -1) then {
		_cfgTransportMaxMagazines = 20;
	};
	if (_cfgTransportMaxWeapons isEqualTo -1) then {
		_cfgTransportMaxWeapons = 5;
	};
	private _backpackCargo = backpackCargo _entity;
	private _magazineCargo = magazineCargo _entity;
	private _weaponCargo = weaponCargo _entity;
	for '_x' from 0 to 1 step 0 do {
		if (alive _entity) then {
			//comment 'Validate weight params here';
			_backpackCargo = backpackCargo _entity;
			if ((count _backpackCargo) > _cfgTransportMaxBackpacks) then {
				clearBackpackCargoGlobal _entity;
				50 cutText ['Crate overfilled, removing excess backpacks','PLAIN DOWN',0.25];
				_index = 0;
				for '_x' from 0 to ((count _backpackCargo) - 1) step 1 do {
					if (_index >= _cfgTransportMaxBackpacks) exitWith {};
					_entity addBackpackCargoGlobal [(_backpackCargo select _index),1];
					_index = _index + 1;
				};
			};
			_magazineCargo = magazineCargo _entity;
			if ((count _magazineCargo) > _cfgTransportMaxMagazines) then {
				clearMagazineCargoGlobal _entity;
				50 cutText ['Crate overfilled, removing excess magazines','PLAIN DOWN',0.25];
				_index = 0;
				for '_x' from 0 to ((count _magazineCargo) - 1) step 1 do {
					if (_index >= _cfgTransportMaxMagazines) exitWith {};
					_entity addMagazineCargoGlobal [(_magazineCargo select _index),1];
					_index = _index + 1;
				};
			};
			_weaponCargo = weaponCargo _entity;
			if ((count _weaponCargo) > _cfgTransportMaxWeapons) then {
				clearWeaponCargoGlobal _entity;
				50 cutText ['Crate overfilled, removing excess weapons','PLAIN DOWN',0.25];
				_index = 0;
				for '_x' from 0 to ((count _weaponCargo) - 1) step 1 do {
					if (_index >= _cfgTransportMaxWeapons) exitWith {};
					_entity addWeaponCargoGlobal [(_weaponCargo select _index),1];
					_index = _index + 1;
				};
			};
		};
		if (((player distance _entity) > 10) || {(!dialog)}) exitWith {
			closeDialog 0;
		};
		uiSleep 0.1;
	};
};