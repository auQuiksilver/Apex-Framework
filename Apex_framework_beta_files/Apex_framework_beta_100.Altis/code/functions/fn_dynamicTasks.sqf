/*/
File: fn_dynamicTasks.sqf
Author: 

	Quiksilver

Last Modified:

	16/10/2017 A3 1.76 by Quiksilver

Description:

	Dynamic Tasks
	
	[1,'DESTROY',[cursorObject,player,(getText (configFile >> 'CfgVehicles' >> (typeOf player) >> 'displayName'))],TRUE] call

[77,'FIRE_SUPPORT',[cursorObject,profileName],FALSE] remoteExec ['QS_fnc_remoteExec',2];

	
____________________________________________________________________________/*/

params ['_case','_type','_params','_isRx'];
private _array = [];
if (_case isEqualTo 1) then {
	if (_type isEqualTo 'DESTROY') then {
		_entity = _params select 0;
		_taskAuthor = _params select 1;
		_taskAuthorClass = _params select 2;
		_taskID = format ['QS_DYNTASK_%1_%2',_type,(round (random 10000))];
		private _description = format ['Destroy a(n) %1.',(getText (configFile >> 'CfgVehicles' >> (typeOf _entity) >> 'displayName'))];
		if (_isRx) then {
			_description = format ['%1 Task created by %2 ( %3 ).',_description,_taskAuthor,_taskAuthorClass];
		};
		_array = [
			_taskID,
			'ADD',
			_type,
			[
				[	/*/CREATED/*/
					[_entity],
					{
						params ['_entity'];
						(alive _entity)
					},
					[
						_taskID,
						TRUE,
						[
							_description,
							'Destroy',
							'Destroy'
						],
						[_entity,TRUE],
						'CREATED',
						0,
						TRUE,
						TRUE,
						'destroy',
						FALSE
					]
				],
				[	/*/SUCCESS/*/
					[_entity],
					{
						params ['_entity'];
						(!alive _entity)
					}
				],
				[	/*/FAILED/*/
					[_entity],
					{
						FALSE
					}
				],
				[	/*/CANCEL/*/
					_params,
					{
						FALSE
					}
				]
			],
			_params
		];
		(missionNamespace getVariable 'QS_module_dynamicTasks_add') pushBack _array;
	};
	if (_type isEqualTo 'MEDEVAC') then {
		_entity = _params select 0;
		_entityName = _params select 1;
		_taskID = format ['QS_DYNTASK_%1_%2',_type,(round (random 10000))];
		(missionNamespace getVariable ['QS_dynTask_medevac_array',[]]) pushBack _entity;
		private _description = format ['Medevac %1.<br/><br/> Bring %1 to the white medical building at main base. The white building has Red Crystal decals and is marked on your map as Medevac HQ.<br/><br/>This person cannot be revived by others.',_entityName];
		_array = [
			_taskID,
			'ADD',
			_type,
			[
				[	/*/CREATED/*/
					[_entity],
					{
						params ['_entity'];
						((alive _entity) && ((lifeState _entity) isEqualTo 'INCAPACITATED'))
					},
					[
						_taskID,
						TRUE,
						[
							_description,
							'Medevac',
							'Medevac'
						],
						[_entity,TRUE],
						'CREATED',
						0,
						TRUE,
						TRUE,
						'heal',
						FALSE
					]
				],
				[	/*/SUCCESS/*/
					[_entity,(markerPos 'QS_marker_medevac_hq')],
					{
						params ['_entity','_medevacBase'];
						private _c = FALSE;
						if (alive _entity) then {
							if ((lifeState _entity) isEqualTo 'INCAPACITATED') then {
								if ((_entity distance _medevacBase) < 5) then {
									if (isNull (objectParent _entity)) then {
										if (isNull (attachedTo _entity)) then {
											_c = TRUE;
										};
									};
								};
							};
						};
						_c;
					}
				],
				[	/*/FAILED/*/
					[_entity],
					{
						params ['_entity'];
						(!alive _entity)
					}
				],
				[	/*/CANCEL/*/
					[_entity],
					{
						FALSE
					}
				]
			],
			_params
		];
		(missionNamespace getVariable 'QS_module_dynamicTasks_add') pushBack _array;
	};
	if (_type isEqualTo 'PRISONER') then {
		_entity = _params select 0;
		_taskID = format ['QS_DYNTASK_%1_%2',_type,(round (random 10000))];
		private _description = 'Ground forces have arrested a unit, get him back to base for interrogation. Locate the fenced area at base (map marker GITMO) and release him there to complete the mission.';
		_array = [
			_taskID,
			'ADD',
			_type,
			[
				[	/*/CREATED/*/
					[_entity],
					{
						params ['_entity'];
						(alive _entity)
					},
					[
						_taskID,
						TRUE,
						[
							_description,
							'Prisoner Extract',
							'Prisoner Extract'
						],
						[_entity,TRUE],
						'CREATED',
						0,
						TRUE,
						TRUE,
						'exit',
						FALSE
					]
				],
				[	/*/SUCCESS/*/
					[_entity,(markerPos 'QS_marker_gitmo')],
					{
						params ['_entity','_prisonBase'];
						private _c = FALSE;
						if (alive _entity) then {
							if ((_entity distance _prisonBase) < 20) then {
								if (isNull (objectParent _entity)) then {
									if (isNull (attachedTo _entity)) then {
										_c = TRUE;
									};
								};
							};
						};
						_c;
					}
				],
				[	/*/FAILED/*/
					[_entity],
					{
						params ['_entity'];
						(!alive _entity)
					}
				],
				[	/*/CANCEL/*/
					[_entity],
					{
						FALSE
					}
				]
			],
			_params
		];
		(missionNamespace getVariable 'QS_module_dynamicTasks_add') pushBack _array;
	};
	if (_type isEqualTo 'EVAC_PILOT') then {
		_entity = _params select 0;
		_entityName = _params select 1;
		_taskID = format ['QS_DYNTASK_%1_%2',_type,(round (random 10000))];
		private _description = format ['A pilot ( %1 ) has been separated from his aircraft and needs a ride back to base. When he is on foot within 500m of base the mission will be completed.',_entityName];
		_array = [
			_taskID,
			'ADD',
			_type,
			[
				[	/*/CREATED/*/
					[_entity],
					{
						params ['_entity'];
						(alive _entity)
					},
					[
						_taskID,
						TRUE,
						[
							_description,
							'Pilot Extract',
							'Pilot Extract'
						],
						[_entity,TRUE],
						'CREATED',
						0,
						TRUE,
						TRUE,
						'navigate',
						FALSE
					]
				],
				[	/*/SUCCESS/*/
					[_entity,(markerPos 'QS_marker_base_marker')],
					{
						params ['_entity','_base'];
						private _c = FALSE;
						if (alive _entity) then {
							if ((_entity distance _base) < 500) then {
								if (isNull (objectParent _entity)) then {
									if (isNull (attachedTo _entity)) then {
										_c = TRUE;
									};
								};
							};
						};
						_c;
					}
				],
				[	/*/FAILED/*/
					[_entity],
					{
						params ['_entity'];
						(!alive _entity)
					}
				],
				[	/*/CANCEL/*/
					[_entity],
					{
						params ['_entity'];
						(((vehicle _entity) isKindOf 'Air') && (_entity isEqualTo (driver (vehicle _entity))))
					}
				]
			],
			_params
		];
		(missionNamespace getVariable 'QS_module_dynamicTasks_add') pushBack _array;		
	};
	if (_type isEqualTo 'FIRE_SUPPORT') then {
		_entity = _params select 0;
		_taskAuthorName = _params select 1;
		_taskID = format ['QS_DYNTASK_%1_%2',_type,(round (random 10000))];
		_timeout = diag_tickTime + 900;
		private _description = format ['%1 has requested CAS / Fire Support on a(n) %2. This task will expire in 15 minutes.',_taskAuthorName,(getText (configFile >> 'CfgVehicles' >> (typeOf _entity) >> 'displayName'))];
		_array = [
			_taskID,
			'ADD',
			_type,
			[
				[	/*/CREATED/*/
					[_entity],
					{
						params ['_entity'];
						(alive _entity)
					},
					[
						_taskID,
						TRUE,
						[
							_description,
							'CAS / Fire Support',
							'CAS / Fire Support'
						],
						[_entity,TRUE],
						'CREATED',
						0,
						TRUE,
						TRUE,
						'target',
						FALSE
					]
				],
				[	/*/SUCCESS/*/
					[_entity],
					{
						params ['_entity'];
						(!alive _entity)
					}
				],
				[	/*/FAILED/*/
					[_entity],
					{
						FALSE
					}
				],
				[	/*/CANCEL/*/
					[_entity,_timeout],
					{
						params ['_entity','_timeout'];
						((diag_tickTime > _timeout) && (alive _entity))
					}
				]
			],
			_params
		];
		(missionNamespace getVariable 'QS_module_dynamicTasks_add') pushBack _array;
	};
};