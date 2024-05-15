/*
File: HQcoast.sqf
Author:

	Quiksilver (credit Rarek [AW] for initial design)
	
Last modified:

	3/02/2016 A3 1.54 by Quiksilver
	
Description:

	-
	
Notes:

	Deprecated mission, needs overhaul with composition instead of solitary building
_________________________________________________________________________________________*/

scriptName 'Side Mission - HQ Coast';

private [
	"_flatPos","_accepted","_position","_randomDir","_x","_briefing","_enemiesArray","_unitsArray","_c4Message","_object","_secondary1",
	"_secondary2","_secondary3","_secondary4","_secondary5","_boatPos","_trawlerPos","_assault_boatPos",'_worldCenterPos','_worldSize',
	'_objectTypes','_objectType','_c4Messages','_boat','_trawler','_assault_boat','_hqType'
];

/*/-------------------- FIND SAFE POSITION FOR MISSION/*/
_accepted = TRUE;
_flatPos = [0,0,0];
_position = [];
_accepted = FALSE;
for '_x' from 0 to 1 step 0 do {
	_flatPos = ['WORLD',-1,-1,'LAND',[2,0,0.3,1,1,TRUE,objNull],TRUE,[],[],TRUE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
	if (_flatPos isNotEqualTo []) then {
		if (_flatPos isNotEqualTo [100,100,0]) then {
			if (missionNamespace getVariable 'QS_module_fob_enabled') then {
				if ((_flatPos distance (markerPos 'QS_marker_module_fob')) < 5000) then {
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

/*/------------------------------------------- SPAWN OBJECTIVE AND AMBIENCE /*/

_hqType = ['Land_Cargo_HQ_V2_F','Land_Cargo_HQ_V4_F'] select (worldName isEqualTo 'Tanoa');
_randomDir = random 360;
missionNamespace setVariable [
	'QS_sideObj',
	(createVehicle [_hqType,[(_flatPos # 0),(_flatPos # 1),0],[],0,'NONE']),
	FALSE
];
(missionNamespace getVariable 'QS_sideObj') setDir _randomDir;
(missionNamespace getVariable 'QS_sideObj') setPosWorld [((getPosWorld (missionNamespace getVariable 'QS_sideObj')) # 0),((getPosWorld (missionNamespace getVariable 'QS_sideObj')) # 1),((getPosWorld (missionNamespace getVariable 'QS_sideObj')) # 2)];
(missionNamespace getVariable 'QS_sideObj') setVectorUp [0,0,1];
_objectTypes = ['Land_CargoBox_V1_F','CargoNet_01_barrels_F'];
_objectType = selectRandom _objectTypes;
_object = createVehicle [_objectType,[0,0,0],[],0,'NONE'];
_object allowDamage FALSE;
_object enableRopeAttach FALSE;
_object enableSimulationGlobal TRUE;
_object enableVehicleCargo FALSE;
_object setPosWorld [((getPosWorld (missionNamespace getVariable 'QS_sideObj')) # 0), ((getPosWorld (missionNamespace getVariable 'QS_sideObj')) # 1), (((getPosWorld (missionNamespace getVariable 'QS_sideObj')) # 2) + 5)];

for '_x' from 0 to 2 step 1 do {
	_object setVariable ['QS_secureable',TRUE,TRUE];
	_object setVariable ['QS_isExplosion',TRUE,TRUE];
};

/*/--------- _boat POSITIONS/*/

_boatPos = [_flatPos,50,150,10,2,1,0] call (missionNamespace getVariable 'QS_fnc_findSafePos');
_trawlerPos = [_flatPos,200,300,10,2,1,0] call (missionNamespace getVariable 'QS_fnc_findSafePos');
_assault_boatPos = [_flatPos,15,25,10,0,1,0] call (missionNamespace getVariable 'QS_fnc_findSafePos');

/*/--------- ENEMY HMG _boat (SEEMS RIGHT SINCE ITS BY THE COAST)/*/
_boatType = 'O_boat_Armed_01_hmg_F';
_boat = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _boatType,_boatType],_boatPos,[],0,'NONE'];
_boat setDir (random 360);
_smuggleGroup = createGroup [EAST,TRUE];
_diverType = 'O_diver_F';

for '_x' from 0 to 4 step 1 do {
	_smuggleGroup createUnit [QS_core_units_map getOrDefault [toLowerANSI _diverType,_diverType],_boatPos,[],0,'NONE'];
};
_smuggleGroup setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
{
	_x = _x call (missionNamespace getVariable 'QS_fnc_unitSetup');
} count (units _smuggleGroup);
((units _smuggleGroup) # 0) assignAsCommander _boat; 
((units _smuggleGroup) # 0) moveInCommander _boat; 
((units _smuggleGroup) # 1) assignAsDriver _boat; 
((units _smuggleGroup) # 1) moveInDriver _boat; 
((units _smuggleGroup) # 2) assignAsGunner _boat; 
((units _smuggleGroup) # 2) moveInGunner _boat; 
((units _smuggleGroup) # 3) assignAsCargo _boat; 
((units _smuggleGroup) # 3) moveInCargo _boat; 
((units _smuggleGroup) # 4) assignAsCargo _boat; 
((units _smuggleGroup) # 4) moveInCargo _boat;
[(units _smuggleGroup),2] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');

/*/---------- SHIPPING _trawler AND INFLATABLE _boat FOR AMBIENCE/*/

_trawler = createVehicle ['C_boat_Civil_04_F',_trawlerPos,[],0,'NONE'];
_trawler setDir (random 360);
_trawler allowDamage FALSE;

_assault_boat = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI 'o_boat_transport_01_f','o_boat_transport_01_f'],_assault_boatPos,[],0,'NONE'];
_assault_boat setDir (random 360);
_assault_boat allowDamage FALSE;
{_x lock 3;} count [_boat,_assault_boat];

/*/------- POS FOR SECONDARY EXPLOSIONS, create a function for this?/*/

_secondary1 = [_flatPos # 0,_flatPos # 1,0] getPos [(random 30),(random 360)];
_secondary2 = [_flatPos # 0,_flatPos # 1,0] getPos [(random 30),(random 360)];
_secondary3 = [_flatPos # 0,_flatPos # 1,0] getPos [(random 30),(random 360)];
_secondary4 = [_flatPos # 0,_flatPos # 1,0] getPos [(random 50),(random 360)];
_secondary5 = [_flatPos # 0,_flatPos # 1,0] getPos [(random 70),(random 360)];

/*/-------------------- SPAWN FORCE PROTECTION/*/

_enemiesArray = [(missionNamespace getVariable 'QS_sideObj')] call (missionNamespace getVariable 'QS_fnc_smEnemyEast');
{
	0 = _enemiesArray pushBack _x;
} count (units _smuggleGroup);

/*/-------------------- BRIEFING/*/

_fuzzyPos = [((_flatPos # 0) - 300) + (random 600),((_flatPos # 1) - 300) + (random 600),0];
{
	_x setMarkerPosLocal _fuzzyPos;
	_x setMarkerAlpha 1;
} count ['QS_marker_sideMarker','QS_marker_sideCircle'];
'QS_marker_sideMarker' setMarkerText (format ['%1 %2',(toString [32,32,32]),localize 'STR_QS_Marker_030']);

[
	'QS_IA_TASK_SM_0',
	TRUE,
	[
		(format [
			'%2 %1 %3',
			worldName,
			localize 'STR_QS_Task_074',
			localize 'STR_QS_Task_075'
		]),
		localize 'STR_QS_Task_076',
		localize 'STR_QS_Task_076'
	],
	(markerPos 'QS_marker_sideMarker'),
	'CREATED',
	5,
	FALSE,
	TRUE,
	'download',
	TRUE
] call (missionNamespace getVariable 'BIS_fnc_setTask');
_c4Messages = [
	localize 'STR_QS_Chat_061',
	localize 'STR_QS_Chat_062',
	localize 'STR_QS_Chat_063'
];
_c4Message = selectRandom _c4Messages;
['NewSideMission',[localize 'STR_QS_Notif_084']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
	
/*/-------------------- [ CORE LOOPS ]----------------------- [CORE LOOPS]/*/

missionNamespace setVariable ['QS_sideMissionUp',TRUE,TRUE];
missionNamespace setVariable ['QS_smSuccess',FALSE,TRUE];

for '_x' from 0 to 1 step 0 do {

	/*/----------------------------------------------------- IF HQ IS DESTROYED [FAIL]/*/
		
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
		deleteVehicle [(missionNamespace getVariable 'QS_sideObj'),_boat,_trawler,_assault_boat];
		{
			if (_x isEqualType objNull) then {
				0 = QS_garbageCollector pushBack [_x,'NOW_DISCREET',0];
			};
		} count _enemiesArray;
	};

	/*/------------------------------------------------------ IF WEAPONS ARE DESTROYED [SUCCESS]/*/

	if (missionNamespace getVariable 'QS_smSuccess') exitWith {
		{
			_x setMarkerPosLocal [-5000,-5000,0];
			_x setMarkerAlpha 0;
		} count ['QS_marker_sideMarker','QS_marker_sideCircle'];
	
		/*/-------------------- BOOM!/*/
		
		['sideChat',[WEST,'HQ'],_c4Message] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
		uiSleep 14;											/*/ghetto bomb timer/*/
		'Bo_GBU12_LGB' createVehicle (getPosATL _object); 		/*/ default "Bo_Mk82"/*/
		uiSleep 0.1;
		deleteVehicle _object;
	
		/*/-------------------- DE-BRIEFING/*/

		missionNamespace setVariable ['QS_sideMissionUp',FALSE,TRUE];
		[1,_flatPos] spawn (missionNamespace getVariable 'QS_fnc_smDebrief');
		
		/*/--------------------- SECONDARY EXPLOSIONS, create a function for this?/*/
		
		sleep 10 + (random 10);
		'SmallSecondary' createVehicle _secondary1;
		'SmallSecondary' createVehicle _secondary2;
		sleep 5 + (random 5);
		'SmallSecondary' createVehicle _secondary3;
		sleep 2 + (random 2);
		'SmallSecondary' createVehicle _secondary4;
		'SmallSecondary' createVehicle _secondary5;
		if ((random 1) > 0.333) then {
			_secondary1 = [_flatPos # 0,_flatPos # 1,0] getPos [(random 50),(random 360)];
			_secondary2 = [_flatPos # 0,_flatPos # 1,0] getPos [(random 50),(random 360)];
			_secondary3 = [_flatPos # 0,_flatPos # 1,0] getPos [(random 50),(random 360)];
			_secondary4 = [_flatPos # 0,_flatPos # 1,0] getPos [(random 50),(random 360)];
			_secondary5 = [_flatPos # 0,_flatPos # 1,0] getPos [(random 80),(random 360)];
			sleep 10 + (random 10);
			'SmallSecondary' createVehicle _secondary1;
			'SmallSecondary' createVehicle _secondary2;
			sleep 5 + (random 5);
			'SmallSecondary' createVehicle _secondary3;
			sleep 2 + (random 2);
			'SmallSecondary' createVehicle _secondary4;
			'SmallSecondary' createVehicle _secondary5;
		};
	
		/*/--------------------- DELETE, DESPAWN, HIDE and RESET/*/

		deleteVehicle [(missionNamespace getVariable 'QS_sideObj'),_boat,_trawler,_assault_boat];
		{
			if (_x isEqualType objNull) then {
				0 = QS_garbageCollector pushBack [_x,'NOW_DISCREET',0];
			};
		} count _enemiesArray;
	};
	sleep 2;
};