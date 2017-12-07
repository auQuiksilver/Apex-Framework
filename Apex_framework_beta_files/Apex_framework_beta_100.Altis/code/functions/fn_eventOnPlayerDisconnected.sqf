/*
File: fn_eventOnPlayerDisconnected.sqf
Author:

	Quiksilver
	
Last modified:

	25/04/2016 A3 1.56 by Quiksilver
	
Description:

	On Player Disconnected
	
Number - unique DirectPlay ID (very large number). It is also the same id used for user placed markers (same as _id param)
String - getPlayerUID of the leaving client. The same as Steam ID (same as _uid param)
String - profileName of the leaving client (same as _name param)
Boolean - didJIP of the leaving client (same as _jip param)
Number - owner id of the leaving client (same as _owner param)
__________________________________________________*/

diag_log format ['***** onPlayerDisconnected ***** %1 *****',_this];