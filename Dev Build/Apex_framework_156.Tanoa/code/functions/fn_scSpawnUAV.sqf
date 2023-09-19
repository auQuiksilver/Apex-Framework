/*/
File: fn_scSpawnUAV.sqf
Author:

	Quiksilver
	
Last modified:

	6/04/2018 A3 1.82 by Quiksilver
	
Description:

	Spawn UAV Patrol
__________________________________________________/*/

private _return = [];
_centerPos = missionNamespace getVariable 'QS_AOpos';
_centerRadius = missionNamespace getVariable 'QS_aoSize';
private _allPlayers = allPlayers;
_type = selectRandomWeighted [
	'o_uav_02_dynamicloadout_f',([0.1,0.5] select ((count _allPlayers) > 15)),
	'o_uav_01_f',0.5
];
private _position = [0,0,0];
private _dist = 2000;
if (_type in ['o_uav_01_f']) then {
	_dist = 300;
	_position = _centerPos getPos [(_dist + (random _dist)),(random 360)];
	_position set [2,100];
} else {
	for '_x' from 0 to 9 step 1 do {
		_position = _centerPos getPos [(_dist + (random _dist)),(random 360)];
		if ((_allPlayers inAreaArray [_position,500,500,0,FALSE]) isEqualTo []) exitWith {};
	};
	_position set [2,(1500 + (random 1500))];
};
_vehicle = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _type,_type],_position,[],0,'FLY'];
if (!isNull _vehicle) then {
	_vehicle enableVehicleSensor ['manSensorComponent',TRUE];
	_vehicle setVariable ['QS_uav_protected',TRUE,FALSE];
	_grp = createVehicleCrew _vehicle;
	_vehicle addEventHandler [
		'Deleted',
		{
			deleteVehicleCrew (_this # 0);
		}
	];
	_vehicle addEventHandler [
		'Killed',
		{
			deleteVehicleCrew (_this # 0);	
		}
	];
	_vehicle addEventHandler ['Killed',(missionNamespace getVariable 'QS_fnc_vKilled2')];
	_grp addVehicle _vehicle;
	_return pushBack _vehicle;
	{
		_x enableAIFeature ['LIGHTS',FALSE];
	} forEach (crew _vehicle);
	_vehicle setCollisionLight FALSE;
	_vehicle setAutonomous TRUE;
	_vehicle setVehicleReceiveRemoteTargets TRUE;
	_vehicle setVehicleReportRemoteTargets TRUE;
	{
		_x setVehicleReceiveRemoteTargets TRUE;
		_x setVehicleReportRemoteTargets TRUE;
		_x setSkill 1;
		_x enableAIFeature ['TARGET',TRUE];
		_x enableAIFeature ['AUTOTARGET',TRUE];
		_x setSkill ['spotDistance',1];
	} forEach (units _grp);
	if ((waypoints _grp) isNotEqualTo []) then {
		[_grp,0] setWaypointForceBehaviour FALSE;
	};
	_grp setGroupIdGlobal ['UAV Recon'];
	_grp addEventHandler ['EnemyDetected',{call (missionNamespace getVariable 'QS_fnc_AIGroupEventEnemyDetected2')}];
	if (_type in ['o_uav_02_dynamicloadout_f','i_uav_02_dynamicloadout_f']) then {
		['setFeatureType',_vehicle,2] remoteExec ['QS_fnc_remoteExecCmd',-2,_vehicle];
		if ((random 1) > 0.333) then {
			_vehicle flyInHeightASL [500,(300 + (random 100)),(500 + (random 500))];
		};
		if ((count _allPlayers) >= 15) then {
			missionNamespace setVariable ['QS_AI_supportProviders_CASUAV',((missionNamespace getVariable 'QS_AI_supportProviders_CASUAV') + [effectiveCommander _vehicle]),QS_system_AI_owners];
		} else {
			// Bombs removed for low-pop server situations to reduce GBU spam, also removed from AI CAS support provider network
			{ 
				_vehicle removeWeaponGlobal (getText (configFile >> 'CfgMagazines' >> _x >> 'pylonWeapon'));
			} forEach (getPylonMagazines _vehicle);
		};
		missionNamespace setVariable ['QS_AI_supportProviders_INTEL',((missionNamespace getVariable 'QS_AI_supportProviders_INTEL') + [effectiveCommander _vehicle]),QS_system_AI_owners];
		_vehicle addEventHandler [
			'Fired',
			{
				params ['','','','','_ammo','','_projectile',''];
				_simulation = QS_hashmap_configfile getOrDefaultCall [
					format ['cfgammo_%1_simulation',toLowerANSI _ammo],
					{toLowerANSI (getText (configFile >> 'CfgAmmo' >> _ammo >> 'simulation'))},
					TRUE
				];
				if (_simulation isEqualTo 'shotmissile') then {
					missionNamespace setVariable ['QS_draw2D_projectiles',((missionNamespace getVariable 'QS_draw2D_projectiles') + [_projectile]),TRUE];
					missionNamespace setVariable ['QS_draw3D_projectiles',((missionNamespace getVariable 'QS_draw3D_projectiles') + [_projectile]),TRUE];
				};
			}
		];
		if ((count _allPlayers) >= 15) then {
			[_vehicle,1,[]] call (missionNamespace getVariable 'QS_fnc_vehicleLoadouts');
		};
		_grp setVariable ['QS_AI_GRP',TRUE,FALSE];
		_grp setVariable ['QS_AI_GRP_CONFIG',['AIR_PATROL_UAV','',(count (units _grp)),_vehicle],FALSE];
		_grp setVariable ['QS_AI_GRP_DATA',[],FALSE];
		_grp setVariable ['QS_AI_GRP_TASK',['',[],serverTime,-1],FALSE];
		_grp setVariable ['QS_AI_GRP_PATROLINDEX',0,FALSE];
	};
	if (_type in ['o_uav_06_f','o_uav_06_medical_f','o_uav_01_f']) then {
		if ((random 1) > 0.333) then {
			_vehicle flyInHeightASL [75,75,150];
		};
		missionNamespace setVariable ['QS_AI_supportProviders_INTEL',((missionNamespace getVariable 'QS_AI_supportProviders_INTEL') + [effectiveCommander _vehicle]),QS_system_AI_owners];
		comment 'Radial positions';
		private _radialIncrement = 45;
		private _radialStart = round (random 360);
		private _radialOffset = _centerRadius * (0.4 + (random 0.7));
		private _radialPatrolPositions = [];
		private _patrolPosition = _centerPos getPos [_radialOffset,_radialStart];
		if (!surfaceIsWater _patrolPosition) then {
			_patrolPosition set [2,100];
			_radialPatrolPositions pushBack _patrolPosition;
		};
		for '_x' from 0 to 6 step 1 do {
			_radialStart = _radialStart + _radialIncrement;
			_patrolPosition = _centerPos getPos [_radialOffset,_radialStart];
			if (!surfaceIsWater _patrolPosition) then {
				_patrolPosition set [2,75];
				_radialPatrolPositions pushBack _patrolPosition;
			};
		};
		if (_radialPatrolPositions isNotEqualTo []) then {
			_radialPatrolPositions = _radialPatrolPositions call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
			comment 'Initial movement';
			_grp move (_radialPatrolPositions # 0);
			_grp setFormDir (_position getDir (_radialPatrolPositions # 0));
		};
		_grp setSpeedMode 'NORMAL';
		_grp setBehaviourStrong 'COMBAT';
		_grp setCombatMode 'RED';
		_grp setFormation 'WEDGE';
		_grp setVariable ['QS_AI_GRP',TRUE,FALSE];
		_grp setVariable ['QS_AI_GRP_CONFIG',['AO','UAV_PATROL_RADIAL',(count (units _grp)),_vehicle],FALSE];
		_grp setVariable ['QS_AI_GRP_DATA',[],FALSE];
		_grp setVariable ['QS_AI_GRP_TASK',['PATROL',_radialPatrolPositions,serverTime,-1],FALSE];
		_grp setVariable ['QS_AI_GRP_PATROLINDEX',0,FALSE];
	};
};
_return;