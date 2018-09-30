/*/
File: fn_scBrief.sqf
Author: 

	Quiksilver

Last Modified:

	17/05/2017 A3 1.70 by Quiksilver

Description:

	Aware clients
____________________________________________________________________________/*/

params ['_type','_data'];
if (_type isEqualTo 0) exitWith {
	_data params ['_scWinningSide','_duration'];
	{
		_x setMarkerColor 'ColorOPFOR';
		_x setMarkerAlpha 0;
	} forEach [
		'QS_marker_aoCircle',
		'QS_marker_aoMarker'
	];
	missionNamespace setVariable ['QS_missionStatus_SC_canShow',FALSE,TRUE];
	//comment 'Communicate here';
	if (_scWinningSide in [0,2]) then {
		//comment 'Mission failed!';
		['SC_EXIT_BAD',['','Mission failed...']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
		[
			[],
			{
				playSound 'QS_SC_outro_lose';
				if (!isStreamFriendlyUIEnabled) then {
					_text = parseText format ["<t align='center' size='2'>Mission Failed</t><br/><br/><img size='7' image='%1'/><br/><br/>The enemy dominated us soldiers, get ready for the next one!",'\a3\Data_f_exp\Flags\flag_viper_co.paa'];
					(missionNamespace getVariable 'QS_managed_hints') pushBack [2,FALSE,7.5,-1,_text,[],-1];
				};
			}
		] remoteExec ['spawn',-2,FALSE];
	} else {
		//comment 'Mission complete!';
		['SC_EXIT_GOOD',['','Mission complete!']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
		[
			[],
			{
				playSound 'QS_SC_outro_win';
				if (!isStreamFriendlyUIEnabled) then {
					_text = parseText format ["<t align='center' size='2'>Mission Success</t><br/><br/><img size='7' image='%1'/><br/><br/>We dominated them soldiers, get ready for the next one!",(missionNamespace getVariable ['QS_missionConfig_textures_defaultFlag','a3\data_f\flags\flag_nato_co.paa'])];
					(missionNamespace getVariable 'QS_managed_hints') pushBack [2,FALSE,7.5,-1,_text,[],-1];
				};
			}
		] remoteExec ['spawn',-2,FALSE];
	};
};
if (_type isEqualTo 1) exitWith {
	{
		_x params [
			'_flagData',
			'_sectorAreaObjects',
			'_locationData',
			'_objectData',
			'_markerData',
			'_taskData'
		];
		{
			_x setMarkerAlpha 0.75;
		} count _markerData;
	} forEach _data;
	{
		_x setMarkerColor 'ColorOPFOR';
		_x setMarkerAlpha 0.8;
	} forEach [
		'QS_marker_aoCircle',
		'QS_marker_aoMarker'
	];
	if (!((missionNamespace getVariable 'QS_virtualSectors_sub_1_markers') isEqualTo [])) then {
		{
			_x setMarkerColor 'ColorOPFOR';
			_x setMarkerAlpha 0.5;
		} forEach (missionNamespace getVariable 'QS_virtualSectors_sub_1_markers');
	};
	if (!((missionNamespace getVariable 'QS_virtualSectors_sub_2_markers') isEqualTo [])) then {
		{
			_x setMarkerColor 'ColorOPFOR';
			_x setMarkerAlpha 0.5;
		} forEach (missionNamespace getVariable 'QS_virtualSectors_sub_2_markers');
	};
	if (!((missionNamespace getVariable 'QS_virtualSectors_sub_3_markers') isEqualTo [])) then {
		{
			_x setMarkerColor 'ColorOPFOR';
			_x setMarkerAlpha 0.5;
		} forEach (missionNamespace getVariable 'QS_virtualSectors_sub_3_markers');
	};
	if (!((missionNamespace getVariable 'QS_ao_aaMarkers') isEqualTo [])) then {
		{
			if (_x in allMapMarkers) then {
				_x setMarkerAlpha 0.5;
			};
		} forEach (missionNamespace getVariable 'QS_ao_aaMarkers');
	};
	if (!((missionNamespace getVariable 'QS_virtualSectors_siteMarkers') isEqualTo [])) then {
		{
			_x setMarkerAlpha 0.5;
		} forEach (missionNamespace getVariable 'QS_virtualSectors_siteMarkers');
	};
	//comment 'Communicate here';	
	['SC_INIT',['','Secure all objectives!']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
	missionNamespace setVariable ['QS_missionStatus_SC_canShow',TRUE,TRUE];
};