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
	(missionNamespace getVariable 'QS_managed_hints') pushBack [5,FALSE,5,-1,localize 'STR_QS_Hints_046',[],-1];
	player playActionNow 'Putdown';
	if !(missionNamespace isNil 'QS_RD_CSH_TV_1') then {
		(missionNamespace getVariable 'QS_RD_CSH_TV_1') setObjectTexture [0,(getMissionConfigValue 'QS_RD_liveFeed_noSignal')];
	};
} else {
	if (!(isPipEnabled)) exitWith {
		_text = localize 'STR_QS_Hints_048';
		(missionNamespace getVariable 'QS_managed_hints') pushBack [5,FALSE,5,-1,_text,[],-1];
	};
	player setVariable ['QS_RD_client_liveFeed',TRUE,FALSE];
	playSound 'clickSoft';
	(missionNamespace getVariable 'QS_managed_hints') pushBack [5,FALSE,5,-1,localize 'STR_QS_Hints_047',[],-1];
	player playActionNow 'Putdown';
	if !(missionNamespace isNil 'QS_RD_CSH_TV_1') then {
		(missionNamespace getVariable 'QS_RD_CSH_TV_1') setObjectTexture [0,'#(argb,512,512,1)r2t(QS_RD_LFE,1)'];
	};
};