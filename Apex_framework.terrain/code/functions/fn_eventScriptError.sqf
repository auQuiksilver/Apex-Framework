/*/
File: fn_eventScriptError.sqf
Author:
	
	Quiksilver
	
Last Modified:

	16/10/2023 A3 2.14 by Quiksilver
	
Description:

	Script Error event
	
Notes:

	errorText: String - e.g. "Zero Divisor"
	sourceFile: String - empty string if spawned Code
	lineNumber: Number - script's line number
	errorPos: Number - script's error byte position in the script content
	content: String - the whole script's Code as String
	stackTraceOutput: Array - see diag_stacktrace output
______________________________________________________/*/

params ['_errorText','_sourceFile','_lineNumber','_errorPos','_content','_stackTraceOutput'];
localNamespace setVariable ['QS_allScriptErrors',(localNamespace getVariable ['QS_allScriptErrors',0]) + 1];
// Is error unique
_savedErrors = profileNamespace getVariable ['QS_savedScriptErrors',[]];
_errorData = str (toArray (trim (str [_errorText,_sourceFile,_lineNumber,_errorPos])));
// If error is unique, save it
if (!(_errorData in _savedErrors)) then {
	if ((count _savedErrors) >= 10) then {
		_savedErrors deleteAt 0;
	};
	localNamespace setVariable ['QS_uniqueScriptErrors',(localNamespace getVariable ['QS_uniqueScriptErrors',0]) + 1];
	_savedErrors pushBackUnique _errorData;
	profileNamespace setVariable ['QS_savedScriptErrors',_savedErrors];
	//saveProfileNamespace;
	diag_log '***** DEBUG ***** Error saved *****';
};