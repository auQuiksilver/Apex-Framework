/*
@filename: fn_feedbackBloodEffect.sqf
Author:

	Quiksilver
	
Last modified:

	26/04/2022 A3 2.08 by Quiksilver
	
Description:

	-
__________________________________________________*/

if (!canSuspend) exitWith {};
BIS_oldBleedRemaining = _this # 0;
disableSerialization;
if (uiNamespace isNil 'RscHealthTextures') then {uinamespace setvariable ["RscHealthTextures",displaynull]};
if (isnull (uinamespace getvariable "RscHealthTextures")) then {(["HealthPP_blood"] call BIS_fnc_rscLayer) cutrsc ["RscHealthTextures","plain"]};
private _display = uinamespace getvariable "RscHealthTextures";
private _texLower = _display displayctrl 1211;
_texLower ctrlsetfade 1;
_texLower ctrlcommit 0;
private _texMiddle = _display displayctrl 1212;
_texMiddle ctrlsetfade 1;	
_texMiddle ctrlcommit 0;
private _texUpper = _display displayctrl 1213;
_texUpper ctrlsetfade 1;	
_texUpper ctrlcommit 0;
private _x = ((0 * safezoneW) + safezoneX) + ((safezoneW - (2.125 * safezoneW * 3/4)) / 2);
private _y = (-0.0625 * safezoneH) + safezoneY;
private _w = 2.125 * safezoneW * 3/4;
private _h = 1.125 * safezoneH;
_texLower ctrlsetposition [_x, _y, _w, _h];
_texMiddle ctrlsetposition [_x, _y, _w, _h];
_texUpper ctrlsetposition [_x, _y, _w, _h];
_texLower ctrlcommit 0;
_texMiddle ctrlcommit 0;
_texUpper ctrlcommit 0;
private _primaryDelay = 1;
private _secondaryDelay = 3;
if ((BIS_oldBleedRemaining > 5) && (BIS_oldBleedRemaining < 25)) then {
	_texLower ctrlsetfade 0.2;
	_texLower ctrlcommit 0.2;
	waituntil {ctrlcommitted _texLower};
	uiSleep _primaryDelay;
	_texLower ctrlsetfade 1;
	_texLower ctrlcommit 0.8;
};
if ((BIS_oldBleedRemaining >= 25) && (BIS_oldBleedRemaining < 40)) then {
	_texLower ctrlsetfade 0.2;
	_texMiddle ctrlsetfade 0.85;
	_texLower ctrlcommit 0.2;
	_texMiddle ctrlcommit 0.2;
	waituntil {ctrlcommitted _texMiddle};
	uiSleep _primaryDelay;
	_texLower ctrlsetfade 1;
	_texMiddle ctrlsetfade 1;
	_texMiddle ctrlcommit 1;
	uiSleep _primaryDelay;
	_texLower ctrlcommit 0.8;
};
if ((BIS_oldBleedRemaining >= 40) && (BIS_oldBleedRemaining < 55)) then {
	_texLower ctrlsetfade 0.2;
	_texMiddle ctrlsetfade 0.7;
	_texLower ctrlcommit 0.2;
	_texMiddle ctrlcommit 0.2;
	waituntil {ctrlcommitted _texMiddle};
	uiSleep _primaryDelay;
	_texLower ctrlsetfade 1;
	_texMiddle ctrlsetfade 1;
	_texUpper ctrlsetfade 1;
	_texMiddle ctrlcommit 1;
	uiSleep _primaryDelay;
	_texLower ctrlcommit 0.8;
};
if ((BIS_oldBleedRemaining >= 55) && (BIS_oldBleedRemaining < 70)) then {
	_texLower ctrlsetfade 0.2;
	_texMiddle ctrlsetfade 0.7;
	_texUpper ctrlsetfade 0.85;
	_texLower ctrlcommit 0.2;
	_texMiddle ctrlcommit 0.2;
	_texUpper ctrlcommit 0.2;
	waituntil {ctrlcommitted _texUpper};
	uiSleep _primaryDelay;
	_texLower ctrlsetfade 1;
	_texMiddle ctrlsetfade 1;
	_texUpper ctrlsetfade 1;
	_texUpper ctrlcommit 1.5;
	uiSleep _secondaryDelay;
	_texMiddle ctrlcommit 1;
	uiSleep _primaryDelay;
	_texLower ctrlcommit 0.8;
};
if (BIS_oldBleedRemaining >= 70) then {
	_texLower ctrlsetfade 0.2;
	_texMiddle ctrlsetfade 0.7;
	_texUpper ctrlsetfade 0.7;
	
	_texLower ctrlcommit 0.2;
	_texMiddle ctrlcommit 0.2;
	_texUpper ctrlcommit 0.2;
	waituntil {ctrlcommitted _texUpper};
	uiSleep _primaryDelay;
	_texLower ctrlsetfade 1;
	_texMiddle ctrlsetfade 1;
	_texUpper ctrlsetfade 1;
	_texUpper ctrlcommit 1.5;
	uiSleep _secondaryDelay;
	_texMiddle ctrlcommit 1;
	uiSleep _primaryDelay;
	_texLower ctrlcommit 0.8;
};