/*/
File: fn_clientMenuEntry.sqf
Author:
	
	Quiksilver
	
Last Modified:

	28/04/2023 A3 2.12 by Quiksilver

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
	_text = parseText format [
		'<t underline="true">%5</t>
		<br/><t size="1">%6 %1 %7</t><br/><br/><t underline="true">%8</t><t size="1"><br/>%3</t><br/>
		<br/><t underline="true">%9</t><br/><t size="1">%4</t><br/><br/><t underline="true">%10</t>
		<br/><t size="1">%2</t><br/><br/><t underline="true">%11</t>
		<br/><t size="1">%22 - %23 - %24<br/><br/>
		<br/><t size="1">%12 - %13<br/>%14 - %15
		<br/>[4] - %16<br/>[L.Ctrl]+[%17] - %18<br/>[V] - %19
		<br/>[U] - %20<br/>[J]x2 - %21</t>',
		(missionNamespace getVariable ['QS_terrain_worldName',worldName]),
		(missionNamespace getVariable ['QS_missionConfig_commTS','']),
		(missionNamespace getVariable ['QS_missionConfig_splash_serverRules','']),
		(missionNamespace getVariable ['QS_missionConfig_splash_adminNames','']),
		localize 'STR_QS_Menu_148',
		localize 'STR_QS_Menu_149',
		localize 'STR_QS_Menu_150',
		localize 'STR_QS_Menu_151',
		localize 'STR_QS_Menu_152',
		localize 'STR_QS_Menu_153',
		localize 'STR_QS_Menu_154',
		localize 'STR_QS_Menu_155',
		localize 'STR_QS_Menu_009',
		localize 'STR_QS_Menu_156',
		localize 'STR_QS_Menu_157',
		localize 'STR_QS_Menu_158',
		localize 'STR_QS_Menu_159',
		localize 'STR_QS_Menu_160',
		localize 'STR_QS_Menu_161',
		localize 'STR_QS_Menu_162',
		localize 'STR_QS_Menu_163',
		localize 'STR_QS_Diary_150',
		localize 'STR_QS_Diary_152',
		actionKeysNames ['User20',1] trim ['"',0]
	];
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