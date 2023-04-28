/*/
File: fn_vSetup2.sqf
Author:

	Quiksilver
	
Last Modified:

	19/09/2018 A3 1.84 by Quiksilver
	
Description:

	AI vehicle animation sources & appearance
______________________________________________/*/

if (
	((missionNamespace getVariable ['QS_system_activeDLC','']) isNotEqualTo '') ||
	((missionNamespace getVariable ['QS_missionConfig_dlcVehicles','']) isNotEqualTo '')
) exitWith {};
params [['_case',0],['_vehicle',objNull],['_side',EAST],['_chance',0.5]];
_type = toLowerANSI (typeOf _vehicle);
_cheetah = ['b_apc_tracked_01_aa_f','b_t_apc_tracked_01_aa_f'];
_bobcat = ['b_apc_tracked_01_crv_f','b_t_apc_tracked_01_crv_f'];
_panther = ['b_apc_tracked_01_rcws_f','b_t_apc_tracked_01_rcws_f'];
_tigris = ['o_apc_tracked_02_aa_f','o_t_apc_tracked_02_aa_ghex_f'];
_kamysh = ['o_apc_tracked_02_cannon_f','o_t_apc_tracked_02_cannon_ghex_f'];
_marid = ['o_apc_wheeled_02_rcws_v2_f','o_t_apc_wheeled_02_rcws_v2_ghex_f','o_apc_wheeled_02_rcws_f','o_t_apc_wheeled_02_rcws_ghex_f'];
_sochor = ['o_mbt_02_arty_f','o_t_mbt_02_arty_ghex_f'];
_varsuk = ['o_mbt_02_cannon_f','o_t_mbt_02_cannon_ghex_f'];
_angara = ['o_mbt_04_cannon_f','o_mbt_04_command_F','o_t_mbt_04_cannon_F','o_t_mbt_04_command_f'];
_gorgon = ['i_apc_wheeled_03_cannon_f'];
_mora = ['i_apc_tracked_03_cannon_f','i_e_apc_tracked_03_cannon_f'];
_kuma = ['i_mbt_03_cannon_f'];
_nyx = ['i_lt_01_aa_f','i_lt_01_at_f','i_lt_01_scout_f','i_lt_01_cannon_f'];
_offroad = ['o_g_offroad_01_at_f','o_g_offroad_01_armed_f','i_g_offroad_01_at_f','i_g_offroad_01_armed_f','b_g_offroad_01_at_f','b_g_offroad_01_armed_f'];
_offroad2 = ['i_c_offroad_02_lmg_f'];
_sam = ['b_sam_system_03_f','b_radar_system_01_f','o_sam_system_04_f','o_radar_system_02_f'];
_reserved_1 = [''];
_reserved_2 = [''];
_reserved_3 = [''];
scopeName 'main';
_vehicle enableRopeAttach FALSE;
_vehicle enableVehicleCargo FALSE;
if (_case isEqualTo 0) then {
	if (
		(_vehicle isKindOf 'Helicopter') ||
		{(_vehicle isKindOf 'Tank')} ||
		{(_vehicle isKindOf 'Wheeled_APC_F')}
	) then {
		_vehicle addEventHandler ['IncomingMissile',(missionNamespace getVariable 'QS_fnc_AIXMissileCountermeasure')];
	};
	//comment 'Randomized';
	if (_type in _tigris) then {
		if ((random 1) < 0.666) then {
			_vehicle animateSource ['showslathull',1,1];
		};
		if ((random 1) < 0.5) then {
			{
				_vehicle animateSource _x;
			} forEach [
				['showcamonethull',1,1],
				['showcamonetturret',1,1]
			];
		};
		breakTo 'main';
	};
	if (_type in _cheetah) then {
		if ((random 1) < 0.5) then {
			{
				_vehicle animateSource _x;
			} forEach [
				['showcamonethull',1,1],
				['showcamonetturret',1,1]
			];
		};
		if (_side in [EAST,RESISTANCE]) then {
			if (worldName in ['Tanoa','Lingor3']) then {
				//comment 'Tropics';
				{
					_vehicle setObjectTextureGlobal _x;
				} forEach [
					[0,'A3\armor_f_beta\apc_tracked_01\data\apc_tracked_01_body_indp_co.paa'],
					[1,'A3\armor_f_beta\apc_tracked_01\data\apc_tracked_01_body_indp_co.paa'],
					[2,'A3\armor_f_beta\apc_tracked_01\data\apc_tracked_01_body_indp_co.paa']
				];
			} else {
				//comment 'Desert';
				{
					_vehicle setObjectTextureGlobal _x;
				} forEach [
					[0,'A3\armor_f_beta\apc_tracked_01\data\apc_tracked_01_aa_body_opfor_co.paa'],
					[1,'A3\armor_f_beta\apc_tracked_01\data\apc_tracked_01_aa_body_opfor_co.paa'],
					[2,'A3\armor_f_beta\apc_tracked_01\data\apc_tracked_01_aa_tower_opfor_co.paa']
				];
			};
		};
		breakTo 'main';
	};
	if (_type in _bobcat) then {
		if (_side in [EAST,RESISTANCE]) then {
			if ((random 1) < 0.5) then {
				{
					_vehicle animateSource _x;
				} forEach [
					['showcamonethull',1,1],
					['showcamonetplates1',1,1],
					['showcamonetplates2',1,1]
				];
			};
			if (worldName in ['Tanoa','Lingor3']) then {
				{
					_vehicle setObjectTextureGlobal _x;
				} forEach [
					[0,'A3\armor_f_beta\apc_tracked_01\data\apc_tracked_01_body_indp_co.paa'],
					[1,'A3\armor_f_beta\apc_tracked_01\data\apc_tracked_01_body_indp_co.paa'],
					[2,'A3\armor_f_beta\apc_tracked_01\data\apc_tracked_01_body_indp_co.paa'],
					[3,'A3\armor_f_beta\apc_tracked_01\data\apc_tracked_01_body_indp_co.paa']
				];
			} else {
				{
					_vehicle setObjectTextureGlobal _x;
				} forEach [
					[0,'A3\armor_f_beta\apc_tracked_01\data\apc_tracked_01_crv_opfor_co.paa'],
					[1,'A3\armor_f_beta\apc_tracked_01\data\apc_tracked_01_crv_opfor_co.paa'],
					[2,'A3\armor_f_beta\apc_tracked_01\data\apc_tracked_01_crv_opfor_co.paa'],
					[3,'A3\armor_f_beta\apc_tracked_01\data\apc_tracked_01_crv_opfor_co.paa']
				];
			};
		};
		breakTo 'main';
	};
	if (_type in _panther) then {
		if (_side in [EAST,RESISTANCE]) then {
			if ((random 1) < 0.5) then {
				{
					_vehicle animateSource _x;
				} forEach [
					['showcamonethull',1,1],
					['showcamonetplates1',1,1],
					['showcamonetplates2',1,1]
				];
			};
			if (worldName in ['Tanoa','Lingor3']) then {
				{
					_vehicle setObjectTextureGlobal _x;
				} forEach [
					[0,'A3\armor_f_beta\apc_tracked_01\data\apc_tracked_01_body_indp_co.paa'],
					[1,'A3\armor_f_beta\apc_tracked_01\data\apc_tracked_01_body_indp_co.paa'],
					[2,'A3\armor_f_beta\apc_tracked_01\data\apc_tracked_01_body_indp_co.paa']
				];
			} else {
				{
					_vehicle setObjectTextureGlobal _x;
				} forEach [
					[0,'A3\armor_f_beta\apc_tracked_01\data\apc_tracked_01_crv_opfor_co.paa'],
					[1,'A3\armor_f_beta\apc_tracked_01\data\apc_tracked_01_crv_opfor_co.paa'],
					[2,'A3\armor_f_beta\apc_tracked_01\data\apc_tracked_01_crv_opfor_co.paa']
				];
			};
		};
		breakTo 'main';
	};
	if (_type in _kamysh) then {
		if ((random 1) < 0.5) then {
			_vehicle animateSource ['showslathull',1,1];
		};
		if ((random 1) < 0.5) then {
			{
				_vehicle animateSource _x;
			} forEach [
				['showcamonethull',1,1]
			];
		};
		breakTo 'main';
	};
	if (_type in _marid) then {
		if ((random 1) < 0.5) then {
			_vehicle animateSource ['showslathull',1,1];
		};
		if ((random 1) < 0.5) then {
			{
				_vehicle animateSource _x;
			} forEach [
				['showcamonethull',1,1]
			];
		};
		// arma bug fix, new variant has incorrect livery (A3 1.81)
		if (_type in ['o_t_apc_wheeled_02_rcws_v2_ghex_f']) then {
			{ 
				_vehicle setObjectTextureGlobal [_forEachIndex,_x]; 
			} forEach (getArray ((configOf _vehicle) >> 'TextureSources' >> 'GreenHex' >> 'textures'));
		};
		breakTo 'main';
	};
	if (_type in _sochor) then {
		if ((random 1) < 0.5) then {
			_vehicle animateSource ['showlog',1,1];
		};
		if ((random 1) < 0.5) then {
			{
				_vehicle animateSource _x;
			} forEach [
				['showcamonethull',1,1],
				['showcamonetturret',1,1]
			];
			if ((random 1) > 0.5) then {
				_vehicle animateSource ['showcamonetcannon',1,1];
			};
		};
		breakTo 'main';
	};
	if (_type in _varsuk) then {
		if ((random 1) < 0.5) then {
			_vehicle animateSource ['showlog',1,1];
		};
		if ((random 1) < 0.5) then {
			{
				_vehicle animateSource _x;
			} forEach [
				['showcamonethull',1,1],
				['showcamonetturret',1,1]
			];
			if ((random 1) > 0.333) then {
				_vehicle animateSource ['showcamonetcannon',1,1];
			};
		};
		if (
			((random 1) < 0.5) ||
			{((count allPlayers) < 15)}
		) then {
			_vehicle removeWeaponTurret ['HMG_NSVT',[0,0]];
			{
				_vehicle addWeaponTurret _x;
			} forEach [
				['M134_minigun',[0,0]]
			];
			{
				_vehicle addMagazineTurret _x;
			} forEach [
				['5000Rnd_762x51_Yellow_Belt',[0,0]],
				['5000Rnd_762x51_Yellow_Belt',[0,0]],
				['5000Rnd_762x51_Yellow_Belt',[0,0]],
				['5000Rnd_762x51_Yellow_Belt',[0,0]]
			];
		};
		breakTo 'main';
	};
	if (_type in _angara) then {
		if ((random 1) < 0.5) then {
			{
				_vehicle animateSource _x;
			} forEach [
				['showcamonethull',1,1],
				['showcamonetturret',1,1]
			];
			if ((random 1) > 0.333) then {
				_vehicle animateSource ['showcamonetcannon',1,1];
			};
		};
		if (
			((random 1) < 0.5) ||
			{((count allPlayers) < 15)}
		) then {
			_vehicle removeWeaponTurret ['HMG_127_APC',[0,0]];
			{
				_vehicle addWeaponTurret _x;
			} forEach [
				['M134_minigun',[0,0]]
			];
			{
				_vehicle addMagazineTurret _x;
			} forEach [
				['5000Rnd_762x51_Yellow_Belt',[0,0]],
				['5000Rnd_762x51_Yellow_Belt',[0,0]],
				['5000Rnd_762x51_Yellow_Belt',[0,0]],
				['5000Rnd_762x51_Yellow_Belt',[0,0]]
			];
		};
		breakTo 'main';
	};
	if (_type in _gorgon) then {
		if ((random 1) < 0.5) then {
			_vehicle animateSource ['showslathull',1,1];
		};
		if ((random 1) < 0.5) then {
			{
				_vehicle animateSource _x;
			} forEach [
				['showcamonethull',1,1]
			];
		};
		breakTo 'main';
	};
	if (_type in _mora) then {
		if ((random 1) < 0.5) then {
			{
				_vehicle animateSource _x;
			} forEach [
				['showslathull',1,1],
				['showslatturret',1,1]
			];
		};
		if ((random 1) < 0.5) then {
			{
				_vehicle animateSource _x;
			} forEach [
				['showcamonethull',1,1],
				['showcamonetturret',1,1]
			];
		};
		breakTo 'main';
	};
	if (_type in _kuma) then {
		{
			_vehicle animateSource _x;
		} forEach [
			['hideturret',0,1],
			['hidehull',0,1]
		];
		if ((random 1) < 0.5) then {
			{
				_vehicle animateSource _x;
			} forEach [
				['showcamonethull',1,1],
				['showcamonetturret',1,1],
				['showcamonetcannon',1,1],
				['showcamonetcannon1',1,1]
			];
		};
		if (
			((random 1) < 0.5) ||
			{((count allPlayers) < 15)}
		) then {
			_vehicle removeWeaponTurret ['HMG_127_APC',[0,0]];
			{
				_vehicle addWeaponTurret _x;
			} forEach [
				['M134_minigun',[0,0]]
			];
			{
				_vehicle addMagazineTurret _x;
			} forEach [
				['5000Rnd_762x51_Yellow_Belt',[0,0]],
				['5000Rnd_762x51_Yellow_Belt',[0,0]],
				['5000Rnd_762x51_Yellow_Belt',[0,0]],
				['5000Rnd_762x51_Yellow_Belt',[0,0]]
			];
		};
		breakTo 'main';
	};
	if (_type in _nyx) then {
		if ((random 1) < 0.333) then {
			{
				_vehicle animateSource _x;
			} forEach [
				['showslathull',1,1]
			];
		};
		if ((random 1) < 0.666) then {
			{
				_vehicle animateSource _x;
			} forEach [
				['showcamonethull',1,1],
				['showcamonetplates1',1,1],
				['showcamonetplates2',1,1]
			];
		};
		breakTo 'main';
	};
	if (_type in _offroad) then {
		_vehicle animateSource ['HideBackpacks',(selectRandom [0,1]),1];
		{ 
			_vehicle setObjectTextureGlobal [_forEachIndex,_x]; 
		} forEach (getArray ((configOf _vehicle) >> 'TextureSources' >> (format ['Guerilla_%1',(selectRandom ['01','02','03','04','05','06','07','08','09','10','11','12'])]) >> 'textures'));
		breakTo 'main';
	};
	if (_type in _offroad2) then {
		if ((random 1) > 0.75) then {
			_vehicle addWeaponTurret ['MMG_02_vehicle',[0]];
			for '_x' from 0 to 4 step 1 do {
				_vehicle addMagazineTurret ['130Rnd_338_Mag',[0]];
			};
			_vehicle removeWeaponTurret ['LMG_03_Vehicle_F',[0]];
		};
		breakTo 'main';
	};
	if (_type in _sam) then {
		_vehicle setVehicleRadar 1;
		if (_type in ['o_sam_system_04_f','o_radar_system_02_f']) then {
			{
				_vehicle setObjectTextureGlobal [_forEachIndex,_x];
			} forEach (getArray ((configOf _vehicle) >> 'TextureSources' >> (['AridHex','JungleHex'] select (worldName in ['Tanoa','Lingor3'])) >> 'textures'));
		};
	};
};