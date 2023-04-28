/*/
File: fn_clientInteractServiceVehicle.sqf
Author:

	Quiksilver

Last modified:

	28/03/2023 A3 2.12 by Quiksilver
	
Description:

	Service an asset
___________________________________________________/*/

params ['_target','_caller','_actionID',['_arguments',[]]];
_arguments params [['_cursorObject',cursorObject]];
50 cutText [localize 'STR_QS_Text_418','PLAIN DOWN',0.25];
if (!( (toLowerANSI (pose QS_player)) in ['swimming','surfaceswimming'])) then {
	QS_player playActionNow 'PutDown';
};
if (scriptDone (missionNamespace getVariable ['QS_module_services_script',scriptNull])) then {
	missionNamespace setVariable ['QS_module_services_script',([_cursorObject,([_cursorObject,sizeOf (typeOf _cursorObject)] call QS_fnc_isNearServiceCargo)] spawn QS_fnc_clientVehicleService),FALSE];
};