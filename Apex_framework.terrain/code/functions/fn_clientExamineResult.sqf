/*/
File: fn_clientExamineResult.sqf
Author: 

	Quiksilver

Last Modified:

	22/07/2022 A3 2.10 by Quiksilver

Description:

	Client Examine Result
_______________________________________________/*/

params ['_entity','_result'];
if (_result isEqualTo -1) exitWith {
	//comment 'No intel found';
	50 cutText [localize 'STR_QS_Text_050','PLAIN',0.5];
};
if (_result isEqualTo 0) exitWith {};
if (_result isEqualTo 1) exitWith {
	//comment 'IDAP scenario agent intel';
	playSound ['Orange_Access_FM',FALSE];
	50 cutText [localize 'STR_QS_Text_049','PLAIN',0.5];
};
if (_result isEqualTo 2) exitWith {
	50 cutText [localize 'STR_QS_Text_051','PLAIN',0.5];
	[84,_entity,player,(groupID (group player)),profileName,clientOwner] remoteExec ['QS_fnc_remoteExec',2,FALSE];
};
if (_result isEqualTo 3) exitWith {
	51 cutText [localize 'STR_QS_Text_052','PLAIN DOWN',0.5,TRUE,TRUE];
	playSound ['Orange_Access_FM',FALSE];
	[80,_entity,player,(groupID (group player)),profileName,clientOwner] remoteExec ['QS_fnc_remoteExec',2,FALSE];
};
if (_result isEqualTo 4) exitWith {
	//comment 'IDAP mini task';
	50 cutText [localize 'STR_QS_Text_051','PLAIN',0.5];
	playSound ['Orange_Access_FM',FALSE];
	[81,_entity,player,(groupID (group player)),profileName,clientOwner] remoteExec ['QS_fnc_remoteExec',2,FALSE];
};
if (_result isEqualTo 5) exitWith {
	//comment 'IG mini task';
	50 cutText [localize 'STR_QS_Text_051','PLAIN',0.5];
	playSound ['Orange_Access_FM',FALSE];
	[82,_entity,player,(groupID (group player)),profileName,clientOwner] remoteExec ['QS_fnc_remoteExec',2,FALSE];
};
if (_result isEqualTo 6) exitWith {
	50 cutText [localize 'STR_QS_Text_053','PLAIN',0.5];
	playSound ['Click',FALSE];
};