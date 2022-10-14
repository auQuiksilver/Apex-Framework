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
	_textBody = format ['- %1<br/>- %2<br/>- %3',localize 'STR_QS_Menu_133',localize 'STR_QS_Menu_134',localize 'STR_QS_Menu_135'];
	_textHeader = localize 'STR_QS_Menu_130';
	_textOk = localize 'STR_QS_Menu_131';
	_textCancel = localize 'STR_QS_Menu_114';
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
			50 cutText [localize 'STR_QS_Text_188','PLAIN DOWN',0.5];
			['systemChat',(format [localize 'STR_QS_Chat_103',profileName,(mapGridPosition player)])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
			[77,'MEDEVAC',[player,profileName]] remoteExec ['QS_fnc_remoteExec',2,FALSE];
		} else {
			50 cutText [localize 'STR_QS_Text_189','PLAIN DOWN',0.5];
		};
	} else {
		50 cutText [localize 'STR_QS_Text_190','PLAIN DOWN',0.5];
	};
};