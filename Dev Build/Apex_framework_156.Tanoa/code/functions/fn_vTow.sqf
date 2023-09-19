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
if ((unitIsUAV cameraOn) && ((toLowerANSI (typeOf cameraOn)) in (['ugv_types_1'] call QS_data_listVehicles))) then {
	_isUAV = TRUE;
	_vehicle = cameraOn;
};
_pos = getPosATL _vehicle;
_dir = getDir _vehicle;
_vt = typeOf _vehicle;
_vName = QS_hashmap_configfile getOrDefaultCall [
	format ['cfgvehicles_%1_displayname',toLowerANSI _vt],
	{getText ((configOf _vehicle) >> 'displayName')},
	TRUE
];
_halfLength = ((0 boundingBoxReal _vehicle) # 1) # 1;
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
if ((toLowerANSI _vt) in _towLite) then {
	_towMaxMass = 5100;
};
if ((toLowerANSI _vt) in _towMed) then {
	_towMaxMass = 12000;
};
if ((toLowerANSI _vt) in _towHeavy) then {
	_towMaxMass = 30000;
};
if ((toLowerANSI _vt) in _towSHeavy) then {
	_towMaxMass = 80000;
};
_towableCargoObjects = ['towable_objects_3'] call QS_data_listVehicles;
_crewInVehicle = FALSE;
_foundVehicles = [];
_findCount = 0;
_findIncrementX = 2 * _halfLength * sin _dir;
_findIncrementY = 2 * _halfLength * cos _dir;
_findPos = [(_pos # 0) - _findIncrementX, (_pos # 1) - _findIncrementY, _pos # 2];
while {(_foundVehicles isEqualTo []) && (_findCount < 3)} do {
	_foundVehicles = ((_findPos nearEntities [_towableCargoObjects,(1.2 * _halfLength)]) + (nearestObjects [_findPos,_towableCargoObjects,(1.2 * _halfLength),TRUE]));
	_findPos = [((_findPos # 0) - _findIncrementX),((_findPos # 1) - _findIncrementY),(_findPos # 2)];
	_findCount = _findCount + 1;
};
if (_foundVehicles isEqualTo []) exitWith {50 cutText [localize 'STR_QS_Text_249','PLAIN DOWN',0.5];};
_found = _foundVehicles # 0;
_ft = typeOf _found;
_foundMass = getMass _found;
_foundName = QS_hashmap_configfile getOrDefaultCall [
	format ['cfgvehicles_%1_displayname',toLowerANSI _ft],
	{getText ((configOf _found) >> 'displayName')},
	TRUE
];
if (!(simulationEnabled _found)) exitWith {
	_text = format ['%1 %2',_foundName,localize 'STR_QS_Hints_132'];
	(missionNamespace getVariable 'QS_managed_hints') pushBack [5,FALSE,7,-1,_text,[],-1];
};
if (
	(!isNull (isVehicleCargo _vehicle)) ||
	{(!isNull (attachedTo _vehicle))} ||
	{(!isNull (ropeAttachedTo _vehicle))}
) exitWith {
	(missionNamespace getVariable 'QS_managed_hints') pushBack [5,FALSE,5,-1,localize 'STR_QS_Hints_134',[],-1];
};
if (
	(!(ropeAttachEnabled _found)) ||
	{(!isNull (attachedTo _found))}
) exitWith {
	(missionNamespace getVariable 'QS_managed_hints') pushBack [5,FALSE,5,-1,localize 'STR_QS_Hints_135',[],-1];
};
if (
	(!isNull (isVehicleCargo _found)) ||
	{(!isNull (ropeAttachedTo _found))}
) exitWith {
	(missionNamespace getVariable 'QS_managed_hints') pushBack [5,FALSE,5,-1,(format ['%2 %1',_foundName,localize 'STR_QS_Hints_133']),[],-1];
};
if (_foundMass > _towMaxMass) exitWith {
	_text = format ['%1 %3 %2',_foundName,_vName,localize 'STR_QS_Hints_136'];
	(missionNamespace getVariable 'QS_managed_hints') pushBack [5,FALSE,5,-1,_text,[],-1];
};
if ((toLowerANSI _ft) in _disAllowed) exitWith {50 cutText [format ['%1 %2',_foundName,localize 'STR_QS_Text_250'],'PLAIN DOWN',0.5];};
if (((crew _found) findIf {(alive _x)}) isNotEqualTo -1) then {
	if (!(unitIsUAV _found)) then {
		_crewInVehicle = TRUE;
	};
};
if (_crewInVehicle) exitWith {50 cutText [format ['%1 %2',_foundName,localize 'STR_QS_Text_252'],'PLAIN DOWN',0.5];};
if (((vectorUp _found) # 2) < 0) exitWith {
	_text = format ['%1 %2',_foundName,localize 'STR_QS_Hints_137'];
	(missionNamespace getVariable 'QS_managed_hints') pushBack [5,FALSE,5,-1,_text,[],-1];
};
if (((toLowerANSI _ft) in ['b_sam_system_01_f','b_sam_system_02_f','b_aaa_system_01_f']) && (!((toLowerANSI _vt) in ['b_truck_01_mover_f','b_t_truck_01_mover_f']))) exitWith {
	_image = "A3\EditorPreviews_F\Data\CfgVehicles\B_Truck_01_Mover_F.jpg";
	50 cutText [(format ['%1 %3<br/><br/><img size="5" image="%2"/>',_foundName,_image,localize 'STR_QS_Text_253']),'PLAIN DOWN',0.75,FALSE,TRUE];
};
if (((toLowerANSI _ft) in [
	"b_hmg_01_high_f","b_gmg_01_high_f","o_hmg_01_high_f","o_gmg_01_high_f","i_hmg_01_high_f","i_gmg_01_high_f",
	"b_static_aa_f","b_static_at_f","o_static_aa_f","o_static_at_f","i_static_aa_f","i_static_at_f","b_t_static_aa_f","b_t_static_at_f",
	"b_g_mortar_01_f","b_mortar_01_f","b_t_mortar_01_f","o_mortar_01_f","o_g_mortar_01_f","i_mortar_01_f","i_g_mortar_01_f",
	'b_g_hmg_02_high_f', 'o_g_hmg_02_high_f', 'i_hmg_02_high_f', 'i_g_hmg_02_high_f', 'i_e_hmg_02_high_f', 'i_c_hmg_02_high_f'
]) && (!((toLowerANSI _vt) in [
	"b_g_van_01_transport_f","o_g_van_01_transport_f","i_g_van_01_transport_f","i_c_van_01_transport_f","i_c_van_01_transport_brown_f",
	"i_c_van_01_transport_olive_f","c_van_01_transport_f","c_van_01_transport_red_f","c_van_01_transport_white_f"
]))) exitWith {
	_image = "A3\EditorPreviews_F\Data\CfgVehicles\B_G_Van_01_transport_F.jpg";
	50 cutText [(format ['%1 %3(<br/><br/><img size="5" image="%2"/>',_foundName,_image,localize 'STR_QS_Text_253']),'PLAIN DOWN',0.75,FALSE,TRUE];
};
if (((toLowerANSI _vt) in [
	"b_g_van_01_transport_f","o_g_van_01_transport_f","i_g_van_01_transport_f","i_c_van_01_transport_f","i_c_van_01_transport_brown_f",
	"i_c_van_01_transport_olive_f","c_van_01_transport_f","c_van_01_transport_red_f","c_van_01_transport_white_f"
]) && (!((toLowerANSI _ft) in [
	"b_hmg_01_high_f","b_gmg_01_high_f","o_hmg_01_high_f","o_gmg_01_high_f","i_hmg_01_high_f","i_gmg_01_high_f",
	"b_static_aa_f","b_static_at_f","o_static_aa_f","o_static_at_f","i_static_aa_f","i_static_at_f","b_t_static_aa_f","b_t_static_at_f",
	"b_g_mortar_01_f","b_mortar_01_f","b_t_mortar_01_f","o_mortar_01_f","o_g_mortar_01_f","i_mortar_01_f","i_g_mortar_01_f",
	'b_g_hmg_02_high_f', 'o_g_hmg_02_high_f', 'i_hmg_02_high_f', 'i_g_hmg_02_high_f', 'i_e_hmg_02_high_f', 'i_c_hmg_02_high_f'
]))) exitWith {
	50 cutText [localize 'STR_QS_Text_254','PLAIN DOWN',0.5];
};
0 spawn {
	disableUserInput TRUE;
	uiSleep 0.25;
	disableUserInput FALSE;
};
[_vehicle,_found,_isUAV] spawn (missionNamespace getVariable 'QS_fnc_vTowAttachGround');
TRUE;