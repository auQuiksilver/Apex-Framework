/*/
File: QS_data_planeLoadouts.sqf
Author:

	Quiksilver
	
Last modified:

	15/12/2022 A3 2.10 by Quiksilver
	
Description:

	Plane Pylon Preset Data
___________________________________________________/*/

[
	[
		'b_plane_cas_01_dynamicloadout_f',
		[
			[
				localize 'STR_QS_Dialogs_089',		// AA
				localize 'STR_QS_Dialogs_090',		// Anti-Air
				[
					[1,'Pylons1',[-1],'PylonRack_1Rnd_Missile_AA_04_F',1,'0:10000605'],
					[2,'Pylons2',[-1],'PylonRack_1Rnd_AAA_missiles',1,'0:10000606'],
					[3,'Pylons3',[-1],'PylonRack_1Rnd_AAA_missiles',1,'0:10000607'],
					[4,'Pylons4',[-1],'PylonRack_1Rnd_AAA_missiles',1,'0:10000608'],
					[5,'Pylons5',[-1],'PylonMissile_1Rnd_Bomb_04_F',1,'0:10000610'],
					[6,'Pylons6',[-1],'PylonMissile_1Rnd_Bomb_04_F',1,'0:10000611'],
					[7,'Pylons7',[-1],'PylonRack_1Rnd_AAA_missiles',1,'0:10000612'],
					[8,'Pylons8',[-1],'PylonRack_1Rnd_AAA_missiles',1,'0:10000613'],
					[9,'Pylons9',[-1],'PylonRack_1Rnd_AAA_missiles',1,'0:10000614'],
					[10,'Pylons10',[-1],'PylonRack_1Rnd_Missile_AA_04_F',1,'0:10000615']
				],
				{TRUE},		// Enabled/Disabled
				1,			// Laser-equipped
				0,			// Stealth
				0			// DLC Required
			],
			[
				localize 'STR_QS_Dialogs_091',		// CAS (Bombs)
				localize 'STR_QS_Dialogs_088',		// Close Air Support
				[
					[1,'Pylons1',[-1],'PylonRack_1Rnd_Missile_AA_04_F',1,'0:10000616'],
					[2,'Pylons2',[-1],'PylonMissile_1Rnd_Bomb_04_F',1,'0:10000617'],
					[3,'Pylons3',[-1],'PylonMissile_1Rnd_Bomb_04_F',1,'0:10000618'],
					[4,'Pylons4',[-1],'PylonMissile_1Rnd_Bomb_04_F',1,'0:10000619'],
					[5,'Pylons5',[-1],'PylonMissile_1Rnd_Bomb_04_F',1,'0:10000620'],
					[6,'Pylons6',[-1],'PylonMissile_1Rnd_Bomb_04_F',1,'0:10000621'],
					[7,'Pylons7',[-1],'PylonMissile_1Rnd_Bomb_04_F',1,'0:10000622'],
					[8,'Pylons8',[-1],'PylonMissile_1Rnd_Bomb_04_F',1,'0:10000623'],
					[9,'Pylons9',[-1],'PylonMissile_1Rnd_Bomb_04_F',1,'0:10000624'],
					[10,'Pylons10',[-1],'PylonRack_1Rnd_Missile_AA_04_F',1,'0:10000625']
				],
				{TRUE},		// Enabled/Disabled
				1,		// Laser-equipped
				0,		// Stealth
				0		// DLC Required
			],
			[
				localize 'STR_QS_Dialogs_092',		// CAS
				localize 'STR_QS_Dialogs_088',
				[
					[1,'Pylons1',[-1],'PylonRack_1Rnd_Missile_AA_04_F',1,'0:10000707'],
					[2,'Pylons2',[-1],'PylonRack_1Rnd_Missile_AA_04_F',1,'0:10000708'],
					[3,'Pylons3',[-1],'PylonRack_7Rnd_Rocket_04_AP_F',7,'0:10000709'],
					[4,'Pylons4',[-1],'PylonMissile_1Rnd_Bomb_04_F',1,'0:10000710'],
					[5,'Pylons5',[-1],'PylonMissile_1Rnd_Bomb_04_F',1,'0:10000711'],
					[6,'Pylons6',[-1],'PylonMissile_1Rnd_Bomb_04_F',1,'0:10000712'],
					[7,'Pylons7',[-1],'PylonMissile_1Rnd_Bomb_04_F',1,'0:10000713'],
					[8,'Pylons8',[-1],'PylonRack_7Rnd_Rocket_04_AP_F',7,'0:10000714'],
					[9,'Pylons9',[-1],'PylonRack_1Rnd_Missile_AA_04_F',1,'0:10000715'],
					[10,'Pylons10',[-1],'PylonRack_1Rnd_Missile_AA_04_F',1,'0:10000716']
				],
				{TRUE},		// Enabled/Disabled
				1,		// Laser-equipped
				0,		// Stealth
				0		// DLC Required
			]
		]
	],
	[
		'b_plane_fighter_01_f',
		[
			[
				localize 'STR_QS_Dialogs_089',
				localize 'STR_QS_Dialogs_090',
				[
					[1,'pylon1',[-1],'PylonRack_Missile_AMRAAM_D_x2',2,'0:10000636'],
					[2,'pylon2',[-1],'PylonRack_Missile_AMRAAM_D_x2',2,'0:10000637'],
					[3,'pylon3',[-1],'PylonRack_Missile_BIM9X_x2',2,'0:10000638'],
					[4,'pylon4',[-1],'PylonRack_Missile_BIM9X_x2',2,'0:10000639'],
					[5,'pylonBayRight1',[-1],'PylonMissile_Missile_BIM9X_x1',1,'0:10000640'],
					[6,'pylonBayLeft1',[-1],'PylonMissile_Missile_BIM9X_x1',1,'0:10000641'],
					[7,'pylonBayCenter1',[-1],'PylonMissile_Missile_AMRAAM_D_INT_x1',1,'0:10000642'],
					[8,'pylonBayCenter2',[-1],'PylonMissile_Missile_AMRAAM_D_INT_x1',1,'0:10000643'],
					[9,'pylonBayCenter3',[-1],'PylonMissile_Missile_AMRAAM_D_INT_x1',1,'0:10000644'],
					[10,'pylonBayCenter4',[-1],'PylonMissile_Missile_AMRAAM_D_INT_x1',1,'0:10000645'],
					[11,'pylonBayCenter5',[-1],'PylonMissile_Bomb_GBU12_x1',1,'0:10000646'],
					[12,'pylonBayCenter6',[-1],'PylonMissile_Bomb_GBU12_x1',1,'0:10000647']
				],
				{TRUE},		// Enabled/Disabled
				1,		// Laser-equipped
				0,		// Stealth
				601670		// DLC Required
			],
			[
				localize 'STR_QS_Dialogs_091',
				localize 'STR_QS_Dialogs_088',
				[
					[1,'pylon1',[-1],'PylonMissile_Bomb_GBU12_x1',1,'0:10000648'],
					[2,'pylon2',[-1],'PylonMissile_Bomb_GBU12_x1',1,'0:10000649'],
					[3,'pylon3',[-1],'PylonRack_Bomb_GBU12_x2',2,'0:10000650'],
					[4,'pylon4',[-1],'PylonRack_Bomb_GBU12_x2',2,'0:10000651'],
					[5,'pylonBayRight1',[-1],'PylonMissile_Missile_BIM9X_x1',1,'0:10000652'],
					[6,'pylonBayLeft1',[-1],'PylonMissile_Missile_BIM9X_x1',1,'0:10000653'],
					[7,'pylonBayCenter1',[-1],'PylonMissile_Missile_AMRAAM_D_INT_x1',1,'0:10000654'],
					[8,'pylonBayCenter2',[-1],'PylonMissile_Missile_AMRAAM_D_INT_x1',1,'0:10000655'],
					[9,'pylonBayCenter3',[-1],'PylonRack_Bomb_SDB_x4',4,'0:10000657'],
					[10,'pylonBayCenter4',[-1],'PylonRack_Bomb_SDB_x4',4,'0:10000658'],
					[11,'pylonBayCenter5',[-1],'PylonMissile_Bomb_GBU12_x1',1,'0:10000659'],
					[12,'pylonBayCenter6',[-1],'PylonMissile_Bomb_GBU12_x1',1,'0:10000660']
				],
				{TRUE},		// Enabled/Disabled
				1,		// Laser-equipped
				0,		// Stealth
				601670		// DLC Required
			],
			[
				localize 'STR_QS_Dialogs_092',
				localize 'STR_QS_Dialogs_088',
				[
					[1,'pylon1',[-1],'PylonRack_Missile_BIM9X_x2',2,'0:10000674'],
					[2,'pylon2',[-1],'PylonRack_Missile_BIM9X_x2',2,'0:10000675'],
					[3,'pylon3',[-1],'PylonRack_Bomb_GBU12_x2',2,'0:10000676'],
					[4,'pylon4',[-1],'PylonRack_Bomb_GBU12_x2',2,'0:10000677'],
					[5,'pylonBayRight1',[-1],'PylonMissile_Missile_BIM9X_x1',1,'0:10000678'],
					[6,'pylonBayLeft1',[-1],'PylonMissile_Missile_BIM9X_x1',1,'0:10000679'],
					[7,'pylonBayCenter1',[-1],'PylonMissile_Missile_AMRAAM_D_INT_x1',1,'0:10000680'],
					[8,'pylonBayCenter2',[-1],'PylonMissile_Missile_AMRAAM_D_INT_x1',1,'0:10000681'],
					[9,'pylonBayCenter3',[-1],'PylonRack_Bomb_SDB_x4',4,'0:10000682'],
					[10,'pylonBayCenter4',[-1],'PylonRack_Bomb_SDB_x4',4,'0:10000683'],
					[11,'pylonBayCenter5',[-1],'PylonMissile_Bomb_GBU12_x1',1,'0:10000684'],
					[12,'pylonBayCenter6',[-1],'PylonMissile_Bomb_GBU12_x1',1,'0:10000685']
				],
				{TRUE},		// Enabled/Disabled
				1,		// Laser-equipped
				0,		// Stealth
				601670		// DLC Required
			]
		]
	],
	[
		'b_plane_fighter_01_stealth_f',
		[
			[
				localize 'STR_QS_Dialogs_093',
				localize 'STR_QS_Dialogs_094',
				[
					[1,'pylonDummy1',[-1],'',-1,''],
					[2,'pylonDummy2',[-1],'',-1,''],
					[3,'pylonDummy3',[-1],'',-1,''],
					[4,'pylonDummy4',[-1],'',-1,''],
					[5,'pylonBayRight1',[-1],'PylonMissile_Missile_BIM9X_x1',1,'0:10000741'],
					[6,'pylonBayLeft1',[-1],'PylonMissile_Missile_BIM9X_x1',1,'0:10000742'],
					[7,'pylonBayCenter1',[-1],'PylonMissile_Missile_AMRAAM_D_INT_x1',1,'0:10000743'],
					[8,'pylonBayCenter2',[-1],'PylonMissile_Missile_AMRAAM_D_INT_x1',1,'0:10000744'],
					[9,'pylonBayCenter3',[-1],'PylonMissile_Missile_AMRAAM_D_INT_x1',1,'0:10000745'],
					[10,'pylonBayCenter4',[-1],'PylonMissile_Missile_AMRAAM_D_INT_x1',1,'0:10000746'],
					[11,'pylonBayCenter5',[-1],'PylonMissile_Bomb_GBU12_x1',1,'0:10000748'],
					[12,'pylonBayCenter6',[-1],'PylonMissile_Missile_AMRAAM_D_INT_x1',1,'0:10000749']
				],
				{TRUE},		// Enabled/Disabled
				1,			// Laser-equipped
				0.25,			// Stealth
				601670			// DLC Required
			]
		]
	],
	[
		'o_plane_cas_02_dynamicloadout_f',
		[
			[
				localize 'STR_QS_Dialogs_089',
				localize 'STR_QS_Dialogs_090',
				[
					[1,'Pylons1',[-1],'PylonRack_1Rnd_Missile_AA_03_F',1,'0:10000780'],
					[2,'Pylons2',[-1],'PylonRack_1Rnd_Missile_AA_03_F',1,'0:10000781'],
					[3,'Pylons3',[-1],'PylonRack_1Rnd_Missile_AA_03_F',1,'0:10000782'],
					[4,'Pylons4',[-1],'PylonRack_1Rnd_Missile_AA_03_F',1,'0:10000783'],
					[5,'Pylons5',[-1],'PylonMissile_1Rnd_Bomb_03_F',1,'0:10000785'],
					[6,'Pylons6',[-1],'PylonMissile_1Rnd_Bomb_03_F',1,'0:10000786'],
					[7,'Pylons7',[-1],'PylonRack_1Rnd_Missile_AA_03_F',1,'0:10000787'],
					[8,'Pylons8',[-1],'PylonRack_1Rnd_Missile_AA_03_F',1,'0:10000788'],
					[9,'Pylons9',[-1],'PylonRack_1Rnd_Missile_AA_03_F',1,'0:10000789'],
					[10,'Pylons10',[-1],'PylonRack_1Rnd_Missile_AA_03_F',1,'0:10000790']
				],
				{TRUE},		// Enabled/Disabled
				1,		// Laser-equipped
				0,		// Stealth
				0		// DLC Required
			],
			[
				localize 'STR_QS_Dialogs_092',
				localize 'STR_QS_Dialogs_088',
				[
					[1,'Pylons1',[-1],'PylonRack_1Rnd_Missile_AA_03_F',1,'0:10000791'],
					[2,'Pylons2',[-1],'PylonRack_1Rnd_Missile_AA_03_F',1,'0:10000792'],
					[3,'Pylons3',[-1],'PylonRack_20Rnd_Rocket_03_AP_F',20,'0:10000793'],
					[4,'Pylons4',[-1],'PylonMissile_1Rnd_Bomb_03_F',1,'0:10000794'],
					[5,'Pylons5',[-1],'PylonMissile_1Rnd_Bomb_03_F',1,'0:10000795'],
					[6,'Pylons6',[-1],'PylonMissile_1Rnd_Bomb_03_F',1,'0:10000796'],
					[7,'Pylons7',[-1],'PylonMissile_1Rnd_Bomb_03_F',1,'0:10000797'],
					[8,'Pylons8',[-1],'PylonRack_20Rnd_Rocket_03_AP_F',20,'0:10000798'],
					[9,'Pylons9',[-1],'PylonRack_1Rnd_Missile_AA_03_F',1,'0:10000799'],
					[10,'Pylons10',[-1],'PylonRack_1Rnd_Missile_AA_03_F',1,'0:10000800']
				],
				{TRUE},		// Enabled/Disabled
				1,		// Laser-equipped
				0,		// Stealth
				0		// DLC Required
			],
			[
				localize 'STR_QS_Dialogs_091',
				localize 'STR_QS_Dialogs_088',
				[
					[1,'Pylons1',[-1],'PylonRack_1Rnd_Missile_AA_03_F',1,'0:10000770'],
					[2,'Pylons2',[-1],'PylonRack_1Rnd_Missile_AA_03_F',1,'0:10000771'],
					[3,'Pylons3',[-1],'PylonMissile_1Rnd_Bomb_03_F',1,'0:10000772'],
					[4,'Pylons4',[-1],'PylonMissile_1Rnd_Bomb_03_F',1,'0:10000773'],
					[5,'Pylons5',[-1],'PylonMissile_1Rnd_Bomb_03_F',1,'0:10000774'],
					[6,'Pylons6',[-1],'PylonMissile_1Rnd_Bomb_03_F',1,'0:10000775'],
					[7,'Pylons7',[-1],'PylonMissile_1Rnd_Bomb_03_F',1,'0:10000776'],
					[8,'Pylons8',[-1],'PylonMissile_1Rnd_Bomb_03_F',1,'0:10000777'],
					[9,'Pylons9',[-1],'PylonRack_1Rnd_Missile_AA_03_F',1,'0:10000778'],
					[10,'Pylons10',[-1],'PylonRack_1Rnd_Missile_AA_03_F',1,'0:10000779']
				],
				{TRUE},		// Enabled/Disabled
				1,		// Laser-equipped
				0,		// Stealth
				0		// DLC Required
			]
		]
	],
	[
		'o_plane_fighter_02_f',
		[
			[
				localize 'STR_QS_Dialogs_089',
				localize 'STR_QS_Dialogs_090',
				[
					[1,'pylons1',[-1],'PylonMissile_Missile_AA_R73_x1',1,'0:10000814'],
					[2,'pylons2',[-1],'PylonMissile_Missile_AA_R73_x1',1,'0:10000815'],
					[3,'pylons3',[-1],'PylonMissile_Missile_AA_R73_x1',1,'0:10000816'],
					[4,'pylons4',[-1],'PylonMissile_Missile_AA_R73_x1',1,'0:10000817'],
					[5,'pylons5',[-1],'PylonMissile_Missile_AA_R73_x1',1,'0:10000818'],
					[6,'pylons6',[-1],'PylonMissile_Missile_AA_R73_x1',1,'0:10000819'],
					[7,'pylonBayRight1',[-1],'PylonMissile_Missile_AA_R73_x1',1,'0:10000820'],
					[8,'pylonBayLeft1',[-1],'PylonMissile_Missile_AA_R73_x1',1,'0:10000821'],
					[9,'pylonBayRight2',[-1],'PylonMissile_Missile_AA_R77_x1',1,'0:10000822'],
					[10,'pylonBayLeft2',[-1],'PylonMissile_Missile_AA_R77_x1',1,'0:10000823'],
					[11,'pylonBayCenter1',[-1],'PylonMissile_Missile_AA_R77_INT_x1',1,'0:10000824'],
					[12,'pylonBayCenter2',[-1],'PylonMissile_Missile_AA_R77_INT_x1',1,'0:10000825'],
					[13,'pylonBayCenter3',[-1],'PylonMissile_Bomb_KAB250_x1',1,'0:10000827']
				],
				{TRUE},		// Enabled/Disabled
				1,		// Laser-equipped
				0,		// Stealth
				601670		// DLC Required
			],
			[
				localize 'STR_QS_Dialogs_092',
				localize 'STR_QS_Dialogs_088',
				[
					[1,'pylons1',[-1],'PylonMissile_Missile_AA_R73_x1',1,'0:10000828'],
					[2,'pylons2',[-1],'PylonMissile_Missile_AA_R73_x1',1,'0:10000829'],
					[3,'pylons3',[-1],'PylonMissile_Bomb_KAB250_x1',1,'0:10000830'],
					[4,'pylons4',[-1],'PylonMissile_Bomb_KAB250_x1',1,'0:10000831'],
					[5,'pylons5',[-1],'PylonMissile_Bomb_KAB250_x1',1,'0:10000832'],
					[6,'pylons6',[-1],'PylonMissile_Bomb_KAB250_x1',1,'0:10000833'],
					[7,'pylonBayRight1',[-1],'PylonMissile_Missile_AA_R73_x1',1,'0:10000834'],
					[8,'pylonBayLeft1',[-1],'PylonMissile_Missile_AA_R73_x1',1,'0:10000835'],
					[9,'pylonBayRight2',[-1],'PylonMissile_Missile_AA_R77_x1',1,'0:10000836'],
					[10,'pylonBayLeft2',[-1],'PylonMissile_Missile_AA_R77_x1',1,'0:10000837'],
					[11,'pylonBayCenter1',[-1],'PylonMissile_Missile_AA_R77_INT_x1',1,'0:10000838'],
					[12,'pylonBayCenter2',[-1],'PylonMissile_Missile_AA_R77_INT_x1',1,'0:10000839'],
					[13,'pylonBayCenter3',[-1],'PylonMissile_Bomb_KAB250_x1',1,'0:10000840']
				],
				{TRUE},		// Enabled/Disabled
				1,		// Laser-equipped
				0,		// Stealth
				601670		// DLC Required
			]
		]
	],
	[
		'o_plane_fighter_02_stealth_f',
		[
			[
				localize 'STR_QS_Dialogs_093',
				localize 'STR_QS_Dialogs_094',
				[
					[1,'pylonDummy1',[-1],'',-1,''],
					[2,'pylonDummy2',[-1],'',-1,''],
					[3,'pylonDummy3',[-1],'',-1,''],
					[4,'pylonDummy4',[-1],'',-1,''],
					[5,'pylonDummy5',[-1],'',-1,''],
					[6,'pylonDummy6',[-1],'',-1,''],
					[7,'pylonBayRight1',[-1],'PylonMissile_Missile_AA_R73_x1',1,'0:10000253'],
					[8,'pylonBayLeft1',[-1],'PylonMissile_Missile_AA_R73_x1',1,'0:10000254'],
					[9,'pylonBayRight2',[-1],'PylonMissile_Missile_AA_R77_x1',1,'0:10000256'],
					[10,'pylonBayLeft2',[-1],'PylonMissile_Missile_AA_R77_x1',1,'0:10000257'],
					[11,'pylonBayCenter1',[-1],'PylonMissile_Missile_AA_R77_INT_x1',1,'0:10000258'],
					[12,'pylonBayCenter2',[-1],'PylonMissile_Missile_AA_R77_INT_x1',1,'0:10000259'],
					[13,'pylonBayCenter3',[-1],'PylonMissile_Bomb_KAB250_x1',1,'0:10000261']
				],
				{TRUE},		// Enabled/Disabled
				1,		// Laser-equipped
				0.25,		// Stealth
				601670		// DLC Required
			]
		]
	],
	[
		'i_plane_fighter_03_dynamicloadout_f',
		[
			[
				localize 'STR_QS_Dialogs_089',
				localize 'STR_QS_Dialogs_090',
				[
					[1,'Pylons1',[-1],'PylonRack_1Rnd_Missile_AA_04_F',1,'0:10000856'],
					[2,'Pylons2',[-1],'PylonRack_1Rnd_AAA_missiles',1,'0:10000857'],
					[3,'Pylons3',[-1],'PylonRack_1Rnd_GAA_missiles',1,'0:10000859'],
					[4,'Pylons4',[-1],'PylonWeapon_300Rnd_20mm_shells',300,'0:10000860'],
					[5,'Pylons5',[-1],'PylonRack_1Rnd_GAA_missiles',1,'0:10000861'],
					[6,'Pylons6',[-1],'PylonRack_1Rnd_AAA_missiles',1,'0:10000862'],
					[7,'Pylons7',[-1],'PylonRack_1Rnd_Missile_AA_04_F',1,'0:10000863']
				],
				{TRUE},		// Enabled/Disabled
				1,		// Laser-equipped
				0,		// Stealth
				0		// DLC Required
			],
			[
				localize 'STR_QS_Dialogs_091',
				localize 'STR_QS_Dialogs_088',
				[
					[1,'Pylons1',[-1],'PylonRack_1Rnd_Missile_AA_04_F',1,'0:10000865'],
					[2,'Pylons2',[-1],'PylonRack_1Rnd_AAA_missiles',1,'0:10000866'],
					[3,'Pylons3',[-1],'PylonMissile_1Rnd_Bomb_04_F',1,'0:10000867'],
					[4,'Pylons4',[-1],'PylonWeapon_300Rnd_20mm_shells',300,'0:10000868'],
					[5,'Pylons5',[-1],'PylonMissile_1Rnd_Bomb_04_F',1,'0:10000869'],
					[6,'Pylons6',[-1],'PylonRack_1Rnd_AAA_missiles',1,'0:10000870'],
					[7,'Pylons7',[-1],'PylonRack_1Rnd_Missile_AA_04_F',1,'0:10000871']
				],
				{TRUE},		// Enabled/Disabled
				1,		// Laser-equipped
				0,		// Stealth
				0		// DLC Required
			],
			[
				localize 'STR_QS_Dialogs_092',
				localize 'STR_QS_Dialogs_088',
				[
					[1,'Pylons1',[-1],'PylonRack_1Rnd_Missile_AA_04_F',1,'0:10000881'],
					[2,'Pylons2',[-1],'PylonRack_7Rnd_Rocket_04_AP_F',7,'0:10000882'],
					[3,'Pylons3',[-1],'PylonRack_1Rnd_LG_scalpel',1,'0:10000883'],
					[4,'Pylons4',[-1],'PylonWeapon_300Rnd_20mm_shells',300,'0:10000884'],
					[5,'Pylons5',[-1],'PylonMissile_1Rnd_Bomb_04_F',1,'0:10000885'],
					[6,'Pylons6',[-1],'PylonRack_7Rnd_Rocket_04_HE_F',7,'0:10000887'],
					[7,'Pylons7',[-1],'PylonRack_1Rnd_Missile_AA_04_F',1,'0:10000888']
				],
				{TRUE},		// Enabled/Disabled
				1,		// Laser-equipped
				0,		// Stealth
				0		// DLC Required
			],
			[
				localize 'STR_QS_Dialogs_092',
				localize 'STR_QS_Dialogs_088',
				[
					[1,'Pylons1',[-1],'PylonRack_1Rnd_Missile_AA_04_F',1,'0:10000931'],
					[2,'Pylons2',[-1],'PylonRack_1Rnd_AAA_missiles',1,'0:10000932'],
					[3,'Pylons3',[-1],'PylonMissile_1Rnd_Bomb_04_F',1,'0:10000933'],
					[4,'Pylons4',[-1],'',-1,''],
					[5,'Pylons5',[-1],'PylonRack_1Rnd_LG_scalpel',1,'0:10000934'],				// yes a scalpel
					[6,'Pylons6',[-1],'PylonRack_1Rnd_AAA_missiles',1,'0:10000935'],
					[7,'Pylons7',[-1],'PylonRack_1Rnd_Missile_AA_04_F',1,'0:10000936']
				],
				{TRUE},		// Enabled/Disabled
				1,		// Laser-equipped
				0,		// Stealth
				0		// DLC Required
			]
		]
	],
	[
		'i_plane_fighter_04_f',
		[
			[
				localize 'STR_QS_Dialogs_089',
				localize 'STR_QS_Dialogs_090',
				[
					[1,'pylon1',[-1],'PylonMissile_Missile_BIM9X_x1',1,'0:10000937'],
					[2,'pylon2',[-1],'PylonMissile_Missile_BIM9X_x1',1,'0:10000938'],
					[3,'pylon3',[-1],'PylonRack_Missile_AMRAAM_C_x1',1,'0:10000939'],
					[4,'Pylon4',[-1],'PylonRack_Missile_AMRAAM_C_x1',1,'0:10000940'],
					[5,'pylon5',[-1],'PylonRack_Missile_BIM9X_x2',2,'0:10000941'],
					[6,'Pylon6',[-1],'PylonRack_Missile_BIM9X_x2',2,'0:10000942']
				],
				{TRUE},		// Enabled/Disabled
				1,		// Laser-equipped
				0,		// Stealth
				601670		// DLC Required
			],
			[
				localize 'STR_QS_Dialogs_092',
				localize 'STR_QS_Dialogs_088',
				[
					[1,'pylon1',[-1],'PylonMissile_Missile_BIM9X_x1',1,'0:10000943'],
					[2,'pylon2',[-1],'PylonMissile_Missile_BIM9X_x1',1,'0:10000944'],
					[3,'pylon3',[-1],'PylonRack_Missile_BIM9X_x1',1,'0:10000945'],
					[4,'Pylon4',[-1],'PylonRack_Missile_BIM9X_x1',1,'0:10000946'],
					[5,'pylon5',[-1],'PylonMissile_Bomb_GBU12_x1',1,'0:10000948'],
					[6,'Pylon6',[-1],'PylonMissile_Bomb_GBU12_x1',1,'0:10000949']
				],
				{TRUE},		// Enabled/Disabled
				1,		// Laser-equipped
				0,		// Stealth
				601670		// DLC Required
			]
		]
	],
	[
		'o_heli_attack_02_dynamicloadout_f',
		[
			[
				localize 'STR_QS_Dialogs_092',
				localize 'STR_QS_Dialogs_088',
				[
					[1,'PylonLeft1',[0],'PylonRack_20Rnd_Rocket_03_AP_F',20,'0:10001235'],
					[2,'PylonLeft2',[0],'PylonRack_20Rnd_Rocket_03_HE_F',20,'0:10001237'],
					[3,'PylonRight2',[0],'PylonRack_20Rnd_Rocket_03_HE_F',20,'0:10001238'],
					[4,'PylonRight1',[0],'PylonRack_20Rnd_Rocket_03_AP_F',20,'0:10001239']
				],
				{TRUE},		// Enabled/Disabled
				1,		// Laser-equipped
				0,		// Stealth
				0		// DLC Required
			]
		]
	],
	[
		'o_heli_light_02_dynamicloadout_f',
		[
			[
				localize 'STR_QS_Dialogs_092',
				localize 'STR_QS_Dialogs_088',
				[
					[1,'PylonLeft1',[-1],'PylonRack_19Rnd_Rocket_Skyfire',19,'0:10001249'],
					[2,'PylonRight1',[-1],'PylonRack_19Rnd_Rocket_Skyfire',19,'0:10001250']
				],
				{TRUE},		// Enabled/Disabled
				1,		// Laser-equipped
				0,		// Stealth
				0		// DLC Required
			]
		]
	],
	[
		'b_heli_light_01_dynamicloadout_f',
		[
			[
				localize 'STR_QS_Dialogs_092',
				localize 'STR_QS_Dialogs_088',
				[
					[1,'PylonLeft1',[-1],'PylonRack_12Rnd_missiles',12,'0:10001223'],
					[2,'PylonRight1',[-1],'PylonRack_12Rnd_missiles',12,'0:10001224']
				],
				{TRUE},		// Enabled/Disabled
				1,		// Laser-equipped
				0.25,		// Stealth
				0		// DLC Required
			],
			[
				localize 'STR_QS_Dialogs_095', 			// Recon (AT)
				localize 'STR_QS_Dialogs_096',			// Anti-Tank
				[
					[1,'PylonLeft1',[-1],'PylonRack_7Rnd_Rocket_04_AP_F',7,'0:10001223'],
					[2,'PylonRight1',[-1],'PylonRack_7Rnd_Rocket_04_AP_F',7,'0:10001224']
				],
				{TRUE},		// Enabled/Disabled
				1,		// Laser-equipped
				0.25,		// Stealth
				0		// DLC Required
			],
			[
				localize 'STR_QS_Dialogs_097',		// Recon (AA)
				localize 'STR_QS_Dialogs_090',
				[
					[1,'PylonLeft1',[-1],'PylonRack_1Rnd_AAA_missiles',1,'0:10001101'],
					[2,'PylonRight1',[-1],'PylonRack_1Rnd_AAA_missiles',1,'0:10001102']
				],
				{TRUE},		// Enabled/Disabled
				1,		// Laser-equipped
				0.25,		// Stealth
				0		// DLC Required
			]
		]
	],
	[
		'b_heli_attack_01_dynamicloadout_f',
		[
			[
				localize 'STR_QS_Dialogs_097',
				localize 'STR_QS_Dialogs_098',			// Recon (Anti-Air)
				[
					[1,'PylonLeft1',[0],'PylonMissile_1Rnd_AAA_missiles',1,'0:10001211'],
					[2,'PylonLeft2',[0],'PylonMissile_1Rnd_AAA_missiles',1,'0:10001212'],
					[3,'PylonLeft3',[0],'PylonRack_12Rnd_missiles',12,'0:10001214'],
					[4,'PylonRight3',[0],'PylonRack_12Rnd_missiles',12,'0:10001215'],
					[5,'PylonRight2',[0],'PylonMissile_1Rnd_AAA_missiles',1,'0:10001216'],
					[6,'PylonRight1',[0],'PylonMissile_1Rnd_AAA_missiles',1,'0:10001217']
				],
				{TRUE},		// Enabled/Disabled
				1,		// Laser-equipped
				0.25,		// Stealth
				0		// DLC Required
			],
			[
				localize 'STR_QS_Dialogs_092',
				localize 'STR_QS_Dialogs_088',
				[
					[1,'PylonLeft1',[0],'PylonRack_12Rnd_missiles',12,'0:10001211'],
					[2,'PylonLeft2',[0],'PylonMissile_1Rnd_AAA_missiles',1,'0:10001212'],
					[3,'PylonLeft3',[0],'PylonRack_12Rnd_missiles',12,'0:10001214'],
					[4,'PylonRight3',[0],'PylonRack_12Rnd_missiles',12,'0:10001215'],
					[5,'PylonRight2',[0],'PylonMissile_1Rnd_AAA_missiles',1,'0:10001216'],
					[6,'PylonRight1',[0],'PylonRack_12Rnd_missiles',12,'0:10001217']
				],
				{TRUE},		// Enabled/Disabled
				1,		// Laser-equipped
				0.25,		// Stealth
				0		// DLC Required
			]
		]
	],
	[
		'i_heli_light_03_dynamicloadout_f',
		[
			[
				localize 'STR_QS_Dialogs_092',
				localize 'STR_QS_Dialogs_088',
				[
					[1,'PylonLeft1',[-1],'PylonRack_12Rnd_missiles',12,'0:10001308'],
					[2,'PylonRight1',[-1],'PylonRack_12Rnd_missiles',12,'0:10001309']
				],
				{TRUE},		// Enabled/Disabled
				1,		// Laser-equipped
				0,		// Stealth
				0		// DLC Required
			],
			[
				localize 'STR_QS_Dialogs_099',			// CAS (AT)
				localize 'STR_QS_Dialogs_100',			// Close Air Support (Anti-Tank)
				[
					[1,'PylonLeft1',[-1],'PylonRack_7Rnd_Rocket_04_AP_F',7,'0:10001308'],
					[2,'PylonRight1',[-1],'PylonRack_7Rnd_Rocket_04_AP_F',7,'0:10001309']
				],
				{TRUE},		// Enabled/Disabled
				1,		// Laser-equipped
				0,		// Stealth
				0		// DLC Required
			],
			[
				localize 'STR_QS_Dialogs_097',
				localize 'STR_QS_Dialogs_090',
				[
					[1,'PylonLeft1',[-1],'PylonRack_1Rnd_AAA_missiles',1,'0:10001101'],
					[2,'PylonRight1',[-1],'PylonRack_1Rnd_AAA_missiles',1,'0:10001102']
				],
				{TRUE},		// Enabled/Disabled
				1,		// Laser-equipped
				0.25,		// Stealth
				0		// DLC Required
			]
		]
	],
	[
		'b_t_uav_03_dynamicloadout_f',
		[
			[
				localize 'STR_QS_Dialogs_092',
				localize 'STR_QS_Dialogs_088',
				[
					[1,'Pylons1',[0],'PylonRack_7Rnd_Rocket_04_HE_F',7,'0:10001347'],
					[2,'Pylons2',[0],'PylonRack_7Rnd_Rocket_04_AP_F',7,'0:10001348'],
					[3,'Pylons3',[0],'PylonRack_7Rnd_Rocket_04_AP_F',7,'0:10001349'],
					[4,'Pylons4',[0],'PylonRack_7Rnd_Rocket_04_HE_F',7,'0:10001350']
				],
				{TRUE},		// Enabled/Disabled
				1,		// Laser-equipped
				0,		// Stealth
				395180		// DLC Required
			]
		]
	],
	[
		'b_uav_05_f',
		[
			[
				localize 'STR_QS_Dialogs_092',
				localize 'STR_QS_Dialogs_088',
				[
					[1,'pylon1',[0],'PylonMissile_Bomb_GBU12_x1',1,'0:10001401'],
					[2,'pylon2',[0],'PylonMissile_Bomb_GBU12_x1',1,'0:10001402']
				],
				{TRUE},		// Enabled/Disabled
				1,		// Laser-equipped
				0,		// Stealth
				601670		// DLC Required
			]
		]
	],
	[
		'b_uav_02_dynamicloadout_f',
		[
			[
				localize 'STR_QS_Dialogs_092',
				localize 'STR_QS_Dialogs_088',
				[
					[1,'pylons1',[0],'PylonMissile_1Rnd_Bomb_04_F',1,'0:10001441'],
					[2,'pylons2',[0],'PylonMissile_1Rnd_Bomb_04_F',1,'0:10001442']
				],
				{TRUE},		// Enabled/Disabled
				1,		// Laser-equipped
				0,		// Stealth
				0		// DLC Required
			]
		]
	],
	[
		'o_uav_02_dynamicloadout_f',
		[
			[
				localize 'STR_QS_Dialogs_092',
				localize 'STR_QS_Dialogs_088',
				[
					[1,'pylons1',[0],'PylonMissile_1Rnd_Bomb_03_F',1,'0:10001444'],
					[2,'pylons2',[0],'PylonMissile_1Rnd_Bomb_03_F',1,'0:10001445']
				],
				{TRUE},		// Enabled/Disabled
				1,		// Laser-equipped
				0,		// Stealth
				0		// DLC Required
			]
		]
	],
	[
		'i_uav_02_dynamicloadout_f',
		[
			[
				localize 'STR_QS_Dialogs_092',
				localize 'STR_QS_Dialogs_088',
				[
					[1,'pylons1',[0],'PylonMissile_1Rnd_Bomb_04_F',1,'0:10001438'],
					[2,'pylons2',[0],'PylonMissile_1Rnd_Bomb_04_F',1,'0:10001439']
				],
				{TRUE},		// Enabled/Disabled
				1,		// Laser-equipped
				0,		// Stealth
				0		// DLC Required
			]
		]
	],
	[
		'o_t_vtol_02_infantry_dynamicloadout_f',
		[
			[
				localize 'STR_QS_Dialogs_092',
				localize 'STR_QS_Dialogs_088',
				[
					[1,'PylonRight1',[0],'PylonRack_20Rnd_Rocket_03_HE_F',20,'0:10001544'],
					[2,'PylonRight2',[0],'PylonRack_20Rnd_Rocket_03_AP_F',20,'0:10001546'],
					[3,'PylonLeft2',[0],'PylonRack_20Rnd_Rocket_03_AP_F',20,'0:10001547'],
					[4,'PylonLeft1',[0],'PylonRack_20Rnd_Rocket_03_HE_F',20,'0:10001548']
				],
				{TRUE},		// Enabled/Disabled
				1,		// Laser-equipped
				0,		// Stealth
				395180		// DLC Required
			]
		]
	],
	[
		'o_t_vtol_02_vehicle_dynamicloadout_f',
		[
			[
				localize 'STR_QS_Dialogs_092',
				localize 'STR_QS_Dialogs_088',
				[
					[1,'PylonLeft1',[0],'PylonRack_20Rnd_Rocket_03_HE_F',20,'0:10001550'],
					[2,'PylonLeft2',[0],'PylonRack_20Rnd_Rocket_03_AP_F',20,'0:10001552'],
					[3,'PylonRight2',[0],'PylonRack_20Rnd_Rocket_03_AP_F',20,'0:10001553'],
					[4,'PylonRight1',[0],'PylonRack_20Rnd_Rocket_03_HE_F',20,'0:10001554']
				],
				{TRUE},		// Enabled/Disabled
				1,		// Laser-equipped
				0,		// Stealth
				395180		// DLC Required
			]
		]
	]
]