/*/
File: fn_getKnownEnemies.sqf
Author:

	Quiksilver
	
Last modified:

	25/05/2022 A3 2.08 by Quiksilver
	
Description:

	Get Known Enemies
__________________________________________________/*/

_type = param [0];
if (_type isEqualTo 0) exitWith {
	params ['','_QS_ST_X','_fn_is','_fn_jammer','_gpsJammers'];
	private _array = [];
	if (missionNamespace getVariable ['QS_client_showKnownEnemies',TRUE]) then {
		_player = missionNamespace getVariable ['bis_fnc_moduleRemoteControl_unit',player];
		_cameraOn = cameraOn;
		_group = group _player;
		private _isAir = ((vehicle _player) isKindOf 'Air') || {(_cameraOn isKindOf 'Air')};
		if ((lifeState _player) in ['HEALTHY','INJURED']) then {
			_hiddenTypes = ['hidden_enemy_types_1'] call QS_data_listUnits;
			private _target = objNull;
			private _targetType = '';
			_sideColors = [[0.5,0,0,0.65],[0,0.3,0.6,0.65],[0,0.5,0,0.65],[0.4,0,0.5,0.65],[0.7,0.6,0,0.5]];
			_sides = [EAST,WEST,RESISTANCE,CIVILIAN,SIDEUNKNOWN];
			private _is = 22;
			private _icon = 'a3\ui_f\data\igui\RscCustomInfo\Sensors\Targets\EnemyMan_ca.paa';
			private _color = [0.5,0,0,0.65];
			_showStealth = missionNamespace getVariable ['QS_client_showStealthEnemies',FALSE];
			_remoteTargets = [(listRemoteTargets (_player getVariable ['QS_unit_side',WEST])),0] call (missionNamespace getVariable 'QS_fnc_listRemoteTargets');
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
									_targetType = toLowerANSI (typeOf _target);
									if ((!(_targetType in _hiddenTypes)) || {(_showStealth)}) then {
										if (_knownByGroup) then {
											_color = _sideColors # ((_sides find _targetSide) max 0);
											_color set [3,(0 max (((group _player) knowsAbout _target) / 4) min 4)];
											_is = [_target,1,_QS_ST_X] call _fn_is;
											if ((_gpsJammers isEqualTo []) || {((_gpsJammers isNotEqualTo []) && {(!([0,_targetPosition] call _fn_jammer))})}) then {
												_array pushBack ['a3\ui_f\data\igui\RscCustomInfo\Sensors\Targets\EnemyMan_ca.paa',_color,_targetPosition,_is,_is,0,'',0,0,'RobotoCondensed','right'];
											};
										};
									};
								};
							} else {
								if ((crew _target) isNotEqualTo []) then {
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
										_targetType = toLowerANSI (typeOf _target);
										if ((!(_targetType in _hiddenTypes)) || {(_showStealth)} || {(_isRemoteTarget)}) then {
											if ((_knownByGroup) || {(_isRemoteTarget)}) then {
												if (!(underwater _target)) then {
													if (_isRemoteTarget) then {
														if (((_target distance2D _cameraOn) < 600) && (!(_cameraOn isKindOf 'Air'))) then {
															_color = _sideColors # ((_sides find (side _target)) max 0);
															_icon = QS_hashmap_configfile getOrDefaultCall [
																format ['cfgvehicles_%1_icon',toLowerANSI _targetType],
																{getText ((configOf _target) >> 'icon')},
																TRUE
															];
															_color set [3,1];
															_dir = getDirVisual _target;
															_targetPosition = getPosWorldVisual _target;
														};
													} else {
														_color = _sideColors # (_sides find _targetSide);
														_icon = [
															'a3\ui_f\data\igui\RscCustomInfo\Sensors\Targets\EnemyGround_ca.paa',
															'a3\ui_f\data\igui\RscCustomInfo\Sensors\Targets\EnemyAir_ca.paa'
														] select (_target isKindOf 'Air');
														_color set [3,(0 max (((group _player) knowsAbout _target) / 4) min 4)];
														_dir = 0;
													};
													_is = [_target,1,_QS_ST_X] call _fn_is;
													if ((_gpsJammers isEqualTo []) || {((_gpsJammers isNotEqualTo []) && {(!([0,_targetPosition] call _fn_jammer))})}) then {
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
			} forEach ((_group targets [TRUE,([250,400] select (_player getUnitTrait 'QS_trait_leader'))]) + _remoteTargets);
		};
	};
	_array;
};
if (_type isEqualTo 1) exitWith {
	params ['','_QS_ST_X','_fn_is'];
	private _array = [];
	_hiddenTypes = ['hidden_enemy_types_1'] call QS_data_listUnits;
	_player = missionNamespace getVariable ['bis_fnc_moduleRemoteControl_unit',player];
	_cameraOn = cameraOn;
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
	([_player,'SAFE'] call QS_fnc_inZone) params ['_inSafezone','_safezoneLevel','_safezoneActive'];
	_allPlayers = (units WEST) call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
	private _targetPosition = [0,0,0];
	private _targetKnowledge = [];
	if (
		(_inSafezone && _safezoneActive) ||
		{(((listVehicleSensors (vehicle _player)) isNotEqualTo []) && ( ((listVehicleSensors (vehicle _player)) findIf {((toLowerANSI (_x # 0)) isEqualTo 'activeradarsensorcomponent')}) isNotEqualTo -1) && (isVehicleRadarOn (vehicle _player)))}
	) then {
		{
			if (alive _x) then {
				//if ((side (group _x)) in _enemySides) then {
					_unit = _x;
					_target = vehicle _unit;
					if (((_playerSide knowsAbout _target) > 0) || {(_target in _remoteTargets)}) then {
						if (alive _target) then {
							if (simulationEnabled _target) then {
								if (!(_target getVariable ['QS_hidden',FALSE])) then {
									_targetSide = side (group _unit);
									_targetType = toLowerANSI (typeOf _target);
									_isRemoteTarget = _target in _remoteTargets;
									if ((!(_targetType in _hiddenTypes)) || {(_showStealth)} || {(_isRemoteTarget)}) then {
										if (!(underwater _target)) then {
											if (_target isKindOf 'CAManBase') then {
												_color = _sideColors # ((_sides find _targetSide) max 0);
												_color set [3,(0 max ((_playerSide knowsAbout _target) / 4) min 4)];
												_targetPosition = (_player targetKnowledge _target) # 6;
												if (_targetPosition isEqualTo [0,0,0]) then {
													{
														if ((((_x targetKnowledge _target) # 6) isNotEqualTo [0,0,0]) && (((_x targetKnowledge _target) # 5) < 100)) exitWith {
															_targetPosition = (_x targetKnowledge _target) # 6;
														};
													} forEach _allPlayers;
												};
												if (_targetPosition isNotEqualTo [0,0,0]) then {
													_is = [_target,1,_QS_ST_X] call _fn_is;
													_array pushBack ['a3\ui_f\data\igui\RscCustomInfo\Sensors\Targets\EnemyMan_ca.paa',_color,_targetPosition,_is,_is,0,'',0,0,'RobotoCondensed','right'];
												};
											} else {
												_icon = [
													'a3\ui_f\data\igui\RscCustomInfo\Sensors\Targets\EnemyGround_ca.paa',
													'a3\ui_f\data\igui\RscCustomInfo\Sensors\Targets\EnemyAir_ca.paa'
												] select (_target isKindOf 'Air');
												_color = _sideColors # ((_sides find _targetSide) max 0);
												_color set [3,(0 max ((_playerSide knowsAbout _target) / 4) min 4)];
												_dir = 0;
												_targetPosition = (_player targetKnowledge _target) # 6;
												if (_targetPosition isEqualTo [0,0,0]) then {
													{
														if ((((_x targetKnowledge _target) # 6) isNotEqualTo [0,0,0]) && (((_x targetKnowledge _target) # 5) < 100)) exitWith {
															_targetPosition = (_x targetKnowledge _target) # 6;
														};
													} forEach _allPlayers;
												};
												if (_isRemoteTarget) then {
													if (((_target distance2D _cameraOn) < 600) && (!(_cameraOn isKindOf 'Air'))) then {
														_color = _sideColors # ((_sides find (side _unit)) max 0);
														_icon = QS_hashmap_configfile getOrDefaultCall [
															format ['cfgvehicles_%1_icon',toLowerANSI _targetType],
															{getText ((configOf _target) >> 'icon')},
															TRUE
														];
														_color set [3,1];
														_dir = getDirVisual _target;
													};
												};
												if (_targetPosition isNotEqualTo [0,0,0]) then {
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
				//};
			};
		} forEach ((units EAST) + (units RESISTANCE));
	};
	_array;
};
[]