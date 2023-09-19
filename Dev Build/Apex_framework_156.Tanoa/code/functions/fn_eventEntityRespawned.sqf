/*
File: fn_eventEntityRespawned.sqf
Author:

	Quiksilver
	
Last modified:

	30/03/2017 A3 1.68 by Quiksilver
	
Description:

	Event Entity Respawned
__________________________________________________*/

params ['_newEntity','_oldEntity'];
missionNamespace setVariable ['QS_analytics_entities_respawned',((missionNamespace getVariable 'QS_analytics_entities_respawned') + 1),FALSE];
missionNamespace setVariable ['QS_system_entitiesRespawned',((missionNamespace getVariable ['QS_system_entitiesRespawned',0]) + 1),FALSE];
if (!isNull _newEntity) then {
	if (isPlayer _newEntity) then {
		missionNamespace setVariable ['QS_playerRespawnCountServer',((missionNamespace getVariable 'QS_playerRespawnCountServer') + 1),FALSE];
		if (_newEntity getUnitTrait 'QS_trait_fighterPilot') then {
			if (_oldEntity isEqualTo QS_fighterPilot) then {
				missionNamespace setVariable ['QS_fighterPilot',_newEntity,TRUE];
			};
		};
		if (allCurators isNotEqualTo []) then {
			{
				if (!isNull (getAssignedCuratorUnit _x)) then {
					_x addCuratorEditableObjects [[_newEntity],FALSE];
				};
			} count allCurators;
			if ((getPlayerUID _newEntity) in (['CURATOR'] call (missionNamespace getVariable 'QS_fnc_whitelist'))) then {
				[_newEntity,_oldEntity] spawn {
					params ['_newEntity','_oldEntity'];
					private _module = objNull;
					scriptName 'EventEntityRespawned * Reassigning Curator';
					_module = getAssignedCuratorLogic _oldEntity;
					if (isNull _module) then {
						_module = (allCurators select {(owner _x) isEqualTo (owner _newEntity)}) # 0;
					};
					if (!isNull _module) then {
						waitUntil {
							unassignCurator _module; 
							(isNull (getAssignedCuratorUnit _module)) || 
							(isNull _module)
						};
						waitUntil {
							_newEntity assignCurator _module; 
							((getAssignedCuratorUnit _module) isEqualTo _newEntity) || 
							(isNull _module)
						};
					};
				};
			};
		};
	};
};