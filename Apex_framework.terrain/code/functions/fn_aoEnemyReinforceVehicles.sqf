/*/
File: fn_aoEnemyReinforceVehicles.sqf
Author:

	Quiksilver
	
Last modified:

	25/03/2018 A3 1.82 by Quiksilver
	
Description:

	Enemy reinforce AO
__________________________________________________/*/

params ['_pos'];
private [
	'_base','_foundSpawnPos','_spawnPosDefault','_reinforceGroup','_infTypes','_infType','_destination','_count','_wp','_ticker','_playerSelected','_arr','_playerPos',
	'_vehTypes','_QS_array','_minDist','_maxDist','_nearRoads','_roadsValid','_roadRoadValid','_fn_blacklist'
];
_worldName = worldName;
_worldSize = worldSize;
_allPlayers = allPlayers;
_QS_array = [];
_destination = [0,0,0];
if (_worldName isEqualTo 'Tanoa') then {
	_minDist = 1200;
	_maxDist = 2400;
	_fn_blacklist = {
		private _c = TRUE;
		{
			if ((_this distance2D (_x select 0)) < (_x select 1)) exitWith {
				_c = FALSE;
			};
		} count [
			[[13415.7,5194.57,0.00172806],350],
			[[12897.9,5442.16,0.00107098],175],
			[[2257.59,1664.31,0.00162601],90],
			[[3681.47,9377.08,0.00176811],400],
			[[11440.4,14422,0.0013628],275]
		];
		_c;
	};
} else {
	_minDist = 1500;
	_maxDist = 3500;
	_fn_blacklist = {TRUE};
};

/*/================================================ FIND POSITION/*/
_roadsValid = [];
_validRoadSurfaces = ['#gdtreddirt','#gdtasphalt','#gdtsoil','#gdtconcrete'];
_ticker = 0;
_base = markerPos 'QS_marker_base_marker';
_foundSpawnPos = FALSE;
for '_x' from 0 to 499 step 1 do {
	_roadRoadValid = [0,0,0];
	_spawnPosDefault = [_pos,_minDist,_maxDist,5,0,0.5,0] call (missionNamespace getVariable 'QS_fnc_findSafePos');
	if ((_allPlayers inAreaArray [_spawnPosDefault,500,500,0,FALSE]) isEqualTo []) then {
		if (_spawnPosDefault call _fn_blacklist) then {
			if (!([_spawnPosDefault,_pos,25] call (missionNamespace getVariable 'QS_fnc_waterIntersect'))) then {
				if (!(_spawnPosDefault isEqualTo [])) then {
					_nearRoads = ((_spawnPosDefault select [0,2]) nearRoads 250) select {((_x isEqualType objNull) && (!((roadsConnectedTo _x) isEqualTo [])))};
					if (!(_nearRoads isEqualTo [])) then {
						{
							if ((toLower (surfaceType (getPosATL _x))) in _validRoadSurfaces) then {
								0 = _roadsValid pushBack (getPosATL _x);
							};
						} count _nearRoads;
						if (!(_roadsValid isEqualTo [])) then {
							_roadRoadValid = selectRandom _roadsValid;
						};
					};
				};
			};
		};
	};
	if (!(_roadRoadValid isEqualTo [0,0,0])) exitWith {};
};
if (_roadRoadValid isEqualTo [0,0,0]) then {
	_roadRoadValid = _spawnPosDefault;
};

/*/================================================ SELECT + SPAWN UNITS/*/

_reinforceGroup = createGroup [EAST,TRUE];
_vType = selectRandomWeighted ([0] call (missionNamespace getVariable 'QS_fnc_getAIMotorPool'));
_v = createVehicle [_vType,_roadRoadValid,[],0,'NONE'];
missionNamespace setVariable [
	'QS_analytics_entities_created',
	((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
	FALSE
];
_v setVariable ['QS_dynSim_ignore',TRUE,TRUE];
_v allowCrewInImmobile TRUE;
_v setUnloadInCombat [TRUE,FALSE];
_v enableRopeAttach FALSE;
_v enableVehicleCargo FALSE;
_v forceFollowRoad TRUE;
_v setConvoySeparation 50;
_v limitSpeed (50 + (random [10,20,30]));
[0,_v,EAST,1] call (missionNamespace getVariable 'QS_fnc_vSetup2');
clearMagazineCargoGlobal _v;
clearWeaponCargoGlobal _v;
clearItemCargoGlobal _v;
clearBackpackCargoGlobal _v;
_v lock 3;
private _vCrewGroup = createVehicleCrew _v;
if (!((side _vCrewGroup) in [EAST,RESISTANCE])) then {
	_vCrewGroup = createGroup [EAST,TRUE];
	{
		[_x] joinSilent _vCrewGroup;
	} forEach (crew _v);
};
(missionNamespace getVariable 'QS_AI_vehicles') pushBack _v;
missionNamespace setVariable [
	'QS_analytics_entities_created',
	((missionNamespace getVariable 'QS_analytics_entities_created') + (count (crew _v))),
	FALSE
];
_vCrewGroup setVariable ['QS_dynSim_ignore',TRUE,TRUE];
_vCrewGroup addVehicle _v;
_v addEventHandler ['Killed',(missionNamespace getVariable 'QS_fnc_vKilled2')];
_v addEventHandler ['GetOut',(missionNamespace getVariable 'QS_fnc_AIXDismountDisabled')];
_QS_array pushBack _v;
{
	_x setVariable ['QS_dynSim_ignore',TRUE,TRUE];
	_x call (missionNamespace getVariable 'QS_fnc_unitSetup');
	_x setVariable ['BIS_noCoreConversations',TRUE,FALSE];
	0 = _QS_array pushBack _x;
} forEach (crew _v);
[(units _vCrewGroup),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
(gunner _v) setSkill ['aimingAccuracy',0.075];
(gunner _v) doWatch (missionNamespace getVariable 'QS_HQpos');
if (!isNull (commander _v)) then {
	(commander _v) doWatch (missionNamespace getVariable 'QS_HQpos');
};
(driver _v) doMove (missionNamespace getVariable 'QS_HQpos');
_ticker = 0;
_vCrewGroup setVariable ['QS_AI_GRP_CONFIG',['GENERAL','VEHICLE',(count (units _vCrewGroup)),_v],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
_vCrewGroup setVariable ['QS_AI_GRP_DATA',[TRUE,diag_tickTime],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
_vCrewGroup setVariable [
	'QS_AI_GRP_TASK',
	[
		'PATROL',
		[
			((missionNamespace getVariable 'QS_HQpos') getPos [(50 + (random 50)),(random 360)]),
			((missionNamespace getVariable 'QS_HQpos') getPos [(50 + (random 50)),(random 360)]),
			((missionNamespace getVariable 'QS_HQpos') getPos [(50 + (random 50)),(random 360)])
		],
		diag_tickTime,
		-1
	],
	FALSE
];
_vCrewGroup setVariable ['QS_AI_GRP_PATROLINDEX',0,FALSE];
_vCrewGroup setVariable ['QS_AI_GRP',TRUE,(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
_vCrewGroup setVariable ['QS_GRP_HC',TRUE,FALSE];
{
	_x enableStamina FALSE;
	_x enableFatigue FALSE;
	_x disableAI 'AUTOCOMBAT';
} count (units _vCrewGroup);
_vCrewGroup enableAttack TRUE;
if ((toLower _vType) in [
	'o_mrap_02_f','o_mrap_02_gmg_f','o_mrap_02_hmg_f','o_lsv_02_armed_f','o_lsv_02_unarmed_f','o_t_mrap_02_ghex_f','o_t_mrap_02_gmg_ghex_f','o_t_mrap_02_hmg_ghex_f','o_t_lsv_02_armed_f','o_t_lsv_02_unarmed_f',
	'i_mrap_03_f','i_mrap_03_gmg_f','i_mrap_03_hmg_f','o_g_offroad_01_armed_f','o_g_offroad_01_f','i_g_offroad_01_armed_f','i_g_offroad_01_f',
	'i_truck_02_transport_f','i_truck_02_covered_f','o_truck_02_transport_f','o_truck_02_covered_f',
	'o_ugv_01_f','o_ugv_01_rcws_f','o_t_ugv_01_rcws_ghex_f','o_t_ugv_01_ghex_f','i_ugv_01_f','i_ugv_01_rcws_f',
	'o_lsv_02_at_f','o_g_offroad_01_at_f','i_c_offroad_02_at_f','i_c_offroad_02_lmg_f','i_g_offroad_01_at_f','o_t_lsv_02_at_f'
]) then {
	if (diag_fps > 15) then {
		if (!(allPlayers isEqualTo [])) then {
			if ((random 1) > 0.5) then {
				if (missionNamespace getVariable ['QS_AI_insertHeli_enabled',FALSE]) then {
					if (({(alive _x)} count (missionNamespace getVariable ['QS_AI_insertHeli_helis',[]])) < (missionNamespace getVariable ['QS_AI_insertHeli_maxHelis',3])) then {
						if (diag_tickTime > ((missionNamespace getVariable ['QS_AI_insertHeli_lastEvent',-1]) + (missionNamespace getVariable ['QS_AI_insertHeli_cooldown',600]))) then {
							if ((missionNamespace getVariable ['QS_AI_insertHeli_spawnedAO',0]) < (missionNamespace getVariable ['QS_AI_insertHeli_maxAO',3])) then {
								if (([4,EAST,(missionNamespace getVariable 'QS_aoPos'),2000] call (missionNamespace getVariable 'QS_fnc_AIGetKnownEnemies')) isEqualTo 0) then {
									if (([3,EAST,(missionNamespace getVariable 'QS_aoPos'),2000] call (missionNamespace getVariable 'QS_fnc_AIGetKnownEnemies')) isEqualTo 0) then {
										missionNamespace setVariable ['QS_AI_insertHeli_spawnedAO',((missionNamespace getVariable 'QS_AI_insertHeli_spawnedAO') + 1),FALSE];
										missionNamespace setVariable ['QS_AI_insertHeli_lastEvent',diag_tickTime,FALSE];
										_v enableRopeAttach TRUE;
										_v enableVehicleCargo TRUE;
										private _insertHeliType = '';
										if ((toLower _vType) in [
											'o_mrap_02_f','o_mrap_02_gmg_f','o_mrap_02_hmg_f','o_lsv_02_armed_f','o_lsv_02_unarmed_f','o_t_mrap_02_ghex_f','o_t_mrap_02_gmg_ghex_f','o_t_mrap_02_hmg_ghex_f','o_t_lsv_02_armed_f','o_t_lsv_02_unarmed_f',
											'i_mrap_03_f','i_mrap_03_gmg_f','i_mrap_03_hmg_f','i_truck_02_transport_f','i_truck_02_covered_f','o_truck_02_transport_f','o_truck_02_covered_f',
											'o_ugv_01_f','o_ugv_01_rcws_f','o_t_ugv_01_rcws_ghex_f','o_t_ugv_01_ghex_f','i_ugv_01_f','i_ugv_01_rcws_f','o_lsv_02_at_f','o_t_lsv_02_at_f'
										]) then {
											_insertHeliType = ['O_Heli_Transport_04_F','O_Heli_Transport_04_black_F'] select (_worldName isEqualTo 'Tanoa');
										};
										if ((toLower _vType) in [
											'o_g_offroad_01_armed_f','o_g_offroad_01_f','i_g_offroad_01_armed_f','i_g_offroad_01_f','o_g_offroad_01_at_f','i_c_offroad_02_at_f','i_c_offroad_02_lmg_f','i_g_offroad_01_at_f'
										]) then {
											_insertHeliType = ['O_Heli_Light_02_unarmed_F','O_Heli_Light_02_unarmed_F'] select (_worldName isEqualTo 'Tanoa');
										};
										if (!(_insertHeliType isEqualTo '')) then {
											[
												_pos,
												_v,
												_insertHeliType,
												EAST
											] call (missionNamespace getVariable 'QS_fnc_AIXHeliInsertVehicle');
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
_QS_array;