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
_type = selectRandomWeighted [
	'o_uav_02_dynamicloadout_f',0.5,
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
		if ((allPlayers inAreaArray [_position,500,500,0,FALSE]) isEqualTo []) exitWith {};
	};
	_position set [2,(1500 + (random 1500))];
};
_vehicle = createVehicle [_type,_position,[],0,'FLY'];
if (!isNull _vehicle) then {
	_vehicle enableVehicleSensor ['manSensorComponent',TRUE];
	_vehicle setVariable ['QS_uav_protected',TRUE,FALSE];
	_grp = createVehicleCrew _vehicle;
	_vehicle addEventHandler [
		'Deleted',
		{
			{
				_x setDamage [1,FALSE];
			} count (crew (_this select 0));
		}
	];
	_vehicle addEventHandler [
		'Killed',
		{
			{
				_x setDamage [1,FALSE];
			} count (crew (_this select 0));		
		}
	];
	_vehicle addEventHandler ['Killed',(missionNamespace getVariable 'QS_fnc_vKilled2')];
	_grp addVehicle _vehicle;
	_return pushBack _vehicle;
	{
		_x disableAI 'LIGHTS';
	} forEach (crew _vehicle);
	_vehicle setCollisionLight FALSE;
	_vehicle setAutonomous TRUE;
	_vehicle setVehicleReceiveRemoteTargets TRUE;
	_vehicle setVehicleReportRemoteTargets TRUE;
	{
		_x setVehicleReceiveRemoteTargets TRUE;
		_x setVehicleReportRemoteTargets TRUE;
		_x setSkill 1;
		_x enableAI 'TARGET';
		_x enableAI 'AUTOTARGET';
		_x setSkill ['spotDistance',1];
	} forEach (units _grp);
	if (!((waypoints _grp) isEqualTo [])) then {
		[_grp,0] setWaypointForceBehaviour FALSE;
	};
	if (_type in ['o_uav_02_dynamicloadout_f','i_uav_02_dynamicloadout_f']) then {
		['setFeatureType',_vehicle,2] remoteExec ['QS_fnc_remoteExecCmd',-2,_vehicle];
		if ((random 1) > 0.333) then {
			_vehicle flyInHeightASL [500,(300 + (random 100)),(500 + (random 500))];
		};
		(missionNamespace getVariable 'QS_AI_supportProviders_CASUAV') pushBack (effectiveCommander _vehicle);
		(missionNamespace getVariable 'QS_AI_supportProviders_INTEL') pushBack (effectiveCommander _vehicle);
		_vehicle addEventHandler [
			'Fired',
			{
				params ['','','','','_ammo','','_projectile',''];
				if ((toLower _ammo) in [
					'bomb_03_f','bomb_04_f','bo_gbu12_lgb','bo_gbu12_lgb_mi10','bo_air_lgb','bo_air_lgb_hidden','bo_mk82','bo_mk82_mi08'
				]) then {
					missionNamespace setVariable ['QS_draw2D_projectiles',((missionNamespace getVariable 'QS_draw2D_projectiles') + [_projectile]),TRUE];
					missionNamespace setVariable ['QS_draw3D_projectiles',((missionNamespace getVariable 'QS_draw3D_projectiles') + [_projectile]),TRUE];
				};
			}
		];
		[_vehicle,1,[]] call (missionNamespace getVariable 'QS_fnc_vehicleLoadouts');
		_grp setVariable ['QS_AI_GRP',TRUE,FALSE];
		_grp setVariable ['QS_AI_GRP_CONFIG',['AIR_PATROL_UAV','',(count (units _grp)),_vehicle],FALSE];
		_grp setVariable ['QS_AI_GRP_DATA',[],FALSE];
		_grp setVariable ['QS_AI_GRP_TASK',['',[],diag_tickTime,-1],FALSE];
		_grp setVariable ['QS_AI_GRP_PATROLINDEX',0,FALSE];
		_grp setVariable ['QS_GRP_HC',TRUE,FALSE];
	};
	if (_type in ['o_uav_06_f','o_uav_06_medical_f','o_uav_01_f']) then {
		if ((random 1) > 0.333) then {
			_vehicle flyInHeightASL [75,75,150];
		};
		(missionNamespace getVariable 'QS_AI_supportProviders_INTEL') pushBack (effectiveCommander _vehicle);
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
		if (!(_radialPatrolPositions isEqualTo [])) then {
			_radialPatrolPositions = _radialPatrolPositions call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
			comment 'Initial movement';
			_grp move (_radialPatrolPositions select 0);
			_grp setFormDir (_position getDir (_radialPatrolPositions select 0));
		};
		_grp setSpeedMode 'NORMAL';
		_grp setBehaviour 'SAFE';
		_grp setCombatMode 'YELLOW';
		_grp setFormation 'WEDGE';
		_grp setVariable ['QS_AI_GRP',TRUE,FALSE];
		_grp setVariable ['QS_AI_GRP_CONFIG',['AO','UAV_PATROL_RADIAL',(count (units _grp)),_vehicle],FALSE];
		_grp setVariable ['QS_AI_GRP_DATA',[],FALSE];
		_grp setVariable ['QS_AI_GRP_TASK',['PATROL',_radialPatrolPositions,diag_tickTime,-1],FALSE];
		_grp setVariable ['QS_AI_GRP_PATROLINDEX',0,FALSE];
		_grp setVariable ['QS_GRP_HC',TRUE,FALSE];
	};
};
_return;