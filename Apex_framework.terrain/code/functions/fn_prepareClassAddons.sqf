/*/
File: fn_prepareClassAddons.sqf
Author:

	Sa-Matra
	
Last Modified:

	12/12/2022 A3 2.10 by Quiksilver
	
Description:

	Prepare Class Addons (for DLC/Mod compatibility)
___________________________________________/*/

private _class = toLowerANSI _this;
if (isNil 'QS_addonCheckedClasses') then {QS_addonCheckedClasses = createHashMap;};
if (_class in QS_addonCheckedClasses) exitWith {};
private _needed = (unitAddons _class) apply {toLowerANSI _x};
private _active = activatedAddons;
private _missing = _needed - (_needed arrayIntersect _active);
if (_missing isNotEqualTo []) then {
	_active append _missing;
	activateAddons _active;
};
QS_addonCheckedClasses set [_class,_needed];