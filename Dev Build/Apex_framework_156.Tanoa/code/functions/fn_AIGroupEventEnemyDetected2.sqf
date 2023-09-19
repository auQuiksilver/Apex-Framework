/*/
File: fn_AIGroupEventEnemyDetected2.sqf
Author:

	Quiksilver
	
Last Modified:

	25/08/2022 A3 2.10 by Quiksilver
	
Description:

	AI Intel Collectors (Aircraft, etc)
		- Target
		- Time seen
		- Position seen
		- Level of knowledge
		- Last group to report info
		- Is target on ground
___________________________________________/*/

params [['_grp',grpNull],['_target',objNull]];
if (serverTime < (_grp getVariable ['QS_AI_GRP_intelED_cooldown',-1])) exitWith {};
_grp setVariable ['QS_AI_GRP_intelED_cooldown',serverTime + 5,FALSE];
([_target,'SAFE'] call QS_fnc_inZone) params ['_inSafezone','_safezoneLevel','_safezoneActive'];
if (_inSafezone && _safezoneActive && (_safezoneLevel > 1)) exitWith {};
_targetIndex = QS_AI_targetsIntel findIf { _target isEqualTo (_x # 0) };
if (_targetIndex isEqualTo -1) then {
	missionNamespace setVariable ['QS_AI_targetsIntel',((missionNamespace getVariable 'QS_AI_targetsIntel') + [[_target,serverTime,ASLToAGL (((leader _grp) targetKnowledge _target) # 6),_grp knowsAbout _target,_grp,isTouchingGround _target,rating _target]]),QS_system_AI_owners];
} else {
	QS_AI_targetsIntel set [_targetIndex,[_target,serverTime,ASLToAGL (((leader _grp) targetKnowledge _target) # 6),_grp knowsAbout _target,_grp,isTouchingGround _target,rating _target]];
	missionNamespace setVariable ['QS_AI_targetsIntel',(missionNamespace getVariable 'QS_AI_targetsIntel'),QS_system_AI_owners];
};