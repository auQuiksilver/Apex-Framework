/*/
File: QS_data_speedLimitAreas.sqf
Author:

	Quiksilver
	
Last modified:

	28/10/2022 A3 2.10 by Quiksilver
	
Description:

	Speed-limited areas at base
	
Notes:

	- Positions which represent a polygon
	- Set 3rd value in each position to 1 (as seen below) like this: [ ... , ... , 1 ]
	- Positions must be in clockwise or counterclockwise order, they must not be mixed. The positions, connected consecutively, must form the polygon.
	- https://community.bistudio.com/wiki/inPolygon
	- If there are too many areas, or the areas are too complex with lots of corners, FPS may be affected.
	- All speed-limited areas must be inside the base safezone (no-fire zone).
__________________________________________________________________________/*/

// EDIT BELOW
if ((missionNamespace getVariable ['QS_missionConfig_baseLayout',0]) isNotEqualTo 0) exitWith {
	private _return = [ [[0,0,1],[1,0,1],[1,1,1],[0,1,1]] ];		// Default failsafe
	if (worldName isEqualTo 'Altis') then {
		// CUSTOM base layout, speed limited areas for ALTIS
		_return = [
			[ [14576.5,16637.2,1],[14623,16593.1,1],[14800.4,16765,1],[14859.1,16719.5,1],[14904.8,16756.4,1],[14786.7,16873,1],[14731.4,16813.3,1],[14742,16803.9,1] ]		// Speed limited area #1
		];
	};
	if (worldName isEqualTo 'Tanoa') then {
		// CUSTOM base layout, speed limited areas for TANOA
		_return = [
			[ [6955.91,7320.77,1],[6998.99,7330.48,1],[6974.06,7456.62,1],[6933.65,7449.47,1] ],							// Speed limited area #1
			[ [7039,7296.95,1],[7053.38,7220.18,1],[7088.85,7174.77,1],[7165.03,7175.23,1],[7128.51,7311.59,1] ],			// Speed limited area #2
			[ [7059.01,7523.01,1],[7073.57,7565.42,1],[6994.1,7600.87,1],[6971.92,7553.27,1] ]								// Speed limited area #3
		];
	};
	if (worldName isEqualTo 'Malden') then {
		// CUSTOM base layout, speed limited areas for MALDEN
		_return = [
			[ [8098.5,10237.6,1],[7987.92,10238.1,1],[7987.61,10022.9,1],[8097.11,10023.5,1] ],								// Speed limited area #1
			[ [8017.61,10385.9,1],[8012.09,10246.4,1],[8115.71,10244.8,1],[8118.9,10382.4,1] ]								// Speed limited area #2
		];
	};
	if (worldName isEqualTo 'Enoch') then {
		// Default base layout, speed limited areas for LIVONIA
		_return = [
			[[4070.12,10310.7,0],[3942.69,10181.2,0],[3976.86,10147.4,0],[4105.77,10273.6,0]],								// Speed limited area #1
			[[3810.13,10133.7,0],[3832.01,10091.3,0],[3926.57,10177.1,0],[3890.72,10213.8,0]]								// Speed limited area #2
		];
	};
	if (worldName isEqualTo 'Stratis') then {
		// Default base layout, speed limited areas for STRATIS
		_return = [
			[																																														// Speed limited area #1
				[1881.77,5730.51,0.00141811],[1926.75,5720.96,0.00142717],[1984.13,5953.76,0.00148726],[1873.29,6099.13,0.00167799],[1791.67,6120.36,0.00139737],
				[1460.3,4952.82,0.00140667],[1544.86,4918.45,0.00156641],[1730.94,5551.46,0.00143862],[1888.87,5513.81,0.00141668],[1929.52,5651.31,0.00130463],[1861.14,5668.23,0.00143862]
			]
		];
	};
	_return;
};
// EDIT ABOVE, below is for default base layout

























if (worldName isEqualTo 'Altis') exitWith {
	// Default base layout, speed limited areas for ALTIS
	[
		[[14576.5,16637.2,1],[14623,16593.1,1],[14800.4,16765,1],[14859.1,16719.5,1],[14904.8,16756.4,1],[14786.7,16873,1],[14731.4,16813.3,1],[14742,16803.9,1]]
	]
};
if (worldName isEqualTo 'Tanoa') exitWith {
	// Default base layout, speed limited areas for TANOA
	[
		[[6955.91,7320.77,1],[6998.99,7330.48,1],[6974.06,7456.62,1],[6933.65,7449.47,1]],
		[[7039,7296.95,1],[7053.38,7220.18,1],[7088.85,7174.77,1],[7165.03,7175.23,1],[7128.51,7311.59,1]],
		[[7059.01,7523.01,1],[7073.57,7565.42,1],[6994.1,7600.87,1],[6971.92,7553.27,1]]
	]
};
if (worldName isEqualTo 'Malden') exitWith {
	// Default base layout, speed limited areas for MALDEN
	[
		[[8098.5,10237.6,1],[7987.92,10238.1,1],[7987.61,10022.9,1],[8097.11,10023.5,1]],
		[[8017.61,10385.9,1],[8012.09,10246.4,1],[8115.71,10244.8,1],[8118.9,10382.4,1]]
	]
};
if (worldName isEqualTo 'Enoch') exitWith {
	// Default base layout, speed limited areas for LIVONIA
	[
		[[4070.12,10310.7,1],[3942.69,10181.2,1],[3976.86,10147.4,1],[4105.77,10273.6,1]],
		[[3810.13,10133.7,1],[3832.01,10091.3,1],[3926.57,10177.1,1],[3890.72,10213.8,1]]
	]
};
if (worldName isEqualTo 'Stratis') exitWith {
	// Default base layout, speed limited areas for LIVONIA
	[
		[																																														// Speed limited area #1
			[1881.77,5730.51,0.00141811],[1926.75,5720.96,0.00142717],[1984.13,5953.76,0.00148726],[1873.29,6099.13,0.00167799],[1791.67,6120.36,0.00139737],
			[1460.3,4952.82,0.00140667],[1544.86,4918.45,0.00156641],[1730.94,5551.46,0.00143862],[1888.87,5513.81,0.00141668],[1929.52,5651.31,0.00130463],[1861.14,5668.23,0.00143862]
		]
	]
};
[ [[0,0,1],[1,0,1],[1,1,1],[0,1,1]] ]		// Do not edit, this is just a failsafe area