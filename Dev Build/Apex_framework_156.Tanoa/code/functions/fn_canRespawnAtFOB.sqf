/*/
File: fn_canRespawnAtFOB.sqf
Author:
	
	Quiksilver
	
Last Modified:

	15/04/2023 A3 2.12 by Quiksilver
	
Description:

	-
______________________________________________________/*/

params (localNamespace getVariable ['QS_deployment_dataParams',[]]);
_deploymentPosition = [_deploymentType,_deploymentLocationData] call QS_fnc_getDeploymentPosition;
_downedPosition = player getVariable ['QS_client_downedPosition',[-5000,-5000,0]];
_aoPos = missionNamespace getVariable ['QS_aoPos',[0,0,0]];
_sidePos = markerPos 'QS_marker_sideMarker';
_inContactWindow = diag_tickTime < (player getVariable ['QS_client_lastCombatDamageTime',-1]);
_basePosition = markerPos 'QS_marker_base_marker';
_baseDistance = _downedPosition distance _basePosition;
_deploymentDistance = _downedPosition distance _deploymentPosition;
_aoDistance = _downedPosition distance _aoPos;
_sideDistance = _downedPosition distance _sidePos;
(
	((_deploymentDistance < _baseDistance) || (_aoDistance < 2500) || (_sideDistance < 2500)) &&
	(_inContactWindow || (_deploymentDistance < 3000))
)