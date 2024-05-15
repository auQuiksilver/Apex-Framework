/*/
File: QS_data_mortarPit.sqf
Author:

	Quiksilver
	
Last modified:

	20/04/2018 A3 1.82 by Quiksilver
	
Description:

	Mortar pit
__________________________________________________________________________/*/

if (worldName in ['Tanoa','Lingor3']) exitWith {
	[
		["Land_BagFence_01_round_green_F",[0.84375,-0.822754,-0.0026021],93.7561,[],false,false,TRUE,{}], 
		["Land_BagFence_01_round_green_F",[-0.249023,1.80664,-0.0026021],285.207,[],false,false,TRUE,{}], 
		["Land_BagFence_01_round_green_F",[-2.33203,0.675293,-0.0026021],14.8742,[],false,false,TRUE,{}], 
		["Land_BagFence_01_round_green_F",[-1.79004,-1.65137,-0.0026021],190.105,[],false,false,TRUE,{}], 
		["I_G_Mortar_01_F",[-1.45361,2.0835,-0.0753462],0,[],false,TRUE,false,{
			_mortar = _this # 0;
			_grp = createVehicleCrew _mortar;
			{
				missionNamespace setVariable ['QS_HC_AO_enemyArray',((missionNamespace getVariable 'QS_HC_AO_enemyArray') + [_x]),FALSE];
			} forEach [
				_mortar,
				(effectiveCommander _mortar)
			];
			if (worldName in ['Tanoa','Lingor3']) then {
				(effectiveCommander _mortar) setUnitLoadout (selectRandom [
					"I_C_Soldier_Para_1_F","I_C_Soldier_Para_2_F","I_C_Soldier_Para_3_F","I_C_Soldier_Para_4_F","I_C_Soldier_Para_5_F","I_C_Soldier_Para_6_F",
					"I_C_Soldier_Para_7_F","I_C_Soldier_Para_8_F"
				]);
			} else {
				(effectiveCommander _mortar) setUnitLoadout (selectRandom [
					"O_soldierU_A_F","O_soldierU_AAR_F","O_soldierU_AR_F","O_soldierU_medic_F","O_engineer_U_F","O_soldierU_exp_F","O_SoldierU_GL_F",
					"O_Urban_HeavyGunner_F","O_soldierU_M_F","O_soldierU_AT_F","O_soldierU_F","O_soldierU_LAT_F","O_Urban_Sharpshooter_F",
					"O_SoldierU_SL_F","O_soldierU_TL_F","O_G_engineer_F","O_G_medic_F","O_G_Soldier_A_F","O_G_Soldier_AR_F","O_G_Soldier_exp_F","O_G_Soldier_F","O_G_Soldier_F",
					"O_G_Soldier_GL_F","O_G_Soldier_LAT_F","O_G_Soldier_lite_F","O_G_Soldier_M_F","O_G_Soldier_SL_F","O_G_Soldier_TL_F",
					"O_G_Sharpshooter_F","O_G_Soldier_AR_F"
				]);
			};
			_mortar lock 3;
			_mortar enableDynamicSimulation FALSE;
			_mortar setVariable ['QS_dynSim_ignore',TRUE,FALSE];
			_mortar enableWeaponDisassembly FALSE;
			_mortar setVariable ['QS_hidden',TRUE,TRUE];
			_mortar addEventHandler [
				'Killed',
				{
					_mortar = _this # 0;
					if (!isNull (gunner _mortar)) then {
						(gunner _mortar) setDamage 1;
					};
				}
			];
			_mortar addEventHandler [
				'GetOut',
				{
					_mortar = _this # 0;
					_mortar setDamage [1,FALSE];
				}
			];
			(gunner _mortar) addEventHandler [
				'Killed',
				{
					params ['_killed','_killer'];
					(vehicle _killed) setDamage 1;
				}
			];
			(gunner _mortar) call (missionNamespace getVariable 'QS_fnc_unitSetup');
			(gunner _mortar) addEventHandler [
				'FiredMan',
				{
					if ((toLowerANSI (_this # 5)) in ['8rnd_82mm_mo_shells','12rnd_230mm_rockets','32rnd_155mm_mo_shells','4rnd_155mm_mo_guided','2rnd_155mm_mo_lg']) then {
						if ((toLowerANSI (_this # 5)) in ['8rnd_82mm_mo_shells']) then {
							(_this # 6) addEventHandler ['Explode',{(_this + [0]) spawn (missionNamespace getVariable 'QS_fnc_craterEffect')}];
						} else {
							(_this # 6) addEventHandler ['Explode',{(_this + [1]) spawn (missionNamespace getVariable 'QS_fnc_craterEffect')}];
						};
					};
					if (missionNamespace isNil 'QS_enemy_mortarFireMessage') then {
						missionNamespace setVariable ['QS_enemy_mortarFireMessage',diag_tickTime,FALSE];
					};
					if ((missionNamespace getVariable 'QS_enemy_mortarFireMessage') > (diag_tickTime - 300)) exitWith {};
					missionNamespace setVariable ['QS_enemy_mortarFireMessage',diag_tickTime,FALSE];
					['sideChat',[WEST,'HQ'],localize 'STR_QS_Chat_007'] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
				}
			];
			(gunner _mortar) addEventHandler [
				'GetOutMan',
				{
					(_this # 0) removeAllEventHandlers 'FiredMan';
				}
			];
			(gunner _mortar) addEventHandler [
				'HandleRating',
				{
					params ['_unit','_rating'];
					if ((rating _unit) < 0) then {
						_unit addRating (0 - (rating _unit));
					};
				}
			];
			missionNamespace setVariable ['QS_AI_supportProviders_MTR',((missionNamespace getVariable 'QS_AI_supportProviders_MTR') + [gunner _mortar]),QS_system_AI_owners];
			_grp deleteGroupWhenEmpty TRUE;
			_grp enableDynamicSimulation FALSE;
			_grp setVariable ['QS_dynSim_ignore',TRUE,FALSE];
			_grp addVehicle _mortar;
			_grp setVariable ['QS_AI_GRP',TRUE,FALSE];
			_grp setVariable ['QS_AI_GRP_CONFIG',['SUPPORT','MORTAR',_mortar],FALSE];
			_grp setVariable ['QS_AI_GRP_DATA',[TRUE,serverTime],FALSE];
			_grp setVariable ['QS_AI_GRP_TASK',['SUPPORT','MORTAR',serverTime,-1],FALSE];	
			_mortar;
		}], 
		["Land_BagFence_01_round_green_F",[2.76563,0.580566,-0.0026021],190.105,[],false,false,TRUE,{}], 
		["I_G_Mortar_01_F",[2.96875,-1.1333,-0.0753462],0,[],false,TRUE,false,{
			_mortar = _this # 0;
			_grp = createVehicleCrew _mortar;
			{
				missionNamespace setVariable [
					'QS_HC_AO_enemyArray',
					((missionNamespace getVariable 'QS_HC_AO_enemyArray') + [_x]),
					FALSE
				];
			} forEach [
				_mortar,
				(effectiveCommander _mortar)
			];
			if (worldName in ['Tanoa','Lingor3']) then {
				(effectiveCommander _mortar) setUnitLoadout (selectRandom [
					"I_C_Soldier_Para_1_F","I_C_Soldier_Para_2_F","I_C_Soldier_Para_3_F","I_C_Soldier_Para_4_F","I_C_Soldier_Para_5_F","I_C_Soldier_Para_6_F",
					"I_C_Soldier_Para_7_F","I_C_Soldier_Para_8_F"
				]);
			} else {
				(effectiveCommander _mortar) setUnitLoadout (selectRandom [
					"O_soldierU_A_F","O_soldierU_AAR_F","O_soldierU_AR_F","O_soldierU_medic_F","O_engineer_U_F","O_soldierU_exp_F","O_SoldierU_GL_F",
					"O_Urban_HeavyGunner_F","O_soldierU_M_F","O_soldierU_AT_F","O_soldierU_F","O_soldierU_LAT_F","O_Urban_Sharpshooter_F",
					"O_SoldierU_SL_F","O_soldierU_TL_F","O_G_engineer_F","O_G_medic_F","O_G_Soldier_A_F","O_G_Soldier_AR_F","O_G_Soldier_exp_F","O_G_Soldier_F","O_G_Soldier_F",
					"O_G_Soldier_GL_F","O_G_Soldier_LAT_F","O_G_Soldier_lite_F","O_G_Soldier_M_F","O_G_Soldier_SL_F","O_G_Soldier_TL_F",
					"O_G_Sharpshooter_F","O_G_Soldier_AR_F"
				]);
			};
			_mortar lock 3;
			_mortar enableDynamicSimulation FALSE;
			_mortar setVariable ['QS_dynSim_ignore',TRUE,FALSE];
			_mortar enableWeaponDisassembly FALSE;
			_mortar setVariable ['QS_hidden',TRUE,TRUE];
			_mortar addEventHandler [
				'Killed',
				{
					_mortar = _this # 0;
					if (!isNull (gunner _mortar)) then {
						(gunner _mortar) setDamage 1;
					};
				}
			];
			_mortar addEventHandler [
				'GetOut',
				{
					_mortar = _this # 0;
					_mortar setDamage [1,FALSE];
				}
			];
			(gunner _mortar) addEventHandler [
				'Killed',
				{
					params ['_killed','_killer'];
					(vehicle _killed) setDamage 1;
				}
			];
			(gunner _mortar) call (missionNamespace getVariable 'QS_fnc_unitSetup');
			(gunner _mortar) addEventHandler [
				'FiredMan',
				{
					if ((toLowerANSI (_this # 5)) in ['8rnd_82mm_mo_shells','12rnd_230mm_rockets','32rnd_155mm_mo_shells','4rnd_155mm_mo_guided','2rnd_155mm_mo_lg']) then {
						if ((toLowerANSI (_this # 5)) in ['8rnd_82mm_mo_shells']) then {
							(_this # 6) addEventHandler ['Explode',{(_this + [0]) spawn (missionNamespace getVariable 'QS_fnc_craterEffect')}];
						} else {
							(_this # 6) addEventHandler ['Explode',{(_this + [1]) spawn (missionNamespace getVariable 'QS_fnc_craterEffect')}];
						};
					};
					if (missionNamespace isNil 'QS_enemy_mortarFireMessage') then {
						missionNamespace setVariable ['QS_enemy_mortarFireMessage',diag_tickTime,FALSE];
					};
					if ((missionNamespace getVariable 'QS_enemy_mortarFireMessage') > (diag_tickTime - 300)) exitWith {};
					missionNamespace setVariable ['QS_enemy_mortarFireMessage',diag_tickTime,FALSE];
					['sideChat',[WEST,'HQ'],localize 'STR_QS_Chat_007'] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
				}
			];
			(gunner _mortar) addEventHandler [
				'HandleRating',
				{
					params ['_unit','_rating'];
					if ((rating _unit) < 0) then {
						_unit addRating (0 - (rating _unit));
					};
				}
			];
			missionNamespace setVariable ['QS_AI_supportProviders_MTR',((missionNamespace getVariable 'QS_AI_supportProviders_MTR') + [gunner _mortar]),QS_system_AI_owners];
			_grp deleteGroupWhenEmpty TRUE;
			_grp enableDynamicSimulation FALSE;
			_grp setVariable ['QS_dynSim_ignore',TRUE,FALSE];
			_grp addVehicle _mortar;
			_grp setVariable ['QS_AI_GRP',TRUE,FALSE];
			_grp setVariable ['QS_AI_GRP_CONFIG',['SUPPORT','MORTAR',_mortar],FALSE];
			_grp setVariable ['QS_AI_GRP_DATA',[TRUE,serverTime],FALSE];
			_grp setVariable ['QS_AI_GRP_TASK',['SUPPORT','MORTAR',serverTime,-1],FALSE];
			_mortar;
		}], 
		["Land_BagFence_01_round_green_F",[2.02832,-2.75488,-0.0026021],14.8742,[],false,false,TRUE,{}], 
		["I_G_Mortar_01_F",[-1.67529,-3.41846,-0.0753462],0,[],false,TRUE,false,{
			_mortar = _this # 0;
			_grp = createVehicleCrew _mortar;
			{
				missionNamespace setVariable [
					'QS_HC_AO_enemyArray',
					((missionNamespace getVariable 'QS_HC_AO_enemyArray') + [_x]),
					FALSE
				];
			} forEach [
				_mortar,
				(effectiveCommander _mortar)
			];
			if (worldName in ['Tanoa','Lingor3']) then {
				(effectiveCommander _mortar) setUnitLoadout (selectRandom [
					"I_C_Soldier_Para_1_F","I_C_Soldier_Para_2_F","I_C_Soldier_Para_3_F","I_C_Soldier_Para_4_F","I_C_Soldier_Para_5_F","I_C_Soldier_Para_6_F",
					"I_C_Soldier_Para_7_F","I_C_Soldier_Para_8_F"
				]);
			} else {
				(effectiveCommander _mortar) setUnitLoadout (selectRandom [
					"O_soldierU_A_F","O_soldierU_AAR_F","O_soldierU_AR_F","O_soldierU_medic_F","O_engineer_U_F","O_soldierU_exp_F","O_SoldierU_GL_F",
					"O_Urban_HeavyGunner_F","O_soldierU_M_F","O_soldierU_AT_F","O_soldierU_F","O_soldierU_LAT_F","O_Urban_Sharpshooter_F",
					"O_SoldierU_SL_F","O_soldierU_TL_F","O_G_engineer_F","O_G_medic_F","O_G_Soldier_A_F","O_G_Soldier_AR_F","O_G_Soldier_exp_F","O_G_Soldier_F","O_G_Soldier_F",
					"O_G_Soldier_GL_F","O_G_Soldier_LAT_F","O_G_Soldier_lite_F","O_G_Soldier_M_F","O_G_Soldier_SL_F","O_G_Soldier_TL_F",
					"O_G_Sharpshooter_F","O_G_Soldier_AR_F"
				]);
			};
			_mortar lock 3;
			_mortar enableDynamicSimulation FALSE;
			_mortar setVariable ['QS_dynSim_ignore',TRUE,FALSE];
			_mortar enableWeaponDisassembly FALSE;
			_mortar setVariable ['QS_hidden',TRUE,TRUE];
			_mortar addEventHandler [
				'Killed',
				{
					_mortar = _this # 0;
					if (!isNull (gunner _mortar)) then {
						(gunner _mortar) setDamage 1;
					};
				}
			];
			_mortar addEventHandler [
				'GetOut',
				{
					_mortar = _this # 0;
					_mortar setDamage [1,FALSE];
				}
			];
			(gunner _mortar) addEventHandler [
				'Killed',
				{
					params ['_killed','_killer'];
					(vehicle _killed) setDamage 1;
				}
			];
			(gunner _mortar) call (missionNamespace getVariable 'QS_fnc_unitSetup');
			(gunner _mortar) addEventHandler [
				'FiredMan',
				{
					if ((toLowerANSI (_this # 5)) in ['8rnd_82mm_mo_shells','12rnd_230mm_rockets','32rnd_155mm_mo_shells','4rnd_155mm_mo_guided','2rnd_155mm_mo_lg']) then {
						if ((toLowerANSI (_this # 5)) in ['8rnd_82mm_mo_shells']) then {
							(_this # 6) addEventHandler ['Explode',{(_this + [0]) spawn (missionNamespace getVariable 'QS_fnc_craterEffect')}];
						} else {
							(_this # 6) addEventHandler ['Explode',{(_this + [1]) spawn (missionNamespace getVariable 'QS_fnc_craterEffect')}];
						};
					};
					if (missionNamespace isNil 'QS_enemy_mortarFireMessage') then {
						missionNamespace setVariable ['QS_enemy_mortarFireMessage',diag_tickTime,FALSE];
					};
					if ((missionNamespace getVariable 'QS_enemy_mortarFireMessage') > (diag_tickTime - 300)) exitWith {};
					missionNamespace setVariable ['QS_enemy_mortarFireMessage',diag_tickTime,FALSE];
					['sideChat',[WEST,'HQ'],localize 'STR_QS_Chat_007'] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
				}
			];
			(gunner _mortar) addEventHandler [
				'HandleRating',
				{
					params ['_unit','_rating'];
					if ((rating _unit) < 0) then {
						_unit addRating (0 - (rating _unit));
					};
				}
			];
			missionNamespace setVariable ['QS_AI_supportProviders_MTR',((missionNamespace getVariable 'QS_AI_supportProviders_MTR') + [gunner _mortar]),QS_system_AI_owners];
			_grp deleteGroupWhenEmpty TRUE;
			_grp enableDynamicSimulation FALSE;
			_grp setVariable ['QS_dynSim_ignore',TRUE,FALSE];
			_grp addVehicle _mortar;
			_grp setVariable ['QS_AI_GRP',TRUE,FALSE];
			_grp setVariable ['QS_AI_GRP_CONFIG',['SUPPORT','MORTAR',_mortar],FALSE];
			_grp setVariable ['QS_AI_GRP_DATA',[TRUE,serverTime],FALSE];
			_grp setVariable ['QS_AI_GRP_TASK',['SUPPORT','MORTAR',serverTime,-1],FALSE];
			_mortar;
		}], 
		["Land_BagFence_01_round_green_F",[-0.445313,-3.85547,-0.0026021],285.207,[],false,false,TRUE,{}], 
		["Land_BagFence_01_round_green_F",[-1.59424,4.01123,-0.0026021],190.105,[],false,false,TRUE,{}], 
		["Land_BagFence_01_round_green_F",[-3.5166,2.60791,-0.0026021],93.7561,[],false,false,TRUE,{}], 
		["Land_BagFence_01_round_green_F",[4.11084,-1.62354,-0.0026021],285.207,[],false,false,TRUE,{}], 
		["Land_BagFence_01_round_green_F",[-3.7124,-3.05469,-0.0026021],93.7561,[],false,false,TRUE,{}], 
		["Land_BagFence_01_round_green_F",[-2.52783,-4.98682,-0.0026021],14.8742,[],false,false,TRUE,{}], 
		["Land_HBarrier_01_line_5_green_F",[4.88965,-4.34033,0],315.506,[],false,false,TRUE,{}], 
		["Land_HBarrier_01_line_5_green_F",[0.389648,7.02051,0],182.663,[],false,false,TRUE,{}], 
		["Land_HBarrier_01_line_5_green_F",[0.224609,-7.30664,0],341.417,[],false,false,TRUE,{}], 
		["Land_HBarrier_01_line_5_green_F",[-4.62158,5.82764,0],154.725,[],false,false,TRUE,{}], 
		["Land_HBarrier_01_big_4_green_F",[7.14893,-2.6626,0],295.284,[],false,false,TRUE,{}], 
		["Land_HBarrier_01_big_4_green_F",[2.18213,7.67627,0],204.466,[],false,false,TRUE,{}], 
		["Land_HBarrier_01_big_4_green_F",[2.93066,-7.61279,0],332.658,[],false,false,TRUE,{}], 
		["Land_HBarrier_01_line_5_green_F",[-8.00098,1.81592,0],106.998,[],false,false,TRUE,{}], 
		["Land_HBarrier_01_line_5_green_F",[-4.29248,-7.03857,0],17.6912,[],false,false,TRUE,{}], 
		["Land_HBarrier_01_line_5_green_F",[-7.85596,-3.39355,0],65.8922,[],false,false,TRUE,{}], 
		["Land_HBarrier_01_line_5_green_F",[8.31641,-2.51416,0],95.9111,[],false,false,TRUE,{}], 
		["Land_HBarrier_01_big_4_green_F",[-5.2002,7.14795,0],154.693,[],false,false,TRUE,{}], 
		["Land_HBarrier_01_big_4_green_F",[-3.50244,-8.61816,0],16.6592,[],false,false,TRUE,{}], 
		["Land_HBarrier_01_line_5_green_F",[2.23389,9.08545,0],28.0912,[],false,false,TRUE,{}], 
		["Land_HBarrier_01_big_4_green_F",[-9.31348,1.82959,0],107.606,[],false,false,TRUE,{}], 
		["Land_HBarrier_01_line_3_green_F",[7.21094,-6.1792,0],128.997,[],false,false,TRUE,{}], 
		["Land_HBarrier_01_line_5_green_F",[3.97314,-8.66846,0],150.552,[],false,false,TRUE,{}], 
		["Land_HBarrier_01_big_4_green_F",[-8.57959,-4.69824,0],65.5002,[],false,false,TRUE,{}], 
		["Land_HBarrier_01_line_3_green_F",[6.43311,7.3374,0],13.3802,[],false,false,TRUE,{}], 
		["Land_HBarrier_01_big_4_green_F",[7.54834,6.43604,0],342.142,[],false,false,TRUE,{}], 
		["Land_HBarrier_01_line_3_green_F",[0.347168,-10.0596,0],175.616,[],false,false,TRUE,{}], 
		["Land_HBarrier_01_line_5_green_F",[-5.42236,8.50928,0],334.226,[],false,false,TRUE,{}], 
		["Land_HBarrier_01_line_3_green_F",[-1.42822,10.0142,0],346.88,[],false,false,TRUE,{}], 
		["Land_HBarrier_01_line_5_green_F",[-3.82617,-9.47314,0],195.276,[],false,false,TRUE,{}], 
		["Land_HBarrier_01_line_3_green_F",[-8.87109,6.28613,0],312.677,[],false,false,TRUE,{}], 
		["Land_HBarrier_01_line_5_green_F",[-10.7017,2.71973,0],287.641,[],false,false,TRUE,{}], 
		["Land_HBarrier_01_line_3_green_F",[-7.67773,-8.07568,0],210.771,[],false,false,TRUE,{}], 
		["Land_HBarrier_01_line_5_green_F",[-9.93604,-5.08887,0],244.746,[],false,false,TRUE,{}], 
		["Land_HBarrier_01_line_3_green_F",[-11.2925,-1.20898,0],262.422,[],false,false,TRUE,{}], 
		["Land_HBarrier_01_big_4_green_F",[12.085,4.28906,0],71.8171,[],false,false,TRUE,{}]
	]
};
[
	["I_G_Mortar_01_F",[3.13574,1.62061,0.036881],360,[],false,true,false,{
		_mortar = _this # 0;
		_grp = createVehicleCrew _mortar;
		{
			missionNamespace setVariable [
				'QS_HC_AO_enemyArray',
				((missionNamespace getVariable 'QS_HC_AO_enemyArray') + [_x]),
				FALSE
			];
		} forEach [
			_mortar,
			(effectiveCommander _mortar)
		];
		if (worldName in ['Tanoa','Lingor3']) then {
			(effectiveCommander _mortar) setUnitLoadout (selectRandom [
				"I_C_Soldier_Para_1_F","I_C_Soldier_Para_2_F","I_C_Soldier_Para_3_F","I_C_Soldier_Para_4_F","I_C_Soldier_Para_5_F","I_C_Soldier_Para_6_F",
				"I_C_Soldier_Para_7_F","I_C_Soldier_Para_8_F"
			]);
		} else {
			(effectiveCommander _mortar) setUnitLoadout (selectRandom [
				"O_soldierU_A_F","O_soldierU_AAR_F","O_soldierU_AR_F","O_soldierU_medic_F","O_engineer_U_F","O_soldierU_exp_F","O_SoldierU_GL_F",
				"O_Urban_HeavyGunner_F","O_soldierU_M_F","O_soldierU_AT_F","O_soldierU_F","O_soldierU_LAT_F","O_Urban_Sharpshooter_F",
				"O_SoldierU_SL_F","O_soldierU_TL_F","O_G_engineer_F","O_G_medic_F","O_G_Soldier_A_F","O_G_Soldier_AR_F","O_G_Soldier_exp_F","O_G_Soldier_F","O_G_Soldier_F",
				"O_G_Soldier_GL_F","O_G_Soldier_LAT_F","O_G_Soldier_lite_F","O_G_Soldier_M_F","O_G_Soldier_SL_F","O_G_Soldier_TL_F",
				"O_G_Sharpshooter_F","O_G_Soldier_AR_F"
			]);
		};
		_mortar lock 3;
		_mortar enableDynamicSimulation FALSE;
		_mortar setVariable ['QS_dynSim_ignore',TRUE,FALSE];
		_mortar enableWeaponDisassembly FALSE;
		_mortar setVariable ['QS_hidden',TRUE,TRUE];
		_mortar addEventHandler [
			'Killed',
			{
				_mortar = _this # 0;
				if (!isNull (gunner _mortar)) then {
					(gunner _mortar) setDamage 1;
				};
			}
		];
		_mortar addEventHandler [
			'GetOut',
			{
				_mortar = _this # 0;
				_mortar setDamage [1,FALSE];
			}
		];
		(gunner _mortar) addEventHandler [
			'Killed',
			{
				params ['_killed','_killer'];
				(vehicle _killed) setDamage 1;
			}
		];
		(gunner _mortar) call (missionNamespace getVariable 'QS_fnc_unitSetup');
		(gunner _mortar) addEventHandler [
			'FiredMan',
			{
				if ((toLowerANSI (_this # 5)) in ['8rnd_82mm_mo_shells','12rnd_230mm_rockets','32rnd_155mm_mo_shells','4rnd_155mm_mo_guided','2rnd_155mm_mo_lg']) then {
					if ((toLowerANSI (_this # 5)) in ['8rnd_82mm_mo_shells']) then {
						(_this # 6) addEventHandler ['Explode',{(_this + [0]) spawn (missionNamespace getVariable 'QS_fnc_craterEffect')}];
					} else {
						(_this # 6) addEventHandler ['Explode',{(_this + [1]) spawn (missionNamespace getVariable 'QS_fnc_craterEffect')}];
					};
				};
				if (missionNamespace isNil 'QS_enemy_mortarFireMessage') then {
					missionNamespace setVariable ['QS_enemy_mortarFireMessage',diag_tickTime,FALSE];
				};
				if ((missionNamespace getVariable 'QS_enemy_mortarFireMessage') > (diag_tickTime - 300)) exitWith {};
				missionNamespace setVariable ['QS_enemy_mortarFireMessage',diag_tickTime,FALSE];
				['sideChat',[WEST,'HQ'],localize 'STR_QS_Chat_007'] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
			}
		];
		(gunner _mortar) addEventHandler [
			'HandleRating',
			{
				params ['_unit','_rating'];
				if ((rating _unit) < 0) then {
					_unit addRating (0 - (rating _unit));
				};
			}
		];
		missionNamespace setVariable ['QS_AI_supportProviders_MTR',((missionNamespace getVariable 'QS_AI_supportProviders_MTR') + [gunner _mortar]),QS_system_AI_owners];
		_grp deleteGroupWhenEmpty TRUE;
		_grp enableDynamicSimulation FALSE;
		_grp setVariable ['QS_dynSim_ignore',TRUE,FALSE];
		_grp addVehicle _mortar;
		_grp setVariable ['QS_AI_GRP',TRUE,FALSE];
		_grp setVariable ['QS_AI_GRP_CONFIG',['SUPPORT','MORTAR',_mortar],FALSE];
		_grp setVariable ['QS_AI_GRP_DATA',[TRUE,serverTime],FALSE];
		_grp setVariable ['QS_AI_GRP_TASK',['SUPPORT','MORTAR',serverTime,-1],FALSE];
		_mortar;
	}], 
	["I_G_Mortar_01_F",[0.695801,-3.58252,0.0368857],360,[],false,true,false,{
		_mortar = _this # 0;
		_grp = createVehicleCrew _mortar;
		{
			missionNamespace setVariable [
				'QS_HC_AO_enemyArray',
				((missionNamespace getVariable 'QS_HC_AO_enemyArray') + [_x]),
				FALSE
			];
		} forEach [
			_mortar,
			(effectiveCommander _mortar)
		];
		if (worldName in ['Tanoa','Lingor3']) then {
			(effectiveCommander _mortar) setUnitLoadout (selectRandom [
				"I_C_Soldier_Para_1_F","I_C_Soldier_Para_2_F","I_C_Soldier_Para_3_F","I_C_Soldier_Para_4_F","I_C_Soldier_Para_5_F","I_C_Soldier_Para_6_F",
				"I_C_Soldier_Para_7_F","I_C_Soldier_Para_8_F"
			]);
		} else {
			(effectiveCommander _mortar) setUnitLoadout (selectRandom [
				"O_soldierU_A_F","O_soldierU_AAR_F","O_soldierU_AR_F","O_soldierU_medic_F","O_engineer_U_F","O_soldierU_exp_F","O_SoldierU_GL_F",
				"O_Urban_HeavyGunner_F","O_soldierU_M_F","O_soldierU_AT_F","O_soldierU_F","O_soldierU_LAT_F","O_Urban_Sharpshooter_F",
				"O_SoldierU_SL_F","O_soldierU_TL_F","O_G_engineer_F","O_G_medic_F","O_G_Soldier_A_F","O_G_Soldier_AR_F","O_G_Soldier_exp_F","O_G_Soldier_F","O_G_Soldier_F",
				"O_G_Soldier_GL_F","O_G_Soldier_LAT_F","O_G_Soldier_lite_F","O_G_Soldier_M_F","O_G_Soldier_SL_F","O_G_Soldier_TL_F",
				"O_G_Sharpshooter_F","O_G_Soldier_AR_F"
			]);
		};
		_mortar lock 3;
		_mortar enableDynamicSimulation FALSE;
		_mortar setVariable ['QS_dynSim_ignore',TRUE,FALSE];
		_mortar enableWeaponDisassembly FALSE;
		_mortar setVariable ['QS_hidden',TRUE,TRUE];
		_mortar addEventHandler [
			'Killed',
			{
				_mortar = _this # 0;
				if (!isNull (gunner _mortar)) then {
					(gunner _mortar) setDamage 1;
				};
			}
		];
		_mortar addEventHandler [
			'GetOut',
			{
				_mortar = _this # 0;
				_mortar setDamage [1,FALSE];
			}
		];
		(gunner _mortar) addEventHandler [
			'Killed',
			{
				params ['_killed','_killer'];
				(vehicle _killed) setDamage 1;
			}
		];
		(gunner _mortar) call (missionNamespace getVariable 'QS_fnc_unitSetup');
		(gunner _mortar) addEventHandler [
			'FiredMan',
			{
				if ((toLowerANSI (_this # 5)) in ['8rnd_82mm_mo_shells','12rnd_230mm_rockets','32rnd_155mm_mo_shells','4rnd_155mm_mo_guided','2rnd_155mm_mo_lg']) then {
					if ((toLowerANSI (_this # 5)) in ['8rnd_82mm_mo_shells']) then {
						(_this # 6) addEventHandler ['Explode',{(_this + [0]) spawn (missionNamespace getVariable 'QS_fnc_craterEffect')}];
					} else {
						(_this # 6) addEventHandler ['Explode',{(_this + [1]) spawn (missionNamespace getVariable 'QS_fnc_craterEffect')}];
					};
				};
				if (missionNamespace isNil 'QS_enemy_mortarFireMessage') then {
					missionNamespace setVariable ['QS_enemy_mortarFireMessage',diag_tickTime,FALSE];
				};
				if ((missionNamespace getVariable 'QS_enemy_mortarFireMessage') > (diag_tickTime - 300)) exitWith {};
				missionNamespace setVariable ['QS_enemy_mortarFireMessage',diag_tickTime,FALSE];
				['sideChat',[WEST,'HQ'],localize 'STR_QS_Chat_007'] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
			}
		];
		(gunner _mortar) addEventHandler [
			'HandleRating',
			{
				params ['_unit','_rating'];
				if ((rating _unit) < 0) then {
					_unit addRating (0 - (rating _unit));
				};
			}
		];
		missionNamespace setVariable ['QS_AI_supportProviders_MTR',((missionNamespace getVariable 'QS_AI_supportProviders_MTR') + [gunner _mortar]),QS_system_AI_owners];
		_grp deleteGroupWhenEmpty TRUE;
		_grp enableDynamicSimulation FALSE;
		_grp setVariable ['QS_dynSim_ignore',TRUE,FALSE];
		_grp addVehicle _mortar;
		_grp setVariable ['QS_AI_GRP',TRUE,FALSE];
		_grp setVariable ['QS_AI_GRP_CONFIG',['SUPPORT','MORTAR',_mortar],FALSE];
		_grp setVariable ['QS_AI_GRP_DATA',[TRUE,serverTime],FALSE];
		_grp setVariable ['QS_AI_GRP_TASK',['SUPPORT','MORTAR',serverTime,-1],FALSE];
		_mortar;
	}], 
	["I_G_Mortar_01_F",[-3.28564,1.77783,0.0368829],360,[],false,true,false,{
		_mortar = _this # 0;
		_grp = createVehicleCrew _mortar;
		{
			missionNamespace setVariable [
				'QS_HC_AO_enemyArray',
				((missionNamespace getVariable 'QS_HC_AO_enemyArray') + [_x]),
				FALSE
			];
		} forEach [
			_mortar,
			(effectiveCommander _mortar)
		];
		if (worldName in ['Tanoa','Lingor3']) then {
			(effectiveCommander _mortar) setUnitLoadout (selectRandom [
				"I_C_Soldier_Para_1_F","I_C_Soldier_Para_2_F","I_C_Soldier_Para_3_F","I_C_Soldier_Para_4_F","I_C_Soldier_Para_5_F","I_C_Soldier_Para_6_F",
				"I_C_Soldier_Para_7_F","I_C_Soldier_Para_8_F"
			]);
		} else {
			(effectiveCommander _mortar) setUnitLoadout (selectRandom [
				"O_soldierU_A_F","O_soldierU_AAR_F","O_soldierU_AR_F","O_soldierU_medic_F","O_engineer_U_F","O_soldierU_exp_F","O_SoldierU_GL_F",
				"O_Urban_HeavyGunner_F","O_soldierU_M_F","O_soldierU_AT_F","O_soldierU_F","O_soldierU_LAT_F","O_Urban_Sharpshooter_F",
				"O_SoldierU_SL_F","O_soldierU_TL_F","O_G_engineer_F","O_G_medic_F","O_G_Soldier_A_F","O_G_Soldier_AR_F","O_G_Soldier_exp_F","O_G_Soldier_F","O_G_Soldier_F",
				"O_G_Soldier_GL_F","O_G_Soldier_LAT_F","O_G_Soldier_lite_F","O_G_Soldier_M_F","O_G_Soldier_SL_F","O_G_Soldier_TL_F",
				"O_G_Sharpshooter_F","O_G_Soldier_AR_F"
			]);
		};
		_mortar lock 3;
		_mortar enableDynamicSimulation FALSE;
		_mortar setVariable ['QS_dynSim_ignore',TRUE,FALSE];
		_mortar enableWeaponDisassembly FALSE;
		_mortar setVariable ['QS_hidden',TRUE,TRUE];
		_mortar addEventHandler [
			'Killed',
			{
				_mortar = _this # 0;
				if (!isNull (gunner _mortar)) then {
					(gunner _mortar) setDamage 1;
				};
			}
		];
		_mortar addEventHandler [
			'GetOut',
			{
				_mortar = _this # 0;
				_mortar setDamage [1,FALSE];
			}
		];
		(gunner _mortar) addEventHandler [
			'Killed',
			{
				params ['_killed','_killer'];
				(vehicle _killed) setDamage 1;
			}
		];
		(gunner _mortar) call (missionNamespace getVariable 'QS_fnc_unitSetup');
		(gunner _mortar) addEventHandler [
			'FiredMan',
			{
				if ((toLowerANSI (_this # 5)) in ['8rnd_82mm_mo_shells','12rnd_230mm_rockets','32rnd_155mm_mo_shells','4rnd_155mm_mo_guided','2rnd_155mm_mo_lg']) then {
					if ((toLowerANSI (_this # 5)) in ['8rnd_82mm_mo_shells']) then {
						(_this # 6) addEventHandler ['Explode',{(_this + [0]) spawn (missionNamespace getVariable 'QS_fnc_craterEffect')}];
					} else {
						(_this # 6) addEventHandler ['Explode',{(_this + [1]) spawn (missionNamespace getVariable 'QS_fnc_craterEffect')}];
					};
				};
				if (missionNamespace isNil 'QS_enemy_mortarFireMessage') then {
					missionNamespace setVariable ['QS_enemy_mortarFireMessage',diag_tickTime,FALSE];
				};
				if ((missionNamespace getVariable 'QS_enemy_mortarFireMessage') > (diag_tickTime - 300)) exitWith {};
				missionNamespace setVariable ['QS_enemy_mortarFireMessage',diag_tickTime,FALSE];
				['sideChat',[WEST,'HQ'],localize 'STR_QS_Chat_007'] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
			}
		];
		(gunner _mortar) addEventHandler [
			'HandleRating',
			{
				params ['_unit','_rating'];
				if ((rating _unit) < 0) then {
					_unit addRating (0 - (rating _unit));
				};
			}
		];
		missionNamespace setVariable ['QS_AI_supportProviders_MTR',((missionNamespace getVariable 'QS_AI_supportProviders_MTR') + [gunner _mortar]),QS_system_AI_owners];
		_grp deleteGroupWhenEmpty TRUE;
		_grp enableDynamicSimulation FALSE;
		_grp setVariable ['QS_dynSim_ignore',TRUE,FALSE];
		_grp addVehicle _mortar;
		_grp setVariable ['QS_AI_GRP',TRUE,FALSE];
		_grp setVariable ['QS_AI_GRP_CONFIG',['SUPPORT','MORTAR',_mortar],FALSE];
		_grp setVariable ['QS_AI_GRP_DATA',[TRUE,serverTime],FALSE];
		_grp setVariable ['QS_AI_GRP_TASK',['SUPPORT','MORTAR',serverTime,-1],FALSE];
		_mortar;
	}], 
	["Land_BagFence_Round_F",[1.52246,-2.35498,0],221.198,[],false,false,true,{}], 
	["Land_BagFence_Round_F",[-0.530273,-2.83887,0],109.416,[],false,false,true,{}], 
	["Land_BagFence_Round_F",[1.97559,2.3125,0],109.416,[],false,false,true,{}], 
	["Land_BagFence_Round_F",[-3.01025,0.794434,0],350.741,[],false,false,true,{}], 
	["Land_BagFence_Round_F",[3.36084,0.631348,0],350.741,[],false,false,true,{}], 
	["Land_BagFence_Round_F",[-2.34277,2.95947,0],221.198,[],false,false,true,{}], 
	["Land_BagFence_Round_F",[0.85498,-4.52002,0],350.741,[],false,false,true,{}], 
	["Land_BagFence_Round_F",[4.02832,2.79639,0],221.198,[],false,false,true,{}], 
	["Land_BagFence_Round_F",[-4.39551,2.47559,0],109.416,[],false,false,true,{}], 
	["Land_HBarrier_5_F",[-6.64014,-1.69385,0],76.7103,[],false,false,true,{}], 
	["Land_HBarrier_5_F",[-3.80322,-6.1333,0],40.5611,[],false,false,true,{}], 
	["Land_HBarrier_3_F",[3.71826,6.52148,0],214.752,[],false,false,true,{}], 
	["Land_HBarrier_5_F",[6.61816,3.55078,0],232.769,[],false,false,true,{}], 
	["Land_HBarrier_1_F",[-7.35205,1.54688,0],333.341,[],false,false,true,{}], 
	["Land_HBarrier_5_F",[0.95752,-7.73779,0],1.1124,[],false,false,true,{}], 
	["Land_HBarrier_5_F",[-0.0424805,7.81396,0],192.983,[],false,false,true,{}], 
	["Land_HBarrier_5_F",[7.87842,-1.30908,0],271.626,[],false,false,true,{}], 
	["Land_HBarrier_5_F",[5.53076,-6.01514,0],313.739,[],false,false,true,{}], 
	["Land_HBarrier_Big_F",[-8.46289,0.229492,0],90.299,[],false,false,true,{}], 
	["Land_HBarrier_Big_F",[-5.86865,-6.31934,0],48.8287,[],false,false,true,{}], 
	["Land_HBarrier_Big_F",[0.214844,8.80615,0],182.173,[],false,false,true,{}], 
	["Land_HBarrier_Big_F",[6.51758,6.07178,0],230.221,[],false,false,true,{}], 
	["Land_HBarrier_Big_F",[0.36084,-9.2627,0],2.1171,[],false,false,true,{}], 
	["Land_HBarrier_Big_F",[9.30566,-0.566406,0],271.267,[],false,false,true,{}], 
	["Land_HBarrier_Big_F",[6.66406,-6.91455,0],316.879,[],false,false,true,{}], 
	["Land_HBarrier_5_F",[-9.91455,0.293945,0],269.435,[],false,false,true,{}], 
	["Land_HBarrier_5_F",[-6.72266,-7.48779,0],47.4539,[],false,false,true,{}], 
	["Land_HBarrier_3_F",[-9.28125,-4.021,0],247.194,[],false,false,true,{}], 
	["Land_HBarrier_3_F",[4.81787,9.10449,0],14.4074,[],false,false,true,{}], 
	["Land_HBarrier_5_F",[7.91748,6.83301,0],47.4539,[],false,false,true,{}], 
	["Land_HBarrier_3_F",[10.2246,3.46387,0],66.2934,[],false,false,true,{}], 
	["Land_HBarrier_5_F",[10.7993,-0.578613,0],89.9335,[],false,false,true,{}], 
	["Land_HBarrier_5_F",[0.412598,-10.8335,0],179.914,[],false,false,true,{}], 
	["Land_HBarrier_3_F",[-3.61719,-10.2759,0],205.419,[],false,false,true,{}], 
	["Land_HBarrier_5_F",[8.10791,-7.76953,0],135.185,[],false,false,true,{}], 
	["Land_HBarrier_3_F",[4.63623,-10.2441,0],158.593,[],false,false,true,{}], 
	["Land_HBarrier_3_F",[10.396,-4.64355,0],109.741,[],false,false,true,{}], 
	["Land_HBarrier_Big_F",[-10.1948,7.51416,0],62.8607,[],false,false,true,{}], 
	["Land_HBarrier_Big_F",[-8.77148,12.1636,0],152.389,[],false,false,true,{}]
]