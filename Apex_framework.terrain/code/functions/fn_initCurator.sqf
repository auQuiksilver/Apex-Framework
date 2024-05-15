/*/
File: fn_initCurator.sqf
Author: 

	Quiksilver
	
Last Modified: 

	10/10/2023 A3 2.14 by Quiksilver
	
Description:

	Zeus initialization
_______________________________________________________/*/

params ['_type'];
if (_type isEqualTo 0) then {
	if (!isDedicated) exitWith {};
	params ['','_client','_puid','_cid'];
	if (!isNull (getAssignedCuratorLogic _client)) exitWith {diag_log '***** CURATOR ***** Client already has curator module assigned *****';};
	_logicGrp = createGroup [sideLogic,TRUE];
	_logicGrp setVariable ['isCuratorModuleGroup',TRUE,TRUE];
	_module = _logicGrp createUnit ['ModuleCurator_F',[-1000,-1000,0],[],0,'NONE'];
	_module setSkill 0;
	_module allowDamage FALSE;
	_module enableStamina FALSE;
	_module enableFatigue FALSE;
	_module enableAIFeature ['ALL',FALSE];
	_module addCuratorPoints 1;
	_module setVehicleVarName (format ['%1',(name _client)]);
	{
		_module setVariable _x;
	} forEach [
		['owner',_puid,FALSE],
		['Addons',3,FALSE],
		['forced',0,FALSE],
		['name','Zeus',FALSE],
		['channels',[],FALSE],
		['showNotification',FALSE,FALSE],
		['birdType','',FALSE],
		['QS_cleanup_protected',TRUE,FALSE],
		['QS_curator_modules',[],TRUE],
		['QS_curator_markers',[],TRUE]
	];
	[_module,'Init'] call (missionNamespace getVariable 'BIS_fnc_moduleInit');
	sleep 3;
	for '_x' from 0 to 1 step 0 do {
		_client assignCurator _module;
		if ((getAssignedCuratorUnit _module) isEqualTo _client) exitWith {
			[1,_module] remoteExec ['QS_fnc_initCurator',_cid,FALSE];
		};
		if ((isNull _module) || (isNull _client)) exitWith {};
		sleep 2;
	};
	_module addEventHandler [
		'Local',
		{
			params ['_object','_isLocal'];
			if (_isLocal) then {
				if (!isNull _object) then {
					if !(_object isNil 'QS_curator_modules') then {
						if ((_object getVariable 'QS_curator_modules') isEqualType []) then {
							deleteVehicle (_object getVariable ['QS_curator_modules',[]]);
						};
					};
					if !(_object isNil 'QS_curator_markers') then {
						if ((_object getVariable 'QS_curator_markers') isEqualType []) then {
							private _allMapMarkers = allMapMarkers;
							{
								if (_x in _allMapMarkers) then {
									deleteMarker _x;
								};
							} count (_object getVariable 'QS_curator_markers');
						};
					};
					deleteVehicle _object;
				};
			};
		}
	];
	if (missionNamespace getVariable ['QS_missionConfig_zeusRestrictions',TRUE]) then {
		private _disabled_addons = (['zeus_addons_disabled_1'] call QS_data_listOther) apply {toLowerANSI _x};
		if (missionNamespace getVariable ['QS_missionConfig_zeusLightning',FALSE]) then {
			_lightningAddons = ['a3_modules_f_curator_lightning','curatoronly_modules_f_curator_lightning'];
			_disabled_addons = _disabled_addons select {(!(_x in _lightningAddons))};
		};
		_module removeCuratorAddons _disabled_addons;
	};
	diag_log format ['***** CURATOR ***** Module created for %1 ( %2 ) *****',(name _client),_puid];
};
if (_type isEqualTo 1) then {
	if (isServer || !hasInterface) exitWith {};
	_module = getAssignedCuratorLogic player;
	if (!isNull _module) then {
		[_module,'Init'] call (missionNamespace getVariable 'BIS_fnc_moduleInit');
		{
			_module removeAllEventHandlers _x;
		} forEach [
			'curatorFeedbackMessage',
			'curatorPinged',
			'curatorObjectPlaced',
			'curatorObjectEdited',
			'curatorWaypointPlaced',
			'curatorObjectDoubleClicked',
			'curatorGroupDoubleClicked',
			'curatorWaypointDoubleClicked',
			'curatorMarkerDoubleClicked'
		];
		{
			_module addEventHandler _x;
		} forEach [
			['curatorFeedbackMessage',{call (missionNamespace getVariable 'BIS_fnc_showCuratorFeedbackMessage');}],
			/*/['curatorPinged',{call (missionNamespace getVariable 'BIS_fnc_curatorPinged');}],/*/
			['curatorObjectPlaced',{call (missionNamespace getVariable 'BIS_fnc_curatorObjectPlaced');}],
			['curatorObjectEdited',{call (missionNamespace getVariable 'BIS_fnc_curatorObjectEdited'); call (missionNamespace getVariable 'QS_fnc_clientEventCuratorObjectEdited')}],
			['curatorWaypointPlaced',{call (missionNamespace getVariable 'BIS_fnc_curatorWaypointPlaced');}],
			['curatorObjectDoubleClicked',{(_this # 1) call (missionNamespace getVariable 'BIS_fnc_showCuratorAttributes');}],
			['curatorGroupDoubleClicked',{(_this # 1) call (missionNamespace getVariable 'BIS_fnc_showCuratorAttributes');}],
			['curatorWaypointDoubleClicked',{(_this # 1) call (missionNamespace getVariable 'BIS_fnc_showCuratorAttributes');}],
			['curatorMarkerDoubleClicked',{(_this # 1) call (missionNamespace getVariable 'BIS_fnc_showCuratorAttributes');}],
			['curatorGroupPlaced',{call (missionNamespace getVariable 'QS_fnc_clientEventCuratorGroupPlaced')}],
			['curatorMarkerPlaced',{call (missionNamespace getVariable 'QS_fnc_clientEventCuratorMarkerPlaced')}],
			['curatorObjectPlaced',{call (missionNamespace getVariable 'QS_fnc_clientEventCuratorObjectPlaced')}],
			['curatorObjectRegistered',{call (missionNamespace getVariable 'QS_fnc_clientEventCuratorObjectRegistered')}],
			['curatorObjectDeleted',{call (missionNamespace getVariable 'QS_fnc_clientEventCuratorObjectDeleted')}],
			['curatorSelectionPresetLoaded',{call (missionNamespace getVariable 'QS_fnc_clientEventCuratorSelectionPresetLoaded')}],
			['curatorSelectionPresetSaved',{call (missionNamespace getVariable 'QS_fnc_clientEventCuratorSelectionPresetSaved')}],
			['curatorWaypointEdited',{call (missionNamespace getVariable 'QS_fnc_clientEventCuratorWaypointEdited')}],
			['curatorWaypointPlaced',{call (missionNamespace getVariable 'QS_fnc_clientEventCuratorWaypointPlaced')}]
		];
		[_module,[-1,-2,0]] call (missionNamespace getVariable 'BIS_fnc_setCuratorVisionModes');	
		{
			_module setVariable _x;
		} forEach [
			['QS_curator_modules',[],TRUE],
			['QS_curator_markers',[],TRUE]
		];
		_module enableAIFeature ['ALL',FALSE];
		private _actionID = -1;
		if !(missionNamespace isNil 'QS_airdefense_laptop') then {
			if (!isNull (missionNamespace getVariable 'QS_airdefense_laptop')) then {
				_laptop = missionNamespace getVariable 'QS_airdefense_laptop';
				_actionID = _laptop addAction [
					localize 'STR_QS_Interact_088',
					{
						params ['_actionTarget','','_actionID',''];
						private ['_result'];
						if (!(missionNamespace getVariable 'QS_smSuspend')) then {
							_result = [localize 'STR_QS_Menu_137',localize 'STR_QS_Menu_138',localize 'STR_QS_Menu_139',localize 'STR_QS_Menu_114',(findDisplay 46),FALSE,FALSE] call (missionNamespace getVariable 'BIS_fnc_guiMessage');
							if (_result) then {
								missionNamespace setVariable ['QS_smSuspend',TRUE,TRUE];
								50 cutText [localize 'STR_QS_Text_214','PLAIN DOWN',0.5];
								_actionTarget setUserActionText [_actionID,localize 'STR_QS_Interact_104',(format ["<t size='3'>%1</t>",localize 'STR_QS_Interact_104'])];
								['systemChat',(format ['%1 %2',profileName,localize 'STR_QS_Chat_130'])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
							};
						} else {
							_result = [localize 'STR_QS_Menu_141',localize 'STR_QS_Menu_138',localize 'STR_QS_Menu_140',localize 'STR_QS_Menu_114',(findDisplay 46),FALSE,FALSE] call (missionNamespace getVariable 'BIS_fnc_guiMessage');
							if (_result) then {
								missionNamespace setVariable ['QS_smSuspend',FALSE,TRUE];
								50 cutText [localize 'STR_QS_Text_215','PLAIN DOWN',0.5];
								_actionTarget setUserActionText [_actionID,localize 'STR_QS_Interact_088',(format ["<t size='3'>%1</t>",localize 'STR_QS_Interact_088'])];
								['systemChat',(format ['%1 %2',profileName,localize 'STR_QS_Chat_131'])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
							};
						};
					},
					[],
					50,
					TRUE,
					TRUE,
					'',
					'(!isNull (getAssignedCuratorLogic player))',
					5,
					FALSE
				];
				_laptop setUserActionText [_actionID,((_laptop actionParams _actionID) # 0),(format ["<t size='3'>%1</t>",((_laptop actionParams _actionID) # 0)])];
				_actionID2 = _laptop addAction [
					localize 'STR_QS_Interact_089',
					{
						params ['_actionTarget','','_actionID',''];
						private ['_result'];
						
						if ((missionNamespace getVariable ['QS_missionConfig_aoType','ZEUS']) isNotEqualTo 'ZEUS') then {
							if (!(missionNamespace getVariable ['QS_customAO_GT_active',FALSE])) then {
								if (!(missionNamespace getVariable 'QS_aoSuspended')) then {
									_result = [localize 'STR_QS_Menu_143',localize 'STR_QS_Menu_142',localize 'STR_QS_Menu_139',localize 'STR_QS_Menu_114',(findDisplay 46),FALSE,FALSE] call (missionNamespace getVariable 'BIS_fnc_guiMessage');
									if (_result) then {
										missionNamespace setVariable ['QS_aoSuspended',TRUE,TRUE];
										missionNamespace setVariable ['QS_aoCycleVar',TRUE,TRUE];
										missionNamespace setVariable ['QS_forceDefend',-1,TRUE];
										50 cutText [localize 'STR_QS_Text_216','PLAIN DOWN',0.5];
										_actionTarget setUserActionText [_actionID,(localize 'STR_QS_Interact_105'),(format ["<t size='3'>%1</t>",(localize 'STR_QS_Interact_105')])];
										['systemChat',(format ['%1 %2',profileName,localize 'STR_QS_Chat_132'])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
									};
								} else {
									_result = [localize 'STR_QS_Menu_144',localize 'STR_QS_Menu_142',localize 'STR_QS_Menu_140',localize 'STR_QS_Menu_114',(findDisplay 46),FALSE,FALSE] call (missionNamespace getVariable 'BIS_fnc_guiMessage');
									if (_result) then {
										missionNamespace setVariable ['QS_aoSuspended',FALSE,TRUE];
										missionNamespace setVariable ['QS_aoCycleVar',FALSE,TRUE];
										50 cutText [localize 'STR_QS_Text_217','PLAIN DOWN',0.5];
										_actionTarget setUserActionText [_actionID,(localize 'STR_QS_Interact_089'),(format ["<t size='3'>%1</t>",(localize 'STR_QS_Interact_089')])];
										['systemChat',(format ['%1 %2',profileName,localize 'STR_QS_Chat_133'])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
									};
								};
							} else {
								50 cutText [localize 'STR_QS_Text_218','PLAIN DOWN',0.5];
							};
						} else {
							50 cutText [localize 'STR_QS_Text_219','PLAIN DOWN',0.5];
						};
					},
					[],
					50,
					TRUE,
					TRUE,
					'',
					'(!isNull (getAssignedCuratorLogic player))',
					5,
					FALSE
				];
				_laptop setUserActionText [_actionID2,((_laptop actionParams _actionID2) # 0),(format ["<t size='3'>%1</t>",((_laptop actionParams _actionID2) # 0)])];
				_actionID3 = _laptop addAction [
					localize 'STR_QS_Interact_090',
					{
						params ['_actionTarget','','_actionID',''];
						private ['_result'];
						if ((missionNamespace getVariable ['QS_missionConfig_aoType','ZEUS']) isNotEqualTo 'ZEUS') then {
							if (!(missionNamespace getVariable ['QS_customAO_GT_active',FALSE])) then {
								if (diag_tickTime < (player getVariable ['QS_client_aoCycleCooldown',-1])) exitWith {
									50 cutText [(format ['%2 %1',(round((player getVariable ['QS_client_aoCycleCooldown',-1]) - diag_tickTime)),localize 'STR_QS_Text_220']),'PLAIN',0.5];
								};
								player setVariable ['QS_client_aoCycleCooldown',(diag_tickTime + 60),FALSE];
								if (!(missionNamespace getVariable ['QS_aoSuspended',FALSE])) then {
									_result = [localize 'STR_QS_Menu_146',localize 'STR_QS_Menu_142',localize 'STR_QS_Menu_145',localize 'STR_QS_Menu_114',(findDisplay 46),FALSE,FALSE] call (missionNamespace getVariable 'BIS_fnc_guiMessage');
									if (_result) then {
										missionNamespace setVariable ['QS_aoCycleVar',TRUE,TRUE];
										['systemChat',(format ['%1 %2',profileName,localize 'STR_QS_Chat_134'])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
										50 cutText [localize 'STR_QS_Text_221','PLAIN DOWN',0.5];
									} else {
										50 cutText [localize 'STR_QS_Text_222','PLAIN DOWN',0.5];
									};
								} else {
									50 cutText [localize 'STR_QS_Text_223','PLAIN DOWN',0.5];
								};
							} else {
								50 cutText [localize 'STR_QS_Text_218','PLAIN DOWN',0.5];
							};
						} else {
							50 cutText [localize 'STR_QS_Text_219','PLAIN DOWN',0.5];
						};
					},
					[],
					50,
					TRUE,
					TRUE,
					'',
					'(!isNull (getAssignedCuratorLogic player))',
					5,
					FALSE
				];
				_laptop setUserActionText [_actionID3,((_laptop actionParams _actionID3) # 0),(format ["<t size='3'>%1</t>",((_laptop actionParams _actionID3) # 0)])];
			};
		};
		calculatePlayerVisibilityByFriendly TRUE;
		player enableAIFeature ['ALL',TRUE];
		disableRemoteSensors FALSE;
		missionNamespace setVariable ['QS_hashmap_tracers',(createHashMapFromArray (call QS_data_tracers)),FALSE];
		
		//===== Zeus script to handle some stuff
		
		private _cameraOn = objNull;
		private _entity = objNull;
		private _nearUnits = [];
		private _nearUnitsIncapacitated = [];
		private _nearUnitsInjured = [];
		private _entitySide = WEST;
		private _unitSide = WEST;
		private _unit = objNull;
		private _jobData = [];
		private _time = diag_tickTime;
		private _healScript = scriptNull;
		private _oldUnitPos = '';
		private _prioritise = [];
		private _job = FALSE;
		private _serverTime = serverTime;
		private _diag_fps = diag_fps;
		private _allPlayersCount = count allPlayers;
		private _scriptEvalUnit = scriptNull;
		private _customAILogic = FALSE;
		_fn_AIHandleUnit = missionNamespace getVariable 'QS_fnc_AIHandleUnit';
		for '_z' from 0 to 1 step 0 do {
			uiSleep 1;
			_allPlayersCount = count allPlayers;
			_diag_fps = diag_fps;
			_serverTime = serverTime;
			_time = diag_tickTime;
			{
				if (!isPlayer _x) then {
					if (local _x) then {
						_entity = _x;
						if (_customAILogic) then {
							_scriptEvalUnit = [_scriptEvalUnit,_serverTime,_diag_fps,_allPlayersCount] spawn _fn_AIHandleUnit;
							waitUntil {scriptDone _scriptEvalUnit};
						};
						_entitySide = side (group _entity);
						if ((lifeState _entity) in ['HEALTHY','INJURED']) then {
							if (_entitySide in [EAST,RESISTANCE]) then {
								if (!(_entity getVariable ['QS_zeus_aiSkill',FALSE])) then {
									_entity setVariable ['QS_zeus_aiSkill',TRUE,FALSE];
									_entity setSkill 1;
									_entity setSkill ['aimingAccuracy',0.11];
								};
							};
							if (!(_entity getVariable ['QS_AI_JOB',FALSE])) then {
								if (_entity getUnitTrait 'medic') then {
									if ((lifeState _entity) isEqualTo 'INJURED') then {
										if ((random 1) > 0.75) then {
											_entity action ['HealSoldierSelf',_entity];
										};
									} else {
										_nearUnits = ((((getPosATL _entity) nearEntities ['CAManBase',100]) + (units (group _entity))) select {((!isNull (group _x)) && {((side (group _x)) isEqualTo _entitySide)})}) - [_entity];
										if (
											(_nearUnits isNotEqualTo []) &&
											{((count _nearUnits) > 1)}
										) then {
											_nearUnitsIncapacitated = _nearUnits select {((lifeState _x) isEqualTo 'INCAPACITATED')};
											if (_nearUnitsIncapacitated isNotEqualTo []) then {
												_nearUnitsIncapacitated = _nearUnitsIncapacitated apply {
													[
														_x distance2D _entity,
														_x
													]
												};
												_nearUnitsIncapacitated sort TRUE;
												_nearUnitsIncapacitated = _nearUnitsIncapacitated apply {_x # 1};
											};
											_nearUnitsInjured = _nearUnits select {((lifeState _x) isEqualTo 'INJURED')};
											if (_nearUnitsInjured isNotEqualTo []) then {	
												_nearUnitsInjured = _nearUnitsInjured apply {
													[
														_x distance2D _entity,
														_x
													]
												};
												_nearUnitsInjured sort TRUE;
												_nearUnitsInjured = _nearUnitsInjured apply {_x # 1};
											};
											_nearUnits = _nearUnitsIncapacitated + _nearUnitsInjured;
											if (_nearUnits isNotEqualTo []) then {
												_job = FALSE;
												{
													_unit = _x;
													if (alive _unit) then {
														if (!(_unit getVariable ['QS_revive_disable',FALSE])) then {
															if (isNull (attachedTo _unit)) then {
																if (isNull (objectParent _unit)) then {
																	if (
																		(!( alive (_unit getVariable ['QS_AI_JOB_PROVIDER',objNull]))) ||
																		((alive (_unit getVariable ['QS_AI_JOB_PROVIDER',objNull])) && {(((_unit getVariable ['QS_AI_JOB_PROVIDER',objNull]) distance _unit) > 15)})
																	) then {
																		_job = TRUE;

																		{
																			_entity enableAIFeature _x;
																		} forEach [
																			['AUTOCOMBAT',FALSE],
																			['TARGET',FALSE],
																			['SUPPRESSION',FALSE]
																		];
																		_entity addEventHandler [
																			'Hit',
																			{
																				(_this # 0) enableAIFeature ['TARGET',TRUE];
																				(_this # 0) enableAIFeature ['SUPPRESSION',TRUE];
																				(_this # 0) removeEventHandler [_thisEvent,_thisEventHandler];
																			}
																		];
																		_unit setVariable ['QS_AI_JOB_PROVIDER',_entity,FALSE];
																		_entity setVariable ['QS_AI_JOB',TRUE,FALSE];
																		_entity setVariable ['QS_AI_JOB_DATA',[(_time + 30),1,_time,scriptNull,'MEDIC',_unit,(getPosATL _unit)],FALSE];
																		if ((unitPos _entity) in ['Up','Auto']) then {
																			_entity setUnitPos 'Middle';
																		};
																	};
																};
															};
														};
													};
													if (_job) exitWith {};
												} forEach _nearUnits;
											};
										};
									};
								};
							} else {
								_jobData = _entity getVariable ['QS_AI_JOB_DATA',[]];
								_jobData params [
									'_jobTimeout',
									'_jobEvalDelay',
									'_jobEvalCheckDelay',
									'_jobScript',
									'_jobType',
									'_jobTarget',
									'_jobPosition'
								];
								if (_time > _jobTimeout) then {
									_entity doWatch objNull;
									_entity forceSpeed -1;
									_entity doFollow (leader (group _entity));
									_entity setVariable ['QS_AI_JOB',FALSE,FALSE];
									_entity setVariable ['QS_AI_JOB_DATA',[],FALSE];
									_jobTarget setVariable ['QS_AI_JOB_PROVIDER',objNull,FALSE];
								} else {
									if (_time > _jobEvalCheckDelay) then {
										_jobData set [2,(_time + _jobEvalDelay)];
										if (_jobType isEqualTo 'MEDIC') then {
											_jobData params [
												'',
												'',
												'',
												'',
												'',
												'_jobTarget',
												'_jobPosition'
											];
											if (
												(alive _jobTarget) && 
												((lifeState _jobTarget) in ['INCAPACITATED','INJURED']) && 
												(isNull (objectParent _jobTarget)) && 
												(isNull (attachedTo _jobTarget)) && 
												(alive _entity) && 
												((lifeState _entity) in ['HEALTHY','INJURED'])
											) then {
												if ((unitPos _entity) in ['Up','Auto']) then {
													_entity setUnitPos 'Middle';
												};
												if ((_entity distance _jobTarget) < 50) then {
													if (!isNull (objectParent _entity)) then {
														if (((vectorMagnitude (velocity (objectParent _entity))) * 3.6) < 2) then {
															if (
																((assignedVehicleRole _entity) isNotEqualTo []) && 
																{(((assignedVehicleRole _entity) # 0) isEqualTo 'cargo')}
															) then {
																moveOut _entity;
															};
														};
													};
												};
												if ((_entity distance _jobTarget) > 3) then {
													if ((lifeState _entity) isEqualTo 'INJURED') then {
														if ((random 1) > 0.75) then {
															_entity action ['HealSoldierSelf',_entity];
															_entity setDamage [0,FALSE];
														};
													} else {
														doStop _entity;
														uiSleep 0.1;
														_entity doMove (getPosATL _jobTarget);
													};
												} else {
													if (isNull _jobScript) then {
														_jobScript = [_entity,_jobTarget] spawn {
															params ['_entity','_jobTarget'];
															_entity doWatch _jobTarget;
															_entity playMoveNow 'ainvpknlmstpslaywrfldnon_medicother';
															_entity action ['HealSoldier',_jobTarget];
															_entity setDir (_entity getDir _jobTarget);
															uiSleep 5.7;
															_jobTarget setVariable ['QS_AI_JOB_PROVIDER',objNull,FALSE];
															if ((lifeState _jobTarget) isEqualTo 'INJURED') then {
																_jobTarget setDamage 0.09;
															};
															if (
																(alive _jobTarget) && 
																((lifeState _jobTarget) isEqualTo 'INCAPACITATED') && 
																(isNull (objectParent _jobTarget)) && 
																(isNull (attachedTo _jobTarget)) && 
																(alive _entity) && 
																((lifeState _entity) in ['HEALTHY','INJURED'])
															) then {
																if (local _jobTarget) then {
																	_jobTarget setUnconscious FALSE;
																	_jobTarget setCaptive FALSE;
																	if (!isPlayer _jobTarget) then {
																		['switchMove',_jobTarget,'AmovPpneMstpSnonWnonDnon'] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
																	};
																} else {
																	[68,_jobTarget,FALSE,FALSE] remoteExec ['QS_fnc_remoteExec',_jobTarget,FALSE];
																};
															};
															_entity doWatch objNull;
															doStop _entity;
															_entity doFollow (leader (group _entity));
															_entity setVariable ['QS_AI_JOB',FALSE,FALSE];
															_entity setVariable ['QS_AI_JOB_DATA',[],FALSE];
															_jobTarget setVariable ['QS_AI_JOB_PROVIDER',objNull,FALSE];
														};
														_entity enableAIFeature ['AUTOCOMBAT',FALSE];
														_entity enableAIFeature ['TARGET',TRUE];
														_jobData set [3,_jobScript];
													};
												};
												_jobData set [6,(getPosATL _jobTarget)];
												_entity setVariable ['QS_AI_JOB_DATA',_jobData,FALSE];
											} else {
												_entity setVariable ['QS_AI_JOB',FALSE,FALSE];
												_entity setVariable ['QS_AI_JOB_DATA',[],FALSE];
												_jobTarget setVariable ['QS_AI_JOB_PROVIDER',objNull,FALSE];
											};
										};		
									};
								};
							};
						};
					};
				};
			} forEach allUnits;
		};
	};
};