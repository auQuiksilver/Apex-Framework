/*
File: fn_highCommand.sqf
Author:

	Quiksilver
	
Last modified:

	12/09/2016 A3 1.62 by Quiksilver
	
Description:

	High Command
	
Concept:

	Commander can issue orders to subordinate squads
	Requires advanced intel (UAV intel?)
	Squad leaders need to see given orders
	Squads need to see the position
	Commander has satellite scan
	
	unit setvariable ['QS_client_hc_waypoint',[],FALSE]
	
__________________________________________________*/
TRUE spawn {
	scriptName 'Client Commander thread';
	private ['_grp','_maxDistFromBase','_basePos'];
	_maxDistFromBase = 1000;
	_basePos = markerPos 'QS_marker_base_marker';
	50 cutText ['Commander is not able to leave the base area','PLAIN',5];
	1 enableChannel [TRUE,TRUE];
	player action ['SwitchWeapon',player,player,100];
	hcShowBar TRUE;
	QS_TEST = TRUE;
	_QS_ST_X = [] call (missionNamespace getVariable 'QS_ST_X');
	setGroupIconsVisible [TRUE,TRUE];
	setGroupIconsSelectable TRUE;
	[_QS_ST_X] spawn {
		scriptName 'Soldier Tracker (Group Icons) by Quiksilver';
		private [
			'_grp','_grpLeader','_as','_QS_ST_X','_grpIconArray','_grpID','_sidesFriendly','_checkDiplomacy_delay','_checkDiplomacy','_dynamicDiplomacy','_showFriendlySides',
			'_playerFaction','_showAIGroups','_configGroupIcon','_groupUpdateDelay','_showCivilianGroups','_groupUpdateDelay_timer','_friendlySidesDefault','_groupIconsVisibleMap',
			'_showMapUnitIcons','_showOwnGroup'
		];
		_QS_ST_X = _this select 0;
		_sidesFriendly = [];
		_showMapUnitIcons = _QS_ST_X select 0;
		_dynamicDiplomacy = _QS_ST_X select 8;
		_showFriendlySides = _QS_ST_X select 57;
		_playerFaction = _QS_ST_X select 3;
		_showAIGroups = TRUE;
		_configGroupIcon = _QS_ST_X select 53;
		_showCivilianGroups = _QS_ST_X select 59;
		_groupIconsVisibleMap = _QS_ST_X select 31;
		_showOwnGroup = _QS_ST_X select 76;
		_sides = [EAST,WEST,RESISTANCE,CIVILIAN];
		_grpLeader = objNull;
		if (!(_showCivilianGroups)) then {
			_sides deleteAt 3;
		};
		_groupUpdateDelay_timer = 5;
		_groupUpdateDelay = time + _groupUpdateDelay_timer;
		if (_dynamicDiplomacy) then {
			_checkDiplomacy_delay = 10;
			_checkDiplomacy = time + _checkDiplomacy_delay;
			_sidesFriendly = _sides;
		};
		_as = [];
		0 = _as pushBack (_sides select _playerFaction);
		{
			0 = _as pushBack (_sides select _x);
		} count _showFriendlySides;
		for '_x' from 0 to 1 step 0 do {
			if (_dynamicDiplomacy) then {
				if (time > _checkDiplomacy) then {
					_as = [];
					{
						if (((_sides select _playerFaction) getFriend _x) > 0.6) then {
							0 = _as pushBack _x;
						};
					} count _sides;
					_checkDiplomacy = time + _checkDiplomacy_delay;
				};
			};
			if (time > _groupUpdateDelay) then {
				{
					_grp = _x;
					if ((_showOwnGroup) || {((!(_showOwnGroup)) && (!(_grp isEqualTo (group player))))} || {(!(_showMapUnitIcons))}) then {
						if (({(alive _x)} count (units _grp)) > 0) then {
							if ((side _grp) in _as) then {
								_grpLeader = leader _grp;
								if (_showAIGroups) then {
									if (isNil {_grp getVariable 'QS_ST_Group'}) then {
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
										if (isNil {_grp getVariable 'QS_ST_Group'}) then {
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
								if (!isNil {_grp getVariable 'QS_ST_Group_Icon'}) then {
									[_grp,2,_QS_ST_X] call _configGroupIcon;
								};
							};
						} else {
							if (!isNil {_grp getVariable 'QS_ST_Group_Icon'}) then {
								[_grp,2,_QS_ST_X] call _configGroupIcon;
							};
						};
					};
					uiSleep 0.05;
				} count allGroups;
				_groupUpdateDelay = time + _groupUpdateDelay_timer;
			};
			if ((visibleMap) || {(shownArtilleryComputer)} || {(!isNull ((findDisplay -1) displayCtrl 500))}) then {
				if ((ctrlMapScale ((findDisplay 12) displayCtrl 51)) isEqualTo 1) then {
					if (groupIconsVisible select 0) then {
						setGroupIconsVisible [FALSE,(groupIconsVisible select 1)];
					};
				} else {
					if (_groupIconsVisibleMap) then {
						if (!(groupIconsVisible select 0)) then {
							setGroupIconsVisible [TRUE,(groupIconsVisible select 1)];
						};
					};
				};
			} else {
				if (_groupIconsVisibleMap) then {
					if (groupIconsVisible select 0) then {
						setGroupIconsVisible [FALSE,(groupIconsVisible select 1)];
					};
				};
			};
			uiSleep 0.1;
		};
	};
	player setVariable ['QS_HC_selectedGroups',[],FALSE];
	{
		addMissionEventHandler _x;
	} forEach [
		['GroupIconClick',(_QS_ST_X select 54)],
		['GroupIconOverEnter',(_QS_ST_X select 58)],
		['GroupIconOverLeave',(_QS_ST_X select 55)],
		[
			'CommandModeChanged',
			{
				params ['_isHighCommand','_isForced'];
				
			}
		],
		[
			'HCGroupSelectionChanged',
			{
				params ['_group','_isSelected'];
				if (_isSelected) then {
					systemChat str (groupID _group);
					
					{
						if (isNull _x) then {
							(player getVariable 'QS_HC_selectedGroups') deleteAt _forEachIndex;
						};
					} forEach (player getVariable 'QS_HC_selectedGroups');
					
					
					player setVariable [
						'QS_HC_selectedGroups',
						((player getVariable 'QS_HC_selectedGroups') + [_group]),
						FALSE
					];
				} else {
					systemChat str (groupID _group);
					private _selectedGroups = player getVariable ['QS_HC_selectedGroups',[]];
					if (_group in _selectedGroups) then {
						_selectedGroups deleteAt (_selectedGroups find _group);
					};
					player setVariable ['QS_HC_selectedGroups',_selectedGroups,FALSE];
				};
			}
		],
		[
			'GroupIconClick',
			{
				params ['_is3D','_group','_wpID','_mb','_posX','_posY','_shift','_ctrl','_alt'];
				player hcSelectGroup [_group];
			}
		]
	];

	_QS_ST_X = nil;
	for '_x' from 0 to 1 step 0 do {
		if (!(QS_TEST)) exitWith {};
		if (!((primaryWeapon player) isEqualTo '')) then {
			player removeWeapon (primaryWeapon player);
		};
		if (!((secondaryWeapon player) isEqualTo '')) then {
			player removeWeapon (secondaryWeapon player);
		};
		if (!hcShownBar) then {
			hcShowBar TRUE;
		};
		if (!(player isEqualTo (leader (group player)))) then {
			(group player) selectLeader player;
		};
		{
			_grp = _x;
			if ((side _grp) isEqualTo WEST) then {
				comment "if (isPlayer (leader _grp)) then {";
					if (!(_grp in (hcAllGroups player))) then {
						player hcSetGroup [_grp,(groupID _grp),'teammain'];
					} else {
						if (({(alive _x)} count (units _grp)) isEqualTo 0) then {
							player hcRemoveGroup _grp;
						} else {
							if (!((toLower (groupID _grp)) isEqualTo (toLower ((player hcGroupParams _grp) select 0)))) then {
								player hcSetGroup [_grp,(groupID _grp),((player hcGroupParams _grp) select 1)];
							};
							if (_grp isEqualTo (group player)) then {
								if (!(((player hcGroupParams _grp) select 1) isEqualTo 'teammain')) then {
									player hcSetGroup [_grp,(groupID _grp),'teammain'];
								};
							};
						};
					};
				comment "};";
			};
			uiSleep 0.1;
		} count allGroups;
		if ((player distance _basePos) > _maxDistFromBase) then {
			if (isNull (objectParent player)) then {
				player setPos _basePos;
			} else {
				moveOut player;
				if (!isNull (attachedTo player)) then {
					detach player;
				};
				['switchMove',player,''] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
				player setPos _basePos;
			};
		};
		uiSleep 10;
	};
};