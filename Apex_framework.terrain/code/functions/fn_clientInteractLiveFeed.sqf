/*
File: fn_clientInteractLiveFeed.sqf
Author:
	
	Quiksilver
	
Last Modified:

	22/08/2018 ArmA 3 1.84 by Quiksilver

Description:

	Live Feed toggle
__________________________________________________________*/

private _onOrOff = player getVariable ['QS_RD_client_liveFeed',FALSE];
if (_onOrOff) then {
	player setVariable ['QS_RD_client_liveFeed',FALSE,FALSE];
	playSound 'clickSoft';
	(missionNamespace getVariable 'QS_managed_hints') pushBack [5,FALSE,5,-1,'Live Feed now OFF',[],-1];
	player playAction 'Putdown';
	if (!isNil {missionNamespace getVariable 'QS_RD_CSH_TV_1'}) then {
		(missionNamespace getVariable 'QS_RD_CSH_TV_1') setObjectTexture [0,(getMissionConfigValue 'QS_RD_liveFeed_noSignal')];
		/*/(missionNamespace getVariable 'QS_RD_CSH_TV_1') setObjectTexture [0,(getText (missionConfigFile >> 'QS_RD_liveFeed_noSignal'))];/*/
	};
} else {
	if (!(isPipEnabled)) exitWith {
		_text = parseText 'PiP not enabled.<br/> Esc >> Configure >> Video >> PiP.';
		(missionNamespace getVariable 'QS_managed_hints') pushBack [5,FALSE,5,-1,_text,[],-1];
	};
	player setVariable ['QS_RD_client_liveFeed',TRUE,FALSE];
	playSound 'clickSoft';
	(missionNamespace getVariable 'QS_managed_hints') pushBack [5,FALSE,5,-1,'Live Feed now ON, please wait.',[],-1];
	player playAction 'Putdown';
	if (!isNil {missionNamespace getVariable 'QS_RD_CSH_TV_1'}) then {
		(missionNamespace getVariable 'QS_RD_CSH_TV_1') setObjectTexture [0,'#(argb,512,512,1)r2t(QS_RD_LFE,1)'];
	};
};