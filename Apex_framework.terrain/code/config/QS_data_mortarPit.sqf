/*/
File: QS_data_mortarPit.sqf
Author:

	Quiksilver
	
Last modified:

	15/04/2018 A3 1.82 by Quiksilver
	
Description:

	Mortar pit
	
	_grp enableDynamicSimulation FALSE;
	_grp setVariable ['QS_dynSim_ignore',TRUE,FALSE];
__________________________________________________________________________/*/

if (worldName in ['Tanoa','Lingor3']) exitWith {
	[
		["Land_BagFence_01_round_green_F",[0.84375,-0.822754,-0.0026021],93.7561,[],false,false,TRUE,{}], 
		["Land_BagFence_01_round_green_F",[-0.249023,1.80664,-0.0026021],285.207,[],false,false,TRUE,{}], 
		["Land_BagFence_01_round_green_F",[-2.33203,0.675293,-0.0026021],14.8742,[],false,false,TRUE,{}], 
		["Land_BagFence_01_round_green_F",[-1.79004,-1.65137,-0.0026021],190.105,[],false,false,TRUE,{}], 
		["I_G_Mortar_01_F",[-1.45361,2.0835,-0.0753462],0,[],false,TRUE,false,{
			_mortar = _this select 0;
			createVehicleCrew _mortar;
			missionNamespace setVariable [
				'QS_analytics_entities_created',
				((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
				FALSE
			];
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
					_mortar = _this select 0;
					if (!isNull (gunner _mortar)) then {
						(gunner _mortar) setDamage 1;
					};
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
					if (isNil {missionNamespace getVariable 'QS_enemy_mortarFireMessage'}) then {
						missionNamespace setVariable ['QS_enemy_mortarFireMessage',diag_tickTime,FALSE];
					};
					if ((missionNamespace getVariable 'QS_enemy_mortarFireMessage') > (diag_tickTime - 300)) exitWith {};
					missionNamespace setVariable ['QS_enemy_mortarFireMessage',diag_tickTime,FALSE];
					['sideChat',[WEST,'HQ'],'Enemy mortars are firing!'] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
				}
			];
			(gunner _mortar) addEventHandler [
				'GetOutMan',
				{
					(_this select 0) removeAllEventHandlers 'FiredMan';
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
			(missionNamespace getVariable 'QS_AI_supportProviders_MTR') pushBack (gunner _mortar);
			_grp = group (gunner _mortar);
			_grp deleteGroupWhenEmpty TRUE;
			_grp enableDynamicSimulation FALSE;
			_grp setVariable ['QS_dynSim_ignore',TRUE,FALSE];
			_grp addVehicle _mortar;
			_grp setVariable ['QS_AI_GRP',TRUE,FALSE];
			_grp setVariable ['QS_AI_GRP_CONFIG',['SUPPORT','MORTAR',_mortar],FALSE];
			_grp setVariable ['QS_AI_GRP_DATA',[TRUE,diag_tickTime],FALSE];
			_grp setVariable ['QS_AI_GRP_TASK',['SUPPORT','MORTAR',diag_tickTime,-1],FALSE];
			_mortar;
		}], 
		["Land_BagFence_01_round_green_F",[2.76563,0.580566,-0.0026021],190.105,[],false,false,TRUE,{}], 
		["I_G_Mortar_01_F",[2.96875,-1.1333,-0.0753462],0,[],false,TRUE,false,{
			_mortar = _this select 0;
			createVehicleCrew _mortar;
			missionNamespace setVariable [
				'QS_analytics_entities_created',
				((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
				FALSE
			];
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
					_mortar = _this select 0;
					if (!isNull (gunner _mortar)) then {
						(gunner _mortar) setDamage 1;
					};
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
					if (isNil {missionNamespace getVariable 'QS_enemy_mortarFireMessage'}) then {
						missionNamespace setVariable ['QS_enemy_mortarFireMessage',diag_tickTime,FALSE];
					};
					if ((missionNamespace getVariable 'QS_enemy_mortarFireMessage') > (diag_tickTime - 300)) exitWith {};
					missionNamespace setVariable ['QS_enemy_mortarFireMessage',diag_tickTime,FALSE];
					['sideChat',[WEST,'HQ'],'Enemy mortars are firing!'] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
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
			(missionNamespace getVariable 'QS_AI_supportProviders_MTR') pushBack (gunner _mortar);
			_grp = group (gunner _mortar);
			_grp deleteGroupWhenEmpty TRUE;
			_grp enableDynamicSimulation FALSE;
			_grp setVariable ['QS_dynSim_ignore',TRUE,FALSE];
			_grp addVehicle _mortar;
			_grp setVariable ['QS_AI_GRP',TRUE,FALSE];
			_grp setVariable ['QS_AI_GRP_CONFIG',['SUPPORT','MORTAR',_mortar],FALSE];
			_grp setVariable ['QS_AI_GRP_DATA',[TRUE,diag_tickTime],FALSE];
			_grp setVariable ['QS_AI_GRP_TASK',['SUPPORT','MORTAR',diag_tickTime,-1],FALSE];
			_mortar;
		}], 
		["Land_BagFence_01_round_green_F",[2.02832,-2.75488,-0.0026021],14.8742,[],false,false,TRUE,{}], 
		["I_G_Mortar_01_F",[-1.67529,-3.41846,-0.0753462],0,[],false,TRUE,false,{
			_mortar = _this select 0;
			createVehicleCrew _mortar;
			missionNamespace setVariable [
				'QS_analytics_entities_created',
				((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
				FALSE
			];
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
					_mortar = _this select 0;
					if (!isNull (gunner _mortar)) then {
						(gunner _mortar) setDamage 1;
					};
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
					if (isNil {missionNamespace getVariable 'QS_enemy_mortarFireMessage'}) then {
						missionNamespace setVariable ['QS_enemy_mortarFireMessage',diag_tickTime,FALSE];
					};
					if ((missionNamespace getVariable 'QS_enemy_mortarFireMessage') > (diag_tickTime - 300)) exitWith {};
					missionNamespace setVariable ['QS_enemy_mortarFireMessage',diag_tickTime,FALSE];
					['sideChat',[WEST,'HQ'],'Enemy mortars are firing!'] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
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
			(missionNamespace getVariable 'QS_AI_supportProviders_MTR') pushBack (gunner _mortar);
			_grp = group (gunner _mortar);
			_grp deleteGroupWhenEmpty TRUE;
			_grp enableDynamicSimulation FALSE;
			_grp setVariable ['QS_dynSim_ignore',TRUE,FALSE];
			_grp addVehicle _mortar;
			_grp setVariable ['QS_AI_GRP',TRUE,FALSE];
			_grp setVariable ['QS_AI_GRP_CONFIG',['SUPPORT','MORTAR',_mortar],FALSE];
			_grp setVariable ['QS_AI_GRP_DATA',[TRUE,diag_tickTime],FALSE];
			_grp setVariable ['QS_AI_GRP_TASK',['SUPPORT','MORTAR',diag_tickTime,-1],FALSE];
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
	["Land_BagFence_Round_F",[-1.06055,0.576172,-0.00130081],255.744,[],false,true,true,{}], 
	["Land_BagFence_Round_F",[0.841797,-1.64258,-0.00130081],87.1952,[],false,true,true,{}], 
	["Land_BagFence_Round_F",[2.41992,0.0859375,-0.00130081],176.862,[],false,true,true,{}], 
	["Land_BagFence_Round_F",[-2.39844,-1.35352,-0.00130081],352.093,[],false,true,true,{}], 
	["Land_BagFence_Round_F",[1.24414,2.17773,-0.00130081],352.093,[],false,true,true,{}], 
	["I_G_Mortar_01_F",[-2.78711,-0.201172,-0.0383983],359.995,[],false,true,false,{
		_mortar = _this select 0;
		createVehicleCrew _mortar;
		missionNamespace setVariable [
			'QS_analytics_entities_created',
			((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
			FALSE
		];
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
				_mortar = _this select 0;
				if (!isNull (gunner _mortar)) then {
					(gunner _mortar) setDamage 1;
				};
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
				if (isNil {missionNamespace getVariable 'QS_enemy_mortarFireMessage'}) then {
					missionNamespace setVariable ['QS_enemy_mortarFireMessage',diag_tickTime,FALSE];
				};
				if ((missionNamespace getVariable 'QS_enemy_mortarFireMessage') > (diag_tickTime - 300)) exitWith {};
				missionNamespace setVariable ['QS_enemy_mortarFireMessage',diag_tickTime,FALSE];
				['sideChat',[WEST,'HQ'],'Enemy mortars are firing!'] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
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
		(missionNamespace getVariable 'QS_AI_supportProviders_MTR') pushBack (gunner _mortar);
		_grp = group (gunner _mortar);
		_grp deleteGroupWhenEmpty TRUE;
		_grp enableDynamicSimulation FALSE;
		_grp setVariable ['QS_dynSim_ignore',TRUE,FALSE];
		_grp addVehicle _mortar;
		_grp setVariable ['QS_AI_GRP',TRUE,FALSE];
		_grp setVariable ['QS_AI_GRP_CONFIG',['SUPPORT','MORTAR',_mortar],FALSE];
		_grp setVariable ['QS_AI_GRP_DATA',[TRUE,diag_tickTime],FALSE];
		_grp setVariable ['QS_AI_GRP_TASK',['SUPPORT','MORTAR',diag_tickTime,-1],FALSE];
		_mortar;		
	}], 
	["I_G_Mortar_01_F",[2.55078,-1.90039,-0.0383978],359.994,[],false,true,false,{
		_mortar = _this select 0;
		createVehicleCrew _mortar;
		missionNamespace setVariable [
			'QS_analytics_entities_created',
			((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
			FALSE
		];
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
				_mortar = _this select 0;
				if (!isNull (gunner _mortar)) then {
					(gunner _mortar) setDamage 1;
				};
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
				if (isNil {missionNamespace getVariable 'QS_enemy_mortarFireMessage'}) then {
					missionNamespace setVariable ['QS_enemy_mortarFireMessage',diag_tickTime,FALSE];
				};
				if ((missionNamespace getVariable 'QS_enemy_mortarFireMessage') > (diag_tickTime - 300)) exitWith {};
				missionNamespace setVariable ['QS_enemy_mortarFireMessage',diag_tickTime,FALSE];
				['sideChat',[WEST,'HQ'],'Enemy mortars are firing!'] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
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
		(missionNamespace getVariable 'QS_AI_supportProviders_MTR') pushBack (gunner _mortar);
		_grp = group (gunner _mortar);
		_grp deleteGroupWhenEmpty TRUE;
		_grp enableDynamicSimulation FALSE;
		_grp setVariable ['QS_dynSim_ignore',TRUE,FALSE];
		_grp addVehicle _mortar;
		_grp setVariable ['QS_AI_GRP',TRUE,FALSE];
		_grp setVariable ['QS_AI_GRP_CONFIG',['SUPPORT','MORTAR',_mortar],FALSE];
		_grp setVariable ['QS_AI_GRP_DATA',[TRUE,diag_tickTime],FALSE];
		_grp setVariable ['QS_AI_GRP_TASK',['SUPPORT','MORTAR',diag_tickTime,-1],FALSE];
		_mortar;
	}], 
	["Land_BagFence_Round_F",[-2.78711,2,-0.00130081],176.862,[],false,true,true,{}], 
	["I_G_Mortar_01_F",[0.886719,3.65039,-0.0383978],359.995,[],false,true,false,{
		_mortar = _this select 0;
		createVehicleCrew _mortar;
		missionNamespace setVariable [
			'QS_analytics_entities_created',
			((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
			FALSE
		];
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
				_mortar = _this select 0;
				if (!isNull (gunner _mortar)) then {
					(gunner _mortar) setDamage 1;
				};
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
				if (isNil {missionNamespace getVariable 'QS_enemy_mortarFireMessage'}) then {
					missionNamespace setVariable ['QS_enemy_mortarFireMessage',diag_tickTime,FALSE];
				};
				if ((missionNamespace getVariable 'QS_enemy_mortarFireMessage') > (diag_tickTime - 300)) exitWith {};
				missionNamespace setVariable ['QS_enemy_mortarFireMessage',diag_tickTime,FALSE];
				['sideChat',[WEST,'HQ'],'Enemy mortars are firing!'] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
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
		(missionNamespace getVariable 'QS_AI_supportProviders_MTR') pushBack (gunner _mortar);
		_grp = group (gunner _mortar);
		_grp deleteGroupWhenEmpty TRUE;
		_grp enableDynamicSimulation FALSE;
		_grp setVariable ['QS_dynSim_ignore',TRUE,FALSE];
		_grp addVehicle _mortar;
		_grp setVariable ['QS_AI_GRP',TRUE,FALSE];
		_grp setVariable ['QS_AI_GRP_CONFIG',['SUPPORT','MORTAR',_mortar],FALSE];
		_grp setVariable ['QS_AI_GRP_DATA',[TRUE,diag_tickTime],FALSE];
		_grp setVariable ['QS_AI_GRP_TASK',['SUPPORT','MORTAR',diag_tickTime,-1],FALSE];
		_mortar;
	}], 
	["Land_BagFence_Round_F",[-0.722656,3.80273,-0.00130081],87.1952,[],false,true,true,{}], 
	["Land_BagFence_Round_F",[-4.36523,0.271484,-0.00130081],87.1952,[],false,true,true,{}], 
	["Land_BagFence_Round_F",[2.80859,-3.26758,-0.00130081],352.093,[],false,true,true,{}], 
	["Land_BagFence_Round_F",[4.14648,-1.33789,-0.00130081],255.744,[],false,true,true,{}], 
	["Land_BagFence_Round_F",[2.58203,4.10742,-0.00130081],255.744,[],false,true,true,{}], 
	["Land_BagFence_Round_F",[0.855469,5.53125,-0.00130081],176.862,[],false,true,true,{}], 
	['Land_HBarrier_5_F',[-2.10742,7,0],135.745,[],false,true,true,{}], 
	['Land_HBarrier_5_F',[-5.82422,3.04102,0],109.089,[],false,true,true,{}], 
	['Land_HBarrier_5_F',[-0.783203,-7.00195,0],350.031,[],false,true,true,{}], 
	['Land_HBarrier_5_F',[4.51563,-5.57227,0],305.326,[],false,true,true,{}], 
	['Land_HBarrier_5_F',[7.35938,-1.03906,0],268.986,[],false,true,true,{}], 
	['Land_HBarrier_5_F',[3,7.45898,0],179.679,[],false,true,true,{}], 
	['Land_HBarrier_Big_F',[-7.66602,0.396484,0],97.2722,[],false,true,true,{}], 
	['Land_HBarrier_5_F',[6.77734,3.96289,0],227.88,[],false,true,true,{}], 
	['Land_HBarrier_Big_F',[0.144531,-7.93555,0],6.45383,[],false,true,true,{}], 
	['Land_HBarrier_Big_F',[-5.14844,6.37109,0],134.646,[],false,true,true,{}], 
	['Land_HBarrier_Big_F',[7,-5.21875,0],316.681,[],false,true,true,{}], 
	['Land_HBarrier_5_F',[-8.44531,-1.76953,0],257.899,[],false,true,true,{}], 
	['Land_HBarrier_Big_F',[0.662109,9.25586,0],178.647,[],false,true,true,{}], 
	['Land_HBarrier_Big_F',[9.31445,1.06641,0],269.594,[],false,true,true,{}], 
	['Land_HBarrier_5_F',[0.912109,-9.77344,0],190.079,[],false,true,true,{}], 
	['Land_HBarrier_Big_F',[6.65625,7.04883,0],227.488,[],false,true,true,{}], 
	['Land_HBarrier_5_F',[-7.70508,5.94922,0],312.54,[],false,true,true,{}], 
	['Land_HBarrier_5_F',[-9.28125,3.32813,0],290.985,[],false,true,true,{}], 
	['Land_HBarrier_Big_F',[-5.19141,-8.42969,0],144.13,[],false,true,true,{}], 
	['Land_HBarrier_5_F',[4.26953,-9.82227,0],175.368,[],false,true,true,{}], 
	['Land_HBarrier_5_F',[9.64258,-5.16797,0],136.214,[],false,true,true,{}], 
	['Land_HBarrier_5_F',[6.49609,-8.5625,0],148.868,[],false,true,true,{}], 
	['Land_HBarrier_5_F',[-4.26953,9.83594,0],337.604,[],false,true,true,{}], 
	['Land_HBarrier_5_F',[-1.36523,10.9102,0],0.528867,[],false,true,true,{}], 
	['Land_HBarrier_5_F',[10.9766,3.2793,0],89.6286,[],false,true,true,{}], 
	['Land_HBarrier_5_F',[11.125,-2.12695,0],113.757,[],false,true,true,{}], 
	['Land_HBarrier_5_F',[9.89453,5.88086,0],64.4096,[],false,true,true,{}], 
	['Land_HBarrier_5_F',[6.60352,9.73242,0],46.734,[],false,true,true,{}], 
	['Land_HBarrier_5_F',[3.86914,11.1094,0],21.9666,[],false,true,true,{}], 
	['Land_HBarrier_Big_F',[-10.2246,-7.89063,0],233.805,[],false,true,true,{}]
]