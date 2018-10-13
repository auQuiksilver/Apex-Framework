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
if (worldName isEqualTo 'Altis') then {
	if (_aoName isEqualTo 'oreokastro') then {
		/*/ Scaffolding to get ontop of castle/*/
	};
	if (_aoName isEqualTo 'research facility') then {
		/*/ Minefield on the approach hill sometimes/*/
	};
	if (_aoName isEqualTo 'zaros power station') then {
		/*/ Minefield on the approach hill sometimes/*/
	};
	IF (_aoName isEqualTo 'limni') then {
	
	};
};
if (worldName isEqualTo 'Tanoa') then {

};
if (worldName isEqualTo 'Malden') then {

};
_return;