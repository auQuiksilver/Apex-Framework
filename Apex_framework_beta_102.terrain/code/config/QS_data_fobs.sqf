/*/
File: QS_data_fobs.sqf
Author:

	Quiksilver
	
Last modified:

	4/07/2017 A3 1.72 by Quiksilver
	
Description:

	FOB Data
__________________________________________________________________________/*/

_type = _this select 0;
_worldName = worldName;
private _quadType = 'B_G_Quadbike_01_F';
if (_worldName isEqualTo 'Tanoa') then {
	_quadType = 'B_T_Quadbike_01_F';
};
if (_worldName isEqualTo 'Altis') exitWith {
	private _return = [];
	if (_type isEqualTo 0) then {
		/* Central */
		_return = [
			[11877.3,22309.1],
			[
				["Flag_White_F",[1.0498,-4.32031,0],0,[],false,true,false,{
					missionNamespace setVariable ['QS_module_fob_flag',(_this select 0),TRUE];
					(_this select 0);
				}], 
				["Land_LampShabby_F",[1.81738,4.90234,0],265.391,[],false,true,false,{}], 
				["Land_HBarrier_1_F",[0.0136719,-6.6582,0.00244141],269.388,[],false,false,true,{}], 
				["Land_Cargo_HQ_V1_F",[7.31738,3.12891,0],0,[],false,true,false,{
					_obj = _this select 0;
					missionNamespace setVariable ['QS_module_fob_HQ',_obj,TRUE];
					[_obj] spawn {
						_obj = _this select 0;
						private _dataTerminal = createVehicle ['Land_DataTerminal_01_F',(getPosWorld _obj),[],0,'NONE'];
						missionNamespace setVariable [
							'QS_analytics_entities_created',
							((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
							FALSE
						];
						sleep 0.1;
						detach _dataTerminal;
						_dataTerminal attachTo [_obj,[1,1.75,-3.25]];
						sleep 0.1;
						_dataTerminal setDir 90;
						missionNamespace setVariable ['QS_module_fob_dataTerminal',_dataTerminal,TRUE];
						QS_module_fob_dataTerminal attachTo [QS_module_fob_HQ,[1,1.75,-3.25]];
						QS_module_fob_dataTerminal setDir 90;
					};
					_obj;
				}], 
				["Land_HBarrier_Big_F",[4.88086,-6.32813,0.00836945],356.969,[],false,false,true,{}], 
				["Land_TTowerSmall_2_F",[8.64746,-4.87305,-0.00716972],0,[],false,false,true,{}], 
				["Land_TTowerSmall_2_F",[11.1963,-4.42578,0.0199718],120.104,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[5.81055,-11.2793,0.0329475],92.8596,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[13.4355,-6.11133,0.00309181],2.67278,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[6.69336,-15.3516,0.0264454],135.257,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[17.0039,-0.71875,-0.00661278],273.103,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[12.6934,-13.2695,0.00123024],3.39044,[],false,false,true,{}], 
				["Land_HBarrier_5_F",[10.6064,-14.9316,-0.252996],147.567,[],false,false,true,{}], 
				["Land_CncBarrier_F",[-18.4131,0.367188,-5.53131e-005],102.919,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[16.9502,7.92188,-0.0100746],273.176,[],false,false,true,{}], 
				["Land_CncBarrier_F",[-18.6348,-2.14453,-6.67572e-005],87.6085,[],false,false,true,{}], 
				["Land_CncBarrier_F",[-18.2725,-4.58594,-7.05719e-005],76.3436,[],false,false,true,{}], 
				["Land_HBarrier_1_F",[-0.104492,19.8516,0.000434875],269.349,[],false,false,true,{}], 
				["Land_HBarrier_5_F",[16.0801,-15.2637,0.00484467],182.442,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[4.99707,20.0078,-0.00231743],180.642,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[16.7188,16.2207,0.0121613],273.096,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[13.2881,20.082,0.00169563],180.453,[],false,false,true,{}], 
				["Land_CncBarrier_F",[-24.6182,-2.47656,-3.62396e-005],87.6085,[],false,false,true,{}], 
				["Land_CncBarrier_F",[-25.0205,-0.115234,-5.91278e-005],71.4857,[],false,false,true,{}], 
				["Land_CncBarrier_F",[-24.7285,-4.89844,-6.10352e-005],98.1006,[],false,false,true,{}], 
				["Land_HBarrier_5_F",[20.1396,-19.0352,0.0511971],225.493,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[19.8232,-16.209,0.0012455],226.087,[],false,false,true,{}], 
				["Land_HBarrier_1_F",[-16.459,19.6523,0.000835419],269.273,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[5.96484,-25.623,0.045208],57.0906,[],false,false,true,{}], 
				["Land_HBarrier_5_F",[6.89258,-23.6797,0.219658],51.4104,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-27.2969,1.87695,-0.00148582],89.0641,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-26.8691,-6.83789,-0.00166893],89.0623,[],false,false,true,{}], 
				["Land_HBarrier_1_F",[-27.4434,6.74805,0],0.0138461,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[5.24805,-28.9336,0.0826969],92.877,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-21.2295,19.3633,-0.00053215],180.227,[],false,false,true,{}], 
				["Land_HBarrier_1_F",[-26.6113,-11.8418,0.000492096],0.00620041,[],false,false,true,{}], 
				["Land_HBarrier_5_F",[19.9629,-24.1348,0.00982094],275.417,[],false,false,true,{}], 
				["Land_HBarrier_5_F",[10.6348,-27.4043,-0.0468178],359.796,[],false,false,true,{}], 
				["Land_LampHalogen_F",[-22.5859,21.2051,0],63.3204,[],false,true,false,{}], 
				["Land_HBarrier_5_F",[15.6953,-26.9043,-0.0246429],332.371,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[21.8486,-22.625,0.00268173],277.352,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[11.915,-28.2637,-0.325504],359.746,[],false,false,true,{}], 
				["Land_HBarrier_1_F",[-25.9551,19.1191,0.00177765],269.271,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[18.0938,-27.6426,0.00361824],333.225,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-23.9316,24.6133,-0.00159454],89.8985,[],false,false,true,{}], 
				["Land_HBarrier_1_F",[-26.9736,-21.459,0.000864029],3.13825,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[4.94043,-36.5938,0.0087986],92.786,[],false,false,true,{}], 
				["Land_HBarrier_1_F",[-31.8037,18.9063,0.00171471],269.289,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-26.7666,-26.2305,-0.00189972],89.0633,[],false,false,true,{}], 
				["Land_HBarrier_1_F",[-24.1162,29.6699,0.000581741],358.168,[],false,false,true,{}], 
				["Land_HBarrier_1_F",[1.16504,-40.9707,0.000957489],268.559,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-36.418,18.791,-0.00126457],180.231,[],false,false,true,{}], 
				["Land_HBarrier_3_F",[4.75488,-40.9414,-0.0801201],179.447,[],false,false,true,{}], 
				["Land_LampShabby_F",[-25.0195,-33.7656,0],55.4748,[],false,true,false,{}], 
				["Land_Cargo_Patrol_V1_F",[-21.8242,-38.8457,0],0.335386,[],false,true,false,{{(_this select 0) animate _x;} forEach [['hatch_1_rot',1],['hatch_2_rot',1],['hatch_3_rot',1],['hatch_4_rot',1]];(_this select 0);}], 
				["Land_HBarrier_Big_F",[-26.4082,-34.8516,7.05719e-005],89.0999,[],false,false,true,{}], 
				["Land_HBarrier_1_F",[-24.248,37.123,0.000213623],358.138,[],false,false,true,{}], 
				["Land_HBarrier_1_F",[-41.2646,18.541,0.00317001],269.28,[],false,false,true,{}], 
				["Land_HBarrier_3_F",[-22.874,-40.3906,-0.000102997],0.0197628,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-24.2676,41.9434,-0.000976563],89.9377,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-27.3467,-40.4551,0.00630188],2.95011,[],false,false,true,{}], 
				["Land_HBarrier_1_F",[-48.46,18.0996,0.0018959],269.213,[],false,false,true,{}], 
				["Land_HelipadCircle_F",[-37.7148,38.0879,0],24.7135,[],false,false,false,{}], 
				["Land_HBarrier_Big_F",[-35.8691,-40.4219,0.00381279],2.9661,[],false,false,true,{}], 
				["Land_Shed_Small_F",[-31.6094,-39.1504,0.161453],270.916,[],false,false,false,{(_this select 0) setVectorUp [0,0,1];(_this select 0);}], 
				["Land_Cargo_Patrol_V1_F",[-55.9756,-7.23242,0],91.1544,[],false,true,false,{{(_this select 0) animate _x;} forEach [['hatch_1_rot',1],['hatch_2_rot',1],['hatch_3_rot',1],['hatch_4_rot',1]];(_this select 0);}], 
				["Land_HBarrier_Big_F",[-24.3926,50.3848,-0.000602722],89.9392,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-53.3848,18.0488,0.00158882],180.211,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-56.6279,-2.25781,-0.000762939],89.9377,[],false,false,true,{}], 
				["Land_Shed_Small_F",[-54.624,-35.9043,0.285671],359.954,[],false,false,false,{(_this select 0) setVectorUp [0,0,1];(_this select 0);}], 
				["Land_HBarrier_1_F",[-56.8496,2.49023,0.000453949],353.094,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-56.6748,-10.7246,-0.000507355],91.1268,[],false,false,true,{}], 
				["Land_HBarrier_1_F",[-57.1445,9.29297,0.000156403],179.14,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-57.2432,14.0332,-0.00152588],90.5977,[],false,false,true,{}], 
				["Land_HBarrier_1_F",[-22.208,55.1387,0.000396729],99.9272,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-44.1787,-40.3145,-0.00494766],2.7273,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-56.5039,-19.582,0.00448036],271.89,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-57.1719,22.2246,0.00733376],268.445,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-27.3262,55.3145,0.00172234],3.33548,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-56.3857,-27.9434,-0.000640869],89.2033,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-57.6318,31.0098,0.00190926],268.445,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-52.8154,-40.125,-0.00353813],2.87344,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-36.0801,55.6563,0.00232697],3.33973,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-55.9756,-36.6152,0.00223923],270.028,[],false,false,true,{}], 
				["Land_Mil_WallBig_4m_F",[-57.2188,40.7012,-0.0388145],89.9397,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-57.9297,39.4961,0.00180244],268.448,[],false,false,true,{}], 
				["Land_Mil_WallBig_4m_F",[-56.3125,44.1953,-0.0466652],125.761,[],false,false,true,{}], 
				["Land_Mil_WallBig_4m_F",[-53.9795,47.3457,-0.077795],125.761,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-44.667,56.1133,-0.000974655],0.531234,[],false,false,true,{}], 
				["Land_Mil_WallBig_4m_F",[-51.9072,50.4746,-0.0423412],121.602,[],false,false,true,{}], 
				["Land_Mil_WallBig_4m_F",[-49.7871,53.5391,-0.0895901],128.037,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-55.7158,46.5938,0.00194359],307.853,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-50.8438,53.3516,0.00203514],307.852,[],false,false,true,{}]
			],
			[
				["B_G_Van_01_transport_F",[11827.5,22291.5,0.0156975],91.8069],
				["B_G_Van_01_transport_F",[11827.5,22283.5,0.0144081],91.7919],
				["B_G_Offroad_01_F",[11835.8,22275.7,-0.0720425],1.0348],
				["B_G_Offroad_01_F",[11843.8,22275.2,-0.0520267],1.13733],
				["B_G_Offroad_01_F",[11847.2,22283.3,-0.0308762],0.051058],
				[_quadType,[11879.1,22274.9,0.00467873],269.944],
				[_quadType,[11879,22277.4,0.00496864],269.923],
				[_quadType,[11883.4,22325.7,0.0050869],183.166],
				[_quadType,[11886.5,22326,0.0045414],1.8752]
			],
			[11839.6,22347.2,0.00136948],
			[11855.7,22306.7,0.00137138],
			'Trenchfoot'
		];
	};
	if (_type isEqualTo 1) then {
		/* Northwest */
		_return = [
			[5398.9,17910.1],
			[
				["Land_HBarrier_3_F",[-5.43652,2.36328,-0.0379333],85.4875,[],false,false,true,{}], 
				["Land_HBarrier_3_F",[-8.7085,0.212891,0.00863647],0.0073345,[],false,false,true,{}], 
				["Land_HBarrier_3_F",[-8.84863,1.95117,0.0918655],359.971,[],false,false,true,{}], 
				["Land_HBarrier_3_F",[-9.81152,-0.0878906,-0.0247574],265.846,[],false,false,true,{}], 
				["Land_HelipadCircle_F",[10.6929,-13.3203,0],0.0255398,[],false,false,false,{}], 
				["Land_CncBarrier_F",[-19.3345,-5.92188,0.000450134],182.13,[],false,false,true,{}], 
				["Land_HBarrier_3_F",[-13.8833,15.3262,-0.0460587],122.017,[],false,false,true,{}], 
				["Land_HBarrier_5_F",[-15.6841,13.0547,-0.152779],148.112,[],false,false,true,{}], 
				["Land_HBarrier_5_F",[-12.3462,20.2676,0.196083],108.708,[],false,false,true,{}], 
				["Land_CncBarrier_F",[-21.8911,-5.79883,0.000480652],182.13,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-18.6421,13.2324,0.00708771],147.638,[],false,false,true,{}], 
				["Flag_White_F",[-18.3511,-14.5313,-0.0232086],0,[],false,true,false,{
					missionNamespace setVariable ['QS_module_fob_flag',(_this select 0),TRUE];
					(_this select 0);
				}], 
				["Land_HBarrier_3_F",[-18.0054,14.6758,0.0409317],309.601,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-14.4775,18.5352,0.00709534],286.663,[],false,false,true,{}], 
				["Land_CncBarrier_F",[-19.5967,-13.0684,0.000816345],359.826,[],false,false,true,{}], 
				["Land_HBarrier_3_F",[-12.4976,22.6992,0.0933075],91.4057,[],false,false,true,{}], 
				["Land_CncBarrier_F",[-24.4097,-5.69531,0.000221252],183.148,[],false,false,true,{}], 
				["Land_HBarrier_5_F",[-16.0176,17.7305,-0.217064],283.231,[],false,false,true,{}], 
				["Land_CncBarrier_F",[-22.1953,-13.0879,0.000457764],359.826,[],false,false,true,{}], 
				["Land_HBarrier_5_F",[23.2432,6.21875,0.0954819],360,[],false,false,true,{}], 
				["Land_CncBarrier_F",[-25.7202,-6.87891,0.000144958],92.9488,[],false,false,true,{}], 
				["Land_CncBarrier_F",[-25.7383,-9.35547,0.000946045],268.178,[],false,false,true,{}], 
				["Land_CncBarrier_F",[-24.6201,-13.0879,0.000701904],0.015909,[],false,false,true,{}], 
				["Land_HBarrier_5_F",[-14.7153,26.7344,-0.139046],62.5132,[],false,false,true,{}], 
				["Land_CncBarrier_F",[-25.8022,-11.8379,0.00102997],272.616,[],false,false,true,{}], 
				["Land_LampHalogen_F",[-24.7852,-14.5645,0.00108337],171.264,[],false,true,false,{}], 
				["Land_Mil_WallBig_4m_F",[3.82568,29.084,-0.0444031],180.232,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-15.1582,24.6348,-0.0155716],240.819,[],false,false,true,{}], 
				["Land_LampShabby_F",[-26.3564,-13.2793,0],55.0611,[],false,true,false,{}], 
				["Land_Cargo_House_V2_F",[9.77002,28.8164,-0.0222092],0,[],false,true,true,{(_this select 0) animate ['door_1_rot',1];(_this select 0);}],
				["Land_Mil_WallBig_4m_F",[-7.26611,29.2129,-0.0217972],175.197,[],false,false,true,{}], 
				["Land_Cargo_House_V2_ruins_F",[-2.08203,29.8242,0.00189972],0,[],false,false,true,{}], 
				["Land_HBarrier_5_F",[-15.5107,23.0117,0.107735],236.413,[],false,false,true,{}], 
				["Land_Mil_WallBig_4m_F",[-11.1265,28.9238,-0.0982742],175.077,[],false,false,true,{}], 
				["Land_Cargo_HQ_V2_F",[-23.3931,-21.6328,0],180.714,[],false,true,false,{								/*[-23.3931,-21.6328,-1.4069]*/
					_obj = _this select 0;
					missionNamespace setVariable ['QS_module_fob_HQ',_obj,TRUE];
					[_obj] spawn {
						_obj = _this select 0;
						private _dataTerminal = createVehicle ['Land_DataTerminal_01_F',(getPosWorld _obj),[],0,'NONE'];
						missionNamespace setVariable [
							'QS_analytics_entities_created',
							((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
							FALSE
						];
						sleep 0.1;
						detach _dataTerminal;
						_dataTerminal attachTo [_obj,[1,1.75,-3.25]];
						sleep 0.1;
						_dataTerminal setDir 90;
						missionNamespace setVariable ['QS_module_fob_dataTerminal',_dataTerminal,TRUE];
						QS_module_fob_dataTerminal attachTo [QS_module_fob_HQ,[1,1.75,-3.25]];
						QS_module_fob_dataTerminal setDir 90;
					};
					_obj;			
				}], 
				["Land_HBarrier_5_F",[-27.0313,19.6543,0.0116043],56.1116,[],false,false,true,{}], 
				["Land_Cargo20_military_green_F",[18.1187,25.8008,0.0610962],266.469,[],false,false,false,{}], 
				["Land_HBarrier_1_F",[1.96338,-31.6504,0.000274658],310.963,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-27.2451,17.3379,0.00153351],234.106,[],false,false,true,{}], 
				["Land_HBarrier_5_F",[-26.8076,14.1191,-0.00832367],230.45,[],false,false,true,{}], 
				["Land_Mil_WallBig_4m_F",[14.9028,29.6855,-0.0484772],181.858,[],false,false,true,{}], 
				["Land_HBarrier_3_F",[22.2183,23.1133,0.083107],267.972,[],false,false,true,{}], 
				["Land_HBarrierBig_F",[32.437,6.52734,-0.00195313],0.0187361,[],false,false,true,{}], 
				["Land_HBarrier_5_F",[-17.8467,-29.4668,-0.0229263],359.976,[],false,false,true,{}], 
				["Land_LampShabby_F",[23.0142,24.6055,0],130.093,[],false,true,false,{}], 
				["Land_HBarrier_3_F",[23.4072,23.3438,0.0129318],359.878,[],false,false,true,{}], 
				["Land_Cargo_Patrol_V2_F",[35.1514,2.4668,-0.021553],269.572,[],false,true,false,{{(_this select 0) animate _x;} forEach [['hatch_1_rot',1],['hatch_2_rot',1],['hatch_3_rot',1],['hatch_4_rot',1]];(_this select 0);}], 
				["Land_HBarrier_5_F",[-25.623,24.2266,0.060051],110.185,[],false,false,true,{}], 
				["Land_HBarrier_1_F",[-0.521484,-34.5156,0.00149536],251.959,[],false,false,true,{}], 
				["Land_Mil_WallBig_4m_F",[18.9897,30.1172,-0.0722961],179.448,[],false,false,true,{}], 
				["Land_HBarrier_3_F",[-4.17627,-35.0215,0.0541763],0.0146556,[],false,false,true,{}], 
				["Land_HBarrier_3_F",[4.8584,-34.7266,0.0304489],359.987,[],false,false,true,{}], 
				["Land_HBarrier_3_F",[-30.2593,17.9883,-0.0391006],258.633,[],false,false,true,{}], 
				["Land_HBarrierBig_F",[-9.12598,-35.084,-0.00162506],359.819,[],false,false,true,{}], 
				["Land_HBarrierBig_F",[36.1489,-3.97461,-0.00261688],274.797,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-27.8564,23.1836,-0.00119019],292.93,[],false,false,true,{}], 
				["Land_HBarrierBig_F",[11.5859,-34.5195,0.00635529],359.865,[],false,false,true,{}], 
				["Land_HBarrierBig_F",[-22.4497,-29.1016,-0.00137329],2.80118,[],false,false,true,{}], 
				["Land_HBarrierBig_F",[36.6748,3.30273,-0.00203705],276.153,[],false,false,true,{}], 
				["Land_Shed_Small_F",[37.3325,-7.30859,-0.228775],184.047,[],false,false,false,{(_this select 0) setVectorUp [0,0,1];(_this select 0);}], 
				["Land_HBarrier_5_F",[-30.522,20.7402,-0.171349],294.831,[],false,false,true,{}], 
				["Land_HBarrier_5_F",[-35.4707,-16.9961,0.0213852],359.976,[],false,false,true,{}], 
				["Land_Cargo_Patrol_V2_F",[-22.2642,31.5254,3.5],177.886,[],false,true,false,{{(_this select 0) animate _x;} forEach [['hatch_1_rot',1],['hatch_2_rot',1],['hatch_3_rot',1],['hatch_4_rot',1]];(_this select 0);}], 
				["Land_Communication_F",[-30.6563,-21.5352,0.00392914],359.999,[],false,false,true,{}], 
				["Land_HBarrierBig_F",[30.2178,23.5098,-0.00304413],359.978,[],false,false,true,{}], 
				["Land_HBarrier_5_F",[-35.7061,-16.873,-0.236275],241.404,[],false,false,true,{}], 
				["Land_Mil_WallBig_4m_F",[23.9575,31.5762,-0.12442],100.985,[],false,false,true,{}], 
				["Land_HBarrierBig_F",[20.1255,-34.4453,0.00292969],0.131818,[],false,false,true,{}], 
				["Land_HBarrierBig_F",[-39.6177,-9.33594,0.00933838],60.7078,[],false,false,true,{}], 
				["Land_Mil_WallBig_4m_F",[24.4331,35.416,-0.0326157],100.836,[],false,false,true,{}], 
				["Land_Wreck_HMMWV_F",[33.8691,28.4766,0.0063858],264.101,[],false,false,true,{}], 
				["Land_HBarrierBig_F",[28.5806,-33.9727,0.00617218],0.272186,[],false,false,true,{}], 
				["Land_HBarrier_3_F",[32.1626,-32.3477,-0.170547],276.226,[],false,false,true,{}], 
				["Land_Grave_dirt_F",[31.3276,32.2266,-0.000312805],268.095,[],false,false,true,{}], 
				["Land_Cargo_Patrol_V2_F",[-45.9424,4.66016,0.000930786],67.861,[],false,true,false,{{(_this select 0) animate _x;} forEach [['hatch_1_rot',1],['hatch_2_rot',1],['hatch_3_rot',1],['hatch_4_rot',1]];(_this select 0);}], 
				["Land_HBarrierBig_F",[38.2681,23.9707,-0.000915527],0.0688662,[],false,false,true,{}], 
				["Land_Mil_WallBig_4m_F",[26.084,37.4004,0.0253296],175.107,[],false,false,true,{}], 
				["Land_HBarrier_1_F",[-43.2715,14.0215,0.024231],214.614,[],false,false,true,{}], 
				["Land_Grave_forest_F",[34.0244,32.4961,0.000198364],270.426,[],false,false,true,{}], 
				["Land_HBarrierBig_F",[-46.4741,10.9043,0.0390015],142.718,[],false,false,true,{}], 
				["Land_Mil_WallBig_4m_F",[29.7559,37.6152,0.0382004],175.101,[],false,false,true,{}], 
				["Land_HBarrier_5_F",[-49.2021,7.03125,0.334869],63.2965,[],false,false,true,{}], 
				["Land_Mil_WallBig_4m_F",[33.7651,38.4082,0.0647583],175.106,[],false,false,true,{}], 
				["Land_Mil_WallBig_4m_F",[37.251,38.4727,0.0733337],175.171,[],false,false,true,{}], 
				["Land_Mil_WallBig_4m_F",[41.0977,38.748,0.0193176],175.062,[],false,false,true,{}], 
				["Land_Wreck_Slammer_F",[-207.25,-61.5332,0.156265],359.42,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-215.579,-60.0703,0.153687],86.9432,[],false,false,true,{}], 
				["Land_HBarrier_5_F",[-215.15,-64.2676,0.0174255],97.6115,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-218.607,-55.0723,0.0241089],204.626,[],false,true,true,{}], 
				["Land_Cargo_Patrol_V2_F",[-219.276,-58.9902,0],256.47,[],false,true,false,{{(_this select 0) animate _x;} forEach [['hatch_1_rot',1],['hatch_2_rot',1],['hatch_3_rot',1],['hatch_4_rot',1]];(_this select 0);}], 
				["Land_HBarrier_3_F",[-222.762,-64.3672,0.121445],79.7962,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-225.766,-54.4082,0.0432281],347.502,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-223.683,-70.3398,0.0728912],110.085,[],false,false,true,{}], 
				["Land_Cargo_House_V2_F",[-229.153,-68.9375,0],173.557,[],false,true,true,{(_this select 0) animate ['door_1_rot',1];(_this select 0);}],
				["Land_HBarrier_3_F",[-234.731,-52.0195,0.22583],346.192,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-229.134,-74.1523,0.077774],355.83,[],false,false,true,{}], 
				["Land_Mil_WallBig_4m_F",[-234.604,-59.7715,0.857727],146.899,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-236.191,-55.9199,0.0935822],112.886,[],false,false,true,{}], 
				["Land_Mil_WallBig_4m_F",[-235.705,-62.5547,0.254501],76.6692,[],false,false,true,{}], 
				["Land_Mil_WallBig_4m_F",[-234.598,-66.2813,0.0654755],76.6692,[],false,false,true,{}], 
				["Land_Mil_WallBig_4m_F",[-233.583,-69.8691,-0.102463],70.0294,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-233.844,-71.2598,-0.019104],251.762,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-236.211,-63.1934,-0.00747681],258.156,[],false,false,true,{}]
			],
			[
				["B_G_Van_01_transport_F",[5362.05,17909.1,0.0398483],85.3037],
				["B_G_Van_01_transport_F",[5393.65,17933.5,-0.00283051],359.943],
				["B_G_Offroad_01_F",[5429.61,17901.2,-0.0342407],92.5201],
				["B_G_Offroad_01_F",[5430.28,17892.9,-0.0573273],275.761],
				["B_G_Offroad_01_F",[5429.86,17884.9,-0.024231],271.18],
				[_quadType,[5370.8,17898.4,0.0089035],359.984],
				[_quadType,[5367.67,17898,0.00885773],359.973],
				[_quadType,[5366.28,17924.1,0.00737762],179.925],
				[_quadType,[5369.87,17924.1,0.0101013],180.662]
			],
			[5409.02,17896.8,0.00154877],		/*helipad*/
			[5377.99,17899.3,0.00139618],		/* service bay*/
			'Forlorn Hope'						/* Marker text */
		];
	};
	if (_type isEqualTo 2) then {
		/* northeast */
		_return = [
			[22343.2,19984.3],
			[
				["Flag_White_F",[3.01758,-3.4707,0.00574303],0,[],false,true,false,{
					missionNamespace setVariable ['QS_module_fob_flag',(_this select 0),TRUE];
					(_this select 0);
				}], 
				["Land_Cargo_HQ_V1_F",[5.87305,5.21875,0],341.871,[],false,true,false,{					/*/[5.87305,5.21875,-1.4069]/*/
					_obj = _this select 0;
					missionNamespace setVariable ['QS_module_fob_HQ',_obj,TRUE];
					[_obj] spawn {
						_obj = _this select 0;
						private _dataTerminal = createVehicle ['Land_DataTerminal_01_F',(getPosWorld _obj),[],0,'NONE'];
						missionNamespace setVariable [
							'QS_analytics_entities_created',
							((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
							FALSE
						];
						sleep 0.1;
						detach _dataTerminal;
						_dataTerminal attachTo [_obj,[1,1.75,-3.25]];
						sleep 0.1;
						_dataTerminal setDir 90;
						missionNamespace setVariable ['QS_module_fob_dataTerminal',_dataTerminal,TRUE];
						QS_module_fob_dataTerminal attachTo [QS_module_fob_HQ,[1,1.75,-3.25]];
						QS_module_fob_dataTerminal setDir 90;
					};
					_obj;				
				}], 
				["Land_LampHalogen_F",[10.2676,-0.863281,0],294.565,[],false,true,false,{}], 
				["Land_TTowerSmall_2_F",[11.7656,-0.283203,-0.0286846],256.009,[],false,false,true,{}], 
				["Land_TTowerSmall_2_F",[14.1387,0.191406,-0.0290565],256.009,[],false,false,true,{}], 
				["Land_Cargo_House_V1_F",[13.7188,-7.24609,-0.0111685],75.9347,[],false,true,true,{(_this select 0) animate ['door_1_rot',1];(_this select 0);}],
				["Land_HBarrier_Big_F",[14.7676,-1.89258,0.0148659],345.402,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[7.43555,13.4219,0.0420504],161.078,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[16.332,3.98828,0.0053997],252.592,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[13.5742,12.0723,0.0062542],252.523,[],false,false,true,{}], 
				["Land_LampShabby_F",[17.1504,6.27148,0.0167389],53.7447,[],false,true,false,{}], 
				["Land_CncBarrier_F",[17.25,8.00977,0.000782013],70.8476,[],false,false,true,{}], 
				["Land_CncBarrier_F",[16.498,10.3965,0.000768661],72.6518,[],false,false,true,{}], 
				["Land_CncBarrier_F",[18.7578,6.23633,0.00104809],25.4105,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[19.2617,-5.77344,0.00583267],77.7656,[],false,false,true,{}], 
				["Land_CncBarrier_F",[15.7832,12.7227,0.000859261],72.6518,[],false,false,true,{}], 
				["Land_HBarrier_1_F",[-15.1563,-13.5293,0.000980377],72.0809,[],false,false,true,{}], 
				["Land_CncBarrier_F",[21.1309,5.99219,0.00108528],347.586,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[10.5703,19.9063,-0.00146294],250.227,[],false,false,true,{}], 
				["Land_HBarrier_1_F",[20.541,-10.6035,0.000899315],169.656,[],false,false,true,{}], 
				["Land_CncBarrier_F",[23.3789,7.04102,0.00104141],322.874,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-19.9648,-14.9375,0.00102997],164.747,[],false,false,true,{}], 
				["Land_HelipadCircle_F",[-2.08008,-24.9785,3.62396e-005],59.6581,[],false,false,false,{}], 
				["Land_CncBarrier_F",[24.1367,9.04492,0.000317574],251.126,[],false,false,true,{}], 
				["Land_JunkPile_F",[25.3535,5.56445,-0.00794411],247.784,[],false,false,true,{}], 
				["Land_CncBarrier_F",[23.4102,11.4492,0.000390053],251.126,[],false,false,true,{}], 
				["Land_Tyres_F",[26.1563,2.83984,0.0557556],47.2986,[],false,false,true,{}], 
				["Land_GarbageWashingMachine_F",[26.2891,-0.689453,-0.00158691],359.93,[],false,false,true,{}], 
				["Land_HBarrier_3_F",[8.82031,23.9512,-0.0307274],248.792,[],false,false,true,{}], 
				["Land_CncBarrier_F",[22.5605,13.832,0.000390053],251.126,[],false,false,true,{}], 
				["Land_Tyres_F",[26.2656,-3.42578,0.0142126],359.929,[],false,false,true,{}], 
				["Land_HBarrier_5_F",[-29.3418,2.83594,-0.0335941],343.953,[],false,false,true,{}], 
				["Land_HBarrier_3_F",[21.584,-15.707,-0.0372601],83.6909,[],false,false,true,{}], 
				["Land_Tyres_F",[28.0313,-2.97656,-0.0227928],206.479,[],false,false,true,{}], 
				["Land_HBarrier_3_F",[-27.9277,-5.28516,-0.0116472],68.4797,[],false,false,true,{}], 
				["Land_HBarrier_3_F",[-25.6387,-12.6602,-0.0162096],68.491,[],false,false,true,{}], 
				["Land_LampShabby_F",[-28.9551,1.9707,0.00148201],108.481,[],false,true,false,{}], 
				["Land_HBarrier_Big_F",[28.4375,6.64648,0.00251675],71.7865,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-29.1895,-1.78711,0.00748539],252.388,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-23.5352,-17.959,0.00221157],252.362,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[25.9316,14.5508,0.000123978],72.7613,[],false,false,true,{}], 
				["Land_Cargo_House_V1_F",[27.2832,-15.5996,0],167.638,[],false,true,true,{(_this select 0) animate ['door_1_rot',1];(_this select 0);}],
				["Land_Cargo_Patrol_V1_F",[-31.5605,5.75391,0.00716972],72.3388,[],false,true,false,{{(_this select 0) animate _x;} forEach [['hatch_1_rot',1],['hatch_2_rot',1],['hatch_3_rot',1],['hatch_4_rot',1]];(_this select 0);}], 
				["Land_HBarrier_5_F",[-31.6328,9.50586,0.0803185],343.921,[],false,false,true,{}], 
				["Land_HBarrier_3_F",[-21.7598,-23.0508,0.0220394],252.615,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[22.8164,-21.8516,0.00252151],257.81,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[31.7441,-4.10938,0.00275326],77.357,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-32.0645,6.1543,0.0241823],252.405,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-28.2305,-17.6855,0.000318527],344.05,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[22.3086,25.1055,0.000957489],71.8315,[],false,false,true,{}], 
				["Land_HBarrier_1_F",[22.5625,-26.3926,0.000911713],210.986,[],false,false,true,{}], 
				["Land_HBarrier_3_F",[-33.9473,11.9277,-0.0182257],79.6104,[],false,false,true,{}], 
				["Land_HBarrier_3_F",[-19.0742,-30.707,0.0256996],252.624,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[26.8535,-23.5039,-0.00159836],156.492,[],false,false,true,{}], 
				["Land_HBarrier_1_F",[17.0879,-31.4023,0.000131607],210.947,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[33.4707,-12.4824,0.00199318],80.8655,[],false,false,true,{}], 
				["Land_HBarrier_1_F",[20.9355,29.7559,0.00615215],359.731,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[32.1895,-18.9238,9.91821e-005],129.739,[],false,false,true,{}], 
				["Land_JunkPile_F",[-35.3105,-13.1426,0.00590134],359.985,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[14.6563,-35.0801,-0.00134659],121.406,[],false,false,true,{}], 
				["Land_Tyres_F",[-36.5156,-11.3379,0.0282412],359.992,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-17.8594,-33.7324,0.00837231],252.37,[],false,false,true,{}], 
				["Land_Tyres_F",[-37.0977,-9.75977,-0.00119591],206.457,[],false,false,true,{}], 
				["Land_Tyres_F",[-37.8535,-8.45508,0.00501347],47.1911,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-35.3711,-17.1035,-0.000734329],26.5105,[],false,false,true,{}], 
				["Land_HBarrier_3_F",[-3.25,40.543,-0.0619097],79.6687,[],false,false,true,{}], 
				["Land_GarbageWashingMachine_F",[-40.1914,-4.5,-0.000174522],359.991,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[9.02539,-39.8418,0.00321579],164.502,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-13.1797,-38.7695,0.0179901],208.648,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-39.9395,-12.0176,-0.00126648],67.7247,[],false,true,true,{}], 
				["Land_JunkPile_F",[-41.7852,1.32422,-0.00174999],247.648,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[0.935547,-42.0723,0.00735092],164.467,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-6.14258,-42.1289,0.00765038],201.652,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-42.8809,-4.17969,-0.00132847],71.6846,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-4.76953,43.9824,0.0420208],248.497,[],false,false,true,{}], 
				["Land_HBarrier_5_F",[-6.75,44.1641,-0.392488],159.79,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-45.5117,3.2168,-0.00122356],71.6895,[],false,false,true,{}], 
				["Land_HBarrier_1_F",[-47.0098,7.5625,0.000131607],0.00101843,[],false,false,true,{}], 
				["Land_HBarrier_3_F",[-39.9609,27.6836,-0.0345087],74.1624,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-6.65039,48.6855,0.00224018],250.605,[],false,false,true,{}], 
				["Land_Cargo_Patrol_V1_F",[-12.0469,50.5371,0.0244427],163.718,[],false,true,false,{{(_this select 0) animate _x;} forEach [['hatch_1_rot',1],['hatch_2_rot',1],['hatch_3_rot',1],['hatch_4_rot',1]];(_this select 0);}], 
				["Land_HBarrier_Big_F",[-41.2285,31.0176,-0.0033865],70.5687,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-11.5273,51.3789,0.00600243],166.876,[],false,false,true,{}], 
				["Land_HBarrier_1_F",[-15.8984,50.1797,0.000207901],257.902,[],false,false,true,{}], 
				["Land_HBarrier_1_F",[-21.002,48.9121,0.00022316],257.917,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-25.3125,47.6016,0.00228596],164.581,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-49.6289,24.3555,-0.00064373],164.046,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-33.2891,45.4219,-0.000867844],164.181,[],false,false,true,{}], 
				["Land_HBarrier_1_F",[-52.3047,21.2422,0.000267029],162.187,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-44.2207,38.4258,-0.00338459],70.5478,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-41.4004,42.873,-0.00165844],166.09,[],false,false,true,{}], 
				["Land_LampShabby_F",[-43.8828,41,0],117.43,[],false,true,false,{}], 
				["Land_HBarrier_Big_F",[-54.127,25.8242,-0.00128078],71.6995,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-48.9375,38.9551,0.000891685],326.826,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-53.8926,32.8008,0.00174809],296.879,[],false,false,true,{}]
			],
			[
				["B_G_Van_01_transport_F",[22318,20027.4,0.0262794],343.335],
				["B_G_Van_01_transport_F",[22312.9,20024.1,0.0244427],159.411],
				["B_G_Offroad_01_F",[22323,19973.3,-0.0417566],72.7205],
				["B_G_Offroad_01_F",[22320.6,19978.7,-0.0464363],255.243],
				["B_G_Offroad_01_F",[22318.8,19984,-0.0404987],76.0835],
				[_quadType,[22334.2,20025.4,-0.010622],252.432],
				[_quadType,[22346.8,19999.9,0.0109558],339.826],
				[_quadType,[22349.4,20000.8,0.0114098],339.833],
				[_quadType,[22325,19966.3,0.00566483],161.299]
			],
			[22341,19959.2,0.00135899],
			[22364.3,19993.9,0.00131226],
			'Donald'
		];
	};
	if (_type isEqualTo 3) then {
		/*/southeast/*/
		_return = [
			[16920.4,9966.65],
			[
				["Land_HBarrier_Big_F",[12.5059,-8.70117,-0.00060463],93.0589,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[15.5957,-2.7666,-0.0131016],322.334,[],false,false,true,{}], 
				["Land_JunkPile_F",[15.793,-8.54199,-0.000139236],0,[],false,false,true,{}], 
				["Land_Tyres_F",[16.5098,-6.51758,-0.00521851],290.672,[],false,false,true,{}], 
				["Land_LampShabby_F",[-14.3926,11.623,0],115.179,[],false,true,false,{}], 
				["Land_GarbageBags_F",[17.4648,-5.18848,0.0209484],359.998,[],false,false,true,{}], 
				["Land_LampHalogen_F",[-16.0254,8.99023,0],274.84,[],false,true,false,{}], 
				["Land_HBarrier_3_F",[12.2051,-15.3477,0.0271149],276.137,[],false,false,true,{}], 
				["Land_LampShabby_F",[-16.1738,11.6846,0],295.005,[],false,true,false,{}], 
				["Land_HBarrier_Big_F",[-18.4082,9.2627,-0.00148773],334.133,[],false,false,true,{}], 
				["Land_CncBarrier_F",[20.3125,-6.05078,0],112.944,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[21.7324,2.43359,0.00201797],141.055,[],false,false,true,{}], 
				["Land_CncBarrier_F",[21.7168,-3.74805,-7.62939e-005],129.037,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-16.4902,15.4463,0.00213051],246.425,[],false,false,true,{}], 
				["Land_CncBarrier_F",[23.4863,-1.72266,0.0020256],129.037,[],false,false,true,{}], 
				["Land_HBarrier_1_F",[-22.8164,7.03223,0.000328064],245.354,[],false,false,true,{}], 
				["Land_HBarrier_3_F",[12.0566,21.7383,0.100632],195.095,[],false,false,true,{}], 
				["Land_HBarrier_5_F",[9.43164,22.5713,-0.00519371],235.162,[],false,false,true,{}], 
				["Land_HBarrier_3_F",[26.6133,6.43066,0.109404],141.726,[],false,false,true,{}], 
				["Land_HBarrier_1_F",[-18.625,19.8311,0.000162125],158.008,[],false,false,true,{}], 
				["Land_HBarrier_5_F",[16.1074,24.6465,0.177311],143.283,[],false,false,true,{}], 
				["Land_CncBarrier_F",[25.4746,-10.1484,0.00202942],114.717,[],false,false,true,{}], 
				["Land_CncBarrier_F",[26.7207,-8.07813,0.00200081],127.222,[],false,false,true,{}], 
				["Land_CncBarrier_F",[28.3203,-5.95313,0.00200272],127.222,[],false,false,true,{}], 
				["Land_HBarrier_5_F",[24.7207,-18.3154,-0.108276],297.367,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[29.332,-10.7266,0.0383644],307.525,[],false,false,true,{}], 
				["Land_HBarrier_3_F",[24.2422,-21.0166,-0.00176811],280.904,[],false,false,true,{}], 
				["Land_HelipadCircle_F",[-18.4375,-25.8799,0],19.3771,[],false,false,false,{}], 
				["Land_Mil_WallBig_4m_F",[23.2773,-22.9746,0.143337],276.773,[],false,false,true,{}], 
				["Land_LampShabby_F",[32.6875,-3.51855,0.0187588],254.741,[],false,true,false,{}], 
				["Land_Mil_WallBig_4m_F",[34.6641,-1.87695,0.204683],317.266,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[34.1172,-4.24805,-0.00146675],131.362,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[24.3477,-24.8564,0.00693512],91.3544,[],false,false,true,{}], 
				["Land_Mil_WallBig_4m_F",[23.1582,-26.8594,0.132931],272.51,[],false,false,true,{}], 
				["Land_HBarrier_5_F",[4.1875,33.4346,0.238567],246.524,[],false,false,true,{}], 
				["Land_Unfinished_Building_01_F",[12.3809,33.4863,0.327715],143.059,[],false,false,false,{}], 
				["Land_Mil_WallBig_4m_F",[37.3164,0.686523,-0.0768623],307.206,[],false,false,true,{}], 
				["Land_Mil_WallBig_4m_F",[23.3379,-30.5869,0.0390377],264.221,[],false,false,true,{}], 
				["Land_HBarrier_3_F",[2.12695,37.9209,0.0305576],228.099,[],false,false,true,{}], 
				["Land_Mil_WallBig_4m_F",[39.75,3.74512,-0.0420742],308.776,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[39.668,1.98633,-0.000150681],131.779,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[24.6621,-32.8916,0.00137901],88.5842,[],false,false,true,{}], 
				["Land_Mil_WallBig_4m_F",[23.6641,-34.3857,0.0540409],264.221,[],false,false,true,{}], 
				["Land_HBarrier_5_F",[-42.5801,3.04785,5.34058e-005],75.9973,[],false,false,true,{}], 
				["Land_HBarrier_1_F",[-23.3965,35.2529,0.00464058],158.786,[],false,false,true,{}], 
				["Land_Mil_WallBig_4m_F",[42.2402,6.81543,0.120619],311.573,[],false,false,true,{}], 
				["Land_d_Stone_Shed_V1_F",[22.8418,38.2959,0.0205002],318.439,[],false,false,true,{}], 
				["Land_HBarrier_5_F",[-42.1895,-1.27637,0.0511189],165.029,[],false,false,true,{}], 
				["Land_Mil_WallBig_4m_F",[23.334,-38.5117,0.105715],290.467,[],false,false,true,{}], 
				["Flag_White_F",[-35.1113,27.6797,0],0,[],false,true,false,{
					missionNamespace setVariable ['QS_module_fob_flag',(_this select 0),TRUE];
					(_this select 0);
				}], 
				["Land_Mil_WallBig_4m_F",[44.4277,9.99023,-0.0146332],309.085,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[44.7188,8.59863,-0.00285721],126.634,[],false,false,true,{}], 
				["Land_LampShabby_F",[-46.0703,-3.38672,0],170.648,[],false,true,false,{}], 
				["Land_Cargo_House_V3_F",[-45.7832,11.127,-0.0891342],257.727,[],false,true,true,{(_this select 0) animate ['door_1_rot',1];(_this select 0);}],
				["Land_Mil_WallBig_4m_F",[21.4063,-42.0732,-0.00655556],305.198,[],false,false,true,{}], 
				["Land_Cargo_Patrol_V3_F",[-48.0625,1.20117,-0.0142536],77.6609,[],false,true,false,{{(_this select 0) animate _x;} forEach [['hatch_1_rot',1],['hatch_2_rot',1],['hatch_3_rot',1],['hatch_4_rot',1]];(_this select 0);}], 
				["Land_Cargo_House_V3_F",[-32.2813,35.2822,-0.0233936],333.32,[],false,true,true,{(_this select 0) animate ['door_1_rot',1];(_this select 0);}],
				["Land_HBarrier_Big_F",[23.4707,-40.8379,0.000881195],113.823,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-25.4023,39.5625,0.029253],246.016,[],false,false,true,{}], 
				["Land_HBarrier_3_F",[-47.4766,-3.60742,-0.0028019],64.0535,[],false,false,true,{}], 
				["Land_HBarrier_5_F",[16.2227,-43.6279,-0.0692806],18.0321,[],false,false,true,{}], 
				["Land_Mil_WallBig_4m_F",[46.7832,13.0908,-0.0160961],306.522,[],false,false,true,{}], 
				["Land_Mil_WallBig_4m_F",[-41.8184,-25.1709,-0.0348434],83.3644,[],false,false,true,{}], 
				["Land_Cargo_HQ_V3_F",[-43.0332,24.1035,0],208.23,[],false,true,false,{					/*/[-43.0332,24.1035,-1.4069]/*/
					_obj = _this select 0;
					missionNamespace setVariable ['QS_module_fob_HQ',_obj,TRUE];
					[_obj] spawn {
						_obj = _this select 0;
						private _dataTerminal = createVehicle ['Land_DataTerminal_01_F',(getPosWorld _obj),[],0,'NONE'];
						missionNamespace setVariable [
							'QS_analytics_entities_created',
							((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
							FALSE
						];
						sleep 0.1;
						detach _dataTerminal;
						_dataTerminal attachTo [_obj,[1,1.75,-3.25]];
						sleep 0.1;
						_dataTerminal setDir 90;
						missionNamespace setVariable ['QS_module_fob_dataTerminal',_dataTerminal,TRUE];
						QS_module_fob_dataTerminal attachTo [QS_module_fob_HQ,[1,1.75,-3.25]];
						QS_module_fob_dataTerminal setDir 90;
					};
					_obj;				
				}], 
				["Land_HBarrier_Big_F",[-48.6523,1.125,0.00177765],79.7277,[],false,false,true,{}], 
				["Land_HBarrier_5_F",[2.15234,49.8281,-0.0317326],148.752,[],false,false,true,{}], 
				["Land_HBarrier_3_F",[-44.043,-21.1787,0.0740604],90.9533,[],false,false,true,{}], 
				["Land_HBarrier_5_F",[11.1211,-50.6211,0.0948677],274.246,[],false,false,true,{}], 
				["Land_Mil_WallBig_4m_F",[-41.0391,-29.0176,-0.261724],78.8979,[],false,false,true,{}], 
				["Land_HBarrier_5_F",[-1.82227,47.998,0.145571],241.23,[],false,false,true,{}], 
				["Land_Mil_WallBig_4m_F",[-9.33398,-50.2188,0.191185],5.91504,[],false,false,true,{}], 
				["Land_Mil_WallBig_4m_F",[19.584,-47.6865,-0.0236073],301.149,[],false,false,true,{}], 
				["Land_Mil_WallBig_4m_F",[-13.3086,-49.9053,0.169184],5.91504,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-50.6523,9.1543,0.0613365],80.0777,[],false,false,true,{}], 
				["Land_HBarrier_1_F",[-7.06055,-50.9707,0.000444412],91.4886,[],false,false,true,{}], 
				["Land_LampShabby_F",[10.2734,-50.5742,0],284.063,[],false,true,false,{}], 
				["Land_Cargo_Patrol_V3_F",[14.0918,-50.8154,0.03018],2.07213,[],false,true,false,{{(_this select 0) animate _x;} forEach [['hatch_1_rot',1],['hatch_2_rot',1],['hatch_3_rot',1],['hatch_4_rot',1]];(_this select 0);}], 
				["Land_HBarrier_Big_F",[-43.2402,-28.0693,0.00614166],80.0973,[],false,false,true,{}], 
				["Land_HBarrier_3_F",[-23.7695,45.8398,0.18313],152.476,[],false,false,true,{}], 
				["Land_LampShabby_F",[-4.90039,51.5527,0],244.592,[],false,true,false,{}], 
				["Land_Mil_WallBig_4m_F",[-40.3301,-33.084,0.0778828],82.2249,[],false,false,true,{}], 
				["Land_Mil_WallBig_4m_F",[-17.2305,-49.5195,0.0566692],5.87948,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[49.7148,15.7168,0.00944138],127.348,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-11.4902,-50.8809,0.0111389],185.87,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[20.1543,-48.1924,-0.00310898],119.782,[],false,false,true,{}], 
				["Land_HBarrier_1_F",[9.41211,-51.502,0.000537872],266.798,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-30.0293,42.8848,0.00891209],156.552,[],false,false,true,{}], 
				["Land_Mil_WallBig_4m_F",[17.3184,-50.0635,-0.0099678],328.504,[],false,false,true,{}], 
				["Land_HBarrier_3_F",[-5.41797,52.7451,-0.000980377],154.957,[],false,false,true,{}], 
				["Land_Mil_WallBig_4m_F",[-21.1484,-49.1094,0.0605087],5.87467,[],false,false,true,{}], 
				["Land_Cargo_Patrol_V3_F",[-1.7207,54.5039,-0.0391369],151.016,[],false,true,false,{{(_this select 0) animate _x;} forEach [['hatch_1_rot',1],['hatch_2_rot',1],['hatch_3_rot',1],['hatch_4_rot',1]];(_this select 0);}], 
				["Land_HBarrier_5_F",[50.5977,19.7744,0.314045],225.479,[],false,false,true,{}], 
				["Land_Mil_WallBig_4m_F",[-39.4453,-36.8389,0.0584965],78.4033,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[14.4609,-51.5684,-0.00222778],183.843,[],false,false,true,{}], 
				["Land_HBarrier_1_F",[33.1699,42.3262,0.000377655],235.973,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-19.8477,-50.7324,0.00223732],2.69984,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-37.8516,39.3096,-0.000680923],156.337,[],false,false,true,{}], 
				["Land_Mil_WallBig_4m_F",[-24.9375,-49.0459,0.0270405],359.332,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-41.5215,-36.6406,-0.00270653],79.461,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-1.53125,55.2363,0.00759315],327.449,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-52.4277,17.6016,0.0454311],78.6686,[],false,false,true,{}], 
				["Land_Mil_WallBig_4m_F",[-38.7148,-40.5703,0.0464668],80.1343,[],false,false,true,{}], 
				["Land_Mil_WallBig_4m_F",[-28.7402,-49.3164,0.0269699],358.503,[],false,false,true,{}], 
				["Land_GarbageContainer_open_F",[4.83008,56.7334,0.00148392],147.115,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-45.2793,35.5752,-0.00287151],156.293,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-27.6895,-50.7021,0.00345802],2.45672,[],false,false,true,{}], 
				["Land_Mil_WallBig_4m_F",[-38.1719,-44.2637,-0.00421906],82.1163,[],false,false,true,{}], 
				["Land_Cargo_House_V3_F",[30.8359,50.4189,0.00266647],53.2016,[],false,true,true,{(_this select 0) animate ['door_1_rot',1];(_this select 0);}], 
				["Land_HBarrier_5_F",[48.6191,27.9482,-0.0422363],316.693,[],false,false,true,{}], 
				["Land_GarbageContainer_closed_F",[6.63867,58.1396,0.0103703],151.072,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[36.8164,45.4834,0.00160408],320.495,[],false,false,true,{}], 
				["Land_Mil_WallBig_4m_F",[-32.6855,-49.2207,0.0514469],6.45633,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[54.543,21.7178,-0.00185776],137.058,[],false,false,true,{}], 
				["Land_Tyres_F",[10.0313,58.374,0.000910759],254.64,[],false,false,true,{}], 
				["Land_Mil_WallBig_4m_F",[-36.3477,-47.6748,0.0649815],37.9595,[],false,false,true,{}], 
				["Land_LampShabby_F",[51.0957,31.5107,0],301.669,[],false,true,false,{}], 
				["Land_HBarrier_Big_F",[-39.6191,-45.0254,-0.00367165],79.5196,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-54.6367,25.8213,0.00344086],254.497,[],false,false,true,{}], 
				["Land_Tyres_F",[11.4043,59.5137,0.0678129],0.138908,[],false,false,true,{}], 
				["Land_Cargo_Patrol_V3_F",[54.5605,28.9541,0.0512562],228.48,[],false,true,false,{{(_this select 0) animate _x;} forEach [['hatch_1_rot',1],['hatch_2_rot',1],['hatch_3_rot',1],['hatch_4_rot',1]];(_this select 0);}], 
				["Land_HBarrier_Big_F",[5.49805,60.3193,0.00710106],327.45,[],false,false,true,{}], 
				["Land_HBarrier_3_F",[52.873,31.7529,0.000572205],224.808,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-35.7637,-50.0762,-0.00169182],188.174,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-53.0508,31.751,-0.0040884],156.23,[],false,false,true,{}], 
				["Land_Cargo_House_V3_F",[26.2344,57.1543,0.0137405],53.2016,[],false,true,true,{(_this select 0) animate ['door_1_rot',1];(_this select 0);}],
				["Land_HBarrier_Big_F",[55.627,28.207,0.0027771],234.628,[],false,false,true,{}], 
				["Land_HBarrier_3_F",[43.0234,45.2988,0.0580711],241.636,[],false,false,true,{}], 
				["Land_JunkPile_F",[15.5313,61.7656,0.0149193],0.10766,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[39.4863,50.4668,0.00119781],234.583,[],false,false,true,{}], 
				["Land_GarbagePallet_F",[17.5645,63.25,0.0251579],133.628,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[35.0898,56.3027,0.0184193],234.383,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[12.6191,65.2334,0.00898933],327.52,[],false,false,true,{}], 
				["Land_GarbagePallet_F",[20.4746,65.4004,-0.00792885],0.0432421,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[30.2051,62.8398,0.0184212],234.383,[],false,false,true,{}], 
				["Land_GarbageWashingMachine_F",[22.5762,67.2666,-0.00213051],0.0783501,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[18.9766,69.4453,0.0147457],327.445,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[25.1211,69.5654,0.0168457],234.38,[],false,false,true,{}]
			],
			[
				["B_G_Van_01_transport_F",[16938.4,9933.84,0.0188465],95.0396],
				["B_G_Van_01_transport_F",[16936.2,9927.77,0.028059],284.755],
				["B_G_Offroad_01_F",[16966,9986.39,-0.0223694],314.523],
				["B_G_Offroad_01_F",[16963.2,9982.1,-0.0226402],135.086],
				["B_G_Offroad_01_F",[16959.3,9977.79,-0.033987],135.292],
				[_quadType,[16904.6,9973.08,0.00403976],160.629],
				[_quadType,[16900.9,9971.58,0.00464058],160.627],
				[_quadType,[16900.7,9980.77,0.00444984],244.637],
				[_quadType,[16899.4,9983.27,0.00471878],244.638]
			],
			[16902,9940.71,0.00138855],
			[16944.2,9960.85,0.00100899],
			'Alamo'
		];
	};
	if (_type isEqualTo 4) then {
		/*/southwest/*/
		_return = [
			[7379.61,11437.6],
			[
				["Flag_White_F",[0.70166,4.50195,-0.00757599],0,[],false,true,false,{
					missionNamespace setVariable ['QS_module_fob_flag',(_this select 0),TRUE];
					(_this select 0);
				}], 
				["Land_LampShabby_F",[-4.85156,-3.70801,0],75.4867,[],false,true,false,{}], 
				["Land_HBarrier_1_F",[3.10742,5.66113,0.000735283],320.559,[],false,false,true,{}], 
				["Land_LampHalogen_F",[-5.05176,-4.42871,0],260.618,[],false,true,false,{}], 
				["Land_Cargo_HQ_V1_F",[-7.94727,1.48438,0],213.639,[],false,true,false,{				/*/[-7.94727,1.48438,-1.4069]/*/
					_obj = _this select 0;
					missionNamespace setVariable ['QS_module_fob_HQ',_obj,TRUE];
					[_obj] spawn {
						_obj = _this select 0;
						private _dataTerminal = createVehicle ['Land_DataTerminal_01_F',(getPosWorld _obj),[],0,'NONE'];
						missionNamespace setVariable [
							'QS_analytics_entities_created',
							((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
							FALSE
						];
						sleep 0.1;
						detach _dataTerminal;
						_dataTerminal attachTo [_obj,[1,1.75,-3.25]];
						sleep 0.1;
						_dataTerminal setDir 90;
						missionNamespace setVariable ['QS_module_fob_dataTerminal',_dataTerminal,TRUE];
						QS_module_fob_dataTerminal attachTo [QS_module_fob_HQ,[1,1.75,-3.25]];
						QS_module_fob_dataTerminal setDir 90;
					};
					_obj;
				}], 
				["Land_HBarrier_Big_F",[-0.779785,8.39941,0],36.5528,[],false,false,true,{}], 
				["Land_TTowerSmall_2_F",[-5.78662,8.95898,0],137.281,[],false,false,true,{}], 
				["Land_TTowerSmall_2_F",[-6.96045,10.0254,0.00866127],0,[],false,false,true,{}], 
				["Land_HBarrier_3_F",[-11.4116,-5.94336,0.000868797],213.996,[],false,false,true,{}], 
				["Land_Cargo_House_V1_F",[13.7383,8.19531,0.034915],55.9502,[],false,true,true,{(_this select 0) animate ['door_1_rot',1];(_this select 0);}],
				["Land_HBarrier_Big_F",[-8.08643,12.7773,-0.0021286],32.4325,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-15.8311,-2.48047,0.0703888],213.648,[],false,false,true,{}], 
				["Land_HBarrier_3_F",[15.0435,3.41602,-0.0363827],329.664,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-13.6357,9.79102,0.00270271],305.003,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-18.1714,2.71094,0.061739],305.85,[],false,false,true,{}], 
				["Land_HBarrier_1_F",[-9.91064,15.7725,0.0236216],29.6664,[],false,false,true,{}], 
				["Land_Cargo_House_V1_F",[22.1797,-0.206055,0],67.5952,[],false,true,true,{(_this select 0) animate ['door_1_rot',1];(_this select 0);}],
				["Land_HBarrier_Big_F",[20.7798,7.2041,0.000314713],148.221,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[14.3984,17.7588,0.00472736],222.67,[],false,false,true,{}], 
				["Land_HBarrier_3_F",[18.6455,13.915,0.015172],220.519,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[7.97559,23.0859,0.00830841],221.126,[],false,false,true,{}], 
				["Land_HBarrier_1_F",[-6.44336,23.6592,0.00173569],215.115,[],false,false,true,{}], 
				["Land_HBarrier_3_F",[24.0801,9.16797,0.0235815],225.512,[],false,false,true,{}], 
				["Land_HBarrier_3_F",[3.9585,-25.8135,0.082737],204.477,[],false,false,true,{}], 
				["Land_Cargo_House_V1_F",[25.2026,-9.5293,0],76.115,[],false,true,true,{(_this select 0) animate ['door_1_rot',1];(_this select 0);}],
				["Land_HBarrier_Big_F",[25.9448,5.77344,-0.00178719],71.9791,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-3.55811,27.8252,-0.00306797],125.308,[],false,false,true,{}], 
				["Land_HBarrier_3_F",[-24.1665,-13.3682,-0.134857],91.9641,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[1.67529,28.6904,-0.00417519],46.6805,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[7.99854,-28.0059,0.00556469],211.172,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[29.0952,-2.17285,-0.00152397],70.2735,[],false,false,true,{}], 
				["Land_Mil_WallBig_4m_F",[8.19873,-29.5098,-0.0846195],209.246,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-23.7676,-20,0.00725269],267.716,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[31.5259,-10.3027,0.00386238],264.414,[],false,false,true,{}], 
				["Land_Cargo_Patrol_V1_F",[-4.49316,33.8203,0.0137119],229.29,[],false,true,false,{{(_this select 0) animate _x;} forEach [['hatch_1_rot',1],['hatch_2_rot',1],['hatch_3_rot',1],['hatch_4_rot',1]];(_this select 0);}], 
				["Land_Mil_WallBig_4m_F",[11.5259,-31.4141,-0.0688896],209.215,[],false,false,true,{}], 
				["Land_HBarrier_3_F",[-10.7378,30.9688,0.0497398],238.979,[],false,false,true,{}], 
				["Land_CncBarrier_F",[-25.4434,-22.3701,0.000337601],300.06,[],false,false,true,{}], 
				["Land_LampShabby_F",[-24.6689,-24.8506,0],271.196,[],false,true,false,{}], 
				["Land_HBarrier_Big_F",[-4.59717,34.8906,0.00385475],47.9183,[],false,false,true,{}], 
				["Land_HBarrier_1_F",[31.9927,-15.1328,0.00044632],0.00152732,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[15.249,-32.0996,0.00510406],211.146,[],false,false,true,{}], 
				["Land_HBarrier_5_F",[-11.0825,33.0898,0.157915],322.835,[],false,false,true,{}], 
				["Land_CncBarrier_F",[-25.9844,-24.6611,0.000439644],264.498,[],false,false,true,{}], 
				["Land_Mil_WallBig_4m_F",[14.8511,-33.377,-0.0643005],209.215,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-23.4067,-28.3252,0.00734901],267.667,[],false,false,true,{}], 
				["Land_CncBarrier_F",[-25.1626,-27.0654,0.000495911],241.791,[],false,false,true,{}], 
				["Land_LampShabby_F",[-8.35449,36.3691,0],315.421,[],false,true,false,{}], 
				["Land_CncBarrier_F",[-32.5376,-22.4072,0.000478745],253.132,[],false,false,true,{}], 
				["Land_HBarrier_3_F",[-7.31641,37.8467,0.00470543],238.512,[],false,false,true,{}], 
				["Land_Mil_WallBig_4m_F",[18.1821,-35.3066,-0.0717621],209.219,[],false,false,true,{}], 
				["Land_CncBarrier_F",[-32.1172,-24.8486,0.000398636],269.823,[],false,false,true,{}], 
				["Land_HBarrier_3_F",[-23.2324,-32.4551,-0.0557537],92.1128,[],false,false,true,{}], 
				["Land_CncBarrier_F",[-32.4478,-27.375,0.000289917],282.505,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[22.3833,-36.2588,0.00262642],211.171,[],false,false,true,{}], 
				["Land_Mil_WallBig_4m_F",[21.562,-37.1504,-0.0643139],209.219,[],false,false,true,{}], 
				["Land_HelipadCircle_F",[0.850098,-44.0215,-7.62939e-006],22.1967,[],false,false,false,{}], 
				["Land_HBarrier_5_F",[35.2139,-25.4014,-0.0940962],0.0374672,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[28.9058,-35.6582,-0.00357056],132.54,[],false,false,true,{}], 
				["Land_Mil_WallBig_4m_F",[23.7095,-40.1729,-0.00722313],258.682,[],false,false,true,{}], 
				["Land_LampShabby_F",[40.1714,-24.6973,0],316.904,[],false,true,false,{}], 
				["Land_Cargo_Patrol_V1_F",[39.6465,-28.374,0.0311871],277.066,[],false,true,false,{{(_this select 0) animate _x;} forEach [['hatch_1_rot',1],['hatch_2_rot',1],['hatch_3_rot',1],['hatch_4_rot',1]];(_this select 0);}], 
				["Land_HBarrier_1_F",[40.689,-24.8701,0.001544],30.1046,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[35.2715,-32.5732,0.0040741],2.51284,[],false,false,true,{}], 
				["Land_Mil_WallBig_4m_F",[22.7563,-43.9639,0.0256901],297.918,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[24.5474,-42.543,-0.00291061],115.3,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[40.1455,-29.4316,0.00860405],277.067,[],false,false,true,{}], 
				["Land_Mil_WallBig_4m_F",[20.9175,-47.374,0.0355949],298.499,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-47.5884,21.6045,0.028512],116.825,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-40.9307,33.5449,-0.00092411],124.744,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-51.9111,-10.9629,-0.0227175],74.7894,[],false,false,true,{}], 
				["Land_LampShabby_F",[-50.3867,16.9873,0.0429296],172.793,[],false,true,false,{}], 
				["Land_HBarrier_Big_F",[-35.6626,39.6074,-0.00269604],139.757,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-29.5703,44.9678,0.00658703],135.72,[],false,false,true,{}], 
				["Land_Mil_WallBig_4m_F",[19.1763,-50.751,0.0322151],294.993,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-51.6553,-16.876,-0.00206184],92.0174,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[21.146,-50.2168,-0.00224113],118.103,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-51.8271,19.5322,0.0215006],167.177,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-23.9019,50.6484,0.0453863],139.468,[],false,false,true,{}], 
				["Land_HBarrier_3_F",[-20.4307,52.6172,0.0267029],144.491,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[15.707,-55.126,0.00131798],162.61,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-51.6938,-25.2949,-0.00187016],90.7863,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-57.2891,-3.50195,0.172834],40.2871,[],false,false,true,{}], 
				["Land_HBarrier_3_F",[-28.6895,-50.9531,-0.159618],359.915,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[7.92627,-58.2637,-0.000574112],160.49,[],false,false,true,{}], 
				["Land_HBarrier_3_F",[-5.00293,-59.3096,-0.0897846],0.00945667,[],false,false,true,{}], 
				["Land_HBarrier_3_F",[2.5752,-59.5127,-0.0349007],0.00733203,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-8.40674,-59.0176,0.00493622],185.334,[],false,false,true,{}], 
				["Land_HBarrier_3_F",[-60.3076,1.70605,0.123964],76.2357,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-16.8691,-58.5527,0.0137701],185.273,[],false,false,true,{}], 
				["Land_HBarrier_5_F",[-28.8369,-56.4854,-0.0620241],273.705,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-51.5728,-33.749,-0.00236511],90.3239,[],false,false,true,{}], 
				["Land_Cargo_Patrol_V1_F",[-26.0044,-57.3574,-0.0230579],5.85555,[],false,true,false,{{(_this select 0) animate _x;} forEach [['hatch_1_rot',1],['hatch_2_rot',1],['hatch_3_rot',1],['hatch_4_rot',1]];(_this select 0);}], 
				["Land_HBarrier_Big_F",[-58.2217,21.0273,0.0373888],220.59,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-25.3115,-58.002,0.0178547],185.256,[],false,false,true,{}], 
				["Land_LampShabby_F",[-29.9277,-56.7217,0],277.163,[],false,true,false,{}], 
				["Land_HBarrier_3_F",[-32.1265,-57.8818,-0.0713015],359.997,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-51.813,-42.333,0.00141335],87.9724,[],false,false,true,{}], 
				["Land_HBarrier_3_F",[-61.8765,23.3193,-0.00415611],201.703,[],false,false,true,{}], 
				["Land_HBarrier_Big_F",[-51.0918,-50.792,-0.0038662],84.7212,[],false,false,true,{}], 
				["Land_HBarrier_3_F",[-49.896,-54.873,-0.131235],33.204,[],false,false,true,{}]
			],
			[
				["B_G_Van_01_transport_F",[7391.53,11411.8,0.0331402],302.884],
				["B_G_Van_01_transport_F",[7400.31,11406.5,0.0300865],301.717],
				["B_G_Offroad_01_F",[7386.52,11453.6,-0.0316191],226.272],
				["B_G_Offroad_01_F",[7382.9,11457.1,-0.0395355],40.4797],
				["B_G_Offroad_01_F",[7378.83,11460.9,-0.0319805],216.421],
				[_quadType,[7364.51,11451.9,-0.0128307],299.801],
				[_quadType,[7362.4,11448.9,0.0539665],300.181],
				[_quadType,[7360.58,11445.9,0.0548353],130.375],
				[_quadType,[7358.42,11442.8,0.0381327],296.91]
			],
			[7380.55,11393.5,0.00141335],
			[7350.43,11413,0.00137043],
			'Lonestar'
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
				["Land_LampShabby_F",[4.90234,3.69531,-3.05176e-005],199.139,[],false,true,false,{}], 
				["Flag_White_F",[-5.25098,3.27637,0],188.658,[],false,true,false,{
					missionNamespace setVariable ['QS_module_fob_flag',(_this select 0),TRUE];
					(_this select 0);
				}], 
				["Land_Cargo_HQ_V4_F",[-2.32715,8.61523,0.00112915],275.111,[],false,true,false,{
					_obj = _this select 0;
					missionNamespace setVariable ['QS_module_fob_HQ',_obj,TRUE];
					[_obj] spawn {
						_obj = _this select 0;
						private _dataTerminal = createVehicle ['Land_DataTerminal_01_F',(getPosWorld _obj),[],0,'NONE'];
						missionNamespace setVariable [
							'QS_analytics_entities_created',
							((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
							FALSE
						];
						sleep 0.1;
						detach _dataTerminal;
						_dataTerminal attachTo [_obj,[1,1.75,-3.25]];
						sleep 0.1;
						_dataTerminal setDir 90;
						missionNamespace setVariable ['QS_module_fob_dataTerminal',_dataTerminal,TRUE];
						QS_module_fob_dataTerminal attachTo [QS_module_fob_HQ,[1,1.75,-3.25]];
						QS_module_fob_dataTerminal setDir 90;
					};
					_obj;
				}], 
				["Land_WaterTower_01_F",[8.43457,13.7285,0.00210571],6.0019,[],false,true,false,{}], 
				["Land_HBarrier_01_big_4_green_F",[2.60547,18.9795,0.000976563],183.142,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[-5.44434,18.7148,-0.000152588],170.038,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[-12.3457,15.6563,-0.00228882],141.453,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[11.2715,18.5918,-0.112366],183.166,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[-19.2441,10.1113,0.00241089],141.427,[],false,true,true,{}], 
				["Land_FieldToilet_F",[17.4961,14.8594,0.00256348],0.0037223,[],false,true,true,{}], 
				["Land_Cargo_House_V4_F",[-23.6777,-4.34668,9.15527e-005],278.945,[],false,true,true,{(_this select 0) animate ['door_1_rot',1];(_this select 0);}],
				["Land_FieldToilet_F",[19.0947,14.7188,0.000244141],6.72028,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[-25.75,4.62109,0.00012207],139.224,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[19.5674,18.2373,6.10352e-005],183.138,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[-28.6611,-2.00684,6.10352e-005],95.4409,[],false,true,true,{}], 
				["Land_Cargo_House_V4_F",[-25.2432,-15.583,0],278.945,[],false,true,true,{(_this select 0) animate ['door_1_rot',1];(_this select 0);}],
				["Land_HBarrier_01_big_4_green_F",[-29.6523,-10.5166,0.00140381],95.4428,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[28.0469,17.7578,-6.10352e-005],183.138,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[-30.5605,-18.6982,-0.00152588],95.4389,[],false,true,true,{}], 
				["Land_LampShabby_F",[-12.4707,-36.8906,-0.000213623],121.472,[],false,true,false,{}], 
				["Land_HBarrier_01_line_1_green_F",[4.19922,-39.417,0.000274658],0,[],false,true,true,{}], 
				["Land_HBarrier_01_line_1_green_F",[-11.1465,-38.2734,0.00942993],0,[],false,true,true,{}], 
				["Land_Cargo_Patrol_V4_F",[-26.1318,-31.8672,-0.0303345],58.1537,[],false,true,false,{{(_this select 0) animate _x;} forEach [['hatch_1_rot',1],['hatch_2_rot',1],['hatch_3_rot',1],['hatch_4_rot',1]];(_this select 0);}], 
				["Land_HBarrier_01_big_4_green_F",[36.4805,17.2549,6.10352e-005],183.138,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[9.14063,-39.8672,0.0114136],3.33881,[],false,true,true,{}], 
				["Land_Shed_Small_F",[29.666,16.4512,0.210785],93.1557,[],false,false,false,{(_this select 0) setVectorUp [0,0,1];(_this select 0);}], 
				["Land_HBarrier_01_big_4_green_F",[-15.7949,-37.9814,0.0205688],3.37912,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[-31.4502,-27.1963,3.05176e-005],95.4409,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[17.4131,-40.0439,0.00244141],183.131,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[-23.874,-37.584,0.0288391],3.29022,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[-29.9141,-34.1484,0.00518799],59.2305,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[45.0225,16.8174,0.00326538],183.137,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[25.7051,-40.4834,0.00970459],183.142,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[34.292,-40.8145,-0.0457458],183.137,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[53.4229,16.3145,0],183.138,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[42.8047,-41.1797,0.0140686],183.152,[],false,true,true,{}], 
				["Land_HelipadCircle_F",[57.6055,-19.3057,-6.10352e-005],273.469,[],false,false,false,{}], 
				["Land_HBarrier_01_big_4_green_F",[61.9199,15.8945,0],183.138,[],false,true,true,{}], 
				["Land_Shed_Small_F",[54.123,15.1191,-0.129791],94.1961,[],false,false,false,{(_this select 0) setVectorUp [0,0,1];(_this select 0);}], 
				["Land_HBarrier_01_big_4_green_F",[51.1074,-41.7197,0.0179138],3.72031,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[70.4248,15.3281,-0.000915527],183.138,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[59.5264,-42.291,0.0188293],3.72354,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[78.8447,14.8174,0.00613403],183.138,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[68.2217,-42.4404,0.00698853],1.41041,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[76.6377,-42.6152,0.0141296],1.42353,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[87.2783,14.3145,-0.000457764],183.138,[],false,true,true,{}], 
				["Land_Cargo_Patrol_V4_F",[90.8896,8.57422,9.15527e-005],239.945,[],false,true,false,{{(_this select 0) animate _x;} forEach [['hatch_1_rot',1],['hatch_2_rot',1],['hatch_3_rot',1],['hatch_4_rot',1]];(_this select 0);}], 
				["Land_HBarrier_01_big_4_green_F",[93.293,11.1475,-0.00143433],58.3219,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[84.7813,-42.8486,0.00769043],1.415,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[97.6982,3.90625,0.0100098],58.298,[],false,true,true,{}], 
				["Land_HBarrier_01_line_1_green_F",[99.2197,-0.235352,3.05176e-005],95.7182,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[91.1309,-40.3057,-0.00222778],313.311,[],false,true,true,{}], 
				["Land_LampShabby_F",[98.5264,-16.4492,0],21.4226,[],false,true,false,{}], 
				["Land_HBarrier_01_line_1_green_F",[100.078,-14.8311,3.05176e-005],95.7081,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[99.6094,-19.6855,-6.10352e-005],275.344,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[96.6543,-34.2988,-0.000335693],310.172,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[99.2549,-27.666,0.00888062],269.7,[],false,true,true,{}], 
				["Land_Cargo_Patrol_V4_F",[79.7266,82.041,0],204.99,[],false,true,false,{{(_this select 0) animate _x;} forEach [['hatch_1_rot',1],['hatch_2_rot',1],['hatch_3_rot',1],['hatch_4_rot',1]];(_this select 0);}], 
				["Land_BagBunker_01_small_green_F",[-119.663,-47.21,-0.000396729],82.3092,[],false,true,true,{}],
				["Land_CncBarrier_F",[91.8467,-20.4502,0],3.79918,[],false,true,true,{}], 
				["Land_CncBarrier_F",[90.8438,-27.7617,9.15527e-005],3.79918,[],false,true,true,{}], 
				["Land_CncBarrier_F",[94.127,-20.625,0],3.79918,[],false,true,true,{}], 
				["Land_CncBarrier_F",[93.3975,-27.9736,6.10352e-005],3.79918,[],false,true,true,{}], 
				["Land_CncBarrier_F",[96.6182,-20.7549,0],3.79918,[],false,true,true,{}], 
				["Land_CncBarrier_F",[95.9414,-28.1279,-6.10352e-005],3.79918,[],false,true,true,{}], 
				["Land_CncBarrier_F",[97.8467,-22.0352,0.000213623],277.546,[],false,true,true,{}], 
				["Land_CncBarrier_F",[97.5732,-24.502,0.000213623],277.546,[],false,true,true,{}], 
				["Land_CncBarrier_F",[97.2822,-26.9697,-6.10352e-005],277.546,[],false,true,true,{}]
			],
			[
				["B_G_Van_01_transport_F",[11090.2,11515.8,0.0272827],185.119],
				["B_G_Van_01_transport_F",[11081.5,11516,0.0466919],185.211],
				["b_t_lsv_01_unarmed_f",[11074.4,11517.4,-0.0336304],182.348],
				["b_t_lsv_01_unarmed_f",[11065.8,11517.9,-0.0372925],183.048],
				["b_t_lsv_01_unarmed_f",[11058,11518.4,-0.042511],183.018],
				[_quadType,[11027.2,11515.7,0.00378418],95.1882],
				[_quadType,[11026.9,11512.5,0.00640869],95.1844],
				[_quadType,[11002.1,11514.7,0.00543213],141.413],
				[_quadType,[10999.1,11512.5,0.00308228],141.258]
			],
			[11076.1,11488.5,0.00143433],
			[11112,11483.4,0.00134277],
			'Kokoda'
		];
	};
	if (_type isEqualTo 1) then {
		/*/ south island /*/
		_return = [
			[11673.3, 4402.3],
			[
				["Land_HBarrier_01_line_5_green_F",[-2.30859,-4.2168,0.00622559],95.4332,[],false,true,true,{}], 
				["Land_HBarrier_01_line_5_green_F",[-2.37402,4.58008,0.000411987],96.1634,[],false,true,true,{}], 
				["Land_LampShabby_F",[-3.23926,5.4624,-1.33318],123.506,[],false,true,false,{}], 
				["Flag_White_F",[-3.84961,-6.25635,-0.0313721],0,[],false,true,false,{
					missionNamespace setVariable ['QS_module_fob_flag',(_this select 0),TRUE];
					(_this select 0);
				}], 
				["Land_HBarrier_01_line_3_green_F",[-3.79395,-7.46289,0.00219727],0,[],false,true,true,{}], 
				["Land_Cargo_HQ_V4_F",[-9.48438,-1.62646,-0.144318],188.66,[],false,true,false,{
					_obj = _this select 0;
					missionNamespace setVariable ['QS_module_fob_HQ',_obj,TRUE];
					[_obj] spawn {
						_obj = _this select 0;
						private _dataTerminal = createVehicle ['Land_DataTerminal_01_F',(getPosWorld _obj),[],0,'NONE'];
						missionNamespace setVariable [
							'QS_analytics_entities_created',
							((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
							FALSE
						];
						sleep 0.1;
						detach _dataTerminal;
						_dataTerminal attachTo [_obj,[1,1.75,-3.25]];
						sleep 0.1;
						_dataTerminal setDir 90;
						missionNamespace setVariable ['QS_module_fob_dataTerminal',_dataTerminal,TRUE];
						QS_module_fob_dataTerminal attachTo [QS_module_fob_HQ,[1,1.75,-3.25]];
						QS_module_fob_dataTerminal setDir 90;
					};
					_obj;
				}], 
				["Land_HBarrier_01_line_5_green_F",[-6.13379,6.36719,0.00421143],8.38397,[],false,true,true,{}], 
				["Land_HBarrier_01_line_5_green_F",[-11.6582,7.20752,0.0104828],8.32746,[],false,true,true,{}], 
				["Land_HBarrier_01_line_3_green_F",[-11.584,-8.42432,0.00366211],0,[],false,true,true,{}], 
				["Land_Mil_WallBig_4m_F",[3.51953,14.498,0.121246],188.534,[],false,true,true,{}], 
				["Land_Mil_WallBig_4m_F",[7.31641,14.1626,0.0483398],182.246,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[1.89453,15.9014,-0.00163269],5.09395,[],false,true,true,{}], 
				["Land_HBarrier_01_line_3_green_F",[-15.2959,7.52881,0.00439453],0,[],false,true,true,{}], 
				["Land_Mil_WallBig_4m_F",[11.2432,14.0308,-0.0117798],182.246,[],false,true,true,{}], 
				["Land_HBarrier_01_line_5_green_F",[-15.9336,-8.02344,0.00830078],186.571,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[-6.84668,16.418,-0.00119019],5.07062,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[10.6299,15.1953,-0.000564575],5.09687,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[-18.8555,0.181152,0.0116425],97.0809,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[-17.6797,8.6167,0.0257721],96.7366,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[-14.3877,14.6577,0.00187683],327.863,[],false,true,true,{}], 
				["Land_HBarrier_01_line_1_green_F",[15.3174,14.6958,0.00012207],0,[],false,true,true,{}], 
				["Land_Mil_WallBig_4m_F",[-19.0791,-10.5366,-0.0121765],97.0434,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[-19.916,-8.02832,0.0257111],96.7996,[],false,true,true,{}], 
				["Land_Mil_WallBig_4m_F",[-19.499,-14.3232,-0.0124054],97.0434,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[-20.96,-16.2793,0.00317383],96.884,[],false,true,true,{}], 
				["Land_Mil_WallBig_4m_F",[-19.9775,-18.2031,0.00723267],97.0434,[],false,true,true,{}], 
				["Land_HelipadCircle_F",[23.1475,-13.5454,0.00012207],185.272,[],false,false,false,{}], 
				["Land_Mil_WallBig_4m_F",[-20.46,-22.0029,0.0185242],97.0434,[],false,true,true,{}], 
				["Land_Mil_WallBig_4m_F",[-20.9111,-25.7358,-0.00979614],97.0434,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[-22.1191,-24.6484,0.00212097],96.9028,[],false,true,true,{}], 
				["Land_HBarrier_01_line_1_green_F",[30.7598,12.7363,0.00144958],186.862,[],false,true,true,{}], 
				["Land_LampShabby_F",[32.9238,10.4966,-3.05176e-005],301.132,[],false,true,false,{}], 
				["Land_CncBarrier_F",[0.623047,-35.1118,0.00172424],93.8389,[],false,true,true,{}], 
				["Land_CncBarrier_F",[-6.91895,-34.5249,0.00248718],93.8389,[],false,true,true,{}], 
				["Land_Mil_WallBig_4m_F",[-21.4199,-29.6064,0.0519104],97.0434,[],false,true,true,{}], 
				["Land_CncBarrier_F",[0.455078,-37.6528,0.00210571],93.8389,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[35.4756,12.2256,0.0108795],185.131,[],false,true,true,{}], 
				["Land_CncBarrier_F",[-7.10254,-37.0688,0.00238037],93.8389,[],false,true,true,{}], 
				["Land_Mil_WallBig_4m_F",[36.5,10.5938,0.181625],185.614,[],false,true,true,{}], 
				["Land_Mil_WallBig_4m_F",[-21.9932,-33.4419,0.0586853],97.0434,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[-23.2207,-32.9956,0.0101624],97.1035,[],false,true,true,{}], 
				["Land_Cargo_Patrol_V4_F",[-18.0889,-37.0229,0.00660706],59.6746,[],false,true,false,{{(_this select 0) animate _x;} forEach [['hatch_1_rot',1],['hatch_2_rot',1],['hatch_3_rot',1],['hatch_4_rot',1]];(_this select 0);}], 
				["Land_CncBarrier_F",[0.299805,-40.186,0.001297],93.8389,[],false,true,true,{}], 
				["Land_CncBarrier_F",[-7.27148,-39.6294,0.00354004],93.8389,[],false,true,true,{}], 
				["Land_Mil_WallBig_4m_F",[40.2891,9.38818,0.100464],215.674,[],false,true,true,{}], 
				["Land_CncBarrier_F",[-3.64453,-41.2007,-0.0153503],2.5257,[],false,true,true,{}], 
				["Land_CncBarrier_F",[-1.05664,-41.3462,0.00114441],2.5257,[],false,true,true,{}], 
				["Land_CncBarrier_F",[-6.16406,-40.9624,0.0147552],2.5257,[],false,true,true,{}], 
				["Land_LampShabby_F",[2.30762,-42.1094,0],308.481,[],false,true,false,{}], 
				["Land_Mil_WallBig_4m_F",[-21.2148,-37.3481,-0.0132294],62.3135,[],false,true,true,{}], 
				["Land_Mil_WallBig_4m_F",[-4.25098,-42.9683,-0.159424],5.01235,[],false,true,true,{}], 
				["Land_LampShabby_F",[2.38086,-42.4248,-0.0313416],113.856,[],false,true,false,{}], 
				["Land_Mil_WallBig_4m_F",[-0.363281,-43.2344,-0.0542908],1.61966,[],false,true,true,{}], 
				["Land_Mil_WallBig_4m_F",[-8.10547,-42.5869,-0.188736],5.01235,[],false,true,true,{}], 
				["Land_Mil_WallBig_4m_F",[-11.6592,-41.8521,-0.066452],16.3959,[],false,true,true,{}], 
				["Land_Mil_WallBig_4m_F",[-14.9053,-41.4009,-0.115143],4.27782,[],false,true,true,{}], 
				["Land_Mil_WallBig_4m_F",[-18.5908,-40.2705,-0.0344086],29.8081,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[42.6436,9.19238,-0.206238],222.729,[],false,true,true,{}], 
				["Land_Cargo_Patrol_V4_F",[44.6123,6.57227,-0.0320129],225.182,[],false,true,false,{{(_this select 0) animate _x;} forEach [['hatch_1_rot',1],['hatch_2_rot',1],['hatch_3_rot',1],['hatch_4_rot',1]];(_this select 0);}], 
				["Land_HBarrier_01_big_4_green_F",[-7.6582,-43.8413,0.0216217],184.139,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[0.734375,-44.5029,0.0103607],184.161,[],false,true,true,{}], 
				["Land_HBarrier_01_line_1_green_F",[5.37207,-44.9028,0.00585938],186.813,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[-21.8135,-40.1196,0.00982666],56.2816,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[-15.9209,-43.0674,0.0101776],184.162,[],false,true,true,{}], 
				["Land_Shed_Small_F",[49.2236,-10.9487,0.328476],188.176,[],false,false,false,{(_this select 0) setVectorUp [0,0,1];(_this select 0);}], 
				["Land_HBarrier_01_line_1_green_F",[18.0732,-45.7178,0.00520325],186.833,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[49.0996,3.35205,0.0361481],222.51,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[22.791,-46.0908,0.0203094],184.15,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[51.5752,-3.50537,0.0148163],97.0447,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[50.5264,-11.894,0.0130005],96.5487,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[49.4248,-20.1519,0.00862122],96.6072,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[48.2969,-28.4946,0.0065155],96.643,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[31.3203,-46.4463,0.0244751],184.151,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[47.5752,-36.9609,0.0042572],92.599,[],false,true,true,{}], 
				["Land_Cargo_Patrol_V4_F",[45.0684,-42.3984,0.102463],295.812,[],false,true,false,{{(_this select 0) animate _x;} forEach [['hatch_1_rot',1],['hatch_2_rot',1],['hatch_3_rot',1],['hatch_4_rot',1]];(_this select 0);}], 
				["Land_HBarrier_01_big_4_green_F",[39.6885,-47.1484,0.0222321],184.159,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[44.957,-44.4521,0.013443],121.813,[],false,true,true,{}]
			],
			[
				["B_G_Van_01_transport_F",[11658.4,4376.98,0.0422974],97.8669],
				["B_G_Van_01_transport_F",[11659,4381.78,0.0203552],92.568],
				["b_t_lsv_01_unarmed_f",[11717.9,4389.92,-0.0317383],282.13],
				["b_t_lsv_01_unarmed_f",[11716.2,4381.31,-0.0322571],282.163],
				["b_t_lsv_01_unarmed_f",[11714.9,4374.51,-0.0816803],278.176],
				[_quadType,[11657.9,4390.31,0.0150604],174.047],
				[_quadType,[11660.6,4390.28,0.0161591],174.036],
				[_quadType,[11673.7,4395.52,0.0124054],95.9092],
				[_quadType,[11674,4398.33,0.0285645],96.2489]
			],
			[11696.5,4388.75,0.00132751],
			[11669.8,4365.29,0.00120544],
			'Singapore'
		];
	};	
	if (_type isEqualTo 2) then {
		_return = [
			[4920.18, 5110.65],
			[
				["Land_LampShabby_F",[5.35693,-0.292969,-0.0306416],269.513,[],false,true,false,{}], 
				["Flag_White_F",[-2.78271,5.22412,-6.29425e-005],0,[],false,true,false,{
					missionNamespace setVariable ['QS_module_fob_flag',(_this select 0),TRUE];
					(_this select 0);
				}], 
				["Land_HBarrier_01_big_4_green_F",[3.68848,-6.52637,0.114778],123.772,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[8.07129,-0.0493164,0.0546818],123.669,[],false,true,true,{}], 
				["Land_Cargo_HQ_V4_F",[2.75195,8.76904,0.00263214],307.853,[],false,true,false,{
					_obj = _this select 0;
					missionNamespace setVariable ['QS_module_fob_HQ',_obj,TRUE];
					[_obj] spawn {
						_obj = _this select 0;
						private _dataTerminal = createVehicle ['Land_DataTerminal_01_F',(getPosWorld _obj),[],0,'NONE'];
						missionNamespace setVariable [
							'QS_analytics_entities_created',
							((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
							FALSE
						];
						sleep 0.1;
						detach _dataTerminal;
						_dataTerminal attachTo [_obj,[1,1.75,-3.25]];
						sleep 0.1;
						_dataTerminal setDir 90;
						missionNamespace setVariable ['QS_module_fob_dataTerminal',_dataTerminal,TRUE];
						QS_module_fob_dataTerminal attachTo [QS_module_fob_HQ,[1,1.75,-3.25]];
						QS_module_fob_dataTerminal setDir 90;
					};
					_obj;
				}], 
				["Land_TTowerSmall_2_F",[9.4751,6.32422,-0.00739288],119.945,[],false,true,true,{}], 
				["Land_HBarrier_01_line_5_green_F",[-2.68408,13.4121,0.00139999],303.962,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[-1.31152,-13.7813,0.0949688],123.59,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[13.0278,7.16748,0.0554571],123.738,[],false,true,true,{}], 
				["Land_TTowerSmall_2_F",[12.3735,9.23242,-0.00761032],0,[],false,true,true,{}], 
				["Land_HBarrier_01_line_5_green_F",[0.737305,17.9277,-1.33514e-005],308.584,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[13.3521,13.4121,0.0589733],35.5213,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[6.92627,18.0615,-0.00305748],35.5149,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[-5.75146,-20.9814,0.0017252],120.252,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[-0.148926,23.2007,-0.00226021],35.518,[],false,true,true,{}], 
				["Land_HelipadCircle_F",[-24.9868,9.06445,-5.14984e-005],214.515,[],false,false,false,{}], 
				["Land_HBarrier_01_big_4_green_F",[-7.11133,28.0195,0.0623035],35.5766,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[-10.2051,-28.4453,0.0171671],120.287,[],false,true,true,{}], 
				["Land_CncBarrier_F",[-27.3647,-20.9175,0.00143147],123.918,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[-13.5854,32.6528,-0.00146675],35.5132,[],false,true,true,{}], 
				["Land_Cargo_Patrol_V4_F",[-15.5669,-33.9434,0.00520706],345.174,[],false,true,false,{{(_this select 0) animate _x;} forEach [['hatch_1_rot',1],['hatch_2_rot',1],['hatch_3_rot',1],['hatch_4_rot',1]];(_this select 0);}], 
				["Land_CncBarrier_F",[-28.8213,-23.0679,0.000313759],123.918,[],false,true,true,{}], 
				["Land_CncBarrier_F",[-33.8965,-16.7412,0.00101376],123.918,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[-14.6484,-35.9072,-0.00135899],120.311,[],false,true,true,{}], 
				["Land_CncBarrier_F",[-30.3022,-25.2017,0.00112534],123.918,[],false,true,true,{}], 
				["Land_CncBarrier_F",[-35.3306,-18.8379,0.00107765],123.918,[],false,true,true,{}], 
				["Land_CncBarrier_F",[-32.0371,-25.4863,0.000483513],32.4585,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[-20.7695,-35.8779,-0.00108337],32.3404,[],false,true,true,{}], 
				["Land_CncBarrier_F",[-34.2329,-24.0703,0.000713348],32.4585,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[-28.1172,-31.0879,0.0148468],32.3955,[],false,true,true,{}], 
				["Land_CncBarrier_F",[-36.7607,-20.96,0.000717163],123.918,[],false,true,true,{}], 
				["Land_CncBarrier_F",[-36.4321,-22.6421,0.000729561],32.4585,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[-20.6221,37.7563,-0.0158882],35.5064,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[-35.4185,-26.4463,-0.00250626],32.3066,[],false,true,true,{}], 
				["Land_LampShabby_F",[-25.3105,37.7656,0.0076561],316.546,[],false,true,false,{}], 
				["Land_HBarrier_01_big_4_green_F",[-42.7246,-21.6982,0.00537205],32.3381,[],false,true,true,{}], 
				["Land_HBarrier_01_line_3_green_F",[-25.2744,41.0674,-0.000116348],34.7848,[],false,true,true,{}], 
				["Land_HBarrier_01_line_3_green_F",[-47.6743,-18.5068,0.00279522],34.7129,[],false,true,true,{}], 
				["Land_Shed_Small_F",[-61.772,9.23047,0.289904],35.2027,[],false,false,false,{(_this select 0) setVectorUp [0,0,1];(_this select 0);}], 
				["Land_HBarrier_01_big_4_green_F",[-45.8208,35.1401,-0.000150681],123.641,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[-50.2393,28.5767,0.0251503],123.715,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[-40.9355,42.3477,0.00696182],123.627,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[-55.21,21.3184,0.0255919],123.717,[],false,true,true,{}], 
				["Land_HBarrier_01_line_3_green_F",[-37.8369,46.7881,0.00230408],132.554,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[-60.0508,14.1338,-0.00361347],123.685,[],false,true,true,{}], 
				["Land_LampShabby_F",[-62.7969,-5.0127,-9.72748e-005],154.164,[],false,true,false,{}], 
				["Land_HBarrier_01_line_3_green_F",[-62.4639,-8.41016,0.00170994],34.8641,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[-64.8877,7.16992,-0.000551224],124.637,[],false,true,true,{}], 
				["Land_Cargo_Patrol_V4_F",[-68.1636,-1.48877,-0.0111599],87.8973,[],false,true,false,{{(_this select 0) animate _x;} forEach [['hatch_1_rot',1],['hatch_2_rot',1],['hatch_3_rot',1],['hatch_4_rot',1]];(_this select 0);}], 
				["Land_HBarrier_01_big_4_green_F",[-67.2432,-5.31592,-0.00263786],32.3042,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[-69.7983,0.210449,-0.00162601],124.647,[],false,true,true,{}]
			],
			[
				["B_G_Van_01_transport_F",[4912.38,5096.04,0.0463343],305.289],
				["B_G_Van_01_transport_F",[4878.82,5141.9,-0.0359764],126.324],
				["b_t_lsv_01_unarmed_f",[4873.54,5131.92,-0.0792809],127.006],
				["b_t_lsv_01_unarmed_f",[4868.82,5125.25,-0.038291],127.122],
				["b_t_lsv_01_unarmed_f",[4863.68,5118.71,0.0172453],127.195],
				[_quadType,[4917.26,5128.8,0.0148125],308.022],
				[_quadType,[4915.06,5125.89,-0.0103645],308.144],
				[_quadType,[4921.21,5105.34,0.00935555],308.164],
				[_quadType,[4919.19,5102.57,0.00955772],308.26]
			],
			[4895.24,5119.63,0.00149727],
			[4887.97,5089.9,0.00125885],
			'Fiji'			
		];
	};
	if (_type isEqualTo 3) then {
		_return = [
			[4002.96, 11802.3],
			[
				["Land_HBarrier_01_line_3_green_F",[0.384033,4.78906,0.0229092],126.476,[],false,true,true,{}], 
				["Land_LampShabby_F",[0.102783,5.61914,-1.4275],174.479,[],false,true,false,{}], 
				["Flag_White_F",[-5.98364,-3.02539,0.0549469],0,[],false,true,false,{
					missionNamespace setVariable ['QS_module_fob_flag',(_this select 0),TRUE];
					(_this select 0);
				}], 
				["Land_HBarrier_01_line_3_green_F",[-0.226563,7.33203,0.00209808],54.9784,[],false,true,true,{}], 
				["Land_Cargo_HQ_V4_F",[-9.13208,2.84473,-4.76837e-005],216.814,[],false,true,false,{
					_obj = _this select 0;
					missionNamespace setVariable ['QS_module_fob_HQ',_obj,TRUE];
					[_obj] spawn {
						_obj = _this select 0;
						private _dataTerminal = createVehicle ['Land_DataTerminal_01_F',(getPosWorld _obj),[],0,'NONE'];
						missionNamespace setVariable [
							'QS_analytics_entities_created',
							((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
							FALSE
						];
						sleep 0.1;
						detach _dataTerminal;
						_dataTerminal attachTo [_obj,[1,1.75,-3.25]];
						sleep 0.1;
						_dataTerminal setDir 90;
						missionNamespace setVariable ['QS_module_fob_dataTerminal',_dataTerminal,TRUE];
						QS_module_fob_dataTerminal attachTo [QS_module_fob_HQ,[1,1.75,-3.25]];
						QS_module_fob_dataTerminal setDir 90;
					};
					_obj;
				}], 
				["Land_HBarrier_01_line_5_green_F",[-3.29248,10.0391,0.00665474],36.7546,[],false,true,true,{}], 
				["Land_HBarrier_01_line_3_green_F",[-6.49927,11.5615,0.0209541],130.527,[],false,true,true,{}], 
				["Land_HBarrier_01_line_5_green_F",[-9.39526,12.9385,-0.0153732],36.3834,[],false,true,true,{}], 
				["Land_HBarrier_01_line_5_green_F",[-16.4524,-0.578125,0.00864792],217.142,[],false,true,true,{}], 
				["Land_HBarrier_01_line_3_green_F",[-12.4319,13.1943,0.000642776],327.625,[],false,true,true,{}], 
				["Land_HBarrier_01_line_5_green_F",[-15.0063,10.251,0.026453],306.204,[],false,true,true,{}], 
				["Land_HBarrier_01_line_3_green_F",[-19.0229,2.04199,0.00733566],270.33,[],false,true,true,{}], 
				["Land_HBarrier_01_line_5_green_F",[-18.3337,5.88672,0.000745773],304.462,[],false,true,true,{}], 
				["Land_Cargo_House_V4_F",[-27.9744,-22.0391,0.0517635],226.075,[],false,true,true,{(_this select 0) animate ['door_1_rot',1];(_this select 0);}],
				["Land_Cargo_House_V4_F",[-23.0393,-27.4346,9.53674e-005],226.075,[],false,true,true,{(_this select 0) animate ['door_1_rot',1];(_this select 0);}],
				["Land_Shed_Small_F",[-37.9805,-14.2051,-0.139549],355.218,[],false,false,false,{(_this select 0) setVectorUp [0,0,1];(_this select 0);}], 
				["Land_HBarrier_01_big_4_green_F",[28.4326,21.0566,-0.000114441],231.536,[],false,true,true,{}], 
				["Land_HBarrier_01_line_3_green_F",[31.925,16.7539,0.00201225],48.2175,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[23.366,27.6992,0.0430164],231.815,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[3.24731,37.4854,-0.000972748],184.885,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[17.7859,34.0869,0.00512505],223.035,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[11.3005,36.999,0.00120544],180.864,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[-4.59253,39.2764,0.00288391],199.328,[],false,true,true,{}], 
				["Land_CncBarrier_F",[17.2297,-37.3398,0.00028801],39.6228,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[-30.2139,-28.165,0.000324249],40.8177,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[-23.5957,-34.0205,0.00989532],40.8745,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[-41.6316,1.25977,0.00135422],87.2043,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[-41.2344,-7.13965,0.00365448],87.0939,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[-36.3853,-22.0801,0.00440979],41.1415,[],false,true,true,{}], 
				["Land_HBarrier_01_line_3_green_F",[-19.6272,-38.0674,-5.72205e-005],48.1731,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[-41.7432,10.2373,0.00171661],87.2095,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[-40.3748,-15.6855,-0.00200844],76.1314,[],false,true,true,{}], 
				["Land_CncBarrier_F",[19.1316,-38.8721,0.00182152],39.6228,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[-12.5352,42.252,0.0144787],199.426,[],false,true,true,{}], 
				["Land_CncBarrier_F",[12.5652,-43.1299,0.000938416],39.6228,[],false,true,true,{}], 
				["Land_LampShabby_F",[45.4417,0.428711,0.000146866],353.245,[],false,true,false,{}], 
				["Land_CncBarrier_F",[21.0642,-40.5313,0.00185966],39.6228,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[-42.1477,18.3389,0.00611877],87.2415,[],false,true,true,{}], 
				["Land_HBarrier_01_line_3_green_F",[46.6201,2.2832,0.00556755],48.2805,[],false,true,true,{}], 
				["Land_CncBarrier_F",[14.4766,-44.7959,0.00216293],39.6228,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[38.0083,-28.0215,0.0473099],130.864,[],false,true,true,{}], 
				["Land_CncBarrier_F",[21.3315,-42.2764,0.00316811],309.633,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[33.6785,-33.1396,-0.0125999],130.233,[],false,true,true,{}], 
				["Land_Cargo_Patrol_V4_F",[-30.2444,39.0234,-0.00596046],141.352,[],false,true,false,{{(_this select 0) animate _x;} forEach [['hatch_1_rot',1],['hatch_2_rot',1],['hatch_3_rot',1],['hatch_4_rot',1]];(_this select 0);}], 
				["Land_HBarrier_01_big_4_green_F",[27.8149,-39.6143,-0.0445423],130.452,[],false,true,true,{}], 
				["Land_CncBarrier_F",[19.7739,-44.3496,0.00208664],309.633,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[43.323,-22.1133,0.0473499],130.907,[],false,true,true,{}], 
				["Land_CncBarrier_F",[16.3979,-46.3809,0.0038929],39.6228,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[-20.0872,45.1895,-0.0163651],199.621,[],false,true,true,{}], 
				["Land_Cargo_Patrol_V4_F",[50.4016,-2.73145,0.0336342],222.876,[],false,true,false,{{(_this select 0) animate _x;} forEach [['hatch_1_rot',1],['hatch_2_rot',1],['hatch_3_rot',1],['hatch_4_rot',1]];(_this select 0);}], 
				["Land_CncBarrier_F",[18.0835,-46.3232,0.00370026],309.633,[],false,true,true,{}], 
				["Land_LampShabby_F",[-34.0757,36.0518,-0.016058],275.944,[],false,true,false,{}], 
				["Land_HBarrier_01_big_4_green_F",[50.2222,-0.90918,-0.00926208],39.3925,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[-42.4114,26.8916,0.011301],87.2332,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[21.7056,-45.918,0.0130272],130.051,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[48.6995,-15.7021,0.0208378],130.793,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[-33.53,39.0205,0.00448418],138.137,[],false,true,true,{}], 
				["Land_HBarrier_01_line_1_green_F",[-37.0715,35.875,0.0047226],136.083,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[-26.9146,44.4688,0.0304604],137.938,[],false,true,true,{}], 
				["Land_HBarrier_01_line_1_green_F",[-41.5964,31.3555,0.00321007],136.038,[],false,true,true,{}], 
				["Land_LampShabby_F",[1.8374,-52.6533,-0.0212841],282.71,[],false,true,false,{}], 
				["Land_HBarrier_01_line_3_green_F",[0.114014,-54.1035,0.00306511],48.2896,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[54.3931,-4.54688,0.00207901],39.1245,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[15.5632,-52.4092,0.0265846],129.741,[],false,true,true,{}], 
				["Land_Cargo_Patrol_V4_F",[7.54028,-55.7119,-0.0726585],2.97452,[],false,true,false,{{(_this select 0) animate _x;} forEach [['hatch_1_rot',1],['hatch_2_rot',1],['hatch_3_rot',1],['hatch_4_rot',1]];(_this select 0);}], 
				["Land_HBarrier_01_big_4_green_F",[54.2324,-9.75488,0.049551],130.714,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[4.36719,-58.0703,-0.0233707],40.7677,[],false,true,true,{}], 
				["Land_HBarrier_01_big_4_green_F",[9.77905,-58.7676,0.00780678],129.879,[],false,true,true,{}], 
				["Land_HelipadCircle_F",[-4.54224,-76.3262,0],2.46989,[],false,false,false,{}]
			],
			[
				["B_G_Van_01_transport_F",[4041.23,11787.1,-0.00193977],309.786],
				["B_G_Van_01_transport_F",[4037.65,11781.8,0.0648212],309.72],
				["b_t_lsv_01_unarmed_f",[3970.35,11790.4,-0.0533409],85.6809],
				["b_t_lsv_01_unarmed_f",[3969.21,11798.6,-0.0456924],85.6263],
				["b_t_lsv_01_unarmed_f",[3968.24,11806.6,-0.0744991],85.6863],
				[_quadType,[4002.48,11814,0.0570889],41.8019],
				[_quadType,[4005.22,11811.9,-0.017189],41.1992],
				[_quadType,[4033.01,11773.8,0.0244293],311.475],
				[_quadType,[4035.17,11776.1,0.00571251],311.537]
			],
			[3998.37,11726.2,0.00171661],
			[4019.29,11760.8,0.00162697],
			'Guadalcanal'
		];
	};
	_return;
};
if (_worldName isEqualTo 'Stratis') exitWith {_return = [];_return;};
if (_worldName isEqualTo 'Malden') exitWith {_return = [];_return;};
if (_worldName isEqualTo 'Chernarus') exitWith {_return = [];_return;};
if (_worldName isEqualTo 'Sahrani') exitWith {_return = [];_return;};
if (_worldName isEqualTo 'Takistan') exitWith {_return = [];_return;};
[]