/*/
File: fn_simpleWinch.sqf
Author:

	Quiksilver
	
Last Modified:

	11/03/2023 A3 2.12 by Quiksilver
	
Description:

	Simple Winch
	
Notes:

	Applies only to vanilla vehicles with visible winches
	
	To apply to other vehicles, set this variable to vehicle:
	
		<vehicle> setVariable ['QS_winch_enabled',true];
___________________________________________/*/

params ['_mode'];
if (_mode isEqualTo 'MODE0') exitWith {
	params ['','_vehicle','_toggle'];
	_attached = ropeAttachedObjects _vehicle;
	if (_attached isNotEqualTo []) then {
		private _child = _attached # 0;
		if (
			(_child isKindOf 'Car') || 
			{(_child isKindOf 'Tank')}
		) then {
			if (
				(_toggle && (!brakesDisabled _child)) ||
				{(!_toggle && (brakesDisabled _child))}
			) then {
				if (local _child) then {
					_child disableBrakes _toggle;
				} else {
					if (diag_tickTime > (uiNamespace getVariable ['QS_winch_lastRXTime',-1])) then {
						uiNamespace setVariable ['QS_winch_lastRXTime',diag_tickTime + 5];
						missionNamespace setVariable ['QS_RE_CMD',[[_child,_toggle],['disableBrakes',_child,FALSE]],2];
						['disableBrakes',_child,_toggle] remoteExec ['QS_fnc_remoteExecCmd',_child,FALSE];
					};
				};
			};
		};
		['MODE0',_child,_toggle] call QS_fnc_simpleWinch;
	};
};
if (_mode isEqualTo 'MODE1') exitWith {
	params ['','_vehicle'];
	_attached = ropeAttachedObjects _vehicle;
	if (_attached isNotEqualTo []) then {
		private _child = _attached # 0;
		if (
			(_child isKindOf 'Car') || 
			{(_child isKindOf 'Tank')}
		) then {
			if (brakesDisabled _child) then {
				if (local _child) then {
					_child disableBrakes FALSE;
				} else {
					if (diag_tickTime > (uiNamespace getVariable ['QS_winch_lastRXTime',-1])) then {
						uiNamespace setVariable ['QS_winch_lastRXTime',diag_tickTime + 5];
						missionNamespace setVariable ['QS_RE_CMD',[[_child,FALSE],['disableBrakes',_child,FALSE]],2];
						['disableBrakes',_child,FALSE] remoteExec ['QS_fnc_remoteExecCmd',_child,FALSE];
					};
				};
			};
		};
		['MODE1',_child] call QS_fnc_simpleWinch;
	};
};
if (_mode isEqualTo 'MODE2') exitWith {
	params ['','_vehicle'];
	_attached = ropeAttachedObjects _vehicle;
	if (_attached isNotEqualTo []) then {
		private _child = _attached # 0;
		if (
			(_child isKindOf 'Car') || 
			{(_child isKindOf 'Tank')}
		) then {
			if (!brakesDisabled _child) then {
				if (local _child) then {
					_child disableBrakes TRUE;
				} else {
					if (diag_tickTime > (uiNamespace getVariable ['QS_winch_lastRXTime',-1])) then {
						uiNamespace setVariable ['QS_winch_lastRXTime',diag_tickTime + 5];
						missionNamespace setVariable ['QS_RE_CMD',[[_child,TRUE],['disableBrakes',_child,FALSE]],2];
						['disableBrakes',_child,TRUE] remoteExec ['QS_fnc_remoteExecCmd',_child,FALSE];
					};
				};
			};
		};
		['MODE2',_child] call QS_fnc_simpleWinch;
	};
};
if (_mode isEqualTo 'MODE3') exitWith {
	params ['','_vehicle'];
	if (!isGameFocused) exitWith {};
	_attached = ropeAttachedObjects _vehicle;
	if (_attached isNotEqualTo []) then {
		_ropeLengthMod = ropeLength ((ropes _vehicle) # 0);
		private _child = _attached # 0;
		if (
			((vectorMagnitude (velocity _child)) < 0.1) &&
			{((_vehicle distance _child) > _ropeLengthMod)}
		) then {
			if (local _child) then {
				if (!brakesDisabled _child) then {
					_child disableBrakes TRUE;
				};
				_child setVelocityModelSpace [0,1,1];
			} else {
				if (diag_tickTime > (uiNamespace getVariable ['QS_winch_lastRXTime',-1])) then {
					uiNamespace setVariable ['QS_winch_lastRXTime',diag_tickTime + 5];
					if (!brakesDisabled _child) then {
						missionNamespace setVariable ['QS_RE_CMD',[[_child,TRUE],['disableBrakes',_child,FALSE]],2];
						['disableBrakes',_child,TRUE] remoteExec ['QS_fnc_remoteExecCmd',_child,FALSE];
					};
					missionNamespace setVariable ['QS_RE_CMD',[[_child,[0,1,1]],['setVelocityModelSpace',_child,FALSE]],2];
					['setVelocityModelSpace',_child,[0,1,1]] remoteExec ['QS_fnc_remoteExecCmd',_child,FALSE];
				};
			};
		};
		['MODE3',_child] call QS_fnc_simpleWinch;
	};
};
if (_mode isEqualTo 'MODE4') exitWith {
	params ['',['_rope',objNull],['_child',objNull],['_parent',objNull],['_bypassPosCheck',FALSE]];
	_cameraOn = cameraOn;
	private _new = isNull _rope;
	getCursorObjectParams params ['_cursorObject','_cursorSelections','_cursorDistance'];
	private _attachPointInfo = ['MODE23',_cursorObject] call QS_fnc_simpleWinch;
	if (
		(!isNull _rope) ||
		{(
			(isNull _rope) &&
			{(
				(alive _cursorObject) &&
				{(((local _cursorObject) && _new) || (!_new))} &&
				{(_attachPointInfo # 0)} &&
				{(_cursorDistance < 3)} &&
				{(((_cameraOn distance (_cursorObject modelToWorld (_attachPointInfo # 1))) < 3) || _bypassPosCheck)} &&
				{(simulationEnabled _cursorObject)} &&
				{(ropeAttachEnabled _cursorObject)} &&
				{(isNull (attachedTo _cursorObject))} &&
				{(isNull (ropeAttachedTo _cursorObject))} &&
				{(isNull (isVehicleCargo _cursorObject))} &&
				{(!(_cursorObject getVariable ['QS_logistics_wreck',FALSE]))} &&
				{(!(_cursorObject getVariable ['QS_logistics_deployed',FALSE]))} &&
				{((ropeAttachedObjects _cursorObject) isEqualTo [])} &&
				{((ropes _cursorObject) isEqualTo [])} &&
				{(!(QS_player call QS_fnc_isBusyAttached))} &&
				{(!(missionNamespace getVariable ['QS_targetBoundingBox_placementMode',FALSE]))} &&
				{(((['MODE19',_cursorObject] call QS_fnc_simpleWinch) findAny ['SLING','PULL','WINCH']) isEqualTo -1)} &&
				{(isNull (missionNamespace getVariable ['QS_winch_globalHelperObject',objNull]))}
			)}
		)}
	) then {
		if (_new) then {
			_parent = _cursorObject;
			missionNamespace setVariable ['QS_winch_activeVehicle',_parent,FALSE];
			missionNamespace setVariable ['QS_winch_activePoint',_attachPointInfo # 1,FALSE];
		} else {
			_attachPointInfo = ['MODE23',_parent] call QS_fnc_simpleWinch;
			missionNamespace setVariable ['QS_winch_activeVehicle',_parent,FALSE];
			missionNamespace setVariable ['QS_winch_activePoint',_attachPointInfo # 1,FALSE];
		};
		if (isNil 'QS_winch_globalHelperObject') then {
			QS_winch_globalHelperObject = objNull;
		};
		if (isNull QS_winch_globalHelperObject) then {
			QS_winch_globalHelperObject = createVehicle ['Sign_Sphere10cm_F',(position player) vectorAdd [0,0,50]];
			QS_winch_globalHelperObject allowDamage FALSE;
			uiSleep (diag_deltaTime * 2);
			QS_winch_globalHelperObject enableRopeAttach TRUE;
			QS_winch_globalHelperObject enableSimulation TRUE;
			QS_winch_globalHelperObject setVariable ['QS_winch_helper',TRUE,TRUE];
			_timeout = diag_tickTime + 3;
			waitUntil {
				['hideObjectGlobal',QS_winch_globalHelperObject,TRUE] remoteExec ['QS_fnc_remoteExecCmd',2,FALSE];
				((isObjectHidden QS_winch_globalHelperObject) || (diag_tickTime > _timeout))
			};
		};
		QS_winch_globalHelperObject setVariable ['QS_winch_helper',TRUE,TRUE];
		QS_winch_globalHelperObject attachTo [player, [0,0,0.1],'lefthand',TRUE];
		//[1,QS_winch_globalHelperObject,[player, [0,0,0.1],'lefthand',TRUE]] call QS_fnc_eventAttach;
		player setVariable ['QS_winch_globalHelperObject',QS_winch_globalHelperObject,TRUE];
		_parent setVariable ['QS_rope_helperObjects',((_parent getVariable ['QS_rope_helperObjects',[]]) + [QS_winch_globalHelperObject]),TRUE];
		private _timeout = 0;
		uiNamespace setVariable ['QS_rope_monitor_wait',diag_tickTime + 1];
		if (isNil 'QS_winch_monitor') then {
			QS_winch_monitor = [];
		};
		if (_new) then {
			[109,['MODE25','MODE29',[_parent,(_attachPointInfo # 1),QS_winch_globalHelperObject,[0,0,0],20,['',[0, 1, 0]],['RopeEnd', [0, 1, 0]],'Rope']]] remoteExecCall ['QS_fnc_remoteExec',2,FALSE];
			_timeout = diag_tickTime + 3;
			waitUntil {
				(((ropes _parent) isNotEqualTo []) || (diag_tickTime > _timeout))
			};
			QS_winch_rope = (ropes _parent) # 0;
			QS_winch_monitor pushBack [QS_winch_rope,_parent,QS_winch_globalHelperObject,QS_winch_globalHelperObject,FALSE];
		} else {
			QS_winch_rope = _rope;
			[109,['MODE25','MODE30',[_child,[QS_winch_globalHelperObject,[0,0,0],[0,0,-1]],QS_winch_rope,clientOwner,FALSE]]] remoteExecCall ['QS_fnc_remoteExec',2,FALSE];
			_timeout = diag_tickTime + 3;
			waitUntil {
				(((ropeAttachedTo QS_winch_globalHelperObject) isEqualTo _parent) || (diag_tickTime > _timeout))
			};
			_index = QS_winch_monitor findIf {(_x # 0) isEqualTo QS_winch_rope};
			if (_index isNotEqualTo -1) then {
				_element = QS_winch_monitor # _index;
				_element set [0,QS_winch_rope];
				_element set [2,QS_winch_globalHelperObject];
				_element set [3,QS_winch_globalHelperObject];
				QS_winch_monitor set [_index,_element];
			};
		};
		if (!(_parent getVariable ['QS_winch_server',FALSE])) then {
			[109,['MODE25','MODE27',_parent]] remoteExecCall ['QS_fnc_remoteExec',2,FALSE];
		};
		if (!((toLowerANSI (pose QS_player)) in ['swimming','surfaceswimming'])) then {
			_cameraOn playActionNow 'PutDown';
		};
		uiNamespace setVariable ['QS_rope_monitor_wait',diag_tickTime + 1];
		['MODE24'] call QS_fnc_simpleWinch;
		['MODE21'] call QS_fnc_simpleWinch;
	} else {
		if (!local _cursorObject) exitWith {50 cutText [localize 'STR_QS_Text_334','PLAIN DOWN',0.75];};
	};
};
if (_mode isEqualTo 'MODE5') exitWith {
	params ['','_player1'];
	getCursorObjectParams params ['_cursorObject1','','_cursorDistance1'];
	private _return1 = FALSE;
	if (
		(cameraOn isEqualTo _player1) &&
		{(alive _cursorObject1)} &&
		{(simulationEnabled _cursorObject1)} &&
		{(_cursorDistance1 < 2.5)} &&
		{(((['Car','Tank','Wheeled_APC_F'] findIf { _cursorObject1 isKindOf _x }) isNotEqualTo -1) || (_cursorObject1 getVariable ['QS_winch_enabled',FALSE]))} &&
		{(ropeAttachEnabled _cursorObject1)} &&
		{(isNull (attachedTo _cursorObject1))} &&
		{(isNull (ropeAttachedTo _cursorObject1))} &&
		{(isNull (isVehicleCargo _cursorObject1))} &&
		{((ropeAttachedObjects _cursorObject1) isEqualTo [])} &&
		{((ropes _cursorObject1) isEqualTo [])} &&
		{(!(_cursorObject1 getVariable ['QS_logistics_wreck',FALSE]))} &&
		{(!(_cursorObject1 getVariable ['QS_logistics_deployed',FALSE]))} &&
		{(((['MODE19',_cursorObject1] call QS_fnc_simpleWinch) findAny ['SLING','PULL','WINCH']) isEqualTo -1)} &&
		{(isNull (missionNamespace getVariable ['QS_winch_globalHelperObject',objNull]))} &&
		{(!(missionNamespace getVariable ['QS_targetBoundingBox_placementMode',FALSE]))} &&
		{(!((getPlayerUID player) in QS_blacklist_logistics))}
	) then {
		_attachPointInfo = ['MODE23',_cursorObject1] call QS_fnc_simpleWinch;
		_relDir = _player1 getRelDir (_cursorObject1 modelToWorld (_attachPointInfo # 1));
		if (
			(_attachPointInfo # 0) &&
			{((_player1 distance (_cursorObject1 modelToWorld (_attachPointInfo # 1))) < 3)} &&
			{((_relDir > 330) || (_relDir < 30))}
		) then {
			_return1 = TRUE;
		};
	};
	_return1;
};
if (_mode isEqualTo 'MODE6') exitWith {
	_this spawn {
		uiSleep 0.1;
		_winchTargetInfo = missionNamespace getVariable ['QS_winch_target',[FALSE,objNull,[0,0,0],FALSE]];
		_activeVehicle = missionNamespace getVariable ['QS_winch_activeVehicle',objNull];
		_targetVehicle = _winchTargetInfo # 1;
		if (
			(_activeVehicle isEqualTo _targetVehicle) ||
			{((['CAManBase','Rope','RopeSegment'] findIf { _targetVehicle isKindOf _x }) isNotEqualTo -1)}
		) exitWith {
			playSoundUI ['addItemFailed', 0.5, 1.5];
			50 cutText [localize 'STR_QS_Text_332','PLAIN',1];
		};
		if (
			((ropes _targetVehicle) isNotEqualTo []) ||
			{((ropeAttachedObjects _targetVehicle) isNotEqualTo [])} ||
			{(!isNull (ropeAttachedTo _targetVehicle))} ||
			{(!isNull (attachedTo _targetVehicle))} ||
			{(!isNull (isVehicleCargo _targetVehicle))} ||
			{(((['MODE19',_targetVehicle] call QS_fnc_simpleWinch) findAny ['SLING','PULL']) isNotEqualTo -1)} ||
			{(['MODE12',_targetVehicle] call QS_fnc_simpleWinch)}
		) exitWith {
			playSoundUI ['addItemFailed', 0.5, 1.5];
			50 cutText [localize 'STR_QS_Text_331','PLAIN',1];
		};
		playSoundUI ['click', 0.5, 1.5];
		uiNamespace setVariable ['QS_rope_monitor_wait',diag_tickTime + 1];
		if (
			((damage _targetVehicle) isEqualTo 1) &&
			(!(_targetVehicle isKindOf 'AllVehicles'))
		) exitWith {50 cutText [localize 'STR_QS_Text_333','PLAIN',1];};
		if (!((toLowerANSI (pose QS_player)) in ['swimming','surfaceswimming'])) then {
			cameraOn playActionNow 'PutDown';
		};
		_localhelper = missionNamespace getVariable ['QS_winch_localHelperObject',objNull];
		if (!isNull _localhelper) then {
			_localhelper hideObject TRUE;
		};
		if (_winchTargetInfo # 3) exitWith {
			_index = QS_winch_monitor findIf {(_x # 0) isEqualTo QS_winch_rope};
			_parent = _activeVehicle;
			_parent setVariable ['QS_rope_mode',3,TRUE];
			_oldHelper = QS_winch_globalHelperObject;
			_newHelperType = 'B_static_AA_F';
			QS_winch_tempObject = objNull;
			private _timeout = diag_tickTime + 5;
			waitUntil {
				[109,['MODE25','MODE26','QS_winch_tempObject',_newHelperType,clientOwner]] remoteExecCall ['QS_fnc_remoteExec',2,FALSE];
				((!isNull QS_winch_tempObject) || (diag_tickTime > _timeout))
			};
			if (isNull QS_winch_tempObject) exitWith {50 cutText [localize 'STR_QS_Text_335','PLAIN',0.5];};
			_newHelper = QS_winch_tempObject;
			[0,QS_winch_globalHelperObject] call QS_fnc_eventAttach;
			_newHelper setPosWorld (getPosWorld QS_winch_globalHelperObject);
			_newHelper setVariable ['QS_winch_pos',(getPosWorld QS_winch_localHelperObject)];
			_newHelper setVariable ['QS_winch_surfaceObject',[_targetVehicle,(getPosWorld _targetVehicle)],TRUE];
			['MODE14',QS_winch_globalHelperObject,_newHelper] call QS_fnc_simpleWinch;
			_rope = QS_winch_rope;
			['MODE25','MODE34',[_parent,_newHelper,_rope,(ropeLength _rope) * 1.1,clientOwner,_index]] call QS_fnc_simpleWinch;
			[localize 'STR_QS_Hints_167',TRUE,TRUE,localize 'STR_QS_Hints_166',TRUE] call QS_fnc_hint;
		};
		_targetVehicle setVariable ['QS_rope_mode',2,TRUE];
		_activeVehicle setVariable ['QS_rope_mode',2,TRUE];
		[109,['MODE25','MODE30',[QS_winch_globalHelperObject,[_targetVehicle,(_targetVehicle worldToModel (ASLToAGL (_winchTargetInfo # 2))),[0,0,-1]],QS_winch_rope,clientOwner,TRUE,TRUE]]] remoteExecCall ['QS_fnc_remoteExec',2,FALSE];
		_index = QS_winch_monitor findIf {(_x # 0) isEqualTo QS_winch_rope};
		if (_index isNotEqualTo -1) then {
			_element = QS_winch_monitor # _index;
			_element set [0,QS_winch_rope];
			_element set [2,_targetVehicle];
			_element set [3,objNull];
			QS_winch_monitor set [_index,_element];
		};
		['MODE24'] call QS_fnc_simpleWinch;
	};
};
if (_mode isEqualTo 'MODE7') exitWith {
	(missionNamespace getVariable ['QS_winch_target',[FALSE,objNull,[0,0,0],FALSE]]) params ['_isValidObject','_intersectionObject','_intersectionPos','_isValidReversed'];
	(
		(_isValidObject || _isValidReversed) &&
		{(_intersectionObject isNotEqualTo (missionNamespace getVariable ['QS_winch_activeVehicle',objNull]))} &&
		{((['MODE18',_intersectionObject] call QS_fnc_simpleWinch) isNotEqualTo 1)}
	)
};
if (_mode isEqualTo 'MODE8') exitWith {
	_localhelper = missionNamespace getVariable ['QS_winch_localHelperObject',objNull];
	if (!isNull _localhelper) then {
		_localhelper hideObject TRUE;
	};
	_cameraOn = cameraOn;
	private _rope = objNull;
	private _ropes = [];
	private _helper = missionNamespace getVariable ['QS_winch_globalHelperObject',objNull];
	uiNamespace setVariable ['QS_rope_monitor_wait',diag_tickTime + 1];
	private _tempParent = objNull;
	private _tempChild = objNull;
	if (_cameraOn isKindOf 'CAManBase') then {
		if (!isNull _helper) then {
			_ropes = ropes (ropeAttachedTo _helper);
			if (_ropes isNotEqualTo []) then {
				_tempParent = ropeAttachedTo _helper;
				_tempChild = _helper;
				_rope = _ropes # 0;
			} else {
				_ropes = ropes _helper;
				if (_ropes isNotEqualTo []) then {
					_tempParent = _helper;
					_tempChild = (ropeAttachedObjects _helper) # 0;
					_rope = _ropes # 0;
				};
			};
		};
		if (!isNull _rope) exitWith {
			if ((!isNull _tempParent) && (!isNull _tempChild)) then {
				[109,['MODE25','MODE31',[_tempChild,_rope,_tempParent]]] remoteExecCall ['QS_fnc_remoteExec',2,FALSE];
			};
		};
		_cursorObject = cursorObject;
		if ((ropes _cursorObject) isNotEqualTo []) exitWith {
			_rope = (ropes _cursorObject) # 0;
			_attached = (ropeAttachedObjects _cursorObject) # 0;
			if (!isNull _rope) then {
				[109,['MODE25','MODE31',[_attached,_rope,_cursorObject]]] remoteExecCall ['QS_fnc_remoteExec',2,FALSE];
			};
		};
		if (!isNull (ropeAttachedTo _cursorObject)) exitWith {
			if (['MODE12',_cursorObject] call QS_fnc_simpleWinch) exitWith {
				_ropes = ropes (ropeAttachedTo _cursorObject);
				{
					_cursorObject ropeDetach _x;
				} forEach _ropes;
				comment "['ropeDetach',_ropes] remoteExec ['QS_fnc_remoteExecCmd',(ropeAttachedTo _child),FALSE];";
			};
			_rope = (ropes (ropeAttachedTo _cursorObject)) # 0;
			if (!isNull _rope) then {
				[109,['MODE25','MODE31',[_cursorObject,_rope,(ropeAttachedTo _cursorObject)]]] remoteExecCall ['QS_fnc_remoteExec',2,FALSE];
			};
		};
	} else {
		if ((ropes _cameraOn) isNotEqualTo []) then {
			_rope = (ropes _cameraOn) # 0;
			if (!isNull _rope) then {
				[109,['MODE25','MODE31',[((ropeAttachedObjects _cameraOn) # 0),_rope,_cameraOn]]] remoteExecCall ['QS_fnc_remoteExec',2,FALSE];
			};
		};
		if (!isNull (ropeAttachedTo _cameraOn)) then {
			_rope = (ropes (ropeAttachedTo _cameraOn)) # 0;
			if (!isNull _rope) then {
				if ((ropeAttachedTo _cameraOn) isKindOf 'Static') then {
					[109,['MODE25','MODE32',[_rope]]] remoteExecCall ['QS_fnc_remoteExec',2,FALSE];
				} else {
					[109,['MODE25','MODE31',[((ropeAttachedObjects (ropeAttachedTo _cameraOn)) # 0),_rope,(ropeAttachedTo _cameraOn)]]] remoteExecCall ['QS_fnc_remoteExec',2,FALSE];
				};
			};
		};
	};
};
if (_mode isEqualTo 'MODE9') exitWith {
	_cameraOn = cameraOn;
	if (_cameraOn isKindOf 'CAManBase') then {
		(
			(
				(!isNull (missionNamespace getVariable ['QS_winch_globalHelperObject',objNull])) && 
				{
					(QS_winch_globalHelperObject in (attachedObjects _cameraOn)) ||
					({(
						((QS_winch_globalHelperObject getVariable ['QS_rope_mode',2]) isEqualTo 3) &&
						{((_cameraOn distance QS_winch_globalHelperObject) < 5)} &&
						{(((_cameraOn getRelDir QS_winch_globalHelperObject) > 315) || {((_cameraOn getRelDir QS_winch_globalHelperObject) < 45)})}
					)})
				}
			) ||
			{
				(['MODE15'] call QS_fnc_simpleWinch) params ['_relation','_vehicle','_ropeStart','_ropeEnd','','_vehicle2'];
				(
					(
						((_relation isEqualTo 'CHILD') && ((_cameraOn distance _ropeEnd) < 3)) ||
						{((_relation isEqualTo 'PARENT') && ((_cameraOn distance _ropeStart) < 3))}
					) &&
					{(!(['MODE12',_vehicle] call QS_fnc_simpleWinch))} &&
					{(!(['MODE12',_vehicle2] call QS_fnc_simpleWinch))} &&
					{((['MODE18',_vehicle] call QS_fnc_simpleWinch) isNotEqualTo 1)} &&
					{((['MODE18',_vehicle2] call QS_fnc_simpleWinch) isNotEqualTo 1)}
				) ||
				(
					(_relation isEqualTo 'CHILD') && 
					{(['MODE12',_vehicle] call QS_fnc_simpleWinch)}
				)
			}
			
		)
	} else {
		(
			(((ropes _cameraOn) isNotEqualTo []) || {(!isNull (ropeAttachedTo _cameraOn))}) &&
			{(!(['MODE12',_cameraOn] call QS_fnc_simpleWinch))} && 
			{((['MODE18',_cameraOn] call QS_fnc_simpleWinch) isNotEqualTo 1)}
		)
	};
};
if (_mode isEqualTo 'MODE10') exitWith {
	_ropeEndInfo = ['MODE15'] call QS_fnc_simpleWinch;
	if (_ropeEndInfo isEqualTo []) exitWith {FALSE};
	_ropeEndInfo params ['_relation','_child','_ropeStart','_ropeEnd','_rope','_parent'];
	if (
		(_relation isEqualTo 'CHILD') && 
		{(['MODE12',_child] call QS_fnc_simpleWinch)}
	) exitWith {
		_ropes = ropes (ropeAttachedTo _child);
		if (_ropes isNotEqualTo []) then {
			['ropeDetach',_child,_ropes] remoteExecCall ['QS_fnc_remoteExecCmd',0,FALSE];
		};
	};
	[_rope,_child,_parent] spawn {
		params ['_rope','_child','_parent'];
		sleep 0.5;
		['MODE4',_rope,_child,_parent] spawn QS_fnc_simpleWinch;
	};
};
if (_mode isEqualTo 'MODE11') exitWith {
	_ropeEndInfo = ['MODE15'] call QS_fnc_simpleWinch;
	if (_ropeEndInfo isEqualTo []) exitWith {FALSE};
	_ropeEndInfo params ['_relation','_child','_ropeStart','_ropeEnd','_rope','_parent'];
	getCursorObjectParams params ['','','_cursorDistance'];
	_cameraOn = cameraOn;
	_relDir = _cameraOn getRelDir _ropeEnd;
	(
		(_relation isEqualTo 'CHILD') &&
		{(local _parent)} &&
		{(_cursorDistance < 3)} &&
		{((_cameraOn distance _ropeEnd) < 3)} &&
		{((_relDir >= 315) || (_relDir <= 45))} &&
		{(_cameraOn isKindOf 'CAManBase')} &&
		{((currentWeapon _cameraOn) isEqualTo '')} &&
		{(ropeUnwound _rope)} &&
		{(((['MODE19',_child] call QS_fnc_simpleWinch) findAny ['WINCH']) isNotEqualTo -1)} &&
		{(((missionNamespace getVariable ['QS_winch_globalHelperObject',objNull]) getVariable ['QS_rope_mode',2]) isNotEqualTo 3)}
	)
};
if (_mode isEqualTo 'MODE12') exitWith {
	params ['','_vehicle'];
	if (isNull _vehicle) exitWith {TRUE};
	(
		(!isNull (getSlingLoad _vehicle)) ||
		{(
			(!isNull (ropeAttachedTo _vehicle)) &&
			{(_vehicle isEqualTo (getSlingLoad (ropeAttachedTo _vehicle)))}
		)}
	)
};
if (_mode isEqualTo 'MODE13') exitWith {
	params ['','_parent','_child','_newRope','_rope','_monitor_index'];
	_element = QS_winch_monitor # _monitor_index;
	_element set [0,_newRope];
	_element set [1,_child];
	_element set [2,_parent];
	_element set [3,_child];
	_element set [4,TRUE];
	QS_winch_monitor set [_monitor_index,_element];
	missionNamespace setVariable ['QS_winch_activeVehicle',_child,FALSE];
};
if (_mode isEqualTo 'MODE14') exitWith {
	params ['','_oldHelper','_newHelper'];
	_monitor_index = QS_winch_monitor findIf { ((_x # 3) isEqualTo _oldHelper) };
	if (_monitor_index isNotEqualTo -1) exitWith {
		_element = QS_winch_monitor # _monitor_index;
		_element set [3,_newHelper];
		QS_winch_monitor set [_monitor_index,_element];
		QS_winch_globalHelperObject = _newHelper;
		deleteVehicle _oldHelper;
		TRUE
	};
	FALSE
};
if (_mode isEqualTo 'MODE15') exitWith {
	_vehicle = cursorObject;
	if (isNull _vehicle) exitWith {[]};
	if ((ropes _vehicle) isNotEqualTo []) exitWith {
		_rope = (ropes _vehicle) # 0;
		(ropeEndPosition _rope) params ['_ropeStart','_ropeEnd'];
		['PARENT',_vehicle,_ropeStart,_ropeEnd,_rope,((ropeAttachedObjects _vehicle) # 0)]
	};
	_parent = ropeAttachedTo _vehicle;
	if (
		(isNull _parent) ||
		{((ropes _parent) isEqualTo [])}
	) exitWith {[]};
	_rope = (ropes _parent) # 0;
	(ropeEndPosition _rope) params ['_ropeStart','_ropeEnd'];
	['CHILD',_vehicle,_ropeStart,_ropeEnd,_rope,_parent]
};
if (_mode isEqualTo 'MODE16') exitWith {
	params ['','_parent',['_rope',objNull]];
	if (
		(!isNull _rope) &&
		{(local _parent)}
	) then {
		ropeUnwind [_rope,2,1,FALSE];
		uiSleep (diag_deltaTime * 2);
		_timeout = diag_tickTime + 10;
		waitUntil { ((ropeUnwound _rope) || (diag_tickTime > _timeout)) };
		ropeDestroy _rope;
		[109,['MODE25','MODE32',[_rope]]] remoteExecCall ['QS_fnc_remoteExec',2,FALSE];
	};
};
if (_mode isEqualTo 'MODE17') exitWith {
	player setVariable ['QS_sling_keyDownDelay',(diag_tickTime + 0.5),FALSE];
	params ['','_vehicle',['_upOrDown',FALSE]];
	if (!local _vehicle) exitWith {};
	if (
		((ropeAttachedObjects _vehicle) isEqualTo []) &&
		{((ropes _vehicle) isNotEqualTo [])} &&
		{(
			(!isNull (missionNamespace getVariable ['QS_winch_globalHelperObject',objNull])) && 
			{((ropeAttachedTo _vehicle) isNotEqualTo (missionNamespace getVariable ['QS_winch_globalHelperObject',objNull]))}
		)}
	) exitWith {
		[109,['MODE25','MODE32',(ropes _vehicle)]] remoteExecCall ['QS_fnc_remoteExec',2,FALSE];
	};
	private _anchor = ropeAttachedTo _vehicle;
	private _isReversed = (!isNull _anchor) && (_anchor isEqualTo (missionNamespace getVariable ['QS_winch_globalHelperObject',objNull]));
	if (_isReversed) then {
		_vehicle = _anchor;
	};
	_speed = [1,5] select ((uiNamespace getVariable ['QS_uiaction_vehicleturbo',FALSE]) || (uiNamespace getVariable ['QS_uiaction_turbo',FALSE]));
	_min = [3,1] select _isReversed;
	_max = 25;
	_delta = 1;
	private _ropeLength = 0;
	if (_upOrDown) then {
		{
			_ropeLength = ropeLength _x;
			if (_ropeLength >= _min) then {
				ropeUnwind [_x,_speed,-_delta,TRUE];
			};
		} forEach (ropes _vehicle);
	} else {
		{
			_ropeLength = ropeLength _x;
			if (_ropeLength <= _max) then {
				ropeUnwind [_x,_speed,_delta,TRUE];
			};
		} forEach (ropes _vehicle);
	};
	if (isNull ((findDisplay 46) displayCtrl 31081)) then {
		[ropeLength ((ropes _vehicle) # 0),_max] spawn {
			params ['_ropeLength','_max'];
			scriptName 'QS - Rope - UI';
			disableSerialization;
			private _ctrlPosition = [
				[
					(profileNamespace getVariable ['IGUI_GRID_CUSTOMINFOLEFT_X',0]),
					(profilenamespace getvariable ['IGUI_GRID_CUSTOMINFOLEFT_Y',(10 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25))]) - 0.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) +    ((12.3 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)) - 1.25 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)),
					(profilenamespace getvariable ['IGUI_GRID_CUSTOMINFOLEFT_W',(10 * (((safezoneW / safezoneH) min 1.2) / 40))]),
					1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)
				],
				[
					(profileNamespace getVariable ['IGUI_GRID_CUSTOMINFORIGHT_X',0]),
					(profilenamespace getvariable ['IGUI_GRID_CUSTOMINFORIGHT_Y',(10 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25))]) - 0.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) +    ((12.3 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)) - 1.25 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)),
					(profilenamespace getvariable ['IGUI_GRID_CUSTOMINFORIGHT_W',(10 * (((safezoneW / safezoneH) min 1.2) / 40))]),
					1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)
				]
			] select ('SlingLoadDisplay' in (infoPanel 'right'));
			private _controls = [];
			_QS_ctrlCreateArray = ['RscBackground',31080];
			_QS_ctrl_0 = (findDisplay 46) ctrlCreate _QS_ctrlCreateArray;
			_QS_ctrl_0 ctrlShow FALSE;
			_controls pushBack _QS_ctrl_0;
			_QS_ctrl_0 ctrlSetText '';
			_QS_ctrl_0 ctrlSetBackgroundColor [0,0,0,0.175];
			_QS_ctrl_0 ctrlSetPosition _ctrlPosition;
			_QS_ctrlCreateArray = ['RscProgress',31081];
			_QS_ctrl_1 = (findDisplay 46) ctrlCreate _QS_ctrlCreateArray;
			_QS_ctrl_1 ctrlShow FALSE;
			_controls pushBack _QS_ctrl_1;
			_QS_ctrl_1 ctrlSetText '';
			_QS_ctrl_1 ctrlSetTextColor [(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843]),(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019]),(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862]),(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])];
			_QS_ctrl_1 ctrlSetPosition _ctrlPosition;
			_QS_ctrlCreateArray = ['RscText',31082];
			_QS_ctrl_2 = (findDisplay 46) ctrlCreate _QS_ctrlCreateArray;
			_QS_ctrl_2 ctrlShow FALSE;
			_controls pushBack _QS_ctrl_2;
			_QS_ctrl_2 ctrlSetText (localize 'STR_QS_Menu_105');
			_QS_ctrl_2 ctrlSetPosition _ctrlPosition;
			{
				_x ctrlCommit 0;
			} forEach _controls;
			waitUntil {
				uiSleep 0.01;
				_ctrlPosition = [
					[
						(profileNamespace getVariable ['IGUI_GRID_CUSTOMINFOLEFT_X',0]),
						(profilenamespace getvariable ['IGUI_GRID_CUSTOMINFOLEFT_Y',(10 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25))]) - 0.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) +    ((12.3 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)) - 1.25 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)),
						(profilenamespace getvariable ['IGUI_GRID_CUSTOMINFOLEFT_W',(10 * (((safezoneW / safezoneH) min 1.2) / 40))]),
						1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)
					],
					[
						(profileNamespace getVariable ['IGUI_GRID_CUSTOMINFORIGHT_X',0]),
						(profilenamespace getvariable ['IGUI_GRID_CUSTOMINFORIGHT_Y',(10 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25))]) - 0.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) +    ((12.3 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)) - 1.25 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)),
						(profilenamespace getvariable ['IGUI_GRID_CUSTOMINFORIGHT_W',(10 * (((safezoneW / safezoneH) min 1.2) / 40))]),
						1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)
					]
				] select ('EmptyDisplay' in (infoPanel 'left'));
				if ((ctrlPosition ((findDisplay 46) displayCtrl 31080)) isNotEqualTo _ctrlPosition) then {
					((findDisplay 46) displayCtrl 31080) ctrlSetPosition _ctrlPosition;
					((findDisplay 46) displayCtrl 31080) ctrlCommit 0;
				};
				if ((ctrlPosition ((findDisplay 46) displayCtrl 31081)) isNotEqualTo _ctrlPosition) then {
					((findDisplay 46) displayCtrl 31081) ctrlSetPosition _ctrlPosition;
					((findDisplay 46) displayCtrl 31081) ctrlCommit 0;
				};
				if ((ctrlPosition ((findDisplay 46) displayCtrl 31082)) isNotEqualTo _ctrlPosition) then {
					((findDisplay 46) displayCtrl 31082) ctrlSetPosition _ctrlPosition;
					((findDisplay 46) displayCtrl 31082) ctrlCommit 0;
				};
				(diag_tickTime > ((player getVariable ['QS_sling_keyDownDelay',-1]) + 3))
			};
			{
				ctrlDelete _x;
			} forEach _controls;
		};
	} else {
		disableSerialization;
		private _ctrlPosition = [
			[
				(profileNamespace getVariable ['IGUI_GRID_CUSTOMINFOLEFT_X',0]),
				(profilenamespace getvariable ['IGUI_GRID_CUSTOMINFOLEFT_Y',(10 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25))]) - 0.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) +    ((12.3 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)) - 1.25 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)),
				(profilenamespace getvariable ['IGUI_GRID_CUSTOMINFOLEFT_W',(10 * (((safezoneW / safezoneH) min 1.2) / 40))]),
				1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)
			],
			[
				(profileNamespace getVariable ['IGUI_GRID_CUSTOMINFORIGHT_X',0]),
				(profilenamespace getvariable ['IGUI_GRID_CUSTOMINFORIGHT_Y',(10 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25))]) - 0.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) +    ((12.3 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)) - 1.25 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)),
				(profilenamespace getvariable ['IGUI_GRID_CUSTOMINFORIGHT_W',(10 * (((safezoneW / safezoneH) min 1.2) / 40))]),
				1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)
			]
		] select ('EmptyDisplay' in (infoPanel 'left'));
		if ( (ctrlPosition ((findDisplay 46) displayCtrl 31080)) isNotEqualTo _ctrlPosition) then {
			((findDisplay 46) displayCtrl 31080) ctrlSetPosition _ctrlPosition;
		};
		if ( (ctrlPosition ((findDisplay 46) displayCtrl 31081)) isNotEqualTo _ctrlPosition) then {
			((findDisplay 46) displayCtrl 31081) ctrlSetPosition _ctrlPosition;
		};
		if ( (ctrlPosition ((findDisplay 46) displayCtrl 31082)) isNotEqualTo _ctrlPosition) then {
			((findDisplay 46) displayCtrl 31082) ctrlSetPosition _ctrlPosition;
		};
		if (!(ctrlShown ((findDisplay 46) displayCtrl 31080))) then {
			((findDisplay 46) displayCtrl 31080) ctrlShow TRUE;
		};
		if (!(ctrlShown ((findDisplay 46) displayCtrl 31081))) then {
			((findDisplay 46) displayCtrl 31081) ctrlShow TRUE;
		};
		if (!(ctrlShown ((findDisplay 46) displayCtrl 31082))) then {
			((findDisplay 46) displayCtrl 31082) ctrlShow TRUE;
		};
		((findDisplay 46) displayCtrl 31081) progressSetPosition (_ropeLength / _max);
		((findDisplay 46) displayCtrl 31082) ctrlSetText (format ['%2 %1 m',(round _ropeLength),localize 'STR_QS_Menu_107']);
		((findDisplay 46) displayCtrl 31080) ctrlCommit 0;
		((findDisplay 46) displayCtrl 31081) ctrlCommit 0;
		((findDisplay 46) displayCtrl 31082) ctrlCommit 0;
	};
};
if (_mode isEqualTo 'MODE18') exitWith {
	params ['','_vehicle'];
	private _ropeMode = 0;
	if (
		((_vehicle getVariable ['QS_rope_mode',0]) > 0) &&
		{(
			((ropes _vehicle) isNotEqualTo []) ||
			{(!isNull (ropeAttachedTo _vehicle))}
		)}
	) then {
		_ropeMode = _vehicle getVariable ['QS_rope_mode',0];
	};
	_ropeMode;
};
if (_mode isEqualTo 'MODE19') exitWith {
	params ['','_vehicle'];
	private _modes = [];
	if (((ropes _vehicle) findIf { (((_x getVariable ['QS_rope_relation',[objNull,objNull,'']]) # 2) isEqualTo 'SLING') }) isNotEqualTo -1) then {_modes pushBackUnique 'SLING'};
	if (((ropes _vehicle) findIf { (((_x getVariable ['QS_rope_relation',[objNull,objNull,'']]) # 2) isEqualTo 'PULL') }) isNotEqualTo -1) then {_modes pushBackUnique 'PULL'};
	if (((ropes _vehicle) findIf { (((_x getVariable ['QS_rope_relation',[objNull,objNull,'']]) # 2) isEqualTo 'WINCH') }) isNotEqualTo -1) then {_modes pushBackUnique 'WINCH'};
	if (((ropes (ropeAttachedTo _vehicle)) findIf { (((_x getVariable ['QS_rope_relation',[objNull,objNull,'']]) # 2) isEqualTo 'SLING') }) isNotEqualTo -1) then {_modes pushBackUnique 'SLING'};
	if (((ropes (ropeAttachedTo _vehicle)) findIf { (((_x getVariable ['QS_rope_relation',[objNull,objNull,'']]) # 2) isEqualTo 'PULL') }) isNotEqualTo -1) then {_modes pushBackUnique 'PULL'};
	if (((ropes (ropeAttachedTo _vehicle)) findIf { (((_x getVariable ['QS_rope_relation',[objNull,objNull,'']]) # 2) isEqualTo 'WINCH') }) isNotEqualTo -1) then {_modes pushBackUnique 'WINCH'};		
	_modes
};
if (_mode isEqualTo 'MODE20') exitWith {
	_vehicle = missionNamespace getVariable ['QS_winch_activeVehicle',objNull];
	_winchPoint = missionNamespace getVariable ['QS_winch_activePoint',[0,0,0]];
	(
		(!alive cameraOn) ||
		{(!alive _vehicle)} ||
		{(!local _vehicle)} ||
		{(!(cameraOn isKindOf 'CAManBase'))} ||
		{((cameraOn distance (_vehicle modelToWorld _winchPoint)) > ((ropeLength QS_winch_rope) * 1.2))} ||
		{(!(ropeAttachEnabled _vehicle))} ||
		{(!(isNull (attachedTo _vehicle)))} ||
		{(!(isNull (ropeAttachedTo _vehicle)))} ||
		{(!(isNull (isVehicleCargo _vehicle)))} ||
		{((ropeAttachedObjects _vehicle) isEqualTo [])} ||
		{(isNull QS_winch_globalHelperObject)} ||
		{(isNull QS_winch_localHelperObject)} ||
		{((count (ropes _vehicle)) > 1)} ||
		{(((['MODE19',_vehicle] call QS_fnc_simpleWinch) findAny ['SLING','PULL']) isNotEqualTo -1)} ||
		{((ropes _vehicle) isEqualTo [])}
	)
};
if (_mode isEqualTo 'MODE21') exitWith {
	if ((currentWeapon QS_player) isNotEqualTo '') then {
		action ['SwitchWeapon',QS_player,QS_player,100];
	};
	if (!(missionNamespace getvariable ['QS_simpleWinch_uiHelper',FALSE])) then {
		missionNamespace setVariable ['QS_simpleWinch_uiHelper',TRUE,FALSE];
		QS_winch_localHelperObject = createSimpleObject ['Sign_Sphere10cm_F',getPosASL player,TRUE];
		if (isNil 'QS_WINCH_UIHELPER') then {
			QS_WINCH_UIHELPER = -1;
		};
		QS_WINCH_UIHELPER = addMissionEventHandler [
			'Draw3D',
			{
				if (['MODE20'] call QS_fnc_simpleWinch) exitWith {
					if (diag_tickTime > (uiNamespace getVariable ['QS_rope_monitor_wait',-1])) then {
						['MODE22'] call QS_fnc_simpleWinch;
					};
				};
				_helper = missionNamespace getVariable ['QS_winch_localHelperObject',objNull];
				if (isNull _helper) exitWith {};
				_beg = eyePos QS_player;
				_end = _beg vectorAdd ((getCameraViewDirection QS_player) vectorMultiply 2.5);
				_intersections = lineIntersectsSurfaces [_beg, _end, QS_player, _helper];
				if (_intersections isNotEqualTo []) then {
					(_intersections # 0) params ['_intersectionPos','',['_intersectionObject',objNull]];
					if (!isNull _intersectionObject) then {
						_isValidObject = (
							(alive _intersectionObject) &&
							{(simulationEnabled _intersectionObject)} &&
							{(ropeAttachEnabled _intersectionObject)} &&
							{(isNull (attachedTo _intersectionObject))} &&
							{(isNull (isVehicleCargo _intersectionObject))} &&
							{ ((['AllVehicles','Reammobox_F','Cargo10_base_F'] findIf { _intersectionObject isKindOf _x }) isNotEqualTo -1) } &&
							{(((crew _intersectionObject) findIf {((isPlayer _x) && (alive _x))}) isEqualTo -1)} &&
							{(_intersectionObject isNotEqualTo (missionNamespace getVariable ['QS_winch_activeVehicle',objNull]))}
						);
						missionNamespace setVariable ['QS_winch_target',[_isValidObject,_intersectionObject,_intersectionPos,!_isValidObject],FALSE];
						_helper setObjectTexture [0,format ['%1',['#(rgb,8,8,3)color(1,1,0,1)','#(rgb,8,8,3)color(0,1,0,1)'] select _isValidObject]];
						_helper setPosASL _intersectionPos;
					} else {
						missionNamespace setVariable ['QS_winch_target',[FALSE,objNull,[0,0,0],FALSE],FALSE];
						_helper setObjectTexture [0,'#(rgb,8,8,3)color(1,0,0,1)'];
						if ((_end # 2) < (getTerrainHeightASL _end)) then {
							_end set [2,(getTerrainHeightASL _end)];
						};
						_helper setPosASL _end;
					};
				} else {
					missionNamespace setVariable ['QS_winch_target',[FALSE,objNull,[0,0,0],FALSE],FALSE];
					_helper setObjectTexture [0,'#(rgb,8,8,3)color(1,0,0,1)'];
					if ((_end # 2) < (getTerrainHeightASL _end)) then {
						_end set [2,(getTerrainHeightASL _end)];
					};
					_helper setPosASL _end;
				};
			}
		];
	};
};
if (_mode isEqualTo 'MODE22') exitWith {
	missionNamespace setVariable ['QS_winch_target',[FALSE,objNull,[0,0,0]],FALSE];
	missionNamespace setVariable ['QS_simpleWinch_uiHelper',FALSE,FALSE];
	if (isNil 'QS_WINCH_UIHELPER') then {
		QS_WINCH_UIHELPER = -1;
	};
	if (isNil 'QS_winch_tempObject') then {
		QS_winch_tempObject = objNull;
	};
	removeMissionEventHandler ['Draw3D',QS_WINCH_UIHELPER];
	deleteVehicle QS_winch_localHelperObject;
	if ((ropes QS_winch_globalHelperObject) isNotEqualTo []) exitWith {};
	missionNamespace setVariable ['QS_winch_activeVehicle',objNull,FALSE];
	deleteVehicle QS_winch_globalHelperObject;
};
if (_mode isEqualTo 'MODE23') exitWith {
	params ['','_vehicle'];
	_attachPointData = QS_hashmap_winchAttachPoints getOrDefaultCall [
		toLowerANSI (typeOf _vehicle),
		{
			[(['FRONT',_vehicle] call QS_fnc_getRopeAttachPos),{((_this getVariable ['QS_winch_enabled',FALSE]) || ((missionNamespace getVariable ['QS_missionConfig_interactWinch',1]) isEqualTo 2))}]
		},
		TRUE
	];
	[_vehicle call (_attachPointData # 1),_attachPointData # 0]
};
if (_mode isEqualTo 'MODE24') exitWith {
	if (!(missionNamespace getVariable ['QS_winch_monitoring',FALSE])) then {
		missionNamespace setVariable ['QS_winch_monitoring',TRUE,FALSE];
		if (isNil 'QS_WINCH_MONITOR_EH') then {
			QS_WINCH_MONITOR_EH = -1;
		};			
		if (!(QS_simpleWinch_actionAttach in (actionIDs player))) then {
			QS_simpleWinch_actionAttach = player addAction [localize 'STR_QS_Interact_125',{['MODE6'] spawn QS_fnc_simpleWinch},nil,11,FALSE,TRUE,'','(["MODE7"] call QS_fnc_simpleWinch)'];
			player setUserActionText [QS_simpleWinch_actionAttach,localize 'STR_QS_Interact_125',(format ["<t size='3'>%1</t>",localize 'STR_QS_Interact_125'])];
		};
		if (!(QS_simpleWinch_actionRelease in (actionIDs player))) then {
			QS_simpleWinch_actionRelease = player addAction [localize 'STR_QS_Interact_010',{['MODE8'] call QS_fnc_simpleWinch},nil,-48,FALSE,TRUE,'','(["MODE9"] call QS_fnc_simpleWinch)'];
			player setUserActionText [QS_simpleWinch_actionRelease,localize 'STR_QS_Interact_010',(format ["<t size='3'>%1</t>",localize 'STR_QS_Interact_010'])];
		};
		if (!(QS_simpleWinch_actionUnhook in (actionIDs player))) then {
			QS_simpleWinch_actionUnhook = player addAction [localize 'STR_QS_Interact_126',{['MODE10'] call QS_fnc_simpleWinch},nil,10,TRUE,TRUE,'','(["MODE11"] call QS_fnc_simpleWinch)'];
			player setUserActionText [QS_simpleWinch_actionUnhook,localize 'STR_QS_Interact_126',(format ["<t size='3'>%1</t>",localize 'STR_QS_Interact_126'])];
		};
		QS_WINCH_MONITOR_EH = addMissionEventHandler [
			'EachFrame',
			{
				if (diag_tickTime < (uiNamespace getVariable ['QS_rope_monitor_wait',-1])) exitWith {};
				if (QS_winch_monitor isNotEqualTo []) exitWith {
					{
						_x params [['_rope',objNull],['_parent',objNull],['_child',objNull],['_helper',objNull],['_reversed',FALSE]];
						if (isNull _rope) exitWith {
							['MODE22'] call QS_fnc_simpleWinch;
							deleteVehicle _helper;
							QS_winch_monitor deleteAt _forEachIndex;
						};
						if ((isNull _child) && (isNull _helper)) exitWith {
							['MODE16',_parent,_rope] spawn QS_fnc_simpleWinch;
							['MODE22'] call QS_fnc_simpleWinch;
							QS_winch_monitor deleteAt _forEachIndex;
						};
						if (((ropeAttachedObjects _parent) isEqualTo []) && (!isNull _rope)) exitWith {
							['MODE16',_parent,_rope] spawn QS_fnc_simpleWinch;
							['MODE22'] call QS_fnc_simpleWinch;
							QS_winch_monitor deleteAt _forEachIndex;
						};
						if (
							(['MODE12',_parent] call QS_fnc_simpleWinch) ||
							{(['MODE12',_child] call QS_fnc_simpleWinch)} ||
							{(((['MODE19',_parent] call QS_fnc_simpleWinch) findAny ['SLING','PULL']) isNotEqualTo -1)} ||
							{(((['MODE19',_child] call QS_fnc_simpleWinch) findAny ['SLING','PULL']) isNotEqualTo -1)}
						) exitWith {
							['MODE16',_parent,_rope] spawn QS_fnc_simpleWinch;
							['MODE22'] call QS_fnc_simpleWinch;
							QS_winch_monitor deleteAt _forEachIndex;
						};
						_isLocal = local _child;
						if (!_isLocal) then {
							if (diag_tickTime > (uiNamespace getVariable ['QS_winch_lastRXTime5',-1])) then {
								uiNamespace setVariable ['QS_winch_lastRXTime5',diag_tickTime + 3];
								['setOwner',_child,clientOwner] remoteExec ['QS_fnc_remoteExecCmd',2,FALSE];
							};
						};
						if (_reversed) then {
							if (
								(!isNull _child) &&
								{_isLocal}
							) then {
								if (!brakesDisabled _child) then {
									_child disableBrakes TRUE;
								};
								if (!isAwake _child) then {
									_child awake TRUE;
								};
								if (!isNull (getTowParent _child)) then {
									_child setTowParent objNull;
								};
							};
							if (!isNull _parent) then {
								_surfaceInfo = _parent getVariable ['QS_winch_surfaceObject',[]];
								if (
									(_surfaceInfo isNotEqualTo []) &&
									{
										((getPosWorld (_surfaceInfo # 0)) isNotEqualTo (_surfaceInfo # 1)) ||
										((_surfaceInfo # 1) isEqualTo [0,0,0])
									}
								) then {
									_parent setDamage [1,FALSE];
									['MODE16',_parent,_rope] spawn QS_fnc_simpleWinch;
									['MODE22'] call QS_fnc_simpleWinch;
									QS_winch_monitor deleteAt _forEachIndex;
								};
								if (
									(alive _parent) &&
									{(isNull (attachedTo _parent))} &&
									{(isObjectHidden _parent)}
								) then {
									_parent setPosWorld (_parent getVariable ['QS_winch_pos',getPosWorld _parent]);
								};
							};
						} else {
							if (!isNull _child) then {
								if (!brakesDisabled _child) then {
									if (_isLocal) then {
										_child disableBrakes TRUE;
									} else {
										if (diag_tickTime > (uiNamespace getVariable ['QS_winch_lastRXTime1',-1])) then {
											uiNamespace setVariable ['QS_winch_lastRXTime1',diag_tickTime + 3];
											['disableBrakes',_child,TRUE] remoteExec ['QS_fnc_remoteExecCmd',_child,FALSE];
										};
									};
								};
								if (!isAwake _child) then {
									if (_isLocal) then {
										_child awake TRUE;
									} else {
										if (diag_tickTime > (uiNamespace getVariable ['QS_winch_lastRXTime2',-1])) then {
											uiNamespace setVariable ['QS_winch_lastRXTime2',diag_tickTime + 3];
											['awake',_child,TRUE] remoteExec ['QS_fnc_remoteExecCmd',_child,FALSE];
										};
									};
								};
								if (!isNull (getTowParent _child)) then {
									if (_isLocal) then {
										_child setTowParent objNull;
									} else {
										if (diag_tickTime > (uiNamespace getVariable ['QS_winch_lastRXTime3',-1])) then {
											uiNamespace setVariable ['QS_winch_lastRXTime3',diag_tickTime + 3];
											['setTowParent',_child,objNull] remoteExec ['QS_fnc_remoteExecCmd',_child,FALSE];
										};
									};
								};
								if (!isNull _rope) then {
									(ropeEndPosition _rope) params [
										['_startPos',[0,0,0]],
										['_endPos',[0,0,0]]
									];
									_ropeDistance = _startPos distance _endPos;
									_ropeLength = ropeLength _rope;
									if (
										((vectorMagnitude (velocity _child)) < 0.1) &&
										{(_ropeDistance > (_ropeLength * 1.2))}
									) then {
										if (local _child) then {
											_child setVelocityModelSpace [0,1,0];
										} else {
											if (diag_tickTime > (uiNamespace getVariable ['QS_winch_lastRXTime4',-1])) then {
												uiNamespace setVariable ['QS_winch_lastRXTime4',diag_tickTime + 3];
												['setVelocityModelSpace',_child,[0,1,0]] remoteExec ['QS_fnc_remoteExecCmd',_child,FALSE];
											};
										};
									};
								};
							};
						};
					} forEach QS_winch_monitor;
				};
				if (QS_simpleWinch_actionAttach in (actionIDs player)) then {
					player removeAction QS_simpleWinch_actionAttach;
				};
				if (QS_simpleWinch_actionRelease in (actionIDs player)) then {
					player removeAction QS_simpleWinch_actionRelease;
				};
				if (QS_simpleWinch_actionUnhook in (actionIDs player)) then {
					player removeAction QS_simpleWinch_actionUnhook;
				};
				['MODE22'] call QS_fnc_simpleWinch;
				removeMissionEventHandler [_thisEvent,_thisEventHandler];
				missionNamespace setVariable ['QS_winch_monitoring',FALSE,FALSE];
			}
		];
	};
};
if (_mode isEqualTo 'MODE25') exitWith {
	params ['','_mode2'];
	if (_mode2 isEqualTo 'MODE26') then {
		_this spawn {
			params ['','','_varname','_type','_clientOwner'];
			if (diag_tickTime > (uiNamespace getVariable [format ['QS_winch_lastRequestTime_%1',_clientOwner],-1])) then {
				uiNamespace setVariable [format ['QS_winch_lastRequestTime_%1',_clientOwner],diag_tickTime + 3];
				_vehicle = createVehicle [_type,[0,0,0]];
				_vehicle allowDamage FALSE;
				_vehicle hideObjectGlobal TRUE;
				_vehicle enableWeaponDisassembly FALSE;
				_vehicle enableVehicleCargo FALSE;
				QS_garbageCollector pushBack [_vehicle,'DELAYED_DISCREET',600];	// just incase
				_vehicle setVariable ['QS_rope_mode',3,TRUE];
				_vehicle lock 2;
				private _timeout = diag_tickTime + 3;
				waitUntil {
					if (!isObjectHidden _vehicle) then {
						_vehicle hideObjectGlobal TRUE;
					};
					((isObjectHidden _vehicle) || (diag_tickTime > _timeout))
				};
				_timeout = diag_tickTime + 3;
				waitUntil {
					((_vehicle setOwner _clientOwner) || (diag_tickTime > _timeout))
				};
				['MODE25','MODE27',_vehicle] call QS_fnc_simpleWinch;
				[
					[_vehicle,_varname],
					{
						params ['_vehicle','_varname'];
						missionNamespace setVariable [_varname,_vehicle,FALSE];
						_vehicle allowDamage FALSE;
						_vehicle enableWeaponDisassembly FALSE;
						_vehicle enableVehicleCargo FALSE;
						_vehicle lock 2;
					}
				] remoteExec ['call',_clientOwner,FALSE];
			};
		};
	};
	if (_mode2 isEqualTo 'MODE27') then {
		params ['','','_vehicle',['_owner',2]];
		if (!(_vehicle getVariable ['QS_winch_server',FALSE])) then {
			_vehicle setVariable ['QS_winch_server',TRUE,TRUE];
			{
				_vehicle addEventHandler _x;
			} forEach [
				[
					'Deleted',
					{
						params ['_vehicle'];
						{
							ropeDestroy _x;
						} forEach (ropes _vehicle);
						if (!isNull (ropeAttachedTo _vehicle)) then {
							{
								ropeDestroy _x;
							} forEach (ropes (ropeAttachedTo _vehicle));
						};
						if ((_vehicle getVariable ['QS_rope_helperObjects',[]]) isNotEqualTo []) then {
							deleteVehicle (_vehicle getVariable ['QS_rope_helperObjects',[]]);
						};
					}
				],
				[
					'Local',
					{
						params ['_vehicle','_isLocal'];
						if (_isLocal) then {
							{
								ropeDestroy _x;
							} forEach (ropes _vehicle);
							if (!isNull (ropeAttachedTo _vehicle)) then {
								{
									ropeDestroy _x;
								} forEach (ropes (ropeAttachedTo _vehicle));
							};
							if ((_vehicle getVariable ['QS_rope_helperObjects',[]]) isNotEqualTo []) then {
								{
									ropeDestroy _x;
								} forEach (_vehicle getVariable ['QS_rope_helperObjects',[]]);
								_vehicle setVariable ['QS_rope_helperObjects',[],TRUE];
							};
							if ((_vehicle getVariable ['QS_rope_mode',0]) isEqualTo 3) exitWith {
								deleteVehicle _vehicle;
							};
							if (
								(_vehicle isKindOf 'Sign_Sphere10cm_F') ||
								{(_vehicle isKindOf 'B_UAV_01_F')} ||
								{(_vehicle isKindOf 'B_static_AA_F')}
							) then {
								deleteVehicle _vehicle;
							};
						};
					}
				],
				[
					'RopeBreak',
					{
						params ['_parent','_rope','_child'];
						_ropeMode = _parent getVariable ['QS_rope_mode',0];
						if (_ropeMode in [0,1]) exitWith {};
						if ((_parent getVariable ['QS_rope_helperObjects',[]]) isNotEqualTo []) then {
							{
								ropeDestroy _x;
							} forEach (_parent getVariable ['QS_rope_helperObjects',[]]);
							_parent setVariable ['QS_rope_helperObjects',[],TRUE];
						};
						if (
							(_parent isKindOf 'Sign_Sphere10cm_F') ||
							{(_parent isKindOf 'B_UAV_01_F')} ||
							{(_parent isKindOf 'B_static_AA_F')}
						) then {
							_rope remoteExec ['ropeDestroy',_parent,FALSE];
							deleteVehicle _parent;
						};
					}
				]
			];
		};
	};
	if (_mode2 isEqualTo 'MODE28') then {
		params ['','','_vehicle',['_owner',2]];
		_timeout = diag_tickTime + 3;
		if ((owner _vehicle) isNotEqualto _owner) then {
			waitUntil {
				((_vehicle setOwner _owner) || (diag_tickTime > _timeout))
			};
		};
		[_vehicle,TRUE] remoteExec ['disableBrakes',_vehicle,FALSE];
	};
	if (_mode2 isEqualTo 'MODE29') then {
		params ['','','_ropeParams'];
		_parent = _ropeParams # 0;
		_child = _ropeParams # 2;
		_rope = ropeCreate _ropeParams;
		_parent setVariable ['QS_winch_rope',_rope,TRUE];
		_child setVariable ['QS_winch_rope',_rope,TRUE];
		_rope setVariable ['QS_rope_relation',[_parent,_child,'WINCH'],TRUE];
		if (!(_parent getVariable ['QS_winch_server',FALSE])) then {
			['MODE25','MODE27',_parent] call QS_fnc_simpleWinch;
		};
		if (!(_child getVariable ['QS_winch_server',FALSE])) then {
			['MODE25','MODE27',_child] call QS_fnc_simpleWinch;
		};
	};
	if (_mode2 isEqualTo 'MODE30') then {
		params ['','','_ropeParams'];
		_ropeParams params ['_childOld','_attachParams','_rope','_clientOwner',['_deleteOld',FALSE],['_setOwner',FALSE]];
		_childNew = _attachParams # 0;
		_ropeRelation = _rope getVariable ['QS_rope_relation',[]];
		if (_ropeRelation isNotEqualTo []) then {
			_ropeRelation set [1,_childNew];
			_rope setVariable ['QS_rope_relation',_ropeRelation,TRUE];
		};
		if (!isNull (getTowParent _childNew)) then {
			[_childNew,objNull] remoteExec ['setTowParent',0,FALSE];
		};
		if (!isNull _childOld) then {
			[_childOld,_rope] remoteExecCall ['ropeDetach',0,FALSE];
		};
		[_attachParams,_rope] remoteExec ['ropeAttachTo',0,FALSE];
		if (!(_childNew getVariable ['QS_winch_server',FALSE])) then {
			['MODE25','MODE27',_childNew] call QS_fnc_simpleWinch;
		};
		if (_setOwner) then {
			if ((owner _childNew) isNotEqualTo _clientOwner) then {
				[_childNew,_clientOwner] spawn {
					params ['_childNew','_clientOwner'];
					for '_z' from 0 to 9 step 1 do {
						if (_childNew setOwner _clientOwner) exitWith {};
					};
				};
			};
		};
		if (_deleteOld) then {
			_childOld spawn {
				sleep (diag_deltaTime * 2);
				deleteVehicle _this;
			};
		};
	};
	if (_mode2 isEqualTo 'MODE31') then {
		params ['','','_ropeParams'];
		_ropeParams params ['_attachedObject','_rope','_ropeParent'];
		[_attachedObject,_rope] remoteExec ['ropeDetach',0,FALSE];
		['MODE16',_ropeParent,_rope] remoteExec ['QS_fnc_simpleWinch',_ropeParent,FALSE];
	};
	if (_mode2 isEqualTo 'MODE32') then {
		params ['','',['_ropes',[]]];
		{
			ropeDestroy _x;
		} forEach _ropes;
	};
	if (_mode2 isEqualTo 'MODE33') then {
		params ['','','_ropeParams'];
		[_ropeParams] spawn {
			params ['_ropeParams'];
			_rope = _ropeParams # 0;
			ropeUnwind _ropeParams;
			uiSleep (diag_deltaTime * 2);
			_timeout = diag_tickTime + 10;
			waitUntil { ((ropeUnwound _rope) || (diag_tickTime > _timeout)) };
			ropeDestroy _rope;
		};
	};
	if (_mode2 isEqualTo 'MODE34') then {
		params ['','','_ropeParams'];
		_ropeParams params ['_parent','_child','_rope','_ropeLength','_clientOwner','_monitor_index'];
		_attachPointInfo = ['MODE23',_parent] call QS_fnc_simpleWinch;
		if (isDedicated) then {
			_child setVariable ['QS_rope_mode',3,TRUE];
			_parent setVariable ['QS_rope_mode',3,TRUE];
			_rope remoteExec ['ropeDestroy',0];
			[_parent,_child,objNull,_rope,_clientOwner,_monitor_index,(_attachPointInfo # 1),_ropeLength] spawn {
				params ['_parent','_child','_newRope','_rope','_clientOwner','_monitor_index','_attachPoint','_ropeLength'];
				private _timeout = diag_tickTime + 5;
				waitUntil {
					_newRope = ropeCreate [_child,[0,0,0],_parent,_attachPoint,_ropeLength,['RopeEnd',[0,1,0]],['',[0,1,0]],'Rope',-1];
					sleep 1;
					((!isNull _newRope) || (diag_tickTime > _timeout))
				};
				if (diag_tickTime > _timeout) exitWith {};
				_newRope setVariable ['QS_rope_relation',[_child,_parent,'WINCH'],TRUE];
				['MODE13',_parent,_child,_newRope,_rope,_monitor_index] remoteExec ['QS_fnc_simpleWinch',_clientOwner,FALSE];
			};
		} else {
			private _timeout = diag_tickTime + 5;
			private _newRope = objNull;
			ropeDestroy _rope;
			sleep (diag_deltaTime * 2);
			waitUntil {
				_newRope = ropeCreate [_child,[0,0,0],_parent,(_attachPointInfo # 1),_ropeLength,['RopeEnd',[0,1,0]],['',[0,1,0]],'Rope',-1];
				((!isNull _newRope) || (diag_tickTime > _timeout))
			};		
			_newRope setVariable ['QS_rope_relation',[_child,_parent,'WINCH'],TRUE];
			if (diag_tickTime > _timeout) exitWith {};
			['MODE13',_parent,_child,_newRope,_rope,_monitor_index] call QS_fnc_simpleWinch;
		};
	};
};