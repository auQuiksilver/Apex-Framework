/*/
File: fn_AIHandleUnit.sqf
Author: 

	Quiksilver

Last Modified:

	29/10/2017 A3 1.76 by Quiksilver

Description:

	Handle Unit AI
	_unit setVariable ['QS_AI_UNIT_isMG',TRUE,FALSE];
____________________________________________________________________________/*/

params ['_unit','_uiTime','_fps'];
if (
	(!(alive _unit)) ||
	{(!(local _unit))} ||
	{(!(simulationEnabled _unit))} ||
	{(!((lifeState _unit) in ['HEALTHY','INJURED']))}
) exitWith {};
comment 'Set some nil vars';
if (isNil {_unit getVariable 'QS_AI_UNIT'}) then {
	_unit setVariable ['QS_AI_UNIT',TRUE,FALSE];
	if (isNil {_unit getVariable 'QS_AI_UNIT_lastSelfRearm'}) then {
		_unit setVariable ['QS_AI_UNIT_lastSelfRearm',_uiTime,FALSE];
	};
	if (isNil {_unit getVariable 'QS_AI_UNIT_lastSelfHeal'}) then {
		_unit setVariable ['QS_AI_UNIT_lastSelfHeal',_uiTime,FALSE];
	};
	if (isNil {_unit getVariable 'QS_AI_UNIT_isMG'}) then {
		if (((getText (configFile >> 'CfgWeapons' >> (primaryWeapon _unit) >> 'cursor')) isEqualTo 'mg') || {((toLower (typeOf _unit)) in ['o_t_soldier_ar_f'])}) then {
			_unit setVariable ['QS_AI_UNIT_isMG',TRUE,FALSE];
		} else {
			_unit setVariable ['QS_AI_UNIT_isMG',FALSE,FALSE];
		};
		if (_unit getVariable 'QS_AI_UNIT_isMG') then {
			if (isNil {_unit getVariable 'QS_AI_UNIT_lastSuppressiveFire'}) then {
				_unit setVariable ['QS_AI_UNIT_lastSuppressiveFire',(_uiTime - 1),FALSE];
			};
		};
	};
	if (isNil {_unit getVariable 'QS_AI_UNIT_lastSmoke'}) then {
		_unit setVariable ['QS_AI_UNIT_lastSmoke',_uiTime,FALSE];
	};
	if (isNil {_unit getVariable 'QS_AI_UNIT_lastFrag'}) then {
		_unit setVariable ['QS_AI_UNIT_lastFrag',_uiTime,FALSE];
	};
	if (isNil {_unit getVariable 'QS_AI_UNIT_lastStanceAdjust'}) then {
		_unit setVariable ['QS_AI_UNIT_lastStanceAdjust',_uiTime,FALSE];
	};
	if (isNil {_unit getVariable 'QS_AI_UNIT_lastGesture'}) then {
		_unit setVariable ['QS_AI_UNIT_lastGesture',(_uiTime + (random [5,30,60])),FALSE];
	};
	if (isNil {_unit getVariable 'QS_AI_UNIT_exp'}) then {
		if (_unit getUnitTrait 'explosiveSpecialist') then {
			_unit setVariable ['QS_AI_UNIT_lastExpEval',(_uiTime + (random [30,60,90])),FALSE];
		};
	};
};
comment 'Get some basic info';
_grp = group _unit;
_isLeader = _unit isEqualTo (leader _grp);
if (_isLeader) then {
	if (isNil {_unit getVariable 'QS_AI_UNIT_lastSupportRequest'}) then {
		_unit setVariable ['QS_AI_UNIT_lastSupportRequest',(_uiTime - 1),FALSE];
	};
	if (isNil {_unit getVariable 'QS_AI_UNIT_lastRegroup'}) then {
		_unit setVariable ['QS_AI_UNIT_lastRegroup',(_uiTime + (random [30,60,90])),FALSE];
	};
};
_objectParent = objectParent _unit;
_suppression = getSuppression _unit;
_unitReady = unitReady _unit;
_unitBehaviour = behaviour _unit;
if (isNull _objectParent) then {
	_unitPos = unitPos _unit;
	comment 'Suppression';
	if (_suppression >= 0.2) then {
		if (_uiTime > (_unit getVariable ['QS_AI_UNIT_lastStanceAdjust',-1])) then {
			_unit setVariable ['QS_AI_UNIT_lastStanceAdjust',(_uiTime + (random [30,60,90])),FALSE];
			if (!(_unitPos isEqualTo 'MIDDLE')) then {
				_unit setUnitPosWeak 'MIDDLE';
			};
		};
	} else {
		if (_unitPos isEqualTo 'DOWN') then {
			_unit setUnitPos 'AUTO';
		};
	};
	comment 'Self heal';
	if (_uiTime > (_unit getVariable ['QS_AI_UNIT_lastSelfHeal',-1])) then {
		_unit setVariable ['QS_AI_UNIT_lastSelfHeal',(_uiTime + (random [30,60,90])),FALSE];
		if ((!((damage _unit) isEqualTo 0)) || {(({(!(_x isEqualTo 0))} count ((getAllHitPointsDamage _unit) select 2)) > 0)}) then {
			if (isNull _objectParent) then {
				_weaponLowered = weaponLowered _unit;
				if ((isNull (_unit findNearestEnemy _unit)) || {(_unitReady)} || {(_weaponLowered)}) then {
					_unit action ['HealSoldierSelf',_unit];
					_unit setDamage [0,FALSE];
				};
			};
		};
	};
	if (_fps > 15) then {
		if (_unit getVariable ['QS_AI_UNIT_isMG',FALSE]) then {
			if (!(_unit getVariable ['QS_AI_UNIT_sfEvent',FALSE])) then {
				if (_uiTime > (_unit getVariable ['QS_AI_UNIT_lastSuppressiveFire',-1])) then {
					_unit setVariable ['QS_AI_UNIT_sfEvent',TRUE,FALSE];
					_unit addEventHandler ['FiredMan',{_this call (missionNamespace getVariable 'QS_fnc_AIXSuppressiveFire')}];
				};
			};
		};
	};
	if (_fps > 15) then {
		if ((random 1) > 0.9) then {
			if (_uiTime > (_unit getVariable ['QS_AI_UNIT_LastGesture',-1])) then {
				_unit setVariable ['QS_AI_UNIT_LastGesture',(_uiTime + (random ([[5,10,15],[20,40,60]] select (_unitBehaviour isEqualTo 'COMBAT')))),FALSE];
				if ((count (missionNamespace getVariable 'QS_AI_unitsGestureReady')) < ([5,10] select (_fps > 20))) then {
					_unit setVariable ['QS_AI_UNIT_gestureEvent',TRUE,FALSE];
					_unit addEventHandler ['Hit',{_this call (missionNamespace getVariable 'QS_fnc_AIXHitEvade')}];
					(missionNamespace getVariable 'QS_AI_unitsGestureReady') pushBack _unit;
				};
			};
		};
	};
	if (_fps > 15) then {
		if (_unit getUnitTrait 'explosiveSpecialist') then {
			if ((random 1) > 0) then {
				if (!(_unit getVariable ['QS_AI_JOB',FALSE])) then {
					if (_uiTime > (_unit getVariable ['QS_AI_UNIT_lastExpEval',-1])) then {
						_unit setVariable ['QS_AI_UNIT_lastExpEval',(diag_tickTime + (random [30,45,60])),FALSE];
						if ((count (missionNamespace getVariable 'QS_AI_scripts_Assault')) < 3) then {
							private _targetFound = FALSE;
							_assignedTarget = assignedTarget _unit;
							if (alive _assignedTarget) then {
								_assignedTargetVehicle = vehicle _assignedTarget;
								if (_assignedTargetVehicle isKindOf 'AllVehicles') then {
									if (!(_assignedTargetVehicle isKindOf 'CAManBase')) then {
										if (isTouchingGround _assignedTargetVehicle) then {
											if ((_unit distance2D _assignedTargetVehicle) < 150) then {
												_targetFound = TRUE;
												_unit setVariable ['QS_AI_JOB',TRUE,FALSE];
												(missionNamespace getVariable 'QS_AI_scripts_Assault') pushBack ([_unit,_assignedTargetVehicle,300,(selectRandom ['explosive charge','explosive charge','satchel']),6,FALSE,TRUE] spawn (missionNamespace getVariable 'QS_fnc_AIXSetMine'));
											};
										};
									};
								};
							};
							if (!(_targetFound)) then {
								if (!((_grp getVariable ['QS_AI_GRP_nearTargets',[]]) isEqualTo [])) then {
									_targets = (_grp getVariable 'QS_AI_GRP_nearTargets') select 0;
									private _targetFound = FALSE;
									if (!(_targets isEqualTo [])) then {
										{
											if (alive _x) then {
												if (_x isKindOf 'AllVehicles') then {
													if (!(_x isKindOf 'CAManBase')) then {
														if (isTouchingGround _x) then {
															if ((_x distance2D _unit) < 150) then {
																comment 'Target found';
																_targetFound = TRUE;
																_unit setVariable ['QS_AI_JOB',TRUE,FALSE];
																(missionNamespace getVariable 'QS_AI_scripts_Assault') pushBack ([_unit,_x,300,(selectRandom ['explosive charge','explosive charge','satchel']),6,FALSE,TRUE] spawn (missionNamespace getVariable 'QS_fnc_AIXSetMine'));
															};
														};
													};
												};
											};
											if (_targetFound) exitWith {};
										} forEach _targets;
									};
								};
							};
							if (!(_targetFound)) then {
								_targets = [6,EAST,(getPosATL _unit),(150 + (random 100))] call (missionNamespace getVariable 'QS_fnc_AIGetKnownEnemies');
								if (!(_targets isEqualTo [])) then {
									_targetFound = TRUE;
									_target = selectRandom _targets;
									_unit setVariable ['QS_AI_JOB',TRUE,FALSE];
									(missionNamespace getVariable 'QS_AI_scripts_Assault') pushBack ([_unit,_target,300,(selectRandom ['explosive charge','explosive charge','satchel']),6,FALSE,TRUE] spawn (missionNamespace getVariable 'QS_fnc_AIXSetMine'));
								};
							};
						};
					};
				};
			};
		};
	};
};
if (!isNil {_grp getVariable 'BLDG_GARRISON'}) then {
	if (!isNull (_unit findNearestEnemy _unit)) then {
		if (((_unit findNearestEnemy _unit) distance2D _unit) < 15) then {
			if (isNil {_unit getVariable 'QS_unit_hitEvent'}) then {
				_unit addEventHandler [
					'Hit',
					{
						_unit = _this select 0;
						_enemy = _unit findNearestEnemy _unit;
						_unit removeEventHandler ['Hit',_thisEventHandler];
						_unit setVariable ['QS_unit_hitEvent',nil,FALSE];
						if ((_enemy distance2D _unit) < 15) then {
							_unit enableAI 'PATH';
						};
					}
				];
			};
		};
	};
};
if (_isLeader) then {
	if (_uiTime > (_unit getVariable ['QS_AI_UNIT_lastRegroup',-1])) then {
		_unit setVariable ['QS_AI_UNIT_lastRegroup',(_uiTime + (random [30,60,90])),FALSE];
		if (({(alive _x)} count (units _grp)) isEqualTo 1) then {
			comment 'Search for nearby equivalent groups, search for nearby rally points if unavailable';
			[_unit,300] call (missionNamespace getVariable 'QS_fnc_AIFindNearestRegroup');
		};
	};
	if ((combatMode _grp) isEqualTo 'RED') then {
		comment 'if ((_suppression > 0) || {(!((damage _unit) isEqualTo 0))}) then {';
		if ('ItemRadio' in (assignedItems _unit)) then {
			if (_uiTime > (_unit getVariable 'QS_AI_UNIT_lastSupportRequest')) then {
				_unit setVariable ['QS_AI_UNIT_lastSupportRequest',(diag_tickTime + (120 + (random 120))),FALSE];
				_allTargets = _unit targets [TRUE,600];
				if (!(_allTargets isEqualTo [])) then {
					_time = time;
					private _filteredTargets = _allTargets select {(((_time - ((_unit targetKnowledge _x) select 2)) < 30) && (isTouchingGround _x) && ((lifeState _x) in ['HEALTHY','INJURED']))};
					if (!(_filteredTargets isEqualTo [])) then {
						private _target = objNull;
						if ((count _filteredTargets) isEqualTo 1) then {
							_target = _filteredTargets select 0;
						} else {
							if ((random 1) > 0.5) then {
								_target = selectRandom _filteredTargets;
							} else {
								private _rating = -9999;
								{
									if ((rating _x) > _rating) then {
										_target = _x;
										_rating = rating _x;
									};
								} count _filteredTargets
							};
						};
						if (!isNull _target) then {
							if ((count (missionNamespace getVariable 'QS_AI_scripts_fireMissions')) <= 3) then {
								private _exit = FALSE;
								private _supportProviders = [];
								private _supportProvider = objNull;
								private _targetPos = [0,0,0];
								private _smokePos = [0,0,0];
								if (!((missionNamespace getVariable 'QS_AI_supportProviders_ARTY') isEqualTo [])) then {
									_supportProviders = missionNamespace getVariable 'QS_AI_supportProviders_ARTY';
									{
										_supportProvider = _x;
										if (!isNull _supportProvider) then {
											if (alive _supportProvider) then {
												if ((vehicle _supportProvider) isKindOf 'LandVehicle') then {
													_supportGroup = group _supportProvider;
													if ((_supportGroup getVariable 'QS_AI_GRP_DATA') select 0) then {
														if (isNil {_supportGroup getVariable 'QS_AI_GRP_fireMission'}) then {
															if (isNil {_supportGroup getVariable 'QS_AI_GRP_MTR_cooldown'}) then {
																if (((_unit targetKnowledge _target) select 6) inRangeOfArtillery [[_supportProvider],'32Rnd_155mm_Mo_shells']) then {
																	_unit playActionNow 'HandSignalRadio';
																	comment 'Should spawn red smoke nearby here?';
																	if (missionNamespace getVariable ['QS_virtualSectors_active',FALSE]) then {
																		if (missionNamespace getVariable ['QS_virtualSectors_sub_1_active',FALSE]) then {
																			EAST reportRemoteTarget [_target,60];
																		};
																	};
																	_smokePos = ((_unit targetKnowledge _target) select 6) getPos [(random 10),(random 360)];
																	_smokePos set [2,0.25];
																	_smokeShell = createVehicle ['SmokeShellRed',[_smokePos select 0,_smokePos select 1,25],[],0,'NONE'];
																	_smokeShell setVehiclePosition [(getPosWorld _smokeShell),[],0,'NONE'];
																	(missionNamespace getVariable 'QS_garbageCollector') pushBack [_smokeShell,'DELAYED_FORCED',(time + 120)];
																	missionNamespace setVariable [
																		'QS_analytics_entities_created',
																		((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
																		FALSE
																	];
																	_targetPos = ((_unit targetKnowledge _target) select 6) getPos [(random 25),(random 360)];
																	_targetPos set [2,0];
																	_supportGroup setVariable ['QS_AI_GRP_fireMission',[_targetPos,'32Rnd_155mm_Mo_shells',(round (2 + (random 2))),(diag_tickTime + 240)],FALSE];
																	_exit = TRUE;
																};
															};
														};
													};
												};
											};
										};
										if (_exit) exitWith {};
									} forEach _supportProviders;
								};
								if (!((missionNamespace getVariable 'QS_AI_supportProviders_MTR') isEqualTo [])) then {
									_supportProviders = missionNamespace getVariable 'QS_AI_supportProviders_MTR';
									{
										_supportProvider = _x;
										if (!isNull _supportProvider) then {
											if (alive _supportProvider) then {
												if ((vehicle _supportProvider) isKindOf 'StaticMortar') then {
													_supportGroup = group _supportProvider;
													if ((_supportGroup getVariable 'QS_AI_GRP_DATA') select 0) then {
														if (isNil {_supportGroup getVariable 'QS_AI_GRP_fireMission'}) then {
															if (isNil {_supportGroup getVariable 'QS_AI_GRP_MTR_cooldown'}) then {
																if (((_unit targetKnowledge _target) select 6) inRangeOfArtillery [[_supportProvider],'8Rnd_82mm_Mo_shells']) then {
																	_unit playActionNow 'HandSignalRadio';
																	comment 'Should spawn red smoke nearby here?';
																	if (missionNamespace getVariable ['QS_virtualSectors_active',FALSE]) then {
																		if (missionNamespace getVariable ['QS_virtualSectors_sub_1_active',FALSE]) then {
																			EAST reportRemoteTarget [_target,60];
																		};
																	};
																	_smokePos = ((_unit targetKnowledge _target) select 6) getPos [(random 10),(random 360)];
																	_smokePos set [2,0.25];
																	_smokeShell = createVehicle ['SmokeShellRed',[_smokePos select 0,_smokePos select 1,25],[],0,'NONE'];
																	_smokeShell setVehiclePosition [(getPosWorld _smokeShell),[],0,'NONE'];
																	(missionNamespace getVariable 'QS_garbageCollector') pushBack [_smokeShell,'DELAYED_FORCED',(time + 120)];
																	missionNamespace setVariable [
																		'QS_analytics_entities_created',
																		((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
																		FALSE
																	];
																	_targetPos = ((_unit targetKnowledge _target) select 6) getPos [(random 25),(random 360)];
																	_targetPos set [2,0];
																	_supportGroup setVariable ['QS_AI_GRP_fireMission',[_targetPos,'8Rnd_82mm_Mo_shells',(round (2 + (random 2))),(diag_tickTime + 360)],FALSE];
																	_exit = TRUE;
																};
															};
														};
													};
												};
											};
										};
										if (_exit) exitWith {};
									} forEach _supportProviders;
								};
								if (_exit) exitWith {};
								if (!((missionNamespace getVariable 'QS_AI_supportProviders_CASHELI') isEqualTo [])) then {
									_supportProviders = missionNamespace getVariable 'QS_AI_supportProviders_CASHELI';
									{
										_supportProvider = _x;
										if (!isNull _supportProvider) then {
											if (alive _supportProvider) then {
												if ((vehicle _supportProvider) isKindOf 'Helicopter') then {
													if (((vehicle _supportProvider) distance2D _target) < 3000) then {
														_supportGroup = group _supportProvider;
														if (isNil {_supportGroup getVariable 'QS_AI_GRP_fireMission'}) then {
															_unit playActionNow 'HandSignalRadio';
															_exit = TRUE;
															_supportGroup setVariable ['QS_AI_GRP_fireMission',[_target,(diag_tickTime + 240)],FALSE];
															_smokePos = ((_unit targetKnowledge _target) select 6) getPos [(random 10),(random 360)];
															_smokePos set [2,0.25];
															_smokeShell = createVehicle ['SmokeShellRed',[_smokePos select 0,_smokePos select 1,25],[],0,'NONE'];
															_smokeShell setVehiclePosition [(getPosWorld _smokeShell),[],0,'NONE'];
															(missionNamespace getVariable 'QS_garbageCollector') pushBack [_smokeShell,'DELAYED_FORCED',(time + 120)];
															_handle = [1,_supportProvider,_supportGroup,_target,(position _target),_smokePos,(diag_tickTime + 240)] spawn (missionNamespace getVariable 'QS_fnc_AIFireMission');
															(missionNamespace getVariable 'QS_AI_scripts_fireMissions') pushBack _handle;
															missionNamespace setVariable [
																'QS_analytics_entities_created',
																((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
																FALSE
															];
														};
													};
												};
											};
										};
										if (_exit) exitWith {};
									} forEach _supportProviders;
								};
								if (_exit) exitWith {};
								if (!((missionNamespace getVariable 'QS_AI_supportProviders_CASPLANE') isEqualTo [])) then {
									_supportProviders = missionNamespace getVariable 'QS_AI_supportProviders_CASPLANE';
									private _laserTarget = objNull;
									private _laserPos = [0,0,0];
									{
										_supportProvider = _x;
										if (!isNull _supportProvider) then {
											if (alive _supportProvider) then {
												if ((vehicle _supportProvider) isKindOf 'Plane') then {
													_supportGroup = group _supportProvider;
													if (isNil {_supportGroup getVariable 'QS_AI_GRP_fireMission'}) then {
														_unit playActionNow 'HandSignalRadio';
														_exit = TRUE;
														_supportGroup setVariable ['QS_AI_GRP_fireMission',[_target,(diag_tickTime + 180)],FALSE];
														_laserPos = (_unit targetKnowledge _target) select 6;
														_laserPos set [2,1];
														_handle = [2,_supportProvider,_supportGroup,_target,(position _target),(diag_tickTime + 120)] spawn (missionNamespace getVariable 'QS_fnc_AIFireMission');
														(missionNamespace getVariable 'QS_AI_scripts_fireMissions') pushBack _handle;														
														_smokeShell = createVehicle ['SmokeShellRed',[_smokePos select 0,_smokePos select 1,25],[],0,'NONE'];
														_smokeShell setVehiclePosition [(getPosWorld _smokeShell),[],0,'NONE'];
														(missionNamespace getVariable 'QS_garbageCollector') pushBack [_smokeShell,'DELAYED_FORCED',(time + 120)];
														missionNamespace setVariable [
															'QS_analytics_entities_created',
															((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
															FALSE
														];
													};
												};
											};
										};
										if (_exit) exitWith {};
									} forEach _supportProviders;
								};
								if (_exit) exitWith {};
								if (!((missionNamespace getVariable 'QS_AI_supportProviders_CASUAV') isEqualTo [])) then {
									_supportProviders = missionNamespace getVariable 'QS_AI_supportProviders_CASUAV';
									private _laserTarget = objNull;
									private _laserPos = [0,0,0];
									{
										_supportProvider = _x;
										if (!isNull _supportProvider) then {
											if (alive _supportProvider) then {
												if (unitIsUav (vehicle _supportProvider)) then {
													_supportGroup = group _supportProvider;
													if (isNil {_supportGroup getVariable 'QS_AI_GRP_fireMission'}) then {
														_unit playActionNow 'HandSignalRadio';
														_exit = TRUE;
														_supportGroup setVariable ['QS_AI_GRP_fireMission',[_target,(diag_tickTime + 180)],FALSE];
														_laserPos = (_unit targetKnowledge _target) select 6;
														_laserPos set [2,1];
														_handle = [3,_supportProvider,_supportGroup,_target,(position _target),(diag_tickTime + 180)] spawn (missionNamespace getVariable 'QS_fnc_AIFireMission');
														(missionNamespace getVariable 'QS_AI_scripts_fireMissions') pushBack _handle;	
														_smokeShell = createVehicle ['SmokeShellRed',[_smokePos select 0,_smokePos select 1,25],[],0,'NONE'];
														_smokeShell setVehiclePosition [(getPosWorld _smokeShell),[],0,'NONE'];
														(missionNamespace getVariable 'QS_garbageCollector') pushBack [_smokeShell,'DELAYED_FORCED',(time + 120)];
														missionNamespace setVariable [
															'QS_analytics_entities_created',
															((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
															FALSE
														];
													};
												};
											};
										};
										if (_exit) exitWith {};
									} forEach _supportProviders;							
								};
								if (_exit) exitWith {};
							};
						};
					};
				};
			};
		};
	};
};