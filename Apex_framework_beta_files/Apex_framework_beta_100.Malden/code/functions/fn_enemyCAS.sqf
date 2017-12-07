/*
File: fn_enemyCAS.sqf
Author:

	Quiksilver
	
Last modified:

	31/05/2017 A3 1.70 by Quiksilver
	
Description:

	Spawn an enemy CAS jet with some routines
______________________________________________________*/

private ['_QS_AOpos','_spawnPos','_jetSelect','_casArray','_jetLimit','_jetLimit1','_jetLimit2','_jetPilot','_jetActual','_new','_QS_v','_grp'];
if ((count _this) > 0) then {
	_QS_v = _this select 0;
} else {
	_QS_v = objNull;
};
_jetSelect = [
	'O_Plane_CAS_02_dynamicLoadout_F',
	'O_Plane_Fighter_02_F',
	'O_Plane_Fighter_02_Stealth_F',
	'I_Plane_Fighter_03_AA_F',
	'I_Plane_Fighter_03_dynamicLoadout_F',
	'I_Plane_Fighter_04_F',
	'c_plane_civil_01_racing_f',
	'I_Plane_Fighter_03_Cluster_F'
] selectRandomWeighted [
	0.3,
	0.1,
	0.1,
	0.1,
	0.3,
	0.3,
	0.1,
	0.1
];
_spawnPos = [(random worldSize),(random worldSize),2000];
_QS_AOpos = missionNamespace getVariable 'QS_AOpos';
_new = FALSE;
if (isNull (missionNamespace getVariable 'QS_enemyCasGroup')) then {
	_new = TRUE;
	missionNamespace setVariable ['QS_enemyCasGroup',(createGroup [EAST,TRUE]),FALSE];
};
_grp = missionNamespace getVariable 'QS_enemyCasGroup';
_jetPilot = (missionNamespace getVariable 'QS_enemyCasGroup') createUnit ['o_fighter_pilot_f',[-100,-100,0],[],0,'NONE'];
missionNamespace setVariable [
	'QS_analytics_entities_created',
	((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
	FALSE
];
_jetActual = createVehicle [_jetSelect,_spawnPos,[],0,'FLY'];
missionNamespace setVariable [
	'QS_analytics_entities_created',
	((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
	FALSE
];
_jetActual engineOn TRUE;
_jetActual setAirplaneThrottle 1;
_jetActual allowCrewInImmobile TRUE;
/*/
if (!((toLower (typeOf _jetActual)) in ['c_plane_civil_01_racing_f','c_plane_civil_01_racing_f'])) then {
	_jetActual flyInHeight (100 + (random 1500));
};
/*/
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
	} forEach (getArray (configFile >> 'CfgVehicles' >> _jetSelect >> 'TextureSources' >> 'Hex' >> 'textures'));
};
if ((toLower(typeOf _jetActual)) in ['c_plane_civil_01_racing_f']) then {
	[_jetActual] call (missionNamespace getVariable 'QS_fnc_Q51');
};
_jetActual lock 2;
[_jetActual,1,[]] call (missionNamespace getVariable 'QS_fnc_vehicleLoadouts');
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
			if (({(alive _x)} count (crew _vehicle)) isEqualTo 0) then {
				_vehicle setDamage [1,TRUE];
			};
		}
	],
	[
		'Killed',
		{
			params ['_jet','_killer'];
			_jet removeAllEventHandlers 'Killed';
			['EnemyJetDown',['Enemy CAS is down!']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
			if (isPlayer _killer) then {
				_name = name _killer;
				['sideChat',[WEST,'HQ'],(format ['%1 destroyed the enemy jet!',_name])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
			};
		}
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
(missionNamespace getVariable 'QS_AI_supportProviders_CASPLANE') pushBack _jetPilot;
if (missionNamespace getVariable ['QS_virtualSectors_active',FALSE]) then {
	_jetActual setVehicleReceiveRemoteTargets (missionNamespace getVariable ['QS_virtualSectors_sub_1_active',FALSE]);
	_jetActual setVehicleReportRemoteTargets (missionNamespace getVariable ['QS_virtualSectors_sub_1_active',FALSE]);
	_jetActual setVehicleReportOwnPosition (missionNamespace getVariable ['QS_virtualSectors_sub_1_active',FALSE]);
	_jetActual setVehicleRadar ([2,0] select (missionNamespace getVariable ['QS_virtualSectors_sub_1_active',FALSE]));
};
_jetPilot setVariable ['BIS_noCoreConversations',TRUE,FALSE];
_jetActual setVariable ['QS_enemyCAS_position',(getPosWorld _jetActual),FALSE];
_jetActual setVariable ['QS_enemyCAS_nextRearmTime',(time + 600),FALSE];
_jetActual setVariable ['QS_enemyQS_casJetPilot',_jetPilot,FALSE];
_jetActual setVariable ['QS_enemyQS_casJetMaxSpeed',(getNumber (configFile >> 'CfgVehicles' >> (typeOf _jetActual) >> 'maxSpeed')),FALSE];
_grp setVariable ['QS_AI_GRP',TRUE,FALSE];
_grp setVariable ['QS_AI_GRP_CONFIG',['AIR_PATROL_CAS','',_jetActual],FALSE];
_grp setVariable ['QS_AI_GRP_DATA',[TRUE,diag_tickTime],FALSE];
_grp setVariable ['QS_AI_GRP_TASK',['CAP',(missionNamespace getVariable ['QS_AOpos',[(worldSize / 2),(worldSize / 2),500]]),diag_tickTime,-1],FALSE];
if (_new) then {_jetPilot setRank 'COLONEL';} else {_jetPilot setRank 'MAJOR';};
[(units _grp),4] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
_grp move (missionNamespace getVariable ['QS_AOpos',[(worldSize / 2),(worldSize / 2),500]]);
_grp enableAttack TRUE;
_grp setCombatMode 'RED';
_grp setBehaviour 'COMBAT';
_grp setSpeedMode 'FULL';
if (!((toLower _jetSelect) in ['o_plane_fighter_02_stealth_f'])) then {
	['EnemyJet',['Enemy CAS inbound!']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
} else {
	if ((random 1) > 0.8) then {
		_jetActual forceSpeed (_jetActual getVariable ['QS_enemyQS_casJetMaxSpeed',1000]);
	};
};
missionNamespace setVariable [
	'QS_enemyCasArray2',
	((missionNamespace getVariable 'QS_enemyCasArray2') + [_jetActual]),
	FALSE
];