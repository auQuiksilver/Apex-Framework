/*/
File: QS_icons.sqf
Script Name: Soldier Tracker
Author:

	Quiksilver (contact: armacombatgroup@gmail.com)
	
Version:

	2.5.0 (released 24/02/2018 A3 1.80)

Created: 

	8/08/2014
	
Last Modified: 

	9/10/2023 A3 2.14 by Quiksilver
	
Installation: 

	In client/player init (initPlayerLocal.sqf)
		
		[] execVM "QS_icons.sqf";
		
	or 
		
		[] execVM "scripts\QS_icons.sqf";    (if in a folder called "scripts" in your mission directory.)

	Follow instructions posted in the below link
		
		http://forums.bistudio.com/showthread.php?184108-Soldier-Tracker-(-Map-and-GPS-Icons-)
_________________________________________________________________/*/

if (isDedicated || !hasInterface) exitWith {};
private [
	'_side','_sides','_QS_ST_X','_QS_ST_map_enableUnitIcons','_QS_ST_gps_enableUnitIcons',	'_QS_ST_enableGroupIcons','_QS_ST_faction','_QS_ST_friendlySides_EAST',
	'_QS_ST_friendlySides_WEST','_QS_ST_friendlySides_RESISTANCE','_QS_ST_friendlySides_CIVILIAN','_QS_ST_friendlySides_Dynamic','_QS_ST_iconColor_EAST','_QS_ST_iconColor_WEST',
	'_QS_ST_iconColor_RESISTANCE','_QS_ST_iconColor_CIVILIAN','_QS_ST_iconColor_UNKNOWN','_QS_ST_showMedicalWounded','_QS_ST_MedicalSystem','_QS_ST_MedicalIconColor','_QS_ST_iconShadowMap',
	'_QS_ST_iconShadowGPS','_QS_ST_iconTextSize_Map','_QS_ST_iconTextSize_GPS','_QS_ST_iconTextOffset','_QS_ST_iconSize_Man','_QS_ST_iconSize_LandVehicle',	
	'_QS_ST_iconSize_Ship','_QS_ST_iconSize_Air','_QS_ST_iconSize_StaticWeapon','_QS_ST_GPSDist','_QS_ST_GPSshowNames','_QS_ST_GPSshowGroupOnly',	'_QS_ST_showAIGroups',			
	'_QS_ST_showGroupMapIcons','_QS_ST_showGroupHudIcons','_QS_ST_groupInteractiveIcons','_QS_ST_groupInteractiveIcons_showClass',		
	'_QS_ST_showGroupMapText','_QS_ST_groupIconScale','_QS_ST_groupIconOffset','_QS_ST_groupIconText','_QS_ST_autonomousVehicles','_QS_fnc_iconColor','_QS_fnc_iconType',				
	'_QS_fnc_iconSize','_QS_fnc_iconPosDir','_QS_fnc_iconText','_QS_fnc_iconUnits','_QS_fnc_onMapSingleClick','_QS_fnc_mapVehicleShowCrew','_QS_fnc_iconDrawMap',			
	'_QS_fnc_iconDrawGPS','_QS_fnc_groupIconText','_QS_fnc_groupIconType','_QS_fnc_configGroupIcon','_QS_fnc_onGroupIconClick','_QS_fnc_onGroupIconOverLeave',	
	'_QS_ST_iconMapClickShowDetail','_QS_ST_showFriendlySides','_QS_fnc_onGroupIconOverEnter','_QS_ST_showCivilianGroups','_QS_ST_iconTextFont','_QS_ST_showAll','_QS_ST_showFactionOnly',		
	'_QS_ST_showAI','_QS_ST_showMOS','_QS_ST_showGroupOnly','_QS_ST_iconUpdatePulseDelay','_QS_ST_iconMapText','_QS_ST_showMOS_range',
	'_QS_ST_iconTextFonts','_QS_fnc_isIncapacitated','_QS_ST_htmlColorMedical','_QS_ST_R','_QS_ST_showAINames','_QS_ST_AINames',
	'_QS_ST_groupTextFactionOnly','_QS_ST_showCivilianIcons','_QS_ST_showOnlyVehicles','_QS_ST_showOwnGroup','_QS_ST_iconColor_empty',
	'_QS_ST_iconSize_empty','_QS_ST_showEmptyVehicles','_QS_ST_colorInjured','_QS_ST_htmlColorInjured','_QS_fnc_iconColorGroup','_QS_ST_otherDisplays','_QS_ST_MAPrequireGPSItem',
	'_QS_ST_GPSrequireGPSItem','_QS_ST_GRPrequireGPSItem','_QS_ST_admin','_QS_ST_showKnownEnemies'
];

//==============================================================================================================================//
//=============================================================== CONFIGURATION START ==========================================//
//==============================================================================================================================//
//============================================================== FREE TO EDIT BELOW!!! =========================================//
//==============================================================================================================================//

//==================================================================================//
//================================ CONFIGURE COMMON ================================//
//==================================================================================//

//================== MASTER SWITCHES

_QS_ST_map_enableUnitIcons = TRUE;														// BOOL. TRUE to enable MAP unit/vehicle Icons. Default TRUE.
_QS_ST_gps_enableUnitIcons = TRUE;														// BOOL. TRUE to enable GPS unit/vehicle Icons. Default TRUE.
_QS_ST_enableGroupIcons = player getUnitTrait 'QS_trait_HQ';							// BOOL. TRUE to enable Map+GPS+HUD GROUP Icons. Default TRUE.

// These are overridden by custom scripted systems
disableMapIndicators [
	TRUE,				// --- Friendly
	TRUE,				// --- Enemy
	TRUE,				// --- Mines
	TRUE				// --- Tactical Ping
];

//================= ADMIN

_QS_ST_admin = FALSE;										// BOOL. TRUE to enable showing all units (even enemies) if logged in as admin on a server. Default FALSE;
_QS_ST_showAll = 0;											// NUMBER. Intended for Debug / Development use only! Caution: Will cause lag if 1 or 2! Settings -  0 = Disabled (Recommended). 1 = Reveal all Units + vehicles. 2 = Reveal all mission objects + vehicles + units. May override below configurations if set at 1 or 2.
	
//================= DIPLOMACY - set the Friendly factions for each faction.

_QS_ST_friendlySides_Dynamic = TRUE;						// BOOL. Set TRUE to allow faction alliances to change dynamically (IE. AAF may not always be loyal to NATO) and be represented on the map. Default TRUE.
_QS_ST_friendlySides_EAST = [								// ARRAY (NUMBER). Uncomment the relevant number(s). Remove comma after last used entry (important!).
	//1,					//EAST is friendly to WEST
	//2,					//EAST is friendly to INDEPENDENT/RESISTANCE
	3						//EAST is friendly to CIVILIANS
];
_QS_ST_friendlySides_WEST = [								// ARRAY (NUMBER). Uncomment the relevant number(s). Remove comma after last used entry (important!).
	//0,					//WEST is friendly to EAST
	2						//WEST is friendly to INDEP/RESISTANCE
	//3						//WEST is friendly to CIVILIAN
];
_QS_ST_friendlySides_RESISTANCE = [							// ARRAY (NUMBER). Uncomment the relevant number(s). Remove comma after last used entry (important!).
	//0,					//RESISTANCE is friendly to EAST
	1,						//RESISTANCE is friendly to WEST
	3						//RESISTANCE is friendly to CIVILIAN
];
_QS_ST_friendlySides_CIVILIAN = [							// ARRAY (NUMBER). Uncomment the relevant number(s). Remove comma after last used entry (important!).
	0,						//CIVILIAN is friendly to EAST
	//1,					//CIVILIAN is friendly to WEST
	2						//CIVILIAN is friendly to INDEP/RESISTANCE
];

//================= DEFAULT ICON COLORS by FACTION

_QS_ST_iconColor_EAST = [0.5,0,0,0.65];							// ARRAY (NUMBER). RGBA color code.	Default [0.5,0,0,0.65];
_QS_ST_iconColor_WEST = [0,0.3,0.6,0.65];						// ARRAY (NUMBER). RGBA color code. Default [0,0.3,0.6,0.65];
_QS_ST_iconColor_RESISTANCE = [0,0.5,0,0.65];					// ARRAY (NUMBER). RGBA color code. Default [0,0.5,0,0.65];	
_QS_ST_iconColor_CIVILIAN = [0.4,0,0.5,0.65];					// ARRAY (NUMBER). RGBA color code. Default [0.4,0,0.5,0.65];	
_QS_ST_iconColor_UNKNOWN = [0.7,0.6,0,0.5];						// ARRAY (NUMBER). RGBA color code. Default [0.7,0.6,0,0.5];

//================= MEDICAL

_QS_ST_showMedicalWounded = TRUE;								// BOOL. TRUE to show wounded on the map and GPS. FALSE to not show wounded on the map with this script. Default TRUE.
_QS_ST_MedicalSystem = [										// ARRAY(STRING). The Active Medical System. Uncomment ONLY ONE. FIRST UNCOMMENTED ONE WILL BE USED. Comment the rest out as shown. Do not add commas and only allow 1 to be uncommented.
	'BIS'														// BIS Revive.
	//'BTC'														// BTC Revive.
	//'AIS'														// AIS Revive.
	//'ACE'														// ACE 3 Revive.
	//'FAR'														// Farooq's Revive.
	//'AWS'    													// A3 Wounding System by Psycho.
];
_QS_ST_MedicalIconColor = [1,0.41,0,1];							// ARRAY (NUMBER). Color of medical icons in RGBA format. Default [1,0.41,0,1];
_QS_ST_colorInjured = [0.75,0.55,0,0.75];						// ARRAY (NUMBER). RGBA color code. Color of units with > 10% damage, in map group interactive interface. Default [0.7,0.6,0,0.5];

//==================================================================================//
//=========================== CONFIGURE MAP (UNIT/VEHICLE) ICONS ===================//
//==================================================================================//

_QS_ST_showFactionOnly = FALSE;									// BOOL. will override ST_showFriendlySides TRUE. If TRUE then will only show players faction. If FALSE then can show friendly factions. Default FALSE.
_QS_ST_showAI = TRUE;											// BOOL. FALSE = players only, TRUE = players and AI. Default TRUE.
_QS_ST_AINames = FALSE;											// BOOL. Set TRUE to show human names for AI with the map/vehicle icons. Set FALSE and will be named 'AI'. Default FALSE.
_QS_ST_showCivilianIcons = FALSE;								// BOOL. Set TRUE to allow showing of civilians, only works if Dynamic Diplomacy is enabled above. Default FALSE.
_QS_ST_iconMapText = TRUE;										// BOOL. TRUE to show unit/vehicle icon text on the map. FALSE to only show the icon and NO text (name/class). Default TRUE.
_QS_ST_showMOS = TRUE;											// BOOL. TRUE = show Military Occupational Specialty text(unit/vehicle class/role display name), FALSE = disable and only show icons and names. Default FALSE.
_QS_ST_showMOS_range = 3500;									// NUMBER. Range in distance to show MOS on the map. Default 3500.
_QS_ST_showGroupOnly = FALSE;									// BOOL. Set TRUE to show ONLY the unit icons of THE PLAYERS GROUP MEMBERS on the MAP, FALSE to show ALL your factions units. May override other config. Default TRUE.
_QS_ST_showOnlyVehicles = FALSE;								// BOOL. Set TRUE to show ONLY vehicles, no foot-soldier units will be shown. May override other config. Default TRUE.
_QS_ST_iconMapClickShowDetail = TRUE;							// BOOL. Set TRUE to show unit/vehicle detail when player clicks on their map near the vehicle. Only works for shown vehicles. Default TRUE.
_QS_ST_iconUpdatePulseDelay = 0;								// NUMBER. How often should location of unit on the MAP be updated? 0 = as fast as possible, else if > 0 then it = time in seconds. Default 0.
_QS_ST_iconShadowMap = 1;										// NUMBER. Icon Shadow on MAP. 0 = no shadow. 1 = shadow. 2 = outline. Must be 0, 1, or 2. Default 1.
_QS_ST_iconTextSize_Map = 0.05;									// NUMBER. Icon Text Size on MAP display. Default is 0.05.
_QS_ST_iconTextOffset = 'right';								// STRING. Icon Text Offset. Can be 'left' or 'center' or 'right'. Default is 'right'
_QS_ST_iconSize_Man = 22;										// NUMBER. Icon Size by Vehicle Type. Man/Units. Default = 22
_QS_ST_iconSize_LandVehicle = 26;								// NUMBER. Icon Size by Vehicle Type. Ground-based vehicles. Default = 26	
_QS_ST_iconSize_Ship = 24;										// NUMBER. Icon Size by Vehicle Type. Water-based vehicles. Default = 24
_QS_ST_iconSize_Air = 24;										// NUMBER. Icon Size by Vehicle Type. Air vehicles. Default = 24
_QS_ST_iconSize_StaticWeapon = 22;								// NUMBER. Icon Size by Vehicle Type. Static Weapon (Mortar, remote designator, HMG/GMG. Default = 22
_QS_ST_iconTextFonts = [										// ARRAY (STRING). Icon Text Font. Only the uncommented one will be used. Do not add commas and only allow 1 to be uncommented. Default 'puristaMedium'.
	//'EtelkaMonospacePro'
	//'EtelkaMonospaceProBold'
	//'EtelkaNarrowMediumPro'
	//'LucidaConsoleB'
	//'PuristaBold'
	//'PuristaLight'
	//'puristaMedium'
	//'PuristaSemibold'
	'RobotoCondensed'
	//'TahomaB'
];
_QS_ST_otherDisplays = FALSE;									// BOOL. TRUE to add Unit/Vehicle Icon support for UAV Terminal and Artillery Computer. Runs a separate script to handle these displays. Only works if  _QS_ST_map_enableUnitIcons = TRUE;
_QS_ST_MAPrequireGPSItem = FALSE;								// BOOL. TRUE to require player have GPS in his assigned items. Default FALSE.

//==================================================================================//
//=========================== CONFIGURE GPS (UNIT/VEHICLE) ICONS ===================//
//==================================================================================//

_QS_ST_GPSDist = 300;											// NUMBER. Distance from player that units shown on GPS. Higher number = lower script performance. Not significant but every 1/10th of a frame counts! Default 300
_QS_ST_GPSshowNames = FALSE;									// BOOL. TRUE to show unit names on the GPS display. Default FALSE.
_QS_ST_GPSshowGroupOnly = FALSE;								// BOOL. TRUE to show only group members on the GPS display. Default TRUE.
_QS_ST_iconTextSize_GPS = 0.05;									// NUMBER. Icon Text Size on GPS display. Default is 0.05.
_QS_ST_iconShadowGPS = 1;										// NUMBER. Icon Shadow on GPS. 0 = no shadow. 1 = shadow. 2 = outline. Must be 0, 1, or 2. Default 1.
_QS_ST_GPSrequireGPSItem = FALSE;								// BOOL. TRUE to require player have GPS in his assigned items. Default FALSE.

//==================================================================================//
//============================= CONFIGURE GROUP ICONS ==============================//
//==================================================================================//

_QS_ST_showGroupMapIcons = TRUE;								// BOOL. Group icons displayed on map. Default TRUE.
_QS_ST_showGroupHudIcons = FALSE;								// BOOL. Group icons displayed on player 3D HUD. Default FALSE.
_QS_ST_showAIGroups = TRUE;										// BOOL. Show Groups with AI leaders. Default TRUE.
_QS_ST_showAINames = FALSE;										// BOOL. Show AI Names. If FALSE, when names are listed with Group features, will only display as '[AI]'. Default FALSE.
_QS_ST_groupInteractiveIcons = TRUE;							// BOOL. Group icons are interactable (mouse hover and mouse click for group details). Default TRUE.
_QS_ST_groupInteractiveIcons_showClass = TRUE;					// BOOL. TRUE to show units vehicle class when revealing group details with interactive map group click. Default TRUE.
_QS_ST_showGroupMapText = TRUE;									// BOOL. TRUE to show Group Name on the map. If FALSE, name can still be seen by clicking on the group icon, if QS_ST_groupInteractiveIcons = TRUE. Default FALSE.
_QS_ST_groupIconScale = 0.75;										// NUMBER. Group Icon Scale. Default = 0.75
_QS_ST_groupIconOffset = [0.65,0.65];							// ARRAY (NUMBERS). [X,Y], offset position of icon from group leaders position. Can be positive or negative numbers. Default = [0.65,0.65];
_QS_ST_groupTextFactionOnly = TRUE;								// BOOL. TRUE to show group icon text from ONLY the PLAYERS faction. FALSE will show text for all friendly/revealed factions. Default TRUE.
_QS_ST_showCivilianGroups = FALSE;								// BOOL. TRUE to show Civilian groups. Must be whitelisted above in friendlySides. Default FALSE.
_QS_ST_showOwnGroup = TRUE;									// BOOL. TRUE to show the Players own group icon. Default FALSE.
_QS_ST_GRPrequireGPSItem = FALSE;								// BOOL. TRUE to require player have GPS in his assigned items. Default FALSE.

//==================================================================================//
//============================= CONFIGURE BONUS FEATURES ===========================//
//==================================================================================//

_QS_ST_showEmptyVehicles = 2;									// NUMBER. 0 - Disabled. 1 - All empty flagged vehicles. 2 - Player-grouped vehicles only. If setting == 1, the vehicle must be assigned this variable:    <vehicle> setVariable ['QS_ST_drawEmptyVehicle',TRUE,TRUE];    Default 0.   Only works if  _QS_ST_map_enableUnitIcons = TRUE;
_QS_ST_iconColor_empty = [0.7,0.6,0,0.5];						// ARRAY (NUMBERS). Color of unoccupied vehicles, in RGBA. Default = [0.7,0.6,0,0.5];
_QS_ST_iconSize_empty = 20;										// NUMBER. Icon size of unoccupied vehicles, if shown.
_QS_ST_showKnownEnemies = TRUE && ((missionNamespace getVariable ['QS_missionConfig_mapContentEnemy',1]) isEqualTo 1);		// BOOL. TRUE to mark known enemies on the map. Default - FALSE.

//==================================================================================//
//================ TEXT (for LOCALIZATION / LANGUAGE TRANSLATION) ==================//
//==================================================================================//

missionNamespace setVariable ['QS_ST_STR_text1','Click to show group details',FALSE];				/*/ STRING. Text shown when a player passes Mouse over Group leader (only if _QS_ST_groupInteractiveIcons = TRUE;)/*/
missionNamespace setVariable ['QS_ST_STR_text2','This group is not in your faction!',FALSE];		/*/ STRING. Text shown when a player clicks on a Group Icon of other faction. (only if _QS_ST_groupInteractiveIcons = TRUE;)/*/

//==============================================================================================================================//
//=============================================================== CONFIGURATION END ============================================//
//==============================================================================================================================//
//===================================================== EDITING BELOW FOR ADVANCED USERS ONLY!!! ===============================//
//==============================================================================================================================//

_QS_fnc_isIncapacitated = {
	params ['_u'];
	((lifeState _u) isEqualTo 'INCAPACITATED')
};
_QS_fnc_iconColor = {
	params [['_v',objNull],['_ds',1],'_QS_ST_X',['_ms',1]];
	_u = effectiveCommander _v;
	_s = side (group _u);
	private _exit = FALSE;
	private _c = _QS_ST_X # 13;
	private _a = 0;
	if (
		(!(_v isKindOf 'CAManBase')) &&
		{((crew _v) isEqualTo [])} &&
		{(_v getVariable ['QS_ST_drawEmptyVehicle',FALSE])}
	) then {
		_exit = TRUE;
		_c = _QS_ST_X # 78;
		_c set [3,0.65];
		if (
			(_ds isEqualTo 1) &&
			{(_ms > 0.80)}
		) then {
			_c set [3,0];
		};
	};
	if (_exit) exitWith {_c;};
	private _useTeamColor = FALSE;
	if ((group _u) isEqualTo (group QS_player)) then {
		_useTeamColor = TRUE;
		_a = 0.85;
	} else {
		_a = 0.65;
	};
	if (_QS_ST_X # 14) then {
		if ([_u,((_QS_ST_X # 15) # 0)] call (_QS_ST_X # 69)) then {
			_exit = TRUE;
			_c = _QS_ST_X # 16;
			if (isPlayer _u) then {
				_c set [1,((_c # 1) * ((((_u getVariable ['QS_revive_downtime',serverTime]) + 600) - serverTime) / 600))];
			};
			_c set [3,_a];
			if (_ms > 0.80) then {
				if (_ds isEqualTo 1) then {
					_c set [3,0];
				};
			};
		};
	} else {
		if ([_u,((_QS_ST_X # 15) # 0)] call (_QS_ST_X # 69)) then {
			_exit = TRUE;
			_c = _QS_ST_X # 16;
			if (isPlayer _u) then {
				_c set [1,((_c # 1) * ((((_u getVariable ['QS_revive_downtime',serverTime]) + 600) - serverTime) / 600))];
			};
			_c set [3,0];
		};
	};
	if (_exit) exitWith {_c;};
	if (_useTeamColor) then {
		if (isNull (objectParent _u)) then {
			if (_s isEqualTo EAST) then {_c = _QS_ST_X # 9;};
			if (_s isEqualTo WEST) then {_c = _QS_ST_X # 10;};
			if (_s isEqualTo RESISTANCE) then {_c = _QS_ST_X # 11;};
			if (_s isEqualTo CIVILIAN) then {_c = _QS_ST_X # 12;};
			_c = [_c,_c,[1,0,0,1],[0,1,0.5,1],[0,0.5,1,1],[1,1,0,1]] # ((['','MAIN','RED','GREEN','BLUE','YELLOW'] find (assignedTeam _u)) max 1);
			_c set [3,_a];
			if (_ms > 0.80) then {
				if (_ds isEqualTo 1) then {
					_c set [3,0];
				};
			};
			_exit = TRUE;
		};
	};
	if (_exit) exitWith {_c;};
	if (_s isEqualTo EAST) exitWith {_c = _QS_ST_X # 9; _c set [3,_a];if (_ds isEqualTo 1) then {if (_ms > 0.80) then {_c set [3,0];};};_c;};
	if (_s isEqualTo WEST) exitWith {_c = _QS_ST_X # 10;_c set [3,_a];if (_ds isEqualTo 1) then {if (_ms > 0.80) then {_c set [3,0];};};_c;};
	if (_s isEqualTo RESISTANCE) exitWith {_c = _QS_ST_X # 11;_c set [3,_a];if (_ds isEqualTo 1) then {if (_ms > 0.80) then {_c set [3,0];};};_c;};
	if (_s isEqualTo CIVILIAN) exitWith {_c = _QS_ST_X # 12;_c set [3,_a];if (_ds isEqualTo 1) then {if (_ms > 0.80) then {_c set [3,0];};};_c;};
	_c = _QS_ST_X # 13;if (_ds isEqualTo 1) then { if (_ms > 0.80) then {_c set [3,0];};};_c;
};
_QS_fnc_iconType = {
	params ['_u'];
	private _vt = typeOf _u;
	private _i = '';
	if ((_u isKindOf 'CAManBase') && {(isPlayer (effectiveCommander _u))}) then {
		if ((_u getVariable ['QS_unit_role_icon',-1]) isEqualTo -1) then {
			_i = ['GET_ROLE_ICONMAP',(_u getVariable ['QS_unit_role','rifleman']),_u] call (missionNamespace getVariable 'QS_fnc_roles');
		} else {
			_i = _u getVariable ['QS_unit_role_icon','a3\ui_f\data\map\vehicleicons\iconMan_ca.paa'];
		};
	} else {
		_i = QS_hashmap_configfile getOrDefaultCall [
			format ['cfgvehicles_%1_icon',toLowerANSI _vt],
			{getText ((configOf _u) >> 'icon')},
			TRUE
		];
	};
	_i;
};
_QS_fnc_iconSize = {
	params ['_v','','_QS_ST_X'];
	private _i = missionNamespace getVariable [(format ['QS_ST_iconSize#%1',(typeOf _v)]),0];
	if (_i isEqualTo 0) then {
		if (_v isKindOf 'CAManBase') then {_i = _QS_ST_X # 22;};
		if (_v isKindOf 'LandVehicle') then {_i = _QS_ST_X # 23;};
		if (_v isKindOf 'Air') then {_i = _QS_ST_X # 25;};
		if (_v isKindOf 'StaticWeapon') then {_i = _QS_ST_X # 26;};
		if (_v isKindOf 'Ship') then {_i = _QS_ST_X # 24;};
		missionNamespace setVariable [(format ['QS_ST_iconSize#%1',(typeOf _v)]),_i,FALSE];
	};
	_i;
};
_QS_fnc_iconPosDir = {
	params ['_v','_ds','_dl'];
	private _posDir = [[0,0,0],0];
	if (_ds isEqualTo 1) then {
		if (_dl > 0) then {
			if (diag_tickTime > (missionNamespace getVariable ['QS_ST_iconUpdatePulseTimer',0])) then {
				_posDir = [getPosWorldVisual _v,getDirVisual _v];
				_v setVariable ['QS_ST_lastPulsePos',_posDir,FALSE];
			} else {
				if (!(_v isNil 'QS_ST_lastPulsePos')) then {
					_posDir = _v getVariable 'QS_ST_lastPulsePos';
				} else {
					_posDir = [getPosWorldVisual _v,getDirVisual _v];
					_v setVariable ['QS_ST_lastPulsePos',_posDir,FALSE];
				};		
			};
		} else {
			_posDir = [getPosWorldVisual _v,getDirVisual _v];
		};
	} else {
		_posDir = [getPosWorldVisual _v,getDirVisual _v];
	};
	_posDir;
};
_QS_fnc_iconText = {
	params ['_v','_ds','_QS_ST_X',['_ms',1]];
	if ((_ds isEqualTo 2) || {(!(_QS_ST_X # 67))}) exitWith {
		''
	};
	_showMOS = _QS_ST_X # 64;
	_showAINames = _QS_ST_X # 71;
	private _t = '';
	private _n = 0;
	private _vt = QS_hashmap_configfile getOrDefaultCall [
		format ['cfgvehicles_%1_displayname',toLowerANSI (typeOf _v)],
		{getText ((configOf _v) >> 'displayName')},
		TRUE
	];
	if ((_vt isEqualTo '') || {((_v isKindOf 'CAManBase') && (isPlayer _v))})  then {
		if ((_v isKindOf 'CAManBase') && (isPlayer _v)) then {
			if ((_v getVariable ['QS_unit_role_displayName',-1]) isEqualTo -1) then {
				_vt = ['GET_ROLE_DISPLAYNAME',(_v getVariable ['QS_unit_role','rifleman'])] call (missionNamespace getVariable 'QS_fnc_roles');
			} else {
				_vt = _v getVariable ['QS_unit_role_displayName','Rifleman'];
			};
		};
	};
	if ((_v getVariable ['QS_ST_customDN','']) isNotEqualTo '') then {
		_vt = _v getVariable ['QS_ST_customDN',''];
	};
	if (!(_QS_ST_X # 64)) then {
		_vt = '';
	};
	private _vn = name ((crew _v) # 0);
	if (!isPlayer ((crew _v) # 0)) then {
		if (!(_showAINames)) then {
			_vn = '[AI]';
		};
	};
	_isAdmin = ((_QS_ST_X # 86) && {((call (missionNamespace getVariable 'BIS_fnc_admin')) isEqualTo 2)});
	if (((_v distance2D QS_player) < (_QS_ST_X # 68)) || {(_isAdmin)}) then {
		if ((_ms < 0.75) || {(_isAdmin)}) then {
			if ((_ms > 0.25) || {(_isAdmin)}) then {
				if (_showMOS) then {
					_t = format ['%1 [%2]',_vn,_vt];
				} else {
					_t = format ['%1',_vn];
				};
			} else {
				if (_ms < 0.006) then {
					if (_showMOS) then {
						_t = format ['%1 [%2]',_vn,_vt];
					} else {
						_t = format ['%1',_vn];
					};
				} else {
					_t = '';
				};
			};
		} else {
			_t = '';
		};
	} else {
		if (_ms < 0.75) then {
			if (_ms > 0.25) then {
				_t = format ['%1',_vn];
			} else {
				if (_ms < 0.006) then {
					_t = format ['%1',_vn];
				} else {
					_t = '';
				};
			};
		} else {
			_t = '';
		};
	};
	if ((_v isKindOf 'LandVehicle') || {(_v isKindOf 'Air')} || {(_v isKindOf 'Ship')}) then {
		_n = 0;
		_n = (count (crew _v)) - 1;
		if (_n > 0) then {
			if (!(_v isNil 'QS_ST_mapClickShowCrew')) then {
				if (_v getVariable 'QS_ST_mapClickShowCrew') then {
					_t = '';
					private _crewIndex = 0;
					private _na = '';
					_crewCount = (count (crew _v)) - 1;
					{
						_na = name _x;
						if (!(_showAINames)) then {
							if (!isPlayer _x) then {
								_na = '[AI]';
							};
						};
						if (!(['error',_na,FALSE] call (missionNamespace getVariable 'QS_fnc_inString'))) then {
							if (_crewIndex isNotEqualTo _crewCount) then {
								_t = _t + _na + ', ';
							} else {
								_t = _t + _na;
							};
						};
						_crewIndex = _crewIndex + 1;
					} count (crew _v);
				} else {
					if (!isNull driver _v) then {
						if (_ms < 0.75) then {
							if (_ms > 0.25) then {
								if (_showMOS) then {
									_t = format ['%1 [%2] +%3',_vn,_vt,_n];
								} else {
									_t = format ['%1 +%2',_vn,_n];
								};
							} else {
								if (_ms < 0.006) then {
									if (_showMOS) then {
										_t = format ['%1 [%2] +%3',_vn,_vt,_n];
									} else {
										_t = format ['%1 +%2',_vn,_n];
									};
								} else {
									_t = format ['+%1',_n];
								};
							};
						} else {
							_t = format ['+%1',_n];
						};
					} else {
						if (_ms < 0.75) then {
							if (_ms > 0.25) then {
								if (_showMOS) then {
									_t = format ['[%1] %2 +%3',_vt,_vn,_n];
								} else {
									_t = format ['%1 +%2',_vn,_n];
								};
							} else {
								if (_ms < 0.006) then {
									if (_showMOS) then {
										_t = format ['[%1] %2 +%3',_vt,_vn,_n];
									} else {
										_t = format ['%1 +%2',_vn,_n];
									};
								} else {
									_t = format ['+%1',_n];
								};
							};
						} else {
							_t = format ['+%1',_n];
						};
					};
				};
			} else {
				if (!isNull driver _v) then {
					if (_ms < 0.75) then {
						if (_ms > 0.25) then {
							if (_showMOS) then {
								_t = format ['%1 [%2] +%3',_vn,_vt,_n];
							} else {
								_t = format ['%1 +%2',_vn,_n];
							};
						} else {
							if (_ms < 0.006) then {
								if (_showMOS) then {
									_t = format ['%1 [%2] +%3',_vn,_vt,_n];
								} else {
									_t = format ['%1 +%2',_vn,_n];
								};
							} else {
								_t = format ['+%1',_n];
							};
						};
					} else {
						_t = format ['+%1',_n];
					};
				} else {
					if (_ms < 0.75) then {
						if (_ms > 0.25) then {
							if (_showMOS) then {
								_t = format ['[%1] %2 +%3',_vt,_vn,_n];
							} else {
								_t = format ['%1 +%2',_vn,_n];
							};
						} else {
							if (_ms < 0.006) then {
								if (_showMOS) then {
									_t = format ['[%1] %2 +%3',_vt,_vn,_n];
								} else {
									_t = format ['%1 +%2',_vn,_n];
								};
							} else {
								_t = format ['+%1',_n];
							};
						};
					} else {
						_t = format ['+%1',_n];
					};
				};
			};
		} else {
			if (!isNull driver _v) then {
				if (_ms < 0.75) then {
					if (_ms > 0.25) then {
						if (_showMOS) then {
							_t = format ['%1 [%2]',_vn,_vt];
						} else {
							_t = format ['%1',_vn];
						};
					} else {
						if (_ms < 0.006) then {
							if (_showMOS) then {
								_t = format ['%1 [%2]',_vn,_vt];
							} else {
								_t = format ['%1',_vn];
							};
						} else {
							_t = '';
						};
					};
				} else {
					_t = '';
				};
			} else {
				if (_ms < 0.75) then {
					if (_ms > 0.25) then {
						if (_showMOS) then {
							_t = format ['[%1] %2',_vt,_vn];
						} else {
							_t = format ['%1',_vn];
						};
					} else {
						if (_ms < 0.006) then {
							if (_showMOS) then {
								_t = format ['[%1] %2',_vt,_vn];
							} else {
								_t = format ['%1',_vn];
							};
						} else {
							_t = '';
						};
					};
				} else {
					_t = '';
				};
			};
		};
		if (unitIsUAV _v) then {
			if (alive (remoteControlled (currentPilot _v))) then {
				_y = remoteControlled (currentPilot _v);
				if (_ms < 0.75) then {
					if (_ms > 0.25) then {
						if (_showMOS) then {
							_t = format ['%1 [%2]',name _y,_vt];
						} else {
							_t = format ['%1',name _y];
						};
					} else {
						if (_ms < 0.006) then {
							if (_showMOS) then {
								_t = format ['%1 [%2]',name _y,_vt];
							} else {
								_t = format ['%1',name _y];
							};
						} else {
							_t = '';
						};
					};
				} else {
					_t = '';
				};
			} else {
				if (isUavConnected _v) then {
					_y = (UAVControl _v) # 0;
					if (_ms < 0.75) then {
						if (_ms > 0.25) then {
							if (_showMOS) then {
								_t = format ['%1 [%2]',name _y,_vt];
							} else {
								_t = format ['%1',name _y];
							};
						} else {
							if (_ms < 0.006) then {
								if (_showMOS) then {
									_t = format ['%1 [%2]',name _y,_vt];
								} else {
									_t = format ['%1',name _y];
								};
							} else {
								_t = '';
							};
						};
					} else {
						_t = '';
					};
				} else {
					if (_ms < 0.75) then {
						if (_ms > 0.25) then {
							if (_showMOS) then {
								_t = format ['[%2] [%1]',_vt,localize 'STR_QS_Text_273'];
							} else {
								_t = format ['[%1]',localize 'STR_QS_Text_273'];
							};
						} else {
							if (_ms < 0.006) then {
								if (_showMOS) then {
									_t = format ['[%2] [%1]',_vt,localize 'STR_QS_Text_273'];
								} else {
									_t = format ['[%1]',localize 'STR_QS_Text_273'];
								};
							} else {
								_t = '';
							};
						};
					} else {
						_t = '';
					};
				};
			};
		};
	};
	_t;
};
_QS_fnc_iconUnits = {
	params ['_di','_QS_ST_X'];
	private _exit = FALSE;
	private _si = [EAST,WEST,RESISTANCE,CIVILIAN];
	private _as = [];
	private _au = [];
	private _drawnVehicles = [];
	_unk = sideUnknown;
	_pSide = QS_player getVariable ['QS_unit_side',WEST];
	_isAdmin = ((_QS_ST_X # 86) && {((call (missionNamespace getVariable 'BIS_fnc_admin')) isEqualTo 2)});
	if (_pSide isNotEqualTo CIVILIAN) then {
		if (!(_QS_ST_X # 74)) then {
			_si = [EAST,WEST,RESISTANCE];
		};
	};
	if ((_QS_ST_X # 61) > 0) exitWith {
		if ((_QS_ST_X # 61) isEqualTo 1) then {
			_au = allUnits + vehicles;
		};
		if ((_QS_ST_X # 61) isEqualTo 2) then {
			_au = entities [[],[],TRUE,TRUE];
		};
		_au;
	};
	if (((_di isEqualTo 1) && ((_QS_ST_X # 65))) && {(!(_QS_ST_X # 75))}) then {
		_exit = TRUE;
		_au = units (group QS_player);
		if ((_QS_ST_X # 80) isNotEqualTo 0) then {
			if ((_QS_ST_X # 80) isEqualTo 1) then {
				{
					if ((crew _x) isEqualTo []) then {
						if (_x getVariable ['QS_ST_drawEmptyVehicle',FALSE]) then {
							0 = _au pushBackUnique _x;
						};
					};
				} count vehicles;
			} else {
				{
					if ((crew _x) isEqualTo []) then {
						0 = _au pushBackUnique _x;
					};
				} count (assignedVehicles (group QS_player));
			};
		};
		_au;
	};
	if ((_di isEqualTo 2) && ((_QS_ST_X # 29))) then {
		_exit = TRUE;
		_au = units (group QS_player);
		_au;
	};
	if (_exit) exitWith {_au;};
	if (_QS_ST_X # 62) then {
		_as pushBack _pSide;
	} else {
		if (isMultiplayer) then {
			if (_isAdmin) then {
				{
					_as pushBack _x;
				} forEach _si;
			} else {
				_as pushBack _pSide;
				{
					if ((_pSide getFriend _x) > 0.6) then {
						_as pushBackUnique _x;
					};
				} forEach _si;
			};
		} else {
			_as pushBack _pSide;
			{
				if ((_pSide getFriend _x) > 0.6) then {
					_as pushBack _x;
				};
			} forEach _si;
		};		
	};
	if (!(_QS_ST_X # 63)) then {
		if (isMultiplayer) then {
			if (_isAdmin) then {
				{
					if (
						(isNull (objectParent _x)) ||
						{(_x in [effectiveCommander (vehicle _x),currentPilot (vehicle _x)])} ||
						{(_x isEqualTo ((crew (objectParent _x)) # 0))}
					) then {
						if ((isNull (objectParent _x)) || {(!((objectParent _x) in _drawnVehicles))}) then {
							_au pushBack _x;
							if (!isNull (objectParent _x)) then {
								_drawnVehicles pushBackUnique (objectParent _x);	
							};
						};
					};
				} forEach allUnits;
			} else {
				{
					if (
						((side (group _x)) in _as) || 
						{((_x getVariable ['QS_unit_side',_unk]) isEqualTo _pSide)} ||
						{((captive _x) && ((lifeState _x) isNotEqualTo 'INCAPACITATED'))}
					) then {
						if (isPlayer _x) then {
							if (_di isEqualTo 2) then {
								if ((_x distance2D QS_player) < (_QS_ST_X # 27)) then {
									if (
										(isNull (objectParent _x)) ||
										{(_x in [effectiveCommander (vehicle _x),currentPilot (vehicle _x)])} ||
										{(_x isEqualTo ((crew (objectParent _x)) # 0))}
									) then {
										if (!((vehicle _x) getVariable ['QS_hidden',FALSE])) then {
											if ((isNull (objectParent _x)) || {(!((objectParent _x) in _drawnVehicles))}) then {
												0 = _au pushBack _x;
												if (!isNull (objectParent _x)) then {
													0 = _drawnVehicles pushBackUnique (objectParent _x);	
												};
											};
										};
									};
								};
							} else {
								if (
									(isNull (objectParent _x)) ||
									{(_x in [effectiveCommander (vehicle _x),currentPilot (vehicle _x)])} ||
									{(_x isEqualTo ((crew (objectParent _x)) # 0))}
								) then {
									if (!((vehicle _x) getVariable ['QS_hidden',FALSE])) then {
										if ((isNull (objectParent _x)) || {(!((objectParent _x) in _drawnVehicles))}) then {
											0 = _au pushBack _x;
											if (!isNull (objectParent _x)) then {
												0 = _drawnVehicles pushBackUnique (objectParent _x);	
											};
										};
									};
								};
							};
						};
					};
				} count (allPlayers + allUnitsUav);
			};
		} else {
			{
				if (
					((side (group _x)) in _as) ||
					{((_x getVariable ['QS_unit_side',_unk]) isEqualTo _pSide)} ||
					{((captive _x) && ((lifeState _x) isNotEqualTo 'INCAPACITATED'))}
				) then {
					if (isPlayer _x) then {
						if (_di isEqualTo 2) then {
							if ((_x distance2D QS_player) < (_QS_ST_X # 27)) then {
								if (
									(isNull (objectParent _x)) ||
									{(_x in [effectiveCommander (vehicle _x),currentPilot (vehicle _x)])} ||
									{(_x isEqualTo ((crew (objectParent _x)) # 0))}
								) then {
									if (!((vehicle _x) getVariable ['QS_hidden',FALSE])) then {
										if ((isNull (objectParent _x)) || {(!((objectParent _x) in _drawnVehicles))}) then {
											0 = _au pushBack _x;
											if (!isNull (objectParent _x)) then {
												0 = _drawnVehicles pushBackUnique (objectParent _x);	
											};
										};
									};
								};
							};
						} else {
							if (
								(isNull (objectParent _x)) ||
								{(_x in [effectiveCommander (vehicle _x),currentPilot (vehicle _x)])} ||
								{(_x isEqualTo ((crew (objectParent _x)) # 0))}
							) then {
								if (!((vehicle _x) getVariable ['QS_hidden',FALSE])) then {
									if ((isNull (objectParent _x)) || {(!((objectParent _x) in _drawnVehicles))}) then {
										0 = _au pushBack _x;
										if (!isNull (objectParent _x)) then {
											0 = _drawnVehicles pushBackUnique (objectParent _x);	
										};
									};
								};
							};
						};
					};
				};
			} count (allPlayers + allUnitsUav);
		};
	} else {
		{
			if (
				((side (group _x)) in _as) ||
				{((_x getVariable ['QS_unit_side',_unk]) isEqualTo _pSide)} ||
				{((captive _x) && ((lifeState _x) isNotEqualTo 'INCAPACITATED'))}
			) then {
				if (_di isEqualTo 2) then {
					if ((_x distance2D QS_player) < (_QS_ST_X # 27)) then {
						if (
							(isNull (objectParent _x)) ||
							{(_x in [effectiveCommander (vehicle _x),currentPilot (vehicle _x)])} ||
							{(_x isEqualTo ((crew (objectParent _x)) # 0))}
						) then {
							if (!((vehicle _x) getVariable ['QS_hidden',FALSE])) then {
								if ((isNull (objectParent _x)) || {(!((objectParent _x) in _drawnVehicles))}) then {
									0 = _au pushBack _x;
									if (!isNull (objectParent _x)) then {
										0 = _drawnVehicles pushBackUnique (objectParent _x);	
									};
								};
							};
						};
					};
				} else {
					if (!((vehicle _x) getVariable ['QS_hidden',FALSE])) then {
						if ((isNull (objectParent _x)) || {(!((objectParent _x) in _drawnVehicles))}) then {
							0 = _au pushBack _x;
							if (!isNull (objectParent _x)) then {
								0 = _drawnVehicles pushBackUnique (objectParent _x);	
							};
						};
					};
				};
			};
		} count allUnits;
	};
	if ((_di isEqualTo 1) && (_QS_ST_X # 75)) exitWith {
		_auv = [];
		{
			if (!((vehicle _x) isKindOf 'CAManBase')) then {
				0 = _auv pushBack _x;
			};
		} count _au;
		if ((_QS_ST_X # 80) isNotEqualTo 0) then {
			if ((_QS_ST_X # 80) isEqualTo 1) then {
				{
					if ((crew _x) isEqualTo []) then {
						if (_x getVariable ['QS_ST_drawEmptyVehicle',FALSE]) then {
							0 = _auv pushBackUnique _x;
						};
					};
				} count vehicles;
			} else {
				{
					if ((crew _x) isEqualTo []) then {
						0 = _auv pushBackUnique _x;
					};
				} count (assignedVehicles (group QS_player));
			};
		};
		if (_QS_ST_X # 65) then {
			{
				0 = _auv pushBack _x;
			} count (units (group QS_player));
		};
		_auv;
	};
	if ((_di isEqualTo 1) && {((_QS_ST_X # 80) isNotEqualTo 0)}) exitWith {
		if ((_QS_ST_X # 80) isEqualTo 1) then {
			{
				if ((crew _x) isEqualTo []) then {
					if (_x getVariable ['QS_ST_drawEmptyVehicle',FALSE]) then {
						0 = _au pushBackUnique _x;
					};
				};
			} count vehicles;
		} else {
			{
				if ((crew _x) isEqualTo []) then {
					0 = _au pushBackUnique _x;
				};
			} count (assignedVehicles (group QS_player));
		};
		_au;
	};
	_au;
};
_QS_fnc_onMapSingleClick = {
	params ['_units','_position','_alt','_shift'];
	if ((!(_alt)) && (!(_shift))) then {
		if (QS_player getVariable ['QS_ST_mapSingleClick',FALSE]) then {
			QS_player setVariable ['QS_ST_mapSingleClick',FALSE,FALSE];
			if (alive (QS_player getVariable ['QS_ST_map_vehicleShowCrew',objNull])) then {
				(QS_player getVariable ['QS_ST_map_vehicleShowCrew',objNull]) setVariable ['QS_ST_mapClickShowCrew',FALSE,FALSE];
			};
		};
		QS_player setVariable ['QS_ST_mapSingleClick',TRUE,FALSE];
		private _vehicle = objNull;
		_vehicles = (nearestObjects [_position,['Air','LandVehicle','Ship'],250,TRUE]) select {(alive _x)};
		if ((count _vehicles) > 0) then {
			if ((count _vehicles) > 1) then {
				private _dist = 999999;
				{
					if ((_x distance2D _position) < _dist) then {
						_dist = _x distance2D _position;
						_vehicle = _x;
					};
				} forEach _vehicles;
			} else {
				_vehicle = _vehicles # 0;
			};
		};
		_QS_ST_X = call (missionNamespace getVariable 'QS_ST_X');
		if (
			(alive _vehicle) &&
			{((count (crew _vehicle)) > 1)} &&
			{((side (effectiveCommander _vehicle)) isEqualTo (QS_player getVariable ['QS_unit_side',WEST]))} &&
			{(_vehicle isNotEqualTo (QS_player getVariable ['QS_ST_map_vehicleShowCrew',objNull]))}
		) then {
			QS_player setVariable ['QS_ST_map_vehicleShowCrew',_vehicle,FALSE];
			_vehicle setVariable ['QS_ST_mapClickShowCrew',TRUE,FALSE];
		} else {
			(QS_player getVariable ['QS_ST_map_vehicleShowCrew',objNull]) setVariable ['QS_ST_mapClickShowCrew',FALSE,FALSE];
			QS_player setVariable ['QS_ST_map_vehicleShowCrew',objNull,FALSE];
			QS_player setVariable ['QS_ST_mapSingleClick',FALSE,FALSE];
		};
	};
	if (_shift) then {
		if (QS_player isEqualTo (leader (group QS_player))) then {
			private _nearUnit = objNull;
			_nearUnits = (nearestObjects [_position,['CAManBase'],250,TRUE]) select {((alive _x) && ((group _x) isEqualTo (group QS_player)) && (isNull (objectParent _x)))};
			if (_nearUnits isNotEqualTo []) then {
				if ((count _nearUnits) > 1) then {
					private _dist = 999999;
					{
						if ((_x distance2D _position) < _dist) then {
							_dist = _x distance2D _position;
							_nearUnit = _x;
						};
					} forEach _nearUnits;
				} else {
					_nearUnit = _nearUnits # 0;
				};
			};
			if (alive _nearUnit) then {
				QS_player groupSelectUnit [_nearUnit,(!(_nearUnit in _units))];
			};
		};
	};
};
_QS_fnc_mapVehicleShowCrew = {};
_QS_fnc_iconDrawMap = {
	params ['_m'];
	_QS_ST_X = call (missionNamespace getVariable 'QS_ST_X');
	if ((_QS_ST_X # 83) && ((QS_player getSlotItemName 612) isEqualTo '')) exitWith {};
	_player = missionNamespace getVariable ['bis_fnc_moduleRemoteControl_unit',player];
	_fn_jammer = missionNamespace getVariable 'QS_fnc_gpsJammer';
	_gpsJammers = missionNamespace getVariable ['QS_mission_gpsJammers',[]];
	if (diag_tickTime > (missionNamespace getVariable 'QS_ST_updateDraw_map')) then {
		missionNamespace setVariable ['QS_ST_updateDraw_map',(diag_tickTime + 5),FALSE];
		missionNamespace setVariable ['QS_ST_drawArray_map',([1,_QS_ST_X] call (_QS_ST_X # 46)),FALSE];
		if (_QS_ST_X # 35) then {
			missionNamespace setVariable ['QS_ST_drawArrayEnemy_map',([([0,1] select (QS_player getUnitTrait 'QS_trait_HQ')),_QS_ST_X,(_QS_ST_X # 43),_fn_jammer,_gpsJammers] call (missionNamespace getVariable 'QS_fnc_getKnownEnemies')),FALSE];
		};
	};
	_sh = _QS_ST_X # 17;
	_ts = _QS_ST_X # 19;
	_tf = _QS_ST_X # 60;
	_to = _QS_ST_X # 21;
	_de = _QS_ST_X # 66;
	_fn_po = _QS_ST_X # 44;
	_fn_is = _QS_ST_X # 43;
	_fn_it = _QS_ST_X # 42;
	_fn_ic = _QS_ST_X # 41;
	_fn_ite = _QS_ST_X # 45;
	if ((missionNamespace getVariable 'QS_ST_drawArrayEnemy_map') isNotEqualTo []) then {
		{
			_m drawIcon _x;
		} count (missionNamespace getVariable ['QS_ST_drawArrayEnemy_map',[]]);
	};
	_ms = ctrlMapScale _m;
	private _ve = objNull;
	private _po = [[0,0,0],0];
	private _is = 0;
	_inJammerArea = missionNamespace getVariable ['QS_module_gpsJammer_inArea',FALSE];
	if ((missionNamespace getVariable 'QS_ST_drawArray_map') isNotEqualTo []) then {
		{
			if (!isNull _x) then {
				_ve = vehicle _x;
				if (alive _ve) then {
					if (!(_ve getVariable ['QS_hidden',FALSE])) then {
						if (
							(_gpsJammers isEqualTo []) || 
							{!_inJammerArea}
						) then {
							_po = [_ve,1,_de] call _fn_po;
							_is = [_ve,1,_QS_ST_X] call _fn_is;
							if (_ve isEqualTo (vehicle QS_player)) then {
								_m drawIcon ['a3\ui_f\data\igui\cfg\islandmap\iconplayer_ca.paa',[1,0,0,0.666],(_po # 0),24,24,(_po # 1),'',0,0.03,_tf,_to];
							};
							_m drawIcon [
								([_ve,1,_QS_ST_X] call _fn_it),
								([_ve,1,_QS_ST_X,_ms] call _fn_ic),
								(_po # 0),
								_is,
								_is,
								(_po # 1),
								([_ve,1,_QS_ST_X,_ms] call _fn_ite),
								_sh,
								_ts,
								_tf,
								_to
							];
						};
					};
				};
			};
		} count (missionNamespace getVariable ['QS_ST_drawArray_map',[]]);
	};
	_grp = group QS_player;
	_grpLeader = leader _grp;
	if (_grp getVariable ['QS_HComm_grp',FALSE]) then {
		if ((waypoints _grp) isNotEqualTo []) then {
			_grpWaypoints = waypoints _grp;
			private _wpType = '';
			private _wpIcon = '';
			private _wpTypeName = '';
			for '_i' from 0 to ((count _grpWaypoints) - 1) step 1 do {
				if ((waypointPosition [_grp,_i]) isNotEqualTo [0,0,0]) then {
					if (_i isEqualTo 0) then {
						_m drawLine [
							(getPosWorldVisual (vehicle _grpLeader)),
							(waypointPosition [_grp,_i]),
							[0,0,0,0.6]
						];
					} else {
						_m drawLine [
							(waypointPosition [_grp,_i]),
							(waypointPosition [_grp,(_i - 1)]),
							[0,0,0,0.6]
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
						[0,0,0,0.6],
						(waypointPosition [_grp,_i]),
						26,
						26,
						0,
						_wpTypeName,
						0,
						0.04,
						'RobotoCondensed',
						'left'
					];
				};
			};
		};
	};
	_grpWPPos = _grp getVariable ['QS_GRP_waypoint',[]];
	if (_grpWPPos isNotEqualTo []) then {
		_m drawIcon [
			'A3\3DEN\Data\CfgWaypoints\Move_ca.paa',
			[1,1,1,0.6],
			_grpWPPos,
			([24,1] select (QS_player isEqualTo _grpLeader)),
			([24,1] select (QS_player isEqualTo _grpLeader)),
			0,
			groupId _grp,
			2,
			0.04,
			'RobotoCondensed',
			'right'
		];
	};
	if (!_inJammerArea) then {
		if (QS_player isEqualTo _grpLeader) then {
			if ((groupSelectedUnits QS_player) isNotEqualTo []) then {
				{
					_m drawLine [(getPosWorldVisual QS_player),(getPosWorldVisual (vehicle _x)),[0,1,1,0.5]];
				} count (groupSelectedUnits QS_player);
			};
		} else {
			if (
				(isNull (objectParent QS_player)) &&
				{(isNull (objectParent _grpLeader))} &&
				{((_grpLeader distance2D QS_player) < (_QS_ST_X # 27))}
			) then {
				_m drawLine [(getPosWorldVisual QS_player),(getPosWorldVisual _grpLeader),[0,1,1,0.5]];
			};
		};
	};
	if (_de > 0) then {
		if (diag_tickTime > (missionNamespace getVariable 'QS_ST_iconUpdatePulseTimer')) then {
			missionNamespace setVariable ['QS_ST_iconUpdatePulseTimer',(diag_tickTime + _de)];
		};
	};
	if ((missionNamespace getVariable ['QS_draw2D_projectiles',[]]) isNotEqualTo []) then {
		_deg = ((ceil diag_tickTime) - diag_tickTime) * 360;
		{
			if (_x isEqualType objNull) then {
				if (!isNull _x) then {
					_m drawIcon [
						'a3\ui_f\data\igui\cfg\cursors\explosive_ca.paa',
						[1,0,0,0.75],
						(getPosWorldVisual _x),
						13,
						13,
						_deg,
						'',
						0,
						0,
						'RobotoCondensed',
						'right'
					];
				};
			};
		} forEach (missionNamespace getVariable 'QS_draw2D_projectiles');
	};
	if ((missionNamespace getVariable ['QS_client_customDraw2D',[]]) isNotEqualTo []) then {
		{
			if (_x isEqualType []) then {
				if ((_x # 1) isEqualTo 'ICON') exitWith {
					_m drawIcon (_x # 2);
				};
				if ((_x # 1) isEqualTo 'ELLIPSE') exitWith {
					_m drawEllipse (_x # 2);
				};
				if ((_x # 1) isEqualTo 'RECTANGLE') exitWith {
					_m drawRectangle (_x # 2);
				};
				if ((_x # 1) isEqualTo 'POLYGON') exitWith {
					_m drawPolygon (_x # 2);
				};
				if ((_x # 1) isEqualTo 'TRIANGLE') exitWith {
					_m drawTriangle (_x # 2);
				};
				if ((_x # 1) isEqualTo 'LOCATION') exitWith {
					_m drawLocation (_x # 2);
				};
				if ((_x # 1) isEqualTo 'LINE') exitWith {
					_m drawLine (_x # 2);
				};
				if ((_x # 1) isEqualTo 'ARROW') exitWith {
					_m drawArrow (_x # 2);
				};
			};
		} forEach (missionNamespace getVariable 'QS_client_customDraw2D');
	};
	if (_gpsJammers isNotEqualTo []) then {
		if (_inJammerArea) then {
			{
				if (_x # 6) then {
					_m drawEllipse [(_x # 2),(_x # 3),(_x # 3),0,[0.1,0.1,0.1,1],'#(rgb,8,8,3)color(0.6,0.6,0.6,1)'];
				};
			} forEach _gpsJammers;
		};
		{
			_m drawIcon ['iconMan',[1,1,1,1],(_x # 2),0,0,0,(format ['%1   ',localize 'STR_QS_Task_031']),2,0.04,'TahomaB','left'];
		} forEach _gpsJammers;
	};
};
_QS_fnc_iconDrawGPS = {
	params ['_m'];
	_QS_ST_X = call (missionNamespace getVariable 'QS_ST_X');
	_mapDir = ctrlMapDir _m;
	if (
		(!('MinimapDisplay' in ((infoPanel 'left') + (infoPanel 'right')))) ||
		{(visibleMap)} ||
		{((_QS_ST_X # 84) && ((QS_player getSlotItemName 612) isEqualTo ''))}
	) exitWith {};
	_gpsJammers = missionNamespace getVariable ['QS_mission_gpsJammers',[]];
	_fn_jammer = missionNamespace getVariable 'QS_fnc_gpsJammer';
	if (diag_tickTime > (missionNamespace getVariable 'QS_ST_updateDraw_gps')) then {
		missionNamespace setVariable ['QS_ST_updateDraw_gps',(diag_tickTime + 3),FALSE];
		missionNamespace setVariable ['QS_ST_drawArray_gps',([2,_QS_ST_X] call (_QS_ST_X # 46)),FALSE];
	};
	_inJammerArea = missionNamespace getVariable ['QS_module_gpsJammer_inArea',FALSE];
	if ((missionNamespace getVariable 'QS_ST_drawArray_gps') isNotEqualTo []) then {
		_sh = _QS_ST_X # 18;
		_ts = _QS_ST_X # 20;
		_tf = _QS_ST_X # 60;
		_to = _QS_ST_X # 21;
		_de = _QS_ST_X # 66;
		_fn_po = _QS_ST_X # 44;
		_fn_is = _QS_ST_X # 43;
		_fn_it = _QS_ST_X # 42;
		_fn_ic = _QS_ST_X # 41;
		_fn_ite = _QS_ST_X # 45;
		private _ve = objNull;
		private _po = [[0,0,0],0];
		private _is = 0;
		{
			if (!isNull _x) then {
				_ve = vehicle _x;
				if (alive _ve) then {
					if (!(_ve getVariable ['QS_hidden',FALSE])) then {
						if (
							(_gpsJammers isEqualTo []) || 
							{!_inJammerArea}
						) then {
							_po = [_ve,2,_de] call _fn_po;
							_is = [_ve,2,_QS_ST_X] call _fn_is;
							_m drawIcon [
								([_ve,2,_QS_ST_X] call _fn_it),
								([_ve,2,_QS_ST_X] call _fn_ic),
								(_po # 0),
								_is,
								_is,
								_mapDir + (_po # 1),
								([_ve,2,_QS_ST_X] call _fn_ite),
								_sh,
								_ts,
								_tf,
								_to
							];
						};
					};
				};
			};
		} count (missionNamespace getVariable ['QS_ST_drawArray_gps',[]]);
	};
	if (!_inJammerArea) then {
		if (QS_player isEqualTo (leader (group QS_player))) then {
			if ((groupSelectedUnits QS_player) isNotEqualTo []) then {
				{
					_m drawLine [(getPosWorldVisual QS_player),(getPosWorldVisual (vehicle _x)),[0,1,1,0.5]];
				} count (groupSelectedUnits QS_player);
			};
		} else {
			if (
				(isNull (objectParent QS_player)) &&
				{(isNull (objectParent (leader (group QS_player))))} &&
				{(((leader (group QS_player)) distance2D QS_player) < (_QS_ST_X # 27))}
			) then {
				_m drawLine [(getPosWorldVisual QS_player),(getPosWorldVisual (leader (group QS_player))),[0,1,1,0.5]];
			};
		};
	};
	if (_gpsJammers isNotEqualTo []) then {
		if (_inJammerArea) then {
			{
				if (_x # 6) then {
					_m drawEllipse [(_x # 2),(_x # 3),(_x # 3),0,[0.1,0.1,0.1,1],'#(rgb,8,8,3)color(0.6,0.6,0.6,1)'];
				};
			} forEach _gpsJammers;
		};
	};
};
_QS_fnc_groupIconText = {
	params ['_grp','_QS_ST_X','_di'];
	private _text = '';
	if (_di isEqualTo 1) then {
		if (_QS_ST_X # 36) then {
			if ((leader _grp) isEqualTo (effectiveCommander (vehicle (leader _grp)))) then {
				_text = groupId _grp;
			} else {
				_text = '';
			};
		};
	};
	_text;
};
_QS_fnc_groupIconType = {
	params ['_grp','_grpSize','_grpVehicle','_grpSide'];
	_grpVehicle_type = typeOf _grpVehicle;
	_vehicleClass = _grpVehicle getVariable ['QS_ST_groupVehicleClass',''];
	if (_vehicleClass isEqualTo '') then {
		_vehicleClass = getText ((configOf _grpVehicle) >> 'vehicleClass');
		_grpVehicle setVariable ['QS_ST_groupVehicleClass',_vehicleClass];
	};
	private _iconType = _grpVehicle getVariable ['QS_ST_groupVehicleIconType',''];
	if (_iconType isNotEqualTo '') exitWith {
		_iconType;
	};
	_iconTypes_EAST = ['o_inf','o_motor_inf','o_mech_inf','o_armor','o_recon','o_air','o_plane','o_uav','o_med','o_art','o_mortar','o_hq','o_support','o_maint','o_service','o_naval','o_unknown','o_antiair'];
	_iconTypes_WEST = ['b_inf','b_motor_inf','b_mech_inf','b_armor','b_recon','b_air','b_plane','b_uav','b_med','b_art','b_mortar','b_hq','b_support','b_maint','b_service','b_naval','b_unknown','b_antiair'];
	_iconTypes_RESISTANCE = ['n_inf','n_motor_inf','n_mech_inf','n_armor','n_recon','n_air','n_plane','n_uav','n_med','n_art','n_mortar','n_hq','n_support','n_maint','n_service','n_naval','n_unknown','n_antiair'];
	_iconTypes_CIVILIAN = ['c_air','c_car','c_plane','c_ship','c_unknown'];
	private _iconTypes = [];
	_iconType = 'c_unknown';
	if (_grpSide isEqualTo EAST) then {
		_iconType = 'o_unknown';
		_iconTypes = _iconTypes_EAST;
	};
	if (_grpSide isEqualTo WEST) then {
		_iconType = 'b_unknown';
		_iconTypes = _iconTypes_WEST;
	};
	if (_grpSide isEqualTo RESISTANCE) then {
		_iconType = 'n_unknown';
		_iconTypes = _iconTypes_RESISTANCE;
	};
	if (_grpSide isEqualTo CIVILIAN) exitWith {
		_iconType = 'c_unknown';
		_iconTypes = _iconTypes_CIVILIAN;
		if (_grpVehicle isKindOf 'Helicopter') then {
			_iconType = _iconTypes # 0;
		};
		if (_grpVehicle isKindOf 'LandVehicle') then {
			_iconType = _iconTypes # 1;
		};
		if (_grpVehicle isKindOf 'Plane') then {
			_iconType = _iconTypes # 2;
		};
		if (_grpVehicle isKindOf 'Ship') then {
			_iconType = _iconTypes # 3;
		};
		if (_grpVehicle isKindOf 'CAManBase') then {
			_iconType = _iconTypes # 4;
		};
		_grpVehicle setVariable ['QS_ST_groupVehicleIconType',_iconType,FALSE];
		_iconType;
	};
	if ((_vehicleClass isEqualTo 'Ship') || {(_vehicleClass isEqualTo 'Submarine')}) exitWith {
		_iconType = _iconTypes # 15; 
		_iconType;
	};
	if (_vehicleClass in ['Men','MenRecon','MenSniper','MenDiver','MenSupport','MenUrban','MenStory']) exitWith {
		_iconType = _iconTypes # 0;
		if (_vehicleClass isEqualTo 'Men') then {
			_iconType = _iconTypes # 0;
		};
		if (_vehicleClass in ['MenRecon','MenSniper','MenDiver']) then {
			_iconType = _iconTypes # 4;
		};
		if (['medic',_grpVehicle_type,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) then {
			_iconType = _iconTypes # 8;
		};
		_grpVehicle setVariable ['QS_ST_groupVehicleIconType',_iconType,FALSE];
		_iconType;
	};
	if (_vehicleClass isEqualTo 'StaticWeapon') exitWith {
		if (['mortar',_grpVehicle_type,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) then {
			_iconType = _iconTypes # 10; 
		} else {
			if (['_aa_',_grpVehicle_type,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) then {
				_iconType = _iconTypes # 17; 
			} else {
				_iconType = _iconTypes # 12;
			};
		};
		_grpVehicle setVariable ['QS_ST_groupVehicleIconType',_iconType,FALSE];
		_iconType;
	};
	if (_vehicleClass isEqualTo 'Autonomous') exitWith {
		if (['UAV',_grpVehicle_type,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) then {
			_iconType = _iconTypes # 7; 
		} else {
			if (['UGV',_grpVehicle_type,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) then {
				_iconType = _iconTypes # 12;
			} else {
				if ((['SAM',_grpVehicle_type,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) || (['AAA',_grpVehicle_type,FALSE] call (missionNamespace getVariable 'QS_fnc_inString'))) then {
					_iconType = _iconTypes # 12;
				};
			};
		};
		_grpVehicle setVariable ['QS_ST_groupVehicleIconType',_iconType,FALSE];
		_iconType;
	};
	if (_vehicleClass isEqualTo 'Air') exitWith {
		if (_grpVehicle isKindOf 'Helicopter') then {
			_iconType = _iconTypes # 5; 
		} else {
			_iconType = _iconTypes # 6; 
		};
		_grpVehicle setVariable ['QS_ST_groupVehicleIconType',_iconType,FALSE];
		_iconType;
	};
	if (_vehicleClass isEqualTo 'Armored') exitWith {
		if ((['apc',_grpVehicle_type,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) || {(['afv_',_grpVehicle_type,FALSE] call (missionNamespace getVariable 'QS_fnc_inString'))}) then {
			_iconType = _iconTypes # 2; 
		} else {
			if ((['arty',_grpVehicle_type,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) || {(['mlrs',_grpVehicle_type,FALSE] call (missionNamespace getVariable 'QS_fnc_inString'))}) then {
				_iconType = _iconTypes # 9; 
			} else {
				if (['mbt',_grpVehicle_type,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) then {
					_iconType = _iconTypes # 3; 
				} else {
					if (['_aa_',_grpVehicle_type,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) then {
						_iconType = _iconTypes # 17; 
					};
				};
			};
		};
		_grpVehicle setVariable ['QS_ST_groupVehicleIconType',_iconType,FALSE];
		_iconType;
	};
	if (_vehicleClass isEqualTo 'Car') exitWith {
		_iconType = _iconTypes # 1; 
		_grpVehicle setVariable ['QS_ST_groupVehicleIconType',_iconType,FALSE];
		_iconType;
	};
	if (_vehicleClass isEqualTo 'Support') exitWith {
		if (['medical',_grpVehicle_type,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) then {
			_iconType = _iconTypes # 8; 
		} else {
			if ((['ammo',_grpVehicle_type,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) || {(['box',_grpVehicle_type,FALSE] call (missionNamespace getVariable 'QS_fnc_inString'))} || {(['fuel',_grpVehicle_type,FALSE] call (missionNamespace getVariable 'QS_fnc_inString'))} || {(['CRV',_grpVehicle_type,FALSE] call (missionNamespace getVariable 'QS_fnc_inString'))} || {(['repair',_grpVehicle_type,FALSE] call (missionNamespace getVariable 'QS_fnc_inString'))}) then {
				_iconType = _iconTypes # 14; 
			};
		};
		_grpVehicle setVariable ['QS_ST_groupVehicleIconType',_iconType,FALSE];
		_iconType;
	};
	_grpVehicle setVariable ['QS_ST_groupVehicleIconType',_iconType,FALSE];
	_iconType;
};
_QS_fnc_configGroupIcon = {
	params ['_grp','_type','_QS_ST_X'];
	private _scale = 0;
	private _text = '';
	private _visibility = TRUE;
	private _grpIconColor = [0,0,0,0];
	private _iconID = -1;
	private _grpIconType = 'c_unknown';
	_grpLeader = leader _grp;
	_grpLeader_vehicle = vehicle _grpLeader;
	_grpLeader_vType = typeOf _grpLeader_vehicle;
	_grpSize = count (units _grp);
	_grpSide = side _grpLeader;
	if (_type isEqualTo 0) then {
		_grpIconType = [_grp,_grpSize,_grpLeader_vehicle,_grpSide] call (_QS_ST_X # 52);		
		_grp setVariable ['QS_ST_Group',1,FALSE];
		_iconID = _grp addGroupIcon [_grpIconType,(_QS_ST_X # 38)];
		_grp setGroupIcon [_iconID,_grpIconType];
		_grpIconColor = [_grpLeader,_QS_ST_X] call (_QS_ST_X # 77);
		_text = [_grp,_QS_ST_X,1] call (_QS_ST_X # 51);
		_scale = (_QS_ST_X # 37);
		_visibility = TRUE;
		_grp setGroupIconParams [_grpIconColor,_text,_scale,_visibility];
		_grp setVariable ['QS_ST_Group_Icon',[_iconID,_grpIconType,_grpLeader_vType,_grpIconColor,_text,_scale,_visibility],FALSE];
	};
	if (_type isEqualTo 1) then {
		private _update = FALSE;
		private _updateIcon = FALSE;
		private _updateParams = FALSE;
		_iconDetail = _grp getVariable 'QS_ST_Group_Icon';
		_iconDetail params ['_iconID','_grpIconType','_grpLeaderType','','_text','_scale','_visibility'];
		if (_grpLeaderType isNotEqualTo (typeOf _grpLeader_vehicle)) then {
			_update = TRUE;
			_updateIcon = TRUE;
		};
		if (_text isNotEqualTo ([_grp,_QS_ST_X,1] call (_QS_ST_X # 51))) then {
			_update = TRUE;
			_updateParams = TRUE;
		};
		if (_update) then {
			_grpIconColor = [_grpLeader_vehicle,_QS_ST_X] call (_QS_ST_X # 77);
			if (_updateIcon) then {
				_grpIconType = [_grp,_grpSize,_grpLeader_vehicle,_grpSide] call (_QS_ST_X # 52);	
				_grp setGroupIcon [_iconID,_grpIconType];
			};
			if (_updateParams) then {
				_text = [_grp,_QS_ST_X,1] call (_QS_ST_X # 51);
				_grp setGroupIconParams [_grpIconColor,_text,_scale,_visibility];
			};
			_grp setVariable ['QS_ST_Group_Icon',[_iconID,_grpIconType,_grpLeader_vType,_grpIconColor,_text,_scale,_visibility],FALSE];
		};
	};
	if (_type isEqualTo 2) then {
		_grpIconArray = _grp getVariable 'QS_ST_Group_Icon';
		_grpID = _grpIconArray # 0;
		clearGroupIcons _grp;
		_grp setVariable ['QS_ST_Group_Icon',nil,FALSE];
		_grp setVariable ['QS_ST_Group',nil,FALSE];
	};
	true;
};
_QS_fnc_iconColorGroup = {
	params ['_v','_QS_ST_X'];
	_u = effectiveCommander _v;
	_ps = side _u;
	private _c = [0,0,0,0];
	if (_ps isEqualTo EAST) exitWith {_c = _QS_ST_X # 9; _u setVariable ['QS_ST_groupIconColor',[_c,_ps],FALSE];_c;};
	if (_ps isEqualTo WEST) exitWith {_c = _QS_ST_X # 10; _u setVariable ['QS_ST_groupIconColor',[_c,_ps],FALSE];_c;};
	if (_ps isEqualTo RESISTANCE) exitWith {_c = _QS_ST_X # 11; _u setVariable ['QS_ST_groupIconColor',[_c,_ps],FALSE];_c;};
	if (_ps isEqualTo CIVILIAN) exitWith {_c = _QS_ST_X # 12; _u setVariable ['QS_ST_groupIconColor',[_c,_ps],FALSE];_c;};
	_c = _QS_ST_X # 13;
	_u setVariable ['QS_ST_groupIconColor',[_c,_ps],FALSE];
	_c;
};
_QS_fnc_onGroupIconClick = {
	scriptName 'QS_ST_onGroupIconClick';
	params ['_is3D','_group','_wpID','_button','_posx','_posy','_shift','_ctrl','_alt'];
	if (!isNull (objectParent (leader _group))) exitWith {};
	if ((side _group) isNotEqualTo (QS_player getVariable ['QS_unit_side',WEST])) exitWith {
		[QS_ST_STR_text2] call (missionNamespace getVariable 'QS_fnc_hint');
		0 spawn {uiSleep 3;[''] call (missionNamespace getVariable 'QS_fnc_hint');};
	};
	_QS_ST_X = call (missionNamespace getVariable 'QS_ST_X');
	private _lifeState = '';
	private _unitMOS = '';
	private _unitName = '';
	private _color = [0,0,0,1];
	private _colorIncapacitated = [1,0.41,0,1];
	private _colorInjured = [0,0,0,1];
	private _colorDead = [0.4,0,0.5,0.65];
	_text = [_group,_QS_ST_X,1] call (_QS_ST_X # 51);
	_groupCount = count (units _group);
	private _unitNameList = '';
	_leader = TRUE;
	if ((_QS_ST_X # 14)) then {
		_colorIncapacitated = _QS_ST_X # 70;
		_colorInjured = _QS_ST_X # 81;
		_colorDead = [0.4,0,0.5,0.65];
	} else {
		_colorIncapacitated = [1,0.41,0,1];
		_colorInjured = [0,0,0,1];
		_colorDead = [0.4,0,0.5,0.65];	
	};
	_showClass = _QS_ST_X # 34;
	_AINames = _QS_ST_X # 72;
	{
		_color = [0,0,0,1];
		_lifeState = lifeState _x;
		if (_lifeState isEqualTo 'INJURED') then {
			_color = _colorInjured;
		} else {
			if (_lifeState isEqualTo 'INCAPACITATED') then {
				_color = _colorIncapacitated;
			} else {
				if (_lifeState isEqualTo 'DEAD') then {
					_color = _colorDead;
				};
			};
		};
		if ([_x,((_QS_ST_X # 15) # 0)] call (_QS_ST_X # 69)) then {_color = _colorIncapacitated;};
		if (isPlayer _x) then {
			if ((_x getVariable ['QS_unit_role_displayName',-1]) isEqualTo -1) then {
				_unitMOS = ['GET_ROLE_DISPLAYNAME',(_x getVariable ['QS_unit_role','rifleman'])] call (missionNamespace getVariable 'QS_fnc_roles');
			} else {
				_unitMOS = _x getVariable ['QS_unit_role_displayName','Rifleman'];
			};		
		} else {
			_unitMOS = QS_hashmap_configfile getOrDefaultCall [
				format ['cfgvehicles_%1_displayname',toLowerANSI (typeOf _x)],
				{getText ((configOf _x) >> 'displayName')},
				TRUE
			];
		};
		_unitName = name _x;
		if (!isPlayer _x) then {
			if (!(_AINames)) then {
				_unitName = '[AI]';
			};
		};
		if (_leader) then {
			_leader = FALSE;
			if (_showClass) then {
				_unitNameList = _unitNameList + format ["<t align='left'><t size='1.2'><t color='%2'>%1</t></t></t>",_unitName,_color] + format ["<t align='right'><t size='0.75'><t color='%2'>[%1]</t></t></t>",_unitMOS,_color] + '<br/>';
			} else {
				_unitNameList = _unitNameList + format ["<t align='left'><t size='1.2'><t color='%2'>%1</t></t></t>",_unitName,_color] + '<br/>';				
			};
		} else {
			if (_showClass) then {
				_unitNameList = _unitNameList + format ["<t align='left'><t color='%2'>%1</t></t>",_unitName,_color] + format ["<t align='right'><t size='0.75'><t color='%2'>[%1]</t></t></t>",_unitMOS,_color] + '<br/>';
			} else {
				_unitNameList = _unitNameList + format ["<t align='left'><t color='%2'>%1</t></t>",_unitName,_color] + '<br/>';				
			};
		};
	} count (units _group);
	[(format [
		"
			<t align='left'><t size='2'>%1</t></t><t align='right'>%2</t><br/><br/>
			%3
		",
		_text,
		_groupCount,
		_unitNameList
	])] call (missionNamespace getVariable 'QS_fnc_hint');
};
_QS_fnc_onGroupIconOverEnter = {
	if ((side (_this # 1)) isNotEqualTo (QS_player getVariable ['QS_unit_side',WEST])) exitWith {};
};
_QS_fnc_onGroupIconOverLeave = {
	hintSilent '';
};
scriptName 'Soldier Tracker by Quiksilver - (Init)';
_side = player getVariable ['QS_unit_side',WEST];
_sides = [EAST,WEST,RESISTANCE,CIVILIAN];
uiSleep 0.1;
_QS_ST_faction = _sides find _side;
if (_side isEqualTo EAST) then {
	_QS_ST_showFriendlySides = _QS_ST_friendlySides_EAST;
};
if (_side isEqualTo WEST) then {
	_QS_ST_showFriendlySides = _QS_ST_friendlySides_WEST;
};
if (_side isEqualTo RESISTANCE) then {
	_QS_ST_showFriendlySides = _QS_ST_friendlySides_RESISTANCE;
};
if (_side isEqualTo CIVILIAN) then {
	_QS_ST_showFriendlySides = _QS_ST_friendlySides_CIVILIAN;
};
_QS_ST_autonomousVehicles = [];
if (!(_QS_ST_iconShadowMap in [0,1,2])) then {
	_QS_ST_iconShadowMap = 1;
};
if (!(_QS_ST_iconShadowGPS in [0,1,2])) then {
	_QS_ST_iconShadowGPS = 1;
};
if (_QS_ST_iconUpdatePulseDelay > 0) then {
	missionNamespace setVariable ['QS_ST_iconUpdatePulseTimer',diag_tickTime];
};
_QS_ST_iconTextFont = _QS_ST_iconTextFonts # 0;
if (_QS_ST_enableGroupIcons) then {
	if (!(_QS_ST_map_enableUnitIcons)) then {
		_QS_ST_groupIconOffset = [0,0];
	};
};
_QS_ST_groupIconText = FALSE;
_QS_ST_htmlColorMedical = [_QS_ST_MedicalIconColor # 0,_QS_ST_MedicalIconColor # 1,_QS_ST_MedicalIconColor # 2,_QS_ST_MedicalIconColor # 3] call (missionNamespace getVariable 'BIS_fnc_colorRGBtoHTML');
_QS_ST_htmlColorInjured = [_QS_ST_colorInjured # 0,_QS_ST_colorInjured # 1,_QS_ST_colorInjured # 2,_QS_ST_colorInjured # 3] call (missionNamespace getVariable 'BIS_fnc_colorRGBtoHTML');
_QS_ST_otherDisplays = FALSE;	// debug - part of new role selection system
_QS_ST_R = [
	_QS_ST_map_enableUnitIcons,
	_QS_ST_gps_enableUnitIcons,
	_QS_ST_enableGroupIcons,
	_QS_ST_faction,
	_QS_ST_friendlySides_EAST,
	_QS_ST_friendlySides_WEST,
	_QS_ST_friendlySides_RESISTANCE,
	_QS_ST_friendlySides_CIVILIAN,
	_QS_ST_friendlySides_Dynamic,
	_QS_ST_iconColor_EAST,
	
	_QS_ST_iconColor_WEST,
	_QS_ST_iconColor_RESISTANCE,
	_QS_ST_iconColor_CIVILIAN,
	_QS_ST_iconColor_UNKNOWN,
	_QS_ST_showMedicalWounded,
	_QS_ST_MedicalSystem,
	_QS_ST_MedicalIconColor,
	_QS_ST_iconShadowMap,
	_QS_ST_iconShadowGPS,
	_QS_ST_iconTextSize_Map,
	
	_QS_ST_iconTextSize_GPS,
	_QS_ST_iconTextOffset,
	_QS_ST_iconSize_Man,
	_QS_ST_iconSize_LandVehicle,
	_QS_ST_iconSize_Ship,
	_QS_ST_iconSize_Air,
	_QS_ST_iconSize_StaticWeapon,
	_QS_ST_GPSDist,
	_QS_ST_GPSshowNames,
	_QS_ST_GPSshowGroupOnly,
	
	_QS_ST_showAIGroups,
	_QS_ST_showGroupMapIcons,
	_QS_ST_showGroupHudIcons,
	_QS_ST_groupInteractiveIcons,
	_QS_ST_groupInteractiveIcons_showClass,
	_QS_ST_showKnownEnemies,
	_QS_ST_showGroupMapText,
	_QS_ST_groupIconScale,
	_QS_ST_groupIconOffset,
	_QS_ST_groupIconText,
	
	_QS_ST_autonomousVehicles,
	_QS_fnc_iconColor,
	_QS_fnc_iconType,
	_QS_fnc_iconSize,
	_QS_fnc_iconPosDir,
	_QS_fnc_iconText,
	_QS_fnc_iconUnits,
	_QS_fnc_onMapSingleClick,
	_QS_fnc_mapVehicleShowCrew,
	_QS_fnc_iconDrawMap,
	
	_QS_fnc_iconDrawGPS,
	_QS_fnc_groupIconText,
	_QS_fnc_groupIconType,
	_QS_fnc_configGroupIcon,
	_QS_fnc_onGroupIconClick,
	_QS_fnc_onGroupIconOverLeave,
	_QS_ST_iconMapClickShowDetail,
	_QS_ST_showFriendlySides,
	_QS_fnc_onGroupIconOverEnter,
	_QS_ST_showCivilianGroups,
	
	_QS_ST_iconTextFont,
	_QS_ST_showAll,
	_QS_ST_showFactionOnly,
	_QS_ST_showAI,
	_QS_ST_showMOS,
	_QS_ST_showGroupOnly,
	_QS_ST_iconUpdatePulseDelay,
	_QS_ST_iconMapText,
	_QS_ST_showMOS_range,
	_QS_fnc_isIncapacitated,
	
	_QS_ST_htmlColorMedical,
	_QS_ST_AINames,
	_QS_ST_showAINames,
	_QS_ST_groupTextFactionOnly,
	_QS_ST_showCivilianIcons,
	_QS_ST_showOnlyVehicles,
	_QS_ST_showOwnGroup,
	_QS_fnc_iconColorGroup,
	_QS_ST_iconColor_empty,
	_QS_ST_iconSize_empty,
	
	_QS_ST_showEmptyVehicles,
	_QS_ST_htmlColorInjured,
	_QS_ST_otherDisplays,
	_QS_ST_MAPrequireGPSItem,
	_QS_ST_GPSrequireGPSItem,
	_QS_ST_GRPrequireGPSItem,
	_QS_ST_admin
];
{
	missionNamespace setVariable _x;
} forEach [
	['QS_ST_X',(compileFinal (str _QS_ST_R)),FALSE],
	['QS_ST_updateDraw_map',(diag_tickTime + 2),FALSE],
	['QS_ST_updateDraw_gps',(diag_tickTime + 1),FALSE],
	['QS_ST_drawArray_map',[],FALSE],
	['QS_ST_drawArray_gps',[],FALSE],
	['QS_ST_drawArrayEnemy_map',[],FALSE]
];
waitUntil {
	uiSleep 0.1; 
	!(isNull (findDisplay 12))
};
_QS_ST_X = call (missionNamespace getVariable 'QS_ST_X');
if (_QS_ST_X # 0) then {
	((findDisplay 12) displayCtrl 51) ctrlAddEventHandler ['Draw',(format ['call %1',(_QS_ST_X # 49)])];
	if (_QS_ST_X # 82) then {
		/*/
		[_QS_ST_X] spawn {
			scriptName 'Soldier Tracker by Quiksilver - Artillery Computer and UAV Terminal support';
			private ['_QS_display1Opened','_QS_display2Opened'];
			_QS_ST_X = _this # 0;
			_QS_display1Opened = FALSE;
			_QS_display2Opened = FALSE;
			disableSerialization;
			for '_x' from 0 to 1 step 0 do {
				if (!(_QS_display1Opened)) then {
					if (!isNull ((findDisplay 160) displayCtrl 51)) then {
						_QS_display1Opened = TRUE;
						((findDisplay 160) displayCtrl 51) ctrlAddEventHandler ['Draw',(format ['_this call %1',(_QS_ST_X # 49)])];
					};
				} else {
					if (isNull ((findDisplay 160) displayCtrl 51)) then {
						_QS_display1Opened = FALSE;
					};		
				};
				if (!(_QS_display2Opened)) then {
					if (!isNull((findDisplay -1) displayCtrl 500)) then {
						_QS_display2Opened = TRUE;
						((findDisplay -1) displayCtrl 500) ctrlAddEventHandler ['Draw',(format ['_this call %1',(_QS_ST_X # 49)])];
					};
				} else {
					if (isNull ((findDisplay -1) displayCtrl 500)) then {
						_QS_display2Opened = FALSE;
					};		
				};
				uiSleep 0.25;
			};
		};
		/*/
	};
	if (_QS_ST_X # 56) then {
		player setVariable ['QS_ST_map_vehicleShowCrew',objNull,FALSE];
		player setVariable ['QS_ST_mapSingleClick',FALSE,FALSE];
		{
			addMissionEventHandler _x;
		} forEach [
			['MapSingleClick',(_QS_ST_X # 47)],
			[
				'Map',
				{
					params ['_mapIsOpened','_mapIsForced'];
					if (!(_mapIsOpened)) then {
						if (alive (QS_player getVariable ['QS_ST_map_vehicleShowCrew',objNull])) then {
							QS_player setVariable ['QS_ST_mapSingleClick',FALSE,FALSE];
							(QS_player getVariable ['QS_ST_map_vehicleShowCrew',objNull]) setVariable ['QS_ST_mapClickShowCrew',FALSE,FALSE];
							QS_player setVariable ['QS_ST_map_vehicleShowCrew',objNull,FALSE];
						};
					};
				}
			]
		];
	};
};

if (_QS_ST_X # 1) then {
	[_QS_ST_X] spawn {
		scriptName 'Soldier Tracker (GPS Icons) - Waiting for GPS display';
		params ['_QS_ST_X'];
		disableSerialization;
		private _gps = controlNull;
		private _exit = FALSE;
		for '_x' from 0 to 1 step 0 do {
			{
				if (['311',(str _x),FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) then {
					if (!isNull (_x displayCtrl 101)) exitWith {
						_gps = (_x displayCtrl 101);
						_gps ctrlRemoveAllEventHandlers 'Draw';
						_gps ctrlAddEventHandler ['Draw',(format ['call %1',(_QS_ST_X # 50)])];
						_exit = TRUE;
					};
				};
			} forEach (uiNamespace getVariable 'IGUI_displays');
			uiSleep 0.25;
			if (_exit) exitWith {};
		};
	};
};
if (_QS_ST_X # 2) then {
	setGroupIconsVisible [(_QS_ST_X # 31),(_QS_ST_X # 32)];
	setGroupIconsSelectable (_QS_ST_X # 33);
	if (_QS_ST_X # 33) then {
		{
			addMissionEventHandler _x;
		} forEach [
			['GroupIconClick',(_QS_ST_X # 54)],
			['GroupIconOverEnter',(_QS_ST_X # 58)],
			['GroupIconOverLeave',(_QS_ST_X # 55)]
		];
	};
	_grpscript = [_QS_ST_X] spawn {
		scriptName 'Soldier Tracker (Group Icons)';
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
		if (_dynamicDiplomacy) then {
			_sidesFriendly = _sides;
		};
		private _as = [];
		_as pushBack (_sides # _playerFaction);
		{
			0 = _as pushBack (_sides # _x);
		} count _showFriendlySides;
		for '_x' from 0 to 1 step 0 do {
			if (
				_dynamicDiplomacy &&
				{(diag_tickTime > _checkDiplomacy)}
			) then {
				_as = [];
				{
					if (((QS_player getVariable ['QS_unit_side',WEST]) getFriend _x) > 0.6) then {
						_as pushBack _x;
					};
				} forEach _sides;
				_checkDiplomacy = diag_tickTime + _checkDiplomacy_delay;
			};
			if (diag_tickTime > _groupUpdateDelay) then {
				{
					if ((_showOwnGroup) || {((!(_showOwnGroup)) && (_x isNotEqualTo (group QS_player)))} || {(!(_showMapUnitIcons))}) then {
						_grp = _x;
						if (((units _grp) findIf {(alive _x)}) isNotEqualTo -1) then {
							if ((side _grp) in _as) then {
								_grpLeader = leader _grp;
								if (_showAIGroups) then {
									if (_grp isNil 'QS_ST_Group') then {
										if (
											(!isNull _grp) &&
											{(!isNull _grpLeader)}
										) then {
											[_grp,0,_QS_ST_X] call _configGroupIcon;
										};
									} else {
										if (
											(!isNull _grp) &&
											{(!isNull _grpLeader)}
										) then {
											[_grp,1,_QS_ST_X] call _configGroupIcon;
										};
									};
								} else {
									if (isPlayer _grpLeader) then {
										if (_grp isNil 'QS_ST_Group') then {
											if (
												(!isNull _grp) &&
												{(!isNull _grpLeader)}
											) then {
												[_grp,0,_QS_ST_X] call _configGroupIcon;
											};
										} else {
											if (
												(!isNull _grp) &&
												{(!isNull _grpLeader)}
											) then {
												[_grp,1,_QS_ST_X] call _configGroupIcon;
											};
										};
									};
								};
							} else {
								if (!(_grp isNil 'QS_ST_Group_Icon')) then {
									[_grp,2,_QS_ST_X] call _configGroupIcon;
								};
							};
						} else {
							if (!(_grp isNil 'QS_ST_Group_Icon')) then {
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
			if (
				_gpsRequired &&
				{((QS_player getSlotItemName 612) isEqualTo '')}
			) then {
				setGroupIconsVisible [FALSE,FALSE];
				waitUntil {
					uiSleep 0.25;
					((QS_player getSlotItemName 612) isNotEqualTo '')
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
			uiSleep 0.1;
		};
	};
	missionNamespace setVariable ['QS_script_grpIcons',_grpscript,FALSE];
};