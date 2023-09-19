/*/
File: fn_canWreck.sqf
Author:
	
	Quiksilver
	
Last Modified:

	25/03/2023 A3 2.12 by Quiksilver
	
Description:

	Can vehicle wreck in this case
	
Notes:

	Too close to base, in safezone, etc
______________________________________________________/*/

params ['_entity',['_applyChance',TRUE]];
if (isNull _entity) exitWith {FALSE};
(
	(missionNamespace getVariable ['QS_missionConfig_wrecks',TRUE]) &&
	{(!(_entity getVariable ['QS_logistics_wreck',FALSE]))} &&
	{((!_applyChance) || (_applyChance && {(_entity getVariable ['QS_wreck_chance',FALSE])}))} &&
	{(isTouchingGround _entity)} &&
	{(!surfaceIsWater (getPosWorld _entity))} &&
	{(((getPosATL _entity) # 2) > -1)} &&
	{(((getPosASL _entity) # 2) > -1)} &&
	{(!([_entity] call QS_fnc_inAnyZone))} &&
	{(!([_entity,30,8] call QS_fnc_waterInRadius))}
)