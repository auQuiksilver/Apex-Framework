/*/
File: fn_clientInteractRevive.sqf
Author:

	Quiksilver
	
Last Modified:

	1/12/2022 A3 2.10 by Quiksilver
	
Description:

	Revive
________________________________________/*/

private _t = cursorTarget;
_player = QS_player;
if (
	(!(_t isKindOf 'CAManBase')) ||
	{(!alive _t)} ||
	{((lifeState _t) isNotEqualTo 'INCAPACITATED')} ||
	{(!isNull (attachedTo _t))} ||
	{(!isNull (objectParent _player))}
) exitWith {};
if (_t getVariable ['QS_revive_disable',FALSE]) exitWith {
	50 cutText [(format [localize 'STR_QS_Text_129',(name _t)]),'PLAIN',0.5];
};
if (_t getVariable ['QS_unit_needsStabilise',FALSE]) exitWith {
	50 cutText [localize 'STR_QS_Text_088','PLAIN',0.3];
};
private _val = 1;
if ((_player getVariable 'QS_stamina_multiplier') # 0) then {
	_val = 1.25;
};
_itemsPlayer = (items _player) apply {toLowerANSI _x};
_itemsTarget = (items _t) apply {toLowerANSI _x};
private _requiredMedikit = (getMissionConfigValue ['ReviveRequiredItems',2]) > 0;
private _requiredFirstAidKit = (getMissionConfigValue ['ReviveRequiredItems',2]) > 1;
private _firstAidKitConsumed = (getMissionConfigValue ['ReviveRequiredItemsFakConsumed',1]) > 0;
private _playerHasMedikit = (_itemsPlayer findAny QS_core_classNames_itemMedikits) isNotEqualTo -1;
private _incapacitatedHasMedikit = (_itemsTarget findAny QS_core_classNames_itemMedikits) isNotEqualTo -1;
private _playerHasFAK = (_itemsPlayer findAny QS_core_classNames_itemFirstAidKits) isNotEqualTo -1;
private _incapacitatedHasFAK = (_itemsTarget findAny QS_core_classNames_itemFirstAidKits) isNotEqualTo -1;
private _fakType = '';
if (_playerHasFAK) then {
	_fakType = QS_core_classNames_itemFirstAidKits # (QS_core_classNames_itemFirstAidKits findAny _itemsPlayer);
};
if (_incapacitatedHasFAK) then {
	_fakType = QS_core_classNames_itemFirstAidKits # (QS_core_classNames_itemFirstAidKits findAny _itemsTarget);
};
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
private _currentWeapon = currentWeapon _player;
private _stance = stance _player;
_player setVariable ['QS_client_currentAnim',(animationState _player),FALSE];
_player setVariable ['QS_client_animCancel',FALSE,FALSE];
private _animation = '';
private _cancelEnabled = FALSE;
private _action_cancel = -1;
private _weaponSuffix = switch _currentWeapon do {
    case (primaryWeapon _player): {'wrfldnon_medicother'};
    case (handgunWeapon _player): {'wpstdnon_medicother'};
    case (secondaryWeapon _player): {'wlnrdnon_medicother'};
    default {'wnondnon_medicother'};
};
_animation = switch _stance do {
    case 'STAND': {'ainvpknlmstpslay' + _weaponSuffix};
    case 'CROUCH': {'ainvpknlmstpslay' + _weaponSuffix};
    case 'PRONE': {'ainvppnemstpslay' + _weaponSuffix};
    default {''};
};
if (_animation isEqualTo '') exitWith {};
private _exit = FALSE;
_player playMoveNow _animation;
private _safetyTimeout = diag_tickTime + 60;
waitUntil {
	uiSleep 0.1;
	(((animationState _player) in [
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
_player setVariable ['QS_animDone',FALSE,FALSE];
waitUntil {
	uiSleep 0.1;
	((!alive _player) || {(!((lifeState _player) in ['HEALTHY','INJURED']))} || {(_player getVariable 'QS_animDone')} || {(_player getVariable 'QS_client_animCancel')})
};
if (_player getVariable 'QS_client_animCancel') exitWith {
	_player setVariable ['QS_client_animCancel',FALSE,FALSE];
	50 cutText [localize 'STR_QS_Text_128','PLAIN DOWN',0.333];
};
if (_stance isEqualTo 'PRONE') then {
	private _time2 = diag_tickTime + 0.5;
	waitUntil {
		uiSleep 0.1;
		(diag_tickTime > _time2)
	};
	if (((lifeState _t) isNotEqualTo 'INCAPACITATED') || {(!(isNull (attachedTo _t)))} || {(!((lifeState _player) in ['HEALTHY','INJURED']))} || {(_player getVariable 'QS_client_animCancel')}) exitWith {
		_exit = TRUE;
	};
	_player playMoveNow _animation;
	waitUntil {
		uiSleep 0.1;
		((animationState _player) in [
			'ainvppnemstpslaywrfldnon_medicother','ainvppnemstpslaywnondnon_medicother','ainvppnemstpslaywpstdnon_medicother'
		])
	};
	_player setVariable ['QS_animDone',FALSE,FALSE];
	waitUntil {
		uiSleep 0.1;
		((!alive _player) || {(_player getVariable 'QS_animDone')} || {(!((lifeState _player) in ['HEALTHY','INJURED']))} || {(_player getVariable 'QS_client_animCancel')})
	};
};
if (_player getVariable 'QS_client_animCancel') exitWith {
	_player setVariable ['QS_client_animCancel',FALSE,FALSE];
	50 cutText [localize 'STR_QS_Text_128','PLAIN DOWN',0.333];
};
if (_cancelEnabled) then {
	player removeAction _action_cancel;
};
if (_exit) exitWith {
	50 cutText [localize 'STR_QS_Text_128','PLAIN DOWN',0.25];
};
if (missionNamespace getVariable ['QS_medical_garbage_enabled',FALSE]) then {
	if (((getPosASL _player) # 2) > 0.1) then {
		private _intersections = lineIntersectsSurfaces [(eyePos _player),[((eyePos _player) # 0),((eyePos _player) # 1),-1],_player,objNull,TRUE,3,'GEOM'];
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
if (!(_player getVariable ['QS_client_animCancel',FALSE])) then {
	if (alive _player) then {
		if (alive _t) then {
			if ((lifeState _player) isNotEqualTo 'INCAPACITATED') then {
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
									_t removeItem _fakType;
								} else {
									_player removeItem _fakType;
								};
							};
						};
						if (isPlayer _t) then {
							_text = format [localize 'STR_QS_Text_263',profileName];
							[63,[5,[_text,'PLAIN DOWN',0.75]]] remoteExec ['QS_fnc_remoteExec',_t,FALSE];
						};
						if (_player isNil 'QS_revive_lastPatient') then {
							_player setVariable ['QS_revive_lastPatient',[(getPlayerUID _t),(time + 180)],FALSE];
							[51,[_player,(getPlayerUID _player),profileName,_val]] remoteExec ['QS_fnc_remoteExec',2,FALSE];
						} else {
							if ((getPlayerUID _t) isEqualTo ((_player getVariable 'QS_revive_lastPatient') # 0)) then {
								if (time > ((_player getVariable 'QS_revive_lastPatient') # 1)) then {
									[51,[_player,(getPlayerUID _player),profileName,_val]] remoteExec ['QS_fnc_remoteExec',2,FALSE];
								};
							} else {
								[51,[_player,(getPlayerUID _player),profileName,_val]] remoteExec ['QS_fnc_remoteExec',2,FALSE];
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
if (_player getVariable ['QS_client_animCancel',FALSE]) then {
	_player setVariable ['QS_client_animCancel',FALSE,FALSE];
};
TRUE;