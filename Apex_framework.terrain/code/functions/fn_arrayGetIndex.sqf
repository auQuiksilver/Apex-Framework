/*/
File: fn_arrayGetIndex.sqf
Author:

	Quiksilver
	
Last Modified:

	18/03/2018 A3 1.82 by Quiksilver
	
Description:

	Pull element index from nested array
________________________________________________________________/*/

params ['_a','_v','_i'];
(_a findIf {((_x select _i) isEqualTo _v)});
