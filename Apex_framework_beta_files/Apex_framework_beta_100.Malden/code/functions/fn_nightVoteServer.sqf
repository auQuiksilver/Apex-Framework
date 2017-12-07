/*
File: fn_nightVoteServer.sqf
Author:

	Quiksilver
	
Last modified:

	4/06/2016 A3 1.60 by Quiksilver
	
Description:

	-
__________________________________________________*/

if (isNil 'QS_nightInProgress') exitWith {missionNamespace setVariable ['QS_nightInProgress',FALSE,FALSE];};
if (missionNamespace getVariable 'QS_nightInProgress') exitWith {};
missionNamespace setVariable ['QS_votePV',TRUE,TRUE];
missionNamespace setVariable ['QS_votesTotal',0,FALSE];
missionNamespace setVariable ['QS_voteFor',0,FALSE];
missionNamespace setVariable ['QS_voteAgainst',0,FALSE];
sleep 20;
missionNamespace setVariable ['QS_votesTotal',((missionNamespace getVariable 'QS_voteAgainst') + (missionNamespace getVariable 'QS_voteFor')),FALSE];
_text = format ['Night Mission - Votes For: %1 - Votes Against: %2',(missionNamespace getVariable 'QS_voteFor'),(missionNamespace getVariable 'QS_voteAgainst')];
['systemChat',_text] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
['hint',_text] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
if ((missionNamespace getVariable 'QS_voteFor') > (2 * (missionNamespace getVariable 'QS_voteAgainst'))) then {
	missionNamespace setVariable ['QS_nightInProgress',TRUE,FALSE];
	skipTime (17 - dayTime);
	[] spawn {
		scriptName 'Night Vote thread';
		for '_x' from 0 to 1 step 0 do {
			if ((dayTime < 12) && (dayTime > 6)) exitWith {
				missionNamespace setVariable ['QS_nightInProgress',FALSE,FALSE];
			};
			sleep 10;
		};
	};
} else {
	['systemChat','Votes FOR must be a super majority ( > 66 percent ). Night Mission not approved!'] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
};