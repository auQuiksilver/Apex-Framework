/*/
File: QS_vehicleTextures.sqf
Author:

	Quiksilver
	
Last Modified:

	24/03/2018 A3 1.82 by Quiksilver
	
Description:

	Vehicle Skins
	
Data Structure:

	[0,'Dahoman',[[0,'A3\air_f_beta\Heli_Transport_02\Data\Skins\heli_transport_02_1_dahoman_co.paa'],[1,'A3\air_f_beta\Heli_Transport_02\Data\Skins\heli_transport_02_2_dahoman_co.paa'],[2,'A3\air_f_beta\Heli_Transport_02\Data\Skins\heli_transport_02_3_dahoman_co.paa']],'CH-49 Mohawk (Heli)',['I_Heli_Transport_02_F'],'Bohemia Interactive'],

	[ <just put number 0 here> , <ingame menu title> , <texture application logic (see next line) , <menu mouse-hover tooltip> , <list of classnames (case sensitive)> , <author text> ]
	
	For vehicle application logic, it plugs into this function:
	
		https://community.bistudio.com/wiki/setObjectTextureGlobal
		
	So for the above example, it looks like this:
		
		[
			[0,'A3\air_f_beta\Heli_Transport_02\Data\Skins\heli_transport_02_1_dahoman_co.paa'],
			[1,'A3\air_f_beta\Heli_Transport_02\Data\Skins\heli_transport_02_2_dahoman_co.paa'],
			[2,'A3\air_f_beta\Heli_Transport_02\Data\Skins\heli_transport_02_3_dahoman_co.paa']
		]
	
	And then in the menu script, it is executed like this:
	
		{
			<vehicle> setObjectTextureGlobal _x;
		} forEach [
			[0,'A3\air_f_beta\Heli_Transport_02\Data\Skins\heli_transport_02_1_dahoman_co.paa'],
			[1,'A3\air_f_beta\Heli_Transport_02\Data\Skins\heli_transport_02_2_dahoman_co.paa'],
			[2,'A3\air_f_beta\Heli_Transport_02\Data\Skins\heli_transport_02_3_dahoman_co.paa']
		];
		
	Which can also appear like this (but this is messier):
	
		<vehicle> setObjectTextureGlobal [0,'A3\air_f_beta\Heli_Transport_02\Data\Skins\heli_transport_02_1_dahoman_co.paa'];
		<vehicle> setObjectTextureGlobal [1,'A3\air_f_beta\Heli_Transport_02\Data\Skins\heli_transport_02_2_dahoman_co.paa'];
		<vehicle> setObjectTextureGlobal [2,'A3\air_f_beta\Heli_Transport_02\Data\Skins\heli_transport_02_3_dahoman_co.paa'];
		
	To see exactly where its executed (in v1.0.5):
	
		"code\functions\fn_clientMenuVTexture.sqf" line 104
		
	At the bottom of this file is a commented-out storage section where you can see some examples of custom skins in the correct data structure.
	
__________________________________________________________________________/*/

[
	[0,'Reset',[[0,'']],'',[''],''],
	[0,'Dazzle',[[0,"a3\soft_f_exp\lsv_01\data\nato_lsv_01_dazzle_co.paa"],[1,"a3\soft_f_exp\lsv_01\data\nato_lsv_02_olive_co.paa"],[2,"a3\soft_f_exp\lsv_01\data\nato_lsv_03_olive_co.paa"],[3,"a3\soft_f_exp\lsv_01\data\nato_lsv_adds_olive_co.paa"]],'Prowler (LSV)',["B_LSV_01_armed_black_F","B_LSV_01_armed_F","B_LSV_01_armed_olive_F","B_LSV_01_armed_sand_F","B_LSV_01_unarmed_black_F","B_LSV_01_unarmed_F","B_LSV_01_unarmed_olive_F","B_LSV_01_unarmed_sand_F","B_T_LSV_01_armed_black_F","B_T_LSV_01_armed_F","B_T_LSV_01_armed_olive_F","B_T_LSV_01_armed_sand_F","B_T_LSV_01_unarmed_black_F","B_T_LSV_01_unarmed_F","B_T_LSV_01_unarmed_olive_F","B_T_LSV_01_unarmed_sand_F"],'Bohemia Interactive'],
	[0,'Wave 2',[[0,'A3\air_f\Heli_Light_02\Data\heli_light_02_ext_civilian_co.paa']],'PO-30 Orca (Heli)',['o_heli_light_02_dynamicloadout_f','O_Heli_Light_02_F','O_Heli_Light_02_v2_F','O_Heli_Light_02_unarmed_F'],'Bohemia Interactive'],
	[0,'Indep',[[0,'A3\air_f\Heli_Light_02\Data\heli_light_02_ext_indp_co.paa']],'PO-30 Orca (Heli)',['o_heli_light_02_dynamicloadout_f','O_Heli_Light_02_F','O_Heli_Light_02_v2_F','O_Heli_Light_02_unarmed_F'],'Bohemia Interactive'],	
	[0,'Dahoman',[[0,'A3\air_f_beta\Heli_Transport_02\Data\Skins\heli_transport_02_1_dahoman_co.paa'],[1,'A3\air_f_beta\Heli_Transport_02\Data\Skins\heli_transport_02_2_dahoman_co.paa'],[2,'A3\air_f_beta\Heli_Transport_02\Data\Skins\heli_transport_02_3_dahoman_co.paa']],'CH-49 Mohawk (Heli)',['I_Heli_Transport_02_F'],'Bohemia Interactive'],
	[0,'Ion',[[0,'A3\air_f_beta\Heli_Transport_02\Data\Skins\heli_transport_02_1_ion_co.paa'],[1,'A3\air_f_beta\Heli_Transport_02\Data\Skins\heli_transport_02_2_ion_co.paa'],[2,'A3\air_f_beta\Heli_Transport_02\Data\Skins\heli_transport_02_3_ion_co.paa']],'CH-49 Mohawk (Heli)',['I_Heli_Transport_02_F'],'Bohemia Interactive'],
	[0,'Blackfoot (Green)',[[0,'A3\Air_F\Heli_Light_02\Data\heli_light_02_common_co.paa']],'AH-99 Blackfoot',['B_Heli_Attack_01_F','B_Heli_Attack_01_dynamicLoadout_F'],'Bohemia Interactive'],
	[0,'Gendarmerie',[[0,'a3\soft_f_exp\offroad_01\data\offroad_01_ext_gen_co.paa'],[1,'a3\soft_f_exp\offroad_01\data\offroad_01_ext_gen_co.paa']],'Offroad (Police)',['C_Offroad_01_blue_F','C_Offroad_01_bluecustom_F','C_Offroad_01_darkred_F','C_Offroad_01_F','C_Offroad_01_red_F','C_Offroad_01_repair_F','C_Offroad_01_sand_F','C_Offroad_01_white_F','C_Offroad_stripped_F','B_G_Offroad_01_armed_F','B_G_Offroad_01_F','B_G_Offroad_01_repair_F','I_G_Offroad_01_armed_F','I_G_Offroad_01_F','I_G_Offroad_01_repair_F','O_G_Offroad_01_armed_F','O_G_Offroad_01_F','O_G_Offroad_01_repair_F'],'Bohemia Interactive'],
	[0,'Digital',[[0,'A3\air_f\heli_light_01\data\skins\heli_light_01_ext_digital_co.paa']],'MH-9 Hummingbird (Heli)',['B_Heli_Light_01_F','B_Heli_Light_01_armed_F','C_Heli_Light_01_civil_F','B_Heli_Light_01_stripped_F','B_Heli_Light_01_dynamicLoadout_F'],'Bohemia Interactive'],
	[0,'Vrana',[[0,'A3\air_f\heli_light_01\data\skins\heli_light_01_ext_vrana_co.paa']],'MH-9 Hummingbird (Heli)',['B_Heli_Light_01_F','B_Heli_Light_01_armed_F','C_Heli_Light_01_civil_F','B_Heli_Light_01_stripped_F','B_Heli_Light_01_dynamicLoadout_F'],'Bohemia Interactive'],
	[0,'Wasp',[[0,'A3\air_f\heli_light_01\data\skins\heli_light_01_ext_wasp_co.paa']],'MH-9 Hummingbird (Heli)',['B_Heli_Light_01_F','B_Heli_Light_01_armed_F','C_Heli_Light_01_civil_F','B_Heli_Light_01_stripped_F','B_Heli_Light_01_dynamicLoadout_F'],'Bohemia Interactive'],
	[0,'Indep',[[0,'A3\Air_F\Heli_Light_01\Data\heli_light_01_ext_indp_co.paa']],'MH-9 Hummingbird (Heli)',['B_Heli_Light_01_F','B_Heli_Light_01_armed_F','C_Heli_Light_01_civil_F','B_Heli_Light_01_stripped_F','B_Heli_Light_01_dynamicLoadout_F'],'Bohemia Interactive'],
	[0,'Ion',[[0,'A3\air_f\Heli_Light_01\Data\heli_light_01_ext_ion_co.paa']],'MH-9 Hummingbird (Heli)',['B_Heli_Light_01_F','B_Heli_Light_01_armed_F','C_Heli_Light_01_civil_F','B_Heli_Light_01_stripped_F','B_Heli_Light_01_dynamicLoadout_F'],'Bohemia Interactive'],
	[
		0,'Gryphon',
		[
			[0,"a3\air_f_jets\plane_fighter_04\data\Fighter_04_fuselage_01_gray_co.paa"],
			[1,"a3\air_f_jets\plane_fighter_04\data\Fighter_04_fuselage_02_gray_co.paa"],
			[2,"a3\air_f_jets\plane_fighter_04\data\fighter_04_misc_01_co.paa"],
			[3,"a3\air_f_jets\plane_fighter_04\data\Numbers\Fighter_04_number_04_ca.paa"],
			[4,"a3\air_f_jets\plane_fighter_04\data\Numbers\Fighter_04_number_04_ca.paa"],
			[5,"a3\air_f_jets\plane_fighter_04\data\Numbers\Fighter_04_number_08_ca.paa"]
		],'A-149 Gryphon (Plane)',['I_Plane_Fighter_04_F'],'Bohemia Interactive'
	],
	[
		0,'Shikra',
		[
			[0,"a3\air_f_jets\plane_fighter_02\data\Fighter_02_fuselage_01_Grey_co.paa"],
			[1,"a3\air_f_jets\plane_fighter_02\data\Fighter_02_fuselage_02_Grey_co.paa"],
			[2,"a3\air_f_jets\plane_fighter_02\data\Fighter_02_fuselage_01_Grey_co.paa"],
			[3,"a3\air_f_jets\plane_fighter_02\data\Numbers\Fighter_02_number_02_co.paa"],
			[4,"a3\air_f_jets\plane_fighter_02\data\Numbers\Fighter_02_number_00_co.paa"],
			[5,"a3\air_f_jets\plane_fighter_02\data\Numbers\Fighter_02_number_01_co.paa"]
		],'To-201 Shikra (Plane)',['O_Plane_Fighter_02_F','O_Plane_Fighter_02_Stealth_F'],'Bohemia Interactive'
	],	
	[
		0,'F/A-181',
		[
			[0,"a3\air_f_jets\plane_fighter_01\data\fighter_01_fuselage_01_Camo_co.paa"],
			[1,"a3\air_f_jets\plane_fighter_01\data\fighter_01_fuselage_02_Camo_co.paa"],
			[2,"a3\air_f_jets\plane_fighter_01\data\fighter_01_glass_01_ca.paa"],
			[3,"a3\air_f_jets\plane_fighter_01\data\fighter_01_cockpit_01_co.paa"],
			[4,"a3\air_f_jets\plane_fighter_01\data\fighter_01_cockpit_02_co.paa"],
			[5,"a3\air_f_jets\plane_fighter_01\data\fighter_01_cockpit_05_co.paa"]
		],'F/A-181 Black Wasp II (Plane)',['B_Plane_Fighter_01_F','B_Plane_Fighter_01_Stealth_F'],'Bohemia Interactive'
	],
	[
		0,'F/A-182',
		[
			[0,"media\images\vskins\fa181\digitalwasp3.paa"],
			[1,"media\images\vskins\fa181\digitalwing3.paa"],
			[2,"a3\air_f_jets\plane_fighter_01\data\fighter_01_glass_01_ca.paa"],
			[3,"a3\air_f_jets\plane_fighter_01\data\fighter_01_cockpit_01_co.paa"],
			[4,"a3\air_f_jets\plane_fighter_01\data\fighter_01_cockpit_02_co.paa"],
			[5,"a3\air_f_jets\plane_fighter_01\data\fighter_01_cockpit_05_co.paa"]
		],'F/A-181 Black Wasp II (Plane)',['B_Plane_Fighter_01_F','B_Plane_Fighter_01_Stealth_F'],'Archimedes'
	],
	[
		0,'Van-BB',
		[
			[0,"a3\Soft_F_Orange\Van_02\Data\van_body_BB_CO.paa"],
			[1,"a3\Soft_F_Orange\Van_02\Data\van_wheel_BB_CO.paa"],
			[2,"a3\Soft_F_Orange\Van_02\Data\van_glass_BB_CA.paa"],
			[3,"a3\Soft_F_Orange\Van_02\Data\van_body_BB_CO.paa"]
		],'Van',['C_Van_02_vehicle_F','C_Van_02_service_F','C_Van_02_transport_F','C_IDAP_Van_02_vehicle_F','C_IDAP_Van_02_transport_F','B_G_Van_02_vehicle_F','B_G_Van_02_transport_F','O_G_Van_02_vehicle_F','O_G_Van_02_transport_F','I_C_Van_02_vehicle_F','I_C_Van_02_transport_F','I_G_Van_02_vehicle_F','I_G_Van_02_transport_F'],'Bohemia Interactive'
	],
	[
		0,'Van-G',
		[
			[0,"a3\Soft_F_Orange\Van_02\Data\van_body_Green_CO.paa"],
			[1,"a3\soft_f_orange\van_02\data\van_wheel_co.paa"],
			[2,"a3\soft_f_orange\van_02\data\van_glass_utility_CA.paa"],
			[3,"a3\Soft_F_Orange\Van_02\Data\van_body_Green_CO.paa"]
		],'Van',['C_Van_02_vehicle_F','C_Van_02_service_F','C_Van_02_transport_F','C_IDAP_Van_02_vehicle_F','C_IDAP_Van_02_transport_F','B_G_Van_02_vehicle_F','B_G_Van_02_transport_F','O_G_Van_02_vehicle_F','O_G_Van_02_transport_F','I_C_Van_02_vehicle_F','I_C_Van_02_transport_F','I_G_Van_02_vehicle_F','I_G_Van_02_transport_F'],'Bohemia Interactive'
	],
	[
		0,'Van-Bl',
		[
			[0,"a3\Soft_F_Orange\Van_02\Data\van_body_Black_CO.paa"],
			[1,"a3\soft_f_orange\van_02\data\van_wheel_co.paa"],
			[2,"a3\soft_f_orange\van_02\data\van_glass_utility_CA.paa"],
			[3,"a3\Soft_F_Orange\Van_02\Data\van_body_Black_CO.paa"]
		],'Van',['C_Van_02_vehicle_F','C_Van_02_service_F','C_Van_02_transport_F','C_IDAP_Van_02_vehicle_F','C_IDAP_Van_02_transport_F','B_G_Van_02_vehicle_F','B_G_Van_02_transport_F','O_G_Van_02_vehicle_F','O_G_Van_02_transport_F','I_C_Van_02_vehicle_F','I_C_Van_02_transport_F','I_G_Van_02_vehicle_F','I_G_Van_02_transport_F'],'Bohemia Interactive'
	],
	[
		0,'Van-Br',
		[
			[0,"a3\Soft_F_Orange\Van_02\Data\van_body_Syndikat_CO.paa"],
			[1,"a3\soft_f_orange\van_02\data\van_wheel_co.paa"],
			[2,"a3\soft_f_orange\van_02\data\van_glass_utility_CA.paa"],
			[3,"a3\Soft_F_Orange\Van_02\Data\van_body_Syndikat_CO.paa"]
		],'Van',['C_Van_02_vehicle_F','C_Van_02_service_F','C_Van_02_transport_F','C_IDAP_Van_02_vehicle_F','C_IDAP_Van_02_transport_F','B_G_Van_02_vehicle_F','B_G_Van_02_transport_F','O_G_Van_02_vehicle_F','O_G_Van_02_transport_F','I_C_Van_02_vehicle_F','I_C_Van_02_transport_F','I_G_Van_02_vehicle_F','I_G_Van_02_transport_F'],'Bohemia Interactive'
	],
	[
		0,'Van (Camo)',
		[
			[0,"a3\Soft_F_Orange\Van_02\Data\van_body_FIA_01_CO.paa"],
			[1,"a3\soft_f_orange\van_02\data\van_wheel_transport_co.paa"],
			[2,"a3\soft_f_orange\van_02\data\van_glass_transport_CA.paa"],
			[3,"a3\Soft_F_Orange\Van_02\Data\van_body_FIA_01_CO.paa"]
		],'Van',['C_Van_02_vehicle_F','C_Van_02_service_F','C_Van_02_transport_F','C_IDAP_Van_02_vehicle_F','C_IDAP_Van_02_transport_F','B_G_Van_02_vehicle_F','B_G_Van_02_transport_F','O_G_Van_02_vehicle_F','O_G_Van_02_transport_F','I_C_Van_02_vehicle_F','I_C_Van_02_transport_F','I_G_Van_02_vehicle_F','I_G_Van_02_transport_F'],'Bohemia Interactive'
	],
	[
		0,'Gorgon IG 1',
		[
			[0,"A3\Data_F_Tacops\data\APC_Wheeled_03_Ext_IG_01_CO.paa"],
			[1,"A3\Data_F_Tacops\data\APC_Wheeled_03_Ext2_IG_01_CO.paa"],
			[2,"A3\Data_F_Tacops\data\RCWS30_IG_01_CO.paa"],
			[3,"A3\Data_F_Tacops\data\APC_Wheeled_03_Ext_alpha_IG_01_CO.paa"]
		],'AFV-4 Gorgon (APC)',['I_APC_Wheeled_03_cannon_F','B_APC_Wheeled_03_cannon_F'],'Bohemia Interactive'
	],
	[
		0,'Gorgon IG 2',
		[
			[0,"A3\Data_F_Tacops\data\APC_Wheeled_03_Ext_IG_02_CO.paa"],
			[1,"A3\Data_F_Tacops\data\APC_Wheeled_03_Ext2_IG_02_CO.paa"],
			[2,"A3\Data_F_Tacops\data\RCWS30_IG_02_CO.paa"],
			[3,"A3\Data_F_Tacops\data\APC_Wheeled_03_Ext_alpha_IG_02_CO.paa"]
		],'AFV-4 Gorgon (APC)',['I_APC_Wheeled_03_cannon_F','B_APC_Wheeled_03_cannon_F'],'Bohemia Interactive'
	],
	[
		0,'Gorgon IG 1',
		[
			[0,"A3\Data_F_Tacops\data\APC_Wheeled_03_Ext_IG_03_CO.paa"],
			[1,"A3\Data_F_Tacops\data\APC_Wheeled_03_Ext2_IG_03_CO.paa"],
			[2,"A3\Data_F_Tacops\data\RCWS30_IG_03_CO.paa"],
			[3,"A3\Data_F_Tacops\data\APC_Wheeled_03_Ext_alpha_IG_03_CO.paa"]
		],'AFV-4 Gorgon (APC)',['I_APC_Wheeled_03_cannon_F','B_APC_Wheeled_03_cannon_F'],'Bohemia Interactive'
	]
]

// Deep Storage
/*/
[
	[0,'Reset',[[0,'']],'',[''],''],
	[0,'USMC X',[[0,'media\images\vskins\v44\vtol_01_ext01_marines_co.paa'],[1,'media\images\vskins\v44\vtol_01_ext02_marines_co.paa'],[2,'media\images\vskins\v44\vtol_01_ext03_marines_co.paa'],[3,'media\images\vskins\v44\vtol_01_ext04_marines_co.paa']],'V-44 X Blackfish (VTOL)',["B_T_VTOL_01_armed_blue_F","B_T_VTOL_01_armed_F","B_T_VTOL_01_armed_olive_F","B_T_VTOL_01_infantry_blue_F","B_T_VTOL_01_infantry_F","B_T_VTOL_01_infantry_olive_F","B_T_VTOL_01_vehicle_blue_F","B_T_VTOL_01_vehicle_F","B_T_VTOL_01_vehicle_olive_F"],'Redphoenix (gamingwithredphoenix@gmail.com)'],
	[0,'король',[[0,'media\images\vskins\to199\russia_fighter02_ext01.paa'],[1,'media\images\vskins\to199\russia_fighter02_ext02.paa']],'To-199 Neophron (Plane)',['O_Plane_CAS_02_F','O_Plane_CAS_02_dynamicLoadout_F'],'Redphoenix (gamingwithredphoenix@gmail.com)'],
	[0,'US Navy 143',[[0,'media\images\vskins\a143\Buzzard1.paa'],[1,'media\images\vskins\a143\Buzzard0.paa']],'A-143 Buzzard (Plane)',['I_Plane_Fighter_03_AA_F','I_Plane_Fighter_03_CAS_F','I_Plane_Fighter_03_Cluster_F','I_Plane_Fighter_03_dynamicLoadout_F'],'Aleksy (cportsmouth98@gmail.com)'],
	[0,'Arctic',[[0,'media\images\vskins\a143\Buzzard_1.paa'],[1,'media\images\vskins\a143\Buzzard_2.paa']],'A-143 Buzzard (Plane)',['I_Plane_Fighter_03_AA_F','I_Plane_Fighter_03_CAS_F','I_Plane_Fighter_03_Cluster_F','I_Plane_Fighter_03_dynamicLoadout_F'],'Dasweetdude (dasweetdude@gmail.com)'],
	[0,'Grey',[[0,"a3\Air_F_Gamma\Plane_Fighter_03\Data\Plane_Fighter_03_body_1_greyhex_CO.paa"],[1,"a3\Air_F_Gamma\Plane_Fighter_03\Data\Plane_Fighter_03_body_2_greyhex_CO.paa"]],'A-143 Buzzard (Plane)',['I_Plane_Fighter_03_AA_F','I_Plane_Fighter_03_CAS_F','I_Plane_Fighter_03_Cluster_F','I_Plane_Fighter_03_dynamicLoadout_F'],'Bohemia Interactive'],
	[0,'J-Hawk',[[0,'media\images\vskins\ch49\mohawk_jungle_01_co.paa'],[1,'media\images\vskins\ch49\mohawk_jungle_02_co.paa'],[2,'media\images\vskins\ch49\mohawk_jungle_03_co.paa']],'CH-49 Mohawk (Heli)',['I_Heli_Transport_02_F'],'Redphoenix (gamingwithredphoenix@gmail.com)'],
	[0,'Merlin',[[0,'media\images\vskins\ch49\mohawk_usmc_01_co.paa'],[1,'media\images\vskins\ch49\mohawk_usmc_02_co.paa'],[2,'media\images\vskins\ch49\mohawk_usmc_03_co.paa']],'CH-49 Mohawk (Heli)',['I_Heli_Transport_02_F'],'Redphoenix (gamingwithredphoenix@gmail.com)'],
	[0,'Honey',[[0,'media\images\vskins\huron\HoneybeeHuronFront.paa'],[1,'media\images\vskins\huron\HoneybeeHuronBack.paa']],'CH-67 Huron (Heli)',['B_Heli_Transport_03_black_F','B_Heli_Transport_03_F','B_Heli_Transport_03_unarmed_F','B_Heli_Transport_03_unarmed_green_F'],'Johnny Honeybee (N/A)'],
	[0,'AMV-8',[[0,'media\images\vskins\amv7\jungleamv_01_co.paa'],[1,'media\images\vskins\amv7\jungleamv_02_co.paa'],[2,'media\images\vskins\amv7\jungleamv_03_co.paa']],'AMV-7 Marshall (APC)',['B_APC_Wheeled_01_cannon_F','B_T_APC_Wheeled_01_cannon_F'],'Redphoenix (gamingwithredphoenix@gmail.com)'],		
	[0,'Rocky Road',[[0,'media\images\vskins\amv7\amvrus00.paa'],[1,'media\images\vskins\amv7\amvrus01.paa'],[2,'media\images\vskins\amv7\amvrus02.paa']],'AMV-7 Marshall (APC)',['B_APC_Wheeled_01_cannon_F','B_T_APC_Wheeled_01_cannon_F'],'Fitz (fitz@acf.sx)'],
	[0,'Arctic',[[0,'media\images\vskins\mse3\arctic\apc_wheeled_02_ext_01_blufor_co.paa'],[1,'media\images\vskins\mse3\arctic\apc_wheeled_02_ext_02_blufor_co.paa'],[2,'media\images\vskins\mse3\arctic\apc_wheeled_02_ext_02_blufor_co.paa']],'MSE-3 Marid (APC)',['O_T_APC_Wheeled_02_rcws_ghex_F','O_T_APC_Wheeled_02_rcws_v2_ghex_F','O_APC_Wheeled_02_rcws_F','O_APC_Wheeled_02_rcws_v2_F'],'Archimedes'],
	[0,'Lightning I',[[0,'media\images\vskins\m2a4\bluelightning\mbt_01_body_co.paa'],[1,'media\images\vskins\m2a4\bluelightning\mbt_addons_co.paa'],[2,'media\images\vskins\m2a4\bluelightning\mbt_addons_co.paa']],'M2A4 Slammer (Tank)',['B_MBT_01_TUSK_F','B_MBT_01_cannon_F','B_T_MBT_01_TUSK_F','B_T_MBT_01_cannon_F'],'Archimedes'],		
	[0,'Molten',[[0,'media\images\vskins\mbt52\mb1.paa'],[1,'media\images\vskins\mbt52\mbt2.paa'],[2,'media\images\vskins\mbt52\mbt3.paa']],'MBT-52 Kuma (Tank)',['I_MBT_03_cannon_F'],'Dasweetdude (dasweetdude@gmail.com)'],		
	[0,'Medevac',[[0,'media\images\vskins\uh80\medevac\medevacghosthawk.paa'],[1,'media\images\vskins\uh80\medevac\medevacghosthawk1.paa']],'UH-80 Ghosthawk',["B_Heli_Transport_01_camo_F","B_Heli_Transport_01_F","B_CTRG_Heli_Transport_01_sand_F","B_CTRG_Heli_Transport_01_tropic_F"],'Bohemia Interactive'],
	[0,'Digital I',[[0,'media\images\vskins\uh80\digital\heli_transport_01_ext01_blufor_co.paa'],[1,'media\images\vskins\uh80\digital\heli_transport_01_ext02_blufor_co.paa']],'UH-80 Ghosthawk',['B_Heli_Transport_01_F','B_Heli_Transport_01_camo_F','B_CTRG_Heli_Transport_01_sand_F','B_CTRG_Heli_Transport_01_tropic_F'],'Archimedes'],
	[0,'AU-67',[[0,'media\images\vskins\huron\huron_0_v1.jpg'],[1,'media\images\vskins\huron\huron_1_v1.jpg']],'CH-67 Huron (Heli)',['B_Heli_Transport_03_black_F','B_Heli_Transport_03_F','B_Heli_Transport_03_unarmed_F','B_Heli_Transport_03_unarmed_green_F'],'N/A'],
	[0,'AU-164',[[0,'media\images\vskins\a164\wipeout_0_v1.jpg'],[1,'media\images\vskins\a164\wipeout_1_v1.jpg']],'A-164 Wipeout (Plane)',['B_Plane_CAS_01_F','B_Plane_CAS_01_dynamicLoadout_F'],'N/A'],
	[0,'USMC',[[0,'media\images\vskins\huron\huron_ext01_usmc_CO.paa'],[1,'media\images\vskins\huron\huron_ext02_usmc_CO.paa']],'CH-67 Huron (Heli)',['B_Heli_Transport_03_black_F','B_Heli_Transport_03_F','B_Heli_Transport_03_unarmed_F','B_Heli_Transport_03_unarmed_green_F'],'Redphoenix (gamingwithredphoenix@gmail.com)'],
	[0,'Cheeta',[[0,'media\images\vskins\strider\cheeta.paa'],[1,'media\images\vskins\strider\cheeta.paa']],'Strider',["I_MRAP_03_F","I_MRAP_03_hmg_F","I_MRAP_03_gmg_F"],'Archimedes'],		
	[0,'Raptor',[[0,'media\images\vskins\4wd\jpjeep.paa']],'4WD',['C_Offroad_02_unarmed_black_F','C_Offroad_02_unarmed_blue_F','C_Offroad_02_unarmed_F','C_Offroad_02_unarmed_green_F','C_Offroad_02_unarmed_orange_F','C_Offroad_02_unarmed_red_F','C_Offroad_02_unarmed_white_F','I_C_Offroad_02_unarmed_brown_F','I_C_Offroad_02_unarmed_F','I_C_Offroad_02_unarmed_olive_F'],'Archimedes'],		
	[0,'USCG',[[0,'media\images\vskins\po30\orcau.paa']],'PO-30 Orca (Heli)',['o_heli_light_02_dynamicloadout_f','O_Heli_Light_02_F','O_Heli_Light_02_v2_F','O_Heli_Light_02_unarmed_F'],'Archimedes'],
	[0,'Dazzle',[[0,"a3\soft_f_exp\lsv_01\data\nato_lsv_01_dazzle_co.paa"],[1,"a3\soft_f_exp\lsv_01\data\nato_lsv_02_olive_co.paa"],[2,"a3\soft_f_exp\lsv_01\data\nato_lsv_03_olive_co.paa"],[3,"a3\soft_f_exp\lsv_01\data\nato_lsv_adds_olive_co.paa"]],'Prowler (LSV)',["B_LSV_01_armed_black_F","B_LSV_01_armed_F","B_LSV_01_armed_olive_F","B_LSV_01_armed_sand_F","B_LSV_01_unarmed_black_F","B_LSV_01_unarmed_F","B_LSV_01_unarmed_olive_F","B_LSV_01_unarmed_sand_F","B_T_LSV_01_armed_black_F","B_T_LSV_01_armed_F","B_T_LSV_01_armed_olive_F","B_T_LSV_01_armed_sand_F","B_T_LSV_01_unarmed_black_F","B_T_LSV_01_unarmed_F","B_T_LSV_01_unarmed_olive_F","B_T_LSV_01_unarmed_sand_F"],'Bohemia Interactive'],
	[0,'Wave 2',[[0,'A3\air_f\Heli_Light_02\Data\heli_light_02_ext_civilian_co.paa']],'PO-30 Orca (Heli)',['o_heli_light_02_dynamicloadout_f','O_Heli_Light_02_F','O_Heli_Light_02_v2_F','O_Heli_Light_02_unarmed_F'],'Bohemia Interactive'],
	[0,'Indep',[[0,'A3\air_f\Heli_Light_02\Data\heli_light_02_ext_indp_co.paa']],'PO-30 Orca (Heli)',['o_heli_light_02_dynamicloadout_f','O_Heli_Light_02_F','O_Heli_Light_02_v2_F','O_Heli_Light_02_unarmed_F'],'Bohemia Interactive'],	
	[0,'Dahoman',[[0,'A3\air_f_beta\Heli_Transport_02\Data\Skins\heli_transport_02_1_dahoman_co.paa'],[1,'A3\air_f_beta\Heli_Transport_02\Data\Skins\heli_transport_02_2_dahoman_co.paa'],[2,'A3\air_f_beta\Heli_Transport_02\Data\Skins\heli_transport_02_3_dahoman_co.paa']],'CH-49 Mohawk (Heli)',['I_Heli_Transport_02_F'],'Bohemia Interactive'],
	[0,'Ion',[[0,'A3\air_f_beta\Heli_Transport_02\Data\Skins\heli_transport_02_1_ion_co.paa'],[1,'A3\air_f_beta\Heli_Transport_02\Data\Skins\heli_transport_02_2_ion_co.paa'],[2,'A3\air_f_beta\Heli_Transport_02\Data\Skins\heli_transport_02_3_ion_co.paa']],'CH-49 Mohawk (Heli)',['I_Heli_Transport_02_F'],'Bohemia Interactive'],
	[0,'Blackfoot (Green)',[[0,'A3\Air_F\Heli_Light_02\Data\heli_light_02_common_co.paa']],'AH-99 Blackfoot',['B_Heli_Attack_01_F','B_Heli_Attack_01_dynamicLoadout_F'],'Bohemia Interactive'],
	[0,'Gendarmerie',[[0,'a3\soft_f_exp\offroad_01\data\offroad_01_ext_gen_co.paa'],[1,'a3\soft_f_exp\offroad_01\data\offroad_01_ext_gen_co.paa']],'Offroad (Police)',['C_Offroad_01_blue_F','C_Offroad_01_bluecustom_F','C_Offroad_01_darkred_F','C_Offroad_01_F','C_Offroad_01_red_F','C_Offroad_01_repair_F','C_Offroad_01_sand_F','C_Offroad_01_white_F','C_Offroad_stripped_F','B_G_Offroad_01_armed_F','B_G_Offroad_01_F','B_G_Offroad_01_repair_F','I_G_Offroad_01_armed_F','I_G_Offroad_01_F','I_G_Offroad_01_repair_F','O_G_Offroad_01_armed_F','O_G_Offroad_01_F','O_G_Offroad_01_repair_F'],'Bohemia Interactive'],
	[0,'Bee',[[0,'media\images\vskins\mh9\bee.paa']],'MH-9 Hummingbird (Heli)',['B_Heli_Light_01_F','B_Heli_Light_01_armed_F','C_Heli_Light_01_civil_F','B_Heli_Light_01_stripped_F','B_Heli_Light_01_dynamicLoadout_F'],'Dasweetdude (dasweetdude@gmail.com)'],
	[0,'Digital',[[0,'A3\air_f\heli_light_01\data\skins\heli_light_01_ext_digital_co.paa']],'MH-9 Hummingbird (Heli)',['B_Heli_Light_01_F','B_Heli_Light_01_armed_F','C_Heli_Light_01_civil_F','B_Heli_Light_01_stripped_F','B_Heli_Light_01_dynamicLoadout_F'],'Bohemia Interactive'],
	[0,'Vrana',[[0,'A3\air_f\heli_light_01\data\skins\heli_light_01_ext_vrana_co.paa']],'MH-9 Hummingbird (Heli)',['B_Heli_Light_01_F','B_Heli_Light_01_armed_F','C_Heli_Light_01_civil_F','B_Heli_Light_01_stripped_F','B_Heli_Light_01_dynamicLoadout_F'],'Bohemia Interactive'],
	[0,'Wasp',[[0,'A3\air_f\heli_light_01\data\skins\heli_light_01_ext_wasp_co.paa']],'MH-9 Hummingbird (Heli)',['B_Heli_Light_01_F','B_Heli_Light_01_armed_F','C_Heli_Light_01_civil_F','B_Heli_Light_01_stripped_F','B_Heli_Light_01_dynamicLoadout_F'],'Bohemia Interactive'],
	[0,'Indep',[[0,'A3\Air_F\Heli_Light_01\Data\heli_light_01_ext_indp_co.paa']],'MH-9 Hummingbird (Heli)',['B_Heli_Light_01_F','B_Heli_Light_01_armed_F','C_Heli_Light_01_civil_F','B_Heli_Light_01_stripped_F','B_Heli_Light_01_dynamicLoadout_F'],'Bohemia Interactive'],
	[0,'Ion',[[0,'A3\air_f\Heli_Light_01\Data\heli_light_01_ext_ion_co.paa']],'MH-9 Hummingbird (Heli)',['B_Heli_Light_01_F','B_Heli_Light_01_armed_F','C_Heli_Light_01_civil_F','B_Heli_Light_01_stripped_F','B_Heli_Light_01_dynamicLoadout_F'],'Bohemia Interactive'],
	[
		0,'Gryphon',
		[
			[0,"a3\air_f_jets\plane_fighter_04\data\Fighter_04_fuselage_01_gray_co.paa"],
			[1,"a3\air_f_jets\plane_fighter_04\data\Fighter_04_fuselage_02_gray_co.paa"],
			[2,"a3\air_f_jets\plane_fighter_04\data\fighter_04_misc_01_co.paa"],
			[3,"a3\air_f_jets\plane_fighter_04\data\Numbers\Fighter_04_number_04_ca.paa"],
			[4,"a3\air_f_jets\plane_fighter_04\data\Numbers\Fighter_04_number_04_ca.paa"],
			[5,"a3\air_f_jets\plane_fighter_04\data\Numbers\Fighter_04_number_08_ca.paa"]
		],'A-149 Gryphon (Plane)',['I_Plane_Fighter_04_F'],'Bohemia Interactive'
	],
	[
		0,'Shikra',
		[
			[0,"a3\air_f_jets\plane_fighter_02\data\Fighter_02_fuselage_01_Grey_co.paa"],
			[1,"a3\air_f_jets\plane_fighter_02\data\Fighter_02_fuselage_02_Grey_co.paa"],
			[2,"a3\air_f_jets\plane_fighter_02\data\Fighter_02_fuselage_01_Grey_co.paa"],
			[3,"a3\air_f_jets\plane_fighter_02\data\Numbers\Fighter_02_number_02_co.paa"],
			[4,"a3\air_f_jets\plane_fighter_02\data\Numbers\Fighter_02_number_00_co.paa"],
			[5,"a3\air_f_jets\plane_fighter_02\data\Numbers\Fighter_02_number_01_co.paa"]
		],'To-201 Shikra (Plane)',['O_Plane_Fighter_02_F','O_Plane_Fighter_02_Stealth_F'],'Bohemia Interactive'
	],	
	[
		0,'F/A-181',
		[
			[0,"a3\air_f_jets\plane_fighter_01\data\fighter_01_fuselage_01_Camo_co.paa"],
			[1,"a3\air_f_jets\plane_fighter_01\data\fighter_01_fuselage_02_Camo_co.paa"],
			[2,"a3\air_f_jets\plane_fighter_01\data\fighter_01_glass_01_ca.paa"],
			[3,"a3\air_f_jets\plane_fighter_01\data\fighter_01_cockpit_01_co.paa"],
			[4,"a3\air_f_jets\plane_fighter_01\data\fighter_01_cockpit_02_co.paa"],
			[5,"a3\air_f_jets\plane_fighter_01\data\fighter_01_cockpit_05_co.paa"]
		],'F/A-181 Black Wasp II (Plane)',['B_Plane_Fighter_01_F','B_Plane_Fighter_01_Stealth_F'],'Bohemia Interactive'
	],
	[
		0,'F/A-182',
		[
			[0,"media\images\vskins\fa181\digitalwasp3.paa"],
			[1,"media\images\vskins\fa181\digitalwing3.paa"],
			[2,"a3\air_f_jets\plane_fighter_01\data\fighter_01_glass_01_ca.paa"],
			[3,"a3\air_f_jets\plane_fighter_01\data\fighter_01_cockpit_01_co.paa"],
			[4,"a3\air_f_jets\plane_fighter_01\data\fighter_01_cockpit_02_co.paa"],
			[5,"a3\air_f_jets\plane_fighter_01\data\fighter_01_cockpit_05_co.paa"]
		],'F/A-181 Black Wasp II (Plane)',['B_Plane_Fighter_01_F','B_Plane_Fighter_01_Stealth_F'],'Archimedes'
	],
	[
		0,'Van-BB',
		[
			[0,"a3\Soft_F_Orange\Van_02\Data\van_body_BB_CO.paa"],
			[1,"a3\Soft_F_Orange\Van_02\Data\van_wheel_BB_CO.paa"],
			[2,"a3\Soft_F_Orange\Van_02\Data\van_glass_BB_CA.paa"],
			[3,"a3\Soft_F_Orange\Van_02\Data\van_body_BB_CO.paa"]
		],'Van',['C_Van_02_vehicle_F','C_Van_02_service_F','C_Van_02_transport_F','C_IDAP_Van_02_vehicle_F','C_IDAP_Van_02_transport_F','B_G_Van_02_vehicle_F','B_G_Van_02_transport_F','O_G_Van_02_vehicle_F','O_G_Van_02_transport_F','I_C_Van_02_vehicle_F','I_C_Van_02_transport_F','I_G_Van_02_vehicle_F','I_G_Van_02_transport_F'],'Bohemia Interactive'
	],
	[
		0,'Van-G',
		[
			[0,"a3\Soft_F_Orange\Van_02\Data\van_body_Green_CO.paa"],
			[1,"a3\soft_f_orange\van_02\data\van_wheel_co.paa"],
			[2,"a3\soft_f_orange\van_02\data\van_glass_utility_CA.paa"],
			[3,"a3\Soft_F_Orange\Van_02\Data\van_body_Green_CO.paa"]
		],'Van',['C_Van_02_vehicle_F','C_Van_02_service_F','C_Van_02_transport_F','C_IDAP_Van_02_vehicle_F','C_IDAP_Van_02_transport_F','B_G_Van_02_vehicle_F','B_G_Van_02_transport_F','O_G_Van_02_vehicle_F','O_G_Van_02_transport_F','I_C_Van_02_vehicle_F','I_C_Van_02_transport_F','I_G_Van_02_vehicle_F','I_G_Van_02_transport_F'],'Bohemia Interactive'
	],
	[
		0,'Van-Bl',
		[
			[0,"a3\Soft_F_Orange\Van_02\Data\van_body_Black_CO.paa"],
			[1,"a3\soft_f_orange\van_02\data\van_wheel_co.paa"],
			[2,"a3\soft_f_orange\van_02\data\van_glass_utility_CA.paa"],
			[3,"a3\Soft_F_Orange\Van_02\Data\van_body_Black_CO.paa"]
		],'Van',['C_Van_02_vehicle_F','C_Van_02_service_F','C_Van_02_transport_F','C_IDAP_Van_02_vehicle_F','C_IDAP_Van_02_transport_F','B_G_Van_02_vehicle_F','B_G_Van_02_transport_F','O_G_Van_02_vehicle_F','O_G_Van_02_transport_F','I_C_Van_02_vehicle_F','I_C_Van_02_transport_F','I_G_Van_02_vehicle_F','I_G_Van_02_transport_F'],'Bohemia Interactive'
	],
	[
		0,'Van-Br',
		[
			[0,"a3\Soft_F_Orange\Van_02\Data\van_body_Syndikat_CO.paa"],
			[1,"a3\soft_f_orange\van_02\data\van_wheel_co.paa"],
			[2,"a3\soft_f_orange\van_02\data\van_glass_utility_CA.paa"],
			[3,"a3\Soft_F_Orange\Van_02\Data\van_body_Syndikat_CO.paa"]
		],'Van',['C_Van_02_vehicle_F','C_Van_02_service_F','C_Van_02_transport_F','C_IDAP_Van_02_vehicle_F','C_IDAP_Van_02_transport_F','B_G_Van_02_vehicle_F','B_G_Van_02_transport_F','O_G_Van_02_vehicle_F','O_G_Van_02_transport_F','I_C_Van_02_vehicle_F','I_C_Van_02_transport_F','I_G_Van_02_vehicle_F','I_G_Van_02_transport_F'],'Bohemia Interactive'
	],
	[
		0,'Van (Camo)',
		[
			[0,"a3\Soft_F_Orange\Van_02\Data\van_body_FIA_01_CO.paa"],
			[1,"a3\soft_f_orange\van_02\data\van_wheel_transport_co.paa"],
			[2,"a3\soft_f_orange\van_02\data\van_glass_transport_CA.paa"],
			[3,"a3\Soft_F_Orange\Van_02\Data\van_body_FIA_01_CO.paa"]
		],'Van',['C_Van_02_vehicle_F','C_Van_02_service_F','C_Van_02_transport_F','C_IDAP_Van_02_vehicle_F','C_IDAP_Van_02_transport_F','B_G_Van_02_vehicle_F','B_G_Van_02_transport_F','O_G_Van_02_vehicle_F','O_G_Van_02_transport_F','I_C_Van_02_vehicle_F','I_C_Van_02_transport_F','I_G_Van_02_vehicle_F','I_G_Van_02_transport_F'],'Bohemia Interactive'
	],
	[
		0,'Gorgon IG 1',
		[
			[0,"A3\Data_F_Tacops\data\APC_Wheeled_03_Ext_IG_01_CO.paa"],
			[1,"A3\Data_F_Tacops\data\APC_Wheeled_03_Ext2_IG_01_CO.paa"],
			[2,"A3\Data_F_Tacops\data\RCWS30_IG_01_CO.paa"],
			[3,"A3\Data_F_Tacops\data\APC_Wheeled_03_Ext_alpha_IG_01_CO.paa"]
		],'AFV-4 Gorgon (APC)',['I_APC_Wheeled_03_cannon_F','B_APC_Wheeled_03_cannon_F'],'Bohemia Interactive'
	],
	[
		0,'Gorgon IG 2',
		[
			[0,"A3\Data_F_Tacops\data\APC_Wheeled_03_Ext_IG_02_CO.paa"],
			[1,"A3\Data_F_Tacops\data\APC_Wheeled_03_Ext2_IG_02_CO.paa"],
			[2,"A3\Data_F_Tacops\data\RCWS30_IG_02_CO.paa"],
			[3,"A3\Data_F_Tacops\data\APC_Wheeled_03_Ext_alpha_IG_02_CO.paa"]
		],'AFV-4 Gorgon (APC)',['I_APC_Wheeled_03_cannon_F','B_APC_Wheeled_03_cannon_F'],'Bohemia Interactive'
	],
	[
		0,'Gorgon IG 1',
		[
			[0,"A3\Data_F_Tacops\data\APC_Wheeled_03_Ext_IG_03_CO.paa"],
			[1,"A3\Data_F_Tacops\data\APC_Wheeled_03_Ext2_IG_03_CO.paa"],
			[2,"A3\Data_F_Tacops\data\RCWS30_IG_03_CO.paa"],
			[3,"A3\Data_F_Tacops\data\APC_Wheeled_03_Ext_alpha_IG_03_CO.paa"]
		],'AFV-4 Gorgon (APC)',['I_APC_Wheeled_03_cannon_F','B_APC_Wheeled_03_cannon_F'],'Bohemia Interactive'
	]
]
/*/