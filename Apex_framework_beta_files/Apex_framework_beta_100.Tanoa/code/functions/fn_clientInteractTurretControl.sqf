/*
File: fn_turretControl.sqf
Author:

	Quiksilver
	
Last modified:

	15/11/2017 A3 1.76 by Quiksilver
	
Description:

	Turret Control action-manager
_______________________________________________*/

private ['_v','_v2'];

_v = vehicle player;

/*/{player removeAction _x;} count QS_turretActions;/*/
QS_turretActions = [];

if (isNil {_v getVariable 'QS_turretSafety'}) then {
	_v setVariable ['QS_turretSafety',TRUE,TRUE];
	_v setVariable ['QS_turretL_locked',FALSE,TRUE];
	_v setVariable ['QS_turretR_locked',FALSE,TRUE];
};
private _actionIndex = -1;
if (_v getVariable 'QS_turretL_locked') then {
	_actionIndex = QS_turretActions pushBack (player addAction ['Unlock turret (Left)',(missionNamespace getVariable 'QS_fnc_turretActions'),[_v,1,0],80,FALSE,FALSE,'','[] call QS_fnc_conditionTurretActionUnlockL']);
	player setUserActionText [(QS_turretActions select _actionIndex),((player actionParams (QS_turretActions select _actionIndex)) select 0),(format ["<t size='3'>%1</t>",((player actionParams (QS_turretActions select _actionIndex)) select 0)])];
};
if (_v getVariable 'QS_turretR_locked') then {
	_actionIndex = QS_turretActions pushBack (player addAction ['Unlock turret (Right)',(missionNamespace getVariable 'QS_fnc_turretActions'),[_v,2,0],79,FALSE,FALSE,'','[] call QS_fnc_conditionTurretActionUnlockR']);
	player setUserActionText [(QS_turretActions select _actionIndex),((player actionParams (QS_turretActions select _actionIndex)) select 0),(format ["<t size='3'>%1</t>",((player actionParams (QS_turretActions select _actionIndex)) select 0)])];
};
if (!(_v getVariable 'QS_turretL_locked')) then {
	_actionIndex = QS_turretActions pushBack (player addAction ['Lock turret (Left)',(missionNamespace getVariable 'QS_fnc_turretActions'),[_v,1,1],78,FALSE,FALSE,'','[] call QS_fnc_conditionTurretActionLockL']);
	player setUserActionText [(QS_turretActions select _actionIndex),((player actionParams (QS_turretActions select _actionIndex)) select 0),(format ["<t size='3'>%1</t>",((player actionParams (QS_turretActions select _actionIndex)) select 0)])];
};
if (!(_v getVariable 'QS_turretR_locked')) then {
	_actionIndex = QS_turretActions pushBack (player addAction ['Lock turret (Right)',(missionNamespace getVariable 'QS_fnc_turretActions'),[_v,2,1],77,FALSE,FALSE,'','[] call QS_fnc_conditionTurretActionLockR']);
	player setUserActionText [(QS_turretActions select _actionIndex),((player actionParams (QS_turretActions select _actionIndex)) select 0),(format ["<t size='3'>%1</t>",((player actionParams (QS_turretActions select _actionIndex)) select 0)])];
};
_actionIndex = QS_turretActions pushBack (player addAction ['Cancel turret actions',(missionNamespace getVariable 'QS_fnc_turretActionCancel'),[],76]);
player setUserActionText [(QS_turretActions select _actionIndex),((player actionParams (QS_turretActions select _actionIndex)) select 0),(format ["<t size='3'>%1</t>",((player actionParams (QS_turretActions select _actionIndex)) select 0)])];
if (!(QS_inturretloop)) then {
	QS_inturretloop = TRUE;
	[_v] spawn {
		private ['_v','_v2'];
		_v = _this select 0;
		QS_turretControl = TRUE;
		while {QS_turretControl} do {
			_v2 = vehicle player;
			if ((!alive player) || {(!(player isEqualTo player))} || {(!(_v2 isEqualTo _v))}) then {
				QS_turretControl = FALSE;
				[_v,1,0] call (missionNamespace getVariable 'QS_fnc_turretReset');
				[_v,2,0] call (missionNamespace getVariable 'QS_fnc_turretReset');
			};
			sleep 0.5;
		};
		QS_inturretloop = FALSE;
	};
};