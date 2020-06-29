/*/
File: fn_clientAIBehaviours.sqf
Author:

	Quiksilver
	
Last Modified:

	21/6/2020 A3 1.98 by Quiksilver
	
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
	if ((!(player isEqualTo (leader (group player)))) || (((units (group player)) findIf {((alive _x) && (!(isPlayer _x)) && (!(unitIsUav _x)))}) isEqualTo -1)) exitWith {};
	{
		_entity = _x;
		_entitySide = side _entity;
		if (!isPlayer _entity) then {
			if (alive _entity) then {
				if ((getSuppression _entity) <= 0) then {
					if (!(_entity getVariable ['QS_AI_JOB',FALSE])) then {
						//comment 'MEDIC AUTO REVIVE';
						if (_entity getUnitTrait 'medic') then {
							_nearUnits = (getPosATL _entity) nearEntities ['CAManBase',([50,15] select ((lifeState player) in ['HEALTHY','INJURED']))];
							if (!(_nearUnits isEqualTo [])) then {
								_job = FALSE;
								{
									_unit = _x;
									if (alive _unit) then {
										if ((lifeState _unit) isEqualTo 'INCAPACITATED') then {
											if (!(_unit getVariable ['QS_revive_disable',FALSE])) then {
												if (isNull (attachedTo _unit)) then {
													if (isNull (objectParent _unit)) then {
														if (!( alive (_unit getVariable ['QS_AI_JOB_PROVIDER',objNull]))) then {
															_job = TRUE;
															_unit setVariable ['QS_AI_JOB_PROVIDER',_entity,FALSE];
															_entity setVariable ['QS_AI_JOB',TRUE,FALSE];
															_entity setVariable ['QS_AI_JOB_DATA',[(_time + 30),1,_time,scriptNull,'MEDIC',_unit,(getPosATL _unit)],FALSE];
															if ((unitPos _entity) in ['UP','AUTO']) then {
																_entity setUnitPos 'MIDDLE';
															};
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
						
						//comment 'OTHER BEHAVIOURS';
						
						
					} else {
						//comment 'Unit is on job, evaluate';
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
								//comment 'MEDIC AUTO REVIVE';
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
									if ((alive _jobTarget) && ((lifeState _jobTarget) isEqualTo 'INCAPACITATED') && (isNull (objectParent _jobTarget)) && (isNull (attachedTo _jobTarget)) && (alive _entity) && ((lifeState _entity) in ['HEALTHY','INJURED'])) then {
										if ((unitPos _entity) in ['UP','AUTO']) then {
											_entity setUnitPos 'MIDDLE';
										};
										if ((_entity distance _jobTarget) > 4) then {
											doStop _entity;
											_entity doMove (getPosATL _jobTarget);
										} else {
											if (isNull _jobScript) then {
												_jobScript = [_entity,_jobTarget] spawn {
													params ['_entity','_jobTarget'];
													_entity doWatch _jobTarget;
													_entity action ['HealSoldier',_jobTarget];
													uiSleep 6;
													if ((alive _jobTarget) && ((lifeState _jobTarget) isEqualTo 'INCAPACITATED') && (isNull (objectParent _jobTarget)) && (isNull (attachedTo _jobTarget)) && (alive _entity) && ((lifeState _entity) in ['HEALTHY','INJURED'])) then {
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
												_jobData set [3,_jobScript];
											};
										};
										_jobData set [6,(getPosATL _jobTarget)];
										_entity setVariable ['QS_AI_JOB_DATA',_jobData,FALSE];
									} else {
										_entity setVariable ['QS_AI_JOB',FALSE,FALSE];
										_entity setVariable ['QS_AI_JOB_DATA',[],FALSE];
									};
								};
								//comment 'OTHER BEHAVIOURS';
								
							};
						};
					};
				};
			};
		};
	} forEach (units (group player));
	uiSleep 0.5;
};