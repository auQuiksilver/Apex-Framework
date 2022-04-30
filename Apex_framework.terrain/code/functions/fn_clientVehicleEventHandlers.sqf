/*/
File: fn_clientVehicleEventHandlers.sqf
Author:
	
	Quiksilver
	
Last Modified:

	15/11/2018 A3 1.84 by Quiksilver

Description:

	Set Vehicle Event Handlers
_________________________________________________/*/

params ['_type','_vehicle'];
if (_type isEqualTo 0) then {
	//comment 'Remove Events';
	if (!isNil {_vehicle getVariable 'QS_client_vehicleEventHandlers'}) then {
		if (!((_vehicle getVariable 'QS_client_vehicleEventHandlers') isEqualTo [])) then {
			{
				_vehicle removeEventHandler _x;
			} forEach (_vehicle getVariable 'QS_client_vehicleEventHandlers');
		};
		_vehicle setVariable ['QS_client_vehicleEventHandlers',nil,FALSE];
	};
};
if (_type isEqualTo 1) then {
	//comment 'Add Events';
	if (isNil {_vehicle getVariable 'QS_client_vehicleEventHandlers'}) then {
		private _vehicleEventHandlers = [];
		{
			_vehicleEventHandlers pushBack [(_x select 0),(_vehicle addEventHandler _x)];
		} forEach [
			['Local',{call (missionNamespace getVariable 'QS_fnc_clientVehicleEventLocal')}],
			['Killed',{call (missionNamespace getVariable 'QS_fnc_clientVehicleEventKilled')}],
			['Hit',{call (missionNamespace getVariable 'QS_fnc_clientVehicleEventHit')}],
			['HandleDamage',{call (missionNamespace getVariable 'QS_fnc_clientVehicleEventHandleDamage')}],
			['IncomingMissile',{call (missionNamespace getVariable 'QS_fnc_clientVehicleEventIncomingMissile')}],
			['Fired',{call (missionNamespace getVariable 'QS_fnc_clientVehicleEventFired')}],
			['EpeContactStart',{call (missionNamespace getVariable 'QS_fnc_clientVehicleEventEpeContactStart')}],
			['Engine',{call (missionNamespace getVariable 'QS_fnc_clientVehicleEventEngine')}],
			['Fuel',{call (missionNamespace getVariable 'QS_fnc_clientVehicleEventFuel')}],
			['Deleted',{call (missionNamespace getVariable 'QS_fnc_clientVehicleEventDeleted')}],
			['Dammaged',{call (missionNamespace getVariable 'QS_fnc_clientVehicleEventDammaged')}]
		];
		if (_vehicle isKindOf 'Air') then {
			{
				_vehicleEventHandlers pushBack [(_x select 0),(_vehicle addEventHandler _x)];
			} forEach [
				['Gear',{call (missionNamespace getVariable 'QS_fnc_clientVehicleEventGear')}]
			];
			if (_vehicle isKindOf 'Helicopter') then {
				{
					_vehicleEventHandlers pushBack [(_x select 0),(_vehicle addEventHandler _x)];
				} forEach [
					['RopeAttach',{call (missionNamespace getVariable 'QS_fnc_clientVehicleEventRopeAttach')}],
					['RopeBreak',{call (missionNamespace getVariable 'QS_fnc_clientVehicleEventRopeBreak')}]
				];
			};
		};
		_vehicle setVariable ['QS_client_vehicleEventHandlers',_vehicleEventHandlers,FALSE];
	};
};
if (_type isEqualTo 2) then {
	if (isNil {_vehicle getVariable 'QS_client_vehicleManaged'}) then {
		_vehicle setVariable ['QS_client_vehicleManaged',TRUE,FALSE];
		_vehicle addEventHandler ['Local',{call (missionNamespace getVariable 'QS_fnc_clientVehicleEventLocal')}];
	};
};