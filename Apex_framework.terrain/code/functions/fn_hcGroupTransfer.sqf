/*/
File: fn_hcGroupTransfer.sqf
Author: 

	Quiksilver

Last Modified:

	10/06/2022 A3 2.10 by Quiksilver

Description:

	Transfer Group to Headless Client
	
"all"	Disables all features.	
Arma 3 logo black.png
1.66
"AIMINGERROR"	Prevents AI's aiming from being distracted by its shooting, moving, turning, reloading, hit, injury, fatigue, suppression or concealed / lost target.	
Arma 3 logo black.png
1.42
"ANIM"	Disables all animations of the unit. Completely freezes the unit, including breathing and blinking. No move command works until the unit is unfrozen.	
Logo A0.png
1.99
"AUTOCOMBAT"	Disables autonomous switching to "COMBAT" AI Behaviour when in danger.	
Arma 3 logo black.png
1.56
"AUTOTARGET"	Essentially makes single units without a group "deaf". The unit still goes prone and combat ready if it hears gunfire. It will not turn around when gunfire comes from behind, but if an enemy walks in front of it it will target the enemy and fire as normal. Does not work for grouped units as the leader will assign targets to the units, effectively reenabling this feature.	-
"CHECKVISIBLE"	Disables visibility raycasts. Useful in PvP missions where these raycasts are not needed.	
Arma 3 logo black.png
1.54
"COVER"	Disables usage of cover positions by the AI.	
Arma 3 logo black.png
1.56
"FSM"	Disables the attached FSM scripts which are responsible for the AI behaviour. Enemies react slower to enemy fire and the enemy stops using hand signals. Disabling FSM can give the impression of untrained units as they react slower and are more disorganized compared to when FSM is enabled.	
A2 OA Logo.png
1.60
"LIGHTS"	Stops AI from operating vehicle headlights and collision lights.	
Arma 3 logo black.png
1.92
"MINEDETECTION"	Disable AI's mine detection.	
Arma 3 logo black.png
1.76
"MOVE"	This will stop units from turning and moving, including vehicles. Units will still change stance and fire at the enemy if the enemy happens to walk right in front of the barrel. Units will watch enemies that are in their line of sight, but will not turn their bodies to face the enemy, only their head. Works for grouped units as well. Good for staging units and holding them completely still. Movement can not be controlled via script either, this feature has to be reenabled for that. The unit will still be able to aim within its cone of fire.	-
"NVG"	Stops AI from putting on NVGs (but not from taking them off).	
Arma 3 logo black.png
1.92
"PATH"	Stops the AI's movement but not the target alignment.	
Arma 3 logo black.png
1.62
"RADIOPROTOCOL"	Stops AI from talking and texting while still being able to issue orders.	
Arma 3 logo black.png
1.96
"SUPPRESSION"	Prevents AI from being suppressed. See Arma 3: Suppression.	
Arma 3 logo black.png
1.42
"TARGET"	Prevents units from engaging targets. Units still move around for cover, but will not hunt down enemies. Works in groups as well. Excellent for keeping units inside bases or other areas without having them flank or engage anyone. They will still seek good cover if something is close by.	-
"TEAMSWITCH"	This will disable AI unit when teamswitching.	-
"WEAPONAIM"

"general"
"courage"
"aimingAccuracy"
"aimingShake"
"aimingSpeed"
"commanding"
"endurance"
"spotDistance"
"spotTime"
"reloadSpeed"
__________________________________________________/*/

// Variables
// setBehaviour
// checkAIFeature




_AIGroup = group cursorObject;
_AIGroupUnits = units _AIGroup;
_AIBehaviour = behaviour (leader _AIGroup);
_AICombatMode = combatMode _AIGroup;
private _unit = objNull;
private _unitAIFeatures = [];
private _unitSkills = [];
private _groupUnitData = [];
private _unitData = [];
private _AISkill = [
	'general',
	'courage',
	'aimingAccuracy',
	'aimingShake',
	'aimingSpeed',
	'commanding',
	'endurance',
	'spotDistance',
	'spotTime',
	'reloadSpeed'
];
private _AIFeatures = [
	//'ALL',
	'AIMINGERROR',
	'ANIM',
	'AUTOCOMBAT',
	'AUTOTARGET',
	'CHECKVISIBLE',
	'COVER',
	'FSM',
	'LIGHTS',
	'MINEDETECTION',
	'MOVE',
	'NVG',
	'PATH',
	'RADIOPROTOCOL',
	'SUPPRESSION',
	'TARGET',
	'TEAMSWITCH',
	'WEAPONAIM'
];
_groupData = [_AIBehaviour,_AICombatMode];
{
	_unit = _x;
	_unitAIFeatures = _AIFeatures apply { [0,1] select (_unit checkAIFeature _x) };
	_unitSkills = _AISkill apply { _unit skillFinal _x };
	_groupUnitData pushBack [_unit,_unitAIFeatures,_unitSkills];
} forEach _AIGroupUnits;
copyToClipboard str _groupUnitData;
systemChat str _groupUnitData;

[_AIBehaviour,_AICombatMode,_groupUnitData]


[[B Alpha 1-2:1,[true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true],[0.5775,0.5775,0.31375,0.31375,0.78875,0.5775,0.5775,0.5775,0.5775,0.5775]],[B Alpha 1-2:2,[true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true],[0.5775,0.5775,0.31375,0.31375,0.78875,0.5775,0.5775,0.5775,0.5775,0.5775]],[B Alpha 1-2:3,[true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true],[0.5775,0.5775,0.31375,0.31375,0.78875,0.5775,0.5775,0.5775,0.5775,0.5775]],[B Alpha 1-2:4,[true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true],[0.5775,0.5775,0.31375,0.31375,0.78875,0.5775,0.5775,0.5775,0.5775,0.5775]],[B Alpha 1-2:5,[true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true],[0.5775,0.5775,0.31375,0.31375,0.78875,0.5775,0.5775,0.5775,0.5775,0.5775]],[B Alpha 1-2:6,[true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true],[0.5775,0.5775,0.31375,0.31375,0.78875,0.5775,0.5775,0.5775,0.5775,0.5775]],[B Alpha 1-2:7,[true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true],[0.5775,0.5775,0.31375,0.31375,0.78875,0.5775,0.5775,0.5775,0.5775,0.5775]],[B Alpha 1-2:8,[true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true],[0.5775,0.5775,0.31375,0.31375,0.78875,0.5775,0.5775,0.5775,0.5775,0.5775]]]
[[B Alpha 1-2:1,[["ALL",false],["AIMINGERROR",true],["ANIM",true],["AUTOCOMBAT",true],["AUTOTARGET",true],["CHECKVISIBLE",true],["COVER",true],["FSM",true],["LIGHTS",true],["MINEDETECTION",true],["MOVE",true],["NVG",true],["PATH",true],["RADIOPROTOCOL",true],["SUPPRESSION",true],["TARGET",true],["TEAMSWITCH",true],["WEAPONAIM",true]],[["general",0.5775],["courage",0.5775],["aimingAccuracy",0.31375],["aimingShake",0.31375],["aimingSpeed",0.78875],["commanding",0.5775],["endurance",0.5775],["spotDistance",0.5775],["spotTime",0.5775],["reloadSpeed",0.5775]]],[B Alpha 1-2:2,[["ALL",false],["AIMINGERROR",true],["ANIM",true],["AUTOCOMBAT",true],["AUTOTARGET",true],["CHECKVISIBLE",true],["COVER",true],["FSM",true],["LIGHTS",true],["MINEDETECTION",true],["MOVE",true],["NVG",true],["PATH",true],["RADIOPROTOCOL",true],["SUPPRESSION",true],["TARGET",true],["TEAMSWITCH",true],["WEAPONAIM",true]],[["general",0.5775],["courage",0.5775],["aimingAccuracy",0.31375],["aimingShake",0.31375],["aimingSpeed",0.78875],["commanding",0.5775],["endurance",0.5775],["spotDistance",0.5775],["spotTime",0.5775],["reloadSpeed",0.5775]]],[B Alpha 1-2:3,[["ALL",false],["AIMINGERROR",true],["ANIM",true],["AUTOCOMBAT",true],["AUTOTARGET",true],["CHECKVISIBLE",true],["COVER",true],["FSM",true],["LIGHTS",true],["MINEDETECTION",true],["MOVE",true],["NVG",true],["PATH",true],["RADIOPROTOCOL",true],["SUPPRESSION",true],["TARGET",true],["TEAMSWITCH",true],["WEAPONAIM",true]],[["general",0.5775],["courage",0.5775],["aimingAccuracy",0.31375],["aimingShake",0.31375],["aimingSpeed",0.78875],["commanding",0.5775],["endurance",0.5775],["spotDistance",0.5775],["spotTime",0.5775],["reloadSpeed",0.5775]]],[B Alpha 1-2:4,[["ALL",false],["AIMINGERROR",true],["ANIM",true],["AUTOCOMBAT",true],["AUTOTARGET",true],["CHECKVISIBLE",true],["COVER",true],["FSM",true],["LIGHTS",true],["MINEDETECTION",true],["MOVE",true],["NVG",true],["PATH",true],["RADIOPROTOCOL",true],["SUPPRESSION",true],["TARGET",true],["TEAMSWITCH",true],["WEAPONAIM",true]],[["general",0.5775],["courage",0.5775],["aimingAccuracy",0.31375],["aimingShake",0.31375],["aimingSpeed",0.78875],["commanding",0.5775],["endurance",0.5775],["spotDistance",0.5775],["spotTime",0.5775],["reloadSpeed",0.5775]]],[B Alpha 1-2:5,[["ALL",false],["AIMINGERROR",true],["ANIM",true],["AUTOCOMBAT",true],["AUTOTARGET",true],["CHECKVISIBLE",true],["COVER",true],["FSM",true],["LIGHTS",true],["MINEDETECTION",true],["MOVE",true],["NVG",true],["PATH",true],["RADIOPROTOCOL",true],["SUPPRESSION",true],["TARGET",true],["TEAMSWITCH",true],["WEAPONAIM",true]],[["general",0.5775],["courage",0.5775],["aimingAccuracy",0.31375],["aimingShake",0.31375],["aimingSpeed",0.78875],["commanding",0.5775],["endurance",0.5775],["spotDistance",0.5775],["spotTime",0.5775],["reloadSpeed",0.5775]]],[B Alpha 1-2:6,[["ALL",false],["AIMINGERROR",true],["ANIM",true],["AUTOCOMBAT",true],["AUTOTARGET",true],["CHECKVISIBLE",true],["COVER",true],["FSM",true],["LIGHTS",true],["MINEDETECTION",true],["MOVE",true],["NVG",true],["PATH",true],["RADIOPROTOCOL",true],["SUPPRESSION",true],["TARGET",true],["TEAMSWITCH",true],["WEAPONAIM",true]],[["general",0.5775],["courage",0.5775],["aimingAccuracy",0.31375],["aimingShake",0.31375],["aimingSpeed",0.78875],["commanding",0.5775],["endurance",0.5775],["spotDistance",0.5775],["spotTime",0.5775],["reloadSpeed",0.5775]]],[B Alpha 1-2:7,[["ALL",false],["AIMINGERROR",true],["ANIM",true],["AUTOCOMBAT",true],["AUTOTARGET",true],["CHECKVISIBLE",true],["COVER",true],["FSM",true],["LIGHTS",true],["MINEDETECTION",true],["MOVE",true],["NVG",true],["PATH",true],["RADIOPROTOCOL",true],["SUPPRESSION",true],["TARGET",true],["TEAMSWITCH",true],["WEAPONAIM",true]],[["general",0.5775],["courage",0.5775],["aimingAccuracy",0.31375],["aimingShake",0.31375],["aimingSpeed",0.78875],["commanding",0.5775],["endurance",0.5775],["spotDistance",0.5775],["spotTime",0.5775],["reloadSpeed",0.5775]]],[B Alpha 1-2:8,[["ALL",false],["AIMINGERROR",true],["ANIM",true],["AUTOCOMBAT",true],["AUTOTARGET",true],["CHECKVISIBLE",true],["COVER",true],["FSM",true],["LIGHTS",true],["MINEDETECTION",true],["MOVE",true],["NVG",true],["PATH",true],["RADIOPROTOCOL",true],["SUPPRESSION",true],["TARGET",true],["TEAMSWITCH",true],["WEAPONAIM",true]],[["general",0.5775],["courage",0.5775],["aimingAccuracy",0.31375],["aimingShake",0.31375],["aimingSpeed",0.78875],["commanding",0.5775],["endurance",0.5775],["spotDistance",0.5775],["spotTime",0.5775],["reloadSpeed",0.5775]]]]
