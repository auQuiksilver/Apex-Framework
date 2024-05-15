/*/
File: QS_data_pfhWhitelist.sqf
Author:

	Quiksilver
	
Last modified:

	2/12/2023 A3 2.12 by Quiksilver
	
Description:

	Per Frame Handler function name whitelist
	
	For security, the PFH can only exec whitelisted mission namespace vars, and they need to be compileFinal too.
	
Note:

	Must be lowercase
________________________________________/*/

[
	'qs_fnc_serverspawnasset',
	'qs_fnc_initplayerserver'
]