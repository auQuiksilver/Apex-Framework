/*/
File: fn_AIEnableFeature.sqf
Author:

	Quiksilver
	
Last Modified:

	8/05/2022 A3 2.08 by Quiksilver
	
Description:

	Toggle AI Features on/off
	
Example:

	[0,(units _grp),['AUTOCOMBAT','COVER'],FALSE] call (missionNamespace getVariable 'QS_fnc_AIEnableFeature');
	https://community.bistudio.com/wiki/disableAI
	https://community.bistudio.com/wiki/enableAI

	"all"	Disables all features.	
	"AIMINGERROR"	Prevents AI's aiming from being distracted by its shooting, moving, turning, reloading, hit, injury, fatigue, suppression or concealed / lost target.	
	"ANIM"	Disables all animations of the unit. Completely freezes the unit, including breathing and blinking. No move command works until the unit is unfrozen.	
	"AUTOCOMBAT"	Disables autonomous switching to "COMBAT" AI Behaviour when in danger.	
	"AUTOTARGET"	Essentially makes single units without a group "deaf". The unit still goes prone and combat ready if it hears gunfire. It will not turn around when gunfire comes from behind, but if an enemy walks in front of it it will target the enemy and fire as normal. Does not work for grouped units as the leader will assign targets to the units, effectively reenabling this feature.	-
	"CHECKVISIBLE"	Disables visibility raycasts. Useful in PvP missions where these raycasts are not needed.	
	"COVER"	Disables usage of cover positions by the AI.	
	"FSM"	Disables the attached FSM scripts which are responsible for the AI behaviour. Enemies react slower to enemy fire and the enemy stops using hand signals. Disabling FSM can give the impression of untrained units as they react slower and are more disorganized compared to when FSM is enabled.	
	"LIGHTS"	Stops AI from operating vehicle headlights and collision lights.	
	"MINEDETECTION"	Disable AI's mine detection.	
	"MOVE"	This will stop units from turning and moving, including vehicles. Units will still change stance and fire at the enemy if the enemy happens to walk right in front of the barrel. Units will watch enemies that are in their line of sight, but will not turn their bodies to face the enemy, only their head. Works for grouped units as well. Good for staging units and holding them completely still. Movement can not be controlled via script either, this feature has to be reenabled for that. The unit will still be able to aim within its cone of fire.	-
	"NVG"	Stops AI from putting on NVGs (but not from taking them off).	
	"PATH"	Stops the AI's movement but not the target alignment.	
	"RADIOPROTOCOL"	Stops AI from talking and texting while still being able to issue orders.	
	"SUPPRESSION"	Prevents AI from being suppressed. See Arma 3: Suppression.	2
	"TARGET"	Prevents units from engaging targets. Units still move around for cover, but will not hunt down enemies. Works in groups as well. Excellent for keeping units inside bases or other areas without having them flank or engage anyone. They will still seek good cover if something is close by.	-
	"TEAMSWITCH"	This will disable AI unit when teamswitching.	-
	"WEAPONAIM"	Disables weapon aiming.
	
_________________________________________________/*/

params [
	['_type',-1],
	['_units',[]],
	['_ai',[]],
	['_onOff',TRUE]
];
if (_type isEqualTo 4) exitWith {
	_units enableAIFeature [_ai,_onOff];
};
if (_type isEqualTo 0) exitWith {
	private _unit = objNull;
	if (_units isEqualType []) then {
		private _unit = objNull;
		{
			if (local _x) then {
				_unit = _x;
				if (_ai isNotEqualTo []) then {
					{
						if (_onOff) then {
							if (!(_unit checkAIFeature _x)) then {
								_unit enableAIFeature [_x,_onOff];
							};
						} else {
							if (_unit checkAIFeature _x) then {
								_unit enableAIFeature [_x,_onOff];
							};
						};
					} forEach _ai;
				};
			};
		} forEach _units;
	} else {
		if (_units isEqualType objNull) then {
			{
				if (_onOff) then {
					if (!(_units checkAIFeature _x)) then {
						_units enableAIFeature [_x,_onOff];
					};
				} else {
					if (_units checkAIFeature _x) then {
						_units enableAIFeature [_x,_onOff];
					};
				};
			} forEach _ai;
		};
	
	};
};
if (_type isEqualTo 1) exitWith {
	// preset 1 - NORMAL
	_preset_1 = [
		['ALL',TRUE],
		['AIMINGERROR',TRUE],
		['ANIM',TRUE],
		['AUTOCOMBAT',FALSE],
		['AUTOTARGET',TRUE],
		['CHECKVISIBLE',TRUE],
		['COVER',FALSE],
		['FSM',TRUE],
		['LIGHTS',TRUE],
		['MINEDETECTION',FALSE],
		['MOVE',TRUE],
		['NVG',TRUE],
		['PATH',TRUE],
		['RADIOPROTOCOL',FALSE],
		['SUPPRESSION',FALSE],
		['TARGET',TRUE],
		['TEAMSWITCH',TRUE],
		['WEAPONAIM',TRUE]
	];
	{
		_unit enableAIFeature [_x # 0,_x # 1];
	} forEach _units;
};
if (_type isEqualTo 2) exitWith {
	// preset 2 - OFF
	_preset_1 = [
		['ALL',FALSE],
		['AIMINGERROR',FALSE],
		['ANIM',FALSE],
		['AUTOCOMBAT',FALSE],
		['AUTOTARGET',FALSE],
		['CHECKVISIBLE',FALSE],
		['COVER',FALSE],
		['FSM',FALSE],
		['LIGHTS',FALSE],
		['MINEDETECTION',FALSE],
		['MOVE',FALSE],
		['NVG',FALSE],
		['PATH',FALSE],
		['RADIOPROTOCOL',FALSE],
		['SUPPRESSION',FALSE],
		['TARGET',FALSE],
		['TEAMSWITCH',FALSE],
		['WEAPONAIM',FALSE]
	];
	{
		_unit enableAIFeature [_x # 0,_x # 1];
	} forEach _units;
};
if (_type isEqualTo 3) exitWith {
	// preset 3 - ON
	_preset_1 = [
		['ALL',TRUE],
		['AIMINGERROR',TRUE],
		['ANIM',TRUE],
		['AUTOCOMBAT',TRUE],
		['AUTOTARGET',TRUE],
		['CHECKVISIBLE',TRUE],
		['COVER',TRUE],
		['FSM',TRUE],
		['LIGHTS',TRUE],
		['MINEDETECTION',TRUE],
		['MOVE',TRUE],
		['NVG',TRUE],
		['PATH',TRUE],
		['RADIOPROTOCOL',TRUE],
		['SUPPRESSION',TRUE],
		['TARGET',TRUE],
		['TEAMSWITCH',TRUE],
		['WEAPONAIM',TRUE]
	];
	{
		_unit enableAIFeature [_x # 0,_x # 1];
	} forEach _units;
};