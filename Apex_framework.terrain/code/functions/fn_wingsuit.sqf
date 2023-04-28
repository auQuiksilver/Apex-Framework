/*/
File: fn_wingsuit.sqf
Author: 

	Quiksilver
	
Last modified:

	27/01/2023 A3 2.12 by Quiksilver
	
Description:

	-
__________________________________________/*/

_unit = player;
if (!(_unit getVariable ['QS_freefalling',FALSE])) then {
	_unit setVariable ['QS_freefalling',TRUE,FALSE];
	QS_freefall_speed = 100;
	QS_freefall_lift = 0.1;
	QS_EH_wingkeys = (findDisplay 46) displayAddEventHandler [
		'KeyDown',
		{
			params ['','_key','','',''];
			if (_key in (actionKeys 'moveforward')) exitWith {
				QS_freefall_lift = 0.1;
				QS_freefall_speed = 100;
			};
			if (_key in (actionkeys 'moveback')) exitWith {
				QS_freefall_lift = 0.2;
				QS_freefall_speed = 50;
			};
			if (_key in (actionKeys 'turnleft')) exitWith {
				QS_freefall_lift = -0.1;
				QS_freefall_speed = 75;
			};
			if (_key in (actionKeys 'turnright')) exitWith {
				QS_freefall_lift = -0.1;
				QS_freefall_speed = 75;
			};
		}
	];	
};
(getUnitFreefallInfo _unit) params ['_isFalling','_isInFreefallPose',''];
if (
	(!((lifeState _unit) in ['HEALTHY','INJURED'])) ||
	{(!isNull (objectParent _unit))} ||
	{(isTouchingGround _unit)} ||
	{(!_isFalling)} ||
	{(!_isInFreefallPose)}
) exitWith {
	_unit setVariable ['QS_freefalling',FALSE,FALSE];
	(findDisplay 46) displayRemoveEventHandler ['KeyDown',QS_EH_wingkeys];
	removeMissionEventHandler [_thisEvent,_thisEventHandler];
};
_vel = velocity _unit;
_dir2 = getDirVisual _unit;
_velX = [0,(sin _dir2 * 1)] select ((vectorMagnitude _vel) < QS_freefall_speed);
_velY = [0,(cos _dir2 * 1)] select ((vectorMagnitude _vel) < QS_freefall_speed);
_velZ = [0,QS_freefall_lift] select ((_vel # 2) < -25);
_unit setVelocity (_vel vectorAdd [_velX,_velY,_velZ]);