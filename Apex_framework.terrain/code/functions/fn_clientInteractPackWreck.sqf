/*/
File: fn_clientInteractPackWreck.sqf
Author:

	Quiksilver
	
Last modified:

	29/10/2023 A3 2.14 by Quiksilver
	
Description:
	
	Pack wreck into movable logistics container
__________________________________________________________________________/*/

private _packTime = 10;
getCursorObjectParams params ['_cursorObject','_selections','_cursorDistance'];
if (
	(alive _cursorObject) &&
	{(_cursorDistance < 15)} &&
	{(_cursorObject getVariable ['QS_logistics_wreck',FALSE])}
) then {
	if (
		(QS_player getUnitTrait 'engineer') ||
		((qs_core_classnames_itemtoolkits findAny ((items QS_player) apply {toLowerANSI _x})) isNotEqualTo -1)
	) then {
		_onCompleted = {
			getCursorObjectParams params ['_cursorObject','_cursorSelections','_cursorDistance'];
			if (
				(alive _cursorObject) &&
				{(_cursorDistance < 15)} &&
				{(_cursorObject getVariable ['QS_logistics_wreck',FALSE])} &&
				{(!(_cursorObject getVariable ['QS_logistics_packable',FALSE]))} &&
				{simulationEnabled _cursorObject} &&
				{(isNull (attachedTo _cursorObject))} &&
				{(isNull (ropeAttachedTo _cursorObject))} &&
				{((crew _cursorObject) isEqualTo [])} &&
				{((getVehicleCargo _cursorObject) isEqualTo [])} &&
				{((ropes _cursorObject) isEqualTo [])}
			) then {
				QS_player playActionNow 'PutDown';
				_dn = QS_hashmap_configfile getOrDefaultCall [
					format ['cfgvehicles_%1_displayname',toLowerANSI (typeOf _cursorObject)],
					{getText ((configOf _cursorObject) >> 'displayName')},
					TRUE
				];
				_text = format [localize 'STR_QS_Chat_182',profileName,(_cursorObject getVariable ['QS_ST_customDN',_dn]),mapGridPosition _cursorObject];
				['systemChat',_text] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
				[
					114,
					[
						_cursorObject,
						0,
						TRUE,
						[TRUE,typeOf _cursorObject,([_cursorObject,typeOf _cursorObject] call QS_fnc_getWreckType),(_cursorObject getVariable ['QS_ST_customDN',_dn])],
						TRUE
					]
				] remoteExec ['QS_fnc_remoteExec',2];
			};
		};
		_conditionCancel = {
			getCursorObjectParams params ['_cursorObject','_cursorSelections','_cursorDistance'];
			(
				(!alive _cursorObject) ||
				{!(_cursorObject getVariable ['QS_logistics_wreck',FALSE])} ||
				{(_cursorObject getVariable ['QS_logistics_packable',FALSE])} ||
				{(_cursorDistance >= 15)} ||
				{!simulationEnabled _cursorObject} ||
				{!(isNull (attachedTo _cursorObject))} ||
				{!(isNull (ropeAttachedTo _cursorObject))} ||
				{((crew _cursorObject) isNotEqualTo [])} ||
				{((getVehicleCargo _cursorObject) isNotEqualTo [])} ||
				{((ropes _cursorObject) isNotEqualTo [])}
			)
		};
		[localize 'STR_QS_Interact_145',_packTime,0,[[],{FALSE}],[[],_conditionCancel],[[],_onCompleted],[[],{FALSE}],FALSE,1,["\a3\ui_f\data\igui\cfg\actions\loadVehicle_ca.paa"]] spawn QS_fnc_clientProgressVisualization;
	} else {
		50 cutText [localize 'STR_QS_Text_470','PLAIN DOWN',0.5];	
	};
};