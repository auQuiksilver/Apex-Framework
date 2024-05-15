/*
File: fn_turretControl.sqf
Author:

	Quiksilver
	
Last modified:

	31/08/2022 A3 2.10 by Quiksilver
	
Description:

	Turret Control action-manager
_______________________________________________*/

private _v = vehicle player;
QS_turretActions = [];
if (_v isNil 'QS_turretSafety') then {
	_v setVariable ['QS_turretSafety',TRUE,TRUE];
	_v setVariable ['QS_turretL_locked',FALSE,TRUE];
	_v setVariable ['QS_turretR_locked',FALSE,TRUE];
};
private _actionIndex = -1;
if (_v getVariable 'QS_turretL_locked') then {
	_actionIndex = QS_turretActions pushBack (player addAction [localize 'STR_QS_Interact_067',(missionNamespace getVariable 'QS_fnc_turretActions'),[_v,1,0],80,FALSE,FALSE,'','[] call QS_fnc_conditionTurretActionUnlockL']);
	player setUserActionText [(QS_turretActions # _actionIndex),((player actionParams (QS_turretActions # _actionIndex)) # 0),(format ["<t size='3'>%1</t>",((player actionParams (QS_turretActions # _actionIndex)) # 0)])];
};
if (_v getVariable 'QS_turretR_locked') then {
	_actionIndex = QS_turretActions pushBack (player addAction [localize 'STR_QS_Interact_068',(missionNamespace getVariable 'QS_fnc_turretActions'),[_v,2,0],79,FALSE,FALSE,'','[] call QS_fnc_conditionTurretActionUnlockR']);
	player setUserActionText [(QS_turretActions # _actionIndex),((player actionParams (QS_turretActions # _actionIndex)) # 0),(format ["<t size='3'>%1</t>",((player actionParams (QS_turretActions # _actionIndex)) # 0)])];
};
if (!(_v getVariable 'QS_turretL_locked')) then {
	_actionIndex = QS_turretActions pushBack (player addAction [localize 'STR_QS_Interact_069',(missionNamespace getVariable 'QS_fnc_turretActions'),[_v,1,1],78,FALSE,FALSE,'','[] call QS_fnc_conditionTurretActionLockL']);
	player setUserActionText [(QS_turretActions # _actionIndex),((player actionParams (QS_turretActions # _actionIndex)) # 0),(format ["<t size='3'>%1</t>",((player actionParams (QS_turretActions # _actionIndex)) # 0)])];
};
if (!(_v getVariable 'QS_turretR_locked')) then {
	_actionIndex = QS_turretActions pushBack (player addAction [localize 'STR_QS_Interact_070',(missionNamespace getVariable 'QS_fnc_turretActions'),[_v,2,1],77,FALSE,FALSE,'','[] call QS_fnc_conditionTurretActionLockR']);
	player setUserActionText [(QS_turretActions # _actionIndex),((player actionParams (QS_turretActions # _actionIndex)) # 0),(format ["<t size='3'>%1</t>",((player actionParams (QS_turretActions # _actionIndex)) # 0)])];
};
_actionIndex = QS_turretActions pushBack (player addAction [localize 'STR_QS_Interact_071',(missionNamespace getVariable 'QS_fnc_turretActionCancel'),[],76]);
player setUserActionText [(QS_turretActions # _actionIndex),((player actionParams (QS_turretActions # _actionIndex)) # 0),(format ["<t size='3'>%1</t>",((player actionParams (QS_turretActions # _actionIndex)) # 0)])];
if (!(QS_inturretloop)) then {
	QS_inturretloop = TRUE;
	[_v] spawn {
		params ['_v'];
		private _v2 = objNull;
		QS_turretControl = TRUE;
		while {QS_turretControl} do {
			_v2 = vehicle player;
			if ((!alive player) || {(_v2 isNotEqualTo _v)}) then {
				QS_turretControl = FALSE;
				[_v,1,0] call (missionNamespace getVariable 'QS_fnc_turretReset');
				[_v,2,0] call (missionNamespace getVariable 'QS_fnc_turretReset');
			};
			sleep 0.5;
		};
		QS_inturretloop = FALSE;
	};
};