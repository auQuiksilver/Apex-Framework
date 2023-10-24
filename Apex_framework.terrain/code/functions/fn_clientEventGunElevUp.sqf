/*/
File: fn_clientEventGunElevUp.sqf
Author:
	
	Quiksilver
	
Last Modified:

	24/10/2023 A3 2.14 by Quiksilver
	
Description:

	-
______________________________________________________/*/

_vehicle = cameraOn;
if (
	(local _vehicle) &&
	{(
		(_vehicle isKindOf 'LandVehicle') || 
		{(_vehicle isKindOf 'Ship')}
	)} &&
	{
		((_vehicle unitTurret player) isEqualTo [-1]) ||
		(player isEqualTo (currentPilot _vehicle))
	} &&
	{(isNull curatorCamera)} &&
	{(isNull (ropeAttachedTo _vehicle))} &&
	{(isNull (isVehicleCargo _vehicle))} &&
	{(isNull (attachedTo _vehicle))} &&
	{((ropeAttachedObjects _vehicle) isEqualTo [])}
) then {
	if (isNil 'QS_cc_convoySeparation') then {
		QS_cc_convoySeparation = 50;
		QS_cc_convoyDistanceStep = 5;
		QS_cc_convoyMinSeparation = 10;
		QS_cc_convoyMaxSeparation = 100;
	};
	QS_cc_convoySeparation = QS_cc_convoyMaxSeparation min (QS_cc_convoySeparation - QS_cc_convoyDistanceStep) max QS_cc_convoyMinSeparation;
	if (QS_cc_convoySeparation > QS_cc_convoyMaxSeparation) then {
		if ((_vehicle getVariable ['QS_cc_convoySeparation',-1]) isNotEqualTo -1) then {
			_vehicle setVariable ['QS_cc_convoySeparation',-1,TRUE];
		};
		QS_cc_convoySeparation = QS_cc_convoyMaxSeparation;
		50 cutText [format ['%1 - %2',localize 'STR_QS_Text_325',localize 'STR_QS_Text_326'],'PLAIN DOWN',0.5];
	} else {
		_vehicle setVariable ['QS_cc_convoySeparation',QS_cc_convoySeparation,TRUE];
		50 cutText [format ['%1 - %2 m',localize 'STR_QS_Text_325',QS_cc_convoySeparation],'PLAIN DOWN',0.5];
	};
	_vehicle setVariable ['QS_cc_convoySeparation',QS_cc_convoySeparation,TRUE];
	_vehicleOwner = effectiveCommander _vehicle;
	_group = group _vehicleOwner;
	private _groupedVehicle = objNull;
	{
		_groupedVehicle = vehicle _x;
		if (local _groupedVehicle) then {
			_groupedVehicle setConvoySeparation _convoySeparation;
		};
	} forEach (units _group);
};
if (
	(local _vehicle) &&
	{(_vehicle isKindOf 'Air')} &&
	{(player in _vehicle)} &&
	{(!isRemoteControlling player)}
) then {
	_max = 5000;
	_min = 10;
	_steps = [5,100];
	_step = _steps select (uiNamespace getVariable ['QS_uiaction_vehicleturbo',FALSE]);
	_altitude = (getPosASL _vehicle) # 2;
	_flyInHeight = _vehicle getVariable ['QS_air_flyInHeight',((getPos _vehicle) # 2)];
	_newHeight = round (_min max ((round (_flyInHeight / _step) * _step) + _step) min _max);
	_vehicle flyInHeightASL [_newHeight,_newHeight,_newHeight];
	_vehicle flyInHeight [(_newHeight - 1),TRUE];
	_vehicle setVariable ['QS_air_flyInHeight',_newHeight];
	50 cutText [format [localize 'STR_QS_Text_318',_newHeight],'PLAIN DOWN',0.5];
};
if (player getUnitTrait 'uavhacker') then {
	_isUav = unitIsUav _vehicle;
	if (!(unitIsUav _vehicle)) then {
		_vehicle = getConnectedUAV player;
	};
	if (
		(alive _vehicle) &&
		{(local _vehicle)} &&
		{(unitIsUav _vehicle)} &&
		{(_vehicle isKindOf 'Air')}
	) then {
		_isBackpackDrone = ((_vehicle isKindOf 'UAV_06_base_F') || (_vehicle isKindOf 'UAV_01_base_F'));
		_max = 5000;
		_min = 1;
		_steps = [
			[5,50],
			[1,10]
		] select ((_vehicle isKindOf 'UAV_06_base_F') || (_vehicle isKindOf 'UAV_01_base_F'));
		_step = _steps select (uiNamespace getVariable ['QS_uiaction_vehicleturbo',FALSE]);
		_altitude = (getPosASL _vehicle) # 2;
		_flyInHeight = _vehicle getVariable ['QS_air_flyInHeight',0];
		_newHeight = round (_min max ((round (_flyInHeight / _step) * _step) + _step) min _max);
		_vehicle flyInHeightASL [_newHeight,_newHeight,_newHeight];
		_vehicle flyInHeight [(_newHeight - 1),TRUE];
		_vehicle setVariable ['QS_air_flyInHeight',_newHeight];
		if (
			_isBackpackDrone &&
			(!isEngineOn _vehicle) &&
			((_flyInHeight isEqualTo 0) && (_newHeight > 0))
		) then {
			deleteVehicleCrew _vehicle;
			_grp = createVehicleCrew _vehicle;
			_grp deleteGroupWhenEmpty TRUE;
			{
				_x setName ['AI','AI','AI'];
			} forEach (units _grp);
			(units _grp) joinSilent (group player);
			_vehicle land 'NONE';
			_vehicle engineOn TRUE;
			(crew _vehicle) doFollow cameraOn;
		} else {
			if (_vehicle getVariable ['QS_vehicle_isLanding',FALSE]) then {
				_vehicle land 'NONE';
				_vehicle setVariable ['QS_vehicle_isLanding',FALSE];
			};
		};
		50 cutText [format [localize 'STR_QS_Text_318',_newHeight],'PLAIN DOWN',0.5];
	};
};