/*/
File: fn_AIHandleUnit.sqf
Author: 

	Quiksilver

Last Modified:

	9/10/2023 A3 2.14 by Quiksilver

Description:

	Handle Unit AI
_______________________________________________________/*/

scriptName 'QS_fnc_AIHandleUnit';
params ['_unit','_uiTime','_fps','_playercount'];
if (
	(!(alive _unit)) ||
	{(!(local _unit))} ||
	{(!(simulationEnabled _unit))} ||
	{(!((lifeState _unit) in ['HEALTHY','INJURED']))}
) exitWith {
	if (_unit isEqualTo (leader (group _unit))) then {
		_grp = group _unit;
		if (!alive _unit) then {
			private _grpUnits = (units _grp) select {((alive _x) && ((lifeState _x) in ['HEALTHY','INJURED']))};
			if (_grpUnits isNotEqualTo []) then {
				_grpUnits = _grpUnits apply {[rankId _x,_x]};
				_grpUnits sort FALSE;
				_grp selectLeader ((_grpUnits # 0) # 1);
			};
		};
	};
};
private _grp = group _unit;
_objectParent = objectParent _unit;
if (!(_unit getVariable ['QS_AI_UNIT',FALSE])) then {
	_unit setVariable ['QS_AI_UNIT',TRUE,FALSE];
	_unit setVariable ['QS_AI_UNIT_rv',[(random 1),(random 1),(random 1)],FALSE];
	if (_unit isNil 'QS_AI_UNIT_nextSelfRearm') then {
		_unit setVariable ['QS_AI_UNIT_nextSelfRearm',(_uiTime + (random [180,300,420])),FALSE];
	};
	if (_unit isNil 'QS_AI_UNIT_lastSelfHeal') then {
		_unit setVariable ['QS_AI_UNIT_lastSelfHeal',_uiTime,FALSE];
	};
	if (_unit isNil 'QS_AI_UNIT_isMG') then {
		if (
			((toLowerANSI (primaryWeapon _unit)) in (missionNamespace getVariable ['QS_AI_weapons_MG',[]])) ||
			{((!isNull _objectParent) && {(_unit isEqualTo (gunner _objectParent))})}
		) then {
			if (
				(isNull _objectParent) || 
				{(!(['_aa_',(typeOf _objectParent),FALSE] call (missionNamespace getVariable 'QS_fnc_inString')))}
			) then {
				_unit setVariable ['QS_AI_UNIT_isMG',TRUE,FALSE];
			} else {
				_unit setVariable ['QS_AI_UNIT_isMG',FALSE,FALSE];
			};
		} else {
			_unit setVariable ['QS_AI_UNIT_isMG',FALSE,FALSE];
		};
	};
	if (_unit isNil 'QS_AI_UNIT_isGL') then {
		if ((toLowerANSI (primaryWeapon _unit)) in (missionNamespace getVariable ['QS_AI_weapons_GL',[]])) then {
			_unit setVariable ['QS_AI_UNIT_isGL',TRUE,FALSE];
		} else {
			_unit setVariable ['QS_AI_UNIT_isGL',FALSE,FALSE];
		};
	};
	if (_unit isNil 'QS_AI_UNIT_lastSmoke') then {
		_unit setVariable ['QS_AI_UNIT_lastSmoke',_uiTime,FALSE];
	};
	if (_unit isNil 'QS_AI_UNIT_lastFrag') then {
		_unit setVariable ['QS_AI_UNIT_lastFrag',_uiTime,FALSE];
	};
	if (_unit isNil 'QS_AI_UNIT_lastStanceAdjust') then {
		_unit setVariable ['QS_AI_UNIT_lastStanceAdjust',_uiTime,FALSE];
	};
	if (_unit isNil 'QS_AI_UNIT_lastGesture') then {
		_unit setVariable ['QS_AI_UNIT_lastGesture',(_uiTime + (random [5,30,60])),FALSE];
	};
	if (_unit isNil 'QS_AI_UNIT_exp') then {
		if (_unit getUnitTrait 'explosiveSpecialist') then {
			_unit setVariable ['QS_AI_UNIT_lastExpEval',(_uiTime + (random [30,60,90])),FALSE];
		};
	};
	if (_unit getUnitTrait 'engineer') then {
		if (_unit isNil 'QS_AI_UNIT_assignedVehicle') then {
			_unit setVariable ['QS_AI_UNIT_assignedVehicle',(assignedVehicle _unit),FALSE];
		};
	};
	if (_unit isNil 'QS_AI_unstuckInterval') then {
		_unit setVariable ['QS_AI_unstuckInterval',(_uiTime + (180 + (random 600))),FALSE];
	};
	if ((secondaryWeapon _unit) isNotEqualTo '') then {
		if ((_playercount < 20) || ((random 1) > 0.5)) then {
			if ((random 1) > 0.25) then {
				[_unit,_grp] call (missionNamespace getVariable 'QS_fnc_AISetRockets');
			};
		};
	};
};
_isLeader = _unit isEqualTo (leader _grp);
if (_isLeader) then {
	if (_unit isNil 'QS_AI_UNIT_lastSupportRequest') then {
		_unit setVariable ['QS_AI_UNIT_lastSupportRequest',-1,FALSE];
	};
	if (_unit isNil 'QS_AI_UNIT_lastRegroup') then {
		_unit setVariable ['QS_AI_UNIT_lastRegroup',(_uiTime + (random [30,60,90])),FALSE];
	};
	if (!alive _unit) then {
		private _grpUnits = (units _grp) select {((lifeState _x) in ['HEALTHY','INJURED'])};
		if (_grpUnits isNotEqualTo []) then {
			_grpUnits = _grpUnits apply {[rankId _x,_x]};
			_grpUnits sort FALSE;
			_grp selectLeader ((_grpUnits # 0) # 1);
		};
	};
};
_attackTarget = getAttackTarget _unit;

if (
	((random 1) > 0.5) &&
	(!alive _attackTarget) &&
	(_fps > 15)
) then {
	_attackTarget = [_unit,300,TRUE] call (missionNamespace getVariable 'QS_fnc_AIGetAttackTarget');
};
if (alive _attackTarget) then {
	_unit setVariable ['QS_AI_UNIT_attackTarget',_attackTarget,FALSE];
};
_suppression = getSuppression _unit;
_unitReady = unitReady _unit;
_unitBehaviour = behaviour _unit;
_unitMorale = morale _unit;
_unitDamage = damage _unit;
_formationPos = formationPosition _unit;
_expectedDestination = expectedDestination _unit;
_currentCommand = currentCommand _unit;
_aiPath = _unit checkAIFeature 'PATH';
if (
	!scriptDone (_grp getVariable ['QS_AI_GRP_SCRIPT',scriptNull])
) exitWith {};
//=========== DELAYED INSTRUCTIONS
if ((_unit getVariable ['QS_AI_UNIT_delayedInstructions',[]]) isNotEqualTo []) then {
	_delayedInstructions = _unit getVariable ['QS_AI_UNIT_delayedInstructions',[-1,-1]];
	if (_uiTime > (_delayedInstructions # 0)) then {
		[_unit,(_delayedInstructions # 1)] call (missionNamespace getVariable 'QS_fnc_AIXDelayedInstruction');
	};
};
if (isNull _objectParent) then {
	
	//=============================== ADD TRACERS
	if (
		(!(_unit getVariable ['QS_AI_tracersAdded',FALSE])) &&
		{((_unit getUnitTrait 'audibleCoef') > 0.5)}
	) then {
		if (
			(
				((missionNamespace getVariable ['QS_missionConfig_tracers',1]) isEqualTo 1) &&
				{((_playercount < 15) || (([0,0,0] getEnvSoundController 'night') isEqualTo 1))}
			) ||
			{((missionNamespace getVariable ['QS_missionConfig_tracers',1]) isEqualTo 2)}
		) then {
			[_unit,_grp] call (missionNamespace getVariable 'QS_fnc_AISetTracers');
		};
	};

	//=============================== UNSTUCK CHECK
	if (_uiTime > (_unit getVariable ['QS_AI_unstuckInterval',-1])) then {
		_unit setVariable ['QS_AI_unstuckInterval',(_uiTime + (180 + (random 600))),FALSE];
		[_unit,group _unit,'CAManBase'] call (missionNamespace getVariable 'QS_fnc_AIXVehicleUnstuck');
	};

	//=============================== STANCE ADJUST
	if (!(_unit getVariable ['QS_AI_UNIT_disableStanceAdjust',FALSE])) then {
		_unitPos = unitPos _unit;
		if (
			(_unitBehaviour isEqualTo 'COMBAT') &&
			{((_suppression > 0) || (_unitDamage > 0.1))}
		) then {
			if (_uiTime > (_unit getVariable ['QS_AI_UNIT_lastStanceAdjust',-1])) then {
				_unit setVariable ['QS_AI_UNIT_lastStanceAdjust',(_uiTime + (random [15,30,45])),FALSE];
				if (_unitPos isEqualTo 'Up') then {
					_unit setUnitPos 'Middle';
				};
			};
		} else {
			if (_unitPos isEqualTo 'Down') then {
				_unit setUnitPos 'Auto';
			};
		};
	};
	//================================ SELF HEAL

	if (_uiTime > (_unit getVariable ['QS_AI_UNIT_lastSelfHeal',-1])) then {
		_unit setVariable ['QS_AI_UNIT_lastSelfHeal',(_uiTime + (random [30,60,90])),FALSE];
		if (
			(isNull _objectParent) &&
			{(
				(isNull _attackTarget) ||
				{_unitReady} ||
				{weaponLowered _unit}
			)} &&
			{(
				((damage _unit) isNotEqualTo 0) ||
				{((((getAllHitPointsDamage _unit) # 2) findIf {(_x isNotEqualTo 0)}) isNotEqualTo -1)}
			)}
		) then {
			_unit action ['HealSoldierSelf',_unit];
			_unit setDamage [0,FALSE];
		};
	};
	
	//================================ THROWABLES
	
	if (_aiPath) then {
		if (alive _attackTarget) then {
			if (
				((random 1) > 0.75) &&
				{(_unitBehaviour isNotEqualTo 'STEALTH')} &&
				{(_uiTime > (_unit getVariable ['QS_AI_UNIT_lastSmoke',-1]))} &&
				{(((alive _attackTarget) && ((_unit distance2D _attackTarget) < 100)) || {(_suppression > 0)})}
			) then {
				QS_AI_managed_smoke = QS_AI_managed_smoke select {(serverTime < _x)};
				if ((count QS_AI_managed_smoke) < QS_AI_managed_smoke_max) then {
					QS_AI_managed_smoke pushBack (serverTime + 45);
					_unit setVariable ['QS_AI_UNIT_lastSmoke',(_uiTime + (random [15,30,45])),FALSE];
					[_unit,_attackTarget,'SMOKE',TRUE] call (missionNamespace getVariable 'QS_fnc_AIXThrow');
				};
			};
			private _fragAttempted = FALSE;
			if (
				((random 1) > 0.75) &&
				{(_uiTime > (_unit getVariable ['QS_AI_UNIT_lastFrag',-1]))} &&
				{((_unit distance2D _attackTarget) < 65)}
			) then {
				QS_AI_managed_frags = QS_AI_managed_frags select {(serverTime < _x)};
				if ((count QS_AI_managed_frags) < QS_AI_managed_frags_max) then {
					QS_AI_managed_frags pushBack (serverTime + 15);
					_fragAttempted = TRUE;
					_unit setVariable ['QS_AI_UNIT_lastFrag',(_uiTime + (random [15,45,65])),FALSE];
					[_unit,_attackTarget,'FRAG',TRUE] call (missionNamespace getVariable 'QS_fnc_AIXThrow');
				};
			};
		};
	};
	
	//================================== VEHICLE DEMOLITION
	
	if (_fps > 10) then {
		if (_aiPath) then {
			if ((random 1) > 0.75) then {
				if (_uiTime > (_unit getVariable ['QS_AI_UNIT_LastGesture',-1])) then {
					_unit setVariable ['QS_AI_UNIT_LastGesture',(_uiTime + (random ([[5,10,15],[20,40,60]] select (_unitMorale < 0)))),FALSE];
					if (_unit checkAIFeature 'PATH') then {
						if ((count (missionNamespace getVariable 'QS_AI_unitsGestureReady')) < ([5,10] select (_fps > 15))) then {
							_unit setVariable ['QS_AI_UNIT_gestureEvent',TRUE,FALSE];
							_unit addEventHandler ['Hit',{call (missionNamespace getVariable 'QS_fnc_AIXHitEvade')}];
							(missionNamespace getVariable 'QS_AI_unitsGestureReady') pushBack _unit;
						};
					};
				};
			};
			if ((_unit getUnitTrait 'explosiveSpecialist') || {(_unit getUnitTrait 'engineer')}) then {
				if ((random 1) > 0.5) then {
					if (!(_unit getVariable ['QS_AI_JOB',FALSE])) then {
						if (_uiTime > (_unit getVariable ['QS_AI_UNIT_lastExpEval',-1])) then {
							_unit setVariable ['QS_AI_UNIT_lastExpEval',(serverTime + (random [30,45,60])),FALSE];
							if ((count (missionNamespace getVariable 'QS_AI_scripts_Assault')) < 3) then {
								private _targetFound = FALSE;
								_assignedTarget = assignedTarget _unit;
								if (alive _assignedTarget) then {
									_assignedTargetVehicle = vehicle _assignedTarget;
									if (
										(_assignedTargetVehicle isKindOf 'AllVehicles') &&
										{(!(_assignedTargetVehicle isKindOf 'CAManBase'))} &&
										{(isTouchingGround _assignedTargetVehicle)} &&
										{((_unit distance2D _assignedTargetVehicle) < 150)}
									) then {
										_targetFound = TRUE;
										_QS_script = [_unit,_assignedTargetVehicle,300,(selectRandomWeighted ['explosive charge',0.666,'satchel',0.333]),6,FALSE,TRUE] spawn (missionNamespace getVariable 'QS_fnc_AIXSetMine');
										_unit setVariable ['QS_AI_JOB',TRUE,FALSE];
										_unit setVariable ['QS_AI_UNIT_script',_QS_script,FALSE];
										missionNamespace setVariable ['QS_AI_scripts_Assault',((missionNamespace getVariable 'QS_AI_scripts_Assault') + [serverTime + 300]),QS_system_AI_owners];
									};
								} else {
									_unitPos = getPosATL _unit;
									_nearVehicles = [6,EAST,_unitPos,350] call (missionNamespace getVariable 'QS_fnc_AIGetKnownEnemies');
									if (_nearVehicles isNotEqualTo []) then {
										private _nearVPos = 99999;
										private _nearV = objNull;
										{
											if ((_x distance2D _unitPos) < _nearVPos) then {
												_nearVPos = _x distance2D _unitPos;
												_nearV = _x;
											};
										} forEach _nearVehicles;
										_unit doTarget _nearV;
										_targetFound = TRUE;
										_QS_script = [_unit,_nearV,300,(selectRandomWeighted ['explosive charge',0.666,'satchel',0.333]),6,FALSE,TRUE] spawn (missionNamespace getVariable 'QS_fnc_AIXSetMine');
										_unit setVariable ['QS_AI_JOB',TRUE,FALSE];
										_unit setVariable ['QS_AI_UNIT_script',_QS_script,FALSE];
										missionNamespace setVariable ['QS_AI_scripts_Assault',((missionNamespace getVariable 'QS_AI_scripts_Assault') + [serverTime + 300]),QS_system_AI_owners];
									};
								};
								if (!(_targetFound)) then {
									if ((_grp getVariable ['QS_AI_GRP_nearTargets',[]]) isNotEqualTo []) then {
										_targets = (_grp getVariable 'QS_AI_GRP_nearTargets') # 0;
										private _targetFound = FALSE;
										if (_targets isNotEqualTo []) then {
											{
												if (alive _x) then {
													if (_x isKindOf 'AllVehicles') then {
														if (!(_x isKindOf 'CAManBase')) then {
															if (isTouchingGround _x) then {
																if ((_x distance2D _unit) < 150) then {
																	_targetFound = TRUE;
																	_QS_script = [_unit,_x,300,(selectRandomWeighted ['explosive charge',0.666,'satchel',0.333]),6,FALSE,TRUE] spawn (missionNamespace getVariable 'QS_fnc_AIXSetMine');
																	_unit setVariable ['QS_AI_JOB',TRUE,FALSE];
																	_unit setVariable ['QS_AI_UNIT_script',_QS_script,FALSE];
																	missionNamespace setVariable ['QS_AI_scripts_Assault',((missionNamespace getVariable 'QS_AI_scripts_Assault') + [serverTime + 300]),QS_system_AI_owners];
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
									if (_targets isNotEqualTo []) then {
										_targetFound = TRUE;
										_target = selectRandom _targets;
										_QS_script = [_unit,_target,300,(selectRandomWeighted ['explosive charge',0.666,'satchel',0.333]),6,FALSE,TRUE] spawn (missionNamespace getVariable 'QS_fnc_AIXSetMine');
										_unit setVariable ['QS_AI_JOB',TRUE,FALSE];
										_unit setVariable ['QS_AI_UNIT_script',_QS_script,FALSE];
										missionNamespace setVariable ['QS_AI_scripts_Assault',((missionNamespace getVariable 'QS_AI_scripts_Assault') + [serverTime + 300]),QS_system_AI_owners];
									};
								};
							};
						};
					};
				};
			};
		};
	};
	//================================== Vehicle Repair
	if (_aiPath) then {
		if (_unit getUnitTrait 'engineer') then {
			if ((count (missionNamespace getVariable 'QS_AI_scripts_support')) < 2) then {
				if (_grp isNil 'QS_AI_engineer_vehicles') then {
					_grp setVariable ['QS_AI_engineer_vehicles',[],FALSE];
				};
				_grp setVariable ['QS_AI_engineer_vehicles',((_grp getVariable 'QS_AI_engineer_vehicles') select {(alive _x)}),FALSE];
				if ((count (_grp getVariable ['QS_AI_engineer_vehicles',[]])) < 2) then {
					private _vehicle = objNull;
					private _QS_script = scriptNull;
					{
						_vehicle = _x;
						if (alive _vehicle) then {
							if (_vehicle isNotEqualTo (_unit getVariable ['QS_AI_UNIT_assignedVehicle',objNull])) then {
								if (!(_vehicle in (_grp getVariable ['QS_AI_engineer_vehicles',[]]))) then {
									if (!canMove _vehicle) then {
										if ((_vehicle distance2D _unit) < 500) then {
											_grp setVariable ['QS_AI_engineer_vehicles',((_grp getVariable 'QS_AI_engineer_vehicles') + [_vehicle]),FALSE];
											_grp addVehicle _vehicle;
											_QS_script = [_unit,_vehicle,300,7,TRUE] spawn (missionNamespace getVariable 'QS_fnc_AIXRepairVehicle');
											_unit setVariable ['QS_AI_UNIT_script',_QS_script,FALSE];
											missionNamespace setVariable ['QS_AI_scripts_support',((missionNamespace getVariable 'QS_AI_scripts_support') + [serverTime + 300]),QS_system_AI_owners];
										};
									};
								} else {
									if (canMove _vehicle) then {
										_grp setVariable ['QS_AI_engineer_vehicles',((_grp getVariable 'QS_AI_engineer_vehicles') - [_vehicle]),FALSE];
										if ((alive (_unit getVariable ['QS_AI_UNIT_assignedVehicle',objNull])) || {(!('VEHICLE' in (_grp getVariable ['QS_AI_GRP_CONFIG',[]])))}) then {
											_grp leaveVehicle _vehicle;
										};
									};
								};
							};
						};
					} forEach (missionNamespace getVariable 'QS_AI_vehicles');
				} else {
					_grp setVariable ['QS_AI_engineer_vehicles',((_grp getVariable 'QS_AI_engineer_vehicles') select {(!canMove _x)}),FALSE];
				};
			};
		};
	};
};
//======================================================================= SUPPRESSIVE FIRE (UNIT)
if (_fps > 10) then {
	private _isSuppressing = _currentCommand isEqualTo 'Suppress';
	if (
		(!_isSuppressing) &&
		{(isNull _objectParent)} &&
		{((random 1) > 0.666)} &&
		{((_unit getVariable ['QS_AI_UNIT_isMG',FALSE]) || (_unit getVariable ['QS_AI_UNIT_isGL',FALSE]) || (((_unit getVariable ['QS_AI_UNIT_rv',[-1,-1,-1]]) # 0) > 0.85))} &&
		{(_uiTime > (_unit getVariable ['QS_AI_UNIT_lastSuppressiveFire',-1]))} &&
		{(_unitBehaviour in ['AWARE','COMBAT'])}
	) then {
		if (alive _attackTarget) then {
			private _attackTarget = vehicle _attackTarget;
			if (([_unit,'FIRE',_attackTarget] checkVisibility [(eyePos _unit),(aimPos _attackTarget)]) > 0) then {
				_isSuppressing = [_unit,_attackTarget,1,TRUE,TRUE,FALSE,-1] call (missionNamespace getVariable 'QS_fnc_AIDoSuppressiveFire');
			} else {
				_isSuppressing = [
					_unit,
					((_unit targetKnowledge _attackTarget) # 6),
					1,
					FALSE,
					FALSE,
					FALSE,
					-1
				] call (missionNamespace getVariable 'QS_fnc_AIDoSuppressiveFire');
			};
			if (((_unit getEventHandlerInfo ['FiredMan',0]) # 2) isNotEqualTo 0) then {
				_unit removeAllEventHandlers 'FiredMan';
			};
			_unit setVariable ['QS_AI_UNIT_lastSuppressiveFire',(serverTime + (random [10,15,20])),FALSE];
		};
		_hostileBuildings = missionNamespace getVariable ['QS_AI_hostileBuildings',[]];
		if (_hostileBuildings isNotEqualTo []) then {
			private _hostileBuilding = objNull;
			{
				if (([_objectParent,'VIEW',_x] checkVisibility [(eyePos _objectParent),(aimPos _x)]) > 0.1) exitWith {
					_hostileBuilding = _x;
				};
			} forEach _hostileBuildings;
			if (!isNull _hostileBuilding) then {
				if (((_unit getEventHandlerInfo ['FiredMan',0]) # 2) isNotEqualTo 0) then {
					_unit removeAllEventHandlers 'FiredMan';
				};
				_unit setVariable ['QS_AI_UNIT_lastSuppressiveFire',(serverTime + (random [10,15,20])),FALSE];
				_isSuppressing = [_unit,_hostileBuilding,selectRandomWeighted [1,0.5,2,0.5],TRUE,FALSE,FALSE,-1] call (missionNamespace getVariable 'QS_fnc_AIDoSuppressiveFire');
			};
		};
	};
	
	//======================================= SUPPRESSIVE FIRE (VEHICLE)

	if (
		(alive _objectParent) &&
		{(!(_isSuppressing))} &&
		{(!((_objectParent unitTurret _unit) in [[],[-1]]))} &&
		{((['Air','StaticMortar','O_APC_Tracked_02_AA_F','O_T_APC_Tracked_02_AA_ghex_F'] findIf { _objectParent isKindOf _x }) isEqualTo -1)} &&
		{(!((toLowerANSI (currentMuzzle _unit)) in ['','fakehorn','laserdesignator_vehicle']))} &&
		{(!(_unit getVariable ['QS_AI_disableSuppFire',FALSE]))}
	) then {
		if (_uiTime > (_unit getVariable ['QS_AI_UNIT_lastSuppressiveFire',-1])) then {
			if ((random 1) > 0.666) then {
				if (_unitBehaviour in ['AWARE','COMBAT']) then {
					
					//=================================== Suppress target
					if (alive _attackTarget) then {
						private _attackTarget = vehicle _attackTarget;
						if (!(_attackTarget isKindOf 'Air')) then {
							if ((_attackTarget distance2D _unit) < 500) then {
								if (((_unit getEventHandlerInfo ['FiredMan',0]) # 2) isNotEqualTo 0) then {
									_unit removeAllEventHandlers 'FiredMan';
								};
								_unit setVariable ['QS_AI_UNIT_lastSuppressiveFire',(serverTime + (random [10,15,20])),FALSE];
								if (([_unit,'FIRE',_attackTarget] checkVisibility [[_objectParent,0] call (missionNamespace getVariable 'QS_fnc_getVehicleGunEnd'),(aimPos _attackTarget)]) > 0) then {
									_isSuppressing = [_unit,_attackTarget,selectRandomWeighted [1,0.5,2,0.5],TRUE,FALSE,FALSE,-1] call (missionNamespace getVariable 'QS_fnc_AIDoSuppressiveFire');
								} else {
									_isSuppressing = [_unit,((_unit targetKnowledge _attackTarget) # 6),selectRandomWeighted [1,0.5,2,0.5],FALSE,FALSE,FALSE,-1] call (missionNamespace getVariable 'QS_fnc_AIDoSuppressiveFire');
								};
							};
						};
					};

					//==================================== Suppress Building
					if (!(_isSuppressing)) then {
						_hostileBuildings = missionNamespace getVariable ['QS_AI_hostileBuildings',[]];
						if (_hostileBuildings isNotEqualTo []) then {
							private _hostileBuilding = objNull;
							{
								if ((_objectParent distance2D _x) < 500) then {
									_hostileBuilding = _x;
								};
							} forEach _hostileBuildings;
							if (!isNull _hostileBuilding) then {
								if (!(terrainIntersectASL [[_objectParent,0] call (missionNamespace getVariable 'QS_fnc_getVehicleGunEnd'),aimPos _hostileBuilding])) then {
									if (((_unit getEventHandlerInfo ['FiredMan',0]) # 2) isNotEqualTo 0) then {
										_unit removeAllEventHandlers 'FiredMan';
									};
									_unit setVariable ['QS_AI_UNIT_lastSuppressiveFire',(serverTime + (random [10,15,20])),FALSE];
									_isSuppressing = [_unit,_hostileBuilding,selectRandomWeighted [1,0.5,2,0.5],TRUE,FALSE,FALSE,-1] call (missionNamespace getVariable 'QS_fnc_AIDoSuppressiveFire');
								};
							};
						};
					};
					
					//==================================== Direct Fire Support

					if (!(_isSuppressing)) then {
						private _smokeTargets = (missionNamespace getVariable ['QS_AI_smokeTargets',[]]) select {!isNull _x};
						if (_smokeTargets isNotEqualTo []) then {
							_smokeTargets = _smokeTargets inAreaArray [_unit,1000,1000,0,FALSE];
							if (_smokeTargets isNotEqualTo []) then {
								_smokeTargets = _smokeTargets apply {
									[
										(
											[
												_objectParent,
												'VIEW',			// 'FIRE'
												objNull
											] checkVisibility [
												[_objectParent,0] call (missionNamespace getVariable 'QS_fnc_getVehicleGunEnd'),
												(getPosASL _x) vectorAdd [0,0,1]
											]
										),
										_x,
										getPosASL _x
									]
								};
								_smokeTargets = _smokeTargets select {((_x # 0) > 0) && ((_x # 2) isNotEqualTo [0,0,0])};
								if (_smokeTargets isNotEqualTo []) then {
									_smokeTargets sort FALSE;
									_attackTarget = ((_smokeTargets # 0) # 2) vectorAdd [-5 + (random 10),-5 + (random 10),2 + (random 2)];
									_isSuppressing = [_unit,_attackTarget,selectRandomWeighted [1,0.5,2,0.5],TRUE,FALSE,FALSE,-1] call (missionNamespace getVariable 'QS_fnc_AIDoSuppressiveFire');
								};
							};
						};
					};
					if (
						(!(_isSuppressing)) &&
						{((random 1) > 0.666)}
					) then {
						private _targets = _unit targets [TRUE, 1000];
						if (_targets isNotEqualTo []) then {
							_isSuppressing = [_unit,selectRandom _targets,selectRandomWeighted [1,0.5,2,0.5],FALSE,FALSE,FALSE,-1] call (missionNamespace getVariable 'QS_fnc_AIDoSuppressiveFire');
						};
					};
				};
			};
		};
	};
	if (
		(!(_isSuppressing)) &&
		{((random 1) > 0.666)} &&
		{(_unitBehaviour isNotEqualTo 'STEALTH')} &&
		{((_unit getVariable ['QS_AI_UNIT_isMG',FALSE]) || (_unit getVariable ['QS_AI_UNIT_isGL',FALSE]) || (((_unit getVariable ['QS_AI_UNIT_rv',[-1,-1,-1]]) # 0) > 0.85))} &&
		{(((_unit getEventHandlerInfo ['FiredMan',0]) # 2) isEqualTo 0)} &&
		{(_uiTime > (_unit getVariable ['QS_AI_UNIT_lastSuppressiveFire',-1]))}
	) then {
		_unit addEventHandler ['FiredMan',{call (missionNamespace getVariable 'QS_fnc_AIXSuppressiveFire')}];
	};
};
if (isNull _objectParent) then {
	// SELF RE-ARM
	if (_uiTime > (_unit getVariable ['QS_AI_UNIT_nextSelfRearm',0])) then {
		_unit setVariable ['QS_AI_UNIT_nextSelfRearm',(_uiTime + (random [240,300,360])),FALSE];
		if ((primaryWeapon _unit) isNotEqualTo '') then {
			if ((_unit ammo (primaryWeapon _unit)) isEqualTo 0) then {
					private _baseWeapon = toLowerANSI ([(primaryWeapon _unit)] call (missionNamespace getVariable 'QS_fnc_baseWeapon'));
					private _magIndex = (missionNamespace getVariable 'QS_AI_weaponMagazines') findIf {((_x # 0) isEqualTo _baseWeapon)};
					private _cfgMagazines = [];
					if (_magIndex isEqualTo -1) then {
						_cfgMagazines = QS_hashmap_configfile getOrDefaultCall [
							format ['cfgweapons_%1_magazines',_baseWeapon],
							{(getArray (configFile >> 'CfgWeapons' >> _baseWeapon >> 'magazines')) apply {toLowerANSI _x}},
							TRUE
						];
						(missionNamespace getVariable 'QS_AI_weaponMagazines') pushBack [_baseWeapon,_cfgMagazines];
					} else {
						_cfgMagazines = ((missionNamespace getVariable 'QS_AI_weaponMagazines') # _magIndex) # 1;
					};
					if (_cfgMagazines isNotEqualTo []) then {
						_cfgMagazines = _cfgMagazines apply {(toLowerANSI _x)};
						private _magazines = (magazines _unit) select {((toLowerANSI _x) in _cfgMagazines)};
						if (_magazines isEqualTo []) then {
							for '_i' from 0 to 5 step 1 do {
								_unit addMagazine (_cfgMagazines # 0);
							};
							_unit addPrimaryWeaponItem (_cfgMagazines # 0);
							_unit selectWeapon (primaryWeapon _unit);
							_unit setVariable ['QS_AI_tracersAdded',FALSE,FALSE];
						};
					};
			};
		};
		if ((secondaryWeapon _unit) isNotEqualTo '') then {
			if ((_unit ammo (secondaryWeapon _unit)) isEqualTo 0) then {
				private _baseWeapon = toLowerANSI ([(secondaryWeapon _unit)] call (missionNamespace getVariable 'QS_fnc_baseWeapon'));
				private _magIndex = (missionNamespace getVariable 'QS_AI_weaponMagazines') findIf {((_x # 0) isEqualTo _baseWeapon)};
				private _cfgMagazines = [];
				if (_magIndex isEqualTo -1) then {
					_cfgMagazines = QS_hashmap_configfile getOrDefaultCall [
						format ['cfgweapons_%1_magazines',_baseWeapon],
						{(getArray (configFile >> 'CfgWeapons' >> _baseWeapon >> 'magazines')) apply {toLowerANSI _x}},
						TRUE
					];
					(missionNamespace getVariable 'QS_AI_weaponMagazines') pushBack [_baseWeapon,_cfgMagazines];
				} else {
					_cfgMagazines = ((missionNamespace getVariable 'QS_AI_weaponMagazines') # _magIndex) # 1;
				};
				if (_cfgMagazines isNotEqualTo []) then {
					_cfgMagazines = _cfgMagazines apply {(toLowerANSI _x)};
					private _magazines = (magazines _unit) select {((toLowerANSI _x) in _cfgMagazines)};
					if (_magazines isEqualTo []) then {
						for '_i' from 0 to 2 step 1 do {
							_unit addMagazine (_cfgMagazines # 0);
						};
						_unit addSecondaryWeaponItem (_cfgMagazines # 0);
						_unit selectWeapon (primaryWeapon _unit);
					};
				};
				if ((_playercount < 20) || ((random 1) > 0.5)) then {
					if ((random 1) > 0.25) then {
						[_unit,_grp] call (missionNamespace getVariable 'QS_fnc_AISetRockets');
					};
				};
			};
		};
	};
};
if (
	(_fps >= 15) &&
	{((random 1) > 0.666)} &&
	{(isNull _objectParent)} &&
	{(!_isLeader)} &&
	{(_aiPath)} &&
	{(_currentCommand in ['ATTACK','ATTACKFIRE'])} &&
	{((alive _attackTarget) && {((_unit distance2D _attackTarget) < 50)})}
) then {
	_inHouse = [_attackTarget,getPosWorld _attackTarget] call (missionNamespace getVariable 'QS_fnc_inHouse');
	private _buildingPositions = (_inHouse # 1) buildingPos -1;
	if (
		(_inHouse # 0) &&
		{(_buildingPositions isNotEqualTo [])}
	) then {
		doStop _unit;
		private _dist = 100;
		private _buildingPos = selectRandom _buildingPositions;
		{
			if ((_attackTarget distance _x) < _dist) then {
				_buildingPos = _x;
				_dist = _attackTarget distance _x;
			};
		} forEach _buildingPositions;
		if (_dist < 100) then {
			_unit doMove _buildingPos;
		};
	};
};
if (_isLeader) then {
	if (
		_aiPath &&
		{(isNull _objectParent)} &&
		{((stance _unit) isNotEqualTo 'PRONE')} &&
		{(!(_unit getVariable ['QS_AI_UNIT_regroup_disable',FALSE]))} &&
		{(_uiTime > (_unit getVariable ['QS_AI_UNIT_lastRegroup',-1]))}
	) then {
		_unit setVariable ['QS_AI_UNIT_lastRegroup',(_uiTime + (random [30,60,90])),FALSE];
		if (({(alive _x)} count (units _grp)) isEqualTo 1) then {
			[_unit,300] call (missionNamespace getVariable 'QS_fnc_AIFindNearestRegroup');
		};
	};
	if ((combatMode _grp) in ['YELLOW','RED']) then {
		if ((_unit getSlotItemName 611) isNotEqualTo '') then {
			if (_uiTime > (_unit getVariable 'QS_AI_UNIT_lastSupportRequest')) then {
				_unit setVariable ['QS_AI_UNIT_lastSupportRequest',(serverTime + (120 + (random 120))),FALSE];
				private _target = _attackTarget;
				if (!alive _target) then {
					_allTargets = _unit targets [TRUE,600];
					if (_allTargets isNotEqualTo []) then {
						_time = time;
						private _filteredTargets = _allTargets select {(((_time - ((_unit targetKnowledge _x) # 2)) < 30) && (isTouchingGround _x) && ((lifeState _x) in ['HEALTHY','INJURED']))};
						if (_filteredTargets isNotEqualTo []) then {
							if ((count _filteredTargets) isEqualTo 1) then {
								_target = _filteredTargets # 0;
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
									} count _filteredTargets;
								};
							};
						};
					};
				};
				if (
					(alive _target) && 
					(isTouchingGround _target)
				) then {
					if ((count (missionNamespace getVariable 'QS_AI_scripts_fireMissions')) <= 3) then {
						private _exit = FALSE;
						private _supportProviders = [];
						private _supportProvider = objNull;
						private _targetPos = [0,0,0];
						private _smokePos = [0,0,0];
						if ((missionNamespace getVariable 'QS_AI_supportProviders_ARTY') isNotEqualTo []) then {
							_supportProviders = missionNamespace getVariable 'QS_AI_supportProviders_ARTY';
							{
								_supportProvider = _x;
								if (!isNull _supportProvider) then {
									if (alive _supportProvider) then {
										if ((vehicle _supportProvider) isKindOf 'LandVehicle') then {
											_supportGroup = group _supportProvider;
											if ((_supportGroup getVariable 'QS_AI_GRP_DATA') # 0) then {
												if (_supportGroup isNil 'QS_AI_GRP_fireMission') then {
													if (_supportGroup isNil 'QS_AI_GRP_MTR_cooldown') then {
														if (((_unit targetKnowledge _target) # 6) inRangeOfArtillery [[_supportProvider],((magazines (vehicle _supportProvider)) # 0)]) then {
															_unit playActionNow 'HandSignalRadio';
															if (missionNamespace getVariable ['QS_virtualSectors_active',FALSE]) then {
																if (missionNamespace getVariable ['QS_virtualSectors_sub_1_active',FALSE]) then {
																	EAST reportRemoteTarget [_target,60];
																};
															};
															_smokePos = ((_unit targetKnowledge _target) # 6) getPos [(random 10),(random 360)];
															_smokeShell = createVehicle ['SmokeShellRed',_smokePos,[],0,'NONE'];
															_smokeShell setPosWorld ((getPosWorld _smokeShell) vectorAdd [0,0,(75 + (random 50))]);
															missionNamespace setVariable ['QS_AI_smokeTargets',((missionNamespace getVariable ['QS_AI_smokeTargets',[]]) + [_smokeShell]),QS_system_AI_owners];
															(missionNamespace getVariable 'QS_garbageCollector') pushBack [_smokeShell,'DELAYED_FORCED',(time + 120)];
															_targetPos = ((_unit targetKnowledge _target) # 6) getPos [(random 25),(random 360)];
															_targetPos set [2,0];
															_supportGroup setVariable ['QS_AI_GRP_fireMission',[_targetPos,((magazines (vehicle _supportProvider)) # 0),(round (2 + (random 2))),(serverTime + 180)],QS_system_AI_owners];
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
						if ((missionNamespace getVariable 'QS_AI_supportProviders_MTR') isNotEqualTo []) then {
							_supportProviders = missionNamespace getVariable 'QS_AI_supportProviders_MTR';
							{
								_supportProvider = _x;
								if (!isNull _supportProvider) then {
									if (alive _supportProvider) then {
										if ((vehicle _supportProvider) isKindOf 'StaticMortar') then {
											_supportGroup = group _supportProvider;
											if ((_supportGroup getVariable 'QS_AI_GRP_DATA') # 0) then {
												if (_supportGroup isNil 'QS_AI_GRP_fireMission') then {
													if (_supportGroup isNil 'QS_AI_GRP_MTR_cooldown') then {
														if (((_unit targetKnowledge _target) # 6) inRangeOfArtillery [[_supportProvider],((magazines (vehicle _supportProvider)) # 0)]) then {
															_unit playActionNow 'HandSignalRadio';
															if (missionNamespace getVariable ['QS_virtualSectors_active',FALSE]) then {
																if (missionNamespace getVariable ['QS_virtualSectors_sub_1_active',FALSE]) then {
																	EAST reportRemoteTarget [_target,60];
																};
															};
															_smokePos = ((_unit targetKnowledge _target) # 6) getPos [(random 10),(random 360)];
															_smokeShell = createVehicle ['SmokeShellRed',_smokePos,[],0,'NONE'];
															_smokeShell setPosWorld ((getPosWorld _smokeShell) vectorAdd [0,0,(75 + (random 50))]);
															missionNamespace setVariable ['QS_AI_smokeTargets',((missionNamespace getVariable ['QS_AI_smokeTargets',[]]) + [_smokeShell]),QS_system_AI_owners];
															(missionNamespace getVariable 'QS_garbageCollector') pushBack [_smokeShell,'DELAYED_FORCED',(time + 120)];
															_targetPos = ((_unit targetKnowledge _target) # 6) getPos [(random 25),(random 360)];
															_targetPos set [2,0];
															_supportGroup setVariable ['QS_AI_GRP_fireMission',[_targetPos,((magazines (vehicle _supportProvider)) # 0),(round (2 + (random 2))),(serverTime + 180)],QS_system_AI_owners];
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
						if ((missionNamespace getVariable 'QS_AI_supportProviders_CASHELI') isNotEqualTo []) then {
							_supportProviders = missionNamespace getVariable 'QS_AI_supportProviders_CASHELI';
							{
								_supportProvider = _x;
								if (!isNull _supportProvider) then {
									if (alive _supportProvider) then {
										if ((vehicle _supportProvider) isKindOf 'Helicopter') then {
											if (((vehicle _supportProvider) distance2D _target) < 3000) then {
												_supportGroup = group _supportProvider;
												if (_supportGroup isNil 'QS_AI_GRP_fireMission') then {
													_unit playActionNow 'HandSignalRadio';
													_exit = TRUE;
													_supportGroup setVariable ['QS_AI_GRP_fireMission',[_target,(serverTime + 240)],QS_system_AI_owners];
													_smokePos = ((_unit targetKnowledge _target) # 6) getPos [(random 10),(random 360)];
													_smokeShell = createVehicle ['SmokeShellRed',_smokePos,[],0,'NONE'];
													_smokeShell setPosWorld ((getPosWorld _smokeShell) vectorAdd [0,0,(75 + (random 50))]);
													missionNamespace setVariable ['QS_AI_smokeTargets',((missionNamespace getVariable ['QS_AI_smokeTargets',[]]) + [_smokeShell]),QS_system_AI_owners];
													(missionNamespace getVariable 'QS_garbageCollector') pushBack [_smokeShell,'DELAYED_FORCED',(time + 120)];
													if (isDedicated) then {
														_handle = [1,_supportProvider,_supportGroup,_target,(position _target),_smokePos,(serverTime + 240)] spawn (missionNamespace getVariable 'QS_fnc_AIFireMission');
														missionNamespace setVariable ['QS_AI_scripts_fireMissions',((missionNamespace getVariable 'QS_AI_scripts_fireMissions') + [serverTime + 240]),QS_system_AI_owners];
													} else {
														[99,[1,_supportProvider,_supportGroup,_target,(position _target),_smokePos,(serverTime + 240)],(serverTime + 240)] remoteExec ['QS_fnc_remoteExec',2,FALSE];
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
						if ((missionNamespace getVariable 'QS_AI_supportProviders_CASPLANE') isNotEqualTo []) then {
							_supportProviders = missionNamespace getVariable 'QS_AI_supportProviders_CASPLANE';
							private _laserPos = [0,0,0];
							{
								_supportProvider = _x;
								if (!isNull _supportProvider) then {
									if (alive _supportProvider) then {
										if ((vehicle _supportProvider) isKindOf 'Plane') then {
											_supportGroup = group _supportProvider;
											if (_supportGroup isNil 'QS_AI_GRP_fireMission') then {
												_unit playActionNow 'HandSignalRadio';
												_exit = TRUE;
												_supportGroup setVariable ['QS_AI_GRP_fireMission',[_target,(serverTime + 180)],QS_system_AI_owners];
												_laserPos = (_unit targetKnowledge _target) # 6;
												_laserPos set [2,1];
												_smokePos = ((_unit targetKnowledge _target) # 6) getPos [(random 10),(random 360)];
												_smokeShell = createVehicle ['SmokeShellRed',_smokePos,[],0,'NONE'];
												_smokeShell setPosWorld ((getPosWorld _smokeShell) vectorAdd [0,0,(75 + (random 50))]);
												missionNamespace setVariable ['QS_AI_smokeTargets',((missionNamespace getVariable ['QS_AI_smokeTargets',[]]) + [_smokeShell]),QS_system_AI_owners];
												(missionNamespace getVariable 'QS_garbageCollector') pushBack [_smokeShell,'DELAYED_FORCED',(time + 120)];
												if (isDedicated) then {
													_handle = [2,_supportProvider,_supportGroup,_target,(position _target),(serverTime + 120)] spawn (missionNamespace getVariable 'QS_fnc_AIFireMission');
													missionNamespace setVariable ['QS_AI_scripts_fireMissions',((missionNamespace getVariable 'QS_AI_scripts_fireMissions') + [serverTime + 120]),QS_system_AI_owners];
												} else {
													[99,[2,_supportProvider,_supportGroup,_target,(position _target),(serverTime + 120)],(serverTime + 120)] remoteExec ['QS_fnc_remoteExec',2,FALSE];
												};
											};
										};
									};
								};
								if (_exit) exitWith {};
							} forEach _supportProviders;
						};
						if (_exit) exitWith {};
						if ((missionNamespace getVariable 'QS_AI_supportProviders_CASUAV') isNotEqualTo []) then {
							_supportProviders = missionNamespace getVariable 'QS_AI_supportProviders_CASUAV';
							private _laserPos = [0,0,0];
							{
								_supportProvider = _x;
								if (!isNull _supportProvider) then {
									if (alive _supportProvider) then {
										if (unitIsUav _supportProvider) then {
											_supportGroup = group _supportProvider;
											if (_supportGroup isNil 'QS_AI_GRP_fireMission') then {
												_unit playActionNow 'HandSignalRadio';
												_exit = TRUE;
												_supportGroup setVariable ['QS_AI_GRP_fireMission',[_target,(serverTime + 180)],QS_system_AI_owners];
												_laserPos = ((_unit targetKnowledge _target) # 6) getPos [(random 10),(random 360)];
												_laserPos set [2,1];
												_smokeShell = createVehicle ['SmokeShellRed',_laserPos,[],0,'NONE'];
												_smokeShell setPosWorld ((getPosWorld _smokeShell) vectorAdd [0,0,(75 + (random 50))]);
												missionNamespace setVariable ['QS_AI_smokeTargets',((missionNamespace getVariable ['QS_AI_smokeTargets',[]]) + [_smokeShell]),QS_system_AI_owners];
												_handle = [3,_supportProvider,_supportGroup,_target,(position _target),(serverTime + 120)] spawn (missionNamespace getVariable 'QS_fnc_AIFireMission');
												missionNamespace setVariable ['QS_AI_scripts_fireMissions',((missionNamespace getVariable 'QS_AI_scripts_fireMissions') + [serverTime + 120]),QS_system_AI_owners];
												if (isDedicated) then {
													_handle = [3,_supportProvider,_supportGroup,_target,(position _target),(serverTime + 120)] spawn (missionNamespace getVariable 'QS_fnc_AIFireMission');
													missionNamespace setVariable ['QS_AI_scripts_fireMissions',((missionNamespace getVariable 'QS_AI_scripts_fireMissions') + [serverTime + 120]),QS_system_AI_owners];
												} else {
													[99,[3,_supportProvider,_supportGroup,_target,(position _target),(serverTime + 120)],(serverTime + 120)] remoteExec ['QS_fnc_remoteExec',2,FALSE];
												};
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