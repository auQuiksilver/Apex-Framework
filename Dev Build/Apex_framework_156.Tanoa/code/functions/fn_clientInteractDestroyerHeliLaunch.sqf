/*
File: fn_clientInteractDestroyerHeliLaunch.sqf
Author: 

	Quiksilver

Last Modified:

	29/01/2023 A3 2.12 by Quiksilver

Description:

	Move helicopter in/out of USS Liberty hangar
______________________________________________________*/

if (isDedicated) exitWith {
	params ['_clientOwner'];
	if (missionNamespace getVariable ['QS_destroyer_heliLaunch',FALSE]) exitWith {};
	missionNamespace setVariable ['QS_destroyer_heliLaunch',TRUE,TRUE];
	private _launch = FALSE;
	private _obstructed = FALSE;
	private _obstructions = [];
	QS_destroyerHeli_worldPos1 = QS_destroyerObject modelToWorldWorld [0.267822,78.0225,8.81596];
	QS_destroyerHeli_worldPos2 = QS_destroyerObject modelToWorldWorld [0.074707,42.9854,8.81596];
	_helipadPos = QS_destroyerObject modelToWorldWorld [0.267822,78.0273,8.81878];
	if (isNull (QS_destroyerObject getVariable ['QS_destroyer_hangarHeli',objNull])) then {
		private _list = [];
		_list = (nearestObjects [ASLToAGL _helipadPos,['Helicopter'],15,TRUE]) select {alive _x && simulationEnabled _x};
		if (_list isEqualTo []) exitWith {};
		_list = _list apply { [_x distance2D _helipadPos,_x] };
		_list sort TRUE;
		_list = _list apply {_x # 1};
		QS_destroyer_heli = _list # 0;
		QS_destroyer_heli allowDamage FALSE;
		_obstructions = (nearestObjects [ASLToAGL QS_destroyerHeli_worldPos2,['Helicopter'],20,TRUE]) - [QS_destroyer_heli];
		_obstructed = _obstructions isNotEqualTo [];
	} else {
		_launch = TRUE;
		QS_destroyer_heli = QS_destroyerObject getVariable ['QS_destroyer_hangarHeli',objNull];
		_obstructions = (nearestObjects [ASLToAGL _helipadPos,['Helicopter'],20,TRUE]) - [QS_destroyer_heli];
		_obstructed = _obstructions isNotEqualTo [];		
	};
	if (_obstructed) exitWith {
		missionNamespace setVariable ['QS_destroyer_heliLaunch',FALSE,TRUE];
		[[_obstructions],{
			params ['_obstructions'];
			_obstructions = _obstructions apply {(getText ((configOf _x) >> 'displayName'))};
			_obstruction = _obstructions # 0;
			50 cutText [format ['%1 - %2',localize 'STR_QS_Text_102',_obstruction],'PLAIN',0.333];
		}] remoteExec ['call',_clientOwner];
	};
	if (!alive QS_destroyer_heli) exitWith {
		missionNamespace setVariable ['QS_destroyer_heliLaunch',FALSE,TRUE];
	};
	_timeout = diag_tickTime + 5;
	if (!local QS_destroyer_heli) then {
		waitUntil {
			if (
				(!unitIsUAV QS_destroyer_heli) && ((crew QS_destroyer_heli) isNotEqualTo [])
			) then {
				{
					moveOut _x;
				} forEach (crew QS_destroyer_heli);
				sleep 0.1;
			};
			((QS_destroyer_heli setOwner 2) || (diag_tickTime > _timeout))
		};
	};
	if (diag_tickTime > _timeout) exitWith {
		missionNamespace setVariable ['QS_destroyer_heliLaunch',FALSE,TRUE];
	};
	if (
		(!unitIsUAV QS_destroyer_heli) && ((crew QS_destroyer_heli) isNotEqualTo [])
	) then {
		{
			_x moveOut QS_destroyer_heli;
		} forEach (crew QS_destroyer_heli);
	};
	QS_destroyer_heli allowDamage FALSE;
	for '_i' from 0 to 2 step 1 do {
		if (!simulationEnabled QS_destroyer_heli) then {
			QS_destroyer_heli enableSimulationGlobal TRUE;
		};
		sleep 0.1;
		QS_destroyer_heli setDir ((getDir QS_destroyerObject) - 180);
	};
	QS_destroyer_heli lock 2;
	if (isEngineOn QS_destroyer_heli) then {
		QS_destroyer_heli engineOn FALSE;
	};
	if (isCollisionLightOn QS_destroyer_heli) then {
		QS_destroyer_heli setCollisionLight FALSE;
	};
	if (isLightOn QS_destroyer_heli) then {
		QS_destroyer_heli setPilotLight FALSE;
	};
	if (isLightOn [QS_destroyer_heli, [0]]) then {
		(allUnits # 0) action ['SearchlightOff', QS_destroyer_heli];
	};
	QS_destroyer_heli enableDynamicSimulation FALSE;
	if (_launch) then {
		QS_destroyer_heliLaunch_startPos = QS_destroyerHeli_worldPos2;
		QS_destroyer_heliLaunch_endPos = QS_destroyerHeli_worldPos1;	
	} else {
		QS_destroyer_heliLaunch_startPos = QS_destroyerHeli_worldPos1;
		QS_destroyer_heliLaunch_endPos = QS_destroyerHeli_worldPos2;	
	};
	QS_destroyer_heli_t1 = diag_tickTime;
	QS_destroyer_heli_t2 = diag_tickTime + (missionNamespace getVariable ['QS_destroyerHeliLaunch_speed',15]);
	QS_destroyer_heliLaunch_timeout = diag_tickTime + 30;
	addMissionEventHandler [
		'EachFrame',
		{
			_interval = 0 max ((linearConversion [QS_destroyer_heli_t1, QS_destroyer_heli_t2, diag_tickTime, 0, 1,TRUE]) * (1 - diag_deltaTime)) min 1;
			QS_destroyer_heli setVelocityTransformation [
				QS_destroyer_heliLaunch_startPos,
				QS_destroyer_heliLaunch_endPos,
				[0,0,0],
				[0,0,0],
				(vectorDir QS_destroyer_heli),
				(vectorDir QS_destroyer_heli),
				[0,0,1],
				[0,0,1],
				_interval
			];
			if ((QS_destroyer_hangarDoorPart animationPhase 'Door_Hangar_1_1_open') isNotEqualTo 1) then {
				[QS_destroyer_hangarDoorPart,1,TRUE] spawn (missionNamespace getVariable 'BIS_fnc_destroyer01AnimateHangarDoors');
			};
			if (dynamicSimulationEnabled QS_destroyer_heli) then {
				QS_destroyer_heli enableDynamicSimulation FALSE;
			};
			if (!simulationEnabled QS_destroyer_heli) then {
				QS_destroyer_heli enableSimulation TRUE;
			};
			if (
				(_interval >= 0.99) ||
				{(!alive QS_destroyer_heli)} ||
				{(diag_tickTime > QS_destroyer_heliLaunch_timeout)}
			) then {
				if (QS_destroyer_heliLaunch_startPos isEqualTo QS_destroyerHeli_worldPos2) then {
					QS_destroyerObject setVariable ['QS_destroyer_hangarHeli',objNull,TRUE];
					QS_destroyer_heli allowDamage TRUE;
					['lock',QS_destroyer_heli,0] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
				} else {
					QS_destroyerObject setVariable ['QS_destroyer_hangarHeli',QS_destroyer_heli,TRUE];
					QS_destroyer_heli allowDamage FALSE;
					['lock',QS_destroyer_heli,2] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
					if (!unitIsUav QS_destroyer_heli) then {
						{
							_x moveOut QS_destroyer_heli;
						} forEach (crew QS_destroyer_heli);
					};
					[QS_destroyer_heli,16] spawn {
						params ['_vehicle','_rt'];
						_array = ['repair'];
						if (_rt > 5) then {
							_array pushBack 'rearm';
						};
						if (_rt > 15) then {
							_array pushBack 'refuel';
						};
						_position = getPosASL _vehicle;
						{
							playSound3D [
								(format ['A3\Sounds_F\sfx\ui\vehicles\vehicle_%1.wss',_x]),
								_vehicle,
								FALSE,
								_position,
								2,
								1,
								25
							];
							uiSleep 5;
						} forEach _array;
						_vehicle setDamage 0;
						_vehicle setFuel 1;
						_vehicle setVehicleAmmo 1;
					};
				};
				QS_destroyer_heli enableDynamicSimulation TRUE;
				missionNamespace setVariable ['QS_destroyer_heliLaunch',FALSE,TRUE];
				removeMissionEventHandler [_thisEvent,_thisEventHandler];
			};
		}
	];
};
playSound 'Click';
if (diag_tickTime < (missionNamespace getVariable ['QS_destroyerHeli_launchCooldown',-1])) exitWith {
	50 cutText [localize 'STR_QS_Text_000','PLAIN DOWN',0.5];
};
missionNamespace setVariable ['QS_destroyerHeli_launchCooldown',diag_tickTime + 1,FALSE];
if (missionNamespace getVariable ['QS_destroyer_heliLaunch',FALSE]) exitWith {
	50 cutText [localize 'STR_QS_Text_000','PLAIN DOWN',0.5];
};
if ((QS_destroyer_hangarDoorPart animationPhase 'Door_Hangar_1_1_open') isNotEqualTo 1) exitWith {
	50 cutText [localize 'STR_QS_Text_102','PLAIN DOWN',0.5];
};
private _enabled = !isNull (QS_destroyerObject getVariable ['QS_destroyer_hangarHeli',objNull]);
if (!_enabled) then {
	private _list = [];
	_helipadPos = QS_destroyerObject modelToWorldWorld [0.267822,78.0273,8.81878];
	_list = nearestObjects [ASLToAGL _helipadPos,['Air'],15,TRUE];
	/*/
	_list = ((ASLToAGL _helipadPos) nearEntities [
		(['destroyer_helilaunch_1'] call QS_data_listVehicles),
		10
	]) select {alive _x && simulationEnabled _x};
	/*/
	_enabled = _list isNotEqualTo [];
};
if (_enabled) exitWith {
	[97,clientOwner] remoteExec ['QS_fnc_remoteExec',2,FALSE];
};
50 cutText [localize 'STR_QS_Text_103','PLAIN DOWN',0.5];