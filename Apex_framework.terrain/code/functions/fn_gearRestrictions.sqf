/*/
File: fn_gearRestrictions.sqf
Author:

	Quiksilver
	
Last Modified:

	18/12/2017 A3 1.80 by Quiksilver
	
Description:

	Gear Restrictions
	
Notes:

	Gear Restriction Application
_____________________________________________________________________/*/

params ['_unit',['_arsenalType',1],'_arsenalData'];
_uniform = toLower (uniform _unit);
_backpack = toLower (backpack _unit);
_vest = toLower (vest _unit);
_headgear = toLower (headgear _unit);
_goggles = toLower (goggles _unit);
_hmd = toLower (hmd _unit);
_weapons = (weapons _unit) apply {(toLower _x)};
_weaponAttachments = (primaryWeaponItems _unit) apply {(toLower _x)};
_weaponAttachments2 = (secondaryWeaponItems _unit) apply {(toLower _x)};
_weaponAttachments3 = (handgunItems _unit) apply {(toLower _x)};
_magazines = (magazines _unit) apply {(toLower _x)};
_items = (items _unit) apply {(toLower _x)};
_assignedItems = (assignedItems _unit) apply {(toLower _x)};
if (_arsenalType isEqualTo 1) exitWith {
	// WHITELIST
	if (!(_weapons isEqualTo [])) then {
		_weaponsWhitelisted = (_arsenalData select 1) select 3;
		{
			if (!(_x in _weaponsWhitelisted)) then {
				_unit removeWeapon _x;
			};
		} forEach _weapons;
	};
	_uniformsWhitelisted = ((_arsenalData select 1) select 0) select 0;
	if (!(_uniform in _uniformsWhitelisted)) then {
		removeUniform _unit;
		_unit forceAddUniform (selectRandom _uniformsWhitelisted);
	};
	_backpacksWhitelisted = (_arsenalData select 1) select 2;
	if (!(_backpack in _backpacksWhitelisted)) then {
		removeBackpack _unit;
	};
	_vestsWhitelisted = ((_arsenalData select 1) select 0) select 1;
	if (!(_vest in _vestsWhitelisted)) then {
		removeVest _unit;
	};
	_headgearWhitelisted = ((_arsenalData select 1) select 0) select 4;
	if (!(_headgear in _headgearWhitelisted)) then {
		removeHeadgear _unit;
	};
	_gogglesWhitelisted = ((_arsenalData select 1) select 0) select 5;
	if (!(_goggles in _gogglesWhitelisted)) then {
		removeGoggles _unit;
	};
	_hmdWhitelisted = ((_arsenalData select 1) select 0) select 3; 
	if (!(_hmd in _hmdWhitelisted)) then {
		_unit unlinkItem _hmd;
	};
	if (!(_weaponAttachments isEqualTo [])) then {
		_attachmentsWhitelisted = ((_arsenalData select 1) select 0) select 6; 
		{
			if (!(_x in _attachmentsWhitelisted)) then {
				_unit removePrimaryWeaponItem _x;
			};
		} forEach _weaponAttachments;
	};
	if (!(_weaponAttachments2 isEqualTo [])) then {
		_attachments2Whitelisted = ((_arsenalData select 1) select 0) select 6; 
		{
			if (!(_x in _attachments2Whitelisted)) then {
				_unit removeSecondaryWeaponItem _x;
			};
		} forEach _weaponAttachments2;
	};
	if (!(_weaponAttachments3 isEqualTo [])) then {
		_attachments3Whitelisted = ((_arsenalData select 1) select 0) select 6; 
		{
			if (!(_x in _attachments3Whitelisted)) then {
				_unit removeHandgunItem _x;
			};
		} forEach _weaponAttachments3;
	};
	_magazinesWhitelisted = (_arsenalData select 1) select 1;
	if (!(_magazines isEqualTo [])) then {
		{
			if (!(_x in _magazinesWhitelisted)) then {
				_unit removeMagazine _x;
			};
		} forEach _magazines;
	};
	if (!(_items isEqualTo [])) then {
		_whitelistedItems = ((_arsenalData select 1) select 0) select 2;
		{
			if (!(_x in _whitelistedItems)) then {
				_unit removeItem _x;
			};
		} forEach _items;
	};
	if (!(_assignedItems isEqualTo [])) then {
		_whitelistedAssignedItems = ((_arsenalData select 1) select 0) select 3;
		{
			if (!(_x in _whitelistedAssignedItems)) then {
				_unit unlinkItem _x;
				_unit unassignItem _x;
				_unit removeItem _x;
			};
		} forEach _assignedItems;
	};
};
// BLACKLIST
if (!(_weapons isEqualTo [])) then {
	_weaponsBlacklisted = (_arsenalData select 0) select 3;
	{
		if (_x in _weaponsBlacklisted) then {
			_unit removeWeapon _x;
		};
	} forEach _weapons;
};
_uniformsBlacklisted = ((_arsenalData select 0) select 0) select 0;
if (_uniform in _uniformsBlacklisted) then {
	removeUniform _unit;
};
_backpacksBlacklisted = (_arsenalData select 0) select 2;
if (_backpack in _backpacksBlacklisted) then {
	removeBackpack _unit;
};
_vestsBlacklisted = ((_arsenalData select 0) select 0) select 1;
if (_vest in _vestsBlacklisted) then {
	removeVest _unit;
};
_headgearBlacklisted = ((_arsenalData select 0) select 0) select 4;
if (_headgear in _headgearBlacklisted) then {
	removeHeadgear _unit;
};
_gogglesBlacklisted = ((_arsenalData select 0) select 0) select 5;
if (_goggles in _gogglesBlacklisted) then {
	removeGoggles _unit;
};
_hmdBlacklisted = ((_arsenalData select 0) select 0) select 3; 
if (_hmd in _hmdBlacklisted) then {
	_unit unlinkItem _hmd;
};
if (!(_weaponAttachments isEqualTo [])) then {
	_attachmentsBlacklisted = ((_arsenalData select 0) select 0) select 6; 
	{
		if (_x in _attachmentsBlacklisted) then {
			_unit removePrimaryWeaponItem _x;
		};
	} forEach _attachmentsBlacklisted;
};
if (!(_weaponAttachments2 isEqualTo [])) then {
	_attachments2Blacklisted = ((_arsenalData select 0) select 0) select 6; 
	{
		if (_x in _attachments2Blacklisted) then {
			_unit removeSecondaryWeaponItem _x;
		};
	} forEach _weaponAttachments2;
};
if (!(_weaponAttachments3 isEqualTo [])) then {
	_attachments3Blacklisted = ((_arsenalData select 0) select 0) select 6; 
	{
		if (_x in _attachments3Blacklisted) then {
			_unit removeHandgunItem _x;
		};
	} forEach _weaponAttachments3;
};
_magazinesBlacklisted = (_arsenalData select 0) select 1;
if (!(_magazines isEqualTo [])) then {
	{
		if (_x in _magazinesBlacklisted) then {
			_unit removeMagazine _x;
		};
	} forEach _magazines;
};
if (!(_items isEqualTo [])) then {
	_blacklistedItems = ((_arsenalData select 0) select 0) select 2;
	{
		if (_x in _blacklistedItems) then {
			_unit removeItem _x;
		};
	} forEach _items;
};
if (!(_assignedItems isEqualTo [])) then {
	_blacklistedAssignedItems = ((_arsenalData select 0) select 0) select 3;
	{
		if (_x in _blacklistedAssignedItems) then {
			_unit unlinkItem _x;
			_unit unassignItem _x;
			_unit removeItem _x;
		};
	} forEach _assignedItems;
};