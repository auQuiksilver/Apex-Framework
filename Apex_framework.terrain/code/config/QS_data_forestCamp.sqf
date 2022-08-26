/*
Grab data:
Mission: tempMissionSP
World: Tanoa
Anchor position: [1945.61, 7801.98]
Area size: 150
Using orientation of objects: no
*/
_arr = selectRandom [
	[
		["Land_WoodenLog_F",[0.561523,2.89453,0.0025692],0.0308644,[],false,true,true,{}], 
		["Land_WoodenLog_F",[1.29333,3.24561,0.000452995],6.98531e-005,[],false,true,true,{}], 
		["Land_WoodenLog_F",[0.131836,4.17236,0.00100136],0.0106045,[],false,true,true,{}], 
		["Land_Pillow_camouflage_F",[1.9502,-4.04053,-0.00437164],359.949,[],false,true,true,{}], 
		["Land_WoodenLog_F",[2.91699,3.57715,0.000720024],0.00529163,[],false,true,true,{}], 
		["Land_TentA_F",[2.49487,-4.49658,0.0033102],154.394,[],false,true,true,{}], 
		["Land_Pillow_F",[4.07532,-3.20117,-0.00266647],359.976,[],false,true,true,{}], 
		["Land_WoodenLog_F",[-0.628906,5.32422,0.00101948],0.00989454,[],false,true,true,{}], 
		["Land_TentA_F",[0.555664,-5.45117,0.00226498],154.738,[],false,true,true,{}], 
		["Land_WoodenTable_small_F",[-5.53601,1.38818,0.00571918],0.0105207,[],false,true,true,{}], 
		["Land_TentA_F",[4.5553,-3.6709,0.000300407],154.792,[],false,true,true,{}], 
		["Land_Campfire_F",[1.5083,5.66016,-0.0118637],0,[],false,true,false,{}], 
		["Land_BagFence_01_long_green_F",[-4.24316,-4.61084,0.0557795],57.5924,[],false,true,true,{}], 
		["Land_TentA_F",[-1.46533,-6.31299,0.000301361],159.972,[],false,true,true,{}], 
		["Land_BagFence_01_long_green_F",[5.95801,-2.91992,0.0192242],247.137,[],false,true,true,{}], 
		["Land_Axe_F",[2.61304,6.40381,-0.0033474],81.9073,[],false,true,true,{}], 
		["Land_BagFence_01_long_green_F",[2.73621,-6.38232,0.172243],336.854,[],false,true,true,{}], 
		["Land_BagFence_01_long_green_F",[-1.72949,6.74902,-0.122396],151.116,[],false,true,true,{}], 
		["Box_IED_Exp_F",[6.60242,-2.64941,7.43866e-005],248.768,[],false,true,false,{
			private ['_box','_magazineCargo','_index'];
			_box = _this # 0;
			//comment 'Clear smoke grenades as anti-troll measure.';
			_magazineCargo = getMagazineCargo _box;
			clearMagazineCargoGlobal _box;
			_index = 0;
			for '_x' from 0 to ((count (_magazineCargo # 0)) - 1) step 1 do {
				if (!(['SmokeShell',((_magazineCargo # 0) # _index),FALSE] call (missionNamespace getVariable 'QS_fnc_inString'))) then {
					_box addMagazineCargoGlobal [((_magazineCargo # 0) # _index),((_magazineCargo # 1) # _index)];
				};
				_index = _index + 1;
			};
			_box;
		}], 
		["Land_BagFence_01_long_green_F",[5.28918,-5.04541,0.0291109],330.025,[],false,true,true,{}], 
		["Box_Syndicate_Wps_F",[7.10132,-1.83691,3.52859e-005],0.000278935,[],false,true,false,{
			private ['_box','_magazineCargo','_index'];
			_box = _this # 0;
			//comment 'Clear smoke grenades as anti-troll measure.';
			_magazineCargo = getMagazineCargo _box;
			clearMagazineCargoGlobal _box;
			_index = 0;
			for '_x' from 0 to ((count (_magazineCargo # 0)) - 1) step 1 do {
				if (!(['SmokeShell',((_magazineCargo # 0) # _index),FALSE] call (missionNamespace getVariable 'QS_fnc_inString'))) then {
					_box addMagazineCargoGlobal [((_magazineCargo # 0) # _index),((_magazineCargo # 1) # _index)];
				};
				_index = _index + 1;
			};
			_box;
		}], 
		["Land_BagFence_01_long_green_F",[5.34106,5.18262,-0.0010643],236.389,[],false,true,true,{}], 
		["Land_BagFence_01_long_green_F",[0.145386,-7.48535,0.0208321],336.788,[],false,true,true,{}], 
		["Land_BagFence_01_long_green_F",[-2.74231,-7.07715,-0.0406761],57.9387,[],false,true,true,{}], 
		["Land_WoodPile_F",[3.20422,6.97607,0.00199795],151.152,[],false,true,true,{}], 
		["Land_BagFence_01_long_green_F",[-7.4928,1.26465,-0.00218773],64.5598,[],false,true,true,{}], 
		["Land_BagFence_01_long_green_F",[-6.9635,3.19385,-0.0692377],144.333,[],false,true,true,{}], 
		["Box_Syndicate_Ammo_F",[7.47241,-2.76709,8.29697e-005],360,[],false,true,false,{
			private ['_box','_magazineCargo','_index'];
			_box = _this # 0;
			//comment 'Clear smoke grenades as anti-troll measure.';
			_magazineCargo = getMagazineCargo _box;
			clearMagazineCargoGlobal _box;
			_index = 0;
			for '_x' from 0 to ((count (_magazineCargo # 0)) - 1) step 1 do {
				if (!(['SmokeShell',((_magazineCargo # 0) # _index),FALSE] call (missionNamespace getVariable 'QS_fnc_inString'))) then {
					_box addMagazineCargoGlobal [((_magazineCargo # 0) # _index),((_magazineCargo # 1) # _index)];
				};
				_index = _index + 1;
			};
			_box;
		}], 
		["Land_BagFence_01_long_green_F",[0.724609,8.08203,-0.0500402],151.087,[],false,true,true,{}], 
		["Land_BagFence_01_corner_green_F",[-1.85413,-8.00049,-0.0253582],159.037,[],false,true,true,{}], 
		["Land_BagFence_01_long_green_F",[8.38794,-0.620605,0.022336],243.235,[],false,true,true,{}], 
		["Land_Ammobox_rounds_F",[8.12854,-2.37842,-7.82013e-005],359.98,[],false,true,true,{}], 
		["Land_BagFence_01_long_green_F",[3.77649,7.58594,-0.0349331],236.369,[],false,true,true,{}], 
		["Land_BagFence_01_long_green_F",[7.78381,-3.64795,0.0478001],330.024,[],false,true,true,{}], 
		["Land_Ammobox_rounds_F",[8.37781,-2.15088,0.00020504],63.1551,[],false,true,true,{}], 
		["Land_Ammobox_rounds_F",[8.57703,-2.47559,0.000179291],162.848,[],false,true,true,{}], 
		["Land_BagFence_01_corner_green_F",[2.56201,8.81836,0.019496],331.607,[],false,true,true,{}], 
		["Land_BagFence_01_corner_green_F",[9.05444,-2.53369,-0.0145674],66.2969,[],false,true,true,{}]
	],
	[
		["Land_Boat_03_abandoned_cover_F",[0.556641,0.604492,0],0,[],false,false,TRUE,{}], 
		["Land_CampingChair_V2_F",[2.6543,0.660645,0],315.598,[],false,false,TRUE,{}], 
		["Land_TentDome_F",[-3.03369,-2.68701,0],150.339,[],false,false,TRUE,{}], 
		["Land_CampingTable_small_F",[3.8877,-0.209473,-0.13347],0,[],false,false,TRUE,{}], 
		["Box_Syndicate_Wps_F",[3.8916,-0.20752,-9.53674e-007],0,[],false,TRUE,false,{
			private ['_box','_magazineCargo','_index'];
			_box = _this # 0;
			//comment 'Clear smoke grenades as anti-troll measure.';
			_magazineCargo = getMagazineCargo _box;
			clearMagazineCargoGlobal _box;
			_index = 0;
			for '_x' from 0 to ((count (_magazineCargo # 0)) - 1) step 1 do {
				if (!(['SmokeShell',((_magazineCargo # 0) # _index),FALSE] call (missionNamespace getVariable 'QS_fnc_inString'))) then {
					_box addMagazineCargoGlobal [((_magazineCargo # 0) # _index),((_magazineCargo # 1) # _index)];
				};
				_index = _index + 1;
			};
			_box;
		}], 
		["Land_TentDome_F",[-2.41504,3.80762,0],239.998,[],false,false,TRUE,{}], 
		["Land_TentDome_F",[3.98145,2.76904,0],331.559,[],false,false,TRUE,{}], 
		["Land_ClothesLine_01_full_F",[-4.77539,0.646973,0],278.003,[],false,false,TRUE,{(_this # 0) setVectorUp [0,0,1];(_this # 0);}], 
		["Box_Syndicate_WpsLaunch_F",[-4.74512,-1.16406,-1.83582e-005],281.423,[],false,TRUE,false,{
			private ['_box','_magazineCargo','_index'];
			_box = _this # 0;
			//comment 'Clear smoke grenades as anti-troll measure.';
			_magazineCargo = getMagazineCargo _box;
			clearMagazineCargoGlobal _box;
			_index = 0;
			for '_x' from 0 to ((count (_magazineCargo # 0)) - 1) step 1 do {
				if (!(['SmokeShell',((_magazineCargo # 0) # _index),FALSE] call (missionNamespace getVariable 'QS_fnc_inString'))) then {
					_box addMagazineCargoGlobal [((_magazineCargo # 0) # _index),((_magazineCargo # 1) # _index)];
				};
				_index = _index + 1;
			};
			_box;
		}], 
		["Box_Syndicate_Ammo_F",[-2.07861,-4.46387,3.09944e-006],0,[],false,TRUE,false,{
			private ['_box','_magazineCargo','_index'];
			_box = _this # 0;
			//comment 'Clear smoke grenades as anti-troll measure.';
			_magazineCargo = getMagazineCargo _box;
			clearMagazineCargoGlobal _box;
			_index = 0;
			for '_x' from 0 to ((count (_magazineCargo # 0)) - 1) step 1 do {
				if (!(['SmokeShell',((_magazineCargo # 0) # _index),FALSE] call (missionNamespace getVariable 'QS_fnc_inString'))) then {
					_box addMagazineCargoGlobal [((_magazineCargo # 0) # _index),((_magazineCargo # 1) # _index)];
				};
				_index = _index + 1;
			};
			_box;
		}], 
		["Land_CampingChair_V2_F",[4.91016,1.17529,0],47.3084,[],false,false,TRUE,{}], 
		["Box_GEN_Equip_F",[-0.699707,5.01465,-1.66893e-006],275.153,[],false,TRUE,false,{
			private ['_box','_magazineCargo','_index'];
			_box = _this # 0;
			//comment 'Clear smoke grenades as anti-troll measure.';
			_magazineCargo = getMagazineCargo _box;
			clearMagazineCargoGlobal _box;
			_index = 0;
			for '_x' from 0 to ((count (_magazineCargo # 0)) - 1) step 1 do {
				if (!(['SmokeShell',((_magazineCargo # 0) # _index),FALSE] call (missionNamespace getVariable 'QS_fnc_inString'))) then {
					_box addMagazineCargoGlobal [((_magazineCargo # 0) # _index),((_magazineCargo # 1) # _index)];
				};
				_index = _index + 1;
			};
			_box;
		}], 
		["Land_FirePlace_F",[2.72607,-4.42432,-6.81877e-005],0,[],false,TRUE,false,{}], 
		["Land_ClothesLine_01_short_F",[5.19287,-1.479,0],99.415,[],false,false,TRUE,{(_this # 0) setVectorUp [0,0,1];(_this # 0);}], 
		["Land_BagFence_01_long_green_F",[-5.4458,-1.48682,-0.000999928],276.775,[],false,false,TRUE,{}], 
		["Land_BagFence_01_short_green_F",[5.76416,-0.745117,-0.000999928],96.6688,[],false,false,TRUE,{}], 
		["Land_BagFence_01_long_green_F",[-2.80615,-5.19238,-0.000999928],5.91454,[],false,false,TRUE,{}], 
		["Land_BagFence_01_long_green_F",[1.84717,-5.67139,-0.000999928],186.35,[],false,false,TRUE,{}], 
		["Land_BagFence_01_long_green_F",[-1.12402,5.89307,-0.000999928],7.48735,[],false,false,TRUE,{}], 
		["Land_BagFence_01_short_green_F",[-4.82813,3.91064,-0.000999928],97.9591,[],false,false,TRUE,{}], 
		["Land_BagFence_01_long_green_F",[6.13281,1.37402,-0.000999928],99.2055,[],false,false,TRUE,{}], 
		["Land_BagFence_01_long_green_F",[3.65332,5.18799,-0.000999928],188.345,[],false,false,TRUE,{}], 
		["Box_IED_Exp_F",[5.03174,3.93555,-1.26362e-005],296.601,[],false,true,false,{
			private ['_box','_magazineCargo','_index'];
			_box = _this # 0;
			//comment 'Clear smoke grenades as anti-troll measure.';
			_magazineCargo = getMagazineCargo _box;
			clearMagazineCargoGlobal _box;
			_index = 0;
			for '_x' from 0 to ((count (_magazineCargo # 0)) - 1) step 1 do {
				if (!(['SmokeShell',((_magazineCargo # 0) # _index),FALSE] call (missionNamespace getVariable 'QS_fnc_inString'))) then {
					_box addMagazineCargoGlobal [((_magazineCargo # 0) # _index),((_magazineCargo # 1) # _index)];
				};
				_index = _index + 1;
			};
			_box;
		}], 
		["Land_WoodPile_F",[3.729,-5.24219,0],60.0446,[],false,false,TRUE,{}], 
		["Land_BambooFence_01_s_4m_F",[-3.52441,-5.51953,-4.29153e-006],187.187,[],false,false,TRUE,{}], 
		["Land_BambooFence_01_s_4m_F",[6.43701,1.20264,-4.29153e-006],277.15,[],false,false,TRUE,{}], 
		["Land_BambooFence_01_s_4m_F",[-6.18018,-2.29541,-4.29153e-006],277.15,[],false,false,TRUE,{}], 
		["Land_BagFence_01_round_green_F",[-5.19531,-4.17773,-0.00130129],56.3167,[],false,false,TRUE,{}], 
		["Land_BambooFence_01_s_4m_F",[2.69238,-6.08252,-4.29153e-006],187.187,[],false,false,TRUE,{}], 
		["Land_BambooFence_01_s_4m_F",[-1.98535,6.48438,-4.29153e-006],8.81655,[],false,false,TRUE,{}], 
		["Land_BagFence_01_round_green_F",[-3.81787,5.67627,-0.00130129],147.029,[],false,false,TRUE,{}], 
		["Land_BambooFence_01_s_d_F",[-5.16943,4.43848,-0.000166178],102.264,[],false,false,TRUE,{}], 
		["Land_BambooFence_01_s_d_F",[4.17334,5.66797,4.52995e-006],0,[],false,false,TRUE,{}], 
		["Land_BagFence_01_round_green_F",[4.53613,-5.40088,-0.00130129],325.891,[],false,false,TRUE,{}], 
		["Land_BagFence_01_round_green_F",[5.99707,4.07324,-0.00130129],238.747,[],false,false,TRUE,{}], 
		["Land_SlumWall_01_s_2m_F",[-5.90039,-4.5957,-0.000109673],240.126,[],false,false,TRUE,{}], 
		["Land_SlumWall_01_s_2m_F",[5.35205,-5.68652,-4.76837e-006],319.36,[],false,false,TRUE,{}], 
		["Land_SlumWall_01_s_2m_F",[-4.68506,6.53564,-0.000258923],146.417,[],false,false,TRUE,{}]
	]
];
_arr;