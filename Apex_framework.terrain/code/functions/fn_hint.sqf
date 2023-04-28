/*/
File: fn_hint.sqf
Author:

	Quiksilver
	
Last Modified:

	13/09/2022 A3 2.10 by Quiksilver
	
Description:

	Hints
_____________________________________________________________________/*/

params [
	['_text','',['',(parseText '')]],
	['_useSound',FALSE,[FALSE,'']],
	['_adv',FALSE,[FALSE]],
	['_advTitle','',['',(parseText '')]],
	['_advRecall',FALSE,[FALSE]]
];
if (_text isEqualTo '') exitWith {
	33000 cutText ['','PLAIN'];
	uiNamespace setVariable ['QS_hint_opened',FALSE];
};
_display = uiNamespace getVariable ['QS_hint_display_1',displayNull];
if (isNull _display) then {
	33000 cutRsc ['QS_hud_hint','PLAIN',-1,TRUE];
	_display = uiNamespace getVariable ['QS_hint_display_1',displayNull];
};
_control = _display displayCtrl 101;
uiNamespace setVariable ['QS_hint_opened',TRUE];
if ((_adv) && (_text isEqualType '')) then {
	_textSizeSmall = 1;
	_textSizeNormal = 1.25;
	_invChar05 = "<img image='#(argb,8,8,3)color(0,0,0,0)' size='0.5' />";
	_invChar02 = "<img image='#(argb,8,8,3)color(0,0,0,0)' size='0.2' />";
	_shadowColor = '#999999';
	private _keyColor = uiNamespace getVariable ['QS_hint_recallKeyColor',-1];
	if (_keyColor isEqualTo -1) then {
		_keyColor = ['GUI','BCG_RGB'] call (missionNamespace getVariable 'BIS_fnc_displayColorGet');
		_keyColor resize 3;
		_keyColor = _keyColor vectorMultiply (1 / ((_keyColor # 0) max (_keyColor # 1) max (_keyColor # 2)));
		_keyColor = (_keyColor + [1]) call (missionNamespace getVariable 'BIS_fnc_colorRGBtoHTML');
		uiNamespace setVariable ['QS_hint_recallKeyColor',_keyColor];
	};
	_helpArray = actionKeysNamesArray 'help';
	private _keyString = if (_helpArray isNotEqualTo []) then {
		format ["[<t color = '%1'>%2</t>]",_keyColor,_helpArray # 0];
	} else {
		format ["[<t color = '#FF0000'>%1</t>]",(toUpper (localize 'STR_A3_Hints_unmapped'))];
	};
	_partString = format [(localize 'STR_A3_Hints_recall'),_keyString];
	_endPartString = format ["%4<br/><br/><t align='left' size='%2' color='%3'>%1</t>",_partString,_textSizeSmall,_shadowColor,_invChar02];
	private _advHint = '';
	if (_advTitle isNotEqualTo '') then {
		if (_advTitle isEqualType '') then {
			_advHint = format ["<t size = '1.25' align='left' font='RobotoCondensedBold'>%1</t><br/><br/>",(toUpper _advTitle)];
		};
	};
	_advHint = _advHint + _text;
	if (_advRecall) then {
		uiNamespace setVariable ['QS_hint_recalledHint',_this];
		_advHint = _advHint + _endPartString;
	};
	_advHint = parseText _advHint;
	_control ctrlSetStructuredText _advHint;
} else {
	if (_text isEqualType '') then {
		_text = parseText (format ['<br/>%1',_text]);
	};
	_control ctrlSetStructuredText _text;
};
_ctrlPosition = ctrlPosition _control;
_ctrlPosition set [3,(((ctrlTextHeight _control) + 0.02) max 0.06)];
_control ctrlSetPosition _ctrlPosition;
_control ctrlCommit 0;
if (_useSound isEqualType '') then {
	if (_useSound isNotEqualTo '') then {
		playSoundUI [_useSound];
	};
} else {
	if (_useSound isEqualType FALSE) then {
		if (_useSound) then {
			playSoundUI ['hint'];
		};
	};
};