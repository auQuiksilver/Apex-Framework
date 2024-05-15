/*/
File: fn_propCustomCode.sqf
Author:
	
	Quiksilver
	
Last Modified:

	25/11/2023 A3 2.14 by Quiksilver
	
Description:

	-
__________________________________________/*/

params ['_entity',['_class',''],['_parent',objNull]];
if (_class isEqualTo '') then {
	_class = toLowerANSI (typeOf _entity);
} else {
	_class = toLowerANSI _class;
};
{
	_entity setVariable _x;
} forEach [
	['QS_logistics_immovable',TRUE,TRUE],			// Note for later: not sure about this
	['QS_logistics',FALSE,TRUE]
];
_simulation = QS_hashmap_configfile getOrDefaultCall [
	format ['cfgvehicles_%1_simulation',toLowerANSI (typeOf _entity)],
	{toLowerANSI (getText ((configOf _entity) >> 'simulation'))},
	TRUE
];
if ((toLowerANSI _simulation) in ['house']) then {
	_entity addEventHandler [
		'Deleted',
		{
			params ['_entity'];
			(0 boundingBoxReal _entity) params ['','','_radius'];
			_nearObjects = nearestObjects [_entity,[],_radius * 3,TRUE];
			if (_nearObjects isNotEqualTo []) then {
				[
					_nearObjects,
					{
						{
							if (local _x) then {
								_x awake TRUE;
							};
						} forEach _this;
					}
				] remoteExec ['call',0,FALSE];
			};
		}
	];
	_entity addEventHandler [
		'Killed',
		{
			params ['_entity'];
			(0 boundingBoxReal _entity) params ['','','_radius'];
			_nearObjects = nearestObjects [_entity,[],_radius * 3,TRUE];
			if (_nearObjects isNotEqualTo []) then {
				[
					_nearObjects,
					{
						{
							if (local _x) then {
								_x awake TRUE;
							};
						} forEach _this;
					}
				] remoteExec ['call',0,FALSE];
			};
		}
	];
} else {
	if ((toLowerANSI _simulation) in ['thingx']) then {
		_entity setVariable ['QS_logistics',TRUE,TRUE];
		_entity setVariable ['QS_logistics_immovable',FALSE,TRUE];
	};
};
if (_entity isKindOf 'CargoPlatform_01_base_F') then {
	[_entity,TRUE,TRUE] call QS_fnc_logisticsPlatformSnap;
};
if (_entity isKindOf 'AreaMarker_01_F') then {
	comment 'vehicle spawner';
	_parent setVariable ['QS_vehicleSpawnPad',_entity,TRUE];
	QS_registered_vehicleSpawners = QS_registered_vehicleSpawners select {!isNull _x};
	QS_registered_vehicleSpawners pushBack _entity;
};
if (_class isKindOf 'StaticWeapon') then {
	_entity enableWeaponDisassembly FALSE;
	_entity enableRopeAttach FALSE;
	_entity enableVehicleCargo FALSE;
};
if (
	(_class isKindOf 'flagpole_f') ||
	(_class isKindOf 'portableflagpole_01_f')
) then {
	_entity setFlagTexture (missionNamespace getVariable ['QS_missionConfig_textures_defaultFlag','a3\data_f\flags\flag_nato_co.paa']);
	if (_class isKindOf 'portableflagpole_01_f') then {
		_entity animateSource ['flag_source',1,TRUE];
		[_entity,1] remoteExec ['setFlagAnimationPhase',0,FALSE];
	};
};
if (_class in ['sign_arrow_yellow_f']) then {
	if ([_entity,30] call QS_fnc_canFlattenTerrain) then {
		_width = 5;
		_fnc_flattenTerrain = {
			params ['_start','_a','_b','_h'];
			getTerrainInfo params ['', '', '_cellsize',''];
			_step = _cellsize / 2;
			private _newPositions = [];
			private _oldPositions = [];
			_aa = -_a;
			_bb = -_b;
			for '_xStep' from _aa to _a step _step do {
				for '_yStep' from _bb to _b step _step do {
					private _newHeight = _start vectorAdd [_xStep, _yStep, 0];
					_newHeight set [2,_h];
					if ((getTerrainHeight _newHeight) isNotEqualTo _h) then {
						_oldPositions pushBack (getTerrainHeight _newHeight);
						_newPositions pushBack _newHeight;
					};
				}; 
			}; 
			[_oldPositions,_newPositions]
		};
		private _desiredTerrainHeight = (getTerrainHeight (getPosWorld _entity)) - 0;
		private _positionsAndHeights = [getPosWorld _entity,_width,_width,_desiredTerrainHeight] call _fnc_flattenTerrain;
		QS_system_terrainMod pushBack _positionsAndHeights;
		diag_log format ['***** TERRAIN FLATTEN ***** total count: %1 ***** this adjustment: %2 *****',count QS_system_terrainMod,_positionsAndHeights # 1];
		setTerrainHeight [_positionsAndHeights # 1,TRUE];
		_entity spawn {
			_this hideObjectGlobal TRUE;
			sleep 0.5;
			deleteVehicle _this;
		};
	} else {
		_entity spawn {
			_this hideObjectGlobal TRUE;
			sleep 0.5;
			deleteVehicle _this;
		};	
	};
};
if (_class isKindOf 'Lamps_base_F') then {
	if (([_entity] call QS_fnc_getObjectVolume) < 2.1) then {
		_entity spawn {
			sleep 1;
			{
				_this setVariable _x;
			} forEach [
				['QS_logistics_immovable',FALSE,TRUE],
				['QS_logistics',TRUE,TRUE]
			];
		};
	};
};
if (_class isKindOf 'CAManBase') then {
	[_entity,((_parent getVariable ['QS_deploy_tickets',-1]) isNotEqualTo -1)] call QS_fnc_serverUnitConfigure;
	_nearbyStatics = (nearestObjects [_entity,['StaticWeapon'],2,TRUE]) select {
		(
			(alive _x) && 
			{((crew _x) isEqualTo [])} &&
			{(!isObjectHidden _x)} &&
			{(simulationEnabled _x)} &&
			{(isNull (attachedTo _x))} &&
			{(isNull (isVehicleCargo _x))} &&
			{((ropes _x) isEqualTo [])} &&
			{(isNull (ropeAttachedTo _x))} &&
			{((locked _x) in [-1,0,1])} &&
			{(!unitIsUav _x)}
		)
	};
	if (_nearbyStatics isNotEqualTo []) then {
		_nearbyStatic = _nearbyStatics # 0;
		_entity assignAsGunner _nearbyStatic;
		_entity moveInGunner _nearbyStatic;
	};
	if (!isNull (group _entity)) then {
		(group _entity) enableDynamicSimulation TRUE;
	};
	_entity enableDynamicSimulation TRUE;
	_entity enableAIFeature ['ALL',TRUE];
	if (_entity isKindOf 'CAManBase') then {
		_entity setVariable ['QS_unit_canSetStance',TRUE,TRUE];
		_entity enableAIFeature ['PATH',FALSE];
		(group _entity) setFormDir (getDir _entity);
		_entity setUnitPos 'Up';
		_entity setSkill 1;
	};
	_entity addEventHandler [
		'Local',
		{
			params ['_entity','_isLocal'];
			_entity removeEventHandler [_thisEvent,_thisEventHandler];
			if (!_isLocal) then {
				[
					[_entity,_thisEvent],
					{
						params ['_entity','_thisEvent'];
						_entity removeEventHandler [_thisEvent,0];
						_entity enableAIFeature ['ALL',TRUE];
						_entity enableAIFeature ['PATH',TRUE];
						_entity setSkill 1;
						_entity addEventHandler [
							'Killed',
							{
								params ['_entity','_killer','_instigator'];
								if (
									(isNull _killer) ||
									{(isPlayer _killer)} ||
									{(isPlayer (effectiveCommander _killer))} ||
									{(isPlayer _instigator)}
								) then {
									removeAllWeapons _entity;
									removeAllAssignedItems _entity;
									removeAllItems _entity;
									{
										_entity removeMagazine _x;
									} forEach (magazines _entity);
								};
							}
						];
					}
				] remoteExec ['call',_entity,FALSE];
			};
			_entity enableAIFeature ['ALL',TRUE];
			_entity enableAIFeature ['PATH',TRUE];
			_entity setSkill 1;
		}
	];
	_entity addEventHandler [
		'Killed',
		{
			params ['_entity','_killer','_instigator'];
			if (
				(isNull _killer) ||
				{(isPlayer _killer)} ||
				{(isPlayer (effectiveCommander _killer))} ||
				{(isPlayer _instigator)}
			) then {
				removeAllWeapons _entity;
				removeAllAssignedItems _entity;
				removeAllItems _entity;
				{
					_entity removeMagazine _x;
				} forEach (magazines _entity);
			};
		}
	];
	_entity addEventHandler [
		'Deleted',
		{
			params ['_entity'];
			_parent = _entity getVariable ['QS_virtualCargoParent',objNull];
			if (
				(!isNull _parent)
			) then {
				['SET_SERVER',_parent,_entity] call QS_fnc_virtualVehicleCargo;
			};
		}
	];
	_entity call QS_fnc_unitSetup;
};
