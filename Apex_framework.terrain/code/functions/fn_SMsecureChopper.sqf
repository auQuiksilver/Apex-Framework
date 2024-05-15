/*
Author:

	Quiksilver
	
Last modified:

	25/04/2014
	
Description:

	Destroy chopper
	
Notes:

	Deprecated mission
____________________________________*/

scriptName 'Side Mission - Secure Chopper';

private [
	"_objPos","_flatPos","_accepted","_position","_randomDir","_hangar","_x","_enemiesArray",
	"_briefing","_fuzzyPos","_unitsArray","_dummy","_object",'_chopperType','_chopperTypes','_c4Message',
	'_c4Messages','_researchTable','_dummyTypes','_dummyType','_objectTypes','_objectType'
];
_c4Messages = [
	localize 'STR_QS_Chat_061',
	localize 'STR_QS_Chat_062',
	localize 'STR_QS_Chat_063'
];
_c4Message = selectRandom _c4Messages;
_chopperTypes = ["O_Heli_Attack_02_dynamicLoadout_black_F","O_Heli_Light_02_unarmed_F","B_Heli_Attack_01_dynamicLoadout_F","C_Heli_Light_01_civil_F","O_Heli_Transport_04_box_F"];
_chopperType = selectRandom _chopperTypes;

/*/-------------------- FIND SAFE POSITION FOR OBJECTIVE/*/

_flatPos = [0,0,0];
_accepted = false;
while {!_accepted} do {
	_flatPos = ['WORLD',-1,-1,'LAND',[5,0,0.2,(sizeOf 'Land_TentHangar_V1_F'),0,FALSE,objNull],TRUE,[],[],TRUE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
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

_objPos = [_flatPos,20,45,7.5,0,0.5,0] call (missionNamespace getVariable 'QS_fnc_findSafePos');

/*/------------------- SPAWN OBJECTIVE/*/

_randomDir = (random 360);
_hangar = createVehicle ['Land_TentHangar_V1_F',[_flatPos # 0,_flatPos # 1,0],[],0,'NONE'];
_hangar setPosWorld [((getPosWorld _hangar) # 0), ((getPosWorld _hangar) # 1), (((getPosWorld _hangar) # 2) - 0.75)];
_hangar setDir _randomDir;
QS_sideObj = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _chopperType,_chopperType],[0,0,10],[],0,'CAN_COLLIDE'];
QS_sideObj setDir _randomDir;
QS_sideObj setPos [_flatPos # 0,_flatPos # 1,0];
QS_sideObj lock 3;
_house = createVehicle [(['Land_Cargo_House_V3_F','Land_Cargo_House_V4_F'] select (worldName isEqualTo 'Tanoa')),[_objPos # 0,_objPos # 1,0],[],0,'NONE'];
_house setDir (random 360);
_house allowDamage FALSE;
_researchTable = createVehicle ['Land_CampingTable_small_F',[0,0,0],[],0,'NONE'];
sleep 0.3;
[1,_researchTable,[_house,[0,3,0.45]]] call QS_fnc_eventAttach;
sleep 0.3;
_dummyTypes = ['Box_East_AmmoOrd_F','Box_IND_AmmoOrd_F'];
_dummyType = selectRandom _dummyTypes;
_objectTypes = ['Land_Laptop_03_black_F','Land_Laptop_device_F'];
_objectType = selectRandom _objectTypes;
_object = createVehicle [_objectType,[0,0,0],[],0,'NONE'];
_object enableSimulationGlobal TRUE;
sleep 0.1;
[1,_object,[_house,[0,3,1]]] call QS_fnc_eventAttach;
for '_x' from 0 to 2 step 1 do {
	_object setVariable ['QS_secureable',TRUE,TRUE];
	_object setVariable ['QS_isExplosion',TRUE,TRUE];
};

/*/-------------------- SPAWN FORCE PROTECTION/*/

_enemiesArray = [QS_sideObj] call (missionNamespace getVariable 'QS_fnc_smEnemyEast');
	
/*/-------------------- BRIEF/*/

_fuzzyPos = [((_flatPos # 0) - 300) + (random 600),((_flatPos # 1) - 300) + (random 600),0];
'QS_marker_sideMarker' setMarkerTextLocal (format ['%1 %2',(toString [32,32,32]),localize 'STR_QS_Marker_041']);
{
	_x setMarkerPosLocal _fuzzyPos;
	_x setMarkerAlpha 1;
} count ['QS_marker_sideMarker','QS_marker_sideCircle'];
[
	'QS_IA_TASK_SM_0',
	TRUE,
	[
		localize 'STR_QS_Task_105',
		localize 'STR_QS_Task_106',
		localize 'STR_QS_Task_106'
	],
	(markerPos 'QS_marker_sideMarker'),
	'CREATED',
	5,
	FALSE,
	TRUE,
	'download',
	TRUE
] call (missionNamespace getVariable 'BIS_fnc_setTask');
['NewSideMission',[localize 'STR_QS_Notif_110']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
missionNamespace setVariable ['QS_sideMissionUp',TRUE,TRUE];
missionNamespace setVariable ['QS_smSuccess',FALSE,TRUE];

for '_x' from 0 to 1 step 0 do {

	if (!alive QS_sideObj) exitWith {
		
		/*/-------------------- DE-BRIEFING/*/

		['sideChat',[WEST,'HQ'],localize 'STR_QS_Chat_069'] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
		[0,_flatPos] spawn (missionNamespace getVariable 'QS_fnc_smDebrief');
		{
			_x setMarkerPosLocal [-5000,-5000,0];
			_x setMarkerAlpha 0;
		} count ['QS_marker_sideMarker','QS_marker_sideCircle'];
		
		missionNamespace setVariable ['QS_sideMissionUp',FALSE,TRUE];
		
		/*/-------------------- DELETE/*/
		
		deleteVehicle [_object,_researchTable];			/*/ hide objective pieces/*/
		sleep 120;
		deleteVehicle [QS_sideObj,_house,_hangar];
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
		_dummy setPosWorld [((getPosWorld QS_sideObj) # 0), (((getPosWorld QS_sideObj) # 1) +3), (((getPosWorld QS_sideObj) # 2) + 0.5)];
		sleep 0.1;
		deleteVehicle _object;
		uiSleep 14;											/*/ ghetto bomb timer/*/
		'Bo_GBU12_LGB' createVehicle (getPosATL _dummy); 		/*/ default "Bo_Mk82"/*/
		deleteVehicle [_dummy,_researchTable];
		sleep 0.1;
	
		/*/-------------------- DE-BRIEFING/*/

		[1,_flatPos] spawn (missionNamespace getVariable 'QS_fnc_smDebrief');
		{
			_x setMarkerPosLocal [-5000,-5000,0];
			_x setMarkerAlpha 0;
		} count ['QS_marker_sideMarker','QS_marker_sideCircle'];
		missionNamespace setVariable ['QS_sideMissionUp',FALSE,TRUE];
	
		/*/-------------------- DELETE/*/
		sleep 120;
		deleteVehicle [QS_sideObj,_house,_hangar];
		{
			if (_x isEqualType objNull) then {
				0 = QS_garbageCollector pushBack [_x,'NOW_DISCREET',0];
			};
		} count _enemiesArray;
	};
	sleep 2;
};