/*
File: fn_clientJump.sqf
Author:
	
	Quiksilver
	
Last Modified:

	9/10/2023 A3 2.14 by Quiksilver

Description:

	-
_____________________________________*/

private _r = FALSE;
_unit = cameraOn;
if (
	(_unit isKindOf 'CAManBase') &&
	{((lifeState _unit) in ['HEALTHY','INJURED'])} &&
	{(isNull (objectParent _unit))} &&
	{(((vectorMagnitude (velocity _unit)) * 3.6) > 4)} &&
	{(isTouchingGround _unit)} &&
	{((stance _unit) isEqualTo 'STAND')} &&
	{(!((animationState _unit) in ['aovrpercmrunsraswrfldf']))} &&
	{((currentWeapon _unit) isNotEqualTo '')} &&
	{(diag_tickTime > (_unit getVariable ['QS_jumpCooldown',0]))} &&
	{(!(_cameraOn call QS_fnc_isBusyAttached))}
) then {
	_r = TRUE;
	_unit setVariable ['QS_jumpCooldown',(diag_tickTime + 0.5),FALSE];
	_height = (6 - ((load _unit) * 10)) min 4.5;
	_speed = 0.4;
	_vel = velocity _unit;
	_dir = getDir _unit;
	_unit setVelocity (_vel vectorAdd [((sin _dir) * _speed),((cos _dir) * _speed),(_vel # 2) + _height]);
	_unit switchMove ['AovrPercMrunSrasWrflDf'];
	_allPlayers = (allPlayers inAreaArray [_unit,100,100,0,FALSE]) - [_unit];
	if (_allPlayers isNotEqualTo []) then {
		if (uiNamespace isNil 'QS_client_jumpAnimPropagation') then {
			uiNamespace setVariable ['QS_client_jumpAnimPropagation',[]];
		};
		uiNamespace setVariable ['QS_client_jumpAnimPropagation',((uiNamespace getVariable 'QS_client_jumpAnimPropagation') select {(_x > (diag_tickTime - 30))})];
		if ((count (uiNamespace getVariable 'QS_client_jumpAnimPropagation')) < 3) then {
			(uiNamespace getVariable 'QS_client_jumpAnimPropagation') pushBack diag_tickTime;
			['switchMove',_unit,['AovrPercMrunSrasWrflDf']] remoteExec ['QS_fnc_remoteExecCmd',_allPlayers,FALSE];
		};
	};
};
_r;