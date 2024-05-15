/*
File: fn_clientEventInventoryOpened.sqf
Author: 

	Quiksilver
	
Last modified:

	22/01/2023 A3 2.10 by Quiksilver
	
Description:

	Inventory Opened Event
_____________________________________________*/

params ['_unit','_inventory','_inventory2'];
if (!(missionNamespace getVariable ['QS_client_triggerGearCheck',FALSE])) then {
	missionNamespace setVariable ['QS_client_triggerGearCheck',TRUE,FALSE];
};
private _c = FALSE;
_isBackpack = QS_hashmap_configfile getOrDefaultCall [
	format ['cfgvehicles_%1_isbackpack',toLowerANSI (typeOf _inventory)],
	{getNumber ((configOf _inventory) >> 'isBackpack')},
	TRUE
];
['MONITOR',_unit,_inventory,_isBackpack] spawn QS_fnc_lockBackpack;
if (
	(_inventory getVariable ['QS_arsenal_object',FALSE]) &&
	{(_inventory isNotEqualTo _unit)}
) then {
	['Open',TRUE] call (missionNamespace getVariable 'BIS_fnc_arsenal');
	if (uiNamespace isNil 'QS_arsenalAmmoPrompt') then {
		uiNamespace setVariable ['QS_arsenalAmmoPrompt',TRUE];
		50 cutText [localize 'STR_QS_Text_022','PLAIN'];
	};
	_c = TRUE;
};
if (_inventory getVariable ['QS_inventory_disabled',FALSE]) then {
	50 cutText [localize 'STR_QS_Text_023','PLAIN'];
	_c = TRUE;
};
if (_isBackpack isEqualTo 1) then {
	_objectParent = objectParent _inventory;
	if (
		(alive _objectParent) &&
		{(isPlayer _objectParent)} &&
		{(_objectParent getVariable ['QS_lockedInventory',FALSE])}
	) then {
		50 cutText [(format ['%1 %2',(name _objectParent),localize 'STR_QS_Text_020']),'PLAIN',0.5];
		_c = TRUE;
	};
};
if (_inventory isEqualTo (missionNamespace getVariable ['QS_csatCommander',objNull])) then {
	_inventory call (missionNamespace getVariable 'QS_fnc_clientInteractBeret');
};
_c;