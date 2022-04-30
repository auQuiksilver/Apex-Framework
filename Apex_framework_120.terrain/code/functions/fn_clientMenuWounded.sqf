/*
File: fn_clientMenuWounded.sqf
Author:
	
	Quiksilver
	
Last Modified:

	28/04/2016 A3 1.58 by Quiksilver

Description:

	Client Core
__________________________________________________________*/

_type = _this select 0;
playSound 'ClickSoft';
if (_type isEqualTo -1) then {
	closeDialog 0;
};
if (_type isEqualTo 0) then {};
if (_type isEqualTo 1) then {
	player setVariable ['QS_revive_waitButton',FALSE,FALSE];
	player setVariable ['QS_revive_waitTime',(time + 60),FALSE];
	((findDisplay 8000) displayCtrl 1600) ctrlEnable FALSE;
	((findDisplay 8000) displayCtrl 1604) ctrlEnable FALSE;
	((findDisplay 8000) displayCtrl 1605) ctrlEnable FALSE;
	
	private ['_QS_medics','_nearEntities'];
	
	_QS_medics = [
		'B_medic_F','B_recon_medic_F','B_G_medic_F','O_G_medic_F','I_G_medic_F','O_medic_F','I_medic_F','O_recon_medic_f',
		'B_CTRG_soldier_M_medic_F','B_soldier_universal_f','O_soldier_universal_f','I_soldier_universal_f'
	];
	_nearEntities = [];
	_nearEntities = (getPosATL player) nearEntities [_QS_medics,(10 + (random 15))];
	if (_nearEntities isEqualTo []) then {
		[46,[player,1]] remoteExec ['QS_fnc_remoteExec',2,FALSE];
		['ScoreBonus',['Score added for waiting','1']] call (missionNamespace getVariable 'QS_fnc_showNotification');
	} else {
		if (player in _nearEntities) then {
			_nearEntities deleteAt (_nearEntities find player);
			if (_nearEntities isEqualTo []) then {
				[46,[player,1]] remoteExec ['QS_fnc_remoteExec',2,FALSE];
				['ScoreBonus',['Score added for waiting','1']] call (missionNamespace getVariable 'QS_fnc_showNotification');
			};
		};
	};
	['sideChat',[WEST,'BLU'],format ['%1 is waiting for Medical Treatment.',profileName]] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
	50 cutText ['Respawn disabled for 60 seconds','PLAIN DOWN'];
};
if (_type isEqualTo 2) then {
	[1] call (missionNamespace getVariable 'QS_fnc_clientMSpectate');
};
if (_type isEqualTo 3) then {
	[2,(missionNamespace getVariable 'QS_woundedCam')] call (missionNamespace getVariable 'QS_fnc_clientMCameraMode');
};
if (_type isEqualTo 4) then {

};
if (_type isEqualTo 5) then {
	player setVariable ['QS_revive_respawnType','BASE',FALSE];
	if (!isNull (findDisplay 8000)) then {
		(findDisplay 8000) closeDisplay 0;
	};
	[0,(missionNamespace getVariable 'QS_woundedCam')] call (missionNamespace getVariable 'QS_fnc_clientMCameraMode');
};
if (_type isEqualTo 6) then {
	player setVariable ['QS_revive_respawnType','FOB',FALSE];
	missionNamespace setVariable [
		'QS_module_fob_respawnTickets',
		((missionNamespace getVariable 'QS_module_fob_respawnTickets') - 1),
		TRUE
	];
	if (!isNull (findDisplay 8000)) then {
		(findDisplay 8000) closeDisplay 0;
	};
	[0,(missionNamespace getVariable 'QS_woundedCam')] call (missionNamespace getVariable 'QS_fnc_clientMCameraMode');
};