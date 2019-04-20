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
[(((_array1 # 0) # 0) * (_array2 # 0)) + (((_array1 # 0) # 1) * (_array2 # 1)),(((_array1 # 1) # 0) * (_array2 # 0)) + (((_array1 # 1) # 1) * (_array2 # 1))];