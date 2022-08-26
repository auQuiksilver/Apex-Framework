/*/
File: fn_gearRestrictions.sqf
Author:

	Quiksilver
	
Last Modified:

	2/02/2019 A3 1.88 by Quiksilver
	
Description:

	Gear Restrictions
______________________________________________/*/

params ['_unit',['_arsenalType',1],'_arsenalData'];
if (_arsenalType isEqualTo 0) then {
	_arsenalData = 	[
		[
			[[],[],[],[],[],[],[]],
			[],
			[],
			[]
		],
		[
			[[],[],[],[],[],[],[]],
			[],
			[],
			[]
		]
	];
};
_uniform = toLowerANSI (uniform _unit);
_backpack = toLowerANSI (backpack _unit);
_vest = toLowerANSI (vest _unit);
_headgear = toLowerANSI (headgear _unit);
_goggles = toLowerANSI (goggles _unit);
_hmd = toLowerANSI (hmd _unit);
_weapons = (weapons _unit) apply {(toLowerANSI _x)};
_weaponAttachments = (primaryWeaponItems _unit) apply {(toLowerANSI _x)};
_weaponAttachments2 = (secondaryWeaponItems _unit) apply {(toLowerANSI _x)};
_weaponAttachments3 = (handgunItems _unit) apply {(toLowerANSI _x)};
_magazines = (magazines _unit) apply {(toLowerANSI _x)};
_items = (items _unit) apply {(toLowerANSI _x)};
_assignedItems = (assignedItems _unit) apply {(toLowerANSI _x)};
_index = [1,0] select ((missionNamespace getVariable ['QS_missionConfig_Arsenal',0]) isEqualTo 2);
_all = [];
{
	if (_forEachIndex isEqualTo 0) then {
		{
			_all = _all + _x;
		} forEach ((_arsenalData # _index) # 0);
	} else {
		_all = _all + _x;
	};
} forEach (_arsenalData # _index);
_missionBlacklist = (missionNamespace getVariable ['QS_arsenal_missionBlacklist',[[[],[],[],[]],[]]]) # 0;
if (_arsenalType isEqualTo 1) exitWith {
	// WHITELIST
	if (_weapons isNotEqualTo []) then {
		_weaponsWhitelisted = ((_arsenalData # _index) # 3) apply {(toLowerANSI _x)};
		{
			if ((!((toLowerANSI (_x call (missionNamespace getVariable 'QS_fnc_baseWeapon'))) in _weaponsWhitelisted)) || {((toLowerANSI (_x call (missionNamespace getVariable 'QS_fnc_baseWeapon'))) in (_missionBlacklist # 1))}) then {
				_unit removeWeapon _x;
			};
		} forEach _weapons;
	};
	_uniformsWhitelisted = (((_arsenalData # _index) # 0) # 0) apply {(toLowerANSI _x)};
	if ((!(_uniform in _uniformsWhitelisted)) || {(_uniform in (_missionBlacklist # 0))}) then {
		removeUniform _unit;
		_unit forceAddUniform (selectRandom _uniformsWhitelisted);
	};
	_backpacksWhitelisted = ((_arsenalData # _index) # 2) apply {(toLowerANSI _x)};
	if ((!((toLowerANSI (_backpack call (missionNamespace getVariable 'QS_fnc_baseBackpack'))) in _backpacksWhitelisted)) || {((toLowerANSI (_backpack call (missionNamespace getVariable 'QS_fnc_baseBackpack'))) in (_missionBlacklist # 3))}) then {
		removeBackpack _unit;
	};
	_vestsWhitelisted = (((_arsenalData # _index) # 0) # 1) apply {(toLowerANSI _x)};
	if ((!(_vest in _vestsWhitelisted)) || {(_vest in (_missionBlacklist # 0))}) then {
		removeVest _unit;
	};
	_headgearWhitelisted = (((_arsenalData # _index) # 0) # 4) apply {(toLowerANSI _x)};
	if ((!(_headgear in _headgearWhitelisted)) || {(_headgear in (_missionBlacklist # 0))}) then {
		removeHeadgear _unit;
	};
	_gogglesWhitelisted = (((_arsenalData # _index) # 0) # 5) apply {(toLowerANSI _x)};
	if ((!(_goggles in _gogglesWhitelisted)) || {(_goggles in (_missionBlacklist # 0))}) then {
		removeGoggles _unit;
	};
	_hmdWhitelisted = (((_arsenalData # _index) # 0) # 3) apply {(toLowerANSI _x)}; 
	if ((!(_hmd in _hmdWhitelisted)) || {(_hmd in (_missionBlacklist # 0))}) then {
		_unit unlinkItem _hmd;
	};
	if (_weaponAttachments isNotEqualTo []) then {
		_attachmentsWhitelisted = (((_arsenalData # _index) # 0) # 6) apply {(toLowerANSI _x)}; 
		{
			if ((!(_x in _attachmentsWhitelisted)) || {(_x in ((_missionBlacklist # 0) + (_missionBlacklist # 2)))}) then {
				_unit removePrimaryWeaponItem _x;
			};
		} forEach _weaponAttachments;
	};
	if (_weaponAttachments2 isNotEqualTo []) then {
		_attachments2Whitelisted = (((_arsenalData # _index) # 0) # 6) apply {(toLowerANSI _x)}; 
		{
			if ((!(_x in _attachments2Whitelisted)) || {(_x in ((_missionBlacklist # 0) + (_missionBlacklist # 2)))}) then {
				_unit removeSecondaryWeaponItem _x;
			};
		} forEach _weaponAttachments2;
	};
	if (_weaponAttachments3 isNotEqualTo []) then {
		_attachments3Whitelisted = (((_arsenalData # _index) # 0) # 6) apply {(toLowerANSI _x)}; 
		{
			if ((!(_x in _attachments3Whitelisted)) || {(_x in ((_missionBlacklist # 0) + (_missionBlacklist # 2)))}) then {
				_unit removeHandgunItem _x;
			};
		} forEach _weaponAttachments3;
	};
	_magazinesWhitelisted = ((_arsenalData # _index) # 1) apply {(toLowerANSI _x)};
	if (_magazines isNotEqualTo []) then {
		{
			if ((!(_x in _magazinesWhitelisted)) || {(_x in (_missionBlacklist # 2))}) then {
				_unit removeMagazine _x;
			};
		} forEach _magazines;
	};
	if (_items isNotEqualTo []) then {
		_whitelistedItems = _all apply {(toLowerANSI _x)};
		{
			if ((!(_x in _whitelistedItems)) || {(_x in ((missionNamespace getVariable ['QS_arsenal_missionBlacklist',[[[],[],[],[]],[]]]) # 1))}) then {
				_unit removeItem _x;
			};
		} forEach _items;
	};
	if (_assignedItems isNotEqualTo []) then {
		_whitelistedAssignedItems = (((_arsenalData # _index) # 0) # 3) apply {(toLowerANSI _x)};
		{
			if ((!(_x in _whitelistedAssignedItems)) || {(_x in (_missionBlacklist # 0))}) then {
				_unit unlinkItem _x;
				_unit unassignItem _x;
				_unit removeItem _x;
			};
		} forEach _assignedItems;
	};
};
// BLACKLIST
if (_weapons isNotEqualTo []) then {
	_weaponsBlacklisted = ((_arsenalData # _index) # 3) apply {(toLowerANSI _x)};
	{
		if (((toLowerANSI (_x call (missionNamespace getVariable 'QS_fnc_baseWeapon'))) in _weaponsBlacklisted) || {((toLowerANSI (_x call (missionNamespace getVariable 'QS_fnc_baseWeapon'))) in (_missionBlacklist # 1))}) then {
			_unit removeWeapon _x;
		};
	} forEach _weapons;
};
_uniformsBlacklisted = (((_arsenalData # _index) # 0) # 0) apply {(toLowerANSI _x)};
if ((_uniform in _uniformsBlacklisted) || {(_uniform in (_missionBlacklist # 0))}) then {
	removeUniform _unit;
};
_backpacksBlacklisted = ((_arsenalData # _index) # 2) apply {(toLowerANSI _x)};
if (((toLowerANSI (_backpack call (missionNamespace getVariable 'QS_fnc_baseBackpack'))) in _backpacksBlacklisted) || {((toLowerANSI (_backpack call (missionNamespace getVariable 'QS_fnc_baseBackpack'))) in (_missionBlacklist # 3))}) then {
	removeBackpack _unit;
};
_vestsBlacklisted = (((_arsenalData # _index) # 0) # 1) apply {(toLowerANSI _x)};
if ((_vest in _vestsBlacklisted) || {(_vest in (_missionBlacklist # 0))}) then {
	removeVest _unit;
};
_headgearBlacklisted = (((_arsenalData # _index) # 0) # 4) apply {(toLowerANSI _x)};
if ((_headgear in _headgearBlacklisted) || {(_headgear in (_missionBlacklist # 0))}) then {
	removeHeadgear _unit;
};
_gogglesBlacklisted = (((_arsenalData # _index) # 0) # 5) apply {(toLowerANSI _x)};
if ((_goggles in _gogglesBlacklisted) || {(_goggles in (_missionBlacklist # 0))}) then {
	removeGoggles _unit;
};
_hmdBlacklisted = (((_arsenalData # _index) # 0) # 3) apply {(toLowerANSI _x)};
if ((_hmd in _hmdBlacklisted) || {(_hmd in (_missionBlacklist # 0))}) then {
	_unit unlinkItem _hmd;
};
if (_weaponAttachments isNotEqualTo []) then {
	_attachmentsBlacklisted = (((_arsenalData # _index) # 0) # 6) apply {(toLowerANSI _x)}; 
	{
		if ((_x in _attachmentsBlacklisted) || {(_x in ((_missionBlacklist # 0) + (_missionBlacklist # 2)))}) then {
			_unit removePrimaryWeaponItem _x;
		};
	} forEach _attachmentsBlacklisted;
};
if (_weaponAttachments2 isNotEqualTo []) then {
	_attachments2Blacklisted = (((_arsenalData # _index) # 0) # 6) apply {(toLowerANSI _x)}; 
	{
		if ((_x in _attachments2Blacklisted) || {(_x in ((_missionBlacklist # 0) + (_missionBlacklist # 2)))}) then {
			_unit removeSecondaryWeaponItem _x;
		};
	} forEach _weaponAttachments2;
};
if (_weaponAttachments3 isNotEqualTo []) then {
	_attachments3Blacklisted = (((_arsenalData # _index) # 0) # 6) apply {(toLowerANSI _x)}; 
	{
		if ((_x in _attachments3Blacklisted) || {(_x in ((_missionBlacklist # 0) + (_missionBlacklist # 2)))}) then {
			_unit removeHandgunItem _x;
		};
	} forEach _weaponAttachments3;
};
_magazinesBlacklisted = ((_arsenalData # _index) # 1) apply {(toLowerANSI _x)};
if (_magazines isNotEqualTo []) then {
	{
		if ((_x in _magazinesBlacklisted) || {(_x in (_missionBlacklist # 2))}) then {
			_unit removeMagazine _x;
		};
	} forEach _magazines;
};
if (_items isNotEqualTo []) then {
	_blacklistedItems = _all apply {(toLowerANSI _x)};
	{
		if ((_x in _blacklistedItems) || {(_x in ((missionNamespace getVariable ['QS_arsenal_missionBlacklist',[[[],[],[],[]],[]]]) # 1))}) then {
			_unit removeItem _x;
		};
	} forEach _items;
};
if (_assignedItems isNotEqualTo []) then {
	_blacklistedAssignedItems = (((_arsenalData # _index) # 0) # 3) apply {(toLowerANSI _x)};
	{
		if ((_x in _blacklistedAssignedItems) || {(_x in (_missionBlacklist # 0))}) then {
			_unit unlinkItem _x;
			_unit unassignItem _x;
			_unit removeItem _x;
		};
	} forEach _assignedItems;
};