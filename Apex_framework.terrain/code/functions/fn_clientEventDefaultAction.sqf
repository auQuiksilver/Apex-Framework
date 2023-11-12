/*
File: fn_clientEventDefaultAction.sqf
Author:
	
	Quiksilver
	
Last Modified:

	12/11/2023 A3 2.14 by Quiksilver

Description:

	Default Action
_____________________________________*/

params ['_mode'];
if (_mode isEqualTo 'activate') exitWith {
	if (
		(missionNamespace getVariable ['QS_targetBoundingBox_placementMode',FALSE]) &&
		{(diag_tickTime > (missionNamespace getVariable ['QS_targetBoundingBox_placementStartTime',-1]))}
	) then {
		0 spawn {
			_info = uiNamespace getVariable ['QS_targetBoundingBox_this',[]];
			_localHelper = uiNamespace getVariable ['QS_localHelper',TRUE];
			_info params ['_vehicle','_requestedObject','_oldParent'];
			private _currentFrame = 0;
			private _simulation = '';
			if (_requestedObject isEqualType '') exitWith {
				_simulation = QS_hashmap_configfile getOrDefaultCall [
					format ['cfgvehicles_%1_simulation',toLowerANSI _requestedObject],
					{toLowerANSI (getText (configFile >> 'CfgVehicles' >> _requestedObject >> 'simulation'))},
					TRUE
				];
				_thingX = _simulation in ['thingx','tankx','helicopterrtd'];
				if (
					((!(_thingX)) && ((uiNamespace getVariable ['QS_targetBoundingBox_intersected',0]) < 2)) ||
					{(_thingX && ((uiNamespace getVariable ['QS_targetBoundingBox_intersected',0]) isEqualTo 0))} ||
					{((['StaticWeapon','CAManBase'] findIf { _requestedObject isKindOf _x }) isNotEqualTo -1)}
				) then {
					([QS_player,'SAFE'] call QS_fnc_inZone) params ['_inBuildRestrictedZone','_zoneLevel','_zoneActive'];
					if (_inBuildRestrictedZone && _zoneActive && (_zoneLevel > 1)) exitWith {
						50 cutText [localize 'STR_QS_Text_403','PLAIN DOWN',0.5];
					};
					([QS_player,'NO_BUILD'] call QS_fnc_inZone) params ['_inBuildRestrictedZone','_zoneLevel','_zoneActive'];
					if (_inBuildRestrictedZone && _zoneActive) exitWith {
						50 cutText [localize 'STR_QS_Text_403','PLAIN DOWN',0.5];
					};
					if (localNamespace getVariable ['QS_logistics_playerBuild',FALSE]) then {
						_conditionCancel = {
							(
								((stance QS_player) isNotEqualTo 'STAND') ||
								((currentWeapon QS_player) isNotEqualTo '') ||
								(!((lifeState QS_player) in ['HEALTHY','INJURED'])) ||
								(!isNull (objectParent QS_player))
							)
						};
						_onCompleted = {
							params ['_requestedObject'];
							localNamespace setVariable ['QS_logistics_playerBuild',FALSE];
							_sim = uiNamespace getVariable ['QS_client_menuPlayerBuild_sim',1];
							_posASL = uiNamespace getVariable ['QS_targetBoundingBox_ASLPos',[0,0,0]];
							_vectors = uiNamespace getVariable 'QS_targetBoundingBox_vectors';
							_object = [
								_requestedObject,
								_sim,
								_posASL,
								_vectors,
								[QS_player] call QS_fnc_getPlayerBuildBudget
							] call QS_fnc_playerBuildObject;
							if (!isNull _object) then {
								[
									52,
									_object,
									clientOwner,
									QS_player,
									[QS_player] call QS_fnc_getPlayerBuildBudget
								] remoteExec ['QS_fnc_remoteExec',2,FALSE];
							};
							missionNamespace setVariable ['QS_targetBoundingBox_placementMode',FALSE,FALSE];
						};
						[
							localize 'STR_QS_Interact_129',
							5,
							0,
							[[],{FALSE}],
							[[],_conditionCancel],
							[[_requestedObject],_onCompleted],
							[[],{FALSE}],
							FALSE,
							1,
							["\a3\ui_f\data\igui\cfg\actions\repair_ca.paa"]
						] spawn QS_fnc_clientProgressVisualization;
					} else {
						if (
							(!(_requestedObject isKindOf 'sign_arrow_yellow_f')) ||
							{(
								(_requestedObject isKindOf 'sign_arrow_yellow_f') &&
								{([QS_player,30] call QS_fnc_canFlattenTerrain)}
							)}
						) then {
							['GET_CLIENT',_oldParent,_requestedObject,(uiNamespace getVariable ['QS_targetBoundingBox_ASLPos',[0,0,0]]),(uiNamespace getVariable 'QS_targetBoundingBox_vectors')] call QS_fnc_virtualVehicleCargo;
						} else {
							if (_requestedObject isKindOf 'sign_arrow_yellow_f') then {
								systemChat (localize 'STR_QS_Chat_170');
							};
						};
						missionNamespace setVariable ['QS_targetBoundingBox_placementMode',FALSE,FALSE];
					};
				};
			};
			_simulation = QS_hashmap_configfile getOrDefaultCall [
				format ['cfgvehicles_%1_simulation',toLowerANSI (typeOf _requestedObject)],
				{toLowerANSI (getText ((configOf _requestedObject) >> 'simulation'))},
				TRUE
			];
			if (
				((uiNamespace getVariable ['QS_targetBoundingBox_intersected',0]) > 0) &&
				{(_simulation in ['thingx','tankx','helicopterrtd'])}
			) exitWith {
				50 cutText [localize 'STR_QS_Text_120','PLAIN DOWN',0.333];
			};
			if (local _requestedObject) then {
				if (_localHelper) then {
					if (!isNull (isVehicleCargo _requestedObject)) then {
						objNull setVehicleCargo _requestedObject;
						_currentFrame = diag_frameNo + 1;
						waitUntil {diag_frameNo > _currentFrame};
					} else {
						[1,_requestedObject,[QS_player,uiNamespace getVariable ['QS_targetBoundingBox_attachOffset',[0,2,1]]]] call QS_fnc_eventAttach;
						_requestedObject setVectorDirAndUp (uiNamespace getVariable 'QS_targetBoundingBox_vectors');
						_currentFrame = diag_frameNo + 1;
						waitUntil {diag_frameNo > _currentFrame};
						if (_requestedObject in (attachedObjects _vehicle)) then {
							[0,_requestedObject] call QS_fnc_eventAttach;
						};
					};
				} else {
					if (_requestedObject in (attachedObjects _vehicle)) then {
						[0,_requestedObject] call QS_fnc_eventAttach;
					};
					_currentFrame = diag_frameNo + 1;
					waitUntil {diag_frameNo > _currentFrame};
				};
				if (alive (localNamespace getVariable ['QS_placementMode_carrier',objNull])) exitWith {
					[nil,nil,nil,[_requestedObject,(localNamespace getVariable ['QS_placementMode_carrier',objNull])],TRUE] call QS_fnc_clientInteractLoadCargo;
					localNamespace setVariable ['QS_placementMode_carrier',objNull];
				};
				localNamespace setVariable ['QS_placementMode_carrier',objNull];
				_timeout = diag_tickTime + 5;
				waitUntil {((isNull (attachedTo _requestedObject)) || (diag_tickTime > _timeout))};
				_requestedObject setVectorDirAndUp (uiNamespace getVariable 'QS_targetBoundingBox_vectors');
				_requestedObject setPosASL (uiNamespace getVariable ['QS_targetBoundingBox_ASLPos',[0,0,0]]);
				if (isObjectHidden _requestedObject) then {
					[71,_requestedObject,FALSE] remoteExec ['QS_fnc_remoteExec',2,FALSE];
				};
				_timeout = diag_tickTime + 1;
				waitUntil {((!isObjectHidden _requestedObject) || (diag_tickTime > _timeout))};
				QS_player reveal [_requestedObject,4];
				(group QS_player) reveal [_requestedObject,4];
				if ((toLowerANSI _simulation) in ['thingx']) then {
					uiSleep 0.1;
					['awake',_requestedObject,TRUE] remoteExec ['QS_fnc_remoteExecCmd',_requestedObject,FALSE];
					if (local _requestedObject) then {
						_requestedObject setVelocity [0,0,-1];
					} else {
						['setVelocity',_requestedObject,[0,0,-1]] remoteExec ['QS_fnc_remoteExecCmd',_requestedObject,FALSE];
					};
				};
				(collisionDisabledWith _requestedObject) params ['_other','_mutual'];
				if (!isNull _other) then {
					['enableCollisionWith',_requestedObject,_other] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
				};
			} else {
				[45,_vehicle,_requestedObject,(uiNamespace getVariable 'QS_targetBoundingBox_vectors'),(uiNamespace getVariable ['QS_targetBoundingBox_ASLPos',[0,0,0]])] remoteExecCall ['QS_fnc_remoteExec',0,FALSE];
			};
			if (_vehicle isNotEqualTo QS_player) then {
				[_vehicle,TRUE,TRUE] call QS_fnc_updateCenterOfMass;
			};
			missionNamespace setVariable ['QS_targetBoundingBox_placementMode',FALSE,FALSE];
		};
	} else {
		_object = missionNamespace getVariable ['QS_logistics_localTarget',objNull];
		if (
			(!isNull _object) &&
			{(_object in (attachedObjects QS_player))}
		) then {
			0 spawn QS_fnc_clientInteractRelease;
		};
	};
};
if (_mode isEqualTo 'deactivate') exitWith {

};