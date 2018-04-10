/*/
File: fn_fobPrepare.sqf
Author:

	Quiksilver
	
Last Modified:

	9/11/2017 A3 1.76 by Quiksilver

Description:

	Prepare FOB
___________________________________________________/*/

params ['_type','_2'];
if (_type isEqualTo 0) then {
	comment 'Deconstruct';
	{
		missionNamespace setVariable _x;
	} forEach [
		['QS_module_fob_respawnTickets',(round (((missionNamespace getVariable ['QS_module_fob_respawnTickets',0]) / 2) max 0)),TRUE],
		['QS_module_fob_services_fuel',FALSE,TRUE],
		['QS_module_fob_services_repair',FALSE,TRUE],
		['QS_module_fob_services_ammo',FALSE,TRUE],
		['QS_module_fob_client_respawnEnabled',FALSE,TRUE],
		['QS_module_fob_vehicleRespawnEnabled',FALSE,TRUE]
	];
	{
		_x setMarkerAlpha 0;
		_x setMarkerPos [-5000,-5000,0];
	} forEach [
		'QS_marker_veh_fieldservice_04',
		'QS_marker_veh_fieldservice_01'
	];
	{
		missionNamespace setVariable [
			'QS_analytics_entities_deleted',
			((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),
			FALSE
		];
		deleteVehicle _x;
	} forEach [
		(missionNamespace getVariable 'QS_module_fob_dataTerminal'),
		(missionNamespace getVariable 'QS_module_fob_supplycrate')
	];
	[(missionNamespace getVariable 'QS_module_fob_baseDataTerminal'),0] call (missionNamespace getVariable 'BIS_fnc_DataTerminalAnimate');
	{
		if (_x isEqualType objNull) then {
			0 = (missionNamespace getVariable 'QS_garbageCollector') pushBack [_x,'NOW_DISCREET',0];
		};
	} count _2;
	(missionNamespace getVariable 'QS_garbageCollector') pushBack [(missionNamespace getVariable 'QS_module_fob_HQ'),'NOW_DISCREET',0];
	_array = [];
	'QS_marker_module_fob' setMarkerAlpha 0;
};
if (_type isEqualTo 1) then {
	comment 'Construct';
	_array = [
		(([_2] call (missionNamespace getVariable 'QS_data_fobs')) select 0),
		0,
		(([_2] call (missionNamespace getVariable 'QS_data_fobs')) select 1),
		FALSE
	] call (missionNamespace getVariable 'QS_fnc_serverObjectsMapper');
	missionNamespace setVariable ['QS_module_fob_displayName',(([_2] call (missionNamespace getVariable 'QS_data_fobs')) select 5),TRUE];
	'QS_marker_module_fob' setMarkerPos (([_2] call (missionNamespace getVariable 'QS_data_fobs')) select 0);
	'QS_marker_module_fob' setMarkerText (format ['%1FOB %2 (Click for status)',(toString [32,32,32]),(([_2] call (missionNamespace getVariable 'QS_data_fobs')) select 5)]);
	'QS_marker_module_fob' setMarkerAlpha 0.8;
	'QS_marker_module_fob' setMarkerColor 'ColorUnknown';
	missionNamespace setVariable ['QS_module_fob_side',sideUnknown,TRUE];
	[(missionNamespace getVariable 'QS_module_fob_flag'),(missionNamespace getVariable 'QS_module_fob_side'),'',FALSE,objNull,1] call (missionNamespace getVariable 'QS_fnc_setFlag');
};
_array;