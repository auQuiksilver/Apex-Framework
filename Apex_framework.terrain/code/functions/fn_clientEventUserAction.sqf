/*/
File: fn_clientEventUserAction.sqf
Author:

	Quiksilver
	
Last Modified:

	19/03/2023 A3 2.12 by Quiksilver
	
Description:

	User Action Event Handlers
	
Custom:

	User1 - 
	User2 - 
	User3 -
	User4 -
	User5 -
	User6 -
	User7 - Weapon Laser
	User8 - Holster
	User9 - Earplugs
	User10 - Player Menu
	User11 - Admin Menu / Zeus Sync
	User12 -
	User13 -
	User14 - Aircraft Collision Lights
	User15 - Force (Dis)mount AI
	User16 - 
	User17 - Ropes Lengthen
	User18 - Ropes Shorten
	User19 -
	User20 - Extended Context Menu
___________________________________________/*/

if (_this isEqualTo 'init') exitWith {
	{
		addUserActionEventHandler _x;
	} forEach [
		['defaultAction','activate',{['activate'] call QS_fnc_clientEventDefaultAction}],
		['defaultAction','deactivate',{['deactivate'] call QS_fnc_clientEventDefaultAction}],
		['ingamePause','activate',{
			if (
				(uiNamespace getVariable ['QS_localHelper',FALSE]) &&
				(missionNamespace getVariable ['QS_targetBoundingBox_placementMode',FALSE])
			) then {
				missionNamespace setVariable ['QS_targetBoundingBox_placementMode',FALSE,FALSE];
			};
		}],
		['turbo','activate',{uiNamespace setVariable ['QS_uiaction_turbo',TRUE];}],
		['turbo','deactivate',{uiNamespace setVariable ['QS_uiaction_turbo',FALSE];}],
		['turboToggle','activate',{uiNamespace setVariable ['QS_uiaction_turbo',TRUE];}],
		['turboToggle','deactivate',{uiNamespace setVariable ['QS_uiaction_turbo',FALSE];}],
		['vehicleturbo','activate',{call QS_fnc_clientEventVehicleTurbo}],
		['vehicleturbo','deactivate',{uiNamespace setVariable ['QS_uiaction_vehicleturbo',FALSE];}],
		['uavViewToggle','activate',{
			_cameraOn = cameraOn;
			if (
				(local _cameraOn) &&
				{(QS_player in [driver _cameraOn,currentPilot _cameraOn])} &&
				{((['Car','Tank','Ship'] findIf { _cameraOn isKindOf _x }) isNotEqualTo -1)} &&
				{((((velocityModelSpace _cameraOn) # 1) * 3.6) > 5)}
			) then {
				(getCruiseControl _cameraOn) params ['','_active'];
				if (!_active) then {
					[_cameraOn] call QS_fnc_setCruiseControl;
				} else {
					50 cutText [localize 'STR_QS_Text_385','PLAIN DOWN',0.333];
				};
			};
			if (
				(local _cameraOn) &&
				{(_cameraOn isKindOf 'Helicopter')} &&
				{(QS_player isEqualTo (currentPilot _cameraOn))} &&
				{(diag_tickTime > (uiNamespace getVariable ['QS_pilot_lastRappellSafetyToggle',-1]))}
			) then {
				uiNamespace setVariable ['QS_pilot_lastRappellSafetyToggle',diag_tickTime + 3];
				if (!(_cameraOn getVariable ['QS_rappellSafety',FALSE])) then {
					_cameraOn setVariable ['QS_rappellSafety',TRUE,TRUE];
					50 cutText [localize 'STR_QS_Text_041','PLAIN DOWN',1];
				} else {
					_cameraOn setVariable ['QS_rappellSafety',FALSE,TRUE];
					50 cutText [localize 'STR_QS_Text_042','PLAIN DOWN',1];
				};
			};
		}],
		['lookAround','activate',{
				if (uiNamespace getVariable ['QS_uiaction_alt',FALSE]) then {
					uiNamespace setVariable ['QS_uiaction_alt',FALSE];
					if (!isNull curatorCamera) then {
						50 cutText [localize 'STR_QS_Text_421','PLAIN DOWN',0.25];
					};
				} else {
					if (!isNull curatorCamera) then {
						50 cutText [localize 'STR_QS_Text_422','PLAIN DOWN',0.25];
					};
					uiNamespace setVariable ['QS_uiaction_alt',TRUE];
				};
			}
		],
		['User1','activate',{}],
		['User2','activate',{}],
		['User3','activate',{}],
		['User4','activate',{}],
		['User5','activate',{}],
		['User6','activate',{}],
		['User7','activate',{['','',-1,'',FALSE] call QS_fnc_clientInteractLaserToggle;}],
		['User8','activate',{[QS_player] call (missionNamespace getVariable 'QS_fnc_clientHolster');}],
		['User9','activate',{call (missionNamespace getVariable 'QS_fnc_clientEarplugs');}],
		['User10','activate',{
			// Player menu
			if (isNull (findDisplay 2000)) then {
				[0] call (missionNamespace getVariable 'QS_fnc_clientMenu');
			} else {
				[-1] call (missionNamespace getVariable 'QS_fnc_clientMenu');
			};
		}],
		['User11','activate',{
			// Admin menu
			[['KeyDown','Curator'] select (!isNull curatorCamera)] call (missionNamespace getVariable 'QS_fnc_clientMenuStaff');
		}],
		['User12','activate',{}],
		['User13','activate',{}],
		['User14','activate',{
			_cameraOn = cameraOn;
			if (
				(_cameraOn isKindOf 'Air') &&
				{(local _cameraOn)}
			) then {
				_cameraOn setCollisionLight (!isCollisionLightOn _cameraOn);
			};
		}],
		['User15','activate',{[_this,(sizeOf (typeOf cameraOn)),FALSE] call QS_fnc_clientInteractForceDismount;}],
		['User16','activate',{}],
		['User17','activate',{
			// Ropes Lengthen
		}],
		['User18','activate',{
			// Ropes Shorten
		}],
		['User19','activate',{}],
		['User20','activate',{
			['IN'] call QS_fnc_clientMenuActionContext;
			uiNamespace setVariable ['QS_uiaction_context',TRUE];
		}],
		['User20','deactivate',{
			['OUT'] call QS_fnc_clientMenuActionContext;
			uiNamespace setVariable ['QS_uiaction_context',FALSE];
		}],
		['timeDec','activate',{
			if (
				(!isNull curatorCamera) &&
				((curatorSelected # 0) isNotEqualTo [])
			) exitWith {
				private _selected = curatorSelected # 0;
				_selected = _selected select {
					(
						(local _x) &&
						((_x isKindOf 'House') || (_x isKindOf 'Building'))
					)
				};
				if (_selected isNotEqualTo []) then {
					private _position = [0,0,0];
					private _adjustment = [0.1,1] select (uiNamespace getVariable ['QS_uiaction_turbo',FALSE]);
					{
						_position = getPosASL _x;
						_position = _position vectorAdd [0,0,-_adjustment];
						_x setPosASL _position;
						_x awake TRUE;
						if (_x isKindOf 'CargoPlatform_01_base_F') then {
							[_x,TRUE,TRUE] call QS_fnc_logisticsPlatformSnap;
						};
					} forEach _selected;
				};
			};
		}],
		['timeInc','activate',{
			if (
				(!isNull curatorCamera) &&
				((curatorSelected # 0) isNotEqualTo [])
			) exitWith {
				private _selected = curatorSelected # 0;
				_selected = _selected select {
					(
						(local _x) &&
						((_x isKindOf 'House') || (_x isKindOf 'Building'))
					)
				};
				if (_selected isNotEqualTo []) then {
					private _position = [0,0,0];
					private _adjustment = [0.1,1] select (uiNamespace getVariable ['QS_uiaction_turbo',FALSE]);
					{
						_position = getPosASL _x;
						_position = _position vectorAdd [0,0,_adjustment];
						_x setPosASL _position;
						_x awake TRUE;
						if (_x isKindOf 'CargoPlatform_01_base_F') then {
							[_x,TRUE,TRUE] call QS_fnc_logisticsPlatformSnap;
						};
					} forEach _selected;
				};
			};
		}],
		['Action','activate',{uiNamespace setVariable ['QS_uiaction_action',TRUE];uiNamespace setVariable ['QS_uiaction_action_time',diag_tickTime];}],
		['Action','deactivate',{uiNamespace setVariable ['QS_uiaction_action',FALSE];uiNamespace setVariable ['QS_uiaction_action_time',-1];}],
		['prevAction','activate',{call QS_fnc_clientInGameUIPrevAction}],
		['nextAction','activate',{call QS_fnc_clientInGameUINextAction}],
		['prevAction','deactivate',{call QS_fnc_clientInGameUIPrevAction}],
		['nextAction','deactivate',{call QS_fnc_clientInGameUINextAction}],
		['launchCM','activate',{
			if (cameraOn isKindOf 'Helicopter') then {
				if (['CONDITION2',cameraOn] call QS_fnc_clientInteractMH9Stealth) then {
					['INTERACT',cameraOn,TRUE] call QS_fnc_clientInteractMH9Stealth;
				};
			};
		}],
		['HeliRopeAction','activate',{
			_cameraOn = cameraOn;
			if (
				(!(_cameraOn isKindOf 'Man')) &&
				{(!(_cameraOn isKindOf 'Air'))} &&
				{(isNull (getSlingLoad _cameraOn))}
			) then {
				if (['MODE8',_cameraOn] call QS_fnc_simplePull) then {
					['MODE10',_cameraOn] call QS_fnc_simplePull;
				} else {
					if (['MODE9',_cameraOn] call QS_fnc_simplePull) then {
						['MODE13',_cameraOn] call QS_fnc_simplePull
					};
				};
			};
		}],
		['autohover','activate',{
			if (!(missionNamespace getVariable ['QS_missionConfig_autohover',TRUE])) exitWith {
				cameraOn spawn {
					sleep 0.1;
					action ['autohovercancel',_this];
				};
			};
			_v = cameraOn;
			if (
				(_v isKindOf 'Helicopter') &&
				{(QS_player isEqualTo (currentPilot _v))} &&
				{(local _v)} &&
				{(!(isAutoHoverOn _v))} &&
				{(((count (crew _v))) > 1)} &&
				{(diag_tickTime > (uiNamespace getVariable ['QS_client_lastAutoHoverMsg',-1]))}
			) then {
				_arrayToSend = (crew _v) select {((_x isNotEqualTo QS_player) && (alive _x) && (isPlayer _x))};
				if (_arrayToSend isNotEqualTo []) then {
					uiNamespace setVariable ['QS_client_lastAutoHoverMsg',(diag_tickTime + 5),FALSE];
					[63,[5,[(format ['%2 ( %1 ) %3',profileName,localize 'STR_QS_Text_258',localize 'STR_QS_Text_259']),'PLAIN DOWN',0.3]]] remoteExec ['QS_fnc_remoteExec',_arrayToSend,FALSE];
				};
			};
		}],
		['headlights','activate',{
			if (
				(local cameraOn) &&
				{(unitIsUav cameraOn)}
			) then {
				if (cameraOn checkAIFeature 'LIGHTS') then {
					cameraOn enableAIFeature ['LIGHTS',FALSE];
				};
				if ((uiNamespace getVariable ['QS_uiaction_vehicleturbo',TRUE]) || (unitIsUav cameraOn)) then {
					cameraOn setPilotLight (!isLightOn cameraOn);
					cameraOn setCollisionLight (!isCollisionLightOn cameraOn);
				};
			};
			if (
				(!isNull curatorCamera) &&
				((curatorSelected # 0) isNotEqualTo [])
			) then {
				private _light = objNull;
				private _actionTaken = FALSE;
				{
					_light = _x;
					_actionTaken = FALSE;
					if ((['StreetLamp','Lamps_base_F'] findIf { _light isKindOf _x }) isNotEqualTo -1) then {
						if (local _light) then {
							if (!simulationEnabled _light) then {
								_light enableSimulation TRUE;
							};
							_light switchLight (['off','on'] select ((lightIsOn _light) == 'off'));
						} else {
							['switchLight',_light,(['off','on'] select ((lightIsOn _light) == 'off'))] remoteExec ['QS_fnc_remoteExecCmd',_light,FALSE];
						};
					} else {
						if ((['LandVehicle','Air','Ship'] findIf { _light isKindOf _x }) isNotEqualTo -1) then {
							if (!_actionTaken) then {
								if ((getCustomSoundController [_light,'CustomSoundController1']) isEqualTo 1) then {
									_actionTaken = TRUE;
									if (local _light) then {
										setCustomSoundController [_light,'CustomSoundController1',0];
									} else {
										['setCustomSoundController',[_light,'CustomSoundController1',0]] remoteExec ['QS_fnc_remoteExecCmd',_light,FALSE];
									};
								};
								if (_light getVariable ['Utility_Offroad_Beacons',FALSE]) then {
									_actionTaken = TRUE;
									_light setVariable ['Utility_Offroad_Beacons',FALSE,TRUE];
								};
							};
							if (!_actionTaken) then {
								if (local _light) then {
									{
										if (!isPlayer _x) then {
											_x enableAIFeature ['LIGHTS',FALSE];
										};
									} forEach (crew _light);
									_light setPilotLight (!isLightOn _light);
								} else {
									if (!isPlayer (effectiveCommander _light)) then {
										['enableAIFeature',((crew _light) select {!isPlayer _x}),['LIGHTS',FALSE]] remoteExec ['QS_fnc_remoteExecCmd',(crew _light),FALSE];
										['setPilotLight',_light,!isLightOn _light] remoteExec ['QS_fnc_remoteExecCmd',_light,FALSE];
									};
								};
							};
						};
					};
				} forEach (curatorSelected # 0);
			};
		}],
		['eject','activate',{
			if (cameraOn isKindOf 'ParachuteBase') then {
				QS_player moveOut cameraOn;
			};
		}],
		['MoveBack','activate',{
			_vehicle = cameraOn;
			if (
				(_vehicle isKindOf 'Plane') &&
				{(local _vehicle)} &&
				{(isNull (attachedTo _vehicle))} &&
				{(isTouchingGround _vehicle)} &&
				{(((vectorMagnitude (velocity _vehicle)) * 3.6) < 1)}
			) then {
				_vehicle setVelocityModelSpace [0,-3,1];
			};
		}],
		['gunElevUp','activate',{call QS_fnc_clientEventGunElevUp}],
		['gunElevDown','activate',{call QS_fnc_clientEventGunElevDown}],
		['turretElevationUp','activate',{call QS_fnc_clientEventTurretElevUp}],
		['turretElevationDown','activate',{call QS_fnc_clientEventTurretElevDown}],
		['carhandbrake','activate',{
			_cameraOn = cameraOn;
			if (!local _cameraOn) exitWith {};
			if ((ropes _cameraOn) isNotEqualTo []) then {
				if (isNull (getSlingLoad _cameraOn)) then {
					uiNamespace setVariable ['QS_pulling_brakesToggle',(!(uiNamespace getVariable ['QS_pulling_brakesToggle',FALSE]))];
					_result = uiNamespace getVariable ['QS_pulling_brakesToggle',FALSE];
					50 cutText [format ['%1 %2',localize 'STR_QS_Text_321',[localize 'STR_QS_Text_322',localize 'STR_QS_Text_323'] select _result],'PLAIN',0.5];
					['MODE1',_cameraOn,_result] call QS_fnc_simplePull;
				};
			} else {
				if (!isNull (ropeAttachedTo _cameraOn)) then {
					uiNamespace setVariable ['QS_pulling_brakesToggle',(!(uiNamespace getVariable ['QS_pulling_brakesToggle',FALSE]))];
					_result = uiNamespace getVariable ['QS_pulling_brakesToggle',FALSE];
					50 cutText [format ['%1 %2',localize 'STR_QS_Text_321',[localize 'STR_QS_Text_322',localize 'STR_QS_Text_323'] select _result],'PLAIN',0.5];
					['MODE0',_cameraOn,_result] call QS_fnc_simpleWinch;
				};
			};
		}],
		['carback','activate',{
			uiNamespace setVariable ['QS_uiaction_carback',TRUE];
			_cameraOn = cameraOn;
			if (!local _cameraOn) exitWith {};
			if ((ropes _cameraOn) isNotEqualTo []) then {
				if (isNull (getSlingLoad _cameraOn)) then {
					if (uiNamespace getVariable ['QS_pulling_brakesToggle',FALSE]) then {
						['MODE2',_cameraOn] call QS_fnc_simplePull;
					};
				};
			} else {
				if (!isNull (ropeAttachedTo _cameraOn)) then {
					if (uiNamespace getVariable ['QS_pulling_brakesToggle',FALSE]) then {
						['MODE1',_cameraOn] call QS_fnc_simpleWinch;
					};
				};
			};
		}],
		['carback','deactivate',{
			uiNamespace setVariable ['QS_uiaction_carback',FALSE];
			_cameraOn = cameraOn;
			if (!local _cameraOn) exitWith {};
			if ((ropes _cameraOn) isNotEqualTo []) then {
				if (isNull (getSlingLoad _cameraOn)) then {
					if (uiNamespace getVariable ['QS_pulling_brakesToggle',FALSE]) then {
						['MODE3',_cameraOn] call QS_fnc_simplePull;
					};
				};
			} else {
				if (!isNull (ropeAttachedTo _cameraOn)) then {
					if (uiNamespace getVariable ['QS_pulling_brakesToggle',FALSE]) then {
						['MODE2',_cameraOn] call QS_fnc_simpleWinch;
					};
				};
			};
		}],
		['sitdown','activate',{
			if (isNull (objectParent QS_player)) then {
				if (isNil {QS_player getVariable ['QS_seated_oldAnimState',nil]}) then {
					[nil,nil,nil,1] call QS_fnc_clientInteractSit;
				} else {
					[nil,nil,nil,0] call QS_fnc_clientInteractSit;
				};
			};
		}],
		['getout','activate',{
			if (isNull (objectParent QS_player)) then {
				if (!isNil {QS_player getVariable ['QS_seated_oldAnimState',nil]}) then {
					[nil,nil,nil,0] call QS_fnc_clientInteractSit;
				};
			};
		}],
		['tacticalPing','activate',{}]
	];
};