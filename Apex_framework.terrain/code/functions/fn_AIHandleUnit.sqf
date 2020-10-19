/*/
File: fn_AIHandleUnit.sqf
Author: 

	Quiksilver

Last Modified:

	11/08/2019 A3 1.94 by Quiksilver

Description:

	Handle Unit AI
_______________________________________________________/*/

params ['_unit','_uiTime','_fps'];
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
			if (!(_grpUnits isEqualTo [])) then {
				_grpUnits = _grpUnits apply {[rankId _x,_x]};
				_grpUnits sort FALSE;
				_grp selectLeader ((_grpUnits # 0) # 1);
			};
		};
	};
};
if (!(_unit getVariable ['QS_AI_UNIT',FALSE])) then {
	_unit setVariable ['QS_AI_UNIT',TRUE,FALSE];
	_unit setVariable ['QS_AI_UNIT_rv',[(random 1),(random 1),(random 1)],FALSE];
	_unit setVariable ['QS_AI_UNIT_delayedInstructions',[],FALSE];
	if (isNil {_unit getVariable 'QS_AI_UNIT_nextSelfRearm'}) then {
		_unit setVariable ['QS_AI_UNIT_nextSelfRearm',(_uiTime + (random [180,300,420])),FALSE];
	};
	if (isNil {_unit getVariable 'QS_AI_UNIT_lastSelfHeal'}) then {
		_unit setVariable ['QS_AI_UNIT_lastSelfHeal',_uiTime,FALSE];
	};
	if (isNil {_unit getVariable 'QS_AI_UNIT_isMG'}) then {
		if (((getText (configFile >> 'CfgWeapons' >> (primaryWeapon _unit) >> 'cursor')) isEqualTo 'mg') || {((toLower (typeOf _unit)) in ['o_t_soldier_ar_f'])} || {((!isNull (objectParent _unit)) && (_unit isEqualTo (gunner (objectParent _unit))))}) then {
			if ((isNull (objectParent _unit)) || ((!isNull (objectParent _unit)) && {(!( ['_aa_',(typeOf (objectParent _unit)),FALSE] call (missionNamespace getVariable 'QS_fnc_inString') ))})) then {
				_unit setVariable ['QS_AI_UNIT_isMG',TRUE,FALSE];
			};
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
	if (_unit getUnitTrait 'engineer') then {
		if (isNil {_unit getVariable 'QS_AI_UNIT_assignedVehicle'}) then {
			_unit setVariable ['QS_AI_UNIT_assignedVehicle',(assignedVehicle _unit),FALSE];
		};
	};
	if (isNil {_unit getVariable 'QS_AI_UNIT_tankGunner'}) then {
		if ((objectParent _unit) isKindOf 'Tank') then {
			if (_unit isEqualTo (gunner (objectParent _unit))) then {
				_vehicle_weapons = (weapons (objectParent _unit)) apply {(toLower _x)};
				_whitelisted_weapons = ['cannon_125mm_advanced','cannon_125mm','cannon_120mm_long','cannon_20mm','cannon_120mm','autocannon_30mm','autocannon_30mm_ctws'];		// Lowercase
				if (!((_vehicle_weapons findIf {(_x in _whitelisted_weapons)}) isEqualTo -1)) then {
					_unit setVariable ['QS_AI_UNIT_tankGunner',TRUE,FALSE];
					_unit setVariable ['QS_AI_UNIT_gunnerMuzzle',(_whitelisted_weapons select {(_x in _vehicle_weapons)}),FALSE];
				} else {
					_unit setVariable ['QS_AI_UNIT_tankGunner',FALSE,FALSE];
				};
			} else {
				_unit setVariable ['QS_AI_UNIT_tankGunner',FALSE,FALSE];
			};
		} else {
			_unit setVariable ['QS_AI_UNIT_tankGunner',FALSE,FALSE];
		};
	};
};
private _grp = group _unit;
_isLeader = _unit isEqualTo (leader _grp);
if (_isLeader) then {
	if (isNil {_unit getVariable 'QS_AI_UNIT_lastSupportRequest'}) then {
		_unit setVariable ['QS_AI_UNIT_lastSupportRequest',-1,FALSE];
	};
	if (isNil {_unit getVariable 'QS_AI_UNIT_lastRegroup'}) then {
		_unit setVariable ['QS_AI_UNIT_lastRegroup',(_uiTime + (random [30,60,90])),FALSE];
	};
	if (!alive _unit) then {
		private _grpUnits = (units _grp) select {((lifeState _x) in ['HEALTHY','INJURED'])};
		if (!(_grpUnits isEqualTo [])) then {
			_grpUnits = _grpUnits apply {[rankId _x,_x]};
			_grpUnits sort FALSE;
			_grp selectLeader ((_grpUnits # 0) # 1);
		};
	};
};
_attackTarget = getAttackTarget _unit;
_objectParent = objectParent _unit;
_suppression = getSuppression _unit;
_unitReady = unitReady _unit;
_unitBehaviour = behaviour _unit;
_unitMorale = morale _unit;
_formationPos = formationPosition _unit;
_expectedDestination = expectedDestination _unit;
if (isNull _objectParent) then {
	_unitPos = unitPos _unit;
	if ((_suppression >= 0.2) || {(_unitMorale < 0)}) then {
		if (_uiTime > (_unit getVariable ['QS_AI_UNIT_lastStanceAdjust',-1])) then {
			_unit setVariable ['QS_AI_UNIT_lastStanceAdjust',(_uiTime + (random [20,40,60])),FALSE];
			if (!(_unitPos isEqualTo 'MIDDLE')) then {
				_unit setUnitPosWeak 'MIDDLE';
			};
		};
		if (_uiTime > (_unit getVariable ['QS_AI_UNIT_lastSmoke',-1])) then {
			_unit setVariable ['QS_AI_UNIT_lastSmoke',(_uiTime + (random [30,60,90])),FALSE];
			if (alive _attackTarget) then {
				if ((random 1) > 0.85) then {
					[_unit,_attackTarget,'SMOKE',((random 1) > 0.5)] call (missionNamespace getVariable 'QS_fnc_AIXThrow');
				};
			};
		};
	} else {
		if (_unitPos isEqualTo 'DOWN') then {
			_unit setUnitPos 'AUTO';
		};
	};
	if (_uiTime > (_unit getVariable ['QS_AI_UNIT_lastSelfHeal',-1])) then {
		_unit setVariable ['QS_AI_UNIT_lastSelfHeal',(_uiTime + (random [30,60,90])),FALSE];
		if ((!((damage _unit) isEqualTo 0)) || {(!((((getAllHitPointsDamage _unit) # 2) findIf {(!(_x isEqualTo 0))}) isEqualTo -1))}) then {
			if (isNull _objectParent) then {
				_weaponLowered = weaponLowered _unit;
				if ((isNull (getAttackTarget _unit)) || {(_unitReady)} || {(_weaponLowered)}) then {
					_unit action ['HealSoldierSelf',_unit];
					_unit setDamage [0,FALSE];
				};
			};
		};
	};
	if (alive _attackTarget) then {
		private _fragAttempted = FALSE;
		if (((_unit distance2D _attackTarget) < 60) && ((_unit distance2D _attackTarget) > 15)) then {
			if (_uiTime > (_unit getVariable ['QS_AI_UNIT_lastFrag',-1])) then {
				_unit setVariable ['QS_AI_UNIT_lastFrag',(_uiTime + (random [15,45,65])),FALSE];
				if ((random 1) > 0.85) then {
					_fragAttempted = TRUE;
					[_unit,_attackTarget,'FRAG',TRUE] call (missionNamespace getVariable 'QS_fnc_AIXThrow');
				};
			};
		};
		if (!(_fragAttempted)) then {
			if (((_unit getVariable ['QS_AI_UNIT_rv',[-1,-1,-1]]) # 0) > 0.5) then {
				if (!(_unit getVariable ['QS_unitGarrisoned',FALSE])) then {
					if ((_unit distance2D _attackTarget) < 30) then {
						_unit doMove [(((_unit targetKnowledge _attackTarget) # 6) # 0),(((_unit targetKnowledge _attackTarget) # 6) # 1),(((getPosATL _attackTarget) # 2) + 1)];
					};
				};
			};
		};
	};
	if (_fps > 10) then {
		if ((random 1) > 0.9) then {
			if (_uiTime > (_unit getVariable ['QS_AI_UNIT_LastGesture',-1])) then {
				_unit setVariable ['QS_AI_UNIT_LastGesture',(_uiTime + (random ([[5,10,15],[20,40,60]] select (_unitMorale < 0)))),FALSE];
				if ((count (missionNamespace getVariable 'QS_AI_unitsGestureReady')) < ([5,10] select (_fps > 15))) then {
					_unit setVariable ['QS_AI_UNIT_gestureEvent',TRUE,FALSE];
					_unit addEventHandler ['Hit',{_this call (missionNamespace getVariable 'QS_fnc_AIXHitEvade')}];
					(missionNamespace getVariable 'QS_AI_unitsGestureReady') pushBack _unit;
				};
			};
		};
	};
	if (_fps > 10) then {
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
												(missionNamespace getVariable 'QS_AI_scripts_Assault') pushBack ([_unit,_assignedTargetVehicle,300,(selectRandomWeighted ['explosive charge',0.666,'satchel',0.333]),6,FALSE,TRUE] spawn (missionNamespace getVariable 'QS_fnc_AIXSetMine'));
											};
										};
									};
								};
							};
							if (!(_targetFound)) then {
								if (!((_grp getVariable ['QS_AI_GRP_nearTargets',[]]) isEqualTo [])) then {
									_targets = (_grp getVariable 'QS_AI_GRP_nearTargets') # 0;
									private _targetFound = FALSE;
									if (!(_targets isEqualTo [])) then {
										{
											if (alive _x) then {
												if (_x isKindOf 'AllVehicles') then {
													if (!(_x isKindOf 'CAManBase')) then {
														if (isTouchingGround _x) then {
															if ((_x distance2D _unit) < 150) then {
																_targetFound = TRUE;
																_unit setVariable ['QS_AI_JOB',TRUE,FALSE];
																(missionNamespace getVariable 'QS_AI_scripts_Assault') pushBack ([_unit,_x,300,(selectRandomWeighted ['explosive charge',0.666,'satchel',0.333]),6,FALSE,TRUE] spawn (missionNamespace getVariable 'QS_fnc_AIXSetMine'));
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
									(missionNamespace getVariable 'QS_AI_scripts_Assault') pushBack ([_unit,_target,300,(selectRandomWeighted ['explosive charge',0.666,'satchel',0.333]),6,FALSE,TRUE] spawn (missionNamespace getVariable 'QS_fnc_AIXSetMine'));
								};
							};
						};
					};
				};
			};
		};
	};	
	if (_unit getUnitTrait 'engineer') then {
		if ((count (missionNamespace getVariable 'QS_AI_scripts_support')) < 1) then {
			if (isNil {_grp getVariable 'QS_AI_engineer_vehicles'}) then {
				_grp setVariable ['QS_AI_engineer_vehicles',[],FALSE];
			};
			_grp setVariable ['QS_AI_engineer_vehicles',((_grp getVariable 'QS_AI_engineer_vehicles') select {(alive _x)}),FALSE];
			if ((count (_grp getVariable ['QS_AI_engineer_vehicles',[]])) < 2) then {
				private _vehicle = objNull;
				private _QS_script = scriptNull;
				{
					_vehicle = _x;
					if (alive _vehicle) then {
						if (!(_vehicle isEqualTo (_unit getVariable ['QS_AI_UNIT_assignedVehicle',objNull]))) then {
							if (!(_vehicle in (_grp getVariable ['QS_AI_engineer_vehicles',[]]))) then {
								if (!canMove _vehicle) then {
									if ((_vehicle distance2D _unit) < 500) then {
										_grp setVariable ['QS_AI_engineer_vehicles',((_grp getVariable 'QS_AI_engineer_vehicles') + [_vehicle]),FALSE];
										_grp addVehicle _vehicle;
										_QS_script = [_unit,_vehicle,300,7,TRUE] spawn (missionNamespace getVariable 'QS_fnc_AIXRepairVehicle');
										(missionNamespace getVariable 'QS_AI_scripts_support') pushBack _QS_script;
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
if (_fps > 9) then {
	if (_unit getVariable ['QS_AI_UNIT_isMG',FALSE]) then {
		if ((random 1) > 0.666) then {
			if (_unitBehaviour in ['AWARE','COMBAT']) then {
				private _isSuppressing = FALSE;
				if (alive _attackTarget) then {
					private _attackTarget = vehicle _attackTarget;
					if (!(_attackTarget isKindOf 'Air')) then {
						if ((_attackTarget distance2D _unit) < 1000) then {
							if (([_unit,'FIRE',_attackTarget] checkVisibility [(eyePos _unit),(aimPos _attackTarget)]) > 0) then {
								_unit removeAllEventHandlers 'FiredMan';
								_unit setVariable ['QS_AI_UNIT_sfEvent',FALSE,FALSE];
								_unit setVariable ['QS_AI_UNIT_lastSuppressiveFire',(diag_tickTime + (random [10,15,20])),FALSE];
								_unit doWatch _attackTarget;
								_unit doTarget _attackTarget;
								[_unit,_attackTarget] spawn {uiSleep 1; (_this # 0) doSuppressiveFire (aimPos (_this # 1));};
								_isSuppressing = TRUE;
							} else {
								_unit suppressFor (random [10,15,20]);
							};
						} else {
							_unit suppressFor (random [10,15,20]);
						};
					} else {
						_unit suppressFor (random [10,15,20]);
					};
				} else {
					_unit suppressFor (random [10,15,20]);
				};
				if (!(_isSuppressing)) then {
					_hostileBuildings = missionNamespace getVariable ['QS_AI_hostileBuildings',[]];
					if (!(_hostileBuildings isEqualTo [])) then {
						private _hostileBuilding = objNull;
						{
							if (((_objectParent distance2D _x) < ([300,600] select ((_objectParent isKindOf 'Tank') || {(_objectParent isKindOf 'Wheeled_APC_F')}))) && {(([_objectParent,'FIRE',_x] checkVisibility [(_objectParent modelToWorldWorld [0,0,1]),(aimPos _x)]) > 0.1)}) exitWith {
								_hostileBuilding = _x;
							};
						} forEach _hostileBuildings;
						if (!isNull _hostileBuilding) then {
							_unit doWatch _hostileBuilding;
							if ((random 1) > 0.5) then {
								private _aimPos = aimPos _hostileBuilding;
								_intersections = lineIntersectsSurfaces [(_objectParent modelToWorldWorld [0,0,1]),(aimPos _hostileBuilding),_objectParent,objNull,TRUE,-1,'VIEW','FIRE',TRUE];
								if (!(_intersections isEqualTo [])) then {
									{
										if ((_x # 3) isEqualTo _hostileBuilding) exitWith {
											_aimPos = _x # 0;
										};
									} forEach _intersections;
									[_unit,_aimPos] spawn {uiSleep 1; (_this # 0) doSuppressiveFire (_this # 1);};
								};
							} else {
								[_unit,_hostileBuilding] spawn {uiSleep 1; (_this # 0) doSuppressiveFire (aimPos (_this # 1));};
							};
							_unit removeAllEventHandlers 'FiredMan';
							_unit setVariable ['QS_AI_UNIT_sfEvent',FALSE,FALSE];
							_unit setVariable ['QS_AI_UNIT_lastSuppressiveFire',(diag_tickTime + (random [10,15,20])),FALSE];
						};
					};
				};
			};
		};
		if (!(_unit getVariable ['QS_AI_UNIT_sfEvent',FALSE])) then {
			if (_uiTime > (_unit getVariable ['QS_AI_UNIT_lastSuppressiveFire',-1])) then {
				_unit setVariable ['QS_AI_UNIT_sfEvent',TRUE,FALSE];
				_unit addEventHandler ['FiredMan',{_this call (missionNamespace getVariable 'QS_fnc_AIXSuppressiveFire')}];
			};
		};
	};
	if (_unit getVariable ['QS_AI_UNIT_tankGunner',FALSE]) then {
		if (_uiTime > (_unit getVariable ['QS_AI_UNIT_lastSuppressiveFire',-1])) then {
			if ((random 1) > 0.666) then {
				if (_unitBehaviour in ['AWARE','COMBAT']) then {
					_hostileBuildings = missionNamespace getVariable ['QS_AI_hostileBuildings',[]];
					if (!(_hostileBuildings isEqualTo [])) then {
						private _hostileBuilding = objNull;
						{
							if (((_objectParent distance2D _x) < 600) && {(([_objectParent,'FIRE',_x] checkVisibility [(_objectParent modelToWorldWorld [0,0,1]),(aimPos _x)]) > 0.1)}) exitWith {
								_hostileBuilding = _x;
							};
						} forEach _hostileBuildings;
						if (!isNull _hostileBuilding) then {
							_unit doWatch _hostileBuilding;
							_unit doTarget _hostileBuilding;
							private _aimPos = aimPos _hostileBuilding;
							_intersections = lineIntersectsSurfaces [(_objectParent modelToWorldWorld [0,0,1]),(aimPos _hostileBuilding),_objectParent,objNull,TRUE,-1,'VIEW','FIRE',TRUE];
							if (!(_intersections isEqualTo [])) then {
								{
									if ((_x # 3) isEqualTo _hostileBuilding) exitWith {
										_aimPos = _x # 0;
									};
								} forEach _intersections;
								[_unit,_aimPos] spawn {
									params ['_unit','_aimPos'];
									uiSleep 3; 
									_unit doSuppressiveFire _aimPos;
								};
							};
							_unit setVariable ['QS_AI_UNIT_sfEvent',FALSE,FALSE];
							_unit setVariable ['QS_AI_UNIT_lastSuppressiveFire',(diag_tickTime + (random [30,60,90])),FALSE];
						};
					};
				};
			};
		};
	};
};
if (_grp getVariable ['BLDG_GARRISON',FALSE]) then {
	if (!isNull (_unit findNearestEnemy _unit)) then {
		if (((_unit findNearestEnemy _unit) distance2D _unit) < 15) then {
			if (isNil {_unit getVariable 'QS_unit_hitEvent'}) then {
				_unit addEventHandler [
					'Hit',
					{
						_unit = _this # 0;
						_unit removeEventHandler ['Hit',_thisEventHandler];
						_enemy = _unit findNearestEnemy _unit;
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
if (!((_unit getVariable ['QS_AI_UNIT_delayedInstructions',[]]) isEqualTo [])) then {
	_delayedInstructions = _unit getVariable ['QS_AI_UNIT_delayedInstructions',[]];
	_delayedInstructions sort TRUE;
	if (diag_tickTime > ((_delayedInstructions # 0) # 1)) then {
		_currentInstruction = (_unit getVariable ['QS_AI_UNIT_delayedInstructions',[]]) deleteAt 0;
		(_currentInstruction # 2) call (_currentInstruction # 3);
	};
};
if (isNull _objectParent) then {
	if (_uiTime > (_unit getVariable ['QS_AI_UNIT_nextSelfRearm',0])) then {
		if (!((primaryWeapon _unit) isEqualTo '')) then {
			if ((_unit ammo (primaryWeapon _unit)) isEqualTo 0) then {
					private _magIndex = (missionNamespace getVariable 'QS_AI_weaponMagazines') findIf {((_x # 0) isEqualTo (toLower ([(primaryWeapon _unit)] call (missionNamespace getVariable 'QS_fnc_baseWeapon'))))};
					private _cfgMagazines = [];
					if (_magIndex isEqualTo -1) then {
						_cfgMagazines = (getArray (configFile >> 'CfgWeapons' >> ([(primaryWeapon _unit)] call (missionNamespace getVariable 'QS_fnc_baseWeapon')) >> 'magazines')) apply {toLower _x};
						(missionNamespace getVariable 'QS_AI_weaponMagazines') pushBack [(toLower ([(primaryWeapon _unit)] call (missionNamespace getVariable 'QS_fnc_baseWeapon'))),_cfgMagazines];
					} else {
						_cfgMagazines = ((missionNamespace getVariable 'QS_AI_weaponMagazines') # _magIndex) # 1;
					};
					if (!(_cfgMagazines isEqualTo [])) then {
						_cfgMagazines = _cfgMagazines apply {(toLower _x)};
						private _magazines = (magazines _unit) select {((toLower _x) in _cfgMagazines)};
						if (_magazines isEqualTo []) then {
							for '_i' from 0 to 5 step 1 do {
								_unit addMagazine (_cfgMagazines # 0);
							};
							_unit addPrimaryWeaponItem (_cfgMagazines # 0);
							_unit selectWeapon (primaryWeapon _unit);
						};
					};
			};
		};
		if (!((secondaryWeapon _unit) isEqualTo '')) then {
			if ((_unit ammo (secondaryWeapon _unit)) isEqualTo 0) then {
				private _magIndex = (missionNamespace getVariable 'QS_AI_weaponMagazines') findIf {((_x # 0) isEqualTo (toLower ([(secondaryWeapon _unit)] call (missionNamespace getVariable 'QS_fnc_baseWeapon'))))};
				private _cfgMagazines = [];
				if (_magIndex isEqualTo -1) then {
					_cfgMagazines = (getArray (configFile >> 'CfgWeapons' >> ([(secondaryWeapon _unit)] call (missionNamespace getVariable 'QS_fnc_baseWeapon')) >> 'magazines')) apply {toLower _x};
					(missionNamespace getVariable 'QS_AI_weaponMagazines') pushBack [(toLower ([(secondaryWeapon _unit)] call (missionNamespace getVariable 'QS_fnc_baseWeapon'))),_cfgMagazines];
				} else {
					_cfgMagazines = ((missionNamespace getVariable 'QS_AI_weaponMagazines') # _magIndex) # 1;
				};
				if (!(_cfgMagazines isEqualTo [])) then {
					_cfgMagazines = _cfgMagazines apply {(toLower _x)};
					private _magazines = (magazines _unit) select {((toLower _x) in _cfgMagazines)};
					if (_magazines isEqualTo []) then {
						for '_i' from 0 to 2 step 1 do {
							_unit addMagazine (_cfgMagazines # 0);
						};
						_unit addSecondaryWeaponItem (_cfgMagazines # 0);
						_unit selectWeapon (primaryWeapon _unit);
					};
				};
			};
		};
		_unit setVariable ['QS_AI_UNIT_nextSelfRearm',(_uiTime + (random [120,200,280])),FALSE];
	};
};
if (_isLeader) then {
	if (isNull _objectParent) then {
		if (!((stance _unit) isEqualTo 'PRONE')) then {
			if (!(_unit getVariable ['QS_AI_UNIT_regroup_disable',FALSE])) then {
				if (_uiTime > (_unit getVariable ['QS_AI_UNIT_lastRegroup',-1])) then {
					_unit setVariable ['QS_AI_UNIT_lastRegroup',(_uiTime + (random [30,60,90])),FALSE];
					if (({(alive _x)} count (units _grp)) isEqualTo 1) then {
						[_unit,300] call (missionNamespace getVariable 'QS_fnc_AIFindNearestRegroup');
					};
				};
			};
		};
	};
	if ((combatMode _grp) in ['YELLOW','RED']) then {
		if ('ItemRadio' in (assignedItems _unit)) then {
			if (_uiTime > (_unit getVariable 'QS_AI_UNIT_lastSupportRequest')) then {
				_unit setVariable ['QS_AI_UNIT_lastSupportRequest',(diag_tickTime + (120 + (random 120))),FALSE];
				private _target = objNull;
				_target = getAttackTarget _unit;
				if (isNull _target) then {
					_allTargets = _unit targets [TRUE,600];
					if (!(_allTargets isEqualTo [])) then {
						_time = time;
						private _filteredTargets = _allTargets select {(((_time - ((_unit targetKnowledge _x) # 2)) < 30) && (isTouchingGround _x) && ((lifeState _x) in ['HEALTHY','INJURED']))};
						if (!(_filteredTargets isEqualTo [])) then {
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
											if ((_supportGroup getVariable 'QS_AI_GRP_DATA') # 0) then {
												if (isNil {_supportGroup getVariable 'QS_AI_GRP_fireMission'}) then {
													if (isNil {_supportGroup getVariable 'QS_AI_GRP_MTR_cooldown'}) then {
														if (((_unit targetKnowledge _target) # 6) inRangeOfArtillery [[_supportProvider],((magazines (vehicle _supportProvider)) # 0)]) then {
															_unit playActionNow 'HandSignalRadio';
															if (missionNamespace getVariable ['QS_virtualSectors_active',FALSE]) then {
																if (missionNamespace getVariable ['QS_virtualSectors_sub_1_active',FALSE]) then {
																	EAST reportRemoteTarget [_target,60];
																};
															};
															_smokePos = ((_unit targetKnowledge _target) # 6) getPos [(random 10),(random 360)];
															_smokePos set [2,0.25];
															_smokeShell = createVehicle ['SmokeShellRed',[_smokePos # 0,_smokePos # 1,25],[],0,'NONE'];
															_smokeShell setVehiclePosition [(getPosWorld _smokeShell),[],0,'NONE'];
															(missionNamespace getVariable 'QS_garbageCollector') pushBack [_smokeShell,'DELAYED_FORCED',(time + 120)];
															missionNamespace setVariable ['QS_analytics_entities_created',((missionNamespace getVariable 'QS_analytics_entities_created') + 1),FALSE];
															_targetPos = ((_unit targetKnowledge _target) # 6) getPos [(random 25),(random 360)];
															_targetPos set [2,0];
															_supportGroup setVariable ['QS_AI_GRP_fireMission',[_targetPos,((magazines (vehicle _supportProvider)) # 0),(round (2 + (random 2))),(diag_tickTime + 180)],FALSE];
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
											if ((_supportGroup getVariable 'QS_AI_GRP_DATA') # 0) then {
												if (isNil {_supportGroup getVariable 'QS_AI_GRP_fireMission'}) then {
													if (isNil {_supportGroup getVariable 'QS_AI_GRP_MTR_cooldown'}) then {
														if (((_unit targetKnowledge _target) # 6) inRangeOfArtillery [[_supportProvider],((magazines (vehicle _supportProvider)) # 0)]) then {
															_unit playActionNow 'HandSignalRadio';
															if (missionNamespace getVariable ['QS_virtualSectors_active',FALSE]) then {
																if (missionNamespace getVariable ['QS_virtualSectors_sub_1_active',FALSE]) then {
																	EAST reportRemoteTarget [_target,60];
																};
															};
															_smokePos = ((_unit targetKnowledge _target) # 6) getPos [(random 10),(random 360)];
															_smokePos set [2,0.25];
															_smokeShell = createVehicle ['SmokeShellRed',[_smokePos # 0,_smokePos # 1,25],[],0,'NONE'];
															_smokeShell setVehiclePosition [(getPosWorld _smokeShell),[],0,'NONE'];
															(missionNamespace getVariable 'QS_garbageCollector') pushBack [_smokeShell,'DELAYED_FORCED',(time + 120)];
															missionNamespace setVariable ['QS_analytics_entities_created',((missionNamespace getVariable 'QS_analytics_entities_created') + 1),FALSE];
															_targetPos = ((_unit targetKnowledge _target) # 6) getPos [(random 25),(random 360)];
															_targetPos set [2,0];
															_supportGroup setVariable ['QS_AI_GRP_fireMission',[_targetPos,((magazines (vehicle _supportProvider)) # 0),(round (2 + (random 2))),(diag_tickTime + 180)],FALSE];
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
													_smokePos = ((_unit targetKnowledge _target) # 6) getPos [(random 10),(random 360)];
													_smokePos set [2,0.25];
													_smokeShell = createVehicle ['SmokeShellRed',[_smokePos # 0,_smokePos # 1,25],[],0,'NONE'];
													_smokeShell setVehiclePosition [(getPosWorld _smokeShell),[],0,'NONE'];
													(missionNamespace getVariable 'QS_garbageCollector') pushBack [_smokeShell,'DELAYED_FORCED',(time + 120)];
													_handle = [1,_supportProvider,_supportGroup,_target,(position _target),_smokePos,(diag_tickTime + 180)] spawn (missionNamespace getVariable 'QS_fnc_AIFireMission');
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
												_laserPos = (_unit targetKnowledge _target) # 6;
												_laserPos set [2,1];
												_handle = [2,_supportProvider,_supportGroup,_target,(position _target),(diag_tickTime + 120)] spawn (missionNamespace getVariable 'QS_fnc_AIFireMission');
												(missionNamespace getVariable 'QS_AI_scripts_fireMissions') pushBack _handle;
												if ((random 1) > 0.666) then {
													_smokePos = ((_unit targetKnowledge _target) # 6) getPos [(random 10),(random 360)];
													_smokePos set [2,0.25];
													_smokeShell = createVehicle ['SmokeShellRed',[_smokePos # 0,_smokePos # 1,25],[],0,'NONE'];
													_smokeShell setVehiclePosition [(getPosWorld _smokeShell),[],0,'NONE'];
													(missionNamespace getVariable 'QS_garbageCollector') pushBack [_smokeShell,'DELAYED_FORCED',(time + 120)];
												};
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
												_laserPos = (_unit targetKnowledge _target) # 6;
												_laserPos set [2,1];
												_handle = [3,_supportProvider,_supportGroup,_target,(position _target),(diag_tickTime + 180)] spawn (missionNamespace getVariable 'QS_fnc_AIFireMission');
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