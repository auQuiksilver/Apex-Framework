/*/
File: fn_clientEventArsenalOpened.sqf
Author: 

	Quiksilver

Last Modified:

	28/02/2018 A3 1.80 by Quiksilver

Description:

	Event Arsenal Opened
____________________________________________________________________________/*/

0 spawn {
	disableSerialization;
	_t = diag_tickTime + 3;
	waitUntil {
		uiSleep 0.1;
		((diag_tickTime > _t) || {(!isNull (uiNamespace getVariable ['BIS_fnc_arsenal_display',displayNull]))})
	};
	if (!isNull (uiNamespace getVariable ['BIS_fnc_arsenal_display',displayNull])) then {
		(uiNamespace getVariable ['BIS_fnc_arsenal_display',displayNull]) displayRemoveAllEventHandlers 'KeyDown';
		((uiNamespace getVariable ['BIS_fnc_arsenal_display',displayNull]) displayCtrl 44150) ctrlEnable FALSE;
		((uiNamespace getVariable ['BIS_fnc_arsenal_display',displayNull]) displayCtrl 44150) ctrlCommit 0;
		_defaultUniform = ['U_B_CombatUniform_mcam','U_B_T_Soldier_F'] select (worldName isEqualTo 'Tanoa');
		if (isNil {player getVariable 'QS_arsenalAmmoPrompt'}) then {
			player setVariable ['QS_arsenalAmmoPrompt',TRUE,FALSE];
			// Thanks Fitz :)
			0 spawn {
				for '_x' from 0 to 4 step 1 do {
					if (isNull (uiNamespace getVariable ['BIS_fnc_arsenal_display',displayNull])) exitWith {};
					['showMessage',[(uiNamespace getVariable 'BIS_fnc_arsenal_display'),"To add ammunition, select your uniform/vest/backpack on the left and add ammunition on the right."]] call (missionNamespace getVariable 'BIS_fnc_arsenal');
					uiSleep 5;
				};
			};
		};
		private _chatDisabled = FALSE;
		if (!(isStreamFriendlyUIEnabled)) then {
			if (shownChat) then {
				showChat FALSE;
				_chatDisabled = TRUE;
			};
		};
		_QS_module_opsec = (call (missionNamespace getVariable ['QS_missionConfig_AH',{1}])) isEqualTo 1;
		_maxControls = 203;
		for '_x' from 0 to 1 step 0 do {
			if (!(missionNamespace getVariable ['QS_client_triggerGearCheck',FALSE])) then {
				missionNamespace setVariable ['QS_client_triggerGearCheck',TRUE,FALSE];
			};
			if (_QS_module_opsec && ((count (allControls (uiNamespace getVariable ['BIS_fnc_arsenal_display',displayNull]))) > _maxControls)) exitWith {
				[
					40,
					[
						time,
						serverTime,
						(name player),
						profileName,
						profileNameSteam,
						(getPlayerUID player),
						1,
						'Arsenal (Too many buttons)',
						player
					]		
				] remoteExec ['QS_fnc_remoteExec',2,FALSE];
				(uiNamespace getVariable ['BIS_fnc_arsenal_display',displayNull]) closeDisplay 2;
			};
			if (isNull (uiNamespace getVariable ['BIS_fnc_arsenal_display',displayNull])) exitWith {};
			uiSleep 0.5;
		};
		if (_chatDisabled) then {
			if (!(isStreamFriendlyUIEnabled)) then {
				showChat TRUE;
			};
		};
	};
};