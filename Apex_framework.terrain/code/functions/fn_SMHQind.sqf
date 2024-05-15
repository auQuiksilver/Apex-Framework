/*
Author:

	Quiksilver
	
Last modified:

	3/05/2016 A3 1.58 by Quiksilver
	
Description:

	Secure HQ supplies before destroying it.

Notes:

	Deprecated mission, needs overhaul with composition instead of solitary building
____________________________________*/

scriptName 'Side Mission - AA Launchers';

private [
	"_flatPos","_accepted","_position","_enemiesArray","_fuzzyPos","_x","_briefing","_unitsArray","_object",
	"_SMveh","_SMaa","_tower1","_tower2","_tower3","_flatPos1","_flatPos2",'_objectTypes','_objectType','_c4Messages','_c4Message',
	'_baseMarker','_almyraMarker','_sideObj','_houseType'
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
	if ((_flatPos distance2D _baseMarker) > 1700) then {
		if ((_flatPos distance2D _almyraMarker) > 2000) then {
			if (missionNamespace getVariable 'QS_module_fob_enabled') then {
				if ((_flatPos distance (markerPos 'QS_marker_module_fob')) < 4000) then {
					if ((_flatPos distance (markerPos 'QS_marker_module_fob')) > 500) then {
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
_flatPos1 = _flatPos getPos [15,50];
_flatPos2 = _flatPos getPos [15,80];

/*/-------------------- SPAWN OBJECTIVE/*/

if (worldName isEqualTo 'Tanoa') then {
	_houseType = 'Land_Cargo_House_V4_F';
} else {
	_houseType = 'Land_Cargo_House_V2_F';
};
_objDir = random 360;/*/_sideObj/*/
missionNamespace setVariable [
	'QS_sideObj',
	(createVehicle [_houseType,[_flatPos # 0,_flatPos # 1,0],[],0,'NONE']),
	FALSE
];
_sideObj = missionNamespace getVariable 'QS_sideObj';
_sideObj setVectorUp [0,0,1];
_sideObj setDir _objDir;
_objectTypes = ['Box_IND_WpsLaunch_F','Box_IND_WpsLaunch_F'];
_objectType = selectRandom _objectTypes;
_object = createVehicle [_objectType,[0,0,0],[],0,'NONE'];
_object allowDamage FALSE;
_object setPosWorld [((getPosWorld _sideObj) # 0), ((getPosWorld _sideObj) # 1),(((getPosWorld _sideObj) # 2) + 1)];
_object enableRopeAttach FALSE;
_object setVariable ['QS_interaction_disabled',TRUE,TRUE];
_object enableSimulationGlobal TRUE;
for '_x' from 0 to 2 step 1 do {
	_object setVariable ['QS_secureable',TRUE,TRUE];
	_object setVariable ['QS_isExplosion',TRUE,TRUE];
};
_truck1 = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI 'I_Truck_02_ammo_F','I_Truck_02_ammo_F'],_flatPos1,[],0,'NONE'];
_truck2 = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI 'I_Truck_02_ammo_F','I_Truck_02_ammo_F'],_flatPos2,[],0,'NONE'];
{_x setDir (random 360);_x lock 3;} forEach [_truck1,_truck2];

/*/-------------------- SPAWN FORCE PROTECTION/*/

_enemiesArray = [_sideObj] call (missionNamespace getVariable 'QS_fnc_SMenemyIND');

/*/------------------- SPAWN BRIEFING/*/

_fuzzyPos = [((_flatPos # 0) - 300) + (random 600),((_flatPos # 1) - 300) + (random 600),0];
{
	_x setMarkerPosLocal _fuzzyPos;
	_x setMarkerAlpha 1;
} count ['QS_marker_sideMarker','QS_marker_sideCircle'];
'QS_marker_sideMarker' setMarkerText (format ['%1 %2',(toString [32,32,32]),localize 'STR_QS_Marker_032']);

[
	'QS_IA_TASK_SM_0',
	TRUE,
	[
		localize 'STR_QS_Task_080',
		localize 'STR_QS_Task_081',
		localize 'STR_QS_Task_081'
	],
	(markerPos 'QS_marker_sideMarker'),
	'CREATED',
	5,
	FALSE,
	TRUE,
	'download',
	TRUE
] call (missionNamespace getVariable 'BIS_fnc_setTask');
['NewSideMission',[localize 'STR_QS_Notif_086']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
	
/*/-------------------- [ CORE LOOPS ] ------------------------ [ CORE LOOPS ]/*/

missionNamespace setVariable ['QS_sideMissionUp',TRUE,TRUE];
missionNamespace setVariable ['QS_smSuccess',FALSE,TRUE];

for '_x' from 0 to 1 step 0 do {

	/*/--------------------------------------------- IF PACKAGE DESTROYED [FAIL]/*/

	if (!alive _sideObj) exitWith {
		missionNamespace setVariable ['QS_sideMissionUp',FALSE,TRUE];
		['sideChat',[WEST,'HQ'],localize 'STR_QS_Chat_060'] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
		[0,_flatPos] spawn (missionNamespace getVariable 'QS_fnc_smDebrief');
		{
			_x setMarkerPos [-5000,-5000,0];
			_x setMarkerAlpha 0;
		} count ['QS_marker_sideMarker','QS_marker_sideCircle'];
		deleteVehicle _object;
		sleep 120;
		deleteVehicle [_sideObj,_truck1,_truck2];
		{
			if (_x isEqualType objNull) then {
				0 = QS_garbageCollector pushBack [_x,'NOW_DISCREET',0];
			};
		} count _enemiesArray;
	};
	
	/*/--------------------------------------------- IF PACKAGE DESTROYED [FAIL]/*/
	
	if (missionNamespace getVariable 'QS_smSuccess') exitWith {
		['sideChat',[WEST,'HQ'],_c4Message] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
		uiSleep 14;											
		'Bo_Mk82' createVehicle (getPosATL _object);
		uiSleep 0.1;
		deleteVehicle _object;
		missionNamespace setVariable ['QS_sideMissionUp',FALSE,TRUE];
		[1,_flatPos] spawn (missionNamespace getVariable 'QS_fnc_smDebrief');
		{
			_x setMarkerPosLocal [-5000,-5000,0];
			_x setMarkerAlpha 0;
		} count ['QS_marker_sideMarker','QS_marker_sideCircle'];
		sleep 120;
		deleteVehicle [_sideObj,_truck1,_truck2];
		{
			if (_x isEqualType objNull) then {
				0 = QS_garbageCollector pushBack [_x,'NOW_DISCREET',0];
			};
		} count _enemiesArray;
	};
	sleep 2;
};