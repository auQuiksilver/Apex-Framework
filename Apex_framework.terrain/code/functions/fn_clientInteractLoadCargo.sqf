/*/
File: fn_clientInteractLoadCargo.sqf
Author:

	Quiksilver
	
Last Modified:

	27/05/2023 A3 2.12 by Quiksilver
	
Description:

	Load Vehicle Cargo
_____________________________________________________________/*/

(_this # 3) params ['_child','_parent'];
params ['','','','',['_bypass',FALSE]];
if ((getPlayerUID player) in QS_blacklist_logistics) exitWith {
	50 cutText [localize 'STR_QS_Text_388','PLAIN',0.3];
};
if (_parent isEqualType []) then {
	_parent = _parent apply { [_x distance _child,_x] };
	_parent sort TRUE;
	_parent = (_parent # 0) # 1;
};
if (
	(!alive _parent) ||
	{(!alive _child)} || 
	{(_parent getVariable ['QS_logistics_wreck',FALSE])}
) exitWith {
	50 cutText [localize 'STR_QS_Text_116','PLAIN DOWN',0.5];
};
_displayName1 = QS_hashmap_configfile getOrDefaultCall [
	format ['cfgvehicles_%1_displayname',toLowerANSI (typeOf _child)],
	{(getText ((configOf _child) >> 'displayName'))},
	TRUE
];
_displayName2 = QS_hashmap_configfile getOrDefaultCall [
	format ['cfgvehicles_%1_displayname',toLowerANSI (typeOf _parent)],
	{(getText ((configOf _parent) >> 'displayName'))},
	TRUE
];
if (_child getVariable ['QS_logistics_immovable',FALSE]) exitWith {50 cutText [localize 'STR_QS_Text_335','PLAIN DOWN',0.25];};
private _canLoad = [_parent,_child] call QS_fnc_canVehicleCargo;
if (!(_canLoad # 1)) exitWith {
	_result = [nil,nil,nil,nil,_parent,_child] call QS_fnc_clientInteractLoad;
	if (!(_result)) then {
		50 cutText [format [localize 'STR_QS_Text_348',(_child getVariable ['QS_ST_customDN',_displayName1]),(_parent getVariable ['QS_ST_customDN',_displayName2])],'PLAIN DOWN',0.333];
	};
};
if (!(_canLoad # 0)) exitWith {
	50 cutText [localize 'STR_QS_Text_349','PLAIN DOWN',0.333];
};
if (([_child,0] call QS_fnc_logisticsMovementDisallowed) && (!_bypass)) exitWith {
	50 cutText [localize 'STR_QS_Text_378','PLAIN',0.3];
};
if (([_child,1] call QS_fnc_logisticsMovementDisallowed) && (!_bypass)) exitWith {
	50 cutText [localize 'STR_QS_Text_444','PLAIN',0.3];
};
if (lockedInventory _parent) exitWith {
	50 cutText [format ['%1 %2',(_parent getVariable ['QS_ST_customDN',_displayName2]),localize 'STR_QS_Text_380'],'PLAIN DOWN',0.333];
};
private _text = '';
_boundingBox = QS_hashmap_boundingBoxes getOrDefaultCall [
	toLowerANSI (typeOf _child),
	{(0 boundingBoxReal _child)},
	TRUE
];
if (_child getVariable ['QS_logistics_virtual',FALSE]) exitWith {
	['SET_CLIENT',_parent,_child] call QS_fnc_virtualVehicleCargo;
};
if ([_parent,_child] call QS_fnc_setVehicleCargo) then {
	playSound3D [
		'A3\Sounds_F\sfx\ui\vehicles\vehicle_rearm.wss',
		_child,
		FALSE,
		(getPosASL _child),
		1,
		1,
		15
	];
	_text = format ['%1 %3 %2',(_child getVariable ['QS_ST_customDN',_displayName1]),(_parent getVariable ['QS_ST_customDN',_displayName2]),localize 'STR_QS_Text_114'];
	[_parent,TRUE,FALSE] call QS_fnc_updateCenterOfMass;
} else {
	_text = localize 'STR_QS_Text_116';
};
50 cutText [_text,'PLAIN DOWN',0.5];