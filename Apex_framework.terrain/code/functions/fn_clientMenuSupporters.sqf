/*
File: fn_clientMenuSupporters.sqf
Author:
	
	Quiksilver
	
Last Modified:

	24/08/2016 A3 1.62 by Quiksilver

Description:

	Cliet Menu Supporters
__________________________________________________________*/

disableSerialization;
private ['_type','_display'];

_type = _this select 0;

if (_type isEqualTo 'onLoad') exitWith {
	(findDisplay 2000) closeDisplay 1;
	(findDisplay 3000) closeDisplay 1;
	_display = _this select 1;
	setMousePosition (uiNamespace getVariable ['QS_ui_mousePosition',getMousePosition]);
	(_display displayCtrl 1804) ctrlEnable FALSE;
	(_display displayCtrl 1807) ctrlEnable TRUE;
	(_display displayCtrl 1808) ctrlEnable FALSE;
	
	(_display displayCtrl 1809) ctrlSetText '- - -';
	(_display displayCtrl 1809) ctrlSetToolTip '';
	(_display displayCtrl 1809) ctrlEnable FALSE;
};
if (_type isEqualTo 'onUnload') exitWith {
	uiNamespace setVariable ['QS_ui_mousePosition',getMousePosition];
};
if (_type isEqualTo 'B1') exitWith {

};
if (_type isEqualTo 'B2') exitWith {
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

};
if (_type isEqualTo 'B6') exitWith {
	50 cutText ['Soon','PLAIN',0.25];
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