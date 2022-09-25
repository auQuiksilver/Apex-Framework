/*/
File: fn_clientInteractRevive.sqf
Author:

	Quiksilver
	
Last Modified:

	9/09/2022 A3 2.10 by Quiksilver
	
Description:

	Revive
_____________________________________________________________/*/

private _t = cursorTarget;
if (
	(!(_t isKindOf 'Man')) ||
	{(!alive _t)} ||
	{((lifeState _t) isNotEqualTo 'INCAPACITATED')} ||
	{(!isNull (attachedTo _t))} ||
	{(!isNull (objectParent player))}
) exitWith {};
if (_t getVariable ['QS_revive_disable',FALSE]) exitWith {
	50 cutText [(format [localize 'STR_QS_Text_129',(name _t)]),'PLAIN',0.5];
};
if (_t getVariable ['QS_unit_needsStabilise',FALSE]) exitWith {
	50 cutText [localize 'STR_QS_Text_088','PLAIN',0.3];
};
private _val = 1;
if ((player getVariable 'QS_stamina_multiplier') # 0) then {
	_val = 1.25;
};
private _requiredMedikit = (getMissionConfigValue ['ReviveRequiredItems',2]) > 0;
private _requiredFirstAidKit = (getMissionConfigValue ['ReviveRequiredItems',2]) > 1;
private _firstAidKitConsumed = (getMissionConfigValue ['ReviveRequiredItemsFakConsumed',1]) > 0;
private _playerHasMedikit = ((uniqueUnitItems player) getOrDefault ['Medikit',0]) > 0;
private _incapacitatedHasMedikit = ((uniqueUnitItems _t) getOrDefault ['Medikit',0]) > 0;
private _playerHasFAK = ((uniqueUnitItems player) getOrDefault ['FirstAidKit',0]) > 0;
private _incapacitatedHasFAK = ((uniqueUnitItems _t) getOrDefault ['FirstAidKit',0]) > 0;
if (
	_requiredMedikit &&
	((!(_playerHasMedikit)) && (!(_incapacitatedHasMedikit)))
) exitWith {
	50 cutText [localize 'STR_QS_Text_130','PLAIN DOWN'];	
};
if (
	_requiredFirstAidKit &&
	((!(_playerHasFAK)) && (!(_incapacitatedHasFAK)))
) exitWith {
	50 cutText [localize 'STR_QS_Text_130','PLAIN DOWN'];
};
if (isPlayer _t) then {
	private _text = format [localize 'STR_QS_Text_262',profileName];
	[63,[5,[_text,'PLAIN',0.5]]] remoteExec ['QS_fnc_remoteExec',_t,FALSE];
};
private _time = diag_tickTime + 5.5;
private _currentWeapon = currentWeapon player;
private _stance = stance player;
player setVariable ['QS_client_currentAnim',(animationState player),FALSE];
player setVariable ['QS_client_animCancel',FALSE,FALSE];
private _animation = '';
private _cancelEnabled = FALSE;
private _action_cancel = -1;
if (_stance isEqualTo 'STAND') then {
	if (_currentWeapon isEqualTo '') then {
		_animation = 'ainvpknlmstpslaywnondnon_medicother';
	} else {
		if (_currentWeapon isEqualTo (primaryWeapon player)) then {
			_animation = 'ainvpknlmstpslaywrfldnon_medicother';
		} else {
			if (_currentWeapon isEqualTo (handgunWeapon player)) then {
				_animation = 'ainvpknlmstpslaywpstdnon_medicother';
			} else {
				if (_currentWeapon isEqualTo (secondaryWeapon player)) then {
					_animation = 'ainvpknlmstpslaywlnrdnon_medicother';
				};
			};
		}
	};
} else {
	if (_stance isEqualTo 'CROUCH') then {
		if (_currentWeapon isEqualTo '') then {
			_animation = 'ainvpknlmstpslaywnondnon_medicother';
		} else {
			if (_currentWeapon isEqualTo (primaryWeapon player)) then {
				_animation = 'ainvpknlmstpslaywrfldnon_medicother';
			} else {
				if (_currentWeapon isEqualTo (handgunWeapon player)) then {
					_animation = 'ainvpknlmstpslaywpstdnon_medicother';
				} else {
					if (_currentWeapon isEqualTo (secondaryWeapon player)) then {
						_animation = 'ainvpknlmstpslaywlnrdnon_medicother';
					};
				};
			}
		};
	} else {
		if (_stance isEqualTo 'PRONE') then {
			if (_currentWeapon isEqualTo '') then {
				_animation = 'ainvppnemstpslaywnondnon_medicother';
			} else {
				if (_currentWeapon isEqualTo (primaryWeapon player)) then {
					_animation = 'ainvppnemstpslaywrfldnon_medicother';
				} else {
					if (_currentWeapon isEqualTo (handgunWeapon player)) then {
						_animation = 'ainvppnemstpslaywpstdnon_medicother';
					};
				}
			};
		};
	};
};
if (_animation isEqualTo '') exitWith {};
private _exit = FALSE;
player playMoveNow _animation;
private _safetyTimeout = diag_tickTime + 60;
waitUntil {
	uiSleep 0.1;
	(((animationState player) in [
		'ainvpknlmstpslaywnondnon_medicother','ainvpknlmstpslaywrfldnon_medicother','ainvpknlmstpslaywpstdnon_medicother','ainvpknlmstpslaywlnrdnon_medicother',
		'ainvppnemstpslaywnondnon_medicother','ainvppnemstpslaywrfldnon_medicother','ainvppnemstpslaywpstdnon_medicother'
	]) || {(diag_tickTime > _safetyTimeout)})
};
if (diag_tickTime > _safetyTimeout) exitWith {};
if (_stance isEqualTo 'PRONE') then {
	_cancelEnabled = TRUE;
	_action_cancel = player addAction [
		localize 'STR_QS_Interact_065',
		{
			player removeAction (_this # 2);
			player setVariable ['QS_client_animCancel',TRUE,FALSE];
			player switchMove (player getVariable ['QS_client_currentAnim','']);
			['switchMove',player,(player getVariable ['QS_client_currentAnim',''])] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
		},
		nil,
		99,
		TRUE,
		TRUE,
		'',
		'TRUE',
		-1,
		FALSE,
		''
	];
	player setUserActionText [_action_cancel,((player actionParams _action_cancel) # 0),(format ["<t size='3'>%1</t>",((player actionParams _action_cancel) # 0)])];
};
player setVariable ['QS_animDone',FALSE,FALSE];
waitUntil {
	uiSleep 0.1;
	((!alive player) || {(!((lifeState player) in ['HEALTHY','INJURED']))} || {(player getVariable 'QS_animDone')} || {(player getVariable 'QS_client_animCancel')})
};
if (player getVariable 'QS_client_animCancel') exitWith {
	player setVariable ['QS_client_animCancel',FALSE,FALSE];
	50 cutText [localize 'STR_QS_Text_128','PLAIN DOWN',0.333];
};
if (_stance isEqualTo 'PRONE') then {
	private _time2 = diag_tickTime + 0.5;
	waitUntil {
		uiSleep 0.1;
		(diag_tickTime > _time2)
	};
	if (((lifeState _t) isNotEqualTo 'INCAPACITATED') || {(!(isNull (attachedTo _t)))} || {(!((lifeState player) in ['HEALTHY','INJURED']))} || {(player getVariable 'QS_client_animCancel')}) exitWith {
		_exit = TRUE;
	};
	player playMoveNow _animation;
	waitUntil {
		uiSleep 0.1;
		((animationState player) in [
			'ainvppnemstpslaywrfldnon_medicother','ainvppnemstpslaywnondnon_medicother','ainvppnemstpslaywpstdnon_medicother'
		])
	};
	player setVariable ['QS_animDone',FALSE,FALSE];
	waitUntil {
		uiSleep 0.1;
		((!alive player) || {(player getVariable 'QS_animDone')} || {(!((lifeState player) in ['HEALTHY','INJURED']))} || {(player getVariable 'QS_client_animCancel')})
	};
};
if (player getVariable 'QS_client_animCancel') exitWith {
	player setVariable ['QS_client_animCancel',FALSE,FALSE];
	50 cutText [localize 'STR_QS_Text_128','PLAIN DOWN',0.333];
};
if (_cancelEnabled) then {
	player removeAction _action_cancel;
};
if (_exit) exitWith {
	50 cutText [localize 'STR_QS_Text_128','PLAIN DOWN',0.25];
};
if (missionNamespace getVariable ['QS_medical_garbage_enabled',FALSE]) then {
	if (((getPosASL player) # 2) > 0.1) then {
		private _intersections = lineIntersectsSurfaces [(eyePos player),[((eyePos player) # 0),((eyePos player) # 1),-1],player,objNull,TRUE,3,'GEOM'];
		if (_intersections isNotEqualTo []) then {
			_intersections = _intersections select {(!((_x # 3) isKindOf 'CAManBase'))};
			if (_intersections isNotEqualTo []) then {
				[76,((_intersections # 0) # 0),((_intersections # 0) # 1)] remoteExec ['QS_fnc_remoteExec',2,FALSE];
			};
		};
	};
};
waitUntil {
	uiSleep 0.1;
	(diag_tickTime >= _time)
};
if (!(player getVariable ['QS_client_animCancel',FALSE])) then {
	if (alive player) then {
		if (alive _t) then {
			if ((lifeState player) isNotEqualTo 'INCAPACITATED') then {
				if ((lifeState _t) isEqualTo 'INCAPACITATED') then {
					if (isNull (attachedTo _t)) then {
						_t setVariable ['QS_revive_healer',profileName,TRUE];
						if ((lifeState _t) isEqualTo 'INCAPACITATED') then {
						
							if (local _t) then {
								_t setUnconscious FALSE;
								_t setCaptive FALSE;
							} else {
								[68,_t,FALSE,FALSE] remoteExec ['QS_fnc_remoteExec',_t,FALSE];
							};
							_t allowDamage TRUE;
							if (_firstAidKitConsumed) then {
								if (_incapacitatedHasFAK) then {
									_t removeItem 'FirstAidKit';
								} else {
									player removeItem 'FirstAidKit';
								};
							};
						};
						if (isPlayer _t) then {
							_text = format [localize 'STR_QS_Text_263',profileName];
							[63,[5,[_text,'PLAIN DOWN',0.75]]] remoteExec ['QS_fnc_remoteExec',_t,FALSE];
						};
						if (isNil {player getVariable 'QS_revive_lastPatient'}) then {
							player setVariable ['QS_revive_lastPatient',[(getPlayerUID _t),(time + 180)],FALSE];
							[51,[player,(getPlayerUID player),profileName,_val]] remoteExec ['QS_fnc_remoteExec',2,FALSE];
						} else {
							if ((getPlayerUID _t) isEqualTo ((player getVariable 'QS_revive_lastPatient') # 0)) then {
								if (time > ((player getVariable 'QS_revive_lastPatient') # 1)) then {
									[51,[player,(getPlayerUID player),profileName,_val]] remoteExec ['QS_fnc_remoteExec',2,FALSE];
								};
							} else {
								[51,[player,(getPlayerUID player),profileName,_val]] remoteExec ['QS_fnc_remoteExec',2,FALSE];
							};
						};
					} else {
						50 cutText [localize 'STR_QS_Text_131','PLAIN DOWN',0.3];
					};
				} else {
					50 cutText [localize 'STR_QS_Text_131','PLAIN DOWN',0.3];
				};
			};
		};
	};
};
if (player getVariable ['QS_client_animCancel',FALSE]) then {
	player setVariable ['QS_client_animCancel',FALSE,FALSE];
};
TRUE;