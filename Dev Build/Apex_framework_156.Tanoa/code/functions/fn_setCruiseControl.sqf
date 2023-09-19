/*/
File: fn_setCruiseControl.sqf
Author:

	Quiksilver
	
Last Modified:

	24/01/2023 A3 2.10 by Quiksilver
	
Description:

	Cruise Control
_______________________________________/*/

params [['_entity',objNull]];
if (isNull _entity) then {
	_entity = cameraOn;
};
if (!alive _entity) exitWith {};
if (
	(_entity isKindOf 'LandVehicle') ||
	{(_entity isKindOf 'Ship')}
) then {
	private _cursorTarget = cursorObject;
	(getCruiseControl _entity) params ['_entityCC','_cruiseControlActive'];
	_maxSpeed = QS_hashmap_configfile getOrDefaultCall [
		format ['cfgvehicles_%1_maxspeed',toLowerANSI (typeOf _entity)],
		{getNumber ((configOf _entity) >> 'maxSpeed')},
		TRUE
	];
	private _speed = round ((((velocityModelSpace _entity) # 1) * 3.6) max 0);
	private _hintToken = missionProfileNamespace getVariable ['QS_hintToken_cc_1',0];
	if (_hintToken < 50) then {
		_hintToken = _hintToken + 1;
		missionProfileNamespace setVariable ['QS_hintToken_cc_1',_hintToken];
		saveMissionProfileNamespace;
		_customUpText = [
			actionKeysNames ['User18',1] trim ['"',0],
			localize 'STR_QS_Text_367'
		] select ((actionKeysNamesArray 'User18') isEqualTo []);
		_customDownText = [
			actionKeysNames ['User17',1] trim ['"',0],
			localize 'STR_QS_Text_366'
		] select ((actionKeysNamesArray 'User17') isEqualTo []);
		_text = format [
			'<t align="left">%6</t><t align="right">[%2] [%3]</t><br/><br/>
			<t align="left">%7</t> <t align="right">[%4] [%5] OR [%9] [%10]</t><br/><br/>
			<t align="left">%8</t> <t align="right">[%1]</t>',
			actionKeysNames ["carhandbrake",1] trim ['"',0],
			actionKeysNames ["turretElevationUp",1] trim ['"',0],
			actionKeysNames ["turretElevationDown",1] trim ['"',0],
			actionKeysNames ["gunElevUp",1] trim ['"',0],
			actionKeysNames ["gunElevDown",1] trim ['"',0],
			localize 'STR_QS_Hints_163',
			localize 'STR_QS_Hints_164',
			localize 'STR_QS_Hints_165',
			_customUpText,
			_customDownText
		];
		[
			_text,
			FALSE,
			TRUE,
			localize 'STR_QS_Hints_162',
			TRUE
		] call QS_fnc_hint;
	};
	if (
		(alive _cursorTarget) &&
		{(simulationEnabled _cursorTarget)} &&
		{((_cursorTarget isKindOf 'LandVehicle') || (_cursorTarget isKindOf 'Ship'))} &&
		{((_entity distance _cursorTarget) < 250)} &&
		{(((_entity getRelDir _cursorTarget) >= 270) || ((_entity getRelDir _cursorTarget) <= 90))} &&
		{(_cursorTarget isNotEqualTo _entity)}
	) exitWith {
		if (_cruiseControlActive) exitWith {50 cutText [localize 'STR_QS_Text_337','PLAIN DOWN',0.5];};
		_targetType = QS_hashmap_configfile getOrDefaultCall [
			format ['cfgvehicles_%1_displayname',toLowerANSI (typeOf _cursorTarget)],
			{getText ((configOf _cursorTarget) >> 'displayName')},
			TRUE
		];
		_targetMaxSpeed = QS_hashmap_configfile getOrDefaultCall [
			format ['cfgvehicles_%1_maxspeed',toLowerANSI (typeOf _cursorTarget)],
			{getNumber ((configOf _cursorTarget) >> 'maxSpeed')},
			TRUE
		];
		_convoyMaxSpeed = round (_maxSpeed min _targetMaxSpeed);
		50 cutText [format [localize 'STR_QS_Text_336',name (effectiveCommander _cursorTarget),(_cursorTarget getVariable ['QS_ST_customDN',_targetType]),_convoyMaxSpeed],'PLAIN DOWN',0.5];
		_speed = (round (((velocityModelSpace _cursorTarget) # 1) * 3.6)) max 0;
		_entity setCruiseControl [(_speed min (_maxSpeed + 1)),TRUE];
		[_entity,_cursorTarget,_speed,_maxSpeed,_convoyMaxSpeed] spawn {
			QS_cc_convoyActive = TRUE;
			scriptName 'QS Convoy Speed';
			params ['_entity','_cursorTarget','_speed','_maxSpeed','_convoyMaxSpeed'];
			(getCruiseControl _entity) params ['_entityCC','_cruiseControlActive'];
			_distBuffer = round (((0 boundingBoxReal _entity) # 2) + ((0 boundingBoxReal _cursorTarget) # 2));
			private _distance = 0;
			_speedTolerance = 2;
			private _checkInterval = 1;
			_checkIntervalDefault = _checkInterval;
			_checkIntervalClose = 0.25;
			_checkIntervalCloseDistance = 15;
			_minimumConvoySeparation = 10;
			_maximumConvoySeparation = 100;
			_loseConvoyDistance = _maximumConvoySeparation * 2;
			_distanceTolerance = 3;
			_distanceStep = 5;
			_speedAdjustmentNear = 5;
			_speedAdjustmentFar = 15;
			_speedAdjustmentSplit = 30;
			_speedMin = 10;
			private _speedAdjustment = 5;
			_convoySeparation = _maximumConvoySeparation min (round((_entity distance _cursorTarget) / _distanceStep) * _distanceStep) max _minimumConvoySeparation;
			QS_cc_convoySeparation = _convoySeparation;
			QS_cc_convoyDistanceStep = _distanceStep;
			QS_cc_convoyMinSeparation = 10;
			QS_cc_convoyMaxSeparation = 100;
			_entity setConvoySeparation _convoySeparation;
			private _vehicleOwner = effectiveCommander _entity;
			private _group = group _vehicleOwner;
			private _groupedVehicle = objNull;
			{
				_groupedVehicle = vehicle _x;
				if (local _groupedVehicle) then {
					_groupedVehicle setConvoySeparation _convoySeparation;
				};
			} forEach (units _group);
			private _newSpeed = _speed;
			if (!local _cursorTarget) then {
				_displayName = QS_hashmap_configfile getOrDefaultCall [
					format ['cfgvehicles_%1_displayname',toLowerANSI (typeOf _entity)],
					{getText ((configOf _entity) >> 'displayName')},
					TRUE
				];
				_text = format [localize 'STR_QS_Text_338',profileName,(_entity getVariable ['QS_ST_customDN',_displayName]),_convoyMaxSpeed];
				[63,[5,[_text,'PLAIN DOWN',0.75]]] remoteExec ['QS_fnc_remoteExec',_cursorTarget,FALSE];
			} else {
				_cursorTarget limitSpeed (_convoyMaxSpeed * 0.9);
			};
			for '_z' from 0 to 1 step 0 do {
				(getCruiseControl _entity) params ['_entityCC','_cruiseControlActive'];
				if (isLightOn _cursorTarget) then {
					if (!isLightOn _entity) then {
						_entity setPilotLight TRUE;
					};
				} else {
					if (isLightOn _entity) then {
						_entity setPilotLight FALSE;
					};
				};
				_speed = (((velocityModelSpace _cursorTarget) # 1) * 3.6) max 0;
				_distance = (_entity distance _cursorTarget) - _distBuffer;
				if (
					(!alive _entity) ||
					{(!local _entity)} ||
					{(!alive _cursorTarget)} ||
					{(!canMove _cursorTarget)} ||
					{(cameraOn isNotEqualTo _entity)} ||
					{(!alive cameraOn)} ||
					{(_distance > _loseConvoyDistance)} ||
					{(!(_cruiseControlActive))} ||
					{(_speed > _maxSpeed)}
				) exitWith {
					_entity setCruiseControl [0,FALSE];
					QS_cc_convoyActive = FALSE;
					if (_speed > _maxSpeed) then {
						50 cutText [localize 'STR_QS_Text_339','PLAIN DOWN',0.5];
					} else {
						50 cutText [localize 'STR_QS_Text_340','PLAIN DOWN',0.5];
					};
				};
				if (
					(QS_cc_convoySeparation isNotEqualTo _convoySeparation) ||
					{((_cursorTarget getVariable ['QS_cc_convoySeparation',_convoySeparation]) isNotEqualTo _convoySeparation)}
				) then {
					_convoySeparation = _maximumConvoySeparation min (round(QS_cc_convoySeparation / _distanceStep) * _distanceStep) max _minimumConvoySeparation;
					if ((_cursorTarget getVariable ['QS_cc_convoySeparation',-1]) isNotEqualTo -1) then {
						_convoySeparation = _cursorTarget getVariable ['QS_cc_convoySeparation',-1];
						QS_cc_convoySeparation = _convoySeparation;
						50 cutText [format [localize 'STR_QS_Text_341',_convoySeparation],'PLAIN DOWN',0.5];
					};
					_vehicleOwner = effectiveCommander _entity;
					_group = group _vehicleOwner;
					_groupedVehicle = objNull;
					{
						_groupedVehicle = vehicle _x;
						if (local _groupedVehicle) then {
							_groupedVehicle setConvoySeparation _convoySeparation;
						};
					} forEach (units _group);
				};
				_checkInterval = if (_distance < _checkIntervalCloseDistance) then {_checkIntervalClose} else {_checkIntervalDefault};
				if (
					((_speed - _newSpeed) > _speedTolerance) ||
					{((_speed - _newSpeed) < (-_speedTolerance))} ||
					{(_distance > (_convoySeparation + _distanceTolerance))} ||
					{(_distance < (_convoySeparation - _distanceTolerance))}
				) then {
					_newSpeed = _speed;
					if (_distance > (_convoySeparation + _distanceTolerance)) then {
						_speedAdjustment = if ((_distance - _convoySeparation) > _speedAdjustmentSplit) then {_speedAdjustmentFar} else {_speedAdjustmentNear};
						_newSpeed = _speedMin max (_newSpeed + _speedAdjustment);
					};
					if (_distance < (_convoySeparation - _distanceTolerance)) then {
						_speedAdjustment = if ((_convoySeparation - _distance) > _speedAdjustmentSplit) then {_speedAdjustmentFar} else {_speedAdjustmentNear};
						_newSpeed = _newSpeed - _speedAdjustment;
					};
					if (_entityCC isNotEqualTo _newSpeed) then {
						_entity setCruiseControl [0 max _newSpeed min _maxSpeed,TRUE];
					};
				};
				uiSleep _checkInterval;
			};
		};
	};
	if (!(missionNamespace getVariable ['QS_cc_convoyActive',FALSE])) then {
		_entity setCruiseControl [(_speed min (_maxSpeed + 1)),TRUE];
		50 cutText [(format ['%2 %1 %3',round _speed,localize 'STR_QS_Text_241',localize 'STR_QS_Text_242']),'PLAIN DOWN',0.5];
	} else {
		50 cutText [localize 'STR_QS_Text_342','PLAIN DOWN',0.5];
	};
};