/*/
File: parameters.sqf
Author:

	Quiksilver
	
Last Modified:

	7/12/2017 A3 1.80 by Quiksilver
	
Description:

	Mission Parameters
	
Official Support/Help Channels:

	Discord: 	https://discord.gg/FfVaPce
	Forum: 		https://forums.bistudio.com/forums/topic/211146-invade-annex-apex-edition/
	Email: 		armacombatgroup@gmail.com
_______________________________________________________/*/

diag_log '***** Loading mission parameters *****';

//===================================================== COMMUNITY / SERVER

_teamspeak_server = 'ts3.address.com : 1234     - Password: N/A';			// Teamspeak server address, for use with map markers, etc. Customize this accordingly.		Example:	_teamspeak_server = 'ts3.address.com : 1234     - Password: N/A';
_discord_server = "'https://discord.gg/FfVaPce'";							// Discord server (change this to yours).	Example:	_discord_server = "'https://discord.gg/FfVaPce'";
_website_url = "'https://www.google.com'";									// Website URL of your website		Example:	_website_url = "'https://www.google.com'";
_arma_units_url = "'https://units.arma3.com'";								// url path to your A3 Unit		Example:	_arma_units_url = "'https://units.arma3.com'";

//===================================================== GAMEPLAY

_baseLayout = 0;										// Base layout.	0 - Default. 1 - Create custom base.		Note: With custom base, you will have to define all the spawn points and set all the marker positions manually. Caution: Its a lot of work!
_stamina = 0;											// Stamina.		0 - Optional. 1 - Forced On.	(Default: 0). If optional, players can toggle in menu.
_closeAirSupport = 2;									// Jets.		0 - Disabled. 1 - Whitelisted only. 2 - Enabled. 3 - Whitelisted+Linked to Pilot Transport Points.     This controls Fixed-wing Jets access. If Disabled, players will not have access to Jets and Armed UAV drones will not spawn.
_arsenal = 0;											// Arsenal.		0 - Unrestricted. 1- Restricted. Evaluated in fn_clientInteractArsenal.sqf .

//===================================================== SERVER RESTART SCHEDULE

_restart_hours = [0,12,18];								// Hours (24hr clock) which server will restart. Times are local to server machine (consider time zone). Recommended - 8hr intervals for steady play. 6hr intervals for constant full server. 12-16hr intervals for smaller server populations.

//===================================================== MAIN MISSION TYPE

_main_mission_type = 'NONE';

//========== DESCRIPTION===============================//
// 'CLASSIC' 			Classic I&A. 					Recommended: 24-48+ players.			Example: 	_main_mission_type = 'CLASSIC';
// 'SC' 				Sector Control.		 			Recommended: 36-64+ players.			Example: 	_main_mission_type = 'SC';
// 'GRID'				Campaign (Beta). 				Recommended: 4-24+ players.				Example: 	_main_mission_type = 'GRID';				//---- This mission type is in Beta currently (8/12/2017)
// 'NONE'				Primary missions disabled.												Example: 	_main_mission_type = 'NONE';
//====================================================//	


//===================================================== AIRCRAFT CARRIER

_aircraft_carrier_enabled = 1;								// Presence.			0 - Disabled. 1 - Enabled. 2 - Enabled + Turret Defenses.    Note: Turret defenses will consume server/AI/CPU performance resources, recommended to not use.
_aircraft_carrier_vehicles = 1;								// Vehicle Spawning.	0 - None. 1 - Basic. 2 - Full.		This will interfere with _closeAirSupport config above, if Full (2) is used.  These are vehicles which spawn as part of the aircraft carrier package.
_aircraft_carrier_respawning = 1;							// Player Spawning.		0 - None. 1 - Jet pilots only. 2 - All players.		Mission designed for options 0 and 1 only. Advised to only use 2 if AO type == 'NONE' or on closed server.

//===================================================== TEXTURES

_community_logo = '';
_community_flag_texture = 'a3\data_f\flags\flag_nato_co.paa';						// Community texture applied to some flags.		Default: 'a3\data_f\flags\flag_nato_co.paa'
_default_flag_texture = 'a3\data_f\flags\flag_nato_co.paa';							// Texture applied to friendly flags. 			Default: 'a3\data_f\flags\flag_nato_co.paa'
_billboard_1 = ['media\images\billboards\billboard3.jpg'];							// Textures applied to livefeed screen in default base. These parameters act as randomized arrays. Put more file paths in the [ ] array as desired. Example:   ['media\images\billboards\billboard3.jpg','media\images\billboards\billboard4.jpg'];
_billboard_2 = ['media\images\billboards\billboard4.jpg'];							// Textures applied to other screens in default base. These parameters act as randomized arrays. Put more file paths in the [ ] array as desired. Example:   ['media\images\billboards\billboard3.jpg','media\images\billboards\billboard4.jpg'];
_infostand_1 = ['media\images\billboards\billboard5.jpg'];							// Textures applied to info stands (V1) in default base. These parameters act as randomized arrays. Put more file paths in the [ ] array as desired. Example:   ['media\images\billboards\billboard3.jpg','media\images\billboards\billboard4.jpg'];
_infostand_2 = ['media\images\billboards\billboard6.jpg'];							// Textures applied to info stands (V2) in default base. These parameters act as randomized arrays. Put more file paths in the [ ] array as desired. Example:   ['media\images\billboards\billboard3.jpg','media\images\billboards\billboard4.jpg'];

//===================================================== SECURITY
														// Enter a server command password like this. It MUST match servercommandpassword from your server.cfg config file. ---> serverCommandPassword = "ShVQArtpGdc5aDQq"; This is important and some mission systems will not function without it.
_serverCommandPassword = "
	'ShVQArtpGdc5aDQq'
";
_anticheat = "1";											// 0 - Disabled. 1 - Enabled. (Default 1). 		Disable if running mods or in private/secure setting.		Example:	_anticheat = "1";   or    _anticheat = "0";

//===================================================== SPLASH MENU

_serverRules = '- No teamkilling<br/>- No destruction of friendly assets<br/>- No advertising<br/>- No verbal abuse<br/>- Pilots and UAV operator must be on TS<br/>- Staff word is final';		// Server rules shown on splash screen text. Structured Text. Note: there are more rules listed in fn_diary.sqf
_staffNames = 'bob (admin), billy (moderator), albert (moderator), carl (mission editor)';		// This text gets shown on the splash menu when player enters the game, customize as you like.

//===================================================== OTHER

// Cosmetics system (uniform + vehicle + shoulder patches). 	
// Controls access to [Area 51] vehicle/uniform/insignia texture system.
// 0 - Disabled (None have access). 								Example:	_monetizeCosmetics = "0";
// 1 - Enabled (Only whitelisted S3 have access). 					Example:	_monetizeCosmetics = "1";
// 2 - All have access.												Example:	_monetizeCosmetics = "2";
_monetizeCosmetics = "0";

// Link for direct donations toward your server/community + whitelisting + cosmetics,etc. Replace this with your own, or leave blank. Google URL shortener tool is useful here.
// Example for leaving it blank:	_monetizeURL = "";
// Example for use:					_monetizeURL = "'https://goo.gl/tNSc6c'";
_monetizeURL = "";

//==================DO NOT EDIT BELOW=================== INTERPRETING MISSION PARAMETERS

_restart_hours sort TRUE;
{
	missionNamespace setVariable _x;
} forEach [
	['QS_missionConfig_commTS',_teamspeak_server,TRUE],
	['QS_missionConfig_commDS',(compileFinal _discord_server),TRUE],
	['QS_missionConfig_commURL',(compileFinal _website_url),TRUE],
	['QS_missionConfig_commA3U',(compileFinal _arma_units_url),TRUE],
	['QS_missionConfig_baseLayout',_baseLayout,FALSE],
	['QS_missionConfig_AH',(compileFinal _anticheat),TRUE],
	['QS_missionConfig_stamina',_stamina,TRUE],
	['QS_missionConfig_CAS',_closeAirSupport,TRUE],
	['QS_missionConfig_Arsenal',_arsenal,TRUE],
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
	['QS_missionConfig_cosmetics',(compileFinal _monetizeCosmetics),TRUE],
	['QS_missionConfig_monetizeURL',(compileFinal _monetizeURL),TRUE]
];
uiNamespace setVariable ['QS_fnc_serverCommandPassword',(compileFinal _serverCommandPassword)];
diag_log '***** Loaded mission parameters *****';