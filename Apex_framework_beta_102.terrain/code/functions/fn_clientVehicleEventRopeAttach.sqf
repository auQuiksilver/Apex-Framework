/*
File: fn_clientVehicleEventRopeAttach.sqf
Author:
	
	Quiksilver
	
Last Modified:

	16/01/2017 A3 1.66 by Quiksilver

Description:

	Event Rope Attach
__________________________________________________________*/
if (!(local (_this select 0))) exitWith {};
params ['_vehicle','_rope','_attachedObject'];
if (!simulationEnabled _attachedObject) then {
	_attachedObject enableSimulation TRUE;
	[39,_attachedObject,TRUE,profileName,(getPlayerUID player)] remoteExec ['QS_fnc_remoteExec',2,FALSE];
};
_count = count (getArray (configFile >> 'CfgVehicles' >> (typeOf _attachedObject) >> 'slingLoadCargoMemoryPoints'));
if ((count (ropes _vehicle)) isEqualTo _count) then {
	if (!isNull (driver _vehicle)) then {
		if (alive (driver _vehicle)) then {
			if (player isEqualTo (driver _vehicle)) then {
				_attachedObject setVariable ['QS_transporter',[(name (driver _vehicle)),(driver _vehicle),(getPlayerUID (driver _vehicle))],TRUE];
				private _displayName = _attachedObject getVariable ['QS_ST_customDN',''];
				if (_displayName isEqualTo '') then {
					_displayName = getText (configFile >> 'CfgVehicles' >> (typeOf _attachedObject) >> 'displayName');
				};
				_text = format ['Sling Loading a(n) %1',_displayName];
				50 cutText [_text,'PLAIN DOWN',0.5];
				if (!local _attachedObject) then {
					[66,TRUE,_attachedObject,clientOwner] remoteExec ['QS_fnc_remoteExec',2,FALSE];
				};
			};
		};
	};
};