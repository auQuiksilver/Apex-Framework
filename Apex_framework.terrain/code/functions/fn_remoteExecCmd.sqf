/*/
File: fn_remoteExecCmd.sqf
Author:

	Quiksilver
	
Last modified:

	24/06/2017 ArmA 1.72 by Quiksilver
	
Description:

	-
remoteExec and remoteExecCall are currently filtered by BattlEye's remoteexec.txt, the string analyzed by BE is formatted the same way as the following example's output:
format ["%1 %2", functionName, str params]
If CfgRemoteExec class Functions is in mode 1 (whitelist), the following BE filter exclusion can be used to safely allow all whitelisted *_fnc_* functions taking an array as parameter to go through:
!="\w+?_fnc_\w+? \[.*\]"
Any attempt to exploit this exclusion using other RE methods like createUnit will run into "Error Missing ;" without any malicious code being executed.

Mod makers should refrain from remote-executing raw commands from clients, and instead use functions, as commands need to be excluded individually for BE, while all functions are covered by the above exclusion.
_______________________________________________________/*/

params ['_type','_1','_2'];
_isRx = isRemoteExecuted;
_isRxJ = isRemoteExecutedJIP;
_rxID = remoteExecutedOwner;
if (_type isEqualTo 'switchMove') exitWith {
	_1 switchMove _2;
};
if (_type isEqualTo 'sideChat') exitWith {
	_1 sideChat _2;
};
if (_type isEqualTo 'commandChat') exitWith {
	_1 commandChat _2;
};
if (_type isEqualTo 'customChat') exitWith {
	_1 customChat _2;
};
if (_type isEqualTo 'globalChat') exitWith {
	_1 globalChat _2;
};
if (_type isEqualTo 'groupChat') exitWith {
	_1 groupChat _2;
};		
if (_type isEqualTo 'hint') exitWith {
	if (!isStreamFriendlyUIEnabled) then {
		(missionNamespace getVariable 'QS_managed_hints') pushBack [5,TRUE,7.5,-1,_1,[],-1];
	};
};
if (_type isEqualTo 'hintSilent') exitWith {
	if (!isStreamFriendlyUIEnabled) then {
		(missionNamespace getVariable 'QS_managed_hints') pushBack [5,FALSE,7.5,-1,_1,[],-1];
	};
};
if (_type isEqualTo 'lock') exitWith {
	_1 lock _2;
};
if (_type isEqualTo 'lockTurret') exitWith {
	_1 lockTurret _2;
};
if (_type isEqualTo 'setAmmoCargo') exitWith {
	_1 setAmmoCargo _2;
};
if (_type isEqualTo 'setDir') exitWith {
	_1 setDir _2;
};
if (_type isEqualTo 'setFuel') exitWith {
	_1 setFuel _2;
};
if (_type isEqualTo 'setGroupOwner') exitWith {
	if (isDedicated) then {
		_1 setGroupOwner _2;
	};
};
if (_type isEqualTo 'setOwner') exitWith {
	if (isDedicated) then {
		_1 setOwner _2;
	};
};
if (_type isEqualTo 'setSpeaker') exitWith {
	_1 setSpeaker _2;
};
if (_type isEqualTo 'setVehicleAmmo') exitWith {
	_1 setVehicleAmmo _2;
};
if (_type isEqualTo 'systemChat') exitWith {
	systemChat _1;
};
if (_type isEqualTo 'vehicleChat') exitWith {
	_1 vehicleChat _2;
};
if (_type isEqualTo 'setFeatureType') exitWith {
	_1 setFeatureType _2;
};
if (_type isEqualTo 'engineOn') exitWith {
	_1 engineOn _2;
};
if (_type isEqualTo 'playSound') exitWith {
	playSound _1;
};
if (_type isEqualTo 'playMusic') exitWith {
	playMusic _1;
};
if (_type isEqualTo 'removeWeapon') exitWith {
	_1 removeWeapon _2;
};
if (_type isEqualTo 'setMass') exitWith {
	_1 setMass _2;
};
if (_type isEqualTo 'disableAI') exitWith {
	_1 disableAI _2;
};
if (_type isEqualto 'enableAI') exitWith {
	_1 enableAI _2;
};
if (_type isEqualTo 'setVelocity') exitWith {
	_1 setVelocity _2;
};
if (_type isEqualTo 'setVelocityModelSpace') exitWith {
	_1 setVelocityModelSpace _2;
};
if (_type isEqualTo 'playMoveNow') exitWith {
	_1 playMoveNow _2;
};
if (_type isEqualTo 'enableVehicleCargo') exitWith {
	_1 enableVehicleCargo _2;
};
if (_type isEqualTo 'addWaypoint') exitWith {
	_1 addWaypoint _2;
};
if (_type isEqualTo 'deleteWaypoint') exitWith {
	deleteWaypoint _1;
};
if (_type isEqualTo 'setWaypointType') exitWith {
	_1 setWaypointType _2;
};
if (_type isEqualTo 'setFormDir') exitWith {
	_1 setFormDir _2;
};