/*
File: fn_clientVehicleEventRopeAttach.sqf
Author:
	
	Quiksilver
	
Last Modified:

	29/1/2023 A3 2.12 by Quiksilver

Description:

	Event Rope Attach
__________________________________________________________*/
if (!(local (_this # 0))) exitWith {};
params ['_vehicle','_rope','_attachedObject'];
if (!simulationEnabled _attachedObject) then {
	_attachedObject enableSimulation TRUE;
	[39,_attachedObject,TRUE,profileName,(getPlayerUID player)] remoteExec ['QS_fnc_remoteExec',2,FALSE];
};
_memPoints = QS_hashmap_configfile getOrDefaultCall [
	format ['cfgvehicles_%1_slingmempoints',toLowerANSI (typeOf _attachedObject)],
	{getArray ((configOf _attachedObject) >> 'slingLoadCargoMemoryPoints')},
	TRUE
];
private _exit = FALSE;
if (_attachedObject isEqualTo (getSlingLoad _vehicle)) then {
	_rope setVariable ['QS_rope_relation',[_vehicle,_attachedObject,'SLING'],TRUE];
	if (
		(!isNull (isVehicleCargo _attachedObject)) ||
		{(!isNull (attachedTo _attachedObject))} ||
		{(_attachedObject getVariable ['QS_logistics_deployed',FALSE])} ||
		{((ropeAttachedObjects _attachedObject) isNotEqualTo [])} ||
		{((!isNull (ropeAttachedTo _attachedObject)) && {((ropeAttachedTo _attachedObject) isNotEqualTo _vehicle)})}
	) then {
		_exit = TRUE;
		_vehicle setSlingLoad objNull;
	};
};
if (_exit) exitWith {};
if (
	((count (ropes _vehicle)) isEqualTo (count _memPoints)) &&
	{(alive (driver _vehicle))} &&
	{(player isEqualTo (driver _vehicle))}
) then {
	//_vehicle setCustomWeightRTD (((weightRTD _vehicle) # 3) + (getMass _attachedObject));			// might cause game crash
	if (!(_attachedObject getVariable ['QS_dynSim_ignore',FALSE])) then {
		_attachedObject setVariable ['QS_dynSim_ignore',TRUE,TRUE];
	};
	_attachedObject setVariable ['QS_transporter',[(name (driver _vehicle)),(driver _vehicle),(getPlayerUID (driver _vehicle))],TRUE];
	private _displayName = _attachedObject getVariable ['QS_ST_customDN',''];
	if (_displayName isEqualTo '') then {	
		_displayName = QS_hashmap_configfile getOrDefaultCall [
			format ['cfgvehicles_%1_displayname',toLowerANSI (typeOf _attachedObject)],
			{getText ((configOf _attachedObject) >> 'displayName')},
			TRUE
		];
	};
	50 cutText [format [localize 'STR_QS_Text_201',_displayName],'PLAIN DOWN',0.333];
	if (!(isStreamFriendlyUIEnabled)) then {
		if ((missionProfileNamespace getVariable ['QS_client_profile_slingToken4',0]) < 25) then {
			if (!(uiNamespace getVariable ['QS_slingToken_session',FALSE])) then {
				uiNamespace setVariable ['QS_slingToken_session',TRUE];
				missionProfileNamespace setVariable ['QS_client_profile_slingToken4',((missionProfileNamespace getVariable ['QS_client_profile_slingToken4',0]) + 1)];
				saveMissionProfileNamespace;
				_customUpText = [
					actionKeysNames ['User18', 1] trim ['"',0],
					localize 'STR_QS_Text_367'
				] select ((actionKeysNamesArray 'User18') isEqualTo []);
				_customDownText = [
					actionKeysNames ['User17', 1] trim ['"',0],
					localize 'STR_QS_Text_366'
				] select ((actionKeysNamesArray 'User17') isEqualTo []);
				_text = format [
					'<t align="left">%3</t><t align="right">[%1] [%5]</t><br/><br/>
					<t align="left">%4</t> <t align="right">[%2] [%6]</t><br/><br/>',
					actionKeysNames ['gunElevUp',1] trim ['"',0],
					actionKeysNames ['gunElevDown',1] trim ['"',0],
					localize 'STR_QS_Hints_174',
					localize 'STR_QS_Hints_175',
					_customUpText,
					_customDownText
				];
				[
					_text,
					FALSE,
					TRUE,
					localize 'STR_QS_Hints_173',
					TRUE
				] call QS_fnc_hint;
			};
		};
	};
	if (!local _attachedObject) then {
		[66,TRUE,_attachedObject,clientOwner] remoteExec ['QS_fnc_remoteExec',2,FALSE];
	};
};