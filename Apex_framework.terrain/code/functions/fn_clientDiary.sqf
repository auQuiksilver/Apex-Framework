/*/
File: fn_clientDiary.sqf
Author:
	
	Quiksilver
	
Last Modified:

	01/05/2023 A3 2.10 by Quiksilver

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
	['QS_diary_communication',localize 'STR_QS_Diary_006'],
	['QS_diary_leaderboards',localize 'STR_QS_Diary_008'],
	['QS_diary_gitmo',localize 'STR_QS_Diary_009'],
	['QS_diary_fobs',localize 'STR_QS_Diary_010'],
	['QS_diary_revive',localize 'STR_QS_Diary_011'],
	['QS_diary_inventory',localize 'STR_QS_Diary_012']
];

/*/========== Create Diary Records/*/

if ((missionNamespace getVariable ['QS_missionConfig_aoType','']) isEqualTo 'GRID') then {
	player createDiaryRecord [
		'Diary',
		[
			(format [localize 'STR_QS_Diary_013',worldName]),
			(format [localize 'STR_QS_Diary_014',worldName])
		]
	];
};
 if ((missionNamespace getVariable ['QS_missionConfig_aoType','']) isEqualTo 'CLASSIC') then {

	player createDiaryRecord [
		    'Diary',
		[	
			(format [localize 'STR_QS_Diary_013',worldName]),
			(format [localize 'STR_QS_Diary_015',worldName])
		]
	];
};
/*/================================= ROLES/*/

player createDiaryRecord [
	'QS_diary_roles',
	[
		localize 'STR_QS_Diary_148',//Headquarters
		localize 'STR_QS_Diary_149'
	]
];
/*/player createDiaryRecord [
	'QS_diary_roles',
	[
		localize 'STR_QS_Diary_150',//Squad Commander
		localize 'STR_QS_Diary_151'
	]
];/*/
player createDiaryRecord [
	'QS_diary_roles',
	[
		localize 'STR_QS_Diary_152',//Jet Pilot
		localize 'STR_QS_Diary_153'
	]
];
/*/player createDiaryRecord [
	'QS_diary_roles',
	[
		localize 'STR_QS_Diary_154',//Destroyer Heli Pilot
		localize 'STR_QS_Diary_155'
	]
];/*/
player createDiaryRecord [
	'QS_diary_roles',
	[
		localize 'STR_QS_Diary_156',//Transport Heli Pilot
		localize 'STR_QS_Diary_157'
	]
];
player createDiaryRecord [
	'QS_diary_roles',
	[
		localize 'STR_QS_Diary_158',//UAV Operator
		localize 'STR_QS_Diary_159'
	]
];
player createDiaryRecord [
	'QS_diary_roles',
	[
		localize 'STR_QS_Diary_160',//JTAC
		localize 'STR_QS_Diary_161'
	]
];
/*/player createDiaryRecord [
	'QS_diary_roles',
	[
		localize 'STR_QS_Diary_162',//Underwater Assault Commando
		localize 'STR_QS_Diary_163'
	]
];/*/
player createDiaryRecord [
	'QS_diary_roles',
	[
		localize 'STR_QS_Diary_164',//Sniper
		localize 'STR_QS_Diary_165'
	]
];
/*/player createDiaryRecord [
	'QS_diary_roles',
	[
		localize 'STR_QS_Diary_166',//Spotter
		localize 'STR_QS_Diary_167'
	]
];/*/
player createDiaryRecord [
	'QS_diary_roles',
	[
		localize 'STR_QS_Diary_168',//Mortar Gunner
		localize 'STR_QS_Diary_169'
	]
];
/*/player createDiaryRecord [
	'QS_diary_roles',
	[
		localize 'STR_QS_Diary_170',//Tank Crew
		localize 'STR_QS_Diary_171'
	]
];/*/
player createDiaryRecord [
	'QS_diary_roles',
	[
		localize 'STR_QS_Diary_172',//Engineer
		localize 'STR_QS_Diary_173'
	]
];
player createDiaryRecord [
	'QS_diary_roles',
	[
		localize 'STR_QS_Diary_174',//Medic
		localize 'STR_QS_Diary_175'
	]
];
player createDiaryRecord [
	'QS_diary_roles',
	[
		localize 'STR_QS_Diary_176',//Missile Specialist (AA)
		localize 'STR_QS_Diary_177'
	]
];
player createDiaryRecord [
	'QS_diary_roles',
	[
		localize 'STR_QS_Diary_178',//Heavy Rocket (HAT)
		localize 'STR_QS_Diary_179'
	]
];
player createDiaryRecord [
	'QS_diary_roles',
	[
		localize 'STR_QS_Diary_180',//Light Rocket (LAT)
		localize 'STR_QS_Diary_181'
	]
];
player createDiaryRecord [
	'QS_diary_roles',
	[
		localize 'STR_QS_Diary_182',//Machine Gunner
		localize 'STR_QS_Diary_183'
	]
];
player createDiaryRecord [
	'QS_diary_roles',
	[
		localize 'STR_QS_Diary_184',//Auto Rifleman
		localize 'STR_QS_Diary_185'
	]
];
player createDiaryRecord [
	'QS_diary_roles',
	[
		localize 'STR_QS_Diary_186',//Rifleman
		localize 'STR_QS_Diary_187'
	]
];
player createDiaryRecord [
	'QS_diary_roles',
	[
		localize 'STR_QS_Diary_188',//Overview
		(format ["%1 <executeClose expression=""createDialog 'QS_RD_client_dialog_menu_hub';"">%2</executeClose> ",(localize 'STR_QS_Diary_189'),(localize 'STR_QS_Diary_190')])
	]
];
/*/================================= RADIO CHANNELS/*/

player createDiaryRecord [
	'QS_diary_radio',
	[
		localize 'STR_QS_Diary_018',
		localize 'STR_QS_Diary_019'
	]
];
player createDiaryRecord [
	'QS_diary_radio',
	[
		localize 'STR_QS_Diary_022',
		localize 'STR_QS_Diary_023'
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
		localize 'STR_QS_Diary_028'
	]
];
player createDiaryRecord [
	'QS_diary_radio',
	[
		localize 'STR_QS_Diary_032',
		localize 'STR_QS_Diary_033'
	]
];
player createDiaryRecord [
	'QS_diary_radio',
	[
		localize 'STR_QS_Diary_035',
		localize 'STR_QS_Diary_036'
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
		localize 'STR_QS_Diary_044'
	]
];

/*/================================= FOBs/*/

player createDiaryRecord [
	'QS_diary_fobs',
	[
		localize 'STR_QS_Diary_049',
		(format [localize 'STR_QS_Diary_050',worldName])
	]
];

player createDiaryRecord [
	'QS_diary_fobs',
	[
		localize 'STR_QS_Diary_052',
		localize 'STR_QS_Diary_053'
	]
];

player createDiaryRecord [
	'QS_diary_fobs',
	[
		localize 'STR_QS_Diary_056',
		localize 'STR_QS_Diary_057'
	]
];

player createDiaryRecord [
	'QS_diary_fobs',
	[
		localize 'STR_QS_Diary_062',
		localize 'STR_QS_Diary_063'
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
		localize 'STR_QS_Diary_070',
		localize 'STR_QS_Diary_071'
	]
];
player createDiaryRecord [
	'QS_diary_leaderboards',
	[
		localize 'STR_QS_Diary_073',
		localize 'STR_QS_Diary_074'
	]
];
player createDiaryRecord [
	'QS_diary_leaderboards',
	[
		localize 'STR_QS_Diary_078',
		localize 'STR_QS_Diary_079'
	]
];
player createDiaryRecord [
	'QS_diary_leaderboards',
	[
		localize 'STR_QS_Diary_082',
		localize 'STR_QS_Diary_083'
	]
];
player createDiaryRecord [
	'QS_diary_leaderboards',
	[
		localize 'STR_QS_Diary_084',
		localize 'STR_QS_Diary_085'
	]
];
player createDiaryRecord [
	'QS_diary_leaderboards',
	[
		localize 'STR_QS_Diary_086',
		localize 'STR_QS_Diary_087'
	]
];
player createDiaryRecord [
	'QS_diary_leaderboards',
	[
		localize 'STR_QS_Diary_089',
		localize 'STR_QS_Diary_090'
	]
];
player createDiaryRecord [
	'QS_diary_leaderboards',
	[
		localize 'STR_QS_Diary_093',
		localize 'STR_QS_Diary_094'
	]
];
player createDiaryRecord [
	'QS_diary_leaderboards',
	[
		localize 'STR_QS_Diary_099',
		(format [localize 'STR_QS_Diary_100',profileName])
	]
];

/*/-------------------------------------------------- Rules/*/

player createDiaryRecord [
	'QS_diary_hotkeys',
	[
		localize 'STR_QS_Diary_103',
		(format [localize 'STR_QS_Diary_104',(actionKeysNames 'TacticalPing'),(actionKeysNames 'ReloadMagazine'),(actionKeysNames 'Diary'),(actionKeysNames 'Help'),(actionKeysNames 'GetOver'),(actionKeysNames 'Teamswitch')])
	]
];

if ((getPlayerUID player) in (['ALL'] call (missionNamespace getVariable 'QS_fnc_whitelist'))) then {
	player createDiaryRecord [
		'QS_diary_hotkeys',
		[
			localize 'STR_QS_Diary_116',
			localize 'STR_QS_Diary_117'
		]
	];
	if ((getPlayerUID player) in (['CURATOR'] call (missionNamespace getVariable 'QS_fnc_whitelist'))) then {
		player createDiaryRecord [
			'QS_diary_hotkeys',
			[
				localize 'STR_QS_Diary_119',
				localize 'STR_QS_Diary_120'
			]
		];
	};
};

/*/ Enable or change this if you like/*/
player createDiaryRecord [
	'QS_diary_rules',
	[
		localize 'STR_QS_Diary_121',
		localize 'STR_QS_Diary_122'
	]
];

/*/ Enable or change this if you like/*/
player createDiaryRecord [
	'QS_diary_rules',
	[
		localize 'STR_QS_Diary_123',
		localize 'STR_QS_Diary_124'
	]
];

/*/ Enable or change this if you like/*/
player createDiaryRecord [
	'QS_diary_rules',
	[
		localize 'STR_QS_Diary_125',
		localize 'STR_QS_Diary_126'
	]
];
/*/ Enable or change this if you like/*/
player createDiaryRecord [
	'QS_diary_rules',
	[
		localize 'STR_QS_Diary_127',
		localize 'STR_QS_Diary_128'
	]
];
player createDiaryRecord [
	'QS_diary_rules',
	[
		localize 'STR_QS_Diary_129',
		if (isLocalized 'STR_QS_Diary_130') then {localize 'STR_QS_Diary_130'} else {(missionNamespace getVariable ['QS_missionConfig_splash_serverRules',''])}
	]
];


/*/-------------------------------------------------- Mods/*/

/*/ Enable or change this if you like/*/
player createDiaryRecord [
	'QS_diary_mods',
	[
		localize 'STR_QS_Diary_131',
		localize 'STR_QS_Diary_132'
	]
];

player createDiaryRecord [
	'QS_diary_gitmo',
	[
		localize 'STR_QS_Diary_133',
		localize 'STR_QS_Diary_134'
	]
];

/*/-------------------------------------------------- Teamspeak/*/

player createDiaryRecord [
	'QS_diary_communication',
	[
		localize 'STR_QS_Diary_135',
		(format [localize 'STR_QS_Diary_136',(missionNamespace getVariable ['QS_missionConfig_commTS',''])])
	]
];
/*/-------------------------------------------------- Discord/*/
player createDiaryRecord [
	'QS_diary_communication',
	[
		localize 'STR_QS_Diary_137',
		(format [localize 'STR_QS_Diary_138',(missionNamespace getVariable ['QS_missionConfig_commDS_Adres',''])])
	]
];

/*/-------------------------------------------------- Credits/*/
player createDiarySubject [
    'QS_diary_credits',localize 'STR_QS_Diary_139'];				// EULA relevant line.

////////////////////////////////// EDIT BELOW ///////////////////////////////////////

player createDiaryRecord [
	'QS_diary_credits',
	[
		localize 'STR_QS_Diary_140',
		(format ["%1 <executeClose expression=""createDialog 'QS_RD_client_dialog_menu_hub';"">%2</executeClose> %3",(localize 'STR_QS_Diary_141'),(localize 'STR_QS_Diary_142'),(localize 'STR_QS_Diary_143')])
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
		localize 'STR_QS_Diary_144',
		(format ["%1 <executeClose expression=""createDialog 'QS_RD_client_dialog_menu_hub';"">%2</executeClose> %3",(localize 'STR_QS_Diary_145'),(localize 'STR_QS_Diary_146'),(localize 'STR_QS_Diary_147')])
	]
];