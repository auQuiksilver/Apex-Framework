/*/
File: fn_gpsJammer.sqf
Author:

	Quiksilver

Last Modified:

	7/04/2018 A3 1.82 by Quiksilver
	
Description:

	GPS Jammer
	
	[0,cameraOn] call QS_fnc_gpsJammer;
	[1,'QS_jammer_1',QS_aoPos,QS_aoPos,300] call QS_fnc_gpsJammer;
	[2,'QS_jammer_1'] call QS_fnc_gpsJammer;
_____________________________________________________/*/

_type = _this # 0;
if (_type isEqualTo 0) exitWith {
	params ['','_entity'];
	private _return = FALSE;
	_gpsJammers = missionNamespace getVariable ['QS_mission_gpsJammers',[]];
	if (_gpsJammers isNotEqualTo []) then {
		if ((_gpsJammers findIf {((_entity distance2D (_x # 2)) <= (_x # 3))}) isNotEqualTo -1) then {
			_return = TRUE;
		};
	};
	_return;
};
if (_type isEqualTo 1) exitWith {
	params ['','_id','_spawnPosition','_effectPosition','_radius',['_createTask',TRUE],['_drawBlackCircle',TRUE]];
	if (missionNamespace isNil 'QS_mission_gpsJammers') then {
		missionNamespace setVariable ['QS_mission_gpsJammers',[],TRUE];
	};
	private _jammer = objNull;
	if (((missionNamespace getVariable ['QS_mission_gpsJammers',[]]) findIf {((_x # 0) isEqualTo _id)}) isEqualTo -1) then {
		_jammerType = 'O_Truck_03_repair_F';
		_jammer = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _jammerType,_jammerType],[-500,-500,0],[],30,'NONE'];
		_jammer allowDamage FALSE;
		_jammer spawn {uiSleep 3;_this allowDamage TRUE;};
		_jammer setDir (random 360);
		_jammer setVehiclePosition [_spawnPosition,[],30,'NONE'];
		clearWeaponCargoGlobal _jammer;
		clearMagazineCargoGlobal _jammer;
		clearItemCargoGlobal _jammer;
		clearBackpackCargoGlobal _jammer;
		[_jammer,TRUE] remoteExec ['lockInventory',0,FALSE];
		_jammer enableVehicleCargo FALSE;
		_jammer enableRopeAttach FALSE;
		_jammer setRepairCargo 0;
		_jammer setAmmoCargo 0;
		_jammer setFuelCargo 0;
		_jammer lock 2;
		_jammer enableDynamicSimulation FALSE;
		{
			_jammer setVariable _x;
		} forEach [
			['QS_inventory_disabled',TRUE,TRUE],
			['QS_curator_disableEditability',TRUE,FALSE],
			['QS_client_canAttachExp',TRUE,TRUE],
			['QS_dynSim_ignore',TRUE,TRUE],
			['QS_cleanup_protected',TRUE,TRUE],
			['QS_inventory_disabled',TRUE,TRUE]
		];
		_jammer enableSimulation TRUE;
		private _assocObjects = [];
		private _pole = objNull;
		{
			_pole = createSimpleObject [(_x # 0),[-100,-100,0]];
			[1,_pole,[_jammer,(_x # 1)]] call QS_fnc_eventAttach;
			//_pole setDir (_x # 2);
			_assocObjects pushBack _pole;
		} forEach [
			['a3\props_f_enoch\military\equipment\omnidirectionalantenna_01_f.p3d',[0.5,-0.66,2.7],0],
			['a3\props_f_enoch\military\equipment\omnidirectionalantenna_01_f.p3d',[-0.5,-3.04,2.7],0]
		];
		_jammer setVelocity [0,0,0];
		{
			_jammer addEventHandler _x;
		} forEach [
			[
				'Killed',
				{
					params ['_killed','_killer','_instigator',''];
					if ((attachedObjects _killed) isNotEqualTo []) then {
						{
							[0,_x] call QS_fnc_eventAttach;
							deleteVehicle _x;
						} forEach (attachedObjects _killed);
					};
					if (!isNull _instigator) then {
						if (isPlayer _instigator) then {
							_text = format ['%1 ( %2 ) %3',(name _instigator),(groupID (group _instigator)),localize 'STR_QS_Chat_049'];
							[[WEST,'BLU'],_text] remoteExec ['sideChat',-2,FALSE];
						} else {
							[[WEST,'BLU'],localize 'STR_QS_Chat_050'] remoteExec ['sideChat',-2,FALSE];
						};
					} else {
						[[WEST,'BLU'],localize 'STR_QS_Chat_050'] remoteExec ['sideChat',-2,FALSE];
					};
					_gpsJammers = missionNamespace getVariable ['QS_mission_gpsJammers',[]];
					if (_gpsJammers isNotEqualTo []) then {
						_jammerIndex = _gpsJammers findIf {((_x # 4) isEqualTo _killed)};
						if (_jammerIndex isNotEqualTo -1) then {
							[((_gpsJammers # _jammerIndex) # 0)] call (missionNamespace getVariable 'BIS_fnc_deleteTask');
							[2,((_gpsJammers # _jammerIndex) # 0)] call (missionNamespace getVariable 'QS_fnc_gpsJammer');
						};
					};
				}
			],
			[
				'Deleted',
				{
					params ['_entity'];
					if ((attachedObjects _entity) isNotEqualTo []) then {
						{
							[0,_x] call QS_fnc_eventAttach;
							deleteVehicle _x;
						} forEach (attachedObjects _entity);
					};
					if (alive _entity) then {
						_gpsJammers = missionNamespace getVariable ['QS_mission_gpsJammers',[]];
						if (_gpsJammers isNotEqualTo []) then {
							_jammerIndex = _gpsJammers findIf {((_x # 4) isEqualTo _entity)};
							if (_jammerIndex isNotEqualTo -1) then {
								[((_gpsJammers # _jammerIndex) # 0)] call (missionNamespace getVariable 'BIS_fnc_deleteTask');
								[2,((_gpsJammers # _jammerIndex) # 0)] call (missionNamespace getVariable 'QS_fnc_gpsJammer');
							};
						};
						_entity setDamage [1,FALSE];
					};
				}
			],
			[
				'HandleDamage',
				{
					params ['_vehicle','','_damage','','','_hitPartIndex','',''];
					_oldDamage = if (_hitPartIndex isEqualTo -1) then {(damage _vehicle)} else {(_vehicle getHitIndex _hitPartIndex)};
					_damage = _oldDamage + (_damage - _oldDamage) * 0.25;
					_damage;
				}
			],
			[
				'IncomingMissile',
				{
					params ['_vehicle','_ammo','_shooter','_instigator','_projectile'];
					if (!isNull _instigator) then {
						['setMissileTarget',_projectile,objNull] remoteExec ['QS_fnc_remoteExecCmd',_instigator,FALSE];
					};
				}
			]
		];
		if (_createTask) then {
			[
				_id,
				TRUE,
				[
					localize 'STR_QS_Task_030',
					localize 'STR_QS_Task_031',
					localize 'STR_QS_Task_031'
				],
				(_spawnPosition getPos [150 * (sqrt (random 1)),random 360]),
				'CREATED',
				5,
				FALSE,
				TRUE,
				'Destroy',
				TRUE
			] call (missionNamespace getVariable 'BIS_fnc_setTask');
		};
		(missionNamespace getVariable ['QS_mission_gpsJammers',[]]) pushBack [_id,_spawnPosition,_effectPosition,_radius,_jammer,_assocObjects,_drawBlackCircle];
		missionNamespace setVariable ['QS_mission_gpsJammers',(missionNamespace getVariable ['QS_mission_gpsJammers',[]]),TRUE];
	};
	_jammer;
};
if (_type isEqualTo 2) exitWith {
	params ['','_id'];
	_gpsJammers = missionNamespace getVariable ['QS_mission_gpsJammers',[]];
	if (_gpsJammers isNotEqualTo []) then {
		_jammerIndex = _gpsJammers findIf {((_x # 0) isEqualTo _id)};
		if (_jammerIndex isNotEqualTo -1) then {
			[_id] call (missionNamespace getVariable 'BIS_fnc_deleteTask');
			(_gpsJammers # _jammerIndex) params ['','','','',['_jammerObject',objNull],['_assocObjects',[]]];
			if (!isNull _jammerObject) then {
				_jammerObject setDamage [1,FALSE];
				(missionNamespace getVariable 'QS_garbageCollector') pushBack [_jammerObject,'NOW_DISCREET',0];
			};
			if (_assocObjects isNotEqualTo []) then {
				deleteVehicle _assocObjects;
			};
			(missionNamespace getVariable ['QS_mission_gpsJammers',[]]) set [_jammerIndex,FALSE];
			(missionNamespace getVariable ['QS_mission_gpsJammers',[]]) deleteAt _jammerIndex;
			missionNamespace setVariable ['QS_mission_gpsJammers',(missionNamespace getVariable ['QS_mission_gpsJammers',[]]),TRUE];
		};
	};
};
if (_type isEqualTo 3) exitWith {
	params ['','_entity','_signalStrength'];
	private _return = -1;
	_gpsJammers = missionNamespace getVariable ['QS_mission_gpsJammers',[]];
	if (_gpsJammers isNotEqualTo []) then {
		_jammerIndex = _gpsJammers findIf {((_entity distance2D (_x # 2)) <= (_x # 3))};
		if (_jammerIndex isNotEqualTo -1) then {
			(_gpsJammers # _jammerIndex) params ['','_spawnPosition','','_radius'];
			_return = _entity distance2D _spawnPosition;
			if (_signalStrength) then {
				//if ('MinimapDisplay' in ((infoPanel 'left') + (infoPanel 'right'))) then {
					//[1,_spawnPosition,_radius,TRUE] call (missionNamespace getVariable 'QS_fnc_signalStrength');			// Temporarily disabled till better solution is found
				//};
			};
		};
	};
	_return;
};
FALSE;