/*/
File: fn_clientArsenal.sqf
Author: 

	Quiksilver

Last Modified:

	21/09/2023 A3 2.14 by Quiksilver

Description:

	Setup Client Arsenal
____________________________________________________/*/

params [
	['_unit',player]
];
_unit setVariable ['bis_addVirtualWeaponCargo_cargo',[[],[],[],[]],FALSE];
if ((missionNamespace getVariable ['QS_missionConfig_Arsenal',0]) isEqualTo 3) exitWith {
	// Populate faces list
	private _data = [];
	{
		{
			if (
				((getnumber (_x >> 'disabled')) isEqualTo 0) && 
				{((gettext (_x >> 'head')) isNotEqualTo '')} && 
				{((configname _x) != 'Default')}
			) then {
				_data pushBack (configName _x);
			};
		} foreach ('isclass _x' configclasses _x);
	} foreach ('isclass _x' configclasses (configfile >> 'cfgfaces'));
	(missionNamespace getVariable 'bis_fnc_arsenal_data') set [15,_data];
};
private _configRestrictions = getMissionConfigValue ['arsenalRestrictedItems',[]];

/*/ To Do: Implement this instead of the below lists
(call (missionNamespace getVariable 'QS_data_restrictedGear')) params [
	['_restrictedWeapons',[]],
	['_restrictedMagazines',[]],
	['_restrictedItems',[]],
	['_restrictedBackpacks',[]]
];
/*/

private _QS_restrictedItems = [
	'h_helmetleadero_oucamo',
	'h_helmetleadero_ocamo',
	'h_helmetleadero_ghex_f',
	'h_helmeto_oucamo',
	'h_helmeto_ocamo',
	'h_helmeto_ghex_f',
	'h_racinghelmet_1_black_f',
	'h_racinghelmet_1_blue_f',
	'h_racinghelmet_2_f',
	'h_racinghelmet_1_f',
	'h_racinghelmet_1_green_f',
	'h_racinghelmet_1_orange_f',
	'h_racinghelmet_1_red_f',
	'h_racinghelmet_3_f',
	'h_racinghelmet_4_f',
	'h_racinghelmet_1_white_f',
	'h_racinghelmet_1_yellow_f',
	'u_c_idap_man_cargo_f',
	'u_c_idap_man_jeans_f',
	'u_c_idap_man_casual_f',
	'u_c_idap_man_shorts_f',
	'u_c_idap_man_tee_f',
	'u_c_idap_man_teeshorts_f',
	'u_c_driver_1_black',
	'u_c_driver_1_blue',
	'u_c_driver_2',
	'u_c_driver_1',
	'u_c_driver_1_green',
	'u_c_driver_1_orange',
	'u_c_driver_1_red',
	'u_c_driver_3',
	'u_c_driver_4',
	'u_c_driver_1_white',
	'u_c_driver_1_yellow',
	'u_o_t_soldier_f',
	'u_o_combatuniform_ocamo',
	'u_o_combatuniform_oucamo',
	'u_o_fullghillie_ard',
	'u_o_t_fullghillie_tna_f',
	'u_o_fullghillie_lsh',
	'u_o_fullghillie_sard',
	'u_o_t_sniper_f',
	'u_o_ghilliesuit',
	'u_orestesbody',
	'u_o_officer_noinsignia_hex_f',
	'u_o_t_officer_f',
	'u_o_officeruniform_ocamo',
	'u_o_pilotcoveralls',
	'u_o_specopsuniform_ocamo',
	'u_o_v_soldier_viper_f',
	'u_o_v_soldier_viper_hex_f',
	'u_i_protagonist_vr',
	'u_c_protagonist_vr',
	'u_o_protagonist_vr',
	'u_b_protagonist_vr',
	'v_plain_medical_f',
	'v_eod_idap_blue_f',
	'apersminedispenser_mag',
	'integrated_nvg_f',
	'integrated_nvg_ti_0_f',
	'integrated_nvg_ti_1_f',
	'o_uavterminal',
	'i_uavterminal',
	'c_uavterminal',
	'i_e_uavterminal'
] + _configRestrictions;
private _QS_restrictedWeapons = [
	'apersminedispenser_mag'
];
private _QS_restrictedMagazines = [
	'apersminedispenser_mag'
];
private _QS_restrictedBackpacks = [
	'weapon_bag_base',
	'o_hmg_01_support_f',
	'i_hmg_01_support_f',
	'o_hmg_01_support_high_f',
	'i_hmg_01_support_high_f',
	'o_hmg_01_weapon_f',
	'i_hmg_01_weapon_f',
	'b_hmg_01_a_weapon_f',
	'o_hmg_01_a_weapon_f',
	'i_hmg_01_a_weapon_f',
	'i_hmg_02_support_f',
	'i_e_hmg_02_support_f',
	//'i_c_hmg_02_support_f',		// These are allowed in Arsenal until BIS fixes the Blufor variant
	'i_g_hmg_02_support_f',
	'i_hmg_02_support_high_f',
	'i_e_hmg_02_support_high_f',
	//'i_c_hmg_02_support_high_f',
	'i_g_hmg_02_support_high_f',
	'i_hmg_02_weapon_f',
	'i_e_hmg_02_weapon_f',
	//'i_c_hmg_02_weapon_f',
	'i_g_hmg_02_weapon_f',
	'i_hmg_02_high_weapon_f',
	'i_e_hmg_02_high_weapon_f',
	//'i_c_hmg_02_high_weapon_f',
	'i_g_hmg_02_high_weapon_f',
	'o_gmg_01_weapon_f',
	'i_gmg_01_weapon_f',
	'b_gmg_01_a_weapon_f',
	'o_gmg_01_a_weapon_f',
	'i_gmg_01_a_weapon_f',
	'o_hmg_01_high_weapon_f',
	'i_hmg_01_high_weapon_f',
	'o_gmg_01_high_weapon_f',
	'i_gmg_01_high_weapon_f',
	'o_mortar_01_support_f',
	'i_mortar_01_support_f',
	'o_mortar_01_weapon_f',
	'i_mortar_01_weapon_f',
	'b_o_parachute_02_f',
	'b_i_parachute_02_f',
	'o_aa_01_weapon_f',
	'i_aa_01_weapon_f',
	'o_at_01_weapon_f',
	'i_at_01_weapon_f',
	'o_uav_01_backpack_f',
	'i_uav_01_backpack_f',
	'b_respawn_tentdome_f',
	'b_respawn_tenta_f',
	'b_respawn_sleeping_bag_f',
	'b_respawn_sleeping_bag_blue_f',
	'b_respawn_sleeping_bag_brown_f',
	'o_static_designator_02_weapon_f',
	'b_patrol_respawn_bag_f',
	'b_messenger_idap_f',
	'c_idap_uav_01_backpack_f',
	'o_uav_06_backpack_f',
	'i_uav_06_backpack_f',
	'c_idap_uav_06_backpack_f',
	'c_uav_06_backpack_f',
	'c_idap_uav_06_antimine_backpack_f',
	'o_uav_06_medical_backpack_f',
	'i_uav_06_medical_backpack_f',
	'c_idap_uav_06_medical_backpack_f',
	'c_uav_06_medical_backpack_f',
	'i_e_mortar_01_support_f',
	'i_e_mortar_01_weapon_f',
	'i_e_hmg_01_support_high_f',
	'i_e_hmg_01_support_f',
	'i_e_gmg_01_a_weapon_f',
	'i_e_hmg_01_a_weapon_f',
	'i_e_hmg_01_high_weapon_f',
	'i_e_hmg_01_weapon_f',
	'i_e_gmg_01_high_weapon_f',
	'i_e_gmg_01_weapon_f',
	'i_e_ugv_02_demining_backpack_f',
	'i_ugv_02_science_backpack_f',
	'o_ugv_02_science_backpack_f',
	'i_e_ugv_02_science_backpack_f',
	'i_e_aa_01_weapon_f',
	'i_e_at_01_weapon_f',
	'i_e_uav_06_backpack_f',
	'i_e_uav_06_medical_backpack_f',
	'i_e_uav_01_backpack_f',
	'c_idap_ugv_02_demining_backpack_f',
	'i_ugv_02_demining_backpack_f',
	'o_ugv_02_demining_backpack_f'
];
if ((_unit getVariable ['QS_unit_side',WEST]) in [EAST,RESISTANCE]) then {
	_QS_restrictedItems = _QS_restrictedItems -	[
		'','u_i_c_soldier_bandit_4_f','u_i_c_soldier_bandit_1_f','u_i_c_soldier_bandit_2_f','u_i_c_soldier_bandit_5_f','u_i_c_soldier_bandit_3_f','u_o_t_soldier_f',
		'u_o_combatuniform_ocamo','u_o_combatuniform_oucamo','u_o_fullghillie_ard','u_o_t_fullghillie_tna_f','u_o_fullghillie_lsh','u_o_fullghillie_sard','u_o_t_sniper_f',
		'u_o_ghilliesuit','u_bg_guerrilla_6_1','u_bg_guerilla1_1','u_bg_guerilla1_2_f','u_bg_guerilla2_2','u_bg_guerilla2_1','u_bg_guerilla2_3','u_bg_guerilla3_1','u_bg_leader',
		'u_o_officer_noinsignia_hex_f','u_o_t_officer_f','u_o_officeruniform_ocamo','u_i_c_soldier_para_2_f','u_i_c_soldier_para_3_f','u_i_c_soldier_para_5_f','u_i_c_soldier_para_4_f',
		'u_i_c_soldier_para_1_f','u_o_pilotcoveralls','u_o_specopsuniform_ocamo','u_i_c_soldier_camo_f'
	];
};
missionNamespace setVariable ['QS_arsenal_missionBlacklist',[[_QS_restrictedItems,_QS_restrictedWeapons,_QS_restrictedMagazines,_QS_restrictedBackpacks],(_QS_restrictedItems + _QS_restrictedWeapons + _QS_restrictedMagazines + _QS_restrictedBackpacks)],FALSE];
_isBlacklisted = (missionNamespace getVariable ['QS_missionConfig_Arsenal',0]) isEqualTo 2;
if ((_isBlacklisted) || {((missionNamespace getVariable ['QS_missionConfig_Arsenal',0]) isEqualTo 0)}) then {
	// If using blacklist, we first have to add everything, so we can remove the blacklisted items.
	private _internalRestrictions = TRUE;		// Caution, leave TRUE unless you know what you're doing. Set FALSE to disable hard-coded restrictions (respawn backpacks, racing + vr uniforms, etc).
	private _cfgItems = [];
	private _cfgWeapons = [];
	private _cfgMagazines = [];
	private _cfgBackpacks = [];
	_configArray = (
		('((isclass _x) && ((((configName _x) isKindOf ["ItemCore",configFile >> "CfgWeapons"])) || (((configName _x) isKindOf ["DetectorCore",configFile >> "CfgWeapons"])) || (((configName _x) isKindOf ["NVGoggles",configFile >> "CfgWeapons"]))))' configclasses (configfile >> 'cfgweapons')) + 
		('("isclass _x && getnumber (_x >> ""scope"") isEqualTo 2 && getnumber (_x >> ""isBackpack"") isEqualTo 1")' configclasses (configfile >> 'cfgvehicles')) + 
		('isclass _x' configclasses (configfile >> 'cfgglasses'))
	);
	private _weaponType = '';
	private _weaponTypeCategory = '';
	private _class = configNull;
	private _className = '';
	private _scope = -1;
	private _isBase = FALSE;
	private _weaponTypeSpecific = '';
	private _weaponTypeID = -1;
	if (!(_internalRestrictions)) then {
		_QS_restrictedItems = [];
	};
	{
		_class = _x;
		_className = configName _class;
		_scope = if (isnumber (_class >> 'scopeArsenal')) then {getnumber (_class >> 'scopeArsenal')} else {getnumber (_class >> 'scope')};
		_isBase = if (isarray (_class >> 'muzzles')) then {((_className call (missionNamespace getVariable 'QS_fnc_baseWeapon')) == _className)} else {TRUE};
		if ((_scope isEqualTo 2) && {((gettext (_class >> 'model')) isNotEqualTo '')} && _isBase) then {
			_weaponType = (_className call (missionNamespace getVariable 'BIS_fnc_itemType'));
			_weaponTypeCategory = _weaponType # 0;
			if (_weaponTypeCategory != 'VehicleWeapon') then {
				if (!( (toLowerANSI _className) in _QS_restrictedItems)) then {
					_cfgItems pushBackUnique _className;
				};
			};
		};
	} foreach _configArray;
	_cfgWeapons = ("(isclass _x) && ((getnumber (_x >> 'scope')) isEqualTo 2) && (((getnumber (_x >> 'type')) < 5) || ((getnumber (_x >> 'type')) isEqualTo 4096))") configClasses (configFile >> 'cfgWeapons');
	_cfgWeapons = _cfgWeapons apply { (configName _x) };
	_cfgWeapons = _cfgWeapons select {((_x call (missionNamespace getVariable 'QS_fnc_baseWeapon')) == _x)};
	_cfgWeapons = _cfgWeapons arrayIntersect _cfgWeapons;
	if (!(_internalRestrictions)) then {
		_QS_restrictedWeapons = [];
	};
	_cfgWeapons = _cfgWeapons select {(!((toLowerANSI _x) in _QS_restrictedWeapons))};
	private _weaponClass = '';
	private _mag = '';
	private _cfgMag = configNull;
	private _weapon = configNull;
	private _muzzles = [];
	private _muzzle = configNull;
	private _magazines = [];
	if (!(_internalRestrictions)) then {
		_QS_restrictedMagazines = [];
	};
	{
		_weaponClass = _x;
		_weapon = configFile >> 'CfgWeapons' >> _weaponClass;
		if ((toLowerANSI _weaponClass) in ['throw','put']) then {
			_muzzles = getArray (_weapon >> 'muzzles');
			{
				_muzzle = _x;
				_magazines = getArray (configFile >> 'CfgWeapons' >> _weaponClass >> _muzzle >> 'magazines');
				{
					if (isClass (configFile >> 'CfgMagazines' >> _x)) then {
						if ((getNumber (configFile >> 'CfgMagazines' >> _x >> 'scope')) isEqualTo 2) then {
							_cfgMagazines pushBackUnique _x;
						};
					};
				} forEach _magazines;
			} forEach _muzzles;
		} else {
			{
				_mag = _x;
				if (!(_x in _cfgMagazines)) then {
					if (!((toLowerANSI _x) in _QS_restrictedMagazines)) then {
						_cfgMagazines pushBackUnique _x;
					};
				};
			} foreach (getarray (_weapon >> 'magazines'));
		};
	} foreach (_cfgWeapons + ['throw','put']);
	_cfgBackpacks = ("isclass _x && getnumber (_x >> 'scope') >= 1 && getnumber (_x >> 'isBackpack') isEqualTo 1") configClasses (configFile >> 'cfgvehicles');
	_cfgBackpacks = _cfgBackpacks apply { (configName _x) };
	_cfgBackpacks = _cfgBackpacks select {((_x call (missionNamespace getVariable 'QS_fnc_baseBackpack')) == _x)};
	_cfgBackpacks = _cfgBackpacks arrayIntersect _cfgBackpacks;
	if (!(_internalRestrictions)) then {
		_QS_restrictedBackpacks = [];
	};
	_cfgBackpacks = _cfgBackpacks select {(!((toLowerANSI _x) in _QS_restrictedBackpacks))};
	_unit setVariable ['bis_addVirtualWeaponCargo_cargo',[_cfgItems,_cfgWeapons,_cfgMagazines,_cfgBackpacks],FALSE];	
};
_data = [(_unit getVariable ['QS_unit_side',WEST]),(_unit getVariable ['QS_unit_role','rifleman'])] call (missionNamespace getVariable 'QS_data_arsenal');
private _weapons = [];
(_data # ([1,0] select _isBlacklisted)) params ['_itemsData','_magazines','_backpacks','_weapons'];
if (_backpacks isNotEqualTo []) then {
	_backpacks = _backpacks select {((_x call (missionNamespace getVariable 'QS_fnc_baseBackpack')) == _x)};
};
if (_weapons isNotEqualTo []) then {
	_weapons = _weapons select {((_x call (missionNamespace getVariable 'QS_fnc_baseWeapon')) == _x)};
};
private _items = [];
private _goggles = _itemsData # 5;
if (_goggles isNotEqualTo []) then {
	_binGoggles = configFile >> 'CfgGlasses';
	private _goggleClassname = '';
	private _className = configNull;
	for '_i' from 0 to ((count _binGoggles) - 1) step 1 do {
		_className = _binGoggles select _i;
		if (isClass _className) then {
			_goggleClassname = configName _className;
			if ((toLowerANSI _goggleClassname) in _goggles) then {
				_goggles set [(_goggles find (toLowerANSI _goggleClassname)),_goggleClassname];
			};
		};
	};
	_itemsData set [5,_goggles];
};
{
	_items = _items + _x;
} forEach _itemsData;
if (_isBlacklisted) exitWith {
	_cargo = _unit getvariable ['bis_addVirtualWeaponCargo_cargo',[[],[],[],[]]];
	_cargo params ['_cargoItems','_cargoWeapons','_cargoMagazines','_cargoBackpacks'];
	private _class = '';
	private _foundIndex = -1;
	{
		_class = _x;
		_foundIndex = _cargoItems findIf {((toLowerANSI _x) isEqualTo (toLowerANSI _class))};
		if (_foundIndex isNotEqualTo -1) then {
			_cargoItems deleteAt _foundIndex;
		};
	} forEach _items;
	if (_weapons isNotEqualTo []) then {
		{
			_class = configname (configfile >> 'cfgweapons' >> _x);
			_foundIndex = _cargoWeapons findIf {((toLowerANSI _x) isEqualTo (toLowerANSI _class))};
			if (_foundIndex isNotEqualTo -1) then {
				_cargoWeapons deleteAt _foundIndex;
			};
		} forEach _weapons;
	};
	if (_magazines isNotEqualTo []) then {
		{
			_class = configname (configfile >> 'cfgweapons' >> _x);
			_foundIndex = _cargoMagazines findIf {((toLowerANSI _x) isEqualTo (toLowerANSI _class))};
			if (_foundIndex isNotEqualTo -1) then {
				_cargoMagazines deleteAt _foundIndex;
			};
		} forEach _magazines;
	};	
	if (_backpacks isNotEqualTo []) then {
		{
			_class = _x;
			_foundIndex = _cargoBackpacks findIf {((toLowerANSI _x) isEqualTo (toLowerANSI _class))};
			if (_foundIndex isNotEqualTo -1) then {
				_cargoBackpacks deleteAt _foundIndex;
			};
		} forEach _backpacks;
	};
	_unit setVariable ['bis_addVirtualWeaponCargo_cargo',[_cargoItems,_cargoWeapons,_cargoMagazines,_cargoBackpacks],FALSE];
};
{
	if ((_x # 1) isNotEqualTo []) then {
		[_unit,(_x # 1),FALSE,FALSE] call (missionNamespace getVariable (_x # 0));
	};
} forEach [
	[(format ['BIS_fnc_%1VirtualItemCargo',(['add','remove'] select _isBlacklisted)]),(_items select {(!( (toLowerANSI _x) in _QS_restrictedItems))})],
	[(format ['BIS_fnc_%1VirtualMagazineCargo',(['add','remove'] select _isBlacklisted)]),(_magazines select {(!( (toLowerANSI _x) in _QS_restrictedMagazines))})],
	[(format ['BIS_fnc_%1VirtualBackpackCargo',(['add','remove'] select _isBlacklisted)]),(_backpacks select {(!( (toLowerANSI _x) in _QS_restrictedBackpacks))})],
	[(format ['BIS_fnc_%1VirtualWeaponCargo',(['add','remove'] select _isBlacklisted)]),(_weapons select {(!( (toLowerANSI _x) in _QS_restrictedWeapons))})]
];