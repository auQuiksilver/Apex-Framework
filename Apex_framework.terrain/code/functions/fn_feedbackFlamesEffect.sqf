/*
@filename: fn_feedbackDamageChanged.sqf
Author:

	Quiksilver
	
Last modified:

	26/04/2022 A3 2.08 by Quiksilver
	
Description:

	-
__________________________________________________*/

if (!canSuspend) exitWith {};
scriptName "fn_flamesEffect_mainLoop";
disableSerialization;
if (uiNamespace isNil 'RscHealthTextures') then {uinamespace setvariable ["RscHealthTextures",displaynull]};
if (isnull (uinamespace getvariable "RscHealthTextures")) then {(["HealthPP_fire"] call bis_fnc_rscLayer) cutrsc ["RscHealthTextures","plain"]};
private ['_ctrl','_pos'];
for '_i' from 1 to 10 do {
	_ctrl = (uinamespace getvariable "RscHealthTextures") displayctrl (1200+_i);
	_pos = [safezoneX,safezoneY,safezoneW,safezoneH];
	_ctrl ctrlsetposition _pos;
	_ctrl ctrlsetfade 0.5;
	_ctrl ctrlcommit 0;
	uiSleep 0.04;
	_ctrl ctrlsetfade 1;
	_ctrl ctrlcommit 0;
};
uiSleep (0.4 + random 2);
BIS_applyPP6 = true;