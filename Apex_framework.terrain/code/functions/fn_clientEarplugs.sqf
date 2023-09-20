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
if (localNamespace getVariable ['QS_earplugs_toggle',FALSE]) then {
	localNamespace setVariable ['QS_earplugs_toggle',FALSE];
	(uiNamespace getVariable ['QS_client_uiCtrl_earplugs',controlNull]) ctrlShow FALSE;
	0.4 fadeSound _effects;
} else {
	localNamespace setVariable ['QS_earplugs_toggle',TRUE];
	if ((profileNamespace getVariable ['QS_earplugs_hint',0]) < 10) then {
		profileNamespace setVariable ['QS_earplugs_hint',(profileNamespace getVariable ['QS_earplugs_hint',0]) + 1];
		[
			localize 'STR_QS_Hints_189',
			FALSE,
			TRUE,
			localize 'STR_QS_Menu_157',
			TRUE
		] call QS_fnc_hint;
	};
	(uiNamespace getVariable ['QS_client_uiCtrl_earplugs',controlNull]) ctrlShow TRUE;
	0.4 fadeSound ((_effects * _mapFactor) min (_effects * 0.25));
};
TRUE;