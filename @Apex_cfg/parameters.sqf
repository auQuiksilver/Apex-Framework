diag_log format ['***** %1 * Loading mission parameters *****',diag_tickTime];
/*/
File: parameters.sqf
Author:

	Quiksilver
	
Last Modified:

	22/04/2019 A3 1.90 by Quiksilver
	
Description:

	Mission Parameters
	
Official Support/Help Channels:

	Discord: 	https://discord.gg/FfVaPce
	Forum: 		https://forums.bistudio.com/forums/topic/212240-apex-framework/
	Email: 		armacombatgroup@gmail.com
	
For URLs:

	Use Google URL Shortener ( https://goo.gl/ ) to make something like this:   https://goo.gl/7Xajd9
	
Notes for editing below:

	- Be aware of the quotation marks " and ', they need to be what they are. Notice in links there are two sets of quotations:   "'https://goo.gl/7Xajd9'"     and for servercommandpassword:   _serverCommandPassword = "'ShVQArtpGdc5aDQq'";
	- Improving this file will likely be an ongoing task. save and backup your copy before downloading a new one. be careful with pasting info from one to the other, as data types may change.
_______________________________________________________/*/

//===================================================== COMMUNITY / SERVER

_teamspeak_server = 'ts3.address.com : 1234     - Password: N/A';					// Teamspeak server address, for use with map marker, map tabs, ec. Customize this accordingly.		Example:	_teamspeak_server = 'ts3.address.com : 1234     - Password: N/A';
																					// These options can be seen in your Player Menu under [Comm-Link]. Player menu default key binding is [Home], and also in the Escape menu, top button.
_website_url = 
[
	"'https://goo.gl/7Xajd9'",														// Website URL of your website		Example:	"'https://goo.gl/7Xajd9'"
	"Our Website",																	// Button text.
	"Link 1"																		// Tooltip (text shown when mouse hovering over button).
];
_discord_server = 
[
	"'https://goo.gl/7Xajd9'",														// Discord server (change this to yours).	Example:	"'https://goo.gl/7Xajd9'"
	"Our Discord",																	// Button text.
	"Link 2"																		// Tooltip (text shown when mouse hovering over button).
];
_arma_units_url = 
[
	"'https://units.arma3.com'", 													// url path to your A3 Unit		Example:	"'https://goo.gl/7Xajd9'"
	"Our ArmA Unit",																// Button text.
	"Link 3"																		// Tooltip (text shown when mouse hovering over button).
];

_serverRules = '- No teamkilling<br/>- No destruction of friendly assets<br/>- No advertising<br/>- No verbal abuse<br/>- Pilots and UAV operator must be on Teamspeak<br/>- Staff word is final';		// Server rules shown on splash screen text. Structured Text. Note: There are more rules listed in "code\functions\fn_clientDiary.sqf", edit that file to your liking.
_staffNames = 'Miller (admin), Kerry (moderator), Stavrou (moderator), Orestes (mission editor)';						// This text gets shown on the splash screen when player enters the game, customize as you like.

//===================================================== GAMEPLAY

_baseLayout = 0;										// Base layout.	0 - Integrated base. 1 - Custom base.		Note: With custom base, you will have to define all the spawn points and set all the marker positions manually. Caution: Its a lot of work!
_closeAirSupport = 3;									// Jets.		0 - Disabled. 1 - Whitelisted only. 2 - Enabled. 3 - Whitelisted+Linked to Pilot Transport Points.     This controls Fixed-wing Jets access. If Disabled, players will not have access to Jets and Armed UAV drones will not spawn.
_arsenal = 1;											// Arsenal.		0 - Unrestricted (scripted). 1 - Use Whitelist (scripted). 2 - Use Blacklist (scripted). 3 - Vanilla arsenal (unscripted).	(Recommended = 1).			Caution! Blacklist is unconfigured by default, you will have to do it. Only whitelist comes pre-configured.    #3 will disable scripted gear restrictions.
_armor = 1;												// Armored Vehicles.	0 - Disabled. 1 - Enabled. (Default = 1). 		Controls whether players have access to respawning armored vehicles with default layout.
_reducedDamage = 1;										// Damage Modeling.		0 - Disabled. 1 - Enabled. (Default/Recommended 1).		Controls whether players have added body armor and dynamic damage modeling to balance ArmA AI accuracy/aimbot shortcomings, especially in jungle/forest areas. Recommended: 1.
_stamina = 0;											// Stamina.		0 - Optional. 1 - Forced On.	(Default: 0). If optional, players can toggle in menu.
_enemyCAS = 1;											// Enemy Fixed-Wing Aircraft.	0 - Disabled. 1 - Enabled. (Default = 1). Controls whether enemy have access to fixed-wing planes.
_commander = 2;											// Commander role. 0 - Disabled. 1 - Enabled. 2 - Enabled & Whitelisted. (Default = 2). Commander role has the ability to give player groups and AI groups orders and waypoints, can talk on Side Channel, and view bodycam live feeds of any soldier.
_artillery = 1;											// Base artillery.	0 - Disabled. 1 - Enabled. 	If enabled, a self-propelled artillery asset is available for use. Does not affect Mk.6 mortars access. Does not affect naval artillery.
_artilleryComputer = 1;									// Artillery Computer settings. 	0. Disabled. 	1 - Enabled ONLY while in scripted base artillery.		2 - Enabled. (Recommended = 1). Note: Applies to mortars as well.
_mapContentEnemy = 1;									// Enemy Map Indicators. 	0 - Disabled. 1 - Enabled. Recommended = 1.	    Controls whether enemies known to the player are visible on the map.
_recruitableAI = 1;										// Recruitable AI.	0 - Disabled. 1 - Enabled. 		If there are recruitable AI available (default base layout or placed by you in custom base layout), this toggles them on or off.
_playable_opfor = 0;									// OPFOR player roles. 	0 - Disabled. 1 - Enabled (Whitelisted). 2 - Enabled (Unrestricted).		Enable a limited number of enemy player roles for the supported mission types. Highly recommended to NOT use with the standard missions unless you know your players are comfortable with it. Designed for future Framework flexibility and development.

//===================================================== SYSTEM

_role_selection_menu_button = 0;						// Role Selection Menu Button. 	Enables a button in the Escape Menu to access the Role Selection Menu.	0 - Disabled. 1 - Enabled. Default - 0.		Use this option to allow any player to change their role from any map location. If this value is 0, the only way to access the menu after login is via Arsenal crates user action. Recommend 0 for standard gamemodes to avoid exploitation.
_restart_hours = [0,12,18];								// Hours (24hr clock) which server will restart. If you use this, disable your servers restart scheduler.   Leave blank to disable, like this:  _restart_hours = [];    Times are local to server machine (consider time zone). Recommended - 8hr intervals for steady play. 6hr intervals for constant full server. 12-16hr intervals for smaller server populations.
_dynamic_simulation = 1;								// Dynamic Simulation. 	0 - Disabled. 1 - Enabled. 	Raises FPS and performance slightly. Server freezes entities which are far away from all players.    Info: https://community.bistudio.com/wiki/Arma_3_Dynamic_Simulation

//===================================================== MAIN MISSION TYPE

//========== DESCRIPTION===============================//
// 		'CLASSIC' 			Classic I&A. 					Recommended: 24-48+ players.			Example: 	_main_mission_type = 'CLASSIC';
// 		'SC' 				Sector Control.		 			Recommended: 36-64+ players.			Example: 	_main_mission_type = 'SC';
// 		'GRID'				Insurgency Campaign (Beta). 	Recommended: 4-24+ players.				Example: 	_main_mission_type = 'GRID';				//---- This mission type is in Beta currently (9/12/2017)
// 		'NONE'				Primary missions disabled.												Example: 	_main_mission_type = 'NONE';				//---- Use this when you want to create Zeus missions and use the framework mechanics without the scripted missions.
//====================================================//	

_main_mission_type = 'CLASSIC';

//===================================================== SIDE MISSIONS

_sideMissions = 0;										// Side Missions.	0 - Disabled. 1 - Enabled. (Default = 1).	Set 0 to disable default side missions.

//===================================================== STATIC SHIPS
// Aircraft Carrier
_aircraft_carrier_enabled = 0;								// Presence.			0 - Disabled. 1 - Enabled. 2 - Enabled + Turret Defenses.    Note: Turret defenses will consume server/AI/CPU performance resources, recommended to not use.
_aircraft_carrier_vehicles = 1;								// Vehicle Spawning.	0 - None. 1 - Basic. 2 - Full.		This will interfere with _closeAirSupport config above, if Full (2) is used.  These are vehicles which spawn as part of the aircraft carrier package.
_aircraft_carrier_respawning = 1;							// Player Spawning.		0 - None. 1 - Jet pilots only. 2 - All players.		Mission designed for options 0 and 1 only. Advised to only use 2 if AO type == 'NONE' or on closed server.
// Destroyer
_destroyer_enabled = 0;										// Presence.			0 - Disabled. 1 - Enabled. 2 - Enabled + Turret Defenses.    Note: Turret defenses will consume server/AI/CPU performance resources, recommended to not use.
_destroyer_vehicles = 1;									// Vehicle Spawning.	0 - None. 1 - Basic. 2 - Full. These are vehicles which spawn as part of the destroyer package. 1 = boats only, 2 = boats + helicopter.
_destroyer_respawning = 0;									// Player Spawning.		0 - None. 1 - All players will (re)spawn on the ship. 		Note: This option is overridden by  "_aircraft_carrier_respawning" option above. Jet pilots will also respawn on the carrier, even if both are available.
_destroyer_artillery = 0;									// Naval Artillery.		0 - Disabled. 1 - Enabled.	Recommended = 0.	Enable the MK41 VLS Missile Artillery System & MK45 Hammer Naval Gun.
_destroyer_flag = 'a3\data_f\flags\flag_us_co.paa';			// Texture applied to Destroyer flag. Default:  'a3\data_f\flags\flag_us_co.paa'
_destroyer_name = 'a3\boat_f_destroyer\destroyer_01\data\destroyer_01_tag_01_co.paa';		// Name presented on stern of ship. Comes with 7 defaults, just change ..._tag_01_co... to _tag_02_co... etc, from 01 to 07, 00 is blank. You can also set as a custom texture/name/logo.
_destroyer_numbers = [6,6,6];								// Numbers shown on the ship hull.
_destroyer_hangar = 1;										// Hangar Door initial state. 0 - Hangar doors start closed. 1 - Hangar doors start opened.
//===================================================== TEXTURES

_community_logo = '';
_community_flag_texture = 'a3\data_f\flags\flag_nato_co.paa';						// Community texture applied to some flags.		Default: 'a3\data_f\flags\flag_nato_co.paa'
_default_flag_texture = 'a3\data_f\flags\flag_nato_co.paa';							// Texture applied to friendly flags. 			Default: 'a3\data_f\flags\flag_nato_co.paa'
_billboard_1 = ['media\images\billboards\billboard3.jpg','media\images\billboards\billboard3.jpg'];							// Textures applied to livefeed screen in default base. These parameters act as randomized arrays. Put more file paths in the [ ] array as desired. Example:   ['media\images\billboards\billboard3.jpg','media\images\billboards\billboard4.jpg'];
_billboard_2 = ['media\images\billboards\billboard4.jpg','media\images\billboards\billboard4.jpg'];							// Textures applied to other screens in default base. These parameters act as randomized arrays. Put more file paths in the [ ] array as desired. Example:   ['media\images\billboards\billboard3.jpg','media\images\billboards\billboard4.jpg'];
_infostand_1 = ['media\images\billboards\billboard5.jpg','media\images\billboards\billboard5.jpg'];							// Textures applied to info stands (V1) in default base. These parameters act as randomized arrays. Put more file paths in the [ ] array as desired. Example:   ['media\images\billboards\billboard3.jpg','media\images\billboards\billboard4.jpg'];
_infostand_2 = ['media\images\billboards\billboard6.jpg','media\images\billboards\billboard6.jpg'];							// Textures applied to info stands (V2) in default base. These parameters act as randomized arrays. Put more file paths in the [ ] array as desired. Example:   ['media\images\billboards\billboard3.jpg','media\images\billboards\billboard4.jpg'];

//===================================================== SECURITY

_serverCommandPassword = "'ShVQArtpGdc5aDQq'";			// Enter a server command password like this. It MUST match servercommandpassword from your server.cfg config file. ---> serverCommandPassword = "ShVQArtpGdc5aDQq"; This is important and some mission systems will not function without it.
_anticheat = 1;											// 0 - Disabled. 1 - Enabled. (Default 1). 		Disable if running mods or in private/secure setting.

//===================================================== MONETIZATION

// Cosmetics system (uniform + vehicle + shoulder patches). 	
// Controls access to [Area 51] vehicle/uniform/insignia texture system.

_monetizeCosmetics = 0;									// 0 - Disabled (None have access). 1 - Enabled (Only whitelisted "S3" have access). 2 - All have access.

// Link for direct donations toward your server/community + whitelisting + cosmetics,etc. Replace this with your own, or leave blank.
// This option can be seen in your Player Menu under [Comm-Link]. Player menu default key binding is [Home], and also in the Escape menu, top button.

_monetizeURL = [
	"'https://goo.gl/7Xajd9'",											// Monetization URL.
	"Donate",															// Button text.
	"Link 4"															// Tooltip (text shown when mouse hovering over button).
];










//================== DO NOT EDIT BELOW =================== INTERPRETING MISSION PARAMETERS

if (_arsenal isEqualTo 3) then {

};
if (!(_restart_hours isEqualTo [])) then {
	_restart_hours sort TRUE;
};
if (_aircraft_carrier_enabled > 0) then {
	if (_aircraft_carrier_respawning > 1) then {
		if (_destroyer_enabled > 0) then {
			if (_destroyer_respawning > 0) then {
				private _destroyer_respawning = 0;
			};
		};
	};
};
{
	missionNamespace setVariable _x;
	diag_log str ([_x # 0,_x # 1]);
} forEach [
	['QS_missionConfig_commTS',_teamspeak_server,TRUE],
	['QS_missionConfig_commDS',(compileFinal (str _discord_server)),TRUE],
	['QS_missionConfig_commURL',(compileFinal (str _website_url)),TRUE],
	['QS_missionConfig_commA3U',(compileFinal (str _arma_units_url)),TRUE],
	['QS_missionConfig_baseLayout',_baseLayout,TRUE],
	['QS_missionConfig_AH',(compileFinal (str _anticheat)),TRUE],
	['QS_missionConfig_stamina',_stamina,TRUE],
	['QS_missionConfig_enemyCAS',_enemyCAS,FALSE],
	['QS_missionConfig_CAS',_closeAirSupport,TRUE],
	['QS_missionConfig_Commander',_commander,TRUE],
	['QS_missionConfig_Arsenal',_arsenal,TRUE],
	['QS_missionConfig_armor',_armor,TRUE],
	['QS_missionConfig_reducedDamage',(compileFinal (str _reducedDamage)),TRUE],
	['QS_missionConfig_RSS_MenuButton',_role_selection_menu_button,TRUE],
	['QS_missionConfig_restartHours',_restart_hours,TRUE],
	['QS_missionConfig_dynSim',_dynamic_simulation,FALSE],
	['QS_missionConfig_aoType',_main_mission_type,TRUE],
	['QS_missionConfig_sideMissions',_sideMissions,FALSE],
	['QS_missionConfig_arty',_artillery,FALSE],
	['QS_missionConfig_artyEngine',_artilleryComputer,TRUE],
	['QS_missionConfig_mapContentEnemy',_mapContentEnemy,TRUE],
	['QS_missionConfig_recruitableAI',_recruitableAI,FALSE],
	['QS_missionConfig_playableOPFOR',_playable_opfor,TRUE],
	['QS_missionConfig_carrierEnabled',_aircraft_carrier_enabled,TRUE],
	['QS_missionConfig_carrierVehicles',_aircraft_carrier_vehicles,TRUE],
	['QS_missionConfig_carrierRespawn',_aircraft_carrier_respawning,TRUE],
	['QS_missionConfig_destroyerEnabled',_destroyer_enabled,TRUE],
	['QS_missionConfig_destroyerVehicles',_destroyer_vehicles,FALSE],
	['QS_missionConfig_destroyerRespawn',_destroyer_respawning,TRUE],
	['QS_missionConfig_destroyerArtillery',_destroyer_artillery,TRUE],
	['QS_missionConfig_destroyerFlag',_destroyer_flag,FALSE],
	['QS_missionConfig_destroyerName',_destroyer_name,FALSE],
	['QS_missionConfig_destroyerNumbers',_destroyer_numbers,FALSE],
	['QS_missionConfig_destroyerHangar',_destroyer_hangar,FALSE],
	['QS_missionConfig_communityLogo',_community_logo,TRUE],
	['QS_missionConfig_textures_communityFlag',_community_flag_texture,TRUE],
	['QS_missionConfig_textures_defaultFlag',_default_flag_texture,TRUE],
	['QS_missionConfig_textures_billboard1',_billboard_1,TRUE],
	['QS_missionConfig_textures_billboard2',_billboard_2,TRUE],
	['QS_missionConfig_textures_infostand1',_infostand_1,TRUE],
	['QS_missionConfig_textures_infostand2',_infostand_2,TRUE],
	['QS_missionConfig_splash_serverRules',_serverRules,TRUE],
	['QS_missionConfig_splash_adminNames',_staffNames,TRUE],
	['QS_missionConfig_cosmetics',(compileFinal (str _monetizeCosmetics)),TRUE],
	['QS_missionConfig_monetizeURL',(compileFinal (str _monetizeURL)),TRUE]
];
{
	uiNamespace setVariable _x;
} forEach [
	['QS_fnc_serverCommandPassword',(compileFinal _serverCommandPassword)]
];
diag_log format ['***** %1 * Loaded mission parameters *****',diag_tickTime];