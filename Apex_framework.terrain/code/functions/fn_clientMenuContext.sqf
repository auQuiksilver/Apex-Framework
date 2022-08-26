/*
File: fn_clientMenuContext.sqf
Author:
	
	Quiksilver
	
Last Modified:

	28/04/2016 A3 1.58 by Quiksilver

Description:

	Client Context Menu
__________________________________________________________*/
disableSerialization;
_type = _this # 0;
if (_type isEqualTo 'onLoad') then {
	_display = _this # 1;

};
if (_type isEqualTo 'onUnload') then {

};