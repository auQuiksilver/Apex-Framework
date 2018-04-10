/*/
File: parameters.sqf
Author:

	Quiksilver
	
Last Modified:

	10/04/2018 A3 1.82 by Quiksilver
	
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

diag_log '***** Loading mission parameters *****';

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
_staffNames = 'bob (admin), billy (moderator), albert (moderator), carl (mission editor)';						// This text gets shown on the splash screen when player enters the game, customize as you like.

//===================================================== GAMEPLAY

_baseLayout = 0;										// Base layout.	0 - Default. 1 - Create custom base.		Note: With custom base, you will have to define all the spawn points and set all the marker positions manually. Caution: Its a lot of work!
_closeAirSupport = 2;									// Jets.		0 - Disabled. 1 - Whitelisted only. 2 - Enabled. 3 - Whitelisted+Linked to Pilot Transport Points.     This controls Fixed-wing Jets access. If Disabled, players will not have access to Jets and Armed UAV drones will not spawn.
_arsenal = 1;											// Arsenal.		0 - Unrestricted. 1 - Use Whitelist. 2 - Use Blacklist.			Caution! Blacklist is unconfigured by default, you will have to do it. Only whitelist comes pre-configured. Note: Currently in 1.0.7 the Blacklist only works for gear restriction, not the Arsenal menu until we can find a workaround.
_gearRestrictions = 1;									// Gear Restrictions.	0 - Disabled. 1 - Enabled. (Default = 1). 	Controls whether non-snipers can use sniper rifles, non-AT soldiers use missile launchers, etc.
_armor = 1;												// Armored Vehicles.	0 - Disabled. 1 - Enabled. (Default = 1). 		Controls whether players have access to respawning armored vehicles with default layout.
_reducedDamage = 1;										// Damage Modeling.		0 - Disabled. 1 - Enabled. (Default/Recommended 1).		Controls whether players have added body armor and dynamic damage modeling to balance ArmA AI accuracy/aimbot shortcomings, especially in jungle/forest areas. Recommended: 1.
_stamina = 0;											// Stamina.		0 - Optional. 1 - Forced On.	(Default: 0). If optional, players can toggle in menu.
_enemyCAS = 1;											// Enemy Fixed-Wing Aircraft.	0 - Disabled. 1 - Enabled. (Default = 1). Controls whether enemy have access to fixed-wing planes.
_commander = 2;											// [Beta] Commander role. 0 - Disabled. 1 - Enabled. 2 - Enabled & Whitelisted. (Default = 2). Commander role has the ability to give player groups and AI groups orders and waypoints, can talk on Side Channel, and view bodycam live feeds of any soldier.

//===================================================== SYSTEM

_restart_hours = [0,12,18];								// Hours (24hr clock) which server will restart. If you use this, disable your servers restart scheduler.   Leave blank to disable, like this:  _restart_hours = [];    Times are local to server machine (consider time zone). Recommended - 8hr intervals for steady play. 6hr intervals for constant full server. 12-16hr intervals for smaller server populations.

//===================================================== MAIN MISSION TYPE

_main_mission_type = 'NONE';

//========== DESCRIPTION===============================//
// 		'CLASSIC' 			Classic I&A. 					Recommended: 24-48+ players.			Example: 	_main_mission_type = 'CLASSIC';
// 		'SC' 				Sector Control.		 			Recommended: 36-64+ players.			Example: 	_main_mission_type = 'SC';
// 		'GRID'				Campaign (Beta). 				Recommended: 4-24+ players.				Example: 	_main_mission_type = 'GRID';				//---- This mission type is in Beta currently (9/12/2017)
// 		'NONE'				Primary missions disabled.												Example: 	_main_mission_type = 'NONE';				//---- Use this when you want to create Zeus missions and use the framework mechanics without the scripted missions.
//====================================================//	

//===================================================== AIRCRAFT CARRIER

_aircraft_carrier_enabled = 1;								// Presence.			0 - Disabled. 1 - Enabled. 2 - Enabled + Turret Defenses.    Note: Turret defenses will consume server/AI/CPU performance resources, recommended to not use.
_aircraft_carrier_vehicles = 1;								// Vehicle Spawning.	0 - None. 1 - Basic. 2 - Full.		This will interfere with _closeAirSupport config above, if Full (2) is used.  These are vehicles which spawn as part of the aircraft carrier package.
_aircraft_carrier_respawning = 1;							// Player Spawning.		0 - None. 1 - Jet pilots only. 2 - All players.		Mission designed for options 0 and 1 only. Advised to only use 2 if AO type == 'NONE' or on closed server.

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
_anticheat = 1;											// 0 - Disabled. 1 - Enabled. (Default 0). 		Disable if running mods or in private/secure setting.

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

//==================DO NOT EDIT BELOW=================== INTERPRETING MISSION PARAMETERS


if (!(_restart_hours isEqualTo [])) then {
	_restart_hours sort TRUE;
};
{
	missionNamespace setVariable _x;
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
	['QS_missionConfig_gearRestrictions',_gearRestrictions,TRUE],
	['QS_missionConfig_armor',_armor,TRUE],
	['QS_missionConfig_reducedDamage',(compileFinal (str _reducedDamage)),TRUE],
	['QS_missionConfig_restartHours',_restart_hours,TRUE],
	['QS_missionConfig_aoType',_main_mission_type,TRUE],
	['QS_missionConfig_carrierEnabled',_aircraft_carrier_enabled,TRUE],
	['QS_missionConfig_carrierVehicles',_aircraft_carrier_vehicles,TRUE],
	['QS_missionConfig_carrierRespawn',_aircraft_carrier_respawning,TRUE],
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
uiNamespace setVariable ['QS_fnc_serverCommandPassword',(compileFinal _serverCommandPassword)];
diag_log '***** Loaded mission parameters *****';