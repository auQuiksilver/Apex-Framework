/*/
File: fn_clientEarplugs.sqf
Author:
	
	Quiksilver
	
Last Modified:

	22/01/2023 A3 2.10 by Quiksilver

Description:

	Client Earplugs Toggle
__________________________________________________________/*/

if (diag_tickTime < (uiNamespace getVariable ['QS_earplugs_cooldown',-1])) exitWith {};
uiNamespace setVariable ['QS_earplugs_cooldown',diag_tickTime + 1];
playSoundUI ['ClickSoft',1,3,FALSE];
getAudioOptionVolumes params ['_effects','','','','','_earplugs'];
if (soundVolume isEqualTo _earplugs) then {
	(uiNamespace getVariable ['QS_client_uiCtrl_earplugs',controlNull]) ctrlShow FALSE;
	1 fadeSound _effects;
} else {
	if (!(isStreamFriendlyUIEnabled)) then {
		(uiNamespace getVariable ['QS_client_uiCtrl_earplugs',controlNull]) ctrlShow TRUE;
	};
	1 fadeSound _earplugs;
};
TRUE;