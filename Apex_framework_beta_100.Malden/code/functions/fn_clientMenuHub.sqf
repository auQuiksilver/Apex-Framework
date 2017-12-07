/*/
File: fn_clientMenuHub.sqf
Author:
	
	Quiksilver
	
Last Modified:

	7/12/2017 A3 1.78 by Quiksilver

Description:

	Client Menu Hub
	
	1812
__________________________________________________________/*/

disableSerialization;
private ['_type','_display','_ctrl','_link','_ctrlB1','_ctrlB2','_ctrlB3'];
_type = _this select 0;
if (_type isEqualTo 'onLoad') exitWith {
	_display = _this select 1;
	_title = _display displayCtrl 1802;
	_title ctrlSetText 'Comm-Link';
	
	
	
	
	
	/*/======================= EDIT BELOW =======================/*/ 
	_ctrlB1 = _display displayCtrl 1804;
	_ctrlB1 ctrlSetStructuredText (parseText (format ["<a href='%1'>Community Website</a>",(call (missionNamespace getVariable ['QS_missionConfig_commURL',{}]))]));
	_ctrlB1 ctrlSetToolTip 'Link';
	_ctrlB1 ctrlEnable (!((call (missionNamespace getVariable ['QS_missionConfig_commURL',{}])) isEqualTo ''));	
	_ctrlB2 = _display displayCtrl 1805;
	_ctrlB2 ctrlSetStructuredText (parseText (format ["<a href='%1'>Community Discord</a>",(call (missionNamespace getVariable ['QS_missionConfig_commDS',{}]))]));
	_ctrlB2 ctrlSetToolTip 'Link';
	_ctrlB2 ctrlEnable (!((call (missionNamespace getVariable ['QS_missionConfig_commDS',{}])) isEqualTo ''));
	_ctrlB3 = _display displayCtrl 1809;
	_ctrlB3 ctrlSetStructuredText (parseText (format ["<a href='%1'>Community ArmA Unit</a>",(call (missionNamespace getVariable ['QS_missionConfig_commA3U',{}]))]));
	_ctrlB3 ctrlSetToolTip 'Link';
	_ctrlB3 ctrlEnable (!((call (missionNamespace getVariable ['QS_missionConfig_commA3U',{}])) isEqualTo ''));
	_ctrlB3 = _display displayCtrl 1812;
	_ctrlB3 ctrlSetStructuredText (parseText (format ["<a href='%1'>Community Donation</a>",(call (missionNamespace getVariable ['QS_missionConfig_monetizeURL',{}]))]));
	_ctrlB3 ctrlSetToolTip 'Link';
	_ctrlB3 ctrlEnable (!((call (missionNamespace getVariable ['QS_missionConfig_monetizeURL',{}])) isEqualTo ''));

	/*/======================= EDIT ABOVE =======================/*/ 
	
	
	
	
	
	
	
	
	
	
	
	
	
	(_display displayCtrl 1806) ctrlSetText 'Radio Management';
	(_display displayCtrl 1806) ctrlEnable TRUE;
	(_display displayCtrl 1807) ctrlSetText 'Group Management';
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

};
if (_type isEqualTo 'B1') exitWith {

};
if (_type isEqualTo 'B2') exitWith {

};
if (_type isEqualTo 'B3') exitWith {
	closeDialog 0;
	createDialog 'QS_RD_client_dialog_menu_radio';
};
if (_type isEqualTo 'B4') exitWith {
	closeDialog 0;
	(findDisplay 46) createDisplay 'RscDisplayDynamicGroups';
	50 cutText ['Use [Page Up] / [Page Down] to navigate the group list','PLAIN'];
};
if (_type isEqualTo 'B5') exitWith {

};
if (_type isEqualTo 'B6') exitWith {

};
if (_type isEqualTo 'Back') exitWith {
	closeDialog 0;
	createDialog 'QS_RD_client_dialog_menu_main';
};