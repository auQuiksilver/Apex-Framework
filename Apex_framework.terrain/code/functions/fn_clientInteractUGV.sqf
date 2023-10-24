/*/
File: fn_clientInteractUGV.sqf
Author:

	Quiksilver
	
Last modified:

	27/04/2018 A3 1.82 by Quiksilver
	
Description:
	
	Interact with UGV Stomper
	
Flow:

	0 - Is Eligible (has stretchers attached)
	1 - Is space available
	2 - Load
	3 - Unload
	4 -	UGV Load
	5 - UGV Unload
__________________________________________________________________________/*/

params [
	['_vehicle',objNull],
	['_type',-1]
];
private _return = -1;
if (_type isEqualTo 0) exitWith {
	//comment 'Is eligible stomper for medical loading, return type BOOL';
	_return = FALSE;
	_return = (((attachedObjects _vehicle) select {
		(
			((!(isSimpleObject _x)) && ((toLowerANSI (typeOf _x)) in ['land_stretcher_01_f','land_stretcher_01_olive_f','land_stretcher_01_sand_f']) && (!(isObjectHidden _x))) ||
			((isSimpleObject _x) && (((getModelInfo _x) # 1) isEqualTo 'a3\props_f_orange\humanitarian\camps\stretcher_01_f.p3d') && (!(isObjectHidden _x)))
		)
	}) isNotEqualTo []);
	_return;
};
if (_type isEqualTo 1) exitWith {
	//comment 'Get available space, return type SCALAR';
	_nStretchers = count ((attachedObjects _vehicle) select {
		(
			((!(isSimpleObject _x)) && ((toLowerANSI (typeOf _x)) in ['land_stretcher_01_f','land_stretcher_01_olive_f','land_stretcher_01_sand_f'])) ||
			((isSimpleObject _x) && (((getModelInfo _x) # 1) isEqualTo 'a3\props_f_orange\humanitarian\camps\stretcher_01_f.p3d'))
		)
	});
	_nBodies = count ((attachedObjects _vehicle) select {
		((_x isKindOf 'CAManBase') && (alive _x))
	});
	_return = (_nStretchers - _nBodies);
	_return;
};
if (_type isEqualTo 2) exitWith {
	//comment 'Load, return type BOOL';
	params ['','',['_body',objNull]];
	_return = FALSE;
	if (alive _body) then {
		_cargoPosition = [[0,-0.75,-0.5],[0.85,-0.75,-0.5]] select ((count ((attachedObjects _vehicle) select {((_x isKindOf 'CAManBase') && (alive _x))})) isEqualTo 1);
		_body setVariable ['QS_RD_loaded',TRUE,TRUE];
		[0,_body] call QS_fnc_eventAttach;
		if (!isPlayer _body) then {
			['enableAIFeature',_body,['ANIM',FALSE]] remoteExecCall ['QS_fnc_remoteExecCmd',_body];
		};
		[1,_body,[_vehicle,_cargoPosition]] call QS_fnc_eventAttach;
		['switchMove',_body,'unconsciousrevivedefault_a'] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
		_return = TRUE;
	};
	_return;
};
if (_type isEqualTo 3) exitWith {
	//comment 'Unload, return type BOOL';
	params ['','',['_body',objNull]];
	_return = TRUE;
	_position = _vehicle modelToWorld (_vehicle selectionPosition ['pos cargo','memory']);
	_body setVariable ['QS_RD_loaded',FALSE,TRUE];
	[0,_body] call QS_fnc_eventAttach;
	_body setVehiclePosition [_position,[],0,'NONE'];
	['switchMove',_body,'acts_InjuredLyingRifle02'] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
	if (!isPlayer _body) then {
		['enableAI',_body,'ANIM'] remoteExecCall ['QS_fnc_remoteExecCmd',_body];
	};
	_return;
};
if (_type isEqualTo 4) exitWith {
	_list = ((_vehicle getRelPos [3,0]) nearEntities ['CAManBase',3]) select {(((lifeState _x) isEqualTo 'INCAPACITATED') && (isNull (attachedTo _x)) && (isNull (objectParent _x)))};
	if (_list isNotEqualTo []) then {
		_unit = _list # 0;
		[_vehicle,2,_unit] call (missionNamespace getVariable 'QS_fnc_clientInteractUGV');
	};
};
if (_type isEqualTo 5) exitWith {
	_list = (attachedObjects _vehicle) select {(_x isKindOf 'CAManBase')};
	if (_list isNotEqualTo []) then {
		[_vehicle,3,(_list # 0)] call (missionNamespace getVariable 'QS_fnc_clientInteractUGV');
	};
};
_return;