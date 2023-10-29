/*/
File: fn_getContainerType.sqf
Author:
	
	Quiksilver
	
Last Modified:

	28/10/2023 A3 2.12 by Quiksilver
	
Description:

	-
______________________________________________________/*/

params [['_entity',objNull]];
if (
	(!isNull _entity) &&
	{((_entity getVariable ['QS_logistics_containertype','']) isEqualType '')} &&
	{((_entity getVariable ['QS_logistics_containertype','']) isNotEqualTo '')}
) exitWith {
	(_entity getVariable ['QS_logistics_containertype',''])
};
if (_entity isKindOf 'Air') exitWith {
	'land_cargo10_orange_f'
};
if ((_entity isKindOf 'Tank') || {(_entity isKindOf 'Wheeled_APC_F')}) exitWith {
	'land_cargo10_orange_f'
};
if (_entity isKindOf 'Car') exitWith {
	'land_cargo10_orange_f'
};
(missionNamespace getVariable ['QS_logistics_containertype','land_cargo10_orange_f'])