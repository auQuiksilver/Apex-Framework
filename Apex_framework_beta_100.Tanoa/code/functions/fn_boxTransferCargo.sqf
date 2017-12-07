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
if (!((_weapons select 0) isEqualTo [])) then {
	{
		_boxTo addWeaponCargoGlobal [_x,((_weapons select 1) select _forEachIndex)];
	} forEach (_weapons select 0);
};
_items = getItemCargo _boxFrom;
if (!((_items select 0) isEqualTo [])) then {
	{
		_boxTo addItemCargoGlobal [_x,((_items select 1) select _forEachIndex)];
	} forEach (_items select 0);
};
_magazines = getMagazineCargo _boxFrom;
if (!((_magazines select 0) isEqualTo [])) then {
	{
		_boxTo addMagazineCargoGlobal [_x,((_magazines select 1) select _forEachIndex)];
	} forEach (_magazines select 0);
};
_backpacks = getBackpackCargo _boxFrom;
if (!((_backpacks select 0) isEqualTo [])) then {
	{
		_boxTo addBackpackCargoGlobal [_x,((_backpacks select 1) select _forEachIndex)];
	} forEach (_backpacks select 0);
};
if (_deleteBoxFrom) then {
	missionNamespace setVariable [
		'QS_analytics_entities_deleted',
		((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),
		FALSE
	];
	deleteVehicle _boxFrom;
} else {
	clearWeaponCargoGlobal _boxFrom;
	clearItemCargoGlobal _boxFrom;
	clearMagazineCargoGlobal _boxFrom;
	clearBackpackCargoGlobal _boxFrom;
};