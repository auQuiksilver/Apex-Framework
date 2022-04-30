/*/
File: fn_vehicleLoadouts.sqf
Author: 

	Quiksilver

Last Modified:

	19/02/2018 A3 1.80 by Quiksilver

Description:

	Vehicle Loadouts
	https://community.bistudio.com/wiki/Arma_3_Vehicle_Loadouts
____________________________________________________________________________/*/

params ['_vehicle','_type','_data'];
if (_type isEqualTo 0) exitWith {

};
if (_type isEqualTo 1) exitWith {
	_vehicleType = toLower (typeOf _vehicle);
	_preparePylons = {
		{ 
			_this removeWeaponGlobal (getText (configFile >> 'CfgMagazines' >> _x >> 'pylonWeapon'));
		} forEach (getPylonMagazines _this);
	};
	comment '************************************************************* WEST *****';
	if (_vehicleType isEqualTo 'b_t_uav_03_dynamicloadout_f') then {
		_vehicle call _preparePylons;
		{
			_vehicle setPylonLoadout _x;
		} forEach [
			[1,'',TRUE],
			[2,'',TRUE],
			[3,'',TRUE],
			[4,'',TRUE]
		];
	};
	if (_vehicleType isEqualTo 'b_uav_02_dynamicloadout_f') then {
		_vehicle call _preparePylons;
		{
			_vehicle setPylonLoadout _x;
		} forEach [
			[1,'PylonMissile_1Rnd_Bomb_03_F',TRUE,[0]],
			[2,'PylonMissile_1Rnd_Bomb_03_F',TRUE,[0]]
		];
	};
	if (_vehicleType isEqualTo 'b_plane_cas_01_dynamicloadout_f') then {
		//_vehicle call _preparePylons;
		{
			_vehicle setPylonLoadout _x;
		} forEach [
			[1,"PylonRack_1Rnd_Missile_AA_04_F",TRUE],
			[2,"PylonRack_7Rnd_Rocket_04_AP_F",TRUE],
			[3,"PylonRack_7Rnd_Rocket_04_HE_F",TRUE],
			[4,"PylonMissile_1Rnd_Bomb_04_F",TRUE],
			[5,"PylonMissile_1Rnd_Mk82_F",TRUE],
			[6,"PylonMissile_1Rnd_Mk82_F",TRUE],
			[7,"PylonMissile_1Rnd_Bomb_04_F",TRUE],
			[8,"PylonRack_7Rnd_Rocket_04_HE_F",TRUE],
			[9,"PylonRack_7Rnd_Rocket_04_AP_F",TRUE],
			[10,"PylonRack_1Rnd_Missile_AA_04_F",TRUE]
		];
	};
	if (_vehicleType isEqualTo 'b_plane_fighter_01_f') then {
		//_vehicle call _preparePylons;
		{ 
			_vehicle setPylonLoadout _x; 
		} forEach [ 
			[1,"PylonRack_Missile_AMRAAM_D_x1",TRUE],
			[2,"PylonRack_Missile_AMRAAM_D_x1",TRUE],
			[3,"PylonMissile_Bomb_GBU12_x1",TRUE],
			[4,"PylonMissile_Bomb_GBU12_x1",TRUE],
			[5,"PylonMissile_Missile_BIM9X_x1",TRUE],
			[6,"PylonMissile_Missile_BIM9X_x1",TRUE],
			[7,"PylonMissile_Missile_AMRAAM_D_INT_x1",TRUE],
			[8,"PylonMissile_Missile_AMRAAM_D_INT_x1",TRUE],
			[9,"",TRUE],
			[10,"",TRUE],
			[11,"PylonMissile_Bomb_GBU12_x1",TRUE],
			[12,"PylonMissile_Bomb_GBU12_x1",TRUE]
		];
	};
	if (_vehicleType isEqualTo 'b_plane_fighter_01_stealth_f') then {
		//_vehicle call _preparePylons;
		{ 
			_vehicle setPylonLoadout _x; 
		} forEach [
			[1,"",TRUE],
			[2,"",TRUE],
			[3,"",TRUE],
			[4,"",TRUE],
			[5,"PylonMissile_Missile_BIM9X_x1",TRUE],
			[6,"PylonMissile_Missile_BIM9X_x1",TRUE],
			[7,"PylonMissile_Missile_AMRAAM_D_INT_x1",TRUE],
			[8,"PylonMissile_Missile_AMRAAM_D_INT_x1",TRUE],
			[9,"",TRUE],
			[10,"",TRUE],
			[11,"PylonMissile_Bomb_GBU12_x1",TRUE],
			[12,"PylonMissile_Bomb_GBU12_x1",TRUE]
		];
	};
	if (_vehicleType isEqualTo 'b_heli_attack_01_dynamicloadout_f') then {
		comment 'To Do';
	};
	if (_vehicleType isEqualTo 'b_heli_light_01_dynamicloadout_f') then {
		comment 'To Do';
	};	
	
	comment '************************************************************* EAST *****';
	if (_vehicleType isEqualTo 'o_uav_02_dynamicloadout_f') then {
		_vehicle call _preparePylons;
		{
			_vehicle setPylonLoadout _x;
		} forEach [
			[1,'PylonMissile_1Rnd_Bomb_03_F',TRUE],
			[2,'PylonMissile_1Rnd_Bomb_03_F',TRUE]
		];
	};
	if (_vehicleType isEqualTo 'o_plane_cas_02_dynamicloadout_f') then {
		//_vehicle call _preparePylons;
		{ 
			_vehicle setPylonLoadout _x; 
		} forEach [
			[1,"PylonRack_1Rnd_Missile_AA_03_F",TRUE],
			[2,"PylonRack_20Rnd_Rocket_03_HE_F",TRUE],
			[3,"PylonRack_20Rnd_Rocket_03_AP_F",TRUE],
			[4,"",TRUE],
			[5,"PylonMissile_1Rnd_Bomb_03_F",TRUE],
			[6,"PylonMissile_1Rnd_Bomb_03_F",TRUE],
			[7,"",TRUE],
			[8,"PylonRack_20Rnd_Rocket_03_AP_F",TRUE],
			[9,"PylonRack_20Rnd_Rocket_03_HE_F",TRUE],
			[10,"PylonRack_1Rnd_Missile_AA_03_F",TRUE]
		];
	};
	if (_vehicleType isEqualTo 'o_plane_fighter_02_f') then {
		//_vehicle call _preparePylons;
		{ 
			_vehicle setPylonLoadout _x; 
		} forEach 	[
			[1,"PylonMissile_Missile_AA_R73_x1",TRUE],
			[2,"PylonMissile_Missile_AA_R73_x1",TRUE],
			[3,"PylonMissile_Missile_AA_R73_x1",TRUE],	/*/PylonMissile_Missile_AA_R77_x1/*/
			[4,"PylonMissile_Missile_AA_R73_x1",TRUE],	/*/PylonMissile_Missile_AA_R77_x1/*/
			[5,"PylonMissile_Bomb_KAB250_x1",TRUE],
			[6,"PylonMissile_Bomb_KAB250_x1",TRUE],
			[7,"PylonMissile_Missile_AA_R73_x1",TRUE],
			[8,"PylonMissile_Missile_AA_R73_x1",TRUE],
			[9,"PylonMissile_Missile_AA_R73_x1",TRUE],	/*/PylonMissile_Missile_AA_R77_x1/*/
			[10,"PylonMissile_Missile_AA_R73_x1",TRUE],	/*/PylonMissile_Missile_AA_R77_x1/*/
			[11,"PylonMissile_Missile_AA_R77_INT_x1",TRUE],
			[12,"PylonMissile_Missile_AA_R77_INT_x1",TRUE],
			[13,"PylonMissile_Bomb_KAB250_x1",TRUE]
		];
	};
	if (_vehicleType isEqualTo 'o_plane_fighter_02_stealth_f') then {
		//_vehicle call _preparePylons;
		{ 
			_vehicle setPylonLoadout _x; 
		} forEach 	[
			[1,"",TRUE],
			[2,"",TRUE],
			[3,"",TRUE],
			[4,"",TRUE],
			[5,"",TRUE],
			[6,"",TRUE],
			[7,"PylonMissile_Missile_AA_R73_x1",TRUE],
			[8,"PylonMissile_Missile_AA_R73_x1",TRUE],
			[9,"PylonMissile_Missile_AA_R77_x1",TRUE],	/*/PylonMissile_Missile_AA_R77_x1/*/
			[10,"PylonMissile_Missile_AA_R77_x1",TRUE],	/*/PylonMissile_Missile_AA_R77_x1/*/
			[11,"PylonMissile_Missile_AA_R77_INT_x1",TRUE],
			[12,"PylonMissile_Missile_AA_R77_INT_x1",TRUE],
			[13,"PylonMissile_Bomb_KAB250_x1",TRUE]
		];	
	};
	if (_vehicleType in ['o_heli_attack_02_dynamicloadout_f','o_heli_attack_02_dynamicloadout_black_f']) then {
		//_vehicle call _preparePylons;
		{ 
			_vehicle setPylonLoadout _x;
		} forEach 	[
			[1,"PylonRack_19Rnd_Rocket_Skyfire",TRUE],
			[2,"PylonRack_19Rnd_Rocket_Skyfire",TRUE],
			[3,"PylonRack_19Rnd_Rocket_Skyfire",TRUE],
			[4,"PylonRack_19Rnd_Rocket_Skyfire",TRUE]
		];		
	};
	if (_vehicleType in ['o_t_vtol_02_infantry_dynamicloadout_f','o_t_vtol_02_vehicle_dynamicLoadout_F']) then {
		//_vehicle call _preparePylons;
		{ 
			_vehicle setPylonLoadout _x;
		} forEach 	[
			[1,"PylonRack_19Rnd_Rocket_Skyfire",TRUE],
			[2,"PylonRack_19Rnd_Rocket_Skyfire",TRUE],
			[3,"PylonRack_19Rnd_Rocket_Skyfire",TRUE],
			[4,"PylonRack_19Rnd_Rocket_Skyfire",TRUE]
		];
	};
	if (_vehicleType isEqualTo 'o_heli_light_02_dynamicloadout_f') then {
	
	};
	comment '************************************************************* RESISTANCE *****';
	if (_vehicleType isEqualTo 'i_uav_02_dynamicloadout_f') then {
		_vehicle call _preparePylons;
		{
			_vehicle setPylonLoadout _x;
		} forEach [
			[1,'PylonMissile_1Rnd_Bomb_03_F',TRUE],
			[2,'PylonMissile_1Rnd_Bomb_03_F',TRUE]
		];
	};
	if (_vehicleType in ['i_heli_light_03_dynamicloadout_f','i_e_heli_light_03_dynamicloadout_f']) then {
		//_vehicle call _preparePylons;
		{
			_vehicle setPylonLoadout _x;
		} forEach [
			[1,'PylonRack_12Rnd_missiles',TRUE],
			[2,'PylonRack_12Rnd_missiles',TRUE]
		];		
	};
	if (_vehicleType isEqualTo 'i_plane_fighter_03_dynamicloadout_f') then {
		//_vehicle call _preparePylons;
		{
			_vehicle setPylonLoadout _x;
		} forEach [
			[1,"PylonRack_7Rnd_Rocket_04_HE_F",TRUE],
			[2,"PylonRack_1Rnd_AAA_missiles",TRUE],
			[3,"PylonMissile_1Rnd_Bomb_04_F",TRUE],
			[4,"PylonWeapon_300Rnd_20mm_shells",TRUE],
			[5,"PylonMissile_1Rnd_Bomb_04_F",TRUE],
			[6,"PylonRack_1Rnd_AAA_missiles",TRUE],
			[7,"PylonRack_7Rnd_Rocket_04_HE_F",TRUE]
		];	
	};
	if (_vehicleType isEqualTo 'i_plane_fighter_04_f') then {
		//_vehicle call _preparePylons;
		{
			_vehicle setPylonLoadout _x;
		} forEach [
			[1,"PylonMissile_Missile_BIM9X_x1",TRUE],
			[2,"PylonMissile_Missile_BIM9X_x1",TRUE],
			[3,"PylonRack_Missile_AMRAAM_C_x1",TRUE],
			[4,"PylonRack_Missile_AMRAAM_C_x1",TRUE],
			[5,"PylonMissile_Bomb_GBU12_x1",TRUE],
			[6,"PylonMissile_Bomb_GBU12_x1",TRUE]
		];
	};
	{
		if ((toLower _x) in ['laserdesignator_pilotcamera']) then {
			_vehicle removeWeapon 'Laserdesignator_pilotCamera';
		};
		/*/ removes UAV laser
		if ((toLower _x) in ['laserdesignator_mounted']) then {
			_vehicle removeWeapon 'Laserdesignator_mounted';
		};
		/*/
	} forEach (weapons _vehicle);
};
if (_type isEqualTo 2) exitWith {
	{ 
		_vehicle removeWeaponGlobal (getText (configFile >> 'CfgMagazines' >> _x >> 'pylonWeapon'));
	} forEach (getPylonMagazines _vehicle);
	{
		_vehicle setPylonLoadout [(_forEachIndex + 1),(selectRandom _x),TRUE];
	} forEach ([0,_vehicle,0] call (missionNamespace getVariable 'QS_fnc_getCompatiblePylonMags'));
};