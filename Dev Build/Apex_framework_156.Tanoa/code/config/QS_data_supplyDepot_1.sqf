([	
	[
		["CamoNet_OPFOR_open_Curator_F",[1.34827,0.554199,1.1301],268.912,[],false,true,true,{}], 
		["Land_Cargo10_military_green_F",[1.99829,-1.44336,0.0240006],89.7956,[],false,true,true,{}], 
		["Land_Pod_Heli_Transport_04_ammo_F",[1.96533,1.95557,0.0235405],270.37,[],false,true,true,{
			_box = _this # 0;
			missionNamespace setVariable ['QS_virtualSectors_sub_3_obj',_box,TRUE];
			for '_x' from 0 to 2 step 1 do {
				_box setVariable ['QS_sc_subObj_3',TRUE,TRUE];
				_box setVariable ['QS_secureable',TRUE,TRUE];
			};
			_box;
		}],
		["Land_HBarrierWall6_F",[2.58313,-6.52441,0],180.854,[],false,true,true,{}], 
		["Land_TTowerSmall_1_F",[2.0332,-2.46655,-2.64879],0,[],false,true,true,{}], 
		["Land_HBarrierWall_corner_F",[-4.65735,-5.36523,0],179.116,[],false,true,true,{}], 
		["Land_HBarrierWall6_F",[0.315918,8.33936,0],0,[],false,true,true,{}], 
		["Land_HBarrierWall6_F",[9.06592,2.35669,0],89.2217,[],false,true,true,{}], 
		["Land_HBarrierWall_corner_F",[-5.27466,6.6189,0],268.993,[],false,true,true,{}], 
		["Land_HBarrierWall_corner_F",[7.86096,-4.90747,0],94.9585,[],false,true,true,{}], 
		["Land_Cargo10_military_green_F",[-3.6925,-9.03394,0.0240002],0.0907073,[],false,true,true,{}], 
		["Land_Cargo10_military_green_F",[-8.8811,6.67358,-0.000998974],267.936,[],false,true,true,{}], 
		["Land_Cargo10_military_green_F",[11.5593,2.3606,0.0240002],91.3617,[],false,true,true,{}],
		["Box_T_East_Wps_F",[-0.0299072,-0.923096,0.0239992],0.00329516,[],false,true,false,{_box = _this # 0;[_box,0,nil] call (missionNamespace getVariable 'QS_fnc_customInventory');_box;}],
		["Box_GEN_Equip_F",[0.325684,-1.98413,0.0239992],359.964,[],false,true,false,{_box = _this # 0;[_box,0,nil] call (missionNamespace getVariable 'QS_fnc_customInventory');_box;}],
		["Box_Syndicate_Ammo_F",[-1.85022,1.19556,0.0239992],254.757,[],false,true,false,{_box = _this # 0;[_box,0,nil] call (missionNamespace getVariable 'QS_fnc_customInventory');_box;}],
		["Box_T_NATO_Wps_F",[-1.95532,2.31909,0.0239992],267.494,[],false,true,false,{_box = _this # 0;[_box,0,nil] call (missionNamespace getVariable 'QS_fnc_customInventory');_box;}],
		["Box_T_East_Ammo_F",[0.290771,-3.12866,0.0239992],338.145,[],false,true,false,{_box = _this # 0;[_box,0,nil] call (missionNamespace getVariable 'QS_fnc_customInventory');_box;}],
		["Box_Syndicate_WpsLaunch_F",[0.756592,3.74487,0.0240002],0.00161651,[],false,true,false,{_box = _this # 0;[_box,0,nil] call (missionNamespace getVariable 'QS_fnc_customInventory');_box;}],
		["Box_NATO_Grenades_F",[3.88513,-0.512451,0.0239992],27.8111,[],false,true,false,{_box = _this # 0;[_box,0,nil] call (missionNamespace getVariable 'QS_fnc_customInventory');_box;}],
		["Box_Syndicate_Ammo_F",[3.78589,-1.49121,0.0239992],87.0554,[],false,true,false,{_box = _this # 0;[_box,0,nil] call (missionNamespace getVariable 'QS_fnc_customInventory');_box;}],
		["Box_Syndicate_Ammo_F",[2.26672,3.76587,0.0239992],356.888,[],false,true,false,{_box = _this # 0;[_box,0,nil] call (missionNamespace getVariable 'QS_fnc_customInventory');_box;}], 
		["Box_T_East_Ammo_F",[3.73376,-2.41992,0.0239992],97.3107,[],false,true,false,{_box = _this # 0;[_box,0,nil] call (missionNamespace getVariable 'QS_fnc_customInventory');_box;}],
		["Box_East_Support_F",[-1.7207,-4.30786,0.0239992],359.997,[],false,true,false,{_box = _this # 0;[_box,0,nil] call (missionNamespace getVariable 'QS_fnc_customInventory');_box;}],
		["Box_Syndicate_Wps_F",[3.74597,3.31616,0.0240002],221.224,[],false,true,false,{_box = _this # 0;[_box,0,nil] call (missionNamespace getVariable 'QS_fnc_customInventory');_box;}],
		["Box_T_East_Ammo_F",[-5.54846,3.34375,0.024003],212.741,[],false,true,false,{_box = _this # 0;[_box,0,nil] call (missionNamespace getVariable 'QS_fnc_customInventory');_box;}],
		["Box_IED_Exp_F",[7.82349,6.41211,0.0239992],0.00293722,[],false,true,false,{_box = _this # 0;[_box,0,nil] call (missionNamespace getVariable 'QS_fnc_customInventory');_box;}]
	],
	[
		["Land_Cargo10_military_green_F",[2.00989,-1.4231,0.0240006],89.8031,[],false,true,true,{}], 
		["CamoNet_BLUFOR_open_Curator_F",[2.76733,-0.0705566,0.728848],262.765,[],false,true,true,{}], 
		["Land_Pod_Heli_Transport_04_ammo_F",[1.97693,1.97583,0.0235405],270.37,[],false,true,true,{
			_box = _this # 0;
			missionNamespace setVariable ['QS_virtualSectors_sub_3_obj',_box,TRUE];
			for '_x' from 0 to 2 step 1 do {
				_box setVariable ['QS_sc_subObj_3',TRUE,TRUE];
				_box setVariable ['QS_secureable',TRUE,TRUE];
			};
			_box;
		}], 
		["Land_TTowerSmall_1_F",[2.06213,-2.1499,-2.64879],0,[],false,true,true,{}], 
		["Land_HBarrier_01_wall_6_green_F",[2.56836,-6.74219,0],181.46,[],false,true,true,{}], 
		["Land_HBarrier_01_wall_corner_green_F",[-4.61487,-5.32568,0],180.927,[],false,true,true,{}], 
		["Land_HBarrier_01_wall_6_green_F",[0.266724,8.19043,0],0.559541,[],false,true,true,{}], 
		["Land_HBarrier_01_wall_6_green_F",[9.1449,2.073,0],90.3177,[],false,true,true,{}], 
		["Land_HBarrier_01_wall_corner_green_F",[-5.17725,6.51685,0],269.469,[],false,true,true,{}], 
		["Land_HBarrier_01_wall_corner_green_F",[8.15112,-5.14966,0],89.5987,[],false,true,true,{}], 
		["Land_Cargo10_military_green_F",[-3.68091,-9.01367,-0.000998974],0.0808997,[],false,true,true,{}], 
		["Land_Cargo10_military_green_F",[-8.76819,6.71802,-0.000998497],268.942,[],false,true,true,{}], 
		["Land_Cargo10_military_green_F",[11.5709,2.38086,-0.000999928],91.3617,[],false,true,true,{}],
		["Box_T_East_Wps_F",[-0.0299072,-0.923096,0.0239992],0.00329516,[],false,true,false,{_box = _this # 0;[_box,0,nil] call (missionNamespace getVariable 'QS_fnc_customInventory');_box;}],
		["Box_GEN_Equip_F",[0.325684,-1.98413,0.0239992],359.964,[],false,true,false,{_box = _this # 0;[_box,0,nil] call (missionNamespace getVariable 'QS_fnc_customInventory');_box;}],
		["Box_Syndicate_Ammo_F",[-1.85022,1.19556,0.0239992],254.757,[],false,true,false,{_box = _this # 0;[_box,0,nil] call (missionNamespace getVariable 'QS_fnc_customInventory');_box;}],
		["Box_T_NATO_Wps_F",[-1.95532,2.31909,0.0239992],267.494,[],false,true,false,{_box = _this # 0;[_box,0,nil] call (missionNamespace getVariable 'QS_fnc_customInventory');_box;}],
		["Box_T_East_Ammo_F",[0.290771,-3.12866,0.0239992],338.145,[],false,true,false,{_box = _this # 0;[_box,0,nil] call (missionNamespace getVariable 'QS_fnc_customInventory');_box;}],
		["Box_Syndicate_WpsLaunch_F",[0.756592,3.74487,0.0240002],0.00161651,[],false,true,false,{_box = _this # 0;[_box,0,nil] call (missionNamespace getVariable 'QS_fnc_customInventory');_box;}],
		["Box_NATO_Grenades_F",[3.88513,-0.512451,0.0239992],27.8111,[],false,true,false,{_box = _this # 0;[_box,0,nil] call (missionNamespace getVariable 'QS_fnc_customInventory');_box;}],
		["Box_Syndicate_Ammo_F",[3.78589,-1.49121,0.0239992],87.0554,[],false,true,false,{_box = _this # 0;[_box,0,nil] call (missionNamespace getVariable 'QS_fnc_customInventory');_box;}],
		["Box_Syndicate_Ammo_F",[2.26672,3.76587,0.0239992],356.888,[],false,true,false,{_box = _this # 0;[_box,0,nil] call (missionNamespace getVariable 'QS_fnc_customInventory');_box;}],
		["Box_T_East_Ammo_F",[3.73376,-2.41992,0.0239992],97.3107,[],false,true,false,{_box = _this # 0;[_box,0,nil] call (missionNamespace getVariable 'QS_fnc_customInventory');_box;}],
		["Box_East_Support_F",[-1.7207,-4.30786,0.0239992],359.997,[],false,true,false,{_box = _this # 0;[_box,0,nil] call (missionNamespace getVariable 'QS_fnc_customInventory');_box;}],
		["Box_Syndicate_Wps_F",[3.74597,3.31616,0.0240002],221.224,[],false,true,false,{_box = _this # 0;[_box,0,nil] call (missionNamespace getVariable 'QS_fnc_customInventory');_box;}],
		["Box_T_East_Ammo_F",[-5.54846,3.34375,0.024003],212.741,[],false,true,false,{_box = _this # 0;[_box,0,nil] call (missionNamespace getVariable 'QS_fnc_customInventory');_box;}],
		["Box_IED_Exp_F",[7.82349,6.41211,0.0239992],0.00293722,[],false,true,false,{_box = _this # 0;[_box,0,nil] call (missionNamespace getVariable 'QS_fnc_customInventory');_box;}]
	]
] select (worldName isEqualTo 'Tanoa'))