/*/
File: fn_clientDiary.sqf
Author:
	
	Quiksilver
	
Last Modified:

	26/08/2022 A3 2.10 by Quiksilver

Description:

	-
	
License Notes:

	Part of the EULA for this framework is to ensure this file executes as normal.

__________________________________________________________/*/

/*/========== Create Diary Subjects (this is the order they appear in the map tabs)/*/

{
	player createDiarySubject _x;
} forEach [
	['QS_diary_hotkeys',localize 'STR_QS_Diary_001'],
	['QS_diary_rules',localize 'STR_QS_Diary_002'],
	['QS_diary_radio',localize 'STR_QS_Diary_003'],
	['QS_diary_roles',localize 'STR_QS_Diary_004'],
	['QS_diary_mods',localize 'STR_QS_Diary_005'],
	['QS_diary_teamspeak',localize 'STR_QS_Diary_006'],
	['QS_diary_discord',localize 'STR_QS_Diary_007'],
	['QS_diary_leaderboards',localize 'STR_QS_Diary_008'],
	['QS_diary_gitmo',localize 'STR_QS_Diary_009'],
	['QS_diary_fobs',localize 'STR_QS_Diary_010'],
	['QS_diary_revive',localize 'STR_QS_Diary_011'],
	['QS_diary_inventory',localize 'STR_QS_Diary_012']
];

/*/========== Create Diary Records/*/

if ((missionNamespace getVariable ['QS_missionConfig_aoType','']) isEqualTo 'GRID') then {
	_description = format [
		'%2<br/><br/>%3 %1.<br/><br/>%4<br/><br/>%5 %1.',
		(missionNamespace getVariable ['QS_terrain_worldName',worldName]),
		localize 'STR_QS_Diary_014',
		localize 'STR_QS_Diary_015',
		localize 'STR_QS_Diary_016',
		localize 'STR_QS_Diary_017'
	];
	player createDiaryRecord [
		'Diary',
		[
			(format ['%1 %2',(missionNamespace getVariable ['QS_terrain_worldName',worldName]),localize 'STR_QS_Diary_013']),
			_description
		]
	];
};

/*/================================= RADIO CHANNELS/*/

player createDiaryRecord [
	'QS_diary_radio',
	[
		localize 'STR_QS_Diary_018',
		format ['%1<br/><br/>%2<br/><br/>',localize 'STR_QS_Diary_019',localize 'STR_QS_Diary_020',localize 'STR_QS_Diary_021']
	]
];
player createDiaryRecord [
	'QS_diary_radio',
	[
		localize 'STR_QS_Diary_022',
		format ['%1<br/><br/>%2',localize 'STR_QS_Diary_023',localize 'STR_QS_Diary_024']
	]
];
player createDiaryRecord [
	'QS_diary_radio',
	[
		localize 'STR_QS_Diary_025',
		localize 'STR_QS_Diary_026'
	]
];
player createDiaryRecord [
	'QS_diary_radio',
	[
		localize 'STR_QS_Diary_027',
		format ['%1<br/><br/>%2<br/><br/>%3',localize 'STR_QS_Diary_028',localize 'STR_QS_Diary_029',localize 'STR_QS_Diary_030']
	]
];
player createDiaryRecord [
	'QS_diary_radio',
	[
		localize 'STR_QS_Diary_032',
		format ['%1<br/><br/>%2',localize 'STR_QS_Diary_033',localize 'STR_QS_Diary_034']
	]
];
player createDiaryRecord [
	'QS_diary_radio',
	[
		localize 'STR_QS_Diary_035',
		format ['%1<br/><br/>%2<br/><br/>%3<br/><br/>%4<br/><br/>%5',localize 'STR_QS_Diary_036',localize 'STR_QS_Diary_037',localize 'STR_QS_Diary_038',localize 'STR_QS_Diary_039',localize 'STR_QS_Diary_040']
	]
];

/*/================================= INVENTORY/*/

player createDiaryRecord [
	'QS_diary_inventory',
	[
		localize 'STR_QS_Diary_041',
		localize 'STR_QS_Diary_042'
	]
];

/*/================================= REVIVE/*/

player createDiaryRecord [
	'QS_diary_revive',
	[
		localize 'STR_QS_Diary_043',
		format ['%1<br/><br/>%2<br/>%3<br/>%4<br/>%5',localize 'STR_QS_Diary_044',localize 'STR_QS_Diary_045',localize 'STR_QS_Diary_046',localize 'STR_QS_Diary_047',localize 'STR_QS_Diary_048']
	]
];

/*/================================= FOBs/*/

player createDiaryRecord [
	'QS_diary_fobs',
	[
		localize 'STR_QS_Diary_049',
		(format ['%2 %1.<br/><br/>%3',(missionNamespace getVariable ['QS_terrain_worldName',worldName]),localize 'STR_QS_Diary_050',localize 'STR_QS_Diary_051'])
	]
];

player createDiaryRecord [
	'QS_diary_fobs',
	[
		localize 'STR_QS_Diary_052',
		format ['%1<br/><br/>%2<br/><br/>%3',localize 'STR_QS_Diary_053',localize 'STR_QS_Diary_054',localize 'STR_QS_Diary_055']
	]
];

player createDiaryRecord [
	'QS_diary_fobs',
	[
		localize 'STR_QS_Diary_056',
		format ['%1<br/><br/>
		- %2<br/>
		- %3<br/>
		- %4<br/>
		- %5',localize 'STR_QS_Diary_057',localize 'STR_QS_Diary_058',localize 'STR_QS_Diary_059',localize 'STR_QS_Diary_060',localize 'STR_QS_Diary_061']
	]
];

player createDiaryRecord [
	'QS_diary_fobs',
	[
		localize 'STR_QS_Diary_062',
		format ['%1<br/><br/>
		%2<br/>
		%3<br/>
		%4<br/>
		%5<br/>
		',localize 'STR_QS_Diary_063',localize 'STR_QS_Diary_064',localize 'STR_QS_Diary_065',localize 'STR_QS_Diary_066',localize 'STR_QS_Diary_067']
	]
];

player createDiaryRecord [
	'QS_diary_fobs',
	[
		localize 'STR_QS_Diary_068',
		localize 'STR_QS_Diary_069'
	]
];

/*/================================= Leaderboards/*/

player createDiaryRecord [
	'QS_diary_leaderboards',
	[
		localize 'STR_QS_Diary_074',
		format ['%1<br/><br/>%2<br/><br/>%3',localize 'STR_QS_Diary_070',localize 'STR_QS_Diary_071',localize 'STR_QS_Diary_072']
	]
];
player createDiaryRecord [
	'QS_diary_leaderboards',
	[
		localize 'STR_QS_Diary_073',
		format ['%1<br/><br/>%2<br/><br/>%3',localize 'STR_QS_Diary_075',localize 'STR_QS_Diary_076',localize 'STR_QS_Diary_077']
	]
];
player createDiaryRecord [
	'QS_diary_leaderboards',
	[
		localize 'STR_QS_Diary_078',
		format ['%1<br/><br/>%2<br/><br/>Gitmo is marked on your map at base.',localize 'STR_QS_Diary_079',localize 'STR_QS_Diary_080',localize 'STR_QS_Diary_081']
	]
];
player createDiaryRecord [
	'QS_diary_leaderboards',
	[
		localize 'STR_QS_Diary_082',
		format ['%1<br/><br/>%2',localize 'STR_QS_Diary_083',localize 'STR_QS_Diary_080']
	]
];
player createDiaryRecord [
	'QS_diary_leaderboards',
	[
		localize 'STR_QS_Diary_084',
		format ['%1<br/><br/>%2',localize 'STR_QS_Diary_085',localize 'STR_QS_Diary_080']
	]
];
player createDiaryRecord [
	'QS_diary_leaderboards',
	[
		localize 'STR_QS_Diary_086',
		format ['%1<br/><br/>%2',localize 'STR_QS_Diary_087',localize 'STR_QS_Diary_088']
	]
];
player createDiaryRecord [
	'QS_diary_leaderboards',
	[
		localize 'STR_QS_Diary_089',
		format ['%1<br/><br/>%2<br/><br/>%3',localize 'STR_QS_Diary_090',localize 'STR_QS_Diary_091',localize 'STR_QS_Diary_092']
	]
];
player createDiaryRecord [
	'QS_diary_leaderboards',
	[
		localize 'STR_QS_Diary_093',
		format ['%1<br/><br/>%2<br/><br/>%3<br/><br/>%4<br/>%5',localize 'STR_QS_Diary_094',localize 'STR_QS_Diary_095',localize 'STR_QS_Diary_096',localize 'STR_QS_Diary_097',localize 'STR_QS_Diary_098']
	]
];
player createDiaryRecord [
	'QS_diary_leaderboards',
	[
		localize 'STR_QS_Diary_035',
		format [
			'<t size="2">%2</t><br/><br/>%3<br/><br/>%4<br/><br/>%5, %1!',
			profileName,
			localize 'STR_QS_Diary_099',
			localize 'STR_QS_Diary_100',
			localize 'STR_QS_Diary_101',
			localize 'STR_QS_Diary_102'
		]
	]
];

/*/-------------------------------------------------- Rules/*/

player createDiaryRecord [
	'QS_diary_hotkeys',
	[
		localize 'STR_QS_Diary_140',
		(format [
		'
			<br/>1 - [%21] - %1
			<br/>2 - [%22] - %2
			<br/>3 - [%23] - %3
			<br/>4 - [%24] - %4
			<br/>5 - [%25] - %5
			<br/>6 - [%26] - %6
			<br/>7 - [%27] - %7
			<br/>8 - [%28] - %8
			<br/>9 - [%29] - %9
			<br/>10 - [%30] - %10
			<br/>11 - [%31] - %11
			<br/>12 - [%32] - %12
			<br/>13 - [%33] - %13
			<br/>14 - [%34] - %14
			<br/>15 - [%35] - %15
			<br/>16 - [%36] - %16
			<br/>17 - [%37] - %17
			<br/>18 - [%38] - %18
			<br/>19 - [%39] - %19
			<br/>20 - [%40] - %20
			',
			localize 'STR_QS_Diary_151',localize 'STR_QS_Diary_151',localize 'STR_QS_Diary_151',localize 'STR_QS_Diary_151',localize 'STR_QS_Diary_151',localize 'STR_QS_Diary_151',
			localize 'STR_QS_Diary_141',
			localize 'STR_QS_Diary_142',
			localize 'STR_QS_Diary_143',
			localize 'STR_QS_Diary_144',
			localize 'STR_QS_Diary_145',
			localize 'STR_QS_Diary_151',localize 'STR_QS_Diary_151',
			localize 'STR_QS_Diary_146',
			localize 'STR_QS_Diary_147',
			localize 'STR_QS_Diary_151',
			localize 'STR_QS_Diary_148',
			localize 'STR_QS_Diary_149',
			localize 'STR_QS_Diary_151',
			localize 'STR_QS_Diary_150',
			actionKeysNames ["User1",1] trim ['"',0],
			actionKeysNames ["User2",1] trim ['"',0],
			actionKeysNames ["User3",1] trim ['"',0],
			actionKeysNames ["User4",1] trim ['"',0],
			actionKeysNames ["User5",1] trim ['"',0],
			actionKeysNames ["User6",1] trim ['"',0],
			actionKeysNames ["User7",1] trim ['"',0],
			actionKeysNames ["User8",1] trim ['"',0],
			actionKeysNames ["User9",1] trim ['"',0],
			actionKeysNames ["User10",1] trim ['"',0],
			actionKeysNames ["User11",1] trim ['"',0],
			actionKeysNames ["User12",1] trim ['"',0],
			actionKeysNames ["User13",1] trim ['"',0],
			actionKeysNames ["User14",1] trim ['"',0],
			actionKeysNames ["User15",1] trim ['"',0],
			actionKeysNames ["User16",1] trim ['"',0],
			actionKeysNames ["User17",1] trim ['"',0],
			actionKeysNames ["User18",1] trim ['"',0],
			actionKeysNames ["User19",1] trim ['"',0],
			actionKeysNames ["User20",1] trim ['"',0]
		])
	]
];
player createDiaryRecord [
	'QS_diary_hotkeys',
	[
		localize 'STR_QS_Diary_103',
		(format ['
		<br/>%7 - [Home]
		<br/>%8 - [End]
		<br/>%9 - [4]
		<br/>%10 - [L.Ctrl]+[%2]
		<br/>%11 - [%5] %12
		<br/>%13 - [%6]
		<br/>%14 - [%3]
		<br/>%15 - [%4]
		<br/>%16 - [Ctrl]+[Numpad x]
		<br/>%17 - %1
		<br/>%18 - [Page [Up/Down]]
		',
			(actionKeysNames 'TacticalPing'),
			(actionKeysNames 'ReloadMagazine'),
			(actionKeysNames 'Diary'),
			(actionKeysNames 'Help'),
			(actionKeysNames 'GetOver'),
			(actionKeysNames 'Teamswitch'),
			localize 'STR_QS_Diary_104',
			localize 'STR_QS_Diary_105',
			localize 'STR_QS_Diary_106',
			localize 'STR_QS_Diary_107',
			localize 'STR_QS_Diary_108',
			localize 'STR_QS_Diary_109',
			localize 'STR_QS_Diary_110',
			localize 'STR_QS_Diary_111',
			localize 'STR_QS_Diary_112',
			localize 'STR_QS_Diary_113',
			localize 'STR_QS_Diary_114',
			localize 'STR_QS_Diary_115'
		])
	]
];

if ((getPlayerUID player) in (['ALL'] call (missionNamespace getVariable 'QS_fnc_whitelist'))) then {
	player createDiaryRecord [
		'QS_diary_hotkeys',
		[
			localize 'STR_QS_Diary_116',
			format ['
			<br/>%1 - [Shift]+[F2]
			<br/>%2 - [Shift]+[F2]
			',localize 'STR_QS_Diary_117',localize 'STR_QS_Diary_118']
		]
	];
};
if ((getPlayerUID player) in (['CURATOR'] call (missionNamespace getVariable 'QS_fnc_whitelist'))) then {
	player createDiaryRecord [
		'QS_diary_hotkeys',
		[
			localize 'STR_QS_Diary_119',
			format ['
			<br/>%1 - [Shift]+[F3]
			<br/>%2 - [Numpad 1]
			<br/>%3 - [Numpad 2]
			<br/>%4 - [Numpad 3]
			<br/>%5 - [Numpad 4]
			<br/>%6 - [Numpad 6]
			<br/>%7 - [Numpad 7]
			<br/>%8 - [Numpad 8]
			<br/>%9 - [Numpad 9]
			',
			localize 'STR_QS_Diary_120',
			localize 'STR_QS_Diary_121',
			localize 'STR_QS_Diary_122',
			localize 'STR_QS_Diary_123',
			localize 'STR_QS_Diary_124',
			localize 'STR_QS_Diary_125',
			localize 'STR_QS_Diary_126',
			localize 'STR_QS_Diary_127',
			localize 'STR_QS_Diary_128'
			]
		]
	];
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
		localize 'STR_QS_Diary_129',
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
		localize 'STR_QS_Diary_130',
		format [
			'%1<br/><br/>%2<br/><br/>%3',
			localize 'STR_QS_Diary_131',
			localize 'STR_QS_Diary_132',
			localize 'STR_QS_Diary_133'
		]
	]
];

/*/-------------------------------------------------- Teamspeak/*/

player createDiaryRecord [
	'QS_diary_teamspeak',
	[
		localize 'STR_QS_Diary_134',
		format ['
		<br/> %2 %1<br/><br/> %3
		',(missionNamespace getVariable ['QS_missionConfig_commTS','']),localize 'STR_QS_Diary_135',localize 'STR_QS_Diary_136']
	]
];

/*/-------------------------------------------------- Credits/*/
player createDiarySubject ['QS_diary_credits','Credits'];				// EULA relevant line.

////////////////////////////////// EDIT BELOW ///////////////////////////////////////

player createDiaryRecord [
	'QS_diary_credits',
	[
		localize 'STR_QS_Diary_137',
		localize 'STR_QS_Diary_138'
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
		localize 'STR_QS_Diary_139',
		"<br/><br/><font size='20'>Quiksilver</font><br/><br/>This framework is the product of many thousands of hours of doing battle in notepad++ over a number of years (2013-2017). We sincerely hope you enjoy your experience!<br/><br/>If you would like to show your appreciation but do not know how, you can<br/><br/><executeClose expression=""createDialog 'QS_RD_client_dialog_menu_hub';"">Donate to Quiksilver (Patreon)</executeClose><br/><br/>Stay safe out there, soldier!"
	]
];