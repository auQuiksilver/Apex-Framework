/*
File: fn_smEnemyDivers.sqf
Author: 

	Quiksilver
	
Last modified:

	22/11/2017 A3 1.78 by Quiksilver

Description:

	Spawn enemy divers
___________________________________________*/

private [
	'_pos','_terrainHeightASL','_AboatTypes','_AboatType','_boatTypes','_boatType','_AboatsCount','_boatsCount','_enemiesArray','_relPos','_boat',
	'_grp','_diverTypes','_diverType','_unit','_terrainHeightASLActual','_wp','_QS_fnc_radPos','_subTypes','_subType','_foundPos','_grpUnit','_trawler'
];
_pos = _this # 0;
_enemiesArray = [];
_terrainHeightASL = getTerrainHeightASL _pos;
_AboatTypes = ['O_Boat_Armed_01_hmg_F','I_Boat_Armed_01_minigun_F'];
_boatTypes = ['I_Boat_Transport_01_F','O_Boat_Transport_01_F'];
_subTypes = ['O_SDV_01_F','I_SDV_01_F'];
_AboatsCount = 2;
_boatsCount = 1;
_boat = objNull;
_QS_fnc_radPos = {
	private['_pos','_exit','_posX','_posY'];
	params ['_center','_radius','_angle','_isWater'];
	_center = _this # 0;
	_radius = _this # 1;
	_angle = _this # 2;
	_isWater = _this # 3;
	_exit = FALSE;
	for '_x' from 0 to 1 step 0 do {
		_posX = (_radius * (sin _angle));
		_posY = (_radius * (cos _angle));
		_pos = [_posX + (_center # 0),_posY + (_center # 1),0];
		if (_isWater) then {
			if (surfaceIsWater [_pos # 0,_pos # 1]) then {_exit = true} else {_radius = _radius - 1};
		} else {
			if (!surfaceIsWater [_pos # 0,_pos # 1]) then {_exit = true} else {_radius = _radius - 1};
		};
		if (_radius isEqualTo 0) then {_pos = _center;_exit = true};
		if (_exit) exitWith {};
	};
	_pos;
};
for '_x' from 0 to (_AboatsCount - 1) step 1 do {
	_AboatType = selectRandom _AboatTypes;
	_relPos = _pos getPos [(random 300),(random 360)];
	_relPos set [2,0];
	_boat = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _AboatType,_AboatType],_relPos,[],0,'NONE'];
	_boat lock 2;
	0 = _enemiesArray pushBack _boat;
	_boat setDir (random 360);
	_grp = createVehicleCrew _boat;
	{
		_grpUnit = _x;
		_grpUnit call (missionNamespace getVariable 'QS_fnc_unitSetup');
		_grpUnit forceAddUniform 'U_O_Wetsuit';
		_grpUnit addVest 'V_RebreatherIR';
		_grpUnit addGoggles 'G_O_Diving';
		[_grpUnit,'arifle_SDAR_F',3] call (missionNamespace getVariable 'QS_fnc_addWeapon');
		_grpUnit selectWeapon (primaryWeapon _grpUnit);
		_enemiesArray pushBack _grpUnit;
		{
			if ((toLowerANSI _x) in QS_core_classNames_grenades) then {
				_grpUnit removeMagazine _x;
			};
		} forEach (magazines _grpUnit);
	} forEach (units _grp);
	[(units _grp),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
};

_relPos = [_pos,(200 + (random 400)),(random 360),TRUE] call _QS_fnc_radPos;
_trawler = createVehicle ['C_Boat_Civil_04_F',[0,0,0],[],0,'NONE'];
_trawler setDir (random 360);
_trawler setPos _relPos;
_trawler allowDamage FALSE;
0 = _enemiesArray pushBack _trawler;
private _patrolRoute = [];
for '_x' from 0 to 2 step 1 do {
	_relPos = [_pos,(100 + (random 200)),(random 360),TRUE] call _QS_fnc_radPos;
	_patrolRoute pushBack [_relPos # 0,_relPos # 1,0];
};
_unit = (units _grp) # 0;
_patrolRoute pushBack [((getPos _unit) # 0),((getPos _unit) # 1),0];
_grp setVariable ['QS_AI_GRP_TASK',['PATROL',_patrolRoute,serverTime,-1],QS_system_AI_owners];
_grp setVariable ['QS_AI_GRP_PATROLINDEX',0,QS_system_AI_owners];
_grp setVariable ['QS_AI_GRP_CONFIG',['GENERAL','DIVER',(count (units _grp))],QS_system_AI_owners];
_grp setVariable ['QS_AI_GRP_DATA',[],QS_system_AI_owners];
_grp setVariable ['QS_AI_GRP',TRUE,QS_system_AI_owners];
_boatType = selectRandom _boatTypes;
_boat = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _boatType,_boatType],[_pos # 0,_pos # 1,0],[],0,'NONE'];
_boat lock 2;
_enemiesArray pushBack _boat;
_boat setDir (random 360);
_grp = createVehicleCrew _boat;
{
	_grpUnit = _x;
	_grpUnit forceAddUniform 'U_O_Wetsuit';
	_grpUnit addVest 'V_RebreatherIR';
	_grpUnit addGoggles 'G_O_Diving';
	[_grpUnit,'arifle_SDAR_F',3] call (missionNamespace getVariable 'QS_fnc_addWeapon');
	_grpUnit selectWeapon (primaryWeapon _grpUnit);
	0 = _enemiesArray pushBack _grpUnit;
	{
		if ((toLowerANSI _x) in QS_core_classNames_grenades) then {
			_grpUnit removeMagazine _x;
		};
	} forEach (magazines _grpUnit);
} count (units _grp);
_patrolRoute = [];
for '_x' from 0 to 2 step 1 do {
	_relPos = [_pos,(100 + (random 200)),(random 360),TRUE] call _QS_fnc_radPos;
	_patrolRoute pushBack [_relPos # 0,_relPos # 1,0];
};
_unit = (units _grp) # 0;

_patrolRoute pushBack [((getPos _unit) # 0),((getPos _unit) # 1),0];

_grp setVariable ['QS_AI_GRP_TASK',['PATROL',_patrolRoute,serverTime,-1],QS_system_AI_owners];
_grp setVariable ['QS_AI_GRP_PATROLINDEX',0,QS_system_AI_owners];
_grp setVariable ['QS_AI_GRP_CONFIG',['GENERAL','DIVER',(count (units _grp))],QS_system_AI_owners];
_grp setVariable ['QS_AI_GRP_DATA',[],QS_system_AI_owners];
_grp setVariable ['QS_AI_GRP',TRUE,QS_system_AI_owners];

[(units _grp),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');

_foundPos = FALSE;
while {!_foundPos} do {
	_relPos = _pos getPos [(random 300),(random 360)];
	if (surfaceIsWater _relPos) exitWith {};
	uiSleep 0.01;
};
_subType = selectRandom _subTypes;
_sub = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _subType,_subType],_relPos,[],0,'NONE'];
_sub lock 3;
_sub allowCrewInImmobile [TRUE,TRUE];
0 = _enemiesArray pushBack _sub;
_grp = createVehicleCrew _sub;
_sub swimInDepth -2.5;
{
	_grpUnit = _x;
	_grpUnit call (missionNamespace getVariable 'QS_fnc_unitSetup');
	{
		if ((toLowerANSI _x) in QS_core_classNames_grenades) then {
			_grpUnit removeMagazine _x;
		};
	} forEach (magazines _grpUnit);
	_grpUnit swimInDepth -3;
	0 = _enemiesArray pushBack _grpUnit;
} count (units _grp);
_patrolRoute = [];
for '_x' from 0 to 2 step 1 do {
	_relPos = [_pos,(100 + (random 200)),(random 360),TRUE] call _QS_fnc_radPos;
	_patrolRoute pushBack [_relPos # 0,_relPos # 1,-3];
};
_patrolRoute pushBack [((getPos _unit) # 0),((getPos _unit) # 1),-3];
_grp setVariable ['QS_AI_GRP_TASK',['PATROL',_patrolRoute,serverTime,-1],QS_system_AI_owners];
_grp setVariable ['QS_AI_GRP_PATROLINDEX',0,QS_system_AI_owners];
_grp setVariable ['QS_AI_GRP_CONFIG',['GENERAL','DIVER',(count (units _grp))],QS_system_AI_owners];
_grp setVariable ['QS_AI_GRP_DATA',[],QS_system_AI_owners];
_grp setVariable ['QS_AI_GRP',TRUE,QS_system_AI_owners];
[(units _grp),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
private _swimDepth = 0;
for '_x' from 0 to (14 + (round (random 4))) step 1 do {
	_terrainHeightASLActual = _terrainHeightASL / (random 3);
	_relPos = [_pos # 0,_pos # 1,_terrainHeightASLActual] getPos [(random 360),(random 360)];
	_grp = [_relPos,(random 360),RESISTANCE,'HAF_DiverSentry',FALSE] call (missionNamespace getVariable 'QS_fnc_spawnGroup');
	[(units _grp),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
	{
		_grpUnit = _x;
		_swimDepth = random [(getTerrainHeightASL (getPosWorld _x)),((getTerrainHeightASL (getPosWorld _x)) / 2),-1];
		_grpUnit swimInDepth _swimDepth;
		0 = _enemiesArray pushBack _grpUnit;
		_grpUnit setSkill ['aimingAccuracy',(random [0.05,0.1,0.15])];
		_grpUnit setVariable ['QS_AI_UNIT_aimingAccuracy',(_grpUnit skillFinal 'aimingAccuracy'),QS_system_AI_owners];
		_grpUnit setVariable ['QS_AI_UNIT_swimDepth',_swimDepth,QS_system_AI_owners];
		{
			if ((toLowerANSI _x) in QS_core_classNames_grenades) then {
				_grpUnit removeMagazine _x;
			};
		} forEach (magazines _grpUnit);
	} count (units _grp);
	_patrolRoute = [];
	for '_x' from 0 to 3 step 1 do {
		_relPos = [_pos,(100 + (random 200)),(random 360),TRUE] call _QS_fnc_radPos;
		_patrolRoute pushBack [_relPos # 0,_relPos # 1,(((units _grp) # 0) getVariable ['QS_AI_UNIT_swimDepth',-5])];
	};
	_patrolRoute pushBack [((getPos _unit) # 0),((getPos _unit) # 1),(getTerrainHeightASL (getPos ((units _grp) # 0)))];
	_grp setVariable ['QS_AI_GRP_TASK',['PATROL',_patrolRoute,serverTime,-1],QS_system_AI_owners];
	_grp setVariable ['QS_AI_GRP_PATROLINDEX',0,QS_system_AI_owners];
	_grp setVariable ['QS_AI_GRP_CONFIG',['GENERAL','DIVER',(count (units _grp))],QS_system_AI_owners];
	_grp setVariable ['QS_AI_GRP_DATA',[],QS_system_AI_owners];
	_grp setVariable ['QS_AI_GRP',TRUE,QS_system_AI_owners];
	_grp setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
};
_enemiesArray;