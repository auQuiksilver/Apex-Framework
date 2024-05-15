/*/
File: QS_data_artyPit.sqf
Author:

	Quiksilver
	
Last modified:

	29/03/2018 A3 1.82 by Quiksilver
	
Description:

	Mortar pit
	
To Do:

	Altis/Desert/Sand variant
__________________________________________________________________________/*/

[
	["Land_HBarrier_01_line_5_green_F",[-1.49414,0.0917969,0],263.593,[],false,false,true,{}], 
	["Land_HBarrier_01_line_5_green_F",[1.89648,2.74902,0],350.306,[],false,false,true,{}], 
	["Land_Mil_WallBig_4m_F",[-1.77539,2.94482,-0.0119424],352.223,[],false,false,true,{}], 
	["Land_HBarrier_01_line_5_green_F",[-0.868652,-5.18457,0],263.593,[],false,false,true,{}], 
	["Land_HBarrier_01_line_5_green_F",[-5.30859,1.56592,0],350.306,[],false,false,true,{}], 
	["Box_East_AmmoVeh_F",[-2.50635,-5.50049,0.0295422],359.057,[],false,false,true,{}], 
	["Land_Mil_WallBig_4m_F",[-4.67969,7.45361,-0.0119424],83.2767,[],false,false,true,{}], 
	["Box_East_AmmoVeh_F",[9.58203,0.190918,0.0295417],359.999,[],false,false,true,{}],
	["Land_Mil_WallBig_4m_F",[2.10645,9.00781,-0.0119424],352.602,[],false,false,true,{}], 
	["Land_HBarrier_01_wall_6_green_F",[-9.1084,6.604,0],354.161,[],false,false,true,{}], 
	["Land_HBarrier_01_wall_6_green_F",[7.2915,8.27441,0],11.9168,[],false,false,true,{}], 
	["Land_HBarrier_01_wall_6_green_F",[11.8818,3.45068,0],83.6629,[],false,false,true,{}], 
	["Box_East_AmmoVeh_F",[8.65479,-7.12402,0.0545402],233.689,[],false,false,true,{}], 
	["Land_HBarrier_01_wall_6_green_F",[3.47705,-13.001,0],172.753,[],false,false,true,{}], 
	["Land_HBarrier_01_wall_6_green_F",[-13.3662,2.21436,0],294.289,[],false,false,true,{}], 
	["Box_East_AmmoVeh_F",[-5.37256,-11.3833,0.039788],215.424,[],false,false,true,{}], 
	["Land_HBarrier_01_wall_6_green_F",[12.9658,-4.7666,0],83.6629,[],false,false,true,{}], 
	["Land_HBarrier_01_wall_6_green_F",[10.3228,-10.6523,0],150.431,[],false,false,true,{}], 
	["Land_HBarrier_01_wall_6_green_F",[-4.65039,-14.1714,0],178.418,[],false,false,true,{}], 
	["Land_HBarrier_01_wall_6_green_F",[-14.3359,-5.28174,0],265.262,[],false,false,true,{}], 
	["Land_HBarrier_01_wall_6_green_F",[-11.6533,-12.0586,0],234.447,[],false,false,true,{}], 
	["O_MBT_02_arty_F",[4.01807,-1.67236,-0.0691381],353.719,[],true,true,false,{
		_arty = _this # 0;
		(missionNamespace getVariable 'QS_sideMission_enemyArray') pushBack _arty;
		_arty setVariable ['QS_hidden',TRUE,TRUE];
		_arty addEventHandler [
			'HandleDamage',
			{
				params ['_vehicle','','_damage','','','_hitPartIndex','',''];
				_vehicle setHit ['hit_main_turret_point',0];
				_vehicle setHit ['hit_main_gun_point',0];
				_oldDamage = if (_hitPartIndex isEqualTo -1) then {(damage _vehicle)} else {(_vehicle getHitIndex _hitPartIndex)};
				_damage = _oldDamage + (_damage - _oldDamage) * 0.35;
				_damage;
			}
		];
		_arty enableDynamicSimulation FALSE;
		_arty setVariable ['QS_dynSim_ignore',TRUE,TRUE];
		_arty addEventHandler ['GetOut',{(_this # 2) setDamage [1,TRUE];}];
		_arty addEventHandler ['Deleted',{
			deleteVehicleCrew (_this # 0);
		}];
		_group1 = createVehicleCrew _arty;
		_group1 deleteGroupWhenEmpty TRUE;
		_group1 enableDynamicSimulation FALSE;
		_arty setVehicleReceiveRemoteTargets TRUE;
		_group1 setVariable ['QS_dynSim_ignore',TRUE,FALSE];
		_arty deleteVehicleCrew (driver _arty);
		_group1 selectLeader (gunner _arty);
		[(units _group1),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
		_group1 setBehaviour 'COMBAT';
		_group1 setCombatMode 'RED';
		_group1 allowFleeing 0;
		missionNamespace setVariable ['QS_AI_supportProviders_ARTY',((missionNamespace getVariable 'QS_AI_supportProviders_ARTY') + [gunner _arty]),QS_system_AI_owners];
		_group1 setVariable ['QS_AI_GRP',TRUE,FALSE];
		_group1 setVariable ['QS_AI_GRP_CONFIG',['SUPPORT','ARTILLERY',_arty],FALSE];
		_group1 setVariable ['QS_AI_GRP_DATA',[TRUE,serverTime],FALSE];
		_group1 setVariable ['QS_AI_GRP_TASK',['SUPPORT','ARTILLERY',serverTime,-1],FALSE];
		_arty lock 2;
		_group1 addVehicle _arty;
		(gunner _arty) addEventHandler [
			'FiredMan',
			{
				if (!isNull (_this # 6)) then {
					if ((toLowerANSI (_this # 5)) in ['8rnd_82mm_mo_shells','12rnd_230mm_rockets','32rnd_155mm_mo_shells','4rnd_155mm_mo_guided','2rnd_155mm_mo_lg','magazine_shipcannon_120mm_he_shells_x32','magazine_shipcannon_120mm_he_guided_shells_x2','magazine_shipcannon_120mm_he_lg_shells_x2','magazine_missiles_cruise_01_x18']) then {
						if ((toLowerANSI (_this # 5)) in ['8rnd_82mm_mo_shells']) then {
							(_this # 6) addEventHandler ['Explode',{(_this + [0]) spawn (missionNamespace getVariable 'QS_fnc_craterEffect')}];
						} else {
							(_this # 6) addEventHandler ['Explode',{(_this + [1]) spawn (missionNamespace getVariable 'QS_fnc_craterEffect')}];
						};
					};
				};
				if (missionNamespace isNil 'QS_enemy_artyFireMessage') then {
					missionNamespace setVariable ['QS_enemy_artyFireMessage',diag_tickTime,FALSE];
				};
				if ((missionNamespace getVariable 'QS_enemy_artyFireMessage') > (diag_tickTime - 300)) exitWith {};
				missionNamespace setVariable ['QS_enemy_artyFireMessage',diag_tickTime,FALSE];
				_firingMessages = [
					localize 'STR_QS_Chat_001',
					localize 'STR_QS_Chat_002',
					localize 'STR_QS_Chat_003',
					localize 'STR_QS_Chat_004',
					localize 'STR_QS_Chat_005',
					localize 'STR_QS_Chat_006'
				];
				['sideChat',[WEST,'HQ'],(selectRandom _firingMessages)] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
			}
		];
		{
			(missionNamespace getVariable 'QS_sideMission_enemyArray') pushBack _x;
		} forEach (units _group1);
		{
			_x setVariable ['QS_dynSim_ignore',TRUE,FALSE];
			_x enableSimulation TRUE;
			_x enableDynamicSimulation FALSE;
		} forEach (crew _arty);
		_arty;
	}], 
	["O_MBT_02_arty_F",[-6.7666,-2.89453,-0.0691385],353.719,[],true,true,false,{
		_arty = _this # 0;
		(missionNamespace getVariable 'QS_sideMission_enemyArray') pushBack _arty;
		_arty setVariable ['QS_hidden',TRUE,TRUE];
		_arty addEventHandler [
			'HandleDamage',
			{
				params ['_vehicle','','_damage','','','_hitPartIndex','',''];
				_oldDamage = if (_hitPartIndex isEqualTo -1) then {(damage _vehicle)} else {(_vehicle getHitIndex _hitPartIndex)};
				_damage = _oldDamage + (_damage - _oldDamage) * 0.5;
				_damage;
			}
		];
		_arty enableDynamicSimulation FALSE;
		_arty setVariable ['QS_dynSim_ignore',TRUE,FALSE];
		_arty addEventHandler ['GetOut',{(_this # 2) setDamage [1,TRUE];}];
		_arty addEventHandler ['Deleted',{
			deleteVehicleCrew (_this # 0);
		}];
		_group1 = createVehicleCrew _arty;
		_group1 deleteGroupWhenEmpty TRUE;
		_group1 enableDynamicSimulation FALSE;
		_group1 setVariable ['QS_dynSim_ignore',TRUE,FALSE];
		_arty deleteVehicleCrew (driver _arty);
		_group1 selectLeader (gunner _arty);
		[(units _group1),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
		_group1 setBehaviour 'COMBAT';
		_group1 setCombatMode 'RED';
		_group1 allowFleeing 0;
		missionNamespace setVariable ['QS_AI_supportProviders_ARTY',((missionNamespace getVariable 'QS_AI_supportProviders_ARTY') + [gunner _arty]),QS_system_AI_owners];
		_group1 setVariable ['QS_AI_GRP',TRUE,FALSE];
		_group1 setVariable ['QS_AI_GRP_CONFIG',['SUPPORT','ARTILLERY',_arty],FALSE];
		_group1 setVariable ['QS_AI_GRP_DATA',[TRUE,serverTime],FALSE];
		_group1 setVariable ['QS_AI_GRP_TASK',['SUPPORT','ARTILLERY',serverTime,-1],FALSE];
		_arty lock 2;
		_group1 addVehicle _arty;
		(gunner _arty) addEventHandler [
			'FiredMan',
			{
				if (!isNull (_this # 6)) then {
					if ((toLowerANSI (_this # 5)) in ['8rnd_82mm_mo_shells','12rnd_230mm_rockets','32rnd_155mm_mo_shells','4rnd_155mm_mo_guided','2rnd_155mm_mo_lg','magazine_shipcannon_120mm_he_shells_x32','magazine_shipcannon_120mm_he_guided_shells_x2','magazine_shipcannon_120mm_he_lg_shells_x2','magazine_missiles_cruise_01_x18']) then {
						if ((toLowerANSI (_this # 5)) in ['8rnd_82mm_mo_shells']) then {
							(_this # 6) addEventHandler ['Explode',{(_this + [0]) spawn (missionNamespace getVariable 'QS_fnc_craterEffect')}];
						} else {
							(_this # 6) addEventHandler ['Explode',{(_this + [1]) spawn (missionNamespace getVariable 'QS_fnc_craterEffect')}];
						};
					};
				};
				if (missionNamespace isNil 'QS_enemy_artyFireMessage') then {
					missionNamespace setVariable ['QS_enemy_artyFireMessage',diag_tickTime,FALSE];
				};
				if ((missionNamespace getVariable 'QS_enemy_artyFireMessage') > (diag_tickTime - 300)) exitWith {};
				missionNamespace setVariable ['QS_enemy_artyFireMessage',diag_tickTime,FALSE];
				_firingMessages = [
					localize 'STR_QS_Chat_001',
					localize 'STR_QS_Chat_002',
					localize 'STR_QS_Chat_003',
					localize 'STR_QS_Chat_004',
					localize 'STR_QS_Chat_005',
					localize 'STR_QS_Chat_006'
				];
				['sideChat',[WEST,'HQ'],(selectRandom _firingMessages)] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
			}
		];
		{
			(missionNamespace getVariable 'QS_sideMission_enemyArray') pushBack _x;
		} forEach (units _group1);
		{
			_x setVariable ['QS_dynSim_ignore',TRUE,FALSE];
			_x enableSimulation TRUE;
			_x enableDynamicSimulation FALSE;
		} forEach (crew _arty);
		_arty;
	}]
]