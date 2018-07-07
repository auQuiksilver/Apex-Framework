/*/
File: fn_ahScanString.sqf
Author:
	
	Quiksilver
	
Last Modified:

	2/06/2018 A3 1.82 by Quiksilver
	
Description:

	-
	
Notes:

	'#shutdown',"35,115,104,117,116,100,111,119,110",
	'#restart',"35,114,101,115,116,97,114,116",
	'#reassign',"35,114,101,97,115,115,105,103,110",
	'#login',"35,108,111,103,105,110",
	'#exec',"35,101,120,101,99",
	';',"59",
______________________________________________________/*/
params ['_string','','_fn_inString'];
private _return = FALSE;
private _restrictedStrings = [
	'{true}',"123,116,114,117,101,125",
	'],[',"93,44,91",
	'spawn {',"115,112,97,119,110,32,123",
	'spawn "',"115,112,97,119,110,32,34",
	"spawn '","115,112,97,119,110,32,39",
	'call {',"99,97,108,108,32,123",
	'call "',"99,97,108,108,32,34",
	"call '","99,97,108,108,32,39",
	'_fnc_',"95,102,110,99,95",
	'{',"123",
	'}',"125",
	' = ',"32,61,32",
	'==',"61,61",
	'compile',"99,111,109,112,105,108,101",
	'toarray',"116,111,97,114,114,97,121",
	'tostring',"116,111,115,116,114,105,110,103",
	'" + "',"34,32,43,32,34",
	"' + '","39,32,43,32,39",
	'(true)','40,116,114,117,101,41'
];
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