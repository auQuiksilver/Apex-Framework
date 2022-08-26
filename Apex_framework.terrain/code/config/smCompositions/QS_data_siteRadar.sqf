/*
File: QS_data_siteRadar.sqf
Author:

	Quiksilver
	
Last modified:

	24/05/2016 A3 1.58 by Quiksilver
	
Description:

	Radar Site
__________________________________________________________________________*/

if (worldName isEqualTo 'Tanoa') exitWith {
	[
		["Land_Cargo10_military_green_F",[1.49487,6.91235,2.86102e-006],287.207,[],false,true,true,{}], 
		["Land_Cargo_House_V4_F",[-8.09814,-1.7793,0],285.593,[],false,true,false,{
			missionNamespace setVariable ['QS_sm_radarHouse',(_this # 0),FALSE];
			(_this # 0)
		}], 
		["Land_Cargo_House_V4_F",[7.70508,3.71729,0],17.8366,[],false,true,false,{}], 
		["Land_HBarrier_01_big_4_green_F",[-4.7019,-7.89575,0],196.773,[],false,true,true,{}], 
		["Land_Radar_Small_F",[-4.33276,8.04517,0],224.077,[],false,true,false,{
			missionNamespace setVariable ['QS_sideObj',(_this # 0),FALSE];
			(_this # 0)
		}], 
		["Land_HBarrier_01_big_4_green_F",[2.52881,10.7148,0],196.502,[],false,true,true,{}], 
		["Land_Cargo10_sand_F",[5.8811,-9.29346,2.38419e-006],17.9784,[],false,true,true,{}], 
		["Land_HBarrier_01_big_4_green_F",[-10.853,-6.09961,0],196.773,[],false,true,true,{}], 
		["Land_HBarrier_01_big_4_green_F",[12.4219,1.9939,0],284.439,[],false,true,true,{}], 
		["Land_HBarrier_01_big_4_green_F",[8.85864,-9.00977,0],287.343,[],false,true,true,{}], 
		["Land_HBarrier_01_big_4_green_F",[-12.731,0.210938,0],285.422,[],false,true,true,{}], 
		["Land_HBarrier_01_big_4_green_F",[-10.3882,8.54736,0],285.422,[],false,true,true,{}], 
		["Land_HBarrier_01_big_4_green_F",[10.8364,8.1394,0],196.502,[],false,true,true,{}], 
		["Land_TTowerSmall_1_F",[-12.1282,-4.08374,0],0,[],false,true,true,{}], 
		["Land_TTowerSmall_1_F",[11.7791,5.57422,0],0,[],false,true,true,{}], 
		["Land_LampHalogen_F",[11.6833,4.95874,0],330.389,[],false,true,false,{}], 
		["Land_HBarrier_01_big_4_green_F",[-5.87329,12.9937,0],194.483,[],false,true,true,{}], 
		["Land_Cargo_Patrol_V4_F",[-10.864,-10.3313,0],19.6505,[],false,true,false,{}], 
		["Land_HBarrier_01_big_4_green_F",[16.0398,2.18433,0],195.5,[],false,true,true,{}], 
		["Land_HBarrier_01_big_4_green_F",[15.2424,-6.58057,0],196.194,[],false,true,true,{}], 
		["Land_HBarrier_01_line_5_green_F",[6.65234,-15.4143,0],288.351,[],false,true,true,{}], 
		["Land_HBarrier_01_big_4_green_F",[-15.0918,-8.16699,0],285.422,[],false,true,true,{}], 
		["Land_HBarrier_01_big_4_green_F",[-12.4424,-13.0295,0],199.848,[],false,true,true,{}], 
		["Land_Cargo_Patrol_V4_F",[19.0918,-2.74243,0],286.321,[],false,true,false,{}], 
		["Land_HBarrier_01_big_4_green_F",[19.9111,-2.45679,0],107.11,[],false,true,true,{}]
	]
};
[
	["Land_Cargo10_grey_F",[-3.37891,6.25977,9.53674e-007],220.676,[],false,true,true,{}], 
	["Land_Cargo_House_V3_F",[6.91797,-4.67969,0],132.945,[],false,true,false,{}], 
	["Land_Cargo_House_V3_F",[-7.91016,-2.20313,0],223.6,[],false,true,false,{
		missionNamespace setVariable ['QS_sm_radarHouse',(_this # 0),FALSE];
		(_this # 0)
	}], 
	["Land_TBox_F",[-3.80273,-6.49023,0.00195503],132.626,[],false,true,true,{}], 
	["Land_HBarrierBig_F",[8.43359,0.46875,8.39233e-005],43.8569,[],false,false,true,{}], 
	["Land_Cargo10_sand_F",[-1.43945,8.51367,9.53674e-007],220.648,[],false,true,true,{}], 
	["Land_Mil_WiredFence_F",[8.81641,-2.22852,-0.0532513],223.098,[],false,false,true,{}], 
	["Land_Mil_WiredFence_F",[-3.11133,8.85547,0.0267258],131.363,[],false,false,true,{}], 
	["Land_HBarrierBig_F",[8.375,5.23047,0.00273895],133.746,[],false,false,true,{}], 
	["Land_Radar_Small_F",[-0.0625,-10.8438,-0.0157871],67.5299,[],false,true,false,{
		missionNamespace setVariable ['QS_sideObj',(_this # 0),FALSE];
		(_this # 0)
	}], 
	["Land_WaterTank_F",[0.111328,10.4355,9.15527e-005],40.6538,[],false,false,true,{}], 
	["Land_CampingTable_small_F",[8.58203,-6.375,-0.0250015],313.208,[],false,false,true,{}], 
	["Land_HBarrierBig_F",[-4.60938,9.98438,-0.000522614],133.762,[],false,false,true,{}], 
	["Land_Mil_WiredFence_F",[-11.0391,-0.251953,-0.00183296],131.363,[],false,false,true,{}], 
	["Land_Mil_WiredFence_F",[-7.66406,-8.42773,0.020977],42.792,[],false,false,true,{}], 
	["Land_Mil_WiredFence_F",[8.69727,-7.99023,-0.117788],312.03,[],false,false,true,{}], 
	["Land_HBarrierBig_F",[11.6484,-2.36719,0.00249481],43.8652,[],false,false,true,{}], 
	["Land_Mil_WiredFence_F",[-10.498,-5.79688,0.0108147],42.792,[],false,false,true,{}], 
	["Land_HBarrierBig_F",[-12.4824,1.02734,-0.000488281],133.759,[],false,false,true,{}], 
	["Land_Mil_WiredFence_Gate_F",[5.38867,11.4648,0.000209808],223.046,[],false,false,true,{}], 
	["Land_LampHalogen_F",[12.1211,-4.82617,0],19.0543,[],false,true,false,{}], 
	["Land_HBarrierBig_F",[-9.07031,9.68945,0.000123978],223.659,[],false,false,true,{}], 
	["Land_TTowerSmall_2_F",[-12.8262,-3.20898,0.00219154],0,[],false,true,true,{}], 
	["Flag_White_F",[0.716797,13.1348,0],0,[],false,true,false,{}], 
	["Land_HBarrierBig_F",[-7.52148,-11.2676,-0.000360489],226.463,[],false,false,true,{}], 
	["Land_HBarrierBig_F",[10.4688,-8.5918,-0.000669479],133.761,[],false,false,true,{}], 
	["Land_Cargo_Patrol_V3_F",[14.3047,3.17188,1.90735e-006],222.225,[],false,true,false,{}], 
	["Land_Mil_WiredFence_F",[-1.99609,-13.7598,-0.0504704],42.792,[],false,false,true,{}], 
	["Land_HBarrierBig_F",[-0.914063,14.0098,-0.000520706],133.604,[],false,false,true,{}], 
	["Land_Mil_WiredFence_F",[3.54688,-13.623,0.0534325],312.03,[],false,false,true,{}], 
	["Land_HBarrierBig_F",[-13.7227,-5.30273,0.000213623],223.659,[],false,false,true,{}], 
	["Land_Cargo_Patrol_V3_F",[-14.4668,7.77148,1.90735e-006],133.113,[],false,true,false,{}], 
	["Land_HBarrierBig_F",[-15.5938,2.37695,0.000209808],223.659,[],false,false,true,{}], 
	["Land_HBarrierBig_F",[4.66406,-15.0801,0.00261116],133.747,[],false,false,true,{}], 
	["Land_HBarrierBig_F",[16.1094,-2.02148,-0.000766754],133.767,[],false,false,true,{}], 
	["Land_HBarrierBig_F",[-14.7441,8.24023,-0.000900269],133.757,[],false,false,true,{}], 
	["Land_HBarrierBig_F",[-1.22656,-17.1563,-0.00217438],223.644,[],false,false,true,{}], 
	["Land_Razorwire_F",[-15.9707,10.0918,-2.86102e-006],305.989,[],false,false,true,{}], 
	["Land_Razorwire_F",[-0.609375,18.5898,-2.86102e-006],349.156,[],false,false,true,{}], 
	["Land_Razorwire_F",[22.4141,-0.015625,-2.86102e-006],141.191,[],false,false,true,{}]
]