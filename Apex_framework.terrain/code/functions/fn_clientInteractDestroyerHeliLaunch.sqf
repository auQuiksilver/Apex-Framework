/*
File: fn_clientInteractDestroyerHeliLaunch.sqf
Author: 

	Quiksilver

Last Modified:

	6/06/2022 A3 2.10 by Quiksilver

Description:

	-
______________________________________________________*/

if (isDedicated) exitWith {
	params [''];
	if (missionNamespace getVariable ['QS_destroyer_heliLaunch',FALSE]) exitWith {};
	missionNamespace setVariable ['QS_destroyer_heliLaunch',TRUE,TRUE];
	private _launch = FALSE;
	if (isNull (QS_destroyerObject getVariable ['QS_destroyer_hangarHeli',objNull])) then {
		private _list = [];
		_helipadPos = QS_destroyerObject modelToWorldWorld [0.267822,78.0273,8.81878];
		_list = ((ASLToAGL _helipadPos) nearEntities [
			[
				'Heli_Transport_01_base_F',
				'Heli_Light_01_base_F',
				'Heli_Attack_01_base_F',
				'Heli_light_03_base_F',
				'Heli_Light_02_base_F'
			],
			10
		]) select {alive _x && simulationEnabled _x};
		if (_list isEqualTo []) exitWith {};
		QS_destroyer_heli = _list # 0;
		QS_destroyer_heli allowDamage FALSE;
	} else {
		_launch = TRUE;
		QS_destroyer_heli = QS_destroyerObject getVariable ['QS_destroyer_hangarHeli',objNull];
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
			moveOut _x;
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
	QS_destroyerHeli_worldPos1 = QS_destroyerObject modelToWorldWorld [0.267822,78.0225,8.81596];
	QS_destroyerHeli_worldPos2 = QS_destroyerObject modelToWorldWorld [0.074707,42.9854,8.81596];	
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
			if (
				(_interval >= 0.99) ||
				{(!alive QS_destroyer_heli)} ||
				{(diag_tickTime > QS_destroyer_heliLaunch_timeout)}
			) then {
				if (QS_destroyer_heliLaunch_startPos isEqualTo QS_destroyerHeli_worldPos2) then {
					QS_destroyerObject setVariable ['QS_destroyer_hangarHeli',objNull,TRUE];
					QS_destroyer_heli allowDamage TRUE;
					QS_destroyer_heli lock 0;
				} else {
					QS_destroyerObject setVariable ['QS_destroyer_hangarHeli',QS_destroyer_heli,TRUE];
					QS_destroyer_heli allowDamage FALSE;
					QS_destroyer_heli lock 2;
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
				missionNamespace setVariable ['QS_destroyer_heliLaunch',FALSE,TRUE];
				removeMissionEventHandler [_thisEvent,_thisEventHandler];
			};
		}
	];
};
playSound 'Click';
if (diag_tickTime < (missionNamespace getVariable ['QS_destroyerHeli_launchCooldown',-1])) exitWith {
	50 cutText ['Busy','PLAIN DOWN',0.5];
};
missionNamespace setVariable ['QS_destroyerHeli_launchCooldown',diag_tickTime + 1,FALSE];
if (missionNamespace getVariable ['QS_destroyer_heliLaunch',FALSE]) exitWith {
	50 cutText ['Busy','PLAIN DOWN',0.5];
};
if ((QS_destroyer_hangarDoorPart animationPhase 'Door_Hangar_1_1_open') isNotEqualTo 1) exitWith {
	50 cutText ['Obstruction detected','PLAIN DOWN',0.5];
};
private _enabled = !isNull (QS_destroyerObject getVariable ['QS_destroyer_hangarHeli',objNull]);
if (!_enabled) then {
	private _list = [];
	_helipadPos = QS_destroyerObject modelToWorldWorld [0.267822,78.0273,8.81878];
	_list = ((ASLToAGL _helipadPos) nearEntities [
		[
			'Heli_Transport_01_base_F',
			'Heli_Light_01_base_F',
			'Heli_Attack_01_base_F',
			'Heli_light_03_base_F',
			'Heli_Light_02_base_F'
		],
		10
	]) select {alive _x && simulationEnabled _x};
	_enabled = _list isNotEqualTo [];
};
if (_enabled) exitWith {
	[97] remoteExec ['QS_fnc_remoteExec',2,FALSE];
};
50 cutText ['No suitable helicopter found','PLAIN DOWN',0.5];