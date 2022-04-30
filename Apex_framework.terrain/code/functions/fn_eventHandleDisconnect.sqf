/*/
File: fn_eventHandleDisconnect.sqf
Author:

	Quiksilver
	
Last modified:

	30/10/2018 A3 1.84 by Quiksilver
	
Description:

	Handle Disconnect Mission Event
__________________________________________________/*/

params ['_object','_cid','_uid','_name'];
if ((_uid select [0,2]) isEqualTo 'HC') exitWith {};
['HANDLE',['HANDLE_DISCONNECT',_this]] call (missionNamespace getVariable 'QS_fnc_roles');
if (!isNull (group _object)) then {
	if (!isNull (objectParent _object)) then {
		if ((objectParent _object) isKindOf 'AllVehicles') then {
			if (local (objectParent _object)) then {
				(objectParent _object) deleteVehicleCrew _object;
			} else {
				[(objectParent _object),_object] remoteExec ['deleteVehicleCrew',(objectParent _object),FALSE];
			};
		};
	};
};

if (_object getUnitTrait 'QS_trait_fighterPilot') then {
	if (missionNamespace getVariable ['QS_CAS_jetAllowance_gameover',FALSE]) then {
		missionNamespace setVariable ['QS_CAS_jetAllowance_gameover',FALSE,FALSE];
	};
};

if (!isNil {_object getVariable 'QS_pilot_vehicleInfo'}) then {
	_vehicleInfo = _object getVariable 'QS_pilot_vehicleInfo';
	_vehicle = _vehicleInfo # 0;
	_vehicleRole = _vehicleInfo # 1;
	if (_vehicle isKindOf 'Air') then {
		if ((_vehicle distance (markerPos 'QS_marker_base_marker')) > 600) then {
			if (!isTouchingGround _vehicle) then {
				if ((_vehicleRole # 0) isEqualTo 'driver') then {
					missionNamespace setVariable ['QS_analytics_entities_deleted',((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),FALSE];
					[_vehicle,_name] spawn {
						scriptName 'QS Script RTB';
						sleep 0.5;
						params ['_vehicle','_name'];
						private ['_grp','_unit','_wp','_posToGo','_helipad'];
						_grp = createGroup [WEST,TRUE];
						private _unit = _grp createUnit [(if (_vehicle isKindOf 'Helicopter') then [{'B_helipilot_F'},{'B_pilot_F'}]),[6946,7450,0],[],0,'NONE'];
						missionNamespace setVariable ['QS_analytics_entities_created',((missionNamespace getVariable 'QS_analytics_entities_created') + 1),FALSE];
						_unit setUnitTrait ['QS_trait_pilot',TRUE,TRUE];
						removeAllWeapons _unit;
						removeAllItems _unit;
						_unit enableStamina FALSE;
						_unit enableFatigue FALSE;
						_unit setVariable ['BIS_fnc_moduleRemoteControl_owner',objNull,TRUE];
						for '_x' from 0 to 2 step 1 do {
							if (_unit isNotEqualTo (driver _vehicle)) then {
								_unit assignAsDriver _vehicle;
								_unit moveInDriver _vehicle;
							};
						};
						[_unit,_vehicle] spawn {
							params ['_unit','_vehicle'];
							for '_x' from 0 to 2 step 1 do {
								if (_unit isNotEqualTo (driver _vehicle)) then {
									_unit assignAsDriver _vehicle;
									_unit moveInDriver _vehicle;
								};
							};
							sleep 2;
							if ((vehicle _unit) isNotEqualTo _vehicle) then {
								missionNamespace setVariable ['QS_analytics_entities_deleted',((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),FALSE];
								deleteVehicle _unit;
							};
						};
						_unit setCaptive TRUE;
						_vehicle setDamage 0;
						if (_vehicle isKindOf 'Helicopter') then {
							_vehicle flyInHeight 50;
							for '_x' from 0 to 1 step 1 do {
								_vehicle setVariable ['QS_rappellSafety',nil,TRUE];
							};
						};
						if (local _vehicle) then {
							_vehicle setFuel 1;
						} else {
							['setFuel',_vehicle,1] remoteExec ['QS_fnc_remoteExecCmd',_vehicle,FALSE];
						};
						_unit addEventHandler [
							'GetOutMan',
							{
								deleteVehicle (_this # 0);
								missionNamespace setVariable ['QS_analytics_entities_deleted',((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),FALSE];
							}
						];
						_unit addEventHandler [
							'SeatSwitchedMan',
							{
								deleteVehicle (_this # 0);
								missionNamespace setVariable ['QS_analytics_entities_deleted',((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),FALSE];
							}
						];
						_unit addEventHandler [
							'Deleted',
							{
								params ['_entity'];
								(objectParent _entity) removeAllEventHandlers 'ControlsShifted';
							}
						];
						_vehicle addEventHandler [
							'ControlsShifted',
							{
								params ['_vehicle','_newController','_oldController'];
								if (!isPlayer _oldController) then {
									missionNamespace setVariable ['QS_analytics_entities_deleted',((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),FALSE];
									_vehicle deleteVehicleCrew _oldController;
								};
								// move new controller to pilot seat
								_vehicle removeEventHandler ['ControlsShifted',_thisEventHandler];
							}
						];
						{
							_unit disableAI _x;
						} forEach [
							'AUTOCOMBAT',
							'TARGET',
							'AUTOTARGET',
							'SUPPRESSION'
						];
						_unit setSkill 0;
						private _baseID = 0;
						if (worldName isEqualTo 'Tanoa') then {
							_posToGo = _vehicle getVariable ['QS_heli_spawnPosition',[6946,7450,0]];
							_baseID = 0;
						} else {
							_posToGo = _vehicle getVariable ['QS_heli_spawnPosition',(markerPos 'QS_marker_base_marker')];
							_baseID = 0;
						};
						if (_vehicle isKindOf 'Helicopter') then {
							_wp = _grp addWaypoint [_posToGo,30];
							_wp setWaypointType 'GETOUT';
							_wp setWaypointBehaviour 'CARELESS';
							_wp setWaypointSpeed 'FULL';
							_wp setWaypointCombatMode 'BLUE';
							_wp setWaypointPosition [_posToGo,0];
							_wp setWaypointStatements ['TRUE','if (local this) then {(vehicle this) land "get out";if (!isNull ((vehicle this) getVariable ["QS_heli_landingPad",objNull])) then {(vehicle this) landAt ((vehicle this) getVariable "QS_heli_landingPad");} else {};};'];
							_vehicle forceSpeed (getNumber (configFile >> 'CfgVehicles' >> (typeOf _vehicle) >> 'maxSpeed'));
							_helipad = 'Land_HelipadEmpty_F' createVehicleLocal _posToGo;
							_vehicle setVariable ['QS_heli_landingPad',_helipad,FALSE];
							missionNamespace setVariable ['QS_analytics_entities_created',((missionNamespace getVariable 'QS_analytics_entities_created') + 1),FALSE];
							(missionNamespace getVariable 'QS_garbageCollector') pushBack [_helipad,'DELAYED_FORCED',(time + 600)];
						} else {
							if (_vehicle isKindOf 'Plane') then {
								_vehicle assignToAirport _baseID;
								_vehicle landAt _baseID;
								_wp = _grp addWaypoint [_posToGo,30];
								_wp setWaypointType 'GETOUT';
								_wp setWaypointBehaviour 'CARELESS';
								_wp setWaypointSpeed 'FULL';
								_wp setWaypointCombatMode 'BLUE';
								_wp setWaypointPosition [_posToGo,0];
								_vehicle forceSpeed (getNumber (configFile >> 'CfgVehicles' >> (typeOf _vehicle) >> 'maxSpeed'));
								_vehicle addEventHandler [
									'LandedTouchDown',
									{
										params ['_vehicle','_airportID'];
										if (!isNull (driver _vehicle)) then {
											if (!isPlayer (driver _vehicle)) then {
												//comment "deleteVehicle (driver _vehicle);";
											};
										};
										_vehicle removeEventHandler ['LandedTouchDown',_thisEventHandler];
									}
								];
								_vehicle addEventHandler [
									'LandedStopped',
									{
										params ['_vehicle','_airportID'];
										if (!isNull (driver _vehicle)) then {
											if (!isPlayer (driver _vehicle)) then {
												missionNamespace setVariable ['QS_analytics_entities_deleted',((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),FALSE];
												_vehicle deleteVehicleCrew (driver _vehicle);
											};
										};
										_vehicle removeEventHandler ['LandedStopped',_thisEventHandler];
									}
								];
							};
						};
						(missionNamespace getVariable 'QS_garbageCollector') pushBack [_unit,'DELAYED_FORCED',(time + 600)];
						// other pilots
						_arrayToSend = [];
						{
							if (alive _x) then {
								if (!(_x in (crew _vehicle))) then {
									if (_x getUnitTrait 'QS_trait_pilot') then {
										_arrayToSend pushBack _x;
									};
								};
							};
						} forEach allPlayers;
						if (_arrayToSend isNotEqualTo []) then {
							[96,0,FALSE,[_vehicle,_name,(count (crew _vehicle)),(mapGridPosition _vehicle)]] remoteExec ['QS_fnc_remoteExec',_arrayToSend,FALSE];
						};
						// passengers
						uiSleep 2;
						if ((local (currentPilot _vehicle)) && {(isNull (_unit getVariable ['BIS_fnc_moduleRemoteControl_owner',objNull]))}) then {
							private _arrayToSend = [];
							{
								if (isPlayer _x) then {
									if (alive _x) then {
										_arrayToSend pushBack _x;
									};
								};
							} forEach (crew _vehicle);
							if (_arrayToSend isNotEqualTo []) then {
								[96,0,TRUE,[_vehicle,_name]] remoteExec ['QS_fnc_remoteExec',_arrayToSend,FALSE];
							};
						};
					};
				};
			};
		};
	};
};
if (!isNil {_object getVariable 'QS_ClientVTexture'}) then {
	private _clientVTexture = _object getVariable 'QS_ClientVTexture';
	private _v = _clientVTexture select 0;
	if (!isNull _v) then {
		if (alive _v) then {
			if ((typeOf _v) in ['I_MRAP_03_F','I_MRAP_03_hmg_F','I_MRAP_03_gmg_F']) then {
				_v setObjectTextureGlobal [0,'\A3\soft_f_beta\mrap_03\data\mrap_03_ext_co.paa'];
				_v setObjectTextureGlobal [1,'\A3\data_f\vehicles\turret_co.paa'];
			} else {
				{
					_v setObjectTextureGlobal [_forEachIndex,_x];
				} forEach (getArray (configFile >> 'CfgVehicles' >> (typeOf _v) >> 'hiddenSelectionsTextures'));
			};
			_v setVariable ['QS_ClientVTexture_owner',nil,TRUE];
		};
	};

};
diag_log (format ['***** PLAYER DISCONNECT: ***** %1 ***** %2 * %3 ****',time,_uid,_name]);
if (_uid in (['CURATOR'] call (missionNamespace getVariable 'QS_fnc_whitelist'))) then {
	[_object] spawn {
		_object = _this select 0;
		_module = getAssignedCuratorLogic _object;
		if (!isNull _module) then {
			_grp = group _module;
			if (!isNil {_module getVariable 'QS_curator_modules'}) then {
				if ((_module getVariable 'QS_curator_modules') isEqualType []) then {
					{
						if (!isNull _x) then {
							missionNamespace setVariable ['QS_analytics_entities_deleted',((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),FALSE];
							deleteVehicle _x;
						};
					} count (_module getVariable 'QS_curator_modules');
				};
			};
			if (!isNil {_module getVariable 'QS_curator_markers'}) then {
				if ((_module getVariable 'QS_curator_markers') isEqualType []) then {
					{
						if (_x in (_module getVariable 'QS_curator_markers')) then {
							if ((markerColor _x) isNotEqualTo 'ColorYELLOW') then {
								deleteMarker _x;
							};
						};
					} count allMapMarkers;
				};
			};
			missionNamespace setVariable [
				'QS_analytics_entities_deleted',
				((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),
				FALSE
			];
			deleteVehicle _module;
			deleteGroup _grp;
			if (allCurators isEqualTo []) then {
				if (missionNamespace getVariable 'QS_smSuspend') then {
					missionNamespace setVariable ['QS_smSuspend',FALSE,TRUE];
				};
			};
		};
	};
};
if (_object isEqualTo (missionNamespace getVariable ['QS_hc_Commander',objNull])) then {
	missionNamespace setVariable ['QS_hc_Commander',objNull,TRUE];
};
if ((_object isEqualTo (missionNamespace getVariable 'QS_fighterPilot')) || {(_object getUnitTrait 'QS_trait_fighterPilot')}) then {
	missionNamespace setVariable ['QS_fighterPilot',objNull,TRUE];
	if (missionNamespace getVariable ['QS_casJet_destroyedAtBase',FALSE]) then {
		missionNamespace setVariable ['QS_casJet_destroyedAtBase',FALSE,FALSE];
	};
	if (!isNull (missionNamespace getVariable 'QS_casJet')) then {
		missionNamespace setVariable [
			'QS_analytics_entities_deleted',
			((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),
			FALSE
		];
		deleteVehicle (missionNamespace getVariable 'QS_casJet');
	};
};
if ((getAllOwnedMines _object) isNotEqualTo []) then {
	{
		missionNamespace setVariable ['QS_analytics_entities_deleted',((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),FALSE];
		deleteVehicle _x;
	} count (getAllOwnedMines _object);
};
if ((attachedObjects _object) isNotEqualTo []) then {
	{
		detach _x;
	} count (attachedObjects _object);
};
if (!isNull _object) then {
	if (_object isEqualTo (vehicle _object)) then {
		if (isNull (objectParent _object)) then {
			if (isNull (attachedTo _object)) then {
				missionNamespace setVariable ['QS_analytics_entities_deleted',((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),FALSE];
				deleteVehicle _object;
			};
		};
	} else {
		if (alive _object) then {
			_object setDamage [1,FALSE];
			[(objectParent _object),_object] remoteExec ['deleteVehicleCrew',(objectParent _object),FALSE];
		};
	};
};