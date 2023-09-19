/*/
File: fn_commonMultiplyMatrix.sqf
Author:

	Quiksilver
	
Last modified:

	30/04/2019 A3 1.92 by Quiksilver
	
Description:

	QS_fnc_commonMultiplyMatrix
____________________________________________________/*/

params ['_array1','_array2'];
[
	(((_array1 # 0) # 0) * (_array2 # 0)) + (((_array1 # 0) # 1) * (_array2 # 1)),
	(((_array1 # 1) # 0) * (_array2 # 0)) + (((_array1 # 1) # 1) * (_array2 # 1))
];