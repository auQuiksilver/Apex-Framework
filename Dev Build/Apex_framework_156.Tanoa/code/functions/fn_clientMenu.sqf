/*
File: fn_clientMenu.sqf
Author:
	
	Quiksilver
	
Last Modified:

	22/05/2018 A3 1.82 by Quiksilver

Description:

	Client Menu
__________________________________________________________*/

params ['_type'];
if (_type isEqualTo -1) then {
	closeDialog 2;
};
playSound 'ClickSoft';
if (_type isEqualTo 0) then {
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

if (_type isEqualTo 1) then {
	closeDialog 2;
	0 spawn {
		uiSleep 0.1;
		waitUntil {
			closeDialog 2;
			(!dialog)
		};
		createDialog 'QS_RD_client_dialog_menu_viewSettings';
	};
};