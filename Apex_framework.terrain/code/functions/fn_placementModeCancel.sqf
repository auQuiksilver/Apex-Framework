/*
File: fn_placementModeCancel.sqf
Author: 

	Quiksilver

Last Modified:

	23/03/2023 A3 2.12 by Quiksilver

Description:

	Placement Mode Cancel
_____________________________________________*/

params ['_vehicle','_requestedObject',['_oldParent',objNull],['_placementRadius',30]];
_isLocal = uiNamespace getVariable ['QS_localHelper',FALSE];
private _isIntersected = FALSE;
if ((_requestedObject isEqualType objNull) && _isLocal) then {
	
};
(
	(!((lifeState QS_player) in ['HEALTHY','INJURED'])) ||
	{(
		(_vehicle isEqualType objNull) && 
		{
			(!alive _vehicle) || 
			{((_placementRadius isNotEqualTo -1) && {((QS_player distance _vehicle) > _placementRadius)})}
		}
	)} ||
	{(!isNull _oldParent) && {((_placementRadius isNotEqualTo -1) && {((cameraOn distance _oldParent) > _placementRadius)})}} ||
	{((_requestedObject isEqualType objNull) && {(!alive _requestedObject) || {(isNull (attachedTo _requestedObject))}})} ||
	{(!isNull curatorcamera)} ||
	{((isNull (objectParent QS_player)) && ((currentWeapon QS_player) isNotEqualTo ''))} ||
	{(!(missionNamespace getVariable ['QS_targetBoundingBox_placementMode',FALSE]))}
)