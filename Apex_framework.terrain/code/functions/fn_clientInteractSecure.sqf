/*/
File: fn_clientInteractSecure.sqf
Author:

	Quiksilver
	
Last modified:

	8/05/2017 A3 1.68 by Quiksilver
	
Description:

	Action Secure
__________________________________________________/*/

(_this # 3) params [
	'_cursorTarget',
	'_cursorObject'
];
if ((cameraOn distance _cursorObject) > 25) exitWith {
	50 cutText [localize 'STR_QS_Text_132','PLAIN DOWN',0.25];
};
if (
	((!(_cursorTarget isNil 'QS_secured')) && (_cursorTarget getVariable ['QS_secured',FALSE])) || 
	((!(_cursorObject isNil 'QS_secured')) && (_cursorObject getVariable ['QS_secured',FALSE]))
) exitWith {
	50 cutText [localize 'STR_QS_Text_133','PLAIN DOWN',0.75];
};
if !(_cursorTarget isNil 'QS_secureable') then {
	for '_x' from 0 to 2 step 1 do {
		_cursorTarget setVariable ['QS_secured',TRUE,TRUE];
		_cursorTarget setVariable ['QS_secureable',FALSE,TRUE];
	};
};
if !(_cursorObject isNil 'QS_secureable') then {
	for '_x' from 0 to 2 step 1 do {
		_cursorObject setVariable ['QS_secured',TRUE,TRUE];
		_cursorObject setVariable ['QS_secureable',FALSE,TRUE];
	};
};
if !(_cursorTarget isNil 'QS_isExplosion') then {
	playSound3D [getMissionPath 'media\audio\activate_mine.wss',player,FALSE,(getPosASL _cursorTarget),5,1,75];
};
if !(_cursorTarget isNil 'QS_object_GT_0') exitWith {
	player playAction 'PutDown';
	50 cutText [localize 'STR_QS_Text_134','PLAIN DOWN',0.75];
	['sideChat',[WEST,'BLU'],(format [localize 'STR_QS_Chat_030',(groupID (group player)),(['Kavala','Georgetown'] select (worldName isEqualTo 'Tanoa')),localize 'STR_QS_Chat_032'])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
	[71,_cursorTarget,TRUE] remoteExecCall ['QS_fnc_remoteExec',2,FALSE];
};
if !(_cursorObject isNil 'QS_object_GT_0') exitWith {
	player playAction 'PutDown';
	50 cutText [localize 'STR_QS_Text_134','PLAIN DOWN',0.75];
	['sideChat',[WEST,'BLU'],(format [localize 'STR_QS_Chat_030',(groupID (group player)),(['Kavala','Georgetown'] select (worldName isEqualTo 'Tanoa')),localize 'STR_QS_Chat_032'])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
	[71,_cursorObject,TRUE] remoteExecCall ['QS_fnc_remoteExec',2,FALSE];
};
if !(_cursorTarget isNil 'QS_object_GT_1') exitWith {
	player playAction 'PutDown';
	50 cutText [localize 'STR_QS_Text_135','PLAIN DOWN',0.75];
	['systemChat',(format [localize 'STR_QS_Chat_031',(groupID (group player)),(['Kavala','Georgetown'] select (worldName isEqualTo 'Tanoa'))])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
	[71,_cursorTarget,TRUE] remoteExecCall ['QS_fnc_remoteExec',2,FALSE];
};
if !(_cursorObject isNil 'QS_object_GT_1') exitWith {
	player playAction 'PutDown';
	50 cutText [localize 'STR_QS_Text_135','PLAIN DOWN',0.75];
	['systemChat',(format [localize 'STR_QS_Chat_031',(groupID (group player)),(['Kavala','Georgetown'] select (worldName isEqualTo 'Tanoa'))])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
	[71,_cursorObject,TRUE] remoteExecCall ['QS_fnc_remoteExec',2,FALSE];
};
if !(_cursorTarget isNil 'QS_sc_subObj_1') exitWith {
	player playAction 'PutDown';
	50 cutText [localize 'STR_QS_Text_136','PLAIN DOWN',0.75];
	['sideChat',[WEST,'BLU'],(format ['%1 %2',(groupID (group player)),localize 'STR_QS_Chat_033'])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
	[73,1] remoteExec ['QS_fnc_remoteExec',2,FALSE];
};
if !(_cursorObject isNil 'QS_sc_subObj_1') exitWith {
	player playAction 'PutDown';
	50 cutText [localize 'STR_QS_Text_136','PLAIN DOWN',0.75];
	['sideChat',[WEST,'BLU'],(format ['%1 %2',(groupID (group player)),localize 'STR_QS_Chat_033'])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
	[73,1] remoteExec ['QS_fnc_remoteExec',2,FALSE];
};
if !(_cursorTarget isNil 'QS_sc_subObj_3') exitWith {
	player playAction 'PutDown';
	50 cutText [localize 'STR_QS_Text_136','PLAIN DOWN',0.75];
	['sideChat',[WEST,'BLU'],(format ['%1 %2',(groupID (group player)),localize 'STR_QS_Chat_034'])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
	[73,3] remoteExec ['QS_fnc_remoteExec',2,FALSE];
};
if !(_cursorObject isNil 'QS_sc_subObj_3') exitWith {
	player playAction 'PutDown';
	50 cutText [localize 'STR_QS_Text_136','PLAIN DOWN',0.75];
	['sideChat',[WEST,'BLU'],(format ['%1 %2',(groupID (group player)),localize 'STR_QS_Chat_034'])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
	[73,3] remoteExec ['QS_fnc_remoteExec',2,FALSE];
};
player playAction 'PutDown';
['sideChat',[WEST,'BLU'],(format ['%1 %2',(groupID (group player)),localize 'STR_QS_Chat_035'])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
50 cutText [localize 'STR_QS_Text_137','PLAIN DOWN',0.75];
missionNamespace setVariable ['QS_smSuccess',TRUE,TRUE];
TRUE;