/*/
File: fn_remoteExecCmd.sqf
Author:

	Quiksilver
	
Last modified:

	9/06/2019 A3 1.94 by Quiksilver

Description:

	Remote Execution Commands

Notes:

	//_isRx = isRemoteExecuted;
	//_isRxJ = isRemoteExecutedJIP;
	//_rxID = remoteExecutedOwner;
_______________________________________________________/*/

if ((!isRemoteExecuted) || {isRemoteExecutedJIP}) exitWith {};
params ['_type','_1','_2'];
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
if (_type isEqualTo 'ropeUnwind') exitWith {
	ropeUnwind _1;
};
if (_type isEqualTo 'reportRemoteTarget') exitWith {
	_1 reportRemoteTarget _2;
};
if (_type isEqualTo 'confirmSensorTarget') exitWith {
	_1 confirmSensorTarget _2;
};
if (_type isEqualTo 'doSuppressiveFire') exitWith {
	_1 doSuppressiveFire (aimPos _2);
};
if (_type isEqualTo 'commandSuppressiveFire') exitWith {
	_1 commandSuppressiveFire (aimPos _2);
};
if (_type isEqualTo 'deleteVehicleCrew') exitWith {
	_1 deleteVehicleCrew _2;
};
if (_type isEqualTo 'setMissileTarget') exitWith {
	_1 setMissileTarget _2;
};
if (_type isEqualTo 'setMissileTargetPos') exitWith {
	_1 setMissileTargetPos _2;
};
if (_type isEqualTo 'triggerAmmo') exitWith {
	triggerAmmo _1;
};