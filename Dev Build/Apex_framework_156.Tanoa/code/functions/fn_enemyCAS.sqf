/*
File: fn_enemyCAS.sqf
Author:

	Quiksilver
	
Last modified:

	20/04/2018 A3 1.82 by Quiksilver
	
Description:

	Spawn an enemy CAS jet with some routines
______________________________________________________*/

_playerJetCount = count (allPlayers select {((toLowerANSI (typeOf (vehicle _x))) in QS_core_classNames_planeTypesCAS_lower)});
if (((count allPlayers) < 10) && (_playerJetCount isEqualTo 0)) exitWith {};
private _jetSelect = selectRandomWeighted [
	'O_Plane_CAS_02_dynamicLoadout_F',0.3,
	'O_Plane_Fighter_02_F',([0,0.1] select (_playerJetCount > 0)),
	'O_Plane_Fighter_02_Stealth_F',([0,0.1] select (_playerJetCount > 1)),
	'I_Plane_Fighter_03_AA_F',0.1,
	'I_Plane_Fighter_03_dynamicLoadout_F',0.3,
	'I_Plane_Fighter_04_F',([0.3,0.5] select (_playerJetCount > 0)),
	'I_Plane_Fighter_03_Cluster_F',0.1
];
if ((call (missionNamespace getVariable 'QS_fnc_getActiveDLC')) isNotEqualTo '') then {
	_jetSelect = selectRandom QS_core_classNames_planeTypesEnemy_lower;
};
_spawnPos = [(random worldSize),(random worldSize),1000];
_QS_AOpos = missionNamespace getVariable 'QS_AOpos';
private _new = FALSE;
if (isNull (missionNamespace getVariable 'QS_enemyCasGroup')) then {
	_new = TRUE;
	missionNamespace setVariable ['QS_enemyCasGroup',(createGroup [EAST,TRUE]),FALSE];
};
_grp = missionNamespace getVariable 'QS_enemyCasGroup';
_jetPilot = (missionNamespace getVariable 'QS_enemyCasGroup') createUnit [QS_core_units_map getOrDefault [toLowerANSI 'o_fighter_pilot_f','o_fighter_pilot_f'],[-100,-100,0],[],0,'NONE'];
_jetPilot setVariable ['QS_dynSim_ignore',TRUE,FALSE];
_jetPilot enableDynamicSimulation FALSE;
_jetActual = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _jetSelect,_jetSelect],_spawnPos,[],0,'FLY'];
_jetActual engineOn TRUE;
_jetActual setAirplaneThrottle 1;
_jetActual allowCrewInImmobile [TRUE,TRUE];
if (!((toLowerANSI (typeOf _jetActual)) in ['c_plane_civil_01_racing_f','c_plane_civil_01_racing_f'])) then {
	if ((toLowerANSI (typeOf _jetActual)) in ['o_plane_fighter_02_f','o_plane_fighter_02_stealth_f','o_plane_fighter_02_cluster_f']) then {
		_jetActual setVariable ['QS_AI_PLANE_flyInHeight',(selectRandom [2,3]),FALSE];
	} else {
		_jetActual setVariable ['QS_AI_PLANE_flyInHeight',(selectRandom [1,2]),FALSE];
	};
	_jetActual flyInHeight [(500 + (random 1000)),TRUE];
	_jetActual addEventHandler [
		'Hit',
		{
			if ((random 1) > 0.5) then {
				params ['_vehicle','_causedBy','_damage','_instigator'];
				if (!(_vehicle getVariable ['QS_AI_PLANE_fireMission',FALSE])) then {
					if (!isNull _causedBy) then {
						if (_causedBy isKindOf 'Plane') then {
							_altATL = (getPosATL _vehicle) # 2;
							_vehicle flyInHeight [(_altATL + (100 - (random 200))),TRUE];
						};
					};
				};
			};
		}
	];
};
if ((random 1) > 0.333) then {
	if (_jetActual isKindOf 'I_Plane_Fighter_03_dynamicLoadout_F') then {
		_jetActual removeWeapon 'missiles_SCALPEL';
	};
	if (_jetActual isKindOf 'O_Plane_CAS_02_dynamicLoadout_F') then {
		_jetActual removeWeapon 'Missile_AGM_01_Plane_CAS_02_F';
	};
};
if (_jetActual isKindOf 'I_Plane_Fighter_03_Cluster_F') then {
	{ 
		_jetActual setObjectTextureGlobal [_forEachIndex,_x]; 
	} forEach (getArray ((configOf _jetActual) >> 'TextureSources' >> 'Hex' >> 'textures'));
};
if ((toLowerANSI(typeOf _jetActual)) in ['c_plane_civil_01_racing_f']) then {
	[_jetActual] call (missionNamespace getVariable 'QS_fnc_Q51');
};
_jetActual lock 2;
if (!(['cluster',(typeOf _jetActual),FALSE] call (missionNamespace getVariable 'QS_fnc_inString'))) then {
	[_jetActual,([1,2] select ((random 1) > 0.666)),[]] call (missionNamespace getVariable 'QS_fnc_vehicleLoadouts');
} else {
	[_jetActual,1,[]] call (missionNamespace getVariable 'QS_fnc_vehicleLoadouts');
};
_jetPilot addEventHandler [
	'Killed',
	{
		(vehicle _jetPilot) setDamage [1,TRUE];
	}
];
{
	_jetActual addEventHandler _x;
} forEach [
	['Landing',{}],
	['LandingCanceled',{}],
	[
		'LandedTouchDown',
		{
			params ['_plane','_airportID'];
			_plane setDamage [1,TRUE];
		}
	],
	['Deleted',{}],
	['Fuel',{}],
	[
		'GetOut',
		{
			params ['_vehicle','_position','_unit','_turret'];
			_unit setDamage [1,TRUE];
			if (((crew _vehicle) findIf {(alive _x)}) isEqualTo -1) then {
				_vehicle setDamage [1,TRUE];
			};
		}
	],
	[
		'Killed',
		{
			params ['_jet','_killer'];
			_jet removeAllEventHandlers 'Hit';
			if (!isNull _killer) then {
				['EnemyJetDown',[localize 'STR_QS_Notif_053']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
			};
		}
	],
	[
		'Killed',
		(missionNamespace getVariable 'QS_fnc_vKilled2')
	],
	[
		'IncomingMissile',
		{call (missionNamespace getVariable 'QS_fnc_AIXMissileCountermeasure')}
	]
];
['setFeatureType',_jetActual,2] remoteExec ['QS_fnc_remoteExecCmd',-2,_jetActual];
_jetPilot assignAsDriver _jetActual;
_jetPilot moveInDriver _jetActual;
_jetPilot enableStamina FALSE;
_jetPilot enableFatigue FALSE;
_grp addVehicle _jetActual;
removeAllWeapons _jetPilot;
removeAllItems _jetPilot;
missionNamespace setVariable ['QS_AI_supportProviders_CASPLANE',((missionNamespace getVariable 'QS_AI_supportProviders_CASPLANE') + [_jetPilot]),QS_system_AI_owners];
missionNamespace setVariable ['QS_AI_supportProviders_INTEL',((missionNamespace getVariable 'QS_AI_supportProviders_INTEL') + [_jetPilot]),QS_system_AI_owners];
if (missionNamespace getVariable ['QS_virtualSectors_active',FALSE]) then {
	_jetActual setVehicleReceiveRemoteTargets (missionNamespace getVariable ['QS_virtualSectors_sub_1_active',FALSE]);
	_jetActual setVehicleReportRemoteTargets (missionNamespace getVariable ['QS_virtualSectors_sub_1_active',FALSE]);
	_jetActual setVehicleReportOwnPosition (missionNamespace getVariable ['QS_virtualSectors_sub_1_active',FALSE]);
	_jetActual setVehicleRadar ([2,0] select (missionNamespace getVariable ['QS_virtualSectors_sub_1_active',FALSE]));
};
_jetPilot setVariable ['BIS_noCoreConversations',TRUE,FALSE];
_jetActual setVariable ['QS_enemyCAS_position',(getPosWorld _jetActual),FALSE];
_jetActual setVariable ['QS_enemyCAS_nextRearmTime',(serverTime + 300),FALSE];
_jetActual setVariable ['QS_enemyQS_casJetPilot',_jetPilot,FALSE];
_jetActual setVariable ['QS_enemy_casJetMaxSpeed',(getNumber ((configOf _jetActual) >> 'maxSpeed')),FALSE];
_grp setGroupIdGlobal ['Combat Air Patrol'];
_grp addEventHandler ['EnemyDetected',{call (missionNamespace getVariable 'QS_fnc_AIGroupEventEnemyDetected2')}];
_grp setVariable ['QS_AI_GRP',TRUE,FALSE];
_grp setVariable ['QS_AI_GRP_CONFIG',['AIR_PATROL_CAS','',_jetActual],FALSE];
_grp setVariable ['QS_AI_GRP_DATA',[TRUE,serverTime],FALSE];
_grp setVariable ['QS_AI_GRP_TASK',['CAP',(missionNamespace getVariable ['QS_AOpos',[(worldSize / 2),(worldSize / 2),500]]),serverTime,-1],FALSE];
if (_new) then {_jetPilot setRank 'COLONEL';} else {_jetPilot setRank 'MAJOR';};
[(units _grp),4] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
_grp move (missionNamespace getVariable ['QS_AOpos',[(worldSize / 2),(worldSize / 2),500]]);
_grp enableAttack TRUE;
_grp setCombatMode 'RED';
_grp setCombatBehaviour 'COMBAT';
_grp setBehaviourStrong 'COMBAT';
_grp setSpeedMode 'FULL';
[9,EAST,_grp,(leader _grp),_jetActual] call (missionNamespace getVariable 'QS_fnc_AIGetKnownEnemies');
if (!((toLowerANSI _jetSelect) in ['o_plane_fighter_02_stealth_f'])) then {
	if (!(missionNamespace getVariable ['QS_defendActive',FALSE])) then {
		['EnemyJet',[localize 'STR_QS_Notif_054']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
	};
} else {
	if ((random 1) > 0.8) then {
		_jetActual forceSpeed (_jetActual getVariable ['QS_enemy_casJetMaxSpeed',1000]);
	};
};
(missionNamespace getVariable 'QS_enemyCasArray2') pushBack _jetActual;