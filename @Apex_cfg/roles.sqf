/*/
File: roles.sqf
Author:

	Quiksilver
	
Last Modified:

	9/10/2023 A3 2.14 by Quiksilver
	
Description:

	Roles
	
Notes:

	To understand this file, please see documentation in mission file: 
	
		"documentation\role selection system.txt"
_______________________________________________________/*/

_tropical = worldName in ['Tanoa'];
QS_roles_data = [
	[
		[
			'o_autorifleman',
			EAST,
			2,
			2,
			-1,
			0,	
			0,
			0,
			{((missionNamespace getVariable ['QS_RSS_client_canSideSwitch',FALSE]) && (((missionNamespace getVariable ['QS_missionConfig_playableOPFOR',0]) isEqualTo 2) || {(((missionNamespace getVariable ['QS_missionConfig_playableOPFOR',0]) isEqualTo 1) && ((getPlayerUID player) in (['OPFOR'] call (missionNamespace getVariable 'QS_fnc_whitelist'))))}))},
			{((player getVariable ['QS_unit_side',WEST]) isEqualTo EAST) || ((missionNamespace getVariable ['QS_RSS_client_canSideSwitch',FALSE]) && (((missionNamespace getVariable ['QS_missionConfig_playableOPFOR',0]) isEqualTo 2) || {(((missionNamespace getVariable ['QS_missionConfig_playableOPFOR',0]) isEqualTo 1) && ((getPlayerUID player) in (['OPFOR'] call (missionNamespace getVariable 'QS_fnc_whitelist'))))}))},
			{}
		]
	],
	[
		[
			'rifleman',
			WEST,
			(playableSlotsNumber WEST),
			(playableSlotsNumber WEST),
			-1,
			0,	
			0,
			0,
			{TRUE},
			{(((player getVariable ['QS_unit_side',WEST]) isEqualTo WEST) || (missionNamespace getVariable ['QS_RSS_client_canSideSwitch',FALSE]))},
			{}
		],
		[
			'autorifleman',
			WEST,
			3,
			10,
			8,
			0,	
			0,
			0,
			{TRUE},
			{(((player getVariable ['QS_unit_side',WEST]) isEqualTo WEST) || (missionNamespace getVariable ['QS_RSS_client_canSideSwitch',FALSE]))},
			{}
		],
		[
			'machine_gunner',
			WEST,
			1,
			2,
			10,
			0,	
			0,
			0,
			{TRUE},
			{(((player getVariable ['QS_unit_side',WEST]) isEqualTo WEST) || (missionNamespace getVariable ['QS_RSS_client_canSideSwitch',FALSE]))},
			{}
		],
		[
			'rifleman_lat',
			WEST,
			2,
			8,
			8,
			0,	
			0,
			0,
			{TRUE},
			{(((player getVariable ['QS_unit_side',WEST]) isEqualTo WEST) || (missionNamespace getVariable ['QS_RSS_client_canSideSwitch',FALSE]))},
			{}
		],
		[
			'rifleman_hat',
			WEST,
			2,
			4,
			10,
			0,	
			0,
			0,
			{TRUE},
			{(((player getVariable ['QS_unit_side',WEST]) isEqualTo WEST) || (missionNamespace getVariable ['QS_RSS_client_canSideSwitch',FALSE]))},
			{}
		],
		[
			'medic',
			WEST,
			2,
			10,
			8,
			0,
			0,
			0,
			{TRUE},
			{(((player getVariable ['QS_unit_side',WEST]) isEqualTo WEST) || (missionNamespace getVariable ['QS_RSS_client_canSideSwitch',FALSE]))},
			{}
		],
		[
			'engineer',
			WEST,
			2,
			10,
			8,
			0,
			0,
			0,
			{TRUE},
			{(((player getVariable ['QS_unit_side',WEST]) isEqualTo WEST) || (missionNamespace getVariable ['QS_RSS_client_canSideSwitch',FALSE]))},
			{}
		],
		/*/ ----- Crewman has no special abilities in official version
		[
			'crewman',
			WEST,
			3,
			6,
			12,
			0,
			0,
			0,
			{FALSE},
			{(((player getVariable ['QS_unit_side',WEST]) isEqualTo WEST) || (missionNamespace getVariable ['QS_RSS_client_canSideSwitch',FALSE]))},
			{}
		],
		/*/
		[
			'mortar_gunner',
			WEST,
			1,
			1,
			-1,
			0,
			0,
			0,
			{TRUE},
			{(((player getVariable ['QS_unit_side',WEST]) isEqualTo WEST) || (missionNamespace getVariable ['QS_RSS_client_canSideSwitch',FALSE]))},
			{}
		],
		[
			'sniper',
			WEST,
			1,
			2,
			10,
			0,
			0,
			0,
			{TRUE},
			{(((player getVariable ['QS_unit_side',WEST]) isEqualTo WEST) || (missionNamespace getVariable ['QS_RSS_client_canSideSwitch',FALSE]))},
			{}
		],
		[
			'jtac',
			WEST,
			1,
			1,
			-1,
			0,
			0,
			0,
			{TRUE},
			{(((player getVariable ['QS_unit_side',WEST]) isEqualTo WEST) || (missionNamespace getVariable ['QS_RSS_client_canSideSwitch',FALSE]))},
			{}
		],
		[
			'uav',
			WEST,
			1,		// Do not change this, only 1 UAV Operator slot configured
			1,		// Do not change this, only 1 UAV Operator slot configured
			-1,		// Do not change this, only 1 UAV Operator slot configured
			0,		// Do not change this, only 1 UAV Operator slot configured
			0,
			0,
			{TRUE},
			{(((player getVariable ['QS_unit_side',WEST]) isEqualTo WEST) || (missionNamespace getVariable ['QS_RSS_client_canSideSwitch',FALSE]))},
			{}
		],
		[
			'pilot_heli',
			WEST,
			2,
			5,
			8,
			0,
			0,
			0,
			{TRUE},
			{(((player getVariable ['QS_unit_side',WEST]) isEqualTo WEST) || (missionNamespace getVariable ['QS_RSS_client_canSideSwitch',FALSE]))},
			{}
		],
		[
			'pilot_plane',
			WEST,
			1,		// Do not change this, only 1 CAS pilot slot configured
			1,		// Do not change this, only 1 CAS pilot slot configured
			-1,		// Do not change this, only 1 CAS pilot slot configured
			0,		// Do not change this, only 1 CAS pilot slot configured
			0,
			0,
			{TRUE},
			{((((player getVariable ['QS_unit_side',WEST]) isEqualTo WEST) || (missionNamespace getVariable ['QS_RSS_client_canSideSwitch',FALSE])) && ((missionNamespace getVariable ['QS_missionConfig_CAS',2]) isNotEqualTo 0))},
			{}
		],
		//------------------------------------------------ Whitelisted roles
		[
			'medic_WL',
			WEST,
			1,
			1,
			-1,
			0,
			0,
			0,
			{TRUE},
			{(((player getVariable ['QS_unit_side',WEST]) isEqualTo WEST) || (missionNamespace getVariable ['QS_RSS_client_canSideSwitch',FALSE]))},
			{}
		],
		[
			'machine_gunner_WL',
			WEST,
			1,
			1,
			-1,
			0,	
			0,
			0,
			{TRUE},
			{(((player getVariable ['QS_unit_side',WEST]) isEqualTo WEST) || (missionNamespace getVariable ['QS_RSS_client_canSideSwitch',FALSE]))},
			{}
		],
		[
			'sniper_WL',
			WEST,
			1,
			1,
			-1,
			0,
			0,
			0,
			{TRUE},
			{(((player getVariable ['QS_unit_side',WEST]) isEqualTo WEST) || (missionNamespace getVariable ['QS_RSS_client_canSideSwitch',FALSE]))},
			{}
		],
		[
			'pilot_heli_WL',
			WEST,
			2,			// minimum 1 slot
			2,			// maximum 2 slots
			-1,			// per N players an extra role will open, up to the maximum
			0,			// 2 whitelisted slots (should == maximum slots)
			0,
			0,
			{TRUE},
			{(((player getVariable ['QS_unit_side',WEST]) isEqualTo WEST) || (missionNamespace getVariable ['QS_RSS_client_canSideSwitch',FALSE]))},
			{}
		],
		[
			'commander',
			WEST,
			1,		// Do not change this, only 1 Commander slot configured
			1,		// Do not change this, only 1 Commander slot configured
			-1,		// Do not change this, only 1 Commander slot configured
			0,		// Do not change this, only 1 Commander slot configured
			0,
			0,
			{((missionNamespace getVariable ['QS_missionConfig_Commander',0]) isNotEqualTo 0)},
			{(((player getVariable ['QS_unit_side',WEST]) isEqualTo WEST) || (missionNamespace getVariable ['QS_RSS_client_canSideSwitch',FALSE]))},
			{}
		]
	],
	[],
	[]
];
QS_roles_UI_info = [
	['rifleman',localize 'STR_QS_Role_013','a3\ui_f\data\map\vehicleicons\iconMan_ca.paa','a3\ui_f\data\map\vehicleicons\iconMan_ca.paa'],
	['autorifleman',localize 'STR_QS_Role_014','a3\ui_f\data\map\vehicleicons\iconManMG_ca.paa','a3\ui_f\data\map\vehicleicons\iconManMG_ca.paa'],
	['machine_gunner',localize 'STR_QS_Role_015','a3\ui_f\data\map\vehicleicons\iconManMG_ca.paa','a3\ui_f\data\map\vehicleicons\iconManMG_ca.paa'],
	['rifleman_lat',localize 'STR_QS_Role_016','a3\ui_f\data\map\vehicleicons\iconManAT_ca.paa','a3\ui_f\data\map\vehicleicons\iconManAT_ca.paa'],
	['rifleman_hat',localize 'STR_QS_Role_017','a3\ui_f\data\map\vehicleicons\iconManAT_ca.paa','a3\ui_f\data\map\vehicleicons\iconManAT_ca.paa'],
	['engineer',localize 'STR_QS_Role_018','a3\ui_f\data\map\vehicleicons\iconManEngineer_ca.paa','a3\ui_f\data\map\vehicleicons\iconManEngineer_ca.paa'],
	['medic',localize 'STR_QS_Role_019','a3\ui_f\data\map\vehicleicons\iconManMedic_ca.paa','a3\ui_f\data\map\vehicleicons\iconManMedic_ca.paa'],
	['sniper',localize 'STR_QS_Role_020','a3\ui_f\data\map\vehicleicons\iconManRecon_ca.paa','a3\ui_f\data\map\vehicleicons\iconManRecon_ca.paa'],
	['crewman',localize 'STR_QS_Role_021','a3\ui_f\data\map\vehicleicons\iconMan_ca.paa','a3\ui_f\data\map\vehicleicons\iconMan_ca.paa'],
	['jtac',localize 'STR_QS_Role_022','a3\ui_f\data\map\vehicleicons\iconManRecon_ca.paa','a3\ui_f\data\map\vehicleicons\iconManRecon_ca.paa'],
	['mortar_gunner',localize 'STR_QS_Role_023','A3\Static_f\Mortar_01\data\UI\map_Mortar_01_CA.paa','a3\ui_f\data\map\vehicleicons\iconMan_ca.paa'],
	['uav',localize 'STR_QS_Role_024','A3\Drones_F\Air_F_Gamma\UAV_02\Data\UI\Map_UAV_02_CA.paa','a3\ui_f\data\map\vehicleicons\iconMan_ca.paa'],
	['pilot_heli',localize 'STR_QS_Role_025','A3\Air_F_Beta\Heli_Transport_01\Data\UI\Map_Heli_Transport_01_base_CA.paa','a3\ui_f\data\map\vehicleicons\iconMan_ca.paa'],
	['pilot_plane',localize 'STR_QS_Role_026','A3\Air_F_Jets\Plane_Fighter_01\Data\UI\Fighter01_icon_ca.paa','a3\ui_f\data\map\vehicleicons\iconMan_ca.paa'],
	['commander',localize 'STR_QS_Role_027','a3\ui_f\data\gui\cfg\ranks\general_gs.paa','a3\ui_f\data\map\vehicleicons\iconManCommander_ca.paa'],
	['o_rifleman',localize 'STR_QS_Role_013','a3\ui_f\data\map\vehicleicons\iconMan_ca.paa','a3\ui_f\data\map\vehicleicons\iconMan_ca.paa'],
	['o_autorifleman',localize 'STR_QS_Role_014','a3\ui_f\data\map\vehicleicons\iconManMG_ca.paa','a3\ui_f\data\map\vehicleicons\iconManMG_ca.paa'],
	['medic_WL',localize 'STR_QS_Role_019','a3\ui_f\data\map\vehicleicons\iconManMedic_ca.paa','a3\ui_f\data\map\vehicleicons\iconManMedic_ca.paa'],
	['machine_gunner_WL',localize 'STR_QS_Role_015','a3\ui_f\data\map\vehicleicons\iconManMG_ca.paa','a3\ui_f\data\map\vehicleicons\iconManMG_ca.paa'],
	['sniper_WL',localize 'STR_QS_Role_020','a3\ui_f\data\map\vehicleicons\iconManRecon_ca.paa','a3\ui_f\data\map\vehicleicons\iconManRecon_ca.paa'],
	['pilot_heli_WL',localize 'STR_QS_Role_025','A3\Air_F_Beta\Heli_Transport_01\Data\UI\Map_Heli_Transport_01_base_CA.paa','a3\ui_f\data\map\vehicleicons\iconMan_ca.paa']
];
QS_roles_defaultLoadouts = [
	['',([[['arifle_MX_F','','','optic_Hamr',['30Rnd_65x39_caseless_mag_Tracer',30],[],''],[],['hgun_P07_F','','','',['16Rnd_9x21_Mag',16],[],''],['U_B_CombatUniform_mcam',[['FirstAidKit',2],['16Rnd_9x21_Mag',3,16]]],['V_PlateCarrier1_rgr',[['30Rnd_65x39_caseless_mag_Tracer',10,30],['SmokeShell',2,1],['HandGrenade',2,1]]],['B_AssaultPack_mcamo',[]],'H_HelmetB_light','G_Combat',['Binocular','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles']],		[['arifle_MX_khk_F','','','optic_Hamr_khk_F',['30rnd_65x39_caseless_khaki_mag_tracer',30],[],''],[],['hgun_P07_khk_F','','','',['16Rnd_9x21_Mag',16],[],''],['U_B_T_Soldier_F',[['FirstAidKit',2],['16Rnd_9x21_Mag',3,16]]],['V_PlateCarrier1_tna_F',[['SmokeShell',2,1],['HandGrenade',2,1],['30rnd_65x39_caseless_khaki_mag_tracer',10,30]]],['B_AssaultPack_tna_F',[]],'H_HelmetB_Light_tna_F','G_Combat_Goggles_tna_F',['Binocular','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles_tna_F']]] select _tropical)],
	['rifleman',([[['arifle_MX_F','','','optic_Hamr',['30Rnd_65x39_caseless_mag_Tracer',30],[],''],[],['hgun_P07_F','','','',['16Rnd_9x21_Mag',16],[],''],['U_B_CombatUniform_mcam',[['FirstAidKit',2],['16Rnd_9x21_Mag',3,16]]],['V_PlateCarrier1_rgr',[['30Rnd_65x39_caseless_mag_Tracer',10,30],['SmokeShell',2,1],['HandGrenade',2,1]]],['B_AssaultPack_mcamo',[]],'H_HelmetB_light','G_Combat',['Binocular','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles']],	[['arifle_MX_khk_F','','','optic_Hamr_khk_F',['30rnd_65x39_caseless_khaki_mag_tracer',30],[],''],[],['hgun_P07_khk_F','','','',['16Rnd_9x21_Mag',16],[],''],['U_B_T_Soldier_F',[['FirstAidKit',2],['16Rnd_9x21_Mag',3,16]]],['V_PlateCarrier1_tna_F',[['SmokeShell',2,1],['HandGrenade',2,1],['30rnd_65x39_caseless_khaki_mag_tracer',10,30]]],['B_AssaultPack_tna_F',[]],'H_HelmetB_Light_tna_F','G_Combat_Goggles_tna_F',['Binocular','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles_tna_F']]] select _tropical)],
	['autorifleman',([[['arifle_MX_SW_F','','','optic_Hamr',['100Rnd_65x39_caseless_mag',100],[],'bipod_01_F_snd'],[],['hgun_P07_F','','','',['16Rnd_9x21_Mag',16],[],''],['U_B_CombatUniform_mcam_tshirt',[['FirstAidKit',2],['16Rnd_9x21_Mag',3,16]]],['V_PlateCarrier1_rgr',[['SmokeShell',2,1],['HandGrenade',2,1],['100Rnd_65x39_caseless_mag_Tracer',3,100]]],['B_AssaultPack_mcamo',[['100Rnd_65x39_caseless_mag_Tracer',3,100]]],'H_HelmetB_light','G_Combat',['Binocular','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles']],		[['arifle_MX_SW_khk_F','','','optic_Hamr_khk_F',['100Rnd_65x39_caseless_mag',100],[],'bipod_01_F_khk'],[],['hgun_P07_khk_F','','','',['16Rnd_9x21_Mag',16],[],''],['U_B_T_Soldier_AR_F',[['FirstAidKit',2],['16Rnd_9x21_Mag',3,16]]],['V_PlateCarrier1_tna_F',[['SmokeShell',2,1],['HandGrenade',2,1],['100Rnd_65x39_caseless_mag_Tracer',4,100]]],['B_AssaultPack_tna_F',[]],'H_HelmetB_Light_tna_F','G_Combat_Goggles_tna_F',['Binocular','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles_tna_F']]] select _tropical)],
	['machine_gunner',([[['MMG_02_sand_F','','','optic_Hamr',['130Rnd_338_Mag',130],[],'bipod_01_F_snd'],[],['hgun_P07_F','','','',['16Rnd_9x21_Mag',16],[],''],['U_B_CombatUniform_mcam_tshirt',[['FirstAidKit',2],['16Rnd_9x21_Mag',3,16]]],['V_PlateCarrier1_rgr',[['SmokeShell',2,1],['HandGrenade',2,1],['130Rnd_338_Mag',1,130]]],['B_AssaultPack_mcamo',[['130Rnd_338_Mag',2,130]]],'H_HelmetB_light','G_Combat',['Binocular','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles']],		[['MMG_02_black_F','','','optic_Hamr',['130Rnd_338_Mag',130],[],'bipod_01_F_blk'],[],['hgun_P07_khk_F','','','',['16Rnd_9x21_Mag',16],[],''],['U_B_T_Soldier_AR_F',[['FirstAidKit',2],['16Rnd_9x21_Mag',3,16]]],['V_PlateCarrier1_tna_F',[['SmokeShell',2,1],['HandGrenade',2,1],['130Rnd_338_Mag',1,130]]],['B_AssaultPack_tna_F',[['130Rnd_338_Mag',2,130]]],'H_HelmetB_Light_tna_F','G_Combat_Goggles_tna_F',['Binocular','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles_tna_F']]] select _tropical)],
	['rifleman_lat',([[['arifle_MX_F','','','optic_Hamr',['30Rnd_65x39_caseless_mag_Tracer',30],[],''],['launch_NLAW_F','','','',['NLAW_F',1],[],''],['hgun_P07_F','','','',['16Rnd_9x21_Mag',16],[],''],['U_B_CombatUniform_mcam',[['FirstAidKit',2],['16Rnd_9x21_Mag',3,16]]],['V_PlateCarrier1_rgr',[['30Rnd_65x39_caseless_mag_Tracer',10,30],['SmokeShell',2,1],['HandGrenade',2,1]]],['B_AssaultPack_mcamo',[['NLAW_F',2,1]]],'H_HelmetB_light','G_Combat',['Binocular','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles']],		[['arifle_MX_khk_F','','','optic_Hamr_khk_F',['30rnd_65x39_caseless_khaki_mag_tracer',30],[],''],['launch_NLAW_F','','','',['NLAW_F',1],[],''],['hgun_P07_khk_F','','','',['16Rnd_9x21_Mag',16],[],''],['U_B_T_Soldier_F',[['FirstAidKit',2],['16Rnd_9x21_Mag',3,16]]],['V_PlateCarrier1_tna_F',[['SmokeShell',2,1],['HandGrenade',2,1],['30rnd_65x39_caseless_khaki_mag_tracer',10,30]]],['B_AssaultPack_tna_F',[['NLAW_F',2,1]]],'H_HelmetB_Light_tna_F','G_Combat_Goggles_tna_F',['Binocular','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles_tna_F']]] select _tropical)],
	['rifleman_hat',([[['arifle_MX_F','','','optic_Hamr',['30Rnd_65x39_caseless_mag_Tracer',30],[],''],['launch_B_Titan_short_F','','','',['Titan_AT',1],[],''],['hgun_P07_F','','','',['16Rnd_9x21_Mag',16],[],''],['U_B_CombatUniform_mcam',[['FirstAidKit',2],['16Rnd_9x21_Mag',3,16]]],['V_PlateCarrier1_rgr',[['30Rnd_65x39_caseless_mag_Tracer',10,30],['SmokeShell',2,1],['HandGrenade',2,1]]],['B_Kitbag_mcamo',[['Titan_AT',2,1]]],'H_HelmetB_light','G_Combat',['Binocular','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles']],		[['arifle_MX_khk_F','','','optic_Hamr_khk_F',['30rnd_65x39_caseless_khaki_mag_tracer',30],[],''],['launch_B_Titan_short_tna_F','','','',['Titan_AT',1],[],''],['hgun_P07_khk_F','','','',['16Rnd_9x21_Mag',16],[],''],['U_B_T_Soldier_F',[['FirstAidKit',2],['16Rnd_9x21_Mag',3,16]]],['V_PlateCarrier1_tna_F',[['SmokeShell',2,1],['HandGrenade',2,1],['30rnd_65x39_caseless_khaki_mag_tracer',10,30]]],['B_Kitbag_rgr',[['Titan_AT',2,1]]],'H_HelmetB_Light_tna_F','G_Combat_Goggles_tna_F',['Binocular','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles_tna_F']]] select _tropical)],
	['engineer',([[['arifle_MXC_F','','','optic_Hamr',['30Rnd_65x39_caseless_mag_Tracer',30],[],''],[],['hgun_P07_F','','','',['16Rnd_9x21_Mag',16],[],''],['U_B_CombatUniform_mcam',[['FirstAidKit',2],['16Rnd_9x21_Mag',3,16]]],['V_PlateCarrierGL_rgr',[['SmokeShell',2,1],['HandGrenade',2,1],['30Rnd_65x39_caseless_mag_Tracer',10,30]]],['B_AssaultPack_mcamo',[['ToolKit',1],['MineDetector',1]]],'H_HelmetSpecB','G_Combat',['Binocular','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles']],		[['arifle_MXC_khk_F','','','optic_Hamr_khk_F',['30rnd_65x39_caseless_khaki_mag_tracer',30],[],''],[],['hgun_P07_khk_F','','','',['16Rnd_9x21_Mag',16],[],''],['U_B_T_Soldier_F',[['FirstAidKit',2],['16Rnd_9x21_Mag',3,16]]],['V_PlateCarrierGL_tna_F',[['SmokeShell',2,1],['HandGrenade',2,1],['30rnd_65x39_caseless_khaki_mag_tracer',10,30]]],['B_AssaultPack_tna_F',[['ToolKit',1],['MineDetector',1]]],'H_HelmetB_Enh_tna_F','G_Combat_Goggles_tna_F',['Binocular','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles_tna_F']]] select _tropical)],
	['medic',([[['arifle_MX_F','','','optic_Holosight',['30Rnd_65x39_caseless_mag_Tracer',30],[],''],[],['hgun_P07_F','','','',['16Rnd_9x21_Mag',16],[],''],['U_B_CombatUniform_mcam',[['FirstAidKit',2],['16Rnd_9x21_Mag',3,16]]],['V_PlateCarrierSpec_mtp',[['FirstAidKit',5],['30Rnd_65x39_caseless_mag_Tracer',6,30]]],['B_AssaultPack_mcamo',[['Medikit',1],['FirstAidKit',10]]],'H_HelmetB_light','G_Combat',['Binocular','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles']],		[['arifle_MX_khk_F','','','optic_Holosight_khk_F',['30rnd_65x39_caseless_khaki_mag_tracer',30],[],''],[],['hgun_P07_khk_F','','','',['16Rnd_9x21_Mag',16],[],''],['U_B_T_Soldier_F',[['FirstAidKit',2],['16Rnd_9x21_Mag',3,16]]],['V_PlateCarrierSpec_tna_F',[['FirstAidKit',5],['30rnd_65x39_caseless_khaki_mag_tracer',6,30]]],['B_AssaultPack_tna_F',[['Medikit',1],['FirstAidKit',10]]],'H_HelmetB_Light_tna_F','G_Combat_Goggles_tna_F',['Binocular','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles_tna_F']]] select _tropical)],
	['sniper',([[['srifle_LRR_camo_F','','','optic_LRPS',['7Rnd_408_Mag',7],[],''],[],['hgun_P07_F','muzzle_snds_L','','',['16Rnd_9x21_Mag',16],[],''],['U_B_FullGhillie_ard',[['FirstAidKit',2],['16Rnd_9x21_Mag',3,16]]],['V_Chestrig_rgr',[['MiniGrenade',3,1],['7Rnd_408_Mag',8,7]]],[],'','G_Bandanna_tan',['Rangefinder','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles']],		[['srifle_LRR_tna_F','','','optic_LRPS_tna_F',['7Rnd_408_Mag',7],[],''],[],['hgun_P07_khk_F','muzzle_snds_L','','',['16Rnd_9x21_Mag',16],[],''],['U_B_T_FullGhillie_tna_F',[['FirstAidKit',2],['16Rnd_9x21_Mag',3,16]]],['V_Chestrig_rgr',[['MiniGrenade',3,1],['7Rnd_408_Mag',8,7]]],[],'','G_Bandanna_oli',['Rangefinder','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles_tna_F']]] select _tropical)],
	['crewman',([[['SMG_03C_khaki','','','',['50Rnd_570x28_SMG_03',50],[],''],[],['hgun_P07_F','','','',['16Rnd_9x21_Mag',16],[],''],['U_B_CombatUniform_mcam',[['16Rnd_9x21_Mag',2,16],['50Rnd_570x28_SMG_03',2,50]]],[],[],'H_HelmetCrew_B','G_Combat',['Binocular','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles']],		[['SMG_03C_black','','','',['50Rnd_570x28_SMG_03',50],[],''],[],['hgun_P07_khk_F','','','',['16Rnd_9x21_Mag',16],[],''],['U_B_T_Soldier_F',[['50Rnd_570x28_SMG_03',2,50],['16Rnd_9x21_Mag',1,16]]],[],[],'H_HelmetCrew_B','G_Combat_Goggles_tna_F',['Binocular','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles_tna_F']]] select _tropical)],
	['jtac',([[['arifle_MX_GL_F','muzzle_snds_H_snd_F','acc_pointer_IR','optic_Hamr',['30Rnd_65x39_caseless_mag_Tracer',30],['1Rnd_SmokeRed_Grenade_shell',1],''],[],['hgun_P07_F','','','',['16Rnd_9x21_Mag',16],[],''],['U_B_CombatUniform_mcam',[['FirstAidKit',2],['16Rnd_9x21_Mag',2,16],['Laserbatteries',2,1]]],['V_PlateCarrier1_rgr',[['SmokeShell',2,1],['HandGrenade',2,1],['30Rnd_65x39_caseless_mag_Tracer',9,30]]],['b_radiobag_01_mtp_f',[['1Rnd_SmokeRed_Grenade_shell',25,1],['1Rnd_HE_Grenade_shell',15,1]]],'H_Watchcap_khk','G_Lowprofile',['Laserdesignator','','','',['Laserbatteries',2],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles']],		[['arifle_MX_GL_khk_F','muzzle_snds_H_khk_F','acc_pointer_IR','optic_Hamr_khk_F',['30rnd_65x39_caseless_khaki_mag_tracer',30],['1Rnd_HE_Grenade_shell',1],''],[],['hgun_P07_khk_F','','','',['16Rnd_9x21_Mag',16],[],''],['U_B_T_Soldier_F',[['FirstAidKit',2],['16Rnd_9x21_Mag',2,16],['Laserbatteries',1,1]]],['V_PlateCarrier1_tna_F',[['SmokeShell',2,1],['HandGrenade',2,1],['16Rnd_9x21_Mag',1,16],['30rnd_65x39_caseless_khaki_mag_tracer',9,30]]],['b_radiobag_01_tropic_f',[['1Rnd_SmokeRed_Grenade_shell',25,1],['1Rnd_HE_Grenade_shell',14,1]]],'H_Watchcap_camo','G_Lowprofile',['Laserdesignator_01_khk_F','','','',['Laserbatteries',1],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles_tna_F']]] select _tropical)],
	['mortar_gunner',([[['arifle_MXC_F','','','optic_Hamr',['30Rnd_65x39_caseless_mag_Tracer',30],[],''],[],['hgun_P07_F','','','',['16Rnd_9x21_Mag',16],[],''],['U_B_CombatUniform_mcam_tshirt',[['FirstAidKit',2],['16Rnd_9x21_Mag',3,16]]],['V_PlateCarrierGL_rgr',[['SmokeShell',2,1],['HandGrenade',2,1],['30Rnd_65x39_caseless_mag_Tracer',10,30]]],['B_Mortar_01_weapon_F',[]],'H_HelmetSpecB','G_Combat',['Rangefinder','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles']],		[['arifle_MXC_khk_F','','','optic_Hamr_khk_F',['30rnd_65x39_caseless_khaki_mag_tracer',30],[],''],[],['hgun_P07_khk_F','','','',['16Rnd_9x21_Mag',16],[],''],['U_B_T_Soldier_AR_F',[['FirstAidKit',2],['16Rnd_9x21_Mag',3,16]]],['V_PlateCarrierGL_tna_F',[['SmokeShell',2,1],['HandGrenade',2,1],['30rnd_65x39_caseless_khaki_mag_tracer',10,30]]],['B_Mortar_01_Weapon_grn_F',[]],'H_HelmetB_Enh_tna_F','G_Combat_Goggles_tna_F',['Rangefinder','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles_tna_F']]] select _tropical)],
	['uav',([[['arifle_MX_F','','','optic_Hamr',['30Rnd_65x39_caseless_mag_Tracer',30],[],''],[],['hgun_P07_F','','','',['16Rnd_9x21_Mag',16],[],''],['U_B_CombatUniform_mcam',[['FirstAidKit',2],['16Rnd_9x21_Mag',3,16],['Laserbatteries',1,1]]],['V_PlateCarrier1_rgr',[['30Rnd_65x39_caseless_mag_Tracer',10,30],['SmokeShell',2,1],['HandGrenade',2,1],['Laserbatteries',1,1]]],['B_UAV_01_backpack_F',[]],'H_HelmetB_light','G_Lowprofile',['Laserdesignator','','','',['Laserbatteries',1],[],''],['ItemMap','B_UavTerminal','ItemRadio','ItemCompass','ItemWatch','NVGoggles']],		[['arifle_MX_khk_F','','','optic_Hamr_khk_F',['30rnd_65x39_caseless_khaki_mag_tracer',30],[],''],[],['hgun_P07_khk_F','','','',['16Rnd_9x21_Mag',16],[],''],['U_B_T_Soldier_F',[['FirstAidKit',2],['16Rnd_9x21_Mag',3,16]]],['V_PlateCarrier1_tna_F',[['SmokeShell',2,1],['HandGrenade',2,1],['30rnd_65x39_caseless_khaki_mag_tracer',10,30],['Laserbatteries',2,1]]],['B_UAV_01_backpack_F',[]],'H_HelmetB_Light_tna_F','G_Lowprofile',['Laserdesignator_01_khk_F','','','',['Laserbatteries',1],[],''],['ItemMap','B_UavTerminal','ItemRadio','ItemCompass','ItemWatch','NVGoggles_tna_F']]] select _tropical)],
	['pilot_heli',([[['SMG_03C_khaki','','','',['50Rnd_570x28_SMG_03',50],[],''],[],['hgun_P07_F','','','',['16Rnd_9x21_Mag',16],[],''],['U_B_HeliPilotCoveralls',[['FirstAidKit',2],['16Rnd_9x21_Mag',3,16]]],['V_TacVest_blk',[['50Rnd_570x28_SMG_03',4,50],['DemoCharge_Remote_Mag',1,1]]],[],'H_PilotHelmetHeli_B','',['Binocular','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles']],		[['SMG_03C_black','','','',['50Rnd_570x28_SMG_03',50],[],''],[],['hgun_P07_F','','','',['16Rnd_9x21_Mag',16],[],''],['U_B_HeliPilotCoveralls',[['FirstAidKit',2],['16Rnd_9x21_Mag',3,16]]],['V_TacVest_blk',[['DemoCharge_Remote_Mag',1,1],['50Rnd_570x28_SMG_03',3,50]]],[],'H_PilotHelmetHeli_B','',['Binocular','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles_tna_F']]] select _tropical)],
	['pilot_plane',([[[],[],['hgun_P07_F','muzzle_snds_L','','',['16Rnd_9x21_Mag',16],[],''],['U_B_PilotCoveralls',[['FirstAidKit',2],['16Rnd_9x21_Mag',3,16],['SmokeShellBlue',2,1]]],[],[],'H_PilotHelmetFighter_B','G_Combat',[],['ItemMap','','ItemRadio','ItemCompass','ItemWatch','']],		[[],[],['hgun_P07_khk_F','muzzle_snds_L','','',['16Rnd_9x21_Mag',16],[],''],['U_B_PilotCoveralls',[['FirstAidKit',2],['SmokeShellBlue',2,1],['16Rnd_9x21_Mag',3,16]]],[],[],'H_PilotHelmetFighter_B','G_Combat',[],['ItemMap','','ItemRadio','ItemCompass','ItemWatch','']]] select _tropical)],
	['commander',([[[],[],['hgun_Pistol_heavy_02_F','','','optic_Yorris',['6Rnd_45ACP_Cylinder',6],[],''],['U_B_CombatUniform_mcam',[['FirstAidKit',1],['6Rnd_45ACP_Cylinder',4,6]]],[],[],'H_MilCap_mcamo','G_Aviator',['Rangefinder','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles']],		[[],[],['hgun_Pistol_heavy_02_F','','','optic_Yorris',['6Rnd_45ACP_Cylinder',6],[],''],['U_B_T_Soldier_F',[['FirstAidKit',1],['6Rnd_45ACP_Cylinder',4,6]]],[],[],'H_MilCap_tna_F','G_Aviator',['Rangefinder','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles_tna_F']]] select _tropical)],
	['o_rifleman',([[['arifle_Katiba_F','','','',['30Rnd_65x39_caseless_green_mag_Tracer',30],[],''],[],['hgun_Rook40_F','','','',['16Rnd_9x21_Mag',16],[],''],['U_O_CombatUniform_ocamo',[['FirstAidKit',2],['16Rnd_9x21_Mag',2,16]]],['V_HarnessO_brn',[['30Rnd_65x39_caseless_green_mag_Tracer',11,30],['MiniGrenade',5,1],['SmokeShell',2,1]]],[],'H_HelmetSpecO_blk','G_Bandanna_blk',[],['ItemMap','','ItemRadio','ItemCompass','ItemWatch','NVGoggles_OPFOR']],		[['arifle_AKM_F','','','',['30Rnd_762x39_Mag_Tracer_Green_F',30],[],''],[],['hgun_Rook40_F','','','',['16Rnd_9x21_Mag',16],[],''],['U_O_T_Soldier_F',[['FirstAidKit',2],['16Rnd_9x21_Mag',2,16]]],['V_HarnessO_ghex_F',[['MiniGrenade',5,1],['SmokeShell',2,1],['30Rnd_762x39_Mag_Tracer_Green_F',12,30]]],[],'H_HelmetSpecO_blk','G_Bandanna_oli',[],['ItemMap','','ItemRadio','ItemCompass','ItemWatch','NVGoggles_OPFOR']]] select _tropical)],
	['o_autorifleman',([[['LMG_Mk200_F','','','',['200Rnd_65x39_cased_Box_Tracer',200],[],'bipod_02_F_blk'],[],['hgun_Rook40_F','','','',['16Rnd_9x21_Mag',16],[],''],['U_O_CombatUniform_ocamo',[['FirstAidKit',2],['16Rnd_9x21_Mag',2,16]]],['V_HarnessO_brn',[['MiniGrenade',5,1],['SmokeShell',2,1],['200Rnd_65x39_cased_Box_Tracer',2,200]]],['B_FieldPack_ocamo',[['200Rnd_65x39_cased_Box_Tracer',4,200]]],'H_HelmetSpecO_blk','G_Bandanna_oli',[],['ItemMap','','ItemRadio','ItemCompass','ItemWatch','NVGoggles_OPFOR']],		[['LMG_03_F','','','',['200Rnd_556x45_Box_Tracer_F',200],[],''],[],['hgun_Rook40_F','','','',['16Rnd_9x21_Mag',16],[],''],['U_O_T_Soldier_F',[['FirstAidKit',2],['16Rnd_9x21_Mag',2,16]]],['V_HarnessO_ghex_F',[['MiniGrenade',5,1],['SmokeShell',2,1],['200Rnd_556x45_Box_Tracer_F',3,200]]],['B_FieldPack_ghex_F',[['200Rnd_556x45_Box_Tracer_F',5,200]]],'H_HelmetSpecO_blk','G_Bandanna_oli',[],['ItemMap','','ItemRadio','ItemCompass','ItemWatch','NVGoggles_OPFOR']]] select _tropical)],
	['medic_WL',([[['arifle_MX_F','','','optic_Holosight',['30Rnd_65x39_caseless_mag_Tracer',30],[],''],[],['hgun_P07_F','','','',['16Rnd_9x21_Mag',16],[],''],['U_B_CombatUniform_mcam',[['FirstAidKit',2],['16Rnd_9x21_Mag',3,16]]],['V_PlateCarrierSpec_mtp',[['FirstAidKit',5],['30Rnd_65x39_caseless_mag_Tracer',6,30]]],['B_AssaultPack_mcamo',[['Medikit',1],['FirstAidKit',10]]],'H_HelmetB_light','G_Combat',['Binocular','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles']],		[['arifle_MX_khk_F','','','optic_Holosight_khk_F',['30rnd_65x39_caseless_khaki_mag_tracer',30],[],''],[],['hgun_P07_khk_F','','','',['16Rnd_9x21_Mag',16],[],''],['U_B_T_Soldier_F',[['FirstAidKit',2],['16Rnd_9x21_Mag',3,16]]],['V_PlateCarrierSpec_tna_F',[['FirstAidKit',5],['30rnd_65x39_caseless_khaki_mag_tracer',6,30]]],['B_AssaultPack_tna_F',[['Medikit',1],['FirstAidKit',10]]],'H_HelmetB_Light_tna_F','G_Combat_Goggles_tna_F',['Binocular','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles_tna_F']]] select _tropical)],
	['machine_gunner_WL',([[['MMG_02_sand_F','','','optic_Hamr',['130Rnd_338_Mag',130],[],'bipod_01_F_snd'],[],['hgun_P07_F','','','',['16Rnd_9x21_Mag',16],[],''],['U_B_CombatUniform_mcam_tshirt',[['FirstAidKit',2],['16Rnd_9x21_Mag',3,16]]],['V_PlateCarrier1_rgr',[['SmokeShell',2,1],['HandGrenade',2,1],['130Rnd_338_Mag',1,130]]],['B_AssaultPack_mcamo',[['130Rnd_338_Mag',2,130]]],'H_HelmetB_light','G_Combat',['Binocular','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles']],		[['MMG_02_black_F','','','optic_Hamr',['130Rnd_338_Mag',130],[],'bipod_01_F_blk'],[],['hgun_P07_khk_F','','','',['16Rnd_9x21_Mag',16],[],''],['U_B_T_Soldier_AR_F',[['FirstAidKit',2],['16Rnd_9x21_Mag',3,16]]],['V_PlateCarrier1_tna_F',[['SmokeShell',2,1],['HandGrenade',2,1],['130Rnd_338_Mag',1,130]]],['B_AssaultPack_tna_F',[['130Rnd_338_Mag',2,130]]],'H_HelmetB_Light_tna_F','G_Combat_Goggles_tna_F',['Binocular','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles_tna_F']]] select _tropical)],
	['sniper_WL',([[['srifle_LRR_camo_F','','','optic_LRPS',['7Rnd_408_Mag',7],[],''],[],['hgun_P07_F','muzzle_snds_L','','',['16Rnd_9x21_Mag',16],[],''],['U_B_FullGhillie_ard',[['FirstAidKit',2],['16Rnd_9x21_Mag',3,16]]],['V_Chestrig_rgr',[['MiniGrenade',3,1],['7Rnd_408_Mag',8,7]]],[],'','G_Bandanna_tan',['Rangefinder','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles']],		[['srifle_LRR_tna_F','','','optic_LRPS_tna_F',['7Rnd_408_Mag',7],[],''],[],['hgun_P07_khk_F','muzzle_snds_L','','',['16Rnd_9x21_Mag',16],[],''],['U_B_T_FullGhillie_tna_F',[['FirstAidKit',2],['16Rnd_9x21_Mag',3,16]]],['V_Chestrig_rgr',[['MiniGrenade',3,1],['7Rnd_408_Mag',8,7]]],[],'','G_Bandanna_oli',['Rangefinder','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles_tna_F']]] select _tropical)],
	['pilot_heli_WL',([[['SMG_03C_khaki','','','',['50Rnd_570x28_SMG_03',50],[],''],[],['hgun_P07_F','','','',['16Rnd_9x21_Mag',16],[],''],['U_B_HeliPilotCoveralls',[['FirstAidKit',2],['16Rnd_9x21_Mag',3,16]]],['V_TacVest_blk',[['50Rnd_570x28_SMG_03',4,50],['DemoCharge_Remote_Mag',1,1]]],[],'H_PilotHelmetHeli_B','',['Binocular','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles']],		[['SMG_03C_black','','','',['50Rnd_570x28_SMG_03',50],[],''],[],['hgun_P07_F','','','',['16Rnd_9x21_Mag',16],[],''],['U_B_HeliPilotCoveralls',[['FirstAidKit',2],['16Rnd_9x21_Mag',3,16]]],['V_TacVest_blk',[['DemoCharge_Remote_Mag',1,1],['50Rnd_570x28_SMG_03',3,50]]],[],'H_PilotHelmetHeli_B','',['Binocular','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles_tna_F']]] select _tropical)]
];
QS_fnc_roleDescription = compileFinal {
	params ['_role'];
	_tropical = worldName in ['Tanoa'];
	private _description = 'Undefined';
	if (_role in ['rifleman']) then {
		_description = format ['As a Rifleman, you are a front line soldier, and the backbone of the military.<br/><br/><img shadow="0" align="center" size="18" image="media\images\roles\%1\%2.jpg"/>',(['arid','tropic'] select (worldName in ['Tanoa'])),(uiNamespace getVariable ['QS_RSS_currentSelectedRole','rifleman'])];
	};
	if (_role in ['autorifleman','autorifleman_WL']) then {
		_description = format ['An Automatic Riflemans job is to provide cover fire for their squad during engagements and while their squad is moving.<br/><br/><img shadow="0" align="center" size="18" image="media\images\roles\%1\%2.jpg"/>',(['arid','tropic'] select (worldName in ['Tanoa'])),(uiNamespace getVariable ['QS_RSS_currentSelectedRole','rifleman'])];
	};
	if (_role in ['machine_gunner','machine_gunner_WL']) then {
		_description = format ['A Machine Gunners job is to provide suppressive fire at long ranges. Unlike their lighter Autorifleman cousins, Machine Gunners may operate as part of a smaller detachment of the squad, and move at a slower pace.<br/><br/><img shadow="0" align="center" size="18" image="media\images\roles\%1\%2.jpg"/>',(['arid','tropic'] select (worldName in ['Tanoa'])),(uiNamespace getVariable ['QS_RSS_currentSelectedRole','rifleman'])];
	};
	if (_role in ['rifleman_lat','rifleman_lat_WL']) then {
		_description = format ['As a Rifleman (Light Anti-Tank), your role is to provide fire support against infantry, fortifications, unarmored and light-armored vehicles.<br/><br/><img shadow="0" align="center" size="18" image="media\images\roles\%1\%2.jpg"/>',(['arid','tropic'] select (worldName in ['Tanoa'])),(uiNamespace getVariable ['QS_RSS_currentSelectedRole','rifleman'])];
	};
	if (_role in ['rifleman_hat','rifleman_hat_WL']) then {
		_description = format ['As a Rifleman (Heavy Anti-Tank), your role is to provide fire support against armored vehicles.<br/><br/><img shadow="0" align="center" size="18" image="media\images\roles\%1\%2.jpg"/>',(['arid','tropic'] select (worldName in ['Tanoa'])),(uiNamespace getVariable ['QS_RSS_currentSelectedRole','rifleman'])];
	};
	if (_role in ['engineer','engineer_WL']) then {
		_description = format ['An Engineer is a combat soldier with a range of tactical and technical skills.<br/><br/><img shadow="0" align="center" size="18" image="media\images\roles\%1\%2.jpg"/>',(['arid','tropic'] select (worldName in ['Tanoa'])),(uiNamespace getVariable ['QS_RSS_currentSelectedRole','rifleman'])];
	};
	if (_role in ['medic','medic_WL']) then {
		_description = format ['A Medic is responsible for providing First Aid and Medical services to friendly soldiers and non-combatants.<br/><br/><img shadow="0" align="center" size="18" image="media\images\roles\%1\%2.jpg"/>',(['arid','tropic'] select (worldName in ['Tanoa'])),(uiNamespace getVariable ['QS_RSS_currentSelectedRole','rifleman'])];
	};
	if (_role in ['sniper','sniper_WL']) then {
		_description = format ['Marksman DLC Required.<br/><br/>A Snipers main task is reconaissance. When the mission calls for it, snipers can also dismantle and dishearten the enemy with a few well-placed rifle shots. When there is no specific objective, a sniper will look for targets of opportunity.<br/><br/><img shadow="0" align="center" size="18" image="media\images\roles\%1\%2.jpg"/>',(['arid','tropic'] select _tropical),(uiNamespace getVariable ['QS_RSS_currentSelectedRole','rifleman'])];
	};
	if (_role in ['crewman']) then {
		_description = format ['Tanks DLC Required.<br/><br/>A Crewman is able to operate the Driver and Gunner positions of armored vehicles (Tanks, IFVs and APCs).<br/><br/><img shadow="0" align="center" size="18" image="media\images\roles\%1\%2.jpg"/>',(['arid','tropic'] select _tropical),(uiNamespace getVariable ['QS_RSS_currentSelectedRole','rifleman'])];
	};
	if (_role in ['jtac','jtac_WL']) then {
		_description = format ['Working from a forward position, a Joint Terminal Attack Controller (JTAC) directs the action of combat aircraft engaged in close air support and other offensive air operations. This soldier will work closely with Pilots, UAV Operators and Squad Leaders.<br/><br/><img shadow="0" align="center" size="18" image="media\images\roles\%1\%2.jpg"/>',(['arid','tropic'] select _tropical),(uiNamespace getVariable ['QS_RSS_currentSelectedRole','rifleman'])];
	};
	if (_role in ['mortar_gunner']) then {
		_description = format ['Mortar Gunners provide indirect fire support to squads. These soldiers can also deactivate mines, explosives and IEDs.<br/><br/><img shadow="0" align="center" size="18" image="media\images\roles\%1\%2.jpg"/>',(['arid','tropic'] select _tropical),(uiNamespace getVariable ['QS_RSS_currentSelectedRole','rifleman'])];
	};
	if (_role in ['uav']) then {
		_description = format ['A UAV Operator controls autonomous vehicles for logistics, intel-gathering, support and combat tasks.<br/><br/><img shadow="0" align="center" size="18" image="media\images\roles\%1\%2.jpg"/>',(['arid','tropic'] select _tropical),(uiNamespace getVariable ['QS_RSS_currentSelectedRole','rifleman'])];
	};
	if (_role in ['pilot_heli','pilot_heli_WL']) then {
		_description = format ['Transport Pilots provide infantry transport to and from missions.<br/><br/><img shadow="0" align="center" size="18" image="media\images\roles\%1\%2.jpg"/>',(['arid','tropic'] select _tropical),(uiNamespace getVariable ['QS_RSS_currentSelectedRole','rifleman'])];
	};
	if (_role in ['pilot_plane']) then {
		_description = format ['Jets DLC Required.<br/><br/>A Fighter Pilot is responsible for providing Close Air Support to ground elements when requested, and flying Combat Air Patrols to protect transport pilots from enemy aircraft.<br/><br/><img shadow="0" align="center" size="18" image="media\images\roles\%1\%2.jpg"/>',(['arid','tropic'] select _tropical),(uiNamespace getVariable ['QS_RSS_currentSelectedRole','rifleman'])];
	};
	if (_role in ['commander']) then {
		_description = format ['Organize and deploy available resources (including players) to defeat the enemy. <br/><br/>Soldiers are required under military law to obey your orders.<br/><br/><img shadow="0" align="center" size="18" image="media\images\roles\%1\%2.jpg"/>',(['arid','tropic'] select _tropical),(uiNamespace getVariable ['QS_RSS_currentSelectedRole','rifleman'])];
	};
	if (_role in ['o_rifleman']) then {
		_description = format ['As a Rifleman, you are a front line soldier, and the backbone of the military.<br/><br/><img shadow="0" align="center" size="18" image="media\images\roles\%1\%2.jpg"/>',(['arid','tropic'] select (worldName in ['Tanoa'])),(uiNamespace getVariable ['QS_RSS_currentSelectedRole','rifleman'])];
	};
	if (_role in ['o_autorifleman']) then {
		_description = format ['An Automatic Riflemans job is to provide cover fire for their squad during engagements and while their squad is moving.<br/><br/><img shadow="0" align="center" size="18" image="media\images\roles\%1\%2.jpg"/>',(['arid','tropic'] select (worldName in ['Tanoa'])),(uiNamespace getVariable ['QS_RSS_currentSelectedRole','rifleman'])];
	};
	(parseText _description);
};