/*
File: fn_clientInteractDeployAsset.sqf
Author:

	Quiksilver
	
Last Modified:

	28/04/2023 A3 2.12 by Quiksilver
	
Description:

	-
________________________________________________*/

if ((['QS_trait_fighterPilot','QS_trait_pilot'] findIf { player getUnitTrait _x }) isNotEqualTo -1) exitWith {
	50 cutText [localize 'STR_QS_Text_453','PLAIN DOWN',0.333];
};
getCursorObjectParams params ['_cursorObject','_cursorSelections','_cursorDistance'];
params ['_mode'];
private _list = (allPlayers - (entities 'HeadlessClient_F')) - [QS_player];
private _deployParams = _cursorObject getVariable ['QS_logistics_deployParams',[30,30,30,30,100,30]];
_deployParams params [
	'_deploySafeRadius',
	'_deployCooldown',
	'_packSafeRadius',
	'_packCooldown',
	'_safeDistance',
	'_buildRadius'
];
private _cooldown = _cursorObject getVariable ['QS_logistics_deployCooldown',_deployCooldown];
if (_mode isEqualTo 0) exitWith {
	comment 'Pack up';
	if (
		(!alive _cursorObject) ||
		{(!(_cursorObject getVariable ['QS_logistics_deployable',FALSE]))} ||
		{(!(_cursorObject getVariable ['QS_logistics_deployed',FALSE]))} ||
		{(_cursorObject getVariable ['QS_logistics_blocked',FALSE])} ||
		{(serverTime < _cooldown)} ||
		{((_list inAreaArray [getPos _cursorObject,_packSafeRadius,_packSafeRadius,0,FALSE,-1]) isNotEqualTo [])} ||
		{(((flatten ([EAST,RESISTANCE] apply {units _x})) inAreaArray [getPos _cursorObject,300,300,0,FALSE,-1]) isNotEqualTo [])}
	) exitWith {
		50 cutText [localize 'STR_QS_Text_411','PLAIN DOWN',0.333];
		if ((_list inAreaArray [getPos _cursorObject,_packSafeRadius,_packSafeRadius,0,FALSE,-1]) isNotEqualTo []) then {
			systemchat format [localize 'STR_QS_Text_430',_packSafeRadius];
		};
		if (serverTime < _cooldown) then {
			systemchat format ['%1  %2',(localize 'STR_QS_Text_431'),round (_cooldown - serverTime)];
		};
		if (_cursorObject getVariable ['QS_logistics_blocked',FALSE]) then {
			systemChat (localize 'STR_QS_Chat_171');
		};
		if (((flatten ([EAST,RESISTANCE] apply {units _x})) inAreaArray [getPos _cursorObject,300,300,0,FALSE,-1]) isNotEqualTo []) then {
			systemChat (localize 'STR_QS_Chat_173');
		};
	};
	50 cutText [localize 'STR_QS_Text_410','PLAIN DOWN',0.333];
	if (isNull (objectParent QS_player)) then {
		QS_player playActionNow 'PutDown';
	};
	{
		_cursorObject setVariable _x;
	} forEach [
		['QS_logistics_deployCooldown',serverTime + _deployCooldown,TRUE],
		['QS_logistics_deployed',FALSE,TRUE]
	];
	uiSleep (diag_deltaTime * 3);
	[111,_cursorObject,_mode,profileName,clientOwner] remoteExec ['QS_fnc_remoteExec',2,FALSE];
};
if (_mode isEqualTo 1) exitWith {
	comment 'Deploy';
	_deployRestrictedZoneDistance = 2000;
	_deployRestrictedZoneData = [_cursorObject,['SAFE','NO_BUILD'],2] call QS_fnc_nearestZone;
	([_cursorObject,'SAFE'] call QS_fnc_inZone) params ['_inSafezone','_safezoneLevel','_safezoneActive'];
	if (
		(!alive _cursorObject) ||
		{(((crew _cursorObject) select {(alive _x)}) isNotEqualTo [])} ||
		{(!isNull (attachedTo _cursorObject))} ||
		{(!isNull (isVehicleCargo _cursorObject))} ||
		{(!isNull (ropeAttachedTo _cursorObject))} ||
		{((ropes _cursorObject) isNotEqualTo [])} ||
		{((isEngineOn _cursorObject) && ((['Car','Tank'] findIf {_cursorObject isKindOf _x}) isNotEqualTo -1))} ||
		{(!(_cursorObject getVariable ['QS_logistics_deployable',FALSE]))} ||
		{(_cursorObject getVariable ['QS_logistics_deployed',FALSE])} ||
		{(_cursorObject getVariable ['QS_logistics_blocked',FALSE])} ||
		{([_cursorObject,55,8] call QS_fnc_waterInRadius)} ||
		{(_inSafezone && _safezoneActive && (_safezoneLevel > 1))} ||
		{(serverTime < _cooldown)} ||
		{((_list inAreaArray [getPos _cursorObject,_deploySafeRadius,_deploySafeRadius,0,FALSE,-1]) isNotEqualTo [])} ||
		{
			(
				((_cursorObject getVariable ['QS_deploy_type','']) isEqualTo 'FORT') &&
				((_deployRestrictedZoneData # 1) < _deployRestrictedZoneDistance)
			)
		} ||
		{(((flatten ([EAST,RESISTANCE] apply {units _x})) inAreaArray [getPos _cursorObject,300,300,0,FALSE,-1]) isNotEqualTo [])}
	) exitWith {
		50 cutText [localize 'STR_QS_Text_412','PLAIN DOWN',0.333];
		if ((_list inAreaArray [getPos _cursorObject,_deploySafeRadius,_deploySafeRadius,0,FALSE,-1]) isNotEqualTo []) then {
			systemchat format [localize 'STR_QS_Text_430',_deploySafeRadius];
		};
		if (serverTime < _cooldown) then {
			systemchat format ['%1  %2',(localize 'STR_QS_Text_431'),round (_cooldown - serverTime)];
		};
		if ([_cursorObject,55,8] call QS_fnc_waterInRadius) then {
			systemchat (localize 'STR_QS_Text_432');
		};
		if (
			((_cursorObject getVariable ['QS_deploy_type','']) isEqualTo 'FORT') &&
			((_deployRestrictedZoneData # 1) < _deployRestrictedZoneDistance)
		) then {
			systemChat format ['%1 - (%2/%3)',localize 'STR_QS_Chat_167',round (_deployRestrictedZoneData # 1),_deployRestrictedZoneDistance];
		};
		if (((flatten ([EAST,RESISTANCE] apply {units _x})) inAreaArray [getPos _cursorObject,300,300,0,FALSE,-1]) isNotEqualTo []) then {
			systemChat (localize 'STR_QS_Chat_173');
		};
	};
	50 cutText [localize 'STR_QS_Text_409','PLAIN DOWN',0.333];
	if (isNull (objectParent QS_player)) then {
		QS_player playActionNow 'PutDown';
	};
	{
		_cursorObject setVariable _x;
	} forEach [
		['QS_logistics_deployCooldown',serverTime + _packCooldown,TRUE],
		['QS_logistics_deployed',TRUE,TRUE]
	];
	uiSleep (diag_deltaTime * 3);
	[111,_cursorObject,_mode,profileName,clientOwner,(QS_player getVariable ['QS_unit_side',WEST])] remoteExec ['QS_fnc_remoteExec',2,FALSE];
};