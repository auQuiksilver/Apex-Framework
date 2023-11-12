diag_log format ['***** %1 * Loading mission parameters *****',diag_tickTime];
/*/
File: parameters.sqf
Author:

	Quiksilver
	
Last Modified:

	12/11/2023 A3 2.14 by Quiksilver
	
Description:

	Mission Parameters
	
Official Support/Help Channels:

	Discord: 	https://discord.gg/FfVaPce
	Forum: 		https://forums.bistudio.com/forums/topic/212240-apex-framework/
	Email: 		armacombatgroup@gmail.com
	
For URLs:

	Use Google URL Shortener ( https://goo.gl/ ) to make something like this:   https://goo.gl/7Xajd9
	
Goo.gl alternatives:

	https://www.androidauthority.com/best-google-url-shortener-alternatives-853168/
	
Notes for editing below:

	- Remember to change your ServerCommandPassword here, and match it to the password in your server.cfg file:   _serverCommandPassword = "'ShVQArtpGdc5aDQq'";
	- Be aware of the quotation marks " and ', they need to be what they are. Notice in links there are two sets of quotations:   "'https://goo.gl/7Xajd9'"     and for servercommandpassword:   _serverCommandPassword = "'ShVQArtpGdc5aDQq'";
	- Improving this file will likely be an ongoing task. save and backup your copy before downloading a new one. be careful with pasting info from one to the other, as data types may change.
_______________________________________________________/*/

//===================================================== COMMUNITY / SERVER

_teamspeak_server = 'Discord: ';						// Teamspeak server address, for use with map marker, map tabs, ec. Customize this accordingly.		Example:	_teamspeak_server = 'ts3.address.com : 1234     - Password: N/A';
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
_splashMenu = 0;										// Does splash menu appear when first spawns? 0 - Disabed. 1 - Enabled.
_introMusic = 1;										// Intro Music. 0 - Disabled. 1 - Enabled. Music/Audio player hears when they join server.

//===================================================== GAMEPLAY

_baseLayout = 0;										// Base layout.	0 - Integrated base. 1 - Custom base.		Note: With custom base, you will have to define all the spawn points and set all the marker positions manually. Caution: Its a lot of work!
_closeAirSupport = 2;									// Jets.		0 - Disabled. 1 - Whitelisted only. 2 - Enabled. 3 - Whitelisted+Linked to Pilot Transport Points.     This controls Fixed-wing Jets access. If Disabled, players will not have access to Jets and Armed UAV drones will not spawn.
_enemyCAS = 1;											// Enemy Fixed-Wing Aircraft.	0 - Disabled. 1 - Enabled. (Default = 1). Controls whether enemy have access to fixed-wing planes.
_jetLaser = 0;											// Jet Laser Designator. 0 - Disabled. 1 - Enabled.		Do jet pilots have the ability to self-designate targets with laser designator.
_arsenal = 3;											// Arsenal.		0 - Unrestricted (scripted). 1 - Use Whitelist (scripted). 2 - Use Blacklist (scripted). 3 - Vanilla arsenal (unscripted).	(Recommended = 1).			Caution! Blacklist is unconfigured by default, you will have to do it. Only whitelist comes pre-configured.    #3 will disable scripted gear restrictions.
_armor = 1;												// Armored Vehicles.	0 - Disabled. 1 - Enabled. (Default = 1). 		Controls whether players have access to respawning armored vehicles with default layout.
_reducedDamage = 1;										// Damage Modeling.		0 - Disabled. 1 - Enabled. (Default/Recommended 1).		Controls whether players have added body armor and dynamic damage modeling to balance ArmA AI accuracy/aimbot shortcomings, especially in jungle/forest areas. Recommended: 1.
_stamina = 0;											// Stamina.		0 - Optional. 1 - Forced On.	(Default: 0). If optional, players can toggle in menu.
_commander = 0;											// Commander role. 0 - Disabled. 1 - Enabled. 2 - Enabled & Whitelisted. (Default = 2). Commander role has the ability to give player groups and AI groups orders and waypoints, can talk on Side Channel.
_artillery = 1;											// Base artillery.	0 - Disabled. 1 - Player Controlled. 2 - AI Controlled. 	If enabled, a self-propelled artillery asset is available for use. Does not affect Mk.6 mortars access. Does not affect naval artillery.
_artilleryComputer = 1;									// Artillery Computer settings. 	0. Disabled. 	1 - Enabled ONLY while in scripted base artillery.		2 - Enabled. (Recommended = 1). Note: Applies to mortars as well.
_mapContentEnemy = 1;									// Enemy Map Indicators. 	0 - Disabled. 1 - Enabled. Recommended = 1.	    Controls whether enemies known to the player are visible on the map.
_recruitableAI = 1;										// Recruitable AI.	0 - Disabled. 1 - Enabled. 		If there are recruitable AI available (default base layout or placed by you in custom base layout), this toggles them on or off.
_playable_opfor = 0;									// OPFOR player roles. 	0 - Disabled. 1 - Enabled (Whitelisted). 2 - Enabled (Unrestricted).	Recommended = 0.	Enable a limited number of enemy player roles for the supported mission types. Highly recommended to NOT use with the standard missions unless you know your players are comfortable with it. Designed for future Framework flexibility and development.
_ambient_civilians = 1;									// Ambient Civilians.	0 - Disabled. 1 - Enabled. Default = 1.		Disable to save FPS. 	Ambient civilian presence is auto-disabled when player count > 50.
_ambient_animals = 1;									// Ambient Animals.		0 - Disabled. 1 - Enabled. Default = 1.		Disable to save FPS.	Ambient animal presence is auto-disabled when player count > 50.
_vehicle_active_protection = 3;							// Vehicle Active Protection System. 	0 - Disabled. 1 - AI only. 2 - Players only. 3 - AI and players.
_hitMarker_audio = 1;									// Hit Marker Sound.	0 - Disabled. 1 - Enabled (Optional). Default = 1.		Plays a small audio cue when your bullet hits an enemy.
_effectKnockdown = 1;									// Knock-Down effect.	0 - Disabled. 1 - Enabled (Default).	Player can be knocked down in combat (without being incapacitated).
_craters = 24;											// Artillery Crater Effects.	0 - Disabled. 1+ - Enabled. This number is also how many craters will be spawned at any time, oldest get deleted first.
_groupForced = 0;										// Ungrouped players put into registered main group. 0 - Disabled. 1 - Enabled.			https://community.bistudio.com/wiki/Arma_3:_Dynamic_Groups
_groupRegisterInit = 0;									// Register Player Group to Dynamic Groups on server join. 0 - Disabled. 1 - Enabled.		https://community.bistudio.com/wiki/Arma_3:_Dynamic_Groups
_groupLocking = 1;										// Group Lock Ability. 0 - Disabled. 1 - Enabled (default).		Are players able to lock groups they create. Admins can join any group regardless of Lock state.
_groupWaypoint = 1;										// Group Map Waypoint. 0 - Disabled. 1 - Enabled (default).		Can players see their group leaders [Shift+Click] dot on the map.
_enemyUrbanSpawning = 1;								// (Classic Mode) Enemy urban reinforcement spawning. A new system for "CLASSIC" gamemode, to allow enemy to spawn in towns. We add this toggle incase there are unseen bugs.
_tracers = 1;											// Tracer bullets. 0 - Vanilla handling. 1 - At night and low-pop times, AI get tracer bullets. 2 - AI get tracers at all times. Default - 1.
_enemyGearRandomization = 1;							// Randomize Enemy Gear.  0 - Disabled. 1 - Enabled.	If Enabled, enemy gear will be randomized and they will not always receive the default loadout.
_vehicleRoleRestriction_heli = 1;						// Heli restriction. 0 - Any role can use helicopter. 1 - Only pilots can use helicopter.
_vehicleRoleRestriction_plane = 1;						// Plane restriction. 0 - Any role can use planes. 1 - Only fighter pilots can use planes.
_customPylonPresets = 1;								// Aircraft Pylon Presets. 0 - Vanilla. 1 - Custom (Default).	0 - Pilots can set vanilla pylon presets. 1 - Pilots can only set custom pylon presets. BEWARE!!! Pilot will have access to otherwise restricted loadouts: Cluster bombs, ATGM, etc.
_attachExplosives = 1;									// Attach Explosives to vehicles. 0 - scripted vehicles only. 1 - any vehicles (non-player-occupied at moment of attach).
_wrecks = 1;											// Can vehicles get wrecked and require recovery? 0 - Disabled. 1 - Enabled.
_bobcatRecovery = 0;									// Can Bobcat recover wrecks?	0 - Disabled. 1 - Enabled.	Makes it a bit too easy, so we leave disabled but optional.  
_vehicleLock = 1;										// Lock Driver Seat. 0 - Disabled. 1 - Only members of vehicle owners group can toggle the Drivers seat lock.
_vehicleCargoLock = 1;									// Logistics Lock. 0 - Disabled. 1 - Only members of vehicle owners group can toggle the Logistics lock.	Handles: Inventory, Cargo, Sling Loading, Towing.
_vehicleGroupLock = 0;									// Can other members of players group lock/unlock the vehicle. 0 - Disabled, locking is individual-based.  1 - Enabled, locking is group-based.
_autohover = 1;											// Can pilots use autohover? 0 - Disabled. 1 - Enabled.
_autopilot = 1;											// Can pilots use landing autopilot? 0 - Disabled. 1 - Enabled.
_planeForce1PV = 0;										// Are Plane pilots forced to use First Person View? 0 - Disabled (not forced). 1 - Enabled (forced).		
_quickBuild = 1;										// Player role-based ability to build fortifications/sandbags/etc. 0 - Disabled. 1 - Enabled.
_maxSandbags = 100;										// Global cap on player-deployable fortifications.
_maxBuiltObjects = 500;									// Global cap on base-building objects (does not include player sandbags).
_towing = 1;											// Towing mechanics. 0 - Disabled. 1 - Enabled. Most vehicles (Land and Boat) can Tow in one way or another.
_winch = 2;												// Winch mechanics. 0 - Disabled. 1 - Configured vehicles (* See note --> ). 2 - All land vehicles.   * Some vanilla vehicles have visible winches: Hunter, Strider, Prowler LSV, Offroad, Bobcat, Zamak MLRS
_mass = 1;												// Simulate vehicle mass changes based on weight of cargo.	 (Recommended = 0).	0 - Disabled. 1 - Enabled.
_centerofmass = 1;										// Simulate vehicle center-of-mass based on cargo it is carrying. 	(Recommended = 1). 0 - Disabled. 1 - Vehicle-In-Vehicle Cargo only.   2. All cargo objects.   Use with caution!
_role_selection_menu_button = 0;						// Role Selection Menu Button. 	Enables a button in the Escape Menu to access the Role Selection Menu.	0 - Disabled. 1 - Enabled. Default - 0.		Use this option to allow any player to change their role from any map location. If this value is 0, the only way to access the menu after login is via Arsenal crates user action. Recommend 0 for standard gamemodes to avoid exploitation.
_deploymentMenu = 1;									// Deployment Menu. 0 - Disabled. 1 - Enabled.
_deployMenuOnRespawn = 1;								// Deployment Menu shown on Respawn. 0 - Disabled. 1 - Enabled.
_deployMenuHome = 1;									// Can Players set a Home deployment in Deployment Menu. 0 - Disabled. 1 - Enabled.
_weaponLasers = 1;										// (Experimental!!!) 0 - Disabled. 1 - Enabled. 	Enable custom weapon lasers.	Note: Takes some CPU (client only. no effect on server), has a performance cost if many are using in small area. Does not affect server performance.
_weaponLasersColorForced = [-1,-1,-1];					// Laser Color. Force color of custom weapon lasers (RGB). [-1,-1,-1] = players receive random or can set their own in profile. [1000,0,0] = Standard red. Info: https://community.bistudio.com/wiki/drawLaser
_weaponLasersHighPower = 1;								// Laser Power. 0 - Low Power only. 1 - Low and High power (selectable).
_fireSupport = 2;										// Fire Support Module. 0 - Disabled. 1 - Player Support only. 2 - AI and Player Support.	Players are able to call in available fire supports. If 2, players can call support from some AI.

//===================================================== SYSTEM

_restart_hours = [12];									// Hours (24hr clock) which server will restart. If you use this, disable your servers restart scheduler.   Leave blank to disable, like this:  _restart_hours = [];    Times are local to server machine (consider time zone). Recommended - 8hr intervals for steady play. 6hr intervals for constant full server. 12-16hr intervals for smaller server populations.
_restart_dynamic = 1;									// Dynamic Server Restarts. 0 - Disabled. 1 - Enabled. If enabled, Server will wait for mission conditions to be met before restarting. This option is currently only used for Defend missions.
_dynamic_simulation = 1;								// Dynamic Simulation. 	0 - Disabled. 1 - Enabled. 	Raises FPS and performance slightly. Server freezes entities which are far away from all players.    Info: https://community.bistudio.com/wiki/Arma_3_Dynamic_Simulation
_startDate = [];										// Set Start Date (Including time). [] = Disabled. [<year>,<month>,<day>,<hour>,<minute>].	// [2026,10,30,14,30]	= Oct 30 2026 at 2:30pm
_timeMultiplier = [										// Time Multiplier. Set all values to 1 for real-time.
	12,														// Night/dark time acceleration multiplier. Default - 12.
	1,														// Noon/mid-day time acceleration multiplier. Default - 1.
	0.35													// Morning/Evening/Dawn/Dusk time acceleration multiplier. Default - 0.35.
];
_weatherDynamic = 1;									// Dynamic Weather System. 0 - Disabled. 1 - Enabled (Default). 	If enabled, framework will maintain persistent dynamic weather with realistic annual weather cycles for the geographic terrain location.
_weatherForcedMode = -1;									// Forced Weather Mode. -1 = Disabled.  !Automatically disables Dynamic Weather!	 0 - Clear skies. 1 - Overcast/Cloudy. 2 - Rain. 3 - Storm. 4 - Snow.
_logReportFrequency = 60;								// Server RPT log reports general information every X seconds. -1 = disabled. 60 = 1 minute, 300 = 5 minutes, etc.

//===================================================== ZEUS

_zeusModePlayerRespawn = 1;								// (Zeus Mode) Dynamic Player Respawn. Applies ONLY when _main_mission_type = 'ZEUS';. 0 - Players respawn at base. 1 - Players respawn at a Flag Pole that Zeus can move around. 
_zeusModeRespawnMarker = 1;								// (Zeus Mode) Zeus Respawn Position is visible on map. 0 - Disabled. 1 - Enabled.
_zeusModeArsenalFlag = 1;								// (Zeus Mode) When players spawn at Zeus flag pole, Flag Pole is an Arsenal too.	0 - Disabled.  1 - Enabled.
_zeusCanOffloadAI = 1;									// (All Modes) Zeus ability to offload AI to Server.	0 - Disabled. 1 - Enabled. Default - 1.	 Allows Zeus to improve performance of Zeus missions by moving AI control to server. Unbuffered, there is no limit and server can be overloaded, so use responsibly.
_zeusRestrictions = 1;									// Are some modules and objects disabled in zeus?	0 - Restrictions disabled. 1 - Restrictions enabled.	Default = 1
_zeusLightning = 1;										// Can Zeus use lightning? 0 - Disabled. 1 - Enabled. Default = 0 	Lightning is somewhat immersion breaking and there are other ways to destroy things.	Only applies if _zeusRestrictions = 1

//===================================================== HEADLESS CLIENT

_hc_maxLoad_1 = 80;										// Quantity of AI units to distribute to the Headless Client when only 1 headless client is connected.
_hc_maxLoad_2 = 60;										// Quantity of AI units to distribute to each Headless Client when 2 headless clients are connected.
_hc_maxLoad_3 = 40;										// Quantity of AI units to distribute to each Headless Client when 3 headless clients are connected.
_hc_maxLoad_4 = 25;										// Quantity of AI units to distribute to each Headless Client when 4 or more headless clients are connected.
_hc_maxAgents_1 = 20;									// Quantity of AI agents (Civilians & Animals) to distribute to the Headless Client when only 1 headless client is connected.
_hc_maxAgents_2 = 15;									// Quantity of AI agents (Civilians & Animals) to distribute to each Headless Client when 2 headless clients are connected.
_hc_maxAgents_3 = 10;									// Quantity of AI agents (Civilians & Animals) to distribute to each Headless Client when 3 headless clients are connected.
_hc_maxAgents_4 = 5;									// Quantity of AI agents (Civilians & Animals) to distribute to each Headless Client when 4 or more headless clients are connected.

//===================================================== DLC/MODs Support
// Available options by default for auto-detect: 
//
//			'WS' 'VN' 'CSLA' 'GM'

_dlc = '';												// Leave as '' blank to run in Auto-Detect mode (auto-detect works only for the DLC listed above). Tells the framework which DLC/Mod to read.
_dlc_vehicles = '';										// Leave as '' blank to run in Auto-Detect mode (auto-detect works only for the DLC listed above). Determines which list of vehicles are spawned.		_dlc_vehicles = 'CSLA';	
_dlc_units = '';										// Leave as '' blank to run in Auto-Detect mode (auto-detect works only for the DLC listed above). Determines which list of infantry are spawned.
_zeus_reskinUnits = 0;									// Do vanilla units spawned with zeus get re-skinned with modded clothing (according to "code\config\QS_data_tableUnits.sqf"). 0 - Disabled. 1 - Enabled.
_basic_reskin = 0;										// ONLY USE FOR MODDED UNITS. 0 - Disabled. 1 - Enabled. 	Reskin vanilla AI soldiers with the gear of modded AI soldiers.
_basic_reskin_params = [
	['rhs_msv_rifleman'],								// Opfor modded reskin classes (randomized). Leave empty to ignore. Array of modded soldier classnames to reskin all vanilla OPFOR units with. not uniform classnames.
	['rhsusf_usmc_marpat_wd_rifleman'],					// Blufor modded reskin classes (randomized). Leave empty to ignore. Array of modded soldier classnames to reskin all vanilla BLUFOR units with. not uniform classnames.
	['rhs_msv_rifleman'],								// Indfor modded reskin classes (randomized). Leave empty to ignore. Array of modded soldier classnames to reskin all vanilla INDFOR units with. not uniform classnames.
	[]													// Civilian modded reskin classes (randomized). Leave empty to ignore. Array of modded soldier classnames to reskin all vanilla CIVILIAN units with. not uniform classnames.
];

//===================================================== MAIN MISSION TYPE
//========== DESCRIPTION===============================//
// 		'CLASSIC' 			Classic I&A. 					Recommended: 24-48+ players.			Example: 	_main_mission_type = 'CLASSIC';
// 		'SC' 				Sector Control.		 			Recommended: 36-64+ players.			Example: 	_main_mission_type = 'SC';
// 		'GRID'				Insurgency Campaign. 			Recommended: 4-24+ players.				Example: 	_main_mission_type = 'GRID';				//---- This mission type is in Beta currently (9/12/2017)
// 		'ZEUS'				Zeus Mode.																Example: 	_main_mission_type = 'ZEUS';				//---- Use this when you want to create Zeus missions and use the framework mechanics without the scripted missions.
//====================================================//	

_main_mission_type = 'CLASSIC';

//===================================================== SIDE MISSIONS

_sideMissions = 1;										// Side Missions.	0 - Disabled. 1 - Enabled. (Default = 1).	Set 0 to disable default side missions. Automatically disabled when _main_mission_type = 'NONE';

//===================================================== SANDBOX COMBAT MISSIONS

_deploymentMissions = 1;								// Can enemy attack player-built bases? 0 - Disabled. 1 - Enabled.
_dm_MaxConcurrent = 1;									// How many deployments can be attacked simultaneously? 1-10.	Min = 1, Max = 10. Default = 3.
_dm_Frequency = 0.3;									// How frequent are deployment attacks? 0-1. 	0 = Very rare. 1 = Very often.		0 is about once an hour. 1 = every 60 seconds. 0.5 = ~30 minutes. 0.85 = 10 minutes.
_dm_Intensity = 0.5;									// How intense are the attacks? 0-1. 	0 - Low intensity. 1 - High intensity.	Default = 0.5	Basically, how many enemies?
_dm_Duration = 0.25;										// How long can the attacks go for? 0-1. 	0 - Short duration (5 mins). 1 - Long duration (60 mins). Default = 0.5
_dm_SetupTime = 1200;									// How long after deployment until enemies can attack it.	Counted in seconds. Default = 300
_dm_overclock = 0;										// !Careful! Uncapped, can kill performance. Manually set the quantity of enemy per assault. 0 - Disabled.   _dm_overclock = 50;  // 50 enemy.   _dm_overclock = 150;  // 150 enemy. etc.

//===================================================== STATIC SHIPS
// Aircraft Carrier
_aircraft_carrier_enabled = 0;								// Presence.			0 - Disabled. 1 - Enabled. 2 - Enabled + Turret Defenses.    Note: Turret defenses will consume server/AI/CPU performance resources, recommended to not use.
_aircraft_carrier_vehicles = 2;								// Vehicle Spawning.	0 - None. 1 - Basic. -2  Full.		This will interfere with _closeAirSupport config above, if Full (2) is used.  These are vehicles which spawn as part of the aircraft carrier package.
_aircraft_carrier_respawning = 0;							// Player Spawning.		0 - None. 1 - Jet pilots only. 2 - All players.		Mission designed for options 0 and 1 only. Advised to only use 2 if AO type == 'NONE' or on closed server.
// Destroyer
_destroyer_enabled = 1;										// Presence.			0 - Disabled. 1 - Enabled. 2 - Enabled + Turret Defenses.    Note: Turret defenses will consume server/AI/CPU performance resources, recommended to not use.
_destroyer_vehicles = 2;									// Vehicle Spawning.	0 - None. 1 - Basic. 2 - Full. These are vehicles which spawn as part of the destroyer package. 1 = boats only, 2 = boats + helicopter.
_destroyer_respawning = 0;									// Player Spawning.		0 - None. 1 - All players will (re)spawn on the ship. 		Note: This option is overridden by  "_aircraft_carrier_respawning" option above. Jet pilots will also respawn on the carrier, even if both are available.
_destroyer_artillery = 1;									// Naval Artillery.		0 - Disabled. 1 - Enabled.	Recommended = 0.	Enable the MK41 VLS Missile Artillery System & MK45 Hammer Naval Gun.
_destroyer_flag = 'a3\data_f\flags\flag_us_co.paa';			// Texture applied to Destroyer flag. Default:  'a3\data_f\flags\flag_us_co.paa'
_destroyer_name = 'a3\boat_f_destroyer\destroyer_01\data\destroyer_01_tag_01_co.paa';		// Name presented on stern of ship. Comes with 7 defaults, just change ..._tag_01_co... to _tag_02_co... etc, from 01 to 07, 00 is blank. You can also set as a custom texture/name/logo.
_destroyer_numbers = [4,2,0];								// Numbers shown on the ship hull.
_destroyer_hangar = 0;										// Hangar Door initial state. 0 - Hangar doors start closed. 1 - Hangar doors start opened.

//===================================================== CONTAINERS
// This section handles container spawning.
// Spawn location still needs to be set manually, this section merely enables/disables them from spawning.
// Primarily meant for Zeus Mode, but can also be used in other modes.

_fobs_default = 1;						// The default FOBs that spawn around the map. 0 - Disabled. 1 - Enabled.
_container_mobileRespawn = 1;			// White. Acts as a mobile respawn with respawn tickets.
_container_baseSmall = 1;				// Lite Green. Small fortification "Patrol Base"
_container_baseMedium = 1;				// Dark Green. Medium fortification "Combat Outpost"
_container_baseLarge = 1;				// Dark Grey. Large fortification. "FOB". Has integrated Arsenal.
_container_platform = 1;				// Sand. 		Platform/Bridge module.
_container_terrain = 1;					// Yellow. 		Terrain deformer module.
_container_SAM = 1;						// Dark Blue.	Deployable Missile System.
_container_radar = 1;					// Cyan. 		Deployable Radar.

//===================================================== TEXTURES

_IconColor3D = [0,125,255];									// Default R G B colors for 3D hex/nametag icons
_community_logo = '';
_community_flag_texture = 'a3\data_f\flags\flag_nato_co.paa';						// Community texture applied to some flags.		Default: 'a3\data_f\flags\flag_nato_co.paa'
_default_flag_texture = 'a3\data_f\flags\flag_nato_co.paa';							// Texture applied to friendly flags. 			Default: 'a3\data_f\flags\flag_nato_co.paa'
_billboard_1 = ['media\images\billboards\billboard3.jpg','media\images\billboards\billboard3.jpg'];							// Textures applied to livefeed screen in default base. These parameters act as randomized arrays. Put more file paths in the [ ] array as desired. Example:   ['media\images\billboards\billboard3.jpg','media\images\billboards\billboard4.jpg'];
_billboard_2 = ['media\images\billboards\billboard4.jpg','media\images\billboards\billboard4.jpg'];							// Textures applied to other screens in default base. These parameters act as randomized arrays. Put more file paths in the [ ] array as desired. Example:   ['media\images\billboards\billboard3.jpg','media\images\billboards\billboard4.jpg'];
_infostand_1 = ['media\images\billboards\billboard5.jpg','media\images\billboards\billboard5.jpg'];							// Textures applied to info stands (V1) in default base. These parameters act as randomized arrays. Put more file paths in the [ ] array as desired. Example:   ['media\images\billboards\billboard3.jpg','media\images\billboards\billboard4.jpg'];
_infostand_2 = ['media\images\billboards\billboard6.jpg','media\images\billboards\billboard6.jpg'];							// Textures applied to info stands (V2) in default base. These parameters act as randomized arrays. Put more file paths in the [ ] array as desired. Example:   ['media\images\billboards\billboard3.jpg','media\images\billboards\billboard4.jpg'];

//===================================================== SECURITY

_serverCommandPassword = "'abc123'";			// Enter a server command password like this. It MUST match servercommandpassword from your server.cfg config file. ---> serverCommandPassword = "ShVQArtpGdc5aDQq"; This is important and some mission systems will not function without it.
/*/QS Note: Not currently compatible with 1.5.x /*/ _anticheat = 0;	// 0 - Disabled. 1 - Enabled. (Default 1). 		Disable if running mods or in private/secure setting.

//===================================================== MONETIZATION

// Cosmetics system (uniform + vehicle + shoulder patches). 	
// Controls access to [Area 51] vehicle/uniform/insignia texture system.

_monetizeCosmetics = 1;									// 0 - Disabled (None have access). 1 - Enabled (Only whitelisted "S3" have access). 2 - All have access.

// Link for direct donations toward your server/community + whitelisting + cosmetics,etc. Replace this with your own, or leave blank.
// This option can be seen in your Player Menu under [Comm-Link]. Player menu default key binding is [Home], and also in the Escape menu, top button.

_monetizeURL = [
	"'https://goo.gl/7Xajd9'",											// Monetization URL.
	"Donate",															// Button text.
	"Link 4"															// Tooltip (text shown when mouse hovering over button).
];










//================== DO NOT EDIT BELOW =================== INTERPRETING MISSION PARAMETERS
systemTime params ['','_month','_day','','','',''];
if (_arsenal isEqualTo 3) then {};
if (_restart_hours isNotEqualTo []) then {
	_restart_hours sort TRUE;
};
if (_weatherForcedMode > -1) then {
	_weatherDynamic = 0;
};
if (
	(_month isEqualTo 12) &&
	(_day isEqualTo 25)
) then {
	_weatherForcedMode = 4;
	_weatherDynamic = 0;
};
if (
	(_aircraft_carrier_enabled > 0) &&
	{(_aircraft_carrier_respawning > 1)} &&
	{(_destroyer_enabled > 0)} &&
	{(_destroyer_respawning > 0)}
) then {
	_destroyer_respawning = 0;
};
if (!(worldName in ['Altis','Tanoa','Malden','Enoch','Stratis'])) then {
	_anticheat = 0;
};
if (_main_mission_type isEqualTo 'ZEUS') then {
	_sideMissions = 0;
};
if ((count _startDate) > 5) then {
	_startDate = _startDate select [0,5];
};
/*/QS Note: Not currently compatible with 1.5.x /*/ _anticheat = 0;
{
	missionNamespace setVariable _x;
	diag_log str ([_x # 0,_x # 1]);
} forEach [
	['QS_missionConfig_splash',_splashMenu > 0,TRUE],
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
	['QS_missionConfig_AmbCiv',_ambient_civilians,FALSE],
	['QS_missionConfig_AmbAnim',_ambient_animals,FALSE],
	['QS_missionConfig_APS',_vehicle_active_protection,TRUE],
	['QS_missionConfig_hitMarker',_hitMarker_audio,TRUE],
	['QS_missionConfig_knockdown',_effectKnockdown > 0,TRUE],
	['QS_missionConfig_craterEffects',_craters,TRUE],
	['QS_missionConfig_joinUngrouped',_groupForced > 0,TRUE],
	['QS_missionConfig_registerInitGroup',_groupRegisterInit > 0,TRUE],
	['QS_missionConfig_groupLocking',_groupLocking > 0,TRUE],
	['QS_missionConfig_groupWaypoint',_groupWaypoint > 0,TRUE],
	['QS_missionConfig_aoUrbanSpawning',_enemyUrbanSpawning,FALSE],
	['QS_missionConfig_tracers',_tracers,TRUE],
	['QS_missionConfig_enemyRandGear',_enemyGearRandomization > 0,TRUE],
	['QS_missionConfig_introMusic',_introMusic > 0,TRUE],
	['QS_missionConfig_jetLaser',_jetLaser > 0,TRUE],
	['QS_missionConfig_roleRestrictionHeli',_vehicleRoleRestriction_heli > 0,TRUE],
	['QS_missionConfig_roleRestrictionPlane',_vehicleRoleRestriction_plane > 0,TRUE],
	['QS_missionConfig_pylonPresets',_customPylonPresets,TRUE],
	['QS_missionConfig_attachExplosives',_attachExplosives > 0,TRUE],
	['QS_missionConfig_weaponLasers',_weaponLasers > 0,TRUE],
	['QS_missionConfig_wrecks',_wrecks > 0,TRUE],
	['QS_missionConfig_bobcatRecovery',_bobcatRecovery > 0,TRUE],
	['QS_missionConfig_seatLocking',_vehicleLock,TRUE],
	['QS_missionConfig_cargoLocking',_vehicleCargoLock,TRUE],
	['QS_missionConfig_vehicleGroupLock',_vehicleGroupLock > 0,TRUE],
	['QS_missionConfig_autohover',_autohover > 0,TRUE],
	['QS_missionConfig_autopilot',_autopilot > 0,TRUE],
	['QS_missionConfig_plane1PV',_planeForce1PV > 0,TRUE],
	['QS_missionConfig_quickBuild',_quickBuild,TRUE],
	['QS_missionConfig_maxPlayerBuildables',_maxSandbags,TRUE],
	['QS_missionConfig_maxBuild',_maxBuiltObjects,TRUE],
	['QS_missionConfig_interactTowing',_towing > 0,TRUE],
	['QS_missionConfig_interactWinch',_winch,TRUE],
	['QS_missionConfig_mass',_mass > 0,TRUE],
	['QS_missionConfig_centerOfMass',_centerofmass,TRUE],
	['QS_missionConfig_RSS_MenuButton',_role_selection_menu_button,TRUE],
	['QS_missionConfig_deployment',_deploymentMenu > 0,TRUE],
	['QS_missionConfig_respawnDeploy',_deployMenuOnRespawn > 0,TRUE],
	['QS_missionConfig_deployMenuHome',_deployMenuHome > 0,TRUE],
	['QS_missionConfig_weaponLasers',_weaponLasers > 0,TRUE],
	['QS_missionConfig_weaponLasersForced',_weaponLasersColorForced,TRUE],
	['QS_missionConfig_weaponLasersHiPower',_weaponLasersHighPower > 0,TRUE],
	['QS_missionConfig_fireSupport',_fireSupport,TRUE],
	['QS_missionConfig_restartHours',_restart_hours,TRUE],
	['QS_missionConfig_restartDynamic',_restart_dynamic,FALSE],
	['QS_missionConfig_dynSim',_dynamic_simulation,FALSE],
	['QS_missionConfig_startDate',_startDate,FALSE],
	['QS_missionConfig_timeMultiplier',_timeMultiplier,FALSE],
	['QS_missionConfig_weatherDynamic',_weatherDynamic > 0,TRUE],
	['QS_missionConfig_weatherForced',_weatherForcedMode,TRUE],
	['QS_missionConfig_logFrequency',_logReportFrequency,FALSE],
	['QS_missionConfig_zeusRespawnFlag',_zeusModePlayerRespawn > 0,TRUE],
	['QS_missionConfig_zeusRespawnMarker',_zeusModeRespawnMarker > 0,FALSE],
	['QS_missionConfig_zeusRespawnArsenal',_zeusModeArsenalFlag > 0,TRUE],
	['QS_missionConfig_zeusRestrictions',_zeusRestrictions > 0,TRUE],
	['QS_missionConfig_zeusLightning',_zeusLightning > 0,TRUE],
	['QS_missionConfig_zeusOffload',_zeusCanOffloadAI > 0,TRUE],
	['QS_missionConfig_hcMaxLoad',[_hc_maxLoad_1,_hc_maxLoad_2,_hc_maxLoad_3,_hc_maxLoad_4],TRUE],
	['QS_missionConfig_hcMaxAgents',[_hc_maxAgents_1,_hc_maxAgents_2,_hc_maxAgents_3,_hc_maxAgents_4],TRUE],
	['QS_missionConfig_dlcVehicles',_dlc_vehicles,TRUE],
	['QS_missionConfig_dlcUnits',_dlc_units,TRUE],
	['QS_missionConfig_zeusReskinUnits',_zeus_reskinUnits > 0,TRUE],
	['QS_missionConfig_dlcReskin',_basic_reskin > 0,FALSE],
	['QS_missionConfig_dlcReskinParams',_basic_reskin_params,FALSE],
	['QS_missionConfig_aoType',_main_mission_type,TRUE],
	['QS_missionConfig_sideMissions',_sideMissions,FALSE],
	['QS_missionConfig_deploymentMissions',_deploymentMissions > 0,FALSE],
	['QS_missionConfig_deploymentMissionParams',[_dm_MaxConcurrent,_dm_Frequency,_dm_Intensity,_dm_Duration,_dm_SetupTime,_dm_overclock],FALSE],
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
	['QS_missionConfig_fobsDefault',_fobs_default > 0,FALSE],
	['QS_missionConfig_cntnrMobRespawn',_container_mobileRespawn > 0,FALSE],
	['QS_missionConfig_cntnrFortSmall',_container_baseSmall > 0,FALSE],
	['QS_missionConfig_cntnrFortMed',_container_baseMedium > 0,FALSE],
	['QS_missionConfig_cntnrFortBig',_container_baseLarge > 0,FALSE],
	['QS_missionConfig_cntnrPlatform',_container_platform > 0,FALSE],
	['QS_missionConfig_cntnrTerrain',_container_terrain > 0,FALSE],
	['QS_missionConfig_cntnrSAM',_container_SAM > 0,FALSE],
	['QS_missionConfig_cntnrRadar',_container_radar > 0,FALSE],
	['ApexFramework_3DGroupIconColor',_IconColor3D,TRUE],
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