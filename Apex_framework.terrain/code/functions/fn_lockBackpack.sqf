/*
File: fn_lockBackpack.sqf
Author:

	Quiksilver
	
Last Modified:

	1/02/2023 A3 2.12 by Quiksilver
	
Description:

	Lock backpack
	
	(missionProfileNamespace getVariable ['QS_lockedInventory',FALSE])
__________________________________________________*/

params ['_mode1','_unit'];
if (_mode1 isEqualTo 'BUTTON') exitWith {
	if (!isNull ((findDisplay 602) displayCtrl 12346)) then {
		if (_unit getVariable ['QS_lockedInventory',FALSE]) then {
			50 cutText [localize 'STR_QS_Text_021','PLAIN DOWN',0.5];
			_unit setVariable ['QS_lockedInventory',FALSE,TRUE];
			missionProfileNamespace setVariable ['QS_lockedInventory',FALSE];
		} else {
			50 cutText [localize 'STR_QS_Text_020','PLAIN DOWN',0.5];
			_unit setVariable ['QS_lockedInventory',TRUE,TRUE];
			missionProfileNamespace setVariable ['QS_lockedInventory',TRUE];
		};
		saveMissionProfileNamespace;
		uiNamespace setVariable ['QS_backpack_lockTime',(diag_tickTime + 1)];
	};
};
if (_mode1 isEqualTo 'MONITOR') exitWith {
	disableSerialization;
	params ['','','_inventory','_isBackpack'];
	private ['_objectParent'];
	waitUntil {(!isNull (findDisplay 602))};
	_display = findDisplay 602;
	private _QS_ctrlCreateArray = ['RscPicture',12345];
	private _myPicture = _display ctrlCreate _QS_ctrlCreateArray;
	_myPicture ctrlSetPosition [
		(((ctrlPosition ((findDisplay 602) displayCtrl 6191)) # 0) + ((ctrlPosition ((findDisplay 602) displayCtrl 6191)) # 2)),
		((ctrlPosition ((findDisplay 602) displayCtrl 6191)) # 1)
	];
	_myPicture ctrlShow TRUE;
	_myPicture ctrlSetScale 0.175;
	_myPicture ctrlCommit 0;
	_QS_ctrlCreateArray = ['RscButtonArsenal',12346];
	private _QS_buttonCtrl = _display ctrlCreate _QS_ctrlCreateArray;
	_QS_buttonCtrl ctrlSetPosition (ctrlPosition _myPicture);
	_QS_buttonCtrl ctrlSetText ([
		'\a3\Modules_f\data\iconunlock_ca.paa',
		'\a3\Modules_f\data\iconlock_ca.paa'
	] select (player getVariable ['QS_lockedInventory',FALSE]));
	_QS_buttonAction = "['BUTTON',player] call QS_fnc_lockBackpack";
	_QS_buttonCtrl buttonSetAction _QS_buttonAction;
	_QS_buttonCtrl ctrlShow TRUE;
	_QS_buttonCtrl ctrlSetScale 0.175;
	_QS_buttonCtrl ctrlSetTooltip (localize 'STR_QS_Menu_196');
	_QS_buttonCtrl ctrlCommit 0;
	ctrlDelete _myPicture;
	private _isOthersBackpack = FALSE;
	private _objectParent = objNull;
	if (_isBackpack isEqualTo 1) then {
		_objectParent = objectParent _inventory;
		if (
			(alive _objectParent) &&
			{(isPlayer _objectParent)}
		) then {
			_isOthersBackpack = TRUE;
		};
	};
	(_display displayCtrl 111) ctrlSetText (['GET_ROLE_DISPLAYNAME',(player getVariable ['QS_unit_role','rifleman'])] call (missionNamespace getVariable ['QS_fnc_roles',{'rifleman'}]));
	(_display displayCtrl 6308) ctrlSetTooltip (format ['Load: %1 lbs',(round ((loadAbs player) * 0.1))]);
	(_display displayCtrl 12346) ctrlSetTooltip (localize 'STR_QS_Menu_196');
	while {(!isNull (findDisplay 602))} do {
		if (
			(_isOthersBackpack) && 
			{(_objectParent getVariable ['QS_lockedInventory',FALSE])}
		) exitWith {
			waitUntil {
				closeDialog 0;
				(isNull (findDisplay 602))
			};
			50 cutText [(format ['%1 %2',(name _objectParent),localize 'STR_QS_Text_020']),'PLAIN',0.5];
		};
		_QS_buttonCtrl ctrlSetText ([
			'\a3\Modules_f\data\iconunlock_ca.paa',
			'\a3\Modules_f\data\iconlock_ca.paa'
		] select (player getVariable ['QS_lockedInventory',FALSE]));
		if (diag_tickTime > (uiNamespace getVariable ['QS_backpack_lockTime',-1])) then {
			if ((backpack player) isEqualTo '') then {
				if (ctrlEnabled _QS_buttonCtrl) then {
					_QS_buttonCtrl ctrlShow FALSE;
					_QS_buttonCtrl ctrlEnable FALSE;
				};
			} else {
				if (!(ctrlEnabled _QS_buttonCtrl)) then {
					_QS_buttonCtrl ctrlShow TRUE;
					_QS_buttonCtrl ctrlEnable TRUE;
				};
			};
		} else {
			if (ctrlEnabled _QS_buttonCtrl) then {
				_QS_buttonCtrl ctrlEnable FALSE;
			};
		};
		uiSleep 0.01;
	};
};