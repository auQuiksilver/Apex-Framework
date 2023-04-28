/*/
File: fn_conditionTurretToggle.sqf
Author:

	Quiksilver
	
Last Modified:

	8/04/2023 A3 2.12 by Quiksilver
	
Description:

	Condition Turret Toggle
____________________________________________/*/

getCursorObjectParams params ['_cursorObject','','_cursorDistance'];
private _turretAttached = FALSE;
private _attachedTurrets = [];
if (!isNull (objectParent QS_player)) then {
	_cursorObject = objectParent QS_player;
	_cursorDistance = 1;
	_turretAttached = [_cursorObject] call QS_fnc_isTurretInAttached;
	_attachedTurrets = [_cursorObject] call QS_fnc_turretsAttached
};
_text = QS_player actionParams _actionId;
if (
	(_attachedTurrets isNotEqualTo []) && 
	{(_cursorObject isEqualTo (objectParent QS_player))}
) then {
	_cursorObject = _attachedTurrets # 0;
};
_expectedText = [localize 'STR_QS_Interact_139',localize 'STR_QS_Interact_138'] select ((crew _cursorObject) isEqualTo []);
if (_text isNotEqualTo _expectedText) then {
	QS_player setUserActionText [_actionId,_expectedText,format ["<t size='3'>%1</t>",_expectedText]];
};
((!isNull _cursorObject) && ((unitIsUav _cursorObject) || _turretAttached) && (_cursorDistance < 5))