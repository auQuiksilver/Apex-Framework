/*/
File: fn_clientInteractSensorTarget.sqf
Author:

	Quiksilver
	
Last Modified:

	19/12/2017 A3 1.80 by Quiksilver
	
Description:

	Remote Sensors / Datalink
_____________________________________________________________/*/

_cursorObject = cursorObject;
if (isNull _cursorObject) exitWith {};
if (!alive _cursorObject) exitWith {
	50 cutText ['Target dead','PLAIN DOWN',0.25];
};
if ((!(_cursorObject isKindOf 'LandVehicle')) && (!(_cursorObject isKindOf 'Air')) && (!(_cursorObject isKindOf 'Ship')) && (!(_cursorObject isKindOf 'StaticWeapon'))) exitWith {
	50 cutText ['Invalid target','PLAIN DOWN',0.25];
};
if (({(alive _x)} count (crew _cursorObject)) isEqualTo 0) exitWith {
	50 cutText ['Target unoccupied','PLAIN DOWN',0.25];
};
if (_cursorObject isSensorTargetConfirmed playerSide) exitWith {
	50 cutText ['Target already confirmed','PLAIN DOWN',0.45];
};
if (_cursorObject in ([(listRemoteTargets playerSide),0] call (missionNamespace getVariable 'QS_fnc_listRemoteTargets'))) exitWith {
	50 cutText ['Target already reported','PLAIN DOWN',0.45];
};
if (uiNamespace getVariable ['QS_client_progressVisualization_active',FALSE]) exitWith {};
_onCancelled = {
	params ['_cursorObject'];
	private _c = FALSE;
	if (!alive player) then {
		_c = TRUE;
	};
	if (!((lifeState player) in ['HEALTHY','INJURED'])) then {
		_c = TRUE;
	};
	if (!(cursorObject isEqualTo _cursorObject)) then {
		_c = TRUE;
	};
	if (!alive _cursorObject) then {
		_c = TRUE;
	};
	if (_cursorObject in ([(listRemoteTargets playerSide),0] call (missionNamespace getVariable 'QS_fnc_listRemoteTargets'))) then {
		_c = TRUE;
	};
	_c;
};
_onCompleted = {
	params ['_cursorObject'];
	if (player getUnitTrait 'QS_trait_JTAC') then {
		if (!isNil {player getVariable 'QS_client_jtac_sensorTarget'}) then {
			if (!alive (player getVariable 'QS_client_jtac_sensorTarget')) then {
				(player getVariable 'QS_client_jtac_sensorTarget') confirmSensorTarget [playerSide,FALSE];
			};
		};
		if (!(_cursorObject in ([(listRemoteTargets playerSide),0] call (missionNamespace getVariable 'QS_fnc_listRemoteTargets')))) then {
			_cursorObject confirmSensorTarget [playerSide,TRUE];
			_cursorObject setVariable ['QS_remoteTarget_reported',TRUE,TRUE];
			playerSide reportRemoteTarget [_cursorObject,360];
			player setVariable ['QS_client_jtac_sensorTarget',_cursorObject,FALSE];
			50 cutText ['Target reported','PLAIN DOWN',0.3];
			playSound 'beep_target';
			['sideChat',[WEST,'BLU'],(format ['%1 (JTAC) marked a(n) %2 at grid %3 for CAS/Mortar/Artillery Support',profileName,(getText (configFile >> 'CfgVehicles' >> (typeOf _cursorObject) >> 'displayName')),(mapGridPosition _cursorObject)])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
			[77,'FIRE_SUPPORT',[_cursorObject,profileName],FALSE] remoteExec ['QS_fnc_remoteExec',2];
		} else {
			50 cutText ['Target already reported','PLAIN DOWN',0.3];
		};
	} else {
		if (!(_cursorObject in ([(listRemoteTargets playerSide),0] call (missionNamespace getVariable 'QS_fnc_listRemoteTargets')))) then {
			playerSide reportRemoteTarget [_cursorObject,180];
			_cursorObject setVariable ['QS_remoteTarget_reported',TRUE,TRUE];
			50 cutText ['Target reported','PLAIN DOWN',0.3];
			playSound 'beep_target';
			['sideChat',[WEST,'BLU'],(format ['%1 (%2) marked a(n) %3 at grid %4 for CAS/Mortar/Artillery Support',profileName,(groupID (group player)),(getText (configFile >> 'CfgVehicles' >> (typeOf _cursorObject) >> 'displayName')),(mapGridPosition _cursorObject)])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
			[77,'FIRE_SUPPORT',[_cursorObject,profileName],FALSE] remoteExec ['QS_fnc_remoteExec',2];
		} else {
			50 cutText ['Target already reported','PLAIN DOWN',0.3];
		};	
	};
};
playSound 'clickSoft';
[
	'Reporting target ...',
	([7.5,3.75] select (player getUnitTrait 'QS_trait_JTAC')),
	0,
	[[],{FALSE}],
	[[_cursorObject],_onCancelled],
	[[_cursorObject],_onCompleted],
	[[],{FALSE}]
] spawn (missionNamespace getVariable 'QS_fnc_clientProgressVisualization');