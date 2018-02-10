/*
File: fn_clientMenu.sqf
Author:
	
	Quiksilver
	
Last Modified:

	8/09/2015 ArmA 3 1.50 by Quiksilver

Description:

	Client Menu
__________________________________________________________*/

_type = _this select 0;
if (_type isEqualTo -1) then {
	closeDialog 0;
};
playSound 'ClickSoft';
player setVariable ['QS_RD_menuing',TRUE,FALSE];
if (_type isEqualTo 0) then {
	if (!isNull (findDisplay 2000)) then {
		(findDisplay 2000) closeDisplay 0;
	};
	createDialog 'QS_RD_client_dialog_menu_main';
};

if (_type isEqualTo 1) then {
	if (!isNull (findDisplay 2000)) then {
		(findDisplay 2000) closeDisplay 1;
	};
	if (!isNull (findDisplay 3000)) then {
		(findDisplay 3000) closeDisplay 0;
	};
	createDialog 'QS_RD_client_dialog_menu_viewSettings';
};