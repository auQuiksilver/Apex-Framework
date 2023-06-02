/*/
File: fn_clientEarplugs.sqf
Author:
	
	Quiksilver
	
Last Modified:

	23/05/2023 A3 2.12 by Quiksilver

Description:

	Client Earplugs Toggle
__________________________________________________________/*/

if (diag_tickTime < (uiNamespace getVariable ['QS_earplugs_cooldown',-1])) exitWith {FALSE};
uiNamespace setVariable ['QS_earplugs_cooldown',diag_tickTime + 0.5];
playSoundUI ['ClickSoft',1,3,FALSE];
getAudioOptionVolumes params ['_effects','','','','','_mapFactor'];
_earplugs = _effects * _mapFactor;
if (soundVolume isEqualTo _earplugs) then {
	(uiNamespace getVariable ['QS_client_uiCtrl_earplugs',controlNull]) ctrlShow FALSE;
	0.4 fadeSound _effects;
} else {
	(uiNamespace getVariable ['QS_client_uiCtrl_earplugs',controlNull]) ctrlShow TRUE;
	0.4 fadeSound _earplugs;
};
TRUE;