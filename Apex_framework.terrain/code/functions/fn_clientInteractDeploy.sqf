/*
File: fn_clientInteractDeploy.sqf
Author:

	Quiksilver
	
Last Modified:

	22/03/2023 A3 2.12 by Quiksilver
	
Description:

	-
________________________________________________*/

params [['_mode','INTERACT']];
uiNamespace setVariable ['QS_deployment_entryType',_mode];
if (!(missionNamespace getVariable ['QS_missionConfig_deployment',TRUE])) exitWith {};
if (!(missionNamespace getVariable ['QS_deployments_available',TRUE])) exitWith {
	50 cutText [localize 'STR_QS_Text_406','PLAIN DOWN',0.5];
};
(findDisplay 12) createDisplay 'QS_RD_client_dialog_menu_deployment';