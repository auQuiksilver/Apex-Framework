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
		private _vehicleType = typeOf _vehicle;
		if (_vehicleType in [
			"B_APC_Wheeled_01_cannon_F","B_APC_Tracked_01_CRV_F","B_APC_Tracked_01_rcws_F","B_MRAP_01_gmg_F","B_MRAP_01_hmg_F","B_MBT_01_cannon_F","B_MBT_01_TUSK_F","B_T_MBT_01_TUSK_F","B_APC_Tracked_01_AA_F","B_HMG_01_high_F","B_HMG_01_F","B_GMG_01_F","B_GMG_01_high_F","B_T_MRAP_01_hmg_F","B_T_MRAP_01_gmg_F","B_T_APC_Tracked_01_AA_F","B_T_APC_Wheeled_01_cannon_F","B_T_APC_Tracked_01_CRV_F","B_T_APC_Tracked_01_rcws_F","B_T_MBT_01_cannon_F","B_T_GMG_01_F","B_T_HMG_01_F","B_G_Offroad_01_armed_F",
			"I_APC_tracked_03_cannon_F","I_APC_Wheeled_03_cannon_F","I_MRAP_03_gmg_F","I_MRAP_03_hmg_F","I_G_Offroad_01_armed_F","I_HMG_01_F","I_HMG_01_high_F","I_GMG_01_F","I_GMG_01_high_F",
			"O_APC_Tracked_02_AA_F","O_APC_Tracked_02_cannon_F","O_APC_Wheeled_02_rcws_F","O_MRAP_02_gmg_F","O_MRAP_02_hmg_F","O_LSV_02_armed_F","O_HMG_01_F","O_HMG_01_high_F","O_GMG_01_F","O_GMG_01_high_F","O_T_APC_Tracked_02_AA_ghex_F","O_T_APC_Tracked_02_cannon_ghex_F","O_T_MRAP_02_gmg_ghex_F","O_T_APC_Wheeled_02_rcws_ghex_F","O_T_MRAP_02_hmg_ghex_F","O_T_LSV_02_armed_F","O_G_Offroad_01_armed_F"
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
		_vehicleType = typeOf _vehicle;
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