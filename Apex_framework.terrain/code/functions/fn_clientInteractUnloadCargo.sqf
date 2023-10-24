/*
File: fn_clientInteractUnloadCargo.sqf
Author:

	Quiksilver
	
Last Modified:

	30/01/2023 A3 2.12 by Quiksilver
	
Description:

	-
___________________________________________*/

getCursorObjectParams params ['_cursorObject1','_cursorSelections','_cursorDistance'];
params [['_object',_cursorObject1],['_menuSelected',0]];
if (isNull _object) exitWith {systemchat (localize 'STR_QS_Text_459');};
if ((getPlayerUID player) in QS_blacklist_logistics) exitWith {
	50 cutText [localize 'STR_QS_Text_388','PLAIN',0.3];
};
_simulation = QS_hashmap_configfile getOrDefaultCall [
	format ['cfgvehicles_%1_simulation',toLowerANSI (typeOf _object)],
	{toLowerANSI (getText ((configOf _object) >> 'simulation'))},
	TRUE
];
_hasCargo = (
	(
		((getVehicleCargo _object) isNotEqualTo []) ||
		{(((attachedObjects _object) select {
			(_x getVariable ['QS_logistics',FALSE])
		}) isNotEqualTo [])} ||
		{((_object getVariable ['QS_virtualCargo',[]]) isNotEqualTo [])}
	) && 
	{(_menuSelected isEqualTo 0)}
);
if (_hasCargo && {((lockedInventory _object) || {(_object getVariable ['QS_lockedInventory',FALSE])})}) exitWith {
	50 cutText [localize 'STR_QS_Text_379','PLAIN',0.333];
};
if (
	(_object getVariable ['QS_logistics_unloadReqDep',FALSE]) &&
	{(!(_object getVariable ['QS_logistics_deployed',FALSE]))} &&
	{(isNull (attachedTo _object))} &&
	{(isNull (isVehicleCargo _object))}
) exitWith {
	50 cutText [localize 'STR_QS_Text_452','PLAIN DOWN',0.333];
};
if (_hasCargo) exitWith {
	createDialog 'QS_RD_client_dialog_menu_unloadCargo';
};
private _isCargo = (
	(_menuSelected isNotEqualTo 0) ||
	{(!isNull (isVehicleCargo _object))} ||
	{([0,_object,objNull] call (missionNamespace getVariable 'QS_fnc_getCustomCargoParams'))} ||
	{(((toLowerANSI _simulation) in ['house','thingx','tankx','helicopterrtd']) && (_object getVariable ['QS_logistics',FALSE]))}
);
if (!_isCargo) exitWith {50 cutText [localize 'STR_QS_Text_374','PLAIN DOWN',0.333];};
_displayName = QS_hashmap_configfile getOrDefaultCall [
	format ['cfgvehicles_%1_displayname',toLowerANSI (typeOf _object)],
	{(getText ((configOf _object) >> 'displayName'))},
	TRUE
];
if ([_object,1] call QS_fnc_logisticsMovementDisallowed) exitWith {
	50 cutText [localize 'STR_QS_Text_386','PLAIN',0.3];
};
private _hasUnloaded = FALSE;
if (
	([0,_object,objNull] call (missionNamespace getVariable 'QS_fnc_getCustomCargoParams')) && 
	{((stance player) isEqualTo 'STAND')} && 
	{([4,_object,player] call (missionNamespace getVariable 'QS_fnc_getCustomCargoParams'))} &&
	{(isNull (missionNamespace getVariable ['QS_logistics_localTarget',objNull]))}
) then {
	_hasUnloaded = TRUE;
	[QS_player,_object,FALSE,TRUE] call QS_fnc_unloadCargoPlacementMode;
} else {
	if (!isNull (isVehicleCargo _object)) then {
		['setVehicleCargo',objNull,_object] remoteExec ['QS_fnc_remoteExecCmd',[_object,(isVehicleCargo _object)],FALSE];
		_hasUnloaded = TRUE;
		playSound 'Click';
		if (isObjectHidden _object) then {
			[71,_object,FALSE] remoteExec ['QS_fnc_remoteExec',2,FALSE];
		};
	} else {
		_position = (position player) findEmptyPosition [0,10,(typeOf _object)];
		if (_position isNotEqualTo []) then {
			_hasUnloaded = TRUE;
			playSound 'Click';
			if (isObjectHidden _object) then {
				[71,_object,FALSE] remoteExec ['QS_fnc_remoteExec',2,FALSE];
			};
			[0,_object] call QS_fnc_eventAttach;		
			_object setVectorUp (surfaceNormal _position);
			_object setPos _position;
			_object allowDamage FALSE;
			50 cutText [(format [localize 'STR_QS_Text_165',(_object getVariable ['QS_ST_customDN',_displayName])]),'PLAIN DOWN',0.3];
		} else {
			50 cutText [localize 'STR_QS_Text_166','PLAIN DOWN',0.3];
		};
	};
};
if (!_hasUnloaded) exitWith {
	50 cutText [localize 'STR_QS_Text_372','PLAIN DOWN',0.333];
};