/*/
File: fn_remoteExecCmd.sqf
Author:

	Quiksilver
	
Last modified:

	17/02/2023 A3 2.12 by Quiksilver

Description:

	Remote Execution Commands
_______________________________________________________/*/

params ['_type','_1','_2'];
if ((!isRemoteExecuted) || {isRemoteExecutedJIP}) exitWith {diag_log format ['Remote Exec Cmd Failed with: %1 - %2 to %3 (%4 %5)',_this,remoteExecutedOwner,clientOwner,isRemoteExecuted,isRemoteExecutedJIP];};
if (_type isEqualType []) exitWith {
	{
		_x call (missionNamespace getVariable 'QS_fnc_remoteExecCmd');
	} forEach _this;
};
if (_type isEqualTo 'switchMove') exitWith {
	if (_2 isEqualType []) then {
		_1 switchMove _2;
	} else {
		_1 switchMove [_2];
	};
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
if (_type isEqualTo 'setAmmoCargo') exitWith {
	_1 setAmmoCargo _2;
};
if (_type isEqualTo 'setRepairCargo') exitWith {
	_1 setRepairCargo _2;
};
if (_type isEqualTo 'setFuelCargo') exitWith {
	_1 setFuelCargo _2;
};
if (_type isEqualTo 'setDir') exitWith {
	if ((getDir _1) isNotEqualTo _2) then {
		_1 setDir _2;
	};
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
	_1 awake TRUE;
};
if (_type isEqualTo 'setCenterOfMass') exitWith {
	_1 setCenterOfMass _2;
	_1 awake TRUE;
};
if (_type isEqualTo 'disableAI') exitWith {
	_1 enableAIFeature [_2,FALSE];
};
if (_type isEqualto 'enableAI') exitWith {
	_1 enableAIFeature [_2,TRUE];
};
if (_type isEqualto 'enableAIFeature') exitWith {
	if (_1 isEqualType objNull) then {
		_1 enableAIFeature _2;
	};
	if (_1 isEqualType []) then {
		{
			_x enableAIFeature _2;
		} forEach _1;
	};
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
	if (_1 isEqualType []) then {
		{
			ropeUnwind _x;
		} forEach _1;
	} else {
		ropeUnwind _1;
	};
};
if (_type isEqualTo 'ropeDestroy') exitWith {
	if (_1 isEqualType []) then {
		{
			ropeDestroy _x;
		} forEach _1;
	} else {
		ropeDestroy _1;
	};
};
if (_type isEqualTo 'ropeDetach') exitWith {
	if (_2 isEqualType []) then {
		{
			_1 ropeDetach _x;
		} forEach _2;
	} else {
		_1 ropeDetach _2;
	};
};
if (_type isEqualTo 'reportRemoteTarget') exitWith {
	_1 reportRemoteTarget _2;
};
if (_type isEqualTo 'confirmSensorTarget') exitWith {
	_1 confirmSensorTarget _2;
};
if (_type isEqualTo 'doSuppressiveFire') exitWith {
	if (_1 isEqualType []) then {
		{
			_x doSuppressiveFire _2;
		} forEach _1;
	} else {
		_1 doSuppressiveFire _2;
	};
};
if (_type isEqualTo 'commandSuppressiveFire') exitWith {
	if (_1 isEqualType []) then {
		{
			_x commandSuppressiveFire _2;
		} forEach _1;
	} else {
		_1 commandSuppressiveFire _2;
	};
};
if (_type isEqualTo 'deleteVehicleCrew') exitWith {
	if (_1 isEqualTo _2) then {
		deleteVehicleCrew _1;
	} else {
		_1 deleteVehicleCrew _2;
	};
};
if (_type isEqualTo 'setMissileTarget') exitWith {
	if (_1 isEqualType []) then {
		{
			_x setMissileTarget _2;
		} forEach _1;
	} else {
		_1 setMissileTarget _2;
	};
};
if (_type isEqualTo 'setMissileTargetPos') exitWith {
	if (_1 isEqualType []) then {
		{
			_x setMissileTargetPos _2;
		} forEach _1;
	} else {
		_1 setMissileTargetPos _2;
	};
};
if (_type isEqualTo 'triggerAmmo') exitWith {
	triggerAmmo _1;
};
if (_type isEqualTo 'awake') exitWith {
	if (_1 isEqualType objNull) then {
		_1 awake _2;
	} else {
		if (_1 isEqualType []) then {
			{
				if (_x isEqualType objNull) then {
					_x awake _2;
				};
			} forEach _1;
		};
	};
};
if (_type isEqualTo 'action') exitWith {
	if (_rxID <= 2) then {
		_1 action _2;
	};
};
if (_type isEqualTo 'forceWeaponFire') exitWith {
	if (_rxID <= 2) then {
		_1 forceWeaponFire _2;
	};
};
if (_type isEqualTo 'disableBrakes') exitWith {
	_1 disableBrakes _2;
};
if (_type isEqualTo 'setTowParent') exitWith {
	if ((getTowParent _1) isNotEqualTo _2) then {
		_1 setTowParent _2;
	};
};
if (_type isEqualTo 'hideObjectGlobal') exitWith {
	if (isDedicated) then {
		diag_log format ['***** Remote Execution of hideObjectGlobal on %1 by %2 to target %3',(typeOf _1),remoteExecutedOwner,clientOwner];
	};
	_1 hideObjectGlobal _2;
};
if (_type isEqualTo 'setCustomSoundController') exitWith {
	setCustomSoundController _1;
};
if (_type isEqualTo 'setVehicleCargo') exitWith {
	_1 setVehicleCargo _2;
};
if (_type isEqualTo 'lock') exitWith {
	_1 lock _2;
};
if (_type isEqualTo 'lockTurret') exitWith {
	_1 lockTurret _2;
};
if (_type isEqualTo 'lockCargo') exitWith {
	if (_2 isEqualType TRUE) then {
		_1 lockCargo _2;
	} else {
		if (_2 isEqualType []) then {
			if ((_2 # 0) isEqualType []) then {
				{
					_1 lockCargo [_x,(_2 # 1)];
				} forEach (_2 # 0);
			} else {
				if ((_2 # 0) isEqualType 0) then {
					_1 lockCargo _2;
				};
			};
		};
	};
};
if (_type isEqualTo 'lockInventory') exitWith {
	_1 lockInventory _2;
};
if (_type isEqualTo 'lockDriver') exitWith {
	_1 lockDriver _2;
};
if (_type isEqualTo 'switchLight') exitWith {
	if (local _1) then {
		if (!simulationEnabled _1) then {
			if (isDedicated) then {
				_1 enableSimulationGlobal TRUE;
			} else {
				_1 enableSimulation TRUE;
			};
		};
	};
	_1 switchLight _2;
};
if (_type isEqualTo 'setPilotLight') exitWith {
	_1 setPilotLight _2;
};
if (_type isEqualTo 'forgetTarget') exitWith {
	_1 forgetTarget _2;
	if (_1 isEqualType grpNull) then {
		{
			_x forgetTarget _2;
		} forEach (units _1);
	} else {
		(group _1) forgetTarget _2;
	};
};
if (_type isEqualTo 'disableCollisionWith') exitWith {
	_1 disableCollisionWith _2;
};
if (_type isEqualTo 'enableCollisionWith') exitWith {
	_1 enableCollisionWith _2;
};
if (_type isEqualTo 'addVehicle') exitWith {
	if (
		(!isNull _1) &&
		{(!(_2 in (assignedVehicles _1)))} &&
		{((assignedGroup _2) isNotEqualTo _1)}
	) then {
		_1 addVehicle _2;
	};
};
if (_type isEqualTo 'leaveVehicle') exitWith {
	if (
		(!isNull _1) &&
		{(_2 in (assignedVehicles _1))}
	) then {
		_1 leaveVehicle _2;
	};
};
if (_type isEqualTo 'allowService') exitWith {
	_1 allowService _2;
};
if (_type isEqualTo 'setVectorDirAndUp') exitWith {
	_1 setVectorDirAndUp _2;
};
if (_type isEqualTo 'setPlateNumber') exitWith {
	if ((getPlateNumber _1) isNotEqualTo _2) then {
		_1 setPlateNumber _2;
	};
};
if (_type isEqualTo 'setFace') exitWith {
	_1 setFace _2;
};
if (_type isEqualTo 'setFlagAnimationPhase') exitWith {
	if ((flagAnimationPhase _1) isNotEqualTo _2) then {
		_1 setFlagAnimationPhase _2;
	};
};
if (_type isEqualTo 'setEffectiveCommander') exitWith {
	_1 setEffectiveCommander _2;
};
if (_type isEqualTo 'setUnitPos') exitWith {
	_1 setUnitPos _2;
};
if (_type isEqualTo 'addForce') exitWith {
	diag_log format ['***** DEBUG ***** addForce executed: %1 (%4) %2 by %3',_1,_2,remoteExecutedOwner,typeOf _1];
	_1 awake TRUE;
	_1 addForce _2;
};
if (_type isEqualTo 'addTorque') exitWith {
	diag_log format ['***** DEBUG ***** addTorque executed: %1 (%4) %2 by %3',_1,_2,remoteExecutedOwner,typeOf _1];
	_1 awake TRUE;
	_1 addTorque _2;
};