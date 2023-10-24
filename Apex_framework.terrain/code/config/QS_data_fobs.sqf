/*/
File: QS_data_fobs.sqf
Author:

	Quiksilver
	
Last modified:

	30/05/2019 A3 1.94 by Quiksilver
	
Description:

	FOB Data
	
Note on FOB construction:

	If using this method, FOB requires a flag
	
		["FlagPole_F","a3\structures_f\mil\flags\mast_f.p3d",[11847.2,22330.3,20.3864],[[0,1,0],[0,0,1]],0,1,0,[],{
			missionNamespace setVariable ['QS_module_fob_flag',(_this # 0),TRUE];
		}],
		
	And it needs to have this in the init box:
	
		missionNamespace setVariable ['QS_module_fob_flag',(_this # 0),TRUE];
		
	This is required for the FOB deployment/respawn
___________________________________________________/*/

params ['_type'];
_worldName = worldName;
if (_worldName isEqualTo 'Altis') exitWith {
	private _return = [];
	if (_type isEqualTo 0) then {
		/* Central */
		_return = [
			[11833.8,22322],
			[
				["FlagPole_F","a3\structures_f\mil\flags\mast_f.p3d",[11847.2,22330.3,20.3864],[[0,1,0],[0,0,1]],0,1,0,[],{
					missionNamespace setVariable ['QS_module_fob_flag',(_this # 0),TRUE];
					(_this # 0) addEventHandler [
						'Deleted',
						{
							params ['_entity'];
							missionNamespace setVariable ['QS_module_fob_respawnTickets',(round (((_entity getVariable ['QS_deploy_tickets',0]) / 2) max 0)),FALSE];
						}
					];
				}],
				["Land_RepairDepot_01_tan_F","a3\structures_f_tank\military\repairdepot\repairdepot_01_tan_f.p3d",[11854.2,22299.6,19.4647],[[0.000170507,0.999986,-0.00525156],[-0.0293479,0.0052543,0.999556]],0,0,2,[],{
					missionNamespace setVariable ['QS_module_fob_repairDepot',(_this # 0),FALSE];
					(_this # 0) hideObjectGlobal TRUE;
				}],
				["Land_Bunker_01_HQ_F","a3\structures_f_argo\military\bunkers\bunker_01_hq_f.p3d",[11853.1,22327.1,18.3089],[[0,1,0],[0,0,1]],0,0,2,[],{
					_building = _this # 0;
					missionNamespace setVariable ['QS_module_fob_HQ',_building,TRUE];
					[_building] spawn {
						_building = _this # 0;
						_building enableSimulationGlobal TRUE;
						_dataTerminal = createSimpleObject ['Land_DataTerminal_01_F',(getPosWorld _building)];
						[1,_dataTerminal,[_building,[-0.6,0,-1]]] call QS_fnc_eventAttach;
						_dataTerminal setDir 90;
						sleep 0.1;
						[0,_dataTerminal] call QS_fnc_eventAttach;
						missionNamespace setVariable ['QS_module_fob_dataTerminal',_dataTerminal,TRUE];
						_crate = createSimpleObject ['a3\weapons_f\ammoboxes\supplydrop.p3d',(getPosWorld _building)];
						[1,_crate,[_building,[0.7,0,0]]] call QS_fnc_eventAttach;
						_crate setDir 90;
						sleep 0.1;
						[0,_crate] call QS_fnc_eventAttach;
						_crate hideObjectGlobal TRUE;
						missionNamespace setVariable ['QS_module_fob_supplycrate',_crate,FALSE];
						sleep 1;
						_building enableSimulationGlobal FALSE;
					};	
				}],
				["Land_PortableCabinet_01_medical_F","a3\props_f_enoch\military\camps\portablecabinet_01_medical_f.p3d",[11850.7,22328.7,17.7445],[[-0.999792,-0.0203754,0],[0,0,1]],0,0,2,[],{}],
				["Land_LampShabby_F","a3\structures_f\civ\lamps\lampshabby_f.p3d",[11803.7,22281.3,20.5744],[[-0.568408,0.822747,0],[0,0,1]],0,1,0,[],{}],
				["Land_Bunker_01_small_F","a3\structures_f_argo\military\bunkers\bunker_01_small_f.p3d",[11807.2,22273.5,17.5963],[[0.810697,0.585467,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_1_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_1_f.p3d",[11799.7,22285.2,16.6842],[[-0.810299,-0.586017,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_1_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_1_f.p3d",[11802.8,22281.2,16.9065],[[-0.810299,-0.586017,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11799.5,22287.7,17.4885],[[-0.999987,-0.00502202,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11813.8,22266.8,17.6747],[[-0.795581,-0.605848,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11818,22264.5,17.9929],[[-0.0388597,-0.999245,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11812.2,22268.5,17.6646],[[-0.795581,-0.605848,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11804.5,22279,17.7341],[[-0.795581,-0.605848,0],[0,0,1]],0,0,2,[],{}],
				["Land_Shed_Small_F","a3\structures_f\ind\shed\shed_small_f.p3d",[11804.2,22301.7,19.2171],[[-0.00236112,0.999997,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11799.3,22313.2,17.0496],[[-0.999987,-0.00502202,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11799.4,22297.9,17.249],[[-0.999987,-0.00502202,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11799.5,22292.8,17.4467],[[-0.999987,-0.00502202,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11799.4,22308.1,17.3283],[[-0.999987,-0.00502202,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11799.4,22303,17.305],[[-0.999987,-0.00502202,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11799.3,22318.3,16.9063],[[-0.999987,-0.00502202,0],[0,0,1]],0,0,2,[],{}],
				["Land_Excavator_01_abandoned_F","a3\props_f_exp\industrial\heavyequipment\excavator_01_abandoned_f.p3d",[11806,22322.6,18.8198],[[0.908139,-0.418226,0.0192646],[-0.012,0.0199933,0.999728]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_1_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_1_f.p3d",[11799,22346.4,15.2369],[[-0.999739,0.0228242,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11799.1,22338.7,16.1875],[[-0.999987,-0.00502202,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11799.2,22328.5,16.683],[[-0.999987,-0.00502202,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11799.1,22343.8,16.0636],[[-0.999987,-0.00502202,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11799.2,22323.4,16.7849],[[-0.999987,-0.00502202,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11799.2,22333.6,16.614],[[-0.999987,-0.00502202,0],[0,0,1]],0,0,2,[],{}],
				["Land_LampShabby_F","a3\structures_f\civ\lamps\lampshabby_f.p3d",[11799.6,22352.5,18.8314],[[-0.0484383,-0.998826,0],[0,0,1]],0,1,0,[],{}],
				["Land_Mil_WallBig_4m_F","a3\structures_f\walls\mil_wallbig_4m_f.p3d",[11799.8,22354.5,16.7546],[[0.998102,-0.0615759,0],[0,0,1]],0,0,2,[],{}],
				["Land_Mil_WallBig_4m_F","a3\structures_f\walls\mil_wallbig_4m_f.p3d",[11817.1,22376.3,17.7096],[[0.656307,-0.754494,0],[0,0,1]],0,0,2,[],{}],
				["Land_Mil_WallBig_4m_F","a3\structures_f\walls\mil_wallbig_4m_f.p3d",[11800,22356.4,16.7463],[[0.998102,-0.0615759,0],[0,0,1]],0,0,2,[],{}],
				["Land_Mil_WallBig_4m_F","a3\structures_f\walls\mil_wallbig_4m_f.p3d",[11811.2,22371.1,17.4943],[[0.656307,-0.754494,0],[0,0,1]],0,0,2,[],{}],
				["Land_Mil_WallBig_4m_F","a3\structures_f\walls\mil_wallbig_4m_f.p3d",[11805.2,22365.9,17.0349],[[0.641512,-0.767113,0],[0,0,1]],0,0,2,[],{}],
				["Land_Mil_WallBig_4m_F","a3\structures_f\walls\mil_wallbig_4m_f.p3d",[11814.1,22373.7,17.6466],[[0.656307,-0.754494,0],[0,0,1]],0,0,2,[],{}],
				["Land_Mil_WallBig_4m_F","a3\structures_f\walls\mil_wallbig_4m_f.p3d",[11808.2,22368.4,17.2632],[[0.656307,-0.754494,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bulldozer_01_abandoned_F","a3\props_f_exp\industrial\heavyequipment\bulldozer_01_abandoned_f.p3d",[11807.3,22364.5,16.8889],[[-0.685224,-0.727638,-0.0318024],[-0.0279894,-0.0173247,0.999458]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_1_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_1_f.p3d",[11798.9,22351.1,15.2127],[[-0.999739,0.0228242,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_tall_F","a3\structures_f_argo\military\bunkers\bunker_01_tall_f.p3d",[11799.3,22362.9,18.6938],[[0.877085,-0.480335,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11816.2,22377,17.234],[[-0.667152,0.744922,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11804.8,22366.8,16.3626],[[-0.667152,0.744922,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11812.4,22373.6,17.0482],[[-0.667152,0.744922,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11799,22354,16.1286],[[-0.999987,-0.00502202,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11799,22356.2,16.1197],[[-0.991875,0.127214,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11808.6,22370.2,16.6636],[[-0.667152,0.744922,0],[0,0,1]],0,0,2,[],{}],
				["Land_Shed_Small_F","a3\structures_f\ind\shed\shed_small_f.p3d",[11837.7,22268.5,20.3477],[[-0.998963,0.0455198,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11823.1,22264.2,18.0039],[[-0.0388597,-0.999245,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11838.4,22263.7,18.2565],[[-0.0388597,-0.999245,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11828.2,22264.1,18.1115],[[-0.0388597,-0.999245,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11843.5,22263.5,18.2793],[[-0.0388597,-0.999245,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11833.3,22263.9,18.2805],[[-0.0388597,-0.999245,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11848.6,22263.3,18.2975],[[-0.0388597,-0.999245,0],[0,0,1]],0,0,2,[],{}],
				["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[11847.2,22331.2,22.3492],[[-0.999632,-0.0271134,0],[0,0,1]],0,1,0,[],{}],
				["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[11847.2,22332.5,22.2873],[[0.788423,0.615134,0],[0,0,1]],0,1,0,[],{}],
				["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[11847.9,22332.9,22.2732],[[0.996843,-0.0793981,0],[0,0,1]],0,1,0,[],{}],
				["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[11846.8,22332,22.3115],[[0.0225953,0.999745,0],[0,0,1]],0,1,0,[],{}],
				["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[11846.8,22331.1,22.3503],[[-0.807152,0.590344,0],[0,0,1]],0,1,0,[],{}],
				["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[11847.5,22331.8,22.3232],[[-0.00273618,-0.999996,0],[0,0,1]],0,1,0,[],{}],
				["Land_TTowerSmall_2_F","a3\structures_f\ind\transmitter_tower\ttowersmall_2_f.p3d",[11846.6,22323.8,25.1732],[[0,1,0],[0,0,1]],0,0,2,[],{}],
				["Land_Barn_01_brown_F","a3\structures_f_argo\industrial\agriculture\barn_01_brown_f.p3d",[11824.7,22323.5,17.7193],[[-0.999949,-0.0100611,0],[0,0,1]],0,0,2,[],{}],
				["Land_Cargo20_sand_F","a3\structures_f\ind\cargo\cargo20_sand_f.p3d",[11844.7,22374.1,17.5621],[[3.29675e-005,0.999679,0.0253287],[0.00533084,-0.0253285,0.999665]],0,0,2,[],{}],
				["Land_Mil_WallBig_4m_F","a3\structures_f\walls\mil_wallbig_4m_f.p3d",[11820.5,22377.5,17.6817],[[0.0167538,-0.99986,0],[0,0,1]],0,0,2,[],{}],
				["Land_Mil_WallBig_4m_F","a3\structures_f\walls\mil_wallbig_4m_f.p3d",[11824.3,22377.5,17.7521],[[0.0167538,-0.99986,0],[0,0,1]],0,0,2,[],{}],
				["Land_Mil_WallBig_4m_F","a3\structures_f\walls\mil_wallbig_4m_f.p3d",[11828.2,22377.5,17.8283],[[-0.012471,-0.999922,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_1_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_1_f.p3d",[11849.7,22377.6,16.8025],[[0.528534,0.848912,0],[0,0,1]],0,0,2,[],{}],
				["Land_HelipadCircle_F","a3\structures_f\mil\helipads\helipadcircle_f.p3d",[11828.2,22360,15.8662],[[-0.997857,0.0473298,-0.045173],[-0.0452868,-0.0013355,0.998973]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11846.1,22378.2,17.2084],[[0.118892,0.992907,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11820.5,22378.6,17.2016],[[0.0139333,0.999903,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11830.8,22378.5,17.4049],[[0.0139333,0.999903,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11825.6,22378.6,17.2902],[[0.0139333,0.999903,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11835.9,22378.4,17.5992],[[0.0139333,0.999903,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11841,22378.4,17.5897],[[0.0139333,0.999903,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_small_F","a3\structures_f_argo\military\bunkers\bunker_01_small_f.p3d",[11856,22263.2,18.6413],[[-0.385967,0.922513,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_1_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_1_f.p3d",[11851.5,22263.1,18.2766],[[0.01489,-0.999889,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11859.4,22274,18.3636],[[0.999989,0.00474828,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11859.4,22268.9,18.3373],[[0.999983,-0.00590206,0],[0,0,1]],0,0,2,[],{}],
				["Land_Cargo20_sand_F","a3\structures_f\ind\cargo\cargo20_sand_f.p3d",[11853.3,22312.8,18.3424],[[0.000164768,0.99998,-0.00623299],[-0.0226573,0.00623512,0.999724]],0,0,2,[],{}],
				["Land_LampShabby_F","a3\structures_f\civ\lamps\lampshabby_f.p3d",[11858.6,22292.4,20.9763],[[0.0486765,-0.998815,0],[0,0,1]],0,1,0,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11859.2,22299.5,18.0187],[[0.999989,0.00474828,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11859.1,22314.8,17.6057],[[0.999989,0.00474828,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11859.1,22319.9,17.5196],[[0.999989,0.00474828,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11859.1,22304.5,17.8446],[[0.999989,0.00474828,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11859.1,22309.6,17.7558],[[0.999989,0.00474828,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11859.3,22294.4,18.0834],[[0.999989,0.00474828,0],[0,0,1]],0,0,2,[],{}],
				["Land_LampShabby_F","a3\structures_f\civ\lamps\lampshabby_f.p3d",[11858.8,22345.2,20.1033],[[0.00292396,0.999996,0],[0,0,1]],0,1,0,[],{}],
				["Land_Mil_WallBig_4m_F","a3\structures_f\walls\mil_wallbig_4m_f.p3d",[11858.2,22339.2,18.0544],[[-0.999328,0.0366549,0],[0,0,1]],0,0,2,[],{}],
				["Land_Mil_WallBig_4m_F","a3\structures_f\walls\mil_wallbig_4m_f.p3d",[11858.2,22343.1,18.0195],[[-0.999464,-0.0327333,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11859.1,22344.6,17.3265],[[0.999989,0.00474828,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11859.1,22334.4,17.4298],[[0.999989,0.00474828,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11859.1,22339.5,17.3517],[[0.999989,0.00474828,0],[0,0,1]],0,0,2,[],{}],
				["Land_Mil_WallBig_4m_F","a3\structures_f\walls\mil_wallbig_4m_f.p3d",[11858.1,22370.2,17.8911],[[-0.999464,-0.0327333,0],[0,0,1]],0,0,2,[],{}],
				["Land_Mil_WallBig_4m_F","a3\structures_f\walls\mil_wallbig_4m_f.p3d",[11858.2,22366.3,17.8004],[[-0.999464,-0.0327333,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_small_F","a3\structures_f_argo\military\bunkers\bunker_01_small_f.p3d",[11856.3,22375.5,17.0673],[[-0.410213,-0.91199,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_1_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_1_f.p3d",[11851.1,22376.7,16.797],[[0.528534,0.848912,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11858.9,22370.1,17.1558],[[0.999989,0.00474828,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11858.9,22365,17.0342],[[0.999989,0.00474828,0],[0,0,1]],0,0,2,[],{}]
			],
			[
				["B_G_Offroad_01_F",[11805.6,22293.5,-0.0551891],91.3296,{}],
				["B_G_Offroad_01_armed_F",[11805.2,22301.7,-0.0624695],92.2692,{}],
				["B_MRAP_01_F",[11829.8,22271,0.00987434],1.36946,{}],
				["B_MRAP_01_F",[11837.8,22271,-0.00250244],1.42604,{}],
				["B_MRAP_01_F",[11846.1,22270.5,-0.00465584],1.39603,{}],
				["B_Truck_01_transport_F",[11831.9,22317.1,0.0405598],181.002,{}],
				["B_Quadbike_01_F",[11844,22324.5,-0.00384903],270.283,{}],
				["B_Quadbike_01_F",[11844.3,22328.4,-0.00305176],270.272,{}]
			],
			[11828.1,22359.7,0.00135517],
			[11850.5,22299.9,0.00137329],
			localize 'STR_QS_Utility_013'
		];
	};
	if (_type isEqualTo 1) then {
		/* Northwest */
		_return = [
			[5398.9,17910.1],
			[
				["FlagPole_F","a3\structures_f\mil\flags\mast_f.p3d",[5371.82,17898.3,80.5007],[[0,1,0],[0,0,1]],0,1,0,[],{
					missionNamespace setVariable ['QS_module_fob_flag',(_this # 0),TRUE];
					(_this # 0) addEventHandler [
						'Deleted',
						{
							params ['_entity'];
							missionNamespace setVariable ['QS_module_fob_respawnTickets',(round (((_entity getVariable ['QS_deploy_tickets',0]) / 2) max 0)),FALSE];
						}
					];
				}],
				["Land_RepairDepot_01_tan_F","a3\structures_f_tank\military\repairdepot\repairdepot_01_tan_f.p3d",[5424.26,17941,79.9204],[[-0.999322,-0.0368147,-9.58852e-005],[0.00225045,-0.0636868,0.997967]],0,0,2,[],{
					missionNamespace setVariable ['QS_module_fob_repairDepot',(_this # 0),FALSE];
					(_this # 0) hideObjectGlobal TRUE;
				}],
				["Land_Bunker_01_HQ_F","a3\structures_f_argo\military\bunkers\bunker_01_hq_f.p3d",[5372.18,17890,78.2937],[[0.777781,-0.628535,0],[0,0,1]],0,0,2,[],{
					_building = _this # 0;
					missionNamespace setVariable ['QS_module_fob_HQ',_building,TRUE];
					[_building] spawn {
						_building = _this # 0;
						_building enableSimulationGlobal TRUE;
						_dataTerminal = createSimpleObject ['Land_DataTerminal_01_F',(getPosWorld _building)];
						[1,_dataTerminal,[_building,[-0.6,0,-1]]] call QS_fnc_eventAttach;
						_dataTerminal setDir 90;
						sleep 0.1;
						[0,_dataTerminal] call QS_fnc_eventAttach;
						missionNamespace setVariable ['QS_module_fob_dataTerminal',_dataTerminal,TRUE];
						_crate = createSimpleObject ['a3\weapons_f\ammoboxes\supplydrop.p3d',(getPosWorld _building)];
						[1,_crate,[_building,[0.7,0,0]]] call QS_fnc_eventAttach;
						_crate setDir 90;
						sleep 0.1;
						[0,_crate] call QS_fnc_eventAttach;
						_crate hideObjectGlobal TRUE;
						missionNamespace setVariable ['QS_module_fob_supplycrate',_crate,FALSE];
						sleep 1;
						_building enableSimulationGlobal FALSE;
					};	
				}],
				["Land_PortableCabinet_01_medical_F","a3\props_f_enoch\military\camps\portablecabinet_01_medical_f.p3d",[5374.9,17890.9,77.7298],[[0.617444,0.786596,0.00546907],[0.00133357,-0.00799941,0.999967]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[5158,17839.6,141.237],[[-0.595664,-0.803234,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[5155.4,17843.5,140.955],[[-0.975337,-0.22072,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[5156.02,17848.2,140.555],[[-0.863325,0.504648,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_big_F","a3\structures_f_argo\military\bunkers\bunker_01_big_f.p3d",[5168.15,17845.3,141.226],[[-0.985355,-0.170516,0],[0,0,1]],0,0,2,[],{}],
				["Land_TBox_F","a3\structures_f\ind\transmitter_tower\tbox_f.p3d",[5169.09,17853,140.355],[[0.181356,-0.983418,0],[0,0,1]],0,0,2,[],{}],
				["Land_Wreck_AFV_Wheeled_01_F","a3\props_f_tank\military\wrecks\wreck_afv_wheeled_01_f.p3d",[5196.43,17849.9,134.735],[[-0.805127,0.58567,0.0936036],[0.169512,0.0759883,0.982594]],0,0,2,[],{}],
				["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[5365.47,17891.7,82.3269],[[0.37132,0.928505,0],[0,0,1]],0,1,0,[],{}],
				["Land_LampShabby_F","a3\structures_f\civ\lamps\lampshabby_f.p3d",[5356.11,17908.8,80.8137],[[-0.126657,-0.991947,0],[0,0,1]],0,1,0,[],{}],
				["Land_TTowerSmall_2_F","a3\structures_f\ind\transmitter_tower\ttowersmall_2_f.p3d",[5364.46,17890.8,84.811],[[0.591682,0.806171,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_1_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_1_f.p3d",[5356.9,17901.2,76.9497],[[-0.985968,-0.166932,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_1_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_1_f.p3d",[5361.8,17890.5,77.3603],[[-0.534394,-0.845236,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_1_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_1_f.p3d",[5355.44,17907.2,77.1721],[[-0.985968,-0.166932,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_1_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_1_f.p3d",[5364.55,17888.8,77.3203],[[-0.534394,-0.845236,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_1_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_1_f.p3d",[5363.19,17889.7,77.3292],[[-0.534394,-0.845236,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[5360.12,17893.3,77.3786],[[-0.917737,-0.397189,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[5358.07,17898,77.5734],[[-0.917737,-0.397189,0],[0,0,1]],0,0,2,[],{}],
				["Land_Excavator_01_abandoned_F","a3\props_f_exp\industrial\heavyequipment\excavator_01_abandoned_f.p3d",[5363.85,17924.7,80.7512],[[0.413648,0.910161,0.0223896],[0.0279894,-0.0372933,0.998912]],0,0,2,[],{}],
				["Land_Bunker_01_tall_F","a3\structures_f_argo\military\bunkers\bunker_01_tall_f.p3d",[5354.54,17917.1,81.5953],[[0.970453,-0.241288,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[5355.5,17910.6,78.1114],[[-0.997201,0.0747702,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[5366.57,17934.3,78.8627],[[-0.142809,0.98975,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[5363.01,17931.6,78.8254],[[-0.898489,0.438997,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[5360.8,17927,79.0831],[[-0.898489,0.438997,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[5358.55,17922.4,78.9997],[[-0.898489,0.438997,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[5398.72,17876.7,76.3243],[[-0.0629234,-0.998018,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[5395.32,17877,77.2288],[[-0.0629234,-0.998018,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[5380.24,17879.4,77.3758],[[-0.255641,-0.966772,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[5390.19,17877.3,77.3349],[[-0.0629234,-0.998018,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[5385.21,17878.1,77.3381],[[-0.255641,-0.966772,0],[0,0,1]],0,0,2,[],{}],
				["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[5380.46,17891.6,82.2874],[[0.558812,-0.829294,0],[0,0,1]],0,1,0,[],{}],
				["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[5380.33,17889.9,82.2742],[[-0.490739,-0.871307,0],[0,0,1]],0,1,0,[],{}],
				["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[5380.63,17890.8,82.2805],[[-0.0118537,-0.99993,0],[0,0,1]],0,1,0,[],{}],
				["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[5379.9,17892.1,82.2928],[[0.982929,0.183983,0],[0,0,1]],0,1,0,[],{}],
				["Land_LampShabby_F","a3\structures_f\civ\lamps\lampshabby_f.p3d",[5379.74,17889.2,80.0598],[[-0.513688,-0.857977,0],[0,0,1]],0,1,0,[],{}],
				["Land_Bunker_01_blocks_1_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_1_f.p3d",[5372.69,17881.7,77.3062],[[-0.803752,-0.594964,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[5375.26,17880.7,77.3124],[[-0.255641,-0.966772,0],[0,0,1]],0,0,2,[],{}],
				["Land_Cargo20_sand_F","a3\structures_f\ind\cargo\cargo20_sand_f.p3d",[5397.15,17882.2,77.5679],[[-0.0501955,0.039196,-0.99797],[-0.471975,-0.881544,-0.010884]],0,0,2,[],{}],
				["Land_Shed_Small_F","a3\structures_f\ind\shed\shed_small_f.p3d",[5381.65,17931.1,80.1508],[[0.993756,0.111577,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[5397.01,17938.3,78.1715],[[-0.117838,0.993033,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[5391.9,17937.7,78.1893],[[-0.119756,0.992803,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[5376.73,17935.8,78.4659],[[-0.142809,0.98975,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[5371.65,17935,78.4966],[[-0.142809,0.98975,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[5381.71,17936.4,78.496],[[-0.119756,0.992803,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[5386.8,17937.1,78.2226],[[-0.119756,0.992803,0],[0,0,1]],0,0,2,[],{}],
				["Land_Wreck_MBT_04_F","a3\props_f_tank\military\wrecks\wreck_mbt_04_f.p3d",[5402.09,17866.5,74.6386],[[0.889127,-0.386736,-0.244721],[0.0850239,-0.38583,0.918643]],0,0,2,[],{}],
				["Land_Bulldozer_01_abandoned_F","a3\props_f_exp\industrial\heavyequipment\bulldozer_01_abandoned_f.p3d",[5417.32,17879.4,77.4889],[[-0.113576,-0.987924,-0.105384],[-0.0346473,-0.102068,0.994174]],0,0,2,[],{}],
				["Land_Bunker_01_small_F","a3\structures_f_argo\military\bunkers\bunker_01_small_f.p3d",[5428.61,17873.9,76.9598],[[0.0171351,0.999853,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_1_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_1_f.p3d",[5424.23,17875.2,76.7256],[[-0.164114,-0.986441,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_1_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_1_f.p3d",[5407.42,17876.3,76.1761],[[-0.113327,-0.993558,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[5420.93,17875.5,76.7623],[[-0.061148,-0.998129,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[5410.69,17876.1,76.8017],[[-0.0629234,-0.998018,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[5415.81,17875.8,76.6976],[[-0.0629234,-0.998018,0],[0,0,1]],0,0,2,[],{}],
				["Land_HelipadCircle_F","a3\structures_f\mil\helipads\helipadcircle_f.p3d",[5403.54,17896.2,76.4752],[[-0.997966,0.0608306,0.0190906],[0.0173315,-0.0293158,0.99942]],0,0,2,[],{}],
				["Land_WoodenPlanks_01_messy_F","a3\structures_f_exp\industrial\materials\woodenplanks_01_messy_f.p3d",[5410.15,17936.1,78.1049],[[0.997274,0.0736191,0.00497427],[-0.00665923,0.0226598,0.999721]],0,0,2,[],{}],
				["Land_Timbers_F","a3\structures_f\civ\accessories\timbers_f.p3d",[5402.69,17932.7,77.566],[[-0.998791,0.0200348,-0.0448856],[-0.0452855,-0.0199741,0.998774]],0,0,2,[],{}],
				["Land_Timbers_F","a3\structures_f\civ\accessories\timbers_f.p3d",[5402.27,17935.4,77.6014],[[0.996768,0.065498,0.0465044],[-0.0452855,-0.0199741,0.998774]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[5407.2,17939.6,78.2168],[[-0.117838,0.993033,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[5402.1,17938.9,78.218],[[-0.117838,0.993033,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[5429.95,17946.6,78.3935],[[-0.0118075,0.99993,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[5424.82,17946.5,78.5099],[[-0.0118075,0.99993,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[5415.19,17944.8,78.6694],[[-0.653317,0.757085,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[5419.68,17946.5,78.7181],[[-0.0118075,0.99993,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[5411.3,17941.4,78.3881],[[-0.653317,0.757085,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[5433.73,17877.9,76.8376],[[0.942497,-0.334213,0],[0,0,1]],0,0,2,[],{}],
				["Land_Shed_Small_F","a3\structures_f\ind\shed\shed_small_f.p3d",[5430.88,17893,79.4407],[[-0.136936,-0.99058,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_small_F","a3\structures_f_argo\military\bunkers\bunker_01_small_f.p3d",[5438.36,17908.8,77.082],[[-0.999925,-0.012262,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[5435.33,17887.3,76.941],[[0.993244,-0.116047,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[5435.9,17892.5,76.9879],[[0.993244,-0.116047,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[5437.04,17902.7,77.1946],[[0.993244,-0.116047,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[5434.74,17882.2,76.9141],[[0.993244,-0.116047,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[5436.45,17897.6,77.0755],[[0.993244,-0.116047,0],[0,0,1]],0,0,2,[],{}],
				["Land_LampShabby_F","a3\structures_f\civ\lamps\lampshabby_f.p3d",[5437.07,17934.4,80.905],[[0.31536,-0.948972,0],[0,0,1]],0,1,0,[],{}],
				["Land_LampShabby_F","a3\structures_f\civ\lamps\lampshabby_f.p3d",[5436.05,17912.6,80.2605],[[0,1,0],[0,0,1]],0,1,0,[],{}],
				["Land_Bunker_01_small_F","a3\structures_f_argo\military\bunkers\bunker_01_small_f.p3d",[5439.4,17937.6,77.9965],[[-0.998687,-0.0512223,0],[0,0,1]],0,0,2,[],{}],
				["Land_Cargo20_sand_F","a3\structures_f\ind\cargo\cargo20_sand_f.p3d",[5431.6,17941.5,78.7467],[[0.998157,-0.0581712,-0.0172988],[0.0173287,8.80379e-006,0.99985]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[5435.07,17946.7,78.336],[[-0.0269998,0.999635,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[5437.97,17944.4,78.4236],[[0.997944,0.064096,0],[0,0,1]],0,0,2,[],{}],
				["Land_Wreck_LT_01_F","a3\props_f_tank\military\wrecks\wreck_lt_01_f.p3d",[5466.01,17918.8,76.0715],[[0,0.995297,0.0968754],[0.02266,-0.0968506,0.995041]],0,0,2,[],{}]
			],
			[
				["B_Quadbike_01_F",[5379.93,17896.4,-0.000259399],40.4165,{}],
				["B_Quadbike_01_F",[5376.69,17899.2,-0.00130463],40.331,{}],
				["B_MRAP_01_F",[5390.32,17929.1,0.0323334],172.728,{}],
				["B_MRAP_01_F",[5373.58,17927.1,0.00133514],177.623,{}],
				["B_MRAP_01_F",[5382.14,17928.2,0.0809021],177.544,{}],
				["B_G_Offroad_01_F",[5429.07,17893.5,-0.0491638],280.279,{}],
				["B_G_Offroad_01_armed_F",[5430.26,17901.2,-0.0496674],278.539,{}]
			],
			[5403.48,17896.2,0.00151825],		/*helipad*/
			[5424.13,17937.4,0.00135803],		/* service bay*/
			localize 'STR_QS_Utility_014'						/* Marker text */
		];
	};
	if (_type isEqualTo 2) then {
		/* northeast */
		_return = [
			[22081.4,19928.3],
			[
				["FlagPole_F","a3\structures_f\mil\flags\mast_f.p3d",[22071.1,19897.1,18.6108],[[0,1,0],[0,0,1]],0,1,0,[],{
					missionNamespace setVariable ['QS_module_fob_flag',(_this # 0),TRUE];
					(_this # 0) addEventHandler [
						'Deleted',
						{
							params ['_entity'];
							missionNamespace setVariable ['QS_module_fob_respawnTickets',(round (((_entity getVariable ['QS_deploy_tickets',0]) / 2) max 0)),FALSE];
						}
					];
				}],
				["Land_RepairDepot_01_tan_F","a3\structures_f_tank\military\repairdepot\repairdepot_01_tan_f.p3d",[22034.6,19945.4,16.218],[[-0.946385,-0.322806,-0.0123203],[-0.0528278,0.117027,0.991723]],0,0,2,[],{
					missionNamespace setVariable ['QS_module_fob_repairDepot',(_this # 0),FALSE];
					(_this # 0) hideObjectGlobal TRUE;
				}],
				["Land_Bunker_01_HQ_F","a3\structures_f_argo\military\bunkers\bunker_01_hq_f.p3d",[22065.8,19890.7,17.012],[[0.992486,0.122355,0],[0,0,1]],0,0,2,[],{
					_building = _this # 0;
					missionNamespace setVariable ['QS_module_fob_HQ',_building,TRUE];
					[_building] spawn {
						_building = _this # 0;
						_building enableSimulationGlobal TRUE;
						_dataTerminal = createSimpleObject ['Land_DataTerminal_01_F',(getPosWorld _building)];
						[1,_dataTerminal,[_building,[-0.6,0,-1]]] call QS_fnc_eventAttach;
						_dataTerminal setDir 90;
						sleep 0.1;
						[0,_dataTerminal] call QS_fnc_eventAttach;
						missionNamespace setVariable ['QS_module_fob_dataTerminal',_dataTerminal,TRUE];
						_crate = createSimpleObject ['a3\weapons_f\ammoboxes\supplydrop.p3d',(getPosWorld _building)];
						[1,_crate,[_building,[0.7,0,0]]] call QS_fnc_eventAttach;
						_crate setDir 90;
						sleep 0.1;
						[0,_crate] call QS_fnc_eventAttach;
						_crate hideObjectGlobal TRUE;
						missionNamespace setVariable ['QS_module_fob_supplycrate',_crate,FALSE];
						sleep 1;
						_building enableSimulationGlobal FALSE;
					};	
				}],
				["Land_PortableCabinet_01_medical_F","a3\props_f_enoch\military\camps\portablecabinet_01_medical_f.p3d",[22067,19893.3,16.4479],[[-0.113026,0.993219,-0.0272073],[0,0,1]],0,0,2,[],{}],
				["Land_LampShabby_F","a3\structures_f\civ\lamps\lampshabby_f.p3d",[22019.7,19924.9,17.2815],[[-0.554118,0.832438,0],[0,0,1]],0,1,0,[],{}],
				["Land_Bunker_01_small_F","a3\structures_f_argo\military\bunkers\bunker_01_small_f.p3d",[22018.6,19921.3,14.5564],[[0.931272,0.364325,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[22013.4,19939.3,14.4566],[[-0.956947,-0.290264,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[22020,19944.5,14.4337],[[-0.369429,0.929259,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[22015.2,19942.6,14.4317],[[-0.369429,0.929259,0],[0,0,1]],0,0,2,[],{}],
				["Land_Excavator_01_abandoned_F","a3\props_f_exp\industrial\heavyequipment\excavator_01_abandoned_f.p3d",[22043.2,19889,17.6281],[[0.941184,0.336722,-0.0281361],[-0.012,0.116525,0.993115]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_1_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_1_f.p3d",[22045.6,19881.9,15.9476],[[0.0778876,-0.996962,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[22037.4,19883.9,15.322],[[-0.30338,-0.95287,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[22049,19882.6,16.085],[[0.165012,-0.986292,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[22042.2,19882.3,15.9631],[[-0.30338,-0.95287,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[22033.8,19886.8,15.3489],[[-0.916931,-0.399045,0],[0,0,1]],0,0,2,[],{}],
				["Land_Shed_Small_F","a3\structures_f\ind\shed\shed_small_f.p3d",[22031.7,19904.6,16.1268],[[-0.371803,0.928312,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[22031.8,19891.6,14.8993],[[-0.927662,-0.373421,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[22022.1,19915.3,14.0553],[[-0.927662,-0.373421,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[22029.9,19896.3,14.5809],[[-0.927662,-0.373421,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[22026,19905.8,14.2676],[[-0.927662,-0.373421,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[22027.9,19901,14.3072],[[-0.927662,-0.373421,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[22024.1,19910.5,14.067],[[-0.927662,-0.373421,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[22024.7,19946.5,14.3354],[[-0.369429,0.929259,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[22029.5,19948.3,14.2199],[[-0.369429,0.929259,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[22043.8,19954,14.4797],[[-0.326585,0.945168,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[22034.2,19950.2,14.3452],[[-0.369429,0.929259,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[22048.6,19955.7,14.4345],[[-0.326585,0.945168,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[22039,19952.2,14.4809],[[-0.369429,0.929259,0],[0,0,1]],0,0,2,[],{}],
				["Land_LampShabby_F","a3\structures_f\civ\lamps\lampshabby_f.p3d",[22079.9,19888.1,19.4552],[[0.999992,0.00401599,0],[0,0,1]],0,1,0,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[22078.9,19887.2,16.6644],[[0.171802,-0.985131,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[22054,19883.5,16.0066],[[0.165012,-0.986292,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[22073.9,19886.4,16.0421],[[0.127466,-0.991843,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[22059.1,19884.4,15.8775],[[0.165012,-0.986292,0],[0,0,1]],0,0,2,[],{}],
				["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[22067.7,19897.7,20.5783],[[0.992762,0.120099,0],[0,0,1]],0,1,0,[],{}],
				["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[22066.7,19897.6,20.5733],[[-0.138931,0.990302,0],[0,0,1]],0,1,0,[],{}],
				["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[22066.7,19898.1,20.5583],[[0.632425,0.774622,0],[0,0,1]],0,1,0,[],{}],
				["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[22068.7,19897.8,20.5837],[[0.0925157,-0.995711,0],[0,0,1]],0,1,0,[],{}],
				["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[22068.4,19898.3,20.5662],[[0.801323,-0.598232,0],[0,0,1]],0,1,0,[],{}],
				["Land_TTowerSmall_2_F","a3\structures_f\ind\transmitter_tower\ttowersmall_2_f.p3d",[22071.7,19893,23.1787],[[0,1,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bulldozer_01_abandoned_F","a3\props_f_exp\industrial\heavyequipment\bulldozer_01_abandoned_f.p3d",[22071.1,19936.7,15.9338],[[-0.685462,-0.724432,-0.0730738],[-0.00933489,-0.0916092,0.995751]],0,0,2,[],{}],
				["Land_Barn_01_brown_F","a3\structures_f_argo\industrial\agriculture\barn_01_brown_f.p3d",[22068.2,19923.9,15.5352],[[0.930587,0.366072,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_big_F","a3\structures_f_argo\military\bunkers\bunker_01_big_f.p3d",[22079.9,19969,15.4654],[[0.33739,-0.941365,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[22067.9,19962.4,14.9847],[[-0.326585,0.945168,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[22053.4,19957.4,14.5048],[[-0.326585,0.945168,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[22063.1,19960.7,15.0486],[[-0.326585,0.945168,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[22076,19961.9,15.1725],[[-0.956578,-0.291476,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[22072.8,19964.1,14.7381],[[-0.296775,0.954947,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[22079.2,19960.1,15.2063],[[0.275888,-0.96119,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[22058.3,19959,14.8122],[[-0.326585,0.945168,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[22106.5,19891.4,16.7614],[[0.105608,-0.994408,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[22103.1,19893.5,16.7637],[[-0.993874,-0.11052,0],[0,0,1]],0,0,2,[],{}],
				["Land_HelipadCircle_F","a3\structures_f\mil\helipads\helipadcircle_f.p3d",[22107.8,19939,14.3827],[[0.100309,-0.994777,0.018901],[0.0757814,0.0265804,0.99677]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[22107.2,19974,14.991],[[-0.187427,0.982279,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[22097.3,19971.8,14.6335],[[-0.296775,0.954947,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[22102.2,19973,14.5551],[[-0.187427,0.982279,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[22087.5,19968.7,15.1204],[[-0.296775,0.954947,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[22092.4,19970.2,14.8838],[[-0.296775,0.954947,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[22086.4,19965.5,15.6314],[[0.933829,0.357721,0],[0,0,1]],0,0,2,[],{}],
				["Land_Shed_Small_F","a3\structures_f\ind\shed\shed_small_f.p3d",[22115.4,19897.7,18.1357],[[-0.994538,-0.104378,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_small_F","a3\structures_f_argo\military\bunkers\bunker_01_small_f.p3d",[22132.5,19895.6,16.478],[[-0.754587,0.6562,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[22134.2,19907.2,16.5115],[[0.999955,0.00948852,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[22121.7,19893.1,16.657],[[0.105608,-0.994408,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[22134.2,19912.4,16.3515],[[0.999955,0.00948852,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[22111.5,19892,16.5395],[[0.105608,-0.994408,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[22126.8,19893.6,16.7196],[[0.105608,-0.994408,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[22116.6,19892.5,16.5617],[[0.105608,-0.994408,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[22134.3,19902.1,16.6609],[[0.999955,0.00948852,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[22134.1,19917.5,16.1409],[[0.999955,0.00948852,0],[0,0,1]],0,0,2,[],{}],
				["Land_Cargo20_sand_F","a3\structures_f\ind\cargo\cargo20_sand_f.p3d",[22130.3,19940.4,15.7544],[[-0.998402,-0.056034,0.00729148],[0.0057701,0.0272651,0.999611]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[22133.7,19937.9,15.6677],[[0.999728,0.0233283,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[22134,19922.6,15.9477],[[0.999955,0.00948852,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[22133.4,19948.2,15.5167],[[0.999728,0.0233283,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[22133.8,19932.8,15.8267],[[0.999728,0.0233283,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[22133.6,19943.1,15.537],[[0.999728,0.0233283,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[22133.9,19927.7,15.9132],[[0.999728,0.0233283,0],[0,0,1]],0,0,2,[],{}],
				["Land_Cargo20_sand_F","a3\structures_f\ind\cargo\cargo20_sand_f.p3d",[22116.7,19971.2,15.7729],[[0.978061,0.207639,0.0167938],[-0.0229263,0.0271636,0.999368]],0,0,2,[],{}],
				["Land_LampShabby_F","a3\structures_f\civ\lamps\lampshabby_f.p3d",[22129.7,19973.1,18.277],[[0.447214,-0.894427,0],[0,0,1]],0,1,0,[],{}],
				["Land_Bunker_01_small_F","a3\structures_f_argo\military\bunkers\bunker_01_small_f.p3d",[22133.8,19954.4,15.9426],[[-0.984533,-0.175201,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[22130.3,19975.2,14.9812],[[0.98138,0.192074,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[22112.2,19974.9,15.0594],[[-0.187427,0.982279,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[22122.3,19976.9,14.9419],[[-0.187427,0.982279,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[22117.3,19975.9,15.0128],[[-0.187427,0.982279,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[22127.3,19977.9,14.8226],[[-0.187427,0.982279,0],[0,0,1]],0,0,2,[],{}]
			],
			[
				["B_MRAP_01_F",[22037.1,19898.2,0.0137377],65.6465],
				["B_MRAP_01_F",[22031.3,19913.2,0.0051918],65.6393],
				["B_MRAP_01_F",[22034.3,19905.5,0.0108347],65.6277],
				["B_Quadbike_01_F",[22062.2,19898.5,-0.00395203],354.247],
				["B_Quadbike_01_F",[22064.8,19898.7,-0.00516605],354.131],
				["B_Truck_01_transport_F",[22057.6,19924.3,0.0553885],341.621],
				["B_G_Offroad_01_armed_F",[22114.9,19899.1,-0.0410919],355.691],
				["B_G_Offroad_01_AT_F",[22123.4,19900.2,-0.0485096],352.209]
			],
			[22107.7,19939.1,0.00132751],
			[22035.7,19940.8,0.00138283],
			localize 'STR_QS_Utility_015'
		];
	};
	if (_type isEqualTo 3) then {
		/*/southeast/*/
		_return = [
			[16920.3,9968.75],
			[
				["FlagPole_F","a3\structures_f\mil\flags\mast_f.p3d",[16903.7,9972.6,20.3337],[[0,1,0],[0,0,1]],0,1,0,[],{
					missionNamespace setVariable ['QS_module_fob_flag',(_this # 0),TRUE];
					(_this # 0) addEventHandler [
						'Deleted',
						{
							params ['_entity'];
							missionNamespace setVariable ['QS_module_fob_respawnTickets',(round (((_entity getVariable ['QS_deploy_tickets',0]) / 2) max 0)),FALSE];
						}
					];
				}],
				["Land_RepairDepot_01_tan_F","a3\structures_f_tank\military\repairdepot\repairdepot_01_tan_f.p3d",[16871.2,9971.07,18.4273],[[0.296781,-0.954945,0.000774404],[-0.0107547,-0.0025315,0.999939]],0,0,2,[],{
					missionNamespace setVariable ['QS_module_fob_repairDepot',(_this # 0),FALSE];
					(_this # 0) hideObjectGlobal TRUE;
				}],
				["Land_Bunker_01_HQ_F","a3\structures_f_argo\military\bunkers\bunker_01_hq_f.p3d",[16896.8,9976.1,18.3242],[[-0.301006,0.953622,0],[0,0,1]],0,0,2,[],{
					_building = _this # 0;
					missionNamespace setVariable ['QS_module_fob_HQ',_building,TRUE];
					[_building] spawn {
						_building = _this # 0;
						_building enableSimulationGlobal TRUE;
						_dataTerminal = createSimpleObject ['Land_DataTerminal_01_F',(getPosWorld _building)];
						[1,_dataTerminal,[_building,[-0.6,0,-1]]] call QS_fnc_eventAttach;
						_dataTerminal setDir 90;
						sleep 0.1;
						[0,_dataTerminal] call QS_fnc_eventAttach;
						missionNamespace setVariable ['QS_module_fob_dataTerminal',_dataTerminal,TRUE];
						_crate = createSimpleObject ['a3\weapons_f\ammoboxes\supplydrop.p3d',(getPosWorld _building)];
						[1,_crate,[_building,[0.7,0,0]]] call QS_fnc_eventAttach;
						_crate setDir 90;
						sleep 0.1;
						[0,_crate] call QS_fnc_eventAttach;
						_crate hideObjectGlobal TRUE;
						missionNamespace setVariable ['QS_module_fob_supplycrate',_crate,FALSE];
						sleep 1;
						_building enableSimulationGlobal FALSE;
					};	
				}],
				["Land_PortableCabinet_01_medical_F","a3\props_f_enoch\military\camps\portablecabinet_01_medical_f.p3d",[16894,9976.82,17.7603],[[-0.958596,-0.28449,-0.0126412],[0,0,1]],0,0,2,[],{}],
				["Land_Mil_WallBig_4m_F","a3\structures_f\walls\mil_wallbig_4m_f.p3d",[16879,9923.7,17.9021],[[0.976713,0.21455,0],[0,0,1]],0,0,2,[],{}],
				["Land_Mil_WallBig_4m_F","a3\structures_f\walls\mil_wallbig_4m_f.p3d",[16878.1,9927.47,17.7187],[[0.976713,0.21455,0],[0,0,1]],0,0,2,[],{}],
				["Land_Mil_WallBig_4m_F","a3\structures_f\walls\mil_wallbig_4m_f.p3d",[16887.5,9916.75,18.3739],[[-0.031443,0.999506,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_small_F","a3\structures_f_argo\military\bunkers\bunker_01_small_f.p3d",[16880.8,9916.96,17.3629],[[0.591668,0.806182,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[16878.2,9922.36,17.2476],[[-0.977265,-0.212019,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[16877.1,9927.34,17.0661],[[-0.977265,-0.212019,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[16887.7,9915.49,17.7516],[[0.0434738,-0.999055,0],[0,0,1]],0,0,2,[],{}],
				["Land_Mil_WallBig_4m_F","a3\structures_f\walls\mil_wallbig_4m_f.p3d",[16876.5,9934.99,17.3335],[[0.976713,0.21455,0],[0,0,1]],0,0,2,[],{}],
				["Land_Mil_WallBig_4m_F","a3\structures_f\walls\mil_wallbig_4m_f.p3d",[16877.3,9931.22,17.5342],[[0.976713,0.21455,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[16876,9932.27,16.8587],[[-0.977265,-0.212019,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[16874.9,9937.29,16.4972],[[-0.977265,-0.212019,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[16873.8,9942.26,16.8465],[[-0.977265,-0.212019,0],[0,0,1]],0,0,2,[],{}],
				["Land_LampShabby_F","a3\structures_f\civ\lamps\lampshabby_f.p3d",[16870.4,9961.87,19.74],[[0.0987023,-0.995117,0],[0,0,1]],0,1,0,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[16863.5,9977.2,16.6746],[[-0.940652,-0.339373,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[16861.8,9982.03,15.5599],[[-0.940652,-0.339373,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[16867.1,9967.68,17.0411],[[-0.940652,-0.339373,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[16860,9986.82,15.4343],[[-0.940652,-0.339373,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[16868.8,9962.84,17.1436],[[-0.940652,-0.339373,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[16865.3,9972.46,17.0994],[[-0.940652,-0.339373,0],[0,0,1]],0,0,2,[],{}],
				["Land_Shed_Small_F","a3\structures_f\ind\shed\shed_small_f.p3d",[16881,10002,17.1993],[[0.91681,0.399324,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_1_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_1_f.p3d",[16866.3,10000.2,14.2763],[[-0.78833,0.615253,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_1_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_1_f.p3d",[16867.2,10001.3,14.2271],[[-0.78833,0.615253,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_tall_F","a3\structures_f_argo\military\bunkers\bunker_01_tall_f.p3d",[16862.5,9997.39,17.6809],[[0.844356,-0.535782,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[16884.2,10008.9,15.6418],[[-0.392499,0.919752,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[16874.9,10004.8,15.2561],[[-0.392499,0.919752,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[16870.1,10002.9,15.2905],[[-0.392499,0.919752,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[16888.9,10010.9,15.638],[[-0.392499,0.919752,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[16860.7,9991.38,15.3164],[[-0.834294,0.55132,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[16879.5,10006.9,15.4665],[[-0.392499,0.919752,0],[0,0,1]],0,0,2,[],{}],
				["Land_Mil_WallBig_4m_F","a3\structures_f\walls\mil_wallbig_4m_f.p3d",[16898.6,9917.27,18.5129],[[-0.0148189,0.99989,0],[0,0,1]],0,0,2,[],{}],
				["Land_Mil_WallBig_4m_F","a3\structures_f\walls\mil_wallbig_4m_f.p3d",[16894.7,9917.15,18.4541],[[-0.0148189,0.99989,0],[0,0,1]],0,0,2,[],{}],
				["Land_Mil_WallBig_4m_F","a3\structures_f\walls\mil_wallbig_4m_f.p3d",[16906.3,9917.42,18.7527],[[-0.0148189,0.99989,0],[0,0,1]],0,0,2,[],{}],
				["Land_Mil_WallBig_4m_F","a3\structures_f\walls\mil_wallbig_4m_f.p3d",[16890.8,9917.07,18.425],[[-0.0148189,0.99989,0],[0,0,1]],0,0,2,[],{}],
				["Land_Mil_WallBig_4m_F","a3\structures_f\walls\mil_wallbig_4m_f.p3d",[16902.5,9917.35,18.6145],[[-0.0148189,0.99989,0],[0,0,1]],0,0,2,[],{}],
				["Land_Mil_WallBig_4m_F","a3\structures_f\walls\mil_wallbig_4m_f.p3d",[16910.2,9917.71,19.0084],[[-0.0735327,0.997293,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[16897.9,9915.96,17.9113],[[0.0434738,-0.999055,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[16911.5,9916.49,18.5606],[[0.0434738,-0.999055,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[16908.1,9916.4,18.333],[[0.0434738,-0.999055,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[16903,9916.22,17.9813],[[0.0434738,-0.999055,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[16892.8,9915.68,17.9076],[[0.0434738,-0.999055,0],[0,0,1]],0,0,2,[],{}],
				["Land_HelipadCircle_F","a3\structures_f\mil\helipads\helipadcircle_f.p3d",[16895.7,9933.54,16.478],[[-0.631227,-0.775579,-0.00553231],[-0.033315,0.0199866,0.999245]],0,0,2,[],{}],
				["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[16899,9970.19,22.2793],[[-0.985392,-0.170303,0],[0,0,1]],0,1,0,[],{}],
				["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[16891.7,9971.52,22.2006],[[-0.179822,0.983699,0],[0,0,1]],0,1,0,[],{}],
				["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[16903.9,9974.88,22.3503],[[0.251588,-0.967834,0],[0,0,1]],0,1,0,[],{}],
				["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[16900,9983.3,22.3418],[[0.984719,0.174151,0],[0,0,1]],0,1,0,[],{}],
				["Land_LampShabby_F","a3\structures_f\civ\lamps\lampshabby_f.p3d",[16902.3,9971.18,20.1083],[[-0.793524,-0.608539,0],[0,0,1]],0,1,0,[],{}],
				["Land_TTowerSmall_2_F","a3\structures_f\ind\transmitter_tower\ttowersmall_2_f.p3d",[16893.8,9982.44,24.7637],[[0,1,0],[0,0,1]],0,0,2,[],{}],
				["Land_LampShabby_F","a3\structures_f\civ\lamps\lampshabby_f.p3d",[16918.8,10009.5,19.5217],[[-0.994629,-0.103506,0],[0,0,1]],0,1,0,[],{}],
				["Land_Bunker_01_small_F","a3\structures_f_argo\military\bunkers\bunker_01_small_f.p3d",[16894.6,10014.5,16.2515],[[0.419531,-0.907741,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[16919.5,10011.5,16.6634],[[-0.574581,0.818448,0],[0,0,1]],0,0,2,[],{}],
				["Land_LampShabby_F","a3\structures_f\civ\lamps\lampshabby_f.p3d",[16929.6,9922.83,21.1602],[[-0.969228,-0.246166,0],[0,0,1]],0,1,0,[],{}],
				["Land_Bunker_01_small_F","a3\structures_f_argo\military\bunkers\bunker_01_small_f.p3d",[16931.8,9920.04,18.3],[[0,1,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[16938.5,9921.08,18.5397],[[-0.0224815,-0.999747,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[16941.2,9928.78,18.4663],[[0.999753,-0.0222188,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[16941.1,9923.66,18.4501],[[0.999753,-0.0222188,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[16941.3,9948.25,18.1795],[[0.999753,-0.0222188,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[16941.3,9933.84,18.3397],[[0.999753,-0.0222188,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[16942.8,9952.12,17.1896],[[0.694,-0.719975,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[16946.2,9955.97,18.4315],[[0.779549,-0.626341,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[16949.5,9959.95,18.8474],[[0.779549,-0.626341,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[16941.5,9944.06,18.2298],[[0.999753,-0.0222188,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[16941.4,9938.94,18.1876],[[0.999753,-0.0222188,0],[0,0,1]],0,0,2,[],{}],
				["Land_Shed_Small_F","a3\structures_f\ind\shed\shed_small_f.p3d",[16948.5,9967.19,19.9297],[[-0.611393,-0.791327,0],[0,0,1]],0,0,2,[],{}],
				["Land_Excavator_01_abandoned_F","a3\props_f_exp\industrial\heavyequipment\excavator_01_abandoned_f.p3d",[16930,10013.6,19.0456],[[0.381902,0.9242,0.00235224],[-0.0704912,0.0265908,0.997158]],0,0,2,[],{}],
				["Land_Barn_01_brown_F","a3\structures_f_argo\industrial\agriculture\barn_01_brown_f.p3d",[16937.8,10001.6,18.5522],[[-0.659385,0.751805,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[16922.9,10013.9,16.6273],[[-0.574581,0.818448,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[16927.1,10016.8,16.488],[[-0.574581,0.818448,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[16931.3,10019.8,16.6524],[[-0.574581,0.818448,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[16943.8,10028.6,16.9494],[[-0.574581,0.818448,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[16935.4,10022.7,16.8169],[[-0.574581,0.818448,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[16939.6,10025.6,16.8648],[[-0.574581,0.818448,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[16947.4,10028.2,17.3823],[[0.78791,0.615791,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bulldozer_01_abandoned_F","a3\props_f_exp\industrial\heavyequipment\bulldozer_01_abandoned_f.p3d",[16962.8,9982.66,18.9314],[[-0.623473,-0.781809,-0.00748543],[-0.0053265,-0.00532647,0.999972]],0,0,2,[],{}],
				["Land_Bunker_01_tall_F","a3\structures_f_argo\military\bunkers\bunker_01_tall_f.p3d",[16972.2,9988.73,21.1151],[[-0.999763,0.0217812,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[16967.8,9983.34,18.8175],[[0.779549,-0.626341,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[16955.8,9967.93,18.8243],[[0.779549,-0.626341,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[16952.6,9963.93,18.6977],[[0.779549,-0.626341,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[16959,9971.9,18.7238],[[0.779549,-0.626341,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[16961.3,9975.38,18.6905],[[0.779549,-0.626341,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[16964.5,9979.36,18.6022],[[0.779549,-0.626341,0],[0,0,1]],0,0,2,[],{}],
				["Land_LampShabby_F","a3\structures_f\civ\lamps\lampshabby_f.p3d",[16967.3,9993.52,21.2433],[[-0.570476,0.821314,0],[0,0,1]],0,1,0,[],{}],
				["Land_Bunker_01_small_F","a3\structures_f_argo\military\bunkers\bunker_01_small_f.p3d",[16960,10014.3,18.3526],[[-0.763873,-0.645367,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_1_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_1_f.p3d",[16955.8,10017.6,17.5304],[[0.772714,0.634754,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[16968.1,9994.14,18.822],[[0.612919,0.790146,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[16953.8,10020.3,18.3705],[[0.78791,0.615791,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[16950.6,10024.2,17.9347],[[0.78791,0.615791,0],[0,0,1]],0,0,2,[],{}]
			],
			[
				["B_Quadbike_01_F",[16887.9,9976.83,-0.00983047],249.443],
				["B_Quadbike_01_F",[16888.9,9973.17,-0.00904083],247.482],
				["B_MRAP_01_F",[16889.8,10002.5,0.00481033],155.721],
				["B_MRAP_01_F",[16874.3,9996.34,-0.00241661],155.69],
				["B_MRAP_01_F",[16882,9999.41,0.00616455],155.69],
				["B_Truck_01_transport_F",[16936.4,9942.61,0.0241432],360],
				["B_G_Offroad_01_AT_F",[16946.8,9968.09,0.00372124],309.319],
				["B_G_Offroad_01_armed_F",[16951.9,9974.55,0.0277157],312.59]
			],
			[16895.7,9933.64,0.00159073],
			[16875.4,9971.99,0.00147057],
			localize 'STR_QS_Utility_016'
		];
	};
	if (_type isEqualTo 4) then {
		/*/southwest/*/
		_return = [
			[7370.73,11433.4],
			[
				["FlagPole_F","a3\structures_f\mil\flags\mast_f.p3d",[7363.89,11439,17.8208],[[0,1,0],[0,0,1]],0,1,0,[],{
					missionNamespace setVariable ['QS_module_fob_flag',(_this # 0),TRUE];
					(_this # 0) addEventHandler [
						'Deleted',
						{
							params ['_entity'];
							missionNamespace setVariable ['QS_module_fob_respawnTickets',(round (((_entity getVariable ['QS_deploy_tickets',0]) / 2) max 0)),FALSE];
						}
					];
				}],
				["Land_RepairDepot_01_tan_F","a3\structures_f_tank\military\repairdepot\repairdepot_01_tan_f.p3d",[7347.94,11443.9,14.9372],[[0.0611946,0.998125,-0.00118032],[-0.015698,0.00214483,0.999874]],0,0,2,[],{
					missionNamespace setVariable ['QS_module_fob_repairDepot',(_this # 0),FALSE];
					(_this # 0) hideObjectGlobal TRUE;
				}],
				["Land_Bunker_01_HQ_F","a3\structures_f_argo\military\bunkers\bunker_01_hq_f.p3d",[7357.52,11435.5,15.0296],[[0,1,0],[0,0,1]],0,0,2,[],{
					_building = _this # 0;
					missionNamespace setVariable ['QS_module_fob_HQ',_building,TRUE];
					[_building] spawn {
						_building = _this # 0;
						_building enableSimulationGlobal TRUE;
						_dataTerminal = createSimpleObject ['Land_DataTerminal_01_F',(getPosWorld _building)];
						[1,_dataTerminal,[_building,[-0.6,0,-1]]] call QS_fnc_eventAttach;
						_dataTerminal setDir 90;
						sleep 0.1;
						[0,_dataTerminal] call QS_fnc_eventAttach;
						missionNamespace setVariable ['QS_module_fob_dataTerminal',_dataTerminal,TRUE];
						_crate = createSimpleObject ['a3\weapons_f\ammoboxes\supplydrop.p3d',(getPosWorld _building)];
						[1,_crate,[_building,[0.7,0,0]]] call QS_fnc_eventAttach;
						_crate setDir 90;
						sleep 0.1;
						[0,_crate] call QS_fnc_eventAttach;
						_crate hideObjectGlobal TRUE;
						missionNamespace setVariable ['QS_module_fob_supplycrate',_crate,FALSE];
						sleep 1;
						_building enableSimulationGlobal FALSE;
					};	
				}],
				["Land_PortableCabinet_01_medical_F","a3\props_f_enoch\military\camps\portablecabinet_01_medical_f.p3d",[7355.05,11437.1,14.4642],[[-0.999998,-0.00175602,0],[0,0,1]],0,0,2,[],{}],
				["Land_LampShabby_F","a3\structures_f\civ\lamps\lampshabby_f.p3d",[7330.72,11384.1,16.4845],[[0.873648,-0.486558,0],[0,0,1]],0,1,0,[],{}],
				["Land_Bunker_01_small_F","a3\structures_f_argo\military\bunkers\bunker_01_small_f.p3d",[7348,11380.3,14.0133],[[0,1,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[7329.92,11388.7,13.6738],[[-0.999837,-0.0180597,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[7329.8,11393.9,13.6023],[[-0.999837,-0.0180597,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[7329.62,11399,13.7583],[[-0.999837,-0.0180597,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[7329.93,11383.5,13.776],[[-0.999837,-0.0180597,0],[0,0,1]],0,0,2,[],{}],
				["Land_LampShabby_F","a3\structures_f\civ\lamps\lampshabby_f.p3d",[7330,11426.4,15.8881],[[0.0560974,0.998425,0],[0,0,1]],0,1,0,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[7329.62,11404.2,13.7897],[[-0.999837,-0.0180597,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[7329.4,11414.5,13.5275],[[-0.999837,-0.0180597,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[7329.5,11409.4,13.7096],[[-0.999837,-0.0180597,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[7329.39,11419.6,13.4008],[[-0.999837,-0.0180597,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[7329.27,11424.8,13.2237],[[-0.999837,-0.0180597,0],[0,0,1]],0,0,2,[],{}],
				["Land_LampShabby_F","a3\structures_f\civ\lamps\lampshabby_f.p3d",[7332.12,11456,15.6033],[[-0.37797,-0.925818,0],[0,0,1]],0,1,0,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[7331.68,11457.7,12.5804],[[-0.960364,0.278749,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[7333.64,11462,12.3392],[[-0.783855,0.620944,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[7347.32,11477.3,13.4478],[[-0.690737,0.723106,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[7336.93,11466,12.9305],[[-0.783855,0.620944,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[7343.52,11473.8,13.3391],[[-0.690737,0.723106,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[7340.12,11470.1,13.0081],[[-0.783855,0.620944,0],[0,0,1]],0,0,2,[],{}],
				["Land_Cargo20_military_green_F","a3\structures_f\ind\cargo\cargo20_military_green_f.p3d",[7356.63,11384.7,15.1089],[[-0.000644651,0.999813,0.019317],[-0.0744609,-0.0193114,0.997037]],0,0,2,[],{}],
				["Land_Cargo20_military_green_F","a3\structures_f\ind\cargo\cargo20_military_green_f.p3d",[7356.59,11389.2,15.2232],[[9.76586e-005,0.999529,0.0306779],[-0.0827412,-0.0305646,0.996102]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[7375.6,11381.3,15.6823],[[0.0144187,-0.999896,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[7360.11,11381.1,15.0596],[[-0.00890943,-0.99996,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[7365.24,11381.2,15.3128],[[0.0144187,-0.999896,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[7370.41,11381.3,15.4875],[[0.0144187,-0.999896,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[7354.93,11381.3,14.7127],[[-0.00890943,-0.99996,0],[0,0,1]],0,0,2,[],{}],
				["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[7364.09,11432.5,19.7682],[[0.0115341,-0.999933,0],[0,0,1]],0,1,0,[],{}],
				["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[7364.07,11431.6,19.748],[[-0.999562,0.0295801,0],[0,0,1]],0,1,0,[],{}],
				["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[7364.11,11433.4,19.7906],[[1,-0.000520511,0],[0,0,1]],0,1,0,[],{}],
				["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[7364.63,11432,19.8449],[[-0.733453,-0.679741,0],[0,0,1]],0,1,0,[],{}],
				["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[7364.71,11433.1,19.8784],[[0.740073,-0.672527,0],[0,0,1]],0,1,0,[],{}],
				["Land_LampShabby_F","a3\structures_f\civ\lamps\lampshabby_f.p3d",[7351.84,11441.3,16.4031],[[-0.559613,-0.828754,0],[0,0,1]],0,1,0,[],{}],
				["Land_TTowerSmall_2_F","a3\structures_f\ind\transmitter_tower\ttowersmall_2_f.p3d",[7356.98,11442.2,21.2417],[[0.999935,0.0114083,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[7358.69,11487.7,14.5434],[[-0.679067,0.734076,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[7354.83,11484.2,14.1015],[[-0.679067,0.734076,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[7351.05,11480.9,13.7335],[[-0.690737,0.723106,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[7366.44,11494.4,14.4735],[[-0.594737,0.80392,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[7374.8,11500.6,14.7631],[[-0.594737,0.80392,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[7370.66,11497.5,14.6536],[[-0.594737,0.80392,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[7362.47,11491.2,14.2901],[[-0.679067,0.734076,0],[0,0,1]],0,0,2,[],{}],
				["Land_Mil_WallBig_4m_F","a3\structures_f\walls\mil_wallbig_4m_f.p3d",[7404.84,11387,17.393],[[0.950122,-0.31188,0],[0,0,1]],0,0,2,[],{}],
				["Land_Mil_WallBig_4m_F","a3\structures_f\walls\mil_wallbig_4m_f.p3d",[7407.51,11398.2,17.3957],[[0.981391,-0.192018,0],[0,0,1]],0,0,2,[],{}],
				["Land_Mil_WallBig_4m_F","a3\structures_f\walls\mil_wallbig_4m_f.p3d",[7406.7,11394.5,17.4103],[[0.970622,-0.240608,0],[0,0,1]],0,0,2,[],{}],
				["Land_Mil_WallBig_4m_F","a3\structures_f\walls\mil_wallbig_4m_f.p3d",[7405.82,11390.7,17.4099],[[0.97432,-0.225169,0],[0,0,1]],0,0,2,[],{}],
				["Land_Mil_WallBig_4m_F","a3\structures_f\walls\mil_wallbig_4m_f.p3d",[7402.69,11383.9,17.3192],[[0.642885,-0.765962,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bulldozer_01_abandoned_F","a3\props_f_exp\industrial\heavyequipment\bulldozer_01_abandoned_f.p3d",[7397.08,11385.8,16.5177],[[0.999593,0.0055347,0.0279671],[-0.0279894,0.00399518,0.9996]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[7407.4,11394.8,16.351],[[0.981839,-0.189714,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[7406.33,11389.7,16.3545],[[0.981839,-0.189714,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[7380.67,11381.3,15.8593],[[0.0242013,-0.999707,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[7385.84,11381.5,15.9501],[[0.0242013,-0.999707,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[7391.02,11381.5,16.002],[[0.0242013,-0.999707,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[7408.47,11399.7,16.3266],[[0.969462,-0.245243,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[7396.09,11381.7,16.057],[[0.0242013,-0.999707,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[7404.97,11384.8,16.3249],[[0.930451,-0.366417,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[7401.2,11381.8,16.1972],[[0.0242013,-0.999707,0],[0,0,1]],0,0,2,[],{}],
				["Land_Mil_WallBig_4m_F","a3\structures_f\walls\mil_wallbig_4m_f.p3d",[7409.33,11405.7,17.2973],[[0.977915,-0.209005,0],[0,0,1]],0,0,2,[],{}],
				["Land_Mil_WallBig_4m_F","a3\structures_f\walls\mil_wallbig_4m_f.p3d",[7408.42,11401.9,17.3647],[[0.963018,-0.269438,0],[0,0,1]],0,0,2,[],{}],
				["Land_HelipadCircle_F","a3\structures_f\mil\helipads\helipadcircle_f.p3d",[7384.99,11400.1,14.6803],[[0.99746,-0.0680727,0.0209896],[-0.0186628,0.0346395,0.999226]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[7409.65,11404.6,16.2493],[[0.979733,-0.200309,0],[0,0,1]],0,0,2,[],{}],
				["Land_Shed_Small_F","a3\structures_f\ind\shed\shed_small_f.p3d",[7404.7,11452.1,17.6486],[[0.558469,-0.829526,0],[0,0,1]],0,0,2,[],{}],
				["Land_Excavator_01_abandoned_F","a3\props_f_exp\industrial\heavyequipment\excavator_01_abandoned_f.p3d",[7408.86,11432.1,18.0454],[[-0.00359072,0.999993,-0.0013707],[-0.0093285,0.00133715,0.999956]],0,0,2,[],{}],
				["Land_Barn_01_brown_F","a3\structures_f_argo\industrial\agriculture\barn_01_brown_f.p3d",[7384.05,11433.4,15.8085],[[-0.0627283,-0.998031,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[7409.51,11453.5,16.0054],[[0.856116,0.516784,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[7407.28,11457.1,15.9876],[[0.844138,0.536126,0],[0,0,1]],0,0,2,[],{}],
				["Land_Shed_Small_F","a3\structures_f\ind\shed\shed_small_f.p3d",[7391.63,11472,17.1904],[[0.556582,-0.830793,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_small_F","a3\structures_f_argo\military\bunkers\bunker_01_small_f.p3d",[7387.71,11488.3,14.7835],[[-0.811354,-0.584555,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[7398.92,11470,15.9451],[[0.83535,0.549718,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[7404.58,11461.5,15.97],[[0.844138,0.536126,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[7396.11,11474.4,15.9462],[[0.830267,0.557365,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[7401.83,11465.7,15.9556],[[0.830267,0.557365,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[7393.22,11478.6,15.4895],[[0.819028,0.573753,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[7390.23,11482.9,15.2599],[[0.819028,0.573753,0],[0,0,1]],0,0,2,[],{}],
				["Land_LampShabby_F","a3\structures_f\civ\lamps\lampshabby_f.p3d",[7383.65,11490,17.6725],[[-0.511776,0.859119,0],[0,0,1]],0,1,0,[],{}],
				["Land_LampShabby_F","a3\structures_f\civ\lamps\lampshabby_f.p3d",[7411.47,11421.2,18.6631],[[-0.0959464,-0.995386,0],[0,0,1]],0,1,0,[],{}],
				["Land_Mil_WallBig_4m_F","a3\structures_f\walls\mil_wallbig_4m_f.p3d",[7412.03,11427.5,17.1245],[[0.990901,-0.134594,0],[0,0,1]],0,0,2,[],{}],
				["Land_Mil_WallBig_4m_F","a3\structures_f\walls\mil_wallbig_4m_f.p3d",[7411.67,11423.6,17.0915],[[0.997208,-0.074679,0],[0,0,1]],0,0,2,[],{}],
				["Land_Mil_WallBig_4m_F","a3\structures_f\walls\mil_wallbig_4m_f.p3d",[7410.01,11409.5,17.2113],[[0.990901,-0.134594,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_1_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_1_f.p3d",[7411.2,11413,15.1067],[[0.996871,-0.0790408,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_1_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_1_f.p3d",[7412.06,11419.9,15.0643],[[0.996871,-0.0790408,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[7410.62,11409.7,16.14],[[0.979733,-0.200309,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[7412.26,11423.2,15.9641],[[0.995091,-0.0989645,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[7412.53,11426.9,15.9943],[[0.995091,-0.0989645,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_1_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_1_f.p3d",[7413.18,11442,16.0386],[[0.996326,-0.085644,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_tall_F","a3\structures_f_argo\military\bunkers\bunker_01_tall_f.p3d",[7414.54,11432.9,18.5006],[[-0.99965,0.0264671,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[7413.11,11439,16.0816],[[0.998582,-0.0532351,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[7413.32,11444.6,16.0929],[[0.997943,-0.0641136,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[7412.12,11449.3,16.0561],[[0.844449,0.535636,0],[0,0,1]],0,0,2,[],{}]
			],
			[
				["B_Quadbike_01_F",[7358.72,11427.5,0.00548935],181.129],
				["B_Quadbike_01_F",[7361.85,11427.5,0.00237751],179.734],
				["B_G_Offroad_01_F",[7399.16,11458.2,-0.0286922],236.93],
				["B_G_Offroad_01_armed_F",[7402.32,11453.2,-0.0541878],230.705],
				["B_Truck_01_transport_F",[7389.56,11440.7,0.0324707],272.339],
				["B_MRAP_01_F",[7389.78,11470.6,0.0311069],235.601],
				["B_MRAP_01_F",[7393.9,11464.1,-0.00195313],235.777],
				["B_MRAP_01_F",[7385.48,11477.4,0.0118809],235.75]
			],
			[7384.95,11400.3,0.00133705],
			[7343.82,11444.5,0.00141335],
			localize 'STR_QS_Utility_017'
		];
	};
	_return;
};
if (_worldName isEqualTo 'Tanoa') exitWith {
	private _return = [];
	if (_type isEqualTo 0) then {
		/*/ main island /*/
		_return = [
			[11018.4, 11507.8],
			[
				["FlagPole_F","a3\structures_f\mil\flags\mast_f.p3d",[11076.8,11517.8,354.436],[[0,1,0],[0,0,1]],0,1,0,[],{
					missionNamespace setVariable ['QS_module_fob_flag',(_this # 0),TRUE];
					(_this # 0) addEventHandler [
						'Deleted',
						{
							params ['_entity'];
							missionNamespace setVariable ['QS_module_fob_respawnTickets',(round (((_entity getVariable ['QS_deploy_tickets',0]) / 2) max 0)),FALSE];
						}
					];
				}],
				["Land_RepairDepot_01_green_F","a3\structures_f_tank\military\repairdepot\repairdepot_01_green_f.p3d",[11129.2,11485.5,352.852],[[0.0869649,0.996084,-0.0159507],[0.000190131,0.0159948,0.999872]],0,0,2,[],{
					missionNamespace setVariable ['QS_module_fob_repairDepot',(_this # 0),FALSE];
					(_this # 0) hideObjectGlobal TRUE;				
				}],
				["Land_Bunker_01_HQ_F","a3\structures_f_argo\military\bunkers\bunker_01_hq_f.p3d",[11083.3,11522.4,352.194],[[-0.050258,-0.998736,0],[0,0,1]],0,0,2,[],{
					_building = _this # 0;
					missionNamespace setVariable ['QS_module_fob_HQ',_building,TRUE];
					[_building] spawn {
						_building = _this # 0;
						_building enableSimulationGlobal TRUE;
						_dataTerminal = createSimpleObject ['Land_DataTerminal_01_F',(getPosWorld _building)];
						[1,_dataTerminal,[_building,[-0.6,0,-1]]] call QS_fnc_eventAttach;
						_dataTerminal setDir 90;
						sleep 0.1;
						[0,_dataTerminal] call QS_fnc_eventAttach;
						missionNamespace setVariable ['QS_module_fob_dataTerminal',_dataTerminal,TRUE];
						_crate = createSimpleObject ['a3\weapons_f\ammoboxes\supplydrop.p3d',(getPosWorld _building)];
						[1,_crate,[_building,[0.7,0,0]]] call QS_fnc_eventAttach;
						_crate setDir 90;
						sleep 0.1;
						[0,_crate] call QS_fnc_eventAttach;
						_crate hideObjectGlobal TRUE;
						missionNamespace setVariable ['QS_module_fob_supplycrate',_crate,FALSE];
						sleep 1;
						_building enableSimulationGlobal FALSE;
					};				
				}],
				["Land_PortableCabinet_01_medical_F","a3\props_f_enoch\military\camps\portablecabinet_01_medical_f.p3d",[11085.7,11520.7,351.63],[[0.999343,-0.0362502,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_small_F","a3\structures_f_argo\military\bunkers\bunker_01_small_f.p3d",[10841,11446.4,348.413],[[0.884618,-0.466316,0],[0,0,1]],0,0,2,[],{}],
				["Land_LampShabby_F","a3\structures_f\civ\lamps\lampshabby_f.p3d",[10978.4,11475.2,354.588],[[0.997655,-0.0684497,0],[0,0,1]],0,1,0,[],{}],
				["Land_Bunker_01_small_F","a3\structures_f_argo\military\bunkers\bunker_01_small_f.p3d",[10971.8,11478.2,352.518],[[0.937854,0.34703,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[10972.2,11483.7,352.383],[[-0.72333,0.690502,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[10973.8,11487.4,352.258],[[-0.99983,-0.0184454,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[10976.4,11474.4,351.642],[[-0.0618431,-0.998086,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[10973.7,11492.5,352.251],[[-0.99983,-0.0184454,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[10975.5,11501.8,351.578],[[-0.704402,0.709801,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[10973.6,11497.6,351.988],[[-0.99983,-0.0184454,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[10979.1,11505.5,351.378],[[-0.704402,0.709801,0],[0,0,1]],0,0,2,[],{}],
				["Land_LampShabby_F","a3\structures_f\civ\lamps\lampshabby_f.p3d",[10995.6,11474.3,354.899],[[-0.993937,0.109955,0],[0,0,1]],0,1,0,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11002,11472.9,351.969],[[-0.0618431,-0.998086,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[10996.9,11473.2,352.039],[[-0.0618431,-0.998086,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11007.1,11472.6,352.119],[[-0.0618431,-0.998086,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[10982.7,11509.1,351.378],[[-0.704402,0.709801,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[10990,11516.3,351.525],[[-0.704402,0.709801,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[10986.3,11512.7,351.577],[[-0.704402,0.709801,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[10993.6,11520,351.465],[[-0.714964,0.699162,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[10997.1,11523.6,351.468],[[-0.714964,0.699162,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11004.3,11531,351.586],[[-0.714964,0.699162,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11000.7,11527.3,351.489],[[-0.714964,0.699162,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11006.4,11533.3,351.563],[[-0.714964,0.699162,0],[0,0,1]],0,0,2,[],{}],
				["Land_LampShabby_F","a3\structures_f\civ\lamps\lampshabby_f.p3d",[11031.5,11472.5,354.284],[[-0.999477,-0.0323344,0],[0,0,1]],0,1,0,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11037.9,11470.8,351.667],[[-0.0618431,-0.998086,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11012.3,11472.3,351.738],[[-0.0618431,-0.998086,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11020.8,11471.7,350.966],[[-0.0618431,-0.998086,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11017.4,11472,351.282],[[-0.0618431,-0.998086,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11032.7,11471.1,351.225],[[-0.0618431,-0.998086,0],[0,0,1]],0,0,2,[],{}],
				["Land_HelipadCircle_F","a3\structures_f\mil\helipads\helipadcircle_f.p3d",[11035.6,11500.5,350.483],[[0.999156,-0.0305533,0.027468],[-0.0266571,0.0266409,0.99929]],0,0,2,[],{}],
				["Land_Bunker_01_tall_F","a3\structures_f_argo\military\bunkers\bunker_01_tall_f.p3d",[11011.1,11537.2,353.995],[[0.368149,-0.929767,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11027.6,11536,352.842],[[0.0380441,0.999276,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11032.7,11535.8,353.386],[[0.0380441,0.999276,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11017.8,11536.4,351.712],[[0.0380441,0.999276,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11037.7,11535.7,353.356],[[0.0474129,0.998875,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11022.4,11536.2,352.12],[[0.0380441,0.999276,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11063.5,11469.3,352.18],[[-0.0618431,-0.998086,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11053.2,11469.9,351.571],[[-0.0618431,-0.998086,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11068.6,11469,352.328],[[-0.0618431,-0.998086,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11048.1,11470.2,351.613],[[-0.0618431,-0.998086,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11058.3,11469.6,351.84],[[-0.0618431,-0.998086,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11043,11470.5,351.939],[[-0.0618431,-0.998086,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11053.1,11535,351.871],[[0.0474129,0.998875,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11047.9,11535.2,352.28],[[0.0474129,0.998875,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11058.2,11534.8,352.144],[[0.0474129,0.998875,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11042.8,11535.5,352.855],[[0.0474129,0.998875,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11063.4,11534.5,352.95],[[0.0574117,0.998351,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11068.5,11534.3,352.974],[[0.0574117,0.998351,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11083.9,11468.1,352.374],[[-0.0618431,-0.998086,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11099.2,11467.2,352.621],[[-0.0618431,-0.998086,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11089,11467.8,352.55],[[-0.0618431,-0.998086,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11073.7,11468.7,352.359],[[-0.0618431,-0.998086,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11094.1,11467.5,352.645],[[-0.0618431,-0.998086,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11078.8,11468.4,352.324],[[-0.0618431,-0.998086,0],[0,0,1]],0,0,2,[],{}],
				["Land_LampShabby_F","a3\structures_f\civ\lamps\lampshabby_f.p3d",[11083.2,11516.1,354.175],[[-0.950446,0.310889,0],[0,0,1]],0,1,0,[],{}],
				["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[11083,11515.2,356.372],[[-0.619952,0.78464,0],[0,0,1]],0,1,0,[],{}],
				["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[11083,11515.8,356.378],[[0.0650705,0.997881,0],[0,0,1]],0,1,0,[],{}],
				["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[11084.8,11515.1,356.394],[[-0.7666,-0.642125,0],[0,0,1]],0,1,0,[],{}],
				["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[11085,11515.6,356.403],[[-0.0742596,-0.997239,0],[0,0,1]],0,1,0,[],{}],
				["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[11084,11515.7,356.391],[[-0.997669,0.0682419,0],[0,0,1]],0,1,0,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11073.6,11534,352.151],[[0.0574117,0.998351,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11094.1,11533,351.901],[[0.0318885,0.999491,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11099.2,11532.9,351.588],[[0.0318885,0.999491,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11083.9,11533.4,352.358],[[0.0574117,0.998351,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11078.8,11533.7,351.695],[[0.0574117,0.998351,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11089,11533.2,352.27],[[0.0318885,0.999491,0],[0,0,1]],0,0,2,[],{}],
				["Land_Shed_Small_F","a3\structures_f\ind\shed\shed_small_f.p3d",[11106.5,11471.8,353.418],[[-0.999869,0.0162099,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_1_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_1_f.p3d",[11127.4,11469,351.59],[[0.408541,-0.91274,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11124.4,11467.5,351.552],[[0.421045,-0.90704,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11104.3,11466.9,352.573],[[-0.0272484,-0.999629,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11109.5,11466.8,352.23],[[-0.0272484,-0.999629,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11119.7,11466.5,351.502],[[-0.0272484,-0.999629,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11114.6,11466.7,351.765],[[-0.0272484,-0.999629,0],[0,0,1]],0,0,2,[],{}],
				["Land_Shed_Small_F","a3\structures_f\ind\shed\shed_small_f.p3d",[11107.6,11527.5,353.397],[[0.998932,-0.04621,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11119.7,11532.2,351.822],[[0.0405346,0.999178,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11114.6,11532.4,351.841],[[0.0405346,0.999178,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11124.8,11532,351.635],[[0.0405346,0.999178,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11104.4,11532.8,351.63],[[0.0318885,0.999491,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11129.9,11531.9,352.554],[[0.0405346,0.999178,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11109.5,11532.6,351.509],[[0.0318885,0.999491,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_small_F","a3\structures_f_argo\military\bunkers\bunker_01_small_f.p3d",[11131.5,11471.1,351.224],[[-0.720131,0.693838,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11134.3,11482.9,351.367],[[0.997787,-0.0664858,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11133.9,11477.7,351.568],[[0.997811,-0.0661265,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11134.6,11488,351.448],[[0.997787,-0.0664858,0],[0,0,1]],0,0,2,[],{}],
				["Land_LampShabby_F","a3\structures_f\civ\lamps\lampshabby_f.p3d",[11134.1,11493.3,354.154],[[0.179063,0.983838,0],[0,0,1]],0,1,0,[],{}],
				["Land_LampShabby_F","a3\structures_f\civ\lamps\lampshabby_f.p3d",[11135.1,11509.1,354.152],[[-0.0179168,-0.999839,0],[0,0,1]],0,1,0,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11136.1,11510.1,351.329],[[0.997813,-0.0660938,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11134.9,11491.4,351.345],[[0.997787,-0.0664858,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11136.6,11518.7,352.175],[[0.997813,-0.0660938,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11136.3,11513.6,351.526],[[0.997813,-0.0660938,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_small_F","a3\structures_f_argo\military\bunkers\bunker_01_small_f.p3d",[11135.8,11529.3,353.009],[[-0.784654,-0.619934,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11136.9,11523.8,352.823],[[0.997813,-0.0660938,0],[0,0,1]],0,0,2,[],{}]
			],
			[	
				["B_T_LSV_01_armed_F",[11098.4,11472.8,0.0808105],2.71772],
				["B_T_Truck_01_transport_F",[11081,11473.9,0.202972],93.8118],
				["B_T_Quadbike_01_F",[11091.5,11518.2,-0.00732422],89.5248],
				["B_T_Quadbike_01_F",[11091.6,11521.7,-0.00967407],89.4222],
				["B_T_LSV_01_AT_F",[11106.3,11472.6,0.0401917],3.4797],
				["B_T_LSV_01_armed_F",[11107.4,11526.5,-0.0235596],182.453],
				["B_T_LSV_01_unarmed_F",[11100,11527.3,-0.0106201],183.908],
				["B_T_LSV_01_unarmed_F",[11115.6,11526.1,-0.0115051],184.125]
			],
			[11035.9,11500.4,0.00149536],
			[11125.6,11486.2,0.00143433],
			'Kokoda'
		];
	};
	if (_type isEqualTo 1) then {
		/*/ south island /*/
		_return = [
			[11673.3, 4402.3],
			[
				["FlagPole_F","a3\structures_f\mil\flags\mast_f.p3d",[11655.3,4399.4,157.046],[[0.76876,0.639538,0],[0,0,1]],0,1,0,[],{
					missionNamespace setVariable ['QS_module_fob_flag',(_this # 0),TRUE];
					(_this # 0) addEventHandler [
						'Deleted',
						{
							params ['_entity'];
							missionNamespace setVariable ['QS_module_fob_respawnTickets',(round (((_entity getVariable ['QS_deploy_tickets',0]) / 2) max 0)),FALSE];
						}
					];
				}],
				["Land_RepairDepot_01_green_F","a3\structures_f_tank\military\repairdepot\repairdepot_01_green_f.p3d",[11668.3,4358.01,154.396],[[0.992776,-0.0667286,-0.0997173],[0.10212,0.0336162,0.994204]],0,0,2,[],{
					missionNamespace setVariable ['QS_module_fob_repairDepot',(_this # 0),FALSE];
					(_this # 0) hideObjectGlobal TRUE;
				}],
				["Land_Bunker_01_HQ_F","a3\structures_f_argo\military\bunkers\bunker_01_hq_f.p3d",[11654.8,4406.65,154.216],[[-0.809124,-0.587638,0],[0,0,1]],0,0,2,[],{
					_building = _this # 0;
					missionNamespace setVariable ['QS_module_fob_HQ',_building,TRUE];
					[_building] spawn {
						_building = _this # 0;
						_building enableSimulationGlobal TRUE;
						_dataTerminal = createSimpleObject ['Land_DataTerminal_01_F',(getPosWorld _building)];
						[1,_dataTerminal,[_building,[-0.6,0,-1]]] call QS_fnc_eventAttach;
						_dataTerminal setDir 90;
						sleep 0.1;
						[0,_dataTerminal] call QS_fnc_eventAttach;
						missionNamespace setVariable ['QS_module_fob_dataTerminal',_dataTerminal,TRUE];
						_crate = createSimpleObject ['a3\weapons_f\ammoboxes\supplydrop.p3d',(getPosWorld _building)];
						[1,_crate,[_building,[0.7,0,0]]] call QS_fnc_eventAttach;
						_crate setDir 90;
						sleep 0.1;
						[0,_crate] call QS_fnc_eventAttach;
						_crate hideObjectGlobal TRUE;
						missionNamespace setVariable ['QS_module_fob_supplycrate',_crate,FALSE];
						sleep 1;
						_building enableSimulationGlobal FALSE;
					};
				}],
				["Land_PortableCabinet_01_medical_F","a3\props_f_enoch\military\camps\portablecabinet_01_medical_f.p3d",[11655.1,4403.84,153.65],[[0.560795,-0.827955,0],[0,0,1]],0,0,2,[],{}],
				["Land_LampShabby_F","a3\structures_f\civ\lamps\lampshabby_f.p3d",[11643.4,4361.13,158.264],[[0.966792,-0.255565,0],[0,0,1]],0,1,0,[],{}],
				["Land_SandbagBarricade_01_half_F","a3\structures_f_argo\military\fortifications\sandbagbarricade_01_half_f.p3d",[11642.8,4360.2,155.364],[[-0.702474,-0.711709,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_small_F","a3\structures_f_argo\military\bunkers\bunker_01_small_f.p3d",[11640.3,4365.09,155.288],[[0.992999,0.118121,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11641.6,4376.45,154.282],[[-0.997671,0.0682153,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11660.1,4356.77,153.815],[[-0.999784,-0.0208062,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11663.1,4353.96,153.366],[[-0.100782,-0.994909,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11641.3,4371.31,154.388],[[-0.997671,0.0682153,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11668.3,4353.44,152.987],[[-0.09423,-0.99555,0],[0,0,1]],0,0,2,[],{}],
				["Land_Shed_Small_F","a3\structures_f\ind\shed\shed_small_f.p3d",[11647.1,4383.86,156.258],[[0.0679728,0.997687,0],[0,0,1]],0,0,2,[],{}],
				["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[11660.8,4402.24,158.433],[[-0.96499,0.262287,0],[0,0,1]],0,1,0,[],{}],
				["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[11661.2,4403.2,158.396],[[-0.834326,-0.551272,0],[0,0,1]],0,1,0,[],{}],
				["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[11662.2,4403.22,158.266],[[-0.185181,-0.982704,0],[0,0,1]],0,1,0,[],{}],
				["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[11660.3,4402.61,158.484],[[-0.557758,0.830004,0],[0,0,1]],0,1,0,[],{}],
				["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[11662,4403.73,158.293],[[0.529115,-0.84855,0],[0,0,1]],0,1,0,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11642,4381.59,154.169],[[-0.998098,0.0616455,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11642.7,4391.88,154.746],[[-0.997671,0.0682153,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11643.5,4402.19,155.477],[[-0.997671,0.0682153,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11642.3,4386.74,154.322],[[-0.997671,0.0682153,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11645.7,4406.4,154.957],[[-0.597025,0.802223,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11643.1,4397.05,155.197],[[-0.997671,0.0682153,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_1_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_1_f.p3d",[11664.5,4419.88,153.298],[[-0.385934,0.922526,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11667.4,4419.9,152.689],[[0.0785514,0.99691,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11657.9,4415.16,153.512],[[-0.59173,0.806136,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11662,4418.2,153.468],[[-0.59173,0.806136,0],[0,0,1]],0,0,2,[],{}],
				["Land_Cargo20_military_green_F","a3\structures_f\ind\cargo\cargo20_military_green_f.p3d",[11680.4,4357.9,152.235],[[0.983002,-0.158381,-0.0928581],[0.0961488,0.0132259,0.995279]],0,0,2,[],{}],
				["Land_Cargo20_military_green_F","a3\structures_f\ind\cargo\cargo20_military_green_f.p3d",[11675.5,4358.36,152.696],[[0.988616,-0.127807,-0.0793911],[0.0849946,0.0389951,0.995618]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11694,4351.97,149.888],[[-0.0455704,-0.998961,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11678.5,4352.83,152.062],[[-0.0521462,-0.998639,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11673.4,4353.1,152.741],[[-0.0521462,-0.998639,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11699.1,4351.73,149.6],[[-0.0568896,-0.99838,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11683.7,4352.53,151.147],[[-0.0521462,-0.998639,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11688.8,4352.23,150.331],[[-0.0521462,-0.998639,0],[0,0,1]],0,0,2,[],{}],
				["Land_HelipadCircle_F","a3\structures_f\mil\helipads\helipadcircle_f.p3d",[11696.5,4380.78,149.625],[[-0.989143,0.136496,0.0544571],[0.047947,-0.0505396,0.99757]],0,0,2,[],{}],
				["Land_LampShabby_F","a3\structures_f\civ\lamps\lampshabby_f.p3d",[11694.3,4417.33,154.656],[[0.988624,-0.150407,0],[0,0,1]],0,1,0,[],{}],
				["Land_Shed_Small_F","a3\structures_f\ind\shed\shed_small_f.p3d",[11678.1,4413.96,153.844],[[0.994029,-0.109121,0],[0,0,1]],0,0,2,[],{}],
				["Land_SandbagBarricade_01_half_F","a3\structures_f_argo\military\fortifications\sandbagbarricade_01_half_f.p3d",[11695,4417.15,151.566],[[0.0951432,0.995464,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11693,4417.76,151.739],[[0.0915128,0.995804,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11672.4,4419.49,152.234],[[0.0809223,0.99672,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11687.8,4418.18,151.966],[[0.0809223,0.99672,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11682.7,4418.6,151.944],[[0.0809223,0.99672,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11677.5,4419.05,151.968],[[0.0809223,0.99672,0],[0,0,1]],0,0,2,[],{}],
				["Land_LampShabby_F","a3\structures_f\civ\lamps\lampshabby_f.p3d",[11719.8,4354.76,150.198],[[-0.997665,-0.0682923,0],[0,0,1]],0,1,0,[],{}],
				["Land_SandbagBarricade_01_half_F","a3\structures_f_argo\military\fortifications\sandbagbarricade_01_half_f.p3d",[11720.5,4352.4,146.933],[[0.906444,-0.422326,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_small_F","a3\structures_f_argo\military\bunkers\bunker_01_small_f.p3d",[11723.1,4356.28,147.797],[[-0.954056,0.299629,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11724.6,4373.54,148.271],[[0.995677,-0.0928849,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11724.1,4368.41,148.231],[[0.995677,-0.0928849,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11725.1,4378.7,148.242],[[0.995677,-0.0928849,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11707.7,4353.62,148.587],[[0.979067,-0.203537,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11704.3,4351.43,148.636],[[-0.0568896,-0.99838,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11723.7,4363.31,147.636],[[0.994525,-0.104498,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11725.4,4393.82,149.449],[[0.918625,0.395131,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11719.3,4408.07,149.917],[[0.918625,0.395131,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11723.3,4398.56,149.502],[[0.918625,0.395131,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11725.6,4383.82,148.374],[[0.995677,-0.0928849,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11721.3,4403.33,149.555],[[0.918625,0.395131,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11726.1,4388.96,148.863],[[0.996267,-0.0863277,0],[0,0,1]],0,0,2,[],{}],
				["Land_SandbagBarricade_01_half_F","a3\structures_f_argo\military\fortifications\sandbagbarricade_01_half_f.p3d",[11701,4416.56,151.43],[[0.0951432,0.995464,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_small_F","a3\structures_f_argo\military\bunkers\bunker_01_small_f.p3d",[11710.1,4416.96,151.633],[[-0.139288,-0.990252,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11714.8,4413.63,150.523],[[0.627028,0.778997,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11716.4,4412.07,150.572],[[0.659147,0.752014,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[11703.2,4416.73,151.396],[[0.0980668,0.99518,0],[0,0,1]],0,0,2,[],{}]
			],
			[
				["B_T_LSV_01_armed_F",[11647.6,4375.99,-0.0137482],95.3363],
				["B_T_LSV_01_AT_F",[11648.9,4391.86,0.016098],96.6668],
				["B_T_Quadbike_01_F",[11659.9,4399.43,0.0215912],144.34],
				["B_T_Quadbike_01_F",[11657.7,4397.71,0.036026],144.416],
				["B_T_LSV_01_armed_F",[11648.1,4383.9,-0.0020752],97.4776],
				["B_T_LSV_01_unarmed_F",[11669.7,4413.76,0.0231323],185.49],
				["B_T_Truck_01_transport_F",[11696.3,4355.61,0.0588837],274.828],
				["B_T_LSV_01_unarmed_F",[11677.9,4413.07,0.0438843],186.4]
			],
			[11696.4,4380.79,0.00164795],
			[11668.2,4360.46,0.00108337],
			localize 'STR_QS_Utility_019'
		];
	};	
	if (_type isEqualTo 2) then {
		_return = [
			[4920.18, 5110.65],
			[
				["FlagPole_F","a3\structures_f\mil\flags\mast_f.p3d",[4922.85,5113.25,16.482],[[0,1,0],[0,0,1]],0,1,0,[],{
					missionNamespace setVariable ['QS_module_fob_flag',(_this # 0),TRUE];
					(_this # 0) addEventHandler [
						'Deleted',
						{
							params ['_entity'];
							missionNamespace setVariable ['QS_module_fob_respawnTickets',(round (((_entity getVariable ['QS_deploy_tickets',0]) / 2) max 0)),FALSE];
						}
					];
				}],
				["Land_RepairDepot_01_green_F","a3\structures_f_tank\military\repairdepot\repairdepot_01_green_f.p3d",[4853.61,5117.14,16.0682],[[-0.651753,-0.758254,0.0164323],[0.040114,-0.0128278,0.999113]],0,0,2,[],{
					missionNamespace setVariable ['QS_module_fob_repairDepot',(_this # 0),FALSE];
					(_this # 0) hideObjectGlobal TRUE;
				}],
				["Land_Bunker_01_HQ_F","a3\structures_f_argo\military\bunkers\bunker_01_hq_f.p3d",[4928.77,5107.43,13.9648],[[0.0152582,0.999884,0],[0,0,1]],0,0,2,[],{
					_building = _this # 0;
					missionNamespace setVariable ['QS_module_fob_HQ',_building,TRUE];
					[_building] spawn {
						_building = _this # 0;
						_building enableSimulationGlobal TRUE;
						_dataTerminal = createSimpleObject ['Land_DataTerminal_01_F',(getPosWorld _building)];
						[1,_dataTerminal,[_building,[-0.6,0,-1]]] call QS_fnc_eventAttach;
						_dataTerminal setDir 90;
						sleep 0.1;
						[0,_dataTerminal] call QS_fnc_eventAttach;
						missionNamespace setVariable ['QS_module_fob_dataTerminal',_dataTerminal,TRUE];
						_crate = createSimpleObject ['a3\weapons_f\ammoboxes\supplydrop.p3d',(getPosWorld _building)];
						[1,_crate,[_building,[0.7,0,0]]] call QS_fnc_eventAttach;
						_crate setDir 90;
						sleep 0.1;
						[0,_crate] call QS_fnc_eventAttach;
						_crate hideObjectGlobal TRUE;
						missionNamespace setVariable ['QS_module_fob_supplycrate',_crate,FALSE];
						sleep 1;
						_building enableSimulationGlobal FALSE;
					};
				}],
				["Land_PortableCabinet_01_medical_F","a3\props_f_enoch\military\camps\portablecabinet_01_medical_f.p3d",[4926.32,5108.86,13.398],[[-0.999373,0.0354034,0],[0,0,1]],0,0,2,[],{}],
				["Land_SandbagBarricade_01_half_F","a3\structures_f_argo\military\fortifications\sandbagbarricade_01_half_f.p3d",[4851.8,5100.39,13.8301],[[-0.557811,-0.829968,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_small_F","a3\structures_f_argo\military\bunkers\bunker_01_small_f.p3d",[4842.78,5108.85,14.6191],[[0.997733,0.0672905,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[4851.83,5122.58,14.6513],[[-0.78185,0.623466,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[4848.6,5118.58,14.8345],[[-0.78185,0.623466,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[4846.6,5103.72,14.5548],[[-0.54965,-0.835395,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[4845.32,5114.57,14.874],[[-0.78185,0.623466,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[4848.83,5102.3,14.4339],[[-0.54965,-0.835395,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[4855.02,5126.63,14.4169],[[-0.78185,0.623466,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[4858.3,5130.64,14.6482],[[-0.78185,0.623466,0],[0,0,1]],0,0,2,[],{}],
				["Land_LampShabby_F","a3\structures_f\civ\lamps\lampshabby_f.p3d",[4864.19,5092.75,16.0336],[[-0.831699,0.555227,0],[0,0,1]],0,1,0,[],{}],
				["Land_Shed_Small_F","a3\structures_f\ind\shed\shed_small_f.p3d",[4878.45,5088.64,14.7887],[[-0.840268,0.542171,0],[0,0,1]],0,0,2,[],{}],
				["Land_SandbagBarricade_01_half_F","a3\structures_f_argo\military\fortifications\sandbagbarricade_01_half_f.p3d",[4863.08,5092.97,12.9611],[[0.57384,0.818968,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[4878.92,5082.29,12.3682],[[-0.54965,-0.835395,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[4870.35,5088.04,13.0026],[[-0.54965,-0.835395,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[4874.63,5085.19,12.7121],[[-0.54965,-0.835395,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[4866.03,5090.85,13.0761],[[-0.54965,-0.835395,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[4887.63,5076.8,12.01],[[-0.492192,-0.870486,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[4883.24,5079.49,12.3564],[[-0.54965,-0.835395,0],[0,0,1]],0,0,2,[],{}],
				["Land_Cargo20_military_green_F","a3\structures_f\ind\cargo\cargo20_military_green_f.p3d",[4860.56,5125.09,15.0077],[[-0.646873,-0.762581,-0.00515885],[0.0114903,-0.0165104,0.999798]],0,0,2,[],{}],
				["Land_Cargo20_military_green_F","a3\structures_f\ind\cargo\cargo20_military_green_f.p3d",[4863.97,5129.27,15.0222],[[-0.64634,-0.763041,0.00371782],[0.0251336,-0.0164194,0.999549]],0,0,2,[],{}],
				["Land_Bunker_01_small_F","a3\structures_f_argo\military\bunkers\bunker_01_small_f.p3d",[4879.62,5153.89,15.4867],[[0.286984,-0.957935,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[4861.53,5134.66,14.9297],[[-0.78185,0.623466,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[4889.72,5149.17,14.6601],[[0.589221,0.807972,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[4868,5142.72,14.7678],[[-0.78185,0.623466,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[4864.71,5138.71,14.8429],[[-0.78185,0.623466,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[4871.23,5146.72,14.7532],[[-0.78185,0.623466,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[4873.97,5149.6,14.8263],[[-0.642658,0.766153,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[4885.57,5152.28,14.7895],[[0.589221,0.807972,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_small_F","a3\structures_f_argo\military\bunkers\bunker_01_small_f.p3d",[4916.14,5067.28,11.4925],[[-0.836222,0.54839,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[4901.06,5069.13,11.4001],[[-0.492192,-0.870486,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[4910.4,5065.2,11.1542],[[-0.0455178,-0.998964,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[4905.54,5066.52,11.307],[[-0.492192,-0.870486,0],[0,0,1]],0,0,2,[],{}],
				["Land_Shed_Small_F","a3\structures_f\ind\shed\shed_small_f.p3d",[4899.08,5075.98,13.7126],[[-0.860929,0.508724,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[4892.1,5074.19,11.7334],[[-0.492192,-0.870486,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[4896.6,5071.69,11.6319],[[-0.492192,-0.870486,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[4918.95,5073.64,11.4182],[[0.850497,-0.52598,0],[0,0,1]],0,0,2,[],{}],
				["Land_HelipadCircle_F","a3\structures_f\mil\helipads\helipadcircle_f.p3d",[4893.11,5115.81,12.8846],[[-0.797222,0.599771,0.0686378],[0.0638687,-0.0292622,0.997529]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[4918.8,5127.8,14.153],[[0.589221,0.807972,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[4902.18,5140,14.5443],[[0.589221,0.807972,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[4910.51,5133.96,14.3704],[[0.589221,0.807972,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[4898.03,5143.11,14.54],[[0.589221,0.807972,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[4914.66,5130.86,14.2245],[[0.589221,0.807972,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[4893.85,5146.12,14.5357],[[0.589221,0.807972,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[4906.34,5136.97,14.5561],[[0.589221,0.807972,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[4932.48,5095.63,12.5496],[[0.854642,-0.519217,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[4927.08,5086.82,11.8822],[[0.854642,-0.519217,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[4921.73,5078.02,11.5227],[[0.850497,-0.52598,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[4929.83,5091.22,12.1133],[[0.854642,-0.519217,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[4924.41,5082.41,11.7938],[[0.850497,-0.52598,0],[0,0,1]],0,0,2,[],{}],
				["Land_LampShabby_F","a3\structures_f\civ\lamps\lampshabby_f.p3d",[4929.06,5119.91,16.6418],[[-0.837123,0.547014,0],[0,0,1]],0,1,0,[],{}],
				["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[4922.07,5103.24,17.8722],[[-0.997011,0.0772593,0],[0,0,1]],0,1,0,[],{}],
				["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[4922.14,5104.23,17.9202],[[0.0605569,0.998165,0],[0,0,1]],0,1,0,[],{}],
				["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[4922.13,5105.22,17.9808],[[0.996333,-0.0855564,0],[0,0,1]],0,1,0,[],{}],
				["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[4921.69,5105.13,17.9777],[[0.817282,0.576238,0],[0,0,1]],0,1,0,[],{}],
				["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[4921.59,5103.44,17.8822],[[-0.685506,0.728067,0],[0,0,1]],0,1,0,[],{}],
				["Land_SandbagBarricade_01_half_F","a3\structures_f_argo\military\fortifications\sandbagbarricade_01_half_f.p3d",[4923.82,5123.96,13.7515],[[-0.622921,-0.782285,0],[0,0,1]],0,0,2,[],{}],
				["Land_SandbagBarricade_01_half_F","a3\structures_f_argo\military\fortifications\sandbagbarricade_01_half_f.p3d",[4928.99,5120.31,13.5629],[[0.57384,0.818968,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[4931.28,5118.66,13.9086],[[0.589221,0.807972,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[4933.88,5100.16,12.8336],[[0.999928,-0.0120398,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[4921.57,5125.76,14.1053],[[0.589221,0.807972,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[4933.76,5114.65,13.8666],[[0.97413,0.225986,0],[0,0,1]],0,0,2,[],{}]
			],
			[
				["B_T_LSV_01_armed_F",[4885.7,5085.03,0.0107536],34.7073],
				["B_T_LSV_01_armed_F",[4878.74,5089.41,-0.00136852],35.5885],
				["B_T_LSV_01_unarmed_F",[4899.22,5076.92,-0.00946331],33.1819],
				["B_T_LSV_01_AT_F",[4906.42,5072.76,0.00765419],33.1828],
				["B_T_LSV_01_unarmed_F",[4892.45,5080.95,-0.0166426],33.1285],
				["B_T_Quadbike_01_F",[4920,5111.32,-0.0307856],271.692],
				["B_T_Truck_01_transport_F",[4922.41,5084.87,0.109887],30.268],
				["B_T_Quadbike_01_F",[4920.06,5107.87,0.0376863],272.004]
			],
			[4892.86,5115.73,0.00131226],
			[4854.78,5113.15,0.00145626],
			localize 'STR_QS_Utility_020'		
		];
	};
	if (_type isEqualTo 3) then {
		_return = [
			[4002.96, 11802.3],
			[
				["FlagPole_F","a3\structures_f\mil\flags\mast_f.p3d",[3966.5,11806.9,28.3032],[[0,1,0],[0,0,1]],0,1,0,[],{
					missionNamespace setVariable ['QS_module_fob_flag',(_this # 0),TRUE];
					(_this # 0) addEventHandler [
						'Deleted',
						{
							params ['_entity'];
							missionNamespace setVariable ['QS_module_fob_respawnTickets',(round (((_entity getVariable ['QS_deploy_tickets',0]) / 2) max 0)),FALSE];
						}
					];
				}],
				["Land_RepairDepot_01_green_F","a3\structures_f_tank\military\repairdepot\repairdepot_01_green_f.p3d",[3965.69,11831.3,26.1683],[[-0.721859,-0.688597,0.0689461],[0.0133362,0.0857672,0.996226]],0,0,2,[],{
					missionNamespace setVariable ['QS_module_fob_repairDepot',(_this # 0),FALSE];
					(_this # 0) hideObjectGlobal TRUE;				
				}],
				["Land_Bunker_01_HQ_F","a3\structures_f_argo\military\bunkers\bunker_01_hq_f.p3d",[3960.55,11812.1,26.5526],[[0,1,0],[0,0,1]],0,0,2,[],{
					_building = _this # 0;
					missionNamespace setVariable ['QS_module_fob_HQ',_building,TRUE];
					[_building] spawn {
						_building = _this # 0;
						_building enableSimulationGlobal TRUE;
						_dataTerminal = createSimpleObject ['Land_DataTerminal_01_F',(getPosWorld _building)];
						[1,_dataTerminal,[_building,[-0.6,0,-1]]] call QS_fnc_eventAttach;
						_dataTerminal setDir 90;
						sleep 0.1;
						[0,_dataTerminal] call QS_fnc_eventAttach;
						missionNamespace setVariable ['QS_module_fob_dataTerminal',_dataTerminal,TRUE];
						_crate = createSimpleObject ['a3\weapons_f\ammoboxes\supplydrop.p3d',(getPosWorld _building)];
						[1,_crate,[_building,[0.7,0,0]]] call QS_fnc_eventAttach;
						_crate setDir 90;
						sleep 0.1;
						[0,_crate] call QS_fnc_eventAttach;
						_crate hideObjectGlobal TRUE;
						missionNamespace setVariable ['QS_module_fob_supplycrate',_crate,FALSE];
						sleep 1;
						_building enableSimulationGlobal FALSE;
					};				
				}],
				["Land_PortableCabinet_01_medical_F","a3\props_f_enoch\military\camps\portablecabinet_01_medical_f.p3d",[3958.1,11813.6,25.9886],[[-0.999246,0.0388263,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[3954.82,11819.5,25.5693],[[-0.999998,0.00178052,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[3955.17,11804.7,25.4478],[[-0.999998,0.00178052,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[3959.94,11790.7,25.1846],[[-0.749832,-0.661628,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[3955.21,11799.6,25.4852],[[-0.999998,0.00178052,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[3956.71,11794.8,25.4634],[[-0.828612,-0.559824,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[3954.83,11824.7,24.9933],[[-0.999998,0.00178052,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[3956.74,11828.9,25.0008],[[-0.669218,0.743066,0],[0,0,1]],0,0,2,[],{}],
				["Land_LampShabby_F","a3\structures_f\civ\lamps\lampshabby_f.p3d",[3985.75,11765.9,26.6257],[[0.564263,-0.825595,0],[0,0,1]],0,1,0,[],{}],
				["Land_Shed_Small_F","a3\structures_f\ind\shed\shed_small_f.p3d",[3971.73,11784.9,25.8549],[[-0.70911,0.705098,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_small_F","a3\structures_f_argo\military\bunkers\bunker_01_small_f.p3d",[3981.38,11767.2,23.6943],[[0.722539,0.69133,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[3977.85,11772.1,23.486],[[-0.694919,-0.719088,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[3966.79,11782.9,24.0106],[[-0.698981,-0.715141,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[3963.27,11786.7,24.798],[[-0.749832,-0.661628,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[3974.15,11775.7,23.6695],[[-0.698981,-0.715141,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[3970.49,11779.3,23.7312],[[-0.698981,-0.715141,0],[0,0,1]],0,0,2,[],{}],
				["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[3967.18,11817.3,30.4017],[[0.999959,0.00909049,0],[0,0,1]],0,1,0,[],{}],
				["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[3967.07,11815.4,30.4126],[[-0.9999,0.0141473,0],[0,0,1]],0,1,0,[],{}],
				["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[3967.59,11815.5,30.3845],[[-0.750136,-0.661283,0],[0,0,1]],0,1,0,[],{}],
				["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[3967.12,11816.3,30.4179],[[-0.0217305,-0.999764,0],[0,0,1]],0,1,0,[],{}],
				["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[3967.7,11817.3,30.3745],[[0.587756,-0.809039,0],[0,0,1]],0,1,0,[],{}],
				["Land_LampShabby_F","a3\structures_f\civ\lamps\lampshabby_f.p3d",[3970.14,11839.1,26.8124],[[0.815137,0.579269,0],[0,0,1]],0,1,0,[],{}],
				["Land_Bunker_01_blocks_1_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_1_f.p3d",[3969.59,11839.9,23.1468],[[-0.562078,0.827084,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_1_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_1_f.p3d",[3974.21,11842.9,22.9894],[[-0.562078,0.827084,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[3967.08,11838.2,23.7998],[[-0.562102,0.827068,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[3964.42,11835.8,24.0092],[[-0.669218,0.743066,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[3981.04,11847.9,23.425],[[-0.634057,0.773287,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[3983.07,11849.6,23.1993],[[-0.634057,0.773287,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[3960.57,11832.4,24.6325],[[-0.669218,0.743066,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[3976.96,11844.8,23.3629],[[-0.562102,0.827068,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_small_F","a3\structures_f_argo\military\bunkers\bunker_01_small_f.p3d",[3988.86,11853.8,22.4509],[[0.299926,-0.953963,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[4013.61,11752.2,23.5],[[-0.238205,-0.971215,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[4018.6,11751,22.714],[[-0.238205,-0.971215,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[4008.58,11753.4,23.7477],[[-0.238205,-0.971215,0],[0,0,1]],0,0,2,[],{}],
				["Land_Shed_Small_F","a3\structures_f\ind\shed\shed_small_f.p3d",[4002.97,11843.3,24.9221],[[0.89893,-0.438091,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[4004.26,11848.1,22.8469],[[0.428653,0.903469,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[4013.46,11843.7,22.8367],[[0.430126,0.902769,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[4008.83,11845.9,23.28],[[0.430126,0.902769,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[4018.13,11841.5,22.2599],[[0.430126,0.902769,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[3994.95,11852.6,22.8015],[[0.428653,0.903469,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[3999.59,11850.4,22.9395],[[0.428653,0.903469,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[4026.05,11756.5,22.8263],[[0.769928,-0.63813,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[4022.74,11752.6,22.1132],[[0.769928,-0.63813,0],[0,0,1]],0,0,2,[],{}],
				["Land_HelipadCircle_F","a3\structures_f\mil\helipads\helipadcircle_f.p3d",[4020.29,11785.7,22.909],[[0.609201,0.793013,-0.00195993],[-0.0106641,0.0106635,0.999886]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[4029.35,11760.5,23.4843],[[0.769928,-0.63813,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[4032.49,11764.5,23.8998],[[0.801736,-0.597678,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[4044.74,11781.1,24.0969],[[0.811863,-0.583848,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[4038.68,11772.8,25.3248],[[0.801736,-0.597678,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[4041.71,11776.9,24.3737],[[0.811863,-0.583848,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[4048.35,11789.7,22.7304],[[0.945184,0.326538,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[4047.76,11785.3,23.4921],[[0.811863,-0.583848,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[4035.59,11768.6,24.9902],[[0.801736,-0.597678,0],[0,0,1]],0,0,2,[],{}],
				["Land_Cargo20_military_green_F","a3\structures_f\ind\cargo\cargo20_military_green_f.p3d",[4043.35,11788.2,23.9645],[[0.0443079,0.0263938,0.998669],[0.478626,-0.878016,0.0019699]],0,0,2,[],{}],
				["Land_LampShabby_F","a3\structures_f\civ\lamps\lampshabby_f.p3d",[4036.96,11818.1,26.2123],[[0.726725,-0.686929,0],[0,0,1]],0,1,0,[],{}],
				["Land_Cargo20_military_green_F","a3\structures_f\ind\cargo\cargo20_military_green_f.p3d",[4040.83,11794.6,24.1761],[[-0.337726,0.941243,0.00122209],[0.021295,0.00634276,0.999753]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[4045.01,11799.5,23.7089],[[0.945184,0.326538,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[4046.67,11794.6,23.3603],[[0.945184,0.326538,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_small_F","a3\structures_f_argo\military\bunkers\bunker_01_small_f.p3d",[4036.82,11822,22.9906],[[-0.735747,-0.677256,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[4029.16,11831,21.7719],[[0.73181,0.681509,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[4031.98,11826.8,22.9354],[[0.879301,0.476267,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[4022.15,11838.5,22.455],[[0.73181,0.681509,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[4025.64,11834.8,22.0493],[[0.73181,0.681509,0],[0,0,1]],0,0,2,[],{}]
			],
			[
				["B_T_LSV_01_armed_F",[3978.48,11779.9,0.0242786],51.704],
				["B_T_LSV_01_armed_F",[3972.85,11786.2,-0.0169411],48.1789],
				["B_T_LSV_01_unarmed_F",[3966.73,11791.9,-0.00606155],49.8424],
				["B_T_Quadbike_01_F",[3969.31,11808.5,0.0694008],88.6433],
				["B_T_Quadbike_01_F",[3969.24,11812.2,0.025919],88.0386],
				["B_T_Truck_01_transport_F",[3981.01,11843.4,0.059309],232.042],
				["B_T_LSV_01_AT_F",[4002.72,11842,0.0828838],204.691],
				["B_T_LSV_01_unarmed_F",[3994.96,11845.9,-0.0279751],208.667]
			],
			[4020.11,11785.6,0.00140381],
			[3967.68,11828.6,0.00168037],
			localize 'STR_QS_Utility_021'
		];
	};
	_return;
};
if (_worldName isEqualTo 'Malden') exitWith {
	private _return = [];
	if (_type isEqualTo 0) then {
		/* North */
		_return = [
			[5974.28,9660.27],
			[
				["FlagPole_F","a3\structures_f\mil\flags\mast_f.p3d",[5969.09,9645.21,173.479],[[0,1,0],[0,0,1]],0,1,0,[],{
					missionNamespace setVariable ['QS_module_fob_flag',(_this # 0),TRUE];
					(_this # 0) addEventHandler [
						'Deleted',
						{
							params ['_entity'];
							missionNamespace setVariable ['QS_module_fob_respawnTickets',(round (((_entity getVariable ['QS_deploy_tickets',0]) / 2) max 0)),FALSE];
						}
					];
				}],
				["Land_RepairDepot_01_tan_F","a3\structures_f_tank\military\repairdepot\repairdepot_01_tan_f.p3d",[5994.33,9651.12,171.739],[[0.725795,0.685284,-0.0600691],[-0.012609,0.100559,0.994851]],0,0,2,[],{
					missionNamespace setVariable ['QS_module_fob_repairDepot',(_this # 0),FALSE];
					(_this # 0) hideObjectGlobal TRUE;
				}],
				["Land_Bunker_01_HQ_F","a3\structures_f_argo\military\bunkers\bunker_01_hq_f.p3d",[5971.28,9652.44,171.022],[[-0.823947,-0.566667,0],[0,0,1]],0,0,2,[],{
					_building = _this # 0;
					missionNamespace setVariable ['QS_module_fob_HQ',_building,TRUE];
					[_building] spawn {
						_building = _this # 0;
						_building enableSimulationGlobal TRUE;
						_dataTerminal = createSimpleObject ['Land_DataTerminal_01_F',(getPosWorld _building)];
						[1,_dataTerminal,[_building,[-0.6,0,-1]]] call QS_fnc_eventAttach;
						_dataTerminal setDir 90;
						sleep 0.1;
						[0,_dataTerminal] call QS_fnc_eventAttach;
						missionNamespace setVariable ['QS_module_fob_dataTerminal',_dataTerminal,TRUE];
						_crate = createSimpleObject ['a3\weapons_f\ammoboxes\supplydrop.p3d',(getPosWorld _building)];
						[1,_crate,[_building,[0.7,0,0]]] call QS_fnc_eventAttach;
						_crate setDir 90;
						sleep 0.1;
						[0,_crate] call QS_fnc_eventAttach;
						_crate hideObjectGlobal TRUE;
						missionNamespace setVariable ['QS_module_fob_supplycrate',_crate,FALSE];
						sleep 1;
						_building enableSimulationGlobal FALSE;
					};	
				}],
				["Land_PortableCabinet_01_medical_F","a3\props_f_enoch\military\camps\portablecabinet_01_medical_f.p3d",[5971.44,9649.59,170.457],[[0.538358,-0.842716,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[5949.45,9646.37,172.425],[[-0.794696,-0.607008,0],[0,0,1]],0,0,2,[],{}],
				["Land_Shed_Small_F","a3\structures_f\ind\shed\shed_small_f.p3d",[5943.68,9661.91,173.677],[[-0.597678,0.801736,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[5937.02,9662.7,172.42],[[-0.794696,-0.607008,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[5946.36,9650.53,172.449],[[-0.794696,-0.607008,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[5934.06,9670.68,171.968],[[-0.536451,0.843932,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[5938.34,9673.56,171.618],[[-0.536451,0.843932,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[5933.88,9666.76,172.412],[[-0.794696,-0.607008,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[5943.28,9654.58,172.438],[[-0.794696,-0.607008,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[5940.13,9658.65,172.432],[[-0.794696,-0.607008,0],[0,0,1]],0,0,2,[],{}],
				["Land_SandbagBarricade_01_half_F","a3\structures_f_argo\military\fortifications\sandbagbarricade_01_half_f.p3d",[5945.25,9677.22,170.364],[[-0.495008,0.868889,0],[0,0,1]],0,0,2,[],{}],
				["Land_LampShabby_F","a3\structures_f\civ\lamps\lampshabby_f.p3d",[5945.23,9676.25,173.524],[[0.410291,0.911955,0],[0,0,1]],0,1,0,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[5942.64,9676.28,171.142],[[-0.536451,0.843932,0],[0,0,1]],0,0,2,[],{}],
				["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[5967.41,9647.06,175.473],[[0.968368,-0.249526,0],[0,0,1]],0,1,0,[],{}],
				["Land_LampShabby_F","a3\structures_f\civ\lamps\lampshabby_f.p3d",[5966.73,9647.85,173.266],[[-0.376529,0.926405,0],[0,0,1]],0,1,0,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[5962.98,9631.95,171.716],[[-0.125777,-0.992059,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[5958.8,9634.21,172.152],[[-0.794696,-0.607008,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[5955.68,9638.25,172.271],[[-0.794696,-0.607008,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[5968.08,9631.34,171.351],[[-0.125777,-0.992059,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[5973.14,9630.69,171.032],[[-0.125777,-0.992059,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[5952.59,9642.3,172.348],[[-0.794696,-0.607008,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bulldozer_01_abandoned_F","a3\props_f_exp\industrial\heavyequipment\bulldozer_01_abandoned_f.p3d",[5968.37,9662.04,170.205],[[0.592762,-0.805313,0.0102003],[0.051134,0.0502716,0.997426]],0,0,2,[],{}],
				["Land_SandbagBarricade_01_half_F","a3\structures_f_argo\military\fortifications\sandbagbarricade_01_half_f.p3d",[5953.74,9682.74,169.489],[[-0.495008,0.868889,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[5973.04,9695.21,168.595],[[-0.516958,0.856011,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[5955.58,9684.6,169.827],[[-0.536451,0.843932,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[5964.29,9689.87,169.095],[[-0.516958,0.856011,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[5959.92,9687.25,169.441],[[-0.516958,0.856011,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[5968.67,9692.56,168.814],[[-0.516958,0.856011,0],[0,0,1]],0,0,2,[],{}],
				["Land_SandbagBarricade_01_half_F","a3\structures_f_argo\military\fortifications\sandbagbarricade_01_half_f.p3d",[5984.18,9633.64,170.578],[[0.716434,-0.697655,0],[0,0,1]],0,0,2,[],{}],
				["Land_SandbagBarricade_01_half_F","a3\structures_f_argo\military\fortifications\sandbagbarricade_01_half_f.p3d",[5990.61,9641.92,170.411],[[0.716434,-0.697655,0],[0,0,1]],0,0,2,[],{}],
				["Land_LampShabby_F","a3\structures_f\civ\lamps\lampshabby_f.p3d",[5983.3,9633.98,173.642],[[0.804477,0.593984,0],[0,0,1]],0,1,0,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[5996.56,9646.72,170.62],[[0.693146,-0.720797,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[5978.22,9630.08,170.977],[[-0.125777,-0.992059,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[5982.66,9631.38,171.011],[[0.676065,-0.736842,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[5992.88,9643.19,170.791],[[0.693146,-0.720797,0],[0,0,1]],0,0,2,[],{}],
				["Land_Excavator_01_abandoned_F","a3\props_f_exp\industrial\heavyequipment\excavator_01_abandoned_f.p3d",[5999.93,9659.18,171.218],[[0.647455,-0.756748,0.0901912],[0.0415638,0.153232,0.987316]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[5999.59,9666.32,168.493],[[0.857752,0.514064,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[5996.92,9670.71,168.38],[[0.857752,0.514064,0],[0,0,1]],0,0,2,[],{}],
				["Land_HelipadCircle_F","a3\structures_f\mil\helipads\helipadcircle_f.p3d",[5975.53,9677.2,167.78],[[0,0.999608,-0.0279894],[0.0167971,0.0279855,0.999467]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[5988.96,9683.9,168.527],[[0.857752,0.514064,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[5991.61,9679.51,168.399],[[0.857752,0.514064,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[5994.31,9675.09,168.268],[[0.857752,0.514064,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[5983.64,9692.67,168.495],[[0.857752,0.514064,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[5981.03,9697.04,168.423],[[0.857752,0.514064,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[5977.42,9697.88,168.444],[[-0.516958,0.856011,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[5986.31,9688.27,168.567],[[0.857752,0.514064,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[6004.89,9657.56,169.366],[[0.857752,0.514064,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[6000.32,9650.09,170.095],[[0.67813,-0.734942,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[6002.23,9661.95,168.805],[[0.857752,0.514064,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[6004.08,9653.54,169.566],[[0.67813,-0.734942,0],[0,0,1]],0,0,2,[],{}]
			],
			[
				["B_G_Offroad_01_F",[5944.97,9662.78,-0.000183105],54.1998],
				["B_G_Offroad_01_armed_F",[5939.81,9669.36,-0.00164795],56.8689],
				["B_Truck_01_transport_F",[5957.74,9641.58,0.101059],144.18],
				["B_Quadbike_01_F",[5975.17,9645.23,0.0129242],147.672],
				["B_Quadbike_01_F",[5977.46,9646.73,-0.000595093],147.338],
				["B_MRAP_01_F",[5950.63,9657.06,0.0542297],54.4548]
			],
			[5975.5,9676.79,0.00154114],
			[5991.57,9654.35,0.00111389],
			localize 'STR_QS_Utility_022'
		];
	};
	if (_type isEqualTo 1) then {
		/* South */
		_return = [
			[3831.45,4721.96],
			[
				["FlagPole_F","a3\structures_f\mil\flags\mast_f.p3d",[3822.66,4721.68,75.022],[[0,1,0],[0,0,1]],0,1,0,[],{
					missionNamespace setVariable ['QS_module_fob_flag',(_this # 0),TRUE];
					(_this # 0) addEventHandler [
						'Deleted',
						{
							params ['_entity'];
							missionNamespace setVariable ['QS_module_fob_respawnTickets',(round (((_entity getVariable ['QS_deploy_tickets',0]) / 2) max 0)),FALSE];
						}
					];
				}],
				["Land_RepairDepot_01_tan_F","a3\structures_f_tank\military\repairdepot\repairdepot_01_tan_f.p3d",[3841.72,4739.93,71.8833],[[-0.561216,0.827345,0.0231908],[0.092639,0.0349475,0.995086]],0,0,2,[],{
					missionNamespace setVariable ['QS_module_fob_repairDepot',(_this # 0),FALSE];
					(_this # 0) hideObjectGlobal TRUE;
				}],
				["Land_Bunker_01_HQ_F","a3\structures_f_argo\military\bunkers\bunker_01_hq_f.p3d",[3819.96,4713.54,73.2892],[[-0.465802,0.884889,0],[0,0,1]],0,0,2,[],{
					_building = _this # 0;
					missionNamespace setVariable ['QS_module_fob_HQ',_building,TRUE];
					[_building] spawn {
						_building = _this # 0;
						_building enableSimulationGlobal TRUE;
						_dataTerminal = createSimpleObject ['Land_DataTerminal_01_F',(getPosWorld _building)];
						[1,_dataTerminal,[_building,[-0.6,0,-1]]] call QS_fnc_eventAttach;
						_dataTerminal setDir 90;
						sleep 0.1;
						[0,_dataTerminal] call QS_fnc_eventAttach;
						missionNamespace setVariable ['QS_module_fob_dataTerminal',_dataTerminal,TRUE];
						_crate = createSimpleObject ['a3\weapons_f\ammoboxes\supplydrop.p3d',(getPosWorld _building)];
						[1,_crate,[_building,[0.7,0,0]]] call QS_fnc_eventAttach;
						_crate setDir 90;
						sleep 0.1;
						[0,_crate] call QS_fnc_eventAttach;
						_crate hideObjectGlobal TRUE;
						missionNamespace setVariable ['QS_module_fob_supplycrate',_crate,FALSE];
						sleep 1;
						_building enableSimulationGlobal FALSE;
					};	
				}],
				["Land_PortableCabinet_01_medical_F","a3\props_f_enoch\military\camps\portablecabinet_01_medical_f.p3d",[3817.09,4713.74,72.7253],[[-0.891294,-0.453425,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_small_F","a3\structures_f_argo\military\bunkers\bunker_01_small_f.p3d",[3799.25,4748,72.4481],[[0.94252,-0.33415,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[3823.38,4695.34,72.9023],[[-0.897722,-0.440563,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[3821.11,4699.97,72.9198],[[-0.897722,-0.440563,0],[0,0,1]],0,0,2,[],{}],
				["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[3824.16,4720.06,76.9835],[[0.44159,-0.897217,0],[0,0,1]],0,1,0,[],{}],
				["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[3824.2,4719.29,76.9976],[[-0.650865,-0.759194,0],[0,0,1]],0,1,0,[],{}],
				["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[3823.6,4720.51,77.0029],[[0.982493,-0.186299,0],[0,0,1]],0,1,0,[],{}],
				["Land_TTowerSmall_1_F","a3\structures_f\ind\transmitter_tower\ttowersmall_1_f.p3d",[3816.15,4718.75,76.4441],[[0,1,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[3809.7,4722.99,72.9818],[[-0.895959,-0.444136,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[3818.81,4704.54,72.8699],[[-0.895959,-0.444136,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[3811.99,4718.37,72.9761],[[-0.895959,-0.444136,0],[0,0,1]],0,0,2,[],{}],
				["Land_Shed_Small_F","a3\structures_f\ind\shed\shed_small_f.p3d",[3809.45,4733.88,73.9597],[[-0.454185,0.890908,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[3807.38,4727.58,72.9225],[[-0.890312,-0.455351,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[3800.38,4741.33,72.9982],[[-0.890312,-0.455351,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[3805.05,4732.17,72.9225],[[-0.890312,-0.455351,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[3802.71,4736.76,72.9231],[[-0.890312,-0.455351,0],[0,0,1]],0,0,2,[],{}],
				["Land_Mil_WallBig_4m_damaged_right_F","a3\structures_f_argo\walls\military\mil_wallbig_4m_damaged_right_f.p3d",[3817.31,4758.04,72.0416],[[0.444548,-0.895755,0],[0,0,1]],0,0,2,[],{}],
				["Land_LampShabby_F","a3\structures_f\civ\lamps\lampshabby_f.p3d",[3809.73,4753.09,74.6415],[[0.833112,0.553105,0],[0,0,1]],0,1,0,[],{}],
				["Land_Excavator_01_abandoned_F","a3\props_f_exp\industrial\heavyequipment\excavator_01_abandoned_f.p3d",[3807.79,4750.09,74.2197],[[-0.877192,-0.475856,0.0639942],[0.0559132,0.0311363,0.99795]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_1_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_1_f.p3d",[3824.19,4762.32,71.064],[[-0.37622,0.92653,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[3803.5,4752.04,72.4528],[[-0.447968,0.89405,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[3818.2,4759.4,71.5253],[[-0.447968,0.89405,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[3821.89,4761.22,71.3059],[[-0.447968,0.89405,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[3808.11,4754.34,72.1227],[[-0.447968,0.89405,0],[0,0,1]],0,0,2,[],{}],
				["Land_Mil_WallBig_4m_damaged_left_F","a3\structures_f_argo\walls\military\mil_wallbig_4m_damaged_left_f.p3d",[3810.29,4754.41,72.5125],[[0.407659,-0.913134,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bulldozer_01_abandoned_F","a3\props_f_exp\industrial\heavyequipment\bulldozer_01_abandoned_f.p3d",[3827.15,4696.86,72.9417],[[0,0.999767,-0.0215966],[0.0551167,0.0215637,0.998247]],0,0,2,[],{}],
				["Land_Bunker_01_small_F","a3\structures_f_argo\military\bunkers\bunker_01_small_f.p3d",[3831.68,4681.19,72.3051],[[0.408322,0.912838,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[3827.9,4686.11,72.779],[[-0.897722,-0.440563,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[3843.4,4682.86,71.9868],[[0.304048,-0.952657,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[3825.63,4690.74,72.8074],[[-0.897722,-0.440563,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[3848.31,4684.42,71.6908],[[0.304048,-0.952657,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[3838.52,4681.3,72.3561],[[0.304048,-0.952657,0],[0,0,1]],0,0,2,[],{}],
				["Land_HelipadCircle_F","a3\structures_f\mil\helipads\helipadcircle_f.p3d",[3843.95,4703.2,70.355],[[0,0.999767,-0.0215966],[0.0535235,0.0215656,0.998334]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[3846.62,4741.7,70.2226],[[0.807124,0.590383,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[3849.66,4737.53,70.0291],[[0.807124,0.590383,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[3843.6,4745.84,70.3507],[[0.807124,0.590383,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_small_F","a3\structures_f_argo\military\bunkers\bunker_01_small_f.p3d",[3829.66,4762.37,70.3556],[[-0.246567,-0.969126,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[3840.56,4750,70.5507],[[0.807124,0.590383,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[3834.52,4758.28,70.5504],[[0.807124,0.590383,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[3837.54,4754.16,70.5237],[[0.807124,0.590383,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[3861.91,4691.04,70.9137],[[0.568423,-0.822737,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[3866.13,4693.95,70.5867],[[0.568423,-0.822737,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[3857.66,4688.12,71.185],[[0.568423,-0.822737,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[3870.37,4696.88,70.2696],[[0.568423,-0.822737,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[3853.22,4685.97,71.3969],[[0.304048,-0.952657,0],[0,0,1]],0,0,2,[],{}],
				["Land_SandbagBarricade_01_half_F","a3\structures_f_argo\military\fortifications\sandbagbarricade_01_half_f.p3d",[3861.11,4722.18,69.4805],[[0.811806,0.583928,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_small_F","a3\structures_f_argo\military\bunkers\bunker_01_small_f.p3d",[3874.24,4701.27,69.5504],[[-0.989396,0.145241,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[3869.16,4711.57,69.9798],[[0.807401,0.590004,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[3863.1,4719.9,69.9778],[[0.807401,0.590004,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[3872.18,4707.43,69.9538],[[0.807401,0.590004,0],[0,0,1]],0,0,2,[],{}],
				["Land_Bunker_01_blocks_3_F","a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d",[3866.12,4715.74,69.9914],[[0.807401,0.590004,0],[0,0,1]],0,0,2,[],{}],
				["Land_SandbagBarricade_01_half_F","a3\structures_f_argo\military\fortifications\sandbagbarricade_01_half_f.p3d",[3850.8,4735.33,69.4825],[[0.802619,0.596492,0],[0,0,1]],0,0,2,[],{}],
				["Land_LampShabby_F","a3\structures_f\civ\lamps\lampshabby_f.p3d",[3850.11,4735.08,72.6805],[[0.548955,-0.835852,0],[0,0,1]],0,1,0,[],{}]
			],
			[
				["B_MRAP_01_F",[3815.59,4727.83,0.01194],65.3447],
				["B_MRAP_01_F",[3811.95,4735.12,0.0132904],63.9927],
				["B_G_Offroad_01_armed_F",[3807.32,4741.49,-0.0360184],64.3722],
				["B_Truck_01_transport_F",[3834.32,4753.07,0.0375977],144.329],
				["B_Quadbike_01_F",[3827.41,4717.52,-0.000999451],61.6764],
				["B_Quadbike_01_F",[3828.8,4714.77,-0.00174713],61.6764]
			],
			[3843.75,4703.93,0.00127411],		/*helipad*/
			[3837.78,4738.05,0.00170898],		/* service bay*/
			localize 'STR_QS_Utility_023'						/* Marker text */
		];
	};
	_return;
};
if (_worldName isEqualTo 'Enoch') exitWith {
	private _return = [];
	if (_type isEqualTo 0) then {
		/*/ North /*/
		_return = [
			[5535.37,9384.79],
			[
				["FlagPole_F","a3\structures_f\mil\flags\mast_f.p3d",[5552.26,9361.63,16.5221],[[0.249529,0.968367,0],[0,0,1]],0,1,0,[],{
					missionNamespace setVariable ['QS_module_fob_flag',(_this # 0),TRUE];
					(_this # 0) addEventHandler [
						'Deleted',
						{
							params ['_entity'];
							missionNamespace setVariable ['QS_module_fob_respawnTickets',(round (((_entity getVariable ['QS_deploy_tickets',0]) / 2) max 0)),FALSE];
						}
					];
				}],
				["Land_RepairDepot_01_green_F","a3\structures_f_tank\military\repairdepot\repairdepot_01_green_f.p3d",[5583.27,9389.43,15.1911],[[0.201699,0.979448,0.000311439],[-0.00154408,0,0.999999]],0,0,2,[],{
					missionNamespace setVariable ['QS_module_fob_repairDepot',(_this # 0),FALSE];
					(_this # 0) hideObjectGlobal TRUE;
				}],
				["Land_GuardHouse_02_F","a3\structures_f_enoch\military\barracks\guardhouse_02_f.p3d",[5547.13,9360.91,14.4143],[[0.985238,-0.17119,0],[0,0,1]],0,0,2,[],{
					_building = _this # 0;
					_building animateSource ['Door_1_sound_source',1];
					_building animateSource ['Door_2_sound_source',1];
					_building animateSource ['Door_3_sound_source',1];
					missionNamespace setVariable ['QS_module_fob_HQ',_building,TRUE];
					[_building] spawn {
						_building = _this # 0;
						_building enableSimulationGlobal TRUE;
						_dataTerminal = createSimpleObject ['Land_DataTerminal_01_F',(getPosWorld _building)];
						[1,_dataTerminal,[_building,[-0.6,0,-1]]] call QS_fnc_eventAttach;
						_dataTerminal setDir 90;
						sleep 0.1;
						[0,_dataTerminal] call QS_fnc_eventAttach;
						missionNamespace setVariable ['QS_module_fob_dataTerminal',_dataTerminal,TRUE];
						_crate = createSimpleObject ['a3\weapons_f\ammoboxes\supplydrop.p3d',(getPosWorld _building)];
						[1,_crate,[_building,[-2.2,2.5,-0.7]]] call QS_fnc_eventAttach;
						_crate setDir 90;
						sleep 0.1;
						[0,_crate] call QS_fnc_eventAttach;
						_crate hideObjectGlobal TRUE;
						missionNamespace setVariable ['QS_module_fob_supplycrate',_crate,FALSE];
						sleep 1;
						_building enableSimulationGlobal FALSE;
					};
				}],
				["Land_PortableCabinet_01_medical_F","a3\props_f_enoch\military\camps\portablecabinet_01_medical_f.p3d",[5545.89,9356.46,13.2723],[[-0.213451,-0.976954,0],[0,0,1]],0,0,2,[],{}],
				["Land_GuardTower_01_F","a3\structures_f_enoch\military\barracks\guardtower_01_f.p3d",[5494.24,9412.16,17.0595],[[-0.219869,-0.975529,0],[0,0,1]],0,0,0,[],{}],
				["Land_GuardTower_02_F","a3\structures_f_enoch\military\barracks\guardtower_02_f.p3d",[5483.94,9368.71,15.4479],[[-0.861207,-0.508255,0],[0,0,1]],0,0,0,[],{}],
				["Land_Shed_Small_F","a3\structures_f\ind\shed\shed_small_f.p3d",[5542.79,9407.37,14.5924],[[0.979052,-0.203609,0],[0,0,1]],0,0,2,[],{}],
				["Land_HelipadCircle_F","a3\structures_f\mil\helipads\helipadcircle_f.p3d",[5514.21,9381.59,12.42],[[0.640495,-0.767962,0],[0,0,1]],0,0,2,[],{}],
				["Land_TTowerSmall_2_F","a3\structures_f\ind\transmitter_tower\ttowersmall_2_f.p3d",[5548.3,9354.22,20.9613],[[-0.939402,0.342817,0],[0,0,1]],0,0,2,[],{}],
				["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[5543.08,9364.76,18.4592],[[0.546875,0.837214,0],[0,0,1]],0,1,0,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[5483.85,9384.18,13.1206],[[0.971174,-0.238373,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[5486.71,9395.84,13.1445],[[0.971174,-0.238373,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[5485.27,9390.02,13.14],[[0.971174,-0.238373,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[5488.13,9401.67,13.1342],[[0.971174,-0.238373,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[5489.55,9407.5,13.0917],[[0.971174,-0.238373,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[5490.96,9413.32,12.9966],[[0.971174,-0.238373,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[5492.38,9419.15,12.5845],[[0.971174,-0.238373,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[5517.62,9357.91,13.241],[[0.212017,0.977266,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[5505.89,9360.45,13.2259],[[0.212017,0.977266,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[5511.75,9359.17,13.2336],[[0.212017,0.977266,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[5500.03,9361.71,13.2063],[[0.212017,0.977266,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[5494.17,9362.97,13.0544],[[0.212017,0.977266,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[5488.3,9364.23,12.9021],[[0.212017,0.977266,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[5482.44,9365.49,12.6995],[[0.212017,0.977266,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[5558.86,9350.08,13.3542],[[0.185392,0.982665,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[5547.07,9352.3,13.2557],[[0.185392,0.982665,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[5552.96,9351.18,13.259],[[0.185392,0.982665,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[5541.17,9353.4,13.2656],[[0.185392,0.982665,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[5535.27,9354.5,13.267],[[0.185392,0.982665,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[5529.38,9355.6,13.2555],[[0.185392,0.982665,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[5523.48,9356.7,13.2394],[[0.185392,0.982665,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[5583.92,9362.98,13.8423],[[0.988216,-0.153063,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[5585.76,9374.84,13.6139],[[0.988216,-0.153063,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[5584.83,9368.91,13.6787],[[0.988216,-0.153063,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[5586.66,9380.77,13.5922],[[0.988216,-0.153063,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[5587.57,9386.7,13.5848],[[0.988216,-0.153063,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[5588.47,9392.63,13.5934],[[0.988216,-0.153063,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[5589.38,9398.56,13.6101],[[0.988216,-0.153063,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[5573.82,9347.19,14.0723],[[0.185392,0.982665,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[5570.65,9347.86,13.9972],[[0.185392,0.982665,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[5583.02,9357.05,14.0251],[[0.988216,-0.153063,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[5582.29,9352.33,14.0872],[[0.988216,-0.153063,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[5579.2,9348.02,14.1146],[[-0.462519,0.886609,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[5480.2,9369.03,12.6764],[[0.971174,-0.238373,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[5483.05,9380.69,13.1038],[[0.971174,-0.238373,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[5481.61,9374.87,13.0447],[[0.971174,-0.238373,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[5518.43,9416.67,13.2149],[[-0.204312,-0.978906,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[5524.31,9415.45,13.2303],[[-0.204312,-0.978906,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[5530.18,9414.24,13.2419],[[-0.204312,-0.978906,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[5536.05,9413.03,13.2588],[[-0.204312,-0.978906,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[5541.93,9411.81,13.2865],[[-0.204312,-0.978906,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[5500.8,9420.33,12.7463],[[-0.204312,-0.978906,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[5496.13,9421.3,12.5213],[[-0.204312,-0.978906,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[5559.56,9408.12,13.4046],[[-0.204886,-0.978786,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[5581.09,9403.2,13.5723],[[-0.204886,-0.978786,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[5586.96,9401.98,13.5886],[[-0.204886,-0.978786,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[5553.68,9409.34,13.3526],[[-0.204886,-0.978786,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[5547.81,9410.58,13.3162],[[-0.204886,-0.978786,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[5567.93,9351.75,13.8135],[[0.185392,0.982665,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[5562.03,9352.86,13.4484],[[0.185392,0.982665,0],[0,0,1]],0,0,2,[],{}],
				["Land_GuardTower_02_F","a3\structures_f_enoch\military\barracks\guardtower_02_f.p3d",[5578.81,9351.57,16.6624],[[0.497656,-0.867375,0],[0,0,1]],0,0,0,[],{}],
				["Land_GuardTower_02_F","a3\structures_f_enoch\military\barracks\guardtower_02_f.p3d",[5585.74,9398.67,16.1986],[[0.849218,0.528043,0],[0,0,1]],0,0,0,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[5514.91,9414.42,13.2133],[[0.975775,-0.218775,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[5561.82,9404.46,13.4035],[[-0.985423,0.170124,0],[0,0,1]],0,0,2,[],{}],
				["Land_Shed_Small_F","a3\structures_f\ind\shed\shed_small_f.p3d",[5580.66,9369.45,14.9413],[[-0.161903,-0.986807,0],[0,0,1]],0,0,2,[],{}],
				["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[5543.51,9365.11,18.4589],[[0.985641,-0.168857,0],[0,0,1]],0,1,0,[],{}],
				["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[5542.84,9364.09,18.4616],[[0.20647,0.978453,0],[0,0,1]],0,1,0,[],{}],
				["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[5544.13,9365,18.4626],[[0.640019,-0.768359,0],[0,0,1]],0,1,0,[],{}],
				["Land_LampShabby_F","a3\structures_f\civ\lamps\lampshabby_f.p3d",[5502.99,9419.65,15.8498],[[0.992993,-0.11817,0],[0,0,1]],0,1,0,[],{}],
				["Land_LampShabby_F","a3\structures_f\civ\lamps\lampshabby_f.p3d",[5578.86,9403.5,16.5382],[[-0.981418,0.191882,0],[0,0,1]],0,1,0,[],{}],
				["Land_LampShabby_F","a3\structures_f\civ\lamps\lampshabby_f.p3d",[5562.29,9407.31,16.3982],[[0.987531,-0.157423,0],[0,0,1]],0,1,0,[],{}],
				["Land_LampShabby_F","a3\structures_f\civ\lamps\lampshabby_f.p3d",[5552.12,9363.17,16.3158],[[-0.999742,0.0227136,0],[0,0,1]],0,1,0,[],{}]
			],
			[
				["B_T_Truck_01_transport_F",[5486.87,9380.2,0.115631],14.6864],
				["B_T_MRAP_01_F",[5534.72,9407.45,0.149034],190.447],
				["B_T_MRAP_01_F",[5541.83,9405.38,0.149063],190.447],
				["B_T_MRAP_01_F",[5550.25,9403.53,0.149152],190.447],
				["B_T_Quadbike_01_F",[5539.24,9360.42,0.200735],282.621],
				["B_T_Quadbike_01_F",[5540.25,9363.8,0.200786],285.042],
				["B_G_Offroad_01_F",[5579.66,9369.34,0.0581274],278.564],
				["B_G_Offroad_01_armed_F",[5578.64,9361.71,0.0766859],277.015]
			],
			[5514.41,9381.38,0.00143909],
			[5579.19,9390.66,0.00142384],
			localize 'STR_QS_Utility_024'
		];
	};
	if (_type isEqualTo 1) then {
		/*/ West /*/
		_return = [
			[2989.74,5057.98],
			[
				["FlagPole_F","a3\structures_f\mil\flags\mast_f.p3d",[2993,5079.81,216.644],[[0,1,0],[0,0,1]],0,1,0,[],{
					missionNamespace setVariable ['QS_module_fob_flag',(_this # 0),TRUE];
					(_this # 0) addEventHandler [
						'Deleted',
						{
							params ['_entity'];
							missionNamespace setVariable ['QS_module_fob_respawnTickets',(round (((_entity getVariable ['QS_deploy_tickets',0]) / 2) max 0)),FALSE];
						}
					];
				}],
				["Land_RepairDepot_01_green_F","a3\structures_f_tank\military\repairdepot\repairdepot_01_green_f.p3d",[3013.93,5066.66,217.312],[[-0.698303,0.711497,-0.0783901],[-0.0987119,0.0127478,0.995034]],0,0,2,[],{
					missionNamespace setVariable ['QS_module_fob_repairDepot',(_this # 0),FALSE];
					(_this # 0) hideObjectGlobal TRUE;
				}],
				["Land_GuardHouse_02_F","a3\structures_f_enoch\military\barracks\guardhouse_02_f.p3d",[2998.76,5078.95,215.129],[[-0.700159,0.713987,0],[0,0,1]],0,0,2,[],{
					_building = _this # 0;
					_building animateSource ['Door_1_sound_source',1];
					_building animateSource ['Door_2_sound_source',1];
					_building animateSource ['Door_3_sound_source',1];
					missionNamespace setVariable ['QS_module_fob_HQ',_building,TRUE];
					[_building] spawn {
						_building = _this # 0;
						_building enableSimulationGlobal TRUE;
						_dataTerminal = createSimpleObject ['Land_DataTerminal_01_F',(getPosWorld _building)];
						[1,_dataTerminal,[_building,[-0.6,0,-1]]] call QS_fnc_eventAttach;
						_dataTerminal setDir 90;
						sleep 0.1;
						[0,_dataTerminal] call QS_fnc_eventAttach;
						missionNamespace setVariable ['QS_module_fob_dataTerminal',_dataTerminal,TRUE];
						_crate = createSimpleObject ['a3\weapons_f\ammoboxes\supplydrop.p3d',(getPosWorld _building)];
						[1,_crate,[_building,[-2.2,2.5,-0.7]]] call QS_fnc_eventAttach;
						_crate setDir 90;
						sleep 0.1;
						[0,_crate] call QS_fnc_eventAttach;
						_crate hideObjectGlobal TRUE;
						missionNamespace setVariable ['QS_module_fob_supplycrate',_crate,FALSE];
						sleep 1;
						_building enableSimulationGlobal FALSE;
					};
				}],
				["Land_PortableCabinet_01_medical_F","a3\props_f_enoch\military\camps\portablecabinet_01_medical_f.p3d",[2999.61,5084.72,213.987],[[-0.723263,0.690573,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[3026.8,5031.91,218.211],[[-0.546191,0.837661,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[3031.83,5035.18,218.532],[[-0.546191,0.837661,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[3021.78,5028.63,217.766],[[-0.546191,0.837661,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[3011.72,5022.08,216.971],[[-0.546191,0.837661,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[3016.75,5025.35,217.285],[[-0.546191,0.837661,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[3006.7,5018.8,216.476],[[-0.546191,0.837661,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[2996.65,5012.24,215.247],[[-0.546191,0.837661,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[2991.63,5008.95,214.738],[[-0.546191,0.837661,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[2983.3,5014.32,213.678],[[0.759819,0.650135,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[2987.2,5009.76,214.107],[[0.759819,0.650135,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[2979.39,5018.87,213.105],[[0.759819,0.650135,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[2971.6,5028,212.03],[[0.759819,0.650135,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[2975.49,5023.44,212.467],[[0.759819,0.650135,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[2967.69,5032.55,211.546],[[0.759819,0.650135,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[2959.89,5041.67,210.885],[[0.759819,0.650135,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[2963.78,5037.1,211.145],[[0.759819,0.650135,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[2955.98,5046.22,210.702],[[0.759819,0.650135,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[2952.07,5050.77,210.622],[[0.759819,0.650135,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[2948.16,5055.32,210.591],[[0.759819,0.650135,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[2940.36,5064.43,210.659],[[0.759819,0.650135,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[2944.25,5059.87,210.518],[[0.759819,0.650135,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[2936.45,5068.98,210.897],[[0.759819,0.650135,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[2941.54,5077.05,211.006],[[0.642301,-0.766453,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[2936.93,5073.21,210.537],[[0.642301,-0.766453,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[2946.13,5080.92,211.353],[[0.642301,-0.766453,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[2955.34,5088.61,212.148],[[0.642301,-0.766453,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[2950.73,5084.77,211.652],[[0.642301,-0.766453,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[2959.93,5092.48,212.492],[[0.642301,-0.766453,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[2969.12,5100.19,213.155],[[0.642301,-0.766453,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[2964.52,5096.34,212.788],[[0.642301,-0.766453,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[2973.71,5104.05,213.478],[[0.642301,-0.766453,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[2978.3,5107.91,213.767],[[0.642301,-0.766453,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[3041.82,5041.73,219.59],[[-0.546191,0.837661,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[3036.8,5038.45,219.033],[[-0.546191,0.837661,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[3038.11,5049.92,219.227],[[0.725401,0.688327,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[3042.24,5045.56,219.602],[[0.725401,0.688327,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[3021.58,5067.33,217.453],[[0.725401,0.688327,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[3013.32,5076.03,216.454],[[0.725401,0.688327,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[3017.44,5071.67,216.875],[[0.725401,0.688327,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[3009.18,5080.37,216.065],[[0.725401,0.688327,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[3005.05,5084.71,215.62],[[0.725401,0.688327,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[3000.91,5089.06,215.092],[[0.725401,0.688327,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[2996.77,5093.4,214.678],[[0.725401,0.688327,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[2986.76,5103.5,214.38],[[0.725401,0.688327,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v1_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v1_f.p3d",[2982.59,5107.79,213.768],[[0.707659,0.706554,0],[0,0,1]],0,0,2,[],{}],
				["Land_GuardTower_02_F","a3\structures_f_enoch\military\barracks\guardtower_02_f.p3d",[2989.99,5011.52,216.468],[[-0.0104076,-0.999946,0],[0,0,1]],0,0,0,[],{}],
				["Land_GuardTower_01_F","a3\structures_f_enoch\military\barracks\guardtower_01_f.p3d",[2976.16,5101.69,217.252],[[-0.721738,-0.692167,0],[0,0,1]],0,0,2,[],{}],
				["Land_GuardTower_02_F","a3\structures_f_enoch\military\barracks\guardtower_02_f.p3d",[2940.27,5070.82,213.08],[[-0.996959,0.0779305,0],[0,0,1]],0,0,0,[],{}],
				["Land_GuardTower_02_F","a3\structures_f_enoch\military\barracks\guardtower_02_f.p3d",[3038.88,5044.06,221.16],[[0.989755,-0.142777,0],[0,0,1]],0,0,0,[],{}],
				["Land_Shed_Small_F","a3\structures_f\ind\shed\shed_small_f.p3d",[3022.81,5034.28,218.379],[[-0.840897,-0.541195,0],[0,0,1]],0,0,2,[],{}],
				["Land_Shed_Small_F","a3\structures_f\ind\shed\shed_small_f.p3d",[2958.36,5085.46,213.278],[[0.768093,0.640338,0],[0,0,1]],0,0,2,[],{}],
				["Land_HelipadCircle_F","a3\structures_f\mil\helipads\helipadcircle_f.p3d",[2987.51,5047.78,212.409],[[0.636847,-0.767391,0.0744119],[-0.106589,0.00795532,0.994271]],0,0,2,[],{}],
				["Land_Workshop_04_grey_F","a3\structures_f_enoch\industrial\houses\workshop_04_grey_f.p3d",[2956.85,5053.45,210.887],[[-0.66878,0.743461,0],[0,0,1]],0,1,0,[],{}],
				["Land_TTowerSmall_2_F","a3\structures_f\ind\transmitter_tower\ttowersmall_2_f.p3d",[3001.56,5086.03,222.179],[[0,1,0],[0,0,1]],0,0,2,[],{}],
				["SatelliteAntenna_01_Olive_F","a3\props_f_enoch\military\camps\satelliteantenna_01_f.p3d",[2995.08,5079.91,217.506],[[-0.985078,-0.17211,0],[0,0,1]],0,0,2,[],{}],
				["Land_LampShabby_F","a3\structures_f\civ\lamps\lampshabby_f.p3d",[2988.33,5101.73,216.704],[[0.758018,-0.652233,0],[0,0,1]],0,1,0,[],{}],
				["Land_LampShabby_F","a3\structures_f\civ\lamps\lampshabby_f.p3d",[3036.53,5051.36,221.377],[[-0.673374,0.739302,0],[0,0,1]],0,1,0,[],{}],
				["Land_LampShabby_F","a3\structures_f\civ\lamps\lampshabby_f.p3d",[2998.24,5013.53,217.815],[[0.856925,0.51544,0],[0,0,1]],0,1,0,[],{}],
				["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[2999.2,5072.5,219.312],[[-0.942508,0.334183,0],[0,0,1]],0,1,0,[],{}],
				["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[3000.11,5072.83,219.401],[[-0.697189,-0.716888,0],[0,0,1]],0,1,0,[],{}],
				["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[2998.48,5073.02,219.232],[[-0.71638,0.697711,0],[0,0,1]],0,1,0,[],{}],
				["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[2997.95,5073.58,219.171],[[0.327588,0.944821,0],[0,0,1]],0,1,0,[],{}],
				["Land_LampShabby_F","a3\structures_f\civ\lamps\lampshabby_f.p3d",[2997.71,5074.64,216.923],[[-0.592569,0.80552,0],[0,0,1]],0,1,0,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v2_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v2_f.p3d",[3000.88,5021.55,215.661],[[0.561932,-0.827184,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v2_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v2_f.p3d",[2995.91,5018.22,215.104],[[0.556383,-0.830926,0],[0,0,1]],0,0,2,[],{}]
			],
			[
				["B_T_MRAP_01_F",[3028.19,5040.57,0.193939],328.081],
				["B_T_MRAP_01_F",[3021.4,5035.97,0.197433],326.021],
				["B_T_MRAP_01_F",[3014.82,5031.16,0.201523],325.998],
				["B_T_Truck_01_transport_F",[2984.32,5019.31,0.178513],319.448],
				["B_T_Quadbike_01_F",[2962.71,5054.96,0.225739],47.5845],
				["B_T_Quadbike_01_F",[2960.41,5057.63,0.212616],45.2524],
				["B_G_Offroad_01_F",[2952.52,5079.88,0.0759277],140.99],
				["B_G_Offroad_01_armed_F",[2958.58,5085.15,0.0866699],140.42]
			],
			[2987.42,5048.13,0.00146484],
			[3011,5063.88,0.00111389],
			localize 'STR_QS_Utility_025'
		];
	};	
	if (_type isEqualTo 2) then {
		/*/ East /*/
		_return = [
			[11638.9,7996.84],
			[
				["FlagPole_F","a3\structures_f\mil\flags\mast_f.p3d",[11648.6,7975.99,35.902],[[0,1,0],[0,0,1]],0,1,0,[],{
					missionNamespace setVariable ['QS_module_fob_flag',(_this # 0),TRUE];
					(_this # 0) addEventHandler [
						'Deleted',
						{
							params ['_entity'];
							missionNamespace setVariable ['QS_module_fob_respawnTickets',(round (((_entity getVariable ['QS_deploy_tickets',0]) / 2) max 0)),FALSE];
						}
					];
				}],
				["Land_RepairDepot_01_green_F","a3\structures_f_tank\military\repairdepot\repairdepot_01_green_f.p3d",[11635.9,8037.9,32.9917],[[-0.995977,0.05916,-0.06731],[-0.067049,0.00638931,0.997729]],0,0,2,[],{
					missionNamespace setVariable ['QS_module_fob_repairDepot',(_this # 0),FALSE];
					(_this # 0) hideObjectGlobal TRUE;
				}],
				["Land_GuardHouse_02_F","a3\structures_f_enoch\military\barracks\guardhouse_02_f.p3d",[11651.5,7970.61,34.0367],[[0.153715,0.988115,0],[0,0,1]],0,0,2,[],{
					_building = _this # 0;
					_building animateSource ['Door_1_sound_source',1];
					_building animateSource ['Door_2_sound_source',1];
					_building animateSource ['Door_3_sound_source',1];
					missionNamespace setVariable ['QS_module_fob_HQ',_building,TRUE];
					[_building] spawn {
						_building = _this # 0;
						_building enableSimulationGlobal TRUE;
						_dataTerminal = createSimpleObject ['Land_DataTerminal_01_F',(getPosWorld _building)];
						[1,_dataTerminal,[_building,[-0.6,0,-1]]] call QS_fnc_eventAttach;
						_dataTerminal setDir 90;
						sleep 0.1;
						[0,_dataTerminal] call QS_fnc_eventAttach;
						missionNamespace setVariable ['QS_module_fob_dataTerminal',_dataTerminal,TRUE];
						_crate = createSimpleObject ['a3\weapons_f\ammoboxes\supplydrop.p3d',(getPosWorld _building)];
						[1,_crate,[_building,[-2.2,2.5,-0.7]]] call QS_fnc_eventAttach;
						_crate setDir 90;
						sleep 0.1;
						[0,_crate] call QS_fnc_eventAttach;
						_crate hideObjectGlobal TRUE;
						missionNamespace setVariable ['QS_module_fob_supplycrate',_crate,FALSE];
						sleep 1;
						_building enableSimulationGlobal FALSE;
					};
				}],
				["Land_PortableCabinet_01_medical_F","a3\props_f_enoch\military\camps\portablecabinet_01_medical_f.p3d",[11654.1,7969.84,32.8932],[[-0.110411,-0.993886,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v2_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v2_f.p3d",[11614.8,8042.69,29.9058],[[0.0099755,0.99995,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v2_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v2_f.p3d",[11620.8,8042.63,30.3496],[[0.0099755,0.99995,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v2_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v2_f.p3d",[11626.8,8042.59,30.7597],[[0.0099755,0.99995,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v2_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v2_f.p3d",[11632.8,8042.55,31.1357],[[0.0099755,0.99995,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v2_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v2_f.p3d",[11638.8,8042.51,31.5705],[[0.0099755,0.99995,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v2_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v2_f.p3d",[11644.8,8042.46,32.0568],[[0.0099755,0.99995,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v2_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v2_f.p3d",[11650.8,8042.41,32.5847],[[0.0099755,0.99995,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v2_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v2_f.p3d",[11662.8,8042.33,33.8005],[[0.0099755,0.99995,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v2_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v2_f.p3d",[11668.8,8042.29,34.3495],[[0.0099755,0.99995,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v2_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v2_f.p3d",[11671.6,8039.33,34.7037],[[0.994578,-0.103995,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v2_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v2_f.p3d",[11671,8033.34,34.7181],[[0.994578,-0.103995,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v2_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v2_f.p3d",[11670.4,8027.37,34.7431],[[0.994578,-0.103995,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v2_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v2_f.p3d",[11669.8,8021.41,34.7798],[[0.994578,-0.103995,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v2_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v2_f.p3d",[11669.2,8015.44,34.8222],[[0.994578,-0.103995,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v2_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v2_f.p3d",[11668.6,8009.48,34.8821],[[0.994578,-0.103995,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v2_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v2_f.p3d",[11668,8003.49,34.9136],[[0.994578,-0.103995,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v2_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v2_f.p3d",[11667.4,7997.52,34.8492],[[0.994578,-0.103995,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v2_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v2_f.p3d",[11666.8,7991.56,34.7046],[[0.994578,-0.103995,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v2_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v2_f.p3d",[11666.1,7985.59,34.5229],[[0.994578,-0.103995,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v2_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v2_f.p3d",[11665.4,7979.63,35.1789],[[0.988237,-0.152928,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v2_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v2_f.p3d",[11664.5,7973.68,34.9839],[[0.988237,-0.152928,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v2_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v2_f.p3d",[11663.6,7967.75,34.844],[[0.988237,-0.152928,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v2_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v2_f.p3d",[11662.7,7961.82,34.9047],[[0.988237,-0.152928,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v2_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v2_f.p3d",[11659.4,7958.77,34.6028],[[0.00214902,-0.999998,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v2_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v2_f.p3d",[11653.3,7958.75,34.1223],[[0.00214902,-0.999998,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v2_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v2_f.p3d",[11647.3,7958.72,33.7926],[[0.00214902,-0.999998,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v2_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v2_f.p3d",[11641.3,7958.69,33.4252],[[0.00214902,-0.999998,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v2_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v2_f.p3d",[11635.4,7958.66,33.1203],[[0.00214902,-0.999998,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v2_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v2_f.p3d",[11629.4,7958.63,32.8691],[[0.00214902,-0.999998,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v2_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v2_f.p3d",[11623.3,7958.61,32.6864],[[0.00214902,-0.999998,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v2_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v2_f.p3d",[11617.3,7958.58,32.6526],[[0.00214902,-0.999998,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v2_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v2_f.p3d",[11611.3,7958.54,32.6252],[[0.00214902,-0.999998,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v2_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v2_f.p3d",[11605.3,7958.52,32.4428],[[0.00214902,-0.999998,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v2_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v2_f.p3d",[11593.6,7960.14,31.6911],[[0.302415,0.953176,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v2_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v2_f.p3d",[11599.4,7958.87,32.16],[[0.127324,0.991861,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v2_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v2_f.p3d",[11591.6,7963.98,31.3123],[[0.971134,-0.238535,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v2_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v2_f.p3d",[11595.9,7981.73,31.1134],[[-0.968873,0.247557,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v2_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v2_f.p3d",[11597.4,7987.54,31.1374],[[-0.968873,0.247557,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v2_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v2_f.p3d",[11598.8,7993.35,30.9261],[[-0.968873,0.247557,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v2_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v2_f.p3d",[11600.3,7999.18,30.8818],[[-0.968873,0.247557,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v2_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v2_f.p3d",[11601.8,8005,30.912],[[-0.968873,0.247557,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v2_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v2_f.p3d",[11603.2,8010.82,30.8029],[[-0.968873,0.247557,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v2_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v2_f.p3d",[11604.7,8016.63,30.6713],[[-0.968873,0.247557,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v2_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v2_f.p3d",[11609.5,8034.02,30.669],[[-0.96281,0.270178,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v2_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v2_f.p3d",[11611.1,8039.8,30.6057],[[-0.96281,0.270178,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v2_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v2_f.p3d",[11653.3,8038.1,32.8331],[[0.0099755,0.99995,0],[0,0,1]],0,0,2,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v2_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v2_f.p3d",[11659.2,8038,33.4305],[[0.0166674,0.999861,0],[0,0,1]],0,0,2,[],{}],
				["Land_GuardTower_02_F","a3\structures_f_enoch\military\barracks\guardtower_02_f.p3d",[11660.1,7961.22,36.4881],[[0.685766,-0.727822,0],[0,0,1]],0,0,0,[],{}],
				["Land_GuardTower_02_F","a3\structures_f_enoch\military\barracks\guardtower_02_f.p3d",[11669,8039.27,37.0358],[[0.744794,0.667295,0],[0,0,1]],0,0,0,[],{}],
				["Land_GuardTower_02_F","a3\structures_f_enoch\military\barracks\guardtower_02_f.p3d",[11594.3,7963.1,33.3303],[[-0.794976,-0.60664,0],[0,0,1]],0,0,0,[],{}],
				["Land_Shed_Small_F","a3\structures_f\ind\shed\shed_small_f.p3d",[11605.2,8001.03,31.8734],[[0.24891,0.968527,0],[0,0,1]],0,0,2,[],{}],
				["Land_HelipadCircle_F","a3\structures_f\mil\helipads\helipadcircle_f.p3d",[11644,8006.19,31.7383],[[0.63794,-0.765609,0.0829168],[-0.0892423,0.0334481,0.995448]],0,0,2,[],{}],
				["Land_Workshop_04_grey_F","a3\structures_f_enoch\industrial\houses\workshop_04_grey_f.p3d",[11604.5,7984.2,31.6196],[[0.964729,-0.263244,0],[0,0,1]],0,1,0,[],{}],
				["Land_TTowerSmall_2_F","a3\structures_f\ind\transmitter_tower\ttowersmall_2_f.p3d",[11657.3,7971.82,41.0901],[[0,1,0],[0,0,1]],0,0,2,[],{}],
				["SatelliteAntenna_01_Olive_F","a3\props_f_enoch\military\camps\satelliteantenna_01_f.p3d",[11649.4,7972.81,36.4163],[[-0.987133,0.159899,0],[0,0,1]],0,0,2,[],{}],
				["Land_LampShabby_F","a3\structures_f\civ\lamps\lampshabby_f.p3d",[11660.5,8042.13,36.5541],[[-0.98647,0.163942,0],[0,0,1]],0,1,0,[],{}],
				["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[11652,7975.87,38.1768],[[0.959662,-0.281155,0],[0,0,1]],0,1,0,[],{}],
				["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[11651.2,7975.84,38.1052],[[0.936469,0.350749,0],[0,0,1]],0,1,0,[],{}],
				["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[11646.8,7967.87,37.8224],[[0.704043,0.710158,0],[0,0,1]],0,1,0,[],{}],
				["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[11647.1,7967.19,37.8528],[[0.0816469,0.996661,0],[0,0,1]],0,1,0,[],{}],
				["Land_GuardTower_01_F","a3\structures_f_enoch\military\barracks\guardtower_01_f.p3d",[11620.1,8039.9,34.3063],[[0.999967,-0.00816674,0],[0,0,1]],0,0,2,[],{}],
				["Land_Shed_Small_F","a3\structures_f\ind\shed\shed_small_f.p3d",[11625.5,7962.88,33.0696],[[-0.999941,-0.0109084,0],[0,0,1]],0,0,2,[],{}],
				["Land_LampShabby_F","a3\structures_f\civ\lamps\lampshabby_f.p3d",[11609.2,8031.92,32.7562],[[-0.322078,-0.946713,0],[0,0,1]],0,1,0,[],{}],
				["Land_LampShabby_F","a3\structures_f\civ\lamps\lampshabby_f.p3d",[11592.3,7966.27,33.4069],[[0.205827,0.978588,0],[0,0,1]],0,1,0,[],{}],
				["Land_LampShabby_F","a3\structures_f\civ\lamps\lampshabby_f.p3d",[11647.9,7969.53,35.652],[[0.0365829,0.999331,0],[0,0,1]],0,1,0,[],{}],
				["Land_CamoConcreteWall_01_l_4m_v2_F","a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v2_f.p3d",[11607.8,8016.07,30.7976],[[-0.218266,-0.975889,0],[0,0,1]],0,0,2,[],{}]
			],
			[
				["B_T_Truck_01_transport_F",[11666.2,8026.57,0.151493],186.248],
				["B_T_Quadbike_01_F",[11656.3,7978.47,0.230457],7.98857],
				["B_T_Quadbike_01_F",[11652.8,7979.02,0.223614],5.58041],
				["B_G_Offroad_01_armed_F",[11633.8,7963.49,0.0734138],357.128],
				["B_G_Offroad_01_F",[11625.6,7963.96,0.0639992],359.096],
				["B_T_MRAP_01_F",[11605.5,7992.4,0.18536],103.937],
				["B_T_MRAP_01_F",[11607.4,8000.44,0.176075],101.834],
				["B_T_MRAP_01_F",[11609.1,8008.27,0.174536],104.966]
			],
			[11644,8006.04,0.00123405],
			[11635.4,8033.56,0.00124359],
			localize 'STR_QS_Utility_026'
		];
	};
	_return;
};
if (_worldName isEqualTo 'Stratis') exitWith {[]};
[]