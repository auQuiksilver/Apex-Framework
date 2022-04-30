/*
@file: destroyRadar.sqf
Author:

	Quiksilver
	
Last modified:

	24/06/2016 A3 1.62 by Quiksilver
	
Description:

	Get radar telemetry from enemy radar site, then destroy it.
	
Notes:

	Deprecated mission
_________________________________________________________________________*/

scriptName 'Side Mission - Secure Radar';

private [
	"_objPos","_flatPos","_accepted","_position","_randomDir","_hangar","_x","_enemiesArray",
	"_briefing","_fuzzyPos","_unitsArray","_dummy","_object","_tower1","_tower2","_tower3",'_c4Messages',
	'_c4Message','_dummyTypes','_dummyType','_objectTypes','_objectType','_objectsArray'
];

missionNamespace setVariable ['QS_sidemission_objectsArray',[],FALSE];
missionNamespace setVariable ['QS_sideObj',objNull,FALSE];
_objectsArray = [];
_c4Messages = [
	"Radar data secured. The charge has been set! 15 seconds until detonation.",
	"Radar telemetry secured. The explosives have been set! 15 seconds until detonation.",
	"Radar intel secured. The charge is planted! 15 seconds until detonation."
];
_c4Message = selectRandom _c4Messages;

/*/------------------- FIND SAFE POSITION FOR OBJECTIVE/*/
_flatPos = [0,0,0];
_accepted = false;
while {!_accepted} do {
	_flatPos = ['WORLD',-1,-1,'LAND',[10,-1,0.2,20,0,FALSE,objNull],TRUE,[],[],TRUE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
	if ((_flatPos distance (markerPos 'QS_marker_base_marker')) > 1700) then {
		if ((_flatPos distance (markerPos 'QS_marker_Almyra_blacklist_area')) > 2000) then {
			if (missionNamespace getVariable 'QS_module_fob_enabled') then {
				if ((_flatPos distance (markerPos 'QS_marker_module_fob')) < 4000) then {
					if ((_flatPos distance (markerPos 'QS_marker_module_fob')) > 1000) then {
						_accepted = TRUE;
					};
				};
			} else {
				_accepted = TRUE;
			};
		};
	};
	if (_accepted) exitWith {};
};

/*/------------------- SPAWN OBJECTIVE/*/

_objectsArray = [
	_flatPos,
	(random 360),
	(call (missionNamespace getVariable 'QS_site_radar'))
] call (missionNamespace getVariable 'QS_fnc_serverObjectsMapper');
waitUntil {
	sleep 0.01;
	(!isNull (missionNamespace getVariable 'QS_sideObj'))
};
sleep 1;
_dummyTypes = ['Box_East_AmmoOrd_F','Box_IND_AmmoOrd_F'];
_dummyType = selectRandom _dummyTypes;
_researchTable = createVehicle ['Land_CampingTable_small_F',[0,0,0],[],0,'NONE'];
missionNamespace setVariable [
	'QS_analytics_entities_created',
	((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
	FALSE
];
_researchTable attachTo [(missionNamespace getVariable 'QS_sm_radarHouse'),[0,3,0.45]];
_objectTypes = ['Land_Laptop_03_black_F','Land_Laptop_device_F'];
_objectType = selectRandom _objectTypes;
_object = createVehicle [_objectType,[0,0,0],[],0,'NONE'];
missionNamespace setVariable [
	'QS_analytics_entities_created',
	((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
	FALSE
];
_object enableSimulationGlobal TRUE;
_object attachTo [(missionNamespace getVariable 'QS_sm_radarHouse'),[0,3,1]];
for '_x' from 0 to 2 step 1 do {
	_object setVariable ['QS_secureable',TRUE,TRUE];
	_object setVariable ['QS_isExplosion',TRUE,TRUE];
};

/*/------------------- SPAWN FORCE PROTECTION/*/

_enemiesArray = [(missionNamespace getVariable 'QS_sideObj')] call (missionNamespace getVariable 'QS_fnc_smEnemyEast');

/*/------------------- BRIEF/*/

_fuzzyPos = [((_flatPos select 0) - 300) + (random 600),((_flatPos select 1) - 300) + (random 600),0];
{
	_x setMarkerPos _fuzzyPos;
	_x setMarkerAlpha 1;
} count ['QS_marker_sideMarker','QS_marker_sideCircle'];
'QS_marker_sideMarker' setMarkerText (format ['%1Secure Radar',(toString [32,32,32])]);

[
	'QS_IA_TASK_SM_0',
	TRUE,
	[
		'We have located an enemy radar installation. It appears to be under-defended, so this is our chance to learn more about enemy Anti-Air capabilities. Get over there and secure the radar intel. It will be located in a building near the dome. Be careful, once tampered with, the radar will self-destruct. This objective is not accurately marked.',
		'Secure Radar',
		'Secure Radar'
	],
	(markerPos 'QS_marker_sideMarker'),
	'CREATED',
	5,
	FALSE,
	TRUE,
	'download',
	TRUE
] call (missionNamespace getVariable 'BIS_fnc_setTask');

_briefing = parseText "<t align='center'><t size='2.2'>New Side Mission</t><br/><t size='1.5' color='#00B2EE'>Secure Radar</t><br/>____________________<br/>OPFOR have captured a small radar on the island to support their aircraft.<br/><br/>We've marked the position on your map; head over there and secure the site. Take the data and destroy it.</t>";
//['hint',_briefing] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
['NewSideMission',['Secure Radar']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
missionNamespace setVariable ['QS_sideMissionUp',TRUE,TRUE];
missionNamespace setVariable ['QS_smSuccess',FALSE,TRUE];

for '_x' from 0 to 1 step 0 do {

	if (!alive (missionNamespace getVariable 'QS_sideObj')) exitWith {
		
		/*/------------------ DE-BRIEFING/*/

		['sideChat',[WEST,'HQ'],'Intel destroyed, mission FAILED!'] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
		[0,_flatPos] spawn (missionNamespace getVariable 'QS_fnc_smDebrief');
		{
			_x setMarkerPos [-5000,-5000,0];
			_x setMarkerAlpha 0;
		} count ['QS_marker_sideMarker','QS_marker_sideCircle'];
		missionNamespace setVariable ['QS_sideMissionUp',FALSE,TRUE];
		
		/*/------------------- DELETE/*/
		
		{
			missionNamespace setVariable [
				'QS_analytics_entities_deleted',
				((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),
				FALSE
			];
			deleteVehicle _x;
		} forEach [_object,_researchTable];			/*/ hide objective pieces/*/
		sleep 120;
		{
			if (_x isEqualType objNull) then {
				0 = QS_garbageCollector pushBack [_x,'NOW_DISCREET',0];
			};
		} count (_enemiesArray + _objectsArray);
	};
	
	if (missionNamespace getVariable 'QS_smSuccess') exitWith {
		
		['sideChat',[WEST,'HQ'],_c4Message] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
	
		/*/------------------- BOOM!/*/
		
		_dummy = createVehicle [_dummyType,[0,0,0],[],0,'NONE'];
		missionNamespace setVariable [
			'QS_analytics_entities_created',
			((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
			FALSE
		];
		_dummy setPosWorld [((getPosWorld (missionNamespace getVariable 'QS_sideObj')) select 0), (((getPosWorld (missionNamespace getVariable 'QS_sideObj')) select 1) +5), (((getPosWorld (missionNamespace getVariable 'QS_sideObj')) select 2) + 0.5)];
		sleep 0.1;
		missionNamespace setVariable [
			'QS_analytics_entities_deleted',
			((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),
			FALSE
		];
		deleteVehicle _object;
		uiSleep 12;											/*/ghetto bomb timer/*/
		'Bo_Mk82' createVehicle (getPos _dummy); 			/*/ default "Bo_Mk82","Bo_GBU12_LGB"/*/
		missionNamespace setVariable [
			'QS_analytics_entities_created',
			((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
			FALSE
		];
		(missionNamespace getVariable 'QS_sideObj') setDamage 1;
		missionNamespace setVariable [
			'QS_analytics_entities_deleted',
			((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),
			FALSE
		];
		deleteVehicle _dummy;
		missionNamespace setVariable [
			'QS_analytics_entities_deleted',
			((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),
			FALSE
		];
		deleteVehicle _researchTable;
		sleep 0.1;
	
		/*/------------------ DE-BRIEFING/*/

		[1,_flatPos] spawn (missionNamespace getVariable 'QS_fnc_smDebrief');
		{
			_x setMarkerPos [-5000,-5000,0];
			_x setMarkerAlpha 0;
		} count ['QS_marker_sideMarker','QS_marker_sideCircle'];
		missionNamespace setVariable ['QS_sideMissionUp',FALSE,TRUE];
	
		/*/-------------------- DELETE/*/
		sleep 120;
		{
			if (_x isEqualType objNull) then {
				0 = QS_garbageCollector pushBack [_x,'NOW_DISCREET',0];
			};
		} count (_enemiesArray + _objectsArray);
	};
	sleep 1;
};