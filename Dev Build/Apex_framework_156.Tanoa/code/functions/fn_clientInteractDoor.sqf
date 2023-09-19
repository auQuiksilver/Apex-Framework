/*/
File: fn_clientInteractDoor.sqf
Author:

	Quiksilver
	
Last Modified:

	3/04/2017 A3 1.68
	
Description:

	Client Door Interaction
_____________________________________________________________/*/

private _info = _this call (missionNamespace getVariable 'QS_fnc_getDoor');
_info params ['_house','_door'];
if (isNull _house) exitWith {FALSE};
private _getDoorAnimations = [_house, _door] call (missionNamespace getVariable 'QS_fnc_getDoorAnimations');
_getDoorAnimations params ['_animations','_lockedVariable'];
if (_animations isEqualTo []) exitWith {FALSE};
playSound 'Click';
if ((toLowerANSI (_animations # 0)) in ['door_1a_rot','door_1b_rot']) then {
	if (((_house animationPhase (format ['%1',(_animations # 0)])) <= 0) && {((_house getVariable [_lockedVariable # 0, 0]) isEqualTo 1)}) exitWith {
		_lockedVariable set [0,_house];
		_lockedVariable call (missionNamespace getVariable 'BIS_fnc_LockedDoorOpen');
	};
	if ((_house animationPhase (_animations # 0)) < 0.5) then {
		{
			_house animate [(format ['%1',_x]),1,1]; 
		} forEach _animations;
	} else {
		{
			_house animate [(format ['%1',_x]),0,1]; 
		} forEach _animations;		
	};
} else {
	if (((_house animationSourcePhase (_animations # 0)) <= 0) && {((_house getVariable [_lockedVariable # 0, 0]) isEqualTo 1)}) exitWith {
		_lockedVariable set [0,_house];
		_lockedVariable call (missionNamespace getVariable 'BIS_fnc_LockedDoorOpen');
	};
	if ((_house animationSourcePhase (_animations # 0)) < 0.5) then {
		{
			_house animateSource [_x,1,1]; 
		} forEach _animations;
	} else {
		{
			_house animateSource [_x,0,1]; 
		} forEach _animations;		
	};
};
TRUE;