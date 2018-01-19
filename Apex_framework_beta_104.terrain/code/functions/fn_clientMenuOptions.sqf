/*/
File: fn_clientMenuOptions.sqf
Author:
	
	Quiksilver
	
Last Modified:

	30/09/2017 A3 1.76 by Quiksilver

Description:

	Client Menu Options
	
	missionNamespace setVariable ['QS_missionConfig_stamina',_stamina,TRUE];
__________________________________________________________/*/
disableSerialization;
private ['_type','_display','_value'];
_type = _this select 0;
if (_type isEqualTo 'onLoad') then {
	(findDisplay 2000) closeDisplay 1;
	(findDisplay 3000) closeDisplay 1;
	_display = _this select 1;
	if ((missionNamespace getVariable ['QS_missionConfig_stamina',0]) isEqualTo 1) then {
			ctrlEnable [1805,FALSE];
			(_display displayCtrl 1805) ctrlSetTooltip 'Stamina forced ON in server configuration, sorry';
	};
	(_display displayCtrl 1805) cbSetChecked (isStaminaEnabled player);
	sliderSetRange [1807,0.1,1.1];
	sliderSetSpeed [1807,0.1,0.1];
	sliderSetPosition [1807,((player getVariable 'QS_stamina') select 1)];
	ctrlSetText [1808,format ['%1',((player getVariable 'QS_stamina') select 1)]];
	(_display displayCtrl 1810) cbSetChecked ((player getVariable 'QS_1PV') select 0);
	if ((difficultyOption 'thirdPersonView') > 0) then {
		if ((player getVariable 'QS_1PV') select 0) then {
			if (time > ((player getVariable 'QS_1PV') select 1)) then {
				ctrlEnable [1810,TRUE];
			} else {
				ctrlEnable [1810,FALSE];
			};
		};
	} else {
		ctrlEnable [1810,FALSE];
		(_display displayCtrl 1810) ctrlSetToolTip 'Third Person View disabled by server';
	};
	(_display displayCtrl 1813) cbSetChecked (!isNil {player getVariable 'QS_HUD_3'});
	(_display displayCtrl 1815) cbSetChecked (environmentEnabled select 0);
	if ((player getUnitTrait 'uavhacker') || {(player getUnitTrait 'QS_trait_pilot')} || {(player getUnitTrait 'QS_trait_CAS')}) then {
		ctrlEnable [1817,FALSE];
	} else {
		ctrlEnable [1817,TRUE];
	};
	(_display displayCtrl 1817) cbSetChecked (!isNull (missionNamespace getVariable ['QS_dynSim_script',scriptNull]));
};
if (_type isEqualTo 'onUnload') then {
	profileNamespace setVariable ['QS_stamina',(player getVariable 'QS_stamina')];
	profileNamespace setVariable ['QS_1PV',(player getVariable 'QS_1PV')];
	saveProfileNamespace;
};
if (_type isEqualTo 'StaminaCheckbox') then {
	_state = _this select 2;
	if ((_this select 2) isEqualTo 1) then {
		_state = TRUE;
		50 cutText ['Stamina enabled','PLAIN DOWN',0.5];
	};
	if ((_this select 2) isEqualTo 0) then {
		_state = FALSE;
		50 cutText ['Stamina disabled','PLAIN DOWN',0.5];
	};
	if ((missionNamespace getVariable ['QS_missionConfig_stamina',0]) isEqualTo 0) then {
		player enableStamina _state;
	};
	player setVariable ['QS_stamina',[(isStaminaEnabled player),(getCustomAimCoef player)],FALSE];
};
if (_type isEqualTo 'AimCoefSlider') then {
	_value = _this select 2;
	player setCustomAimCoef (_value - _value % 0.1);
	player setVariable ['QS_stamina',[(isStaminaEnabled player),(_value - _value % 0.1)],FALSE];
	ctrlSetText [1808,format ['%1',(_value - _value % 0.1)]];
};
if (_type isEqualTo '1PVCheckbox') then {
	_state = _this select 2;
	if ((_this select 2) isEqualTo 1) then {
		_state = TRUE;
		50 cutText ['1st Person View locked for 20 minutes or by reconnect','PLAIN DOWN',0.75];
		if (isNil {player getVariable 'QS_1stPersonLock'}) then {
			player setVariable ['QS_1stPersonLock',TRUE,FALSE];
			[46,[player,5]] remoteExec ['QS_fnc_remoteExec',2,FALSE];
			['ScoreBonus',['1st Person','5']] call (missionNamespace getVariable 'QS_fnc_showNotification');
		};
	};
	if ((_this select 2) isEqualTo 0) then {
		_state = FALSE;
		50 cutText ['Camera view unlocked','PLAIN DOWN',0.75];
	};
	if (_state) then {
		ctrlEnable [1810,FALSE];
	};
	player setVariable ['QS_1PV',[_state,(time + 1200)],FALSE];
};
if (_type isEqualTo 'QHUDCheckbox') then {
	_state = _this select 2;
	if ((_this select 2) isEqualTo 1) then {
		profileNamespace setVariable ['QS_QTHUD',TRUE];
		['Init'] call (missionNamespace getVariable 'QS_fnc_groupIndicator');
	} else {
		profileNamespace setVariable ['QS_QTHUD',FALSE];
		['Exit'] call (missionNamespace getVariable 'QS_fnc_groupIndicator');
	};
	saveProfileNamespace;
};
if (_type isEqualTo 'AmbientCheckbox') then {
	_state = _this select 2;
	if ((_this select 2) isEqualTo 1) then {
		profileNamespace setVariable ['QS_options_ambientLife',TRUE];
		enableEnvironment [TRUE,TRUE];
		50 cutText ['Ambient Life enabled','PLAIN DOWN',0.5];
	} else {
		profileNamespace setVariable ['QS_options_ambientLife',FALSE];
		enableEnvironment [FALSE,TRUE];
		50 cutText ['Ambient Life disabled','PLAIN DOWN',0.5];
	};
	saveProfileNamespace;
};
if (_type isEqualTo 'T_Checkbox') then {
	_state = _this select 2;
	if ((_this select 2) isEqualTo 1) then {
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
	_state = _this select 2;
	if ((_this select 2) isEqualTo 1) then {
		if (isNull (missionNamespace getVariable ['QS_dynSim_script',scriptNull])) then {
			profileNamespace setVariable ['QS_options_dynSim',TRUE];
			missionNamespace setVariable ['QS_options_dynSim',TRUE,FALSE];
			50 cutText ['Dynamic Simulation enabled','PLAIN DOWN',0.5];
			missionNamespace setVariable [
				'QS_dynSim_script',
				(1 spawn (missionNamespace getVariable 'QS_fnc_clientSimulationManager')),
				FALSE
			];
		};
	} else {
		profileNamespace setVariable ['QS_options_dynSim',FALSE];
		missionNamespace setVariable ['QS_options_dynSim',FALSE,FALSE];
		50 cutText ['Dynamic Simulation disabled','PLAIN DOWN',0.5];
	};
	saveProfileNamespace;
};
if (_type isEqualTo 'Back') then {
	closeDialog 0;
	createDialog 'QS_RD_client_dialog_menu_main';
};