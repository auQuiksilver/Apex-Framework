/*
File: fn_clientMenuContext.sqf
Author:
	
	Quiksilver
	
Last Modified:

	14/12/2022 A3 2.10 by Quiksilver

Description:

	Client Context Menu
	
Notes:

(findDisplay 46) displayRemoveEventHandler ['KeyDown',QS_EH_1];
QS_EH_1 = (findDisplay 46) displayAddEventHandler [
	'KeyDown',
	{
		params ['','_key','_shift','_ctrl','_alt'];
		private _c = FALSE;		
		if (_key isEqualTo 219) then {
			if (diag_tickTime > (uiNamespace getVariable ['QS_client_menu_keyDownCooldown',-1])) then {
				uiNamespace setVariable ['QS_client_menu_keyDownCooldown',diag_tickTime + 0.5];
				if (isNull (uiNamespace getVariable ['QS_client_menu_display',displayNull])) then {
					systemChat 'open';
					uiNamespace setVariable ['QS_client_menu_display',createDialog ['QS_RD_client_dialog_menu_context', TRUE]];
				};
			};
		};
		_c;
	}
];

(findDisplay 46) displayRemoveEventHandler ['KeyDown',QS_EH_2];
QS_EH_2 = (findDisplay 46) displayAddEventHandler [
	'KeyUp',
	{
		params ['','_key','_shift','_ctrl','_alt'];
		private _c = FALSE;		
		if (_key isEqualTo 219) then {
			closeDialog 0;
		};
		_c;
	}
];



createDialog ['QS_RD_client_dialog_menu_context', TRUE];
_______________________________________________*/
disableSerialization;
params ['_type1'];
if (_type1 isEqualTo 'onLoad') exitWith {
	params ['','_display1'];
	uiNamespace setVariable ['QS_client_menu_display',_display1];
	_context = uiNamespace getVariable ['QS_client_menu_context',-1];
	if (_context isEqualTo 0) then {
	
	
	
	};
	if (_context isEqualTo 1) then {
	
	
	
	};
	if (_context isEqualTo 2) then {
	
	
	
	};
};
if (_type1 isEqualTo 'onUnload') exitWith {
	uiNamespace setVariable ['QS_client_menu_display',displayNull];
};