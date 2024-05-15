/*/
File: fn_simplePull.sqf
Author:

	Quiksilver
	
Last Modified:

	27/1/2023 A3 2.12 by Quiksilver
	
Description:

	Simple Pulling
___________________________________________/*/

params ['_mode'];
if (_mode isEqualTo 'MODE0') exitWith {
	params ['','_vehicle','_data'];
	_attached = ropeAttachedObjects _vehicle;
	if (_attached isNotEqualTo []) then {
		private _child = _attached # 0;
		_rope = (ropes _vehicle) # 0;
		if ((getTowParent _child) isNotEqualTo _vehicle) then {
			if (local _child) then {
				_child setTowParent _vehicle;
			} else {
				if (diag_tickTime > (uiNamespace getVariable ['QS_winch_lastRXTime',-1])) then {
					uiNamespace setVariable ['QS_winch_lastRXTime',diag_tickTime + 2];
					['setTowParent',_child,_vehicle] remoteExec ['QS_fnc_remoteExecCmd',[_child,_vehicle],FALSE];
				};
			};
		};
		_ropeEndPositions = ropeEndPosition _rope;
		_maxCoef = 1.1;
		_slowCoef = 0.9;
		if (_ropeEndPositions isNotEqualTo []) then {
			if (((_ropeEndPositions # 0) distance (_ropeEndPositions # 1)) < ((ropeLength _rope) / 2)) then {
				_maxCoef = 0.9;
			};
			if (
				(!brakesDisabled _child) &&
				{((vectorMagnitude (velocity _child)) < 0.1)} &&
				{((vectorMagnitude (velocity _vehicle)) > 1)} &&
				{(((_ropeEndPositions # 0) distance (_ropeEndPositions # 1)) > ((ropeLength _rope) * 2))}
			) then {
				_child disableBrakes TRUE;
				if (!isAwake _child) then {
					_child awake TRUE;
				};
			};
		};
		_data pushBack [_child,getMass _child,'VALID'];
		_maxPulledSpeed = (vectorMagnitude (velocity _vehicle)) * _maxCoef;
		_pulledSpeed = vectorMagnitude (velocity _child);
		if (
			(_pulledSpeed > _maxPulledSpeed) && 
			(_pulledSpeed > 0.5)
		) then {
			_child setVelocity ((velocity _child) vectorMultiply _slowCoef);
		};
		['MODE0',_child,_data] call QS_fnc_simplePull;
	};
	_data
};
if (_mode isEqualTo 'MODE1') exitWith {
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
						uiNamespace setVariable ['QS_winch_lastRXTime',diag_tickTime + 2];
						['disableBrakes',_child,_toggle] remoteExec ['QS_fnc_remoteExecCmd',_child,FALSE];
					};
				};
			};
		};
		['MODE1',_child,_toggle] call QS_fnc_simplePull;
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
			if (brakesDisabled _child) then {
				if (local _child) then {
					_child disableBrakes FALSE;
				} else {
					if (diag_tickTime > (uiNamespace getVariable ['QS_winch_lastRXTime',-1])) then {
						uiNamespace setVariable ['QS_winch_lastRXTime',diag_tickTime + 2];
						['disableBrakes',_child,FALSE] remoteExec ['QS_fnc_remoteExecCmd',_child,FALSE];
					};
				};
			};
		};
		['MODE2',_child] call QS_fnc_simplePull;
	};
};
if (_mode isEqualTo 'MODE3') exitWith {
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
						uiNamespace setVariable ['QS_winch_lastRXTime',diag_tickTime + 2];
						['disableBrakes',_child,TRUE] remoteExec ['QS_fnc_remoteExecCmd',_child,FALSE];
					};
				};
			};
		};
		['MODE3',_child] call QS_fnc_simplePull;
	};
};
if (_mode isEqualTo 'MODE4') exitWith {
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
			_nudgeVector = [0,[3,-3] select (uiNamespace getVariable ['QS_uiaction_carback',FALSE]),0.1];
			if (local _child) then {
				if (!brakesDisabled _child) then {
					_child disableBrakes TRUE;
				};
				_child setVelocityModelSpace _nudgeVector;
			} else {
				if (diag_tickTime > (uiNamespace getVariable ['QS_winch_lastRXTime',-1])) then {
					uiNamespace setVariable ['QS_winch_lastRXTime',diag_tickTime + 2];
					[108,_child,_nudgeVector] remoteExec ['QS_fnc_remoteExec',_child,FALSE];
				};
			};
		};
		['MODE4',_child] call QS_fnc_simplePull;
	};
};
if (_mode isEqualTo 'MODE5') exitWith {
	params ['','_vehicle',['_requireLocal',FALSE]];
	(0 boundingBoxReal _vehicle) params ['_p1','_p2','_rad'];
	_intersections = (lineIntersectsSurfaces [
		(_vehicle modelToWorldVisualWorld [0,_p1 # 1,(_p1 # 2) + 1]),
		(_vehicle modelToWorldVisualWorld [0,(_p1 # 1) - 8,(_p1 # 2) + 1]),
		_vehicle
	]) select {
		private _v = _x # 3;
		(
			(alive _v) &&
			{(simulationEnabled _v)} &&
			{(ropeAttachEnabled _v)} &&
			{((['Car','Tank','Ship','Air'] findIf { _v isKindOf _x }) isNotEqualTo -1)} &&
			{(_v isNotEqualTo _vehicle)} &&
			{((locked _v) in [0,1])} &&
			{(!(lockedDriver _v))} &&
			{(isNull (isVehicleCargo _v))} &&
			{(isNull (attachedTo _v))} &&
			{(isNull (ropeAttachedTo _v))} &&
			{(!(_v getVariable ['QS_logistics_deployed',FALSE]))} &&
			{(((crew _v) findIf {((isPlayer _x) && ((lifeState _x) in ['HEALTHY','INJURED']))}) isEqualTo -1)} &&
			{((vectorMagnitude (velocity _v)) < 1)} &&
			{((_vehicle getRelDir _v) > 90) && ((_vehicle getRelDir _v) < 270)} &&
			{((_v getRelDir _vehicle) > 270) || ((_v getRelDir _vehicle) < 90)} &&
			{(!_requireLocal) || {(_requireLocal && (local _v))}} &&
			{(((['MODE20',_v] call QS_fnc_simplePull) findAny ['SLING','WINCH']) isEqualTo -1)} &&
			{(!(['MODE6',_v] call QS_fnc_simplePull))} &&
			{(['MODE18',_vehicle,_v] call QS_fnc_simplePull)}
		)	
	};
	if (_intersections isNotEqualTo []) exitWith {
		[0,(_intersections # 0) # 3]
	};
	[-1,objNull]
};
if (_mode isEqualTo 'MODE6') exitWith {
	params ['','_vehicle'];
	(
		(!isNull (getSlingLoad _vehicle)) ||
		{(
			(!isNull (ropeAttachedTo _vehicle)) &&
			{(_vehicle isEqualTo (getSlingLoad (ropeAttachedTo _vehicle)))}
		)}
	)
};
if (_mode isEqualTo 'MODE7') exitWith {
	params ['','_parent','_child','_return1'];
	private _parentattachPointIndex = -1;
	private _parentAttachPointData = [];
	private _parentAttachPoint = [0,0,0];
	private _childAttachPointIndex = -1;
	private _childAttachPointData = [];
	private _childAttachPoint = [0,0,0];
	private _parentAttachPoints = [];
	private _childAttachPoints = [];
	private _attachPoint_parent = [];
	private _attachPoint_child = [];
	private _conditionParent = {TRUE};
	private _conditionChild = {TRUE};
	_attachPointData_parent = QS_hashmap_pullPoints getOrDefault [toLowerANSI (typeOf _parent),[]];
	if (_attachPointData_parent isNotEqualTo []) then {
		_parentAttachPoints = _attachPointData_parent # 1;
		_parentAttachPoints sort TRUE;
		if ((count _parentAttachPoints) isEqualTo 2) then {
			_parentAttachPoints params ['_attach1','_attach2'];
			_attach2 set [1,_attach1 # 1];
			_attach2 set [2,_attach1 # 2];
		};
		_conditionParent = _attachPointData_parent # 2;
	};
	_attachPointData_child = QS_hashmap_pullPoints getOrDefault [toLowerANSI (typeOf _child),[]];
	if (_attachPointData_child isNotEqualTo []) then {
		_childAttachPoints = _attachPointData_child # 0;
		_childAttachPoints sort TRUE;
		if ((count _childAttachPoints) isEqualTo 2) then {
			_childAttachPoints params ['_attach1','_attach2'];
			_attach2 set [1,_attach1 # 1];
			_attach2 set [2,_attach1 # 2];
		};
		_conditionChild = _attachPointData_child # 2;
	};
	_parentAttachPoints = if (_parentAttachPoints isNotEqualTo []) then {
		_parentAttachPoints
	} else {
		[['BACK',_parent] call QS_fnc_getRopeAttachPos]
	};		
	_childAttachPoints = if (_childAttachPoints isNotEqualTo []) then {
		_childAttachPoints
	} else {
		[['FRONT',_child] call QS_fnc_getRopeAttachPos]
	};
	[
		_parentAttachPoints,
		_childAttachPoints,
		((_parent modelToWorld (_parentAttachPoints # 0)) distance (_child modelToWorld (_childAttachPoints # 0))),
		_conditionParent,
		_conditionChild
	]
};
if (_mode isEqualTo 'MODE8') exitWith {
	params ['',['_objectParent',cameraOn]];
	(
		(alive _objectParent) &&
		{(local _objectParent)} &&
		{(ropeAttachEnabled _objectParent)} &&
		{(simulationEnabled _objectParent)} &&
		{((ropeAttachedObjects _objectParent) isEqualTo [])} &&
		{(isNull (isVehicleCargo _objectParent))} &&
		{(isNull (attachedTo _objectParent))} &&
		{(!(_objectParent getVariable ['QS_logistics_wreck',FALSE]))} &&
		{(!(_objectParent getVariable ['QS_logistics_deployed',FALSE]))} &&
		{((vectorMagnitude (velocity _objectParent)) < 1)} &&
		{(((['MODE20',_objectParent] call QS_fnc_simplePull) findAny ['SLING','WINCH']) isEqualTo -1)} &&
		{(((['MODE5',_objectParent] call QS_fnc_simplePull) # 0) isNotEqualTo -1)} &&
		{(!((getPlayerUID player) in QS_blacklist_logistics))}
	)
};
if (_mode isEqualTo 'MODE9') exitWith {
	params ['',['_objectParent',cameraOn]];
	(
		((ropeAttachedObjects _objectParent) isNotEqualTo []) &&
		{(isNull (getSlingLoad _objectParent))} &&
		{(!(['MODE6',_objectParent] call QS_fnc_simplePull))}
	)
};
if (_mode isEqualTo 'MODE10') exitWith {
	params ['','_parent',['_requireLocal',TRUE]];
	(['MODE5',_parent,_requireLocal] call QS_fnc_simplePull) params ['_return1','_child'];
	if (_return1 isEqualTo -1) exitWith {};
	if (_parent isEqualTo cameraOn) then {
		_dn = QS_hashmap_configfile getOrDefaultCall [
			format ['cfgvehicles_%1_displayname',toLowerANSI (typeOf _child)],
			{getText ((configOf _child) >> 'displayName')},
			TRUE
		];
		50 cutText [format ['%1 %2',localize 'STR_QS_Text_320',_child getVariable ['QS_ST_customDN',_dn]],'PLAIN DOWN',0.5];
	};
	[106,_parent,_child,_return1] remoteExec ['QS_fnc_remoteExec',2,FALSE];
	_child spawn {
		uisleep 0.5;
		['MODE10',_this,TRUE] call QS_fnc_simplePull;
	};
};
if (_mode isEqualTo 'MODE11') exitWith {
	_cameraOn = cameraOn;
	_nearRopeSegments = ((_cameraOn modelToWorld (_cameraOn selectionPosition 'head')) nearObjects 2) select {_x isKindOf 'RopeSegment'};
	if (
		(!isNull (missionNamespace getVariable ['QS_winch_globalHelperObject',objNull])) &&
		{((missionNamespace getVariable ['QS_winch_globalHelperObject',objNull]) in (attachedObjects _cameraOn))}
	) exitWith {FALSE};
	if (missionNamespace getVariable ['QS_targetBoundingBox_placementMode',FALSE]) exitWith {FALSE};
	((_nearRopeSegments select { (ropeUnwound (objectParent _x)) }) isNotEqualTo [])
};
if (_mode isEqualTo 'MODE12') exitWith {
	_cameraOn = cameraOn;
	_nearRopeSegments = ((_cameraOn modelToWorld (_cameraOn selectionPosition 'head')) nearObjects 2) select {_x isKindOf 'RopeSegment'};
	if (_nearRopeSegments isNotEqualTo []) then {
		QS_player playActionNow 'PutDown';
		_rope = objectParent (_nearRopeSegments # 0);
		if (ropeUnwound _rope) then {
			['ropeDestroy',_rope] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
			50 cutText [localize 'STR_QS_Text_344','PLAIN',0.333];
		};
	};
};
if (_mode isEqualTo 'MODE13') exitWith {
	params ['',['_objectParent',cameraOn]];
	['MODE14',_objectParent] call QS_fnc_simplePull;
	50 cutText [localize 'STR_QS_Text_092','PLAIN DOWN',0.5];
};
if (_mode isEqualTo 'MODE14') exitWith {
	params ['','_parent',['_ropes',[]],['_child',objNull]];
	_attached = ropeAttachedObjects _parent;
	if (_ropes isNotEqualTo []) then {
		{ropeDestroy _x;} forEach _ropes;
	};
	if (_attached isNotEqualTo []) then {
		{ ropeDestroy _x; } forEach (ropes _parent);
		{
			['MODE15',_x] call QS_fnc_simplePull;
		} forEach _attached;
	};
	if (
		(!isNull _child) &&
		{(!(_child in _attached))}
	) then {
		['MODE15',_child] call QS_fnc_simplePull;
	};
};
if (_mode isEqualTo 'MODE15') exitWith {
	params ['','_child'];
	if (!isNull _child) then {
		_simulation = QS_hashmap_configfile getOrDefaultCall [
			format ['cfgvehicles_%1_simulation',toLowerANSI (typeOf _child)],
			{toLowerANSI (getText ((configOf _child) >> 'simulation'))},
			TRUE
		];
		if (_simulation in ['tankx','carx']) then {
			if (!isNull (getTowParent _child)) then {
				if (local _child) then {
					_child setTowParent objNull;
					_child disableBrakes FALSE;
				} else {
					['setTowParent',_child,objNull] remoteExec ['QS_fnc_remoteExecCmd',_child,FALSE];
					['disableBrakes',_child,FALSE] remoteExec ['QS_fnc_remoteExecCmd',_child,FALSE];
				};
			};
		};
	};
};	
if (_mode isEqualTo 'MODE16') exitWith {
	params ['','_parent'];
	missionNamespace setVariable ['QS_simplePull_monitor',FALSE,FALSE];
	if (QS_pullrelease_action in (actionIDs player)) then {
		player removeAction QS_pullrelease_action;
	};
};
if (
	(_mode isEqualTo 'MODE17') &&
	{(((['MODE20',cameraOn] call QS_fnc_simplePull) findAny ['PULL']) isNotEqualTo -1)}
) exitWith {
	if (!(missionNamespace getVariable ['QS_simplePull_monitor',FALSE])) then {
		if (isNil 'QS_pullrelease_action') then {
			QS_pullrelease_action = -1;
		};
		if (!(QS_pullrelease_action in (actionIDs player))) then {
			QS_pullrelease_action = player addAction [localize 'STR_QS_Interact_010',{['MODE13'] call QS_fnc_simplePull},nil,9,FALSE,TRUE,'','(["MODE9"] call QS_fnc_simplePull)'];
			player setUserActionText [QS_pullrelease_action,localize 'STR_QS_Interact_010',(format ["<t size='3'>%1</t>",localize 'STR_QS_Interact_010'])];
		};
		missionNamespace setVariable ['QS_simplePull_monitor',TRUE,FALSE];
		uiNamespace setVariable ['QS_simplePull_updateLocality',-1];
		_maxSafe = 60;
		private _hintToken = missionProfileNamespace getVariable ['QS_hintToken_pull_1',0];
		if (_hintToken < 100) then {
			_hintToken = _hintToken + 1;
			missionProfileNamespace setVariable ['QS_hintToken_pull_1',_hintToken];
			saveMissionProfileNamespace;
			_customUpText = [
				actionKeysNames ['User18',1] trim ['"',0],
				localize 'STR_QS_Text_367'
			] select ((actionKeysNamesArray 'User18') isEqualTo []);
			_customDownText = [
				actionKeysNames ['User17',1] trim ['"',0],
				localize 'STR_QS_Text_366'
			] select ((actionKeysNamesArray 'User17') isEqualTo []);
			_text = format ['
				<t align="left">%7</t><t align="right">[%1]</t><br/><br/>
				<t align="left">%8</t><t align="right">[%2]</t><br/><br/>
				<t align="left">%9</t><t align="right">[%3] [%4] OR [%11] [%12]</t><br/><br/>
				<t align="left">%10</t><t align="right">%5 %6</t>
				',
				actionKeysNames 'carhandbrake' trim ['"',0],
				actionKeysNames 'vehicleturbo' trim ['"',0],
				actionKeysNames 'gunElevUp' trim ['"',0],
				actionKeysNames 'gunElevDown' trim ['"',0],
				_maxSafe,
				localize 'STR_QS_Text_242',
				localize 'STR_QS_Hints_152',
				localize 'STR_QS_Hints_153',
				localize 'STR_QS_Hints_154',
				localize 'STR_QS_Hints_155',
				_customUpText,
				_customDownText
			];
			[_text,TRUE,TRUE,localize 'STR_QS_Hints_151',TRUE] call QS_fnc_hint;
		};
		uiNamespace setVariable ['QS_overspeed_warningShown',FALSE];
		
		localNamespace setVariable ['QS_maxTrain_default',2];		// Default max road-train length (number of attached trailers)
		
		addMissionEventHandler [
			'EachFrame',
			{
				if (!local cameraOn) exitWith {};
				_vehicle = cameraOn;
				_speed = abs (((velocityModelSpace _vehicle) # 1) * 3.6);
				if (!(uiNamespace getVariable ['QS_overspeed_warningShown',FALSE])) then {
					if (_speed > 60) then {
						uiNamespace setVariable ['QS_overspeed_warningShown',TRUE];
						if (_vehicle isKindOf 'LandVehicle') then {
							50 cutText [localize 'STR_QS_Text_373','PLAIN DOWN',0.5];
						};
					};
				};
				if (
					((ropeAttachedObjects _vehicle) isNotEqualTo []) &&
					((_vehicle getVariable ['QS_rope_mode',1]) isEqualTo 1)
				) then {
					if ((uiNamespace getVariable ['QS_pulling_mass_mover',0]) isNotEqualTo (getMass _vehicle)) then {
						uiNamespace setVariable ['QS_pulling_mass_mover',getMass _vehicle];
					};
					_data = ['MODE0',_vehicle,[]] call QS_fnc_simplePull;
					_priorMass = 0;
					_massDiffLimit = 2;
					_breakSpeed = 20;
					_vectorUpLimit = -0.5;
					_entity = objNull;
					private _weakLink = objNull;
					private _weakLinkMass = 0;
					private _priorLink = objNull;
					_length = FALSE;
					_flipped = FALSE;
					_water = FALSE;
					_ropeMode = FALSE;
					{
						_entity = _x # 0;
						if (
							(_forEachIndex > 0) &&
							{((_x # 1) > (_priorMass * _massDiffLimit))} && 
							{(_speed > _breakSpeed)}
						) exitWith {
							_weakLink = _entity;
							_weakLinkMass = _x # 1;
							_data set [_forEachIndex,[_entity,_x # 1,'INVALID']];
						};
						if (
							(((vectorUp _entity) # 2) < _vectorUpLimit) &&
							{(_speed > _breakSpeed)}
						) exitWith {
							_flipped = TRUE;
							_weakLink = _entity;
						};
						if (((getPosASL _entity) # 2) < -1) then {
							if (
								(!(_entity getEntityInfo 9)) &&
								(waterDamaged _entity)
							) then {
								_water = TRUE;
								_weakLink = _entity;
							};
						};
						if (_water) exitWith {};
						if (((['MODE20',_entity] call QS_fnc_simplePull) findAny ['SLING','WINCH']) isNotEqualTo -1) exitWith {
							_weakLink = _entity;
							_ropeMode = TRUE;
						};
						if (_forEachIndex >= (_vehicle getVariable ['QS_towing_maxTrain_1',(localNamespace getVariable ['QS_maxTrain_default',2])])) exitWith {
							_weakLink = _entity;
							_length = TRUE;
						};
						_priorLink = _entity;
						_priorMass = _x # 1;
					} forEach _data;
					if (!isNull _weakLink) then {
						if (_ropeMode) exitWith {
							['MODE14',(ropeAttachedTo _weakLink),ropes (ropeAttachedTo _weakLink),_weakLink] call QS_fnc_simplePull;
							50 cutText [localize 'STR_QS_Text_370','PLAIN DOWN',0.5];
						};
						if (_flipped || _water) exitWith {
							['MODE14',(ropeAttachedTo _weakLink),ropes (ropeAttachedTo _weakLink),_weakLink] call QS_fnc_simplePull;
							50 cutText [localize 'STR_QS_Text_092','PLAIN DOWN',0.5];
						};
						if (_length) exitWith {
							['MODE14',(ropeAttachedTo _weakLink),ropes (ropeAttachedTo _weakLink),_weakLink] call QS_fnc_simplePull;
							50 cutText [
								format [
									'%1 (%2)',
									localize 'STR_QS_Text_327',
									(_vehicle getVariable ['QS_towing_maxTrain_1',(localNamespace getVariable ['QS_maxTrain_default',2])])
								],
								'PLAIN DOWN',
								0.5
							];
						};
						_text1 = QS_hashmap_configfile getOrDefaultCall [
							format ['cfgvehicles_%1_displayname',toLowerANSI (typeOf _weakLink)],
							{getText ((configOf _weakLink) >> 'displayName')},
							TRUE
						];
						_text2 = QS_hashmap_configfile getOrDefaultCall [
							format ['cfgvehicles_%1_displayname',toLowerANSI (typeOf _priorLink)],
							{getText ((configOf _priorLink) >> 'displayName')},
							TRUE
						];
						_text = format [
							'<t align="left">%1</t> <t align="right">%2 %8</t><br/>
							<t align="left">%3</t> <t align="right">%4 %8</t><br/><br/>
							<t align="left">%10</t> <t align="right">%5 x</t><br/>
							<t align="left">%11</t><t align="right">%6 x</t><br/>
							<t align="left">%12</t><t align="right">%7 %9</t>',
							_text2,
							_priorMass,
							_text1,
							_weakLinkMass,
							((_weakLinkMass / _priorMass) toFixed 2),
							_massDiffLimit toFixed 2,
							_breakSpeed,
							localize 'STR_QS_Hints_156',
							localize 'STR_QS_Hints_157',
							localize 'STR_QS_Hints_158',
							localize 'STR_QS_Hints_159',
							localize 'STR_QS_Hints_160'
						];
						[_text,TRUE,TRUE,localize 'STR_QS_Hints_161',TRUE] call QS_fnc_hint;
						50 cutText [localize 'STR_QS_Text_092','PLAIN DOWN',0.5];
						['MODE14',(ropeAttachedTo _weakLink),ropes (ropeAttachedTo _weakLink)] call QS_fnc_simplePull;
					};
					if (isNull (ropeAttachedTo _vehicle)) then {
						if (diag_tickTime > (uiNamespace getVariable ['QS_simplePull_updateLocality',-1])) then {
							uiNamespace setVariable ['QS_simplePull_updateLocality',diag_tickTime + 5];
							{
								if (
									(alive (_x # 0)) &&
									(!local (_x # 0))
								) then {
									['setOwner',(_x # 0),clientOwner] remoteExec ['QS_fnc_remoteExecCmd',2,FALSE];
								};
							} forEach _data;
						};
					};
				};
				if (
					(!alive _vehicle) ||
					{(_vehicle isKindOf 'Air')} ||
					{((ropeAttachedObjects _vehicle) isEqualTo [])} ||
					{(((['MODE20',_vehicle] call QS_fnc_simplePull) findAny ['SLING','WINCH']) isNotEqualTo -1)}
				) exitWith {
					removeMissionEventHandler [_thisEvent,_thisEventHandler];
					if ((_vehicle getVariable ['QS_rope_mode',1]) isEqualTo 1) then {
						['MODE16',_vehicle] call QS_fnc_simplePull;
						['MODE14',_vehicle,ropes _vehicle] call QS_fnc_simplePull;
					};
				};
			}
		];
	};
};
if (_mode isEqualTo 'MODE18') exitWith {
	params ['','_parent','_child'];
	private _return = FALSE;
	_rulesTable = [
		['CAR',['CAR','TANK','SHIP','AIR']],
		['TANK',['CAR','TANK','SHIP','AIR']],
		['SHIP',['CAR','TANK','SHIP']],
		['AIR',[]]
	];
	_index = _rulesTable findIf { _parent isKindOf (_x # 0) };
	if (_index isNotEqualTo -1) then {
		_parentType = (_rulesTable # _index) # 0;
		_allowedList = (_rulesTable # _index) # 1;
		_return = (_allowedList findIf { _child isKindOf _x }) isNotEqualTo -1;
		if (
			(_parentType isEqualTo 'SHIP') &&
			{(!(_child isKindOf 'Ship'))}
		) then {
			_return = _child getEntityInfo 9;
		};
	};
	_return;
};
if (_mode isEqualTo 'MODE19') exitWith {
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
if (_mode isEqualTo 'MODE20') exitWith {
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
if (_mode isEqualTo 'MODE21') exitWith {
	params ['','_parent','_child','_attachPoint_parent','_attachPoint_child',['_ropeLength',5]];
	_rope = ropeCreate [_parent,_attachPoint_parent,_child,_attachPoint_child,3 max (_ropeLength * 1.2) min 20,['RopeEnd',[0,1,0]],['RopeEnd',[0,-1,0]],'Rope'];
	_rope setVariable ['QS_rope_relation',[_parent,_child,'PULL'],TRUE];
	['MODE17'] call QS_fnc_simplePull;
};
if (_mode isEqualTo 'MODE22') exitWith {
	player setVariable ['QS_sling_keyDownDelay',(diag_tickTime + 0.5),FALSE];
	params ['','_vehicle',['_upOrDown',FALSE]];
	if (!local _vehicle) exitWith {};
	if (
		((ropeAttachedObjects _vehicle) isEqualTo []) &&
		((ropes _vehicle) isNotEqualTo [])
	) exitWith {
		{ ropeDestroy _x; } forEach (ropes _vehicle);
	};
	_speed = [1,5] select ((uiNamespace getVariable ['QS_uiaction_vehicleturbo',FALSE]) || (uiNamespace getVariable ['QS_uiaction_turbo',FALSE]));
	_min = 2;
	_max = 24;
	_delta = 1;
	private _ropeLength = 0;
	if (_upOrDown) then {
		{
			_ropeLength = ropeLength _x;
			if (_ropeLength >= (_min + 1)) then {
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
	_child = (ropeAttachedObjects _vehicle) # 0;
	if (!isNull _child) then {
		['MODE22',_child,_upOrDown] call QS_fnc_simplePull;
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
if (_mode isEqualTo 'MODE23') exitWith {
	params ['','_parent','_child','_return1'];
	_parent setVariable ['QS_rope_mode',1,TRUE];
	_child setVariable ['QS_rope_mode',1,TRUE];
	if ((_parent getVariable ['QS_pullParent_EHs',[]]) isEqualTo []) then {
		private _EHs = [];
		{
			_EHs pushBack ([_x # 0,_parent addEventHandler _x]);
		} forEach [
			[
				'Local',
				{
					params ['_parent','_isLocal'];
					{ropeDestroy _x} forEach (ropes _parent);
					['MODE14',_parent,ropes _parent] remoteExec ['QS_fnc_simplePull',_parent,FALSE];
				}
			],
			[
				'Deleted',
				{
					params ['_parent'];
					{ropeDestroy _x} forEach (ropes _parent);
					['MODE14',_parent,ropes _parent] remoteExec ['QS_fnc_simplePull',_parent,FALSE];
				}
			],
			[
				'Killed',
				{
					params ['_parent'];
					{ropeDestroy _x} forEach (ropes _parent);
					['MODE14',_parent,ropes _parent] remoteExec ['QS_fnc_simplePull',_parent,FALSE];
				}
			],
			[
				'RopeAttach',
				{
					params ['_parent','_rope','_child'];
					_ropeMode = _parent getVariable ['QS_rope_mode',0];
					if (_ropeMode in [2,3]) exitWith {};
					private _destroyRopes = FALSE;
					if ((ropeAttachedObjects _parent) isNotEqualTo []) then {
						{
							if (_x isNotEqualTo _child) then {
								_destroyRopes = TRUE;
							};
						} forEach (ropeAttachedObjects _parent);
					};
					if (_destroyRopes) then {
						['MODE14',_parent,ropes _parent] remoteExec ['QS_fnc_simplePull',_parent,FALSE];
					};
				}
			],
			[
				'RopeBreak',
				{
					params ['_parent','_rope','_child'];
					_ropeMode = _parent getVariable ['QS_rope_mode',0];
					if (_ropeMode in [2,3]) exitWith {};
					if (isNull (ropeAttachedTo _child)) then {
						['MODE14',_parent] remoteExec ['QS_fnc_simplePull',_parent,FALSE];
						['MODE15',_child] remoteExec ['QS_fnc_simplePull',_child,FALSE];
					} else {
						ropeDestroy _rope;
					};
				}
			]
		];
		_parent setVariable ['QS_pullParent_EHs',_EHs,FALSE];
	};
	if ((_child getVariable ['QS_pullChild_EHs',[]]) isEqualTo []) then {
		_EHs = [];
		{
			_EHs pushBack ([_x # 0,_child addEventHandler _x]);
		} forEach [
			[
				'Engine',
				{
					params ['_child','_engineState'];
					if (
						_engineState &&
						{((['MODE19',_child] call QS_fnc_simplePull) <= 1)} &&
						{(!isNull (ropeAttachedTo _child))}
					) then {
						_parent = ropeAttachedTo _child;
						if (!(_child isEqualTo (getSlingLoad _parent))) then {
							if ((ropes _parent) isNotEqualTo []) then {
								{ropeDestroy _x} forEach (ropes _parent);
							};
							['MODE14',_child] remoteExec ['QS_fnc_simplePull',_child,FALSE];
						};
					};
				}
			],
			[
				'Deleted',
				{
					params ['_child'];
					if (!isNull (ropeAttachedTo _child)) then {
						_parent = ropeAttachedTo _child;
						if (!(_child isEqualTo (getSlingLoad _parent))) then {
							if ((ropes _parent) isNotEqualTo []) then {
								{ropeDestroy _x} forEach (ropes _parent);
							};
						};
					};
					['MODE14',_child] remoteExec ['QS_fnc_simplePull',_child,FALSE];
				}
			],
			[
				'Killed',
				{
					params ['_child'];
					if (!isNull (ropeAttachedTo _child)) then {
						_parent = ropeAttachedTo _child;
						if (!(_child isEqualTo (getSlingLoad _parent))) then {
							if ((ropes _parent) isNotEqualTo []) then {
								{ropeDestroy _x} forEach (ropes _parent);
							};
						};
					};
					['MODE14',_child] remoteExec ['QS_fnc_simplePull',_child,FALSE];
				}
			],
			[
				'Local',
				{
					params ['_child','_isLocal'];
					if (
						(isNull (ropeAttachedTo _child)) ||
						{((owner _child) isEqualTo (owner (ropeAttachedTo _child)))}
					) exitWith {};
					['MODE15',_child] remoteExec ['QS_fnc_simplePull',_child,FALSE];
					['MODE14',(ropeAttachedTo _child)] remoteExec ['QS_fnc_simplePull',(ropeAttachedTo _child),FALSE];
				}
			]			
		];
		_child setVariable ['QS_pullChild_EHs',_EHs,FALSE];
	};
	_timeout = diag_tickTime + 3;
	if ((owner _child) isNotEqualTo (owner _parent)) then {
		waitUntil {
			((_child setOwner (owner _parent)) || (diag_tickTime > _timeout))
		};
	};
	['MODE24',_parent,_child,_return1] remoteExecCall ['QS_fnc_simplePull',[2,owner _parent,owner _child],FALSE];
};
if (_mode isEqualTo 'MODE24') exitWith {
	params ['','_parent','_child','_return1'];
	if (local _parent) then {
		if (!local _child) then {
			_child addEventHandler [
				'Local',
				{
					params ['_entity','_isLocal'];
					if (_isLocal) then {
						_entity disableBrakes TRUE;
						if ((getTowParent _entity) isNotEqualTo (ropeAttachedTo _entity)) then {
							_entity setTowParent (ropeAttachedTo _entity);
						};
						_entity removeEventHandler [_thisEvent,_thisEventHandler];
					};
				}
			];
		};
		(['MODE7',_parent,_child,_return1] call QS_fnc_simplePull) params ['_attachPoints_parent','_attachPoints_child','_attachDistance','_conditionParent','_conditionChild'];
		_ropeLengthFactor = 1.2;
		_ropeLengthMax = 25;
		_ropeLengthMin = 5;
		private _attachPointParent = [0,0,0];
		private _attachPointChild = [0,0,0];
		if (((count _attachPoints_parent) isEqualTo 1) && ((count _attachPoints_child) isEqualTo 1)) exitWith {
			_attachPointParent = _attachPoints_parent # 0;
			_attachPointChild = _attachPoints_child # 0;
			['MODE21',_parent,_child,_attachPointParent,_attachPointChild,_ropeLengthMax min (_attachDistance * _ropeLengthFactor) max _ropeLengthMin] call QS_fnc_simplePull;
		};
		if (((count _attachPoints_parent) isEqualTo 1) && ((count _attachPoints_child) isEqualTo 2)) exitWith {
			_attachPointParent = _attachPoints_parent # 0;
			_attachPointChild = _attachPoints_child # 0;
			['MODE21',_parent,_child,_attachPointParent,_attachPointChild,_ropeLengthMax min (_attachDistance * _ropeLengthFactor) max _ropeLengthMin] call QS_fnc_simplePull;				
			_attachPointChild = _attachPoints_child # 1;
			['MODE21',_parent,_child,_attachPointParent,_attachPointChild,_ropeLengthMax min (_attachDistance * _ropeLengthFactor) max _ropeLengthMin] call QS_fnc_simplePull;
		};
		if (((count _attachPoints_parent) isEqualTo 2) && ((count _attachPoints_child) isEqualTo 1)) exitWith {
			_attachPointParent = _attachPoints_parent # 0;
			_attachPointChild = _attachPoints_child # 0;
			['MODE21',_parent,_child,_attachPointParent,_attachPointChild,_ropeLengthMax min (_attachDistance * _ropeLengthFactor) max _ropeLengthMin] call QS_fnc_simplePull;				
			_attachPointParent = _attachPoints_parent # 1;
			['MODE21',_parent,_child,_attachPointParent,_attachPointChild,_ropeLengthMax min (_attachDistance * _ropeLengthFactor) max _ropeLengthMin] call QS_fnc_simplePull;
		};
		if (((count _attachPoints_parent) isEqualTo 2) && ((count _attachPoints_child) isEqualTo 2)) exitWith {
			_attachPointParent = _attachPoints_parent # 0;
			_attachPointChild = _attachPoints_child # 0;
			['MODE21',_parent,_child,_attachPointParent,_attachPointChild,_ropeLengthMax min (_attachDistance * _ropeLengthFactor) max _ropeLengthMin] call QS_fnc_simplePull;				
			_attachPointParent = _attachPoints_parent # 1;
			_attachPointChild = _attachPoints_child # 1;
			['MODE21',_parent,_child,_attachPointParent,_attachPointChild,_ropeLengthMax min (_attachDistance * _ropeLengthFactor) max _ropeLengthMin] call QS_fnc_simplePull;				
		};
	};
	if (local _child) then {
		_simulation = QS_hashmap_configfile getOrDefaultCall [
			format ['cfgvehicles_%1_simulation',toLowerANSI (typeOf _child)],
			{toLowerANSI (getText ((configOf _child) >> 'simulation'))},
			TRUE
		];
		if (_simulation in ['tankx','carx']) then {
			if ((getTowParent _child) isNotEqualTo _parent) then {
				['setTowParent',_child,_parent] remoteExec ['QS_fnc_remoteExecCmd',[_child,_parent],FALSE];
			};
			['disableBrakes',_child,TRUE] remoteExec ['QS_fnc_remoteExecCmd',[_child,_parent],FALSE];
		};
		_child engineOn FALSE;
		_child setVelocityModelSpace [0,1,0.1];
	};
};