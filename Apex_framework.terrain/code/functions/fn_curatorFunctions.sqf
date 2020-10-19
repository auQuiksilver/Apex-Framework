/*
File: fn_curatorFunctions.sqf
Author:

	Quiksilver
	
Last Modified:

	7/07/2018 A3 1.82 by Quiksilver
	
Description:

	Custom Curator Functions
	
Keys:

	NUM_0 = 82
	NUM_1 = 79
	NUM_2 = 80
	NUM_3 = 81
	NUM_4 = 75
	NUM_5 = 76
	NUM_6 = 77
	NUM_7 = 71
	NUM_8 = 72
	NUM_9 = 73

	https://community.bistudio.com/wiki/curatorSelected
______________________________________________________*/

_key = _this select 0;
if (isNull (findDisplay 312)) exitWith {};
if (!(_key in [82,79,80,81,75,76,77,71,72,73])) exitWith {};
if (diag_tickTime < (player getVariable ['QS_curator_executingFunction',-1])) exitWith {};
player setVariable ['QS_curator_executingFunction',(diag_tickTime + 2),FALSE];
scopeName 'main';
if (_key isEqualTo 82) exitWith {
	playSound ['ClickSoft',FALSE];
	(missionNamespace getVariable 'QS_managed_hints') pushBack [5,TRUE,5,-1,'No function',[],-1,TRUE,'Curator',FALSE];
};
if (_key isEqualTo 79) exitWith {
	//comment 'Garrison selected units into buildings';
	playSound ['ClickSoft',FALSE];
	private ['_selectedUnits','_countUnits','_radius'];
	_selectedUnits = [];
	if ((curatorSelected select 0) isEqualTo []) then {breakTo 'main';};
	{
		if (_x isKindOf 'Man') then {
			if (!isPlayer _x) then {
				if (alive _x) then {
					0 = _selectedUnits pushBack _x;
				};
			};
		};
	} count (curatorSelected select 0);
	if (_selectedUnits isEqualTo []) then {breakTo 'main';};
	_countUnits = count _selectedUnits;
	_radius = 50;
	if (_countUnits > 8) then {_radius = 100;};
	if (_countUnits > 16) then {_radius = 200;};
	if (_countUnits > 24) then {_radius = 300;};
	[(getPosATL (_selectedUnits select 0)),_radius,_selectedUnits,['House','Building']] spawn (missionNamespace getVariable 'QS_fnc_garrisonUnits');
	(missionNamespace getVariable 'QS_managed_hints') pushBack [5,TRUE,5,-1,'Units garrisoned',[],-1,TRUE,'Curator',FALSE];
};
if (_key isEqualTo 80) exitWith {
	//comment 'Group patrol';
	playSound ['ClickSoft',FALSE];
	private ['_selectedGroups','_countGroups','_radius'];
	_selectedGroups = [];
	if ((curatorSelected select 1) isEqualTo []) then {breakTo 'main';};
	{
		if (!(((units _x) findIf {(alive _x)}) isEqualTo -1)) then {
			if (!(isPlayer (leader _x))) then {
				0 = _selectedGroups pushBack _x;
			};
		};
	} count (curatorSelected select 1);
	if (_selectedGroups isEqualTo []) then {breakTo 'main';};
	{
		[_x,(getPosATL ((units _x) select 0)),100] call (missionNamespace getVariable 'QS_fnc_taskPatrol');
	} forEach _selectedGroups;
	(missionNamespace getVariable 'QS_managed_hints') pushBack [5,TRUE,5,-1,'Group patrol',[],-1,TRUE,'Curator',FALSE];
};
if (_key isEqualTo 81) exitWith {
	//comment 'Search building';
	playSound ['ClickSoft',FALSE];
	(missionNamespace getVariable 'QS_managed_hints') pushBack [5,TRUE,5,-1,'Group search building',[],-1,TRUE,'Curator',FALSE];
	private ['_buildings','_building','_selectedGroup','_waypoint','_grp'];
	if ((curatorSelected select 1) isEqualTo []) then {breakTo 'main';};
	{
		_grp = _x;
		if (!(((units _grp) findIf {(alive _x)}) isEqualTo -1)) then {
			if (!(isPlayer (leader _grp))) then {
				if ((count (waypoints _grp)) > 1) then {
					if ((count (waypoints _grp)) isEqualTo 2) then {
						_waypoint = (waypoints _grp) select 1;
						_buildings = nearestObjects [(waypointPosition _waypoint),['House'],15,TRUE];
						if (_buildings isEqualTo []) then {breakTo 'main';};
						_building = _buildings select 0;
						deleteWaypoint _waypoint;
						0 = [_grp,[_building,(count (_building buildingPos -1))]] spawn (missionNamespace getVariable 'QS_fnc_searchNearbyBuilding');
					};
				} else {
					0 = [_grp] spawn (missionNamespace getVariable 'QS_fnc_searchNearbyBuilding');
				};
			};
		};
	} count (curatorSelected select 1);
};
if (_key isEqualTo 75) exitWith {
	//comment 'Stalker squad';
	playSound ['ClickSoft',FALSE];
	private ['_prey','_building','_selectedGroups','_selectedGroup','_waypoint','_grp','_wpPosition','_nearestUnit','_nearestUnits'];
	_selectedGroups = [];
	if ((curatorSelected select 1) isEqualTo []) then {breakTo 'main';};
	{
		_grp = _x;
		if (local _grp) then {
			if (!(((units _grp) findIf {(alive _x)}) isEqualTo -1)) then {
				if (!(isPlayer (leader _grp))) then {
					if (!((waypoints _grp) isEqualTo [])) then {
						if (!((waypointPosition [_grp,(currentWaypoint _grp)]) isEqualTo [0,0,0])) then {
							_wpPosition = waypointPosition [_grp,(currentWaypoint _grp)];
							_nearestUnits = _wpPosition nearEntities [['CAManBase','LandVehicle'],25];
							if (!(_nearestUnits isEqualTo [])) then {
								_nearestUnit = _nearestUnits select 0;
								if (!isNull _nearestUnit) then {
									if (alive _nearestUnit) then {
										if (((lifeState _nearestUnit) in ['HEALTHY','INJURED']) || {(_nearestUnit isKindOf 'LandVehicle')}) then {
											[
												_grp,
												_nearestUnit,
												{FALSE},
												10,
												'RED',
												'AWARE',
												'FULL',
												'AUTO',
												0,
												FALSE
											] spawn (missionNamespace getVariable 'QS_fnc_stalk');
											0 = (missionNamespace getVariable 'QS_managed_hints') pushBack [5,TRUE,5,-1,'Stalking target',[],-1,TRUE,'Curator',FALSE];
										};
									};
								};
							} else {
								(missionNamespace getVariable 'QS_managed_hints') pushBack [5,TRUE,10,-1,'Stalking failed - No units within 15m of waypoint position',[],-1,TRUE,'Curator',FALSE];
							};
						} else {
							(missionNamespace getVariable 'QS_managed_hints') pushBack [5,TRUE,10,-1,'Stalking failed - Invalid waypoint position',[],-1,TRUE,'Curator',FALSE];
						};
					} else {
						(missionNamespace getVariable 'QS_managed_hints') pushBack [5,TRUE,5,-1,'Stalking failed - No waypoints',[],-1,TRUE,'Curator',FALSE];
					};
				} else {
					(missionNamespace getVariable 'QS_managed_hints') pushBack [5,TRUE,5,-1,'Stalking failed - Group leader is player',[],-1,TRUE,'Curator',FALSE];
				};
			};
		} else {
			(missionNamespace getVariable 'QS_managed_hints') pushBack [5,TRUE,5,-1,'Stalking failed - Group not local',[],-1,TRUE,'Curator',FALSE];
		};
	} count (curatorSelected select 1);
};
if (_key isEqualTo 76) exitWith {
	playSound ['ClickSoft',FALSE];
	(missionNamespace getVariable 'QS_managed_hints') pushBack [5,TRUE,5,-1,'No function',[],-1,TRUE,'Curator',FALSE];
};
if (_key isEqualTo 77) exitWith {
	playSound ['ClickSoft',FALSE];
	(missionNamespace getVariable 'QS_managed_hints') pushBack [5,TRUE,5,-1,'Suppressive Fire',[],-1,TRUE,'Curator',FALSE];
	private ['_selectedUnits','_countUnits','_radius','_unit'];
	_selectedUnits = [];
	if ((curatorSelected select 0) isEqualTo []) then {breakTo 'main';};
	{
		if (_x isKindOf 'Man') then {
			if (!isPlayer _x) then {
				if (alive _x) then {
					0 = _selectedUnits pushBack _x;
				};
			};
		};
	} count (curatorSelected select 0);
	if (_selectedUnits isEqualTo []) then {breakTo 'main';};
	{
		_unit = _x;
		if (!((vehicle _unit) isKindOf 'Man')) then {
			(vehicle _unit) sendSimpleCommand 'FIRE';
		};
		if (alive (getAttackTarget _unit)) then {
			if (([objNull,'VIEW'] checkVisibility [(eyePos _unit),(aimPos (getAttackTarget _unit))]) > 0) then {
				if (local _unit) then {
					_unit doSuppressiveFire (aimPos (getAttackTarget _unit));
				} else {
					0 = [30,_unit,(getAttackTarget _unit)] remoteExec ['QS_fnc_remoteExec',_unit,FALSE];
				};
			} else {
				if (local _unit) then {
					_unit doSuppressiveFire (aimPos (getAttackTarget _unit));
				} else {
					0 = [30,_unit,(aimPos (getAttackTarget _unit))] remoteExec ['QS_fnc_remoteExec',_unit,FALSE];
				};
			};
		};
	} count _selectedUnits;
	private _firingVehiclesArray = [];
	{
		_unit = _x;
		if (local _unit) then {
			if (isNil {_unit getVariable 'QS_vehicle_suppressiveFire'}) then {
				_unit setVariable ['QS_vehicle_suppressiveFire',TRUE,FALSE];
				if ((vehicle _unit) isKindOf 'Man') then {
					0 = _firingVehiclesArray pushBack [
						_unit,
						(_unit addEventHandler [
							'Fired',
							{
								params ['_unit','_weapon','_muzzle','_mode','_ammo','_magazine','_projectile'];
								_unit forceWeaponFire [_muzzle,'FullAuto'];
							}
						])
					];
				} else {
					0 = _firingVehiclesArray pushBack [
						(vehicle _unit),
						((vehicle _unit) addEventHandler [
							'Fired',
							{
								params ['_unit','_weapon','_muzzle','_mode','_ammo','_magazine','_projectile'];
								_unit forceWeaponFire [_muzzle,'FullAuto'];
							}
						])
					];
				};
			};
		};
	} forEach _selectedUnits;
	if (!(_firingVehiclesArray isEqualTo [])) then {
		_firingVehiclesArray spawn {
			uiSleep 20;
			{
				if (!isNull (_x select 0)) then {
					if (alive (_x select 0)) then {
						(_x select 0) removeEventHandler ['Fired',(_x select 1)];
					};
				};
			} forEach _this;
		};
	};
};
if (_key isEqualTo 71) exitWith {
	/*/
	if ((missionNamespace getVariable 'QS_curator_revivePoints') < 1) exitWith {
		(missionNamespace getVariable 'QS_managed_hints') pushBack [5,TRUE,7.5,-1,'Insufficient Curator Points. Curator points refill at the end of each AO.',[],-1,TRUE,'Curator',FALSE];
	};
	if ((curatorPoints (getAssignedCuratorLogic player)) <= 0.05) exitWith {
		(missionNamespace getVariable 'QS_managed_hints') pushBack [5,TRUE,7.5,-1,'Insufficient Curator Points. Curator points refill at the end of each AO.',[],-1,TRUE,'Curator',FALSE];
	};
	/*/
	//_module = getAssignedCuratorLogic player;
	//[28,_module,((curatorPoints _module) - 0.05)] remoteExec ['QS_fnc_remoteExec',2,FALSE];
	//comment 'Revive selected players';
	private _selectedUnits = [];
	if ((curatorSelected select 0) isEqualTo []) then {breakTo 'main';};
	{
		if (_x isKindOf 'Man') then {
			if (isNull (objectParent _x)) then {
				if (alive _x) then {
					if (isNull (attachedTo _x)) then {
						if ((lifeState _x) isEqualTo 'INCAPACITATED') then {
							0 = _selectedUnits pushBack _x;
						};
					};
				};
			};
		};
	} count (curatorSelected select 0);
	if (_selectedUnits isEqualTo []) then {breakTo 'main';};
	private _unit = _selectedUnits select 0;
	if ((lifeState _unit) isEqualTo 'INCAPACITATED') then {
		if (local _unit) then {
			_unit setUnconscious FALSE;
			_unit setCaptive FALSE;
		} else {
			[68,_unit,FALSE,FALSE] remoteExec ['QS_fnc_remoteExec',_unit,FALSE];
		};
	};
	/*/
	missionNamespace setVariable [
		'QS_curator_revivePoints',
		((missionNamespace getVariable 'QS_curator_revivePoints') - 1),
		TRUE
	];
	/*/
	//systemChat format ['Curator revives remaining: %1',(missionNamespace getVariable 'QS_curator_revivePoints')];
	_module = getAssignedCuratorLogic player;
	/*/[28,_module,((curatorPoints _module) - 0.05)] remoteExec ['QS_fnc_remoteExec',2,FALSE];/*/
	private _text = '';
	if ((random 1) > 0.333) then {
		_text = format ['%1 has been revived by a divine intervention!',((name _unit) + ([' [AI]',''] select (isPlayer _unit)))];
	} else {
		if ((random 1) > 0.5) then {
			_text = format ['The gods have smiled upon %1!',((name _unit) + ([' [AI]',''] select (isPlayer _unit)))];
		} else {
			_text = format ['%1 has been revived by an act of the gods!',((name _unit) + ([' [AI]',''] select (isPlayer _unit)))];
		};
	};
	if (!(_text isEqualTo '')) then {
		['systemChat',_text] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
	};
	(missionNamespace getVariable 'QS_managed_hints') pushBack [5,TRUE,5,-1,'Revived selected unit',[],-1,TRUE,'Curator',FALSE];
};
if (_key isEqualTo 72) exitWith {
	//comment 'Toggle player view directions';
	playSound ['ClickSoft',FALSE];
	if (isNil {missionNamespace getVariable 'QS_curator_playerViewDirections'}) then {
		(missionNamespace getVariable 'QS_managed_hints') pushBack [5,TRUE,5,-1,'Player view directions - ON',[],-1,TRUE,'Curator',FALSE];
		missionNamespace setVariable [
			'QS_curator_playerViewDirections',
			(
				addMissionEventHandler [
					'Draw3D',
					{
						private ['_p0','_v1','_p1','_arr'];
						{
							_p0 = eyePos _x;
							_v1 = getCameraViewDirection _x;
							_p1 = _p0 vectorAdd (_v1 vectorMultiply (currentZeroing (vehicle _x)));
							_p1 = ASLToAGL _p1;
							_p0 = ASLToAGL _p0;
							_arr = [_p0,_p1,[1,1,1,1]];
							for '_i' from 0 to 2 step 1 do {
								drawLine3D _arr;
							};
						} count allPlayers;
						if (isNull (findDisplay 312)) then {
							if (!isNil {missionNamespace getVariable 'QS_curator_playerViewDirections'}) then {
								removeMissionEventHandler ['Draw3D',(missionNamespace getVariable 'QS_curator_playerViewDirections')];
								missionNamespace setVariable ['QS_curator_playerViewDirections',nil,FALSE];
							};
						};
					}
				]
			),
			FALSE
		];
	} else {
		(missionNamespace getVariable 'QS_managed_hints') pushBack [5,TRUE,5,-1,'Player view directions - OFF',[],-1,TRUE,'Curator',FALSE];
		removeMissionEventHandler ['Draw3D',(missionNamespace getVariable 'QS_curator_playerViewDirections')];
		missionNamespace setVariable ['QS_curator_playerViewDirections',nil,FALSE];
	};	
};
if (_key isEqualTo 73) exitWith {
	playSound ['ClickSoft',FALSE];
	//comment 'Revive selected players';
	private _selectedUnits = [];
	if ((curatorSelected select 0) isEqualTo []) then {breakTo 'main';};
	{
		if (_x isKindOf 'Man') then {
			if (alive _x) then {
				if (!(isPlayer _x)) then {
					if (isNull (objectParent _x)) then {
						if (isNull (attachedTo _x)) then {
							if ((lifeState _x) in ['HEALTHY','INJURED']) then {
								_selectedUnits pushBack _x;
							};
						};
					};
				};
			};
		};
	} forEach (curatorSelected select 0);
	if (_selectedUnits isEqualTo []) then {breakTo 'main';};
	private _unit = _selectedUnits select 0;
	if ((lifeState _unit) in ['HEALTHY','INJURED']) then {
		if (local _unit) then {
			{
				_unit setVariable _x;
			} forEach [
				['QS_RD_draggable',TRUE,TRUE],
				['QS_RD_loadable',TRUE,TRUE]
			];
			_unit setUnconscious TRUE;
			_unit setCaptive TRUE;
			(missionNamespace getVariable 'QS_managed_hints') pushBack [5,TRUE,3,-1,'Unit set unconscious',[],-1,TRUE,'Curator',FALSE];
		} else {
			50 cutText ['Can only set unconscious units spawned by Zeus','PLAIN DOWN',0.333];
		};
	} else {
		50 cutText ['Cannot set this unit unconscious','PLAIN DOWN',0.333];
	};
};