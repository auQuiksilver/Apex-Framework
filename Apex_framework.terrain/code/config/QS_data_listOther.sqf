/*/
File: QS_data_listOther.sqf
Author:

	Quiksilver
	
Last modified:

	13/12/2022 A3 2.10 by Quiksilver
	
Description:

	Lists of Various config classnames
________________________________/*/

params ['_type',['_mode',0]];
if (_mode isEqualTo 0) exitWith {
	(QS_hashmap_classLists getOrDefaultCall [format ['o_%1',_type],{[_type,1] call QS_data_listOther},TRUE])
};
private _return = [];
if (_type isEqualTo 'restricted_strings_1') exitWith {
	[
		'{true}',"123,116,114,117,101,125",
		'],[',"93,44,91",
		'spawn {',"115,112,97,119,110,32,123",
		'spawn "',"115,112,97,119,110,32,34",
		"spawn '","115,112,97,119,110,32,39",
		'call {',"99,97,108,108,32,123",
		'call "',"99,97,108,108,32,34",
		"call '","99,97,108,108,32,39",
		'_fnc_',"95,102,110,99,95",
		'{',"123",
		'}',"125",
		' = ',"32,61,32",
		'==',"61,61",
		'compile',"99,111,109,112,105,108,101",
		'toarray',"116,111,97,114,114,97,121",
		'tostring',"116,111,115,116,114,105,110,103",
		'" + "',"34,32,43,32,34",
		"' + '","39,32,43,32,39",
		'(true)','40,116,114,117,101,41'
	]
};

if (_type isEqualTo 'injured_anims_1') exitWith {
	[
		'acts_injuredlyingrifle01','acts_injuredlyingrifle02','ainjppnemstpsnonwrfldnon','ainjppnemstpsnonwnondnon','ainjpfalmstpsnonwrfldnon_carried_down',
		'unconscious','amovppnemstpsnonwnondnon','ainjpfalmstpsnonwnondnon_carried_down','unconsciousrevivedefault','unconsciousrevivedefault','unconsciousrevivedefault_a',
		'unconsciousrevivedefault_b','unconsciousrevivedefault_base','unconsciousrevivedefault_c'
	]
};
if (_type isEqualTo 'arsenal_model_1') exitWith {
	// Arsenal Object Models - Add to this list to set a Simple Object to Arsenal properties
	[
		'a3\weapons_f\ammoboxes\supplydrop.p3d'
	]
};
if (_type isEqualTo 'ugv_stretcher_1') exitWith {
	'a3\props_f_orange\humanitarian\camps\stretcher_01_f.p3d'
};
if (_type isEqualTo 'camonet_anims_1') exitWith {
	['showcamonethull','showcamonetcannon','showcamonetcannon1','showcamonetturret','showcamonetplates1','showcamonetplates2']
};
if (_type isEqualTo 'slatarmor_anims_1') exitWith {
	['showslathull','showslatturret']
};
if (_type isEqualTo 'markers_base_hide_1') exitWith {
	// Map Markers which disappear when you zoom out
	[
		'QS_marker_airbaseDefense',
		'QS_marker_airbaseArtillery',
		'QS_marker_casJet_spawn',
		'QS_marker_crate_area',
		'QS_marker_heli_spawn',
		'QS_marker_veh_spawn',
		'QS_marker_side_rewards',
		'QS_marker_veh_baseservice_01',
		'QS_marker_veh_baseservice_02',
		'QS_marker_veh_baseservice_03',
		'QS_marker_gitmo',
		'QS_marker_medevac_hq',
		'QS_marker_base_toc',
		'QS_marker_base_atc',
		'QS_marker_veh_inventoryService_01',
		'QS_marker_veh_fieldservice_04',
		'QS_marker_veh_fieldservice_01',
		'QS_marker_wreck_service_01'
	]
};
if (_type isEqualTo 'crater_decals_1') exitWith {
	[
		'land_shellcrater_02_debris_f',
		'land_shellcrater_02_decal_f',
		'land_shellcrater_01_decal_f',
		'land_shellcrater_02_extralarge_f',
		'land_shellcrater_02_large_f',
		'land_shellcrater_02_small_f',
		'land_shellcrater_01_f',
		'craterlong',
		'craterlong_small'
	]
};
if (_type isEqualTo 'uxo_field_types_1') exitWith {
	[
		'BombCluster_03_UXO1_F',0.1,
		'BombCluster_02_UXO1_F',0.1,
		'BombCluster_01_UXO1_F',0.1,
		'BombCluster_03_UXO4_F',0.1,
		'BombCluster_02_UXO4_F',0.1,
		'BombCluster_01_UXO4_F',0.1,
		'BombCluster_03_UXO2_F',0.3,
		'BombCluster_02_UXO2_F',0.3,
		'BombCluster_01_UXO2_F',0.3,
		'BombCluster_03_UXO3_F',0.1,
		'BombCluster_02_UXO3_F',0.1,
		'BombCluster_01_UXO3_F',0.1
	]
};
if (_type isEqualTo 'minefield_types_1') exitWith {
	['APERSBoundingMine','APERSMine','ATMine']
};
if (_type isEqualTo 'minefield_types_2') exitWith {
	[
		'APERSBoundingMine',0.333,
		'APERSMine',0.5,
		'ATMine',0.167
	]
};
if (_type isEqualTo 'profilename_blacklisted_text_1') exitWith {
	// Blocked text
	[
		'Fuck','Shit','Cunt','Bitch','Nigger','Prick','Fag','Phag',
		'Penis','Vagina','Asshole','Gay','Lesbian','Cvnt',
		'Sh1t','Shlt','G4y','Fvck','H4ck','N1gger','Nlgger','pussy','pvssy','puzzy','pvzzy',
		'rape','r4pe','r4p3','rapist','r4pist','r4p1st','Server','Admin'
	]
};
if (_type isEqualTo 'zeus_modules_blocked_1') exitWith {
	// Disabled zeus modules
	[
		'modulepostprocess_f','moduleskiptime_f','moduletimemultiplier_f','moduleweather_f',
		'modulebootcampstage_f','modulehint_f','modulediary_f','modulecountdown_f','moduleendmission_f',
		'modulerespawntickets_f','modulemissionname_f','modulerespawninventory_f','modulerespawnpositionwest_f',
		'modulerespawnpositionciv_f','modulerespawnpositionguer_f','modulerespawnpositioneast_f','modulevehiclerespawnpositionwest_f',
		'modulevehiclerespawnpositionciv_f','modulevehiclerespawnpositionguer_f','modulevehiclerespawnpositioneast_f',
		'moduleobjectiveattackdefend_f','moduleobjectivesector_f','moduleobjectiveracecp_f','moduleobjectiveracefinish_f',
		'moduleobjectiveracestart_f','moduleanimalsbutterflies_f'
	]
};
if (_type isEqualTo 'zeus_addons_disabled_1') exitWith {
	// Disabled zeus addons
	[
		'a3_modules_f_curator_respawn',
		'a3_modules_f_curator_multiplayer',
		'a3_modules_f_kart',
		'a3_modules_f_mark_firingdrills',
		'a3_modules_f_curator_intel',
		'a3_modules_f_curator_environment',
		'a3_modules_f_curator_effects',
		'a3_characters_f_bootcamp',
		'a3_structures_f_bootcamp_vr_blocks',
		'a3_structures_f_bootcamp_vr_coverobjects',
		'a3_structures_f_bootcamp_vr_helpers',
		'a3_structures_f_exp_a_vr_blocks',
		'a3_structures_f_exp_a_vr_helpers',
		'a3_structures_f_mark_vr_helpers',
		'a3_structures_f_mark_vr_shapes',
		'a3_structures_f_mark_vr_targets',
		'a3_structures_f_heli_vr_helpers',
		'a3_modules_f_curator_lightning',
		'a3_data_f_curator_respawn',
		'curatoronly_modules_f_curator_environment',
		'curatoronly_modules_f_curator_lightning'
	]
};
if (_type isEqualTo 'airfield_objects_1') exitWith {
	[
		'land_runway_edgelight_blue_f','land_flush_light_green_f','land_flush_light_red_f','land_flush_light_yellow_f','runway_edgelight_blue_F',
		'flush_light_green_f','flush_light_red_f','flush_light_yellow_f','land_tenthangar_v1_f','tenthangar_v1_f','land_helipadsquare_f',
		'land_helipadcivil_f','land_helipadrescue_f','land_helipadcircle_f','land_helipadempty_f','helipadsquare_f','helipadcivil_f','helipadrescue_f',
		'helipadcircle_f','helipadempty_f'
	]
};
if (_type isEqualTo 'medic_animations_1') exitWith {
	[
		'ainvpknlmstpslaywrfldnon_medicother','ainvppnemstpslaywrfldnon_medicother','ainvppnemstpslaywnondnon_medicother','ainvpknlmstpslaywnondnon_medicother',
		'ainvpknlmstpslaywnondnon_medic','ainvpknlmstpslaywrfldnon_medic','ainvpknlmstpslaywpstdnon_medic','ainvppnemstpslaywnondnon_medic','ainvppnemstpslaywrfldnon_medic',
		'ainvppnemstpslaywpstdnon_medic'
	]
};
if (_type isEqualTo 'sitting_animations_1') exitWith {
	[
		'hubsittingchaira_idle1','hubsittingchaira_idle2','hubsittingchaira_idle3',
		'hubsittingchairb_idle1','hubsittingchairb_idle2','hubsittingchairb_idle3',
		'hubsittingchairc_idle1','hubsittingchairc_idle2','hubsittingchairc_idle3',
		'hubsittingchairua_idle1','hubsittingchairua_idle2','hubsittingchairua_idle3',
		'hubsittingchairub_idle1','hubsittingchairub_idle2','hubsittingchairub_idle3',
		'hubsittingchairuc_idle1','hubsittingchairuc_idle2','hubsittingchairuc_idle3'
	]
};
if (_type isEqualTo 'camonet_anims_1') exitWith {
	['showcamonethull','showcamonetcannon','showcamonetcannon1','showcamonetturret','showcamonetplates1','showcamonetplates2']
};
if (_type isEqualTo 'intro_music_1') exitWith {
	[
		['EventTrack01_F_Jets',0.1],			// Track + probability weighting
		['LeadTrack01_F_Jets',0.1],
		['LeadTrack02_F_Jets',0.1],
		['AmbientTrack02_F_Exp',0.1],
		['AmbientTrack02a_F_Exp',0.1],
		['AmbientTrack02b_F_Exp',0.1],
		['AmbientTrack02c_F_Exp',0.1],
		['AmbientTrack02d_F_Exp',0.1],
		['AmbientTrack01_F_Orange',0.1],
		['AmbientTrack02_F_Orange',0.1],
		['LeadTrack01_F_Orange',0.1],
		['LeadTrack01_F_Malden',0.1],
		['AmbientTrack04a_F_Tacops',0.1],
		['AmbientTrack04b_F_Tacops',0.1],
		['LeadTrack01_F_Tank',0.1],
		['LeadTrack02_F_Tank',0.1],
		['LeadTrack03_F_Tank',0.1],
		['LeadTrack04_F_Tank',0.1],
		['LeadTrack05_F_Tank',0.1],
		['LeadTrack06_F_Tank',0.1]
	]
};
if (_type isEqualTo 'intro_music_custom') exitWith {
	[
		'Intro',0.1,
		'Intro2',0.1,
		'Intro3',0.1,
		'Intro4',0.1,
		'Intro5',0.1,
		'Intro6',0.1
	]
};
if (_type isEqualTo 'soundplayed_volumes_1') exitWith {
	[
		1,		// NA
		1,		// Breath
		1,		// Breath Injured
		1,		// Breath Scuba
		1,		// Injured
		1,		// Pulsation
		1,		// Hit Scream
		2,		// Burning
		1,		// Drowning
		1,		// Drown
		1,		// Gasping
		1,		// Stabilizing
		2,		// Healing
		2,		// Healing With Medikit
		2,		// Recovered
		1		// Breath Held
	]
};
if (_type isEqualTo 'faction_flagtextures_1') exitWith {
	[
		'a3\Data_f\cfgFactionClasses_OPF_ca.paa',		// EAST
		'a3\Data_f\cfgFactionClasses_BLU_ca.paa',		// WEST
		'a3\Data_f\cfgFactionClasses_IND_ca.paa',		// RESISTANCE
		'a3\Data_f\cfgFactionClasses_CIV_ca.paa'		// CIVILIAN
	]
};
if (_type isEqualTo 'cfgfaces_1') exitWith {
	private _data = [];
	_excluded = ['default','custom'];
	{
		{
			private _className = toLowerANSI (configName _x);
			if (
				((getText (_x >> 'head')) isNotEqualTo '') &&
				(!(_className in _excluded)) &&
				(((getNumber (_x >> 'disabled')) isEqualTo 0) || {(['camo',_className] call QS_fnc_inString)})
			) then {
				_data pushBack [getText (_x >> 'displayName'),_className,{}];
			};
		} forEach ('true' configClasses _x);
	} forEach ('true' configClasses (configfile >> 'cfgfaces'));
	_data
};
if (_type isEqualTo 'heavy_cannons_1') exitWith {
	['cannon_120mm','cannon_120mm_long','cannon_125mm','cannon_125mm_advanced','cannon_railgun']
};
_return;