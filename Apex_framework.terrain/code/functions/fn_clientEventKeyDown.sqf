/*/ 
File: fn_clientEventKeyDown.sqf 
Author:
	
	Quiksilver 	 
	
Last Modified:  	

	9/10/2023 A3 2.14 by Quiksilver
	
Description:  	

	Client Event Key Down 
__________________________________________________________/*/  

params ['','_key','_shift','_ctrl','_alt'];
private _c = FALSE;
_cameraOn = cameraOn;
_player = QS_player;
uiNamespace setVariable ['QS_client_afkTimeout',diag_tickTime];
uiNamespace setVariable ['QS_uiaction_ctrl',_ctrl];
// Holster Weapon
if (((actionKeys 'User8') isEqualTo []) && {(_key isEqualTo 5) && {(commandingMenu isEqualTo '')}}) then {
	[_player] call (missionNamespace getVariable 'QS_fnc_clientHolster');
};
// Earplugs
if (((actionKeys 'User9') isEqualTo []) && {_key in [197,207]}) then {
	call (missionNamespace getVariable 'QS_fnc_clientEarplugs');
};
// Player Menu
if (((actionKeys 'User10') isEqualTo []) && {(_key isEqualTo 199)}) then {
	if (isNull (findDisplay 2000)) then {
		[0] call (missionNamespace getVariable 'QS_fnc_clientMenu');
	} else {
		[-1] call (missionNamespace getVariable 'QS_fnc_clientMenu');
	};
};
if (
	(_key in (actionKeys 'GetOver')) &&
	{(isNull (objectParent _player))}
) exitWith {
	if (uiNamespace getVariable ['QS_uiaction_turbo',FALSE]) then {
		_c = TRUE;
		_this call (missionNamespace getVariable 'QS_fnc_clientJump');
	} else {
		uiNamespace setVariable ['QS_ui_getincargo_activate',TRUE];
		call (missionNamespace getVariable 'QS_fnc_clientInteractGetIn');
	};
};
if (((actionKeys 'User20') isEqualTo []) && {(_key isEqualTo 219)}) then {
	['IN'] call QS_fnc_clientMenuActionContext;
};
if (
	(isNull (objectParent _player)) &&
	{(_key in ((actionKeys 'Throw') + (actionKeys 'Put')))} &&
	{(!(unitIsUav _cameraOn))}
) then {
	([_player,'SAFE'] call QS_fnc_inZone) params ['_inSafezone','_safezoneLevel','_safezoneActive'];
	_c = _inSafezone && _safezoneActive && (_safezoneLevel > 1);
	if (_c) then {
		50 cutText [localize 'STR_QS_Text_013','PLAIN DOWN'];
	};
};
if (_key in (actionKeys 'PushToTalk')) then {
	if (currentChannel isNotEqualTo 5) then {
		if ((_player getSlotItemName 611) isNotEqualTo '') then {
			if (currentChannel in [0,1,6]) then {
				if (
					(!(_player getUnitTrait 'QS_trait_HQ')) &&
					{(!((getPlayerUID _player) in (['ALL'] call (missionNamespace getVariable 'QS_fnc_whitelist'))))}
				) then {
					setCurrentChannel 5;
					50 cutText [localize 'STR_QS_Text_032','PLAIN DOWN'];
					_c = TRUE;
				};
			} else {
				if (
					(currentChannel isEqualTo 7) &&
					{((['uavhacker','QS_trait_fighterPilot','QS_trait_pilot','QS_trait_CAS','QS_trait_HQ'] findIf { _player getUnitTrait _x }) isEqualTo -1)} &&
					{(!((getPlayerUID _player) in (['ALL'] call (missionNamespace getVariable 'QS_fnc_whitelist'))))}
				) then {
					setCurrentChannel 5;
					50 cutText [localize 'STR_QS_Text_035','PLAIN DOWN'];
					_c = TRUE;
				};	
			};
		} else {
			setCurrentChannel 5;
			50 cutText [localize 'STR_QS_Text_003','PLAIN DOWN'];
			_c = TRUE;
		};
	};
};
if (_key in (actionKeys 'PushToTalkSide')) then {
	if (!(_player getUnitTrait 'QS_trait_HQ')) then {
		_c = TRUE;
	};
};
if (_key in 
	(
		(actionKeys 'PersonView') + 
		(actionKeys 'TacticalView') + 
		(actionKeys 'ForceCommandingMode')
	)
) then {
	if ((_player getVariable 'QS_1PV') # 0) then {
		_c = TRUE;
	};
	if (!isNull _cameraOn) then {
		if (
			((side _cameraOn) isEqualTo sideEnemy) &&
			{(cameraView isEqualTo 'INTERNAL')}
		) then {
			_c = TRUE;
		};
		if (
			((side _cameraOn) in [EAST,RESISTANCE]) &&
			{(!(cameraView in ['INTERNAL','GUNNER']))} &&
			{((lifeState _player) isNotEqualTo 'INCAPACITATED')} &&
			{((missionNamespace getVariable ['QS_missionConfig_aoType','CLASSIC']) in ['CLASSIC','SC','GRID','ZEUS'])}
		) then {
			50 cutText [localize 'STR_QS_Text_024','PLAIN DOWN',0.5];
			_player switchCamera 'INTERNAL';
			_c = TRUE;
		};
	};
	if (
		(missionNamespace getVariable ['QS_missionConfig_plane1PV',FALSE]) &&
		{(_cameraOn isKindOf 'Plane')} &&
		{(QS_player isEqualTo (currentPilot _cameraOn))}
	) then {
		if (cameraView isNotEqualTo 'INTERNAL') then {
			QS_player switchCamera 'INTERNAL';
		};
		_c = TRUE;
	};
};
if (_c) exitWith {_c};
if (_key in (actionKeys 'AutoHover')) then {
	if (
		(cameraOn isKindOf 'Helicopter') &&
		{(!(missionNamespace getVariable ['QS_missionConfig_autohover',TRUE]))}
	) then {
		cameraOn spawn {
			sleep 0.1;
			action ['autohovercancel',_this];
		};
		_c = TRUE;
	};
};
// Admin menu
if (
	((actionKeys 'User11') isEqualTo []) &&
	{(
		_shift &&
		{(_key isEqualTo 60)} &&
		{((lifeState _player) in ['HEALTHY','INJURED'])}
	)}
) then {
	[['KeyDown','Curator'] select (!isNull curatorCamera)] call (missionNamespace getVariable 'QS_fnc_clientMenuStaff');
	_c = TRUE;
};
if (
	(_ctrl || _alt) &&
	{(_key in (actionKeys 'ReloadMagazine'))} &&
	{((isNull (objectParent _player)) || {(_player isNotEqualTo (driver (vehicle _player)))})} &&
	{(!(_player call QS_fnc_isBusyAttached))}
) then {
	if (_cameraOn in [QS_player,objectParent QS_player]) then {
		QS_player spawn (missionNamespace getVariable 'QS_fnc_clientRepackMagazines');
	};
};
if (_key in (actionKeys 'VehLockTargets')) then {};
if (_key in (actionKeys 'Zeus')) then {}; 
if (
	_ctrl &&
	{(_key in [0x4C,0x4B,0x47,0x48,0x49,0x4D,0x51])} &&
	{(isNull (objectParent _cameraOn))} &&
	{((stance _cameraOn) in ['STAND','CROUCH'])} &&
	{(!(captive _cameraOn))} &&
	{((lifeState _cameraOn) in ['HEALTHY','INJURED'])} &&
	{(time > (_cameraOn getVariable ['QS_client_lastGesture',-1]))}
) exitWith {
	_c = TRUE;
	_cameraOn setVariable ['QS_client_lastGesture',(time + 3),FALSE];
	private _order = '';
	if (_key isEqualTo 0x4C) exitWith {
		_cameraOn playActionNow (selectRandom ['gestureNo']);
		50 cutText [localize 'STR_QS_Text_036','PLAIN DOWN',0.5];
	};
	if (_key isEqualTo 0x4B) exitWith {
		_cameraOn playActionNow (selectRandom ['gestureGo']);
		_order = localize 'STR_QS_Text_037';
		50 cutText [_order,'PLAIN DOWN',0.5];
	};
	if (_key isEqualTo 0x47) exitWith {
		_cameraOn playActionNow (selectRandom ['gesturePoint','gestureAdvance']);
		_order = localize 'STR_QS_Text_038';
		50 cutText [_order,'PLAIN DOWN',0.5];
	};
	if (_key isEqualTo 0x48) exitWith {
		_cameraOn playActionNow (selectRandom ['gestureNod']);
	};
	if (_key isEqualTo 0x49) exitWith {
		_cameraOn playActionNow (selectRandom ['gestureFreeze']);
		_order = localize 'STR_QS_Text_039';
		50 cutText [_order,'PLAIN DOWN',0.5];
	};
	if (_key isEqualTo 0x4D) exitWith {
		_cameraOn playActionNow (selectRandom ['gestureHi']);
	};
	if (_key isEqualTo 0x51) exitWith {
		_cameraOn playActionNow (selectRandom ['gestureCeaseFire']);
		_order = localize 'STR_QS_Text_040';
		50 cutText [_order,'PLAIN DOWN',0.5];
	};
	if (
		(_order isNotEqualTo '') &&
		{(isPlayer _cameraOn)} &&
		{(isNull (objectParent _cameraOn))} &&
		{(_cameraOn isEqualTo (leader (group _cameraOn)))} &&
		{((count ((units (group _cameraOn)) inAreaArray [_cameraOn,50,50,0,FALSE])) > 1)}
	) then {
		_arrayToSend = ((units (group _cameraOn)) inAreaArray [_cameraOn,50,50,0,FALSE]) select {(_x isNotEqualTo _cameraOn) && ((lifeState _x) in ['HEALTHY','INJURED']) && (isPlayer _x)};
		if (_arrayToSend isNotEqualTo []) then {
			[63,[5,[(format ['%1: %2',profileName,_order]),'PLAIN DOWN',0.333]]] remoteExec ['QS_fnc_remoteExec',_arrayToSend,FALSE];
		};
	};
	_c;
};
if (_key in (actionKeys 'TacticalPing')) then {};
if (
	((actionKeys 'uavViewToggle') isEqualTo []) &&
	{(_key isEqualTo 15)} &&
	{(local _cameraOn)} &&
	{(_cameraOn isKindOf 'Helicopter')} &&
	{(_player isEqualTo (currentPilot _cameraOn))} &&
	{(diag_tickTime > (uiNamespace getVariable ['QS_pilot_lastRappellSafetyToggle',-1]))}
) then {
	uiNamespace setVariable ['QS_pilot_lastRappellSafetyToggle',diag_tickTime + 3];
	if (!(_cameraOn getVariable ['QS_rappellSafety',FALSE])) then {
		_cameraOn setVariable ['QS_rappellSafety',TRUE,TRUE];
		50 cutText [localize 'STR_QS_Text_041','PLAIN DOWN',1];
	} else {
		_cameraOn setVariable ['QS_rappellSafety',FALSE,TRUE];
		50 cutText [localize 'STR_QS_Text_042','PLAIN DOWN',1];
	};
};
if (
	(_key in (actionKeys 'gunElevUp')) ||
	{(_key in (actionKeys 'User18'))} ||
	{((_key in (actionKeys 'HeliRopeAction')) && _ctrl)}
) then {
	if (
		(local _cameraOn) ||
		{((_cameraOn isKindOf 'heli_transport_04_base_f') && (_player isEqualTo (_cameraOn turretUnit [1])))}
	) then {
		if (!isNull (getSlingLoad _cameraOn)) then {
			if (!('SlingLoadDisplay' in ((infoPanel 'left') + (infoPanel 'right')))) then {
				if ('EmptyDisplay' in (infoPanel 'left')) then {
					setInfoPanel ['left','SlingLoadDisplay'];
				} else {
					if ('EmptyDisplay' in (infoPanel 'right')) then {
						setInfoPanel ['right','SlingLoadDisplay'];
					} else {
						setInfoPanel ['left','SlingLoadDisplay'];
					};
				};
			};
			if ((_player isEqualTo (driver _cameraOn)) || {((_cameraOn isKindOf 'heli_transport_04_base_f') && (_player isEqualTo (_cameraOn turretUnit [1])))}) then {
				if (diag_tickTime > (player getVariable ['QS_sling_keyDownDelay',-1])) then {
					player setVariable ['QS_sling_keyDownDelay',(diag_tickTime + 0.5),FALSE];
					_c = TRUE;
					['UP'] call (missionNamespace getVariable 'QS_fnc_slingRope');
				};
			} else {
				_c = TRUE;
			};
		} else {
			if ((ropeAttachedObjects _cameraOn) isNotEqualTo []) then {
				_c = TRUE;
				['MODE22',_cameraOn,TRUE] call QS_fnc_simplePull;
			} else {
				if (!isNull (ropeAttachedTo _cameraOn)) then {
					['MODE17',_cameraOn,TRUE] call QS_fnc_simpleWinch;
					_c = TRUE;
				};
			};
			if (!_c) then {
				_winch_helper = missionNamespace getVariable ['QS_winch_globalHelperObject',objNull];
				if (isNull _winch_helper) then {
					_winch_helper = missionNamespace getVariable ['QS_winch_activeVehicle',objNull];
				};
				if (
					(!isNull _winch_helper) &&
					{((ropes _winch_helper) isNotEqualTo [])}
				) then {
					(ropeEndPosition ((ropes _winch_helper) # 0)) params [
						['_startPos',[0,0,0]],
						['_endPos',[0,0,0]]
					];
					if (
						((_cameraOn distance _startPos) < 5) ||
						((_cameraOn distance _endPos) < 5)
					) then {
						_ropeDistance = _startPos distance _endPos;
						_child = (ropeAttachedObjects _winch_helper) # 0;
						_ropeLength = ropeLength ((ropes _winch_helper) # 0);
						if (
							((vectorMagnitude (velocity _child)) < 0.1) &&
							{(_ropeDistance > (_ropeLength * 1.5))}
						) then {
							if (local _child) then {
								if (!brakesDisabled _child) then {
									_child disableBrakes TRUE;
								};
								_child setVelocityModelSpace [0,1,0];
							} else {
								if (diag_tickTime > (uiNamespace getVariable ['QS_winch_lastRXTime',-1])) then {
									uiNamespace setVariable ['QS_winch_lastRXTime',diag_tickTime + 3];
									if (!brakesDisabled _child) then {
										['disableBrakes',_child,TRUE] remoteExec ['QS_fnc_remoteExecCmd',_child,FALSE];
									};
									['setVelocityModelSpace',_child,[0,1,0]] remoteExec ['QS_fnc_remoteExecCmd',_child,FALSE];
								};
							};
						};
						['MODE17',_winch_helper,TRUE] call QS_fnc_simpleWinch;
						_c = TRUE;
					};
				};
				if (!_c) then {
					_nearRopeSegments = (_cameraOn nearObjects 5) select {_x isKindOf 'RopeSegment'};
					if (_nearRopeSegments isNotEqualTo []) then {
						_nearRopeSegments = _nearRopeSegments apply { [_cameraOn distance _x,_x] };
						_nearRopeSegments sort TRUE;
						_nearRopeSegment = (_nearRopeSegments # 0) # 1;
						_nearRope = objectParent _nearRopeSegment;
						_ropeRelation = _nearRope getVariable ['QS_rope_relation',[]];
						if (_ropeRelation isNotEqualTo []) then {
							_c = TRUE;
							_ropeRelation params ['_parent','_child1','_type3'];
							(ropeEndPosition _nearRope) params [
								['_startPos',[0,0,0]],
								['_endPos',[0,0,0]]
							];
							_ropeDistance = _startPos distance _endPos;
							_ropeLength = ropeLength _nearRope;
							if (
								(((_cameraOn distance _startPos) < 5) || ((_cameraOn distance _endPos) < 5)) &&
								{((vectorMagnitude (velocity _child1)) < 0.1)} &&
								{(_ropeDistance > (_ropeLength * 1.2))}
							) then {
								if (local _child1) then {
									if (!brakesDisabled _child1) then {
										_child1 disableBrakes TRUE;
									};
									_child1 setVelocityModelSpace [0,1,0];
								} else {
									if (diag_tickTime > (uiNamespace getVariable ['QS_winch_lastRXTime',-1])) then {
										uiNamespace setVariable ['QS_winch_lastRXTime',diag_tickTime + 3];
										if (!brakesDisabled _child1) then {
											['disableBrakes',_child1,TRUE] remoteExec ['QS_fnc_remoteExecCmd',_child1,FALSE];
										};
										['setVelocityModelSpace',_child1,[0,1,0]] remoteExec ['QS_fnc_remoteExecCmd',_child1,FALSE];
									};
								};
							};
							if (_type3 isEqualTo 'PULL') then {
								['MODE22',_parent,TRUE] call QS_fnc_simplePull;
							};
							if (_type3 isEqualTo 'WINCH') then {
								['MODE17',_parent,TRUE] call QS_fnc_simpleWinch;
							};
						};
					};
				};
			};
		};
	};
};
if (
	(_key in (actionKeys 'gunElevDown')) ||
	{(_key in (actionKeys 'User17'))} ||
	{((_key in (actionKeys 'HeliRopeAction')) && _alt)}
) then {
	if (
		(local _cameraOn) ||
		{((_cameraOn isKindOf 'heli_transport_04_base_f') && (_player isEqualTo (_cameraOn turretUnit [1])))}
	) then {
		if (!isNull (getSlingLoad _cameraOn)) then {
			if (!('SlingLoadDisplay' in ((infoPanel 'left') + (infoPanel 'right')))) then {
				if ('EmptyDisplay' in (infoPanel 'left')) then {
					setInfoPanel ['left','SlingLoadDisplay'];
				} else {
					if ('EmptyDisplay' in (infoPanel 'right')) then {
						setInfoPanel ['right','SlingLoadDisplay'];
					} else {
						setInfoPanel ['left','SlingLoadDisplay'];
					};
				};
			};
			if (
				(_player isEqualTo (driver _cameraOn)) || 
				{((_cameraOn isKindOf 'heli_transport_04_base_f') && (_player isEqualTo (_cameraOn turretUnit [1])))}
			) then {
				if (diag_tickTime > (player getVariable ['QS_sling_keyDownDelay',-1])) then {
					player setVariable ['QS_sling_keyDownDelay',(diag_tickTime + 0.5),FALSE];
					_c = TRUE;
					['DOWN'] call (missionNamespace getVariable 'QS_fnc_slingRope');
				};
			} else {
				_c = TRUE;
			};
		} else {
			if ((ropeAttachedObjects _cameraOn) isNotEqualTo []) then {
				_c = TRUE;
				['MODE22',_cameraOn,FALSE] call QS_fnc_simplePull;
			} else {
				if (!isNull (ropeAttachedTo _cameraOn)) then {
					['MODE17',_cameraOn,FALSE] call QS_fnc_simpleWinch;
					_c = TRUE;
				};
			};
			if (!_c) then {
				_winch_helper = missionNamespace getVariable ['QS_winch_globalHelperObject',objNull];
				if (isNull _winch_helper) then {
					_winch_helper = missionNamespace getVariable ['QS_winch_activeVehicle',objNull];
				};
				if (
					(!isNull _winch_helper) &&
					{((ropes _winch_helper) isNotEqualTo [])}
				) then {
					(ropeEndPosition ((ropes _winch_helper) # 0)) params [
						['_startPos',[0,0,0]],
						['_endPos',[0,0,0]]
					];
					if (
						((_cameraOn distance _startPos) < 5) ||
						((_cameraOn distance _endPos) < 5)
					) then {
						_ropeDistance = _startPos distance _endPos;
						_child = (ropeAttachedObjects _winch_helper) # 0;
						_ropeLength = ropeLength ((ropes _winch_helper) # 0);
						if (
							((vectorMagnitude (velocity _child)) < 0.1) &&
							{(_ropeDistance < (_ropeLength / 1.5))}
						) then {
							if (local _child) then {
								if (!brakesDisabled _child) then {
									_child disableBrakes TRUE;
								};
							} else {
								if (diag_tickTime > (uiNamespace getVariable ['QS_winch_lastRXTime',-1])) then {
									uiNamespace setVariable ['QS_winch_lastRXTime',diag_tickTime + 3];
									if (!brakesDisabled _child) then {
										['disableBrakes',_child,TRUE] remoteExec ['QS_fnc_remoteExecCmd',_child,FALSE];
									};
								};
							};
						};
						['MODE17',_winch_helper,FALSE] call QS_fnc_simpleWinch;
						_c = TRUE;
					};
				};
				if (!_c) then {
					_nearRopeSegments = (_cameraOn nearObjects 3) select {_x isKindOf 'RopeSegment'};
					if (_nearRopeSegments isNotEqualTo []) then {
						_nearRopeSegments = _nearRopeSegments apply { [_cameraOn distance _x,_x] };
						_nearRopeSegments sort TRUE;
						_nearRopeSegment = (_nearRopeSegments # 0) # 1;
						_nearRope = objectParent _nearRopeSegment;
						_ropeRelation = _nearRope getVariable ['QS_rope_relation',[]];
						if (_ropeRelation isNotEqualTo []) then {
							_c = TRUE;
							_ropeRelation params ['_parent','_child1','_type'];
							(ropeEndPosition _nearRope) params [
								['_startPos',[0,0,0]],
								['_endPos',[0,0,0]]
							];
							_ropeDistance = _startPos distance _endPos;
							_ropeLength = ropeLength _nearRope;
							if (
								(((_cameraOn distance _startPos) < 3) || ((_cameraOn distance _endPos) < 3)) &&
								{((vectorMagnitude (velocity _child1)) < 0.1)} &&
								{(_ropeDistance > (_ropeLength * 1.1))}
							) then {
								if (local _child1) then {
									if (!brakesDisabled _child1) then {
										_child1 disableBrakes TRUE;
									};
									_child1 setVelocityModelSpace [0,1,0];
								} else {
									if (diag_tickTime > (uiNamespace getVariable ['QS_winch_lastRXTime',-1])) then {
										uiNamespace setVariable ['QS_winch_lastRXTime',diag_tickTime + 3];
										if (!brakesDisabled _child1) then {
											['disableBrakes',_child1,TRUE] remoteExec ['QS_fnc_remoteExecCmd',_child1,FALSE];
										};
										['setVelocityModelSpace',_child1,[0,1,0]] remoteExec ['QS_fnc_remoteExecCmd',_child1,FALSE];
									};
								};
							};
							if (_type isEqualTo 'PULL') then {
								['MODE22',_parent,FALSE] call QS_fnc_simplePull;
							};
							if (_type isEqualTo 'WINCH') then {
								['MODE17',_parent,FALSE] call QS_fnc_simpleWinch;
							};
						};
					};
				};
			};
		};
	};
};
if (_key in (actionKeys 'HeliRopeAction')) then {
	if ((!(_alt)) && (!(_ctrl))) then {
		if (!(_c)) then {
			if (_cameraOn isKindOf 'Helicopter') then {
				if (
					(local _cameraOn) ||
					{((_cameraOn isKindOf 'heli_transport_04_base_f') && (_player isEqualTo (_cameraOn turretUnit [1])))}
				) then {
					if (!('SlingLoadDisplay' in ((infoPanel 'left') + (infoPanel 'right')))) then {
						if ('EmptyDisplay' in (infoPanel 'left')) then {
							setInfoPanel ['left','SlingLoadDisplay'];
						} else {
							if ('EmptyDisplay' in (infoPanel 'right')) then {
								setInfoPanel ['right','SlingLoadDisplay'];
							} else {
								setInfoPanel ['left','SlingLoadDisplay'];
							};
						};
					};
					if (
						(_player isEqualTo (driver _cameraOn)) || 
						{((_cameraOn isKindOf 'heli_transport_04_base_f') && (_player isEqualTo (_cameraOn turretUnit [1])))}
					) then {
						if (diag_tickTime > (player getVariable ['QS_sling_keyDownDelay',-1])) then {
							player setVariable ['QS_sling_keyDownDelay',(diag_tickTime + 0.5),FALSE];
							if ((!isNull (getSlingLoad _cameraOn)) || {(!isNull (_cameraOn getVariable ['QS_sling_attached',objNull]))}) then {
								if ((!isNull (getSlingLoad _cameraOn)) && {((getSlingLoad _cameraOn) in (attachedObjects _cameraOn))}) then {
									_c = TRUE;
									['DOWN'] call (missionNamespace getVariable 'QS_fnc_slingRope');
								};
								if (!(_c)) then {
									if ((!isNull (_cameraOn getVariable ['QS_sling_attached',objNull])) && {((_cameraOn getVariable ['QS_sling_attached',objNull]) in (attachedObjects _cameraOn))}) then {
										_c = TRUE;
										['DOWN'] call (missionNamespace getVariable 'QS_fnc_slingRope');
									};
								};
							};
						} else {
							_c = TRUE;
						};
					} else {
						_c = TRUE;
					};
				} else {
					_c = TRUE;
				};
			};
		};
	} else {
		_c = TRUE;
	};
};
if (_key in (actionKeys 'openDlcScreen')) then {
	_DLCsOwned = getDLCs 1;
	if ((304400 in _DLCsOwned) || {((288520 in _DLCsOwned) && (304380 in _DLCsOwned) && (332350 in _DLCsOwned))}) then {
		if (scriptDone QS_script_closeDLCs) then {
			QS_script_closeDLCs = 0 spawn {
				_t = time + 1;
				waitUntil {
					(time > _t) ||
					(!isNull (findDisplay 174))
				};
				if (!isNull (findDisplay 174)) then {
					(findDisplay 174) closeDisplay 2;
				};
			};
		};
	};
};
if (_key isEqualTo 0x39) then {
	if (diag_tickTime > (missionNamespace getVariable ['QS_interact_doorLastOpenTime',(diag_tickTime - 1)])) then {
		missionNamespace setVariable ['QS_interact_doorLastOpenTime',(diag_tickTime + 1),FALSE];
		private _val = 2;
		if (cameraView isEqualTo 'EXTERNAL') then {
			_val = 4.55;
		};
		_c = _val call (missionNamespace getVariable 'QS_fnc_clientInteractDoor');
	};
};
if (
	(_key in (actionKeys 'NavigateMenu')) &&
	{(commandingMenu isEqualTo '')}
) then {
	if (missionNamespace getVariable ['QS_missionStatus_shown',FALSE]) then {
		missionNamespace setVariable ['QS_missionStatus_shown',FALSE,FALSE];
	} else {
		missionNamespace setVariable ['QS_missionStatus_shown',TRUE,FALSE];
	};
	_c = TRUE;
};
/*/
if (
	(_key in (actionKeys 'TeamSwitch')) &&
	{(!(_shift))} &&
	{(!(_ctrl))}
) then {
	if (uiNamespace isNil 'BIS_dynamicGroups_keyDownTime') then {
		uiNamespace setVariable ['BIS_dynamicGroups_keyDownTime',time];
		uiNamespace setVariable ['BIS_dynamicGroups_ignoreInterfaceOpening',nil];
	};
	['UpdateKeyDown'] call (missionNamespace getVariable 'BIS_fnc_dynamicGroups');
	_c = TRUE;
};
/*/
if (_key in (actionKeys 'help')) then {
	if ((!(_shift)) && (!(_ctrl)) && (!(_alt))) then {
		if (diag_tickTime > (uiNamespace getVariable ['QS_hint_lastKeyDown',-1])) then {
			uiNamespace setVariable ['QS_hint_lastKeyDown',(diag_tickTime + 0.25)];
			missionNamespace setVariable ['BIS_fnc_advHint_HPressed',TRUE,FALSE];
			missionNamespace setVariable ['BIS_fnc_advHint_RefreshCtrl',TRUE,FALSE];
			if (uiNamespace getVariable ['QS_hint_opened',FALSE]) then {
				playSound 'HintCollapse';
				[''] call (missionNamespace getVariable 'QS_fnc_hint');
			} else {
				if ((uiNamespace getVariable ['QS_hint_recalledHint',[]]) isNotEqualTo []) then {
					playSound 'HintExpand';
					(uiNamespace getVariable ['QS_hint_recalledHint',[]]) call (missionNamespace getVariable 'QS_fnc_hint');
				};
			};
		};
		_c = TRUE;
	};
};
if (
	(_key in (actionKeys 'deployWeaponAuto')) &&
	(!((lifeState _player) in ['HEALTHY','INJURED']))
) then {
	_c = TRUE;
};
if (
	(_key in (actionKeys 'HeliManualFire')) &&
	{(!isNull (objectParent _player))} &&
	{(local (objectParent _player))} &&
	{(isManualFire (objectParent _player))}
) then {
	([_player,'SAFE'] call QS_fnc_inZone) params ['_inSafezone','_safezoneLevel','_safezoneActive'];
	_c = _inSafezone && _safezoneActive && (_safezoneLevel > 1);
	if (_c) then {
		50 cutText [localize 'STR_QS_Text_075','PLAIN DOWN',0.5];
	};
};
_c;