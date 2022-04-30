/*
File: fn_clientInteractUnloadCargo.sqf
Author:

	Quiksilver
	
Last Modified:

	25/10/2017 A3 1.76 by Quiksilver
	
Description:

	-
_____________________________________________________________*/

_vehicle = cursorObject;
if ((!(_vehicle isKindof 'LandVehicle')) && (!(_vehicle isKindOf 'Ship')) && (!(_vehicle isKindOf 'Air'))) exitWith {};
if (!alive _vehicle) exitWith {};
if ((attachedObjects _vehicle) isEqualTo []) exitWith {};
if (((attachedObjects _vehicle) findIf {(!isNil {_x getVariable 'QS_cargoObject'})}) isEqualTo -1) exitWith {};
private _cargo = objNull;
private _position = [];
private _hasUnloaded = FALSE;
{
	if (!(_hasUnloaded)) then {
		_cargo = _x;
		if ((!isNil {_cargo getVariable 'QS_cargoObject'}) || {((!isNull (isVehicleCargo _cargo)) && ([0,_cargo,objNull] call (missionNamespace getVariable 'QS_fnc_getCustomCargoParams')))}) then {
			if (([0,_cargo,objNull] call (missionNamespace getVariable 'QS_fnc_getCustomCargoParams')) && ((stance player) isEqualTo 'STAND') && ([4,_cargo,player] call (missionNamespace getVariable 'QS_fnc_getCustomCargoParams'))) then {
				_hasUnloaded = TRUE;
				player forceWalk TRUE;
				if (!((currentWeapon player) isEqualTo '')) then {
					player setVariable ['QS_RD_holsteredWeapon',(currentWeapon player),FALSE];
					player action ['SwitchWeapon',player,player,100];
				};
				detach _cargo;
				if (isObjectHidden _cargo) then {
					[71,_cargo,FALSE] remoteExec ['QS_fnc_remoteExec',2,FALSE];
				};
				_cargo attachTo [player,[0,0.5,1.1]];
				if ((toLower (typeOf _cargo)) in [
					"land_plasticcase_01_medium_gray_f",
					"land_plasticcase_01_medium_idap_f",
					"land_plasticcase_01_small_gray_f",
					"land_plasticcase_01_small_idap_f",
					"land_plasticcase_01_medium_f",
					"land_plasticcase_01_small_f",
					"land_metalcase_01_medium_f",
					"land_metalcase_01_small_f"
				]) then {
					if (local _cargo) then {
						_cargo setDir 90;
					} else {
						['setDir',_cargo,90] remoteExec ['QS_fnc_remoteExecCmd',_cargo,FALSE];
					};
				};
				[_cargo] spawn {
					scriptName 'QS Interact Carry Monitor';
					params ['_entity'];
					private _exit = FALSE;
					for '_x' from 0 to 1 step 0 do {
						if (!(_entity in (attachedObjects player))) exitWith {};
						if (!((stance player) isEqualTo 'STAND')) then {_exit = TRUE;};
						if (!((currentWeapon player) isEqualTo '')) then {_exit = TRUE;};
						if (!((lifeState player) in ['HEALTHY','INJURED'])) then {_exit = TRUE;};
						if (_exit) exitWith {
							50 cutText ['Released','PLAIN DOWN',0.3];
							detach _entity;
							player forceWalk FALSE;
							if (_entity call (missionNamespace getVariable 'QS_fnc_isBoundingBoxIntersected')) then {
								_position = (position player) findEmptyPosition [0,10,(typeOf _entity)];
								if (!(_position isEqualTo [])) then {
									_entity setVectorUp (surfaceNormal _position);
									_entity setPos _position; /*/maybe setvehicleposition?/*/
									_entity allowDamage (_entity getVariable ['QS_isDamageAllowed',TRUE]);
									50 cutText ['Released','PLAIN DOWN',0.3];
								};
							};
						};
						uiSleep 0.1;
					};
					player forceWalk FALSE;
					uiSleep 0.1;
					if (local _entity) then {
						_entity setVelocity [0,0,-1];
					} else {
						['setVelocity',_entity,[0,0,-1]] remoteExec ['QS_fnc_remoteExecCmd',_entity,FALSE];
					};
				};
				50 cutText [(format ['Carrying a(n) %1',(_cargo getVariable ['QS_ST_customDN',(getText (configFile >> 'CfgVehicles' >> (typeOf _cargo) >> 'displayName'))])]),'PLAIN DOWN',0.3];
			} else {
				_position = (position player) findEmptyPosition [0,10,(typeOf _cargo)];
				if (!(_position isEqualTo [])) then {
					_hasUnloaded = TRUE;
					playSound 'Click';
					if (isObjectHidden _cargo) then {
						[71,_cargo,FALSE] remoteExec ['QS_fnc_remoteExec',2,FALSE];
					};
					detach _cargo;				
					_cargo setVectorUp (surfaceNormal _position);
					_cargo setPos _position; //comment 'maybe setvehicleposition?';
					_cargo allowDamage (_cargo getVariable ['QS_isDamageAllowed',TRUE]);
					player setVariable ['QS_tempDrawObject',[_cargo,(diag_tickTime + 15)],FALSE];
					addMissionEventHandler [
						'Draw3D',
						{
							_object = (player getVariable 'QS_tempDrawObject') select 0;
							_endTime = (player getVariable 'QS_tempDrawObject') select 1;
							if (!alive _object) exitWith {
								removeMissionEventHandler ['Draw3D',_thisEventHandler];
							};
							_position = position _object;
							_screenPosition = worldToScreen _position;
							if (!(_screenPosition isEqualTo [])) then {
								if (((_screenPosition select 0) < 1) && ((_screenPosition select 0) > 0) && ((_screenPosition select 1) < 1) && ((_screenPosition select 1) > 0)) then {
									removeMissionEventHandler ['Draw3D',_thisEventHandler];
								};
							};
							if (diag_tickTime > _endTime) exitWith {
								removeMissionEventHandler ['Draw3D',_thisEventHandler];
							};
							drawIcon3D ['a3\ui_f\data\map\VehicleIcons\iconcrate_ca.paa',[1,1,1,1],(getPosVisual _object),0,0,0,'Cargo',1,0.1,'RobotoCondensed','right',TRUE];
						}
					];
					50 cutText [(format ['Unloaded %1',(_cargo getVariable ['QS_ST_customDN',(getText (configFile >> 'CfgVehicles' >> (typeOf _cargo) >> 'displayName'))])]),'PLAIN DOWN',0.3];
				} else {
					50 cutText ['No clear position to unload.','PLAIN DOWN',0.3];
				};
			};
		};
	};
} count (attachedObjects _vehicle);