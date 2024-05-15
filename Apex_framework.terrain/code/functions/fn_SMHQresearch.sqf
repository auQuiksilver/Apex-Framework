/*
@file: HQresearch.sqf
Author:

	Quiksilver
	
Last modified:

	24/04/2014
	
Description:

	-

Notes:

	Deprecated mission, needs overhaul with composition instead of solitary building
____________________________________*/

scriptName 'Side Mission - Research';

private [
	"_flatPos","_accepted","_position","_enemiesArray","_fuzzyPos","_x","_briefing","_unitsArray","_object",
	"_dummy","_SMveh","_SMaa","_c4Message","_vehPos",'_vehType','_vehTypes','_dummyTypes','_dummyType','_objectTypes','_objectType',
	'_c4Messages','_c4Message','_researchTable','_veh'
];
_c4Messages = [
	localize 'STR_QS_Chat_061',
	localize 'STR_QS_Chat_062',
	localize 'STR_QS_Chat_063'
];
_c4Message = selectRandom _c4Messages;
if (worldName isEqualTo 'Tanoa') then {
	_vehTypes = ["I_C_Van_01_transport_F","I_C_Offroad_02_unarmed_F","O_MRAP_02_F","O_LSV_02_unarmed_F","I_MRAP_03_F"];
} else {
	_vehTypes = [
		"O_MRAP_02_F","O_Truck_03_covered_F","O_Truck_03_transport_F",
		"O_Heli_Light_02_unarmed_F","O_Truck_02_transport_F","O_Truck_02_covered_F",
		"C_SUV_01_F","C_Van_01_transport_F"
	];
};
_vehType = selectRandom _vehTypes;
/*/-------------------- FIND POSITION FOR OBJECTIVE/*/

_flatPos = [0,0,0];
_accepted = false;
while {!_accepted} do {
	_flatPos = ['WORLD',-1,-1,'LAND',[5,0,0.2,(sizeOf 'Land_Research_HQ_F'),0,FALSE,objNull],TRUE,[],[],TRUE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
	if ((_flatPos distance2D (markerPos "QS_marker_base_marker")) > 1700) then {
		if ((_flatPos distance2D (markerPos "Almyra_blacklist_area")) > 2000) then {
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
};

_vehPos = [_flatPos,15,30,10,0,0.5,0] call (missionNamespace getVariable 'QS_fnc_findSafePos');
	
/*/-------------------- SPAWN OBJECTIVE BUILDING/*/

QS_sideObj = createVehicle ['Land_Research_HQ_F',[_flatPos # 0,_flatPos # 1,0],[],0,'NONE'];
QS_sideObj setPosWorld [((getPosWorld QS_sideObj) # 0), ((getPosWorld QS_sideObj) # 1), ((getPosWorld QS_sideObj) # 2)];
QS_sideObj setVectorUp [0,0,1];
_veh = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _vehType,_vehType],_vehPos,[],0,'NONE'];
_veh lock 3;

/*/---------- SPAWN (okay, tp) TABLE, AND LAPTOP ON IT./*/

_researchTable = createVehicle ['Land_CampingTable_small_F',[0,0,0],[],0,'NONE'];
_researchTable setPosWorld [((getPosWorld QS_sideObj) # 0), ((getPosWorld QS_sideObj) # 1), ((getPosWorld QS_sideObj) # 2)];
_dummyTypes = ['Box_East_AmmoOrd_F','Box_IND_AmmoOrd_F'];
_dummyType = selectRandom _dummyTypes;
_objectTypes = ['Land_Laptop_03_black_F','Land_Laptop_device_F'];
_objectType = selectRandom _objectTypes;
_object = createVehicle [_objectType,[0,0,0],[],0,'NONE'];
_object enableSimulationGlobal TRUE;
[1,_researchTable,[QS_sideObj,[0,0,-2.875]]] call QS_fnc_eventAttach;
[1,_object,[QS_sideObj,[0,0,-2.3]]] call QS_fnc_eventAttach;
for '_x' from 0 to 2 step 1 do {
	_object setVariable ['QS_secureable',TRUE,TRUE];
	_object setVariable ['QS_isExplosion',TRUE,TRUE];
};
	
/*/-------------------- SPAWN FORCE PROTECTION/*/

_enemiesArray = [QS_sideObj] call (missionNamespace getVariable 'QS_fnc_smEnemyEast');

/*/-------------------- BRIEF/*/

_fuzzyPos = [((_flatPos # 0) - 300) + (random 600),((_flatPos # 1) - 300) + (random 600),0];
{
	_x setMarkerPosLocal _fuzzyPos;
	_x setMarkerAlpha 1;
} count ['QS_marker_sideMarker','QS_marker_sideCircle'];
'QS_marker_sideMarker' setMarkerText (format ['%1 %2',(toString [32,32,32]),localize 'STR_QS_Marker_033']);

[
	'QS_IA_TASK_SM_0',
	TRUE,
	[
		localize 'STR_QS_Task_082',
		localize 'STR_QS_Task_083',
		localize 'STR_QS_Task_083'
	],
	(markerPos 'QS_marker_sideMarker'),
	'CREATED',
	5,
	FALSE,
	TRUE,
	'download',
	TRUE
] call (missionNamespace getVariable 'BIS_fnc_setTask');
['NewSideMission',[localize 'STR_QS_Notif_087']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
missionNamespace setVariable ['QS_sideMissionUp',TRUE,TRUE];
missionNamespace setVariable ['QS_smSuccess',FALSE,TRUE];
	
/*/-------------------- [ CORE LOOPS ] ------------------------ [ CORE LOOPS ]/*/

for '_x' from 0 to 1 step 0 do {

	if (!alive QS_sideObj) exitWith {
		
		/*/-------------------- DE-BRIEFING/*/

		['sideChat',[WEST,'HQ'],localize 'STR_QS_Chat_060'] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
		[0,_flatPos] spawn (missionNamespace getVariable 'QS_fnc_smDebrief');
		{
			_x setMarkerPosLocal [-5000,-5000,0];
			_x setMarkerAlpha 0;
		} count ['QS_marker_sideMarker','QS_marker_sideCircle'];
		missionNamespace setVariable ['QS_sideMissionUp',FALSE,TRUE];
		
		/*/-------------------- DELETE/*/
		
		{
			[0,_x] call QS_fnc_eventAttach;
			deleteVehicle _x;
		} count [_object,_researchTable];
		sleep 120;
		deleteVehicle [QS_sideObj,_veh];
		{
			if (_x isEqualType objNull) then {
				0 = QS_garbageCollector pushBack [_x,'NOW_DISCREET',0];
			};
		} count _enemiesArray;
	};
	
	if (missionNamespace getVariable 'QS_smSuccess') exitWith {
		
		['sideChat',[WEST,'HQ'],_c4Message] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
	
		/*/-------------------- BOOM!/*/
		
		_dummy = createVehicle [_dummyType,[0,0,0],[],0,'NONE'];
		_dummy allowDamage FALSE;
		_dummy setPosWorld [((getPosWorld QS_sideObj) # 0), ((getPosWorld QS_sideObj) # 1), (((getPosWorld QS_sideObj) # 2) + 2)];
		uiSleep 0.1;
		[0,_object] call QS_fnc_eventAttach;
		deleteVehicle _object;
		uiSleep 14;											/*/ ghetto bomb timer/*/
		'Bo_Mk82' createVehicle (getPosATL _dummy); 				/*/default "Bo_Mk82"/*/
		{
			[0,_x] call QS_fnc_eventAttach;
			deleteVehicle _x;
		} count [_dummy,_researchTable];
		sleep 0.1;
	
		/*/-------------------- DE-BRIEFING/*/

		[1,_flatPos] spawn (missionNamespace getVariable 'QS_fnc_smDebrief');
		{
			_x setMarkerPosLocal [-5000,-5000,0];
			_x setMarkerAlpha 0;
		} count ['QS_marker_sideMarker','QS_marker_sideCircle'];
		missionNamespace setVariable ['QS_sideMissionUp',FALSE,TRUE];
	
		/*/--------------------- DELETE/*/
		sleep 120;
		deleteVehicle [QS_sideObj,_veh];
		{
			if (_x isEqualType objNull) then {
				0 = QS_garbageCollector pushBack [_x,'NOW_DISCREET',0];
			};
		} count _enemiesArray;
	};
	sleep 2;
};