/*
File: fn_p2pMessage.sqf
Author: 

	Quiksilver

Last Modified:

	20/01/2017 A3 1.66 by Quiksilver

Description:

	Send P2P Message
	
			_text = 'Hello';
		[63,[5,[_text,'PLAIN DOWN',1]]] remoteExec ['QS_fnc_remoteExec',-2,FALSE];
		[63,[2,'Hello!']] remoteExec ['QS_fnc_remoteExec',-2,FALSE];
		
if (_case isEqualTo 63) exitWith {
	if (!isDedicated) then {
		_array = _this select 1;
		[5,[_text,'PLAIN DOWN',1]] call (missionNamespace getVariable 'QS_fnc_p2pMessage');
	};
};

_text = 'Hello!';
[63,[5,[_text,'PLAIN DOWN',1]]] remoteExec ['QS_fnc_remoteExec',-2,FALSE];

[5,[(format ['%1 (Group leader) - %2',profileName,_order]),'PLAIN DOWN',0.333]]
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
	(_params select 0) sideChat (_params select 1);
};
if (_type isEqualTo 7) exitWith {
	//comment 'Group chat';
	(_params select 0) sideChat (_params select 1);
};