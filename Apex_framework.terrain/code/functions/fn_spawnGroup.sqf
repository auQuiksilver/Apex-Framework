/*
File: fn_spawnGroup.sqf
Author:

	Quiksilver
	
Last Modified:

	20/03/2017 A3 1.68 by Quiksilver
	
Description:
	
	Spawn a group of enemies from pre-defined group config
	
Example:

	_grp = [_pos,_dir,_side,_type,FALSE] call (missionNamespace getVariable 'QS_fnc_spawnGroup');
______________________________________________*/

params [['_pos',[]],['_dir',-1],['_side',sideUnknown],['_type',''],['_isProne',FALSE]];
if (
	(_pos isEqualTo []) ||
	{(_dir isEqualTo -1)} ||
	{(_side isEqualTo sideUnknown)} ||
	{(_type isEqualTo '')}
) exitWith {};
private _unit = objNull;
if (_type isEqualType []) then {
	_type = selectRandom _type;
};
_groupComposition = [_side,_type] call (missionNamespace getVariable 'QS_fnc_returnGroupComposition');
_grp = createGroup [_side,TRUE];
_grp setFormation 'WEDGE';
_grp setFormDir _dir;
for '_i' from 0 to ((count _groupComposition) - 1) step 1 do {
	_unit = _grp createUnit [((_groupComposition select _i) select 0),[(0 + (5 - (random 10))),(0 + (5 - (random 10))),0],[],0,'NONE'];
	missionNamespace setVariable [
		'QS_analytics_entities_created',
		((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
		FALSE
	];
	_unit = _unit call (missionNamespace getVariable 'QS_fnc_unitSetup');
	_unit setRank ((_groupComposition select _i) select 1);
	if (_isProne) then {
		_unit switchMove 'amovppnemstpsraswrfldnon';
	};
	if (!((side _unit) isEqualTo _side)) then {
		[_unit] joinSilent _grp;
	};
	_unit setDir _dir;
	_unit setPos [((_pos select 0) + (5 - (random 10))),((_pos select 1) + (5 - (random 10))),0];
};
_grp;