/*
File: fn_clientEventCuratorGroupPlaced.sqf
Author:

	Quiksilver
	
Last modified:

	9/10/2023 A3 2.14 by Quiksilver
	
Description:

	Curator Group Placed
__________________________________________________*/

params ['_module','_group'];
_leader = leader _group;
if (
	(isNull (objectParent _leader)) &&
	{(uiNamespace getVariable ['QS_uiaction_altHold',FALSE])} &&
	{(!isNull curatorCamera)}
) then {
	_leader setDir (curatorCamera getDirVisual _leader);
	_group setFormDir (curatorCamera getDirVisual _leader);
	{
		if (_x isNotEqualTo _leader) then {
			_x setPosASL (AGLToASL (formationPosition _x));
		};
	} forEach (units _group);
};
{
	_x enableAIFeature ['AUTOCOMBAT',FALSE];
} forEach (units _group);
_group setSpeedMode 'FULL';
_group setBehaviourStrong 'AWARE';
_group deleteGroupWhenEmpty TRUE;
_group addEventHandler [
	'WaypointComplete',
	{
		params ['_group','_waypointIndex'];
		if ((waypointPosition [_group,_waypointIndex + 1]) isNotEqualTo [0,0,0]) then {
			_group setFormDir ((leader _group) getDir (waypointPosition [_group,_waypointIndex + 1]));
		};
	}
];
if (!isNull (objectParent (leader _group))) then {
	if ((objectParent (leader _group)) isKindOf 'LandVehicle') then {
		_group setFormation 'COLUMN';
	};
};
[_group,_leader] spawn {
	params ['_group','_leader'];
	sleep 0.25;
	if (!isNull (missionNamespace getVariable ['QS_destroyerObject',objNull])) then {
		_destroyer = missionNamespace getVariable ['QS_destroyerObject',objNull];
		if ((_leader distance2D _destroyer) < 150) then {
			_units = units _group;
			private _destroyerBuildingPositions = (call QS_data_destroyerBuildingPositions) apply { ((missionNamespace getVariable 'QS_destroyerObject') modelToWorldWorld _x) };
			private _destroyerBuildingPositionWeights = [];
			{
				_destroyerBuildingPositionWeights pushBack (0 max (150 - (_x distance2D _leader)) min 150);
			} forEach _destroyerBuildingPositions;
			private _selectedPosition = [0,0,0];
			private _unit = objNull;
			private _index = -1;
			{
				_unit = _x;
				_selectedPosition = _destroyerBuildingPositions selectRandomWeighted _destroyerBuildingPositionWeights;
				_unit setPosWorld _selectedPosition;
				_unit enableAIFeature ['PATH',FALSE];
				_index = _destroyerBuildingPositions find _selectedPosition;
				_destroyerBuildingPositions deleteAt _index;
				_destroyerBuildingPositionWeights deleteAt _index;
			} forEach _units;
		};
	};
};