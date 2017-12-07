/*/
File: QS_icons.sqf
Script Name: Soldier Tracker
Author:

	Quiksilver (contact: camball@gmail.com)
	
Version:

	2.4.0 (released 7/02/2017 A3 v1.66)

Created: 

	8/08/2014
	
Last Modified: 

	7/02/2017 A3 1.66 by Quiksilver
	
Installation: 

	In client/player init (initPlayerLocal.sqf)
		[] execVM "QS_icons.sqf";
	or 
		[] execVM "scripts\QS_icons.sqf";    (if in a folder called scripts in your mission directory.)

	Follow instructions posted in the below link
		http://forums.bistudio.com/showthread.php?184108-Soldier-Tracker-(-Map-and-GPS-Icons-)
		
_________________________________________________________________/*/
if (isDedicated) exitWith {};
if (!hasInterface) exitWith {};
private [
	'_side','_sides','_QS_ST_X','_QS_ST_map_enableUnitIcons','_QS_ST_gps_enableUnitIcons',	'_QS_ST_enableGroupIcons','_QS_ST_faction','_QS_ST_friendlySides_EAST',
	'_QS_ST_friendlySides_WEST','_QS_ST_friendlySides_RESISTANCE','_QS_ST_friendlySides_CIVILIAN','_QS_ST_friendlySides_Dynamic','_QS_ST_iconColor_EAST','_QS_ST_iconColor_WEST',
	'_QS_ST_iconColor_RESISTANCE','_QS_ST_iconColor_CIVILIAN','_QS_ST_iconColor_UNKNOWN','_QS_ST_showMedicalWounded','_QS_ST_MedicalSystem','_QS_ST_MedicalIconColor','_QS_ST_iconShadowMap',
	'_QS_ST_iconShadowGPS','_QS_ST_iconTextSize_Map','_QS_ST_iconTextSize_GPS','_QS_ST_iconTextOffset','_QS_ST_iconSize_Man','_QS_ST_iconSize_LandVehicle',	
	'_QS_ST_iconSize_Ship','_QS_ST_iconSize_Air','_QS_ST_iconSize_StaticWeapon','_QS_ST_GPSDist','_QS_ST_GPSshowNames','_QS_ST_GPSshowGroupOnly',	'_QS_ST_showAIGroups',			
	'_QS_ST_showGroupMapIcons','_QS_ST_showGroupHudIcons','_QS_ST_groupInteractiveIcons','_QS_ST_groupInteractiveIcons_showClass','_QS_ST_dynamicGroupID',			
	'_QS_ST_showGroupMapText','_QS_ST_groupIconScale','_QS_ST_groupIconOffset','_QS_ST_groupIconText','_QS_ST_autonomousVehicles','_QS_fnc_iconColor','_QS_fnc_iconType',				
	'_QS_fnc_iconSize','_QS_fnc_iconPosDir','_QS_fnc_iconText','_QS_fnc_iconUnits','_QS_fnc_onMapSingleClick','_QS_fnc_mapVehicleShowCrew','_QS_fnc_iconDrawMap',			
	'_QS_fnc_iconDrawGPS','_QS_fnc_groupIconText','_QS_fnc_groupIconType','_QS_fnc_configGroupIcon','_QS_fnc_onGroupIconClick','_QS_fnc_onGroupIconOverLeave',	
	'_QS_ST_iconMapClickShowDetail','_QS_ST_showFriendlySides','_QS_fnc_onGroupIconOverEnter','_QS_ST_showCivilianGroups','_QS_ST_iconTextFont','_QS_ST_showAll','_QS_ST_showFactionOnly',		
	'_QS_ST_showAI','_QS_ST_showMOS','_QS_ST_showGroupOnly','_QS_ST_iconUpdatePulseDelay','_QS_ST_iconMapText','_QS_ST_showMOS_range','_QS_ST_autonomousVehicles_Vanilla',
	'_QS_ST_autonomousVehicles_Modded','_QS_ST_iconTextFonts','_QS_fnc_isIncapacitated','_QS_ST_htmlColorMedical','_QS_ST_R','_QS_ST_showAINames','_QS_ST_AINames',
	'_QS_ST_groupTextFactionOnly','_QS_ST_showCivilianIcons','_QS_ST_showOnlyVehicles','_QS_ST_showOwnGroup','_QS_ST_iconColor_empty',
	'_QS_ST_iconSize_empty','_QS_ST_showEmptyVehicles','_QS_ST_colorInjured','_QS_ST_htmlColorInjured','_QS_fnc_iconColorGroup','_QS_ST_otherDisplays','_QS_ST_showKnownEnemies',
	'_QS_fnc_showKnownEnemies'
];

/*/================== MASTER SWITCHES/*/

_QS_ST_map_enableUnitIcons = TRUE;							/*/BOOL. TRUE to enable MAP unit/vehicle Icons. Default TRUE./*/
_QS_ST_gps_enableUnitIcons = TRUE;							/*/ BOOL. TRUE to enable GPS unit/vehicle Icons. Default TRUE./*/
_QS_ST_enableGroupIcons = FALSE;								/*/BOOL. TRUE to enable Map+GPS+HUD GROUP Icons. Default TRUE./*/
	
/*/================= DIPLOMACY - set the Friendly factions for each faction./*/

_QS_ST_friendlySides_Dynamic = FALSE;						/*/ BOOL. Set TRUE to allow faction alliances to change dynamically (IE. AAF may not always be loyal to NATO) and be represented on the map. Default TRUE./*/
_QS_ST_friendlySides_EAST = [								/*/ARRAY (NUMBER). Uncomment the relevant number(s). Remove comma after last used entry (important!)./*/
	//1,		/*/EAST is friendly to WEST/*/
	/*/2,/*/		/*/EAST is friendly to INDEPENDENT/RESISTANCE/*/
	3		/*/EAST is friendly to CIVILIANS/*/
];
_QS_ST_friendlySides_WEST = [								/*/ARRAY (NUMBER). Uncomment the relevant number(s). Remove comma after last used entry (important!)./*/
	/*/0,/*/		/*/WEST is friendly to EAST/*/
	/*/2/*/		/*/WEST is friendly to INDEP/RESISTANCE/*/
	/*/3/*/		/*/WEST is friendly to CIVILIAN/*/
];
_QS_ST_friendlySides_RESISTANCE = [							/*/ ARRAY (NUMBER). Uncomment the relevant number(s). Remove comma after last used entry (important!)./*/
	/*/0,/*/		/*/RESISTANCE is friendly to EAST/*/
	1,		/*/RESISTANCE is friendly to WEST/*/
	3		/*/RESISTANCE is friendly to CIVILIAN/*/
];
_QS_ST_friendlySides_CIVILIAN = [							/*/ ARRAY (NUMBER). Uncomment the relevant number(s). Remove comma after last used entry (important!)./*/
	0,		/*/CIVILIAN is friendly to EAST/*/
	/*/1,/*/		/*/CIVILIAN is friendly to WEST/*/
	2		/*/CIVILIAN is friendly to INDEP/RESISTANCE/*/
];

/*/================= DEFAULT ICON COLORS by FACTION/*/

_QS_ST_iconColor_EAST = [0.5,0,0,0.65];						/*/ ARRAY (NUMBER). RGBA color code.	Default [0.5,0,0,0.65];/*/
_QS_ST_iconColor_WEST = [0,0.3,0.6,0.65];					/*/ ARRAY (NUMBER). RGBA color code. Default [0,0.3,0.6,0.65];/*/
_QS_ST_iconColor_RESISTANCE = [0,0.5,0,0.65];					/*/ ARRAY (NUMBER). RGBA color code. Default [0,0.5,0,0.65];	/*/
_QS_ST_iconColor_CIVILIAN = [0.4,0,0.5,0.65];					/*/ ARRAY (NUMBER). RGBA color code. Default [0.4,0,0.5,0.65];	/*/
_QS_ST_iconColor_UNKNOWN = [0.7,0.6,0,0.5];					/*/ARRAY (NUMBER). RGBA color code. Default [0.7,0.6,0,0.5];/*/

//================= MEDICAL

_QS_ST_showMedicalWounded = TRUE;							/*/ BOOL. TRUE to show wounded on the map and GPS. FALSE to not show wounded on the map with this script. Default TRUE./*/
_QS_ST_MedicalSystem = [									/*/ ARRAY(STRING). The Active Medical System. Uncomment ONLY ONE. FIRST UNCOMMENTED ONE WILL BE USED. Comment the rest out as shown. Do not add commas and only allow 1 to be uncommented./*/
	/*/'BIS'/*/												/*/ BIS Revive./*/
	/*/'BTC'	/*/											/*/ BTC Revive./*/
	/*/'AIS'	/*/											/*/AIS Revive./*/
	/*/'ACE'	/*/											/*/ACE 3 Revive./*/
	/*/'FAR'	/*/											/*/ Farooqs Revive./*/
	/*/'AWS' /*/   											/*/ A3 Wounding System by Psycho./*/
	'QS'												/*/ Quiksilver's Revive/*/
];
_QS_ST_MedicalIconColor = [1,0.41,0,1];						/*/ ARRAY (NUMBER). Color of medical icons in RGBA format. Default [1,0.41,0,1];/*/
_QS_ST_colorInjured = [0.75,0.55,0,0.75];					/*/ ARRAY (NUMBER). RGBA color code. Color of units with > 10% damage, in map group interactive interface. Default [0.7,0.6,0,0.5];/*/

/*/================= MODDED AUTONOMOUS REMOTE-CONTROLLABLE VEHICLES (UAVs/UGVs/Autonomous Statics)/*/

_QS_ST_autonomousVehicles_Modded = [];						/*/ OBSOLETE. ARRAY (STRING). If you are using mods with custom UAV/UGV/autonomous type vehicles, enter them here. Ex:  _QS_ST_autonomousVehicles_Modded = ['B_MOD_UAV_01_F','O_MOD_UAV_01_F','I_MOD_UAV_02_F'];/*/

/*/==================================================================================/*/
/*/=========================== CONFIGURE MAP (UNIT/VEHICLE) ICONS ===================/*/
/*/==================================================================================/*/

_QS_ST_showAll = 0;										/*/ NUMBER. Intended for Debug / Development use only! Caution: WILL CAUSE LAG IF 1 or 2! Settings -  0 = Disabled (Recommended). 1 = Reveal all Units + vehicles. 2 = Reveal all mission objects + vehicles + units. May override below configurations if set at 1 or 2./*/
_QS_ST_showFactionOnly = FALSE;								/*/ BOOL. will override ST_showFriendlySides TRUE. If TRUE then will only show players faction. If FALSE then can show friendly factions. Default FALSE./*/
_QS_ST_showAI = TRUE;										/*/ BOOL. FALSE = players only, TRUE = players and AI. Default TRUE./*/
_QS_ST_AINames = FALSE;									/*/ BOOL. Set TRUE to show human names for AI with the map/vehicle icons. Set FALSE and will be named 'AI'. Default FALSE./*/
_QS_ST_showCivilianIcons = FALSE;							/*/ BOOL. Set TRUE to allow showing of civilians, only works if Dynamic Diplomacy is enabled above. Default FALSE./*/
_QS_ST_iconMapText = TRUE;									/*/ BOOL. TRUE to show unit/vehicle icon text on the map. FALSE to only show the icon and NO text (name/class). Default TRUE./*/
_QS_ST_showMOS = TRUE;										/*/ BOOL. TRUE = show Military Occupational Specialty text(unit/vehicle class/role display name), FALSE = disable and only show icons and names. Default FALSE./*/
_QS_ST_showMOS_range = 3500;								/*/ NUMBER. Range in distance to show MOS on the map. Default 3500./*/
_QS_ST_showGroupOnly = FALSE;								/*/ BOOL. Set TRUE to show ONLY the unit icons of THE PLAYERS GROUP MEMBERS on the MAP, FALSE to show ALL your factions units. May override other config. Default TRUE./*/
_QS_ST_showOnlyVehicles = FALSE;							/*/ BOOL. Set TRUE to show ONLY vehicles, no foot-soldier units will be shown. May override other config. Default TRUE./*/
_QS_ST_iconMapClickShowDetail = TRUE;						/*/ BOOL. Set TRUE to show unit/vehicle detail when player clicks on their map near the vehicle. Only works for shown vehicles. Default TRUE./*/
_QS_ST_iconUpdatePulseDelay = 0;							/*/ NUMBER. How often should location of unit on the MAP be updated? 0 = as fast as possible, else if > 0 then it = time in seconds. Default 0./*/
_QS_ST_iconShadowMap = 1;									/*/ NUMBER. Icon Shadow on MAP. 0 = no shadow. 1 = shadow. 2 = outline. Must be 0, 1, or 2. Default 1./*/
_QS_ST_iconTextSize_Map = 0.05;								/*/ NUMBER. Icon Text Size on MAP display. Default is 0.05./*/
_QS_ST_iconTextOffset = 'right';							/*/ STRING. Icon Text Offset. Can be 'left' or 'center' or 'right'. Default is 'right'/*/
_QS_ST_iconSize_Man = 22;									/*/ NUMBER. Icon Size by Vehicle Type. Man/Units. Default = 22/*/
_QS_ST_iconSize_LandVehicle = 26;							/*/ NUMBER. Icon Size by Vehicle Type. Ground-based vehicles. Default = 26	/*/
_QS_ST_iconSize_Ship = 24;									/*/ NUMBER. Icon Size by Vehicle Type. Water-based vehicles. Default = 24/*/
_QS_ST_iconSize_Air = 24;									/*/ NUMBER. Icon Size by Vehicle Type. Air vehicles. Default = 24/*/
_QS_ST_iconSize_StaticWeapon = 22;							/*/ NUMBER. Icon Size by Vehicle Type. Static Weapon (Mortar, remote designator, HMG/GMG. Default = 22/*/
_QS_ST_iconTextFonts = [									/*/ ARRAY (STRING). Icon Text Font. Only the uncommented one will be used. Do not add commas and only allow 1 to be uncommented. Default 'RobotoCondensed'./*/
	/*/'EtelkaMonospacePro'/*/
	/*/'EtelkaMonospaceProBold'/*/
	/*/'EtelkaNarrowMediumPro'/*/
	/*/'LucidaConsoleB'/*/
	/*/'PuristaBold'/*/
	/*/'PuristaLight'/*/
	/*/'puristaMedium'/*/
	/*/'PuristaSemibold'/*/
	/*/'TahomaB'/*/
	'RobotoCondensed'
];
_QS_ST_otherDisplays = FALSE;
if ((['uav',(typeOf player),FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) || {(['mort',(typeOf player),FALSE] call (missionNamespace getVariable 'QS_fnc_inString'))}) then {
     _QS_ST_otherDisplays = TRUE;     /*/ BOOL. TRUE to add Unit/Vehicle Icon support for UAV Terminal and Artillery Computer. Runs a separate script to handle these displays. Only works if  _QS_ST_map_enableUnitIcons = TRUE;	/*/
};

/*/==================================================================================/*/
/*/=========================== CONFIGURE GPS (UNIT/VEHICLE) ICONS ===================/*/
/*/==================================================================================/*/

_QS_ST_GPSDist = 300;										/*/ NUMBER. Distance from player that units shown on GPS. Higher number = lower script performance. Not significant but every 1/10th of a frame counts! Default 300/*/
_QS_ST_GPSshowNames = FALSE;								/*/ BOOL. TRUE to show unit names on the GPS display. Default FALSE./*/
_QS_ST_GPSshowGroupOnly = FALSE;							/*/ BOOL. TRUE to show only group members on the GPS display. Default TRUE./*/
_QS_ST_iconTextSize_GPS = 0.05;								/*/ NUMBER. Icon Text Size on GPS display. Default is 0.05./*/
_QS_ST_iconShadowGPS = 1;									/*/ NUMBER. Icon Shadow on GPS. 0 = no shadow. 1 = shadow. 2 = outline. Must be 0, 1, or 2. Default 1./*/

/*/==================================================================================/*/
/*/============================= CONFIGURE GROUP ICONS ==============================/*/
/*/==================================================================================/*/

_QS_ST_showGroupMapIcons = TRUE;							/*/BOOL. Group icons displayed on map. Default TRUE./*/
_QS_ST_showGroupHudIcons = FALSE;							/*/ BOOL. Group icons displayed on player 3D HUD. Default FALSE./*/
_QS_ST_showAIGroups = FALSE;								/*/BOOL. Show Groups with AI leaders. Default TRUE./*/
_QS_ST_showAINames = FALSE;								/*/ BOOL. Show AI Names. If FALSE, when names are listed with Group features, will only display as '[AI]'. Default FALSE./*/
_QS_ST_groupInteractiveIcons = TRUE;						/*/BOOL. Group icons are interactable (mouse hover and mouse click for group details). Default TRUE./*/
_QS_ST_groupInteractiveIcons_showClass = TRUE;				/*/ BOOL. TRUE to show units vehicle class when revealing group details with interactive map group click. Default TRUE./*/
_QS_ST_showGroupMapText = TRUE;							/*/ BOOL. TRUE to show Group Name on the map. If FALSE, name can still be seen by clicking on the group icon, if QS_ST_groupInteractiveIcons = TRUE. Default FALSE./*/
_QS_ST_groupIconScale = 0.5;								/*/NUMBER. Group Icon Scale. Default = 0.5/*/
_QS_ST_groupIconOffset = [0.65,0.65];						/*/ ARRAY (NUMBERS). [X,Y], offset position of icon from group leaders position. Can be positive or negative numbers. Default = [0.65,0.65];/*/
_QS_ST_groupTextFactionOnly = TRUE;							/*/ BOOL. TRUE to show group icon text from ONLY the PLAYERS faction. FALSE will show text for all friendly/revealed factions. Default TRUE./*/
_QS_ST_showCivilianGroups = FALSE;							/*/ BOOL. TRUE to show Civilian groups. Must be whitelisted above in friendlySides. Default FALSE./*/
_QS_ST_showOwnGroup = TRUE;								/*/ BOOL. TRUE to show the Players own group icon. Default TRUE./*/

/*/==================================================================================/*/
/*/============================= CONFIGURE BONUS FEATURES ===========================/*/
/*/==================================================================================/*/

_QS_ST_showEmptyVehicles = FALSE;							/*/ BOOL. TRUE to mark certain unoccupied vehicles on the map. The vehicle must be assigned this variable:    <vehicle> setVariable ['QS_ST_drawEmptyVehicle',TRUE,TRUE];    Default FALSE.   Only works if  _QS_ST_map_enableUnitIcons = TRUE;/*/
_QS_ST_iconColor_empty = [0.7,0.6,0,0.5];					/*/ ARRAY (NUMBERS). Color of unoccupied vehicles, in RGBA. Default = [0.7,0.6,0,0.5];/*/
_QS_ST_iconSize_empty = 20;									/*/ NUMBER. Icon size of unoccupied vehicles, if shown./*/
_QS_ST_showKnownEnemies = TRUE;								/*/ BOOL. TRUE to mark known enemies on the map. Default - FALSE./*/

/*/==================================================================================/*/
/*/================ TEXT (for LOCALIZATION / LANGUAGE TRANSLATION) ==================/*/
/*/==================================================================================/*/

missionNamespace setVariable ['QS_ST_STR_text1','Click to show group details',FALSE];				/*/ STRING. Text shown when a player passes Mouse over Group leader (only if _QS_ST_groupInteractiveIcons = TRUE;)/*/
missionNamespace setVariable ['QS_ST_STR_text2','This group is not in your faction!',FALSE];		/*/ STRING. Text shown when a player clicks on a Group Icon of other faction. (only if _QS_ST_groupInteractiveIcons = TRUE;)/*/

/*/==============================================================================================================================/*/
/*/=============================================================== CONFIGURATION END ============================================/*/
/*/==============================================================================================================================/*/
/*/===================================================== EDITING BELOW FOR ADVANCED USERS ONLY!!! ===============================/*/
/*/==============================================================================================================================/*/

/*/===== Define all functions/*/

_QS_fnc_isIncapacitated = {
	_u = _this select 0;
	((lifeState _u) isEqualTo 'INCAPACITATED')
};
_QS_fnc_iconColor = {
	private ['_u','_c','_a','_ps','_ms','_i','_ic','_display','_QS_ST_X','_v'];
	_v = _this select 0;
	_u = effectiveCommander _v;
	_display = _this select 1;
	_QS_ST_X = _this select 2;
	if ((count _this) > 3) then {_ms = _this select 3;};
	_ps = side _u;
	_exit = FALSE;
	if (!(_v isKindOf 'Man')) then {
		if (!isNil {_v getVariable 'QS_ST_drawEmptyVehicle'}) then {
			if (_v getVariable 'QS_ST_drawEmptyVehicle') then {
				if ((count (crew _v)) isEqualTo 0) then {
					_exit = TRUE;
					_c = _QS_ST_X select 78;
					_c set [3,0.65];
					if (_ms > 0.80) then {
						if (_display isEqualTo 1) then {
							_c set [3,0];
						};
					};
				};
			};
		};			
	};
	if (_exit) exitWith {_c;};
	if ((group _u) isEqualTo (group player)) then {_a = 0.85;} else {_a = 0.65;};
	if ((_QS_ST_X select 14)) then {
		if ([_u,((_QS_ST_X select 15) select 0)] call (_QS_ST_X select 69)) then {
			_exit = TRUE;
			_c = _QS_ST_X select 16;
			_c set [3,_a];
			if (_ms > 0.80) then {
				if (_display isEqualTo 1) then {
					_c set [3,0];
				};
			};
			_c;
		};
	} else {
		if ([_u,((_QS_ST_X select 15) select 0)] call (_QS_ST_X select 69)) then {
			_exit = TRUE;
			_c = _QS_ST_X select 16;
			_c set [3,0];
			_c;
		};
	};
	if (_exit) exitWith {_c;};
	if (!isNil {_u getVariable 'QS_ST_iconColor'}) then {
		_ic = _u getVariable 'QS_ST_iconColor';
		if (_ps isEqualTo (_ic select 1)) then {
			_c = _ic select 0;
			_c set [3,_a];
			if (_ms > 0.80) then {
				if (_display isEqualTo 1) then {
					_c set [3,0];
				};
			};
			_exit = TRUE;
		};
	};
	if (_exit) exitWith {_c;};
	if (_ps isEqualTo EAST) exitWith {_c = _QS_ST_X select 9; _c set [3,_a];if (_display isEqualTo 1) then {if (_ms > 0.80) then {_c set [3,0];_c;};};_u setVariable ['QS_ST_iconColor',[_c,_ps],FALSE];_c;};
	if (_ps isEqualTo WEST) exitWith {_c = _QS_ST_X select 10; _c set [3,_a];if (_display isEqualTo 1) then {if (_ms > 0.80) then {_c set [3,0];_c;};};_u setVariable ['QS_ST_iconColor',[_c,_ps],FALSE];_c;};
	if (_ps isEqualTo RESISTANCE) exitWith {_c = _QS_ST_X select 11; _c set [3,_a];if (_display isEqualTo 1) then {if (_ms > 0.80) then {_c set [3,0];_c;};};_u setVariable ['QS_ST_iconColor',[_c,_ps],FALSE];_c;};
	if (_ps isEqualTo CIVILIAN) exitWith {_c = _QS_ST_X select 12; _c set [3,_a];if (_display isEqualTo 1) then {if (_ms > 0.80) then {_c set [3,0];_c;};};_u setVariable ['QS_ST_iconColor',[_c,_ps],FALSE];_c;};
	_c = _QS_ST_X select 13;if (_display isEqualTo 1) then { if (_ms > 0.80) then {_c set [3,0];_c;};};_u setVariable ['QS_ST_iconColor',[_c,_ps],FALSE];_c;
};
_QS_fnc_iconType = {
	private ['_v','_i','_vt'];
	_vt = typeOf (_this select 0);
	/*/_i = (_this select 0) getVariable [format ['QS_ST_iconType#%1',_vt],''];/*/
	_i = missionNamespace getVariable [format ['QS_ST_iconType#%1',_vt],''];
	if (_i isEqualTo '') then {
		/*/
		if ((_this select 0) getUnitTrait 'medic') then {
			_vt = 'B_medic_F';
		} else {
			if ((_this select 0) getUnitTrait 'engineer') then {
				_vt = 'B_engineer_F';
			} else {
				if ((_this select 0) getUnitTrait 'explosiveSpecialist') then {
					_vt = 'B_soldier_exp_F';
				};
			};
		};
		/*/
		_i = getText (configFile >> 'CfgVehicles' >> _vt >> 'icon');
		missionNamespace setVariable [format ['QS_ST_iconType#%1',_vt],_i];
		/*/(_this select 0) getVariable [format ['QS_ST_iconType#%1',_vt],_i];/*/
	};
	_i;
};
_QS_fnc_iconSize = {
	private ['_v','_i','_display','_QS_ST_X'];
	_v = _this select 0;
	_display = _this select 1;
	_QS_ST_X = _this select 2;
	_i = missionNamespace getVariable [format ['QS_ST_iconSize#%1',(typeOf _v)],0];
	if (_i isEqualTo 0) then {
		_i = 22;
		if (_v isKindOf 'Man') then {_i = _QS_ST_X select 22;_i;};
		if (_v isKindOf 'StaticWeapon') then {_i = _QS_ST_X select 26; _i;};
		if (_v isKindOf 'LandVehicle') then {_i = _QS_ST_X select 23;_i;};
		if (_v isKindOf 'Air') then {_i = _QS_ST_X select 25;_i;};
		if (_v isKindOf 'Ship') then {_i = _QS_ST_X select 24;_i;};
		missionNamespace setVariable [format ['QS_ST_iconSize#%1',(typeOf _v)],_i];
	};
	_i;
};
_QS_fnc_iconPosDir = {
	private ['_v','_display','_delay','_posDir'];
	_v = _this select 0;
	_display = _this select 1;
	_delay = _this select 2;
	if (_display isEqualTo 1) then {
		if (_delay > 0) then {
			if (time > (missionNamespace getVariable 'QS_ST_iconUpdatePulseTimer')) then {
				_posDir = [(getPosASLVisual _v),(getDirVisual _v)];
				_v setVariable ['QS_ST_lastPulsePos',_posDir,FALSE];
			} else {
				if (!isNil {_v getVariable 'QS_ST_lastPulsePos'}) then {
					_posDir = _v getVariable 'QS_ST_lastPulsePos';
				} else {
					_posDir = [(getPosASLVisual _v),(getDirVisual _v)];
					_v setVariable ['QS_ST_lastPulsePos',_posDir,FALSE];
				};		
			};
		} else {
			_posDir = [(getPosASLVisual _v),(getDirVisual _v)];
		};
	} else {
		_posDir = [(getPosASLVisual _v),(getDirVisual _v)];
	};
	_posDir;
};
_QS_fnc_iconText = {
	private ['_n','_v','_y','_vt','_t','_vn','_ms','_QS_ST_X','_display','_isAdmin','_newText','_crewIndex','_crewCount','_crewIndex_indexed','_showMOS','_showAINames','_auv','_na'];
	_v = _this select 0;
	_display = _this select 1;
	if (_display isEqualTo 2) exitWith {
		_t = '';
		_t;
	};
	_QS_ST_X = _this select 2;
	if ((count _this) > 3) then {_ms = _this select 3;};
	if (!(_QS_ST_X select 67)) exitWith {
		_t = ''; 
		_t;
	};
	_showMOS = _QS_ST_X select 64;
	_showAINames = _QS_ST_X select 71;
	
	if (!isNil {_v getVariable 'QS_ST_customDN'}) then {
		_vt = _v getVariable 'QS_ST_customDN';
	} else {
		_vt = missionNamespace getVariable [format ['QS_ST_iconVehicleDN#%1',(typeOf _v)],''];
		if (_vt isEqualTo '') then {
			_vt = getText (configFile >> 'CfgVehicles' >> (typeOf _v) >> 'displayName');
			missionNamespace setVariable [format ['QS_ST_iconVehicleDN#%1',(typeOf _v)],_vt];
		};
	};
	if (!(_QS_ST_X select 64)) then {
		_vt = '';
	};
	_vn = name ((crew _v) select 0);
	if (!isPlayer ((crew _v) select 0)) then {
		if (!(_showAINames)) then {
			_vn = '[AI]';
		};
	};
	_isAdmin = serverCommandAvailable '#logout';
	if (((_v distance player) < (_QS_ST_X select 68)) || {(_isAdmin)}) then {
		if ((_ms < 0.5) || {(_isAdmin)}) then {
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
		if (_ms < 0.5) then {
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
			if (!isNil {_v getVariable 'QS_ST_mapClickShowCrew'}) then {
				if (_v getVariable 'QS_ST_mapClickShowCrew') then {
					_t = '';
					_crewIndex = 0;
					_crewCount = count (crew _v);
					_crewIndex_indexed = _crewCount - 1;
					{
						_na = name _x;
						if (!(_showAINames)) then {
							if (!isPlayer _x) then {
								_na = '[AI]';
							};
						};
						if (!(['error',_na,FALSE] call (missionNamespace getVariable 'QS_fnc_inString'))) then {
							if (!(_crewIndex isEqualTo _crewIndex_indexed)) then {
								_t = _t + _na + ', ';
							} else {
								_t = _t + _na;
							};
						};
						_crewIndex = _crewIndex + 1;
					} count (crew _v);
				} else {
					if (!isNull driver _v) then {
						if (_ms < 0.5) then {
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
						if (_ms < 0.5) then {
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
					if (_ms < 0.5) then {
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
					if (_ms < 0.5) then {
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
				if (_ms < 0.5) then {
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
				if (_ms < 0.5) then {
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
		if (unitIsUav _v) then {
			if (isUavConnected _v) then {
				_y = (UAVControl _v) select 0;
				if (_ms < 0.5) then {
					if (_ms > 0.25) then {
						if (_showMOS) then {
							_t = format ['%1 [%2]',name _y,_vt]; _t;
						} else {
							_t = format ['%1',name _y]; _t;
						};
					} else {
						if (_ms < 0.006) then {
							if (_showMOS) then {
								_t = format ['%1 [%2]',name _y,_vt]; _t;
							} else {
								_t = format ['%1',name _y]; _t;
							};
						} else {
							_t = '';
						};
					};
				} else {
					_t = '';
				};
			} else {
				if (_ms < 0.5) then {
					if (_ms > 0.25) then {
						if (_showMOS) then {
							_t = format ['[AUTO] [%1]',_vt]; _t;
						} else {
							_t = '[AUTO]'; _t;
						};
					} else {
						if (_ms < 0.006) then {
							if (_showMOS) then {
								_t = format ['[AUTO] [%1]',_vt]; _t;
							} else {
								_t = '[AUTO]'; _t;
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
	_t;
};
_QS_fnc_iconUnits = {
	private ['_di','_si','_as','_au','_vars','_QS_ST_X','_exit'];
	_di = _this select 0;
	_QS_ST_X = _this select 1;
	_exit = FALSE;
	if (!((side player) isEqualTo CIVILIAN)) then {
		if ((_QS_ST_X select 74)) then {
			_si = [EAST,WEST,RESISTANCE,CIVILIAN];
		} else {
			_si = [EAST,WEST,RESISTANCE];
		};
	} else {
		_si = [EAST,WEST,RESISTANCE,CIVILIAN];
	};
	_as = [];
	_au = [];
	
	if ((_QS_ST_X select 61) > 0) exitWith {
		if ((_QS_ST_X select 61) isEqualTo 1) then {
			_au = allUnits + vehicles;
		};
		if ((_QS_ST_X select 61) isEqualTo 2) then {
			_au = entities [[],[],TRUE,TRUE];
		};
		_au;
	};
	
	if (((_di isEqualTo 1) && ((_QS_ST_X select 65))) && {(!(_QS_ST_X select 75))}) then {
		_exit = TRUE;
		_au = units (group player);
		if ((_QS_ST_X select 80)) then {
			{
				if (!(_x in _au)) then {
					if (!isNil {_x getVariable 'QS_ST_drawEmptyVehicle'}) then {
						if (_x getVariable 'QS_ST_drawEmptyVehicle') then {
							if ((crew _x) isEqualTo []) then {
								0 = _au pushBack _x;
							};
						};
					};
				};
			} count vehicles;
		};
		_au;
	};
	if ((_di isEqualTo 2) && ((_QS_ST_X select 29))) then {
		_exit = TRUE;
		_au = units (group player);
		_au;
	};
	if (_exit) exitWith {_au;};
	if ((_QS_ST_X select 62)) then {
		0 = _as pushBack (_si select (_QS_ST_X select 3));
	} else {
		if (isMultiplayer) then {
			if (serverCommandAvailable '#kick') then {
				{
					0 = _as pushBack _x;
				} count _si;
			} else {
				if ((_QS_ST_X select 8)) then {
					0 = _as pushBack (_si select (_QS_ST_X select 3));
					{
						if (((_si select (_QS_ST_X select 3)) getFriend _x) > 0.6) then {
							0 = _as pushBack _x;
						};
					} count _si;
				} else {
					0 = _as pushBack (_si select (_QS_ST_X select 3));
					{
						0 = _as pushBack (_si select _x);
					} count (_QS_ST_X select 57);
				};
			};
		} else {
			if ((_QS_ST_X select 8)) then {
				0 = _as pushBack (_si select (_QS_ST_X select 3));
				{
					if (((_si select (_QS_ST_X select 3)) getFriend _x) > 0.6) then {
						0 = _as pushBack _x;
					};
				} count _si;
			} else {
				0 = _as pushBack (_si select (_QS_ST_X select 3));
				{
					0 = _as pushBack (_si select _x);
				} count (_QS_ST_X select 57);
			};
		};		
	};
	if (!(_QS_ST_X select 63)) then {
		if (isMultiplayer) then {
			if (serverCommandAvailable '#kick') then {
				if (_x isEqualTo ((crew (vehicle _x)) select 0)) then {
					{
						0 = _au pushBack _x;
					} count allUnits;
				};
			} else {
				{
					if (((side _x) in _as) || {(captive _x)}) then {
						if (isPlayer _x) then {
							if (_di isEqualTo 2) then {
								if ((_x distance2D player) < (_QS_ST_X select 27)) then {
									if (_x isEqualTo ((crew (vehicle _x)) select 0)) then {
										0 = _au pushBack _x;
									};
								};
							} else {
								if (_x isEqualTo ((crew (vehicle _x)) select 0)) then {
									0 = _au pushBack _x;
								};
							};
						};
					};
				} count (allPlayers + allUnitsUav);
			};
		} else {
			{
				if (((side _x) in _as) || {(captive _x)}) then {
					if (isPlayer _x) then {
						if (_di isEqualTo 2) then {
							if ((_x distance2D player) < (_QS_ST_X select 27)) then {
								if (_x isEqualTo ((crew (vehicle _x)) select 0)) then {
									0 = _au pushBack _x;
								};
							};
						} else {
							if (_x isEqualTo ((crew (vehicle _x)) select 0)) then {
								0 = _au pushBack _x;
							};
						};
					};
				};
			} count (allPlayers + allUnitsUav);
		};
	} else {
		{
			if (((side _x) in _as) || {(captive _x)}) then {
				if (_x isEqualTo player) then {
					0 = _au pushBack _x;
				} else {
					if (_di isEqualTo 2) then {
						if ((_x distance2D player) < (_QS_ST_X select 27)) then {
							if (_x isEqualTo ((crew (vehicle _x)) select 0)) then {
								0 = _au pushBack _x;
							};
						};
					} else {
						if (_x isEqualTo (effectiveCommander (vehicle _x))) then {
						/*/if (_x isEqualTo ((crew (vehicle _x)) select 0)) then {/*/
							0 = _au pushBack _x;
						};
					};
				};
			};
		} count allUnits;
	};
	if ((_di isEqualTo 1) && (_QS_ST_X select 75)) exitWith {
		_auv = [];
		{
			if (!((vehicle _x) isKindOf 'Man')) then {
				0 = _auv pushBack _x;
			};
		} count _au;
		if ((_QS_ST_X select 80)) then {
			{
				if (!(_x in _auv)) then {
					if (!isNil {_x getVariable 'QS_ST_drawEmptyVehicle'}) then {
						if (_x getVariable 'QS_ST_drawEmptyVehicle') then {
							if ((crew _x) isEqualTo []) then {
								0 = _auv pushBack _x;
							};
						};
					};
				};
			} count vehicles;
		};
		if ((_QS_ST_X select 65)) then {
			{
				0 = _auv pushBack _x;
			} count (units (group player));
		};
		_auv;
	};
	if ((_di isEqualTo 1) && (_QS_ST_X select 80)) exitWith {
		{
			if (!(_x in _au)) then {
				if (!isNil {_x getVariable 'QS_ST_drawEmptyVehicle'}) then {
					if (_x getVariable 'QS_ST_drawEmptyVehicle') then {
						if ((crew _x) isEqualTo []) then {
							0 = _au pushBack _x;
						};
					};
				};
			};
		} count vehicles;
		_au;
	};
	_au;
};
_QS_fnc_onMapSingleClick = {
	private ['_QS_ST_X','_vehicles','_vehicle','_pos','_vehicle','_vehicles','_position'];
	if ((player getVariable 'QS_ST_mapSingleClick')) exitWith {
		player setVariable ['QS_ST_mapSingleClick',FALSE,FALSE];
		if (!isNull (player getVariable 'QS_ST_map_vehicleShowCrew')) then {
			if (alive (player getVariable 'QS_ST_map_vehicleShowCrew')) then {
				(player getVariable 'QS_ST_map_vehicleShowCrew') setVariable ['QS_ST_mapClickShowCrew',FALSE,FALSE];
			};
		};
	};
	player setVariable ['QS_ST_map_vehicleShowCrew',objNull,FALSE];
	player setVariable ['QS_ST_mapSingleClick',TRUE,FALSE];
	_position = _pos;
	_vehicle = objNull;
	_vehicles = _position nearEntities [['Air','LandVehicle','Ship'],50];
	if ((count _vehicles) > 0) then {
		_vehicle = _vehicles select 0;
	} else {
		_position set [2,50];
		_vehicles = _position nearEntities ['Air',50];
		if ((count _vehicles) > 0) then {
			_vehicle = _vehicles select 0;
		} else {
			_position set [2,100];
			_vehicles = _position nearEntities ['Air',80];
		};
	};
	_QS_ST_X = [] call (missionNamespace getVariable 'QS_ST_X');
	if (!isNull _vehicle) then {
		if ((count (crew _vehicle)) > 1) then {
			if ((side (effectiveCommander _vehicle)) isEqualTo playerSide) then {
				player setVariable ['QS_ST_map_vehicleShowCrew',_vehicle,FALSE];
				_vehicle setVariable ['QS_ST_mapClickShowCrew',TRUE,FALSE];
				[_vehicle] spawn (_QS_ST_X select 48);
			};
		};
	};
};
_QS_fnc_mapVehicleShowCrew = {
	private ['_exit','_vehicle'];
	player setVariable ['QS_ST_mapSingleClick',TRUE,FALSE];
	_vehicle = _this select 0;
	for '_x' from 0 to 1 step 0 do {
		if ((!(visibleMap)) || {(!alive player)} || {(isNull (player getVariable 'QS_ST_map_vehicleShowCrew'))}) exitWith {
			player setVariable ['QS_ST_mapSingleClick',FALSE,FALSE];
			player setVariable ['QS_ST_map_vehicleShowCrew',objNull,FALSE];
			_vehicle setVariable ['QS_ST_mapClickShowCrew',FALSE,FALSE];
		};
		uiSleep 1;
	};
};
_QS_fnc_showKnownEnemies = {
	private [
		'_p','_s','_targetAccuracy','_targetObj','_targetSide','_targetType','_targetPosition','_targetAge','_perceivedPosition','_iconType','_co','_QS_ST_X','_ms','_is'
	];
	_QS_ST_X = _this select 0;
	_ms = _this select 1;
	_ke = [];
	_s = playerSide;
	{
		_targetAccuracy = _x select 0;
		_targetObj = _x select 1;
		_targetSide = _x select 2;
		_targetType = _x select 3;
		_targetPosition = _x select 4;
		_targetAge = _x select 5;
		if (!isNull _targetObj) then {
			if (alive _targetObj) then {
				//if ((_s getFriend _targetSide) < 0.6) then {
					_iconType = missionNamespace getVariable [format ['QS_ST_iconType#%1',_targetType],''];
					if (_iconType isEqualTo '') then {
						_iconType = getText (configFile >> 'CfgVehicles' >> _targetType >> 'icon');
						missionNamespace setVariable [format ['QS_ST_iconType#%1',_targetType],_iconType];
					};
					_co = [_targetObj,1,_QS_ST_X,_ms] call (_QS_ST_X select 41);
					//if (!((_co select 3) isEqualTo 0)) then {
					//	_co set [3,_targetAccuracy];
					//};
					_perceivedPosition = player getHideFrom _targetObj;
					_is = [_targetObj,1,_QS_ST_X] call (_QS_ST_X select 43);
					0 = _ke pushBack [_iconType,_co,_perceivedPosition,_is,_is,(getDirVisual _targetObj),'',0,0.03,'puristaMedium','right'];
				//};
			};
		};
	} count (player targetsQuery [objNull,sideUnknown,'',[],0]);
	//} count (player targets [TRUE,300]);
	_ke;
};
_QS_fnc_iconDrawMap = {
	private ['_m','_ve','_it','_co','_po','_is','_te','_sh','_ts','_tf','_to','_QS_ST_X','_ms','_de'];
	_m = _this select 0;
	_QS_ST_X = [] call (missionNamespace getVariable 'QS_ST_X');
	_ms = ctrlMapScale _m;
	if (time > (missionNamespace getVariable 'QS_ST_updateDraw_map')) then {
		missionNamespace setVariable ['QS_ST_updateDraw_map',(time + 3),FALSE];
		missionNamespace setVariable ['QS_ST_drawArray_map',([1,_QS_ST_X] call (_QS_ST_X select 46)),FALSE];
		if (_QS_ST_X select 35) then {
			missionNamespace setVariable ['QS_ST_drawArrayEnemy_map',([0,_QS_ST_X,(_QS_ST_X select 43)] call (missionNamespace getVariable 'QS_fnc_getKnownEnemies')),FALSE];
		};
	};
	_sh = _QS_ST_X select 17;
	_ts = _QS_ST_X select 19;
	_tf = _QS_ST_X select 60;
	_to = _QS_ST_X select 21;
	_de = _QS_ST_X select 66;
	if (!((missionNamespace getVariable 'QS_ST_drawArrayEnemy_map') isEqualTo [])) then {
		{
			_m drawIcon _x;
		} count (missionNamespace getVariable ['QS_ST_drawArrayEnemy_map',[]]);
	};
	if (!((missionNamespace getVariable 'QS_ST_drawArray_map') isEqualTo [])) then {
		{
			if (!isNull _x) then {
				_ve = vehicle _x;
				if (alive _ve) then {
					if (!(_ve getVariable ['QS_hidden',FALSE])) then {
						_po = [_ve,1,_de] call (_QS_ST_X select 44);
						_is = [_ve,1,_QS_ST_X] call (_QS_ST_X select 43);
						_m drawIcon [
							([_ve,1,_QS_ST_X] call (_QS_ST_X select 42)),
							([_ve,1,_QS_ST_X,_ms] call (_QS_ST_X select 41)),
							(_po select 0),
							_is,
							_is,
							(_po select 1),
							([_ve,1,_QS_ST_X,_ms] call (_QS_ST_X select 45)),
							_sh,
							_ts,
							_tf,
							_to
						];
						if (_ve isEqualTo (vehicle player)) then {
							_m drawIcon ['a3\ui_f\data\igui\cfg\islandmap\iconplayer_ca.paa',[1,0,0,0.75],(_po select 0),24,24,(_po select 1),'',0,0.03,_tf,_to];
						};
					};
				};
			};
		} count (missionNamespace getVariable ['QS_ST_drawArray_map',[]]);
	};
	if (_de > 0) then {
		if (time > (missionNamespace getVariable 'QS_ST_iconUpdatePulseTimer')) then {
			missionNamespace setVariable ['QS_ST_iconUpdatePulseTimer',(time + _de)];
		};
	};
	if (!((missionNamespace getVariable ['QS_draw2D_projectiles',[]]) isEqualTo [])) then {
		{
			if (_x isEqualType objNull) then {
				if (!isNull _x) then {
					_m drawIcon [
						'a3\ui_f\data\igui\cfg\cursors\explosive_ca.paa',
						[1,0,0,0.75],
						(getPosASLVisual _x),
						10,
						10,
						0,
						'',
						0,
						0,
						'RobotoCondensed',
						'right'
					];
				};
			};
		} count (missionNamespace getVariable 'QS_draw2D_projectiles');
	};
	if (!((missionNamespace getVariable ['QS_client_customDraw2D',[]]) isEqualTo [])) then {
		{
			if (_x isEqualType []) then {
				if ((_x select 1) isEqualTo 'ICON') exitWith {
					_m drawIcon (_x select 2);
				};
				if ((_x select 1) isEqualTo 'ELLIPSE') exitWith {
					_m drawEllipse (_x select 2);
				};
				if ((_x select 1) isEqualTo 'RECTANGLE') exitWith {
					_m drawRectangle (_x select 2);
				};
				if ((_x select 1) isEqualTo 'POLYGON') exitWith {
					_m drawPolygon (_x select 2);
				};
				if ((_x select 1) isEqualTo 'TRIANGLE') exitWith {
					_m drawTriangle (_x select 2);
				};
				if ((_x select 1) isEqualTo 'LOCATION') exitWith {
					_m drawLocation (_x select 2);
				};
				if ((_x select 1) isEqualTo 'LINE') exitWith {
					_m drawLine (_x select 2);
				};
				if ((_x select 1) isEqualTo 'ARROW') exitWith {
					_m drawArrow (_x select 2);
				};
			};
		} count (missionNamespace getVariable 'QS_client_customDraw2D');
	};
};
_QS_fnc_iconDrawGPS = {
	private ['_m','_ve','_it','_co','_po','_is','_te','_sh','_ts','_tf','_to','_QS_ST_X','_de','_ex'];
	_m = _this select 0;
	_ex = TRUE;
	{
		if ((_x select 0) isEqualTo 'MinimapDisplay') exitWith {
			_ex = FALSE;
		};
	} forEach [(infoPanel 'left'),(infoPanel 'right')];
	if (_ex) exitWith {};
	_QS_ST_X = [] call (missionNamespace getVariable 'QS_ST_X');
	if (time > (missionNamespace getVariable 'QS_ST_updateDraw_gps')) then {
		missionNamespace setVariable ['QS_ST_updateDraw_gps',(time + 3),FALSE];
		missionNamespace setVariable ['QS_ST_drawArray_gps',([2,_QS_ST_X] call (_QS_ST_X select 46)),FALSE];
	};
	_sh = _QS_ST_X select 18;
	_ts = _QS_ST_X select 20;
	_tf = _QS_ST_X select 60;
	_to = _QS_ST_X select 21;
	_de = _QS_ST_X select 66;
	if (!((missionNamespace getVariable 'QS_ST_drawArray_gps') isEqualTo [])) then {
		{
			if (!isNull _x) then {
				_ve = vehicle _x;
				if (!isNull _ve) then {
					if (!(_ve getVariable ['QS_hidden',FALSE])) then {
						_po = [_ve,2,_de] call (_QS_ST_X select 44);
						_is = [_ve,2,_QS_ST_X] call (_QS_ST_X select 43);
						_m drawIcon [
							([_ve,2,_QS_ST_X] call (_QS_ST_X select 42)),
							([_ve,2,_QS_ST_X] call (_QS_ST_X select 41)),
							(_po select 0),
							_is,
							_is,
							(_po select 1),
							([_ve,2,_QS_ST_X] call (_QS_ST_X select 45)),
							_sh,
							_ts,
							_tf,
							_to
						];
					};
				};
			};
		} count (missionNamespace getVariable ['QS_ST_drawArray_gps',[]]);
	};
};
_QS_fnc_groupIconText = {
	private ['_text','_group','_QS_ST_X','_di','_getIndex','_element','_counter','_index','_grpIndex'];
	_grp = _this select 0;
	_QS_ST_X = _this select 1;
	_di = _this select 2;
	_text = '';
	if (_di isEqualTo 1) then {
		if ((_QS_ST_X select 36)) then {
			_text = groupId _grp;
		};
	};
	_text;
};
_QS_fnc_groupIconType = {
	private [
		'_iconType','_grp','_iconTypes_EAST','_iconTypes_WEST','_iconTypes_RESISTANCE','_iconTypes_CIVILIAN','_vType','_grpSide','_grpSize','_grpVehicle','_iconTypes',
		'_grpVehicle_type'
	];
	_grp = _this select 0;
	_grpSize = _this select 1;
	_grpVehicle = _this select 2;
	_grpSide = _this select 3;
	_grpVehicle_type = typeOf _grpVehicle;
	_vehicleClass = _grpVehicle getVariable ['QS_ST_groupVehicleClass',''];
	if (_vehicleClass isEqualTo '') then {
		_vehicleClass = getText (configFile >> 'CfgVehicles' >> _grpVehicle_type >> 'vehicleClass');
		_grpVehicle setVariable ['QS_ST_groupVehicleClass',_vehicleClass];
	};
	_iconType = _grpVehicle getVariable ['QS_ST_groupVehicleIconType',''];
	if (!(_iconType isEqualTo '')) exitWith {
		_iconType;
	};
	_iconTypes_EAST = ['o_inf','o_motor_inf','o_mech_inf','o_armor','o_recon','o_air','o_plane','o_uav','o_med','o_art','o_mortar','o_hq','o_support','o_maint','o_service','o_naval','o_unknown'];
	_iconTypes_WEST = ['b_inf','b_motor_inf','b_mech_inf','b_armor','b_recon','b_air','b_plane','b_uav','b_med','b_art','b_mortar','b_hq','b_support','b_maint','b_service','b_naval','b_unknown'];
	_iconTypes_RESISTANCE = ['n_inf','n_motor_inf','n_mech_inf','n_armor','n_recon','n_air','n_plane','n_uav','n_med','n_art','n_mortar','n_hq','n_support','n_maint','n_service','n_naval','n_unknown'];
	_iconTypes_CIVILIAN = ['c_air','c_car','c_plane','c_ship','c_unknown'];
	if (_grpSide isEqualTo EAST) then {
		_iconTypes = _iconTypes_EAST;
	};
	if (_grpSide isEqualTo WEST) then {
		_iconTypes = _iconTypes_WEST;
	};
	if (_grpSide isEqualTo RESISTANCE) then {
		_iconTypes = _iconTypes_RESISTANCE;
	};
	if (_grpSide isEqualTo CIVILIAN) exitWith {
		_iconTypes = _iconTypes_CIVILIAN;
		if (_grpVehicle isKindOf 'Helicopter') then {
			_iconType = _iconTypes select 0;
		};
		if (_grpVehicle isKindOf 'LandVehicle') then {
			_iconType = _iconTypes select 1;
		};
		if (_grpVehicle isKindOf 'Plane') then {
			_iconType = _iconTypes select 2;
		};
		if (_grpVehicle isKindOf 'Ship') then {
			_iconType = _iconTypes select 3;
		};
		if (_grpVehicle isKindOf 'Man') then {
			_iconType = _iconTypes select 4;
		};
		_grpVehicle setVariable ['QS_ST_groupVehicleIconType',_iconType,FALSE];
		_iconType;
	};
	if ((_vehicleClass isEqualTo 'Ship') || {(_vehicleClass isEqualTo 'Submarine')}) exitWith {
		_iconType = _iconTypes select 15; _iconType;
	};
	if (_vehicleClass in ['Men','MenRecon','MenSniper','MenDiver','MenSupport','MenUrban','MenStory']) exitWith {
		_iconType = _iconTypes select 0;
		if (_vehicleClass isEqualTo 'Men') then {
			_iconType = _iconTypes select 0;
		};
		if (_vehicleClass in ['MenRecon','MenSniper','MenDiver']) then {
			_iconType = _iconTypes select 4;
		};
		if (['medic',_grpVehicle_type,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) then {
			_iconType = _iconTypes select 8;
		};
		_grpVehicle setVariable ['QS_ST_groupVehicleIconType',_iconType,FALSE];
		_iconType;
	};
	if (_vehicleClass isEqualTo 'Static') exitWith {
		if (['mortar',_grpVehicle_type,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) then {
			_iconType = _iconTypes select 10; 
		} else {
			_iconType = _iconTypes select 12; 
		};
		_grpVehicle setVariable ['QS_ST_groupVehicleIconType',_iconType,FALSE];
		_iconType;
	};
	if (_vehicleClass isEqualTo 'Autonomous') exitWith {
		if (['UAV',_grpVehicle_type,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) then {
			_iconType = _iconTypes select 7; 
		} else {
			if (['UGV',_grpVehicle_type,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) then {
				_iconType = _iconTypes select 12; 
			};
		};
		_grpVehicle setVariable ['QS_ST_groupVehicleIconType',_iconType,FALSE];
		_iconType;
	};
	if (_vehicleClass isEqualTo 'Air') exitWith {
		if (_grpVehicle isKindOf 'Helicopter') then {
			_iconType = _iconTypes select 5; 
		} else {
			_iconType = _iconTypes select 6; 
		};
		_grpVehicle setVariable ['QS_ST_groupVehicleIconType',_iconType,FALSE];
		_iconType;
	};
	if (_vehicleClass isEqualTo 'Armored') exitWith {
		if (['APC',_grpVehicle_type,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) then {
			_iconType = _iconTypes select 2; 
		} else {
			if ((['arty',_grpVehicle_type,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) || {(['mlrs',_grpVehicle_type,FALSE] call (missionNamespace getVariable 'QS_fnc_inString'))}) then {
				_iconType = _iconTypes select 9; 
			} else {
				if (['MBT',_grpVehicle_type,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) then {
					_iconType = _iconTypes select 3; 
				};
			};
		};
		_grpVehicle setVariable ['QS_ST_groupVehicleIconType',_iconType,FALSE];
		_iconType;
	};
	if (_vehicleClass isEqualTo 'Car') exitWith {
		_iconType = _iconTypes select 1; 
		_grpVehicle setVariable ['QS_ST_groupVehicleIconType',_iconType,FALSE];
		_iconType;
	};
	if (_vehicleClass isEqualTo 'Support') exitWith {
		if (['medical',_grpVehicle_type,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) then {
			_iconType = _iconTypes select 8; 
		} else {
			if ((['ammo',_grpVehicle_type,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) || {(['box',_grpVehicle_type,FALSE] call (missionNamespace getVariable 'QS_fnc_inString'))} || {(['fuel',_grpVehicle_type,FALSE] call (missionNamespace getVariable 'QS_fnc_inString'))} || {(['CRV',_grpVehicle_type,FALSE] call (missionNamespace getVariable 'QS_fnc_inString'))} || {(['repair',_grpVehicle_type,FALSE] call (missionNamespace getVariable 'QS_fnc_inString'))}) then {
				_iconType = _iconTypes select 14; 
			};
		};
		_grpVehicle setVariable ['QS_ST_groupVehicleIconType',_iconType,FALSE];
		_iconType;
	};
	_iconType = _iconTypes select 16;
	_grpVehicle setVariable ['QS_ST_groupVehicleIconType',_iconType,FALSE];
	_iconType;
};
_QS_fnc_configGroupIcon = {
	private[
		'_grp','_type','_vars','_grpLeader','_grpLeader_vehicle','_scale','_text','_visibility','_grpIconColor','_grpSize','_grpLeader_vType','_iconID',
		'_grpIconType','_iconDetail','_grpIcon','_grpIconParams','_grpSide','_updateParams','_update','_updateIcon','_QS_ST_X'
	];
	_grp = _this select 0;
	_type = _this select 1;
	_QS_ST_X = _this select 2;
	_grpLeader = leader _grp;
	_grpLeader_vehicle = vehicle _grpLeader;
	_grpLeader_vType = typeOf _grpLeader_vehicle;
	_grpSize = count (units _grp);
	_grpSide = side _grpLeader;
	if (_type isEqualTo 0) then {
		_grpIconType = [_grp,_grpSize,_grpLeader_vehicle,_grpSide] call (_QS_ST_X select 52);		
		_grp setVariable ['QS_ST_Group',1,FALSE];
		_iconID = _grp addGroupIcon [_grpIconType,(_QS_ST_X select 38)];
		_grp setGroupIcon [_iconID,_grpIconType];
		_grpIconColor = [_grpLeader,_QS_ST_X] call (_QS_ST_X select 77);
		_text = [_grp,_QS_ST_X,1] call (_QS_ST_X select 51);
		_scale = (_QS_ST_X select 37);
		_visibility = TRUE;
		_grp setGroupIconParams [_grpIconColor,_text,_scale,_visibility];
		_grp setVariable ['QS_ST_Group_Icon',[_iconID,_grpIconType,_grpLeader_vType,_grpIconColor,_text,_scale,_visibility],FALSE];
	};
	if (_type isEqualTo 1) then {
		_update = FALSE;
		_updateIcon = FALSE;
		_updateParams = FALSE;
		_iconDetail = _grp getVariable 'QS_ST_Group_Icon';
		_iconID = _iconDetail select 0;
		_grpIconType = _iconDetail select 1;
		_grpLeaderType = _iconDetail select 2;
		_text = _iconDetail select 4;
		_scale = _iconDetail select 5;
		_visibility = _iconDetail select 6;
		if (!(_grpLeaderType isEqualTo (typeOf _grpLeader_vehicle))) then {
			_update = TRUE;
			_updateIcon = TRUE;
		};
		if (!(_text isEqualTo ([_grp,_QS_ST_X,1] call (_QS_ST_X select 51)))) then {
			_update = TRUE;
			_updateParams = TRUE;
		};
		if (_update) then {
			_grpIconColor = [_grpLeader_vehicle,_QS_ST_X] call (_QS_ST_X select 77);
			if (_updateIcon) then {
				_grpIconType = [_grp,_grpSize,_grpLeader_vehicle,_grpSide] call (_QS_ST_X select 52);	
				_grp setGroupIcon [_iconID,_grpIconType];
			};
			if (_updateParams) then {
				_text = [_grp,_QS_ST_X,1] call (_QS_ST_X select 51);
				_grp setGroupIconParams [_grpIconColor,_text,_scale,_visibility];
			};
			_grp setVariable ['QS_ST_Group_Icon',[_iconID,_grpIconType,_grpLeader_vType,_grpIconColor,_text,_scale,_visibility],FALSE];
		};
	};
	if (_type isEqualTo 2) then {
		_grpIconArray = _grp getVariable 'QS_ST_Group_Icon';
		_grpID = _grpIconArray select 0;
		clearGroupIcons _grp;
		_grp setVariable ['QS_ST_Group_Icon',nil,FALSE];
		_grp setVariable ['QS_ST_Group',nil,FALSE];
	};
	true;
};
_QS_fnc_iconColorGroup = {
	private ['_u','_c','_ps','_QS_ST_X','_v'];
	_v = _this select 0;
	_QS_ST_X = _this select 1;
	_u = effectiveCommander _v;
	_ps = side _u;
	if (_ps isEqualTo EAST) exitWith {_c = _QS_ST_X select 9; _u setVariable ['QS_ST_groupIconColor',[_c,_ps],FALSE];_c;};
	if (_ps isEqualTo WEST) exitWith {_c = _QS_ST_X select 10; _u setVariable ['QS_ST_groupIconColor',[_c,_ps],FALSE];_c;};
	if (_ps isEqualTo RESISTANCE) exitWith {_c = _QS_ST_X select 11; _u setVariable ['QS_ST_groupIconColor',[_c,_ps],FALSE];_c;};
	if (_ps isEqualTo CIVILIAN) exitWith {_c = _QS_ST_X select 12; _u setVariable ['QS_ST_groupIconColor',[_c,_ps],FALSE];_c;};
	_c = _QS_ST_X select 13;
	_u setVariable ['QS_ST_groupIconColor',[_c,_ps],FALSE];
	_c;
};
_QS_fnc_onGroupIconClick = {
	private ['_lifeState','_unitNameList','_unitMOS','_unitName','_leaderText','_groupCount','_text','_isIncapacitated','_color','_showClass','_AINames','_colorIncapacitated','_colorInjured','_colorDead'];
	scriptName 'QS_ST_onGroupIconClick';
	_is3D = _this select 0;
	_group = _this select 1;
	if (!((side _group) isEqualTo playerSide)) exitWith {hintSilent (missionNamespace getVariable 'QS_ST_STR_text2');[] spawn {uiSleep 3;hintSilent '';};};
	_wpID = _this select 2;
	_button = _this select 3;
	_posx = _this select 4;
	_posy = _this select 5;
	_shift = _this select 6;
	_ctrl = _this select 7;
	_alt = _this select 8;
	_QS_ST_X = [] call (missionNamespace getVariable 'QS_ST_X');
	_text = [_group,_QS_ST_X,2] call (_QS_ST_X select 51);
	_groupCount = count (units _group);
	_unitNameList = '';
	_leader = TRUE;
	if ((_QS_ST_X select 14)) then {
		_colorIncapacitated = _QS_ST_X select 70;
		_colorInjured = _QS_ST_X select 81;
		_colorDead = [0.4,0,0.5,0.65];
	} else {
		_colorIncapacitated = [1,0.41,0,1];
		_colorInjured = [0,0,0,1];
		_colorDead = [0.4,0,0.5,0.65];
	};
	_showClass = _QS_ST_X select 34;
	_AINames = _QS_ST_X select 72;
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
		if ([_x,((_QS_ST_X select 15) select 0)] call (_QS_ST_X select 69)) then {_color = _colorIncapacitated;};
		_unitMOS = getText (configFile >> 'CfgVehicles' >> (typeOf _x) >> 'displayName');
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
	hintSilent parseText format [
		"
			<t align='left'><t size='2'>%1</t></t><t align='right'>%2</t><br/><br/>
			%3
		",
		_text,
		_groupCount,
		_unitNameList
	];
};
_QS_fnc_onGroupIconOverEnter = {
	if (!((side (_this select 1)) isEqualTo playerSide)) exitWith {};
	//hintSilent QS_ST_STR_text1;
};
_QS_fnc_onGroupIconOverLeave = {
	hintSilent '';
};
scriptName 'Soldier Tracker by Quiksilver - (Init)';
_side = playerSide;
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

_QS_ST_autonomousVehicles_Vanilla = [
	'I_UAV_01_F','B_UAV_01_F','O_UAV_01_F','I_UAV_02_F','O_UAV_02_F','I_UAV_02_CAS_F','O_UAV_02_CAS_F','B_UAV_02_F','B_UAV_02_CAS_F',
	'O_UAV_01_F','O_UGV_01_F','O_UGV_01_rcws_F','I_UGV_01_F','B_UGV_01_F','I_UGV_01_rcws_F','B_UGV_01_rcws_F','B_GMG_01_A_F','B_HMG_01_A_F',
	'O_GMG_01_A_F','O_HMG_01_A_F','I_GMG_01_A_F','I_HMG_01_A_F','O_Static_Designator_02_F','B_Static_Designator_01_F'
];

_QS_ST_autonomousVehicles = _QS_ST_autonomousVehicles_Vanilla + _QS_ST_autonomousVehicles_Modded;
if (!(_QS_ST_iconShadowMap in [0,1,2])) then {
	_QS_ST_iconShadowMap = 1;
};
if (!(_QS_ST_iconShadowGPS in [0,1,2])) then {
	_QS_ST_iconShadowGPS = 1;
};
if (_QS_ST_iconUpdatePulseDelay > 0) then {
	missionNamespace setVariable ['QS_ST_iconUpdatePulseTimer',time];
};
_QS_ST_iconTextFont = _QS_ST_iconTextFonts select 0;
if (_QS_ST_enableGroupIcons) then {
	if (!(_QS_ST_map_enableUnitIcons)) then {
		_QS_ST_groupIconOffset = [0,0];
	};
};
_QS_ST_groupIconText = FALSE;
_QS_ST_htmlColorMedical = [_QS_ST_MedicalIconColor select 0,_QS_ST_MedicalIconColor select 1,_QS_ST_MedicalIconColor select 2,_QS_ST_MedicalIconColor select 3] call (missionNamespace getVariable 'BIS_fnc_colorRGBtoHTML');
_QS_ST_htmlColorInjured = [_QS_ST_colorInjured select 0,_QS_ST_colorInjured select 1,_QS_ST_colorInjured select 2,_QS_ST_colorInjured select 3] call (missionNamespace getVariable 'BIS_fnc_colorRGBtoHTML');

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
	_QS_fnc_showKnownEnemies
];

//===== Compile

QS_ST_X = compileFinal str _QS_ST_R;
//QS_ST_X = compileFinal 'QS_ST_R';

//===== Init

waitUntil {
	uiSleep 0.1; 
	(!(isNull (findDisplay 12)))
};
missionNamespace setVariable ['QS_ST_updateDraw_map',(time + 2),FALSE];
missionNamespace setVariable ['QS_ST_updateDraw_gps',(time + 1),FALSE];
missionNamespace setVariable ['QS_ST_drawArray_map',[],FALSE];
missionNamespace setVariable ['QS_ST_drawArray_gps',[],FALSE];
missionNamespace setVariable ['QS_ST_drawArrayEnemy_map',[],FALSE];
_QS_ST_X = [] call (missionNamespace getVariable 'QS_ST_X');
if (_QS_ST_X select 0) then {
	((findDisplay 12) displayCtrl 51) ctrlAddEventHandler ['Draw',(_QS_ST_X select 49)];
	if (_QS_ST_X select 82) then {
		[_QS_ST_X] spawn {
			scriptName 'Soldier Tracker by Quiksilver - Artillery Computer and UAV Terminal support';
			private ['_QS_display1Opened','_QS_display2Opened'];
			_QS_ST_X = _this select 0;
			_QS_display1Opened = FALSE;
			_QS_display2Opened = FALSE;
			disableSerialization;
			for '_x' from 0 to 1 step 0 do {
				comment 'UAV Terminal';
				if (!(_QS_display1Opened)) then {
					if (!isNull ((findDisplay 160) displayCtrl 51)) then {
						_QS_display1Opened = TRUE;
						((findDisplay 160) displayCtrl 51) ctrlAddEventHandler ['Draw',(_QS_ST_X select 49)];
					};
				} else {
					if (isNull ((findDisplay 160) displayCtrl 51)) then {
						_QS_display1Opened = FALSE;
					};		
				};
				comment 'Artillery computer';
				if (!(_QS_display2Opened)) then {
					if (!isNull((findDisplay -1) displayCtrl 500)) then {
						_QS_display2Opened = TRUE;
						((findDisplay -1) displayCtrl 500) ctrlAddEventHandler ['Draw',(_QS_ST_X select 49)];
					};
				} else {
					if (isNull ((findDisplay -1) displayCtrl 500)) then {
						_QS_display2Opened = FALSE;
					};		
				};
				uiSleep 0.25;
			};
		};
	};
	if (_QS_ST_X select 56) then {
		player setVariable ['QS_ST_map_vehicleShowCrew',objNull,FALSE];
		player setVariable ['QS_ST_mapSingleClick',FALSE,FALSE];
		addMissionEventHandler ['MapSingleClick',(_QS_ST_X select 47)];
	};
};
if (_QS_ST_X select 1) then {
	[_QS_ST_X] spawn {
		scriptName 'Soldier Tracker (GPS Icons) by Quiksilver - Waiting for GPS display';
		private ['_gps','_QS_ST_X'];
		_QS_ST_X = _this select 0;
		disableSerialization;
		_gps = controlNull;
		private _exit = FALSE;
		for '_x' from 0 to 1 step 0 do {
			{
				if (['311',(str _x),FALSE] call BIS_fnc_inString) then {
					if (!isNull (_x displayCtrl 101)) then {
						_gps = (_x displayCtrl 101);
						_exit = TRUE;
					};
				};
			} forEach (uiNamespace getVariable 'IGUI_displays');
			uiSleep 0.25;
			if (_exit) exitWith {
				_gps ctrlRemoveAllEventHandlers 'Draw';
				_gps ctrlAddEventHandler ['Draw',(_QS_ST_X select 50)];
			};
		};
	};
};
if (_QS_ST_X select 2) then {
	setGroupIconsVisible [(_QS_ST_X select 31),(_QS_ST_X select 32)];
	setGroupIconsSelectable (_QS_ST_X select 33);
	if ((_QS_ST_X select 33)) then {
		addMissionEventHandler ['GroupIconClick',(_QS_ST_X select 54)];
		addMissionEventHandler ['GroupIconOverEnter',(_QS_ST_X select 58)];
		addMissionEventHandler ['GroupIconOverLeave',(_QS_ST_X select 55)];
	};
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
		_showAIGroups = _QS_ST_X select 30;
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
};