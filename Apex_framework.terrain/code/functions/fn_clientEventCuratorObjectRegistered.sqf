/*/
File: fn_clientEventCuratorObjectRegistered.sqf
Author:

	Quiksilver
	
Last modified:

	9/10/2023 A3 2.14 by Quiksilver
	
Description:

	Curator Object Registered
__________________________________________________/*/

params ['_module','_input'];
[_module,_input] spawn {
	scriptName 'QS EventCuratorObjectRegistered';
	waitUntil {(!isNull (findDisplay 312))};
	if (commandingMenu isNotEqualTo '') then {
		showCommandingMenu '';
	};
	(findDisplay 312) displayAddEventHandler ['KeyDown',{call (missionNamespace getVariable ['QS_fnc_clientEventCuratorKeyDown',{}]);}];
	_uid = getPlayerUID player;
	private _camPrepared = FALSE;
	_environmentEnabled = environmentEnabled;
	enableEnvironment FALSE;
	uiNamespace setVariable ['QS_RD_viewSettings_update',TRUE];
	for '_x' from 0 to 1 step 0 do {
		if (!isNull curatorCamera) then {
			if (!_camPrepared) then {
				_camPrepared = TRUE;
				{
					curatorCamera camCommand _x;
				} forEach [
					'maxPitch 89',
					'minPitch -89',
					'ceilingHeight 12000'
				];
			};
		} else {
			if (_camPrepared) then {
				_camPrepared = FALSE;
			};
		};
		if (isNull (findDisplay 312)) exitWith {
			enableEnvironment _environmentEnabled;
			uiNamespace setVariable ['QS_client_playerViewChanged',TRUE];
			uiNamespace setVariable ['QS_RD_viewSettings_update',TRUE];
			uiNamespace setVariable ['RscMissionStatus_display',(findDisplay 46)];
		};
		uiSleep 0.1;
	};
};