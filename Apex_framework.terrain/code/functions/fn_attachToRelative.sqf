/*/
File: fn_attachToRelative.sqf
Author:
	
	Quiksilver (Alias of BIS_fnc_attachToRelative by Killzone_Kid)
	
Last Modified:

	13/10/2023 A3 2.14 by Quiksilver
	
Description:

	-
______________________________________________________/*/

params ['_obj1','_obj2',['_visual', true]];
_orient = _this call (missionNamespace getVariable 'BIS_fnc_vectorDirAndUpRelative');
[1,_obj1,[_obj2]] call QS_fnc_eventAttach;
_obj1 setVectorDirAndUp _orient;