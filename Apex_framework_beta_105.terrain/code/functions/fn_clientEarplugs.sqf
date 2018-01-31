/*/
File: fn_clientEarplugs.sqf
Author:
	
	Quiksilver
	
Last Modified:

	8/11/2017 A3 1.76 by Quiksilver

Description:

	Client Earplugs Toggle
__________________________________________________________/*/

if (diag_tickTime > (player getVariable ['QS_RD_earplugging',-1])) then {
	player setVariable ['QS_RD_earplugging',(diag_tickTime + 1),FALSE];
	playSound 'ClickSoft';
	private _inOrOut = player getVariable ['QS_RD_earplugs',FALSE];
	if (_inOrOut) then {
		(uiNamespace getVariable ['QS_client_uiCtrl_earplugs',controlNull]) ctrlShow FALSE;
		player setVariable ['QS_RD_earplugs',FALSE,FALSE];
		1 fadeSound (player getVariable 'QS_RD_soundVolume');
	} else {
		if (!(isStreamFriendlyUIEnabled)) then {
			(uiNamespace getVariable ['QS_client_uiCtrl_earplugs',controlNull]) ctrlShow TRUE;
		};
		player setVariable ['QS_RD_soundVolume',soundVolume,FALSE];
		player setVariable ['QS_RD_earplugs',TRUE,FALSE];
		1 fadeSound 0.05;
	};
	TRUE;
};