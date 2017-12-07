/*/
File: fn_getKnownEnemies.sqf
Author:

	Quiksilver
	
Last modified:

	11/07/2017 A3 1.72 by Quiksilver
	
Description:

	Get Known Enemies
__________________________________________________/*/

_type = _this select 0;
if (_type isEqualTo 0) exitWith {
	_QS_ST_X = _this select 1;
	_fn_is = _this select 2;
	private _array = [];
	if (missionNamespace getVariable ['QS_client_showKnownEnemies',TRUE]) then {
		_player = player;
		if ((lifeState _player) in ['HEALTHY','INJURED']) then {
			_hiddenTypes = [
				"o_v_soldier_exp_hex_f","o_v_soldier_jtac_hex_f","o_v_soldier_m_hex_f","o_v_soldier_hex_f","o_v_soldier_medic_hex_f","o_v_soldier_lat_hex_f",
				"o_v_soldier_tl_hex_f","o_v_soldier_exp_ghex_f","o_v_soldier_jtac_ghex_f","o_v_soldier_m_ghex_f","o_v_soldier_ghex_f","o_v_soldier_medic_ghex_f",
				"o_v_soldier_lat_ghex_f","o_v_soldier_tl_ghex_f","o_recon_exp_f","o_recon_jtac_f","o_recon_m_f","o_recon_medic_f","o_pathfinder_f","o_recon_f",
				"o_recon_lat_f","o_recon_tl_f","o_sniper_f","o_ghillie_ard_f","o_ghillie_lsh_f","o_ghillie_sard_f","o_spotter_f","o_t_recon_exp_f","o_t_recon_jtac_f",
				"o_t_recon_m_f","o_t_recon_medic_f","o_t_recon_f","o_t_recon_lat_f","o_t_recon_tl_f","o_t_sniper_f","o_t_ghillie_tna_f","o_t_spotter_f",
				"o_plane_fighter_02_stealth_f","o_diver_f","o_diver_exp_f","o_diver_tl_f","o_t_diver_f","o_t_diver_exp_f","o_t_diver_tl_f","o_uav_01_f","o_t_uav_04_cas_f",
				"o_uav_02_dynamicloadout_f","i_uav_02_dynamicloadout_f"
			];
			private _target = objNull;
			private _targetType = '';
			_sideColors = [[0.5,0,0,0.65],[0,0.3,0.6,0.65],[0,0.5,0,0.65],[0.4,0,0.5,0.65],[0.7,0.6,0,0.5]];
			_sides = [EAST,WEST,RESISTANCE,CIVILIAN,SIDEUNKNOWN];
			private _is = 22;
			private _icon = 'a3\ui_f\data\igui\RscCustomInfo\Sensors\Targets\EnemyMan_ca.paa';
			private _color = _sideColors select 0;
			private _showStealth = missionNamespace getVariable ['QS_client_showStealthEnemies',FALSE];
			private _remoteTargets = [(listRemoteTargets playerSide),0] call (missionNamespace getVariable 'QS_fnc_listRemoteTargets');
			private _isRemoteTarget = FALSE;
			private _dir = 0;
			_time = time;
			{
				if (_x isEqualType objNull) then {
					if (alive _x) then {
						_target = _x;
						if (_target isKindOf 'Man') then {
							(_player targetKnowledge _target) params [
								'_knownByGroup',
								'',
								'_timeLastSeen',
								'',
								'_targetSide',
								'',
								'_targetPosition'
							];
							_targetType = toLower (typeOf _target);
							if ((!(_targetType in _hiddenTypes)) || {(_showStealth)}) then {
								if (_knownByGroup) then {
									_icon = 'a3\ui_f\data\igui\RscCustomInfo\Sensors\Targets\EnemyMan_ca.paa';
									_color = _sideColors select (_sides find _targetSide);
									_color set [3,(0 max (((group _player) knowsAbout _target) / 4) min 4)];
									_is = [_target,1,_QS_ST_X] call _fn_is;
									_array pushBack [_icon,_color,_targetPosition,_is,_is,0,'',0,0.03,'RobotoCondensed','right'];
								};
							};
						} else {
							if (!((crew _target) isEqualTo [])) then {
								_isRemoteTarget = _target in _remoteTargets;
								if ((isNil {_target getVariable ['QS_hidden',nil]}) || {(_target in _remoteTargets)}) then {
									(_player targetKnowledge _target) params [
										'_knownByGroup',
										'',
										'_timeLastSeen',
										'',
										'_targetSide',
										'',
										'_targetPosition'
									];
									_targetType = toLower (typeOf _target);
									if ((!(_targetType in _hiddenTypes)) || {(_showStealth)} ||  {(_isRemoteTarget)}) then {
										if ((_knownByGroup) || {(_isRemoteTarget)}) then {
											if (!(underwater _target)) then {
												if (_isRemoteTarget) then {
													_color = _sideColors select (_sides find (side _target));
													_icon = getText (configFile >> 'CfgVehicles' >> _targetType >> 'icon');
													_color set [3,1];
													_dir = getDirVisual _target;
													_targetPosition = getPosASLVisual _target;
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
												_array pushBack [_icon,_color,_targetPosition,_is,_is,_dir,'',0,0.03,'RobotoCondensed','right'];
											};
										};
									};
								};
							};
						};
					};
				};
			} forEach ((_player targets [TRUE,500]) + _remoteTargets);
		};
	};
	_array;
};
[]