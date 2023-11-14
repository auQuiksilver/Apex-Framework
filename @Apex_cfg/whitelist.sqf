/*/
File: whitelist.sqf
Author:

	Quiksilver
	
Last modified:

	28/04/2022 A3 2.08 by Quiksilver
	
Description:

	UIDs

Comment:
	
	This data can be replaced by extdb3 database system
	
	For staff IDs, ensure ID is in only one list. For instance, either moderator, admin or developer, but not all of them together.
	
	They DO all have to be in the 'ALL' list though.
__________________________________________________________________________/*/

_type = param [0,''];
private _return = [];
//================================================== WHITELISTED ROLES + SKINS ACCESS
if (_type isEqualTo 'S3') then {
	/*/ 
	These IDs will have access to Whitelisted roles in Role Selection, and access to vehicle skins, uniform skins and custom shoulder patches. 
	Does NOT include CAS role (a separate whitelist below). 
	/*/
	_return = [
		'76561100000000000',
		'76561100000000000'
	];
};
//================================================== CAS JET
if (_type isEqualTo 'CAS') then {
	/*/These IDs have access to fixed-wing Jets, subject to mission parameters/*/
	_return = [
		'76561100000000000',
		'76561100000000000'
	];
};
//================================================= COMMANDER
if (_type isEqualTo 'S1') then {
	/*/ These IDs have access to the Commander role, if Commander whitelisting is used. /*/
	_return = [
		'76561100000000000',
		'76561100000000000'
	];
};
//================================================= OPFOR
if (_type isEqualTo 'OPFOR') then {
	/*/ These IDs have access to the OPFOR slots, if OPFOR whitelisting is used. /*/
	_return = [
		'76561100000000000',
		'76561100000000000'
	];
};
//================================================== ALL STAFF IDS. IDs below must be registered here first/*/
if (_type isEqualTo 'ALL') then {
	/*/ All staff UIDs (does not grant permissions/menus, that stuff is below). Robocop reports trolling events and hacking events to these people though./*/
	_return = [
		'76561100000000000',
		'76561100000000000'
	];
};
//================================================== ADMIN IDs/*/
if (_type isEqualTo 'ADMIN') then {
	/*/ Admin UIDs. These IDs have access to all admin tools below Developer access. They do not have Debug Console.  - remove ID from MODERATOR IDs/*/
	_return = [
		'76561100000000000',
		'76561100000000000'
	];
};
//================================================== MODERATOR IDS/*/
if (_type isEqualTo 'MODERATOR') then {
	/*/ Moderator IDs - remove ID from ADMIN IDs/*/
	_return = [
		'76561100000000000',
		'76561100000000000'
	];
};
//================================================== TRUSTED NON-STAFF IDS/*/
if (_type isEqualTo 'TRUSTED') then {
	/*/ Trusted non-staff IDs. Potentially obsolete./*/
	_return = [
		'76561100000000000',
		'76561100000000000'
	];
};
//================================================== MEDIA IDS/*/
if (_type isEqualTo 'MEDIA') then {
	/*/ Media. These IDs will have access to a limited Splendid Camera (which is normally only availabe to Developers), but no other options. May be required to be in 'ALL' first./*/
	_return = [
		'76561100000000000',
		'76561100000000000'
	];
};
//================================================== ZEUS IDs/*/
if (_type isEqualTo 'CURATOR') then {
	/*/Zeus. These IDs have access to Zeus and mission curation functionality. They can suspend side missions and main missions, and cycle main missions (this is done on "air defense laptop" at base)./*/
	_return = [
		'76561100000000000',
		'76561100000000000'
	];
};
//================================================== DEVELOPER IDS/*/
if (_type isEqualTo 'DEVELOPER') then {
	/*/ Developer UIDs. These IDs have access to integrated Debug Console (execution is logged and filtered) and all other ingame tools./*/
	_return = [
		'76561100000000000',
		'76561100000000000'
	];
};
_return;