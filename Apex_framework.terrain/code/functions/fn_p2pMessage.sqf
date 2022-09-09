/*
File: fn_p2pMessage.sqf
Author: 

	Quiksilver

Last Modified:

	20/01/2017 A3 1.66 by Quiksilver

Description:

	Send P2P Message
____________________________________________________________________________*/

params ['_type','_params'];
if (_type isEqualTo 0) exitWith {
	//comment 'Systemchat';
	systemChat _params;
};
if (_type isEqualTo 1) exitWith {
	//comment 'Titletext';
	titleText _params;
};
if (_type isEqualTo 2) exitWith {
	//comment 'hint';
	(missionNamespace getVariable 'QS_managed_hints') pushBack [5,TRUE,10,-1,_params,[],-1];
};
if (_type isEqualTo 3) exitWith {
	//comment 'hintSilent';
	(missionNamespace getVariable 'QS_managed_hints') pushBack [5,FALSE,10,-1,_params,[],-1];
};
if (_type isEqualTo 4) exitWith {
	//comment 'Notification';
	_params call (missionNamespace getVariable 'QS_fnc_showNotification');
};
if (_type isEqualTo 5) exitWith {
	//comment 'CutText';
	50 cutText _params;
};
if (_type isEqualTo 6) exitWith {
	//comment 'Sidechat';
	(_params # 0) sideChat (_params # 1);
};
if (_type isEqualTo 7) exitWith {
	//comment 'Group chat';
	(_params # 0) groupChat (_params # 1);
};