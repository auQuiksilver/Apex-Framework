/*/
File: fn_clientInteractArsenal.sqf
Author:

	Quiksilver
	
Last Modified:

	5/12/2017 A3 1.78 by Quiksilver
	
Description:

	Arsenal Interaction
_____________________________________________________________/*/

if ((missionNamespace getVariable ['QS_missionConfig_Arsenal',0]) isEqualTo 0) then {
	['Open',TRUE] call (missionNamespace getVariable 'BIS_fnc_arsenal');
};
if ((missionNamespace getVariable ['QS_missionConfig_Arsenal',0]) isEqualTo 1) then {
	// Restricted Arsenal, not available
	//['Open',TRUE] call (missionNamespace getVariable 'BIS_fnc_arsenal');
};




if (isNil {player getVariable 'QS_arsenalAmmoPrompt'}) then {
	player setVariable ['QS_arsenalAmmoPrompt',TRUE,FALSE];
	50 cutText ['To add ammunition: open the container on the left (uniform,vest,backpack) and add ammunition on the right.','PLAIN DOWN',1];
};
TRUE;