/*/
File: fn_highCommand.sqf
Author:

	Quiksilver
	
Last modified:

	21/03/2018 A3 1.80 by Quiksilver
	
Description:

	High Command
	
Concept:

	Commander can issue orders to subordinate squads
	Squad leaders need to see given orders
	Squads need to see the position
__________________________________________________/*/

scriptName 'QS - Script - HComm';
private _commanderCanLeaveBase = TRUE;
private _commanderCanUseWeapons = TRUE;
_maxDistFromBase = 1000;
_basePos = markerPos 'QS_marker_base_marker';
if (!(_commanderCanLeaveBase)) then {
	50 cutText ['Commander is not able to leave the base area','PLAIN',3];
};
disableRemoteSensors FALSE;
1 enableChannel [TRUE,TRUE];
(group player) setGroupIDGlobal ['Command'];
if (!(_commanderCanUseWeapons)) then {
	player action ['SwitchWeapon',player,player,100];
};
player setVariable ['QS_ST_customDN','Commander',TRUE];
hcShowBar TRUE;
setGroupIconsVisible [TRUE,TRUE];
setGroupIconsSelectable TRUE;
player setVariable ['QS_HC_selectedGroups',[],FALSE];
player setVariable ['QS_HComm_groupIconOver',FALSE,FALSE];
player setVariable ['QS_HComm_groupIconClick_delay',-1,FALSE];
removeAllMissionEventHandlers 'GroupIconClick';
QS_HComm_testEvent_3 = addMissionEventHandler [
	'GroupIconClick',
	{
		params ['_is3D','_group','_wpID','_mb','_posX','_posY','_shift','_ctrl','_alt'];
		//systemChat format ['GroupIconClick: %1',_this];
		if (!_is3D) then {
			if (player getVariable ['QS_HComm_groupIconOver',FALSE]) then {
				if (diag_tickTime > (player getVariable ['QS_HComm_groupIconClick_delay',-1])) then {
					player setVariable ['QS_HComm_groupIconClick_delay',(diag_tickTime + 0.5),FALSE];
					_this spawn {
						params ['_is3D','_group','_wpID','_mb','_posX','_posY','_shift','_ctrl','_alt'];
						showCommandingMenu '';
						uiSleep 0.1;
						missionNamespace setVariable ['QS_HComm_camera_target',((units _group) select 0),FALSE];
						missionNamespace setVariable ['QS_HComm_camera_group',_group,FALSE];
						player hcSelectGroup [_group];
						showCommandingMenu (['RscHCGroupRootMenu','RscHCMainMenu'] select (_mb isEqualTo 1));
					};
				};
			};
		};
	}
];
removeAllMissionEventHandlers 'GroupIconOverEnter';
QS_HComm_testEvent_4 = addMissionEventHandler [
	'GroupIconOverEnter',
	{
		params ['_is3D','_group','_wpID','_mb','_posX','_posY','_shift','_ctrl','_alt'];
		if (!(player getVariable ['QS_HComm_groupIconOver',FALSE])) then {
			player setVariable ['QS_HComm_groupIconOver',TRUE,FALSE];
		};
	}
];
removeAllMissionEventHandlers 'GroupIconOverLeave';
QS_HComm_testEvent_5 = addMissionEventHandler [
	'GroupIconOverLeave',
	{
		params ['_is3D','_group','_wpID','_mb','_posX','_posY','_shift','_ctrl','_alt'];
		if (player getVariable ['QS_HComm_groupIconOver',FALSE]) then {
			player setVariable ['QS_HComm_groupIconOver',FALSE,FALSE];
		};
	}
];
QS_hc_mapTest_1 = ((findDisplay 12) displayCtrl 51) ctrlAddEventHandler [
	'Draw',
	{
		params ['_m'];
		private _grp = grpNull;
		private _grpLeader = objNull;
		private _grpWaypoints = [];
		private _i = 0;
		private _alpha = 0;
		private _mScale = ctrlMapScale _m;
		private _mouseOver = FALSE;
		private _wpType = '';
		private _wpTypeName = '';
		private _wpIcon = '';
		private _hcSelected = hcSelected player;
		_nearestWaypoint = [(_m ctrlMapScreenToWorld getMousePosition),_mScale] call (missionNamespace getVariable 'QS_fnc_mapGetNearestWaypoint');
		{
			if (!isNull _x) then {
				if ((side _x) isEqualTo playerSide) then {
					_grp = _x;
					if (!(((units _grp) findIf {(alive _x)}) isEqualTo -1)) then {
						_grpLeader = leader _grp;
						if (!((waypoints _grp) isEqualTo [])) then {
							_grpWaypoints = waypoints _grp;
							for '_i' from 0 to ((count _grpWaypoints) - 1) step 1 do {
								_mouseOver = [_grp,_i] isEqualTo _nearestWaypoint;
								_alpha = [
									([0.6,1] select (_grp in _hcSelected)),
									1
								] select _mouseOver;
								if (_i isEqualTo 0) then {
									_m drawLine [
										(getPosASLVisual _grpLeader),
										(waypointPosition [_grp,_i]),
										[0,0,0,_alpha]
									];
								} else {
									_m drawLine [
										(waypointPosition [_grp,_i]),
										(waypointPosition [_grp,(_i - 1)]),
										[0,0,0,_alpha]
									];
								};
								_wpType = waypointType [_grp,_i];
								if (_wpType isEqualTo 'SAD') then {
									_wpType = 'SeekAndDestroy';
								};
								if (_wpType isEqualTo 'TR UNLOAD') then {
									_wpType = 'TransportUnload';
								};
								_wpIcon = getText (configFile >> 'cfgWaypoints' >> 'Default' >> _wpType >> 'icon');
								_wpTypeName = getText (configFile >> 'cfgWaypoints' >> 'Default' >> _wpType >> 'displayName');
								_m drawIcon [
									_wpIcon,
									([[0,0,0,_alpha],[1,1,1,1]] select _mouseOver),
									(waypointPosition [_grp,_i]),
									26,
									26,
									0,
									(format ['%1%2 %3',(['',((groupId _grp) + ' - ')] select _mouseOver),(['',((str _i) + ':')] select ((count _grpWaypoints) > 1)),_wpTypeName]),
									0,
									([0.04,0.07] select _mouseOver),
									'RobotoCondensed',
									'left'
								];
							};
						};
					};
				};
			};
		} forEach allGroups;
		if (!(_hcSelected isEqualTo [])) then {
			{
				_grp = _x;
				_grpLeader = leader _grp;
				if (({(alive _x)} count (units _grp)) > 1) then {
					{
						if (!(_x isEqualTo _grpLeader)) then {
							if (!((vehicle _x) isEqualTo (vehicle _grpLeader))) then {
								_m drawLine [(getPosASLVisual (vehicle _x)),(getPosASLVisual _grpLeader),[0,1,0,0.75]]; comment "[0,1,1,0.5]";
							};
						};
					} forEach (units _grp);
				};
			} forEach _hcSelected;
		};
	}
];
QS_hc_mapTest_2 = ((findDisplay 12) displayCtrl 51) ctrlAddEventHandler [
	'KeyDown',
	{
		if (diag_tickTime > (player getVariable ['QS_HComm_mapLastKeyDown',-1])) then {
			player setVariable ['QS_HComm_mapLastKeyDown',(diag_tickTime + 0.5),FALSE];
			params ['_map','_key','_shift','_ctrl','_alt'];
			//systemChat str _this;
			if (_key isEqualTo 210) then {
				_nearestWaypoint = [(_map ctrlMapScreenToWorld getMousePosition),(ctrlMapScale _map)] call (missionNamespace getVariable 'QS_fnc_mapGetNearestWaypoint');
				if (!(_nearestWaypoint isEqualTo [grpNull,-1])) then {
					deleteWaypoint _nearestWaypoint;
				};
			};
		};
	}
];
QS_hc_mapTest_3 = ((findDisplay 12) displayCtrl 51) ctrlAddEventHandler [
	'MouseButtonDown',
	{
		if (diag_tickTime > (player getVariable ['QS_HComm_mapLastMouseClick',-1])) then {
			player setVariable ['QS_HComm_mapLastMouseClick',(diag_tickTime + 0.5),FALSE];
			params ['_map','_button','_coordX','_coordY','_shift','_ctrl','_alt'];
			//systemChat str _this;
			_nearestWaypoint = [(_map ctrlMapScreenToWorld getMousePosition),(ctrlMapScale _map)] call (missionNamespace getVariable 'QS_fnc_mapGetNearestWaypoint');
			if (!(player getVariable ['QS_HComm_groupIconOver',FALSE])) then {
				if (!(_nearestWaypoint isEqualTo [grpNull,-1])) then {
					if (_button isEqualTo 0) then {
							_nearestWaypoint spawn {
								showCommandingMenu '';
								uiSleep 0.1;
								player hcSelectGroup [(_this select 0)];
								showCommandingMenu 'RscHCWPRootMenu';
							};
					} else {
						_group = _nearestWaypoint select 0;
						['deleteWaypoint',_nearestWaypoint] remoteExec ['QS_fnc_remoteExecCmd',(leader _group),FALSE];
					};
				};
			};
		};
	}
];
private _grp = grpNull;
for '_x' from 0 to 1 step 0 do {
	if (!hcShownBar) then {
		hcShowBar TRUE;
	};
	if (!(player isEqualTo (leader (group player)))) then {
		(group player) selectLeader player;
	};
	{
		_grp = _x;
		if ((side _grp) isEqualTo WEST) then {
			if (!(_grp in (hcAllGroups player))) then {
				if (!(((units _grp) findIf {(alive _x)}) isEqualTo -1)) then {
					if (_grp getVariable ['QS_HComm_grp',TRUE]) then {
						if (!(_grp getVariable ['QS_HComm_grp',FALSE])) then {
							_grp setVariable ['QS_HComm_grp',TRUE,TRUE];
						};
						player hcSetGroup [_grp,(groupID _grp),'teammain'];
					};
				};
			} else {
				if (((units _grp) findIf {(alive _x)}) isEqualTo -1) then {
					player hcRemoveGroup _grp;
				} else {
					if (!((toLower (groupID _grp)) isEqualTo (toLower ((player hcGroupParams _grp) select 0)))) then {
						if (!(_grp getVariable ['QS_HComm_grp',FALSE])) then {
							_grp setVariable ['QS_HComm_grp',TRUE,TRUE];
						};
						player hcSetGroup [_grp,(groupID _grp),((player hcGroupParams _grp) select 1)];
					};
					if (_grp isEqualTo (group player)) then {
						if (!(((player hcGroupParams _grp) select 1) isEqualTo 'teammain')) then {
							if (!(_grp getVariable ['QS_HComm_grp',FALSE])) then {
								_grp setVariable ['QS_HComm_grp',TRUE,TRUE];
							};
							player hcSetGroup [_grp,(groupID _grp),'teammain'];
						};
					};
				};
			};
		};
		uiSleep 0.01;
	} count allGroups;
	if (!(_commanderCanUseWeapons)) then {
		if (!((primaryWeapon player) isEqualTo '')) then {
			player removeWeapon (primaryWeapon player);
		};
		if (!((secondaryWeapon player) isEqualTo '')) then {
			player removeWeapon (secondaryWeapon player);
		};
	};
	if (!(_commanderCanLeaveBase)) then {
		if ((player distance2D _basePos) > _maxDistFromBase) then {
			if (isNull (objectParent player)) then {
				player setVehiclePosition [_basePos,[],0,'NONE'];
				player setVelocity [0,0,0];
			} else {
				moveOut player;
				if (!isNull (attachedTo player)) then {
					detach player;
				};
				['switchMove',player,''] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
				player setVehiclePosition [_basePos,[],0,'NONE'];
				player setVelocity [0,0,0];
			};
		};
	};
	uiSleep 3;
};