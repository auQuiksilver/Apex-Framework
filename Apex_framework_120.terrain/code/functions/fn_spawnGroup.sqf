/*/
File: fn_spawnGroup.sqf
Author:

	Quiksilver
	
Last Modified:

	5/10/2018 A3 1.84 by Quiksilver
	
Description:
	
	Spawn a group of enemies from pre-defined group config
	
Example:

	_grp = [_pos,_dir,_side,_type,FALSE] call (missionNamespace getVariable 'QS_fnc_spawnGroup');
______________________________________________/*/

params [['_pos',[]],['_dir',-1],['_side',sideUnknown],['_type',''],['_isProne',FALSE],['_grp',grpNull],['_useRecycler',FALSE],['_deleteWhenEmpty',TRUE]];
if (
	(_pos isEqualTo []) ||
	{(_dir isEqualTo -1)} ||
	{(_side isEqualTo sideUnknown)} ||
	{(_type isEqualTo '')}
) exitWith {};
private _unit = objNull;
if (_type isEqualType []) then {
	if (!((_type findIf {(_x isEqualType 0)}) isEqualTo -1)) then {
		_type = selectRandomWeighted _type;
	} else {
		_type = selectRandom _type;
	};
};
if (_useRecycler) then {
	_useRecycler = isDedicated;
};
_groupComposition = [_side,_type] call (missionNamespace getVariable 'QS_fnc_returnGroupComposition');
if (isNull _grp) then {
	_grp = createGroup [_side,_deleteWhenEmpty];
	_grp setFormation 'WEDGE';
	_grp setFormDir _dir;
};
for '_i' from 0 to ((count _groupComposition) - 1) step 1 do {
	if (_useRecycler) then {
		_unit = [2,2,((_groupComposition select _i) select 0)] call (missionNamespace getVariable 'QS_fnc_serverObjectsRecycler');
		if (isNull _unit) then {
			_unit = _grp createUnit [((_groupComposition select _i) select 0),[-1015,-1015,0],[],15,'NONE'];
			missionNamespace setVariable ['QS_analytics_entities_created',((missionNamespace getVariable 'QS_analytics_entities_created') + 1),FALSE];
		} else {
			// wake up unit
			missionNamespace setVariable ['QS_analytics_entities_recycled',((missionNamespace getVariable ['QS_analytics_entities_recycled',0]) + 1),FALSE];
			{
				_unit setVariable [_x,nil,TRUE];
			} forEach (allVariables _unit);
			_unit setVariable ['QS_curator_disableEditability',FALSE,FALSE];
			_unit setVariable ['QS_dynSim_ignore',FALSE,FALSE];
			_unit hideObjectGlobal FALSE;
			_unit enableSimulationGlobal TRUE;
			_unit allowDamage TRUE;
			_unit enableAI 'ALL';
			[_unit] joinSilent _grp;
			_unit setUnitLoadout [(getUnitLoadout ((_groupComposition select _i) select 0)),TRUE];
			if ((damage _unit) > 0) then {
				_unit setDamage [0,FALSE];
			};
		};
	} else {
		_unit = _grp createUnit [((_groupComposition select _i) select 0),[-1015,-1015,0],[],15,'NONE'];
		missionNamespace setVariable ['QS_analytics_entities_created',((missionNamespace getVariable 'QS_analytics_entities_created') + 1),FALSE];
	};
	_unit = _unit call (missionNamespace getVariable 'QS_fnc_unitSetup');
	if (!((rank _unit) isEqualTo ((_groupComposition select _i) select 1))) then {
		_unit setRank ((_groupComposition select _i) select 1);
	};
	if (_isProne) then {
		_unit switchMove 'amovppnemstpsraswrfldnon';
	};
	if (!((side (group _unit)) isEqualTo _side)) then {
		[_unit] joinSilent _grp;
	};
	_unit setDir _dir;
	_unit setVehiclePosition [(AGLToASL _pos),[],5,'NONE'];
};
_grp;