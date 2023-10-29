/*
File: fn_getWreckType.sqf
Author:
	
	Quiksilver
	
Last Modified:

	8/04/2023 A3 2.12 by Quiksilver

Description:

	Get Wreck Type
	
	_wreckType = [_v,_t] call _fn_getWreckType;
______________________________*/

params [['_entity',objNull],['_vehicleType','']];
if (
	(!isNull _entity) &&
	{((_entity getVariable ['QS_logistics_wrecktype','']) isEqualType '')} &&
	{((_entity getVariable ['QS_logistics_wrecktype','']) isNotEqualTo '')}
) exitWith {
	(_entity getVariable ['QS_logistics_wrecktype',''])
};
private _return = QS_hashmap_wreckTypes getOrDefault [toLowerANSI _vehicleType,''];
if (_return isNotEqualTo '') exitWith {_return};
if (_entity isKindOf 'Air') exitWith {
	'land_cargo10_red_f'
};
if ((_entity isKindOf 'Tank') || {(_entity isKindOf 'Wheeled_APC_F')}) exitWith {
	'land_cargo10_brick_red_f'
};
if (_entity isKindOf 'Car') exitWith {
	'land_cargo10_orange_f'
};
(missionNamespace getVariable ['QS_logistics_wrecktype','land_cargo10_orange_f'])