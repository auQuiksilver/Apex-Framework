/*
File: fn_clientInteractRespawnVehicle.sqf
Author:

	Quiksilver
	
Last Modified:

	20/02/2023 A3 2.12 by Quiksilver
	
Description:

	- Client can respawn a vehicle via action menu
_____________________________________________________________*/

private ['_t','_text'];
_t = cursorObject;
if (
	(!simulationEnabled _t) ||
	{(!local _t)} ||
	{(((vectorMagnitude (velocity _t)) * 3.6) > 1)} ||
	{(((crew _t) findIf {(alive _x)}) isNotEqualTo -1)} ||
	{(diag_tickTime < (uiNamespace getVariable ['QS_RD_canRespawnVehicle',-1]))} ||
	{(!(_t getVariable ['QS_RD_vehicleRespawnable',FALSE]))} ||
	{((['LandVehicle','Air','Ship'] findIf { _t isKindOf _x }) isEqualTo -1)}
) exitWith {};
if ((getVehicleCargo _t) isNotEqualTo []) exitWith {
	50 cutText [localize 'STR_QS_Text_122','PLAIN',0.3];
};
if (!isNull (getSlingLoad _t)) exitWith {
	50 cutText [localize 'STR_QS_Text_123','PLAIN',0.3];
};
if (_t getVariable ['QS_logistics_blocked',FALSE]) exitWith {
	50 cutText [localize 'STR_QS_Chat_171','PLAIN DOWN',0.333];
};
if (
	((ropes _t) isNotEqualTo []) ||
	{(!(isNull (ropeAttachedTo _t)))}
) exitWith {
	50 cutText [localize 'STR_QS_Text_124','PLAIN',0.3];
};
if (!(isNull (attachedTo _t))) exitWith {
	50 cutText [localize 'STR_QS_Text_125','PLAIN',0.3];
};
if (_t getVariable ['QS_logistics_wreck',FALSE]) exitWith {
	50 cutText [localize 'STR_QS_Text_384','PLAIN',0.333];
};
_displayName = QS_hashmap_configfile getOrDefaultCall [
	format ['cfgvehicles_%1_displayname',toLowerANSI (typeOf _t)],
	{getText ((configOf _t) >> 'displayName')},
	TRUE
];
private _itemType = QS_core_classNames_itemToolKit;
private _result = [(format ['%2 %1',_displayName,localize 'STR_QS_Menu_121']),localize 'STR_QS_Menu_122',localize 'STR_QS_Menu_123',localize 'STR_QS_Menu_114',(findDisplay 46),FALSE,FALSE] call (missionNamespace getVariable 'BIS_fnc_guiMessage'); 
if (_result) then {
	uiNamespace setVariable ['QS_RD_canRespawnVehicle',(diag_tickTime + 120)];
	player playAction 'PutDown';
	playSound 'ClickSoft';
	50 cutText [localize 'STR_QS_Text_126','PLAIN DOWN',0.5];
	([QS_player,'SAFE'] call QS_fnc_inZone) params ['_inSafezone','_safezoneLevel','_safezoneActive'];
	if (((crew _t) findIf {(alive _x)}) isEqualTo -1) then {
		if (!_inSafezone) then {
			_text = format [localize 'STR_QS_Chat_093',profileName,_displayName,(mapGridPosition player)];
			['systemChat',_text] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
		};
		if (
			(alive (player getVariable ['QS_client_createdBoat',objNull])) &&
			{(_t isEqualTo (player getVariable ['QS_client_createdBoat',objNull]))} &&
			{((backpack player) isNotEqualTo '')} &&
			{(player canAddItemToBackpack [_itemType,1])}
		) then {
			if ((player getVariable ['QS_client_createdBoat_itemType','']) isNotEqualTo '') then {
				_itemType = player getVariable ['QS_client_createdBoat_itemType',QS_core_classNames_itemToolKit];
			};
			player addItemToBackpack _itemType;
			50 cutText [(format [localize 'STR_QS_Text_127',_displayName]),'PLAIN DOWN'];
		};
		if (!_inSafezone) then {
			[46,[player,2]] remoteExec ['QS_fnc_remoteExec',2,FALSE];
			['ScoreBonus',[(format ['%2 %1',(missionNamespace getVariable ['QS_terrain_worldName',worldName]),localize 'STR_QS_Notif_041']),'2']] call (missionNamespace getVariable 'QS_fnc_showNotification');	
		};
		[17,_t,true] remoteExec ['QS_fnc_remoteExec',2,FALSE];
	};
} else {
	50 cutText [localize 'STR_QS_Text_128','PLAIN',0.3];
};