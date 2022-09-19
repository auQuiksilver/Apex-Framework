/*
File: fn_clientInteractRespawnVehicle.sqf
Author:

	Quiksilver
	
Last Modified:

	9/09/2022 A3 2.10 by Quiksilver
	
Description:

	- Client can respawn a vehicle via action menu
_____________________________________________________________*/

private ['_t','_text'];
_t = cursorTarget;
if (
	(!simulationEnabled _t) ||
	{(!local _t)} ||
	{(((vectorMagnitude (velocity _t)) * 3.6) > 1)} ||
	{(((crew _t) findIf {(alive _x)}) isNotEqualTo -1)} ||
	{(diag_tickTime < (player getVariable ['QS_RD_canRespawnVehicle',-1]))} ||
	{(!(_t getVariable ['QS_RD_vehicleRespawnable',FALSE]))} ||
	{((!(_t isKindOf 'LandVehicle')) && (!(_t isKindOf 'Air')) && (!(_t isKindOf 'Ship')))}
) exitWith {};
if ((getVehicleCargo _t) isNotEqualTo []) exitWith {
	50 cutText [localize 'STR_QS_Text_122','PLAIN',0.3];
};
if (!isNull (getSlingLoad _t)) exitWith {
	50 cutText [localize 'STR_QS_Text_123','PLAIN',0.3];
};
if ((ropes _t) isNotEqualTo []) exitWith {
	50 cutText [localize 'STR_QS_Text_124','PLAIN',0.3];
};
if (!(isNull (attachedTo _t))) exitWith {
	50 cutText [localize 'STR_QS_Text_125','PLAIN',0.3];
};
private _result = [(format ['%2 %1',(getText (configFile >> 'CfgVehicles' >> (typeOf _t) >> 'displayName')),localize 'STR_QS_Menu_121']),localize 'STR_QS_Menu_122',localize 'STR_QS_Menu_123',localize 'STR_QS_Menu_114',(findDisplay 46),FALSE,FALSE] call (missionNamespace getVariable 'BIS_fnc_guiMessage'); 
if (_result) then {
	player setVariable ['QS_RD_canRespawnVehicle',(diag_tickTime + 120),FALSE];
	player playAction 'PutDown';
	playSound 'ClickSoft';
	50 cutText [localize 'STR_QS_Text_126','PLAIN DOWN',0.5];
	if (((crew _t) findIf {(alive _x)}) isEqualTo -1) then {
		if ((_t distance2D (markerPos 'QS_marker_base_marker')) >= 1000) then {
			_text = format ['%1 %4 %2 %5 %3',profileName,(getText (configFile >> 'CfgVehicles' >> (typeOf _t) >> 'displayName')),(mapGridPosition player),localize 'STR_QS_Chat_093',localize 'STR_QS_Hints_060'];
			['systemChat',_text] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
		};
		if (!isNil {player getVariable 'QS_client_createdBoat'}) then {
			if (!isNull (player getVariable 'QS_client_createdBoat')) then {
				if (alive (player getVariable 'QS_client_createdBoat')) then {
					if (_t isEqualTo (player getVariable 'QS_client_createdBoat')) then {
						if ((backpack player) isNotEqualTo '') then {
							if (player canAddItemToBackpack ['ToolKit',1]) then {
								player addItemToBackpack 'ToolKit';
								50 cutText [(format ['%1 %2',(getText (configFile >> 'CfgVehicles' >> (typeOf _t) >> 'displayName')),localize 'STR_QS_Text_127']),'PLAIN DOWN'];
							};
						};
					};
				};
			};
		};
		if ((_t distance (markerPos 'QS_marker_base_marker')) > 1000) then {
			[46,[player,2]] remoteExec ['QS_fnc_remoteExec',2,FALSE];
			['ScoreBonus',[(format ['%2 %1',worldName,localize 'STR_QS_Notif_041']),'2']] call (missionNamespace getVariable 'QS_fnc_showNotification');	
		};
		[17,_t] remoteExec ['QS_fnc_remoteExec',2,FALSE];
	};
} else {
	50 cutText [localize 'STR_QS_Text_128','PLAIN',0.3];
};