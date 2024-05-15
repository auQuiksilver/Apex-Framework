/*
File: fn_aoTaskDestroyVehicle.sqf
Author: 

	Quiksilver

Last Modified:

	5/10/2016 A3 1.64 by Quiksilver

Description:

	Destroy vehicle task
	
Flow:

	Find vehicle
	Is suitable?
	Mark vehicle
____________________________________________________________________________*/

params ['_case','_state','_data'];
private _return = -1;
if (_state isEqualTo 0) then {
	//comment 'Clean up mission';
	_vehicle = _data # 0;
	if (!isNull _vehicle) then {
		/*/
		deleteVehicle _vehicle;/*/
	};
	diag_log 'Destroy vehicle task deleted';
	//comment 'RETURN EMPTY ARRAY';
	_return = [];
};
if (_state isEqualTo 1) then {
	//comment 'Create mission';
	diag_log 'Destroy vehicle task created';
	_aoPos = markerPos 'QS_marker_aoMarker';
	_worldSize = worldSize;
	if (_aoPos inPolygon [
		[0,0,0],
		[_worldSize,0,0],
		[_worldSize,_worldSize,0],
		[0,_worldSize,0]
	]) then {
		_aoSize = (missionNamespace getVariable 'QS_aoSize') * 1.25;
		private _vehicle = objNull;
		private _testVehicle = objNull;
		{
			if (isNull _vehicle) then {
				_testVehicle = _x;
				if (
					(alive _testVehicle) &&
					((_testVehicle distance _aoPos) <= _aoSize) &&
					((!(_testVehicle isKindOf 'StaticWeapon')) && (!(_testVehicle isKindOf 'Air'))) &&
					(canMove _testVehicle) &&
					(((crew _testVehicle) findIf {(alive _x)}) isNotEqualTo -1) &&
					((side (group (effectiveCommander _testVehicle))) in [EAST,RESISTANCE])
				) then {
					_vehicle = _x;
				};
			};
		} count vehicles;
		if (!isNull _vehicle) then {
			_vehicle addEventHandler [
				'Killed',
				{
					params ['_killed','_killer','_instigator'];
					if (!isNull _instigator) then {
						if (isPlayer _instigator) then {
							['sideChat',[WEST,'HQ'],(format [localize 'STR_QS_Chat_020',(name _instigator)])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
						};
					};
				}
			];
			['ST_DESTROY_VEHICLE',[localize 'STR_QS_Notif_011',localize 'STR_QS_Notif_012']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
			[
				'QS_IA_TASK_AO_3',
				TRUE,
				[
					(localize 'STR_QS_Task_012'),
					(localize 'STR_QS_Task_013'),
					(localize 'STR_QS_Task_013')
				],
				[_vehicle,TRUE],
				'CREATED',
				5,
				FALSE,
				TRUE,
				'Destroy',
				TRUE
			] call (missionNamespace getVariable 'BIS_fnc_setTask');
			_return = [
				_case,
				2,
				[
					_vehicle
				]
			];
			diag_log 'Destroy vehicle task created';
		};
	};
};
if (_state isEqualTo 2) then {
	//comment 'Check mission state';
	_vehicle = _data # 0;
	if ((!alive _vehicle) || {(isNull _vehicle)}) exitWith {
		//comment 'Mission success';
		['ST_DESTROY_VEHICLE',[localize 'STR_QS_Notif_011',localize 'STR_QS_Notif_013']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
		['QS_IA_TASK_AO_3'] call (missionNamespace getVariable 'BIS_fnc_deleteTask');
		if (missionNamespace getVariable ['QS_virtualSectors_active',FALSE]) then {
			private ['_QS_virtualSectors_scoreSides','_scoreEast','_scoreToRemove'];
			_QS_virtualSectors_scoreSides = missionNamespace getVariable ['QS_virtualSectors_scoreSides',[0,0,0,0,0]];
			_scoreEast = _QS_virtualSectors_scoreSides # 0;
			if (_scoreEast > ((missionNamespace getVariable ['QS_virtualSectors_scoreWin',300]) * 0.1)) then {
				_scoreToRemove = (missionNamespace getVariable ['QS_virtualSectors_scoreWin',300]) * (missionNamespace getVariable ['QS_virtualSectors_bonusCoef_smallTask',0.05]);
				_QS_virtualSectors_scoreSides set [0,((_QS_virtualSectors_scoreSides # 0) - _scoreToRemove)];
				missionNamespace setVariable ['QS_virtualSectors_scoreSides',_QS_virtualSectors_scoreSides,FALSE];
			};
		};
		_return = [
			_case,
			0,
			[
				_vehicle
			]
		];
	};
};
_return;