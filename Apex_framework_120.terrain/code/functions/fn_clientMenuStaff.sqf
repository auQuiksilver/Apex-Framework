/*/
File: fn_clientMenuStaff.sqf
Author: 

	Quiksilver
	
Last Modified: 

	7/07/2018 A3 1.82 by Quiksilver
	
Description:

	Staff menu tools
_______________________________________________________/*/

private [
	'_type','_uid','_moderators','_admins','_developers','_allUIDs','_moderatorsActions','_adminsActions',
	'_developersActions','_validActions','_text','_pilots','_cursorTarget','_type2','_staffID'
];
_type = _this select 0;
_type2 = _type;
_uid = getPlayerUID player;
if (isNil '_uid') exitWith {};
_media = ['MEDIA'] call (missionNamespace getVariable 'QS_fnc_whitelist');
_moderators = ['MODERATOR'] call (missionNamespace getVariable 'QS_fnc_whitelist');
_admins = ['ADMIN'] call (missionNamespace getVariable 'QS_fnc_whitelist');
_developers = ['DEVELOPER'] call (missionNamespace getVariable 'QS_fnc_whitelist');
_allUIDs = _moderators + _admins + _developers;
private _actionIDs = -1;
if (!(_uid in _allUIDs)) exitWith {};
if (!isNil {player getVariable 'QS_staff_spectating'}) then {
	closeDialog 0;
	60492 cutText ['','PLAIN'];
	player switchCamera 'INTERNAL';
	player setVariable ['QS_staff_spectating',nil,FALSE];
};
if ((_type2 isEqualType '') && (_type2 isEqualTo 'KeyDown')) exitWith {
	if (!isNil {player getVariable 'QS_staff_menuOpened'}) exitWith {};
	playSound 'Click';
	player setVariable ['QS_staff_menuOpened',TRUE,FALSE];
	0 spawn {uiSleep 2;player setVariable ['QS_staff_menuOpened',nil,FALSE];};
	_moderatorsActions = [
		['0 - Close Menu',(missionNamespace getVariable 'QS_fnc_clientMenuStaff'),2,81,TRUE,TRUE,'','TRUE'],
		['1 - (Target) Delete',(missionNamespace getVariable 'QS_fnc_clientMenuStaff'),3,80,TRUE,TRUE,'','TRUE'],
		['2 - Spectate',(missionNamespace getVariable 'QS_fnc_clientMenuStaff'),4,79,TRUE,TRUE,'','TRUE'],
		['3 - Invincibility',(missionNamespace getVariable 'QS_fnc_clientMenuStaff'),5,78,TRUE,TRUE,'','TRUE'],
		['4 - Show Pilots',(missionNamespace getVariable 'QS_fnc_clientMenuStaff'),6,77,TRUE,TRUE,'','TRUE'],
		['5 - (Target) Repair',(missionNamespace getVariable 'QS_fnc_clientMenuStaff'),7,76,TRUE,TRUE,'','TRUE'],
		['6 - (Target) Pardon',(missionNamespace getVariable 'QS_fnc_clientMenuStaff'),8,75,TRUE,TRUE,'','TRUE'],
		['7 - (Target) Punish',(missionNamespace getVariable 'QS_fnc_clientMenuStaff'),9,75,TRUE,TRUE,'','TRUE'],
		['8 - No function assigned',(missionNamespace getVariable 'QS_fnc_clientMenuStaff'),10,74,TRUE,TRUE,'','TRUE'],
		['9 - No function assigned',(missionNamespace getVariable 'QS_fnc_clientMenuStaff'),11,73,TRUE,TRUE,'','TRUE']
	];
	_adminsActions = [
		['10 - (Target) Revive',(missionNamespace getVariable 'QS_fnc_clientMenuStaff'),12,72,TRUE,TRUE,'','TRUE'],
		['11 - Map Teleport',(missionNamespace getVariable 'QS_fnc_clientMenuStaff'),13,71,TRUE,TRUE,'','TRUE'],
		['12 - (Clean) Base',(missionNamespace getVariable 'QS_fnc_clientMenuStaff'),14,70,TRUE,TRUE,'','TRUE'],
		['13 - (Clean) Island',(missionNamespace getVariable 'QS_fnc_clientMenuStaff'),15,69,TRUE,TRUE,'','TRUE']
	];
	_developersActions = [
		['14 - Splendid Cam',(missionNamespace getVariable 'QS_fnc_clientMenuStaff'),16,68,TRUE,TRUE,'','TRUE'],
		['15 - Dev Terminal',(missionNamespace getVariable 'QS_fnc_clientMenuStaff'),17,67,TRUE,TRUE,'','TRUE']
	];
	_mediaActions = [
		['14 - Splendid Cam',(missionNamespace getVariable 'QS_fnc_clientMenuStaff'),16,68,TRUE,TRUE,'','TRUE']
	];
	if (!isNil {missionNamespace getVariable 'QS_staff_currentActions'}) then {
		if ((count (missionNamespace getVariable 'QS_staff_currentActions')) > 0) then {
			{
				player removeAction _x;
			} count (missionNamespace getVariable 'QS_staff_currentActions');
		};
	};
	missionNamespace setVariable ['QS_staff_currentActions',[],FALSE];
	_validActions = [];
	if (_uid in _developers) then {
		{
			0 = _validActions pushBack _x;
		} count (_moderatorsActions + _adminsActions + _developersActions);		
	} else {
		if (_uid in _admins) then {
			{
				0 = _validActions pushBack _x;
			} count (_moderatorsActions + _adminsActions);
		} else {
			if (_uid in _moderators) then {
				{
					0 = _validActions pushBack _x;
				} count _moderatorsActions;
			};
		};
		if (_uid in _media) then {
			{
				0 = _validActions pushBack _x;
			} count _mediaActions;
		};
	};
	if (!(_validActions isEqualTo [])) then {
		{
			_actionIDs = QS_staff_currentActions pushBack (player addAction _x);
			player setUserActionText [(QS_staff_currentActions select _actionIDs),((player actionParams (QS_staff_currentActions select _actionIDs)) select 0),(format ["<t size='3'>%1</t>",((player actionParams (QS_staff_currentActions select _actionIDs)) select 0)])];
		} forEach _validActions;
	};
};
if ((_type2 isEqualType '') && (_type2 isEqualTo 'Curator')) exitWith {
	if (!isNil {player getVariable 'QS_staff_menuOpened'}) exitWith {};
	playSound 'Click';
	player setVariable ['QS_staff_menuOpened',TRUE,FALSE];
	0 spawn {uiSleep 2;player setVariable ['QS_staff_menuOpened',nil,FALSE];};
	private ['_curators','_logic'];
	_curators = ['CURATOR'] call (missionNamespace getVariable 'QS_fnc_whitelist');
	if (_uid in _curators) then {
		_logic = getAssignedCuratorLogic player;
		if (!isNull _logic) then {
			if (!isNil {player getVariable 'QS_staff_curatorLastUpdate'}) exitWith {
				if (!isStreamFriendlyUIEnabled) then {
					(missionNamespace getVariable 'QS_managed_hints') pushBack [5,FALSE,5,-1,'Please wait a short time (10s) between sync attempts...',[],(serverTime + 10),TRUE,'Curator',FALSE];
				};
			};
			player setVariable ['QS_staff_curatorLastUpdate',TRUE,FALSE];
			0 spawn {uiSleep 10;player setVariable ['QS_staff_curatorLastUpdate',nil,FALSE];};
			[49,_logic] remoteExec ['QS_fnc_remoteExec',2,FALSE];
			if (!isStreamFriendlyUIEnabled) then {
				(missionNamespace getVariable 'QS_managed_hints') pushBack [5,TRUE,5,-1,'Synchronizing editable entities',[],-1,TRUE,'Curator',FALSE];
			};
		};
	};
};
if ((count _this) > 2) then {
	_type2 = _this select 3;
};
if (_type2 isEqualType 0) exitWith {
	if (_type2 isEqualTo 0) then {};
	if (_type2 isEqualTo 1) then {};
	if (_type2 isEqualTo 2) then {
		{
			player removeAction _x;
		} count (missionNamespace getVariable 'QS_staff_currentActions');
		missionNamespace setVariable ['QS_staff_currentActions',[],FALSE];
		playSound 'Click';
	};
	if (_type2 isEqualTo 3) then {
		if (!isNull cursorTarget) then {
			playSound 'ClickSoft';
			_cursorTarget = cursorTarget;
			if ((!(_cursorTarget isKindOf 'LandVehicle')) && (!(_cursorTarget isKindOf 'Air')) && (!(_cursorTarget isKindOf 'Ship')) && (!(_cursorTarget isKindOf 'StaticWeapon')) && (!(_cursorTarget isKindOf 'Man')) && (!(_cursorTarget isKindOf 'WeaponHolder'))) exitWith {hint 'Invalid target type!';};
			if ((_cursorTarget isKindOf 'Man') && (isPlayer _cursorTarget) && (alive _cursorTarget)) exitWith {
				if (!isStreamFriendlyUIEnabled) then {
					(missionNamespace getVariable 'QS_managed_hints') pushBack [5,TRUE,5,-1,'Cannot delete players!',[],-1];
				};
			};
			if (!isNil {_cursorTarget getVariable 'QS_cleanup_protected'}) exitWith {
				if (!isStreamFriendlyUIEnabled) then {
					(missionNamespace getVariable 'QS_managed_hints') pushBack [5,TRUE,5,-1,'Target is protected against cleanup!',[],-1];
				};
			};
			if (isNull _cursorTarget) exitWith {};
			[17,_cursorTarget] remoteExec ['QS_fnc_remoteExec',2,FALSE];
			_text = format ['%1 (staff) has deleted a(n) %2 at grid %3',profileName,(getText (configFile >> 'CfgVehicles' >> (typeOf _cursorTarget) >> 'displayName')),(mapGridPosition player)];
			['systemChat',_text] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
		};
	};
	if (_type2 isEqualTo 4) then {
		playSound 'ClickSoft';
		player setVariable ['QS_staff_spectating',TRUE,FALSE];
		createDialog 'RscDisplayEGSpectator';
		if (!isStreamFriendlyUIEnabled) then {
			(missionNamespace getVariable 'QS_managed_hints') pushBack [5,FALSE,5,-1,'[Shift]+[F2] to Exit spectator mode',[],(serverTime + 10)];
		};
	};
	if (_type2 isEqualTo 5) then {
		playSound 'ClickSoft';
		if (isDamageAllowed player) then {
			player allowDamage FALSE;
			_text = format ['%1 (staff) has turned on Invincibility',profileName];
			['systemChat',_text] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
			if (!isStreamFriendlyUIEnabled) then {
				(missionNamespace getVariable 'QS_managed_hints') pushBack [5,TRUE,5,-1,'Invincibility ON',[],-1];
			};
		} else {
			player allowDamage TRUE;
			_text = format ['%1 (staff) has turned off Invincibility',profileName];
			['systemChat',_text] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
			if (!isStreamFriendlyUIEnabled) then {
				(missionNamespace getVariable 'QS_managed_hints') pushBack [5,TRUE,5,-1,'Invincibility OFF',[],-1];
			};
		};
	};
	if (_type2 isEqualTo 6) then {
		playSound 'ClickSoft';
		private _text = '';
		{
			
			if (
				(_x getUnitTrait 'QS_trait_pilot') ||
				(_x getUnitTrait 'QS_trait_fighterPilot') ||
				(_x getUnitTrait 'uavhacker')
			) then {
				systemChat format ['%1 - %2',(['GET_ROLE_DISPLAYNAME','',_x] call (missionNamespace getVariable 'QS_fnc_roles')),(name _x)];
				_text = _text + (format ['<br/><br/>%1 - %2',(['GET_ROLE_DISPLAYNAME','',_x] call (missionNamespace getVariable 'QS_fnc_roles')),(name _x)]);
			};
		} count allPlayers;
		_text = parseText _text;
		(missionNamespace getVariable 'QS_managed_hints') pushBack [2,TRUE,15,-1,_text,[],-1];
	};
	if (_type2 isEqualTo 7) then {
		_cursorTarget = cursorTarget;
		if (isNull _cursorTarget) exitWith {
			if (!isStreamFriendlyUIEnabled) then {
				(missionNamespace getVariable 'QS_managed_hints') pushBack [5,TRUE,5,-1,'Repair failed, no valid target selected',[],-1];
			};
		};
		if ((!(_cursorTarget isKindOf 'LandVehicle')) && (!(_cursorTarget isKindOf 'Ship')) && (!(_cursorTarget isKindOf 'Air'))) exitWith {
			(missionNamespace getVariable 'QS_managed_hints') pushBack [5,TRUE,5,-1,'Invalid target',[],-1];
		};
		playSound 'ClickSoft';
		_cursorTarget setDamage 0;
		if (local _cursorTarget) then {
			_cursorTarget setFuel 1;
		} else {
			['setFuel',_cursorTarget,1] remoteExec ['QS_fnc_remoteExecCmd',_cursorTarget,FALSE];
		};
		if (!(_cursorTarget isKindOf 'Air')) then {
			_posTarget = getPosWorld cursorTarget;
			_cursorTarget setPosWorld [(_posTarget select 0),(_posTarget select 1),((_posTarget select 2) + 0.3)];
			_cursorTarget setVectorUp (surfaceNormal (getPosWorld _cursorTarget));
		};
		_type2 = getText (configFile >> 'CfgVehicles' >> (typeOf _cursorTarget) >> 'displayName');
		_text = format ['%1 repaired',_type2];
		(missionNamespace getVariable 'QS_managed_hints') pushBack [5,TRUE,5,-1,_text,[],-1];
		_text = format ['%1 (staff) has repaired a(n) %2 at grid %3',profileName,_type2,(mapGridPosition player)];
		['systemChat',_text] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
	};
	if (_type2 isEqualTo 8) then {
		_cursorTarget = cursorTarget;
		if (isNull _cursorTarget) exitWith {};
		if (!(_cursorTarget isKindOf 'Man')) exitWith {};
		if (isPlayer _cursorTarget) then {
			playSound 'ClickSoft';
			[_cursorTarget] call (missionNamespace getVariable 'QS_fnc_clientATAdjust');
		};
	};
	if (_type2 isEqualTo 9) then {
		_cursorTarget = cursorTarget;
		if (isNull _cursorTarget) exitWith {};
		if (!(_cursorTarget isKindOf 'Man')) exitWith {};
		if (!alive _cursorTarget) exitWith {};
		if ((_cursorTarget distance player) > 25) exitWith {};
		if (!isNull (objectParent _cursorTarget)) exitWith {};
		if (!isNull (attachedTo _cursorTarget)) exitWith {};
		if (!((lifeState _cursorTarget) in ['HEALTHY','INJURED'])) exitWith {};
		if (!(isPlayer _cursorTarget)) exitWith {};
		playSound 'ClickSoft';
		['playMoveNow',_cursorTarget,'AmovPercMstpSnonWnonDnon_exercisePushup'] remoteExec ['QS_fnc_remoteExecCmd',_cursorTarget,FALSE];	
		_text = format ['%1 (staff) has punished %2 with 10 pushups.',profileName,(name _cursorTarget)];
		['systemChat',_text] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
	};
	if (_type2 isEqualTo 10) then {
		/*/No function assigned/*/
		(missionNamespace getVariable 'QS_managed_hints') pushBack [5,TRUE,5,-1,'No function assigned',[],-1,TRUE,'Admin Tools',FALSE];
	};
	if (_type2 isEqualTo 11) then {
		/*/No function assigned/*/
		(missionNamespace getVariable 'QS_managed_hints') pushBack [5,TRUE,5,-1,'No function assigned',[],-1,TRUE,'Admin Tools',FALSE];
	};
	if (_type2 isEqualTo 12) then {
		_cursorTarget = cursorTarget;
		if (!(_cursorTarget isKindOf 'Man')) exitWith {
			(missionNamespace getVariable 'QS_managed_hints') pushBack [5,TRUE,5,-1,'Invalid target',[],(serverTime + 10)];
		};
		if (!alive _cursorTarget) exitWith {
			(missionNamespace getVariable 'QS_managed_hints') pushBack [5,TRUE,5,-1,'Invalid target',[],(serverTime + 10)];
		};
		if (!isNull (attachedTo _cursorTarget)) exitWith {
			(missionNamespace getVariable 'QS_managed_hints') pushBack [5,TRUE,5,-1,'Cant revive this target currently',[],(serverTime + 10)];
		};
		playSound 'ClickSoft';
		if (local _cursorTarget) then {
			_cursorTarget setUnconscious FALSE;
			_cursorTarget setCaptive FALSE;
		} else {
			[68,_cursorTarget,FALSE,FALSE] remoteExec ['QS_fnc_remoteExec',_cursorTarget,FALSE];
		};
		_text = format ['%1 (staff) has revived %2 at grid %3',profileName,(name _cursorTarget),(mapGridPosition _cursorTarget)];
		['systemChat',_text] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
	};
	if (_type2 isEqualTo 13) then {
		playSound 'ClickSoft';
		if (!('ItemMap' in (assignedItems player))) then {
			player linkItem 'ItemMap';	
		};
		openMap TRUE;
		0 spawn {
			missionNamespace setVariable ['QS_mapSelected',FALSE,FALSE];
			_timeOut = time + 15;	
			missionNamespace setVariable [
				'QS_staff_mapTP',
				(
					addMissionEventHandler [
						'MapSingleClick',
						{
							params ['_selectedUnits','_pos','_alt','_shift'];
							player setPos _pos;
							if (surfaceIsWater _pos) then {};
							openMap FALSE;
							missionNamespace setVariable ['QS_mapSelected',TRUE,FALSE];
							_text = format ['%1 (staff) has teleported to grid %2',profileName,(mapGridPosition _pos)];
							['systemChat',_text] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
						}
					]
				),
				FALSE
			];
			waitUntil {
				(missionNamespace getVariable 'QS_mapSelected') ||
				(time > _timeOut) ||
				(!visibleMap)
			};
			removeMissionEventHandler ['MapSingleClick',(missionNamespace getVariable 'QS_staff_mapTP')];
			if (missionNamespace getVariable 'QS_mapSelected') then {
				openMap FALSE; 
			};
			missionNamespace setVariable ['QS_mapSelected',nil,FALSE];
		};
	};
	if (_type2 isEqualTo 14) then {
		_result = ['Clean base. Executing this function too often will increase network de-sync.','Base cleanup','Execute','Cancel',(findDisplay 46),FALSE,FALSE] call (missionNamespace getVariable 'BIS_fnc_guiMessage');
		if (_result) then {	
			playSound 'ClickSoft';
			[53,[profileName,(getPlayerUID player)]] remoteExec ['QS_fnc_remoteExec',2,FALSE];
			(missionNamespace getVariable 'QS_managed_hints') pushBack [5,TRUE,3,-1,'Cleaning in progress ...',[],(serverTime + 6)];
			(missionNamespace getVariable 'QS_managed_hints') pushBack [6,TRUE,10,-1,'Base cleaned. Executing this function too often will increase network de-sync.',[],(serverTime + 20)];
			_text = format ['%1 (staff) has cleaned the spawn area.',profileName];
			['systemChat',_text] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
		};
	};
	if (_type2 isEqualTo 15) then {
		_result = [(format ['Clean %1. Executing this function too often will increase network de-sync.',worldName]),(format ['%1 cleanup',worldName]),'Execute','Cancel',(findDisplay 46),FALSE,FALSE] call (missionNamespace getVariable 'BIS_fnc_guiMessage');	
		if (_result) then {	
			playSound 'ClickSoft';
			[54] remoteExec ['QS_fnc_remoteExec',2,FALSE];
			(missionNamespace getVariable 'QS_managed_hints') pushBack [5,TRUE,3,-1,'Cleaning in progress ...',[],(serverTime + 6)];
			_hintText = format ['%1 cleaned. Executing this function too often will increase network de-sync.',worldName];
			(missionNamespace getVariable 'QS_managed_hints') pushBack [6,TRUE,10,-1,_hintText,[],(serverTime + 20)];
			_text = format ['%1 (staff) has initialized %2 cleanup.',profileName,worldName];
			['systemChat',_text] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
		};
	};
	if (_type2 isEqualTo 16) then {
		playSound 'ClickSoft';
		createDialog 'RscDisplayCamera';
		if (!(_uid in _developers)) then {
			0 spawn {
				disableUserInput TRUE;
				uiSleep 0.5;
				disableUserInput FALSE;
			};
			//comment 'Wait a second and then get the display, tweak the controls and switch the keyDown event handler';
			0 spawn {
				disableSerialization;
				uiSleep 0.5;
				private _display = findDisplay 314;
				if (!isNull _display) then {
					(_display displayctrl 31434) ctrlEnable FALSE;
					(_display displayctrl 31434) ctrlShow FALSE;
					(_display displayctrl 31436) ctrlEnable FALSE;
					(_display displayctrl 31436) ctrlShow FALSE;
					(_display displayctrl 31438) ctrlEnable FALSE;
					(_display displayctrl 31438) ctrlShow FALSE;
					_display displayRemoveAllEventHandlers 'KeyDown';
					_display displayAddEventHandler [
						'KeyDown',
						'
							with uiNamespace do {
								_this call {
									_display = _this select 0;
									_key = _this select 1;
									_shift = _this select 2;
									_ctrl = _this select 3;
									_alt = _this select 4;
									private _return = false;

									BIS_fnc_camera_keys set [_key,true];

									_cam = missionnamespace getvariable ["BIS_fnc_camera_cam",objnull];
									_camSave = {
										_positions = profilenamespace getvariable ["BIS_fnc_camera_positions",[]];
										if (_ctrl) then {
											_positions set [
												_this,
												_camParams
											];
											profilenamespace setvariable ["BIS_fnc_camera_positions",_positions];
											saveprofilenamespace;	

											_display call BIS_fnc_camera_showPositions;
										} else {
											_params = _positions select _this;
											if !(isnil "_params") then {
												["Paste",_params] call bis_fnc_camera;
											};
										};
										_return = true;
									};
									_camParams = [
										worldname,
										position _cam,
										direction _cam,
										BIS_fnc_camera_fov,
										BIS_fnc_camera_pitchbank,
										sliderposition (_display displayctrl 31430),
										sliderposition (_display displayctrl 31432),
										sliderposition (_display displayctrl 31434),
										sliderposition (_display displayctrl 31436),
										sliderposition (_display displayctrl 31438),
										sliderposition (_display displayctrl 31440),
										sliderposition (_display displayctrl 31442),
										sliderposition (_display displayctrl 31444)
									];

									switch (true) do {

										case (_key == DIK_1): {1 call _camSave;};
										case (_key == DIK_2): {2 call _camSave;};
										case (_key == DIK_3): {3 call _camSave;};
										case (_key == DIK_4): {4 call _camSave;};
										case (_key == DIK_5): {5 call _camSave;};
										case (_key == DIK_6): {6 call _camSave;};
										case (_key == DIK_7): {7 call _camSave;};
										case (_key == DIK_8): {8 call _camSave;};
										case (_key == DIK_9): {9 call _camSave;};
										case (_key == DIK_0): {0 call _camSave;};

										case (_key in actionkeys "cameraReset"): {
											BIS_fnc_camera_pitchbank = [0,0];
											[0,0] call _camRotate;
											BIS_fnc_camera_fov = 0.7;
											_camPos = position _cam;
											_camDir = direction _cam;
											_cam cameraeffect ["terminate","back"];
											camdestroy _cam;
											_cam = "camera" camcreate _camPos;
											_cam cameraeffect ["internal","back"];
											_cam setdir _camDir;
											missionnamespace setvariable ["BIS_fnc_camera_cam",_cam];
										};

										case (_key in actionkeys "showMap"): {
											_ctrlMouseArea = _display displayctrl 3140;
											_ctrlMap = _display displayctrl 3141;
											if (ctrlenabled _ctrlMap) then {
												_ctrlMouseArea ctrlenable true;
												_ctrlMap ctrlenable false;
												ctrlsetfocus _ctrlMap;
												_ctrlMap ctrlsetposition [-10,-10,0.8 * safezoneW,0.8 * safezoneH];
												_ctrlMap ctrlcommit 0;
											} else {
												_ctrlMouseArea ctrlenable false;
												_ctrlMap ctrlenable true;
												ctrlsetfocus _ctrlMap;
												_ctrlMapPos = [
													safezoneX + 0.1 * safezoneW,
													safezoneY + 0.1 * safezoneH,
													0.8 * safezoneW,
													0.8 * safezoneH
												];
												_ctrlMap ctrlsetposition _ctrlMapPos;
												_ctrlMap ctrlcommit 0;
												_ctrlMap ctrlmapanimadd [0,0.1,position _cam];
												ctrlmapanimcommit _ctrlMap;
											};
										};

										case (_key in actionkeys "cameraInterface"): {
											_return = true;
											_ctrlOverlays = [_display displayctrl 3142,_display displayctrl 3143];
											if (BIS_fnc_camera_visibleHUD) then {
												{_x ctrlsetfade 1;} foreach _ctrlOverlays;
												(_display displayctrl 3142) ctrlenable false;
												cameraEffectEnableHUD false;
											} else {
												{_x ctrlsetfade 0;} foreach _ctrlOverlays;
												(_display displayctrl 3142) ctrlenable true;
												cameraEffectEnableHUD true;
											};
											BIS_fnc_camera_visibleHUD = !BIS_fnc_camera_visibleHUD;
											{_x ctrlcommit 0.1} foreach _ctrlOverlays;
										};

										case (_key == DIK_V): {
											if (_ctrl) then {
												_clipboard = call compile copyfromclipboard;
												if (_clipboard isEqualType []) then {
													_clipboard = [_clipboard] param [0,[],[[]],[13]];
													if ((count _clipboard) isEqualTo 13) then {
														["Paste",_clipboard] call bis_fnc_camera;
													} else {
														["Wrong format of camera params (""%1"")",copyfromclipboard] call bis_fnc_error;
													};
												};
											};
										};

										case (_key in actionkeys "cameraVisionMode"): {
											BIS_fnc_camera_vision = BIS_fnc_camera_vision + 1;
											_vision = BIS_fnc_camera_vision % 4;
											switch (_vision) do {
												case 0: {
													camusenvg false;
													false SetCamUseTi 0;
												};
												case 1: {
													camusenvg true;
													false SetCamUseTi 0;
												};
												case 2: {
													camusenvg false;
													true SetCamUseTi 0;
												};
												case 3: {
													camusenvg false;
													true SetCamUseTi 1;
												};
											};
										};

										case (_key == DIK_P): {
											if (_ctrl) then {

											};
										};
										case (_key == DIK_ESCAPE): {
											_return = true;
											_this spawn {
												disableserialization;
												_display = _this select 0;
												_message = [
													localize "STR_A3_RscDisplayCamera_Exit",
													localize "STR_A3_RscDisplayCamera_Header",
													nil,
													true,
													_display
												] call bis_fnc_guimessage;
												if (_message) then {
													_display closedisplay 2;
												};
											};
										};
										default {};
									};
									_return					
								};
							};
						'
					];
				};
			};
		};
	};
	if (_type2 isEqualTo 17) then {
		playSound 'ClickSoft';
		createDialog 'QS_RD_client_dialog_menu_console';
	};
	{
		player removeAction _x;
	} count (missionNamespace getVariable 'QS_staff_currentActions');
	missionNamespace setVariable ['QS_staff_currentActions',[],FALSE];
};