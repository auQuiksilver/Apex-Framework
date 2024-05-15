/*/
File: fn_clientInteractCreateBoat.sqf
Author:

	Quiksilver
	
Last modified:
	
	24/12/2022 A3 2.10 by Quiksilver
	
Description:

	Engineer creates a boat and consumes a toolkit
_______________________________________________________/*/

_items = (items player) apply {toLowerANSI _x};
if (
	(!isNull (objectParent player)) ||
	{(((_items apply {toLowerANSI _x}) findAny QS_core_classNames_itemToolKits) isEqualTo -1)}
) exitWith {
	50 cutText [localize 'STR_QS_Text_312','PLAIN DOWN',0.5];		// To Do: Localize
};
if (
	!(player isNil 'QS_client_createdBoat') &&
	{(alive (player getVariable 'QS_client_createdBoat'))}
) exitWith {
	50 cutText [(format ['%2 %1',(mapGridPosition (player getVariable 'QS_client_createdBoat')),localize 'STR_QS_Text_095']),'PLAIN DOWN'];
};
private _itemIndex = _items findAny QS_core_classNames_itemToolKits;
private _itemType = _items # _itemIndex;
player removeItem _itemType;
player setVariable ['QS_client_createdBoat_itemType',_itemType,FALSE];
private _boatType = ['B_Lifeboat','B_Boat_Transport_01_F'] select ((!underwater player) && (((eyePos player) # 2) > 0.25));
private _position = player modelToWorld [0,15,0];
_position set [2,1];
[37,profileName,[_boatType,_position,[],0,'NONE'],(getDir player),_position,clientOwner,player] remoteExec ['QS_fnc_remoteExec',2,FALSE];
_dn = QS_hashmap_configfile getOrDefaultCall [
	format ['cfgvehicles_%1_displayname',toLowerANSI (typeOf _boatType)],
	{getText ((configOf _boatType) >> 'displayName')},
	TRUE
];
50 cutText [(format ['%1 %2',_dn,localize 'STR_QS_Text_096']),'PLAIN DOWN',0.75];