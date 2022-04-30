/*/
File: fn_SMpriorityAA.sqf
Author:

	Quiksilver
	
Last modified:

	2/06/2019 A3 1.94 by Quiksilver
	
Description:

	Anti-Air Battery
______________________________________________/*/

scriptName 'QS - SM - AA';
//comment 'Get any data we need';
private _spawnPosition = [0,0,0];
private _aaTypes = ['o_apc_tracked_02_aa_f','o_t_apc_tracked_02_aa_ghex_f','o_t_apc_tracked_02_aa_ghex_f','o_t_apc_tracked_02_aa_ghex_f','o_sam_system_04_f'];
private _aaHulls = [];
private _aaTurrets = [];
private _aaTurretObjects = [];
private _allAssets = [];
private _enemyAssets = [];
private _allAircraft = [];
private _aaHull = objNull;
private _aaTurret = objNull;
private _ammoTruck = objNull;
private _stealthAircraft = ['b_ctrg_heli_transport_01_sand_f','b_ctrg_heli_transport_01_tropic_f','b_heli_attack_01_dynamicloadout_f','b_heli_transport_01_f','b_heli_transport_01_camo_f','b_plane_fighter_01_stealth_f','b_t_uav_03_dynamicloadout_f','o_plane_fighter_02_stealth_f'];
private _time = diag_tickTime;
private _delay = 5;
private _checkDelay = _time + _delay;
private _targetingRange_max = [7500,3500] select (worldName in ['Tanoa','Malden']);
private _targetingRange_heli = [4500,3000] select (worldName in ['Tanoa','Malden']);
private _targetingRange_stealthCoef = 0.666;
private _targetingRange_stealthCoef2 = 0.8;
private _targetingAltitudeMin = random [20,25,30];
private _entitiesParams = [['Air'],['UAV_01_base_F','UAV_06_base_F','ParachuteBase'],FALSE,TRUE];
private _rearmInterval = _time + (240 + (random 80));
private _rearming = FALSE;
private _rearmDelay = [15,20,30];
_rearmingText = 'The CSAT AA Battery is rearming!';
_finishedRearmText = 'The CSAT AA Battery has finished rearming!';
private _turretParams = [];
private _targetListEnemy = [];
private _targetType = '';
private _targetCandidate = objNull;
private _targetPosition = [0,0,0];
private _targetDir = 0;
private _aircraftPosition = [0,0,0];
//comment 'Find position';
_basepos = markerPos 'QS_marker_base_marker';
_fobpos = markerPos 'QS_marker_module_fob';
private _spawnPosition = [0,0,0];
private _accepted = FALSE;
for '_x' from 0 to 1 step 0 do {
	_spawnPosition = ['RADIUS',_basepos,4500,'LAND',[5,0,0.2,5,0,FALSE,objNull],TRUE,[],[],TRUE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
	if ((_spawnPosition distance2D _basepos) > 2000) then {
		if ((_spawnPosition distance2D _fobpos) > 250) then {
			if ((_spawnPosition distance2D (missionNamespace getVariable 'QS_AOpos')) > 500) then {
				if (((((_spawnPosition select [0,2]) nearRoads 25) select {((_x isEqualType objNull) && (!((roadsConnectedTo _x) isEqualTo [])))}) isEqualTo []) && (!((toLower(surfaceType _spawnPosition)) in ['#gdtasphalt'])) && (!([_spawnPosition,30,8] call (missionNamespace getVariable 'QS_fnc_waterInRadius')))) then {
					_accepted = TRUE;
				};
			};
		};
	};
	if (_accepted) exitWith {};
};
private _watchPosition = _spawnPosition vectorAdd [0,0,1000];
//comment 'Generate composition and assets';
private _compositionData = [
	[
		["o_sam_system_04_f",[0.230469,-6.17627,0.0173378],179.236,[],TRUE,TRUE,FALSE,{(_this select 0)}], 			// o_sam_system_04_f   O_APC_Tracked_02_AA_F
		["o_sam_system_04_f",[-0.212402,9.61426,0.0157723],359.523,[],TRUE,TRUE,FALSE,{(_this select 0)}], 			//	o_sam_system_04_f   O_APC_Tracked_02_AA_F
		["Land_HBarrier_5_F",[-0.302979,1.63086,1.72132],0,[],FALSE,FALSE,TRUE,{}], 
		["Land_HBarrier_Big_F",[-0.20874,1.77246,0],0,[],FALSE,FALSE,TRUE,{}], 
		["Land_HBarrier_Big_F",[5.12134,-1.37109,0],271.094,[],FALSE,FALSE,TRUE,{}], 
		["Land_HBarrier_5_F",[5.0769,1.81445,1.72132],89.7338,[],FALSE,FALSE,TRUE,{}], 
		["Land_HBarrier_Big_F",[-5.27954,-1.6084,0],271.094,[],FALSE,FALSE,TRUE,{}], 
		["Land_HBarrier_5_F",[-5.30835,1.51318,1.72132],89.7338,[],FALSE,FALSE,TRUE,{}], 
		["Land_HBarrier_Big_F",[5.03076,5.12256,0],271.094,[],FALSE,FALSE,TRUE,{}], 
		["Box_East_AmmoVeh_F",[-7.21362,-0.240234,0.0305414],360,[],FALSE,FALSE,TRUE,{}], 
		["Land_HBarrier_Big_F",[-5.32275,4.90576,0],271.094,[],FALSE,FALSE,TRUE,{}], 
		["Box_East_AmmoVeh_F",[7.15332,3.21045,0.0305414],359.999,[],FALSE,FALSE,TRUE,{}], 
		["Box_East_AmmoVeh_F",[-5.26563,-6.72168,0.0305414],6.13621e-005,[],FALSE,FALSE,TRUE,{}], 
		["Box_East_AmmoVeh_F",[4.98267,10.3843,0.0305424],360,[],FALSE,FALSE,TRUE,{}], 
		["Land_HBarrierWall6_F",[3.98584,-11.5811,0],176.61,[],FALSE,FALSE,TRUE,{}], 
		["Land_HBarrierWall6_F",[-10.6821,-6.2666,0],272.427,[],FALSE,FALSE,TRUE,{}], 
		["Land_HBarrierWall6_F",[-3.64233,-11.9756,0],182.945,[],FALSE,FALSE,TRUE,{}], 
		["Land_HBarrierWall6_F",[-10.8394,6.53223,0],270.45,[],FALSE,FALSE,TRUE,{}], 
		["Land_HBarrierWall6_F",[12.0781,-4.38086,0],90.4428,[],FALSE,FALSE,TRUE,{}], 
		["Land_HBarrierWall6_F",[9.75806,-9.31543,0],145.115,[],FALSE,FALSE,TRUE,{}], 
		["Land_HBarrierWall6_F",[11.6382,8.96875,0],90.4428,[],FALSE,FALSE,TRUE,{}], 
		["Land_HBarrierWall6_F",[-8.74756,12.0044,0],315.066,[],FALSE,FALSE,TRUE,{}], 
		["Land_HBarrierWall6_F",[-2.82495,14.6338,0],2.07366,[],FALSE,FALSE,TRUE,{}],  
		["Land_HBarrierWall6_F",[5.39624,14.6694,0],1.06539,[],FALSE,FALSE,TRUE,{}], 
		["Land_HBarrierWall_corner_F",[-10.2822,-11.9663,0],182.02,[],FALSE,FALSE,TRUE,{}], 
		["Land_HBarrierWall_corner_F",[11.0156,14.7471,0],0,[],FALSE,FALSE,TRUE,{}]
	],
	[
		["o_sam_system_04_f",[-0.0292969,-6.354,0.0168018],178.855,[],TRUE,TRUE,FALSE,{(_this select 0)}], 		// o_sam_system_04_f    O_T_APC_Tracked_02_AA_ghex_F
		["o_sam_system_04_f",[-0.321777,8.54443,0.0163908],359.998,[],TRUE,TRUE,FALSE,{(_this select 0)}], 		// o_sam_system_04_f   O_T_APC_Tracked_02_AA_ghex_F
		["Land_HBarrier_01_big_4_green_F",[-0.081543,1.03174,0],0,[],FALSE,FALSE,TRUE,{}], 
		["Land_HBarrier_01_line_5_green_F",[-0.195801,1.05566,1.74458],0,[],FALSE,FALSE,TRUE,{}], 
		["Land_HBarrier_01_line_5_green_F",[5.23779,0.97168,1.69463],90,[],FALSE,FALSE,TRUE,{}], 
		["Land_HBarrier_01_line_5_green_F",[-5.31372,0.904785,1.69334],268.879,[],FALSE,FALSE,TRUE,{}], 
		["Land_HBarrier_01_big_4_green_F",[5.17529,-2.11475,0],88.4046,[],FALSE,FALSE,TRUE,{}], 
		["Land_HBarrier_01_big_4_green_F",[-5.32666,-2.39697,0],269.013,[],FALSE,FALSE,TRUE,{}], 
		["Land_HBarrier_01_big_4_green_F",[5.19482,4.3623,0],89.9908,[],FALSE,FALSE,TRUE,{}], 
		["Land_HBarrier_01_big_4_green_F",[-5.57227,4.06348,0],269.013,[],FALSE,FALSE,TRUE,{}], 
		["Box_East_AmmoVeh_F",[-7.29956,-1.11963,0.0305424],0.000326158,[],FALSE,FALSE,TRUE,{}], 
		["Box_East_AmmoVeh_F",[7.06738,2.33105,0.0305405],359.999,[],FALSE,FALSE,TRUE,{}], 
		["Box_East_AmmoVeh_F",[-5.35156,-7.60107,0.0305414],360,[],FALSE,FALSE,TRUE,{}], 
		["Box_East_AmmoVeh_F",[4.89673,9.50488,0.0305443],359.998,[],FALSE,FALSE,TRUE,{}], 
		["Land_HBarrier_01_wall_6_green_F",[-10.9766,5.59082,0],272.586,[],FALSE,FALSE,TRUE,{}], 
		["Land_HBarrier_01_wall_6_green_F",[-10.927,-6.896,0],272.586,[],FALSE,FALSE,TRUE,{}], 
		["Land_HBarrier_01_wall_6_green_F",[3.46362,-12.6069,0],178.77,[],FALSE,FALSE,TRUE,{}], 
		["Land_HBarrier_01_wall_6_green_F",[11.8621,-5.60059,0],90,[],FALSE,FALSE,TRUE,{}], 
		["Land_HBarrier_01_wall_6_green_F",[-4.17578,-12.7153,0],181.822,[],FALSE,FALSE,TRUE,{}], 
		["Land_HBarrier_01_wall_6_green_F",[11.6755,7.30371,0],90,[],FALSE,FALSE,TRUE,{}], 
		["Land_HBarrier_01_wall_6_green_F",[-3.31226,13.3999,0],1.80299,[],FALSE,FALSE,TRUE,{}], 
		["Land_HBarrier_01_wall_6_green_F",[9.60425,-10.2549,0],144.711,[],FALSE,FALSE,TRUE,{}], 
		["Land_HBarrier_01_wall_6_green_F",[-8.68701,11.1494,0],316.332,[],FALSE,FALSE,TRUE,{}], 
		["Land_HBarrier_01_wall_6_green_F",[4.74365,13.3765,0],1.80299,[],FALSE,FALSE,TRUE,{}], 
		["Land_HBarrier_01_wall_corner_green_F",[-10.5381,-12.6621,0],183.027,[],FALSE,FALSE,TRUE,{}], 
		["Land_HBarrier_01_wall_corner_green_F",[11.1887,13.1079,0],4.08422,[],FALSE,FALSE,TRUE,{}]
	]
] select (worldName in ['Tanoa','Lingor3']);
_composition = [_spawnPosition,(random 360),_compositionData,FALSE] call (missionNamespace getVariable 'QS_fnc_serverObjectsMapper');
_compositionData = nil;
//comment 'Configure assets';
{
	if (!(isSimpleObject _x)) then {
		if ((toLower (typeOf _x)) in _aaTypes) then {
			_aaHulls pushBack _x;
		};
	};
} forEach _composition;
{
	if (alive _x) then {
		_aaHull = _x;
		{
			_aaHull animateSource _x;
		} forEach [
			['showslathull',1,1]
		];
		if (unitIsUav _aaHull) then {
			_aaHull setVariable ['QS_uav_protected',TRUE,FALSE];
		};
		if ((toLower (typeOf _aaHull)) in ['o_sam_system_04_f','o_radar_system_02_f']) then {
			{
				_aaHull setObjectTextureGlobal [_forEachIndex,_x];
			} forEach (getArray (configFile >> 'CfgVehicles' >> (typeOf _aaHull) >> 'TextureSources' >> (['AridHex','JungleHex'] select (worldName in ['Tanoa','Lingor3'])) >> 'textures'));
		};
		_aaHull setVehicleRadar 1;
		_aaHull setVehicleReceiveRemoteTargets TRUE;
		_aaHull lockDriver TRUE;
		_aaHull lockTurret [[0],TRUE];
		_aaHull lockTurret [[0,0],TRUE];
		_aaHull lock 2;
		_aaHull enableDynamicSimulation FALSE;
		(missionNamespace getVariable 'QS_AI_vehicles') pushBack _aaHull;
		clearItemCargoGlobal _aaHull;
		clearBackpackCargoGlobal _aaHull;
		clearWeaponCargoGlobal _aaHull;
		clearMagazineCargoGlobal _aaHull;
		_aaHull setVariable ['QS_client_canAttachExp',TRUE,TRUE];
		_aaHull setVariable ['QS_RD_noRepair',TRUE,TRUE];
		if ((toLower (typeOf _aaHull)) in ['o_sam_system_04_f','o_radar_system_02_f']) then {
			_aaHull addEventHandler [
				'HandleDamage',
				{
					params ['_vehicle','','_damage','','','_hitPartIndex','',''];
					_oldDamage = if (_hitPartIndex isEqualTo -1) then {(damage _vehicle)} else {(_vehicle getHitIndex _hitPartIndex)};
					_damage = _oldDamage + (_damage - _oldDamage) * 0.5;
					_damage;
				}
			];
		} else {
			_aaHull addEventHandler [
				'HandleDamage',
				{
					params ['_vehicle','','_damage','','','_hitPartIndex','',''];
					_oldDamage = if (_hitPartIndex isEqualTo -1) then {(damage _vehicle)} else {(_vehicle getHitIndex _hitPartIndex)};
					_damage = _oldDamage + (_damage - _oldDamage) * 0.67;
					_damage;
				}
			];		
		};
		_aaHull addEventHandler [
			'Deleted',
			{
				params ['_entity'];
				if (!( (attachedObjects _entity) isEqualTo [])) then {
					{
						deleteVehicle _x;
					} forEach (attachedObjects _entity);
				};
			}
		];
		_aaHull addEventHandler [
			'Killed',
			{
				params ['_killed','_killer','_instigator',''];
				if (!((attachedObjects _killed) isEqualTo [])) then {
					{
						detach _x;
						deleteVehicle _x;
					} forEach (attachedObjects _killed);
				};
				if (!isNull _instigator) then {
					if (isPlayer _instigator) then {
						_text = format ['%1 ( %2 ) destroyed an AA tank!',(name _instigator),(groupID (group _instigator))];
						[[WEST,'BLU'],_text] remoteExec ['sideChat',-2,FALSE];
					} else {
						[[WEST,'BLU'],'AA tank destroyed!'] remoteExec ['sideChat',-2,FALSE];
					};
				} else {
					[[WEST,'BLU'],'AA tank destroyed!'] remoteExec ['sideChat',-2,FALSE];
				};
			}
		];
		createVehicleCrew _aaHull;
		(crew _aaHull) joinSilent (createGroup [EAST,TRUE]);
		{
			_x setVariable ['QS_hidden',TRUE,TRUE];
		} forEach (crew _aaHull);
		//_aaHull doWatch _watchPosition;
		_aaTurrets pushBack [_aaHull,(gunner _aaHull),(group (gunner _aaHull)),(typeOf _aaHull),((weapons _aaHull) select ([0,1] select (_aaHull isKindOf 'Tank'))),0,0,0];
	};
} forEach _aaHulls;
//comment 'Generate force protection';
{
	_enemyAssets pushBack _x;
	if (!isNull (group _x)) then {
		(group _x) addVehicle (selectRandom _aaHulls);
	};
} forEach ([(_composition select 0)] call (missionNamespace getVariable 'QS_fnc_smEnemyEast'));
//comment 'Brief players';
_fuzzyPos = [((_spawnPosition select 0) - 300) + (random 600),((_spawnPosition select 1) - 300) + (random 600),0];
{
	_x setMarkerPosLocal _fuzzyPos;
	_x setMarkerAlpha 1;
} count ['QS_marker_sideMarker','QS_marker_sideCircle'];
'QS_marker_sideMarker' setMarkerText (format ['%1Priority Target: Anti-Air Battery',(toString [32,32,32])]);
[
	'QS_IA_TASK_SM_0',
	TRUE,
	[
		'The enemy has set up an Anti-Air Battery near our base. This is a priority target, soldiers! It has extremely long range! Get over there and take it out at all cost. While it is active, it is not advised to use air transport. This objective is not accurately marked. While it is re-arming (30 seconds), it will not be able to lock on at long range. Bringing heavy explosives is advised.',
		'Anti-Air Battery',
		'Anti-Air Battery'
	],
	(markerPos 'QS_marker_sideMarker'),
	'CREATED',
	5,
	FALSE,
	TRUE,
	'destroy',
	TRUE
] call (missionNamespace getVariable 'BIS_fnc_setTask');
_briefing = parseText "<t align='center' size='2.2'>Priority Target</t><br/><t size='1.5' color='#b60000'>Anti-Air Battery</t><br/>____________________<br/>OPFOR forces are setting up an anti-air battery to hit you guys damned hard! We've picked up their positions with thermal imaging scans and have marked it on your map.<br/><br/>This is a priority target, boys!";
//['hint',_briefing] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
['NewPriorityTarget',['Anti-Air Battery']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
//comment 'Loop';
missionNamespace setVariable ['QS_smSuccess',FALSE,TRUE];
for '_x' from 0 to 1 step 0 do {
	if (((_aaHulls findIf {(alive _x)}) isEqualTo -1) || {(missionNamespace getVariable ['QS_smSuccess',FALSE])}) exitWith {
		['CompletedPriorityTarget',['Anti-Air Battery Neutralized']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
		[1,_spawnPosition] spawn (missionNamespace getVariable 'QS_fnc_smDebrief');
		{
			_x setMarkerAlpha 0;
		} count ['QS_marker_sideMarker','QS_marker_sideCircle'];
	};
	uiSleep 1;
	_time = diag_tickTime;
	if (_time > _checkDelay) then {
		{
			if (alive _x) then {
				//_x doWatch _watchPosition;
			};
		} forEach _aaHulls;
		_allAircraft = (entities _entitiesParams) select {
			_aircraftPosition = getPosATL _x;
			if (surfaceIsWater _aircraftPosition) then {
				_aircraftPosition = ATLToASL _aircraftPosition;
			};
			(((_x distance2D _spawnPosition) < _targetingRange_max) && ((_aircraftPosition select 2) > _targetingAltitudeMin))
		};
		_targetListEnemy = [];
		if (!(_allAircraft isEqualTo [])) then {
			{
				_targetCandidate = _x;
				if ((side _targetCandidate) isEqualTo WEST) then {
					if (!(((crew _targetCandidate) findIf {(alive _x)}) isEqualTo -1)) then {
						_targetType = toLower (typeOf _targetCandidate);
						if (_targetCandidate isKindOf 'Plane') then {
							if ((_targetType in _stealthAircraft) && (!(isVehicleRadarOn _targetCandidate)) && (!(isLaserOn _targetCandidate))) then {
								if ((_targetCandidate distance2D _spawnPosition) < (_targetingRange_max * _targetingRange_stealthCoef)) then {
									_targetListEnemy pushBack _targetCandidate;
								};
							} else {
								if ((!(isVehicleRadarOn _targetCandidate)) && (!(isLaserOn _targetCandidate))) then {
									if ((_targetCandidate distance2D _spawnPosition) < (_targetingRange_max * _targetingRange_stealthCoef2)) then {
										_targetListEnemy pushBack _targetCandidate;
									};
								};
							};
						} else {
							if (_targetCandidate isKindOf 'Helicopter') then {
								if ((_targetType in _stealthAircraft) && (!(isLaserOn _targetCandidate))) then {
									if ((_targetCandidate distance2D _spawnPosition) < (_targetingRange_heli * _targetingRange_stealthCoef)) then {
										_targetListEnemy pushBack _targetCandidate;
									};
								} else {
									if ((!(isVehicleRadarOn _targetCandidate)) && (!(isLaserOn _targetCandidate))) then {
										if ((_targetCandidate distance2D _spawnPosition) < (_targetingRange_heli * _targetingRange_stealthCoef2)) then {
											_targetListEnemy pushBack _targetCandidate;
										};
									};
								};
							};
						};
					};
				};
			} forEach _allAircraft;
		};
		{
			_turretParams = _x;
			_turretParams params [
				'_aaTurret',
				'_aaGunner',
				'_aaGunnerGroup',
				'_aaTurretType',
				'_aaTurretWeapon',
				'_aaNeedReload',
				'_aaReloadTimeout',
				''
			];
			if (alive _aaTurret) then {
				if ((_aaTurret ammo _aaTurretWeapon) > 0) then {
					if (!(_targetListEnemy isEqualTo [])) then {
						_targetCandidate = selectRandom _targetListEnemy;
						_aaGunner reveal [_targetCandidate,4];
						_aaTurret doTarget _targetCandidate;
						_aaTurret doWatch _targetCandidate;
						uiSleep 2;
						_aaTurret fireAtTarget [_targetCandidate,_aaTurretWeapon];
					};
				} else {
					if (_aaNeedReload isEqualTo 0) then {
						_aaNeedReload = 1;
						_aaReloadTimeout = _time + (random _rearmDelay);
						_turretParams set [5,_aaNeedReload];
						_turretParams set [6,_aaReloadTimeout];
						_aaTurrets set [_forEachIndex,_turretParams];
					} else {
						if (_time > _aaReloadTimeout) then {
							_aaTurret setVehicleAmmo 1;
							_aaNeedReload = 0;
							_turretParams set [5,_aaNeedReload];
							_turretParams set [6,_aaReloadTimeout];
							_aaTurrets set [_forEachIndex,_turretParams];
						};
					};
				};
			};
		} forEach _aaTurrets;
		_checkDelay = _time + _delay;
	};
};
{
	(missionNamespace getVariable 'QS_garbageCollector') pushBack [_x,'NOW_DISCREET',0];
} forEach (_enemyAssets + _composition + _aaTurrets);