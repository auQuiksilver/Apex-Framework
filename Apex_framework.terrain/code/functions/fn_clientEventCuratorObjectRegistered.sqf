/*/
File: fn_clientEventCuratorObjectRegistered.sqf
Author:

	Quiksilver
	
Last modified:

	20/03/2017 A3 1.82 by Quiksilver
	
Description:

	Curator Object Registered
__________________________________________________/*/

params ['_module','_input'];
[_module,_input] spawn {
	scriptName 'QS EventCuratorObjectRegistered';
	waitUntil {(!isNull (findDisplay 312))};
	if (!(commandingMenu isEqualTo '')) then {
		showCommandingMenu '';
	};
	(findDisplay 312) displayAddEventHandler ['KeyDown',{call (missionNamespace getVariable ['QS_fnc_clientEventCuratorKeyDown',{}]);}];
	_uid = getPlayerUID player;
	private _camPrepared = FALSE;
	for '_x' from 0 to 1 step 0 do {
		if (!isNull curatorCamera) then {
			if (!_camPrepared) then {
				_camPrepared = TRUE;
				{
					curatorCamera camCommand _x;
				} forEach [
				'maxPitch 89',
				'minPitch -89',
				'ceilingHeight 10000'			
				];
			};
		} else {
			if (_camPrepared) then {
				_camPrepared = FALSE;
			};
		};
		if (isNull (findDisplay 312)) exitWith {
			player setVariable ['QS_client_playerViewChanged',TRUE,FALSE];
			uiNamespace setVariable ['RscMissionStatus_display',(findDisplay 46)];
		};
		uiSleep 0.1;
	};
};