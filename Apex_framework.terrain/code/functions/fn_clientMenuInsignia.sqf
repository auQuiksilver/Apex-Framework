/*
File: fn_clientMenuInsignia.sqf
Author:
	
	Quiksilver
	
Last Modified:

	24/08/2016 ArmA 3 1.62 by Quiksilver

Description:

	Client Menu Insignia
__________________________________________________________*/

disableSerialization;
private ['_supporterLevel','_list','_type','_supporterAccess','_displayName','_texture','_index','_display','_toolTip','_author'];
_type = _this select 0;
_display = _this select 1;

_supporterLevel = [] call (missionNamespace getVariable 'QS_fnc_clientGetSupporterLevel');
_list = [] call (missionNamespace getVariable 'QS_Insignia');

if (_type isEqualTo 'onLoad') then {
	{
		_supporterAccess = _x select 0;
		_displayName = _x select 1;
		_texture = _x select 2;
		_toolTip = _x select 3;
		_author = _x select 4;
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
	if (!(_index isEqualTo -1)) then {
		_supporterAccess = (_list select _index) select 0;
		_displayName = (_list select _index) select 1;
		_texture = (_list select _index) select 2;
		if (_supporterAccess <= _supporterLevel) then {
			[_texture] call (missionNamespace getVariable 'QS_fnc_clientSetUnitInsignia');
			player setVariable ['QS_ClientUnitInsignia2',_texture,FALSE];
			profileNamespace setVariable ['QS_ClientUnitInsignia2',_texture];
			saveProfileNamespace;
			_text = format ['Insignia Set: %1',_displayName];
			(missionNamespace getVariable 'QS_managed_hints') pushBack [5,FALSE,5,-1,_text,[],(serverTime + 10)];
		} else {
			_text = parseText format ['Supporter level required: %1<br/>Your supporter level: %2<br/>Insignia not set.',_supporterAccess,_supporterLevel];
			(missionNamespace getVariable 'QS_managed_hints') pushBack [5,FALSE,5,-1,_text,[],(serverTime + 10)];
		};
	};
};

if (_type isEqualTo 'Back') then {
	closeDialog 0;
	createDialog 'QS_RD_client_dialog_menu_supporters';
};

if (_type isEqualTo 'onUnload') then {

};