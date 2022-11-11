/*/
File: fn_clientMenuRSS.sqf
Author:

	Quiksilver
	
Last Modified:

	22/04/2019 A3 1.90 by Quiksilver
	
Description:

	Role Selection System Menu
________________________________________________/*/
_timeout = diag_tickTime + 2;
waitUntil {
	uiSleep 0.01;
	((!isNull (uiNamespace getVariable ['QS_client_dialog_menu_roles',displayNull])) || {(diag_tickTime > _timeout)})
};
if (diag_tickTime > _timeout) exitWith {};
_getResolution = getResolution;
_uiScale = _getResolution # 5;
_sW = 0.01 / safezoneW;
_sH = 0.01 / safezoneH;
private _QS_ctrlCreateArray = [];
private _list = [];
_background_color_1 = [(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843]),(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019]),(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862]),(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])];
_display = findDisplay 42000;
private _controls = [];
private _control = controlNull;
private _controlIDC = 100;
_QS_ctrlCreateArray = ['RscFrame',100];
_QS_ctrl_1 = _display ctrlCreate _QS_ctrlCreateArray;
_QS_ctrl_1 ctrlShow TRUE;
_QS_ctrl_1 ctrlSetPosition [
	0.1 * safezoneW + safezoneX,
	0.1 * safezoneH + safezoneY,
	0.55 * safezoneW,
	0.595 * safezoneH
];
_QS_ctrl_1 ctrlSetTextColor [0,0,0,0.9];
_QS_ctrl_1 ctrlSetBackgroundColor [0,0,0,0.9];
_QS_ctrl_1 ctrlCommit 0;
_controls pushBack _QS_ctrl_1;
_QS_ctrlCreateArray = ['QS_RD_dialog_Box_2',101];
_QS_ctrl_2 = _display ctrlCreate _QS_ctrlCreateArray;
_QS_ctrl_2 ctrlShow TRUE;
_QS_ctrl_2 ctrlSetPosition [
	((ctrlPosition _QS_ctrl_1) # 0),
	((ctrlPosition _QS_ctrl_1) # 1),
	((ctrlPosition _QS_ctrl_1) # 2),
	((ctrlPosition _QS_ctrl_1) # 3)
];
_QS_ctrl_2 ctrlSetTextColor [0,0,0,0.9];
_QS_ctrl_2 ctrlSetBackgroundColor [0,0,0,0.9];
_QS_ctrl_2 ctrlCommit 0;
_controls pushBack _QS_ctrl_2;
_QS_ctrlCreateArray = ['RscText',102];
_QS_ctrl_3 = _display ctrlCreate _QS_ctrlCreateArray;
_QS_ctrl_3 ctrlShow TRUE;
_QS_ctrl_3 ctrlSetPosition [
	((ctrlPosition _QS_ctrl_1) # 0) + (0.01 / _uiScale),
	((ctrlPosition _QS_ctrl_1) # 1) + (0.01333 / _uiScale),
	((ctrlPosition _QS_ctrl_1) # 2) * 0.85,
	((ctrlPosition _QS_ctrl_1) # 3) * 0.05
];
_QS_ctrl_3 ctrlSetText (localize 'STR_QS_Menu_077');
_QS_ctrl_3 ctrlSetTextColor [1,1,1,1];
_QS_ctrl_3 ctrlSetBackgroundColor _background_color_1;
_QS_ctrl_3 ctrlCommit 0;
_controls pushBack _QS_ctrl_3;
_QS_ctrlCreateArray = ['RscPictureKeepAspect',103];
_QS_ctrl_4 = _display ctrlCreate _QS_ctrlCreateArray;
_QS_ctrl_4 ctrlShow TRUE;
_QS_ctrl_4 ctrlSetPosition [
	((ctrlPosition _QS_ctrl_1) # 0) + (0.64 / _uiScale),
	((ctrlPosition _QS_ctrl_1) # 1) + 0.01,
	((ctrlPosition _QS_ctrl_1) # 2) * 0.125,
	((ctrlPosition _QS_ctrl_1) # 3) * 0.1666
];
_QS_ctrl_4 ctrlSetText 'a3\UI_F_Jets\Data\CfgUnitInsignia\jets_patch_01.paa';
_QS_ctrl_4 ctrlSetTextColor [1,1,1,1];
_QS_ctrl_4 ctrlSetBackgroundColor _background_color_1;
_QS_ctrl_4 ctrlCommit 0;
_controls pushBack _QS_ctrl_4;
_QS_ctrlCreateArray = ['RscText',104];
_QS_ctrl_5 = _display ctrlCreate _QS_ctrlCreateArray;
_QS_ctrl_5 ctrlShow TRUE;
_QS_ctrl_5 ctrlSetText (localize 'STR_QS_Menu_078');
_QS_ctrl_5 ctrlSetPosition [
	((ctrlPosition _QS_ctrl_1) # 0) + (0.01 / _uiScale),
	((ctrlPosition _QS_ctrl_1) # 1) + (0.065 / _uiScale),
	((ctrlPosition _QS_ctrl_1) # 2) * ((ctrlTextWidth _QS_ctrl_5) * 1.25),
	((ctrlPosition _QS_ctrl_1) # 3) * 0.04
];
_QS_ctrl_5 ctrlSetTextColor [1,1,1,1];
_QS_ctrl_5 ctrlSetBackgroundColor [0.5,0.5,0.5,0.5];
_QS_ctrl_5 ctrlCommit 0;
_controls pushBack _QS_ctrl_5;
_QS_ctrlCreateArray = ['RscText',105];
_QS_ctrl_6 = _display ctrlCreate _QS_ctrlCreateArray;
_QS_ctrl_6 ctrlShow TRUE;
_QS_ctrl_6 ctrlSetText (localize 'STR_QS_Menu_079');
_QS_ctrl_6 ctrlSetPosition [
	((ctrlPosition _QS_ctrl_1) # 0) + (0.15 / _uiScale),
	((ctrlPosition _QS_ctrl_1) # 1) + (0.065 / _uiScale),
	((ctrlPosition _QS_ctrl_1) # 2) * ((ctrlTextWidth _QS_ctrl_6) * 1.25),
	((ctrlPosition _QS_ctrl_1) # 3) * 0.04
];
_QS_ctrl_6 ctrlSetTextColor [1,1,1,1];
_QS_ctrl_6 ctrlSetBackgroundColor [0.5,0.5,0.5,0.5];
_QS_ctrl_6 ctrlCommit 0;
_controls pushBack _QS_ctrl_6;
_QS_ctrlCreateArray = ['RscText',106];
_QS_ctrl_7 = _display ctrlCreate _QS_ctrlCreateArray;
_QS_ctrl_7 ctrlShow TRUE;
_QS_ctrl_7 ctrlSetText (localize 'STR_QS_Menu_080');
_QS_ctrl_7 ctrlSetPosition [
	((ctrlPosition _QS_ctrl_1) # 0) + (0.45 / _uiScale),
	((ctrlPosition _QS_ctrl_1) # 1) + (0.065 / _uiScale),
	((ctrlPosition _QS_ctrl_1) # 2) * ((ctrlTextWidth _QS_ctrl_7) * 1.25),
	((ctrlPosition _QS_ctrl_1) # 3) * 0.04
];
_QS_ctrl_7 ctrlSetTextColor [1,1,1,1];
_QS_ctrl_7 ctrlSetBackgroundColor [0.5,0.5,0.5,0.5];
_QS_ctrl_7 ctrlCommit 0;
_controls pushBack _QS_ctrl_7;
_QS_ctrlCreateArray = ['RscListNBox',107];
_QS_ctrl_8 = _display ctrlCreate _QS_ctrlCreateArray;
_QS_ctrl_8 ctrlShow TRUE;
_QS_ctrl_8 ctrlSetPosition [
	((ctrlPosition _QS_ctrl_1) # 0) + (0.01 / _uiScale),
	((ctrlPosition _QS_ctrl_1) # 1) + (0.1 / _uiScale),
	((ctrlPosition _QS_ctrl_1) # 2) * 0.15,
	((ctrlPosition _QS_ctrl_1) # 3) * 0.2
];
_QS_ctrl_8 ctrlSetTextColor [1,1,1,1];
_QS_ctrl_8 ctrlSetBackgroundColor [0.5,0.5,0.5,0.5];
_QS_ctrl_8 ctrlCommit 0;
_controls pushBack _QS_ctrl_8;
_list = [
	[EAST,'EAST','a3\Data_f\cfgFactionClasses_OPF_ca.paa'],
	[WEST,'WEST','a3\Data_f\cfgFactionClasses_BLU_ca.paa'],
	[RESISTANCE,'RESISTANCE','a3\Data_f\cfgFactionClasses_IND_ca.paa'],
	[CIVILIAN,'CIVILIAN','a3\Data_f\cfgFactionClasses_CIV_ca.paa']
];
private _selectedFactionRow = _list findIf { ((_x # 0) isEqualTo (player getVariable ['QS_unit_side',WEST])) };
private _factionList = [];
{
	if (_x isNotEqualTo []) then {
		_factionList pushBack (_list # _forEachIndex);
	};
} forEach (missionNamespace getVariable 'QS_roles_data');

{
	lnbAddRow [107,['',(_x # 1)]];
	if ((!(missionNamespace getVariable ['QS_RSS_client_canSideSwitch',FALSE])) && ( (_x # 0) isNotEqualTo (player getVariable ['QS_unit_side',WEST]))) then {
		lnbSetColor [107,[_forEachIndex,1],[0.5,0.5,0.5,1]];
	};
	lnbSetPicture [107,[_forEachIndex,0],(_x # 2)];
} forEach _factionList;
private _selectedFaction = _factionList # 0;
lnbSetColumnsPos [
	107,
	[
		0 + (0.01 / _uiScale),
		((ctrlPosition _QS_ctrl_8) # 0) + (((ctrlPosition _QS_ctrl_8) # 2) * 4)
	]
];
_QS_ctrl_8 ctrlCommit 0;
_QS_ctrlCreateArray = ['RscListNBox',108];
_QS_ctrl_9 = _display ctrlCreate _QS_ctrlCreateArray;
_QS_ctrl_9 ctrlShow TRUE;
_QS_ctrl_9 ctrlSetPosition [
	((ctrlPosition _QS_ctrl_1) # 0) + (0.15 / _uiScale),
	((ctrlPosition _QS_ctrl_1) # 1) + (0.1 / _uiScale),
	((ctrlPosition _QS_ctrl_1) # 2) * 0.4,
	((ctrlPosition _QS_ctrl_1) # 3) * 0.7
];
lnbSetColumnsPos [
	108,
	[
		((ctrlPosition _QS_ctrl_9) # 0) + (0.01 / _uiScale),
		((ctrlPosition _QS_ctrl_9) # 0) + (((ctrlPosition _QS_ctrl_9) # 2) * 2),
		((ctrlPosition _QS_ctrl_9) # 0) + (((ctrlPosition _QS_ctrl_9) # 2) * 2.8)
	]
];
_QS_ctrl_9 ctrlSetTextColor [1,1,1,1];
_QS_ctrl_9 ctrlSetBackgroundColor [0.5,0.5,0.5,0.9];
_QS_ctrl_9 ctrlCommit 0;
_controls pushBack _QS_ctrl_9;
private _listRoles = [];
private _list = [];
private _selectedRole = 'rifleman';
private _selectedRoleSide = WEST;
{
	lnbAddRow [108,[_x # 0,_x # 1]];
	lnbSetPicture [108,[_forEachIndex,2],(_x # 2)];
} forEach _list;
_QS_ctrl_9 ctrlCommit 0;
_QS_ctrlCreateArray = ['RscText',102];
_QS_ctrl_10 = _display ctrlCreate _QS_ctrlCreateArray;
_QS_ctrl_10 ctrlShow TRUE;
_QS_ctrl_10 ctrlSetPosition [
	((ctrlPosition _QS_ctrl_1) # 0) + (0.01 / _uiScale),
	((ctrlPosition _QS_ctrl_1) # 1) + (0.545 / _uiScale),
	((ctrlPosition _QS_ctrl_1) # 2) * 0.98,
	((ctrlPosition _QS_ctrl_1) # 3) * 0.07
];
_QS_ctrl_10 ctrlSetText '';
_QS_ctrl_10 ctrlSetTextColor [1,1,1,1];
_QS_ctrl_10 ctrlSetBackgroundColor _background_color_1;
_QS_ctrl_10 ctrlCommit 0;
_controls pushBack _QS_ctrl_10;

_QS_ctrlCreateArray = ['RscFrame',115];
_QS_ctrl_11 = _display ctrlCreate _QS_ctrlCreateArray;
_QS_ctrl_11 ctrlShow TRUE;
_QS_ctrl_11 ctrlSetPosition [
	((ctrlPosition _QS_ctrl_1) # 0) + (0.01 / _uiScale),
	((ctrlPosition _QS_ctrl_1) # 1) + (0.1 / _uiScale),
	((ctrlPosition _QS_ctrl_1) # 2) * 0.15,
	((ctrlPosition _QS_ctrl_1) # 3) * 0.2
];
_QS_ctrl_11 ctrlSetTextColor [1,1,1,1];
_QS_ctrl_11 ctrlSetBackgroundColor [0.5,0.5,0.5,0.1];
_QS_ctrl_11 ctrlCommit 0;
_controls pushBack _QS_ctrl_11;

_QS_ctrlCreateArray = ['RscFrame',116];
_QS_ctrl_12 = _display ctrlCreate _QS_ctrlCreateArray;
_QS_ctrl_12 ctrlShow TRUE;
_QS_ctrl_12 ctrlSetPosition [
	((ctrlPosition _QS_ctrl_1) # 0) + (0.15 / _uiScale),
	((ctrlPosition _QS_ctrl_1) # 1) + (0.1 / _uiScale),
	((ctrlPosition _QS_ctrl_1) # 2) * 0.4,
	((ctrlPosition _QS_ctrl_1) # 3) * 0.7
];
_QS_ctrl_12 ctrlSetTextColor [1,1,1,1];
_QS_ctrl_12 ctrlSetBackgroundColor [0.5,0.5,0.5,0.1];
_QS_ctrl_12 ctrlCommit 0;
_controls pushBack _QS_ctrl_12;
_ctrlGroup = _display ctrlCreate ['RscControlsGroup',1170];
_ctrlGroup ctrlSetPosition [
	((ctrlPosition _QS_ctrl_1) # 0) + (0.45 / _uiScale),
	((ctrlPosition _QS_ctrl_1) # 1) + (0.1 / _uiScale),
	((ctrlPosition _QS_ctrl_1) # 2) * 0.305,
	((ctrlPosition _QS_ctrl_1) # 3) * 0.7
];
_ctrlGroup ctrlCommit 0;
_QS_ctrlCreateArray = ['RscStructuredText',117,_ctrlGroup];
_QS_ctrl_13 = _display ctrlCreate _QS_ctrlCreateArray;
_QS_ctrl_13 ctrlShow TRUE;
_QS_ctrl_13 ctrlSetPosition [
	0,
	0,
	((ctrlPosition _QS_ctrl_1) # 2) * 0.291,
	((ctrlPosition _QS_ctrl_1) # 3) * 0.701
];
_QS_ctrl_13 ctrlSetText '';
_QS_ctrl_13 ctrlSetTextColor [1,1,1,1];
_QS_ctrl_13 ctrlSetBackgroundColor [0.1,0.1,0.1,0.9];
_QS_ctrl_13 ctrlCommit 0;
_controls pushBack _QS_ctrl_13;
_QS_ctrlCreateArray = ['RscText',118];
_QS_ctrl_14 = _display ctrlCreate _QS_ctrlCreateArray;
_QS_ctrl_14 ctrlShow TRUE;
_QS_ctrl_14 ctrlSetText (localize 'STR_QS_Menu_081');
_QS_ctrl_14 ctrlSetPosition [
	((ctrlPosition _QS_ctrl_1) # 0) + (0.01 / _uiScale),
	((ctrlPosition _QS_ctrl_1) # 1) + (0.25 / _uiScale),
	((ctrlPosition _QS_ctrl_1) # 2) * ((ctrlTextWidth _QS_ctrl_14) * 1.25),
	((ctrlPosition _QS_ctrl_1) # 3) * 0.04
];
_QS_ctrl_14 ctrlSetTextColor [1,1,1,1];
_QS_ctrl_14 ctrlSetBackgroundColor [0.5,0.5,0.5,0.5];
_QS_ctrl_14 ctrlCommit 0;
_controls pushBack _QS_ctrl_14;
_QS_ctrlCreateArray = ['RscListNBox',119];
_QS_ctrl_15 = _display ctrlCreate _QS_ctrlCreateArray;
_QS_ctrl_15 ctrlShow TRUE;
_QS_ctrl_15 ctrlSetPosition [
	((ctrlPosition _QS_ctrl_1) # 0) + (0.01 / _uiScale),
	((ctrlPosition _QS_ctrl_1) # 1) + (0.285 / _uiScale),
	((ctrlPosition _QS_ctrl_1) # 2) * 0.15,
	((ctrlPosition _QS_ctrl_1) # 3) * 0.4
];
_QS_ctrl_15 ctrlSetTextColor [1,1,1,1];
_QS_ctrl_15 ctrlSetBackgroundColor [0.5,0.5,0.5,0.5];
_QS_ctrl_15 ctrlCommit 0;
_controls pushBack _QS_ctrl_15;	
private _list = (allPlayers - (entities 'HeadlessClient_F')) apply { (name _x) };
_list sort TRUE;
{
	lnbAddRow [119,[_x]];
} forEach _list;
lnbSetColumnsPos [119,[(0.01 / _uiScale)]];
_QS_ctrl_15 ctrlCommit 0;	
_QS_ctrlCreateArray = ['RscFrame',115];
_QS_ctrl_16 = _display ctrlCreate _QS_ctrlCreateArray;
_QS_ctrl_16 ctrlShow TRUE;
_QS_ctrl_16 ctrlSetPosition [
	((ctrlPosition _QS_ctrl_1) # 0) + (0.01 / _uiScale),
	((ctrlPosition _QS_ctrl_1) # 1) + (0.285 / _uiScale),
	((ctrlPosition _QS_ctrl_1) # 2) * 0.15,
	((ctrlPosition _QS_ctrl_1) # 3) * 0.4
];
_QS_ctrl_16 ctrlSetTextColor [1,1,1,1];
_QS_ctrl_16 ctrlSetBackgroundColor [0.5,0.5,0.5,0.1];
_QS_ctrl_16 ctrlCommit 0;
_controls pushBack _QS_ctrl_16;
_QS_ctrlCreateArray = ['RscButton',120];
_QS_ctrl_17 = _display ctrlCreate _QS_ctrlCreateArray;
_QS_ctrl_17 ctrlShow TRUE;
_QS_ctrl_17 ctrlSetPosition [
	((ctrlPosition _QS_ctrl_1) # 0) + (0.0125 / _uiScale),
	((ctrlPosition _QS_ctrl_1) # 1) + (0.5485 / _uiScale),
	((ctrlPosition _QS_ctrl_1) # 2) * 0.1,
	((ctrlPosition _QS_ctrl_1) # 3) * 0.06
];
_QS_ctrl_17 ctrlEnable TRUE;
_QS_buttonAction = "closeDialog 2;";
_QS_ctrl_17 buttonSetAction _QS_buttonAction;
_QS_ctrl_17 ctrlSetText (localize 'STR_QS_Menu_047');
_QS_ctrl_17 ctrlSetTooltip (localize 'STR_QS_Menu_082');
_QS_ctrl_17 ctrlSetTextColor [1,1,1,1];
_QS_ctrl_17 ctrlSetBackgroundColor [0,0,0,1];
_QS_ctrl_17 ctrlCommit 0;
_controls pushBack _QS_ctrl_17;
_QS_ctrlCreateArray = ['RscButton',121];
_QS_ctrl_18 = _display ctrlCreate _QS_ctrlCreateArray;
_QS_ctrl_18 ctrlShow TRUE;
_QS_ctrl_18 ctrlSetPosition [
	((ctrlPosition _QS_ctrl_1) # 0) + (0.1 / _uiScale),
	((ctrlPosition _QS_ctrl_1) # 1) + (0.5485 / _uiScale),
	((ctrlPosition _QS_ctrl_1) # 2) * 0.1,
	((ctrlPosition _QS_ctrl_1) # 3) * 0.06
];
_QS_ctrl_18 ctrlSetText (localize 'STR_QS_Menu_083');
_QS_buttonAction = "['SET_DEFAULT_LOADOUT',(player getVariable ['QS_unit_role','rifleman']),TRUE] call (missionNamespace getVariable 'QS_fnc_roles');";
_QS_ctrl_18 buttonSetAction _QS_buttonAction;
_QS_ctrl_18 ctrlSetTooltip (localize 'STR_QS_Menu_084');
_QS_ctrl_18 ctrlSetTextColor [1,1,1,1];
_QS_ctrl_18 ctrlSetBackgroundColor [0,0,0,1];
_QS_ctrl_18 ctrlCommit 0;
_controls pushBack _QS_ctrl_18;
_QS_ctrlCreateArray = ['RscButton',122];
_QS_ctrl_19 = _display ctrlCreate _QS_ctrlCreateArray;
_QS_ctrl_19 ctrlShow TRUE;
_QS_ctrl_19 ctrlSetPosition [
	((ctrlPosition _QS_ctrl_1) # 0) + (0.1875 / _uiScale),
	((ctrlPosition _QS_ctrl_1) # 1) + (0.5485 / _uiScale),
	((ctrlPosition _QS_ctrl_1) # 2) * 0.1,
	((ctrlPosition _QS_ctrl_1) # 3) * 0.06
];
_QS_ctrl_19 ctrlEnable TRUE;
_QS_ctrl_19 ctrlSetText (localize 'STR_QS_Menu_085');
_QS_buttonAction = "
	0 spawn {
		uiSleep 0.1;
		waitUntil {
			closeDialog 2;
			(!dialog)
		};
		[nil,nil,nil,player] call (missionNamespace getVariable 'QS_fnc_clientInteractArsenal');
	};
";
_QS_ctrl_19 buttonSetAction _QS_buttonAction;
_QS_ctrl_19 ctrlSetTooltip (localize 'STR_QS_Menu_086');
_QS_ctrl_19 ctrlSetTextColor [1,1,1,1];
_QS_ctrl_19 ctrlSetBackgroundColor [0,0,0,1];
_QS_ctrl_19 ctrlCommit 0;
_controls pushBack _QS_ctrl_19;
_QS_ctrlCreateArray = ['RscButton',123];
_QS_ctrl_20 = _display ctrlCreate _QS_ctrlCreateArray;
_QS_ctrl_20 ctrlShow TRUE;
_QS_ctrl_20 ctrlSetPosition [
	((ctrlPosition _QS_ctrl_1) # 0) + (0.275 / _uiScale),
	((ctrlPosition _QS_ctrl_1) # 1) + (0.5485 / _uiScale),
	((ctrlPosition _QS_ctrl_1) # 2) * 0.1,
	((ctrlPosition _QS_ctrl_1) # 3) * 0.06
];
_QS_ctrl_20 ctrlEnable TRUE;
_QS_ctrl_20 ctrlSetText (localize 'STR_QS_Menu_087');
_QS_buttonAction = "
	0 spawn {
		uiSleep 0.1;
		waitUntil {
			closeDialog 2;
			(!dialog)
		};
		uiSleep 0.01;
		(findDisplay 46) createDisplay 'RscDisplayDynamicGroups';
		50 cutText [localize 'STR_QS_Text_168','PLAIN'];
	};
";
_QS_ctrl_20 buttonSetAction _QS_buttonAction;
_QS_ctrl_20 ctrlSetTooltip (localize 'STR_QS_Diary_110');
_QS_ctrl_20 ctrlSetTextColor [1,1,1,1];
_QS_ctrl_20 ctrlSetBackgroundColor [0,0,0,1];
_QS_ctrl_20 ctrlCommit 0;
_controls pushBack _QS_ctrl_20;
_QS_ctrlCreateArray = ['RscButton',124];
_QS_ctrl_21 = _display ctrlCreate _QS_ctrlCreateArray;
_QS_ctrl_21 ctrlShow FALSE;
_QS_ctrl_21 ctrlSetPosition [
	((ctrlPosition _QS_ctrl_1) # 0) + (0.4 / _uiScale),
	((ctrlPosition _QS_ctrl_1) # 1) + (0.5485 / _uiScale),
	((ctrlPosition _QS_ctrl_1) # 2) * 0.1,
	((ctrlPosition _QS_ctrl_1) # 3) * 0.06
];
_QS_ctrl_21 ctrlEnable FALSE;
_QS_ctrl_21 ctrlSetText '- - -';
_QS_ctrl_21 ctrlSetTooltip (localize 'STR_QS_Menu_088');
_QS_ctrl_21 ctrlSetTextColor [1,1,1,1];
_QS_ctrl_21 ctrlSetBackgroundColor [0,0,0,1];
_QS_ctrl_21 ctrlCommit 0;
_controls pushBack _QS_ctrl_21;
_QS_ctrlCreateArray = ['RscButton',125];
_QS_ctrl_22 = _display ctrlCreate _QS_ctrlCreateArray;
_QS_ctrl_22 ctrlShow FALSE;
_QS_ctrl_22 ctrlEnable FALSE;
_QS_ctrl_22 ctrlSetPosition [
	((ctrlPosition _QS_ctrl_1) # 0) + (0.5 / _uiScale),
	((ctrlPosition _QS_ctrl_1) # 1) + (0.5485 / _uiScale),
	((ctrlPosition _QS_ctrl_1) # 2) * 0.1,
	((ctrlPosition _QS_ctrl_1) # 3) * 0.06
];
_QS_ctrl_22 ctrlSetText (localize 'STR_QS_Menu_089');
_QS_ctrl_22 ctrlSetTextColor [1,1,1,1];
_QS_ctrl_22 ctrlSetBackgroundColor [0,0,0,1];
_QS_ctrl_22 ctrlCommit 0;
_controls pushBack _QS_ctrl_22;
_QS_ctrlCreateArray = ['RscButton',126];
_QS_ctrl_23 = _display ctrlCreate _QS_ctrlCreateArray;
_QS_ctrl_23 ctrlShow TRUE;
_QS_ctrl_23 ctrlSetPosition [
	((ctrlPosition _QS_ctrl_1) # 0) + (0.6 / _uiScale),
	((ctrlPosition _QS_ctrl_1) # 1) + (0.5485 / _uiScale),
	((ctrlPosition _QS_ctrl_1) # 2) * 0.171,
	((ctrlPosition _QS_ctrl_1) # 3) * 0.06
];
_QS_ctrl_23 ctrlSetText (localize 'STR_QS_Menu_090');
_QS_ctrl_23 ctrlSetTooltip (localize 'STR_QS_Menu_091');
_QS_ctrl_23 ctrlSetTextColor [1,1,1,1];
_QS_ctrl_23 ctrlSetBackgroundColor [0,0,0,1];
_QS_ctrl_23 ctrlCommit 0;
_controls pushBack _QS_ctrl_23;
_QS_buttonAction = "['REQUEST_ROLE',(getPlayerUID player),((uiNamespace getVariable ['QS_client_roles_menu_selectedRole',[]]) # 1),((uiNamespace getVariable ['QS_client_roles_menu_selectedRole',[]]) # 0),player,clientOwner] call (missionNamespace getVariable 'QS_fnc_roles')";
_QS_ctrl_23 buttonSetAction _QS_buttonAction;
_QS_ctrlCreateArray = ['RscFrame',116];
_QS_ctrl_24 = _display ctrlCreate _QS_ctrlCreateArray;
_QS_ctrl_24 ctrlShow TRUE;
_QS_ctrl_24 ctrlSetPosition [
	((ctrlPosition _QS_ctrl_1) # 0) + (0.45 / _uiScale),
	((ctrlPosition _QS_ctrl_1) # 1) + (0.1 / _uiScale),
	((ctrlPosition _QS_ctrl_1) # 2) * 0.291,
	((ctrlPosition _QS_ctrl_1) # 3) * 0.7
];
_QS_ctrl_24 ctrlSetTextColor [1,1,1,1];
_QS_ctrl_24 ctrlSetBackgroundColor [0.5,0.5,0.5,0.1];
_QS_ctrl_24 ctrlCommit 0;
_controls pushBack _QS_ctrl_24;

_QS_ctrlCreateArray = ['RscText',127];
_QS_ctrl_25 = _display ctrlCreate _QS_ctrlCreateArray;
_QS_ctrl_25 ctrlShow TRUE;
_QS_ctrl_25 ctrlSetText '';
_QS_ctrl_25 ctrlSetPosition [
	((ctrlPosition _QS_ctrl_3) # 0) + (((ctrlPosition _QS_ctrl_3) # 2) / 2),
	((ctrlPosition _QS_ctrl_1) # 1) + (0.01333 / _uiScale),
	((ctrlTextWidth _QS_ctrl_25) * 1.1),
	((ctrlPosition _QS_ctrl_1) # 3) * 0.05
];
_QS_ctrl_25 ctrlSetTextColor [1,1,1,1];
_QS_ctrl_25 ctrlSetBackgroundColor [0,0,0,0];
_QS_ctrl_25 ctrlCommit 0;
_controls pushBack _QS_ctrl_25;

private _whitelist_color = _background_color_1;
private _whitelist_value = 0;
private _whitelisted = (getPlayerUID player) in (['S3'] call (missionNamespace getVariable 'QS_fnc_whitelist'));
private _roleCount = 0;

private _selectedRoleRow = 0;
private _currentSelectedFaction = 0;
private _selectedRoleCanSelect = FALSE;
uiNamespace setVariable ['QS_client_roles_menu_selectedRole',[]];
lnbSetCurSelRow [107,_selectedFactionRow];
{
	_selectedRoleRow = 0;
	if (((_x # 1) isEqualTo (player getVariable ['QS_unit_side',WEST])) && ((_x # 0) isEqualTo (player getVariable ['QS_unit_role','rifleman']))) exitWith {
		_selectedRoleRow = _forEachIndex;
	};
} forEach ((missionNamespace getVariable 'QS_roles_data') # _selectedFactionRow);
lnbSetCurSelRow [108,_selectedRoleRow];
ctrlSetFocus _QS_ctrl_9;
setMousePosition (uiNamespace getVariable ['QS_ui_mousePosition',getMousePosition]);
_fn_roles = missionNamespace getVariable ['QS_fnc_roles',{}];
_fn_sideColor = missionNamespace getVariable 'BIS_fnc_sideColor';
private _refreshDelayDefault = -1;
private _unit = player;
waitUntil {
	uiSleep 0.03;
	if (diag_tickTime > _refreshDelayDefault) then {
		missionNamespace setVariable ['QS_RSS_refreshUI',TRUE,FALSE];
		_refreshDelayDefault = diag_tickTime + 3;
	};
	ctrlEnable [126,((diag_tickTime > (uiNamespace getVariable ['QS_RSS_requestCooldown',-1])) && ((lnbCurSelRow 108) >= 0))];
	{
		ctrlEnable [_x,(diag_tickTime > (uiNamespace getVariable ['QS_RSS_requestCooldown',-1]))];
	} forEach [
		121
	];
	if ((ctrlText _QS_ctrl_25) isNotEqualTo (['GET_ROLE_DISPLAYNAME2',(_unit getVariable ['QS_unit_role','rifleman'])] call _fn_roles)) then {
		_QS_ctrl_25 ctrlSetText (['GET_ROLE_DISPLAYNAME2',(_unit getVariable ['QS_unit_role','rifleman'])] call _fn_roles);
		_QS_ctrl_25 ctrlSetPosition [
			((ctrlPosition _QS_ctrl_25) # 0),
			((ctrlPosition _QS_ctrl_25) # 1),
			((ctrlTextWidth _QS_ctrl_25) * 1.1),
			((ctrlPosition _QS_ctrl_25) # 3)
		];
		_QS_ctrl_25 ctrlCommit 0;
	};
	if ( (lnbCurSelRow 107) isNotEqualTo _selectedFactionRow) then {
		missionNamespace setVariable ['QS_RSS_refreshUI',TRUE,FALSE];
		_selectedFactionRow = lnbCurSelRow 107;
		if (_selectedFactionRow isNotEqualTo -1) then {
			_selectedFaction = _factionList # _selectedFactionRow;
			{
				_selectedRoleRow = 0;
				if (((_x # 1) isEqualTo (player getVariable ['QS_unit_side',WEST])) && ((_x # 0) isEqualTo (player getVariable ['QS_unit_role','rifleman']))) exitWith {
					_selectedRoleRow = _forEachIndex;
				};
			} forEach ((missionNamespace getVariable 'QS_roles_data') # _selectedFactionRow);
			lnbSetCurSelRow [108,0];
		};
	};
	if (missionNamespace getVariable ['QS_RSS_refreshUI',FALSE]) then {
		_list = (allPlayers - (entities 'HeadlessClient_F')) apply { [ (name _x) , ([(side (group _x)),FALSE] call _fn_sideColor) , _x ] };
		_list sort TRUE;
		_list select [0,100];
		lnbClear 119;
		{
			lnbAddRow [119,[_x # 0]];
			lnbSetColor [119,[_forEachIndex,0],(_x # 1)];
			lnbSetTooltip [119,[_forEachIndex,0],(format ['%1 - %2',(groupId (group (_x # 2))),(['GET_ROLE_DISPLAYNAME2',((_x # 2) getVariable ['QS_unit_role','rifleman'])] call _fn_roles)])];
		} forEach _list;
	};
	if (_selectedFactionRow isNotEqualTo -1) then {
		_list = [];
		_listRoles = [];
		{
			_list pushBack [
				(['GET_ROLE_DISPLAYNAME2',(_x # 0)] call _fn_roles),
				(['GET_ROLE_COUNT',(_x # 0),(_x # 1),TRUE] call _fn_roles),
				(['GET_ROLE_ICON',(_x # 0)] call _fn_roles),
				(call (_x # 8)),
				(call (_x # 9)),
				(call (_x # 10)),
				(['GET_ROLE_COUNT',(_x # 0),(_x # 1),FALSE] call _fn_roles),
				(_x # 5)
			];
			_listRoles pushBack [(_x # 0),(_x # 1),(_x # 8)];
		} forEach ((missionNamespace getVariable 'QS_roles_data') # _selectedFactionRow);
		if (missionNamespace getVariable ['QS_RSS_refreshUI',FALSE]) then {
			missionNamespace setVariable ['QS_RSS_refreshUI',FALSE,FALSE];
			lnbClear 108;
			{
				if (_x # 3) then {
					lnbAddRow [108,[_x # 0,_x # 1]];
					lnbSetPicture [108,[_forEachIndex,2],(_x # 2)];
					lnbSetTooltip [108,[_forEachIndex,0],(_x # 0)];
					if ((!(_x # 4)) || {(((_x # 6) # 0) >= ((_x # 6) # 1))}) then {
						lnbSetValue [108,[_forEachIndex,0],0];
						lnbSetColor [108,[_forEachIndex,0],[0.5,0.5,0.5,1]];
						lnbSetColor [108,[_forEachIndex,1],[0.5,0.5,0.5,1]];
					} else {
						_whitelist_value = _x # 7;
						if (_whitelist_value > 0) then {
							_roleCount = _x # 6;
							_roleCount set [1,((_roleCount # 1) - _whitelist_value)];
							if ((_roleCount # 0) >= (_roleCount # 1)) then {
								lnbSetValue [108,[_forEachIndex,0],1];
								lnbSetColor [108,[_forEachIndex,0],_whitelist_color];
								lnbSetColor [108,[_forEachIndex,1],_whitelist_color];
							} else {
								lnbSetValue [108,[_forEachIndex,0],1];
							};
						} else {
							lnbSetValue [108,[_forEachIndex,0],1];
						};
					};
				} else {
					lnbAddRow [108,['','']];
					lnbSetPicture [108,[_forEachIndex,2],''];
					lnbSetTooltip [108,[_forEachIndex,0],''];
					lnbSetValue [108,[_forEachIndex,0],0];
				};
			} forEach _list;
		};
	};
	_selectedRoleRow = lnbCurSelRow 108;
	if (_selectedRoleRow isNotEqualTo -1) then {
		_selectedRole = (_listRoles # _selectedRoleRow) # 0;
		_selectedRoleSide = (_listRoles # _selectedRoleRow) # 1;
		_selectedRoleVisible = (_listRoles # _selectedRoleRow) # 2;
		_selectedRoleCanSelect = (lnbValue [108,[_selectedRoleRow,0]]) isEqualTo 1;
		if ((uiNamespace getVariable ['QS_client_roles_menu_selectedRole',[]]) isNotEqualTo (_listRoles # _selectedRoleRow)) then {
			uiNamespace setVariable ['QS_client_roles_menu_selectedRole',(_listRoles # _selectedRoleRow)];
		};
		uiNamespace setVariable ['QS_RSS_currentSelectedRole',_selectedRole];
		if (call _selectedRoleVisible) then {
			_QS_ctrl_13 ctrlSetStructuredText (['GET_ROLE_DESCRIPTION',_selectedRole] call _fn_roles);
			_QS_ctrl_13 ctrlSetPosition [0,0,((ctrlPosition _QS_ctrl_13) # 2),((ctrlTextHeight _QS_ctrl_13) max (((ctrlPosition _QS_ctrl_1) # 3) * 0.701))];
		} else {
			_QS_ctrl_13 ctrlSetStructuredText (parseText (localize 'STR_QS_Role_030'));
			_QS_ctrl_13 ctrlSetPosition [0,0,((ctrlPosition _QS_ctrl_13) # 2),((ctrlTextHeight _QS_ctrl_13) max (((ctrlPosition _QS_ctrl_1) # 3) * 0.701))];
		};
	};
	uiNamespace setVariable ['QS_client_roles_menu_canSelectRole',_selectedRoleCanSelect];
	{
		_x ctrlCommit 0;
	} forEach [
		_QS_ctrl_9,
		_QS_ctrl_13,
		_QS_ctrl_15,
		_QS_ctrl_23
	];
	(isNull (uiNamespace getVariable ['QS_client_dialog_menu_roles',displayNull]))
};
{
	uiNamespace setVariable _x;
} forEach [
	['QS_ui_mousePosition',getMousePosition],
	['QS_client_roles_menu_selectedRole',[]],
	['QS_client_roles_menu_canSelectRole',FALSE]
];