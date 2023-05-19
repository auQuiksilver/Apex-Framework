/*/
File: fn_createUGVTrailer.sqf
Author:
	
	Quiksilver
	
Last Modified:

	15/05/2023 A3 2.12 by Quiksilver
	
Description:

	-
______________________________________________________/*/
params ['_string','','_fn_inString'];
private _return = FALSE;
private _restrictedStrings = ['restricted_strings_1'] call QS_data_listOther;
private _stringCount = count _string;
{
	if ([_x,_string,FALSE] call _fn_inString) exitWith {
		if (!isNull (findDisplay 24)) then {
			((findDisplay 24) displayCtrl 101) ctrlSetText (_string select [0,(_stringCount - (count _x))]);
		};
		_return = TRUE;
	};					
} count _restrictedStrings;
_return;