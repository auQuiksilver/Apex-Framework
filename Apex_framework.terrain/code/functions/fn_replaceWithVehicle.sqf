/*/
File: fn_replaceWithVehicle.sqf
Author: 

	Quiksilver

Last Modified:

	28/07/2019 A3 1.94 by Quiksilver

Description:

	Replace Simple Object with vehicle
____________________________________________________________________________/*/

params ['','_prop','_clientOwner','_clientObject','_clientUID'];
if (!isNull _prop) then {
	if (isSimpleObject _prop) then {
		if !(_prop isNil 'QS_vehicle_easterEgg') then {
			_position = getPosATL _prop;
			_vectorDirAndUp = [(vectorDir _prop),(vectorUp _prop)];
			_type = typeOf _prop;
			deleteVehicle _prop;
			_v = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _type,_type],[(random -1000),(random -1000),(1000 + (random 1000))],[],0,'NONE'];
			_v setVectorDirAndUp _vectorDirAndUp;
			_v setPosATL _position;
			_v setVariable ['QS_vehicle_delayedDelete',(diag_tickTime + 600),FALSE];
			_v addEventHandler [
				'GetOut',
				{
					params ['_vehicle'];
					if (diag_tickTime > (_vehicle getVariable ['QS_vehicle_delayedDelete',-1])) then {
						if (((crew _vehicle) findIf {(alive _x)}) isEqualTo -1) then {
							if (!(_vehicle isKindOf 'Air')) then {
								deleteVehicle _vehicle;
							};
						};
					};
				}
			];
			[_v] call (missionNamespace getVariable 'QS_fnc_vSetup');
			clearMagazineCargoGlobal _v;
			clearWeaponCargoGlobal _v;
			(missionNamespace getVariable 'QS_garbageCollector') pushBack [_v,'DELAYED_DISCREET',300];
		} else {
			//comment 'Insert spawned thread here to ensure it cant be exploited or spammed';
			_i = (serverNamespace getVariable 'QS_v_Monitor') findIf {
				((!(_x isEqualType TRUE)) && {((_x # 0) isEqualTo _prop)})
			};
			if (_i isNotEqualTo -1) then {
				_array = (serverNamespace getVariable 'QS_v_Monitor') # _i;
				_array params [
					'_v',
					'_vdelay',
					'_randomize',
					'_configCode',
					'_t',
					'_vpos',
					'_dir',
					'_isRespawning',
					'_canRespawnAfter',
					'_fobVehicleID',
					'_QS_vRespawnDist_base',
					'_QS_vRespawnDist_field',
					'_vRespawnTickets',
					'_nearEntitiesCheck',
					'_isDynamicVehicle',
					'_isCarrierVehicle',
					['_vehicleSpawnCondition',{TRUE}],
					['_isWreck',FALSE],
					['_isDeployed',FALSE],
					['_stateInfo',[]],
					['_wreckInfo',[]],
					['_wreckChance',0],
					['_wreckCond',{TRUE}]
				];
				deleteVehicle _prop;
				_v = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _t,_t],[(random -1000),(random -1000),(1000 + (random 1000))],[],0,'NONE'];
				if (_dir isEqualType 0) then {
					_v setDir _dir;
				} else {
					if (_dir isEqualType []) then {
						_v setVectorDirAndUp _dir;
					};
				};
				if (_isCarrierVehicle isEqualTo 0) then {
					_v setVectorUp (surfaceNormal _vpos);
					_v setPosASL ((AGLToASL _vpos) vectorAdd [0,0,0.1]);
				} else {
					if (_isCarrierVehicle isEqualTo 1) then {
						_v setPosASL _vpos;
					};
				};
				if ((str _configCode) isNotEqualTo '{}') then {
					_v call _configCode;
				};
				_v setVariable ['QS_wreck_chance',(random 1) < _wreckChance,TRUE];
				[_v] call (missionNamespace getVariable 'QS_fnc_vSetup');
				(serverNamespace getVariable 'QS_v_Monitor') set [_i,[_v,_vdelay,_randomize,_configCode,_t,_vpos,_dir,FALSE,0,_fobVehicleID,_QS_vRespawnDist_base,_QS_vRespawnDist_field,_vRespawnTickets,_nearEntitiesCheck,_isDynamicVehicle,_isCarrierVehicle,_vehicleSpawnCondition,FALSE,FALSE,_stateInfo,_wreckInfo,_wreckChance,_wreckCond]];
			};
		};
	};
};