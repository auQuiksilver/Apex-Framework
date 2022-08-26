/*/
File: fn_turnTo.sqf
Author:

	Quiksilver
	
Last Modified:

	14/05/2022 A3 2.08 by Quiksilver
	
Description:

	Incremental rotation
______________________________________________/*/

params [
	['_object',objNull],
	['_dir1',0],
	['_dir2',180],
	['_increment',1]
];
_dir3 = [
	_dir1 - (( ( _dir2 - _dir1 ) * ( pi / 180 ) ) * _increment ),
	_dir1 + (( ( _dir2 - _dir1 ) * ( pi / 180 ) ) * _increment )
] select ((_dir2 - _dir1) >= -180);
if (!isNull _object) exitWith {
	_object setDir _dir3;
	_dir3;
};
_dir3;