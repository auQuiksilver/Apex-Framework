/*/
File: fn_wreckHandleLocal.sqf
Author:
	
	Quiksilver
	
Last Modified:

	30/03/2023 A3 2.12 by Quiksilver
	
Description:

	-
______________________________________________________/*/

params ['_entity','_isLocal'];

if (!(_entity getVariable ['QS_logistics_wreck',FALSE])) exitWith {
	if ((_entity getVariable ['QS_wreck_damageHandler1',-1]) isNotEqualTo -1) then {
		_entity removeEventHandler ['HandleDamage',(_entity getVariable ['QS_wreck_damageHandler1',-1])];
		_entity setVariable ['QS_wreck_damageHandler1',-1,FALSE];
	};
};
if (_isLocal) then {



} else {
	if ((_entity getVariable ['QS_wreck_damageHandler1',-1]) isNotEqualTo -1) then {
		_entity removeEventHandler ['HandleDamage',(_entity getVariable ['QS_wreck_damageHandler1',-1])];
		_entity setVariable ['QS_wreck_damageHandler1',-1,FALSE];
	};
};