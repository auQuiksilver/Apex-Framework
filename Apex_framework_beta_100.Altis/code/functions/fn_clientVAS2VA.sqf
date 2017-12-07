/*
File: fn_clientVAS2VA.sqf
Author:

	Quiksilver
	
Last modified:

	11/01/2017 A3 1.66 by Quiksilver
	
Description:

	-
________________________________________________________________*/

if (!isNil {profileNamespace getVariable 'QS_VAStoArsenal'}) exitWith {};
profileNamespace setVariable ['QS_VAStoArsenal',TRUE];
saveProfileNamespace;
private [
	'_index','_vasLoadout','_vasLoadout_title','_vasLoadout_primary','_vasLoadout_launcher','_vasLoadout_handgun','_vasLoadout_magazines',
	'_vasLoadout_uniform','_vasLoadout_vest','_vasLoadout_backpack','_vasLoadout_items','_vasLoadout_primItems','_vasLoadout_secItems',
	'_vasLoadout_handgunItems','_vasLoadout_uItems','_vasLoadout_vItems','_vasLoadout_bItems','_headgearTypes','_headgear','_gogglesTypes',
	'_binocularTypes','_binocular','_export','_data','_newName','_namespace'
];
_index = 0;
_headgear = '';
_goggles = '';
_binocularTypes = ['Rangefinder','Binocular','Laserdesignator','Laserdesignator_02','Laserdesignator_03','Laserdesignator_01_khk_F','Laserdesignator_02_ghex_F'];
_binocular = '';
_namespace = profileNamespace;
for '_x' from 0 to 24 step 1 do {
	_vasLoadout = profileNamespace getVariable [(format ['vas_gear_new_%1',_index]),[]];
	if (!(_vasLoadout isEqualTo [])) then {
		_vasLoadout params [
			'_vasLoadout_title',
			'_vasLoadout_primary',
			'_vasLoadout_launcher',
			'_vasLoadout_handgun',
			'_vasLoadout_magazines',
			'_vasLoadout_uniform',
			'_vasLoadout_vest',
			'_vasLoadout_backpack',
			'_vasLoadout_items',
			'_vasLoadout_primItems',
			'_vasLoadout_secItems',
			'_vasLoadout_handgunItems',
			'_vasLoadout_uItems',
			'_vasLoadout_vItems',
			'_vasLoadout_bItems'
		];
		{
			if (['H_',_x,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) then {
				_headgear = _x;
			};
			if (_x in _binocularTypes) then {
				_binocular = _x;
			};
		} forEach _vasLoadout_items;
		_export = [];
		_export = [
			[_vasLoadout_uniform,_vasLoadout_uItems],
			[_vasLoadout_vest,_vasLoadout_vItems],
			[_vasLoadout_backpack,_vasLoadout_bItems],
			_headgear,
			_goggles,
			_binocular,
			[_vasLoadout_primary,_vasLoadout_primItems,((getArray (configFile >> 'CfgWeapons' >> _vasLoadout_primary >> 'magazines')) select 0)],
			[_vasLoadout_launcher,_vasLoadout_secItems,((getArray (configFile >> 'CfgWeapons' >> _vasLoadout_launcher >> 'magazines')) select 0)],
			[_vasLoadout_handgun,_vasLoadout_handgunItems,((getArray (configFile >> 'CfgWeapons' >> _vasLoadout_handgun >> 'magazines')) select 0)],
			['ItemMap','ItemCompass','ItemWatch','ItemRadio','ItemGPS'],
			[(face player),'','']
		];
		_newName = format ['%1 (Imported %2)',_vasLoadout_title,_index];
		_data = _namespace getVariable ['bis_fnc_saveInventory_data',[]];
		_nameID = _data find _newName;
		if (_nameID < 0) then {
			_nameID = count _data;
			_data set [_nameID,_newName];
		};
		_data set [_nameID + 1,_export];
		_namespace setVariable ['bis_fnc_saveInventory_data',_data];
		saveProfileNamespace;
	};
	_index = _index + 1;
	uiSleep 0.1;
};