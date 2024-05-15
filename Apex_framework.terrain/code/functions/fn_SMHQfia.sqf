/*
@file: HQfia.sqf
Author:

	Quiksilver
	
Last modified:

	24/04/2014
	
Description:

	Secure HQ supplies before destroying it.
	
Notes:

	Deprecated mission, needs overhaul with composition instead of solitary building
____________________________________*/

scriptName 'Side Mission - Insurgency';

private [
	"_flatPos","_accepted","_position","_enemiesArray","_fuzzyPos","_x","_briefing",
	"_unitsArray","_object","_SMveh","_SMaa","_tower1","_tower2","_tower3","_c4Message",'_c4Messages','_objectTypes','_objectType'
];
_c4Messages = [
	localize 'STR_QS_Chat_061',
	localize 'STR_QS_Chat_062',
	localize 'STR_QS_Chat_063'
];
_c4Message = selectRandom _c4Messages;

/*/-------------------- FIND POSITION FOR OBJECTIVE/*/

_flatPos = [0,0,0];
_accepted = false;
_baseMarker = markerPos 'QS_marker_base_marker';
_almyraMarker = markerPos 'QS_marker_Almyra_blacklist_area';
while {!_accepted} do {
	_flatPos = ['WORLD',-1,-1,'LAND',[10,0,0.2,(sizeOf 'Land_Dome_Small_F'),0,FALSE,objNull],TRUE,[],[],TRUE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
	if ((_flatPos distance (markerPos "QS_marker_base_marker")) > 1700) then {
		if ((_flatPos distance (markerPos "Almyra_blacklist_area")) > 2000) then {
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

/*/-------------------- SPAWN OBJECTIVE/*/

missionNamespace setVariable [
	'QS_sideObj',
	(createVehicle ['Land_Cargo_HQ_V2_F',[(_flatPos # 0),(_flatPos # 1),0],[],0,'NONE']),
	FALSE
];
(missionNamespace getVariable 'QS_sideObj') setPosWorld [((getPosWorld (missionNamespace getVariable 'QS_sideObj')) # 0), ((getPosWorld (missionNamespace getVariable 'QS_sideObj')) # 1),((getPosWorld (missionNamespace getVariable 'QS_sideObj')) # 2)];
(missionNamespace getVariable 'QS_sideObj') setVectorUp [0,0,1];

_objectTypes = ['Land_CargoBox_V1_F','CargoNet_01_barrels_F'];
_objectType = selectRandom _objectTypes;
_object = createVehicle [_objectType,[0,0,0],[],0,'NONE'];
_object setPosWorld [((getPosWorld (missionNamespace getVariable 'QS_sideObj')) # 0),((getPosWorld (missionNamespace getVariable 'QS_sideObj')) # 1),(((getPosWorld (missionNamespace getVariable 'QS_sideObj')) # 2) + 2)];
_object enableRopeAttach FALSE;
_object enableSimulationGlobal TRUE;

for '_x' from 0 to 2 step 1 do {
	_object setVariable ['QS_secureable',TRUE,TRUE];
	_object setVariable ['QS_isExplosion',TRUE,TRUE];
};

_tower1Pos = [_flatPos # 0,_flatPos # 1,0] getPos [50,0];
_tower2Pos = [_flatPos # 0,_flatPos # 1,0] getPos [50,120];
_tower3Pos = [_flatPos # 0,_flatPos # 1,0] getPos [50,240];
_tower1 = createVehicle ['Land_Cargo_Patrol_V2_F',[_tower1Pos # 0,_tower1Pos # 1,0],[],0,'NONE'];
_tower2 = createVehicle ['Land_Cargo_Patrol_V2_F',[_tower2Pos # 0,_tower2Pos # 1,0],[],0,'NONE'];
_tower3 = createVehicle ['Land_Cargo_Patrol_V2_F',[_tower3Pos # 0,_tower3Pos # 1,0],[],0,'NONE'];
_tower1 setDir 180;
_tower2 setDir 300;
_tower3 setDir 60;
{_x allowDamage FALSE;} forEach [_tower1,_tower2,_tower3];

/*/-------------------- SPAWN FORCE PROTECTION/*/

_enemiesArray = [(missionNamespace getVariable 'QS_sideObj')] call (missionNamespace getVariable 'QS_fnc_smEnemyGuer');

/*/-------------------- SPAWN BRIEFING/*/

_fuzzyPos = [((_flatPos # 0) - 300) + (random 600),((_flatPos # 1) - 300) + (random 600),0];
{
	_x setMarkerPosLocal _fuzzyPos;
	_x setMarkerAlpha 1;
} count ['QS_marker_sideMarker','QS_marker_sideCircle'];
'QS_marker_sideMarker' setMarkerText (format ['%1 %2',(toString [32,32,32]),localize 'STR_QS_Marker_031']);

[
	'QS_IA_TASK_SM_0',
	TRUE,
	[
		(format [
			'%2 %1, %3',
			worldName,
			localize 'STR_QS_Task_077',
			localize 'STR_QS_Task_078'
		]),
		localize 'STR_QS_Task_079',
		localize 'STR_QS_Task_079'
	],
	(markerPos 'QS_marker_sideMarker'),
	'CREATED',
	5,
	FALSE,
	TRUE,
	'download',
	TRUE
] call (missionNamespace getVariable 'BIS_fnc_setTask');
['NewSideMission',[localize 'STR_QS_Notif_085']] remoteExec ['QS_fnc_showNotification',-2,FALSE];

/*/-------------------- [ CORE LOOPS ] ------------------------ [ CORE LOOPS ]/*/

missionNamespace setVariable ['QS_sideMissionUp',TRUE,TRUE];
missionNamespace setVariable ['QS_smSuccess',FALSE,TRUE];

for '_x' from 0 to 1 step 0 do {

	/*/--------------------------------------------- IF PACKAGE DESTROYED [FAIL]/*/

	if (!alive (missionNamespace getVariable 'QS_sideObj')) exitWith {
	
		{
			_x setMarkerPosLocal [-5000,-5000,0];
			_x setMarkerAlpha 0;
		} count ['QS_marker_sideMarker','QS_marker_sideCircle'];
		
		/*/-------------------- DE-BRIEFING/*/

		missionNamespace setVariable ['QS_sideMissionUp',FALSE,TRUE];
		['sideChat',[WEST,'HQ'],localize 'STR_QS_Chat_060'] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
		[0,_flatPos] spawn (missionNamespace getVariable 'QS_fnc_smDebrief');

		/*/-------------------- DELETE/*/
		
		deleteVehicle _object;
		sleep 120;
		deleteVehicle [(missionNamespace getVariable 'QS_sideObj'),_tower1,_tower2,_tower3];
		{
			if (_x isEqualType objNull) then {
				0 = QS_garbageCollector pushBack [_x,'NOW_DISCREET',0];
			};
		} count _enemiesArray;
	};
	
	/*/----------------------------------------------- IF PACKAGE SECURED [SUCCESS]/*/
	
	if (missionNamespace getVariable 'QS_smSuccess') exitWith {
	
		{
			_x setMarkerPos [-5000,-5000,0];
			_x setMarkerAlpha 0;
		} count ['QS_marker_sideMarker','QS_marker_sideCircle'];
		['sideChat',[WEST,'HQ'],_c4Message] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
	
		/*/-------------------- BOOM!/*/
	
		uiSleep 14;											/*/ ghetto bomb timer/*/
		'Bo_Mk82' createVehicle (getPosATL _object); 			/*/ default "Bo_Mk82"/*/
		uiSleep 0.1;
		deleteVehicle _object;
	
		/*/-------------------- DE-BRIEFING/*/

		missionNamespace setVariable ['QS_sideMissionUp',FALSE,TRUE];
		[1,_flatPos] spawn (missionNamespace getVariable 'QS_fnc_smDebrief');
	
		/*/--------------------- DELETE/*/
		sleep 120;
		deleteVehicle [(missionNamespace getVariable 'QS_sideObj'),_tower1,_tower2,_tower3];
		{
			if (_x isEqualType objNull) then {
				0 = QS_garbageCollector pushBack [_x,'NOW_DISCREET',0];
			};
		} count _enemiesArray;
	};
	sleep 2;
};