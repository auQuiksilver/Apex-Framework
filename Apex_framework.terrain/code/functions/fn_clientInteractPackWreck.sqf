/*/
File: fn_clientInteractPackWreck.sqf
Author:

	Quiksilver
	
Last modified:

	4/10/2023 A3 2.12 by Quiksilver
	
Description:
	
	Pack wreck into movable logistics container
__________________________________________________________________________/*/

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
		QS_player playActionNow 'PutDown';
		_dn = QS_hashmap_configfile getOrDefaultCall [
			format ['cfgvehicles_%1_displayname',toLowerANSI (typeOf _cursorObject)],
			{getText ((configOf _cursorObject) >> 'displayName')},
			TRUE
		];
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
	} else {
		50 cutText [localize 'STR_QS_Text_470','PLAIN DOWN',0.5];	
	};
};