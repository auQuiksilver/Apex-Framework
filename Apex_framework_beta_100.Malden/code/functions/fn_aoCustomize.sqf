/*
File: fn_aoCustomize.sqf
Author: 

	Quiksilver

Last Modified:

	15/03/2016 A3 1.56 by Quiksilver

Description:

	AO Customizations
____________________________________________________________________________*/

private ['_return'];
_aoName = toLower (_this select 0);
_return = [];
if (_aoName isEqualTo 'oreokastro') then {
	/*/ Scaffolding to get ontop of castle/*/
};
if (_aoName isEqualTo 'research facility') then {
	/*/ Minefield on the approach hill sometimes/*/
};
if (_aoName isEqualTo 'zaros power station') then {
	/*/ Minefield on the approach hill sometimes/*/
};
if (_aoName isEqualTo 'georgetown') then {
	_return = [] spawn (missionNamespace getVariable 'QS_fnc_missionGeorgetown');
	missionNamespace setVariable ['QS_customAO_script',_return,FALSE];
};
_return;