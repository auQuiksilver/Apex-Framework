/*/
File: QS_uniformTextures.sqf
Author:

	Quiksilver
	
Last modified:

	6/12/2017 A3 1.78 by Quiksilver
	
Description:

	Uniforms
	
Data structure:

	[0,'BDU','A3\characters_f\BLUFOR\Data\clothing_wdl_co.paa','NATO uniform skin',_validUniforms_1,'Bohemia Interactive','media\images\uskins\bdu\bdu.paa'],
		
	[ <just put number 0 here> , <ingame menu list title> , <folder path to texture file> , <mouse-hover toolip> , <valid uniform type classnames> , <author text> , <optional backpack texture> ]
	
__________________________________________________________________________/*/

_validUniforms_1 = [	
	'U_B_CombatUniform_mcam','U_B_CombatUniform_mcam_tshirt','U_B_CombatUniform_mcam_vest','U_B_CombatUniform_mcam_worn',
	'U_B_CombatUniform_sgg','U_B_CombatUniform_sgg_tshirt','U_B_CombatUniform_sgg_vest',
	'U_B_CombatUniform_wdl','U_B_CombatUniform_wdl_tshirt','U_B_CombatUniform_wdl_vest',
	'U_B_CTRG_1','U_B_CTRG_2','U_B_CTRG_3','U_B_T_Soldier_SL_F','U_B_T_Soldier_F'
];
_validUniform_2 = [
	'U_C_WorkerCoveralls','U_B_HeliPilotCoveralls'	/*/ coveralls/*/
];
_validUniform_3 = [
	'U_BG_Guerilla1_1'			/*/Guerilla garment/*/
];
_validUniform_4 = [
	'U_O_CombatUniform_ocamo','U_O_CombatUniform_oucamo','U_O_SpecopsUniform_ocamo','U_O_OfficerUniform_ocamo'		/*/ CSAT combat uniforms/*/
];
_validUniform_5 = [
	'U_I_CombatUniform','U_I_CombatUniform_shortsleeve'
];
private _return = [];
_return = [
	[0,'<Empty>','','',[''],''],
	[0,'BDU','A3\characters_f\BLUFOR\Data\clothing_wdl_co.paa','NATO uniform skin',_validUniforms_1,'Bohemia Interactive','media\images\uskins\bdu\bdu.paa'],
	[0,'Sage','A3\characters_f\BLUFOR\Data\clothing_sage_co.paa','NATO uniform skin',_validUniforms_1,'Bohemia Interactive'],
	[0,'Bandit','A3\characters_f\common\data\coveralls_bandit_co.paa','Helipilot/Worker coveralls skin',_validUniform_2,'Bohemia Interactive'],
	[0,'Black','A3\characters_f\common\data\coveralls_black_co.paa','Helipilot/Worker coveralls skin',_validUniform_2,'Bohemia Interactive'],
	[0,'Grey','A3\characters_f\common\data\coveralls_grey_co.paa','Helipilot/Worker coveralls skin',_validUniform_2,'Bohemia Interactive'],
	[0,'Urban','A3\characters_f\common\data\coveralls_urbancamo_co.paa','Helipilot/Worker coveralls skin',_validUniform_2,'Bohemia Interactive'],
	[0,'Wasp','A3\air_f\heli_light_01\data\skins\heli_light_01_ext_wasp_co.paa','Helipilot/Worker coveralls skin',_validUniform_2,'Bohemia Interactive'],
	[0,'Skull shirt','A3\characters_f_gamma\Civil\Data\c_cloth1_black.paa','Guerilla garment skin',_validUniform_3,'Bohemia Interactive'],
	[0,'Kabeiroi','A3\Characters_F\Civil\Data\c_cloth1_kabeiroi_co.paa','Guerilla garment skin',_validUniform_3,'Bohemia Interactive'],	
	[0,'Bandit (Red)','A3\Characters_F\Civil\Data\c_cloth1_bandit_co.paa','Guerilla garment skin',_validUniform_3,'Bohemia Interactive'],	
	[0,'Bandit (Brown)','\a3\characters_f_gamma\Civil\Data\c_cloth1_brown.paa','Guerilla garment skin',_validUniform_3,'Bohemia Interactive'],
	[0,'Bandit (Orange)','A3\Characters_F\Civil\Data\c_cloth1_v3_co.paa','Guerilla garment skin',_validUniform_3,'Bohemia Interactive'],
	[0,'Bandit (Yellow)','A3\Characters_F\Civil\Data\c_cloth1_v2_co.paa','Guerilla garment skin',_validUniform_3,'Bohemia Interactive'],
	[0,'Bandit (Blue)','A3\Characters_F\Civil\Data\c_cloth1_co.paa','Guerilla garment skin',_validUniform_3,'Bohemia Interactive'],
	[0,'Raven','A3\characters_f\OPFOR\Data\clothing_rus_co.paa','CSAT uniform skin',_validUniform_4,'Bohemia Interactive']
];
// Storage
/*/
_return = [
	[0,'<Empty>','','',[''],''],
	[0,'MARPAT','media\images\uskins\marpat\marpat.paa','NATO uniform skin',_validUniforms_1,'Aleksy (cportsmouth98@gmail.com)','media\images\uskins\marpat\marpatch.paa'],
	[0,'BDU','A3\characters_f\BLUFOR\Data\clothing_wdl_co.paa','NATO uniform skin',_validUniforms_1,'Bohemia Interactive','media\images\uskins\bdu\bdu.paa'],
	[0,'SOG','media\images\uskins\tiger\tigerstripe31.paa','NATO uniform skin',_validUniforms_1,'Archimedes','media\images\uskins\tiger\tspatch.paa'],
	[0,'Dirty','media\images\uskins\dirty\abua.paa','NATO uniform skin',_validUniforms_1,'SgtMaj (N/A)','media\images\uskins\dirty\abupatch.paa'],
	[0,'Dark','media\images\uskins\dark\up6.paa','NATO uniform skin',_validUniforms_1,'Skully (N/A)',''],
	[0,'Alfa','media\images\uskins\alfa\AAF_Alfa.paa','AAF uniform skin',_validUniform_5,'Lantern','media\images\uskins\alfa\AAF_Alfa.paa'],
	[0,'Alfa Wood','media\images\uskins\alfa_woodland\AAF_AlfaWoodland.paa','AAF uniform skin',_validUniform_5,'Lantern','media\images\uskins\alfa\AAF_AlfaWoodland.paa'],
	[0,'Kenyan','media\images\uskins\kenyan\AAF_Kenyan.paa','AAF uniform skin',_validUniform_5,'Lantern','media\images\uskins\kenyan\AAF_Kenyan.paa'],
	[0,'SFG','media\images\uskins\sfg\AAF_SFG.paa','AAF uniform skin',_validUniform_5,'Lantern','media\images\uskins\sfg\AAF_SFG.paa'],
	[0,'Sage','A3\characters_f\BLUFOR\Data\clothing_sage_co.paa','NATO uniform skin',_validUniforms_1,'Bohemia Interactive'],
	[0,'Bandit','A3\characters_f\common\data\coveralls_bandit_co.paa','Helipilot/Worker coveralls skin',_validUniform_2,'Bohemia Interactive'],
	[0,'Black','A3\characters_f\common\data\coveralls_black_co.paa','Helipilot/Worker coveralls skin',_validUniform_2,'Bohemia Interactive'],
	[0,'Grey','A3\characters_f\common\data\coveralls_grey_co.paa','Helipilot/Worker coveralls skin',_validUniform_2,'Bohemia Interactive'],
	[0,'Urban','A3\characters_f\common\data\coveralls_urbancamo_co.paa','Helipilot/Worker coveralls skin',_validUniform_2,'Bohemia Interactive'],
	[0,'Wasp','A3\air_f\heli_light_01\data\skins\heli_light_01_ext_wasp_co.paa','Helipilot/Worker coveralls skin',_validUniform_2,'Bohemia Interactive'],
	[0,'Skull shirt','A3\characters_f_gamma\Civil\Data\c_cloth1_black.paa','Guerilla garment skin',_validUniform_3,'Bohemia Interactive'],
	[0,'Kabeiroi','A3\Characters_F\Civil\Data\c_cloth1_kabeiroi_co.paa','Guerilla garment skin',_validUniform_3,'Bohemia Interactive'],	
	[0,'Bandit (Red)','A3\Characters_F\Civil\Data\c_cloth1_bandit_co.paa','Guerilla garment skin',_validUniform_3,'Bohemia Interactive'],	
	[0,'Bandit (Brown)','\a3\characters_f_gamma\Civil\Data\c_cloth1_brown.paa','Guerilla garment skin',_validUniform_3,'Bohemia Interactive'],
	[0,'Bandit (Orange)','A3\Characters_F\Civil\Data\c_cloth1_v3_co.paa','Guerilla garment skin',_validUniform_3,'Bohemia Interactive'],
	[0,'Bandit (Yellow)','A3\Characters_F\Civil\Data\c_cloth1_v2_co.paa','Guerilla garment skin',_validUniform_3,'Bohemia Interactive'],
	[0,'Bandit (Blue)','A3\Characters_F\Civil\Data\c_cloth1_co.paa','Guerilla garment skin',_validUniform_3,'Bohemia Interactive'],
	[0,'Raven','A3\characters_f\OPFOR\Data\clothing_rus_co.paa','CSAT uniform skin',_validUniform_4,'Bohemia Interactive']
];
/*/
_return;