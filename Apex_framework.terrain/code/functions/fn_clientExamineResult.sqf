/*/
File: fn_clientExamineResult.sqf
Author: 

	Quiksilver

Last Modified:

	25/11/2017 A3 1.78 by Quiksilver

Description:

	Client Examine Result
____________________________________________________________________________/*/

params ['_entity','_result'];
if (_result isEqualTo -1) exitWith {
	//comment 'No intel found';
	50 cutText ['Intel located!','PLAIN',0.5];
};
if (_result isEqualTo 0) exitWith {};
if (_result isEqualTo 1) exitWith {
	//comment 'IDAP scenario agent intel';
	playSound ['Orange_Access_FM',FALSE];
	50 cutText ['Intel located!','PLAIN',0.5];
};
if (_result isEqualTo 2) exitWith {
	50 cutText ['Side task found','PLAIN',0.5];
	[84,_entity,player,(groupID (group player)),profileName,clientOwner] remoteExec ['QS_fnc_remoteExec',2,FALSE];
};
if (_result isEqualTo 3) exitWith {
	51 cutText ['<br/><br/>You located an enemy respawn tunnel entrance (Map).','PLAIN DOWN',0.5,TRUE,TRUE];
	playSound ['Orange_Access_FM',FALSE];
	[80,_entity,player,(groupID (group player)),profileName,clientOwner] remoteExec ['QS_fnc_remoteExec',2,FALSE];
};
if (_result isEqualTo 4) exitWith {
	//comment 'IDAP mini task';
	50 cutText ['Side task found','PLAIN',0.5];
	playSound ['Orange_Access_FM',FALSE];
	[81,_entity,player,(groupID (group player)),profileName,clientOwner] remoteExec ['QS_fnc_remoteExec',2,FALSE];
};
if (_result isEqualTo 5) exitWith {
	//comment 'IG mini task';
	50 cutText ['Side task found','PLAIN',0.5];
	playSound ['Orange_Access_FM',FALSE];
	[82,_entity,player,(groupID (group player)),profileName,clientOwner] remoteExec ['QS_fnc_remoteExec',2,FALSE];
};