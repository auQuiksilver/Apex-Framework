/*/
File: QS_data_baseRestrictedArea.sqf
Author:

	Quiksilver
	
Last modified:

	27/01/2018 A3 1.80 by Quiksilver
	
Description:

	Area at base in which vehicles are not allowed (infantry spawn area)
	
Notes:

	- Must be a polygon ( https://community.bistudio.com/wiki/inPolygon )
	
if (worldName isEqualTo 'Altis') exitWith {
	[
		[14590,16753.9,0],
		[14628.8,16723.1,0],
		[14686.4,16783.1,0],
		[14661.9,16810.1,0],
		[14655.3,16808,0],
		[14649.2,16813.4,0]
	]
};
if (worldName isEqualTo 'Tanoa') exitWith {
	[
		[6918.41,7376.67,0],
		[6937.73,7381.24,0],
		[6927.28,7437.82,0],
		[6907.94,7434.23,0]
	]
};
if (worldName isEqualTo 'Malden') exitWith {
	[
		[8123.71,10132.7,0],
		[8103.02,10133.3,0],
		[8102.68,10099,0],
		[8121.91,10100.2,0]
	]
};
[[0,0,0],[1,0,0],[1,1,0],[0,1,0]]
__________________________________________________________________________/*/

if (worldName isEqualTo 'Altis') exitWith {
	[
		[14590,16753.9,0],
		[14628.8,16723.1,0],
		[14686.4,16783.1,0],
		[14661.9,16810.1,0],
		[14655.3,16808,0],
		[14649.2,16813.4,0]
	]
};
if (worldName isEqualTo 'Tanoa') exitWith {
	[
		[6918.41,7376.67,0],
		[6937.73,7381.24,0],
		[6927.28,7437.82,0],
		[6907.94,7434.23,0]
	]
};
if (worldName isEqualTo 'Malden') exitWith {
	[
		[8123.71,10132.7,0],
		[8103.02,10133.3,0],
		[8102.68,10099,0],
		[8121.91,10100.2,0]
	]
};
[[0,0,0],[1,0,0],[1,1,0],[0,1,0]]