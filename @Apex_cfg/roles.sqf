/*/
File: roles.sqf
Author:

	Quiksilver
	
Last Modified:

	01/05/2023 A3 2.10 by Quiksilver
	
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
				/*[
			'spotter',
			WEST,
			4,
			4,
			-1,
			4,
			0,
			0,
			{TRUE},
			{(((player getVariable ['QS_unit_side',WEST]) isEqualTo WEST) || (missionNamespace getVariable ['QS_RSS_client_canSideSwitch',FALSE]))},
			{}
		],*/
		/*[
			'sat',
			WEST,
			11,
			11,
			-1,
			11,
			0,
			0,
			{TRUE},
			{(((player getVariable ['QS_unit_side',WEST]) isEqualTo WEST) || (missionNamespace getVariable ['QS_RSS_client_canSideSwitch',FALSE]))},
			{}
		],*/
		/*[
			'leader',
			WEST,
			0,
			0,
			-1,
			11,
			0,
			0,
			{TRUE},
			{(((player getVariable ['QS_unit_side',WEST]) isEqualTo WEST) || (missionNamespace getVariable ['QS_RSS_client_canSideSwitch',FALSE]) && ((getPlayerUID player) in (['MK1'] call (missionNamespace getVariable 'QS_fnc_whitelist'))))},
			{}
		],*/
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
		/*[
			'pilot_cas',
			WEST,
			1,
			1,
			-1,
			1,
			0,
			0,
			{TRUE},
			{((((player getVariable ['QS_unit_side',WEST]) isEqualTo WEST) || (missionNamespace getVariable ['QS_RSS_client_canSideSwitch',FALSE])) && (!((missionNamespace getVariable ['QS_missionConfig_CAS',2]) isEqualTo 0)))},
			{}
		],*/
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
/*QS_roles_UI_info = [
	['rifleman',localize 'STR_QS_Role_013','a3\ui_f\data\map\vehicleicons\iconMan_ca.paa','a3\ui_f\data\map\vehicleicons\iconMan_ca.paa'],
	['autorifleman',localize 'STR_QS_Role_014','a3\ui_f\data\map\vehicleicons\iconManMG_ca.paa','a3\ui_f\data\map\vehicleicons\iconManMG_ca.paa'],
	['machine_gunner',localize 'STR_QS_Role_015','a3\ui_f\data\map\vehicleicons\iconManMG_ca.paa','a3\ui_f\data\map\vehicleicons\iconManMG_ca.paa'],
	['rifleman_lat',localize 'STR_QS_Role_016','a3\ui_f\data\map\vehicleicons\iconManAT_ca.paa','a3\ui_f\data\map\vehicleicons\iconManAT_ca.paa'],
	['rifleman_hat',localize 'STR_QS_Role_017','a3\ui_f\data\map\vehicleicons\iconManAT_ca.paa','a3\ui_f\data\map\vehicleicons\iconManAT_ca.paa'],
	['engineer',localize 'STR_QS_Role_018','a3\ui_f\data\map\vehicleicons\iconManEngineer_ca.paa','a3\ui_f\data\map\vehicleicons\iconManEngineer_ca.paa'],
	['medic',localize 'STR_QS_Role_019','a3\ui_f\data\map\vehicleicons\iconManMedic_ca.paa','a3\ui_f\data\map\vehicleicons\iconManMedic_ca.paa'],
	['sniper',localize 'STR_QS_Role_020','a3\ui_f\data\map\vehicleicons\iconManRecon_ca.paa','a3\ui_f\data\map\vehicleicons\iconManRecon_ca.paa'],
	//['spotter',localize 'STR_QS_Role_039','a3\ui_f\data\map\vehicleicons\iconManRecon_ca.paa','a3\ui_f\data\map\vehicleicons\iconManRecon_ca.paa'],
	//['crewman',localize 'STR_QS_Role_021','a3\ui_f\data\map\vehicleicons\iconMan_ca.paa','a3\ui_f\data\map\vehicleicons\iconMan_ca.paa'],
	['jtac',localize 'STR_QS_Role_022','a3\ui_f\data\map\vehicleicons\iconManRecon_ca.paa','a3\ui_f\data\map\vehicleicons\iconManRecon_ca.paa'],
	//['sat',localize 'STR_QS_Role_043','a3\ui_f\data\map\vehicleicons\iconManRecon_ca.paa','a3\ui_f\data\map\vehicleicons\iconManRecon_ca.paa'],
	['mortar_gunner',localize 'STR_QS_Role_023','A3\Static_f\Mortar_01\data\UI\map_Mortar_01_CA.paa','a3\ui_f\data\map\vehicleicons\iconMan_ca.paa'],
	['uav',localize 'STR_QS_Role_024','A3\Drones_F\Air_F_Gamma\UAV_02\Data\UI\Map_UAV_02_CA.paa','a3\ui_f\data\map\vehicleicons\iconMan_ca.paa'],
	['pilot_heli',localize 'STR_QS_Role_025','A3\Air_F_Beta\Heli_Transport_01\Data\UI\Map_Heli_Transport_01_base_CA.paa','a3\ui_f\data\map\vehicleicons\iconMan_ca.paa'],
	//['pilot_cas',localize 'STR_QS_Role_048','A3\Air_F_Beta\Heli_Attack_01\Data\UI\Map_Heli_Attack_01_base_CA.paa','a3\ui_f\data\map\vehicleicons\iconMan_ca.paa'],
	['pilot_plane',localize 'STR_QS_Role_026','A3\Air_F_Jets\Plane_Fighter_01\Data\UI\Fighter01_icon_ca.paa','a3\ui_f\data\map\vehicleicons\iconMan_ca.paa'],
	//['leader',localize 'STR_QS_Role_051','a3\ui_f\data\gui\cfg\ranks\general_gs.paa','a3\ui_f\data\map\vehicleicons\iconManCommander_ca.paa'],
	['commander',localize 'STR_QS_Role_027','a3\ui_f\data\gui\cfg\ranks\general_gs.paa','a3\ui_f\data\map\vehicleicons\iconManCommander_ca.paa'],
	['o_rifleman',localize 'STR_QS_Role_054','a3\ui_f\data\map\vehicleicons\iconMan_ca.paa','a3\ui_f\data\map\vehicleicons\iconMan_ca.paa'],
	['o_autorifleman',localize 'STR_QS_Role_056','a3\ui_f\data\map\vehicleicons\iconManMG_ca.paa','a3\ui_f\data\map\vehicleicons\iconManMG_ca.paa'],
	['medic_WL',localize 'STR_QS_Role_019','a3\ui_f\data\map\vehicleicons\iconManMedic_ca.paa','a3\ui_f\data\map\vehicleicons\iconManMedic_ca.paa'],
	['machine_gunner_WL',localize 'STR_QS_Role_015','a3\ui_f\data\map\vehicleicons\iconManMG_ca.paa','a3\ui_f\data\map\vehicleicons\iconManMG_ca.paa'],
	['sniper_WL',localize 'STR_QS_Role_020','a3\ui_f\data\map\vehicleicons\iconManRecon_ca.paa','a3\ui_f\data\map\vehicleicons\iconManRecon_ca.paa'],
	['pilot_heli_WL',localize 'STR_QS_Role_025','A3\Air_F_Beta\Heli_Transport_01\Data\UI\Map_Heli_Transport_01_base_CA.paa','a3\ui_f\data\map\vehicleicons\iconMan_ca.paa']
];*/
QS_roles_defaultLoadouts = [
	['',([[['arifle_MX_F','','','optic_Hamr',['30Rnd_65x39_caseless_mag_Tracer',30],[],''],[],['hgun_P07_F','','','',['16Rnd_9x21_Mag',16],[],''],['U_B_CombatUniform_mcam',[['FirstAidKit',2],['16Rnd_9x21_Mag',3,16]]],['V_PlateCarrier1_rgr',[['30Rnd_65x39_caseless_mag_Tracer',10,30],['SmokeShell',2,1],['HandGrenade',2,1]]],['B_AssaultPack_mcamo',[]],'H_HelmetB_light','G_Combat',['Binocular','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles']],		[['arifle_MX_khk_F','','','optic_Hamr_khk_F',['30rnd_65x39_caseless_khaki_mag_tracer',30],[],''],[],['hgun_P07_khk_F','','','',['16Rnd_9x21_Mag',16],[],''],['U_B_T_Soldier_F',[['FirstAidKit',2],['16Rnd_9x21_Mag',3,16]]],['V_PlateCarrier1_tna_F',[['SmokeShell',2,1],['HandGrenade',2,1],['30rnd_65x39_caseless_khaki_mag_tracer',10,30]]],['B_AssaultPack_tna_F',[]],'H_HelmetB_Light_tna_F','G_Combat_Goggles_tna_F',['Binocular','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles_tna_F']]] select _tropical)],
	['rifleman',([
	[['arifle_MX_F','','acc_flashlight','optic_Hamr',['30Rnd_65x39_caseless_mag_Tracer',30],[],''],[],['hgun_Pistol_heavy_01_F','','acc_flashlight_pistol','optic_MRD',['11Rnd_45ACP_Mag',11],[],''],['u_b_combatuniform_mcam_tshirt',[['FirstAidKit',2],['11Rnd_45ACP_Mag',3,11]]],['V_PlateCarrier2_blk',[['FirstAidKit',10],['MineDetector',1],['SmokeShell',2,1],['HandGrenade',2,1]]],['b_carryall_mcamo',[['30Rnd_65x39_caseless_mag_Tracer',7,30],['satchelcharge_remote_mag',2,1]]],'H_HelmetSpecB','G_Lowprofile',['Binocular','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles']],	
	[['arifle_MX_khk_F','','acc_flashlight','optic_Hamr_khk_F',['30rnd_65x39_caseless_khaki_mag_tracer',30],[],''],[],['hgun_Pistol_heavy_01_green_F','','acc_flashlight_pistol','optic_MRD',['11Rnd_45ACP_Mag',11],[],''],['U_B_T_Soldier_F',[['FirstAidKit',2],['11Rnd_45ACP_Mag',3,11]]],['V_PlateCarrier2_blk',[['FirstAidKit',10],['MineDetector',1],['SmokeShell',2,1],['HandGrenade',2,1]]],['b_carryall_oli',[['30rnd_65x39_caseless_khaki_mag_tracer',7,30],['satchelcharge_remote_mag',2,1]]],'h_helmetb_enh_tna_f','G_Lowprofile',['Binocular','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles_tna_F']]] select _tropical)],
	
	['autorifleman',([
	[['arifle_MX_SW_F','','acc_flashlight','optic_Hamr',['100Rnd_65x39_caseless_mag_Tracer',100],[],'bipod_01_F_snd'],[],['hgun_Pistol_heavy_01_F','','acc_flashlight_pistol','optic_MRD',['11Rnd_45ACP_Mag',11],[],''],['U_B_CombatUniform_mcam_tshirt',[['FirstAidKit',2],['11Rnd_45ACP_Mag',3,11]]],['V_PlateCarrier2_blk',[['FirstAidKit',10],['MineDetector',1],['SmokeShell',2,1],['HandGrenade',2,1]]],['b_carryall_mcamo',[['satchelcharge_remote_mag',1,1],['100Rnd_65x39_caseless_mag_Tracer',7,100]]],'H_HelmetSpecB','G_Lowprofile',['Binocular','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles']],		
	[['arifle_MX_SW_khk_F','','acc_flashlight','optic_Hamr_khk_F',['100Rnd_65x39_caseless_khaki_mag_Tracer',100],[],'bipod_01_F_khk'],[],['hgun_Pistol_heavy_01_green_F','','acc_flashlight_pistol','optic_MRD',['11Rnd_45ACP_Mag',11],[],''],['U_B_T_Soldier_AR_F',[['FirstAidKit',2],['11Rnd_45ACP_Mag',3,11]]],['V_PlateCarrier2_blk',[['FirstAidKit',10],['MineDetector',1],['SmokeShell',2,1],['HandGrenade',2,1]]],['b_carryall_oli',[['satchelcharge_remote_mag',1,1],['100Rnd_65x39_caseless_khaki_mag_Tracer',7,100]]],'h_helmetb_enh_tna_f','G_Lowprofile',['Binocular','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles_tna_F']]] select _tropical)],
	
	['machine_gunner',([
	[['MMG_02_sand_F','','acc_flashlight','optic_Hamr',['130Rnd_338_Mag',130],[],'bipod_01_F_snd'],[],['hgun_Pistol_heavy_01_F','','acc_flashlight_pistol','optic_MRD',['11Rnd_45ACP_Mag',11],[],''],['U_B_CombatUniform_mcam_tshirt',[['FirstAidKit',2],['11Rnd_45ACP_Mag',3,11]]],['V_PlateCarrier2_blk',[['FirstAidKit',10],['MineDetector',1],['SmokeShell',2,1],['HandGrenade',2,1]]],['b_carryall_mcamo',[['130Rnd_338_Mag',5,130]]],'H_HelmetSpecB','G_Lowprofile',['Binocular','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles']],		
	[['MMG_02_black_F','','acc_flashlight','optic_Hamr',['130Rnd_338_Mag',130],[],'bipod_01_F_blk'],[],['hgun_Pistol_heavy_01_green_F','','acc_flashlight_pistol','optic_MRD',['11Rnd_45ACP_Mag',11],[],''],['U_B_T_Soldier_AR_F',[['FirstAidKit',2],['11Rnd_45ACP_Mag',3,11]]],['V_PlateCarrier2_blk',[['FirstAidKit',10],['MineDetector',1],['SmokeShell',2,1],['HandGrenade',2,1]]],['b_carryall_oli',[['130Rnd_338_Mag',5,130]]],'h_helmetb_enh_tna_f','G_Lowprofile',['Binocular','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles_tna_F']]] select _tropical)],
	
	['rifleman_lat',([
	[['arifle_MX_F','','acc_flashlight','optic_Hamr',['30Rnd_65x39_caseless_mag_Tracer',30],[],''],['launch_NLAW_F','','','',['NLAW_F',1],[],''],['hgun_Pistol_heavy_01_F','','acc_flashlight_pistol','optic_MRD',['11Rnd_45ACP_Mag',11],[],''],['u_b_combatuniform_mcam_tshirt',[['FirstAidKit',2],['11Rnd_45ACP_Mag',3,11]]],['V_PlateCarrier2_blk',[['FirstAidKit',10],['MineDetector',1],['SmokeShell',2,1],['HandGrenade',2,1]]],['b_carryall_mcamo',[['30Rnd_65x39_caseless_mag_Tracer',7,30],['NLAW_F',3,1]]],'H_HelmetSpecB','G_Lowprofile',['Binocular','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles']],		
	[['arifle_MX_khk_F','','acc_flashlight','optic_Hamr_khk_F',['30rnd_65x39_caseless_khaki_mag_tracer',30],[],''],['launch_NLAW_F','','','',['NLAW_F',1],[],''],['hgun_Pistol_heavy_01_green_F','','acc_flashlight_pistol','optic_MRD',['11Rnd_45ACP_Mag',11],[],''],['U_B_T_Soldier_F',[['FirstAidKit',2],['11Rnd_45ACP_Mag',3,11]]],['V_PlateCarrier2_blk',[['SmokeShell',2,1],['HandGrenade',2,1],['FirstAidKit',10],['MineDetector',1]]],['b_carryall_oli',[['30rnd_65x39_caseless_khaki_mag_tracer',7,30],['NLAW_F',3,1]]],'h_helmetb_enh_tna_f','G_Lowprofile',['Binocular','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles_tna_F']]] select _tropical)],
	
	['rifleman_hat',([
	[['arifle_MX_F','','acc_flashlight','optic_Hamr',['30Rnd_65x39_caseless_mag_Tracer',30],[],''],['launch_B_Titan_short_F','','','',['Titan_AT',1],[],''],['hgun_Pistol_heavy_01_F','','acc_flashlight_pistol','optic_MRD',['11Rnd_45ACP_Mag',11],[],''],['u_b_combatuniform_mcam_tshirt',[['FirstAidKit',2],['11Rnd_45ACP_Mag',3,11]]],['V_PlateCarrier2_blk',[['FirstAidKit',2],['MineDetector',1],['SmokeShell',2,1],['HandGrenade',2,1],['30Rnd_65x39_caseless_mag_Tracer',7,30]]],['b_carryall_mcamo',[['Titan_AT',3,1]]],'H_HelmetSpecB','G_Lowprofile',['Binocular','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles']],		
	[['arifle_MX_khk_F','','acc_flashlight','optic_Hamr_khk_F',['30rnd_65x39_caseless_khaki_mag_tracer',30],[],''],['launch_B_Titan_short_tna_F','','','',['Titan_AT',1],[],''],['hgun_Pistol_heavy_01_green_F','','acc_flashlight_pistol','optic_MRD',['11Rnd_45ACP_Mag',11],[],''],['U_B_T_Soldier_F',[['FirstAidKit',2],['11Rnd_45ACP_Mag',3,11]]],['V_PlateCarrier2_blk',[['FirstAidKit',2],['MineDetector',1],['SmokeShell',2,1],['HandGrenade',2,1],['30rnd_65x39_caseless_khaki_mag_tracer',7,30]]],['B_Kitbag_rgr',[['Titan_AT',3,1]]],'h_helmetb_enh_tna_f','G_Lowprofile',['Binocular','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles_tna_F']]] select _tropical)],
	
	['medic',([
	[['arifle_MX_F','','acc_flashlight','optic_Holosight',['30Rnd_65x39_caseless_mag_Tracer',30],[],''],[],['hgun_Pistol_heavy_01_F','','acc_flashlight_pistol','optic_MRD',['11Rnd_45ACP_Mag',11],[],''],['u_b_combatuniform_mcam_tshirt',[['FirstAidKit',2],['11Rnd_45ACP_Mag',3,11]]],['V_PlateCarrier2_blk',[['MineDetector',1],['SmokeShell',20,1],['HandGrenade',2,1]]],['b_carryall_mcamo',[['Medikit',1],['FirstAidKit',20],['30Rnd_65x39_caseless_mag_Tracer',7,30]]],'H_HelmetSpecB','G_Lowprofile',['Binocular','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles']],		
	[['arifle_MX_khk_F','','acc_flashlight','optic_Holosight_khk_F',['30rnd_65x39_caseless_khaki_mag_tracer',30],[],''],[],['hgun_Pistol_heavy_01_green_F','','acc_flashlight_pistol','optic_MRD',['11Rnd_45ACP_Mag',11],[],''],['U_B_T_Soldier_F',[['FirstAidKit',2],['11Rnd_45ACP_Mag',3,11]]],['V_PlateCarrier2_blk',[['MineDetector',1],['SmokeShell',20,1],['HandGrenade',2,1]]],['b_carryall_oli',[['Medikit',1],['FirstAidKit',20],['30rnd_65x39_caseless_khaki_mag_tracer',7,30]]],'h_helmetb_enh_tna_f','G_Lowprofile',['Binocular','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles_tna_F']]] select _tropical)],
	
	['engineer',([
	[['arifle_MX_F','','acc_flashlight','optic_Hamr',['30Rnd_65x39_caseless_mag_Tracer',30],[],''],[],['hgun_Pistol_heavy_01_F','','acc_flashlight_pistol','optic_MRD',['11Rnd_45ACP_Mag',11],[],''],['u_b_combatuniform_mcam_tshirt',[['FirstAidKit',2],['11Rnd_45ACP_Mag',3,11]]],['V_PlateCarrier2_blk',[['FirstAidKit',10],['MineDetector',1],['SmokeShell',2,1],['HandGrenade',2,1]]],['b_carryall_mcamo',[['satchelcharge_remote_mag',1,1],['ToolKit',1],['30Rnd_65x39_caseless_mag_Tracer',7,30]]],'H_HelmetSpecB','G_Lowprofile',['Binocular','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles']],
	[['arifle_MX_khk_F','','acc_flashlight','optic_Hamr_khk_F',['30rnd_65x39_caseless_khaki_mag_tracer',30],[],''],[],['hgun_Pistol_heavy_01_green_F','','acc_flashlight_pistol','optic_MRD',['11Rnd_45ACP_Mag',11],[],''],['U_B_T_Soldier_F',[['FirstAidKit',2],['11Rnd_45ACP_Mag',3,11]]],['V_PlateCarrier2_blk',[['FirstAidKit',10],['MineDetector',1],['SmokeShell',2,1],['HandGrenade',2,1]]],['b_carryall_oli',[['satchelcharge_remote_mag',1,1],['ToolKit',1],['30rnd_65x39_caseless_khaki_mag_tracer',7,30]]],'H_HelmetB_Enh_tna_F','G_Lowprofile',['Binocular','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles_tna_F']]] select _tropical)],
	/*
	['crewman',([
	[['arifle_MXC_F','','acc_flashlight','optic_Hamr',['30Rnd_65x39_caseless_mag_Tracer',30],[],''],[],['hgun_Pistol_heavy_01_F','','acc_flashlight_pistol','optic_MRD',['11Rnd_45ACP_Mag',11],[],''],['u_b_combatuniform_mcam_tshirt',[['FirstAidKit',2],['11Rnd_45ACP_Mag',3,11]]],['V_PlateCarrier2_blk',[['FirstAidKit',10],['MineDetector',1],['SmokeShell',2,1],['HandGrenade',2,1]]],['b_carryall_mcamo',[['30Rnd_65x39_caseless_mag_Tracer',7,30]]],'H_HelmetCrew_B','G_Lowprofile',['Binocular','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles']],		
	[['arifle_MXC_khk_F','','acc_flashlight','optic_Hamr',['30Rnd_65x39_caseless_khaki_mag_Tracer',30],[],''],[],['hgun_Pistol_heavy_01_green_F','','acc_flashlight_pistol','optic_MRD',['11Rnd_45ACP_Mag',11],[],''],['U_B_T_Soldier_F',[['FirstAidKit',2],['11Rnd_45ACP_Mag',3,11]]],['V_PlateCarrier2_blk',[['FirstAidKit',10],['MineDetector',1],['SmokeShell',2,1],['HandGrenade',2,1]]],['b_carryall_oli',[['30rnd_65x39_caseless_khaki_mag_tracer',7,30]]],'H_HelmetCrew_B','G_Lowprofile',['Binocular','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles_tna_F']]] select _tropical)],
	*/
	['mortar_gunner',([
	[['arifle_MX_F','','acc_flashlight','optic_Hamr',['30Rnd_65x39_caseless_mag_Tracer',30],[],''],[],['hgun_Pistol_heavy_01_F','','acc_flashlight_pistol','optic_MRD',['11Rnd_45ACP_Mag',11],[],''],['U_B_CombatUniform_mcam_tshirt',[['FirstAidKit',2],['11Rnd_45ACP_Mag',3,11]]],['V_PlateCarrier2_blk',[['FirstAidKit',10],['SmokeShell',2,1],['HandGrenade',2,1],['MineDetector',1]]],['b_carryall_mcamo',[['30Rnd_65x39_caseless_mag_Tracer',7,30]]],'h_helmetcrew_b','G_Lowprofile',['Rangefinder','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles']],		
	[['arifle_MX_khk_F','','acc_flashlight','optic_Hamr_khk_F',['30rnd_65x39_caseless_khaki_mag_tracer',30],[],''],[],['hgun_Pistol_heavy_01_green_F','','acc_flashlight_pistol','optic_MRD',['11Rnd_45ACP_Mag',11],[],''],['U_B_T_Soldier_AR_F',[['FirstAidKit',2],['11Rnd_45ACP_Mag',3,11]]],['V_PlateCarrier2_blk',[['FirstAidKit',10],['SmokeShell',2,1],['HandGrenade',2,1],['MineDetector',1]]],['b_carryall_oli',[['30rnd_65x39_caseless_khaki_mag_tracer',7,30]]],'h_helmetcrew_b','G_Lowprofile',['Rangefinder','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles_tna_F']]] select _tropical)],
	
	['sniper',([
	[['srifle_LRR_camo_F','','','optic_tws_mg',['7Rnd_408_Mag',7],[],''],[],['hgun_Pistol_heavy_01_F','','acc_flashlight_pistol','optic_MRD',['11Rnd_45ACP_Mag',11],[],''],['U_B_FullGhillie_ard',[['FirstAidKit',2],['11Rnd_45ACP_Mag',3,11]]],['V_PlateCarrier2_blk',[['MineDetector',1],['HandGrenade',3,1],['SmokeShell',5,1],['APERSTripMine_Wire_Mag',3,1]]],['b_carryall_mcamo',[['FirstAidKit',10],['7Rnd_408_Mag',15,7]]],'h_cap_headphones','G_Bandanna_tan',['Laserdesignator','','','',['Laserbatteries',1],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','nvgogglesb_gry_f']],
	[['srifle_LRR_tna_F','','','optic_tws_mg_tna_F',['7Rnd_408_Mag',7],[],''],[],['hgun_Pistol_heavy_01_green_F','','acc_flashlight_pistol','optic_MRD',['11Rnd_45ACP_Mag',11],[],''],['U_B_T_FullGhillie_tna_F',[['FirstAidKit',2],['11Rnd_45ACP_Mag',3,11]]],['V_PlateCarrier2_blk',[['MineDetector',1],['HandGrenade',3,1],['SmokeShell',5,1],['APERSTripMine_Wire_Mag',3,1]]],['b_carryall_mcamo',[['FirstAidKit',10],['7Rnd_408_Mag',15,7]]],'h_cap_headphones','G_Bandanna_oli',['Laserdesignator','','','',['Laserbatteries',1],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','nvgogglesb_grn_f']]] select _tropical)],
	/*
	['spotter',([
	[['arifle_MX_F','muzzle_snds_65_TI_hex_F','acc_flashlight','optic_Hamr',['30Rnd_65x39_caseless_mag_Tracer',30],[],'bipod_01_F_snd'],[],['hgun_Pistol_heavy_01_F','','acc_flashlight_pistol','optic_MRD',['11Rnd_45ACP_Mag',11],[],''],['U_B_FullGhillie_ard',[['FirstAidKit',2],['11Rnd_45ACP_Mag',3,11]]],['V_PlateCarrier2_blk',[['MineDetector',1],['HandGrenade',3,1],['SmokeShell',5,1],['APERSTripMine_Wire_Mag',3,1]]],['b_carryall_mcamo',[['FirstAidKit',10],['30Rnd_65x39_caseless_mag_Tracer',7,30]]],'h_cap_headphones','G_Bandanna_tan',['Rangefinder','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','nvgogglesb_gry_f']],
	[['arifle_MX_khk_F','muzzle_snds_65_TI_ghex_F','acc_flashlight','optic_Hamr_khk_F',['30rnd_65x39_caseless_khaki_mag_tracer',30],[],'bipod_01_F_khk'],[],['hgun_Pistol_heavy_01_green_F','','acc_flashlight_pistol','optic_MRD',['11Rnd_45ACP_Mag',11],[],''],['U_B_T_FullGhillie_tna_F',[['FirstAidKit',2],['11Rnd_45ACP_Mag',3,11]]],['V_PlateCarrier2_blk',[['MineDetector',1],['HandGrenade',3,1],['SmokeShell',5,1],['APERSTripMine_Wire_Mag',3,1]]],['b_carryall_oli',[['FirstAidKit',10],['30rnd_65x39_caseless_khaki_mag_tracer',7,30]]],'h_cap_headphones','G_Bandanna_oli',['Rangefinder','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','nvgogglesb_grn_f']]] select _tropical)],
	
	['sat',([
	[['arifle_SDAR_F','','','',['20Rnd_556x45_UW_mag',20],[],''],[],['hgun_Pistol_heavy_01_F','','acc_flashlight_pistol','optic_MRD',['11Rnd_45ACP_Mag',11],[],''],['U_B_Wetsuit',[['11Rnd_45ACP_Mag',3,11],['20Rnd_556x45_UW_mag',5,20],['MineDetector',1]]],['V_RebreatherB',[['']]],['B_Assault_Diver',[['MiniGrenade',3,1],['FirstAidKit',10],['20Rnd_556x45_UW_mag',10,20]]],'','G_B_Diving',['Binocular','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles_OPFOR']],		
	[['arifle_SDAR_F','','','',['20Rnd_556x45_UW_mag',20],[],''],[],['hgun_Pistol_heavy_01_F','','acc_flashlight_pistol','optic_MRD',['11Rnd_45ACP_Mag',11],[],''],['U_B_Wetsuit',[['11Rnd_45ACP_Mag',2,11],['20Rnd_556x45_UW_mag',5,20],['MineDetector',1]]],['V_RebreatherB'],['B_Assault_Diver',[['MiniGrenade',3,1],['FirstAidKit',10],['20Rnd_556x45_UW_mag',10,20]]],'','G_B_Diving',['Binocular','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles_OPFOR']]] select _tropical)],
	
	['leader',([
	[['arifle_MX_GL_F','muzzle_snds_65_ti_hex_f','acc_pointer_IR','optic_Hamr',['30Rnd_65x39_caseless_mag_Tracer',30],['3Rnd_HE_Grenade_shell',1],''],[],['hgun_Pistol_heavy_01_F','','acc_flashlight_pistol','optic_MRD',['11Rnd_45ACP_Mag',11],[],''],['u_b_combatuniform_mcam_tshirt',[['FirstAidKit',2],['11Rnd_45ACP_Mag',3,11]]],['V_PlateCarrier2_blk',[['SmokeShell',2,1],['HandGrenade',2,1],['30Rnd_65x39_caseless_mag_Tracer',7,30],['Laserbatteries',1,1],['MineDetector',1]]],['b_carryall_mcamo',[['FirstAidKit',6],['3Rnd_HE_Grenade_shell',5,1],['satchelcharge_remote_mag',2,1]]],'H_HelmetSpecB','G_Lowprofile',['Laserdesignator','','','',['Laserbatteries',1],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles']],		
	[['arifle_MX_GL_khk_F','muzzle_snds_65_ti_ghex_f','acc_pointer_IR','optic_Hamr_khk_F',['30rnd_65x39_caseless_khaki_mag_tracer',30],['3Rnd_HE_Grenade_shell',1],''],[],['hgun_Pistol_heavy_01_green_F','','acc_flashlight_pistol','optic_MRD',['11Rnd_45ACP_Mag',11],[],''],['U_B_T_Soldier_F',[['FirstAidKit',2],['11Rnd_45ACP_Mag',3,11]]],['V_PlateCarrier2_blk',[['SmokeShell',2,1],['HandGrenade',2,1],['16Rnd_9x21_Mag',1,16],['30rnd_65x39_caseless_khaki_mag_tracer',7,30],['Laserbatteries',1,1],['MineDetector',1]]],['b_carryall_oli',[['FirstAidKit',6],['3Rnd_HE_Grenade_shell',5,1],['satchelcharge_remote_mag',2,1]]],'h_helmetb_enh_tna_f','G_Lowprofile',['Laserdesignator_01_khk_F','','','',['Laserbatteries',1],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles_tna_F']]] select _tropical)],
	*/
	['jtac',([
	[['arifle_MX_GL_F','muzzle_snds_65_ti_hex_f','acc_pointer_IR','optic_Hamr',['30Rnd_65x39_caseless_mag_Tracer',30],['3Rnd_HE_Grenade_shell',1],''],[],['hgun_Pistol_heavy_01_F','','acc_flashlight_pistol','optic_MRD',['11Rnd_45ACP_Mag',11],[],''],['u_b_combatuniform_mcam_tshirt',[['11Rnd_45ACP_Mag',3,11]]],['V_PlateCarrier2_blk',[['SmokeShell',2,1],['HandGrenade',2,1],['30Rnd_65x39_caseless_mag_Tracer',7,30],['Laserbatteries',1,1],['MineDetector',1]]],['b_carryall_mcamo',[['FirstAidKit',6],['3Rnd_HE_Grenade_shell',5,1],['satchelcharge_remote_mag',2,1]]],'H_HelmetSpecB','G_Lowprofile',['Laserdesignator','','','',['Laserbatteries',1],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles']],		
	[['arifle_MX_GL_khk_F','muzzle_snds_65_ti_ghex_f','acc_pointer_IR','optic_Hamr_khk_F',['30rnd_65x39_caseless_khaki_mag_tracer',30],['3Rnd_HE_Grenade_shell',1],''],[],['hgun_Pistol_heavy_01_green_F','','acc_flashlight_pistol','optic_MRD',['11Rnd_45ACP_Mag',11],[],''],['U_B_T_Soldier_F',[['FirstAidKit',2],['11Rnd_45ACP_Mag',3,11]]],['V_PlateCarrier2_blk',[['SmokeShell',2,1],['HandGrenade',2,1],['16Rnd_9x21_Mag',1,16],['30rnd_65x39_caseless_khaki_mag_tracer',7,30],['Laserbatteries',1,1],['MineDetector',1]]],['b_carryall_oli',[['FirstAidKit',6],['3Rnd_HE_Grenade_shell',5,1],['satchelcharge_remote_mag',2,1]]],'h_helmetb_enh_tna_f','G_Lowprofile',['Laserdesignator_01_khk_F','','','',['Laserbatteries',1],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles_tna_F']]] select _tropical)],
	
	['uav',([
	[['arifle_MXC_F','','acc_flashlight','optic_Hamr',['30Rnd_65x39_caseless_mag_Tracer',30],[],''],[],['hgun_Pistol_heavy_01_F','','acc_flashlight_pistol','optic_MRD',['11Rnd_45ACP_Mag',11],[],''],['u_b_combatuniform_mcam_tshirt',[['FirstAidKit',2],['11Rnd_45ACP_Mag',3,11],[]]],['V_PlateCarrier2_blk',[['30Rnd_65x39_caseless_mag_Tracer',7,30],['SmokeShell',2,1],['HandGrenade',2,1]]],['B_UAV_01_backpack_F',[[]]],'h_cap_headphones','G_Lowprofile',['Binocular','','','',[],[],''],['ItemMap','B_UavTerminal','ItemRadio','ItemCompass','ItemWatch','NVGoggles']],		
	[['arifle_MXC_khk_F','','acc_flashlight','optic_Hamr_khk_F',['30rnd_65x39_caseless_khaki_mag_tracer',30],[],''],[],['hgun_Pistol_heavy_01_green_F','','acc_flashlight_pistol','optic_MRD',['11Rnd_45ACP_Mag',11],[],''],['U_B_T_Soldier_F',[['FirstAidKit',2],['11Rnd_45ACP_Mag',3,11]]],['V_PlateCarrier2_blk',[['SmokeShell',2,1],['HandGrenade',2,1],['30rnd_65x39_caseless_khaki_mag_tracer',7,30]]],['B_UAV_01_backpack_F',[[]]],'h_cap_headphones','G_Lowprofile',['Binocular','','','',[],[],''],['ItemMap','B_UavTerminal','ItemRadio','ItemCompass','ItemWatch','NVGoggles_tna_F']]] select _tropical)],
	
	['pilot_heli',([
	[['arifle_MXC_Black_F','','acc_flashlight','optic_Aco',['30Rnd_65x39_caseless_black_mag',30],[],''],[],['hgun_Pistol_heavy_01_F','','acc_flashlight_pistol','optic_MRD',['11Rnd_45ACP_Mag',11],[],''],['U_B_HeliPilotCoveralls',[['30Rnd_65x39_caseless_black_mag',4,30]]],['V_PlateCarrier2_blk',[['11Rnd_45ACP_Mag',3,11],['DemoCharge_Remote_Mag',2,1],['FirstAidKit',3],['SmokeShell',2,1],['SmokeShellGreen',2,1]]],[],'H_PilotHelmetHeli_B','G_Aviator',['Binocular','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles_OPFOR']],		
	[['arifle_MXC_Black_F','','acc_flashlight','optic_Aco',['30Rnd_65x39_caseless_black_mag',30],[],''],[],['hgun_Pistol_heavy_01_F','','acc_flashlight_pistol','optic_MRD',['11Rnd_45ACP_Mag',11],[],''],['U_B_HeliPilotCoveralls',[['30Rnd_65x39_caseless_black_mag',4,30]]],['V_PlateCarrier2_blk',[['11Rnd_45ACP_Mag',3,11],['DemoCharge_Remote_Mag',2,1],['FirstAidKit',3],['SmokeShell',2,1],['SmokeShellGreen',2,1]]],[],'H_PilotHelmetHeli_B','G_Aviator',['Binocular','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles_OPFOR']]] select _tropical)],
	/*
	['pilot_cas',([
	[['arifle_MXC_Black_F','','acc_flashlight','optic_Aco',['30Rnd_65x39_caseless_black_mag',30],[],''],[],['hgun_Pistol_heavy_01_F','','acc_flashlight_pistol','optic_MRD',['11Rnd_45ACP_Mag',11],[],''],['U_B_HeliPilotCoveralls',[['30Rnd_65x39_caseless_black_mag',4,30]]],['V_PlateCarrier2_blk',[['11Rnd_45ACP_Mag',3,11],['DemoCharge_Remote_Mag',2,1],['FirstAidKit',3],['SmokeShell',2,1],['SmokeShellGreen',2,1]]],[],'H_PilotHelmetHeli_B','G_Aviator',['Binocular','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles_OPFOR']],		
	[['arifle_MXC_Black_F','','acc_flashlight','optic_Aco',['30Rnd_65x39_caseless_black_mag',30],[],''],[],['hgun_Pistol_heavy_01_F','','acc_flashlight_pistol','optic_MRD',['11Rnd_45ACP_Mag',11],[],''],['U_B_HeliPilotCoveralls',[['30Rnd_65x39_caseless_black_mag',4,30]]],['V_PlateCarrier2_blk',[['11Rnd_45ACP_Mag',3,11],['DemoCharge_Remote_Mag',2,1],['FirstAidKit',3],['SmokeShell',2,1],['SmokeShellGreen',2,1]]],[],'H_PilotHelmetHeli_B','G_Aviator',['Binocular','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles_OPFOR']]] select _tropical)],
	*/
	['pilot_plane',([
	[['arifle_MXC_Black_F','','acc_flashlight','optic_Aco',['30Rnd_65x39_caseless_black_mag',30],[],''],[],['hgun_Pistol_heavy_01_F','','acc_flashlight_pistol','optic_MRD',['11Rnd_45ACP_Mag',11],[],''],['U_B_PilotCoveralls',[['30Rnd_65x39_caseless_black_mag',4,30]]],['V_PlateCarrier2_blk',[['11Rnd_45ACP_Mag',3,11],['DemoCharge_Remote_Mag',2,1],['FirstAidKit',3],['SmokeShell',2,1],['SmokeShellGreen',2,1]]],[],'H_PilotHelmetFighter_B','G_Aviator',['Binocular','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','']],		
	[['arifle_MXC_Black_F','','acc_flashlight','optic_Aco',['30Rnd_65x39_caseless_black_mag',30],[],''],[],['hgun_Pistol_heavy_01_F','','acc_flashlight_pistol','optic_MRD',['11Rnd_45ACP_Mag',11],[],''],['U_B_PilotCoveralls',[['30Rnd_65x39_caseless_black_mag',4,30]]],['V_PlateCarrier2_blk',[['11Rnd_45ACP_Mag',3,11],['DemoCharge_Remote_Mag',2,1],['FirstAidKit',3],['SmokeShell',2,1],['SmokeShellGreen',2,1]]],[],'H_PilotHelmetFighter_B','G_Aviator',['Binocular','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','']]] select _tropical)],
	
	['commander',([
	[[],[],['hgun_Pistol_heavy_02_F','','','optic_Yorris',['6Rnd_45ACP_Cylinder',6],[],''],['u_b_combatuniform_mcam_tshirt',[['FirstAidKit',1],['6Rnd_45ACP_Cylinder',4,6]]],['V_PlateCarrier2_blk',[['6Rnd_45ACP_Cylinder',4,6],['DemoCharge_Remote_Mag',2,1],['FirstAidKit',3],['SmokeShell',2,1],['SmokeShellGreen',2,1]]],['b_radiobag_01_mtp_f',[['']]],'H_MilCap_mcamo','G_Aviator',['Rangefinder','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles']],		
	[[],[],['hgun_Pistol_heavy_02_F','','','optic_Yorris',['6Rnd_45ACP_Cylinder',6],[],''],['U_B_T_Soldier_F',[['FirstAidKit',1],['6Rnd_45ACP_Cylinder',4,6]]],['V_PlateCarrier2_blk',[['6Rnd_45ACP_Cylinder',4,6],['DemoCharge_Remote_Mag',2,1],['FirstAidKit',3],['SmokeShell',2,1],['SmokeShellGreen',2,1]]],['b_radiobag_01_tropic_f',[['']]],'H_MilCap_tna_F','G_Aviator',['Rangefinder','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles_tna_F']]] select _tropical)],
	
	['o_rifleman',([
	[['arifle_AK12_arid_F','','acc_pointer_IR','optic_ERCO_blk_F',['30Rnd_762x39_AK12_Arid_Mag_Tracer_F',30],[],''],[],['hgun_Rook40_F','','acc_flashlight_pistol','optic_MRD',['11Rnd_45ACP_Mag',11],[],''],['U_O_CombatUniform_ocamo',[['FirstAidKit',2],['11Rnd_45ACP_Mag',3,11]]],['V_PlateCarrier2_rgr',[['MiniGrenade',2,1],['SmokeShell',2,1],['MineDetector',1]]],['b_carryall_ocamo',[['30Rnd_762x39_AK12_Arid_Mag_Tracer_F',11,30],['FirstAidKit',6]]],'H_HelmetSpecO_blk','G_Bandanna_blk',['Binocular','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles_OPFOR']], 
	[['arifle_AK12_lush_F','','acc_pointer_IR','optic_ERCO_khk_F',['30Rnd_762x39_AK12_Lush_Mag_Tracer_F',30],[],''],[],['hgun_Rook40_F','','acc_flashlight_pistol','optic_MRD',['11Rnd_45ACP_Mag',11],[],''],['U_O_T_Soldier_F',[['FirstAidKit',2],['11Rnd_45ACP_Mag',3,11]]],['V_PlateCarrier2_tna_F',[['MiniGrenade',2,1],['SmokeShell',2,1],['MineDetector',1]]],['b_carryall_ghex_F',[['30Rnd_762x39_AK12_Lush_Mag_Tracer_F',11,30],['FirstAidKit',6]]],'H_HelmetSpecO_blk','G_Bandanna_oli',['Binocular','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles_OPFOR']]] select _tropical)],
	
	['o_autorifleman',([
	[['LMG_03_F','','acc_pointer_IR','optic_ERCO_blk_F',['200Rnd_556x45_Box_Tracer_F',200],[],'bipod_02_F_blk'],[],['hgun_Rook40_F','','acc_flashlight_pistol','optic_MRD',['11Rnd_45ACP_Mag',11],[],''],['U_O_CombatUniform_ocamo',[['FirstAidKit',2],['11Rnd_45ACP_Mag',3,11]]],['V_PlateCarrier2_rgr',[['MiniGrenade',2,1],['SmokeShell',2,1],['200Rnd_556x45_Box_Tracer_F',2,200],['MineDetector',1]]],['b_carryall_ocamo',[['200Rnd_556x45_Box_Tracer_F',5,200]]],'H_HelmetSpecO_blk','G_Bandanna_oli',['Binocular','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles_OPFOR']],		
	[['LMG_03_F','','acc_pointer_IR','optic_ERCO_blk_F',['200Rnd_556x45_Box_Tracer_F',200],[],''],[],['hgun_Rook40_F','','acc_flashlight_pistol','optic_MRD',['11Rnd_45ACP_Mag',11],[],''],['U_O_T_Soldier_F',[['FirstAidKit',2],['11Rnd_45ACP_Mag',3,11]]],['V_PlateCarrier2_tna_F',[['MiniGrenade',2,1],['SmokeShell',2,1],['200Rnd_556x45_Box_Tracer_F',2,200],['MineDetector',1]]],['b_carryall_ghex_F',[['200Rnd_556x45_Box_Tracer_F',5,200]]],'H_HelmetSpecO_blk','G_Bandanna_oli',['Binocular','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles_OPFOR']]] select _tropical)],
	
	['medic_WL',([
	[['arifle_MX_F','','acc_flashlight','optic_Holosight',['30Rnd_65x39_caseless_mag_Tracer',30],[],''],[],['hgun_Pistol_heavy_01_F','','acc_flashlight_pistol','optic_MRD',['11Rnd_45ACP_Mag',11],[],''],['u_b_combatuniform_mcam_tshirt',[['FirstAidKit',2],['11Rnd_45ACP_Mag',3,11]]],['V_PlateCarrier2_blk',[['MineDetector',1],['SmokeShell',20,1],['HandGrenade',2,1]]],['b_carryall_mcamo',[['Medikit',1],['FirstAidKit',20],['30Rnd_65x39_caseless_mag_Tracer',7,30]]],'H_HelmetSpecB','G_Lowprofile',['Binocular','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles']],		
	[['arifle_MX_khk_F','','acc_flashlight','optic_Holosight_khk_F',['30rnd_65x39_caseless_khaki_mag_tracer',30],[],''],[],['hgun_Pistol_heavy_01_green_F','','acc_flashlight_pistol','optic_MRD',['11Rnd_45ACP_Mag',11],[],''],['U_B_T_Soldier_F',[['FirstAidKit',2],['11Rnd_45ACP_Mag',3,11]]],['V_PlateCarrier2_blk',[['MineDetector',1],['SmokeShell',20,1],['HandGrenade',2,1]]],['b_carryall_oli',[['Medikit',1],['FirstAidKit',20],['30rnd_65x39_caseless_khaki_mag_tracer',7,30]]],'h_helmetb_enh_tna_f','G_Lowprofile',['Binocular','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles_tna_F']]] select _tropical)],
	
	['machine_gunner_WL',([
	[['MMG_02_sand_F','','acc_flashlight','optic_Hamr',['130Rnd_338_Mag',130],[],'bipod_01_F_snd'],[],['hgun_Pistol_heavy_01_F','','acc_flashlight_pistol','optic_MRD',['11Rnd_45ACP_Mag',11],[],''],['U_B_CombatUniform_mcam_tshirt',[['FirstAidKit',2],['11Rnd_45ACP_Mag',3,11]]],['V_PlateCarrier2_blk',[['FirstAidKit',10],['MineDetector',1],['SmokeShell',2,1],['HandGrenade',2,1]]],['b_carryall_mcamo',[['130Rnd_338_Mag',5,130]]],'H_HelmetSpecB','G_Lowprofile',['Binocular','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles']],		
	[['MMG_02_black_F','','acc_flashlight','optic_Hamr',['130Rnd_338_Mag',130],[],'bipod_01_F_blk'],[],['hgun_Pistol_heavy_01_green_F','','acc_flashlight_pistol','optic_MRD',['11Rnd_45ACP_Mag',11],[],''],['U_B_T_Soldier_AR_F',[['FirstAidKit',2],['11Rnd_45ACP_Mag',3,11]]],['V_PlateCarrier2_blk',[['FirstAidKit',10],['MineDetector',1],['SmokeShell',2,1],['HandGrenade',2,1]]],['b_carryall_oli',[['130Rnd_338_Mag',5,130]]],'h_helmetb_enh_tna_f','G_Lowprofile',['Binocular','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles_tna_F']]] select _tropical)],
	
	['sniper_WL',([
	[['srifle_LRR_camo_F','','','optic_tws_mg',['7Rnd_408_Mag',7],[],''],[],['hgun_Pistol_heavy_01_F','','acc_flashlight_pistol','optic_MRD',['11Rnd_45ACP_Mag',11],[],''],['U_B_FullGhillie_ard',[['FirstAidKit',2],['11Rnd_45ACP_Mag',3,11]]],['V_PlateCarrier2_blk',[['MineDetector',1],['HandGrenade',3,1],['SmokeShell',5,1],['APERSTripMine_Wire_Mag',3,1]]],['b_carryall_mcamo',[['FirstAidKit',10],['7Rnd_408_Mag',15,7]]],'h_cap_headphones','G_Bandanna_tan',['Laserdesignator','','','',['Laserbatteries',1],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','nvgogglesb_gry_f']],
	[['srifle_LRR_tna_F','','','optic_tws_mg_tna_F',['7Rnd_408_Mag',7],[],''],[],['hgun_Pistol_heavy_01_green_F','','acc_flashlight_pistol','optic_MRD',['11Rnd_45ACP_Mag',11],[],''],['U_B_T_FullGhillie_tna_F',[['FirstAidKit',2],['11Rnd_45ACP_Mag',3,11]]],['V_PlateCarrier2_blk',[['MineDetector',1],['HandGrenade',3,1],['SmokeShell',5,1],['APERSTripMine_Wire_Mag',3,1]]],['b_carryall_mcamo',[['FirstAidKit',10],['7Rnd_408_Mag',15,7]]],'h_cap_headphones','G_Bandanna_oli',['Laserdesignator','','','',['Laserbatteries',1],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','nvgogglesb_grn_f']]] select _tropical)],
	
	['pilot_heli_WL',([
	[['arifle_MXC_Black_F','','acc_flashlight','optic_Aco',['30Rnd_65x39_caseless_black_mag',30],[],''],[],['hgun_Pistol_heavy_01_F','','acc_flashlight_pistol','optic_MRD',['11Rnd_45ACP_Mag',11],[],''],['U_B_HeliPilotCoveralls',[['30Rnd_65x39_caseless_black_mag',4,30]]],['V_PlateCarrier2_blk',[['11Rnd_45ACP_Mag',3,11],['DemoCharge_Remote_Mag',2,1],['FirstAidKit',3],['SmokeShell',2,1],['SmokeShellGreen',2,1]]],[],'H_PilotHelmetHeli_B','G_Aviator',['Binocular','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles_OPFOR']],		
	[['arifle_MXC_Black_F','','acc_flashlight','optic_Aco',['30Rnd_65x39_caseless_black_mag',30],[],''],[],['hgun_Pistol_heavy_01_F','','acc_flashlight_pistol','optic_MRD',['11Rnd_45ACP_Mag',11],[],''],['U_B_HeliPilotCoveralls',[['30Rnd_65x39_caseless_black_mag',4,30]]],['V_PlateCarrier2_blk',[['11Rnd_45ACP_Mag',3,11],['DemoCharge_Remote_Mag',2,1],['FirstAidKit',3],['SmokeShell',2,1],['SmokeShellGreen',2,1]]],[],'H_PilotHelmetHeli_B','G_Aviator',['Binocular','','','',[],[],''],['ItemMap','ItemGPS','ItemRadio','ItemCompass','ItemWatch','NVGoggles_OPFOR']]] select _tropical)]
];
QS_fnc_roleDescription = {
	params ['_role'];
	_tropical = worldName in ['Tanoa'];
	private _description = 'Undefined';
	if (_role in ['rifleman']) then {
		_description = format [localize 'STR_QS_Role_031',(['arid','tropic'] select (worldName in ['Tanoa'])),(uiNamespace getVariable ['QS_RSS_currentSelectedRole','rifleman'])];
	};
	if (_role in ['autorifleman','autorifleman_WL']) then {
		_description = format [localize 'STR_QS_Role_032',(['arid','tropic'] select (worldName in ['Tanoa'])),(uiNamespace getVariable ['QS_RSS_currentSelectedRole','rifleman'])];
	};
	if (_role in ['machine_gunner','machine_gunner_WL']) then {
		_description = format [localize 'STR_QS_Role_033',(['arid','tropic'] select (worldName in ['Tanoa'])),(uiNamespace getVariable ['QS_RSS_currentSelectedRole','rifleman'])];
	};
	if (_role in ['rifleman_lat','rifleman_lat_WL']) then {
		_description = format [localize 'STR_QS_Role_034',(['arid','tropic'] select (worldName in ['Tanoa'])),(uiNamespace getVariable ['QS_RSS_currentSelectedRole','rifleman'])];
	};
	if (_role in ['rifleman_hat','rifleman_hat_WL']) then {
		_description = format [localize 'STR_QS_Role_035',(['arid','tropic'] select (worldName in ['Tanoa'])),(uiNamespace getVariable ['QS_RSS_currentSelectedRole','rifleman'])];
	};
	if (_role in ['engineer','engineer_WL']) then {
		_description = format [localize 'STR_QS_Role_036',(['arid','tropic'] select (worldName in ['Tanoa'])),(uiNamespace getVariable ['QS_RSS_currentSelectedRole','rifleman'])];
	};
	if (_role in ['medic','medic_WL']) then {
		_description = format [localize 'STR_QS_Role_037',(['arid','tropic'] select (worldName in ['Tanoa'])),(uiNamespace getVariable ['QS_RSS_currentSelectedRole','rifleman'])];
	};
	if (_role in ['sniper','sniper_WL']) then {
		_description = format [localize 'STR_QS_Role_038',(['arid','tropic'] select _tropical),(uiNamespace getVariable ['QS_RSS_currentSelectedRole','rifleman'])];
	};
	/*if (_role in 'spotter') then {
		_description = format [localize 'STR_QS_Role_040',(['arid','tropic'] select _tropical),(uiNamespace getVariable ['QS_RSS_currentSelectedRole','rifleman'])];
	};*/
	if (_role in ['crewman']) then {
		_description = format [localize 'STR_QS_Role_041',(['arid','tropic'] select (worldName in ['Tanoa'])),(uiNamespace getVariable ['QS_RSS_currentSelectedRole','rifleman'])];
	};
	if (_role in ['jtac','jtac_WL']) then {
		_description = format [localize 'STR_QS_Role_042',(['arid','tropic'] select _tropical),(uiNamespace getVariable ['QS_RSS_currentSelectedRole','rifleman'])];
	};
	/*if (_role in ['sat']) then {
		_description = format [localize 'STR_QS_Role_044',(['arid','tropic'] select (worldName in ['Tanoa'])),(uiNamespace getVariable ['QS_RSS_currentSelectedRole','rifleman'])];
	};*/
	if (_role in ['mortar_gunner']) then {
		_description = format [localize 'STR_QS_Role_045',(['arid','tropic'] select _tropical),(uiNamespace getVariable ['QS_RSS_currentSelectedRole','rifleman'])];
	};
	if (_role in ['uav']) then {
		_description = format [localize 'STR_QS_Role_046',(['arid','tropic'] select _tropical),(uiNamespace getVariable ['QS_RSS_currentSelectedRole','rifleman'])];
	};
	if (_role in ['pilot_heli','pilot_heli_WL']) then {
		_description = format [localize 'STR_QS_Role_047',(['arid','tropic'] select _tropical),(uiNamespace getVariable ['QS_RSS_currentSelectedRole','rifleman'])];
	};
	/*if (_role in 'pilot_cas') then {
		_description = format [localize 'STR_QS_Role_049',(['arid','tropic'] select _tropical),(uiNamespace getVariable ['QS_RSS_currentSelectedRole','rifleman'])];
	};*/
	if (_role in ['pilot_plane']) then {
		_description = format [localize 'STR_QS_Role_050',(['arid','tropic'] select _tropical),(uiNamespace getVariable ['QS_RSS_currentSelectedRole','rifleman'])];
	};
	/*if (_role in 'leader') then {
		_description = format [localize 'STR_QS_Role_052',(['arid','tropic'] select (worldName in ['Tanoa'])),(uiNamespace getVariable ['QS_RSS_currentSelectedRole','rifleman'])];
	};*/
	if (_role in ['commander']) then {
		_description = format [localize 'STR_QS_Role_053',(['arid','tropic'] select _tropical),(uiNamespace getVariable ['QS_RSS_currentSelectedRole','rifleman'])];
	};
	if (_role in ['o_rifleman']) then {
		_description = format [localize 'STR_QS_Role_055',(['arid','tropic'] select (worldName in ['Tanoa'])),(uiNamespace getVariable ['QS_RSS_currentSelectedRole','rifleman'])];
	};
	if (_role in ['o_autorifleman']) then {
		_description = format [localize 'STR_QS_Role_057',(['arid','tropic'] select (worldName in ['Tanoa'])),(uiNamespace getVariable ['QS_RSS_currentSelectedRole','rifleman'])];
	};
	(parseText _description);
};