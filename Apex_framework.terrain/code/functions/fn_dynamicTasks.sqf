/*/
File: fn_dynamicTasks.sqf
Author: 

	Quiksilver

Last Modified:

	6/11/2023 A3 2.14 by Quiksilver

Description:

	Dynamic Tasks
____________________________________________________________________________/*/

params ['_case','_type','_params','_isRx'];
private _array = [];
if (_case isEqualTo 1) then {
	if (_type isEqualTo 'DESTROY') then {
		_entity = _params # 0;
		_taskAuthor = _params # 1;
		_taskAuthorClass = _params # 2;
		_taskID = format ['QS_DYNTASK_%1_%2',_type,(round (random 10000))];
		private _description = format ['Destroy a(n) %1.',(getText ((configOf _entity) >> 'displayName'))];
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
		_entity = _params # 0;
		_entityName = _params # 1;
		_taskID = format ['QS_DYNTASK_%1_%2',_type,(round (random 10000))];
		(missionNamespace getVariable ['QS_dynTask_medevac_array',[]]) pushBack _entity;
		[_entityName,{50 cutText [(format [localize 'STR_QS_Text_207',_this]),'PLAIN DOWN',0.5];}] remoteExec ['call',(allPlayers select {(_x getUnitTrait 'QS_trait_pilot')}),FALSE];
		private _description = format ['Medevac %1.<br/><br/> Bring %1 to the medical facility at base. The location is marked on your map as Medevac HQ.<br/><br/>This person cannot be revived by others.<br/><br/>If the task does not complete, have the patient wait at the medical facility for approximately 30 seconds.',_entityName];
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
						(
							(alive _entity) &&
							((lifeState _entity) isNotEqualTo 'INCAPACITATED') &&
							((_entity distance2D _medevacBase) < 50) &&
							(isNull (objectParent _entity)) &&
							(isNull (attachedTo _entity))
						)
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
		_entity = _params # 0;
		_entity setTaskMarkerOffset [0,-10,1];
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
						params ['_entity'];
						(isNull _entity)
					}
				],
				[	/*/FAILED/*/
					[_entity],
					{
						params ['_entity'];
						(
							(!isNull _entity) &&
							(!alive _entity)
						)
					}
				],
				[	/*/CANCEL/*/
					[_entity],
					{
						params ['_entity'];
						(isNull _entity)
					}
				]
			],
			_params
		];
		(missionNamespace getVariable 'QS_module_dynamicTasks_add') pushBack _array;
	};
	if (_type isEqualTo 'EVAC_PILOT') then {
		_entity = _params # 0;
		_entityName = _params # 1;
		_taskID = format ['QS_DYNTASK_%1_%2',_type,(round (random 10000))];
		private _description = format ['A pilot ( %1 ) has been separated from his aircraft and needs a ride back to base. When he is within 500m of base the mission will be completed.',_entityName];
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
						(
							(alive _entity) &&
							((_entity distance2D _base) < 500)
						)
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
		_entity = _params # 0;
		_taskAuthorName = _params # 1;
		_taskID = format ['QS_DYNTASK_%1_%2',_type,(round (random 10000))];
		_timeout = diag_tickTime + 900;
		private _description = format ['%1 has requested CAS/Artillery on a(n) %2. This task will expire in 15 minutes.',_taskAuthorName,(getText ((configOf _entity) >> 'displayName'))];
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