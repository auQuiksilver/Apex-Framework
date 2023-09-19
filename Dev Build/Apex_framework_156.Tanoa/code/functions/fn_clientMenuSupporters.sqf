/*
File: fn_clientMenuSupporters.sqf
Author:
	
	Quiksilver
	
Last Modified:

	15/04/2023 A3 2.12 by Quiksilver

Description:

	Supporters Menu
__________________________________________*/

disableSerialization;
private ['_type','_display'];
_type = _this # 0;
if (_type isEqualTo 'onLoad') exitWith {
	(findDisplay 2000) closeDisplay 1;
	(findDisplay 3000) closeDisplay 1;
	_display = _this # 1;
	setMousePosition (uiNamespace getVariable ['QS_ui_mousePosition',getMousePosition]);
	(_display displayCtrl 1804) ctrlEnable TRUE;
	(_display displayCtrl 1807) ctrlEnable TRUE;
	(_display displayCtrl 1808) ctrlEnable TRUE;
	
	(_display displayCtrl 1809) ctrlSetText '- - -';
	(_display displayCtrl 1809) ctrlSetToolTip '';
	(_display displayCtrl 1809) ctrlEnable FALSE;
};
if (_type isEqualTo 'onUnload') exitWith {
	uiNamespace setVariable ['QS_ui_mousePosition',getMousePosition];
};
if (_type isEqualTo 'B1') exitWith {
	// Face Paint
	closeDialog 2;
	0 spawn {
		uiSleep 0.1;
		waitUntil {
			closeDialog 2;
			(!dialog)
		};
		createDialog 'QS_RD_client_dialog_menu_face';
	};
};
if (_type isEqualTo 'B2') exitWith {
	// Insignia
	closeDialog 2;
	0 spawn {
		uiSleep 0.1;
		waitUntil {
			closeDialog 2;
			(!dialog)
		};
		createDialog 'QS_RD_client_dialog_menu_insignia';
	};
};
if (_type isEqualTo 'B3') exitWith {
	// Uniform Textures
	closeDialog 2;
	0 spawn {
		uiSleep 0.1;
		waitUntil {
			closeDialog 2;
			(!dialog)
		};
		createDialog 'QS_RD_client_dialog_menu_utexture';
	};
};
if (_type isEqualTo 'B4') exitWith {
	// Vehicle Textures
	closeDialog 2;
	0 spawn {
		uiSleep 0.1;
		waitUntil {
			closeDialog 2;
			(!dialog)
		};
		createDialog 'QS_RD_client_dialog_menu_vtexture';
	};
};
if (_type isEqualTo 'B5') exitWith {
	// Lasers
	closeDialog 2;
	0 spawn {
		uiSleep 0.1;
		waitUntil {
			closeDialog 2;
			(!dialog)
		};
		createDialog 'QS_RD_client_dialog_menu_lasers';
	};
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