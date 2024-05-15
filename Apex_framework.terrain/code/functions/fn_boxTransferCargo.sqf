/*
File: fn_boxTransferCargo.sqf
Author: 

	Quiksilver

Last Modified:

	22/05/2016 A3 1.58 by Quiksilver

Description:

	Transfer Cargo from one box to another
____________________________________________________________________________*/

params ['_boxFrom','_boxTo','_deleteBoxFrom'];
_weapons = getWeaponCargo _boxFrom;
if ((_weapons # 0) isNotEqualTo []) then {
	{
		_boxTo addWeaponCargoGlobal [_x,((_weapons # 1) # _forEachIndex)];
	} forEach (_weapons # 0);
};
_items = getItemCargo _boxFrom;
if ((_items # 0) isNotEqualTo []) then {
	{
		_boxTo addItemCargoGlobal [_x,((_items # 1) # _forEachIndex)];
	} forEach (_items # 0);
};
_magazines = getMagazineCargo _boxFrom;
if ((_magazines # 0) isNotEqualTo []) then {
	{
		_boxTo addMagazineCargoGlobal [_x,((_magazines # 1) # _forEachIndex)];
	} forEach (_magazines # 0);
};
_backpacks = getBackpackCargo _boxFrom;
if ((_backpacks # 0) isNotEqualTo []) then {
	{
		_boxTo addBackpackCargoGlobal [_x,((_backpacks # 1) # _forEachIndex)];
	} forEach (_backpacks # 0);
};
if (_deleteBoxFrom) then {
	deleteVehicle _boxFrom;
} else {
	clearWeaponCargoGlobal _boxFrom;
	clearItemCargoGlobal _boxFrom;
	clearMagazineCargoGlobal _boxFrom;
	clearBackpackCargoGlobal _boxFrom;
};