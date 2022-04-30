/*
File: fn_clientEventGetOutMan.sqf
Author:

	Quiksilver
	
Last modified:

	5/12/2018 A3 1.86 by Quiksilver
	
Description:

	unit: Object - unit the event handler is assigned to
	position: String - Can be either "driver", "gunner", "commander" or "cargo"
	vehicle: Object - Vehicle that the unit left
	turret: Array - turret path
__________________________________________________*/

params ['_unit','_position','_vehicle','_turret'];
player enableAI 'CHECKVISIBLE';
uiNamespace setVariable ['QS_robocop_timeout',diag_tickTime + 3];
[0,_vehicle] call (missionNamespace getVariable 'QS_fnc_clientVehicleEventHandlers');
/*/
{
	setInfoPanel [(['left','right'] select (_forEachIndex isEqualTo 1)),(_x select 0)];
} forEach (missionNamespace getVariable 'QS_client_infoPanels');
/*/
if (!((typeOf _vehicle) in ['Steerable_Parachute_F'])) then {
	player setVariable ['QS_lastObjectParent',_vehicle,FALSE];
	if (!((backpack player) isEqualTo 'B_Parachute')) then {
		if (!((player getVariable 'QS_backpack_data') isEqualTo [])) then {
			player setVariable ['QS_backpack_data',[],FALSE];
		};
	};
} else {
	if (!((player getVariable 'QS_backpack_data') isEqualTo [])) then {
		if (!isNil {player getVariable 'QS_lastObjectParent'}) then {
			if (!(((player getVariable 'QS_backpack_data') select 0) isEqualTo '')) then {
				if (!isNull (player getVariable 'QS_lastObjectParent')) then {
					if (alive (player getVariable 'QS_lastObjectParent')) then {
						if (((player getVariable 'QS_backpack_data') select 0) in (backpackCargo (player getVariable 'QS_lastObjectParent'))) then {
							/*/clearBackpackCargoGlobal (player getVariable 'QS_lastObjectParent');/*/
						};
					}
				};
			};
		};
		0 spawn {
			uiSleep 1;
			if (!(((player getVariable 'QS_backpack_data') select 0) isEqualTo '')) then {
				player addBackpack ((player getVariable 'QS_backpack_data') select 0);
				if (!(((player getVariable 'QS_backpack_data') select 1) isEqualTo [])) then {
					{
						if (player canAddItemToBackpack _x) then {
							player addItemToBackpack _x;
						};
					} forEach ((player getVariable 'QS_backpack_data') select 1);
				};
				if (!(((player getVariable 'QS_backpack_data') select 2) isEqualTo [])) then {
					{
						player addMagazine _x;
					} forEach ((player getVariable 'QS_backpack_data') select 2);
				};
			};
		};
	};	
};
if ((missionNamespace getVariable ['QS_missionConfig_artyEngine',1]) isEqualTo 1) then {
	if (_vehicle isEqualTo (missionNamespace getVariable ['QS_arty',objNull])) then {
		enableEngineArtillery FALSE;
	};
};
if (!isNil {player getVariable 'QS_pilot_vehicleInfo'}) then {
	player setVariable ['QS_pilot_vehicleInfo',nil,TRUE];
};
if ((toLower (typeOf _vehicle)) in ['b_t_apc_tracked_01_crv_f','b_apc_tracked_01_crv_f']) then {
	player removeAction (missionNamespace getVariable 'QS_action_plow');
};
if ((((crew _vehicle) findIf {(alive _x)}) isEqualTo -1) || {(player isEqualTo (driver _vehicle))}) then {
	if (local _vehicle) then {
		_vehicle engineOn FALSE;
	};
};