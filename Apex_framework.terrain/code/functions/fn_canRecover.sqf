/*/
File: fn_canRecover.sqf
Author:
	
	Quiksilver
	
Last Modified:

	7/04/2023 A3 2.12 by Quiksilver
	
Description:

	Can vehicle wreck be recovered
______________________________________________________/*/

params ['_entity',['_force',FALSE]];
if (isNull _entity) exitWith {FALSE};
_nearServices = [_entity,30] call QS_fnc_isNearServiceCargo;
_serviceInfo = _nearServices select { (_x # 1) isEqualTo 'recover' };
_recoverTypes = _nearServices select {
	(
		(
			(!((_x # 0) isKindOf 'B_APC_Tracked_01_CRV_F')) && 
			(!((_x # 0) getVariable ['QS_logistics_recoverEnabled',FALSE]))
		) ||
		((_x # 0) getVariable ['QS_logistics_recoverEnabled',FALSE])
	)
};

_serviceArray = ['reammo','refuel','repair'];
_checkServiceArray = _recoverTypes apply { _x # 1 }; _checkServiceArray sort TRUE;
(
	(_entity getVariable ['QS_logistics_wreck',FALSE]) &&
	{(isNull (attachedTo _entity))} &&
	{(isNull (ropeAttachedto _entity))} &&
	{(isNull (isVehicleCargo _entity))} &&
	{((ropes _entity) isEqualTo [])} &&
	{(
		(([_entity,'WRECK_RECOVER'] call QS_fnc_inZone) # 0) ||
		{(_entity getVariable ['QS_logistics_wreck_forceRecover',FALSE])} ||
		{(_serviceInfo isNotEqualTo [])} ||
		{(_checkServiceArray isEqualTo _serviceArray)} ||
		{_force}
	)} &&
	{(scriptDone (localNamespace getVariable ['QS_recoverWreckClient_script',scriptNull]))}
)