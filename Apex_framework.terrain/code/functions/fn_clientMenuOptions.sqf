/*/
File: fn_clientMenuOptions.sqf
Author:
	
	Quiksilver
	
Last Modified:

	9/09/2022 A3 2.10 by Quiksilver

Description:

	Client Menu Options
__________________________________________________________/*/
disableSerialization;
private ['_type','_display','_value','_state'];
_type = _this # 0;
if (_type isEqualTo 'onLoad') then {
	(findDisplay 2000) closeDisplay 1;
	(findDisplay 3000) closeDisplay 1;
	_display = _this # 1;
	setMousePosition (uiNamespace getVariable ['QS_ui_mousePosition',getMousePosition]);
	if ((missionNamespace getVariable ['QS_missionConfig_stamina',0]) isEqualTo 1) then {
			ctrlEnable [1805,FALSE];
			(_display displayCtrl 1805) ctrlSetTooltip (localize 'STR_QS_Menu_049');
	};
	(_display displayCtrl 1805) cbSetChecked (isStaminaEnabled player);
	sliderSetRange [1807,0.1,1.1];
	sliderSetSpeed [1807,0.1,0.1];
	sliderSetPosition [1807,((player getVariable 'QS_stamina') # 1)];
	ctrlSetText [1808,format ['%1',((player getVariable 'QS_stamina') # 1)]];
	(_display displayCtrl 1810) cbSetChecked ((player getVariable 'QS_1PV') # 0);
	if ((difficultyOption 'thirdPersonView') > 0) then {
		if ((player getVariable 'QS_1PV') # 0) then {
			if (time > ((player getVariable 'QS_1PV') # 1)) then {
				ctrlEnable [1810,TRUE];
			} else {
				ctrlEnable [1810,FALSE];
			};
		};
	} else {
		ctrlEnable [1810,FALSE];
		(_display displayCtrl 1810) ctrlSetToolTip (localize 'STR_QS_Menu_050');
	};
	(_display displayCtrl 1813) cbSetChecked (!(player isNil 'QS_HUD_3'));
	(_display displayCtrl 1815) cbSetChecked (environmentEnabled # 0);
	if ((['uavhacker','QS_trait_fighterPilot','QS_trait_pilot','QS_trait_CAS','QS_trait_HQ'] findIf { player getUnitTrait _x }) isNotEqualTo -1) then {
		ctrlEnable [1817,FALSE];
		(_display displayCtrl 1817) ctrlSetTooltip (localize 'STR_QS_Menu_051');
	} else {
		ctrlEnable [1817,TRUE];
	};
	(_display displayCtrl 1817) cbSetChecked (!isNull (missionNamespace getVariable ['QS_dynSim_script',scriptNull]));
	
	
	(_display displayCtrl 1818) cbSetChecked (missionNamespace getVariable ['QS_HUD_show3DHex',(missionProfileNamespace getVariable ['QS_HUD_show3DHex',TRUE])]);

	(_display displayCtrl 1819) cbSetChecked (missionNamespace getVariable ['QS_HUD_toggleChatSpam',(missionProfileNamespace getVariable ['QS_HUD_toggleChatSpam',TRUE])]);
	
	(_display displayCtrl 1823) cbSetChecked (missionNamespace getVariable ['QS_HUD_toggleSuppression',(missionProfileNamespace getVariable ['QS_HUD_toggleSuppression',TRUE])]);

	if ((missionNamespace getVariable ['QS_missionConfig_hitMarker',1]) isEqualTo 0) then {
		ctrlEnable [1825,FALSE];
		(_display displayCtrl 1825) cbSetChecked FALSE;
		(_display displayCtrl 1825) ctrlSetTooltip (localize 'STR_QS_Menu_052');
	} else {
		(_display displayCtrl 1825) cbSetChecked (missionNamespace getVariable ['QS_HUD_toggleHitMarker',(missionProfileNamespace getVariable ['QS_HUD_toggleHitMarker',TRUE])]);
	};
};
if (_type isEqualTo 'onUnload') then {
	uiNamespace setVariable ['QS_ui_mousePosition',getMousePosition];
	missionProfileNamespace setVariable ['QS_stamina',(player getVariable 'QS_stamina')];
	missionProfileNamespace setVariable ['QS_1PV',(player getVariable 'QS_1PV')];
	saveMissionProfileNamespace;
};
if (_type isEqualTo 'StaminaCheckbox') then {
	_state = _this # 2;
	if ((_this # 2) isEqualTo 1) then {
		_state = TRUE;
		50 cutText [localize 'STR_QS_Text_169','PLAIN DOWN',0.5];
	};
	if ((_this # 2) isEqualTo 0) then {
		_state = FALSE;
		50 cutText [localize 'STR_QS_Text_170','PLAIN DOWN',0.5];
	};
	if ((missionNamespace getVariable ['QS_missionConfig_stamina',0]) isEqualTo 0) then {
		player enableStamina _state;
	};
	player setVariable ['QS_stamina',[_state,((player getVariable ['QS_stamina',[_state,0.1]]) # 1)],FALSE];
};
if (_type isEqualTo 'AimCoefSlider') then {
	_value = _this # 2;
	player setCustomAimCoef (_value - _value % 0.1);
	player setVariable ['QS_stamina',[(isStaminaEnabled player),(_value - _value % 0.1)],FALSE];
	ctrlSetText [1808,format ['%1',(_value - _value % 0.1)]];
};
if (_type isEqualTo '1PVCheckbox') then {
	_state = _this # 2;
	if ((_this # 2) isEqualTo 1) then {
		_state = TRUE;
		50 cutText [localize 'STR_QS_Text_171','PLAIN DOWN',0.75];
		if (player isNil 'QS_1stPersonLock') then {
			player setVariable ['QS_1stPersonLock',TRUE,FALSE];
			[46,[player,5]] remoteExec ['QS_fnc_remoteExec',2,FALSE];
			['ScoreBonus',[localize 'STR_QS_Notif_043','5']] call (missionNamespace getVariable 'QS_fnc_showNotification');
		};
	};
	if ((_this # 2) isEqualTo 0) then {
		_state = FALSE;
		50 cutText [localize 'STR_QS_Text_172','PLAIN DOWN',0.75];
	};
	if (_state) then {
		ctrlEnable [1810,FALSE];
	};
	player setVariable ['QS_1PV',[_state,(time + 1200)],FALSE];
};
if (_type isEqualTo 'QHUDCheckbox') then {
	_state = _this # 2;
	if ((_this # 2) isEqualTo 1) then {
		missionProfileNamespace setVariable ['QS_QTHUD',TRUE];
		['Init'] call (missionNamespace getVariable 'QS_fnc_groupIndicator');
	} else {
		missionProfileNamespace setVariable ['QS_QTHUD',FALSE];
		['Exit'] call (missionNamespace getVariable 'QS_fnc_groupIndicator');
	};
	saveMissionProfileNamespace;
};
if (_type isEqualTo 'AmbientCheckbox') then {
	_state = _this # 2;
	if ((_this # 2) isEqualTo 1) then {
		missionProfileNamespace setVariable ['QS_options_ambientLife',TRUE];
		enableEnvironment [TRUE,TRUE,getMissionConfigValue ['windyCoef',0.65]];
		50 cutText [localize 'STR_QS_Text_173','PLAIN DOWN',0.5];
	} else {
		missionProfileNamespace setVariable ['QS_options_ambientLife',FALSE];
		enableEnvironment [FALSE,TRUE,getMissionConfigValue ['windyCoef',0.65]];
		50 cutText [localize 'STR_QS_Text_174','PLAIN DOWN',0.5];
	};
	saveMissionProfileNamespace;
};
if (_type isEqualTo 'T_Checkbox') then {
	_state = _this # 2;
	if ((_this # 2) isEqualTo 1) then {
		{
			_x setSimpleTaskAlwaysVisible TRUE;
		} count (simpleTasks player);
	} else {
		{
			_x setSimpleTaskAlwaysVisible FALSE;
		} count (simpleTasks player);	
	};
};
if (_type isEqualTo 'DynSimCheckbox') then {
	_state = _this # 2;
	if ((_this # 2) isEqualTo 1) then {
		if (isNull (missionNamespace getVariable ['QS_dynSim_script',scriptNull])) then {
			missionProfileNamespace setVariable ['QS_options_dynSim',TRUE];
			missionNamespace setVariable ['QS_options_dynSim',TRUE,FALSE];
			50 cutText [localize 'STR_QS_Text_175','PLAIN DOWN',0.5];
			missionNamespace setVariable ['QS_dynSim_script',(1 spawn (missionNamespace getVariable 'QS_fnc_clientSimulationManager')),FALSE];
		};
	} else {
		missionProfileNamespace setVariable ['QS_options_dynSim',FALSE];
		missionNamespace setVariable ['QS_options_dynSim',FALSE,FALSE];
		50 cutText [localize 'STR_QS_Text_176','PLAIN DOWN',0.5];
	};
	saveMissionProfileNamespace;
};
if (_type isEqualTo 'Toggle3DGroupHex') then {
	_state = _this # 2;
	if (_state isEqualTo 1) then {
		// Toggled on
		missionNamespace setVariable ['QS_HUD_show3DHex',TRUE,FALSE];
		missionProfileNamespace setVariable ['QS_HUD_show3DHex',TRUE];
		50 cutText [localize 'STR_QS_Text_178','PLAIN DOWN',0.5];
	} else {	
		// Toggled off
		missionNamespace setVariable ['QS_HUD_show3DHex',FALSE,FALSE];
		missionProfileNamespace setVariable ['QS_HUD_show3DHex',FALSE];
		50 cutText [localize 'STR_QS_Text_177','PLAIN DOWN',0.5];
	};
	saveMissionProfileNamespace;
};
if (_type isEqualTo 'ToggleSystemChatSpam') then {
	_state = _this # 2;
	if (_state isEqualTo 1) then {
		// Toggled HIDDEN
		missionNamespace setVariable ['QS_HUD_toggleChatSpam',TRUE,FALSE];
		missionProfileNamespace setVariable ['QS_HUD_toggleChatSpam',TRUE];
		50 cutText [localize 'STR_QS_Text_179','PLAIN DOWN',0.5];
	} else {	
		// Toggled SHOWN
		missionNamespace setVariable ['QS_HUD_toggleChatSpam',FALSE,FALSE];
		missionProfileNamespace setVariable ['QS_HUD_toggleChatSpam',FALSE];
		50 cutText [localize 'STR_QS_Text_180','PLAIN DOWN',0.5];
	};
	saveMissionProfileNamespace;
};
if (_type isEqualTo 'ToggleSuppression') then {
	_state = _this # 2;
	if (_state isEqualTo 1) then {
		missionNamespace setVariable ['QS_HUD_toggleSuppression',TRUE,FALSE];
		missionProfileNamespace setVariable ['QS_HUD_toggleSuppression',TRUE];
		50 cutText [localize 'STR_QS_Text_181','PLAIN DOWN',0.5];
	} else {
		missionNamespace setVariable ['QS_HUD_toggleSuppression',FALSE,FALSE];
		missionProfileNamespace setVariable ['QS_HUD_toggleSuppression',FALSE];
		50 cutText [localize 'STR_QS_Text_182','PLAIN DOWN',0.5];
	};
	saveMissionProfileNamespace;
};
if (_type isEqualTo 'ToggleHitMarker') then {
	_state = _this # 2;
	if (_state isEqualTo 1) then {
		missionNamespace setVariable ['QS_HUD_toggleHitMarker',TRUE,FALSE];
		missionProfileNamespace setVariable ['QS_HUD_toggleHitMarker',TRUE];
		50 cutText [localize 'STR_QS_Text_183','PLAIN DOWN',0.5];
	} else {
		missionNamespace setVariable ['QS_HUD_toggleHitMarker',FALSE,FALSE];
		missionProfileNamespace setVariable ['QS_HUD_toggleHitMarker',FALSE];
		50 cutText [localize 'STR_QS_Text_184','PLAIN DOWN',0.5];
	};
	saveMissionProfileNamespace;
};
if (_type isEqualTo 'Back') then {
	closeDialog 2;
	0 spawn {
		uiSleep 0.1;
		waitUntil {
			closeDialog 2;
			(!dialog)
		};
		createDialog 'QS_RD_client_dialog_menu_main';
	};
};