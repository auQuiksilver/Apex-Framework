/*
File: fn_clientVehicleEventFired.sqf
Author:
	
	Quiksilver
	
Last Modified:

	6/07/2016 A3 1.62 by Quiksilver

Description:

	Event Fired
__________________________________________________________*/

params ['_vehicle','_weapon','_muzzle','_mode','_ammo','_magazine','_projectile','_gunner'];
if (_vehicle isKindOf 'LandVehicle') then {
	if (player isEqualTo (_vehicle turretUnit [0])) then {
		_vehicleType = toLower (typeOf _vehicle);
		if (_vehicleType in [
			"b_apc_wheeled_01_cannon_f","b_apc_tracked_01_crv_f","b_apc_tracked_01_rcws_f","b_mrap_01_gmg_f","b_mrap_01_hmg_f","b_mbt_01_cannon_f","b_mbt_01_tusk_f","b_t_mbt_01_tusk_f","b_apc_tracked_01_aa_f","b_hmg_01_high_f","b_hmg_01_f","b_gmg_01_f","b_gmg_01_high_f","b_t_mrap_01_hmg_f","b_t_mrap_01_gmg_f","b_t_apc_tracked_01_aa_f","b_t_apc_wheeled_01_cannon_f","b_t_apc_tracked_01_crv_f","b_t_apc_tracked_01_rcws_f","b_t_mbt_01_cannon_f","b_t_gmg_01_f","b_t_hmg_01_f","b_g_offroad_01_armed_f",
			"i_apc_tracked_03_cannon_f","i_apc_wheeled_03_cannon_f","i_mrap_03_gmg_f","i_mrap_03_hmg_f","i_g_offroad_01_armed_f","i_hmg_01_f","i_hmg_01_high_f","i_gmg_01_f","i_gmg_01_high_f",
			"o_apc_tracked_02_aa_f","o_apc_tracked_02_cannon_f","o_apc_wheeled_02_rcws_f","o_apc_wheeled_02_rcws_v2_f","o_mrap_02_gmg_f","o_mrap_02_hmg_f","o_lsv_02_armed_f","o_hmg_01_f","o_hmg_01_high_f","o_gmg_01_f","o_gmg_01_high_f","o_t_apc_tracked_02_aa_ghex_f","o_t_apc_tracked_02_cannon_ghex_f","o_t_mrap_02_gmg_ghex_f","o_t_apc_wheeled_02_rcws_ghex_f","o_t_apc_wheeled_02_rcws_v2_ghex_f","o_t_mrap_02_hmg_ghex_f","o_t_lsv_02_armed_f","o_g_offroad_01_armed_f"
		]) then {
			_cursorTarget = cursorTarget;
			_cursorObject = cursorObject;
			if ((!isNull (effectiveCommander _cursorTarget)) || {(!isNull (effectiveCommander _cursorObject))}) then {
				if ((isPlayer (effectiveCommander _cursorTarget)) || {(isPlayer (effectiveCommander _cursorObject))}) then {
					deleteVehicle _projectile;
					if (!isNil {player getVariable 'QS_tto'}) then {
						if ((player getVariable 'QS_tto') > 0) then {
							if ((_vehicle distance2D (markerPos 'QS_marker_base_marker')) < 1000) then {
								[17,_vehicle] remoteExec ['QS_fnc_remoteExec',2,FALSE];
								50 cutText ['Your vehicle was a threat to friendly soldiers and has been removed.','PLAIN'];
							};
						};
					};
				};
			};
		};
	};
	if (player isEqualTo (_vehicle turretUnit [1])) then {
		if (_weapon in [
			'MMG_02_vehicle','HMG_127_MBT','HMG_127_APC','HMG_NSVT'
		]) then {
			_cursorTarget = cursorTarget;
			_cursorObject = cursorObject;
			if ((!isNull (effectiveCommander _cursorTarget)) || {(!isNull (effectiveCommander _cursorObject))}) then {
				if ((isPlayer (effectiveCommander _cursorTarget)) || {(isPlayer (effectiveCommander _cursorObject))}) then {
					deleteVehicle _projectile;
					if (!isNil {player getVariable 'QS_tto'}) then {
						if ((player getVariable 'QS_tto') > 0) then {
							if ((_vehicle distance2D (markerPos 'QS_marker_base_marker')) < 1000) then {
								deleteVehicle _vehicle;
								50 cutText ['Your vehicle was a threat to friendly soldiers and has been removed.','PLAIN'];
							};
						};
					};
				};
			};			
		};
	};
};