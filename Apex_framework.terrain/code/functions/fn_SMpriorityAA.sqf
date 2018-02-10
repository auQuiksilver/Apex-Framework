/*
Author:

	Quiksilver
	
Last modified:

	24/10/2014 ArmA 1.32 by Quiksilver
	
Description:

	Anti-Air Battery.
_____________________________________________________________________________________*/

scriptName 'Side Mission - AA';

if ((count allPlayers) < 25) exitWith {};
if (worldName in ['Tanoa','Stratis','Malden']) exitWith {};

private [
	'_rearmDelay','_rearmMessage','_rearming','_rearmInterval','_rearmTime','_heliDetectDist',"_stealthAir","_barrierArray",
	"_defaultDetectDist","_stealthDetectDist","_typeOfAir","_basepos","_loopVar","_dir","_PTdir","_pos","_barrier","_unitsArray",
	"_flatPos","_accepted","_position","_enemiesArray","_targetList","_fuzzyPos","_x","_briefing","_enemiesArray","_unitsArray",
	"_flatPos1","_flatPos2","_flatPos3","_doTargets","_targetSelect","_targetListEnemy",'_priorityObj1','_priorityObj2','_ammoTruck',
	'_priorityCommander1','_priorityCommander2','_priorityGunner1','_priorityGunner2','_aaType','_ammoTruckType','_engineerType'
];

_stealthAir = ['B_Heli_Attack_01_F','B_Heli_Attack_01_dynamicLoadout_F','B_Heli_Transport_01_F','B_Heli_Transport_01_camo_F','B_CTRG_Heli_Transport_01_sand_F','B_CTRG_Heli_Transport_01_tropic_F'];
_stealthDetectDist = 2500;
_heliDetectDist = 4500;
_defaultDetectDist = 7500;
if (worldName isEqualTo 'Tanoa') then {
	_engineerType = 'O_T_engineer_F';
} else {
	_engineerType = 'O_engineer_F';
};

/*/-------------------- 1. FIND POSITION FOR OBJECTIVE/*/

_basepos = markerPos 'QS_marker_base_marker';
_flatPos = [0,0,0];
_accepted = false;
while {!_accepted} do {
	_flatPos = ['RADIUS',_basepos,6000,'LAND',[5,0,0.2,5,0,FALSE,objNull],TRUE,[],[],TRUE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
	if ((_flatPos distance2D _basepos) > 2000) then {
		if ((_flatPos distance2D _basepos) < 3750) then {
			if ((_flatPos distance2D (missionNamespace getVariable 'QS_AOpos')) > 500) then {
				_accepted = TRUE;
			};
		};
	};
	if (_accepted) exitWith {};
};

_flatPos1 = [(_flatPos select 0) - 3, (_flatPos select 1) - 3, (_flatPos select 2)];
_flatPos2 = [(_flatPos select 0) + 3, (_flatPos select 1) + 3, (_flatPos select 2)];
_flatPos3 = [(_flatPos select 0) + 20, (_flatPos select 1) + random 20, (_flatPos select 2)];

_aaType = 'O_APC_Tracked_02_AA_F';
if (worldName isEqualTo 'Tanoa') then {
	_aaType = 'O_T_APC_Tracked_02_AA_ghex_F';
};

/*/-------------------- 2. SPAWN OBJECTIVES/*/

_PTdir = random 360;


/*/ Spawn composition/*/


_priorityObj1 = createVehicle [_aaType,_flatPos1,[],0,'NONE'];
_priorityObj1 setDir _PTdir;
_priorityObj2 = createVehicle [_aaType,_flatPos2,[],0,'NONE'];
_priorityObj2 setDir _PTdir;
missionNamespace setVariable [
	'QS_analytics_entities_created',
	((missionNamespace getVariable 'QS_analytics_entities_created') + 2),
	FALSE
];

/*/----- SPAWN AMMO TRUCK (for ambiance and plausibiliy of unlimited ammo)/*/

if (worldName isEqualTo 'Tanoa') then {
	_ammoTruckType = 'O_T_Truck_03_ammo_ghex_F';
} else {
	_ammoTruckType = 'O_Truck_03_ammo_F';
};

_ammoTruck = createVehicle [_ammoTruckType,_flatPos3,[],0,'NONE'];
missionNamespace setVariable [
	'QS_analytics_entities_created',
	((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
	FALSE
];
_ammoTruck setDir random 360;
{
	_x lock 3;
	_x allowCrewInImmobile TRUE;
} forEach [_priorityObj1,_priorityObj2,_ammoTruck];
	
/*/-------------------- 3. SPAWN CREW/*/
	
_unitsArray = []; 			/*/ for crew and h-barriers/*/
_priorityGroup = createGroup [EAST,TRUE];
_priorityCommander1 = _priorityGroup createUnit [_engineerType,_flatPos,[],0,'NONE'];
_priorityCommander2 = _priorityGroup createUnit [_engineerType,_flatPos,[],0,'NONE'];
_priorityGunner1 = _priorityGroup createUnit [_engineerType,_flatPos,[],0,'NONE'];
_priorityGunner2 = _priorityGroup createUnit [_engineerType,_flatPos,[],0,'NONE'];
missionNamespace setVariable [
	'QS_analytics_entities_created',
	((missionNamespace getVariable 'QS_analytics_entities_created') + 4),
	FALSE
];
{
	_x = _x call (missionNamespace getVariable 'QS_fnc_unitSetup');
} count (units _priorityGroup);
_priorityCommander1 assignAsCommander _priorityObj1;
_priorityCommander1 moveInCommander _priorityObj1;
_priorityCommander2 assignAsCommander _priorityObj2;
_priorityCommander2 moveInCommander _priorityObj2;
_priorityGunner1 assignAsGunner _priorityObj1;
_priorityGunner1 moveInGunner _priorityObj1;
_priorityGunner2 assignAsGunner _priorityObj2;
_priorityGunner2 moveInGunner _priorityObj2;

{0 = _unitsArray pushBack _x;} count (units _priorityGroup);

/*/---------- Engines on baby/*/

_priorityObj1 engineOn TRUE;
_priorityObj2 engineOn TRUE;

/*/-------------------- 4. SPAWN H-BARRIER RING/*/

_barrierArray = [];
_distance = 16;
_dir = 0;
for '_c' from 0 to 7 do {
	_pos = _flatPos getPos [_distance,_dir];
	_barrier = createVehicle ['Land_HBarrierBig_F',[0,0,0],[],0,'NONE'];
	missionNamespace setVariable [
		'QS_analytics_entities_created',
		((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
		FALSE
	];
	_barrier setDir _dir;
	_dir = _dir + 45;
	_pos set [2,0];
	_barrier allowDamage FALSE;
	_barrier setPos _pos;
	_barrier setVectorUp (surfaceNormal (getPosWorld _barrier));
	0 = _barrierArray pushBack _barrier;
	0 = _unitsArray pushBack _barrier;
};

/*/-------------------- 5. SPAWN FORCE PROTECTION/*/

_enemiesArray = [_priorityObj1] call (missionNamespace getVariable 'QS_fnc_smEnemyEast');

/*/-------------------- 6. THAT GIRL IS SO DANGEROUS!/*/

[(units _priorityGroup),4] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
_priorityGroup setBehaviour 'COMBAT';
_priorityGroup setCombatMode 'RED';	
_priorityGroup allowFleeing 0;

/*/----- 6a. UNLIMITED AMMO/*/

{
	_x setVariable ['selections', []];
	_x setVariable ['gethit', []];
	_x addEventHandler [
		'HandleDamage',
		{
			_unit = _this select 0;
			_selections = _unit getVariable ['selections', []];
			_gethit = _unit getVariable ['gethit', []];
			_selection = _this select 1;
			if !(_selection in _selections) then
			{
				_selections set [count _selections, _selection];
				_gethit set [count _gethit, 0];
			};
			_i = _selections find _selection;
			_olddamage = _gethit select _i;
			_damage = _olddamage + ((_this select 2) - _olddamage) * 0.25;
			_gethit set [_i,_damage];
			_damage;
		}
	];
	_x addEventHandler [
		'Fired',
		{
			(_this select 0) setVehicleAmmo 1;
		}
	];
} forEach [
	_priorityObj1,
	_priorityObj2
];
	
/*/-------------------- 7. BRIEFING/*/

_fuzzyPos = [((_flatPos select 0) - 300) + (random 600),((_flatPos select 1) - 300) + (random 600),0];
{
	_x setMarkerPos _fuzzyPos;
	_x setMarkerAlpha 1;
} count ['QS_marker_sideMarker','QS_marker_sideCircle'];
'QS_marker_sideMarker' setMarkerText (format ['%1Priority Target: Anti-Air Battery',(toString [32,32,32])]);

[
	'QS_IA_TASK_SM_0',
	TRUE,
	[
		'The enemy has set up an Anti-Air Battery near our base. This is a priority target, soldiers! It has extremely long range! Get over there and take it out at all cost. While it is active, it is not advised to use air transport. This objective is not accurately marked. While it is re-arming (30 seconds), it will not be able to lock on at long range.',
		'Anti-Air Battery',
		'Anti-Air Battery'
	],
	(markerPos 'QS_marker_sideMarker'),
	'CREATED',
	5,
	FALSE,
	TRUE,
	'destroy',
	TRUE
] call (missionNamespace getVariable 'BIS_fnc_setTask');

_briefing = parseText "<t align='center' size='2.2'>Priority Target</t><br/><t size='1.5' color='#b60000'>Anti-Air Battery</t><br/>____________________<br/>OPFOR forces are setting up an anti-air battery to hit you guys damned hard! We've picked up their positions with thermal imaging scans and have marked it on your map.<br/><br/>This is a priority target, boys!";
['hint',_briefing] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
['NewPriorityTarget',['Anti-Air Battery']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
	
/*/-------------------- 8. CORE LOOP/*/

_rearmDelay = 45;
_rearmMessage = FALSE;
_rearming = FALSE;
_rearmInterval = time + (240 + (random 80));
_rearmTime = time + _rearmDelay;

_loopVar = TRUE;
_doTargets = [];
_targetSelect = objNull;

missionNamespace setVariable ['QS_smSuccess',FALSE,TRUE];

for '_x' from 0 to 1 step 0 do {

	if (!(_rearming)) then {

		/*/========== Small targeting system routine/*/
		
		_doTargets = [];
		_targetSelect = objNull;
		_targetList = _flatPos nearEntities [['Air'],_defaultDetectDist];
		if ((count _targetList) > 0) then {
			{_priorityGroup reveal [_x,4];} forEach _targetList;
			_targetListEnemy = [];
			{
				if ((side _x) isEqualTo WEST) then {
					_typeOfAir = typeOf _x;
					if (_x isKindOf 'Plane') then {
						0 = _targetListEnemy pushBack _x;
					} else {
						if (_x isKindOf 'Helicopter') then {
							if (_typeOfAir in _stealthAir) then {
								if ((_x distance _flatPos) < _stealthDetectDist) then {	
									0 = _targetListEnemy pushBack _x;
								};
							} else {
								if ((_x distance _flatPos) < _heliDetectDist) then {
									0 = _targetListEnemy pushBack _x;
								};
							};
						};
					};
				};
			} count _targetList;
			
			if ((count _targetListEnemy) > 0) then {
				{
					if (((getPosATL _x) select 2) > 25) then {
						0 = _doTargets pushBack _x;
					};
				} count _targetListEnemy;
				if ((count _doTargets) > 0) then {
					_targetSelect = selectRandom _doTargets;
					if (canFire _priorityObj1) then {
						_priorityObj1 doWatch [((getPosWorld _targetSelect) select 0),((getPosWorld _targetSelect) select 1),2000];
						_priorityObj1 doTarget _targetSelect;
						sleep 2;
						_priorityObj1 fireAtTarget [_targetSelect,'missiles_titan'];
						sleep 2;
						if (canFire _priorityObj2) then {
							_targetSelect = selectRandom _doTargets;
							_priorityObj2 doWatch [((getPosWorld _targetSelect) select 0),((getPosWorld _targetSelect) select 1),2000];
							_priorityObj2 doTarget _targetSelect;
							sleep 2;
							_priorityObj2 fireAtTarget [_targetSelect,'missiles_titan'];
							sleep 2;
						};
					} else {
						if (canFire _priorityObj2) then {
							_priorityObj2 doTarget _targetSelect;
							sleep 2;
							_priorityObj2 doFire _targetSelect;
							sleep 2;
						};
					};
				};
			};
		};
	} else {
		if (time > _rearmTime) then {
			_rearming = FALSE;
			['sideChat',[WEST,'BLU'],'The CSAT AA Battery has finished rearming!'] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
		};
	};
	
	if (time > _rearmInterval) then {
		if (!(_rearming)) then {
			_rearming = TRUE;
			_rearmTime = time + _rearmDelay;
			['sideChat',[WEST,'BLU'],'The CSAT AA Battery is rearming!'] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
		};
		_rearmInterval = time + (240 + (random 80));
	};
	
	/*/============================== Exit strategy/*/

	if ((!alive _priorityObj1) || {(missionNamespace getVariable 'QS_smSuccess')}) then {
		if ((!alive _priorityObj2) || {(missionNamespace getVariable 'QS_smSuccess')}) then {
			
			_loopVar = FALSE;

			/*/-------------------- 9. DE-BRIEF/*/
			
			_completeText = parseText "<t align='center' size='2.2'>Priority Target</t><br/><t size='1.5' color='#08b000'>NEUTRALISED</t><br/>____________________<br/>Incredible job, boys! Make sure you jump on those priority targets quickly; they can really cause havoc if they're left to their own devices.<br/><br/>Keep on with the main objective; we'll tell you if anything comes up.";
			['hint',_completeText] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
			['CompletedPriorityTarget',['Anti-Air Battery Neutralized']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
			[1,_flatPos] spawn (missionNamespace getVariable 'QS_fnc_smDebrief');
			{
				_x removeAllEventHandlers 'HandleDamage';
			} forEach [
				_priorityObj1,
				_priorityObj2
			];
			{
				_x setMarkerPos [-5000,-5000,0];
				_x setMarkerAlpha 0;
			} count ['QS_marker_sideMarker','QS_marker_sideCircle'];

			/*/-------------------- 10. DELETE/*/

			sleep 120;
			{
				if (_x isEqualType objNull) then {
					0 = QS_garbageCollector pushBack [_x,'NOW_DISCREET',0];
				};
			} count _enemiesArray;
			{
				if (_x isEqualType objNull) then {
					0 = QS_garbageCollector pushBack [_x,'NOW_DISCREET',0];
				};
			} count _unitsArray;
			{
				missionNamespace setVariable [
					'QS_analytics_entities_deleted',
					((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),
					FALSE
				];
				deleteVehicle _x;
			} forEach [_priorityObj1,_priorityObj2,_ammoTruck];
		};
	};
	if (!(_loopVar)) exitWith {};
	sleep 5;
};