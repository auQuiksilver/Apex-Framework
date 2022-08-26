/*/
File: fn_AIGroupEventHandlers.sqf
Author:

	Quiksilver
	
Last Modified:

	25/05/2022 A3 2.08 by Quiksilver
	
Description:

	AI Group Event Handlers
___________________________________________/*/

params ['_type','_group'];
if (_type isEqualTo 0) exitWith {
	// Remove
	{
		_group removeEventHandler _x;
	} forEach (_group getVariable ['QS_AI_GRP_EHs',[]]);
	_group setVariable ['QS_AI_GRP_EHs',[],FALSE];
};
if (_type isEqualTo 1) exitWith {
	// Add via QS_fnc_AIHandleGroup
	private _groupEventHandlers = [];
	_objectParent = objectParent (leader _group);
	//===== INFANTRY
	if (isNull _objectParent) then {
		if ((_group getVariable ['QS_AI_GRP_EHs',[]]) isEqualTo []) then {
			{
				_groupEventHandlers pushBack [(_x # 0),(_group addEventHandler _x)];
			} forEach [
				//['CombatModeChanged',{call (missionNamespace getVariable 'QS_fnc_AIGroupEventCombatModeChanged')}],
				//['CommandChanged',{}],
				//['FormationChanged',{}],
				//['SpeedModeChanged',{}],
				//['EnableAttackChanged',{}],
				//['LeaderChanged',{}],
				//['KnowsAboutChanged',{}],
				//['WaypointComplete',{}],
				//['Fleeing',{}],
				['EnemyDetected',{call (missionNamespace getVariable 'QS_fnc_AIGroupEventEnemyDetected')}]
			];
			_group setVariable ['QS_AI_GRP_EHs',_groupEventHandlers,FALSE];
		};
	};
	//===== AIR
	if (_objectParent isKindOf 'Air') then {
	
	};
	//===== LAND & BOAT
	if (_objectParent isKindOf 'LandVehicle') then {
	
	};
	//===== STATIC TURRETS
	if (_objectParent isKindOf 'StaticWeapon') then {
	
	};
};
if (_type isEqualTo 2) exitWith {
	// Locality

};