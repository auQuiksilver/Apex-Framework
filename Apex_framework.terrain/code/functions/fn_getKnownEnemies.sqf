/*/
File: fn_getKnownEnemies.sqf
Author:

	Quiksilver
	
Last modified:

	7/04/2018 A3 1.82 by Quiksilver
	
Description:

	Get Known Enemies
__________________________________________________/*/

_type = param [0];
if (_type isEqualTo 0) exitWith {
	params ['','_QS_ST_X','_fn_is','_fn_jammer','_gpsJammers'];
	private _array = [];
	if (missionNamespace getVariable ['QS_client_showKnownEnemies',TRUE]) then {
		_player = player;
		if ((lifeState _player) in ['HEALTHY','INJURED']) then {
			_hiddenTypes = [
				'b_ctrg_soldier_ar_tna_f','b_ctrg_soldier_exp_tna_f','b_ctrg_soldier_jtac_tna_f','b_ctrg_soldier_m_tna_f','b_ctrg_soldier_medic_tna_f','b_ctrg_soldier_lat2_tna_f',
				'b_ctrg_soldier_tna_f','b_ctrg_soldier_lat_tna_f','b_ctrg_soldier_tl_tna_f','b_ctrg_miller_f','b_diver_f','b_diver_exp_f','b_diver_tl_f','b_recon_exp_f','b_recon_jtac_f','b_recon_m_f',
				'b_recon_medic_f','b_recon_f','b_recon_lat_f','b_recon_sharpshooter_f','b_recon_tl_f','b_sniper_f','b_ghillie_ard_f','b_ghillie_lsh_f','b_ghillie_sard_f','b_spotter_f','b_t_diver_f',
				'b_t_diver_exp_f','b_t_diver_tl_f','b_t_recon_exp_f','b_t_recon_jtac_f','b_t_recon_m_f','b_t_recon_medic_f','b_t_recon_f','b_t_recon_lat_f','b_t_recon_tl_f','b_t_sniper_f',
				'b_t_ghillie_tna_f','b_t_spotter_f','i_diver_f','i_diver_exp_f','i_diver_tl_f','i_sniper_f','i_ghillie_ard_f','i_ghillie_lsh_f','i_ghillie_sard_f','i_spotter_f',
				'o_v_soldier_exp_hex_f','o_v_soldier_jtac_hex_f','o_v_soldier_m_hex_f','o_v_soldier_hex_f','o_v_soldier_medic_hex_f','o_v_soldier_lat_hex_f',
				'o_v_soldier_tl_hex_f','o_v_soldier_exp_ghex_f','o_v_soldier_jtac_ghex_f','o_v_soldier_m_ghex_f','o_v_soldier_ghex_f','o_v_soldier_medic_ghex_f',
				'o_v_soldier_lat_ghex_f','o_v_soldier_tl_ghex_f','o_recon_exp_f','o_recon_jtac_f','o_recon_m_f','o_recon_medic_f','o_pathfinder_f','o_recon_f',
				'o_recon_lat_f','o_recon_tl_f','o_sniper_f','o_ghillie_ard_f','o_ghillie_lsh_f','o_ghillie_sard_f','o_spotter_f','o_t_recon_exp_f','o_t_recon_jtac_f',
				'o_t_recon_m_f','o_t_recon_medic_f','o_t_recon_f','o_t_recon_lat_f','o_t_recon_tl_f','o_t_sniper_f','o_t_ghillie_tna_f','o_t_spotter_f',
				'o_plane_fighter_02_stealth_f','o_diver_f','o_diver_exp_f','o_diver_tl_f','o_t_diver_f','o_t_diver_exp_f','o_t_diver_tl_f','o_uav_01_f','o_t_uav_04_cas_f',
				'o_uav_02_dynamicloadout_f','o_uav_02_cas_f','i_uav_02_dynamicloadout_f','i_uav_02_cas_f','b_plane_fighter_01_stealth_f','b_uav_05_f','b_t_uav_03_dynamicloadout_f',
				'o_r_soldier_ar_f','o_r_medic_f','o_r_soldier_exp_f','o_r_soldier_gl_f','o_r_jtac_f','o_r_soldier_m_f','o_r_soldier_lat_f','o_r_soldier_tl_f',
				'o_r_recon_ar_f','o_r_recon_exp_f','o_r_recon_gl_f','o_r_recon_jtac_f','o_r_recon_m_f','o_r_recon_medic_f','o_r_recon_lat_f','o_r_recon_tl_f'
			];
			private _target = objNull;
			private _targetType = '';
			_sideColors = [[0.5,0,0,0.65],[0,0.3,0.6,0.65],[0,0.5,0,0.65],[0.4,0,0.5,0.65],[0.7,0.6,0,0.5]];
			_sides = [EAST,WEST,RESISTANCE,CIVILIAN,SIDEUNKNOWN];
			private _is = 22;
			private _icon = 'a3\ui_f\data\igui\RscCustomInfo\Sensors\Targets\EnemyMan_ca.paa';
			private _color = [0.5,0,0,0.65];
			_showStealth = missionNamespace getVariable ['QS_client_showStealthEnemies',FALSE];
			_remoteTargets = [(listRemoteTargets (player getVariable ['QS_unit_side',WEST])),0] call (missionNamespace getVariable 'QS_fnc_listRemoteTargets');
			private _isRemoteTarget = FALSE;
			private _dir = 0;
			_time = time;
			{
				if (_x isEqualType objNull) then {
					if (alive _x) then {
						if (simulationEnabled _x) then {
							_target = _x;
							if (_target isKindOf 'CAManBase') then {
								if (!(_target getVariable ['QS_hidden',FALSE])) then {
									(_player targetKnowledge _target) params [
										'_knownByGroup',
										'',
										'',
										'',
										'_targetSide',
										'',
										'_targetPosition'
									];
									_targetType = toLower (typeOf _target);
									if ((!(_targetType in _hiddenTypes)) || {(_showStealth)}) then {
										if (_knownByGroup) then {
											_color = _sideColors select (_sides find _targetSide);
											_color set [3,(0 max (((group _player) knowsAbout _target) / 4) min 4)];
											_is = [_target,1,_QS_ST_X] call _fn_is;
											if ((_gpsJammers isEqualTo []) || {((!(_gpsJammers isEqualTo [])) && {(!([0,_targetPosition] call _fn_jammer))})}) then {
												_array pushBack ['a3\ui_f\data\igui\RscCustomInfo\Sensors\Targets\EnemyMan_ca.paa',_color,_targetPosition,_is,_is,0,'',0,0,'RobotoCondensed','right'];
											};
										};
									};
								};
							} else {
								if (!((crew _target) isEqualTo [])) then {
									_isRemoteTarget = _target in _remoteTargets;
									if ((!(_target getVariable ['QS_hidden',FALSE])) || {(_isRemoteTarget)}) then {
										(_player targetKnowledge _target) params [
											'_knownByGroup',
											'',
											'',
											'',
											'_targetSide',
											'',
											'_targetPosition'
										];
										_targetType = toLower (typeOf _target);
										if ((!(_targetType in _hiddenTypes)) || {(_showStealth)} || {(_isRemoteTarget)}) then {
											if ((_knownByGroup) || {(_isRemoteTarget)}) then {
												if (!(underwater _target)) then {
													if (_isRemoteTarget) then {
														_color = _sideColors select (_sides find (side _target));
														_icon = missionNamespace getVariable [(format ['QS_ST_iconType#%1',_targetType]),''];
														if (_icon isEqualTo '') then {
															_icon = getText (configFile >> 'CfgVehicles' >> _targetType >> 'icon');
															missionNamespace setVariable [(format ['QS_ST_iconType#%1',_targetType]),_icon];
														};
														_color set [3,1];
														_dir = getDirVisual _target;
														_targetPosition = getPosWorldVisual _target;
													} else {
														_color = _sideColors select (_sides find _targetSide);
														_icon = [
															'a3\ui_f\data\igui\RscCustomInfo\Sensors\Targets\EnemyGround_ca.paa',
															'a3\ui_f\data\igui\RscCustomInfo\Sensors\Targets\EnemyAir_ca.paa'
														] select (_target isKindOf 'Air');
														_color set [3,(0 max (((group _player) knowsAbout _target) / 4) min 4)];
														_dir = 0;
													};
													_is = [_target,1,_QS_ST_X] call _fn_is;
													if ((_gpsJammers isEqualTo []) || {((!(_gpsJammers isEqualTo [])) && {(!([0,_targetPosition] call _fn_jammer))})}) then {
														_array pushBack [_icon,_color,_targetPosition,_is,_is,_dir,'',0,0,'RobotoCondensed','right'];
													};
												};
											};
										};
									};
								};
							};
						};
					};
				};
			} forEach ((_player targets [TRUE,([250,450] select (_player getUnitTrait 'QS_trait_leader'))]) + _remoteTargets);
		};
	};
	_array;
};
if (_type isEqualTo 1) exitWith {
	params ['','_QS_ST_X','_fn_is'];
	private _array = [];
	_hiddenTypes = [
		'b_ctrg_soldier_ar_tna_f','b_ctrg_soldier_exp_tna_f','b_ctrg_soldier_jtac_tna_f','b_ctrg_soldier_m_tna_f','b_ctrg_soldier_medic_tna_f','b_ctrg_soldier_lat2_tna_f',
		'b_ctrg_soldier_tna_f','b_ctrg_soldier_lat_tna_f','b_ctrg_soldier_tl_tna_f','b_ctrg_miller_f','b_diver_f','b_diver_exp_f','b_diver_tl_f','b_recon_exp_f','b_recon_jtac_f','b_recon_m_f',
		'b_recon_medic_f','b_recon_f','b_recon_lat_f','b_recon_sharpshooter_f','b_recon_tl_f','b_sniper_f','b_ghillie_ard_f','b_ghillie_lsh_f','b_ghillie_sard_f','b_spotter_f','b_t_diver_f',
		'b_t_diver_exp_f','b_t_diver_tl_f','b_t_recon_exp_f','b_t_recon_jtac_f','b_t_recon_m_f','b_t_recon_medic_f','b_t_recon_f','b_t_recon_lat_f','b_t_recon_tl_f','b_t_sniper_f',
		'b_t_ghillie_tna_f','b_t_spotter_f','i_diver_f','i_diver_exp_f','i_diver_tl_f','i_sniper_f','i_ghillie_ard_f','i_ghillie_lsh_f','i_ghillie_sard_f','i_spotter_f',
		'o_v_soldier_exp_hex_f','o_v_soldier_jtac_hex_f','o_v_soldier_m_hex_f','o_v_soldier_hex_f','o_v_soldier_medic_hex_f','o_v_soldier_lat_hex_f',
		'o_v_soldier_tl_hex_f','o_v_soldier_exp_ghex_f','o_v_soldier_jtac_ghex_f','o_v_soldier_m_ghex_f','o_v_soldier_ghex_f','o_v_soldier_medic_ghex_f',
		'o_v_soldier_lat_ghex_f','o_v_soldier_tl_ghex_f','o_recon_exp_f','o_recon_jtac_f','o_recon_m_f','o_recon_medic_f','o_pathfinder_f','o_recon_f',
		'o_recon_lat_f','o_recon_tl_f','o_sniper_f','o_ghillie_ard_f','o_ghillie_lsh_f','o_ghillie_sard_f','o_spotter_f','o_t_recon_exp_f','o_t_recon_jtac_f',
		'o_t_recon_m_f','o_t_recon_medic_f','o_t_recon_f','o_t_recon_lat_f','o_t_recon_tl_f','o_t_sniper_f','o_t_ghillie_tna_f','o_t_spotter_f',
		'o_plane_fighter_02_stealth_f','o_diver_f','o_diver_exp_f','o_diver_tl_f','o_t_diver_f','o_t_diver_exp_f','o_t_diver_tl_f','o_uav_01_f','o_t_uav_04_cas_f',
		'o_uav_02_dynamicloadout_f','o_uav_02_cas_f','i_uav_02_dynamicloadout_f','i_uav_02_cas_f','b_plane_fighter_01_stealth_f','b_uav_05_f','b_t_uav_03_dynamicloadout_f',
		'o_r_soldier_ar_f','o_r_medic_f','o_r_soldier_exp_f','o_r_soldier_gl_f','o_r_jtac_f','o_r_soldier_m_f','o_r_soldier_lat_f','o_r_soldier_tl_f',
		'o_r_recon_ar_f','o_r_recon_exp_f','o_r_recon_gl_f','o_r_recon_jtac_f','o_r_recon_m_f','o_r_recon_medic_f','o_r_recon_lat_f','o_r_recon_tl_f'
	];
	_player = player;
	_playerSide = _player getVariable ['QS_unit_side',WEST];
	_enemySides = [_playerSide] call (missionNamespace getVariable 'QS_fnc_enemySides');
	private _target = objNull;
	private _targetType = '';
	private _is = 22;
	_sideColors = [[0.5,0,0,0.65],[0,0.3,0.6,0.65],[0,0.5,0,0.65],[0.4,0,0.5,0.65],[0.7,0.6,0,0.5]];
	_sides = [EAST,WEST,RESISTANCE,CIVILIAN,SIDEUNKNOWN];
	private _color = [0.5,0,0,0.65];
	_showStealth = missionNamespace getVariable ['QS_client_showStealthEnemies',FALSE];
	_remoteTargets = [(listRemoteTargets _playerSide),0] call (missionNamespace getVariable 'QS_fnc_listRemoteTargets');
	private _targetSide = EAST;
	private _unit = objNull;
	private _icon = '';
	_allPlayers = (allUnits select {((side (group _x)) isEqualTo WEST)}) call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
	private _targetPosition = [0,0,0];
	private _targetKnowledge = [];
	if (((_player distance2D (markerPos 'QS_marker_base_marker')) < 500) || {((_player distance2D (markerPos 'QS_marker_module_fob')) < 150)} || {((!((listVehicleSensors (vehicle _player)) isEqualTo [])) && (!( ((listVehicleSensors (vehicle _player)) findIf {((toLower (_x select 0)) isEqualTo 'activeradarsensorcomponent')}) isEqualTo -1)) && (isVehicleRadarOn (vehicle _player)))}) then {
		{
			if (alive _x) then {
				if ((side (group _x)) in _enemySides) then {
					_unit = _x;
					_target = vehicle _unit;
					if (((_playerSide knowsAbout _target) > 0) || {(_target in _remoteTargets)}) then {
						if (alive _target) then {
							if (simulationEnabled _target) then {
								if (!(_target getVariable ['QS_hidden',FALSE])) then {
									_targetSide = side (group _unit);
									_targetType = toLower (typeOf _target);
									_isRemoteTarget = _target in _remoteTargets;
									if ((!(_targetType in _hiddenTypes)) || {(_showStealth)} || {(_isRemoteTarget)}) then {
										if (!(underwater _target)) then {
											if (_target isKindOf 'CAManBase') then {
												_color = _sideColors select (_sides find _targetSide);
												_color set [3,(0 max ((_playerSide knowsAbout _target) / 4) min 4)];
												_targetPosition = (_player targetKnowledge _target) select 6;
												if (_targetPosition isEqualTo [0,0,0]) then {
													{
														if ((!(((_x targetKnowledge _target) select 6) isEqualTo [0,0,0])) && (((_x targetKnowledge _target) select 5) < 100)) exitWith {
															_targetPosition = (_x targetKnowledge _target) select 6;
														};
													} forEach _allPlayers;
												};
												if (!(_targetPosition isEqualTo [0,0,0])) then {
													_is = [_target,1,_QS_ST_X] call _fn_is;
													_array pushBack ['a3\ui_f\data\igui\RscCustomInfo\Sensors\Targets\EnemyMan_ca.paa',_color,_targetPosition,_is,_is,0,'',0,0,'RobotoCondensed','right'];
												};
											} else {
												_icon = [
													'a3\ui_f\data\igui\RscCustomInfo\Sensors\Targets\EnemyGround_ca.paa',
													'a3\ui_f\data\igui\RscCustomInfo\Sensors\Targets\EnemyAir_ca.paa'
												] select (_target isKindOf 'Air');
												_color = _sideColors select (_sides find _targetSide);
												_color set [3,(0 max ((_playerSide knowsAbout _target) / 4) min 4)];
												_dir = 0;
												_targetPosition = (_player targetKnowledge _target) select 6;
												if (_targetPosition isEqualTo [0,0,0]) then {
													{
														if ((!(((_x targetKnowledge _target) select 6) isEqualTo [0,0,0])) && (((_x targetKnowledge _target) select 5) < 100)) exitWith {
															_targetPosition = (_x targetKnowledge _target) select 6;
														};
													} forEach _allPlayers;
												};
												if (_isRemoteTarget) then {
													_color = _sideColors select (_sides find (side _unit));
													_icon = missionNamespace getVariable [(format ['QS_ST_iconType#%1',_targetType]),''];
													if (_icon isEqualTo '') then {
														_icon = getText (configFile >> 'CfgVehicles' >> _targetType >> 'icon');
														missionNamespace setVariable [(format ['QS_ST_iconType#%1',_targetType]),_icon];
													};
													_color set [3,1];
													_dir = getDirVisual _target;
												};
												if (!(_targetPosition isEqualTo [0,0,0])) then {
													_is = [_target,1,_QS_ST_X] call _fn_is;
													_array pushBack [_icon,_color,_targetPosition,_is,_is,_dir,'',0,0,'RobotoCondensed','right'];
												};
											};
										};
									};
								};
							};
						};
					};
				};
			};
		} forEach allUnits;
	};
	_array;
};
[]