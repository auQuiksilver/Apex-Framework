/*/
File: QS_data_fortifiedAA.sqf
Author:

	Quiksilver
	
Last modified:

	6/03/2018 A3 1.80 by Quiksilver
	
Description:

	Fortified AA Data
__________________________________________________________________________/*/

if (worldName in ['Tanoa','Lingor3','Enoch']) exitWith {
	if ((random 1) > 0.333) then [
		{
			[
				["o_apc_tracked_02_aa_f",[-5.34766,0.143311,0.016685],270.378,[],FALSE,FALSE,FALSE,(missionNamespace getVariable 'QS_fnc_createAAVehicle')], 
				["Land_BagFence_01_long_green_F",[4.104,0.0585938,2.01259],89.7138,[],FALSE,FALSE,TRUE,{}], 
				["Land_BagFence_01_long_green_F",[0.0810547,-4.68604,1.9154],0,[],FALSE,FALSE,TRUE,{}], 
				["Land_BagFence_01_long_green_F",[4.0498,2.4082,2.01259],269.377,[],FALSE,FALSE,TRUE,{}], 
				["Land_BagFence_01_long_green_F",[0.28125,4.70337,1.96381],0.0261029,[],FALSE,FALSE,TRUE,{}],  
				["Land_BagFence_01_long_green_F",[4.13721,-2.48828,2.01259],89.7138,[],FALSE,FALSE,TRUE,{}], 
				["Land_HBarrier_01_big_4_green_F",[-2.49365,-4.34351,0],0,[],FALSE,FALSE,TRUE,{}], 
				["Land_HBarrier_01_big_4_green_F",[4.24023,-2.72827,0],90.1508,[],FALSE,FALSE,TRUE,{}], 
				["Land_HBarrier_01_big_4_green_F",[-2.3042,4.68652,0],0,[],FALSE,FALSE,TRUE,{}], 
				["Land_BagFence_01_long_green_F",[-2.81201,-4.47412,1.85721],0,[],FALSE,FALSE,TRUE,{}], 
				["Land_BagFence_01_long_green_F",[-2.59473,4.71655,1.84145],0.0261029,[],FALSE,FALSE,TRUE,{}], 
				["Land_HBarrier_01_big_4_green_F",[4.29883,3.45776,0],90.1508,[],FALSE,FALSE,TRUE,{}], 
				["Land_BagFence_01_long_green_F",[4.18018,-5.10205,2.01259],89.7138,[],FALSE,FALSE,TRUE,{}], 
				["Land_BagFence_01_long_green_F",[4.03125,5.3186,2.01259],269.874,[],FALSE,FALSE,TRUE,{}], 
				["Land_BagFence_01_long_green_F",[-5.58252,-4.48584,1.9154],0,[],FALSE,FALSE,TRUE,{}], 
				["Land_BagFence_01_long_green_F",[-5.54932,4.72998,1.96381],0.0261029,[],FALSE,FALSE,TRUE,{}], 
				["Land_HBarrier_01_big_4_green_F",[-6.74072,-4.37427,0],0,[],FALSE,FALSE,TRUE,{}], 
				["Land_HBarrier_01_big_4_green_F",[-6.59717,4.69678,0],0,[],FALSE,FALSE,TRUE,{}], 
				["Land_BagFence_01_long_green_F",[-8.31738,4.70923,1.96381],179.601,[],FALSE,FALSE,TRUE,{}], 
				["Land_BagFence_01_long_green_F",[-8.48779,-4.46411,1.9154],178.714,[],FALSE,FALSE,TRUE,{}], 
				["Land_BagFence_01_long_green_F",[-9.85986,0.136719,2.05747],92.9792,[],FALSE,FALSE,TRUE,{}], 
				["Land_HBarrier_01_big_4_green_F",[-9.89404,0.758057,0],90.7865,[],FALSE,FALSE,TRUE,{}], 
				["Land_BagFence_01_long_green_F",[-9.70703,3.06982,2.09318],92.9792,[],FALSE,FALSE,TRUE,{}], 
				["Land_BagFence_01_long_green_F",[-9.8457,-2.80469,1.92252],268.615,[],FALSE,FALSE,TRUE,{}]
			]
		},
		{
			[
				["o_apc_tracked_02_aa_f",[2.54688,-0.0488281,-0.0447016],270.525,[],FALSE,FALSE,FALSE,(missionNamespace getVariable 'QS_fnc_createAAVehicle')], 
				["Land_HBarrier_01_line_3_green_F",[-4.61914,0.139893,1.17173],268.138,[],FALSE,FALSE,TRUE,{}], 
				["Land_HBarrier_01_line_5_green_F",[-1.78027,-4.44263,1.68432],219.983,[],FALSE,FALSE,TRUE,{}], 
				["Land_Rampart_F",[-5.24414,0.261719,0],0.579887,[],FALSE,FALSE,TRUE,{}], 
				["Land_Rampart_F",[-3.98438,-3.93115,0.177021],138.395,[],FALSE,FALSE,TRUE,{}], 
				["Land_Rampart_F",[-2.87744,5.13672,0.167141],221.716,[],FALSE,FALSE,TRUE,{}], 
				["Land_HBarrier_01_line_5_green_F",[-3.28613,5.17041,1.6311],310.772,[],FALSE,FALSE,TRUE,{}], 
				["Land_HBarrier_01_line_5_green_F",[2.79346,-6.04395,1.66587],0,[],FALSE,FALSE,TRUE,{}], 
				["Land_Rampart_F",[0.815918,-6.93335,0],91.1816,[],FALSE,FALSE,TRUE,{}], 
				["Land_HBarrier_01_line_5_green_F",[0.82959,7.38428,1.85543],352.72,[],FALSE,FALSE,TRUE,{}], 
				["Land_Rampart_F",[1.95459,7.56567,0.00454473],88.8767,[],FALSE,FALSE,TRUE,{}], 
				["Land_HBarrier_01_line_5_green_F",[5.81592,6.39014,1.82709],24.0442,[],FALSE,FALSE,TRUE,{}], 
				["Land_HBarrier_01_line_5_green_F",[7.45996,-4.86206,1.67862],151.957,[],FALSE,FALSE,TRUE,{}], 
				["Land_Rampart_F",[7.51758,-5.62183,0],61.7147,[],FALSE,FALSE,TRUE,{}], 
				["Land_Rampart_F",[9.45605,4.57324,0],313.125,[],FALSE,FALSE,TRUE,{}], 
				["Land_HBarrier_01_line_5_green_F",[9.9917,3.24292,1.78129],49.3943,[],FALSE,FALSE,TRUE,{}], 
				["Land_HBarrier_01_line_5_green_F",[10.9458,-1.0271,1.64725],102.284,[],FALSE,FALSE,TRUE,{}], 
				["Land_Rampart_F",[11.7227,-0.575928,0.112813],2.39138,[],FALSE,FALSE,TRUE,{}]
			]
		}
	];
};
if ((random 1) > 0.333) then [
	{
		[
			["o_apc_tracked_02_aa_f",[-5.34766,0.00170898,0.0160155],269.875,[],FALSE,FALSE,FALSE,(missionNamespace getVariable 'QS_fnc_createAAVehicle')], 
			["Land_BagFence_Long_F",[4.40967,0.370361,1.97424],90.3031,[],FALSE,FALSE,TRUE,{}], 
			["Land_BagFence_Long_F",[-0.148926,-4.56372,1.97631],359.525,[],FALSE,FALSE,TRUE,{}], 
			["Land_HBarrier_Big_F",[4.13379,-2.6626,0],90.7398,[],FALSE,FALSE,TRUE,{}], 
			["Land_HBarrier_Big_F",[-2.53564,-4.33911,0],0.0975143,[],FALSE,FALSE,TRUE,{}], 
			["Land_BagFence_Long_F",[4.49902,-2.26929,1.97631],90.598,[],FALSE,FALSE,TRUE,{}], 
			["Land_BagFence_Long_F",[-0.512695,5.02344,1.97631],358.147,[],FALSE,FALSE,TRUE,{}], 
			["Land_HBarrier_Big_F",[-2.56104,4.60205,0],0.0975143,[],FALSE,FALSE,TRUE,{}], 
			["Land_BagFence_Long_F",[4.39453,2.92847,1.97631],90.598,[],FALSE,FALSE,TRUE,{}], 
			["Land_HBarrier_Big_F",[4.11523,3.62256,0],90.7398,[],FALSE,FALSE,TRUE,{}], 
			["Land_BagFence_Long_F",[-3.11328,-4.57031,1.94209],359.525,[],FALSE,FALSE,TRUE,{}], 
			["Land_BagFence_Long_F",[-3.31396,4.88892,1.92097],358.147,[],FALSE,FALSE,TRUE,{}], 
			["Land_BagFence_Long_F",[4.53809,-4.98926,1.97631],90.598,[],FALSE,FALSE,TRUE,{}], 
			["Land_BagFence_Long_F",[4.35352,5.50195,1.97631],268.777,[],FALSE,FALSE,TRUE,{}], 
			["Land_BagFence_Long_F",[-5.95508,-4.61401,1.97631],359.525,[],FALSE,FALSE,TRUE,{}], 
			["Land_BagFence_Long_F",[-6.25146,4.67578,1.97631],358.147,[],FALSE,FALSE,TRUE,{}], 
			["Land_HBarrier_Big_F",[-6.66064,-4.52563,0],0.0975143,[],FALSE,FALSE,TRUE,{}], 
			["Land_HBarrier_Big_F",[-6.92871,4.5105,0],0.0975143,[],FALSE,FALSE,TRUE,{}], 
			["Land_BagFence_Long_F",[-8.82373,-4.66748,1.97631],178.6,[],FALSE,FALSE,TRUE,{}], 
			["Land_BagFence_Long_F",[-9.09863,4.36987,1.97631],354.32,[],FALSE,FALSE,TRUE,{}], 
			["Land_HBarrier_Big_F",[-10.1143,-0.00439453,0],89.696,[],FALSE,FALSE,TRUE,{}], 
			["Land_BagFence_Long_F",[-10.2422,-0.533203,1.97631],268.662,[],FALSE,FALSE,TRUE,{}],  
			["Land_BagFence_Long_F",[-10.3984,2.45923,1.97631],268.662,[],FALSE,FALSE,TRUE,{}], 
			["Land_BagFence_Long_F",[-10.1797,-3.36719,1.97631],90.7058,[],FALSE,FALSE,TRUE,{}]
		]	
	},
	{
		[
			["o_apc_tracked_02_aa_f",[-5.34375,0.18335,0.0162873],271.02,[],FALSE,FALSE,FALSE,(missionNamespace getVariable 'QS_fnc_createAAVehicle')], 
			["Land_HBarrier_5_F",[3.14111,1.80811,1.68038],60.7709,[],FALSE,FALSE,TRUE,{}], 
			["Land_HBarrier_5_F",[3.39551,-2.41772,1.48671],111.429,[],FALSE,FALSE,TRUE,{}], 
			["Land_Rampart_F",[4.46582,-0.60083,0],2.39138,[],FALSE,FALSE,TRUE,{}], 
			["Land_Rampart_F",[2.19922,4.54834,0],313.125,[],FALSE,FALSE,TRUE,{}], 
			["Land_HBarrier_5_F",[0.175293,-5.50317,1.48671],161.266,[],FALSE,FALSE,TRUE,{}], 
			["Land_Rampart_F",[0.260742,-5.64673,0],61.7147,[],FALSE,FALSE,TRUE,{}], 
			["Land_HBarrier_5_F",[-0.186035,5.98926,1.72212],43.508,[],FALSE,FALSE,TRUE,{}], 
			["Land_HBarrier_5_F",[-4.93555,-6.48071,1.48671],177.276,[],FALSE,FALSE,TRUE,{}], 
			["Land_HBarrier_5_F",[-4.67627,7.81909,1.73503],0,[],FALSE,FALSE,TRUE,{}], 
			["Land_Rampart_F",[-5.30225,7.54077,0],88.8767,[],FALSE,FALSE,TRUE,{}], 
			["Land_Rampart_F",[-6.44092,-6.95825,0],91.1816,[],FALSE,FALSE,TRUE,{}], 
			["Land_HBarrier_5_F",[-9.35107,-4.6416,1.48671],43.508,[],FALSE,FALSE,TRUE,{}], 
			["Land_HBarrier_5_F",[-9.02881,5.9585,1.73503],315.682,[],FALSE,FALSE,TRUE,{}], 
			["Land_Rampart_F",[-10.1343,5.11182,0],221.716,[],FALSE,FALSE,TRUE,{}], 
			["Land_HBarrier_3_F",[-11.7642,0.106445,1.68878],268.63,[],FALSE,FALSE,TRUE,{}], 
			["Land_Rampart_F",[-11.2412,-3.95605,0.181664],138.395,[],FALSE,FALSE,TRUE,{}], 
			["Land_Rampart_F",[-12.501,0.236816,0],0.579887,[],FALSE,FALSE,TRUE,{}]
		]	
	}
];