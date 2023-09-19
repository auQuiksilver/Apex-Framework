/*/
File: fn_initTrait.sqf
Author:

	Quiksilver
	
Last Modified:

	20/04/2019 A3 1.90 by Quiksilver
	
Description:

	-
________________________________________________/*/

params ['_role','_traitParams'];
_traitParams params ['_trait','_traitValue','_isCustom'];
if (_trait isEqualTo 'uavhacker') then {
	if (_traitValue) then {
		if (isNull (missionNamespace getVariable ['QS_script_uavhacker',scriptNull])) then {
			missionNamespace setVariable ['QS_script_uavhacker',(0 spawn (missionNamespace getVariable 'QS_fnc_uavOperator')),FALSE];
		};
		if (!(2 in (missionNamespace getVariable 'QS_client_radioChannels'))) then {
			[1,2] call (missionNamespace getVariable 'QS_fnc_clientRadio');
		};
	} else {
		if (!(_role in ['pilot','pilot_heli','pilot_plane','uav','pilot_cas','commander','jtac','pilot_heli_WL','jtac_WL'])) then {
			[0,2] call (missionNamespace getVariable 'QS_fnc_clientRadio');
		};
	};
};
if (_trait isEqualTo 'QS_trait_HQ') then {
	if (_traitValue) then {
		if (isNull (missionNamespace getVariable ['QS_script_cmdr',scriptNull])) then {
			missionNamespace setVariable ['QS_script_cmdr',(0 spawn (missionNamespace getVariable 'QS_fnc_highCommand')),FALSE];
		};
		if (!(2 in (missionNamespace getVariable 'QS_client_radioChannels'))) then {
			[1,2] call (missionNamespace getVariable 'QS_fnc_clientRadio');
		};
	} else {
		if (!(_role in ['pilot','pilot_heli','pilot_plane','uav','pilot_cas','commander','jtac','pilot_heli_WL','jtac_WL'])) then {
			[0,2] call (missionNamespace getVariable 'QS_fnc_clientRadio');
		};
	};
};
if (_trait isEqualTo 'QS_trait_pilot') then {
	if (_traitValue) then {
		if (!(2 in (missionNamespace getVariable 'QS_client_radioChannels'))) then {
			[1,2] call (missionNamespace getVariable 'QS_fnc_clientRadio');
		};	
	} else {
		if (!(_role in ['pilot','pilot_heli','pilot_plane','uav','pilot_cas','commander','jtac','pilot_heli_WL','jtac_WL'])) then {
			[0,2] call (missionNamespace getVariable 'QS_fnc_clientRadio');
		};	
	};
};
if (_trait isEqualTo 'QS_trait_JTAC') then {
	player setVehicleReportRemoteTargets _traitValue;
	if (_traitValue) then {
		if (!(2 in (missionNamespace getVariable 'QS_client_radioChannels'))) then {
			[1,2] call (missionNamespace getVariable 'QS_fnc_clientRadio');
		};	
	} else {
		if (!(_role in ['pilot','pilot_heli','pilot_plane','uav','pilot_cas','commander','jtac','pilot_heli_WL','jtac_WL'])) then {
			[0,2] call (missionNamespace getVariable 'QS_fnc_clientRadio');
		};	
	};
};
if (_trait isEqualTo 'QS_trait_fighterPilot') then {
	if (_traitValue) then {
		missionNamespace setVariable ['QS_cas_JetsDLCEnabled',(601670 in (getDLCs 1)),2];
		if (!(2 in (missionNamespace getVariable 'QS_client_radioChannels'))) then {
			[1,2] call (missionNamespace getVariable 'QS_fnc_clientRadio');
		};
		_casLaptop = missionNamespace getVariable ['QS_cas_laptop',objNull];
		if (!isNull _casLaptop) then {
			player setVariable ['QS_cas_lastRequestTime',diag_tickTime,FALSE];
			_QS_casLaptop_action = _casLaptop addAction [
				localize 'STR_QS_Interact_091',
				{
					if (diag_tickTime > (player getVariable ['QS_cas_lastRequestTime',(diag_tickTime - 1)])) then {
						[74,player] remoteExec ['QS_fnc_remoteExec',2,FALSE];
						player setVariable ['QS_cas_lastRequestTime',(diag_tickTime + 10),FALSE];
						player playAction 'PutDown';
						50 cutText [localize 'STR_QS_Text_224','PLAIN DOWN',0.25];
					} else {
						50 cutText [localize 'STR_QS_Text_225','PLAIN DOWN',0.25];
					};
				},
				[],
				90,
				TRUE,
				TRUE,
				'',
				'(isNull (objectParent player))',
				5,
				FALSE,
				''
			];
			_casLaptop setUserActionText [_QS_casLaptop_action,localize 'STR_QS_Interact_091',(format ["<t size='3'>%1</t>",localize 'STR_QS_Interact_091'])];
		};
		_carrierLaptop = missionNamespace getVariable ['QS_carrier_casLaptop',objNull];
		if (!isNull _carrierLaptop) then {
			player setVariable ['QS_cas_lastRequestTime',diag_tickTime,FALSE];
			_QS_carrierLaptop_action = _carrierLaptop addAction [
				localize 'STR_QS_Interact_091',
				{
					if (diag_tickTime > (player getVariable ['QS_cas_lastRequestTime',(diag_tickTime - 1)])) then {
						[74,player] remoteExec ['QS_fnc_remoteExec',2,FALSE];
						player setVariable ['QS_cas_lastRequestTime',(diag_tickTime + 10),FALSE];
						player playAction 'PutDown';
						50 cutText [localize 'STR_QS_Text_224','PLAIN DOWN',0.25];
					} else {
						50 cutText [localize 'STR_QS_Text_225','PLAIN DOWN',0.25];
					};
				},
				[],
				90,
				TRUE,
				TRUE,
				'',
				'(isNull (objectParent player))',
				5,
				FALSE,
				''
			];
			_carrierLaptop setUserActionText [_QS_carrierLaptop_action,localize 'STR_QS_Interact_091',(format ["<t size='3'>%1</t>",localize 'STR_QS_Interact_091'])];
		};
	} else {
		if (!(_role in ['pilot','pilot_heli','pilot_plane','uav','pilot_cas','commander','jtac','pilot_heli_WL','jtac_WL'])) then {
			[0,2] call (missionNamespace getVariable 'QS_fnc_clientRadio');
		};
		missionNamespace setVariable ['QS_CAS_jetAllowance_gameover',FALSE,2];
		if (alive (missionNamespace getVariable ['QS_casJet',objNull])) then {
			(missionNamespace getVariable 'QS_casJet') setDamage [1,FALSE];
			(missionNamespace getVariable 'QS_casJet') spawn {
				sleep 0.1;
				deleteVehicle _this;
			};
		};
		if (!isNull (missionNamespace getVariable ['QS_cas_laptop',objNull])) then {
			if ((actionIDs (missionNamespace getVariable 'QS_cas_laptop')) isNotEqualTo []) then {
				_co = missionNamespace getVariable 'QS_cas_laptop';
				removeAllActions _co;
			};
		};
		if (!isNull (missionNamespace getVariable ['QS_carrier_casLaptop',objNull])) then {
			if ((actionIDs (missionNamespace getVariable 'QS_carrier_casLaptop')) isNotEqualTo []) then {
				_co = missionNamespace getVariable 'QS_carrier_casLaptop';
				removeAllActions _co;
			};
		};
	};
};