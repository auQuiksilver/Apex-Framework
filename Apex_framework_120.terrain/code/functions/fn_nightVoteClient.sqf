/*
@filename: fn_nightVoteClient.sqf
Author:

	Quiksilver
	
Last modified:

	1/12/2015 A3 1.52 by Quiksilver
	
Description:

	Obsoleted by night cycle
__________________________________________________*/

if (isServer) exitWith {};
uiSleep 3;
QS_voteAction_1 = player addAction [
	'Vote For Nighttime!',
	{
		{
			player removeAction _x;
		} count [QS_voteAction_1,QS_voteAction_2];
		QS_vote_1 = 1; 
		[56,QS_vote_1] remoteExec ['QS_fnc_remoteExec',2,FALSE];
	},
	[],
	95,
	TRUE,
	TRUE,
	'',
	'true'
];
player setUserActionText [QS_voteAction_1,((player actionParams QS_voteAction_1) select 0),(format ["<t size='3'>%1</t>",((player actionParams QS_voteAction_1) select 0)])];
QS_voteAction_2 = player addAction [
	'Vote Against Nighttime!',
	{
		{
			player removeAction _x;
		} count [QS_voteAction_1,QS_voteAction_2];
		QS_vote_1 = 2; 
		[56,QS_vote_1] remoteExec ['QS_fnc_remoteExec',2,FALSE];
	},
	[],
	95,
	TRUE,
	TRUE,
	'',
	'true'
];
player setUserActionText [QS_voteAction_2,((player actionParams QS_voteAction_2) select 0),(format ["<t size='3'>%1</t>",((player actionParams QS_voteAction_2) select 0)])];
hint 'Vote for/against night ops on your scroll wheel now! Voting open for 15 seconds!';
systemChat 'Vote for/against night ops on your scroll wheel now! Voting open for 15 seconds!';
['TaskAssigned',['','Mouse Scroll to Vote for Night']] call (missionNamespace getVariable 'QS_fnc_showNotification');
uiSleep 15;
{
	player removeAction _x;
} count [QS_voteAction_1,QS_voteAction_2];