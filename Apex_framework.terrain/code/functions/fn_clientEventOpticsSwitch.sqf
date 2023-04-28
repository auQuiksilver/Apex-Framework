/*/
File: fn_clientEventOpticsSwitch.sqf
Author: 

	Quiksilver
	
Last modified:

	16/02/2022 A3 2.12 by Quiksilver
	
Description:

	Optics Switch
______________________________________________/*/

params ['_unit','_isADS'];
if (missionNamespace getVariable ['QS_debug_monitorOptics',FALSE]) then {
	_unit setVariable ['QS_optics_info',[_isADS],TRUE];
};
//_unit setVariable ['QS_unit_isADS',_isADS,TRUE];		// maybe in the future