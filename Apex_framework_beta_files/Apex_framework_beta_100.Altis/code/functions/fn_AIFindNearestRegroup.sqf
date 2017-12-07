/*/
File: fn_AIFindNearestRegroup.sqf
Author:

	Quiksilver
	
Last Modified:

	29/10/2017 A3 1.76 by Quiksilver
	
Description:

	AI Find nearest suitable group to merge with
_____________________________________________________________________/*/

params ['_unit','_radius'];
_side = side _unit;
_grp = group _unit;
_groupConfig = _grp getVariable 'QS_AI_GRP_CONFIG';
_groupTask = _grp getVariable 'QS_AI_GRP_TASK';
private _suitableGroups = [];
private _testGroup = grpNull;
private _testGroupConfig = [];
private _groupFound = FALSE;
{
	if ((side _x) isEqualTo _side) then {
		if (_x getVariable ['QS_AI_GRP',FALSE]) then {
			if (!(({(alive _x)} count (units _x)) isEqualTo 0)) then {
				if (((leader _x) distance2D _unit) < _radius) then {
					_testGroup = _x;
					_testGroupConfig = _testGroup getVariable ['QS_AI_GRP_CONFIG',['','',-1,objNull]];
					_testGroupTask = _testGroup getVariable ['QS_AI_GRP_TASK',['',[0,0,0],-1]];
					if (
						(!isNil {_testGroupConfig select 0) &&
						(!isNil {_testGroupConfig select 1) &&
						(!isNil {_testGroupConfig select 2) &&
						(!isNil {_testGroupTask select 0) &&
						(!isNil {_testGroupTask select 1) &&
						(!isNil {_testGroupTask select 2)
					) then {
						if ((!(_testGroupConfig isEqualTo [])) && (!(_testGroupTask isEqualTo []))) then {
							if (((_testGroupConfig select 0) isEqualTo (_groupConfig select 0)) && ((_testGroupConfig select 1) isEqualTo (_groupConfig select 1)) && ((_testGroupTask select 0) isEqualTo (_groupTask select 0))) then {
								_groupFound = TRUE;
							} else {
								if (((_testGroupConfig select 0) isEqualTo (_groupConfig select 0)) && ((_testGroupConfig select 1) isEqualTo (_groupConfig select 1))) then {
									_suitableGroups pushBack _testGroup;
								} else {
									if ((_testGroupConfig select 0) isEqualTo (_groupConfig select 0)) then {
										_suitableGroups pushBack _testGroup;
									};
								};
							};
						};
					};
				};
			};
		};
	};
	if (_groupFound) exitWith {

	};
} forEach allGroups;
if (_groupFound) exitWith {
	[_unit] joinSilent _testGroup;
	TRUE;
};
if (!(_suitableGroups isEqualTo [])) exitWith {
	[_unit] joinSilent (selectRandom _suitableGroups);
	TRUE;
};
if (!isNil {_grp getVariable 'QS_AI_GRP_regroupPos'}) exitWith {
	_grp setVariable ['QS_AI_GRP_regrouping',TRUE,FALSE];
	_unit forceSpeed -1;
	_unit doMove (_grp getVariable 'QS_AI_GRP_regroupPos');
	TRUE;
};
FALSE;
if (!((missionNamespace getVariable ['QS_AI_regroupPositions',[]]) isEqualTo [])) then {
	{
		if ((_unit distance2D _x) < 1200) exitWith {
			_grp setVariable ['QS_AI_GRP_regroupPos',_x,FALSE];
			_grp setVariable ['QS_AI_GRP_regrouping',TRUE,FALSE];
			_unit forceSpeed -1;
			_unit doMove (_grp getVariable 'QS_AI_GRP_regroupPos');
		};
	} forEach (missionNamespace getVariable ['QS_AI_regroupPositions',[]]);
};