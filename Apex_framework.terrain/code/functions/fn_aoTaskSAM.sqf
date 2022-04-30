/*/
File: fn_aoTaskSAM.sqf
Author: 

	Quiksilver

Last Modified:

	4/03/2018 A3 1.80 by Quiksilver

Description:

	SAM
__________________________________________________________/*/

params ['_case','_state','_data'];
private _return = -1;
if (_state isEqualTo 0) then {
	//comment 'Clean up mission';
	_vehicle = _data select 0;
	if (!isNull _vehicle) then {
		/*/
		missionNamespace setVariable [
			'QS_analytics_entities_deleted',
			((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),
			FALSE
		];
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
				if (!isNull _testVehicle) then {
					if ((_testVehicle distance _aoPos) <= _aoSize) then {
						if ((!(_testVehicle isKindOf 'StaticWeapon')) && (!(_testVehicle isKindOf 'Air'))) then {
							if (alive _testVehicle) then {
								if (canMove _testVehicle) then {
									if (!(((crew _testVehicle) findIf {(alive _x)}) isEqualTo -1)) then {
										if ((side (effectiveCommander _testVehicle)) in [EAST,RESISTANCE]) then {
											_vehicle = _x;
										};
									};
								};
							};
						};
					};
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
							['sideChat',[WEST,'HQ'],(format ['Target destroyed by %1!',(name _instigator)])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
						};
					};
				}
			];
			['ST_DESTROY_VEHICLE',['Destroy','Destroy enemy vehicle']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
			[
				'QS_IA_TASK_AO_3',
				TRUE,
				[
					'Intel has located an enemy vehicle. Take it out!',
					'Destroy vehicle',
					'Destroy vehicle'
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
	_vehicle = _data select 0;
	if ((!alive _vehicle) || {(isNull _vehicle)}) exitWith {
		//comment 'Mission success';
		['ST_DESTROY_VEHICLE',['Destroy','Enemy vehicle destroyed']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
		['QS_IA_TASK_AO_3'] call (missionNamespace getVariable 'BIS_fnc_deleteTask');
		if (missionNamespace getVariable ['QS_virtualSectors_active',FALSE]) then {
			private ['_QS_virtualSectors_scoreSides','_scoreEast','_scoreToRemove'];
			_QS_virtualSectors_scoreSides = missionNamespace getVariable ['QS_virtualSectors_scoreSides',[0,0,0,0,0]];
			_scoreEast = _QS_virtualSectors_scoreSides select 0;
			if (_scoreEast > ((missionNamespace getVariable ['QS_virtualSectors_scoreWin',300]) * 0.1)) then {
				_scoreToRemove = (missionNamespace getVariable ['QS_virtualSectors_scoreWin',300]) * (missionNamespace getVariable ['QS_virtualSectors_bonusCoef_smallTask',0.05]);
				_QS_virtualSectors_scoreSides set [0,((_QS_virtualSectors_scoreSides select 0) - _scoreToRemove)];
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