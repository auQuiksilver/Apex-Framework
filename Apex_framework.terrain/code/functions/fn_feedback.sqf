/*
File: fn_feedback.sqf
Author: 

	Quiksilver
	
Last modified:

	26/04/2022 A3 2.08 by Quiksilver
	
Description:

	Feedback
________________________________________________________*/

if ((getMissionConfigValue ['overrideFeedback',0]) isEqualTo 0) exitWith {};
_true = TRUE;
_false = FALSE;
BIS_fnc_feedback_allowPP = TRUE;
BIS_fnc_feedback_allowDeathScreen = FALSE;
BIS_ppType = '';
BIS_ppDestroyed = false;
BIS_fakeDamage = 0.1;
BIS_add = true;
BIS_distToFire = 10;
BIS_performPP = true;
BIS_fnc_feedback_damagePP = FALSE;
BIS_respawnInProgress = false;
BIS_fnc_feedback_testHelper = 0;
BIS_EnginePPReset = false;
['HealthPP_blood'] call bis_fnc_rscLayer;
['HealthPP_dirt'] call bis_fnc_rscLayer;
['HealthPP_fire'] call bis_fnc_rscLayer;
['HealthPP_black'] call bis_fnc_rscLayer;
BIS_pulsingFreq = getNumber (configFile >> 'cfgFirstAid' >> 'pulsationSoundInterval');
QS_hashmap_configfile set ['cfgfirstaid_pulsationsoundinterval',BIS_pulsingFreq];
BIS_helper = 0.5;
BIS_applyPP1 = true;
BIS_applyPP2 = true;
BIS_applyPP3 = true;
BIS_applyPP8 = true;
BIS_canStartRed = true;
BIS_fnc_feedback_blue = true;
BIS_canStartBlue = true;
BIS_oldDMG = 0;
BIS_deltaDMG = 0;
BIS_oldLifeState = 'HEALTHY';
BIS_TotDesatCC = ppEffectCreate ["ColorCorrections", 1600];
BIS_TotDesatCC ppEffectAdjust [1,1,0,[0, 0, 0, 0],[1, 1, 1, 1],[0,0,0,0]];
BIS_blendColorAlpha = 0.0;
BIS_fnc_feedback_damageCC = ppEffectCreate ["ColorCorrections", 1605];
BIS_fnc_feedback_damageRadialBlur = ppEffectCreate ["RadialBlur", 260];
BIS_fnc_feedback_damageBlur = ppEffectCreate ["DynamicBlur", 160];
BIS_SuffCC = ppEffectCreate ["ColorCorrections", 1610];
BIS_SuffCC ppEffectAdjust [1,1,0,[0, 0, 0, 0 ],[1, 1, 1, 1],[0,0,0,0], [-1, -1, 0, 0, 0, 0.001, 0.5]];
BIS_SuffRadialBlur = ppEffectCreate ["RadialBlur", 270];
BIS_SuffBlur = ppEffectCreate ["DynamicBlur", 170];
BIS_applyPP5 = true;
BIS_oldOxygen = 1.0;
BIS_counter = 1;
BIS_alfa = 0.0;
BIS_applyPP6 = true;
BIS_oldWasBurning = false;
BIS_BurnCC = ppEffectCreate ["ColorCorrections", 1620];
BIS_BurnWet = ppEffectCreate ["WetDistortion", 400];
BIS_PP_burnParams = [];
BIS_PP_burning = false;
BIS_fnc_feedback_burningTimer = 0;
BIS_UncCC = ppEffectCreate ["ColorCorrections", 1603];
BIS_UncRadialBlur = ppEffectCreate ["RadialBlur", 280];
BIS_UncBlur = ppEffectCreate ["DynamicBlur", 180];
BIS_applyPP4 = true;
BIS_DeathCC = ppEffectCreate ["ColorCorrections", 1640];
BIS_DeathRadialBlur = ppEffectCreate ["RadialBlur", 290];
BIS_DeathBlur = ppEffectCreate ["DynamicBlur", 190];
BIS_oldBleedRemaining = 0;
BIS_applyPP7 = true;
BIS_BleedCC = ppEffectCreate ["ColorCorrections", 1645];
BIS_HitCC = ppEffectCreate ["ColorCorrections", 1650];
BIS_wasHit = false;
BIS_performingDustPP = FALSE;
BIS_damageFromExplosion = 0;
BIS_myOxygen = 1.0;
BIS_respawned = false;
BIS_fnc_feedback_fatiguePP = false;
BIS_fnc_feedback_fatigueCC = ppEffectCreate ["ColorCorrections", 1615];
BIS_fnc_feedback_fatigueRadialBlur = ppEffectCreate ["RadialBlur", 275];
BIS_fnc_feedback_fatigueBlur = ppEffectCreate ["DynamicBlur", 175];
BIS_suppressCC = ppEffectCreate ["colorCorrections", 1500];
BIS_suppressCC ppEffectAdjust [1, 1, 0, [0, 0, 0, 0], [1, 1, 1, 1], [1, 1, 1, 0]];
BIS_suppressCC ppEffectEnable TRUE;
BIS_suppressCC ppEffectCommit 0;
BIS_suppressImpactBlur = ppEffectCreate ["RadialBlur", 1010];
BIS_suppressImpactBlur ppEffectAdjust [0, 0, 0, 0];
BIS_suppressImpactBlur ppEffectCommit 0;
BIS_suppressImpactBlur ppEffectEnable TRUE;
BIS_suppressLastShotTime = diag_tickTime;
private _QS_player = player;
private _QS_lifeState = lifeState player;
_fn_feedbackDamageChanged = missionNamespace getVariable 'QS_fnc_feedbackDamageChanged';
_fn_feedbackSuddenDeath = missionNamespace getVariable 'QS_fnc_feedbackSuddenDeath';
_fn_feedbackSuffocating = missionNamespace getVariable 'QS_fnc_feedbackSuffocating';
_fn_feedbackSuffocatingOut = missionNamespace getVariable 'QS_fnc_feedbackSuffocatingOut';
_fn_feedbackFatigue = missionNamespace getVariable 'QS_fnc_feedbackFatigue';
_fn_feedbackRadialRedOut = missionNamespace getVariable 'QS_fnc_feedbackRadialRedOut';

//----------------------------------------------------- MAIN LOOP

for '_z' from 0 to 1 step 0 do {
	if (!isGameFocused) then {
		waitUntil {isGameFocused};
	};
	if (_QS_player isNotEqualTo player) then {
		_QS_player = player;
	};
	if (_QS_lifeState isNotEqualTo (lifeState _QS_player)) then {
		_QS_lifeState = lifeState _QS_player;
	};

	//----- Damage changed - blood/dirt/healing/burning

	if (
		(focusOn isEqualTo _QS_player) &&
		{(_QS_lifeState in ['HEALTHY','INJURED'])} &&
		{(abs((damage _QS_player) - BIS_oldDMG) > 0.0001)} &&
		{BIS_applyPP3} &&
		{BIS_fnc_feedback_allowPP}
	) then {
		BIS_applyPP3 = _false;
		call _fn_feedbackDamageChanged;
	};

	//----- Sudden Death

	if (
		(_QS_lifeState isEqualTo 'DEAD') &&
		{(BIS_oldLifeState in ['HEALTHY','INJURED'])} &&
		{(BIS_applyPP4)} &&
		{(!BIS_fnc_feedback_allowDeathScreen)} &&
		{(BIS_fnc_feedback_allowPP)}
	) then {
		BIS_applyPP4 = _false;
		0 spawn _fn_feedbackSuddenDeath;
	};

	//----- Suffocating
	
	if (
		(focusOn isEqualTo _QS_player) &&
		{((getOxygenRemaining _QS_player) < 0.8)} &&
		{(_QS_lifeState isNotEqualTo 'DEAD')} && 
		{(abs((getOxygenRemaining _QS_player) - BIS_oldOxygen) > 0.0001)} &&
		{BIS_applyPP5} && 
		{BIS_fnc_feedback_allowPP}
	) then {
		BIS_oldOxygen = getOxygenRemaining _QS_player;
		BIS_applyPP5 = _false;
		0 spawn _fn_feedbackSuffocating;
	};
	
	//----- Fatigue
	
	if (
		!BIS_fnc_feedback_fatiguePP && 
		{focusOn isEqualTo _QS_player} &&
		{((getFatigue _QS_player) > 0.5)}
	) then {
		BIS_fnc_feedback_fatiguePP = _true;
		0 spawn _fn_feedbackFatigue;
	};
	
	//----- Check Not Suffocating
	
	if (
		(focusOn isEqualTo _QS_player) &&
		{((getOxygenRemaining _QS_player) >= 0.8)} &&
		{(BIS_oldOxygen < 0.8)} && 
		{BIS_fnc_feedback_allowPP}
	) then {
		BIS_oldOxygen = getOxygenRemaining _QS_player;
		0 spawn _fn_feedbackSuffocatingOut;
	};

	//----- Check Not Burning
	
	if (
		BIS_PP_burning && 
		{focusOn isEqualTo _QS_player} &&
		{!(isBurning _QS_player)}
	) then {
		if (BIS_fnc_feedback_burningTimer isNotEqualTo 0) then {
			if ((diag_tickTime - BIS_fnc_feedback_burningTimer) > 0.2) then {
				BIS_PP_burning = _false; 
				BIS_fnc_feedback_burningTimer = 0; 
				0 spawn _fn_feedbackRadialRedOut;
			};
		} else {
			BIS_fnc_feedback_burningTimer = diag_tickTime;
		};
	};
	uiSleep 0.1;
};