/*/
File: fn_clientEventFiredMan.sqf
Author: 

	Quiksilver
	
Last Modified:

	19/08/2022 A3 2.10 by Quiksilver
	
Description:

	Fired Man Event
_______________________________________________________/*/

params ['_unit','_weapon','_muzzle','','_ammo','_magazine','_projectile','_vehicle'];
if (
	(!(unitIsUav cameraOn)) &&
	(
		(captive _unit) ||
		{(!isDamageAllowed _unit)} ||
		{(!((lifeState _unit) in ['HEALTHY','INJURED']))} ||
		{(isObjectHidden _unit)}
	)
) exitWith {
	deleteVehicle _projectile;
};
missionNamespace setVariable ['QS_suppressed_effectFired',diag_tickTime + 30,FALSE];
if ((toLowerANSI _magazine) in ['8rnd_82mm_mo_shells','12rnd_230mm_rockets','32rnd_155mm_mo_shells','4rnd_155mm_mo_guided','2rnd_155mm_mo_lg']) then {
	if ((toLowerANSI _magazine) in ['8rnd_82mm_mo_shells']) then {
		_projectile addEventHandler ['Explode',{(_this + [0]) spawn (missionNamespace getVariable 'QS_fnc_craterEffect')}];
	} else {
		_projectile addEventHandler ['Explode',{(_this + [1]) spawn (missionNamespace getVariable 'QS_fnc_craterEffect')}];
	};
};
if (_weapon isEqualTo 'Throw') then {
	([_unit,'SAFE'] call QS_fnc_inZone) params ['_inSafezone','_safezoneLevel','_safezoneActive'];
	if (
		_inSafezone &&
		_safezoneActive &&
		(_safezoneLevel > 1)
	) then {
		50 cutText [localize 'STR_QS_Text_013','PLAIN DOWN',0.333];
		deleteVehicle _projectile;
	} else {
		if ((toLowerANSI _magazine) in QS_core_classNames_grenades) then {
			0 = [_projectile] spawn {
				params ['_projectile'];
				uiSleep 3.666;
				private _playersNearby = ([_projectile,15,[WEST],allPlayers,0] call (missionNamespace getVariable 'QS_fnc_serverDetector')) select {(_x isNotEqualTo player)};
				if (_playersNearby isNotEqualTo []) then {
					{
						if ((([objNull,'GEOM'] checkVisibility [(getPosASL _x),(getPosASL _projectile)]) > 0) || {(([objNull,'VIEW'] checkVisibility [(getPosASL _x),(getPosASL _projectile)]) > 0)}) exitWith {
							if ((player targets [TRUE,30,[],0,(getPosATL _projectile)]) isEqualTo []) then {
								_displayName = QS_hashmap_configfile getOrDefaultCall [
									format ['cfgammo_%1_displayname',toLowerANSI (typeOf _projectile)],
									{getText (configFile >> 'CfgAmmo' >> (typeOf _projectile) >> 'displayName')},
									TRUE
								];
								deleteVehicle _projectile;
								50 cutText [(format ['%1 %2',_displayName,localize 'STR_QS_Text_014']),'PLAIN DOWN',0.5];
							};
						};
					} count _playersNearby;
				};
			};
		} else {
			if ((toLowerANSI _magazine) in qs_core_classnames_smokeshells) then {
				if (
					((_unit distance2D (missionNamespace getVariable 'QS_HQpos')) < 50) || 
					(((missionNamespace getVariable ['QS_virtualSectors_positions',[[0,0,0]]]) findIf {((_unit distance2D _x) < 50)}) isNotEqualTo -1)
				) then {
					if !(_unit isNil 'QS_client_hqLastSmoke') then {
						if (time < ((_unit getVariable 'QS_client_hqLastSmoke') + 20)) then {
							0 = [_projectile] spawn {
								params ['_projectile'];
								uiSleep 2;
								deleteVehicle _projectile;
							};
						} else {
							_unit setVariable ['QS_client_hqLastSmoke',time,FALSE];
						};
					} else {
						_unit setVariable ['QS_client_hqLastSmoke',time,FALSE];
					};
				};
			};
		};
	};
} else {
	if (_weapon isEqualTo 'Put') then {
		_nearEntities = _unit nearEntities ['Air',25];
		if (_nearEntities isNotEqualTo []) then {
			{
				if (
					(({(alive _x)} count (crew _x)) > 1) && 
					{(!(_unit getUnitTrait 'QS_trait_pilot'))} && 
					{((side _x) in [WEST,CIVILIAN,sideFriendly])}
				) exitWith {
					deleteVehicle _projectile;
				};
			} forEach _nearEntities;
		};
		if (_muzzle isEqualTo 'DemoChargeMuzzle') then {	
			if ((toLowerANSI _magazine) in QS_core_classNames_demoCharges) then {
				_cursorIntersections = lineIntersectsSurfaces [
					(AGLToASL (positionCameraToWorld [0,0,0])), 
					(AGLToASL (positionCameraToWorld [0,0,(if (cameraView isEqualTo 'INTERNAL') then [{2},{4.55}])])), 
					cameraOn, 
					objNull, 
					TRUE, 
					1, 
					'GEOM'
				];
				if (_cursorIntersections isNotEqualTo []) then {
					_firstCursorIntersection = _cursorIntersections # 0;
					_firstCursorIntersection params [
						'_intersectPosASL',
						'_surfaceNormal',
						'',
						'_objectParent'
					];
					_canAttachExp = _objectParent getVariable ['QS_client_canAttachExp',FALSE];
					if (
						(
							(_objectParent isKindOf 'AllVehicles') && 
							(
								((side _objectParent) in [EAST,RESISTANCE]) || 
								{(_canAttachExp)} ||
								{(missionNamespace getVariable ['QS_missionconfig_attachExplosives',FALSE])}
							)
						) || 
						{(!(_objectParent isKindOf 'AllVehicles'))}
					) then {
						_projectile setVectorUp _surfaceNormal;
						_projectile setPosASL _intersectPosASL;
						[_projectile,_objectParent,TRUE] call (missionNamespace getVariable 'QS_fnc_attachToRelative');
						if ((_objectParent getVariable ['QS_client_canAttachDetach',FALSE]) || {(!simulationEnabled _objectParent)} || {(isSimpleObject _objectParent)}) then {
							[0,_projectile] call QS_fnc_eventAttach;
						};
					};
				};
			};
		};
		if ((getAllOwnedMines _unit) isNotEqualTo []) then {
			if ((count (getAllOwnedMines _unit)) > 7) then {
				deleteVehicle ((getAllOwnedMines _unit) # 0);
				50 cutText [localize 'STR_QS_Text_015','PLAIN DOWN',0.5];
			};
		};
	} else {
		_projectile addEventHandler ['HitPart',{call (missionNamespace getVariable 'QS_fnc_clientProjectileEventHitPart')}];
		if (isNull (objectParent _unit)) then {
			if (_weapon in [primaryweapon _unit,handgunweapon _unit]) then {
				_projectile setVariable ['QS_projectile_accuracy',TRUE];
				if ((toLowerANSI _weapon) in (['sniper_rifles_1'] call QS_data_listItems)) then {
					player setVariable ['QS_client_shots_sniper',(player getVariable 'QS_client_shots_sniper') + 1,FALSE];
					_projectile setVariable ['QS_projectile_sniper',TRUE];
				} else {
					player setVariable ['QS_client_shots',(player getVariable 'QS_client_shots') + 1,FALSE];
				};
			};
		};
		if (_weapon isEqualTo 'SmokeLauncher') then {
			_vehicle setVariable ['QS_passiveStealth_smokeInterval',[serverTime,serverTime + ([10,15] select ((_vehicle animationSourcePhase 'showcamonethull') isEqualTo 1))],TRUE];
			if (
				((_vehicle animationSourcePhase 'showcamonethull') isEqualTo 1) ||
				{(
					((random 1) > 0.1) &&
					{((random 1) > (damage _vehicle))}
				)}
			) then {
				if ((missionNamespace getVariable ['QS_vehicle_incomingMissiles',[]]) isNotEqualTo []) then {
					private _incomingMissiles = (missionNamespace getVariable ['QS_vehicle_incomingMissiles',[]]) select { (['SMOKE_BLINDSPOT',_vehicle,_x # 0] call (missionNamespace getVariable 'QS_fnc_vehicleAPSParams')) };
					if (_incomingMissiles isNotEqualTo []) then {
						_incomingMissilesObjects = _incomingMissiles apply { _x # 0 };
						_incomingMissilesSenders = _incomingMissiles apply { _x # 1 };
						['setMissileTarget',_incomingMissilesObjects,objNull] remoteExecCall ['QS_fnc_remoteExecCmd',_incomingMissilesSenders,FALSE];
					};
				};
			};
		};
		if ((_unit getVariable ['QS_tto',0]) > 0) then {
			private _cursorObject = cursorObject;
			private _cursorTarget = cursorTarget;
			if (
				((side _unit) isEqualTo sideEnemy) ||
				{((rating _unit) < -500)} ||
				{((!(isNull _cursorObject)) && (isPlayer _cursorObject))} ||
				{((!(isNull _cursorTarget)) && (isPlayer _cursorTarget))} ||
				{((!(isNull _cursorObject)) && (!(isNull (effectiveCommander _cursorObject))) && (isPlayer (effectiveCommander _cursorObject)))}
			) then {
				if (!((side (group _cursorTarget)) in ((player getVariable ['QS_unit_side',WEST]) call (missionNamespace getVariable 'QS_fnc_enemySides')))) then {
					deleteVehicle _projectile;
				};
			};
		};
		if (!isNull _projectile) then {
			if ((_projectile isKindOf 'RocketCore') || {(_projectile isKindOf 'MissileCore')}) then {
				['HANDLE',['AT',_projectile,_unit,_vehicle,getPosATL (vehicle _unit),FALSE]] call (missionNamespace getVariable 'QS_fnc_clientProjectileManager');
			};
			if (!isNull (objectParent _unit)) then {
				_simulation = QS_hashmap_configfile getOrDefaultCall [
					format ['cfgammo_%1_simulation',toLowerANSI _ammo],
					{toLowerANSI (getText (configFile >> 'CfgAmmo' >> _ammo >> 'simulation'))},
					TRUE
				];
				if ((toLowerANSI _simulation) isEqualTo 'shotshell') then {
					if (worldName in ['Altis','Tanoa']) then {
						if (missionNamespace getVariable 'QS_customAO_GT_active') then {
							_projectile spawn {
								scriptName 'QS Fired Shell Monitor';
								_missionPos = [[3480.95,13111.1,0],[5762,10367,0]] select (worldName isEqualTo 'Tanoa');
								waitUntil {
									uiSleep 0.1;
									if ((_this distance2D _missionPos) < 750) then {
										50 cutText [localize 'STR_QS_Text_016','PLAIN DOWN',0.25];
										deleteVehicle _this;
									};
									((isNull _this) || {((velocity _this) isEqualTo [0,0,0])})
								};
							};
						};
					};
					missionNamespace setVariable ['QS_draw2D_projectiles',((missionNamespace getVariable 'QS_draw2D_projectiles') + [_projectile]),((toLowerANSI _weapon) isEqualTo 'rockets_230mm_gat')];
					//missionNamespace setVariable ['QS_draw3D_projectiles',((missionNamespace getVariable 'QS_draw3D_projectiles') + [_projectile]),((toLowerANSI _weapon) isEqualTo 'rockets_230mm_gat')];
				};
				if ((toLowerANSI _simulation) isEqualTo 'shotmissile') then {
					missionNamespace setVariable ['QS_draw2D_projectiles',((missionNamespace getVariable 'QS_draw2D_projectiles') + [_projectile]),TRUE];
					missionNamespace setVariable ['QS_draw3D_projectiles',((missionNamespace getVariable 'QS_draw3D_projectiles') + [_projectile]),TRUE];
				};
				if (
					((objectParent _unit) getVariable ['QS_mortar_lite',FALSE]) &&
					{((objectParent _unit) getVariable ['QS_services_reammo_disabled',FALSE])}
				) then {
					if ((_unit ammo _muzzle) isEqualTo 0) then {
						(objectParent _unit) setVariable ['QS_entity_destroyOnExit',TRUE,TRUE];
					};
				};
			};
		};
	};
};