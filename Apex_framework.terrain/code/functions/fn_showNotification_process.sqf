/*
File: fn_showNotification_process.sqf
Author:

	Quiksilver
	
Last modified:

	19/07/2016 A3 1.62 by Quiksilver
	
Description:

	QS_fnc_showNotification_process
__________________________________________________________________________*/

scriptName 'BIS_fnc_showNotification: queue';
private ['_queue','_layers','_layerID','_queueID','_queuePriority','_duration','_data','_dataID'];
_queue = missionNamespace getvariable ['BIS_fnc_showNotification_queue',[]];
_layers = [
	('RscNotification_1' call (missionNamespace getVariable 'BIS_fnc_rscLayer')),
	('RscNotification_2' call (missionNamespace getVariable 'BIS_fnc_rscLayer'))
];
_layerID = 0;
while {((count _queue) > 0)} do {
	_queueID = (count _queue) - 1;
	_queuePriority = _queue # _queueID;
	if (!isNil '_queuePriority') then {
		if (_queuePriority isNotEqualTo []) then {
			_dataID = count _queuePriority - 1;
			_data = +(_queuePriority # _dataID);
			if (((count _data) > 0) && ((alive player) || (isMultiplayer))) then {
				_duration = _data # 7;
				missionNamespace setVariable ['RscNotification_data',_data,FALSE];
				if (!isStreamFriendlyUIEnabled) then {
					(_layers # _layerID) cutRsc ['RscNotification','PLAIN'];
				};
				_layerID = (_layerID + 1) % 2;
				['BIS_fnc_showNotification_counter',-1] call (missionNamespace getVariable 'BIS_fnc_counter');
				uiSleep _duration;
				_queuePriority set [_dataID,[]];
			} else {
				_queuePriority resize _dataID;
			};
		};
		if (_queuePriority isEqualTo []) then {
			_queue resize _queueID;
		};
	} else {
		if (_queueID isEqualTo ((count _queue) - 1)) then {
			_queue resize _queueID;
		};
	};
	uiSleep 0.01;
};