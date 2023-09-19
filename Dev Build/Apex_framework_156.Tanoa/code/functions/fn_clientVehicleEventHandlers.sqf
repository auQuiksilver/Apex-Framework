/*/
File: fn_clientVehicleEventHandlers.sqf
Author:
	
	Quiksilver
	
Last Modified:

	31/01/2023 A3 2.12 by Quiksilver

Description:

	Set Vehicle Event Handlers
_________________________________________________/*/

params ['_type','_vehicle'];
if (_type isEqualTo 0) then {
	//comment 'Remove Events';
	if ((_vehicle getVariable ['QS_client_vehicleEventHandlers',[]]) isNotEqualTo []) then {
		{
			_vehicle removeEventHandler _x;
		} forEach (_vehicle getVariable 'QS_client_vehicleEventHandlers');
		_vehicle setVariable ['QS_client_vehicleEventHandlers',[],FALSE];
	};
};
if (_type isEqualTo 1) then {
	//comment 'Add Events';
	if (!(_vehicle getVariable ['QS_client_vehicleEventsManaged',FALSE])) then {
		_vehicle setVariable ['QS_client_vehicleEventsManaged',TRUE,FALSE];
		_vehicle addEventHandler ['Local',{call (missionNamespace getVariable 'QS_fnc_clientVehicleEventLocal')}];
	};
	if ((_vehicle getVariable ['QS_client_vehicleEventHandlers',[]]) isEqualTo []) then {
		private _vehicleEventHandlers = [];
		{
			_vehicleEventHandlers pushBack [(_x # 0),(_vehicle addEventHandler _x)];
		} forEach [
			['Killed',{call (missionNamespace getVariable 'QS_fnc_clientVehicleEventKilled')}],
			['Hit',{call (missionNamespace getVariable 'QS_fnc_clientVehicleEventHit')}],
			['HandleDamage',{call (missionNamespace getVariable 'QS_fnc_clientVehicleEventHandleDamage')}],
			['IncomingMissile',{call (missionNamespace getVariable 'QS_fnc_clientVehicleEventIncomingMissile')}],
			['Fired',{call (missionNamespace getVariable 'QS_fnc_clientVehicleEventFired')}],
			['EpeContactStart',{call (missionNamespace getVariable 'QS_fnc_clientVehicleEventEpeContactStart')}],
			['Engine',{call (missionNamespace getVariable 'QS_fnc_clientVehicleEventEngine')}],
			['Fuel',{call (missionNamespace getVariable 'QS_fnc_clientVehicleEventFuel')}],
			['Deleted',{call (missionNamespace getVariable 'QS_fnc_clientVehicleEventDeleted')}],
			['Dammaged',{call (missionNamespace getVariable 'QS_fnc_clientVehicleEventDammaged')}],
			['CargoLoaded',{call (missionNamespace getVariable 'QS_fnc_clientVehicleEventCargoLoaded')}],
			['CargoUnloaded',{call (missionNamespace getVariable 'QS_fnc_clientVehicleEventCargoUnloaded')}]
		];
		if (_vehicle isKindOf 'Air') then {
			{
				_vehicleEventHandlers pushBack [(_x # 0),(_vehicle addEventHandler _x)];
			} forEach [
				['Gear',{call (missionNamespace getVariable 'QS_fnc_clientVehicleEventGear')}]
			];
			if (_vehicle isKindOf 'Helicopter') then {
				{
					_vehicleEventHandlers pushBack [(_x # 0),(_vehicle addEventHandler _x)];
				} forEach [
					['RopeAttach',{call (missionNamespace getVariable 'QS_fnc_clientVehicleEventRopeAttach')}],
					['RopeBreak',{call (missionNamespace getVariable 'QS_fnc_clientVehicleEventRopeBreak')}]
				];
			};
		};
		_vehicle setVariable ['QS_client_vehicleEventHandlers',_vehicleEventHandlers,FALSE];
	};
};