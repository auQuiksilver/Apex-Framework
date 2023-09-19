/*
File: fn_clientInteractHangar.sqf
Author:

	Quiksilver
	
Last Modified:

	15/12/2022 A3 2.10
	
Description:

	Hangar
_______________________________________*/

_hangarTarget = cameraOn;
_validHangarTypes = (call (missionNamespace getVariable 'QS_data_planeLoadouts')) apply { toLowerANSI (_x # 0) };
_customPylonPresets = (missionNamespace getVariable ['QS_missionConfig_pylonPresets',0]) isEqualTo 1;
_hasPylons = QS_hashmap_configfile getOrDefaultCall [
	format ['cfgvehicles_%1_pylons_isclass',toLowerANSI (typeOf _hangarTarget)],
	{isClass ((configOf _hangarTarget) >> 'Components' >> 'TransportPylonsComponent')},
	TRUE
];
if (!(_hasPylons)) exitWith {
	50 cutText [localize 'STR_QS_Text_309','PLAIN DOWN',0.5];
};
if (_hangarTarget getVariable ['QS_vehicle_pylons_disabled',FALSE]) exitWith {
	50 cutText [localize 'STR_QS_Text_315','PLAIN DOWN',0.5];
};
if (
	(((toLowerANSI (typeOf _hangarTarget)) in _validHangarTypes) && _customPylonPresets) ||
	(!(_customPylonPresets))
) then {
	uiNamespace setVariable ['QS_client_menuHangar_target',_hangarTarget];
	createDialog 'QS_RD_client_dialog_menu_hangar';
};