/*
File: fn_clientMenuUTexture.sqf
Author:
	
	Quiksilver
	
Last Modified:

	5/10/2016 A3 1.64 by Quiksilver

Description:

	Client Menu Uniform Textures
__________________________________________________________*/

disableSerialization;
params ['_type','_display'];
private [
	'_supporterLevel','_list','_supporterAccess','_displayName','_texture','_index','_toolTip','_validUniforms_1','_validUniforms','_validUniform_2',
	'_validUniform_3','_validUniform_4','_author','_patch'
];
_supporterLevel = [] call (missionNamespace getVariable 'QS_fnc_clientGetSupporterLevel');
_list = [] call (missionNamespace getVariable 'QS_UTextures');
if (_type isEqualTo 'onLoad') then {
	(findDisplay 2000) closeDisplay 1;
	(findDisplay 3000) closeDisplay 1;
	setMousePosition (uiNamespace getVariable ['QS_ui_mousePosition',getMousePosition]);
	{
		_supporterAccess = _x # 0;
		_displayName = _x # 1;
		_texture = _x # 2;
		_toolTip = _x # 3;
		lbAdd [1804,_displayName];
		lbSetPicture [1804,_forEachIndex,_texture];
		lbSetTooltip [1804,_forEachIndex,_toolTip];
		if (_supporterAccess > _supporterLevel) then {
			lbSetColor [1804,_forEachIndex,[0.5,0.5,0.5,0.5]];
			lbSetPictureColor [1804,_forEachIndex,[0.5,0.5,0.5,0.5]];
			lbSetPictureColorSelected [1804,_forEachIndex,[0.5,0.5,0.5,0.5]];
		};
	} forEach _list;
	lbSetCurSel [1804,0];
};
private _text = '';
if (_type isEqualTo 'Select') then {
	_index = lbCurSel 1804;
	if (_index isNotEqualTo -1) then {
		_supporterAccess = (_list # _index) # 0;
		_displayName = (_list # _index) # 1;
		_texture = (_list # _index) # 2;
		_tooltip = (_list # _index) # 3;
		_validUniforms = (_list # _index) # 4;
		_author = (_list # _index) # 5;
		_patch = '';
		if ((count (_list # _index)) > 6) then {
			_patch = (_list # _index) # 6;
		};
		if (_supporterAccess <= _supporterLevel) then {
			if ((uniform player) in _validUniforms) then {
				([QS_player,'SAFE'] call QS_fnc_inZone) params ['_inSafezone','_safezoneLevel','_safezoneActive'];
				if (_inSafezone) then {
					player setObjectTextureGlobal [0,_texture];
					player setVariable ['QS_ClientUTexture2',_texture,FALSE];
					player setVariable ['QS_ClientUTexture2_Uniforms2',_validUniforms,FALSE];
					missionProfileNamespace setVariable ['QS_ClientUTexture2',_texture];
					missionProfileNamespace setVariable ['QS_ClientUTexture2_Uniforms2',_validUniforms];
					if (_patch isNotEqualTo '') then {
						if ((vest player) isNotEqualTo '') then {
						
						};
						/*/
						if ((backpack player) isNotEqualTo '') then {
							(backpackContainer player) setObjectTextureGlobal [0,_patch];
						};
						/*/
					};
					saveMissionProfileNamespace;
					_text = parseText format ['%3 %1<br/>by %2',_displayName,_author,localize 'STR_QS_Hints_074'];
					(missionNamespace getVariable 'QS_managed_hints') pushBack [5,FALSE,5,-1,_text,[],-1];
				} else {
					(missionNamespace getVariable 'QS_managed_hints') pushBack [5,FALSE,5,-1,localize 'STR_QS_Hints_075',[],-1];
				};
			} else {
				if (_index isEqualTo 0) then {
					player forceAddUniform (uniform player);
					player setVariable ['QS_ClientUTexture2','',FALSE];
					player setVariable ['QS_ClientUTexture2_Uniforms2',[],FALSE];
					missionProfileNamespace setVariable ['QS_ClientUTexture2',''];
					missionProfileNamespace setVariable ['QS_ClientUTexture2_Uniforms2',[]];
					saveMissionProfileNamespace;
					(missionNamespace getVariable 'QS_managed_hints') pushBack [5,FALSE,5,-1,localize 'STR_QS_Hints_076',[],-1];
				} else {
					(missionNamespace getVariable 'QS_managed_hints') pushBack [5,FALSE,8,-1,localize 'STR_QS_Hints_077',[],-1];
				};
			};
		} else {
			_text = parseText format ['%3 %1<br/>%4 %2<br/>%5',_supporterAccess,_supporterLevel,localize 'STR_QS_Hints_078',localize 'STR_QS_Hints_079',localize 'STR_QS_Hints_080'];
			(missionNamespace getVariable 'QS_managed_hints') pushBack [5,FALSE,10,-1,_text,[],-1];
		};
	};
};
if (_type isEqualTo 'Back') then {
	closeDialog 2;
	0 spawn {
		uiSleep 0.1;
		waitUntil {
			closeDialog 2;
			(!dialog)
		};
		createDialog 'QS_RD_client_dialog_menu_supporters';
	};
};
if (_type isEqualTo 'onUnload') then {
	uiNamespace setVariable ['QS_ui_mousePosition',getMousePosition];
};