/*/
File: fn_highCommand.sqf
Author:

	Quiksilver
	
Last modified:

	9/10/2023 A3 2.14 by Quiksilver
	
Description:

	High Command
	
Concept:

	Commander can issue orders to subordinate squads
	Squad leaders need to see given orders
	Squads need to see the position
__________________________________________________/*/

scriptName 'QS - Script - HComm';
private _commanderCanLeaveBase = FALSE;
private _commanderCanUseWeapons = FALSE;
_maxDistFromBase = 500;
_basePos = markerPos 'QS_marker_base_marker';
if (!(_commanderCanLeaveBase)) then {
	50 cutText [localize 'STR_QS_Text_210','PLAIN',1];
};
disableRemoteSensors FALSE;
1 enableChannel [TRUE,TRUE];
(group player) setGroupIDGlobal ['Command'];
if (!(_commanderCanUseWeapons)) then {
	player action ['SwitchWeapon',player,player,100];
};
hcShowBar TRUE;
setGroupIconsVisible [TRUE,TRUE];
setGroupIconsSelectable TRUE;
private _missionEvents = [];
private _controlEvents = [];
private _displayEvents = [];
player setVariable ['QS_HC_selectedGroups',[],FALSE];
player setVariable ['QS_HComm_groupIconOver',FALSE,FALSE];
player setVariable ['QS_HComm_groupIconClick_delay',-1,FALSE];
removeAllMissionEventHandlers 'GroupIconClick';
QS_HComm_testEvent_3 = addMissionEventHandler [
	'GroupIconClick',
	{
		params ['_is3D','_group','_wpID','_mb','_posX','_posY','_shift','_ctrl','_alt'];
		if (!_is3D) then {
			if (player getVariable ['QS_HComm_groupIconOver',FALSE]) then {
				if (diag_tickTime > (player getVariable ['QS_HComm_groupIconClick_delay',-1])) then {
					player setVariable ['QS_HComm_groupIconClick_delay',(diag_tickTime + 0.5),FALSE];
					_this spawn {
						params ['_is3D','_group','_wpID','_mb','_posX','_posY','_shift','_ctrl','_alt'];
						showCommandingMenu '';
						uiSleep 0.1;
						missionNamespace setVariable ['QS_HComm_camera_target',((units _group) # 0),FALSE];
						missionNamespace setVariable ['QS_HComm_camera_group',_group,FALSE];
						player hcSelectGroup [_group];
						showCommandingMenu (['RscHCGroupRootMenu','RscHCMainMenu'] select (_mb isEqualTo 1));
					};
				};
			};
		};
	}
];
_missionEvents pushBack ['GroupIconClick',QS_HComm_testEvent_3];
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
_missionEvents pushBack ['GroupIconOverEnter',QS_HComm_testEvent_4];
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
_missionEvents pushBack ['GroupIconOverLeave',QS_HComm_testEvent_5];
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
				_grp = _x;
				if (((units _grp) findIf {(alive _x)}) isNotEqualTo -1) then {
					_grpLeader = leader _grp;
					if ((waypoints _grp) isNotEqualTo []) then {
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
		} forEach (groups (player getVariable ['QS_unit_side',WEST]));
		if (_hcSelected isNotEqualTo []) then {
			{
				_grp = _x;
				_grpLeader = leader _grp;
				if (({(alive _x)} count (units _grp)) > 1) then {
					{
						if (_x isNotEqualTo _grpLeader) then {
							if ((vehicle _x) isNotEqualTo (vehicle _grpLeader)) then {
								_m drawLine [(getPosASLVisual (vehicle _x)),(getPosASLVisual _grpLeader),[0,1,0,0.75]]; //comment "[0,1,1,0.5]";
							};
						};
					} forEach (units _grp);
				};
			} forEach _hcSelected;
		};
	}
];
_controlEvents pushBack [12,51,'Draw',QS_hc_mapTest_1];
QS_hc_mapTest_2 = ((findDisplay 12) displayCtrl 51) ctrlAddEventHandler [
	'KeyDown',
	{
		if (diag_tickTime > (player getVariable ['QS_HComm_mapLastKeyDown',-1])) then {
			player setVariable ['QS_HComm_mapLastKeyDown',(diag_tickTime + 0.5),FALSE];
			params ['_map','_key','_shift','_ctrl','_alt'];
			if (_key isEqualTo 210) then {
				_nearestWaypoint = [(_map ctrlMapScreenToWorld getMousePosition),(ctrlMapScale _map)] call (missionNamespace getVariable 'QS_fnc_mapGetNearestWaypoint');
				if (_nearestWaypoint isNotEqualTo [grpNull,-1]) then {
					deleteWaypoint _nearestWaypoint;
				};
			};
		};
	}
];
_controlEvents pushBack [12,51,'KeyDown',QS_hc_mapTest_2];
QS_hc_mapTest_3 = ((findDisplay 12) displayCtrl 51) ctrlAddEventHandler [
	'MouseButtonDown',
	{
		if (diag_tickTime > (player getVariable ['QS_HComm_mapLastMouseClick',-1])) then {
			player setVariable ['QS_HComm_mapLastMouseClick',(diag_tickTime + 0.5),FALSE];
			params ['_map','_button','_coordX','_coordY','_shift','_ctrl','_alt'];
			_nearestWaypoint = [(_map ctrlMapScreenToWorld getMousePosition),(ctrlMapScale _map)] call (missionNamespace getVariable 'QS_fnc_mapGetNearestWaypoint');
			if (!(player getVariable ['QS_HComm_groupIconOver',FALSE])) then {
				if (_nearestWaypoint isNotEqualTo [grpNull,-1]) then {
					if (_button isEqualTo 0) then {
							_nearestWaypoint spawn {
								showCommandingMenu '';
								uiSleep 0.1;
								player hcSelectGroup [(_this # 0)];
								showCommandingMenu 'RscHCWPRootMenu';
							};
					} else {
						_group = _nearestWaypoint # 0;
						['deleteWaypoint',_nearestWaypoint] remoteExec ['QS_fnc_remoteExecCmd',(leader _group),FALSE];
					};
				};
			};
		};
	}
];
_controlEvents pushBack [12,51,'MouseButtonDown',QS_hc_mapTest_3];

if (isNull (missionNamespace getVariable ['QS_script_grpIcons',scriptNull])) then {
	_QS_ST_X = call (missionNamespace getVariable 'QS_ST_X');
	_grpscript = [_QS_ST_X] spawn {
		scriptName 'Soldier Tracker (Group Icons) by Quiksilver';
		params ['_QS_ST_X'];
		_showMapUnitIcons = _QS_ST_X # 0;
		_dynamicDiplomacy = TRUE;
		_showFriendlySides = _QS_ST_X # 57;
		private _playerFaction = _QS_ST_X # 3;
		_showAIGroups = _QS_ST_X # 30;
		_configGroupIcon = _QS_ST_X # 53;
		_showCivilianGroups = _QS_ST_X # 59;
		_groupIconsVisibleMap = _QS_ST_X # 31;
		_showOwnGroup = _QS_ST_X # 76;
		_gpsRequired = _QS_ST_X # 85;
		private _sidesFriendly = [];
		private _grp = grpNull;
		private _sides = [EAST,WEST,RESISTANCE,CIVILIAN];
		private _grpLeader = objNull;
		private _refreshGroups = FALSE;
		if (!(_showCivilianGroups)) then {
			_sides deleteAt 3;
		};
		_groupUpdateDelay_timer = 5;
		private _groupUpdateDelay = diag_tickTime + _groupUpdateDelay_timer;
		private _checkDiplomacy_delay = 1;
		private _checkDiplomacy = diag_tickTime + _checkDiplomacy_delay;
		
		_groupIconsVisible = groupIconsVisible;
		_groupIconSelectable = groupIconSelectable;
		
		if (_dynamicDiplomacy) then {
			_sidesFriendly = _sides;
		};
		private _as = [];
		_as pushBack (_sides # _playerFaction);
		{
			0 = _as pushBack (_sides # _x);
		} count _showFriendlySides;
		for '_x' from 0 to 1 step 0 do {
			if (_dynamicDiplomacy) then {
				if (diag_tickTime > _checkDiplomacy) then {
					_as = [];
					{
						if (((player getVariable ['QS_unit_side',WEST]) getFriend _x) > 0.6) then {
							_as pushBack _x;
						};
					} forEach _sides;
					_checkDiplomacy = diag_tickTime + _checkDiplomacy_delay;
				};
			};
			if (diag_tickTime > _groupUpdateDelay) then {
				{
					if ((_showOwnGroup) || {((!(_showOwnGroup)) && (_x isNotEqualTo (group player)))} || {(!(_showMapUnitIcons))}) then {
						_grp = _x;
						if (((units _grp) findIf {(alive _x)}) isNotEqualTo -1) then {
							if ((side _grp) in _as) then {
								_grpLeader = leader _grp;
								if (_showAIGroups) then {
									if (_grp isNil 'QS_ST_Group') then {
										if (!isNull _grp) then {
											if (!isNull _grpLeader) then {
												[_grp,0,_QS_ST_X] call _configGroupIcon;
											};
										};
									} else {
										if (!isNull _grp) then {
											if (!isNull _grpLeader) then {
												[_grp,1,_QS_ST_X] call _configGroupIcon;
											};
										};
									};
								} else {
									if (isPlayer _grpLeader) then {
										if (_grp isNil 'QS_ST_Group') then {
											if (!isNull _grp) then {
												if (!isNull _grpLeader) then {
													[_grp,0,_QS_ST_X] call _configGroupIcon;
												};
											};
										} else {
											if (!isNull _grp) then {
												if (!isNull _grpLeader) then {
													[_grp,1,_QS_ST_X] call _configGroupIcon;
												};
											};
										};
									};
								};
							} else {
								if !(_grp isNil 'QS_ST_Group_Icon') then {
									[_grp,2,_QS_ST_X] call _configGroupIcon;
								};
							};
						} else {
							if !(_grp isNil 'QS_ST_Group_Icon') then {
								[_grp,2,_QS_ST_X] call _configGroupIcon;
							};
						};
						uiSleep ([0.05,0.01] select _refreshGroups);
					};
				} count allGroups;
				if (_refreshGroups) then {
					_refreshGroups = FALSE;
				};
				_groupUpdateDelay = diag_tickTime + _groupUpdateDelay_timer;
			};
			if (_gpsRequired) then {
				if ((QS_player getSlotItemName 612) isEqualTo '') then {
					setGroupIconsVisible [FALSE,FALSE];
					waitUntil {
						uiSleep 0.25;
						((QS_player getSlotItemName 612) isNotEqualTo '')
					};
				};
			};
			if ((!(visibleMap)) && (isNull ((findDisplay 160) displayCtrl 51)) && (isNull ((findDisplay -1) displayCtrl 500))) then {
				waitUntil {
					uiSleep 0.25;
					((visibleMap) || {(!isNull ((findDisplay 160) displayCtrl 51))} || {(!isNull ((findDisplay -1) displayCtrl 500))})
				};
				_refreshGroups = TRUE;
			};
			if ((visibleMap) || {(!isNull ((findDisplay 160) displayCtrl 51))} || {(!isNull ((findDisplay -1) displayCtrl 500))}) then {
				if ((ctrlMapScale ((findDisplay 12) displayCtrl 51)) isEqualTo 1) then {
					if (groupIconsVisible # 0) then {
						setGroupIconsVisible [FALSE,(groupIconsVisible # 1)];
					};
				} else {
					if (_groupIconsVisibleMap) then {
						if (!(groupIconsVisible # 0)) then {
							setGroupIconsVisible [TRUE,(groupIconsVisible # 1)];
						};
					};
				};
			} else {
				if (_groupIconsVisibleMap) then {
					if (groupIconsVisible # 0) then {
						setGroupIconsVisible [FALSE,(groupIconsVisible # 1)];
					};
				};
			};
			if (!(player getUnitTrait 'QS_trait_HQ')) exitWith {
				{
					clearGroupIcons _x;
					_x setVariable ['QS_ST_Group_Icon',nil,FALSE];
					_x setVariable ['QS_ST_Group',nil,FALSE];
				} forEach allGroups;
				setGroupIconsVisible _groupIconsVisible;
				setGroupIconsSelectable _groupIconSelectable;
			};
			uiSleep 0.1;
		};
	};
	missionNamespace setVariable ['QS_script_grpIcons',_grpscript,FALSE];
};
private _grp = grpNull;
for '_x' from 0 to 1 step 0 do {
	if (!hcShownBar) then {
		hcShowBar TRUE;
	};
	if (player isNotEqualTo (leader (group player))) then {
		(group player) selectLeader player;
	};
	{
		_grp = _x;
		if ((side _grp) isEqualTo WEST) then {
			if (!(_grp in (hcAllGroups player))) then {
				if (((units _grp) findIf {(alive _x)}) isNotEqualTo -1) then {
					if (_grp isNil 'QS_HComm_grp') then {
						_grp setVariable ['QS_HComm_grp',TRUE,TRUE];
					};
					player hcSetGroup [_grp,(groupID _grp),'teammain'];
				};
			} else {
				if (((units _grp) findIf {(alive _x)}) isEqualTo -1) then {
					player hcRemoveGroup _grp;
				} else {
					if ((toLower (groupID _grp)) isNotEqualTo (toLower ((player hcGroupParams _grp) # 0))) then {
						if (!(_grp getVariable ['QS_HComm_grp',FALSE])) then {
							_grp setVariable ['QS_HComm_grp',TRUE,TRUE];
						};
						player hcSetGroup [_grp,(groupID _grp),((player hcGroupParams _grp) # 1)];
					};
					if (_grp isEqualTo (group player)) then {
						if (((player hcGroupParams _grp) # 1) isNotEqualTo 'teammain') then {
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
		if (!(dialog)) then {
			if ((primaryWeapon player) isNotEqualTo '') then {
				player removeWeapon (primaryWeapon player);
			};
			if ((secondaryWeapon player) isNotEqualTo '') then {
				player removeWeapon (secondaryWeapon player);
			};
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
					[0,player] call QS_fnc_eventAttach;
				};
				['switchMove',player,''] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
				player setVehiclePosition [_basePos,[],0,'NONE'];
				player setVelocity [0,0,0];
			};
		};
	};
	if ((rating player) isNotEqualTo 9000) then {
		player addRating (9000 - (rating player));
	};
	uiSleep 3;
	if (!(player getUnitTrait 'QS_trait_HQ')) exitWith {
		// de-init commander stuff
		systemChat (localize 'STR_QS_Chat_112');
		{
			removeMissionEventHandler _x;
		} forEach _missionEvents;
		{
			((findDisplay (_x # 0)) displayCtrl (_x # 1)) ctrlRemoveEventHandler [_x # 2,_x # 3];
		} forEach _controlEvents;
		{
			if (_x getVariable ['QS_HComm_grp',FALSE]) then {
				uiSleep 0.1;
				_x setVariable ['QS_HComm_grp',nil,TRUE];
			};
		} forEach allGroups;
		if (hcShownBar) then {
			hcShowBar FALSE;
		};
		hcRemoveAllGroups player;
		setGroupIconsVisible [FALSE,FALSE];
		setGroupIconsSelectable FALSE;
		disableRemoteSensors TRUE;
		1 enableChannel [TRUE,FALSE];
		(group player) setGroupIDGlobal [(format ['%1',profileName])];
	};
};