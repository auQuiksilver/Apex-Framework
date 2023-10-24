/*
File: fn_clientInteractDrag.sqf
Author:

	Quiksilver
	
Last Modified:

	13/02/2023 A3 2.12 by Quiksilver
	
Description:

	-
_________________________________________________*/

private _t = cursorTarget;
if (
	(!alive _t) ||
	{(!isNull (attachedTo _t))} ||
	{(!isNull (objectParent _t))} ||
	{((!(_t isKindOf 'CAManBase')) && (!([0,_t,objNull] call (missionNamespace getVariable 'QS_fnc_getCustomCargoParams'))) && (!(_t getVariable ['QS_RD_draggable',FALSE])))} ||
	{((_t isKindOf 'StaticWeapon') && (!(unitIsUav _t)) && (((crew _t) findIf {(alive _x)}) isNotEqualTo -1))}
) exitWith {};
if (_t getVariable ['QS_interaction_disabled',FALSE]) exitWith {
	50 cutText [localize 'STR_QS_Text_087','PLAIN',0.3];
};
if (_t getVariable ['QS_unit_needsStabilise',FALSE]) exitWith {
	50 cutText [localize 'STR_QS_Text_088','PLAIN',0.3];
};
if ([_t,0] call QS_fnc_logisticsMovementDisallowed) exitWith {
	50 cutText [localize 'STR_QS_Text_378','PLAIN',0.3];
};
if (_t getVariable ['QS_logistics_immovable',FALSE]) exitWith {50 cutText [localize 'STR_QS_Text_335','PLAIN DOWN',0.25];};
disableUserInput TRUE;
[0.5] spawn (missionNamespace getVariable 'QS_fnc_clientDisableUserInput');
_boundingBox = QS_hashmap_boundingBoxes getOrDefaultCall [
	toLowerANSI (typeOf _t),
	{(0 boundingBoxReal _t)},
	TRUE
];
if (_t isKindOf 'CAManBase') exitWith {
	_t setVariable ['QS_RD_storedAnim',(animationState _t),TRUE];
	_t setPosWorld ((getPosWorld player) vectorAdd ((vectorDir player) vectorMultiply 1.5));
	for '_x' from 0 to 1 step 1 do {
		_t setVariable ['QS_RD_dragged',TRUE,TRUE];
		_t setVariable ['QS_RD_interacting',TRUE,TRUE];
		player setVariable ['QS_RD_interacting',TRUE,TRUE];
		player setVariable ['QS_RD_dragging',TRUE,TRUE];
	};
	[1,_t,[player,[0,1.1,0.092]]] call QS_fnc_eventAttach;
	[6,_t,180,'AinjPpneMrunSnonWnonDb_grab'] remoteExec ['QS_fnc_remoteExec',0,FALSE];
	50 cutText [(format [localize 'STR_QS_Text_105',(name _t)]),'PLAIN DOWN',0.3];
	player playActionNow 'grabDrag';
};
if ((getPlayerUID player) in QS_blacklist_logistics) exitWith {
	50 cutText [localize 'STR_QS_Text_388','PLAIN',0.3];
};
if (!local _t) then {
	[66,TRUE,_t,clientOwner] remoteExec ['QS_fnc_remoteExec',2,FALSE];
};
_pos = (((getPosATL player) vectorAdd ((vectorDir player) vectorMultiply 1.5))) vectorAdd [0,0,0.2];
_t setPosATL _pos;
[_t,player,TRUE] call (missionNamespace getVariable 'QS_fnc_attachToRelative');
player playActionNow 'grabDrag';
_dn = QS_hashmap_configfile getOrDefaultCall [
	format ['cfgvehicles_%1_displayname',toLowerANSI (typeOf _t)],
	{getText ((configOf _t) >> 'displayName')},
	TRUE
];
_text = format [localize 'STR_QS_Text_105',(_t getVariable ['QS_ST_customDN',_dn])];
50 cutText [_text,'PLAIN DOWN',0.75];
if ((uiNamespace getVariable ['QS_dragStuckMsg',-1]) isEqualTo -1) then {
	uiNamespace setVariable ['QS_dragStuckMsg',0];
	(missionNamespace getVariable 'QS_managed_hints') pushBack [5,TRUE,10,-1,localize 'STR_QS_Hints_033',[],-1,TRUE,localize 'STR_QS_Utility_010',TRUE];
};
TRUE;