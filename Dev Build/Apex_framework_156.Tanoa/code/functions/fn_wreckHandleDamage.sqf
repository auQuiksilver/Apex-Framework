/*/
File: fn_wreckHandleDamage.sqf
Author:
	
	Quiksilver
	
Last Modified:

	30/03/2023 A3 2.12 by Quiksilver
	
Description:

	-
______________________________________________________/*/

if (
	(!(local (_this # 0))) ||
	{(!((_this # 0) getVariable ['QS_logistics_wreck',FALSE]))}
) exitWith {
	(_this # 0) removeEventHandler [_thisEvent,_thisEventHandler];
	(_this # 0) setVariable ['QS_wreck_damageHandler1',-1,FALSE];
};
if (isDamageAllowed (_this # 0)) then {
	(_this # 0) allowDamage FALSE;
};
([(_this # 0) getHit (_this # 1),damage (_this # 0)] select ((_this # 1) isEqualTo ''))