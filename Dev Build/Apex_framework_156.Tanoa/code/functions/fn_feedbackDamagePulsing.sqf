/*
File: fn_feedbackDamagePulsing.sqf
Author: 

	Vladimir Hynek, Borivoj Hlava
	
Last modified:

	25/04/2022 A3 2.08 by Quiksilver
	
Description:

	Damage Pulsing
_____________________________________________________*/

if (!isGameFocused) exitWith {};
BIS_fnc_feedback_damagePP = TRUE;
BIS_fnc_feedback_damageRadialBlur ppEffectAdjust [0,0,0.5,0.5];
BIS_fnc_feedback_damageRadialBlur ppEffectCommit 0;
BIS_fnc_feedback_damageBlur ppEffectAdjust [0];
BIS_fnc_feedback_damageBlur ppEffectCommit 0; 
BIS_fnc_feedback_damageCC ppEffectAdjust [1,1,0,[0.15, 0, 0, 0],[1, 0.5, 0.5, 1],[0.587, 0.199, 0.114, 0],[1, 1, 0, 0, 0, 0.2, 1]];
BIS_fnc_feedback_damageCC ppEffectCommit 0;
private _damage = damage player;
private _delay1 = 0.8 * acctime;
BIS_fnc_feedback_damageRadialBlur ppEffectAdjust [((0.005*_damage)+0.001067), ((0.005*_damage)+0.001067), 0.3, 0.3];
BIS_fnc_feedback_damageRadialBlur ppEffectEnable TRUE;
BIS_fnc_feedback_damageRadialBlur ppEffectCommit _delay1;
BIS_fnc_feedback_damageBlur ppEffectAdjust [_damage/1.5];
BIS_fnc_feedback_damageBlur ppEffectEnable TRUE;
BIS_fnc_feedback_damageBlur ppEffectCommit _delay1;
if ((currentVisionMode player) isEqualTo 0) then	{
	BIS_fnc_feedback_damageCC ppEffectAdjust [1,1,0,[0.15, 0, 0, ((0.466*_damage)+0.4)],
		[1.0, 0.5, 0.5, 1.2-((1.3*_damage)-0.8)],
		[0.587, 0.199, 0.114, 0],
		[0.85, 0.85, 0, 0, 0, 0.2, 1]
	];
} else {
	BIS_fnc_feedback_damageCC ppEffectAdjust [1,1,0,[0.15, 0.15, 0.15, ((0.466*_damage)+0.2)],
		[1, 1, 1, 1],
		[0.3, 0.3, 0.3, 0],
		[0.85, 0.85, 0, 0, 0, 0.2, 1]
	];
};
BIS_fnc_feedback_damageCC ppEffectEnable TRUE;
BIS_fnc_feedback_damageCC ppEffectForceInNVG TRUE;
BIS_fnc_feedback_damageCC ppEffectCommit _delay1;
uiSleep (_delay1 + 0.1);
private _delay2 = (1.5 + random 0.5) * acctime;
BIS_fnc_feedback_damageRadialBlur ppEffectAdjust [0,0,0.5,0.5];
BIS_fnc_feedback_damageRadialBlur ppEffectCommit _delay2;
BIS_fnc_feedback_damageBlur ppEffectAdjust [0];
BIS_fnc_feedback_damageBlur ppEffectCommit _delay2; 
BIS_fnc_feedback_damageCC ppEffectAdjust [1,1,0,[0.15, 0, 0, 0],[1, 0.5, 0.5, 1],[0.587, 0.199, 0.114, 0],[1, 1, 0, 0, 0, 0.2, 1]];
BIS_fnc_feedback_damageCC ppEffectCommit _delay2;
uiSleep (_delay2 + 0.1);
BIS_fnc_feedback_damageCC ppEffectEnable FALSE;
BIS_fnc_feedback_damageRadialBlur ppEffectEnable FALSE;
BIS_fnc_feedback_damageBlur ppEffectEnable FALSE;
BIS_fnc_feedback_damagePP = FALSE;