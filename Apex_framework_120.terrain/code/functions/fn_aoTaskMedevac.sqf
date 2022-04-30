/*
File: fn_aoTaskMedevac.sqf
Author: 

	Quiksilver

Last Modified:

	23/07/2016 A3 1.62 by Quiksilver

Description:

	Medevac task
____________________________________________________________________________*/

params ['_case','_state','_data'];
private _return = -1;
if (_state isEqualTo 0) then {
	//comment 'Clean up mission';
	_unit = _data select 0;
	_missionDuration = _data select 1;
	_missionDestination = _data select 2;
	if (!isNull _unit) then {
		QS_garbageCollector pushBack [_unit,'NOW_FORCED',0];
	};
	diag_log 'Medevac task deleted';
	_return = [];
};
if (_state isEqualTo 1) then {
	//comment 'Create mission';
	diag_log 'Medevac task created 0';
	_aoPos = markerPos 'QS_marker_aoMarker';
	_worldSize = worldSize;
	if (_aoPos inPolygon [
		[0,0,0],
		[_worldSize,0,0],
		[_worldSize,_worldSize,0],
		[0,_worldSize,0]
	]) then {
		_missionDuration = serverTime + 3600;
		_missionDestination = markerPos 'QS_marker_medevac_hq';
		private ['_unitType','_position'];
		for '_x' from 0 to 49 step 1 do {
			_position = ['RADIUS',_aoPos,((missionNamespace getVariable 'QS_aoSize') * 0.75),'LAND',[2,0,0.5,3,0,FALSE,objNull],TRUE,[],[],TRUE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
			if ((([(_position select 0),(_position select 1)] nearRoads 15) select {((_x isEqualType objNull) && (!((roadsConnectedTo _x) isEqualTo [])))}) isEqualTo []) exitWith {};
		};
		if (worldName isEqualTo 'Tanoa') then {
			_unitType = selectRandom ['B_T_Recon_TL_F','B_T_Recon_M_F','B_T_Recon_Medic_F','B_T_Recon_LAT_F','B_T_Recon_JTAC_F','B_T_Recon_Exp_F'];
		} else {
			_unitType = selectRandom ['B_recon_TL_F','B_recon_M_F','B_recon_medic_F','B_recon_F','B_recon_LAT_F','B_recon_JTAC_F','B_recon_exp_F','B_Recon_Sharpshooter_F'];
		};
		_unit = createAgent [_unitType,_position,[],0,'NONE'];
		missionNamespace setVariable [
			'QS_analytics_entities_created',
			((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
			FALSE
		];
		_unit setDir (random 360);
		_unit setSkill 0;
		_unit allowDamage FALSE;
		_unit spawn {
			sleep 5; 
			_this allowDamage TRUE;
		};
		_unit setUnconscious TRUE;
		_unit spawn {
			uiSleep 6;
			['switchMove',_this,'acts_InjuredLyingRifle02'] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
		};
		_unit setCaptive TRUE;
		{
			_unit disableAI _x;
		} forEach [
			'FSM',
			'MOVE',
			'PATH',
			'TEAMSWITCH',
			'TARGET',
			'AUTOTARGET',
			'SUPPRESSION',
			'AIMINGERROR',
			'AUTOCOMBAT',
			'ANIM'
		];
		[_unit,'CTRG'] call (missionNamespace getVariable 'BIS_fnc_setUnitInsignia');
		removeAllWeapons _unit;
		if ((random 1) > 0.5) then {
			removeHeadgear _unit;
		};
		_unit unlinkItem (hmd _unit);
		_unit setDamage 0.5;
		(missionNamespace getVariable 'QS_RD_mission_objectives') pushBack _unit;
		_unit addEventHandler [
			'Killed',
			{
				params ['_killed','_killer'];
				detach _killed;
				['sideChat',[WEST,'BLU'],'Wounded soldier has been killed.'] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
			}
		];
		for '_x' from 0 to 1 step 1 do {
			_unit switchMove 'AinjPpneMstpSnonWnonDnon';
			{
				_unit setVariable _x;
			} forEach [
				['QS_RD_interacting',FALSE,TRUE],
				['QS_RD_isIncapacitated',TRUE,TRUE],
				['QS_RD_missionObjective',TRUE,TRUE],
				['QS_RD_rescued',FALSE,TRUE],
				['QS_RD_loadable',TRUE,TRUE],
				['QS_RD_loaded',FALSE,TRUE],
				['QS_RD_unloaded',TRUE,TRUE],
				['QS_RD_unloadable',TRUE,TRUE],
				['QS_RD_draggable',TRUE,TRUE],
				['QS_RD_dragged',FALSE,TRUE],
				['QS_RD_carried',FALSE,TRUE],
				['QS_RD_recovered',FALSE,FALSE],
				['QS_noHeal',TRUE,TRUE],
				['QS_RD_storedAnim',(animationState _unit),TRUE],
				['QS_aoTask_medevac_unit',TRUE,TRUE],
				['QS_revive_disable',TRUE,TRUE]
			];
		};
		['ST_MEDEVAC',['Medevac','Medevac wounded soldier']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
		[
			'QS_IA_TASK_AO_3',
			TRUE,
			[
				'A recon soldier has been wounded in the AO and requires urgent medevac. Get him back to the Medevac HQ at base (small white building) to complete the mission. If he dies or bleeds out (about 60 minutes from mission start), the mission is failed. Good luck soldiers!',
				'Medevac',
				'Medevac'
			],
			[_unit,TRUE],
			'CREATED',
			5,
			FALSE,
			TRUE,
			'Heal',
			TRUE
		] call (missionNamespace getVariable 'BIS_fnc_setTask');
		['QS_IA_TASK_AO_3',TRUE,_missionDuration] call (missionNamespace getVariable 'QS_fnc_taskSetTimer');
		_return = [
			_case,
			2,
			[
				_unit,
				_missionDuration,
				_missionDestination
			]
		];
	};
	diag_log 'Medevac task created 1';
};
if (_state isEqualTo 2) then {
	//comment 'Check mission state';
	_unit = _data select 0;
	_missionDuration = _data select 1;
	_missionDestination = _data select 2;
	if (!isNull _unit) then {
		if (((getPosASL _unit) select 2) < -1) then {
			_unit setDamage [1,TRUE];
		};
	};
	if (serverTime > _missionDuration) exitWith {
		//comment 'Mission failure';
		['ST_MEDEVAC',['Medevac','Medevac failed, soldier bled out!']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
		['QS_IA_TASK_AO_3'] call (missionNamespace getVariable 'BIS_fnc_deleteTask');
		_return = [
			_case,
			0,
			[
				_unit,
				_missionDuration,
				_missionDestination
			]
		];
	};	
	if ((((_unit distance _missionDestination) < 3.5) && (isNull (attachedTo _unit))) || (([0,_unit] call (missionNamespace getVariable 'QS_fnc_isNearFieldHospital')) && (isNull (attachedTo _unit)) && (isNull (objectParent _unit)))) exitWith {
		//comment 'Mission success';
		['ST_MEDEVAC',['Medevac','Medevac complete!']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
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
				_unit,
				_missionDuration,
				_missionDestination
			]
		];
	};
	if (!alive _unit) exitWith {
		//comment 'Mission failure';
		['ST_MEDEVAC',['Medevac','Medevac failed, soldier killed!']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
		['QS_IA_TASK_AO_3'] call (missionNamespace getVariable 'BIS_fnc_deleteTask');
		_return = [
			_case,
			0,
			[
				_unit,
				_missionDuration,
				_missionDestination
			]
		];
	};
};
_return;