/*/
File: fn_clientProjectileManager.sqf
Author:

	Quiksilver
	
Last Modified:

	29/06/2020 A3 1.98 by Quiksilver
	
Description:

	Projectile Manager
___________________________________________________/*/

if ((_this # 0) isEqualTo 'HANDLE') exitWith {
	missionNamespace setVariable ['QS_projectile_manager',((missionNamespace getVariable ['QS_projectile_manager',[]]) select {(!isNull (_x # 1))}),FALSE];
	if ((count (missionNamespace getVariable ['QS_projectile_manager',[]])) < 10) then {
		(missionNamespace getVariable 'QS_projectile_manager') pushBack (_this # 1);
		if ((missionNamespace getVariable ['QS_projectile_manager_PFH',-1]) isEqualTo -1) then {
			if (isDedicated) then {
				missionNamespace setVariable ['QS_projectile_manager_PFH',(addMissionEventHandler ['EachFrame',{call (missionNamespace getVariable 'QS_fnc_eventEachFrame2')}]),FALSE];
			} else {
				missionNamespace setVariable ['QS_projectile_manager_PFH',(addMissionEventHandler ['EachFrame',{call (missionNamespace getVariable 'QS_fnc_clientEventEachFrame')}]),FALSE];
			};
		};
	};
};
params ['_type','_projectile','_unit','_vehicle','_firedPosition',['_incoming',FALSE]];
if (isNull _projectile) exitWith {};
if ((missionNamespace getVariable ['QS_missionConfig_APS',3]) in [1,2,3]) then {
	if (_type isEqualTo 'AT') then {
		_begPos = getPosWorldVisual _projectile;
		_endPos = _projectile modelToWorldVisualWorld [0,25,0];
		_intersections = lineIntersectsSurfaces [_begPos,_endPos,vehicle _unit,objNull,FALSE,1,'VIEW','GEOM',TRUE];
		if (_intersections isNotEqualTo []) then {
			_firstIntersection = _intersections # 0;
			_firstIntersection params [
				'',
				'',
				'',
				'_objectParent'
			];
			if (
				(alive _objectParent) &&
				{(_objectParent isKindOf 'LandVehicle')}
			) then {
				private _apsParams = _objectParent getVariable ['QS_aps_params',-1];
				if (_apsParams isEqualTo -1) then {
					_apsParams = [_objectParent] call (missionNamespace getVariable 'QS_fnc_vehicleAPSParams');
				};
				_apsParams params [
					['_aps_enabled',FALSE],
					['_aps_sensorPos',[0,0,0]],
					['_aps_maxAmmo',1],
					['_aps_reloadTime',5],
					['_aps_minRange',50],
					['_aps_maxAngle',-0.5],
					['_aps_interceptRange',25],
					['_aps_randomChance',1],
					['_aps_disableBlindspot',FALSE]
				];
				if (_aps_enabled) then {
					if (
						(alive (effectiveCommander _objectParent)) &&
						{(isNull (isVehicleCargo _objectParent))} &&
						{(isNull (ropeAttachedTo _objectParent))} &&
						{(isNull (attachedTo _objectParent))} &&
						{((_objectParent getVariable ['QS_aps_ammo',0]) > 0)} &&
						{((_objectParent distance _unit) >= _aps_minRange)} &&
						{(((_begPos vectorFromTo _endPos) # 2) > _aps_maxAngle)} &&
						{(serverTime > (_objectParent getVariable ['QS_aps_reloadDelay',-1]))} &&
						{((_aps_disableBlindspot) || (['APS_BLINDSPOT',_objectParent,_projectile] call (missionNamespace getVariable 'QS_fnc_vehicleAPSParams')))}
					) then {
						_sensorPos = _objectParent modelToWorldVisualWorld _aps_sensorPos;
						if (([_objectParent,'VIEW',_projectile] checkVisibility [_begPos,_sensorPos]) > 0.5) then {
							_interceptPos = (_objectParent worldToModelVisual (getPosATLVisual _projectile)) vectorMultiply 0.5;
							_charge_1 = createVehicle [(selectRandomWeighted ['SLAMDirectionalMine_Wire_Ammo',0.333,'APERSTripMine_Wire_Ammo',0.333,'ClaymoreDirectionalMine_Remote_Ammo_Scripted',0.333]),[0,0,0]];
							_charge_1 setPosATL (_objectParent modelToWorldVisual _interceptPos);
							_charge_1 setVectorDirAndUp [(_endPos vectorFromTo _begPos),[0,0,1]];
							_charge_1 setDamage [1,TRUE];
							if ((random 1) > 0.5) then {
								_charge_2 = createVehicle [(selectRandomWeighted ['SLAMDirectionalMine_Wire_Ammo',0.4,'APERSTripMine_Wire_Ammo',0.4,'ClaymoreDirectionalMine_Remote_Ammo_Scripted',([0.2,0] select ((damage _objectParent) > 0.5))]),[0,0,0]];
								_charge_2 setPosATL (getPosATLVisual _projectile);
								_charge_2 setVectorDirAndUp [(_begPos vectorFromTo _endPos),[0,0,1]];
								_charge_2 setDamage [1,TRUE];
							};
							if ((random 1) < _aps_randomChance) then {
								deleteVehicle _projectile;
							};
							_objectParent setVariable ['QS_aps_ammo',(((_objectParent getVariable ['QS_aps_ammo',0]) - 1) max 0),TRUE];
							_objectParent setVariable ['QS_aps_reloadDelay',(serverTime + _aps_reloadTime),TRUE];
							if (!isDedicated) then {
								[
									93,
									([0,1] select (([objNull,'VIEW',objNull] checkVisibility [((vehicle _unit) modelToWorldVisualWorld [0,0,1.5]),_sensorPos]) > 0.5)),
									_objectParent,
									_unit,
									_firedPosition
								] remoteExec ['QS_fnc_remoteExec',_objectParent,FALSE];
							};
						};
					};
				};
			};
		};
	};
};