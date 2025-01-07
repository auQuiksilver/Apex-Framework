/*
File: fn_eventEntityKilled.sqf
Author:

	Quiksilver
	
Last modified:

	29/10/2023 A3 2.14 by Quiksilver
	
Description:

	Event Entity Killed
__________________________________________________*/

params ['_killed','_killer','_instigator','_useEffects'];
if ((getObjectType _killed) isNotEqualTo 8) exitWith {};
missionNamespace setVariable ['QS_analytics_entities_killed',((missionNamespace getVariable 'QS_analytics_entities_killed') + 1),FALSE];
missionNamespace setVariable ['QS_system_entitiesKilled',((missionNamespace getVariable ['QS_system_entitiesKilled',0]) + 1),FALSE];
if (_killed getEntityInfo 0) then {
	if (_killed getVariable ['QS_dead_prop',FALSE]) then {
		if (allCurators isNotEqualTo []) then {
			{
				_x removeCuratorEditableObjects [[_killed],TRUE];
			} forEach allCurators;
		};
	};
	if (
		(!isNull (objectParent _killed)) &&
		{(!unitIsUav _killed)}
	) then {
		_killed moveOut (objectParent _killed);
	};
	if (!isNull (group _killed)) then {
		_grp = group _killed;
		if (
			((side _grp) in [EAST,RESISTANCE]) &&
			{(!isPlayer (leader _grp))} &&
			{(_killed isEqualTo (leader _grp))}
		) then {
			private _grpUnits = (units _grp) select {((alive _x) && ((lifeState _x) in ['HEALTHY','INJURED']))};
			if (_grpUnits isNotEqualTo []) then {
				_grpUnits = _grpUnits apply {[rankId _x,_x]};
				_grpUnits sort FALSE;
				if (local _grp) then {
					_grp selectLeader ((_grpUnits # 0) # 1);
				} else {
					[_grp,((_grpUnits # 0) # 1)] remoteExec ['selectLeader',(groupOwner _grp),FALSE];
				};
			};
		};
	};
} else {
	if (
		((getFuelCargo _killed) > -1) &&
		{((['LandVehicle','Air','Ship','Thing','ReammoBox_F'] findIf { _killed isKindOf _x }) isNotEqualTo -1)} &&
		{((QS_hashmap_configfile getOrDefaultCall [
			format ['cfgvehicles_%1_transportfuel',toLowerANSI (typeOf _killed)],
			{getNumber ((configOf _killed) >> 'transportFuel')},
			TRUE
		]) > 0)}
	) then {
		([_killed,'SAFE'] call QS_fnc_inZone) params ['_inSafezone','_safezoneLevel','_safezoneActive'];
		if (_inSafezone && _safezoneActive) then {
			
		} else {
			/*/
			createVehicle [
				[
					'HelicopterExploSmall',
					(selectRandomWeighted ['HelicopterExploSmall',0.5,'HelicopterExploBig',1,'Bo_Mk82',0.1])
				] select ((getMass _killed) > 5000),
				(ASLToAGL (getPosASL _killed))
			];
			/*/
		};
	};
	if (!isNull (isVehicleCargo _killed)) then {
		objNull setVehicleCargo _killed;
	};
	if ((getVehicleCargo _killed) isNotEqualTo []) then {
		_killed setVehicleCargo objNull;
	};
	if ((['LandVehicle','Air','Ship'] findIf {_killed isKindOf _x}) isNotEqualTo -1) then {
		if (!(missionNamespace getVariable ['QS_system_BISwreckCollector',FALSE])) then {
			QS_vehicles_destroyed pushBackUnique _killed;
		};
	} else {
		if (_killed isKindOf 'AllVehicles') then {
			(missionNamespace getVariable 'QS_garbageCollector') pushBack [_killed,'DELAYED_FORCED',time + 60];
		};
	};	
	if ((getCustomSoundController [_killed,'CustomSoundController1']) isEqualTo 1) then {
		[_killed,'CustomSoundController1',0] remoteExec ['setCustomSoundController',_killed,FALSE];
	};
	if (!isNull (_killed getVariable ['QS_effect_smoke',objNull])) then {
		deleteVehicle (_killed getVariable ['QS_effect_smoke',objNull]);
	};
	if (_killed isKindOf 'StaticWeapon') then {
		_killed setVariable ['QS_logistics_immovable',TRUE,TRUE];
	};
	if (
		isDedicated &&
		{(!(_killed getVariable ['QS_logistics_wreck',FALSE]))} &&
		{(
			([_killed] call QS_fnc_canWreck) ||
			{(_killed getVariable ['QS_logistics_forceWreck',FALSE])}
		)}
	) then {
		if (
			(!(unitIsUav _killed)) &&
			(!(_killed isKindOf 'Ship')) &&
			(!(_killed isKindOf 'StaticWeapon'))
		) then {
			_dn = QS_hashmap_configfile getOrDefaultCall [
				format ['cfgvehicles_%1_displayname',toLowerANSI (typeOf _killed)],
				{getText ((configOf _killed) >> 'displayName')},
				TRUE
			];
			[_killed,_killed isKindOf 'Air',typeOf _killed,(_killed getVariable ['QS_ST_customDN',_dn])] spawn {
				params ['_killed','_isAir','_killedType','_displayName'];
				sleep 3;
				_timeout = diag_tickTime + 30;
				waitUntil {
					(
						(isNull _killed) ||
						{(((vectorMagnitude (velocity _killed)) * 3.6) < 0.5)} ||
						{(diag_tickTime > _timeout)}
					)
				};
				if (
					(isNull _killed) ||
					(diag_tickTime > _timeout)
				) exitWith {};
				[
					_killed,
					1,
					TRUE,
					[FALSE,_killedType,'',_displayName],
					_isAir
				] call QS_fnc_setWrecked;
			};
		};
	};
	_marker = _killed getVariable ['QS_wreck_marker',''];
	if (_marker isNotEqualTo '') then {
		deleteMarker _marker;
	};
	_marker2 = _killed getVariable ['QS_deploy_marker',''];
	if (_marker2 isNotEqualTo '') then {
		deleteMarker _marker2;
	};
};
if (isPlayer _killed) then {
	if (
		(!isNull _killer) &&
		(_killer isNotEqualTo _killed)
	) then {
		missionNamespace setVariable ['QS_playerKilledCountServer',((missionNamespace getVariable 'QS_playerKilledCountServer') + 1),FALSE];
		if (
			(unitIsUAV _killer) &&
			{(!local _killer)} &&
			{(([_killer,15,[WEST,CIVILIAN],allPlayers,0] call (missionNamespace getVariable 'QS_fnc_serverDetector')) isEqualTo [])}
		) then {
			deleteVehicle _killer;
		};
	};
} else {
	if ((vehicle _killed) isKindOf 'Man') then {
		if (local _killed) then {
			if (!(_killed getVariable ['QS_dead_prop',FALSE])) then {
				{
					_killed setVariable [_x,nil,FALSE];
				} count (allVariables _killed);
			};
		};
		if (
			(((toLowerANSI (typeOf _killed)) in (['enemy_sniper_types_1'] call QS_data_listUnits)) || {(_killed getUnitTrait 'QS_trait_sniper')}) &&
			{(isPlayer _killer)} &&
			{(!((vehicle _killer) isKindOf 'Air'))}
		) then {
			_text = format ['%3 ( %1 ) %4 %2!',(name _killed),(name _killer),localize 'STR_QS_Chat_108',localize 'STR_QS_Chat_109'];
			_text remoteExec ['systemChat',-2,FALSE];
		};
	} else {
		if (_killed isKindOf 'Reammobox_F') then {
			if (!isNull (attachedTo _killed)) then {
				[0,_killed] call QS_fnc_eventAttach;
			};
			if (!isNull (isVehicleCargo _killed)) then {
				objNull setVehicleCargo _killed;
			};
		};
		if (_killed isKindOf 'AllVehicles') then {
			{
				if (alive _x) then {
					[0,_x] call QS_fnc_eventAttach;
					_x setDamage [1,FALSE];
					deleteVehicle _x;
				};
			} count (attachedObjects _killed);
		};
	};
};