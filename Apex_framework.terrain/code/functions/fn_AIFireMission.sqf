/*/
File: fn_AIFireMission.sqf
Author:

	Quiksilver
	
Last modified:

	28/06/2022 A3 2.10 by Quiksilver
	
Description:

	AI Fire Mission
__________________________________________________/*/

params ['_type'];
if (_type isEqualTo 0) exitWith {
	scriptName 'QS AI FIRE MISSION - ARTY';
	//comment 'Artillery';
	params ['','_grpLeader','_firePosition','_fireShells','_fireRounds'];
	_vehicle = vehicle _grpLeader;
	_vehicle setVehicleAmmo 1;
	_grp = group _grpLeader;
	_grp setFormDir ((getPos _grpLeader) getDir _firePosition);
	_sleep_1 = [5,2] select (_vehicle isKindOf 'StaticMortar');
	_sleep_2 = [7,4] select (_vehicle isKindOf 'StaticMortar');
	_nearbyTargetsCount = count ([12,EAST,_firePosition,100] call (missionNamespace getVariable 'QS_fnc_AIGetKnownEnemies'));
	if ((_vehicle isKindOf 'StaticMortar') && (_nearbyTargetsCount > (selectRandom [5,6]))) then {
		_fireRounds = round (_fireRounds * 2);
	};
	private _radius = 90;
	private _firstShell = TRUE;
	_grpLeader doWatch [(_firePosition # 0),(_firePosition # 1),(1000 + (random 1000))];
	uiSleep (3 + (random 5));
	if (_vehicle isKindOf 'StaticMortar') then {
		for '_x' from 0 to (_fireRounds - 1) step 1 do {
			if ((!alive _vehicle) || {(!alive _grpLeader)} || {(isNull (objectParent _grpLeader))}) exitWith {};
			_grpLeader doArtilleryFire [(_firePosition getPos [(_radius * (sqrt (random 1))),(random 360)]),_fireShells,1];
			_radius = _radius * (random [0.7,0.75,1]);
			if (_firstShell) then {
				_firstShell = FALSE;
				uiSleep (_sleep_1 + (random _sleep_1));
			};
			uiSleep (_sleep_2 + (random _sleep_1));
		};
	} else {
		_grpLeader doArtilleryFire [(_firePosition getPos [(15 * (sqrt (random 1))),(random 360)]),_fireShells,_fireRounds];
		_grp setVariable ['QS_AI_GRP_DATA',[FALSE,(serverTime + 45)],FALSE];
	};
};
if (_type isEqualTo 1) exitWith {
	scriptName 'QS AI FIRE MISSION - HELI';
	//comment 'Heli CAS';
	params ['','_supportProvider','_supportGroup','_targetObject','_targetPosition','_smokePosition','_duration'];
	_vehicle = vehicle _supportProvider;
	_targetAssistant = createSimpleObject ['A3\Structures_F_Heli\VR\Helpers\Sign_sphere10cm_F.p3d',_targetPosition,TRUE];
	[1,_targetAssistant,[_targetObject,[0,0,1]]] call QS_fnc_eventAttach;
	_targetAssistant hideObject TRUE;
	[0,_targetAssistant] call QS_fnc_eventAttach;
	_laserTarget = createVehicle ['LaserTargetE',_targetPosition,[],0,'NONE'];
	[1,_laserTarget,[_targetAssistant,[0,0,0.5]]] call QS_fnc_eventAttach;
	_laserTarget allowDamage FALSE;
	(missionNamespace getVariable 'QS_AI_laserTargets') pushBack _laserTarget;
	_laserTarget confirmSensorTarget [EAST,TRUE];
	if (((_laserTarget getEventHandlerInfo ['IncomingMissile',0]) # 2) isEqualTo 0) then {
		_laserTarget addEventHandler [
			'IncomingMissile',
			{
				params ['_target','_ammo','_vehicle','_instigator','_missile'];
				if (_ammo isKindOf 'BombCore') then {
					[103,_target,_ammo,_vehicle,_missile] remoteExec ['QS_fnc_remoteExec',-2,FALSE];
				};
			}
		];
	};
	private _unit = objNull;
	{
		_unit = _x;
		{
			_unit forgetTarget _x;
		} forEach (_unit targets [TRUE]);
	} forEach (units _supportGroup);
	private _targetPos = _targetPosition;
	_targetPosition set [2,1];
	_supportGroup reveal [_targetObject,4];
	_supportProvider moveTo _targetPosition;
	_supportProvider doMove _targetPosition;
	private _time = time;
	private _rearmDelay = _time + 15;
	private _watchDelay = _time + 5;
	private _moveDelay = _time + 10;
	private _updateTargetDelay = _time + 120;
	private _fireDelay = _time + 5;
	private _firingDuration = 15;
	private _relDir = _vehicle getRelDir _targetPosition;
	private _relPos = _vehicle getRelPos [0,0];
	private _distance2D = _vehicle distance2D _targetPosition;
	private _nearTargets = _supportProvider targets [TRUE,50,[],0,_targetPos];
	private _exit = FALSE;
	private _velocity = velocity _vehicle;
	private _vectorDir = (getPosATL _vehicle) vectorFromTo (getPosATL _laserTarget);
	private _vectorUp = vectorUp _vehicle;
	private _offset = 0;
	private _fireDuration = _time + 3;
	private _selectedTarget = _laserTarget;
	for '_x' from 0 to 1 step 0 do {
		_time = time;
		if (
			(!canMove _vehicle) ||
			{(!alive _vehicle)} ||
			{(_supportGroup isNil 'QS_AI_GRP_fireMission')} ||
			{(_exit)}
		) exitWith {};
		if (_time > _moveDelay) then {
			if (((vectorMagnitude (velocity _vehicle)) * 3.6) < 10) then {
				{
					_supportGroup forgetTarget _x;
					_supportProvider forgetTarget _x;
				} forEach (_supportProvider targets []);
				_relPos = _vehicle getRelPos [(500 + (random 500)),0];
				_relPos set [2,100];
				_supportGroup move _relPos;
			};
			_moveDelay = time + 5;
		};
		if ((_time > _watchDelay) || {(isNull _selectedTarget)}) then {
			_nearTargets = _supportProvider targets [TRUE,75,[],0,_targetPosition];
			if (_nearTargets isEqualTo []) then {
				_selectedTarget = _laserTarget;
			} else {
				_selectedTarget = selectRandom _nearTargets;
			};
			if ((behaviour _supportProvider) isNotEqualTo 'COMBAT') then {
				_supportGroup setBehaviour 'COMBAT';
			};
			if (alive _selectedTarget) then {
				{
					_x reveal [_selectedTarget,3.9];
					_x doWatch (position _selectedTarget);
					_x doTarget _selectedTarget;
				} forEach (units _supportGroup);
				_supportGroup reveal [_selectedTarget,3.9];
				_supportProvider commandTarget _selectedTarget;
			};
			_watchDelay = time + 15;
		};
		if (_time > _fireDelay) then {
			if (((_vehicle aimedAtTarget [_selectedTarget]) > 0.5) && (!(terrainIntersect [(getPosATL _vehicle),(getPosATL _selectedTarget)]))) then {
				//comment 'Fire';
				_supportProvider doSuppressiveFire (aimPos _selectedTarget);
				_fireDuration = time + 5;
				_vehicle setVehicleAmmo 1;
				for '_x' from 0 to 1 step 0 do {
					if (
						(!alive _supportProvider) ||
						{(!alive _vehicle)} ||
						{(!canFire _vehicle)} ||
						{((_vehicle aimedAtTarget [_selectedTarget]) < 0.5)} ||
						{(time > _fireDuration)}
					) exitWith {};
					_vehicle fireAtTarget [_selectedTarget,(currentWeapon _vehicle)];
					sleep (0.5 - ((_vehicle aimedAtTarget [_selectedTarget]) / 2.25));
				};
			};
			_fireDelay = time + 5;
		};
		sleep 1;
	};
	if (!isNull _laserTarget) then {
		deleteVehicle _laserTarget;
	};
	if (!isNull _targetAssistant) then {
		deleteVehicle _targetAssistant;
	};
	if (!isNull _supportGroup) then {
		_supportGroup setVariable ['QS_AI_GRP_fireMission',nil,QS_system_AI_owners];
	};
	if ((alive _vehicle) && (canMove _vehicle)) then {
		_relPos = _vehicle getRelPos [(500 + (random 500)),(random 360)];
		_relPos set [2,100];
		_supportGroup move _relPos;
	};
};
if (_type isEqualTo 2) exitWith {
	scriptName 'QS AI FIRE MISSION - PLANE';
	//comment 'Plane CAS';
	params ['','_supportProvider','_supportGroup','_targetObject','_targetPosition','_duration'];
	_vehicle = vehicle _supportProvider;
	_vehicle flyInHeight (200 + (random 100));
	_vehicle forceSpeed -1;
	_vehicle setVariable ['QS_AI_PLANE_fireMission',TRUE,FALSE];
	_targetAssistant = createSimpleObject ['A3\Structures_F_Heli\VR\Helpers\Sign_sphere10cm_F.p3d',_targetPosition,TRUE];
	[1,_targetAssistant,[_targetObject,[0,0,1]]] call QS_fnc_eventAttach;
	_targetAssistant hideObject TRUE;
	[0,_targetAssistant] call QS_fnc_eventAttach;
	_laserTarget = createVehicle ['LaserTargetE',_targetPosition,[],0,'NONE'];
	[1,_laserTarget,[_targetAssistant,[0,0,0.5]]] call QS_fnc_eventAttach;
	_laserTarget allowDamage FALSE;
	(missionNamespace getVariable 'QS_AI_laserTargets') pushBack _laserTarget;
	_laserTarget confirmSensorTarget [EAST,TRUE];
	if (((_laserTarget getEventHandlerInfo ['IncomingMissile',0]) # 2) isEqualTo 0) then {
		_laserTarget addEventHandler [
			'IncomingMissile',
			{
				params ['_target','_ammo','_vehicle','_instigator','_missile'];
				if (_ammo isKindOf 'BombCore') then {
					[103,_target,_ammo,_vehicle,_missile] remoteExec ['QS_fnc_remoteExec',-2,FALSE];
				};
			}
		];
	};
	_supportGroup reveal [_laserTarget,3.9];
	_supportProvider doWatch _laserTarget;
	_supportProvider commandTarget _laserTarget;
	private _unit = objNull;
	{
		_unit = _x;
		{
			_unit forgetTarget _x;
			_supportGroup forgetTarget _x;
		} forEach (_unit targets [TRUE]);
	} forEach (units _supportGroup);
	private _time = time;
	private _targetDelay = _time + 30;
	private _relPos = _vehicle getRelPos [0,0];
	private _exit = FALSE;
	private _fireDuration = _time + 5;
	private _fireDelay = _time + 5;
	private _firedEvent = nil;
	for '_x' from 0 to 1 step 0 do {
		_time = time;
		if (
			((vehicle _supportProvider) isNotEqualTo _vehicle) ||
			{(!canMove _vehicle)} ||
			{(!alive _vehicle)} ||
			{(_supportGroup isNil 'QS_AI_GRP_fireMission')} ||
			{(_exit)} ||
			{(serverTime > _duration)} ||
			{(isNull _laserTarget)}
		) exitWith {};
		if (_time > _targetDelay) then {
			_vehicle setVehicleAmmo 1;
			if ((behaviour _supportProvider) isNotEqualTo 'COMBAT') then {
				_supportGroup setBehaviour 'COMBAT';
			};
			{
				_unit = _x;
				{
					if (_x isNotEqualTo _laserTarget) then {
						_unit forgetTarget _x;
						_supportGroup forgetTarget _x;
					};
				} forEach (_unit targets [TRUE]);
			} forEach (units _supportGroup);
			_supportGroup reveal [_laserTarget,3.9];
			_supportProvider doWatch _laserTarget;
			_supportProvider commandTarget _laserTarget;
			_targetDelay = _time + 30;
		};
		if (_time > _fireDelay) then {
			if (((_vehicle aimedAtTarget [_laserTarget]) > 0.5) && (!(terrainIntersect [(getPosATL _vehicle),(getPosATL _laserTarget)]))) then {
				//comment 'Fire';
				_firedEvent = _vehicle addEventHandler [
					'Fired',
					{
						params ['','','','','_ammo','','_projectile',''];
						private _simulation = QS_hashmap_configfile getOrDefaultCall [
							format ['cfgammo_%1_simulation',toLowerANSI _ammo],
							{toLowerANSI (getText (configFile >> 'CfgAmmo' >> _ammo >> 'simulation'))},
							TRUE
						];
						if ((toLowerANSI _simulation) isEqualTo 'shotmissile') then {
							missionNamespace setVariable ['QS_draw2D_projectiles',((missionNamespace getVariable 'QS_draw2D_projectiles') + [_projectile]),TRUE];
							missionNamespace setVariable ['QS_draw3D_projectiles',((missionNamespace getVariable 'QS_draw3D_projectiles') + [_projectile]),TRUE];
						};
					}
				];
				uiSleep 0.01;
				_supportProvider doSuppressiveFire (aimPos _laserTarget);
				_fireDuration = time + 5;
				for '_x' from 0 to 1 step 0 do {
					if (
						(!alive _supportProvider) ||
						{(!alive _vehicle)} ||
						{(!canFire _vehicle)} ||
						{((_vehicle aimedAtTarget [_laserTarget]) < 0.5)} ||
						{(time > _fireDuration)}
					) exitWith {};
					_vehicle fireAtTarget [_laserTarget,(currentWeapon _vehicle)];
					sleep (0.5 - ((_vehicle aimedAtTarget [_laserTarget]) / 2.25));
				};
				if (!isNull _laserTarget) then {
					deleteVehicle _laserTarget;
				};
				_vehicle removeEventHandler ['Fired',_firedEvent];
			};
			_fireDelay = time + 5;
		};
		uiSleep 1;
	};
	_vehicle setVariable ['QS_AI_PLANE_fireMission',FALSE,FALSE];
	if (!isNull _laserTarget) then {
		deleteVehicle _laserTarget;
	};
	if (!isNull _targetAssistant) then {
		deleteVehicle _targetAssistant;
	};
	if (!isNull _supportGroup) then {
		_supportGroup setVariable ['QS_AI_GRP_fireMission',nil,QS_system_AI_owners];
	};
	_supportProvider commandWatch objNull;
	if ((alive _vehicle) && (canMove _vehicle)) then {
		_relPos = _vehicle getRelPos [(500 + (random 500)),(random 360)];
		_relPos set [2,300];
		_supportGroup move _relPos;
	};
};
if (_type isEqualTo 3) exitWith {
	scriptName 'QS AI FIRE MISSION - UAV';
	//comment 'UAV CAS';
	params ['','_supportProvider','_supportGroup','_targetObject','_targetPosition','_duration'];
	_vehicle = vehicle _supportProvider;
	_targetAssistant = createSimpleObject ['A3\Structures_F_Heli\VR\Helpers\Sign_sphere10cm_F.p3d',_targetPosition,TRUE];
	[1,_targetAssistant,[_targetObject,[0,0,1]]] call QS_fnc_eventAttach;
	_targetAssistant hideObject TRUE;
	[0,_targetAssistant] call QS_fnc_eventAttach;
	_laserTarget = createVehicle ['LaserTargetE',_targetPosition,[],0,'NONE'];
	[1,_laserTarget,[_targetAssistant,[0,0,0.5]]] call QS_fnc_eventAttach;
	_laserTarget allowDamage FALSE;
	(missionNamespace getVariable 'QS_AI_laserTargets') pushBack _laserTarget;
	_laserTarget confirmSensorTarget [EAST,TRUE];
	if (((_laserTarget getEventHandlerInfo ['IncomingMissile',0]) # 2) isEqualTo 0) then {
		_laserTarget addEventHandler [
			'IncomingMissile',
			{
				params ['_target','_ammo','_vehicle','_instigator','_missile'];
				if (_ammo isKindOf 'BombCore') then {
					[103,_target,_ammo,_vehicle,_missile] remoteExec ['QS_fnc_remoteExec',-2,FALSE];
				};
			}
		];
	};
	_vehicle flyInHeight (100 + (random 100));
	_supportGroup reveal [_laserTarget,4];
	if (!isNull (gunner _vehicle)) then {
		(gunner _vehicle) doWatch _laserTarget;
		(gunner _vehicle) doTarget _laserTarget;
	};
	_supportProvider commandTarget _laserTarget;
	_attackEnabled = attackEnabled _supportGroup;
	_supportGroup enableAttack TRUE;
	_supportGroup move [((getPosATL _laserTarget) # 0),((getPosATL _laserTarget) # 1),300];
	private _unit = objNull;
	{
		_unit = _x;
		{
			_supportGroup forgetTarget _x;
			_unit forgetTarget _x;
		} forEach (_unit targets [TRUE]);
	} forEach (units _supportGroup);
	private _time = time;
	private _targetDelay = _time + 15;
	private _relPos = _vehicle getRelPos [0,0];
	private _exit = FALSE;
	_vehicle setVehicleAmmo 1;
	_supportGroup setCombatMode 'RED';
	_supportGroup setBehaviour 'COMBAT';
	for '_x' from 0 to 1 step 0 do {
		_time = time;
		if (
			(!canMove _vehicle) ||
			{(!alive _vehicle)} ||
			{(_supportGroup isNil 'QS_AI_GRP_fireMission')} ||
			{(_exit)} ||
			{(serverTime > _duration)}
		) exitWith {};
		if (_time > _targetDelay) then {
			if ((behaviour _supportProvider) isNotEqualTo 'COMBAT') then {
				_supportGroup setBehaviour 'COMBAT';
			};
			if ((combatMode _supportGroup) isNotEqualTo 'RED') then {
				_supportGroup setCombatMode 'RED';
			};
			_supportGroup reveal [_laserTarget,4];
			{
				_unit = _x;
				{
					if (_x isNotEqualTo _laserTarget) then {
						_supportGroup forgetTarget _x;
						_unit forgetTarget _x;
					};
				} forEach (_unit targets [TRUE]);
				if (_unit isEqualTo (leader _supportGroup)) then {
					_unit commandWatch _laserTarget;
					_unit commandTarget _laserTarget;
				} else {
					_unit doWatch _laserTarget;
					_unit doTarget _laserTarget;					
				};
			} forEach (units _supportGroup);
			_targetDelay = _time + 15;
		};
		uiSleep 1;
	};
	_vehicle setVehicleAmmo 1;
	if (!isNull _laserTarget) then {
		deleteVehicle _laserTarget;
	};
	if (!isNull _targetAssistant) then {
		deleteVehicle _targetAssistant;
	};
	if (!isNull _supportGroup) then {
		_supportGroup enableAttack _attackEnabled;
		_supportGroup setVariable ['QS_AI_GRP_fireMission',nil,QS_system_AI_owners];
	};
	_vehicle flyInHeightASL [500,(300 + (random 100)),(500 + (random 500))];
	_supportProvider commandWatch objNull;
	if ((alive _vehicle) && (canMove _vehicle)) then {
		_relPos = _vehicle getRelPos [(2500 + (random 2500)),(random 360)];
		_relPos set [2,300];
		_supportGroup move _relPos;
	};
};