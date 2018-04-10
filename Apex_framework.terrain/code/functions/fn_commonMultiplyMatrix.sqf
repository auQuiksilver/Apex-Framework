/*/
File: fn_commonMultiplyMatrix.sqf
Author:

	Quiksilver
	
Last modified:

	8/03/2018 A3 1.80 by Quiksilver
	
Description:

	QS_fnc_commonMultiplyMatrix
____________________________________________________/*/

params ['_array1','_array2'];
[(((_array1 select 0) select 0) * (_array2 select 0)) + (((_array1 select 0) select 1) * (_array2 select 1)),(((_array1 select 1) select 0) * (_array2 select 0)) + (((_array1 select 1) select 1) * (_array2 select 1))];