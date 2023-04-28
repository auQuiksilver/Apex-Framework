/*/
File: fn_safezones.sqf
Author:
	
	Quiksilver
	
Last Modified:

	18/02/2023 A3 2.12 by Quiksilver
	
Description:

	Safezone module
	
Notes:

	Level 1 safezone = Friendly fire disabled
	
	Level 2 safezone = Friendly fire disabled + firing disabled
	
	['ID',reference (pos or obj),type,shape (polygon or radius),area,
	
	QS_system_safezones
______________________________________________________/*/

params ['_mode'];
comment 'Client component';
if (_mode isEqualTo 'INSIDE') exitWith {
	_cameraOn = cameraOn;
};
if (_mode isEqualTo 'ON_INSIDE') exitWith {
	_cameraOn = cameraOn;
};
if (_mode isEqualTo 'ON_OUTSIDE') exitWith {
	_cameraOn = cameraOn;
};

comment 'Server component';
if (_mode isEqualTo 'ADD') exitWith {
	params ['','_data'];
	_data params ['_id'];
	if ((QS_system_safezones findIf { ((_x # 0) isEqualTo _id) }) isEqualTo -1) then {
		QS_system_safezones pushBack _data;
		missionNamespace setVariable ['QS_system_safezones',QS_system_safezones,TRUE];
	};
};
if (_mode isEqualTo 'REMOVE') exitWith {
	params ['','_id'];
	_index = QS_system_safezones findIf { ((_x # 0) isEqualTo _id) };
	if (_index isNotEqualTo -1) then {
		QS_system_safezones deleteAt _index;
		missionNamespace setVariable ['QS_system_safezones',QS_system_safezones,TRUE];
	};
};
if (_mode isEqualTo 'UPDATE') exitWith {
	_index = QS_system_safezones findIf { ((_x # 0) isEqualTo _id) };
	if (_index isNotEqualTo -1) then {

	};
};
