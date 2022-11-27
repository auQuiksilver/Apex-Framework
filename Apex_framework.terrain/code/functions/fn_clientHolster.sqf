/*/
File: fn_clientHolster.sqf
Author:
	
	Quiksilver
	
Last Modified:

	24/11/2022 A3 2.10 by Quiksilver

Description:

	Client Holster Weapon
____________________________________/*/

_cameraOn = cameraOn;
if (
	(_cameraOn isKindOf 'CAManBase') &&
	{(isNull (objectParent _cameraOn))} &&
	{((lifeState _cameraOn) in ['HEALTHY','INJURED'])} &&
	{(diag_tickTime > (_cameraOn getVariable ['QS_RD_holstering',-1]))} &&
	{(((attachedObjects _cameraOn) isEqualTo []) || {(((attachedObjects _cameraOn) findIf {((!isNull _x) && (!(_x isKindOf 'Sign_Sphere10cm_F')))}) isEqualTo -1)})}
) then {
	if ((currentWeapon _cameraOn) isNotEqualTo '') then {
		_cameraOn setVariable ['QS_RD_holsteredWeapon',(currentWeapon _cameraOn),FALSE];
		_cameraOn action ['SwitchWeapon',_cameraOn,_cameraOn,100];
	} else {
		if ((_cameraOn getVariable ['QS_RD_holsteredWeapon','']) isNotEqualTo '') then {
			_cameraOn selectWeapon (_cameraOn getVariable ['QS_RD_holsteredWeapon',(primaryWeapon _cameraOn)]);
		};
	};
};