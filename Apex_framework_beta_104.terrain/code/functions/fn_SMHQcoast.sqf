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
	if (!(_flatPos isEqualTo [])) then {
		if (!(_flatPos isEqualTo [100,100,0])) then {
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
	(createVehicle [_hqType,[(_flatPos select 0),(_flatPos select 1),0],[],0,'NONE']),
	FALSE
];
missionNamespace setVariable [
	'QS_analytics_entities_created',
	((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
	FALSE
];
(missionNamespace getVariable 'QS_sideObj') setDir _randomDir;
(missionNamespace getVariable 'QS_sideObj') setPosWorld [((getPosWorld (missionNamespace getVariable 'QS_sideObj')) select 0),((getPosWorld (missionNamespace getVariable 'QS_sideObj')) select 1),((getPosWorld (missionNamespace getVariable 'QS_sideObj')) select 2)];
(missionNamespace getVariable 'QS_sideObj') setVectorUp [0,0,1];
_objectTypes = ['Land_CargoBox_V1_F','CargoNet_01_barrels_F'];
_objectType = selectRandom _objectTypes;
_object = createVehicle [_objectType,[0,0,0],[],0,'NONE'];
missionNamespace setVariable [
	'QS_analytics_entities_created',
	((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
	FALSE
];
_object allowDamage FALSE;
_object enableRopeAttach FALSE;
_object enableSimulationGlobal TRUE;
_object enableVehicleCargo FALSE;
_object setPosWorld [((getPosWorld (missionNamespace getVariable 'QS_sideObj')) select 0), ((getPosWorld (missionNamespace getVariable 'QS_sideObj')) select 1), (((getPosWorld (missionNamespace getVariable 'QS_sideObj')) select 2) + 5)];

for '_x' from 0 to 2 step 1 do {
	_object setVariable ['QS_secureable',TRUE,TRUE];
	_object setVariable ['QS_isExplosion',TRUE,TRUE];
};

/*/--------- _boat POSITIONS/*/

_boatPos = [_flatPos,50,150,10,2,1,0] call (missionNamespace getVariable 'QS_fnc_findSafePos');
_trawlerPos = [_flatPos,200,300,10,2,1,0] call (missionNamespace getVariable 'QS_fnc_findSafePos');
_assault_boatPos = [_flatPos,15,25,10,0,1,0] call (missionNamespace getVariable 'QS_fnc_findSafePos');

/*/--------- ENEMY HMG _boat (SEEMS RIGHT SINCE ITS BY THE COAST)/*/
_boatType = ['O_boat_Armed_01_hmg_F','O_T_Boat_Armed_01_hmg_F'] select (worldName isEqualTo 'Tanoa');
_boat = createVehicle [_boatType,_boatPos,[],0,'NONE'];
missionNamespace setVariable [
	'QS_analytics_entities_created',
	((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
	FALSE
];
_boat setDir (random 360);
_smuggleGroup = createGroup [EAST,TRUE];
_diverType = ['O_diver_F','O_T_Diver_F'] select (worldName isEqualTo 'Tanoa');

for '_x' from 0 to 4 step 1 do {
	_smuggleGroup createUnit [_diverType,_boatPos,[],0,'NONE'];
};
missionNamespace setVariable [
	'QS_analytics_entities_created',
	((missionNamespace getVariable 'QS_analytics_entities_created') + 5),
	FALSE
];
{
	_x = _x call (missionNamespace getVariable 'QS_fnc_unitSetup');
} count (units _smuggleGroup);
((units _smuggleGroup) select 0) assignAsCommander _boat; 
((units _smuggleGroup) select 0) moveInCommander _boat; 
((units _smuggleGroup) select 1) assignAsDriver _boat; 
((units _smuggleGroup) select 1) moveInDriver _boat; 
((units _smuggleGroup) select 2) assignAsGunner _boat; 
((units _smuggleGroup) select 2) moveInGunner _boat; 
((units _smuggleGroup) select 3) assignAsCargo _boat; 
((units _smuggleGroup) select 3) moveInCargo _boat; 
((units _smuggleGroup) select 4) assignAsCargo _boat; 
((units _smuggleGroup) select 4) moveInCargo _boat;
[(units _smuggleGroup),2] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');

/*/---------- SHIPPING _trawler AND INFLATABLE _boat FOR AMBIENCE/*/

_trawler = createVehicle ['C_boat_Civil_04_F',_trawlerPos,[],0,'NONE'];
missionNamespace setVariable [
	'QS_analytics_entities_created',
	((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
	FALSE
];
_trawler setDir (random 360);
_trawler allowDamage FALSE;

_assault_boat = createVehicle ['O_boat_Transport_01_F',_assault_boatPos,[],0,'NONE'];
missionNamespace setVariable [
	'QS_analytics_entities_created',
	((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
	FALSE
];
_assault_boat setDir (random 360);
_assault_boat allowDamage FALSE;
{_x lock 3;} count [_boat,_assault_boat];

/*/------- POS FOR SECONDARY EXPLOSIONS, create a function for this?/*/

_secondary1 = [_flatPos select 0,_flatPos select 1,0] getPos [(random 30),(random 360)];
_secondary2 = [_flatPos select 0,_flatPos select 1,0] getPos [(random 30),(random 360)];
_secondary3 = [_flatPos select 0,_flatPos select 1,0] getPos [(random 30),(random 360)];
_secondary4 = [_flatPos select 0,_flatPos select 1,0] getPos [(random 50),(random 360)];
_secondary5 = [_flatPos select 0,_flatPos select 1,0] getPos [(random 70),(random 360)];

/*/-------------------- SPAWN FORCE PROTECTION/*/

_enemiesArray = [(missionNamespace getVariable 'QS_sideObj')] call (missionNamespace getVariable 'QS_fnc_smEnemyEast');
{
	0 = _enemiesArray pushBack _x;
} count (units _smuggleGroup);

/*/-------------------- BRIEFING/*/

_fuzzyPos = [((_flatPos select 0) - 300) + (random 600),((_flatPos select 1) - 300) + (random 600),0];
{
	_x setMarkerPos _fuzzyPos;
	_x setMarkerAlpha 1;
} count ['QS_marker_sideMarker','QS_marker_sideCircle'];
'QS_marker_sideMarker' setMarkerText (format ['%1Secure Smuggled Explosives',(toString [32,32,32])]);

[
	'QS_IA_TASK_SM_0',
	TRUE,
	[
		(format ['Secure the smuggled explosives! There are smuggled explosives somewhere on the %1 coastline in this area. Locate and secure them. Once you have secured the explosives, run away! This objective is not accurately marked.',worldName]),
		'Secure Smuggled Explosives',
		'Secure Smuggled Explosives'
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
	'The charge has been set! 15 seconds until detonation.',
	'The c4 has been set! 15 seconds until detonation.',
	'The charge is set! 15 seconds until detonation.'
];
_c4Message = selectRandom _c4Messages;
_briefing = parseText "<t align='center'><t size='2.2'>New Side Mission</t><br/><t size='1.5' color='#00B2EE'>Secure Smuggled Explosives</t><br/>____________________<br/>The OPFOR have been smuggling explosives onto the island and hiding them in a Mobile HQ on the coastline.<br/><br/>We've marked the building on your map; head over there and secure the current shipment. Keep well back when you blow it; there's a lot of stuff in that building.</t>";
//['hint',_briefing] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
['NewSideMission',['Secure Smuggled Explosives']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
	
/*/-------------------- [ CORE LOOPS ]----------------------- [CORE LOOPS]/*/

missionNamespace setVariable ['QS_sideMissionUp',TRUE,TRUE];
missionNamespace setVariable ['QS_smSuccess',FALSE,TRUE];

for '_x' from 0 to 1 step 0 do {

	/*/----------------------------------------------------- IF HQ IS DESTROYED [FAIL]/*/
		
	if (!alive (missionNamespace getVariable 'QS_sideObj')) exitWith {
		{
			_x setMarkerPos [-5000,-5000,0];
			_x setMarkerAlpha 0;
		} count ['QS_marker_sideMarker','QS_marker_sideCircle'];
		
		/*/-------------------- DE-BRIEFING/*/

		missionNamespace setVariable ['QS_sideMissionUp',FALSE,TRUE];
		['sideChat',[WEST,'HQ'],'Objective destroyed, mission FAILED!'] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
		[0,_flatPos] spawn (missionNamespace getVariable 'QS_fnc_smDebrief');
		
		/*/-------------------- DELETE/*/
		
		missionNamespace setVariable [
			'QS_analytics_entities_deleted',
			((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),
			FALSE
		];
		deleteVehicle _object;
		sleep 120;
		{
			missionNamespace setVariable [
				'QS_analytics_entities_deleted',
				((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),
				FALSE
			];
			deleteVehicle _x;
		} forEach [(missionNamespace getVariable 'QS_sideObj'),_boat,_trawler,_assault_boat];
		{
			if (_x isEqualType objNull) then {
				0 = QS_garbageCollector pushBack [_x,'NOW_DISCREET',0];
			};
		} count _enemiesArray;
	};

	/*/------------------------------------------------------ IF WEAPONS ARE DESTROYED [SUCCESS]/*/

	if (missionNamespace getVariable 'QS_smSuccess') exitWith {
		{
			_x setMarkerPos [-5000,-5000,0];
			_x setMarkerAlpha 0;
		} count ['QS_marker_sideMarker','QS_marker_sideCircle'];
	
		/*/-------------------- BOOM!/*/
		
		['sideChat',[WEST,'HQ'],_c4Message] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
		uiSleep 14;											/*/ghetto bomb timer/*/
		'Bo_GBU12_LGB' createVehicle (getPos _object); 		/*/ default "Bo_Mk82"/*/
		missionNamespace setVariable [
			'QS_analytics_entities_created',
			((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
			FALSE
		];
		uiSleep 0.1;
		missionNamespace setVariable [
			'QS_analytics_entities_deleted',
			((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),
			FALSE
		];
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
		missionNamespace setVariable [
			'QS_analytics_entities_created',
			((missionNamespace getVariable 'QS_analytics_entities_created') + 5),
			FALSE
		];
		if ((random 1) > 0.333) then {
			_secondary1 = [_flatPos select 0,_flatPos select 1,0] getPos [(random 50),(random 360)];
			_secondary2 = [_flatPos select 0,_flatPos select 1,0] getPos [(random 50),(random 360)];
			_secondary3 = [_flatPos select 0,_flatPos select 1,0] getPos [(random 50),(random 360)];
			_secondary4 = [_flatPos select 0,_flatPos select 1,0] getPos [(random 50),(random 360)];
			_secondary5 = [_flatPos select 0,_flatPos select 1,0] getPos [(random 80),(random 360)];
			sleep 10 + (random 10);
			'SmallSecondary' createVehicle _secondary1;
			'SmallSecondary' createVehicle _secondary2;
			sleep 5 + (random 5);
			'SmallSecondary' createVehicle _secondary3;
			sleep 2 + (random 2);
			'SmallSecondary' createVehicle _secondary4;
			'SmallSecondary' createVehicle _secondary5;
			missionNamespace setVariable [
				'QS_analytics_entities_created',
				((missionNamespace getVariable 'QS_analytics_entities_created') + 5),
				FALSE
			];
		};
	
		/*/--------------------- DELETE, DESPAWN, HIDE and RESET/*/

		{
			missionNamespace setVariable [
				'QS_analytics_entities_deleted',
				((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),
				FALSE
			];
			deleteVehicle _x;
		} forEach [(missionNamespace getVariable 'QS_sideObj'),_boat,_trawler,_assault_boat];
		{
			if (_x isEqualType objNull) then {
				0 = QS_garbageCollector pushBack [_x,'NOW_DISCREET',0];
			};
		} count _enemiesArray;
	};
	sleep 2;
};