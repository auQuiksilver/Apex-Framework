/*/
File: fn_garrisonUnits.sqf
Author:

	Quiksilver
	
Last Modified:

	9/10/2023 A3 2.14 by Quiksilver
	
Description:

	Garrison an array of objects into buildings in a radius
	
Parameters:

	0 - ARRAY - Position
	1 - SCALAR - Radius
	2 - ARRAY - Units
	
Example:

	_units = [_pos,300,(units _grp),[]] call QS_fnc_garrisonUnits;
_____________________________________________________/*/

params [['_position',objNull,[objNull,[0,0,0]]],['_radius',50],['_gUnits',[]],['_typeNames',['House']],['_structureData',[]],['_deleteUngarrisoned',TRUE]];
if (canSuspend) then {
	scriptName 'QS - Script - Garrison Units';
};
scopeName 'QS_main';
if (_gUnits isEqualTo []) exitWith {diag_log '***** DEBUG ***** fn_garrisonUnits ***** No units selected *****';};
private _buildings = nearestObjects [_position,_typeNames,_radius,TRUE] select {!isObjectHidden _x};
_buildings = _buildings + (((allSimpleObjects []) inAreaArray [_position,_radius,_radius,0,FALSE]) select {!isObjectHidden _x});
private _arrayPositions = [];
_wallOffset = 0.25;
_buildings = _buildings call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
private _buildingPositions = [];
private _building = objNull;
{
	_building = _x;
	_buildingPositions = [_building,(_building buildingPos -1)] call (missionNamespace getVariable 'QS_fnc_customBuildingPositions');
	if (_buildingPositions isNotEqualTo []) then {
		{
			_arrayPositions pushBack _x;
		} forEach _buildingPositions;
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
private _garrisoned_nonLocal = [];
private _isServerHC = ((isDedicated) || (!(hasInterface)));
private _unit = objNull;
{
	if (_forEachIndex > _count) exitWith {breakTo 'QS_main';};
	_unit = _gUnits # _forEachIndex;
	if ((_unit isKindOf 'CAManBase') || {(([_unit] call QS_fnc_getObjectVolume) < 2)}) then {
		if ((!((_arrayPositions2 # _forEachIndex) isEqualType FALSE)) && (((_arrayPositions2 # _forEachIndex) nearEntities ['CAManBase',1]) isEqualTo [])) then {		
			_unit setPosASL (AGLToASL (_arrayPositions2 # _forEachIndex));
		} else {
			_unit setPosASL (AGLToASL [
				(((_arrayPositions2 # _forEachIndex) # 0) + (1 - (random 2))),
				(((_arrayPositions2 # _forEachIndex) # 1) + (1 - (random 2))),
				((_arrayPositions2 # _forEachIndex) # 2)
			]);
		};
		_structure = nearestObject [(_arrayPositions2 # _forEachIndex),'House'];
		if (!isNull _structure) then {
			_structureModelPos = getPosATL _structure;
			if ((_unit distance _structureModelPos) <= (sizeOf (typeOf _structure))) then {
				_relPos = _unit getRelPos [_wallOffset,((_arrayPositions2 # _forEachIndex) getDir _structureModelPos)];
				_unit setPosASL (AGLToASL [(_relPos # 0),(_relPos # 1),((_arrayPositions2 # _forEachIndex) # 2)]);
			};
		};
		if (_unit isKindOf 'CAManBase') then {
			_unit setVariable ['QS_AI_UNIT_NEARESTBUILDING',([_unit] call (missionNamespace getVariable 'QS_fnc_getNearestBuilding')),FALSE];
			_unit setUnitPos (['Middle','Up'] select ((random 1) > 0.2));
			if (attackEnabled (group _unit)) then {
				(group _unit) enableAttack FALSE;
			};
			_unit enableAIFeature ['COVER',FALSE];
			_unit enableAIFeature ['PATH',FALSE];
			if (!local _unit) then {
				_garrisoned_nonLocal pushBack _x;
			};
		};
		if (_isServerHC) then {
			_unit setVariable ['QS_unitGarrisoned',TRUE,QS_system_AI_owners];
		} else {
			_unit setVariable ['QS_unitGarrisoned',TRUE,FALSE];
		};
	};
} forEach _arrayPositions2;
if (_garrisoned_nonLocal isNotEqualTo []) then {
	['enableAIFeature',_garrisoned_nonLocal,['PATH',FALSE]] remoteExec ['QS_fnc_remoteExecCmd',(_garrisoned_nonLocal # 0),FALSE];
};
if (_deleteUngarrisoned) then {
	deleteVehicle (_gUnits select {(!(_x getVariable ['QS_unitGarrisoned',FALSE]))});
};
_gUnits;