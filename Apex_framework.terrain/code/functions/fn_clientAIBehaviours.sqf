/*/
File: fn_clientAIBehaviours.sqf
Author:

	Quiksilver
	
Last Modified:

	21/4/2022 A3 2.08 by Quiksilver
	
Description:

	Behaviours of grouped AI, such as medics
_____________________________________________________________________/*/
scriptName 'QS Script Client AI Behaviours';
private _entity = objNull;
private _nearUnits = [];
private _entitySide = WEST;
private _unitSide = WEST;
private _unit = objNull;
private _jobData = [];
private _time = diag_tickTime;
private _healScript = scriptNull;
private _oldUnitPos = '';
private _job = FALSE;
for '_x' from 0 to 1 step 0 do {
	_time = diag_tickTime;
	if (
		( (player isNotEqualTo (leader (group player))) && ((lifeState player) in ['HEALTHY','INJURED'])) ||
		(((units (group player)) findIf {((alive _x) && (!(isPlayer _x)) && (!(unitIsUav _x)))}) isEqualTo -1)
	) exitWith {};
	{
		if (!isPlayer _x) then {
			if (
				(local _x) && 
				{(_x checkAIFeature 'PATH')}
			) then {
				_entity = _x;
				_entitySide = side (group _entity);
				if ((lifeState _entity) in ['HEALTHY','INJURED']) then {
					if (!(_entity getVariable ['QS_AI_JOB',FALSE])) then {
						if (_entity getUnitTrait 'medic') then {
							if ((lifeState _entity) isEqualTo 'INJURED') then {
								_entity action ['HealSoldierSelf',_entity];
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
												_entity action ['HealSoldierSelf',_entity];
												_entity setDamage [0,FALSE];
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
																['switchMove',_jobTarget,['AmovPpneMstpSnonWnonDnon']] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
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
	} forEach (units (group player));
	uiSleep 0.5;
};