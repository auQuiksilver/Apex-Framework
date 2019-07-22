/*
File: fn_clientEventGetInMan.sqf
Author:

	Quiksilver
	
Last modified:

	7/06/2018 A3 1.82 by Quiksilver
	
Description:

	-
__________________________________________________*/

params ['_unit','_position','_vehicle','_turretPath'];
if (!simulationEnabled _vehicle) then {
	_vehicle enableSimulation TRUE;
};
//missionNamespace setVariable ['QS_client_infoPanels',[(infoPanel 'left'),(infoPanel 'right')],FALSE];
player setVariable ['QS_RD_crewIndicator_show',TRUE,FALSE];
if (_vehicle isKindOf 'Air') then {
	if (!((getNumber (configFile >> 'CfgVehicles' >> (typeOf _vehicle) >> 'transportSoldier')) isEqualTo 0)) then {
		if (!(_position in ['driver','gunner'])) then {
			if (!((backpack _unit) isEqualTo '')) then {
				player setVariable ['QS_backpack_data',[(backpack player),(backpackItems player),(backpackMagazines player)],FALSE];
			};
		};
		if (player getUnitTrait 'QS_trait_pilot') then {
			if (_position isEqualTo 'driver') then {
				player setVariable ['QS_pilot_vehicleInfo',[_vehicle,['driver']],TRUE];
			};
		};
	};
};
[1,_vehicle] call (missionNamespace getVariable 'QS_fnc_clientVehicleEventHandlers');
if (player getUnitTrait 'QS_trait_fighterPilot') then {
	if (_vehicle isKindOf 'Air') then {
		if (_position in ['driver','gunner']) then {
			private _isCAS = FALSE;
			_supportTypes = getArray (configFile >> 'CfgVehicles' >> (typeOf _vehicle) >> 'availableForSupportTypes');
			if (!(_supportTypes isEqualTo [])) then {
				{
					if (['CAS',_x,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) exitWith {
						_isCAS = TRUE;
					};
				} forEach _supportTypes;
			};
			if (_isCAS) then {
				if (isNil {uiNamespace getVariable 'QS_pilotROE_msg'}) then {
					uiNamespace setVariable ['QS_pilotROE_msg',TRUE];
					// This will broadcast CAS ROE to pilots on entry to CAS Jet
					/*/
					0 spawn {
						uiSleep 5;
						'CAS Rules of Engagement' hintC [
							'0. CAS must be called in by ground elements (infantry who are near the target).',
							'1. CAS call-ins must be typed into Side Channel with a specific position or target, no exceptions.',
							'2. CAS may freely engage these targets without ground coordination: Fixed-wing Aircraft.',
							'3. Do not engage any objectives and/or enemies without being called in on that specific target (See rule 1).',
							'4. Do not ram targets and/or objectives.',
							'5. Do not fly near (1km) marked objectives unless necessary to complete a specific mission.',
							'6. Must be on Teamspeak, in Pilot channel and communicable.',
							'Failure to comply may result in administrative action without warning, up to and including permanent removal from CAS whitelist.'
						];
					};
					/*/
				};
			};
		};
	};
};
if ((missionNamespace getVariable ['QS_missionConfig_artyEngine',1]) isEqualTo 1) then {
	if (_vehicle isEqualTo (missionNamespace getVariable ['QS_arty',objNull])) then {
		enableEngineArtillery TRUE;
	};
};
if (_vehicle isKindOf 'StaticMortar') then {
	_nearEntities = (position _vehicle) nearEntities [['LandVehicle','Reammobox_F'],50];
	if (!(_nearEntities isEqualTo [])) then {
		private _vehicle = objNull;
		{
			_vehicle = _x;
			if (!((getAmmoCargo _vehicle) isEqualTo 0)) then {
				if (local _vehicle) then {
					_vehicle setAmmoCargo 0;
				} else {
					['setAmmoCargo',_vehicle,0] remoteExec ['QS_fnc_remoteExecCmd',_vehicle,FALSE];
				};
			};
		} forEach _nearEntities;
	};
};
if ((toLower (typeOf _vehicle)) in ['b_t_apc_tracked_01_crv_f','b_apc_tracked_01_crv_f']) then {
	missionNamespace setVariable [
		'QS_action_plow',
		(
			player addAction [
				'Lower plow',
				{
					_v = vehicle player;
					_animPhase = _v animationSourcePhase 'MovePlow';
					private _soundSource = '';
					private _timeout = -1;
					if (_animPhase isEqualTo 1) then {
						50 cutText ['Raising plow','PLAIN DOWN',0.25];
						_v animateSource ['MovePlow',0,0.9];
						_soundSource = createSoundSource ['SoundPlowUp',(_v modelToWorld (_v selectionPosition 'plow')),[],0];
						_soundSource attachTo [_v,(_v selectionPosition 'plow')];
						_timeout = diag_tickTime + 8;
						waitUntil {
							uiSleep 0.1;
							((diag_tickTime > _timeout) || (!alive _v) || ((_v animationSourcePhase 'MovePlow') isEqualTo 0))
						};
						uiSleep 0.1;
						deleteVehicle _soundSource;
					} else {
						50 cutText ['Lowering plow','PLAIN DOWN',0.25];
						_v animateSource ['MovePlow',1,0.9];
						_soundSource = createSoundSource ['SoundPlowDown',(_v modelToWorld (_v selectionPosition 'plow')),[],0];
						_soundSource attachTo [_v,(_v selectionPosition 'plow')];
						_timeout = diag_tickTime + 8;
						waitUntil {
							uiSleep 0.1;
							((diag_tickTime > _timeout) || (!alive _v) || ((_v animationSourcePhase 'MovePlow') isEqualTo 1))
						};
						uiSleep 0.1;
						deleteVehicle _soundSource;
					};
				},
				nil,
				0,
				FALSE,
				TRUE,
				'',
				'
					(call {
						_c = FALSE;
						_v = vehicle player;
						if ((toLower (typeOf _v)) in ["b_t_apc_tracked_01_crv_f","b_apc_tracked_01_crv_f"]) then {
							if (player isEqualTo (driver _v)) then {
								_animPhase = _v animationSourcePhase "MovePlow";
								if (_animPhase in [0,1]) then {
									if (((player actionParams QS_action_plow) select 0) isEqualTo "Lower plow") then {
										if (_animPhase isEqualTo 1) then {
											player setUserActionText [QS_action_plow,"Raise plow","<t size=""3"">Raise plow</t>"];
										};
									} else {
										if (_animPhase isEqualTo 0) then {
											player setUserActionText [QS_action_plow,"Lower plow","<t size=""3"">Lower plow</t>"];
										};
									};
									if (((vectorMagnitude (velocity _v)) * 3.6) < 1) then {
										_c = TRUE;
									};
								};
							};
						};
						_c;
					})
				',
				-1,
				FALSE,
				''
			]
		),
		FALSE
	];
	player setUserActionText [(missionNamespace getVariable 'QS_action_plow'),((player actionParams (missionNamespace getVariable 'QS_action_plow')) select 0),(format ["<t size='3'>%1</t>",((player actionParams (missionNamespace getVariable 'QS_action_plow')) select 0)])];
};
(group _unit) addVehicle _vehicle;