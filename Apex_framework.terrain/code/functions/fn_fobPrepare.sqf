/*/
File: fn_fobPrepare.sqf
Author:

	Quiksilver
	
Last Modified:

	14/04/2023 A3 2.12 by Quiksilver

Description:

	Prepare FOB	
___________________________________________________/*/

params ['_type','_2'];
if (_type isEqualTo 0) then {
	//comment 'Deconstruct';	
	{
		missionNamespace setVariable _x;
	} forEach [
		['QS_module_fob_respawnTickets',(round (((QS_module_fob_flag getVariable ['QS_deploy_tickets',0]) / 2) max 0)),FALSE],
		['QS_module_fob_services_fuel',FALSE,TRUE],
		['QS_module_fob_services_repair',FALSE,TRUE],
		['QS_module_fob_services_ammo',FALSE,TRUE],
		['QS_module_fob_vehicleRespawnEnabled',FALSE,TRUE]
	];
	{
		_x setMarkerAlpha 0;
		_x setMarkerPos [-5000,-5000,0];
	} forEach [
		'QS_marker_veh_fieldservice_04',
		'QS_marker_veh_fieldservice_01'
	];
	deleteVehicle [
		(missionNamespace getVariable 'QS_module_fob_dataTerminal'),
		(missionNamespace getVariable 'QS_module_fob_supplycrate'),
		(missionNamespace getVariable 'QS_module_fob_repairDepot')
	];
	[(missionNamespace getVariable 'QS_module_fob_baseDataTerminal'),0] call (missionNamespace getVariable 'BIS_fnc_DataTerminalAnimate');
	{
		if (_x isEqualType objNull) then {
			(missionNamespace getVariable 'QS_garbageCollector') pushBack [_x,'NOW_DISCREET',0];
		};
	} forEach _2;
	(missionNamespace getVariable 'QS_garbageCollector') pushBack [(missionNamespace getVariable 'QS_module_fob_HQ'),'NOW_DISCREET',0];
	_array = [];
	'QS_marker_module_fob' setMarkerAlpha 0;
};
if (_type isEqualTo 1) then {
	_array = ['CREATE',_2] call (missionNamespace getVariable 'QS_fnc_fobAssets');
	missionNamespace setVariable ['QS_module_fob_displayName',(([_2] call (missionNamespace getVariable 'QS_data_fobs')) # 5),TRUE];
	'QS_marker_module_fob' setMarkerPosLocal (([_2] call (missionNamespace getVariable 'QS_data_fobs')) # 0);
	'QS_marker_module_fob' setMarkerTextLocal (format ['%1 %3 %2 (%4)',(toString [32,32,32]),(([_2] call (missionNamespace getVariable 'QS_data_fobs')) # 5),localize 'STR_QS_Marker_007',localize 'STR_QS_Marker_008']);
	'QS_marker_module_fob' setMarkerAlphaLocal 0.8;
	'QS_marker_module_fob' setMarkerColor 'ColorUnknown';
	missionNamespace setVariable ['QS_module_fob_side',sideUnknown,TRUE];
	[(missionNamespace getVariable 'QS_module_fob_flag'),(missionNamespace getVariable 'QS_module_fob_side'),'',FALSE,objNull,1] call (missionNamespace getVariable 'QS_fnc_setFlag');
};
_array;