/*
File: fn_clientMenuMain.sqf
Author:
	
	Quiksilver
	
Last Modified:

	9/02/2015 A3 1.54 by Quiksilver

Description:

	Client Menu Main
	
	missionNamespace setVariable ['QS_missionConfig_cosmetics',_monetizeCosmetics,TRUE];
__________________________________________________________*/

disableSerialization;
private ['_type','_display','_index'];
_type = _this select 0;
if (_type isEqualTo 'onLoad') exitWith {
	_display = _this select 1;
	(_display displayCtrl 1600) ctrlEnable TRUE;
	(_display displayCtrl 1600) ctrlSetText 'Comm-Link';
	(_display displayCtrl 1600) ctrlSetToolTip 'Community Hub & Radio Control';
	(_display displayCtrl 1601) ctrlSetText 'Area 51';
	(_display displayCtrl 1601) ctrlSetToolTip '';
	(_display displayCtrl 1601) ctrlEnable FALSE;
	if ((call (missionNamespace getVariable 'QS_missionConfig_cosmetics')) > 0) then {
		if ((call (missionNamespace getVariable 'QS_missionConfig_cosmetics')) isEqualTo 1) then {
			if ((getPlayerUID player) in (['S3'] call (missionNamespace getVariable 'QS_fnc_whitelist'))) then {
				(_display displayCtrl 1601) ctrlEnable TRUE;
			};
		} else {
			(_display displayCtrl 1601) ctrlEnable TRUE;
		};
	};
	(_display displayCtrl 1602) ctrlSetText 'Leaderboards';
	(_display displayCtrl 1602) ctrlEnable TRUE;
	(_display displayCtrl 1603) ctrlSetText 'Visibility';
	(_display displayCtrl 1603) ctrlSetToolTip 'View distance';
	(_display displayCtrl 1604) ctrlSetText 'Close';
	(_display displayCtrl 1604) ctrlSetToolTip '';
	(_display displayCtrl 1605) ctrlSetText 'Options';
	(_display displayCtrl 1605) ctrlSetToolTip '';
};
if (_type isEqualTo 'onUnload') exitWith {
	closeDialog 0;
};
if (_type isEqualTo 'B1') exitWith {
	['onUnload'] call (missionNamespace getVariable 'QS_fnc_clientMenuMain');
	createDialog 'QS_RD_client_dialog_menu_hub';
};
if (_type isEqualTo 'B2') exitWith {
	['onUnload'] call (missionNamespace getVariable 'QS_fnc_clientMenuMain');
	createDialog 'QS_RD_client_dialog_menu_supporters';
};
if (_type isEqualTo 'B3') exitWith {
	['onUnload'] call (missionNamespace getVariable 'QS_fnc_clientMenuMain');
	createDialog 'QS_RD_client_dialog_menu_leaderboard';
};
if (_type isEqualTo 'B4') exitWith {
	['onUnload'] call (missionNamespace getVariable 'QS_fnc_clientMenuMain');
	createDialog 'QS_RD_client_dialog_menu_viewSettings';
};
if (_type isEqualTo 'B5') exitWith {
	['onUnload'] call (missionNamespace getVariable 'QS_fnc_clientMenuMain');
	createDialog 'QS_RD_client_dialog_menu_options';
};
if (_type isEqualTo 'B6') exitWith {
	['onUnload'] call (missionNamespace getVariable 'QS_fnc_clientMenuMain');
};