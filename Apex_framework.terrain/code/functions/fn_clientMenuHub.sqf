/*/
File: fn_clientMenuHub.sqf
Author:
	
	Quiksilver
	
Last Modified:

	22/05/2018 A3 1.82 by Quiksilver

Description:

	Client Menu Hub
__________________________________________________________/*/

params ['_type'];
if (_type isEqualTo 'onLoad') exitWith {
	disableSerialization;
	params ['','_display'];
	_title = _display displayCtrl 1802;
	_title ctrlSetText (localize 'STR_QS_Menu_027');
	setMousePosition (uiNamespace getVariable ['QS_ui_mousePosition',getMousePosition]);
	
	/*/======================= EDIT BELOW =======================/*/ 
	_ctrlB1 = _display displayCtrl 1804;
	_ctrlB1 ctrlSetStructuredText (parseText (format ["<a href=%1>%2</a>",((call (missionNamespace getVariable ['QS_missionConfig_commURL',{}])) # 0),((call (missionNamespace getVariable ['QS_missionConfig_commURL',{}])) # 1)]));
	_ctrlB1 ctrlSetToolTip ((call (missionNamespace getVariable ['QS_missionConfig_commURL',{}])) # 2);
	_ctrlB1 ctrlEnable TRUE;	//(((call (missionNamespace getVariable ['QS_missionConfig_commURL',{}])) # 0) isNotEqualTo '');	
	_ctrlB2 = _display displayCtrl 1805;
	_ctrlB2 ctrlSetStructuredText (parseText (format ["<a href=%1>%2</a>",((call (missionNamespace getVariable ['QS_missionConfig_commDS',{}])) # 0),((call (missionNamespace getVariable ['QS_missionConfig_commDS',{}])) # 1)]));
	_ctrlB2 ctrlSetToolTip ((call (missionNamespace getVariable ['QS_missionConfig_commDS',{}])) # 2);
	_ctrlB2 ctrlEnable TRUE;
	_ctrlB3 = _display displayCtrl 1809;
	_ctrlB3 ctrlSetStructuredText (parseText (format ["<a href=%1>%2</a>",((call (missionNamespace getVariable ['QS_missionConfig_commA3U',{}])) # 0),((call (missionNamespace getVariable ['QS_missionConfig_commA3U',{}])) # 1)]));
	_ctrlB3 ctrlSetToolTip ((call (missionNamespace getVariable ['QS_missionConfig_commA3U',{}])) # 2);
	_ctrlB3 ctrlEnable TRUE;
	_ctrlB4 = _display displayCtrl 1812;
	_ctrlB4 ctrlSetStructuredText (parseText (format ["<a href=%1>%2</a>",((call (missionNamespace getVariable ['QS_missionConfig_monetizeURL',{}])) # 0),((call (missionNamespace getVariable ['QS_missionConfig_monetizeURL',{}])) # 1)]));
	_ctrlB4 ctrlSetToolTip ((call (missionNamespace getVariable ['QS_missionConfig_monetizeURL',{}])) # 2);
	_ctrlB4 ctrlEnable TRUE;	
	/*/======================= EDIT ABOVE =======================/*/ 
	
	
	
	
	
	
	
	
	
	
	
	
	
	(_display displayCtrl 1806) ctrlSetText (localize 'STR_QS_Menu_028');
	(_display displayCtrl 1806) ctrlEnable TRUE;
	(_display displayCtrl 1807) ctrlSetText (localize 'STR_QS_Menu_029');
	(_display displayCtrl 1807) ctrlEnable TRUE;
	(_display displayCtrl 1808) ctrlEnable FALSE;
	(_display displayCtrl 1810) ctrlEnable TRUE;

	/*/======================= DO NOT EDIT BELOW =======================/*/
	/*/ 
	Please do not tamper with the below lines.
	Part of license for use of this framework is to maintain accessibility for players to donate to the Apex Framework developer.
	Servers which have changed, altered or tampered with access this link are in violation of the EULA.
	/*/
	_ctrlB8 = _display displayCtrl 1811;
	_ctrlB8 ctrlSetStructuredText (parseText "<a href='https://goo.gl/bZABA5'>Donate to Quiksilver</a>");
	_ctrlB8 ctrlSetToolTip 'Donate to the Apex Framework developer (by Patreon)';
	_ctrlB8 ctrlEnable TRUE;
	/*/ 
	Please do not tamper with the above lines.
	Part of license for use of this framework is to maintain accessibility for players to donate to the Apex Framework developer.
	Servers which have changed, altered or tampered with access this link are in violation of the EULA.
	/*/
};
if (_type isEqualTo 'onUnload') exitWith {
	uiNamespace setVariable ['QS_ui_mousePosition',getMousePosition];
};
if (_type isEqualTo 'B1') exitWith {

};
if (_type isEqualTo 'B2') exitWith {

};
if (_type isEqualTo 'B3') exitWith {
	closeDialog 2;
	0 spawn {
		uiSleep 0.1;
		waitUntil {
			closeDialog 2;
			(!dialog)
		};
		createDialog 'QS_RD_client_dialog_menu_radio';
	};
};
if (_type isEqualTo 'B4') exitWith {
	closeDialog 2;
	0 spawn {
		uiSleep 0.1;
		waitUntil {
			closeDialog 2;
			(!dialog)
		};
		(findDisplay 46) createDisplay 'RscDisplayDynamicGroups';
		50 cutText [localize 'STR_QS_Text_168','PLAIN'];
	};
};
if (_type isEqualTo 'B5') exitWith {

};
if (_type isEqualTo 'B6') exitWith {

};
if (_type isEqualTo 'Back') exitWith {
	closeDialog 2;
	0 spawn {
		uiSleep 0.1;
		waitUntil {
			closeDialog 2;
			(!dialog)
		};
		createDialog 'QS_RD_client_dialog_menu_main';
	};
};