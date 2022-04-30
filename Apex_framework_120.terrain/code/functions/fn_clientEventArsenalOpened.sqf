/*/
File: fn_clientEventArsenalOpened.sqf
Author: 

	Quiksilver

Last Modified:

	20/04/2019 A3 1.90 by Quiksilver

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
		_display = uiNamespace getVariable ['BIS_fnc_arsenal_display',displayNull];
		_display displayRemoveAllEventHandlers 'KeyDown';
		(_display displayCtrl 44148) ctrlEnable FALSE;
		(_display displayCtrl 44148) ctrlCommit 0;
		(_display displayCtrl 44149) ctrlEnable FALSE;
		(_display displayCtrl 44149) ctrlCommit 0;
		(_display displayCtrl 44150) ctrlEnable FALSE;
		(_display displayCtrl 44150) ctrlCommit 0;
		_defaultUniform = ['U_B_CombatUniform_mcam','U_B_T_Soldier_F'] select (worldName isEqualTo 'Tanoa');
		if (isNil {uiNamespace getVariable 'QS_arsenalAmmoPrompt'}) then {
			uiNamespace setVariable ['QS_arsenalAmmoPrompt',TRUE];
			// Thanks Fitz :)
			0 spawn {
				for '_x' from 0 to 4 step 1 do {
					if (isNull (uiNamespace getVariable ['BIS_fnc_arsenal_display',displayNull])) exitWith {};
					['showMessage',[(uiNamespace getVariable 'BIS_fnc_arsenal_display'),"To add ammunition, select your uniform/vest/backpack on the left panel and add ammunition on the right panel."]] call (missionNamespace getVariable 'BIS_fnc_arsenal');
					uiSleep 5;
				};
			};
		};
		_face = face player;
		private _chatDisabled = FALSE;
		if (!(isStreamFriendlyUIEnabled)) then {
			if (shownChat) then {
				showChat FALSE;
				_chatDisabled = TRUE;
			};
		};
		_ctrl_roleDisplayName = _display ctrlCreate ['RscStructuredText',-1];
		_ctrl_roleDisplayName ctrlSetPosition [
			0.35 * safezoneW + safezoneX,
			0 * safezoneH + safezoneY,
			0.5 * safezoneW,
			0.1 * safezoneH
		];
		_ctrl_roleDisplayName ctrlSetStructuredText (parseText (format ['<t size="3">%1</t>',(['GET_ROLE_DISPLAYNAME',(player getVariable ['QS_unit_role','rifleman'])] call (missionNamespace getVariable 'QS_fnc_roles'))]));
		_ctrl_roleDisplayName ctrlCommit 0;
		_QS_module_opsec = (call (missionNamespace getVariable ['QS_missionConfig_AH',{1}])) isEqualTo 1;
		_maxControls = 205;
		for '_x' from 0 to 1 step 0 do {
			_ctrl_roleDisplayName ctrlShow (ctrlShown (_display displayCtrl 44046));
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
			uiSleep 0.01;
		};
		if ((missionNamespace getVariable ['QS_missionConfig_Arsenal',0]) isEqualTo 3) then {
			if ((face player) isNotEqualTo _face) then {
				['setFace',player,(face player)] remoteExec ['QS_fnc_remoteExecCmd',-2,player];
			};
		};
		if (_chatDisabled) then {
			if (!(isStreamFriendlyUIEnabled)) then {
				showChat TRUE;
			};
		};
	};
};