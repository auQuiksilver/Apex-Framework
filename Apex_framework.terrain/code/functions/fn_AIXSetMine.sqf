/*/
File: fn_AIXSetMine.sqf
Author:

	Quiksilver
	
Last modified:

	7/11/2017 A3 1.76 by Quiksilver
	
Description:

	AI Set Mine
	
To Do:

	Allow AI explosive-attach-to-vehicle
__________________________________________________/*/

scriptName 'QS Script AI Set Mine';
params [
	['_unit',objNull],
	['_target',objNull],
	['_duration',300],
	['_mineType','explosive charge'],
	['_setRadius',6],
	['_manualTouchOff',FALSE],
	['_addMagazine',FALSE]
];
private _magazineDetail = '';
if (_addMagazine) then {
	if (['explosive charge',_mineType,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) then {
		if ((((magazines _unit) apply {toLowerANSI _x}) findAny QS_core_classNames_demoCharges) isEqualTo -1) then {
			_unit addMagazine QS_core_classNames_demoCharge;
		};
	};
	if (['satchel',_mineType,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) then {
		if (((magazines _unit) findIf {((toLowerANSI _x) isEqualTo 'satchelcharge_remote_mag')}) isEqualTo -1) then {
			_unit addMagazine 'SatchelCharge_Remote_Mag';
		};
	};
};
_magazinesDetail = magazinesDetail _unit;
{
	if ([_mineType,_x,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) exitWith {
		_magazineDetail = _x;
	};
} forEach _magazinesDetail;
if (_magazineDetail isEqualTo '') exitWith {};
_magazineDetailArray = _magazineDetail splitString '[]/:';
reverse _magazineDetailArray;
_mineCreator = parseNumber (_magazineDetailArray # 0);
_mineID = parseNumber (_magazineDetailArray # 1);
private _time = diag_tickTime;
_timeout = diag_tickTime + _duration;
_moveDelay = 15;
private _moveCheckDelay = _time + 0;
private _exit = FALSE;
private _exit2 = FALSE;
private _useStartPosition = FALSE;
_startPosition = getPosATL _unit;
if ((_startPosition distance2D _target) > 50) then {
	_useStartPosition = TRUE;
};
_isTargetObject = _target isEqualType objNull;
private _minePosition = if (_isTargetObject) then {(getPosATL _target)} else {_target};
_unit allowFleeing 0;
_unit setUnitPos 'Middle';
{
	_unit enableAIFeature [_x,FALSE];
} forEach [
	'AUTOCOMBAT',
	'COVER',
	'TARGET',
	'AUTOTARGET',
	'WEAPONAIM'
];
_unit setVariable ['QS_AI_JOB',TRUE,FALSE];
private _touchOffDelay = 30;
private _touchOffTimer = -1;
for '_x' from 0 to 1 step 0 do {
	_time = diag_tickTime;
	if ((!alive _unit) || {(!((lifeState _unit) in ['HEALTHY','INJURED']))} || {(!alive _target)}) then {
		_exit2 = TRUE;
	};
	if (_isTargetObject) then {
		if (!alive _target) then {
			_exit2 = TRUE;
		};
	};
	if ((_unit distance2D _target) > _setRadius) then {
		if (_time > _moveCheckDelay) then {
			doStop _unit;
			if (_isTargetObject) then {
				_unit doMove (getPosATL _target);
			} else {
				_unit doMove _target;
			};
			_moveCheckDelay = _time + _moveDelay;
		};
	} else {
		_minePosition = getPosATL _unit;
		doStop _unit;
		_unit setDir (_unit getDir _target);
		uiSleep 0.1;
		_unit action ['UseMagazine',_unit,_unit,_mineCreator,_mineID];
		_exit = TRUE;
		_unit addEventHandler [
			'Killed',
			{
				params ['_unit'];
				{
					_x setDamage [1,TRUE];
				} forEach (getAllOwnedMines _unit);
			}
		];
		_unit addEventHandler [
			'Hit',
			{
				params ['_unit'];
				{
					_x setDamage [1,TRUE];
				} forEach (getAllOwnedMines _unit);
				_unit removeEventHandler [_thisEvent,_thisEventHandler];
			}
		];
	};
	if (_exit) exitWith {};
	if (_exit2) exitWith {};
	if (_time > _timeout) exitWith {};
	uiSleep 3;
};
_emptyPosition = [(getPosATL _unit),40,100,0.5,0,0.5,0] call (missionNamespace getVariable 'QS_fnc_findSafePos');
_unit doTarget objNull;
resetSubgroupDirection _unit;
doStop _unit;
_unit forceSpeed 24;
_unit doMove _emptyPosition;
if (_exit) then {
	_touchOffTimer = diag_tickTime + _touchOffDelay;
	if (_manualTouchOff) then {
		waitUntil {
			uiSleep 1;
			(((_unit distance2D _minePosition) > 50) || (!alive _unit) || (!((lifeState _unit) in ['HEALTHY','INJURED'])) || (diag_tickTime > _touchOffTimer))
		};
		if (alive _unit) then {
			_unit action ['TouchOff',_unit];
		};
	} else {
		uiSleep 1;
		_unitMines = getAllOwnedMines _unit;
		waitUntil {
			uiSleep 1;
			(((_unit distance2D _minePosition) > 50) || (!alive _unit) || (!((lifeState _unit) in ['HEALTHY','INJURED'])) || (diag_tickTime > _touchOffTimer))
		};
		if (alive _unit) then {
			_unit action ['TouchOff',_unit];
		} else {
			if (_unitMines isNotEqualTo []) then {
				{
					_x setDamage [1,TRUE];
				} forEach _unitMines;
			};
		};
	};
};
{
	_unit enableAIFeature [_x,TRUE];
} forEach [
	'TARGET',
	'AUTOTARGET',
	'WEAPONAIM'
];
if (_unit isNotEqualTo (leader (group _unit))) then {
	_unit doFollow (leader (group _unit));
};
_unit setVariable ['QS_AI_JOB',FALSE,FALSE];