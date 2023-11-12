/*/
File: fn_clientInteractPackEntity.sqf
Author:

	Quiksilver
	
Last modified:

	11/11/2023 A3 2.12 by Quiksilver
	
Description:
	
	Pack entity into cargo parent
____________________________________________/*/

private _packTime = 30;
getCursorObjectParams params ['_cursorObject','_cursorSelections','_cursorDistance'];
if (
	(!(_cursorObject getVariable ['QS_logistics_packable',FALSE])) &&
	{(!(_cursorObject getVariable ['QS_logistics_isCargoParent',FALSE]))} &&
	{((['Air','LandVehicle','Ship','Cargo_base_F'] findIf { _cursorObject isKindOf _x }) isEqualTo -1)}
) exitWith {
	50 cutText [localize 'STR_QS_Text_476','PLAIN DOWN',0.25];
};
if ((([_cursorObject,30] call QS_fnc_isNearServiceCargo) findIf { ((_x # 1) in ['repair','recover']) }) isEqualTo -1) exitWith {
	50 cutText [localize 'STR_QS_Text_478','PLAIN DOWN',0.25];
};
if (
	(QS_player getUnitTrait 'engineer') ||
	((qs_core_classnames_itemtoolkits findAny ((items QS_player) apply {toLowerANSI _x})) isNotEqualTo -1)
) then {
	if (
		(_cursorObject getVariable ['QS_logistics_isCargoParent',FALSE]) &&
		{(((attachedObjects _cursorObject) findIf { (_x getVariable ['QS_logistics_packed',FALSE]) }) isNotEqualTo -1)}
	) exitWith {
		_onCompleted = {
			getCursorObjectParams params ['_cursorObject','_cursorSelections','_cursorDistance'];
			if (
				(_cursorObject getVariable ['QS_logistics_isCargoParent',FALSE]) &&
				{(((attachedObjects _cursorObject) findIf { (_x getVariable ['QS_logistics_packed',FALSE]) }) isNotEqualTo -1)}
			) then {
				QS_player playActionNow 'PutDown';
				[120,0,[_cursorObject,profileName]] remoteExec ['QS_fnc_remoteExec',2,FALSE];
			};
		};
		_conditionCancel = {
			getCursorObjectParams params ['_cursorObject','_cursorSelections','_cursorDistance'];
			(
				(!alive _cursorObject) ||
				{(_cursorDistance >= 15)} ||
				{(!(_cursorObject getVariable ['QS_logistics_isCargoParent',FALSE]))} ||
				{(((attachedObjects _cursorObject) findIf { (_x getVariable ['QS_logistics_packed',FALSE]) }) isEqualTo -1)} ||
				{!simulationEnabled _cursorObject} ||
				{(!isNull (attachedTo _cursorObject))} ||
				{(!isNull (ropeAttachedTo _cursorObject))} ||
				{(((crew _cursorObject) findIf {(alive _x)}) isNotEqualTo -1)} ||
				{((getVehicleCargo _cursorObject) isNotEqualTo [])} ||
				{((ropes _cursorObject) isNotEqualTo [])} ||
				{((([_cursorObject,30] call QS_fnc_isNearServiceCargo) findIf { ((_x # 1) in ['repair','recover']) }) isEqualTo -1)}
			)
		};
		[localize 'STR_QS_Interact_146',_packTime,0,[[],{FALSE}],[[],_conditionCancel],[[],_onCompleted],[[],{FALSE}],FALSE,1,["\a3\ui_f\data\igui\cfg\actions\unloadVehicle_ca.paa"]] spawn QS_fnc_clientProgressVisualization;
	};
	if (
		(alive _cursorObject) &&
		{(_cursorObject getVariable ['QS_logistics_packable',FALSE])} &&
		{!(_cursorObject getVariable ['QS_logistics_wreck',FALSE])} &&
		{!(_cursorObject getVariable ['QS_logistics_deployed',FALSE])} &&
		{!(_cursorObject getVariable ['QS_logistics_packed',FALSE])} &&
		{(_cursorDistance < 15)} &&
		{simulationEnabled _cursorObject} &&
		{(isNull (attachedTo _cursorObject))} &&
		{(isNull (ropeAttachedTo _cursorObject))} &&
		{(((crew _cursorObject) findIf {(alive _x)}) isEqualTo -1)} &&
		{((getVehicleCargo _cursorObject) isEqualTo [])} &&
		{((ropes _cursorObject) isEqualTo [])} &&
		{((([_cursorObject,30] call QS_fnc_isNearServiceCargo) findIf { ((_x # 1) in ['repair','recover']) }) isNotEqualTo -1)}
	) then {
		_onCompleted = {
			getCursorObjectParams params ['_cursorObject','_cursorSelections','_cursorDistance'];
			if (
				(alive _cursorObject) &&
				{(_cursorObject getVariable ['QS_logistics_packable',FALSE])} &&
				{!(_cursorObject getVariable ['QS_logistics_wreck',FALSE])} &&
				{!(_cursorObject getVariable ['QS_logistics_deployed',FALSE])} &&
				{!(_cursorObject getVariable ['QS_logistics_packed',FALSE])} &&
				{(_cursorDistance < 15)} &&
				{simulationEnabled _cursorObject} &&
				{(isNull (attachedTo _cursorObject))} &&
				{(isNull (ropeAttachedTo _cursorObject))} &&
				{(((crew _cursorObject) findIf {(alive _x)}) isEqualTo -1)} &&
				{((getVehicleCargo _cursorObject) isEqualTo [])} &&
				{((ropes _cursorObject) isEqualTo [])} &&
				{((([_cursorObject,30] call QS_fnc_isNearServiceCargo) findIf { ((_x # 1) in ['repair','recover']) }) isNotEqualTo -1)}
			) then {
				QS_player playActionNow 'PutDown';
				[120,1,[_cursorObject,profileName]] remoteExec ['QS_fnc_remoteExec',2,FALSE];
			};
		};
		_conditionCancel = {
			getCursorObjectParams params ['_cursorObject','_cursorSelections','_cursorDistance'];
			(
				(!alive _cursorObject) ||
				{!(_cursorObject getVariable ['QS_logistics_packable',FALSE])} ||
				{(_cursorObject getVariable ['QS_logistics_wreck',FALSE])} ||
				{(_cursorObject getVariable ['QS_logistics_deployed',FALSE])} ||
				{(_cursorObject getVariable ['QS_logistics_packed',FALSE])} ||
				{(_cursorDistance >= 15)} ||
				{!simulationEnabled _cursorObject} ||
				{!(isNull (attachedTo _cursorObject))} ||
				{!(isNull (ropeAttachedTo _cursorObject))} ||
				{(((crew _cursorObject) findIf {(alive _x)}) isNotEqualTo -1)} ||
				{((getVehicleCargo _cursorObject) isNotEqualTo [])} ||
				{((ropes _cursorObject) isNotEqualTo [])} ||
				{(lockedInventory _cursorObject)} ||
				{((([_cursorObject,30] call QS_fnc_isNearServiceCargo) findIf { ((_x # 1) in ['repair','recover']) }) isEqualTo -1)}
			)
		};
		[localize 'STR_QS_Interact_145',_packTime,0,[[],{FALSE}],[[],_conditionCancel],[[],_onCompleted],[[],{FALSE}],FALSE,1,["\a3\ui_f\data\igui\cfg\actions\loadVehicle_ca.paa"]] spawn QS_fnc_clientProgressVisualization;
	} else {
		if (!(_cursorObject getVariable ['QS_logistics_packable',FALSE])) then {
			50 cutText [localize 'STR_QS_Text_475','PLAIN DOWN',0.25];	
		};
	};
} else {
	50 cutText [localize 'STR_QS_Text_470','PLAIN DOWN',0.25];
};