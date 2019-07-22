/*/
File: fn_clientEventFiredMan.sqf
Author: 

	Quiksilver
	
Last Modified:

	1/12/2018 A3 1.86 by Quiksilver
	
Description:

	Fired Man Event
	
	params ['_unit','_weapon','_muzzle','_mode','_ammo','_magazine','_projectile','_vehicle'];
_______________________________________________________/*/

params ['_unit','_weapon','_muzzle','','_ammo','_magazine','_projectile','_vehicle'];
if (!((lifeState _unit) in ['HEALTHY','INJURED'])) exitWith {
	deleteVehicle _projectile;
};
if (_weapon isEqualTo 'Throw') then {
	if ((_unit distance2D (markerPos 'QS_marker_base_marker')) < 500) then {
		if (!(unitIsUav cameraOn)) then {
			50 cutText ['Grenades disabled at base','PLAIN DOWN',0.333];
			deleteVehicle _projectile;
		};
	} else {
		if (_magazine in ['HandGrenade','MiniGrenade']) then {
			0 = [_projectile] spawn {
				params ['_projectile'];
				uiSleep 3.666;
				private _playersNearby = ([(getPos _projectile),15,[WEST],allPlayers,0] call (missionNamespace getVariable 'QS_fnc_serverDetector')) select {(!(_x isEqualTo player))};
				if (!(_playersNearby isEqualTo [])) then {
					{
						if ((([objNull,'GEOM'] checkVisibility [(getPosASL _x),(getPosASL _projectile)]) > 0) || {(([objNull,'VIEW'] checkVisibility [(getPosASL _x),(getPosASL _projectile)]) > 0)}) exitWith {
							if ((player targets [TRUE,30,[],0,(getPos _projectile)]) isEqualTo []) then {
								deleteVehicle _projectile;
								50 cutText [(format ['Friendlies in lethal radius, %1 disarmed',(getText (configFile >> 'CfgAmmo' >> (typeOf _projectile) >> 'displayName'))]),'PLAIN DOWN',0.5];
							};
						};
					} count _playersNearby;
				};
			};
		} else {
			if (_magazine in [
				'SmokeShell','SmokeShellBlue','SmokeShellGreen','SmokeShellOrange','SmokeShellPurple','SmokeShellRed','SmokeShellYellow'
			]) then {
				if (((_unit distance2D (missionNamespace getVariable 'QS_HQpos')) < 50) || (!(((missionNamespace getVariable ['QS_virtualSectors_positions',[[0,0,0]]]) findIf {((_unit distance2D _x) < 50)}) isEqualTo -1))) then {
					if (!isNil {_unit getVariable 'QS_client_hqLastSmoke'}) then {
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
		_nearEntities = _unit nearEntities ['Air',20];
		if (!(_nearEntities isEqualTo [])) then {
			{
				if ((({(alive _x)} count (crew _x)) > 1) && (!(_unit getUnitTrait 'QS_trait_pilot')) && ((side _x) in [WEST,CIVILIAN,sideFriendly])) exitWith {
					deleteVehicle _projectile;
				};
			} forEach _nearEntities;
		};
		if (_muzzle isEqualTo 'DemoChargeMuzzle') then {
			if (_magazine isEqualTo 'DemoCharge_Remote_Mag') then {
				_cursorIntersections = lineIntersectsSurfaces [
					(AGLToASL (positionCameraToWorld [0,0,0])), 
					(AGLToASL (positionCameraToWorld [0,0,(if (cameraView isEqualTo 'INTERNAL') then [{2},{4.55}])])), 
					cameraOn, 
					objNull, 
					TRUE, 
					1, 
					'GEOM'
				];
				if (!(_cursorIntersections isEqualTo [])) then {
					_firstCursorIntersection = _cursorIntersections # 0;
					_firstCursorIntersection params [
						'_intersectPosASL',
						'_surfaceNormal',
						'',
						'_objectParent'
					];
					_canAttachExp = _objectParent getVariable ['QS_client_canAttachExp',FALSE];
					if (((_objectParent isKindOf 'AllVehicles') && (((side _objectParent) in [EAST,RESISTANCE]) || {(_canAttachExp)})) || {(!(_objectParent isKindOf 'AllVehicles'))}) then {
						_projectile setVectorUp _surfaceNormal;
						_projectile setPosASL _intersectPosASL;
						[_projectile,_objectParent,TRUE] call (missionNamespace getVariable 'BIS_fnc_attachToRelative');
						if ((_objectParent getVariable ['QS_client_canAttachDetach',FALSE]) || (!simulationEnabled _objectParent)) then {
							detach _projectile;
						};
					};
				};
			};
		};
		if (!((getAllOwnedMines _unit) isEqualTo [])) then {
			if ((count (getAllOwnedMines _unit)) > 7) then {
				deleteVehicle ((getAllOwnedMines _unit) # 0);
				50 cutText ['Explosives limit ( 7 ) exceeded','PLAIN DOWN',0.5];
			};
		};
	} else {
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
			private _cursorTarget = cursorTarget;
			if ((toLower _weapon) in ['mortar_82mm','mortar_155mm_amos','rockets_230mm_gat']) then {
				if ((toLower _ammo) in ['sh_82mm_amos','sh_155mm_amos','sh_155mm_amos_guided','r_230mm_he']) then {
					if (worldName in ['Altis','Tanoa']) then {
						if (missionNamespace getVariable 'QS_customAO_GT_active') then {
							_projectile spawn {
								scriptName 'QS Fired Shell Monitor';
								_missionPos = [[3480.95,13111.1,0],[5762,10367,0]] select (worldName isEqualTo 'Tanoa');
								waitUntil {
									uiSleep 0.1;
									if ((_this distance2D _missionPos) < 750) then {
										50 cutText ['Firing into restricted area, shell disarmed','PLAIN DOWN',0.25];
										deleteVehicle _this;
									};
									((isNull _this) || {((velocity _this) isEqualTo [0,0,0])})
								};
							};
						};
					};
					missionNamespace setVariable ['QS_draw2D_projectiles',((missionNamespace getVariable 'QS_draw2D_projectiles') + [_projectile]),((toLower _weapon) isEqualTo 'rockets_230mm_gat')];
					missionNamespace setVariable ['QS_draw3D_projectiles',((missionNamespace getVariable 'QS_draw3D_projectiles') + [_projectile]),((toLower _weapon) isEqualTo 'rockets_230mm_gat')];
				};
			};
			if (!isNull (objectParent _unit)) then {
				if ((toLower _ammo) in [
					'bomb_03_f','bomb_04_f','bo_gbu12_lgb','bo_gbu12_lgb_mi10','bo_air_lgb','bo_air_lgb_hidden','bo_mk82','bo_mk82_mi08'
				]) then {
					missionNamespace setVariable ['QS_draw2D_projectiles',((missionNamespace getVariable 'QS_draw2D_projectiles') + [_projectile]),TRUE];
					missionNamespace setVariable ['QS_draw3D_projectiles',((missionNamespace getVariable 'QS_draw3D_projectiles') + [_projectile]),TRUE];
				};
			};
		};
	};
};