/*
File: fn_commonMultiplyMatrix.sqf
Author:

	Quiksilver
	
Last modified:

	16/12/2014 ArmA 1.36 by Quiksilver
	
Description:

	QS_fnc_commonMultiplyMatrix
__________________________________________________________________________*/

params ['_array1','_array2'];
_result = [
	(((_array1 select 0) select 0) * (_array2 select 0)) + (((_array1 select 0) select 1) * (_array2 select 1)),
	(((_array1 select 1) select 0) * (_array2 select 0)) + (((_array1 select 1) select 1) * (_array2 select 1))
];
_result;
