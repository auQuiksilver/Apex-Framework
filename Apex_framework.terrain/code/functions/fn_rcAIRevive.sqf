/*/
File: fn_rcAIRevive.sqf
Author:

	Quiksilver
	
Last modified:

	27/03/2022 A3 2.08 by Quiksilver
	
Description:

	AI Revive (Remote Controlled)
__________________________________________________/*/

private [
	'_t','_medi','_fak','_itemsPlayer','_itemsIncapacitated','_playerHasMedikit','_playerHasFAK','_incapacitatedHasFAK','_time','_isProne','_hasPrimaryWeapon',
	'_primaryWeapon','_time2','_val','_currentWeapon','_stance','_animation'
];
private _cameraOn = cameraOn;
if (!(_cameraOn getVariable ['QS_animDoneEH',FALSE])) then {
	_cameraOn setVariable ['QS_animDoneEH',TRUE];
	_cameraOn addEventHandler ["AnimDone", {
		params ["_unit", "_anim"];
		if (!(_unit getVariable ['QS_animDone',FALSE])) then {
			_unit setVariable ['QS_animDone',TRUE,FALSE];
		};
	}];
};
_t = cursorTarget;
if (
	(!(_t isKindOf 'CAManBase')) ||
	{(!alive _t)} ||
	{((lifeState _t) isNotEqualTo 'INCAPACITATED')} ||
	{(!isNull (attachedTo _t))} ||
	{(!isNull (objectParent _cameraOn))}
) exitWith {};
if (isPlayer _t) then {
	private _text = format [localize 'STR_QS_Text_262',profileName];
	[63,[5,[_text,'PLAIN',0.5]]] remoteExec ['QS_fnc_remoteExec',_t,FALSE];
};
_time = diag_tickTime + 5.5;
_currentWeapon = currentWeapon _cameraOn;
_stance = stance _cameraOn;
_cameraOn setVariable ['QS_client_currentAnim',(animationState _cameraOn),FALSE];
_cameraOn setVariable ['QS_client_animCancel',FALSE,FALSE];
_animation = '';
private _cancelEnabled = FALSE;
private _action_cancel = -1;
if (_stance isEqualTo 'STAND') then {
	if (_currentWeapon isEqualTo '') then {
		_animation = 'ainvpknlmstpslaywnondnon_medicother';
	} else {
		if (_currentWeapon isEqualTo (primaryWeapon _cameraOn)) then {
			_animation = 'ainvpknlmstpslaywrfldnon_medicother';
		} else {
			if (_currentWeapon isEqualTo (handgunWeapon _cameraOn)) then {
				_animation = 'ainvpknlmstpslaywpstdnon_medicother';
			} else {
				if (_currentWeapon isEqualTo (secondaryWeapon _cameraOn)) then {
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
			if (_currentWeapon isEqualTo (primaryWeapon _cameraOn)) then {
				_animation = 'ainvpknlmstpslaywrfldnon_medicother';
			} else {
				if (_currentWeapon isEqualTo (handgunWeapon _cameraOn)) then {
					_animation = 'ainvpknlmstpslaywpstdnon_medicother';
				} else {
					if (_currentWeapon isEqualTo (secondaryWeapon _cameraOn)) then {
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
				if (_currentWeapon isEqualTo (primaryWeapon _cameraOn)) then {
					_animation = 'ainvppnemstpslaywrfldnon_medicother';
				} else {
					if (_currentWeapon isEqualTo (handgunWeapon _cameraOn)) then {
						_animation = 'ainvppnemstpslaywpstdnon_medicother';
					};
				}
			};
		};
	};
};
if (_animation isEqualTo '') exitWith {};
private _exit = FALSE;
_cameraOn playMoveNow _animation;
waitUntil {
	uiSleep 0.1;
	((animationState _cameraOn) in [
		'ainvpknlmstpslaywnondnon_medicother','ainvpknlmstpslaywrfldnon_medicother','ainvpknlmstpslaywpstdnon_medicother','ainvpknlmstpslaywlnrdnon_medicother',
		'ainvppnemstpslaywnondnon_medicother','ainvppnemstpslaywrfldnon_medicother','ainvppnemstpslaywpstdnon_medicother'
	])
};
if (_stance isEqualTo 'PRONE') then {
	_cancelEnabled = TRUE;
	_action_cancel = _cameraOn addAction [
		localize 'STR_QS_Interact_065',
		{
			_cameraOn = cameraOn;
			_cameraOn removeAction (_this # 2);
			_cameraOn setVariable ['QS_client_animCancel',TRUE,FALSE];
			_cameraOn switchMove (_cameraOn getVariable ['QS_client_currentAnim','']);
			['switchMove',_cameraOn,(_cameraOn getVariable ['QS_client_currentAnim',''])] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
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
	_cameraOn setUserActionText [_action_cancel,((_cameraOn actionParams _action_cancel) # 0),(format ["<t size='3'>%1</t>",((_cameraOn actionParams _action_cancel) # 0)])];
};
_cameraOn setVariable ['QS_animDone',FALSE,FALSE];
waitUntil {
	uiSleep 0.1;
	((!alive _cameraOn) || {(!((lifeState _cameraOn) in ['HEALTHY','INJURED']))} || {(_cameraOn getVariable 'QS_animDone')} || {(_cameraOn getVariable 'QS_client_animCancel')})
};
if (_cameraOn getVariable 'QS_client_animCancel') exitWith {
	_cameraOn setVariable ['QS_client_animCancel',FALSE,FALSE];
	50 cutText [localize 'STR_QS_Text_128','PLAIN DOWN',0.333];
};
if (_stance isEqualTo 'PRONE') then {
	_time2 = diag_tickTime + 0.5;
	waitUntil {
		uiSleep 0.1;
		(diag_tickTime > _time2)
	};
	if (((lifeState _t) isNotEqualTo 'INCAPACITATED') || {(!(isNull (attachedTo _t)))} || {(!((lifeState _cameraOn) in ['HEALTHY','INJURED']))} || {(_cameraOn getVariable 'QS_client_animCancel')}) exitWith {
		_exit = TRUE;
	};
	_cameraOn playMoveNow _animation;
	waitUntil {
		uiSleep 0.1;
		((animationState _cameraOn) in [
			'ainvppnemstpslaywrfldnon_medicother','ainvppnemstpslaywnondnon_medicother','ainvppnemstpslaywpstdnon_medicother'
		])
	};
	_cameraOn setVariable ['QS_animDone',FALSE,FALSE];
	waitUntil {
		uiSleep 0.1;
		((!alive _cameraOn) || {(_cameraOn getVariable 'QS_animDone')} || {(!((lifeState _cameraOn) in ['HEALTHY','INJURED']))} || {(_cameraOn getVariable 'QS_client_animCancel')})
	};
};
if (_cameraOn getVariable 'QS_client_animCancel') exitWith {
	_cameraOn setVariable ['QS_client_animCancel',FALSE,FALSE];
	50 cutText [localize 'STR_QS_Text_128','PLAIN DOWN',0.333];
};
if (_cancelEnabled) then {
	_cameraOn removeAction _action_cancel;
};
if (_exit) exitWith {
	50 cutText [localize 'STR_QS_Text_128','PLAIN DOWN',0.25];
};
waitUntil {
	uiSleep 0.1;
	(diag_tickTime >= _time)
};
if (!(_cameraOn getVariable ['QS_client_animCancel',FALSE])) then {
	if (alive _cameraOn) then {
		if (alive _t) then {
			if ((lifeState _cameraOn) isNotEqualTo 'INCAPACITATED') then {
				if ((lifeState _t) isEqualTo 'INCAPACITATED') then {
					if (isNull (attachedTo _t)) then {
						if ((lifeState _t) isEqualTo 'INCAPACITATED') then {
							if (local _t) then {
								_t setUnconscious FALSE;
								_t setCaptive FALSE;
							} else {
								[68,_t,FALSE,FALSE] remoteExec ['QS_fnc_remoteExec',_t,FALSE];
							};
							_t allowDamage TRUE;
						};
						if (isPlayer _t) then {
							_text = format [localize 'STR_QS_Text_263',profileName];
							[63,[5,[_text,'PLAIN DOWN',0.75]]] remoteExec ['QS_fnc_remoteExec',_t,FALSE];
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
if (_cameraOn getVariable ['QS_client_animCancel',FALSE]) then {
	_cameraOn setVariable ['QS_client_animCancel',FALSE,FALSE];
};
TRUE;