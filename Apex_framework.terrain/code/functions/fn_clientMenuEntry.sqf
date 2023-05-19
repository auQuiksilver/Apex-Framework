/*/
File: fn_clientMenuEntry.sqf
Author:
	
	Quiksilver
	
Last Modified:

	01/05/2023 A3 2.12 by Quiksilver

Description:

	Client Entry Menu
__________________________________________________________/*/
disableSerialization;
_type = _this # 0;
if (_type isEqualTo 'onLoad') then {
	_display = _this # 1;
	_ctrlTitle = _display displayCtrl 1802;
	_ctrlTitle ctrlSetText briefingName;
	_ctrlSText1 = _display displayCtrl 1806;
	private _text = '';
	_text = parseText (format [localize 'STR_QS_Menu_148',worldName,(missionNamespace getVariable ['QS_missionConfig_commTS','']),(missionNamespace getVariable ['QS_missionConfig_commDS_Adres','']),(if (isLocalized 'STR_QS_Menu_149') then {localize 'STR_QS_Menu_149'} else {(missionNamespace getVariable ['QS_missionConfig_splash_serverRules',''])}),(missionNamespace getVariable ['QS_missionConfig_splash_adminNames',''])]);
	_ctrlSText1 ctrlSetStructuredText _text;
};
if (_type isEqualTo 'B1') then {
	closeDialog 0;
};
if (_type isEqualTo 'onUnload') then {
	0 spawn {
		uiSleep 0.1;
		createDialog 'QS_client_dialog_menu_roles';
	};
};