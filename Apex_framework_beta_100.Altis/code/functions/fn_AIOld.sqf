/*
File: fn_AI.sqf
Author:

	Quiksilver
	
Last modified:

	3/12/2015 A3 1.54 by Quiksilver
	
Description:

	AI Manager
	
	- Designed to work on either server or headless client
	
	4 Components:
	
	- Request handler
	- Creator
	- Manager

Manager organizes the unit and group behaviour, including waypoints and tasks.
For performance sake we don't add more than one waypoint at a time, we allow the AI to get to their waypoint within a reasonable timeframe, then we set a new waypoint based on their orders and tasks.
__________________________________________________*/

private [''];

_isMultiplayer = isMultiplayer;
_isServer = isServer;
_isDedicated = isDedicated;
_hasInterface = hasInterface;

disableRemoteSensors TRUE;

_timeNow = time;
_threadSleep = 1;

_QS_AI_requester = FALSE;
_QS_AI_requester_delay = 5;
_QS_AI_requester_checkDelay = _timeNow + _QS_AI_requester_delay;
missionNamespace setVariable ['QS_AI_Manager_Request_Queue',[],FALSE];
_QS_AI_requester_requestQueue = [];

_QS_AI_creator = FALSE;
_QS_AI_creator_delay = 5;
_QS_AI_creator_checkDelay = _timeNow + _QS_AI_creator_delay;
missionNamespace setVariable ['QS_AI_Manager_Creator_Queue',[],FALSE];
_QS_AI_creator_queue = [];
_QS_AI_unitsArray = [];

_QS_AI_logic = FALSE;
_QS_AI_logic_delay = 15;
_QS_AI_logic_checkDelay = _timeNow + _QS_AI_logic_delay;
_QS_AI_logic_updateUnits_delay = 10;
_QS_AI_logic_updateUnits_checkDelay = _timeNow + _QS_AI_logic_updateUnits_delay;
_QS_AI_logic_updateGroups_delay = 10;
_QS_AI_logic_updateGroups_checkDelay = _timeNow + _QS_AI_logic_updateGroups_delay;

_QS_AI_dynamicSkill = FALSE;
_QS_AI_unitCap = 125;

_QS_AI_managed_units = [];
_QS_AI_managed_groups = [];

_index = -1;

for '_x' from 0 to 1 step 0 do {
	
	/*/============================================================================ Update some basic data/*/
	
	_timeNow = time;
	_dayTime = dayTime;
	_fps = diag_fps;
	_allPlayersCount = count allPlayers;
	_allAICount = count allUnits - _allPlayersCount;
	
	/*/============================================================================ Receive AI requests from mission control/*/
	
	if (_QS_AI_requester) then {
		if (_timeNow > _QS_AI_requester_checkDelay) then {
			_QS_AI_requester_requestQueue = missionNamespace getVariable 'QS_AI_Manager_Request_Queue';
			if (!isNil {_QS_AI_requester_requestQueue}) then {
				if (_QS_AI_requester_requestQueue isEqualType []) then {
					if (!(_QS_AI_requester_requestQueue isEqualTo [])) then {
						_QS_AI_request_actual = (_QS_AI_requester_requestQueue select 0) select 0;
						if (_QS_AI_request_actual isEqualTo 'PRIMARY') then {
							/*/ Handle request for AI from mission/*/
							_QS_mission_Position = (_QS_AI_requester_requestQueue select 0) select 1;
							_array = [_QS_mission_Position] call (missionNamespace getVariable 'QS_fnc_aoEnemy');
							if (!(_array isEqualTo [])) then {
								_newArray = [];
								{
									0 = _newArray pushBack _x;
								} count _array;
								missionNamespace setVariable [
									'QS_AI_Manager_Creator_Queue',
									_newArray,
									FALSE
								];
							};
						};
						_QS_AI_requester_requestQueue set [0,FALSE];
						_QS_AI_requester_requestQueue deleteAt 0;
						missionNamespace setVariable ['QS_AI_Manager_Request_Queue',_QS_AI_requester_requestQueue,FALSE];
					};
				};
			};
			_QS_AI_requester_checkDelay = _timeNow + _QS_AI_requester_delay;
		};
	};
	
	/*/============================================================================ Create/Delete AI/*/
	/*/['CREATE','PRIMARY','PATROL',_side,_position,'OIF_Assault']/*/
	/*/['DELETE','PRIMARY']/*/
	/*/0 = _requestArray pushBack ['CREATE','PRIMARY','PATROL','INFANTRY',EAST,_randomPos,_pos,_infType];/*/
	
	if (_QS_AI_creator) then {
		if (_timeNow > _QS_AI_creator_checkDelay) then {
			_QS_AI_creator_queue = missionNamespace getVariable 'QS_AI_Manager_Creator_Queue';
			if (!isNil {_QS_AI_creator_queue}) then {
				if (_QS_AI_creator_queue isEqualType []) then {
					if (!(_QS_AI_creator_queue isEqualTo [])) then {
						_QS_AI_create_actual = _QS_AI_creator_queue select 0;	
						_QS_AI_createOrDelete = _QS_AI_create_actual select 0;
						_QS_AI_create_mission = _QS_AI_create_actual select 1;
						if (_QS_AI_createOrDelete isEqualTo 'CREATE') then {
							_QS_AI_create_actual_array = _QS_AI_create_actual call (missionNamespace getVariable 'QS_fnc_AIcreate');
							0 = _QS_AI_unitsArray pushBack [_QS_AI_create_mission,_QS_AI_create_actual_array];
						} else {						
							if (_QS_AI_createOrDelete isEqualTo 'DELETE') then {
								{
									_index = [_QS_AI_unitsArray,_QS_AI_create_mission,0] call (missionNamespace getVariable 'ZEN_fnc_arrayGetNestedIndex');
									if (_index isEqualTo -1) then {
										_QS_AI_create_delete_array = (_QS_AI_unitsArray select _index) select 1;
										_QS_AI_create_delete_array call (missionNamespace getVariable 'QS_fnc_AIdelete');
										_QS_AI_unitsArray set [_index,FALSE];
										_QS_AI_unitsArray deleteAt _index;
									};
								} count _QS_AI_unitsArray;
							};
						};
						_QS_AI_creator_queue set [0,FALSE];
						_QS_AI_creator_queue deleteAt 0;
					};
				};
			};
			_QS_AI_creator_checkDelay = _timeNow + _QS_AI_creator_delay;
		};	
	};
	
	/*/============================================================================ Manage AI/*/
	
	if (_QS_AI_logic) then {
		if (_timeNow > _QS_AI_logic_checkDelay) then {
			if (_timeNow > _QS_AI_logic_updateUnits_checkDelay) then {
			
				/*/============================================================================ Add new units/*/
			
				{
					if (local _x) then {
						if (!isPlayer _x) then {
							_unit = _x;
							_managed = _unit getVariable ['QS_AI_UNIT',FALSE];
							if (!(_managed)) then {
								if (!isNil {_unit getVariable 'QS_AI_MANAGEREQUEST'}) then {
									if (_unit getVariable 'QS_AI_MANAGEREQUEST') then {
										0 = _QS_AI_managed_units pushBack _unit;
										_unit setVariable ['QS_AI_UNIT',TRUE,FALSE];
										_unit setVariable ['QS_AI_MANAGEREQUEST',nil];
									};
								};
							};
						};
					};
					sleep 0.01;
				} count allUnits;
				_QS_AI_logic_updateUnits_checkDelay = _timeNow + _QS_AI_logic_updateUnits_delay;
			};
			if (_timeNow > _QS_AI_logic_updateGroups_checkDelay) then {
			
				/*/============================================================================ Add new groups/*/
			
				{
					_grp = _x;
					if (local _grp) then {
						_managed = _grp getVariable ['QS_AI_GROUP',FALSE];
						if (!(_managed)) then {
							if (!isNil {_grp getVariable 'QS_AI_MANAGEREQUEST'}) then {
								if (_grp getVariable 'QS_AI_MANAGEREQUEST') then {
									0 = _QS_AI_managed_groups pushBack _grp;
									[_grp] call (missionNamespace getVariable 'QS_fnc_AIconfigGroup');
								};
							};
						};
					};
					sleep 0.01;
				} count allGroups;
				_QS_AI_logic_updateGroups_checkDelay = _timeNow + _QS_AI_logic_updateGroups_delay;
			};
			if ((count _QS_AI_managed_units) > 0) then {
				
				/*/============================================================================ Manage managed units/*/
			
				{
					_unit = _x;
					if ((isNull _unit) || {(!alive _unit)}) then {
						_QS_AI_managed_units set [_forEachIndex,FALSE];
						_QS_AI_managed_units deleteAt _forEachIndex;
					} else {
					
						/*/ Unit is alive/*/
					
					};
					sleep 0.01;
				} forEach _QS_AI_managed_units;
			};
			if ((count _QS_AI_managed_groups) > 0) then {
				
				/*/============================================================================ Manage managed groups/*/
				
				{
					_grp = _x;
					if ((isNull _grp) || {(({(alive _x)} count (units _x)) isEqualTo 0)}) then {
						_QS_AI_managed_groups set [_forEachIndex,FALSE];
						_QS_AI_managed_groups deleteAt _forEachIndex;
					} else {
					
						/*/Group has members/*/
					
					};
					sleep 0.01;
				} forEach _QS_AI_managed_groups;
			};
			_QS_AI_logic_checkDelay = _timeNow + _QS_AI_logic_delay;
		};
	};
	sleep _threadSleep;
};