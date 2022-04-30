/*/
File: fn_vTow.sqf
Author:

	Quiksilver
	
Last modified:

	15/08/2018 A3 1.82 by Quiksilver
	
Description:

	Filter Tow attempt
__________________________________________________/*/
private [																					
	'_towable','_vehicle','_crewInVehicle','_pos','_dir','_halfLength','_foundVehicles','_findCount','_findIncrementX','_findIncrementY',
	'_findPos','_found','_foundName','_disAllowed','_foundMass','_towMaxMass','_isUAV','_text'
];
_vehicle = vehicle player;
_isUAV = FALSE;
if ((unitIsUAV cameraOn) && ((toLower (typeOf cameraOn)) in [
	'b_ugv_01_f',
	'b_t_ugv_01_olive_f',
	'o_ugv_01_f',
	'o_t_ugv_01_ghex_f',
	'i_ugv_01_f',
	'c_idap_ugv_01_f',
	'i_e_ugv_01_f'
])) then {
	_isUAV = TRUE;
	_vehicle = cameraOn;
};
_pos = getPosATL _vehicle;
_dir = getDir _vehicle;
_vt = typeOf _vehicle;
_vName = getText (configFile >> 'CfgVehicles' >> _vt >> 'displayName');
_halfLength = ((boundingBoxReal _vehicle) select 1) select 1;
_disAllowed = ["b_mbt_01_arty_f","b_t_mbt_01_arty_f","b_mbt_01_mlrs_f","b_t_mbt_01_mlrs_f"];
_towVs = [
	"b_apc_tracked_01_crv_f","b_truck_01_mover_f","b_t_apc_tracked_01_crv_f","b_t_truck_01_mover_f","c_offroad_01_f","c_offroad_01_repair_f",
	"o_g_offroad_01_f","b_g_offroad_01_f","i_g_offroad_01_f","o_g_offroad_01_repair_f","i_g_offroad_01_repair_f","b_g_offroad_01_repair_f","b_gen_offroad_01_gen_f",'c_idap_offroad_01_f',
	'b_ugv_01_f',
	'o_ugv_01_f',
	'o_t_ugv_01_ghex_f',
	'i_ugv_01_f',
	'c_idap_ugv_01_f',
	'i_e_ugv_01_f'
];
_towLite = [
	"c_offroad_01_f","c_offroad_01_repair_f","o_g_offroad_01_f","b_g_offroad_01_f","i_g_offroad_01_f","o_g_offroad_01_repair_f","i_g_offroad_01_repair_f",
	"b_g_offroad_01_repair_f","b_gen_offroad_01_gen_f",'c_idap_offroad_01_f',
	'b_ugv_01_f',
	'o_ugv_01_f',
	'o_t_ugv_01_ghex_f',
	'i_ugv_01_f',
	'c_idap_ugv_01_f',
	'i_e_ugv_01_f'
];
_towMed = ["b_truck_01_repair_f","b_t_truck_01_repair_f","o_truck_03_repair_f","i_truck_02_box_f","o_truck_02_box_f"];
_towHeavy = ["b_apc_tracked_01_crv_f","b_truck_01_mover_f","b_t_apc_tracked_01_crv_f","b_t_truck_01_mover_f"];
_towSHeavy = ["b_apc_tracked_01_crv_f","b_truck_01_mover_f","b_t_apc_tracked_01_crv_f","b_t_truck_01_mover_f"];
_towMaxMass = 5100;
if ((toLower _vt) in _towLite) then {
	_towMaxMass = 5100;
};
if ((toLower _vt) in _towMed) then {
	_towMaxMass = 12000;
};
if ((toLower _vt) in _towHeavy) then {
	_towMaxMass = 30000;
};
if ((toLower _vt) in _towSHeavy) then {
	_towMaxMass = 80000;
};
_towableCargoObjects = [
	'LandVehicle','Air','Ship','Reammobox_F',
	'b_slingload_01_repair_f','b_slingload_01_medevac_f','b_slingload_01_fuel_f','b_slingload_01_ammo_f','b_slingload_01_cargo_f',
	'land_pod_heli_transport_04_medevac_f','land_pod_heli_transport_04_covered_f','land_pod_heli_transport_04_ammo_f','land_pod_heli_transport_04_box_f','land_pod_heli_transport_04_repair_f',
	'land_pod_heli_transport_04_medevac_black_f','land_pod_heli_transport_04_covered_black_f','land_pod_heli_transport_04_ammo_black_f','land_pod_heli_transport_04_box_black_f','land_pod_heli_transport_04_repair_black_f',
	'land_pod_heli_transport_04_fuel_f','land_pod_heli_transport_04_fuel_black_f',
	'land_pod_heli_transport_04_bench_f','land_pod_heli_transport_04_bench_black_f',
	'box_nato_ammoveh_f','box_ind_ammoveh_f','box_east_ammoveh_f','box_eaf_ammoveh_f',
	'b_cargonet_01_ammo_f','o_cargonet_01_ammo_f','i_cargonet_01_ammo_f','c_idap_cargonet_01_supplies_f','i_e_cargonet_01_ammo_f',
	'cargonet_01_box_f',
	'cargonet_01_barrels_f',
	'b_supplycrate_f','o_supplycrate_f','i_supplycrate_f','c_t_supplycrate_f','c_supplycrate_f','ig_supplycrate_f','c_idap_supplycrate_f',
	'land_device_slingloadable_f',
	'land_cargobox_v1_f',
	'land_cargo10_yellow_f','land_cargo10_white_f','land_cargo10_sand_f','land_cargo10_red_f','land_cargo10_orange_f','land_cargo10_military_green_f','land_cargo10_light_green_f','land_cargo10_light_blue_f','land_cargo10_grey_f','land_cargo10_cyan_f','land_cargo10_brick_red_f','land_cargo10_blue_f',
	'land_cargo20_yellow_f','land_cargo20_white_f','land_cargo20_sand_f','land_cargo20_red_f','land_cargo20_orange_f','land_cargo20_military_green_f','land_cargo20_light_green_f','land_cargo20_light_blue_f','land_cargo20_grey_f','land_cargo20_cyan_f','land_cargo20_brick_red_f','land_cargo20_blue_f',
	'land_watertank_f',
	'land_cargo10_idap_f','land_cargo20_idap_f','land_paperbox_01_small_stacked_f','land_waterbottle_01_stack_f',
	'Land_Destroyer_01_Boat_Rack_01_F'
];
_crewInVehicle = FALSE;
_foundVehicles = [];
_findCount = 0;
_findIncrementX = 2 * _halfLength * sin _dir;
_findIncrementY = 2 * _halfLength * cos _dir;
_findPos = [(_pos select 0) - _findIncrementX, (_pos select 1) - _findIncrementY, _pos select 2];
while {(_foundVehicles isEqualTo []) && (_findCount < 3)} do {
	_foundVehicles = ((_findPos nearEntities [_towableCargoObjects,(1.2 * _halfLength)]) + (nearestObjects [_findPos,_towableCargoObjects,(1.2 * _halfLength),TRUE]));
	_findPos = [((_findPos select 0) - _findIncrementX),((_findPos select 1) - _findIncrementY),(_findPos select 2)];
	_findCount = _findCount + 1;
};
if (_foundVehicles isEqualTo []) exitWith {50 cutText ['No towable vehicles found','PLAIN DOWN',0.5];};
_found = _foundVehicles select 0;
_ft = typeOf _found;
_foundMass = getMass _found;
_foundName = getText (configFile >> 'CfgVehicles' >> _ft >> 'displayName');
if (!(simulationEnabled _found)) exitWith {
	_text = format ['This %1 may not towable at all! Try getting into it first before attempting Tow.',_foundName];
	(missionNamespace getVariable 'QS_managed_hints') pushBack [5,FALSE,7,-1,_text,[],-1];
};
if (!isNull (isVehicleCargo _found)) exitWith {(missionNamespace getVariable 'QS_managed_hints') pushBack [5,FALSE,5,-1,(format ['Cannot Tow the %1',_foundName]),[],-1];};
if (!isNull (isVehicleCargo _vehicle)) exitWith {(missionNamespace getVariable 'QS_managed_hints') pushBack [5,FALSE,5,-1,'Cannot Tow at this time',[],-1];};
if (!(ropeAttachEnabled _found)) exitWith {(missionNamespace getVariable 'QS_managed_hints') pushBack [5,FALSE,5,-1,'This vehicle is not towable',[],-1];};
if (!isNull (attachedTo _found)) exitWith {(missionNamespace getVariable 'QS_managed_hints') pushBack [5,FALSE,5,-1,'This vehicle is not towable',[],-1];};
if (!isNull (attachedTo _vehicle)) exitWith {(missionNamespace getVariable 'QS_managed_hints') pushBack [5,FALSE,5,-1,'Cannot Tow at this time',[],-1];};
if (!isNull (ropeAttachedTo _vehicle)) exitWith {(missionNamespace getVariable 'QS_managed_hints') pushBack [5,FALSE,5,-1,'Cannot Tow at this time',[],-1];};
if (!isNull (ropeAttachedTo _found)) exitWith {(missionNamespace getVariable 'QS_managed_hints') pushBack [5,FALSE,5,-1,(format ['Cannot Tow the %1',_foundName]),[],-1];};
if (_foundMass > _towMaxMass) exitWith {
	_text = format ['The %1 is too heavy for the %2 to tow!',_foundName,_vName];
	(missionNamespace getVariable 'QS_managed_hints') pushBack [5,FALSE,5,-1,_text,[],-1];
};
if ((toLower _ft) in _disAllowed) exitWith {50 cutText [format ['%1 cannot be towed',_foundName],'PLAIN DOWN',0.5];};
if (isNil {_found getVariable 'QS_ropeAttached'}) exitWith {50 cutText ['This vehicle cannot be towed','PLAIN DOWN',0.5];};
if (!(((crew _found) findIf {(alive _x)}) isEqualTo -1)) then {
	if (!(unitIsUAV _found)) then {
		_crewInVehicle = TRUE;
	};
};
if (_crewInVehicle) exitWith {50 cutText [format ['%1 is currently occupied. Cannot tow player-occupied vehicles.',_foundName],'PLAIN DOWN',0.5];};
if (((vectorUp _found) select 2) < 0) exitWith {
	_text = format ['The %1 must be unflipped before it can be towed!',_foundName];
	(missionNamespace getVariable 'QS_managed_hints') pushBack [5,FALSE,5,-1,_text,[],-1];
};
if (_vehicle getVariable 'QS_ropeAttached') exitWith {
	_text = format ['The %1 is currently towing a vehicle!',_vName];
	(missionNamespace getVariable 'QS_managed_hints') pushBack [5,FALSE,5,-1,_text,[],-1];
};
if (_found getVariable 'QS_ropeAttached') exitWith {
	_text = format ['That %1 is already being towed!',_foundName];
	(missionNamespace getVariable 'QS_managed_hints') pushBack [5,FALSE,5,-1,_text,[],-1];
};
if (((toLower _ft) in ['b_sam_system_01_f','b_sam_system_02_f','b_aaa_system_01_f']) && (!((toLower _vt) in ['b_truck_01_mover_f','b_t_truck_01_mover_f']))) exitWith {
	_image = "A3\EditorPreviews_F\Data\CfgVehicles\B_Truck_01_Mover_F.jpg";
	50 cutText [(format ['A(n) %1 is only towable by a(n) HEMTT<br/><br/><img size="5" image="%2"/>',_foundName,_image]),'PLAIN DOWN',0.75,FALSE,TRUE];
};
if (((toLower _ft) in [
	"b_hmg_01_high_f","b_gmg_01_high_f","o_hmg_01_high_f","o_gmg_01_high_f","i_hmg_01_high_f","i_gmg_01_high_f",
	"b_static_aa_f","b_static_at_f","o_static_aa_f","o_static_at_f","i_static_aa_f","i_static_at_f","b_t_static_aa_f","b_t_static_at_f",
	"b_g_mortar_01_f","b_mortar_01_f","b_t_mortar_01_f","o_mortar_01_f","o_g_mortar_01_f","i_mortar_01_f","i_g_mortar_01_f",
	'b_g_hmg_02_high_f', 'o_g_hmg_02_high_f', 'i_hmg_02_high_f', 'i_g_hmg_02_high_f', 'i_e_hmg_02_high_f', 'i_c_hmg_02_high_f'
]) && (!((toLower _vt) in [
	"b_g_van_01_transport_f","o_g_van_01_transport_f","i_g_van_01_transport_f","i_c_van_01_transport_f","i_c_van_01_transport_brown_f",
	"i_c_van_01_transport_olive_f","c_van_01_transport_f","c_van_01_transport_red_f","c_van_01_transport_white_f"
]))) exitWith {
	_image = "A3\EditorPreviews_F\Data\CfgVehicles\B_G_Van_01_transport_F.jpg";
	50 cutText [(format ['A(n) %1 is only towable by a Truck<br/><br/><img size="5" image="%2"/>',_foundName,_image]),'PLAIN DOWN',0.75,FALSE,TRUE];
};
if (((toLower _vt) in [
	"b_g_van_01_transport_f","o_g_van_01_transport_f","i_g_van_01_transport_f","i_c_van_01_transport_f","i_c_van_01_transport_brown_f",
	"i_c_van_01_transport_olive_f","c_van_01_transport_f","c_van_01_transport_red_f","c_van_01_transport_white_f"
]) && (!((toLower _ft) in [
	"b_hmg_01_high_f","b_gmg_01_high_f","o_hmg_01_high_f","o_gmg_01_high_f","i_hmg_01_high_f","i_gmg_01_high_f",
	"b_static_aa_f","b_static_at_f","o_static_aa_f","o_static_at_f","i_static_aa_f","i_static_at_f","b_t_static_aa_f","b_t_static_at_f",
	"b_g_mortar_01_f","b_mortar_01_f","b_t_mortar_01_f","o_mortar_01_f","o_g_mortar_01_f","i_mortar_01_f","i_g_mortar_01_f",
	'b_g_hmg_02_high_f', 'o_g_hmg_02_high_f', 'i_hmg_02_high_f', 'i_g_hmg_02_high_f', 'i_e_hmg_02_high_f', 'i_c_hmg_02_high_f'
]))) exitWith {
	50 cutText ['This vehicle can only tow Static Weapons and Mortars currently','PLAIN DOWN',0.5];
};
0 spawn {
	disableUserInput TRUE;
	uiSleep 0.25;
	disableUserInput FALSE;
};
[_vehicle,_found,_isUAV] spawn (missionNamespace getVariable 'QS_fnc_vTowAttachGround');
TRUE;