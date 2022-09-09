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
_type = _this # 0;
_display = _this # 1;

_supporterLevel = [] call (missionNamespace getVariable 'QS_fnc_clientGetSupporterLevel');
_list = [] call (missionNamespace getVariable 'QS_Insignia');

if (_type isEqualTo 'onLoad') then {
	{
		_supporterAccess = _x # 0;
		_displayName = _x # 1;
		_texture = _x # 2;
		_toolTip = _x # 3;
		_author = _x # 4;
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
		_supporterAccess = (_list # _index) # 0;
		_displayName = (_list # _index) # 1;
		_texture = (_list # _index) # 2;
		if (_supporterAccess <= _supporterLevel) then {
			[_texture] call (missionNamespace getVariable 'QS_fnc_clientSetUnitInsignia');
			player setVariable ['QS_ClientUnitInsignia2',_texture,FALSE];
			missionProfileNamespace setVariable ['QS_ClientUnitInsignia2',_texture];
			saveMissionProfileNamespace;
			_text = format ['%2 %1',_displayName,localize 'STR_QS_Hints_053'];
			(missionNamespace getVariable 'QS_managed_hints') pushBack [5,FALSE,5,-1,_text,[],(serverTime + 10)];
		} else {
			_text = parseText format ['%3 %1<br/>%4 %2<br/>%5',_supporterAccess,_supporterLevel,localize 'STR_QS_Hints_054',localize 'STR_QS_Hints_055',localize 'STR_QS_Hints_056'];
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