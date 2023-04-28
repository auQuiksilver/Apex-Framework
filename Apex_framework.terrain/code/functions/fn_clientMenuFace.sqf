/*
File: fn_clientMenuFace.sqf
Author:
	
	Quiksilver
	
Last Modified:

	15/04/2023 A3 2.12 by Quiksilver

Description:

	Face Paint Menu
__________________________________________*/

disableSerialization;
params ['_type','_display'];
private _data = ['cfgfaces_1'] call QS_data_listOther;
if (_type isEqualTo 'onLoad') then {
	localNamespace setVariable ['QS_unit_selectedFaceIndex',''];
	localNamespace setVariable ['QS_unit_startFace',face player];
	_startingFace = face player;
	private _displayName = '';
	private _tooltip = '';
	{
		_displayName = _x # 0;
		_className = _x # 1;
		lbAdd [1804,_displayName];
	} forEach _data;
	private _index = -1;
	private _heldIndex = -2;
	private _face = '';
	private _element = [];
	waitUntil {
		_index = lbCurSel 1804;
		if (
			(_index isNotEqualTo -1) &&
			{(_heldIndex isNotEqualTo _index)}
		) then {
			_heldIndex = _index;
			_element = _data # _index;
			_element params ['_displayName','_face','_custom'];
			localNamespace setVariable ['QS_unit_selectedFace',_face];
			localNamespace setVariable ['QS_faceMenu_data',[_displayName,_face,_custom]];
			if ((face player) != _face) then {
				player setFace _face;
			};
		};
		(isNull _display)
	};
};
if (_type isEqualTo 'onUnload') then {
	if ((localNamespace getVariable ['QS_unit_selectedFace','']) isEqualTo '') then {
		player setFace (localNamespace getVariable ['QS_unit_startFace',face player]);
	};
};
if (_type isEqualTo 'Select') then {
	_index = lbCurSel 1804;
	if (_index isNotEqualTo -1) then {
		_face = localNamespace getVariable ['QS_unit_selectedFace',face player];
		player setVariable ['QS_unit_face',_face,TRUE];
		['setFace',player,_face] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
		missionProfileNamespace setVariable ['QS_unit_face',_face];
		saveMissionProfileNamespace;
	};
	closeDialog 2;
	0 spawn {
		uiSleep 0.1;
		waitUntil {
			closeDialog 2;
			(!dialog)
		};
		50 cutText [localize 'STR_QS_Text_443','PLAIN DOWN',0.3];
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