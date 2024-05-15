/*
File: fn_clientMenuLeaderboard.sqf
Author:
	
	Quiksilver
	
Last Modified:

	13/09/2022 A3 2.10 by Quiksilver

Description:

	Client Menu Leaderboard
__________________________________________________________*/

params ['_type','_display'];
private _list = [
	[0,'<Empty>','',localize 'STR_QS_Menu_042'],
	[1,localize 'STR_QS_Menu_174',localize 'STR_QS_Menu_175',localize 'STR_QS_Menu_176'],
	[2,localize 'STR_QS_Menu_177',localize 'STR_QS_Menu_178',localize 'STR_QS_Menu_179'],
	[3,localize 'STR_QS_Menu_180',localize 'STR_QS_Menu_181',localize 'STR_QS_Menu_182'],
	[4,localize 'STR_QS_Menu_183',localize 'STR_QS_Menu_184',localize 'STR_QS_Menu_182'],
	[5,localize 'STR_QS_Menu_185',localize 'STR_QS_Menu_186',localize 'STR_QS_Menu_187'],
	[6,localize 'STR_QS_Menu_188',localize 'STR_QS_Menu_189',localize 'STR_QS_Menu_190'],
	[7,localize 'STR_QS_Menu_191',localize 'STR_QS_Menu_192',localize 'STR_QS_Menu_193'],
	[8,localize 'STR_QS_Menu_194',localize 'STR_QS_Menu_195',localize 'STR_QS_Menu_193']
];
if (_type isEqualTo 'onLoad') exitWith {
	disableSerialization;
	_display = _this # 1;
	// Request leaderboard sync
	if (diag_tickTime > (missionNamespace getVariable ['QS_LB_netSync_cooldown',-1])) then {
		missionNamespace setVariable ['QS_LB_netSync',FALSE,FALSE];
		missionNamespace setVariable ['QS_LB_netSync_cooldown',diag_tickTime + 30,FALSE];
		[101,(['',getPlayerUID player] select (missionNamespace isNil 'QS_leaderboards4'))] remoteExec ['QS_fnc_remoteExec',2,FALSE];
	};
	setMousePosition (uiNamespace getVariable ['QS_ui_mousePosition',getMousePosition]);
	(_display displayCtrl 1802) ctrlSetText (localize 'STR_QS_Menu_030');
	(_display displayCtrl 1802) ctrlSetToolTip '';
	(_display displayCtrl 1803) ctrlSetText 'a3\UI_F_Jets\Data\CfgUnitInsignia\jets_patch_01.paa';
	(_display displayCtrl 1804) ctrlSetText (localize 'STR_QS_Menu_031');
	(_display displayCtrl 1806) ctrlSetText (localize 'STR_QS_Menu_032');
	(_display displayCtrl 1806) ctrlSetToolTip (localize 'STR_QS_Menu_033');
	(_display displayCtrl 1807) ctrlSetText (localize 'STR_QS_Menu_034');
	(_display displayCtrl 1809) ctrlSetText (localize 'STR_QS_Menu_035');
	(_display displayCtrl 1810) ctrlSetText (localize 'STR_QS_Menu_036');
	(_display displayCtrl 1811) ctrlSetText (localize 'STR_QS_Menu_037');		// Score
	(_display displayCtrl 1812) ctrlSetText (localize 'STR_QS_Menu_038');
	(_display displayCtrl 1813) ctrlSetText (localize 'STR_QS_Menu_039');
	private _displayName = '';
	private _toolTip = '';
	{
		_displayName = _x # 1;
		_toolTip = _x # 2;
		lbAdd [1805,_displayName];
		lbSetTooltip [1805,_forEachIndex,_toolTip];
	} forEach _list;
	_timeout = diag_tickTime + 5;
	waitUntil {
		((diag_tickTime > _timeout) || (missionNamespace getVariable ['QS_LB_netSync',FALSE]))
	};
	if (missionNamespace getVariable ['QS_LB_netSync',FALSE]) then {
		(_display displayCtrl 1813) ctrlSetText (localize 'STR_QS_Menu_040');
	};
	missionNamespace setVariable ['QS_LB_netSync',FALSE,FALSE];
};
if (_type isEqualTo 'B1') exitWith {
	disableSerialization;
	_display = ctrlParent (_this # 1);
	_display spawn {
		disableSerialization;
		if (diag_tickTime > (missionNamespace getVariable ['QS_LB_netSync_cooldown',-1])) then {
			missionNamespace setVariable ['QS_LB_netSync',FALSE,FALSE];
			missionNamespace setVariable ['QS_LB_netSync_cooldown',diag_tickTime + 30,FALSE];
			[101,''] remoteExec ['QS_fnc_remoteExec',2,FALSE];		// To Do: Figure out why we arent using getPlayerUID player here. If I add it, will something else break?
		};
		_timeout = diag_tickTime + 5;
		waitUntil {
			((diag_tickTime > _timeout) || (missionNamespace getVariable ['QS_LB_netSync',FALSE]))
		};
		if (missionNamespace getVariable ['QS_LB_netSync',FALSE]) then {
			(_this displayCtrl 1813) ctrlSetText (localize 'STR_QS_Menu_040');
		};
	};
	uiSleep 0.25;
	private _index = lbCurSel 1805;
	private _object = objNull;
	if (_index isNotEqualTo -1) then {
		private _leaderboardID = (_list # _index) # 0;
		lnbClear 1808;
		if (_leaderboardID in [0]) then {
			(_display displayCtrl 1802) ctrlSetText (localize 'STR_QS_Menu_030');
			(_display displayCtrl 1809) ctrlSetText (localize 'STR_QS_Menu_036');
			(_display displayCtrl 1810) ctrlSetText (localize 'STR_QS_Menu_041');
			(_display displayCtrl 1811) ctrlSetText (localize 'STR_QS_Menu_042');
			if ((count allPlayers) > 0) then {
				lnbSetColumnsPos [1808,[(1 * (safezoneW * 0.03)),(4 * (safezoneW * 0.03)),(7 * (safezoneW * 0.03)),(10 * (safezoneW * 0.03))]];
				{
					_object = _x;
					lnbAddRow [1808,[(name _object),(['GET_ROLE_DISPLAYNAME',(_object getVariable ['QS_unit_role','rifleman'])] call (missionNamespace getVariable ['QS_fnc_roles',{'rifleman'}])),(str (rating _object))]];
					if ((squadParams _object) isNotEqualTo []) then {
						if ((((squadParams _object) # 0) # 4) isNotEqualTo '') then {
							lnbSetPicture [1808,[_forEachIndex,3],(((squadParams _object) # 0) # 4)];
						} else {
							lnbSetPicture [1808,[_forEachIndex,3],'media\images\insignia\comm_patch.paa'];
						};
					} else {
						if ( ((_object getVariable ['QS_ClientUnitInsignia2','']) isNotEqualTo '') && (!((_object getVariable ['QS_ClientUnitInsignia2','']) == '#(argb,8,8,3)color(0,0,0,0)'))) then {
							lnbSetPicture [1808,[_forEachIndex,3],(_object getVariable ['QS_ClientUnitInsignia2',''])];
						} else {
							lnbSetPicture [1808,[_forEachIndex,3],'media\images\insignia\comm_patch.paa'];
						};
					};
				} forEach allPlayers;
			};
		} else {
			(_display displayCtrl 1802) ctrlSetText ((localize 'STR_QS_Menu_030') + ' - ' + ((_list # _index) # 1));
			(_display displayCtrl 1809) ctrlSetText (localize 'STR_QS_Menu_035');
			(_display displayCtrl 1810) ctrlSetText (localize 'STR_QS_Menu_036');
			(_display displayCtrl 1811) ctrlSetText ((_list # _index) # 3);
			(_display displayCtrl 1812) ctrlSetText (localize 'STR_QS_Menu_038');
			private _tempLBHash = + QS_leaderboards4;
			if (QS_leaderboards3 isNotEqualTo []) then {
				private _key = '';
				private _val = -1;
				private _val2 = -1;
				private _element1 = 0;
				private _element2 = 0;
				private _numer = 0;
				private _denom = 1;
				{
					_key = _x;
					_val = _y;
					_val2 = QS_leaderboards3 getOrDefault [_key,-1,FALSE];
					if (_val2 isNotEqualTo -1) then {
						_element1 = _val # _leaderboardID;
						_element2 = _val2 # _leaderboardID;
						if (_element1 isEqualType 0) then {
							_val set [_leaderboardID,_element1 + _element2];
						};
						if (_element1 isEqualType []) then {
							_numer = (_element1 # 0) + (_element2 # 0);
							_denom = ((_element1 # 1) + (_element2 # 1)) max 1;
							_val set [_leaderboardID,[_numer,_denom]];
						};
						_tempLBHash set [_key,_val];
					};
				} forEach _tempLBHash;
			};
			private _isAccuracyLB = _leaderboardID in [7,8];
			private _leaderboardData = _tempLBHash toArray FALSE;
			_tempLBHash = nil;
			_leaderboardData = _leaderboardData apply {
				if (_isAccuracyLB) then {
					[
						(parseNumber (((((_x # 1) # _leaderboardID) # 0) / ((((_x # 1) # _leaderboardID) # 1) max 1)) toFixed 3)),
						(_x # 0),
						(_x # 1) # 0,
						[(((_x # 1) # _leaderboardID) # 0),(((_x # 1) # _leaderboardID) # 1)]
					]
				} else {
					[
						(_x # 1) # _leaderboardID,
						(_x # 0),
						(_x # 1) # 0
					]
				};
			};
			if (_isAccuracyLB) then {
				_leaderboardData = _leaderboardData select { ((_x # 3) # 1) >= 100 };
			};
			_leaderboardData sort FALSE;
			if (_leaderboardData isNotEqualTo []) then {
				lnbSetColumnsPos [1808,[(1 * (safezoneW * 0.03)),(4 * (safezoneW * 0.03)),(7 * (safezoneW * 0.03)),(10 * (safezoneW * 0.03))]];
				_myUID = getPlayerUID player;
				_allPlayers = allPlayers;
				private _myIndex = -1;
				private _puid = '';
				private _rank = 0;
				private _points = 0;
				private _pname = '';
				private _color = [1,1,1,1];
				private _isIngame = FALSE;
				{
					_rank = _forEachIndex + 1;
					_points = _x # 0;
					_puid = _x # 1;
					_pname = _x # 2;
					if (
						(_puid isEqualType '') && 
						(_puid isNotEqualTo '')
					) then {
						_isIngame = FALSE;
						_object = objNull;
						{
							if ((getPlayerUID _x) isEqualTo _puid) then {
								_object = _x;
								_isIngame = TRUE;
							};
						} count _allPlayers;
						if (_rank <= 8) then {
							if (_isAccuracyLB) then {
								lnbAddRow [1808,['',_pname,(format ['%1    (%2 / %3)',_points,(_x # 3) # 0,(_x # 3) # 1])]];
							} else {
								lnbAddRow [1808,['',_pname,(str _points)]];
							};
							if (_rank isEqualTo 1) then {lnbSetPicture [1808,[_forEachIndex,0],'a3\ui_f\data\gui\cfg\ranks\general_gs.paa'];};
							if (_rank isEqualTo 2) then {lnbSetPicture [1808,[_forEachIndex,0],'a3\ui_f\data\gui\cfg\ranks\colonel_pr.paa'];};
							if (_rank isEqualTo 3) then {lnbSetPicture [1808,[_forEachIndex,0],'a3\ui_f\data\gui\cfg\ranks\major_pr.paa'];};
							if (_rank isEqualTo 4) then {lnbSetPicture [1808,[_forEachIndex,0],'a3\ui_f\data\gui\cfg\ranks\captain_pr.paa'];};
							if (_rank isEqualTo 5) then {lnbSetPicture [1808,[_forEachIndex,0],'a3\ui_f\data\gui\cfg\ranks\lieutenant_pr.paa'];};
							if (_rank isEqualTo 6) then {lnbSetPicture [1808,[_forEachIndex,0],'a3\ui_f\data\gui\cfg\ranks\sergeant_pr.paa'];};
							if (_rank isEqualTo 7) then {lnbSetPicture [1808,[_forEachIndex,0],'a3\ui_f\data\gui\cfg\ranks\corporal_pr.paa'];};
							if (_rank isEqualTo 8) then {lnbSetPicture [1808,[_forEachIndex,0],'a3\ui_f\data\gui\cfg\ranks\private_pr.paa'];};		
						} else {
							if (_isAccuracyLB) then {
								lnbAddRow [1808,[(str _rank),_pname,(format ['%1    (%2 / %3)',_points,(_x # 3) # 0,(_x # 3) # 1])]];
							} else {
								lnbAddRow [1808,[(str _rank),_pname,(str _points)]];
							};
							if (_myUID isEqualTo _puid) then {
								_color = [(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843]),(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019]),(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862]),(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])];
								lnbSetColor [1808,[_forEachIndex,0],_color];
								lnbSetColor [1808,[_forEachIndex,1],_color];
								lnbSetColor [1808,[_forEachIndex,2],_color];
							} else {
								if (!(_isIngame)) then {
									lnbSetColor [1808,[_forEachIndex,0],[0.5,0.5,0.5,0.5]];
									lnbSetColor [1808,[_forEachIndex,1],[0.5,0.5,0.5,0.5]];
									lnbSetColor [1808,[_forEachIndex,2],[0.5,0.5,0.5,0.5]];
								};
							};
						};
						if (_myUID isEqualTo _puid) then {
							_myIndex = _forEachIndex;
							lnbSetCurSelRow [1808,_forEachIndex];
							_color = [(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843]),(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019]),(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862]),(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])];
							lnbSetColor [1808,[_forEachIndex,1],_color];
							lnbSetColor [1808,[_forEachIndex,2],_color];
						} else {
							if (!(_isIngame)) then {
								lnbSetColor [1808,[_forEachIndex,0],[0.5,0.5,0.5,0.5]];
								lnbSetColor [1808,[_forEachIndex,1],[0.5,0.5,0.5,0.5]];
								lnbSetColor [1808,[_forEachIndex,2],[0.5,0.5,0.5,0.5]];
							};								
						};
						if (_isIngame) then {
							if ((squadParams _object) isNotEqualTo []) then {
								if ((((squadParams _object) # 0) # 4) isNotEqualTo '') then {
									lnbSetPicture [1808,[_forEachIndex,3],(((squadParams _object) # 0) # 4)];
								} else {
									lnbSetPicture [1808,[_forEachIndex,3],'media\images\insignia\comm_patch.paa'];
								};
							} else {
								if (((_object getVariable ['QS_ClientUnitInsignia2','']) isNotEqualTo '') && ((_object getVariable ['QS_ClientUnitInsignia2','']) isNotEqualTo '#(argb,8,8,3)color(0,0,0,0)')) then {
									lnbSetPicture [1808,[_forEachIndex,3],(_object getVariable ['QS_ClientUnitInsignia2',''])];
								} else {
									lnbSetPicture [1808,[_forEachIndex,3],'media\images\insignia\comm_patch.paa'];
								};
							};
						} else {
							lnbSetPicture [1808,[_forEachIndex,3],'media\images\insignia\comm_patch.paa'];
						};
					};
				} forEach _leaderboardData;
				if (_myIndex isNotEqualTo -1) then {
					lnbSetCurSelRow [1808,_myIndex];
				};
			} else {
				
			};
		};
	};
};
if (_type isEqualTo 'B2') exitWith {
	closeDialog 2;
	createDialog 'QS_RD_client_dialog_menu_main';
};
if (_type isEqualTo 'onUnload') exitWith {
	50 cutText ['','PLAIN',0.5];
	uiNamespace setVariable ['QS_ui_mousePosition',getMousePosition];
	closeDialog 2;
};