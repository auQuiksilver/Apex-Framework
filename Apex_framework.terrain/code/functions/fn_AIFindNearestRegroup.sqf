/*/
File: fn_AIFindNearestRegroup.sqf
Author:

	Quiksilver
	
Last Modified:

	9/12/2017 A3 1.80 by Quiksilver
	
Description:

	AI Find nearest suitable group to merge with
_____________________________________________________________________/*/

params ['_unit','_radius'];
_side = side _unit;
_grp = group _unit;
_groupConfig = _grp getVariable ['QS_AI_GRP_CONFIG',[]];
_groupTask = _grp getVariable ['QS_AI_GRP_TASK',[]];
if ((_groupConfig isEqualTo []) || {(_groupTask isEqualTo [])}) exitWith {FALSE};
private _suitableGroups = [];
private _testGroup = grpNull;
private _testGroupConfig = [];
private _groupFound = FALSE;
{
	if (
		(_x getVariable ['QS_AI_GRP',FALSE]) &&
		{(_grp isNotEqualTo _x)} &&
		{(((units _x) findIf {(alive _x)}) isNotEqualTo -1)} &&
		{(((leader _x) distance2D _unit) < _radius)}
	) then {
		_testGroup = _x;
		_testGroupConfig = _testGroup getVariable ['QS_AI_GRP_CONFIG',['','',-1,objNull]];
		_testGroupTask = _testGroup getVariable ['QS_AI_GRP_TASK',['',[0,0,0],-1]];
		if (
			((count _testGroupConfig) >= 3) &&
			((count _testGroupTask) >= 3)
		) then {
			if ((_testGroupConfig isNotEqualTo []) && (_testGroupTask isNotEqualTo [])) then {
				if (((_testGroupConfig # 0) isEqualTo (_groupConfig # 0)) && ((_testGroupConfig # 1) isEqualTo (_groupConfig # 1)) && ((_testGroupTask # 0) isEqualTo (_groupTask # 0))) then {
					_groupFound = TRUE;
				} else {
					if (((_testGroupConfig # 0) isEqualTo (_groupConfig # 0)) && ((_testGroupConfig # 1) isEqualTo (_groupConfig # 1))) then {
						_suitableGroups pushBack _testGroup;
					} else {
						if ((_testGroupConfig # 0) isEqualTo (_groupConfig # 0)) then {
							_suitableGroups pushBack _testGroup;
						};
					};
				};
			};
		};
	};
	if (_groupFound) exitWith {};
} forEach (groups _side);
if (_groupFound) exitWith {
	[_unit] joinSilent _testGroup;
	TRUE;
};
if (_suitableGroups isNotEqualTo []) exitWith {
	[_unit] joinSilent (selectRandom _suitableGroups);
	TRUE;
};
if (!(_grp isNil 'QS_AI_GRP_regroupPos')) exitWith {
	_grp setVariable ['QS_AI_GRP_regrouping',TRUE,FALSE];
	doStop _unit;
	_unit doMove (_grp getVariable ['QS_AI_GRP_regroupPos',[0,0,0]]);
	TRUE;
};
if ((missionNamespace getVariable ['QS_AI_regroupPositions',[]]) isNotEqualTo []) then {
	private _dist = 99999;
	private _max = _dist;
	private _nearest = [0,0,0];
	{
		if ((side _unit) in (_x # 1)) then {
			_dist = _unit distance2D (_x # 2);
			if (_dist < 1200) then {
				if (_dist < _max) then {
					_nearest = _x # 2;
					_max = _dist;
				};
			};
		};
	} forEach (missionNamespace getVariable ['QS_AI_regroupPositions',[]]);
	if (_nearest isNotEqualTo [0,0,0]) then {
		_grp setVariable ['QS_AI_GRP_regroupPos',_nearest,FALSE];
		_grp setVariable ['QS_AI_GRP_regrouping',TRUE,FALSE];
		doStop _unit;
		_unit doMove (_grp getVariable ['QS_AI_GRP_regroupPos',[0,0,0]]);
	};
};
FALSE;