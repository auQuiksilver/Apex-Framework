/*/
File: fn_clientEventTurretElevDown.sqf
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
	{((_vehicle isKindOf 'LandVehicle') || (_vehicle isKindOf 'Ship'))} &&
	{
		((_vehicle unitTurret player) isEqualTo [-1]) ||
		(player isEqualTo (currentPilot _vehicle))
	} &&
	{(isNull curatorCamera)}
) then {
	(getCruiseControl _vehicle) params ['_speed','_cruiseControlActive'];
	if (_cruiseControlActive) then {
		_maxSpeed = QS_hashmap_configfile getOrDefaultCall [
			format ['cfgvehicles_%1_maxspeed',toLowerANSI (typeOf _vehicle)],
			{getNumber ((configOf _vehicle) >> 'maxSpeed')},
			TRUE
		];
		_stepDefault = 1;
		_stepTurbo = 5;
		_step = [_stepDefault,_stepTurbo] select (uiNamespace getVariable ['QS_uiaction_vehicleturbo',FALSE]);
		_speed = round (0 max ((round(_speed / _step) * _step) - _step) min _maxSpeed);
		if (missionNamespace getVariable ['QS_cc_convoyActive',FALSE]) then {
			50 cutText [localize 'STR_QS_Text_324','PLAIN DOWN',0.5];
		} else {
			_vehicle setCruiseControl [_speed,TRUE];
			50 cutText [(format ['%2 %1 %3',_speed,localize 'STR_QS_Text_241',localize 'STR_QS_Text_242']),'PLAIN DOWN',0.5];
		};
	};
};