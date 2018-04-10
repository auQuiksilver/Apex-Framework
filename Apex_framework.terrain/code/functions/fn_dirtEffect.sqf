/*
	File: fn_dirtEffect.sqf
	Author: Vladimir Hynek (tweaked by Quiksilver)

	Description:
	Dirt (texture) postprocess.

	Parameter(s):
	_this select 0: Object - Unit who gets the damage.
	_this select 1: Number - Damage given unit by explosion.
	
	Returned value:
	None.
*/

if ((!(missionNamespace getVariable 'BIS_performingDustPP'))  && (isAbleToBreathe player) && (((uavControl (getConnectedUav player)) select 1) isEqualTo '')) then {
	missionNamespace setVariable ['BIS_performingDustPP',TRUE,FALSE];
	missionNamespace setVariable ['BIS_damageFromExplosion',(_this select 1),FALSE];
	0 spawn {
		scriptName 'BIS dirtEffect';
		private ['_display','_texLower','_texUpper','_x','_y','_w','_h'];
		disableSerialization;
		if (isnil {uinamespace getvariable 'RscHealthTextures'}) then {
			uinamespace setvariable ['RscHealthTextures',displaynull];
		};
		if (isnull (uinamespace getvariable 'RscHealthTextures')) then {
			(['HealthPP_dirt'] call (missionNamespace getVariable 'BIS_fnc_rscLayer')) cutrsc ['RscHealthTextures','PLAIN'];
		};
		_display = uinamespace getvariable 'RscHealthTextures';
	   _texLower = _display displayctrl 1214;
	   _texLower ctrlsetfade 1;	
	   _texLower ctrlcommit 0;
	   _texUpper = _display displayctrl 1215;
	   _texUpper ctrlsetfade 1;
	   _texUpper ctrlcommit 0;
		_x = ((0 * safezoneW) + safezoneX) + ((safezoneW - (2.125 * safezoneW * 3/4)) / 2);
		_y = (-0.0625 * safezoneH) + safezoneY;
		_w = 2.125 * safezoneW * 3/4;
		_h = 1.125 * safezoneH;
		_texLower ctrlsetposition [_x,_y,_w,_h];
		_texUpper ctrlsetposition [_x,_y,_w,_h];
		_texLower ctrlcommit 0;
		_texUpper ctrlcommit 0;
		/*/lower/*/
		if (((missionNamespace getVariable 'BIS_damageFromExplosion') > 0.0001) && ((missionNamespace getVariable 'BIS_damageFromExplosion') < 0.03)) then {
			_texLower ctrlsetfade 0;
			_texLower ctrlcommit 0.3;
			waituntil {ctrlcommitted _texLower};
			/*/fade out/*/
			uiSleep 1.5;
			_texLower ctrlsetfade 1;
			_texLower ctrlcommit 1.2;
		};
		/*/lower, 50% upper/*/
		if (((missionNamespace getVariable 'BIS_damageFromExplosion') >= 0.03) && ((missionNamespace getVariable 'BIS_damageFromExplosion') < 0.15)) then {
			_texLower ctrlsetfade 0;
			_texUpper ctrlsetfade 0.5;
			_texLower ctrlcommit 0.3;
			_texUpper ctrlcommit 0.3;
			waituntil {ctrlcommitted _texUpper};
			/*/fade out-----------------------/*/
			uiSleep 1.5;
			_texLower ctrlsetfade 1;
			_texUpper ctrlsetfade 1;
			_texUpper ctrlcommit 1.5;
			uiSleep 0.75;
			_texLower ctrlcommit 1.2;
		};
		/*/lower, upper/*/
		if ((missionNamespace getVariable 'BIS_damageFromExplosion') >= 0.15) then {
			_texLower ctrlsetfade 0;
			_texUpper ctrlsetfade 0;
			_texLower ctrlcommit 0.2;
			_texUpper ctrlcommit 0.2;
			waituntil {ctrlcommitted _texUpper};
			/*/fade out-----------------------/*/
			uiSleep 1.5;
			_texLower ctrlsetfade 1;
			_texUpper ctrlsetfade 1;
			_texUpper ctrlcommit 1.5;
			uiSleep 0.75;
			_texLower ctrlcommit 1.2;
		};
		uiSleep 1.2;
		missionNamespace setVariable ['BIS_performingDustPP',FALSE,FALSE];
	};
};