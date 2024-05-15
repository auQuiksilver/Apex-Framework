/*
File: fn_clientEventGetOutMan.sqf
Author:

	Quiksilver
	
Last modified:

	18/03/2023 A3 2.12 by Quiksilver
	
Description:

	unit: Object - unit the event handler is assigned to
	position: String - Can be either "driver", "gunner", "commander" or "cargo"
	vehicle: Object - Vehicle that the unit left
	turret: Array - turret path
__________________________________________________*/

params ['_unit','_position','_vehicle','_turret','_isEject'];
private _isLocal = local _vehicle;
player enableAIFeature ['CHECKVISIBLE',TRUE];
uiNamespace setVariable ['QS_robocop_timeout',diag_tickTime + 3];
localNamespace setVariable ['QS_service_cancelled',TRUE];
if (_isLocal) then {
	if (_vehicle isKindOf 'LandVehicle') then {
		[_vehicle,TRUE,TRUE] call QS_fnc_updateCenterOfMass;
	};
};
[0,_vehicle] call (missionNamespace getVariable 'QS_fnc_clientVehicleEventHandlers');
if ((missionNamespace getVariable ['QS_missionConfig_artyEngine',1]) isEqualTo 1) then {
	if (_vehicle isEqualTo (missionNamespace getVariable ['QS_arty',objNull])) then {
		enableEngineArtillery FALSE;
	};
};
if !(player isNil 'QS_pilot_vehicleInfo') then {
	player setVariable ['QS_pilot_vehicleInfo',nil,TRUE];
};
if ((toLowerANSI (typeOf _vehicle)) in ['b_t_apc_tracked_01_crv_f','b_apc_tracked_01_crv_f']) then {
	if (QS_action_plow in (actionIDs player)) then {
		player removeAction QS_action_plow;
	};
};
if (_isLocal) then {
	if (_position isEqualTo 'driver') then {
		_vehicle engineOn FALSE;
	};
	if (
		(!isNull (getTowParent _vehicle)) &&
		{(isNull (ropeAttachedTo _vehicle))}
	) then {
		_vehicle setTowParent objNull;
	};
};
if (
	(!isTouchingGround _vehicle) &&
	{(((getPos _unit) # 2) >= ((getUnitFreefallInfo _unit) # 2))}
) then {
	[5,_unit] spawn {
		uiSleep (_this # 0);
		if (!isTouchingGround (_this # 1)) then {
			QS_EH_IronMan = addMissionEventHandler ['EachFrame',{call (missionNamespace getVariable 'QS_fnc_wingsuit')}];
		};
	};
};
if (
	(_vehicle isKindOf 'StaticMortar') &&
	{(_vehicle getVariable ['QS_mortar_lite',FALSE])} &&
	{(_vehicle getVariable ['QS_entity_destroyOnExit',FALSE])}
) then {
	_vehicle spawn {
		sleep 1;
		_this setDamage [1,FALSE];
	};
};
if (
	_isLocal &&
	((ropeAttachedObjects _vehicle) isNotEqualTo []) &&
	(!(['MODE6',_vehicle] call QS_fnc_simplePull))
) then {
	['MODE2',_vehicle] call QS_fnc_simplePull;
};
if (_vehicle isKindOf 'ParachuteBase') then {
	_vehicle spawn {
		sleep 2;
		deleteVehicle _this;
	};
};
if (
	_isLocal &&
	{(_vehicle isKindOf 'LandVehicle')} &&
	{((getCustomSoundController [_vehicle,'CustomSoundController1']) isEqualTo 1)}
) then {
	setCustomSoundController [_vehicle,'CustomSoundController1',0];
};