/*
File: fn_clientInGameUIPrevAction.sqf
Author:

	Quiksilver
	
Last modified:

	24/02/2023 A3 2.12
	
Description:

	-
________________________________________*/

if (missionNamespace getVariable ['QS_targetBoundingBox_placementMode',FALSE]) exitWith {
	(uiNamespace getVariable ['QS_targetBoundingBox_bbox',[]]) params ['_p1','_p2','_radius'];
	(0 boundingBoxReal cameraOn) params ['','_q2',''];
	_maxZ = (cameraOn modelToWorld _q2) # 2;
	_upperBoundZ = (QS_targetBoundingBox_helper modelToWorld _p2) # 2;
	_lowerBoundZ = (QS_targetBoundingBox_helper modelToWorld _p1) # 2;
	_delta = [0.025,0.25] select (uiNamespace getVariable ['QS_uiaction_turbo',FALSE]);
	_newElev = (uiNamespace getVariable ['QS_targetBoundingBox_zOffset',0]) + _delta;	
	if ((_lowerBoundZ + _delta) < _maxZ) then {
		uiNamespace setVariable ['QS_targetBoundingBox_zOffset',_newElev];
	};
};
_object = missionNamespace getVariable ['QS_logistics_localTarget',objNull];
if (
	(!isNull _object) &&
	{(_object in (attachedObjects player))} &&
	{(!(uiNamespace getVariable ['QS_uiaction_ctrl',FALSE]))}
) then {
	_simulation = QS_hashmap_configfile getOrDefaultCall [
		format ['cfgvehicles_%1_simulation',toLowerANSI (typeOf _object)],
		{toLowerANSI (getText ((configOf _object) >> 'simulation'))},
		TRUE
	];
	_sim1 = ['house'];
	_followRotation = !(_object isKindOf 'StaticWeapon') && !(_simulation in _sim1);
	_boundingBox = QS_hashmap_boundingBoxes getOrDefaultCall [
		toLowerANSI (typeOf _object),
		{(0 boundingBoxReal _object)},
		TRUE
	];
	_boundingBox params ['_p1','_p2','_radius'];
	_boundingLengths = [(abs ((_p2 # 0) - (_p1 # 0))),(abs ((_p2 # 1) - (_p1 # 1)))];
	_playerBox = (0 boundingBoxReal player) params ['','_q2',''];
	_playerUpperZ = _q2 # 2;
	_objectLowerZ = (player worldToModel (_object modelToWorld _p1)) # 2;
	_bufferY = 0.333;
	_bufferZ = [0,0.25] select !_followRotation;
	_elevationOffset = [2,2] select !_followRotation;
	_memoryPoint = ['pelvis',''] select !_followRotation;
	_maxHeight = abs (((_p2 # 2) - (_p1 # 2)) / _elevationOffset);
	_elev = ((_object getVariable ['QS_logistics_elev',0]) + ([0.025,0.1] select (uiNamespace getVariable ['QS_uiaction_turbo',FALSE])));
	if (
		(_playerUpperZ > _objectLowerZ) &&
		{(_playerUpperZ > (_maxHeight + _bufferZ + _elev))}
	) then {
		_object attachTo [player,[0,((selectMax _boundingLengths) / 1.9) + _bufferY,_maxHeight + _bufferZ + _elev],_memoryPoint,_followRotation];
		_object setVariable ['QS_logistics_elev',_elev];
		_object setDir (_object getVariable ['QS_logistics_azi',0]);
	};
} else {
	if (
		(cameraView isEqualTo 'GUNNER') ||
		{((currentWeapon cameraOn) isEqualTo '')}
	) then {
		getCursorObjectParams params ['_cursorObject','_cursorSelection','_cursorDistance'];
		if (
			(!isNull _cursorObject) &&
			{_cursorSelection isNotEqualTo []} &&
			{_cursorDistance < 2}
		) then {
			_index = _cursorSelection findIf { ((QS_hashmap_animationParams getOrDefault [toLowerANSI _x,[]]) isNotEqualTo []) };
			if (_index isNotEqualTo -1) then {
				_data = QS_hashmap_animationParams getOrDefault [toLowerANSI (_cursorSelection # _index),[]];
				if (_data isNotEqualTo []) then {
					_data params ['_mode','_anim1','_anim2','_rangeMin','_rangeMax','_step','_speed','_lockedVar','_condition'];
					if (
						(_cursorObject call _condition) &&
						{((_cursorObject getVariable [_lockedVar,0]) isEqualTo 0)}
					) then {
						_step = [_step,_step * 2] select (uiNamespace getVariable ['QS_uiaction_turbo',FALSE]);
						_speed = [_speed,_speed * 2] select (uiNamespace getVariable ['QS_uiaction_turbo',FALSE]);
						private _anim = _anim1;
						if (_mode isEqualTo 0) then {
							_cursorObject animate [_anim,_rangeMin max ((_cursorObject animationPhase _anim) + _step) min _rangeMax];
						};
						if (_mode isEqualTo 1) then {
							_cursorObject animateSource [_anim,_rangeMin max ((_cursorObject animationSourcePhase _anim) + _step) min _rangeMax];
						};
						if (_mode isEqualTo 2) then {
							_cursorObject animateDoor [_anim,_rangeMin max ((_cursorObject doorPhase _anim) + _step) min _rangeMax];
						};
						if (_mode isEqualTo 3) then {
							_cursorObject animateDoor [_anim,_rangeMin max ((_cursorObject animationSourcePhase _anim) + _step) min _rangeMax];
						};
					};
				};
			};
		};
	};
};
FALSE;