/*/
File: fn_clientRequestMedevac.sqf
Author:
	
	Quiksilver
	
Last Modified:

	22/10/2017 A3 1.76 by Quiksilver

Description:

	Client Medevac Request
__________________________________________________________/*/

closeDialog 2;
0 spawn {
	uiSleep 0.05;
	_textBody = '- Selecting OK will disable your ability to respawn or abort for 10 minutes.<br/>- Medics will be unable to revive you.<br/>- To be revived, other people must bring you to a location equipped with Medevac services before you bleed out.';
	_textHeader = 'Medevac Mission Reminder (Please read)';
	_textOk = 'OK';
	_textCancel = 'CANCEL';
	private _result = [_textBody,_textHeader,_textOk,_textCancel,(findDisplay 46),FALSE,FALSE] call (missionNamespace getVariable 'BIS_fnc_guiMessage'); 
	if (_result) then {
		if ((!(missionNamespace getVariable ['QS_dynTask_medevac_inProgress',TRUE])) && ((lifeState player) isEqualTo 'INCAPACITATED') && (isNull (objectParent player)) && (isNull (attachedTo player))) then {
			{
				player setVariable _x;
			} forEach [
				['QS_client_medevacRequested',TRUE,FALSE],
				['QS_client_lastMedevacRequest',(diag_tickTime + 60),FALSE],
				['QS_revive_disable',TRUE,TRUE],
				['QS_respawn_disable',(diag_tickTime + 600),FALSE]
			];
			50 cutText ['Medevac requested','PLAIN DOWN',0.5];
			['systemChat',(format ['%1 requested medevac at grid %2',profileName,(mapGridPosition player)])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
			[77,'MEDEVAC',[player,profileName]] remoteExec ['QS_fnc_remoteExec',2,FALSE];
		} else {
			50 cutText ['Medevac unavailable','PLAIN DOWN',0.5];
		};
	} else {
		50 cutText ['Medevac request cancelled','PLAIN DOWN',0.5];
	};
};