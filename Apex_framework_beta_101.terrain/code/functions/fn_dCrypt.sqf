/*
File: fn_dCrypt.sqf
Author:

	Quiksilver (Credit: NextGenBen)

Last Modified:

	14/02/2016 A3 1.54 by Quiksilver
	
Description:

	- 
_____________________________________________________________*/

_DcryptMe = _this select 0;
_key = _this select 1;
_counter = 0;
_Array = toArray(_key);
for '_i' from 0 to (count(_Dcryptme)-1) step 1 do {
	if(_counter > (count(_Array)-1)) then {
		_counter = 0;
	};
	_var = (_Dcryptme select _i) / (_Array select _counter);
	_Dcryptme set [_i,_var];
	_counter = _counter + 1;
};
toString(_Dcryptme);