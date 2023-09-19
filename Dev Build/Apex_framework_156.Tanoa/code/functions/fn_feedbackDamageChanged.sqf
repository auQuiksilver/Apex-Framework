/*
@filename: fn_feedbackDamageChanged.sqf
Author:

	Quiksilver
	
Last modified:

	26/04/2022 A3 2.08 by Quiksilver
	
Description:

	-
__________________________________________________*/

BIS_applyPP3 = FALSE;
BIS_fnc_feedback_deltaDamage = (damage player) - BIS_oldDMG;
BIS_deltaDMG = abs BIS_fnc_feedback_deltaDamage;
if (BIS_fnc_feedback_deltaDamage < 0) then {
	if (BIS_fnc_feedback_blue) then {
		0 spawn QS_fnc_feedbackHealing;
	};
} else {
	if (BIS_wasHit) then {
		BIS_wasHit = FALSE;
		if (BIS_fnc_feedback_deltaDamage > 0) then {
			if (BIS_canStartRed) then {
				BIS_hitArray spawn QS_fnc_feedbackRadialRed;
			};
			if (isBurning player) then {
				BIS_fnc_feedback_burningTimer = 0;
				BIS_PP_burning = true;
				if (BIS_applyPP6) then {
					0 spawn QS_fnc_feedbackFlamesEffect;
				};
			};
		};
		if ((((GetBleedingRemaining player) - BIS_oldBleedRemaining) > 0.0001) && (isAbleToBreathe player)) then {
			[getBleedingRemaining player] spawn QS_fnc_feedbackBloodEffect;
		} else {
			BIS_oldBleedRemaining = getBleedingRemaining player;
		};
	};
};
BIS_applyPP3 = TRUE;
BIS_oldDMG = damage player;