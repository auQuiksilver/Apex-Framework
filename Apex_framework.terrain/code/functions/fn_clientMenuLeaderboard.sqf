/*
File: fn_clientMenuLeaderboard.sqf
Author:
	
	Quiksilver
	
Last Modified:

	8/02/2015 A3 1.54 by Quiksilver

Description:

	Client Menu Leaderboard
__________________________________________________________*/

private ['_type','_display','_index','_list','_displayName','_toolTip','_leaderboardID','_rank'];
_type = _this select 0;
_list = [
	[0,'<Empty>',''],
	[1,'Transporters','Transport pilot leaderboard'],
	[2,'Revivalists','Combat life saver leaderboard'],
	[3,'---','---'],
	[4,'Gold Diggers','Gold Tooth collector leaderboard'],
	[5,'Tower Rangers','Radio tower leaderboard'],
	[6,'Gitmo','Enemy capture leaderboard']
];
if (_type isEqualTo 'onLoad') exitWith {
	disableSerialization;
	_display = _this select 1;
	setMousePosition (uiNamespace getVariable ['QS_ui_mousePosition',getMousePosition]);
	(_display displayCtrl 1802) ctrlSetText 'Leaderboards';
	(_display displayCtrl 1802) ctrlSetToolTip 'v1.0';
	(_display displayCtrl 1803) ctrlSetText 'media\images\insignia\comm_patch.paa';
	(_display displayCtrl 1804) ctrlSetText 'Type';
	(_display displayCtrl 1806) ctrlSetText 'Select';
	(_display displayCtrl 1806) ctrlSetToolTip 'Refresh';
	(_display displayCtrl 1807) ctrlSetText 'Back';
	(_display displayCtrl 1809) ctrlSetText 'Rank';
	(_display displayCtrl 1810) ctrlSetText 'Player';
	(_display displayCtrl 1811) ctrlSetText 'Score';
	(_display displayCtrl 1812) ctrlSetText 'Insignia';
	(_display displayCtrl 1813) ctrlSetText 'v1.0';
	{
		_displayName = _x select 1;
		_toolTip = _x select 2;
		lbAdd [1805,_displayName];
		lbSetTooltip [1805,_forEachIndex,_toolTip];
	} forEach _list;
};
if (_type isEqualTo 'B1') exitWith {
	private [
		'_leaderboardDataArray','_leaderboardIndex','_rank','_points','_pname','_col1','_col2','_col3','_col4','_color','_myUID','_isIngame','_allPlayers','_object',
		'_myIndex','_display'
	];
	disableSerialization;
	_display = ctrlParent (_this select 1);
	_index = lbCurSel 1805;
	if (!(_index isEqualTo -1)) then {
		_leaderboardID = (_list select _index) select 0;
		lnbClear 1808;
		if (_leaderboardID in [0,3]) then {
			(_display displayCtrl 1809) ctrlSetText 'Player';
			(_display displayCtrl 1810) ctrlSetText 'Role';
			(_display displayCtrl 1811) ctrlSetText 'Rating';
			if ((count allPlayers) > 0) then {
				lnbSetColumnsPos [1808,[(1 * (safezoneW * 0.03)),(4 * (safezoneW * 0.03)),(7 * (safezoneW * 0.03)),(10 * (safezoneW * 0.03))]];
				{
					_object = _x;
					lnbAddRow [1808,[(name _object),(['GET_ROLE_DISPLAYNAME',(_object getVariable ['QS_unit_role','rifleman'])] call (missionNamespace getVariable ['QS_fnc_roles',{'rifleman'}])),(str (rating _object))]];
					if (!((squadParams _object) isEqualTo [])) then {
						if (!((((squadParams _object) select 0) select 4) isEqualTo '')) then {
							lnbSetPicture [1808,[_forEachIndex,3],(((squadParams _object) select 0) select 4)];
						} else {
							lnbSetPicture [1808,[_forEachIndex,3],'media\images\insignia\comm_patch.paa'];
						};
					} else {
						if ((!((_object getVariable ['QS_ClientUnitInsignia2','']) isEqualTo '')) && (!((_object getVariable ['QS_ClientUnitInsignia2','']) == '#(argb,8,8,3)color(0,0,0,0)'))) then {
							lnbSetPicture [1808,[_forEachIndex,3],(_object getVariable ['QS_ClientUnitInsignia2',''])];
						} else {
							lnbSetPicture [1808,[_forEachIndex,3],'media\images\insignia\comm_patch.paa'];
						};
					};
				} forEach allPlayers;
			};
		} else {
			(_display displayCtrl 1809) ctrlSetText 'Rank';
			(_display displayCtrl 1810) ctrlSetText 'Player';
			(_display displayCtrl 1811) ctrlSetText 'Score';
			(_display displayCtrl 1812) ctrlSetText 'Insignia';
			if (isNil {missionNamespace getVariable 'QS_leaderboards'}) exitWith {};
			_leaderboardDataArray = (missionNamespace getVariable 'QS_leaderboards') select _leaderboardID;
			_leaderboardDataArray sort FALSE;
			if (!(_leaderboardDataArray isEqualTo [])) then {
				_leaderboardIndex = 0;
				lnbSetColumnsPos [1808,[(1 * (safezoneW * 0.03)),(4 * (safezoneW * 0.03)),(7 * (safezoneW * 0.03)),(10 * (safezoneW * 0.03))]];
				_myUID = getPlayerUID player;
				_allPlayers = allPlayers;
				_myIndex = -1;
				{
					_rank = _forEachIndex + 1;
					_points = _x select 0;
					_puid = _x select 1;
					_pname = _x select 2;
					if ((_puid isEqualType '') && (!(_puid isEqualTo ''))) then {
						_isIngame = FALSE;
						_object = objNull;
						{
							if ((getPlayerUID _x) == _puid) then {
								_object = _x;
								_isIngame = TRUE;
							};
						} count _allPlayers;
						if (_rank <= 8) then {
							lnbAddRow [1808,['',_pname,(str _points)]];
							if (_rank isEqualTo 1) then {lnbSetPicture [1808,[_forEachIndex,0],'a3\ui_f\data\gui\cfg\ranks\general_gs.paa'];};
							if (_rank isEqualTo 2) then {lnbSetPicture [1808,[_forEachIndex,0],'a3\ui_f\data\gui\cfg\ranks\colonel_pr.paa'];};
							if (_rank isEqualTo 3) then {lnbSetPicture [1808,[_forEachIndex,0],'a3\ui_f\data\gui\cfg\ranks\major_pr.paa'];};
							if (_rank isEqualTo 4) then {lnbSetPicture [1808,[_forEachIndex,0],'a3\ui_f\data\gui\cfg\ranks\captain_pr.paa'];};
							if (_rank isEqualTo 5) then {lnbSetPicture [1808,[_forEachIndex,0],'a3\ui_f\data\gui\cfg\ranks\lieutenant_pr.paa'];};
							if (_rank isEqualTo 6) then {lnbSetPicture [1808,[_forEachIndex,0],'a3\ui_f\data\gui\cfg\ranks\sergeant_pr.paa'];};
							if (_rank isEqualTo 7) then {lnbSetPicture [1808,[_forEachIndex,0],'a3\ui_f\data\gui\cfg\ranks\corporal_pr.paa'];};
							if (_rank isEqualTo 8) then {lnbSetPicture [1808,[_forEachIndex,0],'a3\ui_f\data\gui\cfg\ranks\private_pr.paa'];};		
						} else {
							lnbAddRow [1808,[(str _rank),_pname,(str _points)]];
							if (_myUID == _puid) then {
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
						if (_myUID == _puid) then {
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
							if (!((squadParams _object) isEqualTo [])) then {
								if (!((((squadParams _object) select 0) select 4) isEqualTo '')) then {
									lnbSetPicture [1808,[_forEachIndex,3],(((squadParams _object) select 0) select 4)];
								} else {
									lnbSetPicture [1808,[_forEachIndex,3],'media\images\insignia\comm_patch.paa'];
								};
							} else {
								if ((!((_object getVariable ['QS_ClientUnitInsignia2','']) isEqualTo '')) && (!((_object getVariable ['QS_ClientUnitInsignia2','']) isEqualTo '#(argb,8,8,3)color(0,0,0,0)'))) then {
									lnbSetPicture [1808,[_forEachIndex,3],(_object getVariable ['QS_ClientUnitInsignia2',''])];
								} else {
									lnbSetPicture [1808,[_forEachIndex,3],'media\images\insignia\comm_patch.paa'];
								};
							};
						} else {
							lnbSetPicture [1808,[_forEachIndex,3],'media\images\insignia\comm_patch.paa'];
						};
					};
				} forEach _leaderboardDataArray;
				if (!(_myIndex isEqualTo -1)) then {
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
	uiNamespace setVariable ['QS_ui_mousePosition',getMousePosition];
	closeDialog 2;
};