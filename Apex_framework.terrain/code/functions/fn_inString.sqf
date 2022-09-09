/* 	
File: inString.sqf 	
Author: 
	
	Mika Hannola, optimised by Killzone_Kid 	 	
	
Description: 	

	Find a string within a string. 	 	
	
Parameter(s): 	
	
	_this # 0: <string> string to be found 	
	_this # 1: <string> string to search from 	
	_this # 2 (Optional): <boolean> search is case sensitive (default: false) 	 	
	
Returns: 	

	Boolean (true when string is found). 	 	
	
How to use: 	

	_found = ["string", "String", true] call QS_fnc_inString; 

*/  
params ['_find','_string',['_matchcase',FALSE]]; 
if (_matchcase) exitWith {((_string find _find) > -1)}; 
(((toLower _string) find (toLower _find)) > -1)