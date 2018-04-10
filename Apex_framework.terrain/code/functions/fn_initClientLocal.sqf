/*/ 
File: fn_initClientLocal.sqf 
Author:

	Quiksilver
	
Last Modified:

	8/12/2017 A3 1.80 by Quiksilver
	
Description:

	Client Initialization 
______________________________________________________/*/
if (isDedicated || !isMultiplayer || is3DEN) exitWith {};
0 spawn {
	setViewDistance 200; 	
	setObjectViewDistance 0; 	
	_hasInterface = hasInterface; 	
	if (_hasInterface) then {
		player setVehiclePosition [(getPosWorld player),[],0,'NONE'];
		waitUntil {
			(!(isNull(findDisplay 46)))
		};
	};
	if (isNil {missionNamespace getVariable 'QS_fnc_remoteExec'}) then {
		waitUntil {
			uiSleep 0.1;
			(!isNil {missionNamespace getVariable 'QS_fnc_remoteExec'})
		};
	};
	if (isMultiplayer) then {
		if (_hasInterface) then {
			/*/ extra security feature
			if (!(userInputDisabled)) then {
				disableUserInput TRUE;
			};
			/*/
			50 cutText ['Initializing ...','BLACK OUT',0.1,TRUE];
		};
	};
	private _count = 1;
	_limit = 4;
	_didJIP = didJIP;
	_clientowner = clientOwner;
	_puid = getPlayerUID player;
	for '_x' from 0 to 1 step 0 do {
		[0,player,_didJIP,_clientowner,_puid,profileName] remoteExec ['QS_fnc_remoteExec',2,FALSE];
		uiSleep 10;
		if (!isNil {player getVariable 'QS_5551212'}) exitWith {};
		_count = _count + 1;
		if (_count > _limit) exitWith {
			if (_hasInterface) then {
				if (userInputDisabled) then {
					disableUserInput FALSE;
				};
			};
			endMission 'QS_RD_end_2';
		};
		if (_hasInterface) then {
			if (!((getOxygenRemaining player) isEqualTo 1)) then {
				player setOxygenRemaining 1;
			};
		};
	};
};