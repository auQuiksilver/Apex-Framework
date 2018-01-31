/*/
File: QS_data_speedLimitAreas.sqf
Author:

	Quiksilver
	
Last modified:

	27/01/2018 A3 1.80 by Quiksilver
	
Description:

	Speed-limited areas at base
	
Notes:

	- Positions which represent a polygon
	- Set 3rd value in each position to 1 (as seen below) like this: [ ... , ... , 1 ]
	- Positions must be in clockwise or counterclockwise order, they must not be mixed. The positions, connected consecutively, must form the polygon.
	- https://community.bistudio.com/wiki/inPolygon
__________________________________________________________________________/*/

if (worldName isEqualTo 'Altis') exitWith {
	[
		[[14576.5,16637.2,1],[14623,16593.1,1],[14800.4,16765,1],[14859.1,16719.5,1],[14904.8,16756.4,1],[14786.7,16873,1],[14731.4,16813.3,1],[14742,16803.9,1]]
	]
};
if (worldName isEqualTo 'Tanoa') exitWith {
	[
		[[6955.91,7320.77,1],[6998.99,7330.48,1],[6974.06,7456.62,1],[6933.65,7449.47,1]],
		[[7039,7296.95,1],[7053.38,7220.18,1],[7088.85,7174.77,1],[7165.03,7175.23,1],[7128.51,7311.59,1]],
		[[7059.01,7523.01,1],[7073.57,7565.42,1],[6994.1,7600.87,1],[6971.92,7553.27,1]]
	]
};
if (worldName isEqualTo 'Malden') exitWith {
	[
		[[8098.5,10237.6,1],[7987.92,10238.1,1],[7987.61,10022.9,1],[8097.11,10023.5,1]],
		[[8017.61,10385.9,1],[8012.09,10246.4,1],[8115.71,10244.8,1],[8118.9,10382.4,1]]
	]
};
[ [[0,0,1],[1,0,1],[1,1,1],[0,1,1]] ]