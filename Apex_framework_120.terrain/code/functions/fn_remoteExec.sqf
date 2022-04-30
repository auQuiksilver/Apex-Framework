/*/
File: fn_remoteExec.sqf
Author:

	Quiksilver
	
Last modified:

	31/10/2018 A3 1.84 by Quiksilver
	
Description:

	Scripted Remote Executions
__________________________________________________/*/

_case = _this # 0;
_isRx = isRemoteExecuted;
_isRxJ = isRemoteExecutedJIP;
_rxID = remoteExecutedOwner;
if (_case < 10) exitWith {
	if (_case isEqualTo -1) then {

	};
	/*/ init player server/*/
	if (_case isEqualTo 0) then {
		if (isDedicated) then {
			_this params [
				'',
				'_client',
				'_didJIP',
				'_clientOwner',
				'_puid'
			];
			if (_client isEqualType objNull) then {
				if (isPlayer _client) then {
					if (_didJIP isEqualType TRUE) then {
						[_client,_didJIP,_clientOwner,_puid] spawn (missionNamespace getVariable 'QS_fnc_initPlayerServer');
					};
				};
			};
		};
	};
	/*/===== HC/*/
	if (_case isEqualTo 0.5) then {
		/*/[0.5,'AO_INIT'] remoteExec ['QS_fnc_remoteExec',-999];/*/
		_instruction = _this # 1;
		if (_instruction isEqualTo 'AO_INIT') then {
		
		};
		if (_instruction isEqualTo 'AO_EXIT') then {
		
		};
		if (_instruction isEqualTo 'SM_INIT') then {
		
		};
		if (_instruction isEqualTo 'SM_EXIT') then {
		
		};
	};
	/*/===== Task Update/*/
	if (_case isEqualTo 0.6) then {
		params ['',''];
	
	};
	/*/pow/*/
	if (_case isEqualTo 1) then {
		private _POW = _this # 1;
		if (!(_POW isEqualType objNull)) exitWith {};
		_POW setCaptive FALSE;
		if (local _POW) then {
			{
				if (isServer) then {
					missionNamespace setVariable [
						'QS_analytics_entities_deleted',
						((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),
						FALSE
					];
				};
				deleteVehicle _x;
			} count (attachedObjects _POW);
			_POW playAction 'Default';
			['switchMove',_POW,''] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
		};
		_POW disableAI 'MOVE';
		_POW disableAI 'FSM';
		_POW disableAI 'TEAMSWITCH';
		_POW disableAI 'PATH';
		for '_x' from 0 to 1 step 1 do {
			_POW setVariable ['QS_RD_escortable',TRUE,TRUE];
			_POW setVariable ['QS_RD_loadable',TRUE,TRUE];
		};
	};
	/*/pow/*/
	if (_case isEqualTo 2) then {
		params ['','_unit'];
		if (local _unit) then {
			unassignVehicle _unit;
			_unit disableAI 'PATH';
			_unit disableAI 'MOVE';
			_unit disableAI 'FSM';
			_unit disableAI 'TEAMSWITCH';
		};
	};
	/*/Load unit into vehicle/*/
	if (_case isEqualTo 3) then {
		private ['_obj','_v'];
		_obj = _this # 1;
		_v = _this # 2;
		[_obj,_v] call (missionNamespace getVariable 'QS_fnc_moveInCargoMedical');
		if (!isPlayer _obj) then {
			if ((lifeState _obj) in ['HEALTHY','INJURED']) then {
				_obj allowFleeing 0;
				_obj disableAI 'FSM';
				_obj disableAI 'MOVE';
				_obj disableAI 'TEAMSWITCH';
				_obj disableAI 'PATH';
			};
		};
	};
	/*/turret safety system/*/
	if (_case isEqualTo 4) then {
		private ['_v','_arr','_validVTypes_1','_validTurretTypes','_turretType'];
		_v = _this # 1;
		if (local _v) then {
			_arr = _this # 2;
			_validVTypes_1 = ['B_Heli_Transport_01_camo_F','B_Heli_Transport_01_F','B_Heli_Transport_03_F'];
			_turretType = _arr # 0;
			if ((typeOf _v) in _validVTypes_1) then {
				_validTurretTypes = ['LMG_Minigun_Transport','LMG_Minigun_Transport2'];
				if (_turretType in _validTurretTypes) then {
					_v addWeaponTurret _arr;
				};
			};
		};
	};
	/*/ turret safety system/*/
	if (_case isEqualTo 5) then {
		private ['_v','_arr','_validVTypes_1','_validTurretTypes','_turretType'];
		_v = _this # 1;
		if (local _v) then {
			_arr = _this # 2;
			_validVTypes_1 = ['B_Heli_Transport_01_camo_F','B_Heli_Transport_01_F','B_Heli_Transport_03_F'];
			_turretType = _arr # 0;
			if ((typeOf _v) in _validVTypes_1) then {
				_validTurretTypes = ['LMG_Minigun_Transport','LMG_Minigun_Transport2'];
				if (_turretType in _validTurretTypes) then {
					_v removeWeaponTurret _arr;
				};
			};
		};
	};
	/*/drag/*/
	if (_case isEqualTo 6) then {
		private ['_t'];
		_t = _this # 1;
		_dir = _this # 2;
		_anim = _this # 3;
		if (local _t) then {
			_t setDir _dir;
			['switchMove',_t,_anim] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
		};
	};
	/*/ carry/*/
	if (_case isEqualTo 7) then {
		private _t = _this # 1;
		_dir = _this # 2;
		_anim = _this # 3;
		if (local _t) then {
			if (isPlayer _t) then {
				0 spawn {
					player setVariable ['QS_animDone',FALSE,FALSE];
					player setVariable ['QS_RD_interacting',TRUE,TRUE];
					uiSleep 7;
					player setVariable ['QS_animDone',FALSE,FALSE];
					uiSleep 7;
					player setVariable ['QS_animDone',TRUE,FALSE];
					player setVariable ['QS_RD_interacting',FALSE,TRUE];
				};
			};
			_t setDir _dir;
			['switchMove',_t,_anim] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
		};
	};
	/*/carry 2/*/
	if (_case isEqualTo 7.1) then {
		private ['_t'];
		_t = _this # 1;
		_dir = _this # 2;
		if (local _t) then {
			_t setDir _dir;
		};
	};
	/*/carry 3/*/
	if (_case isEqualTo 7.2) then {
		_t = _this # 1;
		_anim = _this # 2;
		_t2 = _this # 3;
		_anim2 = _this # 4;
		if ((currentWeapon _t2) isEqualTo '') then {
			_t2 switchMove 'amovpercmstpsraswrfldnon';
			uiSleep 0.1;
			_t2 switchMove _anim2;
			_t switchMove _anim;
		} else {
			_t2 switchMove _anim2;
			_t switchMove _anim;
		};
		if (local _t) then {
			[_t,_anim] call (missionNamespace getVariable 'QS_fnc_clientEventAnimChanged');
		};
		if (local _t2) then {
			[_t2,_anim2] call (missionNamespace getVariable 'QS_fnc_clientEventAnimChanged');
		};
	};
	/*/release carry/*/
	if (_case isEqualTo 8) then {
		private _t = _this # 1;
		_dir = _this # 2;
		_anim = _this # 3;
		_t switchMove _anim;
		if (local _t) then {
			_t setDir _dir;
		};
	};
	/*/ release drag/*/
	if (_case isEqualTo 9) then {
		private ['_t'];
		_t = _this # 1;
		_anim1 = _this # 2;
		_anim2 = _this # 3;
		if (local _t) then {
			0 = [] spawn {
				player setVariable ['QS_RD_interacting',TRUE,TRUE];
				uiSleep 8;
				player setVariable ['QS_RD_interacting',FALSE,TRUE];
			};
			_t playMoveNow _anim1;
			uiSleep 1;
			if (isPlayer _t) then {
				['switchMove',_t,'acts_injuredlyingrifle02'] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
				_t setDir ((getDir player) + 180);
			} else {
				_t playMoveNow _anim2;
			};
		};
	};
};
if (_case < 20) exitWith {
	if (_case isEqualTo 10) then {
		private ['_t'];
		_t = _this # 1;
		_dir = _this # 2;
		if (local _t) then {
			_t setDir _dir;
		};
	};
	/*/ Add remote units to curator (used for UAV operator currently)/*/
	if (_case isEqualTo 11) exitWith {
		if (isServer) then {
			private ['_crew'];
			_crew = _this # 1;
		};
	};
	/*/ Unload incapacitated from vehicle/*/
	if (_case isEqualTo 12) exitWith {
		private ['_unit','_anim'];
		_unit = _this # 1;
		/*/_anim = _this # 2;/*/
		if (isMultiplayer) then {
			['switchMove',_unit,'AinjPpneMstpSnonWnonDnon'] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
		} else {
			if (isServer) then {
				_unit switchMove 'AinjPpneMstpSnonWnonDnon';
			};
		};
	};
	/*/ Add score/*/
	if (_case isEqualTo 13) exitWith {
		private ['_healer'];
		_healer = _this # 1;
		_side = _this # 2;
		_scoreToAdd = _this # 3;
		_healer addScore _scoreToAdd;
		_side addScoreSide -(_scoreToAdd);
	};
	/*/ Distribute tunes/*/
	if (_case isEqualTo 14) exitWith {
		if (isDedicated) exitWith {};
		if (!hasInterface) exitWith {};
		if (isNull (objectParent player)) exitWith {};
		if (isEngineOn (vehicle player)) then {
			_QS_track = _this # 1;
			_QS_volume = _this # 2;
			_QS_pause = _this # 3;
			_QS_duration = _this # 4;
			_QS_musicVolume = musicVolume;
			3 fadeMusic 0;
			uiSleep 2;
			playMusic [_QS_track,_QS_pause];
			2 fadeMusic (_QS_musicVolume + ((random 0.2) - (random 0.4)));
		};
	};
	/*/ Role Request/*/
	if (_case isEqualTo 15) exitWith {
		params ['','_uid','_side','_role','_unit','_clientOwner'];
		// To Do: Sanity checks
		if (_clientOwner isEqualTo _rxID) then {
			['HANDLE',['HANDLE_REQUEST_ROLE','',_side,_role,_unit]] call (missionNamespace getVariable 'QS_fnc_roles');
		};
	};
	/*/ Role Set/*/
	if (_case isEqualTo 16) exitWith {
		params ['','_role'];
		['INIT_ROLE',_role] call (missionNamespace getVariable ['QS_fnc_roles',{}]);
	};
	/*/ Remote Delete/*/
	if (_case isEqualTo 17) exitWith {
		_object = _this # 1;
		if (isServer) then {
			if (_object isEqualType objNull) then {
				if ((attachedObjects _object) isNotEqualTo []) then {
					{
						missionNamespace setVariable ['QS_analytics_entities_deleted',((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),FALSE];
						detach _x;
						deleteVehicle _x;
					} count (attachedObjects _object);
				};
				missionNamespace setVariable ['QS_analytics_entities_deleted',((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),FALSE];
				deleteVehicle _object;
			} else {
				if (_object isEqualType []) then {
					private _obj = objNull;
					private _attachedObj = objNull;
					{
						_obj = _x;
						if ((attachedObjects _obj) isNotEqualTo []) then {
							{
								missionNamespace setVariable [
									'QS_analytics_entities_deleted',
									((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),
									FALSE
								];
								if (!isNull (attachedTo _x)) then {
									detach _x;
								};
								deleteVehicle _x;
							} count (attachedObjects _obj);
						};
						missionNamespace setVariable [
							'QS_analytics_entities_deleted',
							((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),
							FALSE
						];
						if (!isNull (attachedTo _obj)) then {
							detach _obj;
						};
						deleteVehicle _obj;
					} forEach _object;
				};
			};
		};
	};
	/*/ Server comm menu component/*/
	if (_case isEqualTo 18) exitWith {
		['',(_this # 1)] call (missionNamespace getVariable 'QS_fnc_serverCommMenu');
	};
	/*/Command Recruit/*/
	if (_case isEqualTo 19) exitWith {
		private _unit = _this # 1;
		if (local _unit) then {
			private _unit = _this # 1;
			_recruiter = _this # 2;
			{
				_unit enableAI _x;
			} count [
				'FSM',
				'TEAMSWITCH',
				'AIMINGERROR',
				'SUPPRESSION',
				'TARGET',
				'AUTOTARGET',
				'MOVE'
			];
			_unit disableAI 'COVER';
			_unit disableAI 'AUTOCOMBAT';
			[(units (group _unit)),4] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
			_unit enableStamina TRUE;
			_unit setAnimSpeedCoef 1.1;
			_unit allowDamage TRUE;
			_unit playActionNow 'gestureHi';
			if (isDedicated) then {
				(group _unit) setGroupOwner (owner _recruiter);
				_unit setOwner (owner _recruiter);
			};
		};
	};
};
if (_case < 30) exitWith {
	if (_case isEqualTo 20) then {
		// Unused
	};
	/*/Surrender/*/
	if (_case isEqualTo 21) then {
		private ['_unit'];
		_unit = _this # 1;
		_puid = _this # 2;
		_pname = _this # 3;
		if (local _unit) then {
			_unit setCaptive TRUE;
			if (isPlayer _unit) then {
				/*/ WIP >:o)/*/
			} else {
				_unit disableAI 'PATH';
				_unitDir = getDir _unit;
				_unitPos = getPosWorld _unit;
				/*/_unitType = typeOf _unit;/*/					/*/cant load side enemy agents into vehicle and then get in yourself, and cant switch their side. so we use unarmed friendly-side agent/*/
				_unitType = 'b_soldier_unarmed_f';
				_unitDamage = damage _unit;
				_unitUniform = uniform _unit;
				_unitVest = vest _unit;
				_unitHeadgear = headgear _unit;
				_unitFace = face _unit;
				_name = name _unit;
				private _isPrisoner = _unit getVariable ['QS_unit_isPrisoner',FALSE];
				_agent = createAgent [_unitType,[0,0,0],[],0,'NONE'];
				missionNamespace setVariable [
					'QS_analytics_entities_created',
					((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
					FALSE
				];
				_agent disableAI 'ALL';
				_agent enableAI 'ANIM';
				removeAllWeapons _agent;
				removeGoggles _agent;
				removeHeadgear _agent;
				removeBackpack _agent;
				removeVest _agent;
				_agent setCaptive TRUE;
				{
					_agent unlinkItem _x;
				} count (assignedItems _agent);
				_agent switchMove 'amovpercmstpssurwnondnon';
				[_agent,'amovpercmstpssurwnondnon'] remoteExecCall ['switchMove',0,FALSE];
				_agent setUnitPos 'UP';
				_agent setDir _unitDir;
				[_agent,_unitFace] remoteExec ['setFace',-2,FALSE];
				[_agent,_name] remoteExec ['setName',-2,FALSE];
				_agent forceAddUniform _unitUniform;
				_agent addHeadgear _unitHeadgear;
				if (_unitDamage < 0.89) then {
					_agent setDamage _unitDamage;
				};
				if (_isPrisoner) then {
					0 = [_agent] spawn {
						uiSleep 1; 
						(_this # 0) setObjectTextureGlobal [0,'#(rgb,8,8,3)color(1,0.1,0,1)'];
					};
				};
				{
					_agent setVariable _x;
				} forEach [
					['QS_surrenderable',FALSE,TRUE],
					['QS_isSurrendered',TRUE,TRUE],
					['QS_RD_escortable',TRUE,TRUE],
					['QS_RD_loadable',TRUE,TRUE],
					['QS_captor',[_puid,_pname],TRUE],
					['QS_ST_customDN','Prisoner',TRUE]
				];
				_agent addEventHandler ['Killed',(missionNamespace getVariable 'QS_fnc_eventAgentKilled')];
				[77,'PRISONER',[_agent],TRUE] remoteExec ['QS_fnc_remoteExec',2];
				if (isServer) then {
					missionNamespace setVariable [
						'QS_enemyCaptives',
						((missionNamespace getVariable 'QS_enemyCaptives') + [_agent]),
						FALSE
					];
				} else {
					[55,[_agent]] remoteExec ['QS_fnc_remoteExec',2,FALSE];
				};
				missionNamespace setVariable [
					'QS_analytics_entities_deleted',
					((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),
					FALSE
				];
				deleteVehicle _unit;
				_agent setPosWorld _unitPos;
				if (isDedicated) then {
					[
						[_agent],
						{
							params ['_agent'];
							player reveal [_agent,4];
						}
					] remoteExec ['call',((_agent nearEntities 30) select {(isPlayer _x)}),FALSE];
				};
			};
		};
	};
	if (_case isEqualTo 22) then {
		if (isDedicated) then {
			private _this2 = _this;
			_this2 params [
				'',
				'_args',
				'_string',
				'_type',
				'_executor',
				'_executorUID',
				'_executorProfileName',
				'_executorProfileNameSteam',
				'_executorOwner',
				'_targetLocality'
			];
			_this2 set [2,(str (count _string))];
			diag_log format ['***** DEV CONSOLE ***** %1 *****',_this2];
			if (_isRx) then {
				if (!isNil '_executor') then {
					if (!isNull _executor) then {
						if (isPlayer _executor) then {
							if (_executor isEqualTo ((allPlayers select {((owner _x) isEqualTo _rxID)}) # 0)) then {
								if (!isNil '_executorUID') then {
									if (_executorUID isEqualType '') then {
										if ((count _executorUID) isEqualTo 17) then {
											if (_executorUID in (['DEVELOPER'] call (missionNamespace getVariable 'QS_fnc_whitelist'))) then {
												if (_executorUID isEqualTo (getPlayerUID _executor)) then {
													if (_executorOwner isEqualTo _rxID) then {
														if (_targetLocality isEqualType 0) then {
															diag_log format ['***** DEV CONSOLE ***** Compiling String ***** %1',_string];
															_code = compile _string;	// _code = compile [_string,TRUE];
															if (_code isEqualType {}) then {
																diag_log format ['***** DEV CONSOLE ***** Code %1 executed by %2 ( %3 * %4)',_targetLocality,_executorProfileName,_executorUID,_executorProfileNameSteam];
																if (_targetLocality isEqualTo 2) then {
																	_args call _code;
																} else {
																	[_args,_code] remoteExec ['call',_targetLocality,FALSE];
																};
															};
														};
													};
												};
											};
										};
									};
								};
							};
						};
					};
				};
			};
		};
	};
	/*/ Utility offroad beacons/*/
	if (_case isEqualTo 23) then {
		if (!isDedicated) then {
			_vehicle = _this # 1;
			if (_vehicle isEqualType objNull) then {
				if (!isNull _vehicle) then {
					[_vehicle] spawn (missionNamespace getVariable 'QS_fnc_utilityLights');
				};
			};
		};
	};
	/*/Arty lock turret/*/
	if (_case isEqualTo 24) then {
		[(_this # 1),(_this # 2)] call (missionNamespace getVariable 'QS_fnc_artyLockTurret');
	};
	/*/ Heli turrets/*/
	if (_case isEqualTo 25) then {
		_array = _this # 1;
		_array call (missionNamespace getVariable 'QS_fnc_turret');
	};
	/*/Collision/*/
	if (_case isEqualTo 26) then {
		private ['_towedVehicle','_state'];
		_towedVehicle = _this # 1;
		_state = _this # 2;
		if (_state) then {
			if (!isDedicated) then {
				player enableCollisionWith _towedVehicle;
			};
		} else {
			if (isDedicated) then {
				_towedVehicle addEventHandler [
					'Local',
					{
						params ['_towedVehicle','_isLocal'];
						private ['_center','_vehicle','_position','_posToSet'];
						if (_isLocal) then {
							[26,_towedVehicle,TRUE] remoteExec ['QS_fnc_remoteExec',-2,FALSE];
							_towedVehicle removeEventHandler ['Local',_thisEventHandler];
						};
						if (!isNull (attachedTo _towedVehicle)) then {
							_vehicle = attachedTo _towedVehicle;
							_center = getPosWorld _towedVehicle;
							for '_x' from 0 to 1 step 0 do {
								_position = _center findEmptyPosition [0,40,(typeOf _towedVehicle)];
								if (_position isEqualTo []) then {
									_position = [_center,0,50,(sizeOf (typeOf _towedVehicle)),0,0.5,0] call (missionNamespace getVariable 'QS_fnc_findSafePos');
								};
								if ((lineIntersectsSurfaces [(AGLToASL (_vehicle modelToWorld [0,0,0])),(AGLToASL _position),_vehicle,_towedVehicle,TRUE,1,'GEOM']) isEqualTo []) exitWith {};
							};
							_position set [2,(_center # 2)];
							_posToSet = [(_position # 0),(_position # 1),((_position # 2)+0.35)];
							_towedVehicle allowDamage FALSE;
							[_towedVehicle,_posToSet] spawn {sleep 2;(_this # 0) allowDamage TRUE;(_this # 0) setVectorUp (surfaceNormal (_this # 1));};
							_towedVehicle setPosWorld _posToSet;
							if (!isNull (attachedTo _towedVehicle)) then {
								detach _towedVehicle;
							};
							_towedVehicle setVectorUp (surfaceNormal (getPosWorld _towedVehicle));
							_vehicle setVariable ['QS_ropeAttached',FALSE,TRUE];
						};
						['lock',_towedVehicle,0] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
						_towedVehicle enableRopeAttach TRUE;
						_towedVehicle enableVehicleCargo TRUE;
						_towedVehicle setVariable ['QS_ropeAttached',FALSE,TRUE];
					}
				];
			} else {
				player disableCollisionWith _towedVehicle;
			};
		};
	};
	/*/===== Curator/*/
	if (_case isEqualTo 27) then {
		if (!isServer) exitWith {};
		_client = _this # 1;
		_puid = _this # 2;
		_cid = _this # 3;
		if (_puid in (['CURATOR'] call (missionNamespace getVariable 'QS_fnc_whitelist'))) then {
			[0,_client,_puid,_cid] call (missionNamespace getVariable 'QS_fnc_initCurator');
		};
	};
	/*/===== Curator Points/*/
	if (_case isEqualTo 28) then {
		if (!isServer) exitWith {};
		_module = _this # 1;
		_points = _this # 2;
		_module addCuratorPoints _points;
	};
	/*/===== Radar/*/
	if (_case isEqualTo 29) then {
		if (isServer) exitWith {};
		_side = _this # 1;
		if ((player getVariable ['QS_unit_side',WEST]) isEqualTo _side) then {
			//comment 'Enable';
			player enableAI 'TARGET';
			player enableAI 'AUTOTARGET';
			disableRemoteSensors FALSE;
		} else {
			//comment 'Disable';
			player disableAI 'TARGET';
			player disableAI 'AUTOTARGET';
			disableRemoteSensors TRUE;
		};
	};
};
if (_case < 40) exitWith {
	/*/===== Suppressive Fire/*/
	if (_case isEqualTo 30) then {
		_unit = _this # 1;
		_fireTarget = _this # 2;
		if (local _unit) then {
			_unit doSuppressiveFire (aimPos _fireTarget);
		};
	};
	/*/===== Incoming Missile/*/
	if (_case isEqualTo 31) then {
		if (isDedicated) exitWith {};
		if (!hasInterface) exitWith {};
		(_this # 1) call (missionNamespace getVariable 'QS_fnc_clientVehicleEventIncomingMissile');
	};
	/*/===== Reset vehicle/*/
	if (_case isEqualTo 32) then {
		_v = _this # 1;
		_dir = _this # 2;
		if (!isNull _v) then {
			if (local _v) then {
				_v setVehicleAmmo 1;
				_v setDir _dir;
				if ((fuel _v) < 0.25) then {_v setFuel 1;};
				if (isEngineOn _v) then {_v engineOn FALSE;};
				if (isCollisionLightOn _v) then {_v setCollisionLight FALSE;};
				if (isLightOn _v) then {_v setPilotLight FALSE;};
			};
		};
	};
	/*/===== AFK kick/*/
	if (_case isEqualTo 33) then {
		params ['','_cid','_profileName'];
		if (isDedicated) then {
			if (_rxID isEqualTo _cid) then {
				diag_log format ['***** ADMIN ***** %1 ***** %2 kicked for AFK timeout *****',time,_profileName];
				['systemChat',(format ['Robocop kicked %1 for AFK timeout.',_profileName])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
				([] call (uiNamespace getVariable 'QS_fnc_serverCommandPassword')) serverCommand (format ['#kick %1 AFK timeout',_cid]);
			};
		};
	};
	/*/===== Notification/*/
	if (_case isEqualTo 34) then {
		if (isDedicated) exitWith {};
		if (!hasInterface) exitWith {};
		_args = _this # 1;
		_args call (missionNamespace getVariable 'QS_fnc_showNotification');
	};
	/*/===== Set Velocity/*/
	if (_case isEqualTo 35) then {
		_t = _this # 1;
		if (local _t) then {
			_pushVector = _this # 2;
			_t setVelocity _pushVector;
		};
	};
	/*/===== Set Vector Normal/*/
	if (_case isEqualTo 36) then {
		_t = _this # 1;
		if (local _t) then {
			_t setVectorUp (surfaceNormal (getPosWorld _t));
		};
	};
	/*/===== Set Vector Up/*/
	if (_case isEqualTo 36.5) then {
		_t = _this # 1;
		if (local _t) then {
			if (simulationEnabled _t) then {
				_t setVectorUp [0,0,1];
			};
		};
	};
	/*/===== Create vehicle/*/
	if (_case isEqualTo 37) then {
		if (isDedicated) then {
			_this spawn {
				scriptName 'QS Script Create Vehicle';
				_clientPN = _this # 1;
				_array = _this # 2;
				_direction = _this # 3;
				_position = _this # 4;
				_owner = _this # 5;
				_unit = _this # 6;
				diag_log format ['***** CREATE VEHICLE ***** Server created vehicle for %1 at %2 *****',_clientPN,_position];
				_vehicle = createVehicle _array;
				missionNamespace setVariable [
					'QS_analytics_entities_created',
					((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
					FALSE
				];
				_vehicle setDir _direction;
				_vehicle setPos _position;
				_text = format ['%1 has inflated a(n) %2 at grid %3',_clientPN,(getText (configFile >> 'CfgVehicles' >> (_array # 0) >> 'displayName')),(mapGridPosition _unit)];
				['systemChat',_text] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
				if (surfaceIsWater _position) then {
					_vehicle setPosASL _position;
				} else {
					_vehicle setPosATL _position;
				};
				_vehicle lock 0;
				_vehicle enableSimulationGlobal TRUE;
				if (_vehicle isKindOf 'Ship') then {
					(missionNamespace getVariable 'QS_garbageCollector') pushBack [_vehicle,'DELAYED_DISCREET',(time + 180)];
					[
						[_vehicle],
						{
							params ['_vehicle'];
							_vehicle setVariable ['QS_RD_vehicleRespawnable',TRUE,TRUE];
							if (local _vehicle) then {
								_vehicle setFuel (0.05 + (random 0.1));
							};
							clearItemCargoGlobal _vehicle;
							player setVariable ['QS_client_createdBoat',_vehicle,TRUE];
							_vehicle enableSimulation TRUE;
						}
					] remoteExec ['call',_owner,FALSE];
				};
			};
		};
	};
	/*/===== Weather Sync/*/
	if (_case isEqualTo 38) then {
		if (!isDedicated) then {
			_array = _this # 1;
			[TRUE,_array] call (missionNamespace getVariable 'QS_fnc_clientWeatherSync');
		};
	};
	/*/===== Disable Simulation/*/
	if (_case isEqualTo 39) then {
		if (isDedicated) then {
			_object = _this # 1;
			_state = _this # 2;
			_profileName = _this # 3;
			_puid = _this # 4;
			diag_log format ['***** REMOTE EXECUTION ***** %1 ( %2 ) set simulation of %3 ( %4 ) to %5 *****',_profileName,_puid,_object,(getText (configFile >> 'CfgVehicles' >> (typeOf _object) >> 'displayName')),_state];
			_object enableSimulationGlobal _state;
		};
	};
};
if (_case < 50) exitWith {
	/*/===== Log Event/*/
	if (_case isEqualTo 40) then {
		if (isDedicated) then {
			[nil,(_this # 1)] call (missionNamespace getVariable 'QS_fnc_logEvent');
		};
	};
	/*/===== Session UID Blacklist/*/
	if (_case isEqualTo 41) then {
		if (isDedicated) then {
			_array = _this # 1;
			[nil,_array] call (missionNamespace getVariable 'QS_fnc_atServer');
		};
	};
	/*/===== Session UID Blacklist Adjust/*/
	if (_case isEqualTo 42) then {
		if (isDedicated) then {
			_array = _this # 1;
			[nil,_array] call (missionNamespace getVariable 'QS_fnc_atAdjust');
		};
	};
	if (_case isEqualTo 43) then {
		// Unused
	};
	if (_case isEqualTo 44) then {
		// Unused
	};
	/*/===== Register Leaderboard/*/
	if (_case isEqualTo 45) then {
		// Obsolete
	};
	/*/===== Add Player Score/*/
	if (_case isEqualTo 46) then {
		if (isDedicated) then {
			_array = _this # 1;
			_unit = _array # 0;
			_value = _array # 1;
			_unit addScore _value;
		};
	};
	/*/===== Configure Vehicle Server/*/
	if (_case isEqualTo 47) then {
		if (isDedicated) then {
			_vehicle = _this # 1;
			[_vehicle,TRUE] call (missionNamespace getVariable 'QS_fnc_vSetup');
		};
	};
	/*/===== Sector Scan/*/
	if (_case isEqualTo 48) then {
		if (isDedicated) then {
			_array = _this # 1;
			_array call (missionNamespace getVariable 'QS_fnc_sectorScan');
		};
	};
	/*/===== Curator Sync/*/
	if (_case isEqualTo 49) then {
		if (isDedicated) then {
			_logic = _this # 1;
			[_logic] spawn (missionNamespace getVariable 'QS_fnc_curatorSync');
		};
	};
};
if (_case < 60) exitWith {
	/*/===== Enable FOB/*/
	if (_case isEqualTo 50) then {
		if (isDedicated) then {
			_array = _this # 1;
			_array call (missionNamespace getVariable 'QS_fnc_fobEnable');
		};
	};
	/*/===== Add Revive/*/
	if (_case isEqualTo 51) then {
		if (isDedicated) then {
			_array = _this # 1;
			_puid = _array # 1;
			_pname = _array # 2;
			_val = _array # 3;
			(missionNamespace getVariable 'QS_leaderboards_session_queue') pushBack ['REVIVE',_puid,_pname,_val];
		};
	};
	/*/===== Enable Antihack/*/
	if (_case isEqualTo 52) then {
		// Obsolete
	};
	/*/===== Request Base Cleanup/*/
	if (_case isEqualTo 53) then {
		if (isDedicated) then {
			if (!isNil {missionNamespace getVariable 'QS_staff_requestBaseCleanup_time'}) then {
				if (time > (missionNamespace getVariable 'QS_staff_requestBaseCleanup_time')) then {
					missionNamespace setVariable ['QS_staff_requestBaseCleanup_time',(time + 300),FALSE];
					diag_log format ['%1 (%2) (staff) has initiated base cleanup',((_this # 1) # 0),((_this # 1) # 1)];
					0 = 0 spawn {
						_baseMarker = markerPos 'QS_marker_base_marker';
						{
							if ((_x distance _baseMarker) < 1000) then {
								if (!(_x getVariable ['QS_dead_prop',FALSE])) then {
									missionNamespace setVariable [
										'QS_analytics_entities_deleted',
										((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),
										FALSE
									];
									deleteVehicle _x;
									uiSleep 0.01;
								};
							};
						} count (allDead + (allMissionObjects 'CraterLong') + (allMissionObjects 'WeaponHolder') + (allMissionObjects 'StaticWeapon') + (allMissionObjects '#destructioneffects'));
						{
							_x setDamage 0;
						} count (_baseMarker nearObjects ['All',1000]);
						{
							_x setDamage 0;
						} count (_baseMarker nearObjects ['House',1000]);
						{
							_x setDamage 0;
						} count (_baseMarker nearObjects ['Building',1000]);
						{
							if ((crew _x) isEqualTo []) then {
								_x setDamage 0;
							};
						} count (_baseMarker nearEntities [['LandVehicle','Air','Ship'],1000]);
						{
							if ((damage _x) > 0) then {
								_x setDamage 0;
							};
						} forEach (nearestObjects [_baseMarker,[],300,TRUE]);
					};
				};
			};
		};
	};
	/*/===== Remote Delete Request/*/
	if (_case isEqualTo 54) then {
		if (isDedicated) then {
			0 spawn {
				scriptName 'Remote Delete';
				private _toDelete = [];
				{
					if (!(_x getVariable ['QS_dead_prop',FALSE])) then {
						0 = _toDelete pushBack _x;
					};
				} count allDead;
				{
					if ((_x isKindOf 'LandVehicle') || {(_x isKindOf 'Air')} || {(_x isKindOf 'Ship')} || {(_x isKindOf 'StaticWeapon')} || {(_x isKindOf 'WeaponHolder')} || {(_x isKindOf 'WeaponHolderSimulated')} || {(_x isKindOf 'GroundWeaponHolder')} || {(_x isKindOf 'CraterLong')}) then {
						if ((crew _x) isEqualTo []) then {
							if (isNil {_x getVariable 'QS_cleanup_protected'}) then {
								0 = _toDelete pushBack _x;
							} else {
								if (!(_x getVariable 'QS_cleanup_protected')) then {
									0 = _toDelete pushBack _x;
								};
							};
						};
					};
				} count (allMissionObjects 'All');
				{
					if (!isNull _x) then {
						missionNamespace setVariable [
							'QS_analytics_entities_deleted',
							((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),
							FALSE
						];
						deleteVehicle _x;
					};
					uiSleep 0.025;
				} count _toDelete;
			};
		};
	};
	/*/===== Add Enemy Captive/*/
	if (_case isEqualTo 55) then {
		if (isDedicated) then {
			_array = _this # 1;
			_agent = _array # 0;
			missionNamespace setVariable [
				'QS_enemyCaptives',
				((missionNamespace getVariable 'QS_enemyCaptives') + [_agent]),
				FALSE
			];
		};
	};
	/*/===== Night Vote/*/
	if (_case isEqualTo 56) then {
		if (isDedicated) then {
			_value = _this # 1;
			if (_value isEqualTo 1) then {
				missionNamespace setVariable [
					'QS_voteFor',
					((missionNamespace getVariable 'QS_voteFor') + 1),
					FALSE
				];
			};
			if (_value isEqualTo 2) then {
				missionNamespace setVariable [
					'QS_voteAgainst',
					((missionNamespace getVariable 'QS_voteAgainst') + 1),
					FALSE
				];
			};
		};
	};
	/*/===== UAV spawned/*/
	if (_case isEqualTo 57) then {
		if (isDedicated) then {
			missionNamespace setVariable ['QS_uavCanSpawn',FALSE,FALSE];
			_vehicle = _this # 1;
			if (!isNull _vehicle) then {
				missionNamespace setVariable ['QS_cas_uav',_vehicle,FALSE];
				_vehicle addMPEventHandler [
					'MPKilled',
					{
						if (isDedicated) then {
							(_this # 0) removeAllEventHandlers 'Deleted';
							missionNamespace setVariable ['QS_uavRespawnTimeout',(time + 300),FALSE];
						};
					}
				];
				_vehicle addEventHandler [
					'Deleted',
					{
						if (alive (_this # 0)) then {
							missionNamespace setVariable ['QS_uavRespawnTimeout',(time + 300),FALSE];
						};
					}
				];
			};
		};
	};
	/*/===== Commander Captured/*/
	if (_case isEqualTo 58) then {
		if (isDedicated) then {
			_array = _this # 1;
			_name = _array # 0;
			{
				_x setMarkerColor 'ColorWEST'; 
				_x setMarkerPos (missionNamespace getVariable 'QS_HQpos');
			} forEach [
				'QS_marker_hqMarker',
				'QS_marker_hqCircle'
			];
			[(missionNamespace getVariable 'QS_AO_HQ_flag'),WEST,'',FALSE,objNull,1] call (missionNamespace getVariable 'QS_fnc_setFlag');
			['QS_IA_TASK_AO_2'] call (missionNamespace getVariable 'BIS_fnc_deleteTask');
			['sideChat',[WEST,'HQ'],(format ['Enemy commander captured by %1!',_name])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
		};
	};
	/*/===== Remote Add To Remains Collector/*/
	if (_case isEqualTo 59) then {
		if (isDedicated) then {
			_array = _this # 1;
			_object = _array # 0;
			if (_object isEqualType objNull) then {
				if (!isNull _object) then {
					if (alive _object) then {
						QS_garbageCollector pushBack [_object,'NOW_DISCREET',0];
					};
				};
			};
		};
	};
};
if (_case < 70) exitWith {
	/*/===== Register Prisoner/*/
	if (_case isEqualTo 60) then {
		if (isDedicated) then {
			_array = _this # 1;
			_puid = (_array # 1) # 1;
			_name = (_array # 1) # 2;
			0 = QS_leaderboards_session_queue pushBack (_array # 0);
			0 = QS_leaderboards_session_queue pushBack (_array # 1);
			missionNamespace setVariable [
				'QS_enemiesCaptured_AO',
				((missionNamespace getVariable 'QS_enemiesCaptured_AO') + 1),
				FALSE
			];
			((_array # 2) # 0) addScore ((_array # 2) # 1);
			diag_log format ['***** LEADERBOARD ***** %1 (%2) incarcerated a prisoner *****',_name,_puid];	
		};
	};
	/*/===== Add Ear/*/
	if (_case isEqualTo 61) then {
		if (isDedicated) then {
			params ['_var','_array'];
			_object = _array # 0;
			_puid = _array # 1;
			_pname = _array # 2;
			(missionNamespace getVariable 'QS_leaderboards_session_queue') pushBack ['EARS',_puid,_pname,1];
			_object addScore 1;
		};
	};
	/*/===== Add Gold Tooth/*/
	if (_case isEqualTo 62) then {
		if (isDedicated) then {
			params ['_var','_array'];
			_object = _array # 0;
			_puid = _array # 1;
			_pname = _array # 2;
			(missionNamespace getVariable 'QS_leaderboards_session_queue') pushBack ['TOOTH',_puid,_pname,1];
			_object addScore 10;
		};
	};
	/*/===== P2P Message/*/
	if (_case isEqualTo 63) then {
		if (!isDedicated) then {
			_array = _this # 1;
			_array call (missionNamespace getVariable 'QS_fnc_p2pMessage');
		};
	};
	/*/===== HC Waypoint Add/Remove/*/
	if (_case isEqualTo 64) then {

	};
	/*/===== Toggle Collisions/*/
	if (_case isEqualTo 65) then {
		_obj1 = _this # 1;
		_obj2 = _this # 2;
		_toggle = _this # 3;
		if (_toggle) then {
			comment 'ENABLE collisions';
			_obj1 enableCollisionWith _obj2;
			_obj2 enableCollisionWith _obj1;
		} else {
			comment 'DISABLE collisions';
			_obj1 disableCollisionWith _obj2;
			_obj2 disableCollisionWith _obj1;
		};
	};
	/*/===== Set Ownership/*/
	if (_case isEqualTo 66) then {
		if (isDedicated) then {
			private _objOrGroup = _this # 1;
			private _entity = _this # 2;
			private _newOwner = _this # 3;
			if (_objOrGroup) then {
				if (!isNull _entity) then {
					for '_x' from 0 to 2 step 1 do {
						if ((owner _entity) isEqualTo _newOwner) exitWith {};
						_entity setOwner _newOwner;
						if (canSuspend) then {
							uiSleep 0.1;
						};
					};
				};
			} else {
				if (!isNull _entity) then {
					for '_x' from 0 to 2 step 1 do {
						if ((groupOwner _entity) isEqualTo _newOwner) exitWith {};
						_entity setGroupOwner _newOwner;
						if (canSuspend) then {
							uiSleep 0.1;
						};
					};
				};
			};
		};
	};
	/*/===== Register Marker/*/
	if (_case isEqualTo 67) then {
		if (isDedicated) then {
			_marker = _this # 1;
			_module = _this # 2;
			diag_log format ['***** REPORT ***** Marker added * %1 * %2 * %3 *****',_marker,_module,(name (getAssignedCuratorUnit _module))];
			if (_module in allCurators) then {
				if (!isNull (getAssignedCuratorUnit _module)) then {
					missionNamespace setVariable [
						'QS_markers_whitelistedDynamic',
						((missionNamespace getVariable 'QS_markers_whitelistedDynamic') + [_marker]),
						FALSE
					];
				};
			};
		};
	};
	/*/===== Set Unconscious State/*/
	if (_case isEqualTo 68) then {
		_unit = _this # 1;
		_state = _this # 2;
		_captiveState = _this # 3;
		if (local _unit) then {
			if (_unit isEqualType objNull) then {
				if (_state isEqualType FALSE) then {
					if (_unit isKindOf 'Man') then {
						_unit setUnconscious _state;
						_unit setCaptive _captiveState;
						if (!isPlayer _unit) then {
							['switchMove',_unit,'AmovPpneMstpSnonWnonDnon'] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
						};
					};
				};
			};
		};
	};
	/*/===== Replace Simple Object with Vehicle/*/
	
	if (_case isEqualTo 69) then {
		params ['','_vehicle','','','','_isSimpleObject'];
	
	
		if (_isSimpleObject) then {
			_this call (missionNamespace getVariable 'QS_fnc_replaceWithVehicle');
		} else {
			_vehicle lock 0;
			_vehicle lockInventory FALSE;
			_vehicle enableSimulationGlobal TRUE;
			_vehicle allowDamage TRUE;
		};
	};
};
if (_case < 80) exitWith {
	/*/===== Move Incapacitated Unit From Vehicle/*/
	if (_case isEqualTo 70) then {
		_unit = _this # 1;
		if (local _unit) then {
			_unit spawn {
				_this setVariable ['QS_incapacitated_processMoveOutRequest',TRUE,FALSE];
				_this setUnconscious FALSE;
				uiSleep 0.1;
				moveOut _this;
				unassignVehicle _this;
				uiSleep 0.1;
				_this setUnconscious TRUE;
			};
		};
	};
	/*/===== Toggle Hide Object/*/
	if (_case isEqualTo 71) then {
		if (isDedicated) then {
			_object = _this # 1;
			_toggle = _this # 2;
			_object hideObjectGlobal _toggle;
		};
	};
	/*/===== Add To Analytics (from Client)/*/
	if (_case isEqualTo 72) then {
		_type = _this # 1;
		_valueToAdd = _this # 2;
		if (_type isEqualTo 0) then {
			missionNamespace setVariable [
				'QS_analytics_entities_deleted',
				((missionNamespace getVariable 'QS_analytics_entities_deleted') + _valueToAdd),
				FALSE
			];
		};
		if (_type isEqualTo 1) then {
			missionNamespace setVariable [
				'QS_analytics_entities_created',
				((missionNamespace getVariable 'QS_analytics_entities_created') + _valueToAdd),
				FALSE
			];
		};
	};
	/*/===== Sub Objective SC/*/
	if (_case isEqualTo 73) then {
		_type = _this # 1;
		if (_type isEqualTo 1) then {
			comment 'Datalink';
			missionNamespace setVariable ['QS_virtualSectors_sub_1_active',FALSE,FALSE];
			(missionNamespace getVariable 'QS_virtualSectors_sub_1_obj') hideObjectGlobal TRUE;
			if ((missionNamespace getVariable 'QS_virtualSectors_sub_1_markers') isNotEqualTo []) then {
				{
					_x setMarkerAlpha 0;
				} forEach (missionNamespace getVariable 'QS_virtualSectors_sub_1_markers');
			};
			comment 'Communicate here';
			['QS_virtualSectors_sub_1_task'] call (missionNamespace getVariable 'BIS_fnc_deleteTask');
			['SC_SUB_COMPLETED',['','Datalink secured']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
			if (missionNamespace getVariable ['QS_virtualSectors_active',FALSE]) then {
				private ['_QS_virtualSectors_scoreSides','_scoreEast','_scoreToRemove'];
				_QS_virtualSectors_scoreSides = missionNamespace getVariable ['QS_virtualSectors_scoreSides',[0,0,0,0,0]];
				_scoreEast = _QS_virtualSectors_scoreSides # 0;
				if (_scoreEast > ((missionNamespace getVariable ['QS_virtualSectors_scoreWin',300]) * 0.1)) then {
					_scoreToRemove = (missionNamespace getVariable ['QS_virtualSectors_scoreWin',300]) * (missionNamespace getVariable ['QS_virtualSectors_bonusCoef_subTask',0.05]);
					_QS_virtualSectors_scoreSides set [0,((_QS_virtualSectors_scoreSides # 0) - _scoreToRemove)];
					missionNamespace setVariable ['QS_virtualSectors_scoreSides',_QS_virtualSectors_scoreSides,FALSE];
				};
				
				comment 'disrupt active datalink';
				{
					if ((side _x) in [EAST,RESISTANCE]) then {
						_x setDamage [1,TRUE];
					};
				} count allUnitsUav;
				{
					if (alive _x) then {
						if ((side _x) in [EAST,RESISTANCE]) then {
							if ((crew _x) isNotEqualTo []) then {
								_x setVehicleReceiveRemoteTargets (missionNamespace getVariable ['QS_virtualSectors_sub_1_active',FALSE]);
								_x setVehicleReportRemoteTargets (missionNamespace getVariable ['QS_virtualSectors_sub_1_active',FALSE]);
								_x setVehicleReportOwnPosition (missionNamespace getVariable ['QS_virtualSectors_sub_1_active',FALSE]);
								if (_x isKindOf 'Plane') then {
									_x setVehicleRadar ([2,0] select (missionNamespace getVariable ['QS_virtualSectors_sub_1_active',FALSE]));
								};
							};
						};
					};
				} forEach vehicles;
			};
		};
		if (_type isEqualTo 2) then {
			comment 'Radio tower NA, done in event handlers from composition file';
		};
		if (_type isEqualTo 3) then {
			comment 'Supply depot';
			missionNamespace setVariable ['QS_virtualSectors_sub_3_active',FALSE,FALSE];
			if (missionNamespace getVariable ['QS_virtualSectors_active',FALSE]) then {
				private ['_QS_virtualSectors_scoreSides','_scoreEast','_scoreToRemove'];
				_QS_virtualSectors_scoreSides = missionNamespace getVariable ['QS_virtualSectors_scoreSides',[0,0,0,0,0]];
				_scoreEast = _QS_virtualSectors_scoreSides # 0;
				if (_scoreEast > ((missionNamespace getVariable ['QS_virtualSectors_scoreWin',300]) * 0.1)) then {
					_scoreToRemove = (missionNamespace getVariable ['QS_virtualSectors_scoreWin',300]) * (missionNamespace getVariable ['QS_virtualSectors_bonusCoef_subTask',0.05]);
					_QS_virtualSectors_scoreSides set [0,((_QS_virtualSectors_scoreSides # 0) - _scoreToRemove)];
					missionNamespace setVariable ['QS_virtualSectors_scoreSides',_QS_virtualSectors_scoreSides,FALSE];
				};
			};
			comment 'remove launchers from units in AO';
			private _centroid = missionNamespace getVariable ['QS_aoPos',[0,0,0]];
			if ((missionNamespace getVariable ['QS_mission_aoType','CLASSIC']) isEqualTo 'SC') then {
				_centroid = missionNamespace getVariable ['QS_virtualSectors_centroid',[0,0,0]];
			};
			private _unit = objNull;
			{
				_unit = _x;
				if ((side _unit) in [EAST,RESISTANCE]) then {
					if ((_unit distance2D _centroid) < 1500) then {
						if ((secondaryWeapon _unit) isNotEqualTo '') then {
							if ((random 1) > 0.8) then {
								_unit removeWeapon (secondaryWeapon _unit);
							};
						};
					};
				};
			} forEach allUnits;
			(missionNamespace getVariable 'QS_virtualSectors_sub_3_obj') hideObjectGlobal TRUE;
			if ((missionNamespace getVariable 'QS_virtualSectors_sub_3_markers') isNotEqualTo []) then {
				_marker1 = createMarker ['QS_marker_virtualSectors_sd',[-1000,-1000,0]];
				_marker1 setMarkerAlphaLocal 0;
				_marker1 setMarkerShapeLocal 'ICON';
				_marker1 setMarkerTypeLocal 'mil_dot';
				_marker1 setMarkerColorLocal 'ColorWEST';
				_marker1 setMarkerTextLocal (format ['%1Supply Depot',(toString [32,32,32])]);
				_marker1 setMarkerSizeLocal [0.5,0.5];
				_marker1 setMarkerPosLocal (missionNamespace getVariable ['QS_virtualSectors_sd_position',[-1000,-1000,0]]);
				_marker1 setMarkerAlpha 1;
				(missionNamespace getVariable 'QS_virtualSectors_sd_marker') pushBack _marker1;		
				{
					if ((markerAlpha _x) isNotEqualTo 0) then {
						_x setMarkerAlpha 0;
					};
				} forEach (missionNamespace getVariable 'QS_virtualSectors_sub_3_markers');
			};		
			comment 'Communicate here';
			['QS_virtualSectors_sub_3_task'] call (missionNamespace getVariable 'BIS_fnc_deleteTask');
			['SC_SUB_COMPLETED',['','Supply Depot secured']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
		};
	};
	/*/===== CAS spawner/*/
	if (_case isEqualTo 74) then {
		if (isDedicated) then {
			if (!isNull (missionNamespace getVariable ['QS_fighterPilot',objNull])) then {
				[allPlayers] call (missionNamespace getVariable 'QS_fnc_casRespawn');
			};
		};
	};
	/*/===== Fast Rope/*/
	if (_case isEqualTo 75) then {
		params ['','_params','_functionName','_isCall'];
		if ((toLower _functionName) in [
			'ar_rappel_all_cargo','ar_hint','ar_rappel_from_heli','ar_hide_object_global','ar_client_rappel_from_heli','ar_enable_rappelling_animation','ar_enable_rappelling_animation_client'
		]) then {
			if (_isCall) then {
				_params call (missionNamespace getVariable [_functionName,{}]);
			} else {
				_params spawn (missionNamespace getVariable [_functionName,{}]);
			};
		};
	};
	/*/===== Medical Litter/*/
	if (_case isEqualTo 76) then {
		params ['','_position','_vectorNormal'];
		if (missionNamespace getVariable 'QS_medical_garbage_enabled') then {
			if ((missionNamespace getVariable 'QS_medical_garbage') isEqualTo []) then {
				missionNamespace setVariable ['QS_medical_garbage',(missionNamespace getVariable 'QS_medical_garbage_backup'),TRUE];
			};
			uiSleep 0.01;
			if (!(scriptDone (missionNamespace getVariable 'QS_medical_garbage_script'))) then {
				_time = time + 3;
				waitUntil {
					uiSleep 0.01;
					((scriptDone (missionNamespace getVariable 'QS_medical_garbage_script')) || (time > _time))
				};
			};
			_position set [2,((_position # 2) + (random [0.02,0.0225,0.025]))];
			missionNamespace setVariable [
				'QS_medical_garbage_script',
				([_position,_vectorNormal] spawn {
					params ['_position','_vectorNormal'];
					_garbage = (missionNamespace getVariable 'QS_medical_garbage') deleteAt 0;
					(missionNamespace getVariable 'QS_medical_garbage') pushBack _garbage;
					_garbage setDir (random 360);
					_garbage setVectorUp _vectorNormal;
					_garbage setPosASL _position;
					_garbage enableSimulationGlobal TRUE;
					uiSleep 0.2;
					_garbage enableSimulationGlobal FALSE;
				}),
				FALSE
			];
		};
	};
	/*/===== Player-Created Dynamic Task/*/
	if (_case isEqualTo 77) then {
		if (isDedicated) then {
			_type = _this # 1;
			_params = _this # 2;
			[1,_type,_params,_isRx] call (missionNamespace getVariable 'QS_fnc_dynamicTasks');
		};
	};
	/*/===== Update Custom draw/*/

	if (_case isEqualTo 78) then {
		params ['','_addRemoveSet','_var','_iconID','_iconData'];
		if (_addRemoveSet isEqualTo 0) then {
			//comment 'Remove';
			_iconIndex = (missionNamespace getVariable _var) findIf {((_x # 0) isEqualTo _iconID)};
			if (_iconIndex isNotEqualTo -1) then {
				(missionNamespace getVariable _var) set [_iconIndex,FALSE];
				(missionNamespace getVariable _var) deleteAt _iconIndex;
			};
		};
		if (_addRemoveSet isEqualTo 1) then {
			//comment 'Add';
			(missionNamespace getVariable _var) pushBack _iconData;
		};
		if (_addRemoveSet isEqualTo 2) then {
			//comment 'Update';
			_iconIndex = (missionNamespace getVariable _var) findIf {((_x # 0) isEqualTo _iconID)};
			if (_iconIndex isNotEqualTo -1) then {
				(missionNamespace getVariable _var) set [_iconIndex,_iconData];
			} else {
				(missionNamespace getVariable _var) pushBack _iconData;
			};		
		};
	};

	/*/===== Replace Unit with Agent/*/

	if (_case isEqualTo 79) then {
		params ['','_unit','_side','_isPrisoner'];
		_unitDir = getDir _unit;
		_unitPos = getPosWorld _unit;
		_unitType = typeOf _unit;
		_unitDamage = damage _unit;
		_unitUniform = uniform _unit;
		_unitVest = vest _unit;
		_unitHeadgear = headgear _unit;
		_unitFace = face _unit;
		_agent = createAgent [_unitType,[0,0,0],[],0,'NONE'];
		missionNamespace setVariable [
			'QS_analytics_entities_created',
			((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
			FALSE
		];
		_agent disableAI 'ALL';
		removeAllWeapons _agent;
		removeGoggles _agent;
		removeHeadgear _agent;
		removeBackpack _agent;
		removeVest _agent;
		_agent setCaptive TRUE;
		{
			_agent unlinkItem _x;
		} count (assignedItems _agent);
		{
			_agent removeItem _x;
		} forEach (items _agent);
		['switchMove',_agent,''] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
		_agent setUnitPos 'UP';
		_agent setDir _unitDir;
		_agent setFace _unitFace;
		_agent forceAddUniform _unitUniform;
		_agent addHeadgear _unitHeadgear;
		if (_unitDamage < 0.89) then {
			_agent setDamage [_unitDamage,FALSE];
		};
		if (_isPrisoner) then {
			0 = [_agent] spawn {
				uiSleep 1; 
				(_this # 0) setObjectTextureGlobal [0,'#(rgb,8,8,3)color(1,0.1,0,1)'];
				(_this # 0) enableSimulationGlobal FALSE;
			};
		};
	};
};
if (_case < 90) exitWith {
	if (_case isEqualTo 80) then {
		params ['','_entity','_player','_groupID','_profileName','_clientOwner'];		
		if (!(isObjectHidden _entity)) then {
			if ((_entity getVariable ['QS_entity_intel_copy',[]]) isNotEqualTo []) then {
				{
					if (!(isObjectHidden _x)) then {
						_x hideObjectGlobal TRUE;
					};
				} forEach (_entity getVariable ['QS_entity_intel_copy',[]]);
			};
			if (!(isObjectHidden _entity)) then {
				_entity hideObjectGlobal TRUE;
			};
			_text = format ['%1 (%2) located intel',_profileName,_groupID];
			_text remoteExec ['systemChat',-2];
			if ((_entity getVariable ['QS_intel_marker',-1]) isNotEqualTo -1) then {
				for '_x' from 0 to 1 step 1 do {
					(_entity getVariable 'QS_intel_marker') setMarkerAlpha 1;
				};
			};
		};
	};
	if (_case isEqualTo 81) then {
		params ['','_entity','_player','_groupID','_profileName','_clientOwner'];
		if (!(isObjectHidden _entity)) then {
			_entity hideObjectGlobal TRUE;
			_entity enableSimulationGlobal FALSE;
			_text = format ['%1 (%2) located intel',_profileName,_groupID];
			_text remoteExec ['systemChat',-2];
			[(_entity getVariable ['QS_entity_assocPos',(position _entity)]),_clientOwner] spawn (missionNamespace getVariable 'QS_fnc_aoTaskIDAP');
		};
	};
	if (_case isEqualTo 82) then {
		params ['','_entity','_player','_groupID','_profileName','_clientOwner'];
		if (!(isObjectHidden _entity)) then {
			_entity hideObjectGlobal TRUE;
			_entity enableSimulationGlobal FALSE;
			_text = format ['%1 (%2) located intel',_profileName,_groupID];
			_text remoteExec ['systemChat',-2];
			[(_entity getVariable ['QS_entity_assocPos',(getPosATL _entity)]),_clientOwner] spawn (missionNamespace getVariable 'QS_fnc_aoTaskIG');
		};
	};
	if (_case isEqualTo 83) then {
		params ['','_subType','_entity'];
		if (_subType isEqualTo 0) then {
			{
				_entity removeEventHandler _x;
			} forEach (_entity getVariable ['QS_vehicle_tempEvents',[]]);
			_entity setVariable ['QS_vehicle_tempEvents',nil,FALSE];
		};
		if (_subType isEqualTo 1) then {
			private _tempEvents = [];
			{
				_tempEvents pushBack [(_x # 0),(_entity addEventHandler _x)];
			} forEach [
				[
					'Local',
					{
						params ['_entity'];
						{
							_entity removeEventHandler _x;
						} forEach (_entity getVariable ['QS_vehicle_tempEvents',[]]);
						_carrierAnimData = _entity getVariable ['QS_vehicle_carrierAnimData',[]];
						if (_carrierAnimData isNotEqualTo []) then {
							(_carrierAnimData # 0) animateSource (_carrierAnimData # 1);
							playSound3D ['A3\Sounds_F_Jets\vehicles\air\Shared\FX_Plane_Jet_Flaps_Down.wss',objNull,FALSE,((_carrierAnimData # 0) modelToWorldWorld ((_carrierAnimData # 0) selectionPosition ((_carrierAnimData # 1) # 0))),25,1,75];
						};
					}
				],
				[
					'Gear',
					{
						params ['_entity'];
						{
							_entity removeEventHandler _x;
						} forEach (_entity getVariable ['QS_vehicle_tempEvents',[]]);
						_carrierAnimData = _entity getVariable ['QS_vehicle_carrierAnimData',[]];
						if (_carrierAnimData isNotEqualTo []) then {
							(_carrierAnimData # 0) animateSource (_carrierAnimData # 1);
							playSound3D ['A3\Sounds_F_Jets\vehicles\air\Shared\FX_Plane_Jet_Flaps_Down.wss',objNull,FALSE,((_carrierAnimData # 0) modelToWorldWorld ((_carrierAnimData # 0) selectionPosition ((_carrierAnimData # 1) # 0))),25,1,75];
						};						
					}
				],
				[
					'GetOut',
					{
						params ['_entity'];
						{
							_entity removeEventHandler _x;
						} forEach (_entity getVariable ['QS_vehicle_tempEvents',[]]);	
						_carrierAnimData = _entity getVariable ['QS_vehicle_carrierAnimData',[]];
						if (_carrierAnimData isNotEqualTo []) then {
							(_carrierAnimData # 0) animateSource (_carrierAnimData # 1);
							playSound3D ['A3\Sounds_F_Jets\vehicles\air\Shared\FX_Plane_Jet_Flaps_Down.wss',objNull,FALSE,((_carrierAnimData # 0) modelToWorldWorld ((_carrierAnimData # 0) selectionPosition ((_carrierAnimData # 1) # 0))),25,1,75];
						};						
					}
				],
				[
					'Killed',
					{
						params ['_entity'];
						{
							_entity removeEventHandler _x;
						} forEach (_entity getVariable ['QS_vehicle_tempEvents',[]]);
						_carrierAnimData = _entity getVariable ['QS_vehicle_carrierAnimData',[]];
						if (_carrierAnimData isNotEqualTo []) then {
							(_carrierAnimData # 0) animateSource (_carrierAnimData # 1);
							playSound3D ['A3\Sounds_F_Jets\vehicles\air\Shared\FX_Plane_Jet_Flaps_Down.wss',objNull,FALSE,((_carrierAnimData # 0) modelToWorldWorld ((_carrierAnimData # 0) selectionPosition ((_carrierAnimData # 1) # 0))),25,1,75];
						};						
					}
				],
				[
					'Deleted',
					{
						params ['_entity'];
						{
							_entity removeEventHandler _x;
						} forEach (_entity getVariable ['QS_vehicle_tempEvents',[]]);
						_carrierAnimData = _entity getVariable ['QS_vehicle_carrierAnimData',[]];
						if (_carrierAnimData isNotEqualTo []) then {
							(_carrierAnimData # 0) animateSource (_carrierAnimData # 1);
							playSound3D ['A3\Sounds_F_Jets\vehicles\air\Shared\FX_Plane_Jet_Flaps_Down.wss',objNull,FALSE,((_carrierAnimData # 0) modelToWorldWorld ((_carrierAnimData # 0) selectionPosition ((_carrierAnimData # 1) # 0))),25,1,75];
						};						
					}
				]
			];
			_entity setVariable ['QS_vehicle_tempEvents',_tempEvents,FALSE];
		};
	};
	if (_case isEqualTo 84) then {
		params ['','_entity','_player','_groupID','_profileName','_clientOwner'];	
		if (!(isObjectHidden _entity)) then {
			_entity hideObjectGlobal TRUE;
			_entity enableSimulationGlobal FALSE;
			_text = format ['%1 (%2) located intel',_profileName,_groupID];
			_text remoteExec ['systemChat',-2];
			[(getPosATL _entity)] spawn (missionNamespace getVariable 'QS_fnc_aoTaskKill');
		};
	};
	if (_case isEqualTo 85) then {
		['GRID_IDAP_UPDATE',['Area Of Operations','Objective failed<br/>No civilian casualties']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
		'QS_marker_grid_civState' setMarkerText (format ['%1No civilian casualties (failed)',(toString [32,32,32])]);
		'QS_marker_grid_civState' setMarkerColor 'ColorRED';
	};
	if (_case isEqualTo 86) then {
		_vehicle = _this # 1;
		_vehicle setVariable ['QS_ST_customDN','',TRUE];
		_vehicle addEventHandler [
			'GetOut',
			{
				params ['_vehicle','','_unit',''];
				if (!isNull (attachedTo _vehicle)) then {
					if (alive (attachedTo _vehicle)) then {
						if (((attachedTo _vehicle) emptyPositions 'cargo') > 0) then {
							if (local _unit) then {
								_unit moveInCargo (attachedTo _vehicle);
							} else {
								[[_unit,(attachedTo _vehicle)],{(_this # 0) moveInCargo (_this # 1);}] remoteExec ['call',_unit,FALSE];
							};
						} else {
							_unit setPosASL ((attachedTo _vehicle) modelToWorldWorld ((attachedTo _vehicle) selectionPosition 'pos cargo'));
						};
					};
				};
			}
		];
	};
	if (_case isEqualTo 87) then {
		_vehicle = _this # 1;
		if (local _vehicle) then {
			_vPosition = getPosWorld _vehicle;
			_direction = getDir _vehicle;
			private _success = FALSE;
			private _safePosition = _vPosition findEmptyPosition [0,20,(typeOf _vehicle)];
			if (_safePosition isNotEqualTo []) then {
				_vehicle setPos [(random -1000),(random -1000),(10 + (random -1000))];
				_vehicle setDir _direction;
				_vehicle setVectorUp (surfaceNormal _safePosition);
				_vehicle setVehiclePosition [_safePosition,[],0,'NONE'];
			} else {
				_safePosition = [_vPosition,0,34,(sizeOf (typeOf _vehicle)),0,0.5,0] call (missionNamespace getVariable 'QS_fnc_findSafePos');
				if ((_safePosition distance2D _vPosition) < 35) then {
					_vehicle setPos [(random -1000),(random -1000),(10 + (random -1000))];
					_vehicle setDir _direction;
					_vehicle setVectorUp (surfaceNormal _safePosition);
					_vehicle setVehiclePosition [_safePosition,[],0,'NONE'];
				};
			};
		};
	};
	if (_case isEqualTo 88) then {
		params ['',['_vehicle',objNull]];
		if (!isNull _vehicle) then {
			if (local _vehicle) then {
				_vehicle setRepairCargo 0;
				_vehicle setAmmoCargo 0;
				_vehicle setFuelCargo 0;
			};
		};
	};
	if (_case isEqualTo 89) then {
		params ['','_command','_profileName','_hcSelected'];
		[0,_command,_profileName,_hcSelected] call (missionNamespace getVariable 'QS_fnc_hCommMenu');
	};
};
if (_case < 100) exitWith {
	if (_case isEqualTo 90) then {
		// https://feedback.bistudio.com/T128186
		params ['',['_unit',objNull],['_case',0]];
		if (alive _unit) then {
			_objectParent = objectParent _unit;
			if (alive _objectParent) then {
				if (_case isEqualTo 1) then {
					if (local _unit) then {
						unassignVehicle _unit;
						_unit disableAI 'MOVE';
						_unit disableAI 'FSM';
						_unit disableAI 'PATH';
					};
				};
				if (local _objectParent) then {
					moveOut _unit;
				};
			};
		};
	};
	if (_case isEqualTo 91) then {
		0 spawn {
			sleep 3;
			{
				if (local _x) then {
					deleteVehicle _x;
				};
			} forEach (allMissionObjects 'EmptyDetector');
		};
	};
	// Replace agent with vehicle
	if (_case isEqualTo 92) then {
		params ['','_unit','_side','_isPrisoner'];
		_unitDir = getDir _unit;
		_unitPos = getPosWorld _unit;
		_unitType = typeOf _unit;
		_unitDamage = damage _unit;
		_unitUniform = uniform _unit;
		_unitVest = vest _unit;
		_unitHeadgear = headgear _unit;
		_unitFace = face _unit;
		_agent = createVehicle [_unitType,[0,0,0],[],0,'NONE'];
		_agent disableAI 'ALL';
		deleteVehicle _unit;
		_agent setPosWorld _unitPos;
		removeAllWeapons _agent;
		removeGoggles _agent;
		removeHeadgear _agent;
		removeBackpack _agent;
		removeVest _agent;
		_agent setCaptive TRUE;
		{
			_agent unlinkItem _x;
		} count (assignedItems _agent);
		{
			_agent removeItem _x;
		} forEach (items _agent);
		_agent switchMove 'amovpercmstpsnonwnondnon';
		[_agent,'amovpercmstpsnonwnondnon'] remoteExec ['switchMove',0,FALSE];
		_agent setUnitPos 'UP';
		_agent setDir _unitDir;
		_agent setFace _unitFace;
		_agent forceAddUniform _unitUniform;
		_agent addHeadgear _unitHeadgear;
		if (_unitDamage < 0.89) then {
			_agent setDamage [_unitDamage,FALSE];
		};
		if (_isPrisoner) then {
			0 = [_agent] spawn {
				uiSleep 1; 
				(_this # 0) setObjectTextureGlobal [0,'#(rgb,8,8,3)color(1,0.1,0,1)'];
				(_this # 0) enableSimulationGlobal FALSE;
				(_this # 0) enableDynamicSimulation FALSE;
			};
		};
	};
	if (_case isEqualTo 93) then {
		params ['','_type','_vehicle','_unit','_firedPosition'];
		if ((behaviour (effectiveCommander _vehicle)) isNotEqualTo 'COMBAT') then {
			(group (effectiveCommander _vehicle)) setBehaviour 'COMBAT';
			(crew _vehicle) doWatch _firedPosition;
		};
		if (_type isEqualTo 1) then {
			_grp = group (effectiveCommander _vehicle);
			if (!isNull _grp) then {
				{
					_grp reveal _x;
				} forEach [
					[_unit,4],
					[vehicle _unit,4]
				];
			};
		};
	};
	if (_case isEqualTo 94) then {
		params ['','_rxAPSParams'];
		//if (isDedicated) then {
			_rxAPSParams call (missionNamespace getVariable 'QS_fnc_clientProjectileManager');
		//};
	};
	// Uniform MP fix
	if (_case isEqualTo 95) then {
		if (!isDedicated) then {
			if ((uniform player) isNotEqualTo '') then {
				player forceAddUniform (uniform player);
			};
		};
	};
	// Heli takeover
	if (_case isEqualTo 96) then {
		if (isDedicated) then {
			// SERVER
			params ['','_stage'];
			if (_stage isEqualTo 1) then {
				params ['','','_unit','_vehicle'];
				if (alive _vehicle) then {
					_currentPilot = currentPilot _vehicle;
					if ((local _currentPilot) && {(isNull (_currentPilot getVariable ['BIS_fnc_moduleRemoteControl_owner',objNull]))}) then {
						_currentPilot setVariable ['BIS_fnc_moduleRemoteControl_owner',_unit,TRUE];
						(group _currentPilot) setGroupOwner (owner _unit);
						[96,2,_unit,_vehicle] remoteExec ['QS_fnc_remoteExec',_unit,FALSE];
					};
				};
			};
		} else {
			// CLIENT
			params ['','_stage'];
			if (_stage isEqualTo 0) then {
				params ['','','_isPassenger','_data'];
				_data params ['_vehicle','_name'];
				if (_isPassenger) then {
					// is passenger
					50 cutText [(format ['Attention: Your pilot ( %1 ) has disconnected, an AI pilot is attempting to fly you back to base, please stand by.',_name]),'PLAIN DOWN',2];
					uiSleep 0.5 + (random 1.5);
					if (!(QS_heli_takeover_action in (actionIDs player))) then {
						QS_heli_takeover_action = player addAction [
							'Take controls',
							{
								params ['','','_actionID','_args'];
								_args params ['_vehicle'];
								player removeAction _actionID;
								50 cutText ['Requesting helicopter controls','PLAIN DOWN',0.5];
								if (alive _vehicle) then {
									if (isNull ((currentPilot _vehicle) getVariable ['BIS_fnc_moduleRemoteControl_owner',objNull])) then {
										[96,1,player,_vehicle] remoteExec ['QS_fnc_remoteExec',2,FALSE];
									};
								};
							},
							[_vehicle],
							90,
							TRUE,
							FALSE,
							'',
							'(isNull ((currentPilot (vehicle player)) getVariable ["BIS_fnc_moduleRemoteControl_owner",objNull]))'
						];
						player setUserActionText [QS_heli_takeover_action,((player actionParams QS_heli_takeover_action) # 0),(format ["<t size='3'>%1</t>",((player actionParams QS_heli_takeover_action) # 0)])];
						private _timeout = diag_tickTime + 15;
						waitUntil {
							((diag_tickTime > _timeout) || (!alive _vehicle) || (!isNull ((currentPilot _vehicle) getVariable ['BIS_fnc_moduleRemoteControl_owner',objNull])))
						};
						if (QS_heli_takeover_action in (actionIDs player)) then {
							player removeAction QS_heli_takeover_action;
						};
					};
				} else {
					// is pilot
					_data params ['_vehicle','_name','_crewCount','_mapGridPosition'];
					50 cutText [(format ['Attention: A pilot ( %1 ) has disconnected mid-flight with %2 passengers onboard at %3. An AI pilot is attempting to fly them back to base.',_name,_crewCount,_mapGridPosition]),'PLAIN DOWN',2];
					uiSleep 0.5 + (random 1.5);
					if (!(QS_heli_takeover_action in (actionIDs player))) then {
						QS_heli_takeover_action = player addAction [
							'Take controls',
							{
								params ['','','_actionID','_args'];
								_args params ['_vehicle'];
								player removeAction _actionID;
								50 cutText ['Requesting helicopter controls','PLAIN DOWN',0.5];
								if (alive _vehicle) then {
									if (isNull ((currentPilot _vehicle) getVariable ['BIS_fnc_moduleRemoteControl_owner',objNull])) then {
										[96,1,player,_vehicle] remoteExec ['QS_fnc_remoteExec',2,FALSE];
									};
								};
							},
							[_vehicle],
							90,
							TRUE,
							FALSE,
							'',
							'(isNull (objectParent player))'
						];
						player setUserActionText [QS_heli_takeover_action,((player actionParams QS_heli_takeover_action) # 0),(format ["<t size='3'>%1</t>",((player actionParams QS_heli_takeover_action) # 0)])];
						private _timeout = diag_tickTime + 30;
						waitUntil {
							((diag_tickTime > _timeout) || (!alive _vehicle) || (!isNull ((currentPilot _vehicle) getVariable ['BIS_fnc_moduleRemoteControl_owner',objNull])))
						};
						if (QS_heli_takeover_action in (actionIDs player)) then {
							player removeAction QS_heli_takeover_action;
						};
					};
				};
			};
			if (_stage isEqualTo 2) then {
				params ['','','_unit','_vehicle'];
				uiSleep 0.5;
				_pilot = currentPilot _vehicle;
				50 cutText ['Taking control','PLAIN DOWN',0.5];
				['systemChat',format ['%1 took control of a crashing %2 ( Pilot disconnected )',profileName,getText (configFile >> 'CfgVehicles' >> (typeOf _vehicle) >> 'displayName')]] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
				_pilot addEventHandler [
					'Killed',
					{
						objNull remoteControl (_this # 0);
						player switchCamera 'INTERNAL';
					}
				];
				_pilot addEventHandler [
					'Deleted',
					{
						objNull remoteControl (_this # 0);
						player switchCamera 'INTERNAL';
					}
				];
				_pilot addEventHandler [
					'GetOutMan',
					{
						objNull remoteControl (_this # 0);
						player switchCamera 'INTERNAL';							
						(_this # 0) setDamage 1;
					}
				];
				player remoteControl _pilot;
				_pilot switchCamera 'INTERNAL';
				_pilot setVariable ['BIS_fnc_moduleRemoteControl_owner',player,TRUE];
				private _timeout = diag_tickTime + 600;
				waitUntil {
					(
						(!alive player) || 
						(!alive _pilot) || 
						(!alive _vehicle) || 
						(diag_tickTime > _timeout)
					)
				};
				objNull remoteControl _pilot;
				player switchCamera 'INTERNAL';
				{
					if (local _x) then {
						objNull remoteControl _x;
					};
				} forEach allUnits;
			};
		};
	};
};