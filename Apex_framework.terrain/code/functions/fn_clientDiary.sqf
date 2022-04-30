/*/
File: fn_clientDiary.sqf
Author:
	
	Quiksilver
	
Last Modified:

	6/12/2017 A3 1.78 by Quiksilver

Description:

	-
	
License Notes:

	Part of the EULA for this framework is to ensure this file executes as normal.

__________________________________________________________/*/

/*/========== Create Diary Subjects (this is the order they appear in the map tabs)/*/

{
	player createDiarySubject _x;
} forEach [
	['QS_diary_hotkeys','Key Bindings'],
	['QS_diary_rules','Rules'],
	['QS_diary_radio','Radio Channels'],
	['QS_diary_roles','Roles'],
	['QS_diary_mods','Mods'],
	['QS_diary_teamspeak','Teamspeak'],
	['QS_diary_leaderboards','Leaderboards'],
	['QS_diary_gitmo','Gitmo'],
	['QS_diary_fobs','FOBs'],
	['QS_diary_revive','Revive'],
	['QS_diary_inventory','Inventory']
];

/*/========== Create Diary Records/*/

if ((missionNamespace getVariable ['QS_missionConfig_aoType','']) isEqualTo 'GRID') then {
	_description = format ['After the war between NATO and CSAT ended in an uneasy truce, an opportunistic insurgency sponsored by surrounding nations crushed local militias and moved in to fill the power vacuum.<br/><br/>They have been destabilizing the region and threatening to pull NATO and CSAT back into open conflict on %1.<br/><br/>Moving around using an old wartime tunnel network, they have thus far thwarted low-cost attempts to destroy the insurgency with drone warfare.<br/><br/>In a last ditch effort, NATO has deployed boots on the ground to root out the determined enemy and bring peace to %1.',worldName];
	player createDiaryRecord [
		'Diary',
		[
			(format ['%1 Campaign',worldName]),
			_description
		]
	];
};

/*/================================= RADIO CHANNELS/*/

player createDiaryRecord [
	'QS_diary_radio',
	[
		'General channel',
		'Subscribe to the General channel for Voice communications.<br/><br/>Transmission of music and other non-voice sounds is not permitted on this channel.<br/><br/>Verbal abuse is, of course, not tolerated.'
	]
];
player createDiaryRecord [
	'QS_diary_radio',
	[
		'Platoon channels',
		'Join a Platoon channel (Alpha, Bravo or Charlie) for inter-squad communications.<br/><br/>You can only be subscribed to one Platoon channel at a time.'
	]
];
player createDiaryRecord [
	'QS_diary_radio',
	[
		'AO channels',
		'If you are subscribed to these channels, you will automatically be added to these channels when within 2km of the Primary AO, and 1km of the Secondary AO (side mission). When you leave this area, you will no longer be able to receive or transmit on it.'
	]
];
player createDiaryRecord [
	'QS_diary_radio',
	[
		'Aircraft channel',
		'Pilots and UAV Operator are active on this channel.<br/><br/>Currently only Pilots and UAV Operator can transmit voice on this channel.<br/><br/>If you are not Pilot or UAV Operator, you can still listen to this channel, if you are in the Air Traffic Control tower or the TOC (map marker at base).'
	]
];
player createDiaryRecord [
	'QS_diary_radio',
	[
		'Side channel',
		'Voice communication is disabled on Side channel<br/><br/>Use General channel to transmit voice to all players on the server.'
	]
];
player createDiaryRecord [
	'QS_diary_radio',
	[
		'Overview',
		'Beta v0.9<br/><br/>A number of custom radio channels are available for use in-game.<br/><br/>To access: Press [Home] >> [Comm-Link] >> [Radio Management]<br/><br/>A Radio inventory item is required to transmit voice communications.<br/><br/>Transmission of music or other audio is only permitted over Group, Vehicle and Direct channels (when away from base).<br/><br/>Spamming and generally annoying other players using Voice communications can lead to administrative action.'
	]
];

/*/================================= INVENTORY/*/

player createDiaryRecord [
	'QS_diary_inventory',
	[
		'Inventory Editing',
		'Near the Crate Area and Inventory markers at base, you are able to easily customize the inventory of vehicles and ammo crates'
	]
];

/*/================================= REVIVE/*/

player createDiaryRecord [
	'QS_diary_revive',
	[
		'Medical Vehicles',
		'Load incapacitated soldiers into a Medical vehicle (HEMTT Medical, Taru Medical Pod, etc) to revive them.<br/><br/>The vehicle must have sufficient Revive Tickets.<br/>Reviving a player consumes a Revive Ticket.<br/>Revive tickets can be replenished at the Base Service markers.<br/>Revive tickets correspond to number of cargo seats in the vehicle.'
	]
];

/*/================================= FOBs/*/

player createDiaryRecord [
	'QS_diary_fobs',
	[
		'General',
		(format ['Forward Operating Bases are scattered around %1.<br/><br/>Some services are available from these FOBs, and they are also locations of interest to the enemy.',worldName])
	]
];

player createDiaryRecord [
	'QS_diary_fobs',
	[
		'Radar Services',
		'When the FOB is active and held by your faction, enemy map data and radar data will be available<br/><br/>To interact with the FOBs, there is a laptop inside the main building.<br/><br/>When certain types of vehicles/crates are within a radius of the FOB, they can activate certain services.'
	]
];

player createDiaryRecord [
	'QS_diary_fobs',
	[
		'Respawning',
		'Respawning is available at FOBs if several conditions are met:<br/><br/>
		- The FOB must be online and held by your faction<br/>
		- You must enable your personal FOB respawn. This can be done at the FOB terminal located inside the FOB HQ building<br/>
		- You are NOT a pilot<br/>
		- The FOB has more than 0 Respawn Tickets<br/>
		- You have not respawned there in the past 3 minutes'
	]
];

player createDiaryRecord [
	'QS_diary_fobs',
	[
		'Vehicle Services',
		'Several vehicle services are available at the FOBs for Aircraft and Land Vehicles:<br/><br/>
		- Respawn - Bring a HEMTT Mover or HEMTT Box truck to the FOB to activate Vehicle Respawn Services<br/>
		- Repair - Bring a repair truck or crate to the FOB to activate Repair Services<br/>
		- Fuel - Bring a fuel truck or crate to the FOB to bring Refueling Services online<br/>
		- Ammo - Bring an Ammo truck or crate to the FOB to bring Ammo Services online<br/>
		'
	]
];

player createDiaryRecord [
	'QS_diary_fobs',
	[
		'Respawn Tickets',
		'Bring Medical Vehicles and Crates to the FOB to replenish its Revive Tickets'
	]
];

player createDiaryRecord [
	'QS_diary_fobs',
	[
		'Ammo Crate',
		'Load Crates at base with gear and Tow or Sling to the FOB to add that gear to the FOB Ammo Crate'
	]
];

/*/================================= Leaderboards/*/

player createDiaryRecord [
	'QS_diary_leaderboards',
	[
		'Gitmo',
		'Earn points by imprisoning enemies in "Gitmo".<br/><br/>Multipliers: n/a<br/><br/>Gitmo is marked on your map at base. See "Gitmo" diary tab for further details.'
	]
];
player createDiaryRecord [
	'QS_diary_leaderboards',
	[
		'Tower Rangers',
		'Earn points as an infantryman by destroying the radiotower (pilots not eligible).<br/><br/>Multipliers: n/a'
	]
];
player createDiaryRecord [
	'QS_diary_leaderboards',
	[
		'Gold Diggers',
		'Earn points by collecting human trophies (gold teeth) from dead enemies (very rare).<br/><br/>Multipliers: n/a'
	]
];
player createDiaryRecord [
	'QS_diary_leaderboards',
	[
		'Ear Slicers',
		'Earn points by collecting human trophies (ears) from dead enemies.<br/><br/>Multipliers: n/a'
	]
];
player createDiaryRecord [
	'QS_diary_leaderboards',
	[
		'Revivalists',
		'Earn points as a Medic by reviving fallen soldiers.<br/><br/>Multipliers: Stamina<br/><br/>Top 3 medics of the week (ending Sunday 23:59h) added to whitelisted medic slot for following week.'
	]
];
player createDiaryRecord [
	'QS_diary_leaderboards',
	[
		'Transporters',
		'Earn points as a Pilot by safely transporting soldiers to and from missions in helicopters.<br/><br/>Multipliers: Advanced Flight Model<br/><br/>Top 3 pilots of the week (ending Sunday 23:59h) added to whitelisted pilot slot for following week.<br/><br/>Sling loading is not currently supported.<br/>Vehicle cargo is not currently supported.'
	]
];
player createDiaryRecord [
	'QS_diary_leaderboards',
	[
		'General Info',
		format ['<t size="2">Version 1.0</t><br/><br/>Leaderboards are reset each Monday at 00:01h.<br/><br/>Please report bugs and weird shit on the forums or to Quiksilver on TS.<br/><br/>To maintain performance and FPS, the leaderboards are synchronized every 5-10 minutes instead of continuously, and saved to database every 10-15 minutes. For this reason, points accumulated just prior to server restart may not be saved (*sadface*). Since it is new, we are experimenting with the best and most performance-friendly methods.<br/><br/>Thanks for your patience, %1!',profileName]
	]
];

/*/-------------------------------------------------- Rules/*/

player createDiaryRecord [
	'QS_diary_hotkeys',
	[
		'Key Bindings',
		(format ['
		<br/>Player Menu - [Home]
		<br/>Earplugs - [End]
		<br/>Holster Weapon - [4]
		<br/>Magazine Repack - [L.Ctrl]+[%2]
		<br/>Jump - [%5] while running
		<br/>Group Manager - [%6]
		<br/>Tasks - [%3]
		<br/>Hints - [%4]
		<br/>Gestures - [Ctrl]+[Numpad x]
		<br/>Tactical Ping - %1
		<br/>Open and close doors - [Space]
		',(actionKeysNames 'TacticalPing'),(actionKeysNames 'ReloadMagazine'),(actionKeysNames 'Diary'),(actionKeysNames 'Help'),(actionKeysNames 'GetOver'),(actionKeysNames 'Teamswitch')])
	]
];

if ((getPlayerUID player) in (['ALL'] call (missionNamespace getVariable 'QS_fnc_whitelist'))) then {
	player createDiaryRecord [
		'QS_diary_hotkeys',
		[
			'Staff Bindings',
			'
			<br/>Staff Menu Open - [Shift]+[F2]
			<br/>Staff Menu Close - [Shift]+[F2]
			<br/>Exit Spectate - [Shift]+[F2]
			'
		]
	];
	if ((getPlayerUID player) in (['CURATOR'] call (missionNamespace getVariable 'QS_fnc_whitelist'))) then {
		player createDiaryRecord [
			'QS_diary_hotkeys',
			[
				'Curator (Zeus) Bindings',
				'
				<br/>Sync Editable Objects - [Shift]+[F3]
				<br/>(Selected Group) Garrison in Buildings - [Numpad 1]
				<br/>(Selected Group) Patrol Area - [Numpad 2]
				<br/>(Selected Group) Search Building - [Numpad 3]
				<br/>(Selected Group) Stalk Target - [Numpad 4]
				<br/>(Selected Group) Suppressive Fire - [Numpad 6]
				<br/>(Selected Unit) Revive Player - [Numpad 7]
				<br/>(All Players) View Directions - [Numpad 8]
				<br/>(Selected Unit) Set unit Unconscious - [Numpad 9]
				'
			]
		];
	};
};

/*/ Enable or change this if you like
player createDiaryRecord [
	'QS_diary_rules',
	[
		'Enforcement',
		'
		<br />The purpose of the above rules are to ensure a fun and relaxing environment for public players.
		<br />
		<br />Server rules are in place merely as a means to that end.
		<br />
		<br />Guideline for enforcement:
		<br />
		<br />-	Innocent rule violation and disruptive behavior: 
		<br />
		<br />		= Verbal / Written request to cease, or warning.
		<br /> 
		<br />-	Minor or first-time rule violation:
		<br />
		<br />		= Kick, or 0 - 3 day ban.
		<br />
		<br />-	Serious or repetitive rule violation: 
		<br />
		<br />		= 3 - 7 day ban.
		<br />
		<br />-	Administrative ban (hack/exploit/verbal abuse/serious offense):
		<br />
		<br />		= permanent or 30 day.
		<br />
		<br />
		<br />The above is subject to discretion.
		'
	]
];
/*/

player createDiaryRecord [
	'QS_diary_rules',
	[
		'General',
		(missionNamespace getVariable ['QS_missionConfig_splash_serverRules',''])
	]
];
/*/ Enable or change this if you like
player createDiaryRecord [
	'QS_diary_rules',
	[
		'Aviation',
		"
		<br /> Pilots have their own specialized roles, therefore they come with additional responsibilities. If you have any issues with any pilot, please report the player to an admin or moderator.
		<br />
		<br />1. You MUST be on our Teamspeak server--in the correct channel--and communicable. Exception if TS is down or full.
		<br />
		<br />2. You MUST be a pilot to fly an aircraft.
		<br />	If you are a non-pilot and there are less than 20 players on the server, then you may fly a hummingbird in copilot. 
		<br />	If there are over 20 players, you may fly a hummingbird to a side mission ONLY.
		<br />	
		<br />3. Pilots must not play infantry while in a pilot slot.
		<br />
		<br />4a. If you are an inexperienced pilot, please consider the time and enjoyment of others. The editor is there for a reason.
		<br /> 
		<br />4b. This is a public server. Helicopters are not private/reserved transport. A Pilots primary role is to provide timely general transport to and from objectives.
		<br /> 
		<br />-		* General transport in this context is defined as: Indiscriminate and timely transport for each and all players on the server.
		<br />
		<br />5. You must be able to fly AND LAND any aircraft with reasonable competence, if you do not have experience in any aircraft, you may be asked to leave the role.
		<br />		
		<br />6. Landing or slinging objects/vehicles inside of infantry spawn may result in a warning or a kick for first offense.
		<br />
		<br />7. Ramming enemy or intentional crashing may result in a ban without warning, try to preserve assets.
		<br />
		<br />The above rules are subject to discretion of moderators and administrators.
		<br />
		<br />If you see a player in violation of the above, contact a moderator or admin (teamspeak).
		"
	]
];
/*/
/*/ Enable or change this if you like
player createDiaryRecord [
	'QS_diary_rules',
	[
		'Close Air Support',
		"
		<br/>0. CAS must be called in by ground elements (infantry who are near the target).
		<br/><br/>1. CAS call-ins must be typed into Side Channel with a specific position or target, no exceptions.
		<br/><br/>2. CAS may freely engage these targets without ground coordination: Fixed-wing Aircraft.
		<br/><br/>3. Do not engage any objectives and/or enemies without being called in on that specific target (See rule 1).
		<br/><br/>4. Do not ram targets and/or objectives.
		<br/><br/>5. Do not fly near (1km) marked objectives unless necessary to complete a mission.
		<br/><br/>6. Must be on Teamspeak, in Pilot channel and communicable.
		<br/><br/><br/>Failure to comply may result in administrative action without warning, up to and including permanent removal from CAS whitelist.
		"
	]
];
/*/
/*/ Enable or change this if you like
player createDiaryRecord [
	'QS_diary_rules',
	[
		'Comms',
		'
		<br />1. Spamming comms will not be tolerated
		<br />2. Arguing on comms will not be tolerated
		<br />3. Shouting/Screaming on comms will not be tolerated. (This includes telling a pilot they suck and can not fly to save their own life)
		<br />4. Speaking on Global or Side will result in a kick, and if done again a ban will be issued.
		<br />5. Speaking over side is laggy and no-one can understand you. Type on side. Talk in Group or better join us on TS
		<br />6. Excessive mic spam will result in a kick, if done again a ban will be issued
		'
	]
];
/*/

/*/-------------------------------------------------- Mods/*/

/*/ Enable or change this if you like
player createDiaryRecord [
	'QS_diary_mods',
	[
	'Mods Allowed',
	'
	<br /> Mods currently allowed (subject to change without notice):<br /><br />

	<br/>- JSRS soundmod (Steam Workshop): Audio effects mod
	<br/>- Blastcore standalone (Steam Workshop): Visual effects mod
	'
	]
];
/*/

player createDiaryRecord [
	'QS_diary_gitmo',
	[
		'Enemy Capture',
		'It is possible to capture enemies!<br/><br/>To capture an enemy soldier, you must get within 5m and aim at him. You may get a Command Surrender action on your scroll wheel. To receive full reward, bring the captive back to the Gitmo area at base. To incarcerate a prisoner into Gitmo, walk up to the Phone Booth with your prisoner, look at the Phone Booth, wait 3-5 seconds and Release your prisoner while looking at the phone booth.<br/><br/>Good hunting!'
	]
];

/*/-------------------------------------------------- Teamspeak/*/

player createDiaryRecord [
	'QS_diary_teamspeak',
	[
		'TS3 Server',
		format ['
		<br/> Address: %1
		<br/>
		<br/> Visitors and guests welcome!
		',(missionNamespace getVariable ['QS_missionConfig_commTS',''])]
	]
];

/*/-------------------------------------------------- Credits/*/
player createDiarySubject ['QS_diary_credits','Credits'];				// EULA relevant line.

////////////////////////////////// EDIT BELOW ///////////////////////////////////////

player createDiaryRecord [
	'QS_diary_credits',
	[
		'Community Editors',
		'Your Name Here'
	]
];

////////////////////////////////// EDIT ABOVE ///////////////////////////////////////

////////////////////////////////// DO NOT EDIT BELOW ///////////////////////////////////////
/*/ 
Please do not tamper with the below lines.
Part of license for use of this framework is to maintain accessibility for players to donate to the Apex Framework developer.
Servers which have made it difficult or impossible for players to access this link are in violation of the EULA.
/*/
player createDiaryRecord [
	'QS_diary_credits',
	[
		"Developer",
		"<br/><br/><font size='20'>Quiksilver</font><br/><br/>This framework is the product of many thousands of hours of doing battle in notepad++ over a number of years (2013-2017). We sincerely hope you enjoy your experience!<br/><br/>If you would like to show your appreciation but do not know how, you can<br/><br/><executeClose expression=""createDialog 'QS_RD_client_dialog_menu_hub';"">Donate to Quiksilver (Patreon)</executeClose><br/><br/>Stay safe out there, soldier!"
	]
];