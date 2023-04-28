/*
File: fn_clientInteractGetIn.sqf
Author:

	Quiksilver
	
Last Modified:

	3/01/2023 A3 2.10
	
Description:

	Simple "Get In Cargo" user action
_______________________________________________*/

getCursorObjectParams params ['_cursorObject','_cursorSelections','_cursorDistance'];
private _testGetIn = (
	!isActionMenuVisible &&
	{(isNull (objectParent QS_player))} &&
	{(!(QS_player call QS_fnc_isBusyAttached))} &&
	{(alive _cursorObject)} &&
	{((locked _cursorObject) in [0,1])} &&
	{(_cursorDistance < 3)} &&
	{(!(_cursorObject getVariable ['QS_logistics_wreck',FALSE]))} &&
	{((((fullCrew [_cursorObject,'',TRUE]) select {((!alive (_x # 0)) && (!(_cursorObject lockedCargo (_x # 2))) &&(((_x # 1) in ['cargo']) || (((_x # 1) in ['turret']) && (_x # 4))))}) apply {(_x # 2)}) isNotEqualTo [])}
);
if (_testGetIn) then {
	_onCompleted = {
		getCursorObjectParams params ['_cursorObject','_cursorSelections','_cursorDistance'];
		if (
			!isActionMenuVisible &&
			{(isNull (objectParent QS_player))} &&
			{(!(QS_player call QS_fnc_isBusyAttached))} &&
			{(alive _cursorObject)} &&
			{((locked _cursorObject) in [0,1])} &&
			{(_cursorDistance < 3)} &&
			{((((fullCrew [_cursorObject,'',TRUE]) select {((!alive (_x # 0)) && (!(_cursorObject lockedCargo (_x # 2))) &&(((_x # 1) in ['cargo']) || (((_x # 1) in ['turret']) && (_x # 4))))}) apply {(_x # 2)}) isNotEqualTo [])}
		) then {
			private _emptyCargoSeats = ((fullCrew [_cursorObject,'',TRUE]) select {((!alive (_x # 0)) && (!(_cursorObject lockedCargo (_x # 2))) &&(((_x # 1) in ['cargo']) || (((_x # 1) in ['turret']) && (_x # 4))))}) apply {(_x # 2)};
			if (_emptyCargoSeats isNotEqualTo []) then {
				_cargoSeat = selectRandom _emptyCargoSeats;
				QS_player moveInCargo [_cursorObject,_cargoSeat,FALSE];
			};
		};
	};
	_conditionCancel = {
		getCursorObjectParams params ['_cursorObject','_cursorSelections','_cursorDistance'];
		(
			isActionMenuVisible ||
			{(!(uiNamespace getVariable ['QS_ui_getincargo_activate',TRUE]))} ||
			{(!isNull (objectParent QS_player))} ||
			{(QS_player call QS_fnc_isBusyAttached)} ||
			{(!alive _cursorObject)} ||
			{(!((locked _cursorObject) in [0,1]))} ||
			{(_cursorDistance > 3)} ||
			{(_cursorObject getVariable ['QS_logistics_wreck',FALSE])} ||
			{((((fullCrew [_cursorObject,'',TRUE]) select {((!alive (_x # 0)) && (!(_cursorObject lockedCargo (_x # 2))) &&(((_x # 1) in ['cargo']) || (((_x # 1) in ['turret']) && (_x # 4))))}) apply {(_x # 2)}) isEqualTo [])}
		)
	};
	[localize 'STR_QS_Interact_120',1.5,0,[[],{FALSE}],[[],_conditionCancel],[[],_onCompleted],[[],{FALSE}],FALSE,1,["\a3\ui_f\data\igui\cfg\actions\getincargo_ca.paa"]] spawn QS_fnc_clientProgressVisualization;
};
_testGetIn;