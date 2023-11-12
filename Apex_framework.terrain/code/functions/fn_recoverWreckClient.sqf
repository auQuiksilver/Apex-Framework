/*
File: fn_recoverWreckClient.sqf
Author:
	
	Quiksilver
	
Last Modified:

	31/03/2023 2.12 by Quiksilver

Description:

	Wreck Recovery
____________________________________________*/

params ['_vehicle','','','_onFoot'];
localNamespace setVariable ['QS_service_blocked',TRUE];
localNamespace setVariable ['QS_service_cancelled',FALSE];
if ((_vehicle getVariable ['QS_service_eventHit',-1]) isEqualTo -1) then {
	_vehicle setVariable ['QS_service_eventHit',(_vehicle addEventHandler ['Hit',{
		localNamespace setVariable ['QS_service_cancelled',TRUE];
		(_this # 0) removeEventHandler [_thisEvent,_thisEventHandler];
	}]),FALSE];
};
_cancel2 = {
	params ['_vehicle',['_onFoot',FALSE]];
	(
		(!alive _vehicle) ||
		{(
			(isEngineOn _vehicle) && 
			{(!unitIsUav _vehicle)} &&
			{((['LandVehicle','Air','Ship'] findIf { _vehicle isKindOf _x }) isNotEqualTo -1)}
		)} ||
		{(((vectorMagnitude (velocity _vehicle)) * 3.6) >= 1)} ||
		{((!(_vehicle isKindOf 'Ship')) && (!(isTouchingGround _vehicle)))} ||
		{((!(_vehicle isKindOf 'Ship')) && (((getPosASL _vehicle) # 2) <= -1))} ||
		{(!isNull curatorCamera)} ||
		{(localNamespace getVariable ['QS_service_cancelled',FALSE])}
	)
};
QS_player playActionNow 'PutDown';
private _delay = 10;
private _delayMessage = 0.5;
private _startTime = diag_tickTime;
private _timeout = diag_tickTime + _delay;
private _currentTime = diag_tickTime + 3;
private _linearConversion = linearConversion [_startTime, _timeout, _currentTime, 0, 100, TRUE];
private _msgDelay = diag_tickTime + _delayMessage;
private _msgText = localize 'STR_QS_Text_424';
for '_z' from 0 to 999 step 1 do {
	if ([_vehicle,_onFoot] call _cancel2) then {};
	_linearConversion = linearConversion [_startTime, _timeout, diag_tickTime, 0, 100, TRUE];
	if (diag_tickTime > _msgDelay) then {
		50 cutText [format ['%1 ( %2%3 )',_msgText,ceil _linearConversion,'%'],'PLAIN DOWN',0.25];
		_msgDelay = diag_tickTime + _delayMessage;
	};	
	if (diag_tickTime > _timeout) exitWith {
		50 cutText ['','PLAIN DOWN',0.333];
		51 cutText [format ['100%1','%'],'PLAIN DOWN',0.333];
	};
	uiSleep 0.1;
};
localNamespace setVariable ['QS_service_blocked',FALSE];
_vehicle removeEventHandler ['Hit',(_vehicle getVariable ['QS_service_eventHit',-1])];
_vehicle setVariable ['QS_service_eventHit',-1];
if ([_vehicle,_onFoot] call _cancel2) then {50 cutText [localize 'STR_QS_Text_425','PLAIN DOWN',0.25];};
[112,[_vehicle,profileName,getPlayerUID player]] remoteExec ['QS_fnc_remoteExec',2,FALSE];