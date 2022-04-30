/*/
File: fn_garrisonUnits.sqf
Author:

	Quiksilver
	
Last Modified:

	5/04/2018 A3 1.82 by Quiksilver
	
Description:

	Garrison an array of units into buildings in a radius
	
Parameters:

	0 - ARRAY - Position
	1 - SCALAR - Radius
	2 - ARRAY - Units
	
Example:

	_units = [_pos,300,(units _grp),[]] call QS_fnc_garrisonUnits;
_____________________________________________________/*/

params ['_position','_radius','_gUnits','_typeNames',['_structureData',[]]];
if (canSuspend) then {
	scriptName 'QS - Script - Garrison Units';
};
scopeName 'QS_main';
private _buildings = nearestObjects [_position,_typeNames,_radius,TRUE];
_buildings = _buildings + ((allSimpleObjects []) select {(((_x distance2D _position) <= _radius) && (!(isObjectHidden _x)))});
private _arrayPositions = [];
_wallOffset = 0.25;
_buildings = _buildings call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
private _buildingPositions = [];
private _building = objNull;
{
	_building = _x;
	if (!(isObjectHidden _building)) then {
		_buildingPositions = [_building,(_building buildingPos -1)] call (missionNamespace getVariable 'QS_fnc_customBuildingPositions');
		if (_buildingPositions isNotEqualTo []) then {
			{
				0 = _arrayPositions pushBack _x;
			} forEach _buildingPositions;
		};
	};
} forEach _buildings;
if (_arrayPositions isEqualTo []) exitWith {diag_log '***** DEBUG ***** fn_garrisonUnits ***** No building positions available *****';};
_arrayPositions = _arrayPositions call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
_count = count _gUnits - 1;
private _arrayPositions2 = [];
private _index = -1;
private _positionToAdd = [0,0,0];
private _structureModelPos = [0,0,0];
private _structure = objNull;
private _relPos = [0,0,0];
for '_x' from 0 to _count step 1 do {
	_positionToAdd = selectRandom _arrayPositions;
	if (!isNil '_positionToAdd') then {
		_index = _arrayPositions find _positionToAdd;
		_arrayPositions2 pushBack _positionToAdd;
		_arrayPositions set [_index,FALSE];
		_arrayPositions deleteAt _index;
	};
};
private _isServerHC = ((isDedicated) || (!(hasInterface)));
private _unit = objNull;
{
	if (_forEachIndex > _count) exitWith {breakTo 'QS_main';};
	_unit = _gUnits select _forEachIndex;
	if ((_unit isKindOf 'Man') || {(_unit isKindOf 'Reammobox_F')}) then {
		if ((!((_arrayPositions2 select _forEachIndex) isEqualType FALSE)) && (((_arrayPositions2 select _forEachIndex) nearEntities ['Man',1]) isEqualTo [])) then {
			_unit setPos (_arrayPositions2 select _forEachIndex);
		} else {
			_unit setPos [
				(((_arrayPositions2 select _forEachIndex) select 0) + (1 - (random 2))),
				(((_arrayPositions2 select _forEachIndex) select 1) + (1 - (random 2))),
				((_arrayPositions2 select _forEachIndex) select 2)
			];
		};
		_unit setVariable ['QS_AI_UNIT_NEARESTBUILDING',([_unit] call (missionNamespace getVariable 'QS_fnc_getNearestBuilding')),FALSE];
		_structure = nearestObject [(_arrayPositions2 select _forEachIndex),'House'];
		if (!isNull _structure) then {
			_structureModelPos = getPosATL _structure;
			if ((_unit distance _structureModelPos) <= (sizeOf (typeOf _structure))) then {
				_relPos = _unit getRelPos [_wallOffset,((_arrayPositions2 select _forEachIndex) getDir _structureModelPos)];
				_unit setPos [(_relPos select 0),(_relPos select 1),((_arrayPositions2 select _forEachIndex) select 2)];
			};
		};
		if (_unit isKindOf 'Man') then {
			_unit setUnitPosWeak (['MIDDLE','UP'] select ((random 1) > 0.2));
			if (attackEnabled (group _unit)) then {
				(group _unit) enableAttack FALSE;
			};
		};
		_unit disableAI 'PATH';
		if (_isServerHC) then {
			_unit setVariable ['QS_unitGarrisoned',TRUE,(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
		} else {
			_unit setVariable ['QS_unitGarrisoned',TRUE,FALSE];
		};
	};
} forEach _arrayPositions2;
{
	if (!(_x getVariable ['QS_unitGarrisoned',FALSE])) then {
		deleteVehicle _x;
	};
} forEach _gUnits;
if (missionNamespace getVariable ['QS_HC_Active',FALSE]) then {
	[
		_gUnits,
		{
			{
				if (alive _x) then {
					_x disableAI 'PATH';
					_x setVariable ['QS_unitGarrisoned',TRUE,FALSE];
					if (attackEnabled (group _x)) then {
						(group _x) enableAttack FALSE;
					};
					_x setUnitPosWeak (['MIDDLE','UP'] select ((random 1) > 0.2));
				};
			} forEach _this;
		}
	] remoteExec ['call',(missionNamespace getVariable ['QS_headlessClients',[]]),FALSE];
};
_gUnits;