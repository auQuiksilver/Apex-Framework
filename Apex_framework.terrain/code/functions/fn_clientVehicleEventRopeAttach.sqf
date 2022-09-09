/*
File: fn_clientVehicleEventRopeAttach.sqf
Author:
	
	Quiksilver
	
Last Modified:

	5/05/2018 A3 1.82 by Quiksilver

Description:

	Event Rope Attach
__________________________________________________________*/
if (!(local (_this # 0))) exitWith {};
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
				if (!(_attachedObject getVariable ['QS_dynSim_ignore',FALSE])) then {
					_attachedObject setVariable ['QS_dynSim_ignore',TRUE,TRUE];
				};
				_attachedObject setVariable ['QS_transporter',[(name (driver _vehicle)),(driver _vehicle),(getPlayerUID (driver _vehicle))],TRUE];
				private _displayName = _attachedObject getVariable ['QS_ST_customDN',''];
				if (_displayName isEqualTo '') then {
					_displayName = getText (configFile >> 'CfgVehicles' >> (typeOf _attachedObject) >> 'displayName');
				};
				if (!(isStreamFriendlyUIEnabled)) then {
					if ((missionProfileNamespace getVariable ['QS_client_profile_slingToken',0]) < 5) then {
						if (!(uiNamespace getVariable ['QS_slingToken_session',FALSE])) then {
							uiNamespace setVariable ['QS_slingToken_session',TRUE];
							missionProfileNamespace setVariable ['QS_client_profile_slingToken',((missionProfileNamespace getVariable ['QS_client_profile_slingToken',0]) + 1)];
							saveMissionProfileNamespace;
						};
						_text = format ['%3 %2 %1',localize 'STR_QS_Text_203',(actionKeysNames ['HeliRopeAction',1]),localize 'STR_QS_Text_202'];
						50 cutText [_text,'PLAIN DOWN',1];
					} else {
						_text = format ['%2 %1',_displayName,localize 'STR_QS_Text_201'];
						50 cutText [_text,'PLAIN DOWN',0.5];					
					};
				};
				if (!local _attachedObject) then {
					[66,TRUE,_attachedObject,clientOwner] remoteExec ['QS_fnc_remoteExec',2,FALSE];
				};
			};
		};
	};
};