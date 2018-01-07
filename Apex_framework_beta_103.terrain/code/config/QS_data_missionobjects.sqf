/*/
File: QS_data_missionobjects.sqf
Author:

	Quiksilver
	
Last modified:

	5/12/2016 A3 1.66 by Quiksilver
	
Description:

	Default Base Layouts
	
[	
	<object type> ,
	<object model> , 
	<object world position > , 
	[ <vector direction> , <vector up> ] , 
	<damage allowed> , 			// 0 = disabled, 1 = enabled
	<simulation state> , 		// 0 = disabled, 1 = enabled
	<simple object state> , 	// 0 = not simple, 1 = simple, 2 = super simple
	<arguments> , 
	<init code> 
]

How to build list (in 3DEN Editor):
	---------------------
	
	private _array = [];
	{
		_array pushBack [(typeOf _x),((getModelInfo _x) select 1),(getPosWorld _x),[(vectorDir _x),(vectorUp _x)],0,0,2,[],{}];
	} forEach (all3DENEntities select 0);
	copyToClipboard str _array;
	
	-------------------
	Set sim-required entities (flags, houses with animated doors, helipads (for AI)) simple object state to 0, and simulated state to 1.
	For objects with screens, set simple object state to 1 or 0 (not 2)
	Objects with addaction need to be simpleobject state 0
__________________________________________________________________________/*/

_worldName = worldName;
if (_worldName isEqualTo 'Altis') exitWith {
	[
		["Land_HelipadSquare_F","a3\structures_f\mil\helipads\helipadsquare_f.p3d",[14661.9,16660.5,17.91],[[-0.707779,0.706434,0],[0,0,1]],0,0,0,[],{}],
		["Land_HelipadSquare_F","a3\structures_f\mil\helipads\helipadsquare_f.p3d",[14696.8,16696.2,17.91],[[-0.707779,0.706434,0],[0,0,1]],0,0,0,[],{}],
		["Land_HelipadSquare_F","a3\structures_f\mil\helipads\helipadsquare_f.p3d",[14731.6,16731.6,17.91],[[-0.707779,0.706434,0],[0,0,1]],0,0,0,[],{}],
		["Land_HelipadRescue_F","a3\structures_f\mil\helipads\helipadrescue_f.p3d",[14718.6,16778.6,17.91],[[0.709714,-0.70449,0],[0,0,1]],0,0,0,[],{}],
		["Land_HelipadCircle_F","a3\structures_f\mil\helipads\helipadcircle_f.p3d",[14780.7,16848.5,17.91],[[0.00283542,-0.999996,0],[0,0,1]],0,0,0,[],{}],
		["Land_HelipadCircle_F","a3\structures_f\mil\helipads\helipadcircle_f.p3d",[14811.9,16818.4,17.91],[[0.00283542,-0.999996,0],[0,0,1]],0,0,0,[],{}],
		["Land_HelipadCircle_F","a3\structures_f\mil\helipads\helipadcircle_f.p3d",[14841.2,16790.6,17.91],[[0.00283542,-0.999996,0],[0,0,1]],0,0,0,[],{}],
		["Land_HelipadCircle_F","a3\structures_f\mil\helipads\helipadcircle_f.p3d",[14760.3,16827.3,17.91],[[0.00283542,-0.999996,0],[0,0,1]],0,0,0,[],{}],
		["Land_HelipadCircle_F","a3\structures_f\mil\helipads\helipadcircle_f.p3d",[14791.4,16795.6,17.91],[[0.00283542,-0.999996,0],[0,0,1]],0,0,0,[],{}],
		["Land_HelipadCircle_F","a3\structures_f\mil\helipads\helipadcircle_f.p3d",[14868.5,16763.7,17.91],[[0.00283542,-0.999996,0],[0,0,1]],0,0,0,[],{}],
		["Land_HelipadCircle_F","a3\structures_f\mil\helipads\helipadcircle_f.p3d",[14606.9,16631.4,17.91],[[0.708311,-0.7059,0],[0,0,1]],0,0,0,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14623.5,16717.1,18.2957],[[0.0703582,-0.997522,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14626,16718.7,18.2957],[[-0.712714,0.701455,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14627.8,16720.6,18.2957],[[-0.712714,0.701455,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14629.6,16722.4,18.2957],[[-0.712714,0.701455,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14631.4,16724.3,18.2957],[[-0.712714,0.701455,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14633.2,16726.1,18.2957],[[-0.712714,0.701455,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14635,16728,18.2957],[[-0.712714,0.701455,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14636.8,16729.8,18.2957],[[-0.712714,0.701455,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14638.6,16731.7,18.2957],[[-0.712714,0.701455,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14645.9,16739.1,18.2957],[[-0.712714,0.701455,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14647.7,16740.9,18.2957],[[-0.712714,0.701455,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14649.5,16742.8,18.2957],[[-0.712714,0.701455,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14651.3,16744.6,18.2957],[[-0.712714,0.701455,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14653.2,16746.5,18.2957],[[-0.712714,0.701455,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14655,16748.3,18.2957],[[-0.712714,0.701455,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14656.8,16750.2,18.2957],[[-0.712714,0.701455,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14658.6,16752.1,18.2957],[[-0.712714,0.701455,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14660.4,16753.9,18.2957],[[-0.712714,0.701455,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14662.2,16755.8,18.2957],[[-0.712714,0.701455,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14664,16757.6,18.2957],[[-0.712714,0.701455,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14665.8,16759.4,18.2957],[[-0.712714,0.701455,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14682.1,16776.1,18.2957],[[0.740967,-0.671541,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14680.4,16774.3,18.2957],[[0.712562,-0.701609,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14678.6,16772.4,18.2957],[[0.712562,-0.701609,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14676.7,16770.6,18.2957],[[0.712562,-0.701609,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14674.9,16768.7,18.2957],[[0.712562,-0.701609,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14673.1,16766.9,18.2957],[[0.712562,-0.701609,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14673.5,16798.7,18.2957],[[0.731457,0.681887,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14675.2,16796.8,18.2957],[[0.731457,0.681887,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14678.8,16793,18.2957],[[0.731457,0.681887,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14680.6,16791.1,18.2957],[[0.731457,0.681887,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14684.1,16787.3,18.2957],[[0.731457,0.681887,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14685.9,16785.4,18.2957],[[0.731457,0.681887,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14687.6,16783.5,18.2957],[[0.731457,0.681887,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14671.7,16800.6,18.2957],[[0.731457,0.681887,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14658.3,16809.8,18.2957],[[-0.280234,0.959932,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14660.8,16810.6,18.2957],[[-0.33743,0.941351,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14662.9,16810,18.2957],[[0.731457,0.681887,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14664.7,16808.1,18.2957],[[0.731457,0.681887,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14666.4,16806.2,18.2957],[[0.731457,0.681887,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14668.2,16804.3,18.2957],[[0.731457,0.681887,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14607.6,16735.3,18.2957],[[-0.670305,-0.742086,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14621.4,16717.9,18.2957],[[-0.670305,-0.742086,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14619.4,16719.7,18.2957],[[-0.708639,-0.705571,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14618.6,16722,18.2957],[[-0.997663,-0.0683328,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14617.4,16724.2,18.2957],[[-0.670305,-0.742086,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14625.6,16718.1,18.2957],[[0.729758,-0.683705,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14613.4,16730.1,18.2957],[[-0.670305,-0.742086,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14611.4,16731.8,18.2957],[[-0.670305,-0.742086,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14609.5,16733.6,18.2957],[[-0.670305,-0.742086,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14599.9,16742.2,18.2957],[[-0.670305,-0.742086,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14597.9,16744,18.2957],[[-0.670305,-0.742086,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14596,16745.7,18.2957],[[-0.670305,-0.742086,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14605.7,16737.1,18.2957],[[-0.670305,-0.742086,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14647.8,16813.5,18.2957],[[-0.687587,0.726102,0.00111871],[-0.000845728,-0.00234157,0.999997]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14653.7,16810.6,18.2957],[[0.700623,0.713532,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14651.9,16812.5,18.2957],[[0.707645,0.706568,0],[0,0,1]],0,0,2,[],{}],
		["Land_MedicalTent_01_white_generic_open_F","a3\structures_f_orange\humanitarian\camps\medicaltent_01_f.p3d",[14673.1,16791.1,19.2846],[[0.726607,0.687053,0],[0,0,1]],0,0,1,[],{
			(_this select 0) setObjectTextureGlobal [0,"a3\structures_f_orange\humanitarian\Camps\Data\MedicalTent_01_MTP_F_CO.paa"];
		}],
		["Land_MedicalTent_01_white_generic_open_F","a3\structures_f_orange\humanitarian\camps\medicaltent_01_f.p3d",[14666.1,16798.6,19.2846],[[0.717054,0.697017,0],[0,0,1]],0,0,1,[],{
			(_this select 0) setObjectTextureGlobal [0,"a3\structures_f_orange\humanitarian\Camps\Data\MedicalTent_01_MTP_F_CO.paa"];
		}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14687.5,16781.7,18.2957],[[0.740967,-0.671541,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14685.8,16779.8,18.2957],[[0.712562,-0.701609,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14684,16777.9,18.2957],[[0.682081,-0.731276,0],[0,0,1]],0,0,2,[],{}],
		["Land_Bollard_01_F","a3\structures_f_exp\signs\traffic\bollard_01_f.p3d",[14676.9,16794.7,18.4303],[[0,1,0],[0,0,1]],0,0,2,[],{}],
		["Land_HBarrier_Big_F","a3\structures_f\mil\fortification\hbarrier_big_f.p3d",[14684.3,16785.1,19.12],[[0.753696,0.657223,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14682.3,16789.2,18.2957],[[0.731457,0.681887,0],[0,0,1]],0,0,2,[],{}],
		["Land_HBarrier_Big_F","a3\structures_f\mil\fortification\hbarrier_big_f.p3d",[14682.8,16778.8,19.12],[[-0.68217,0.731193,0],[0,0,1]],0,0,2,[],{}],
		["Land_HBarrier_1_F","a3\structures_f\mil\fortification\hbarrier_1_f.p3d",[14679.6,16775.2,18.6121],[[-0.730257,0.683172,0],[0,0,1]],0,0,2,[],{}],
		["Land_HBarrier_1_F","a3\structures_f\mil\fortification\hbarrier_1_f.p3d",[14681.1,16788.7,18.6121],[[-0.751071,-0.660221,0],[0,0,1]],0,0,2,[],{}],
		["Land_Bollard_01_F","a3\structures_f_exp\signs\traffic\bollard_01_f.p3d",[14670,16802.5,18.4303],[[0,1,0],[0,0,1]],0,0,2,[],{}],
		["Land_HBarrier_Big_F","a3\structures_f\mil\fortification\hbarrier_big_f.p3d",[14652.2,16747.4,19.12],[[0.692101,-0.721801,0],[0,0,1]],0,0,2,[],{}],
		["Land_HBarrier_Big_F","a3\structures_f\mil\fortification\hbarrier_big_f.p3d",[14615.9,16772.2,19.12],[[0.692101,-0.721801,0],[0,0,1]],0,0,2,[],{}],
		["Land_HBarrier_Big_F","a3\structures_f\mil\fortification\hbarrier_big_f.p3d",[14609.6,16773.6,19.12],[[0.714772,0.699357,0],[0,0,1]],0,0,2,[],{}],
		["Land_HBarrier_Big_F","a3\structures_f\mil\fortification\hbarrier_big_f.p3d",[14621.5,16786,19.12],[[-0.703419,-0.710775,0],[0,0,1]],0,0,2,[],{}],
		["Land_HBarrier_Big_F","a3\structures_f\mil\fortification\hbarrier_big_f.p3d",[14623.3,16780.1,19.12],[[0.692101,-0.721801,0],[0,0,1]],0,0,2,[],{}],
		["Land_Airport_Tower_F","a3\structures_f\ind\airport\airport_tower_f.p3d",[14621.4,16724.4,28.5746],[[-0.723482,0.690343,0],[0,0,1]],0,1,0,[],{
			(_this select 0) animateSource ['door_1_source',1];
			(_this select 0) animateSource ['door_2_source',1];
		}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14626.8,16724.2,18.2957],[[0.71279,0.701377,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14625.5,16725.5,18.2957],[[0.71279,0.701377,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14623.3,16726.4,18.2957],[[0.0313653,0.999508,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14619.3,16729,18.2957],[[0.71279,0.701377,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14617.2,16730.4,18.2957],[[0.308075,0.951362,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14615.2,16730,18.2957],[[-0.688391,0.725339,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14614.5,16728,18.2957],[[-0.997588,-0.0694112,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14615.4,16726,18.2957],[[-0.679252,-0.733905,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14594.1,16747.4,18.2957],[[-0.670305,-0.742086,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14592.1,16749.2,18.2957],[[-0.670305,-0.742086,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14590.3,16751,18.2957],[[-0.73825,-0.674527,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14588.6,16752.9,18.2957],[[-0.796162,-0.605083,0],[0,0,1]],0,0,2,[],{}],
		["Land_Bollard_01_F","a3\structures_f_exp\signs\traffic\bollard_01_f.p3d",[14671.6,16765.4,18.4303],[[0,1,0],[0,0,1]],0,0,2,[],{}],
		["Land_Bollard_01_F","a3\structures_f_exp\signs\traffic\bollard_01_f.p3d",[14670.8,16764.6,18.4303],[[0,1,0],[0,0,1]],0,0,2,[],{}],
		["Land_Bollard_01_F","a3\structures_f_exp\signs\traffic\bollard_01_f.p3d",[14670.1,16763.9,18.4303],[[0,1,0],[0,0,1]],0,0,2,[],{}],
		["Land_Bollard_01_F","a3\structures_f_exp\signs\traffic\bollard_01_f.p3d",[14669.4,16763.2,18.4303],[[0,1,0],[0,0,1]],0,0,2,[],{}],
		["Land_Bollard_01_F","a3\structures_f_exp\signs\traffic\bollard_01_f.p3d",[14668.7,16762.5,18.4303],[[0,1,0],[0,0,1]],0,0,2,[],{}],
		["Land_Bollard_01_F","a3\structures_f_exp\signs\traffic\bollard_01_f.p3d",[14667.9,16761.7,18.4303],[[0,1,0],[0,0,1]],0,0,2,[],{}],
		["Land_Bollard_01_F","a3\structures_f_exp\signs\traffic\bollard_01_f.p3d",[14667.2,16760.9,18.4303],[[0,1,0],[0,0,1]],0,0,2,[],{}],
		["Land_Bollard_01_F","a3\structures_f_exp\signs\traffic\bollard_01_f.p3d",[14644.4,16737.6,18.4303],[[0,1,0],[0,0,1]],0,0,2,[],{}],
		["Land_Bollard_01_F","a3\structures_f_exp\signs\traffic\bollard_01_f.p3d",[14643.6,16736.8,18.4303],[[0,1,0],[0,0,1]],0,0,2,[],{}],
		["Land_Bollard_01_F","a3\structures_f_exp\signs\traffic\bollard_01_f.p3d",[14642.9,16736.1,18.4303],[[0,1,0],[0,0,1]],0,0,2,[],{}],
		["Land_Bollard_01_F","a3\structures_f_exp\signs\traffic\bollard_01_f.p3d",[14642.2,16735.4,18.4303],[[0,1,0],[0,0,1]],0,0,2,[],{}],
		["Land_Bollard_01_F","a3\structures_f_exp\signs\traffic\bollard_01_f.p3d",[14641.5,16734.7,18.4303],[[0,1,0],[0,0,1]],0,0,2,[],{}],
		["Land_Bollard_01_F","a3\structures_f_exp\signs\traffic\bollard_01_f.p3d",[14640.7,16733.9,18.4303],[[0,1,0],[0,0,1]],0,0,2,[],{}],
		["Land_Bollard_01_F","a3\structures_f_exp\signs\traffic\bollard_01_f.p3d",[14640,16733.1,18.4303],[[0,1,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14627.7,16722,18.2957],[[0.999596,0.0284246,0],[0,0,1]],0,0,2,[],{}],
		["Land_MedicalTent_01_floor_light_F","a3\structures_f_orange\humanitarian\camps\medicaltent_01_floor_light_f.p3d",[14673.1,16791.1,17.91],[[-0.723269,-0.690566,0],[0,0,1]],0,0,2,[],{}],
		["Land_MedicalTent_01_floor_light_F","a3\structures_f_orange\humanitarian\camps\medicaltent_01_floor_light_f.p3d",[14666.2,16798.8,17.91],[[0.717305,0.696759,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14649.8,16813.9,18.2957],[[0.470897,0.882184,0.00246395],[-0.000845728,-0.00234157,0.999997]],0,0,2,[],{}],
		["Land_Bollard_01_F","a3\structures_f_exp\signs\traffic\bollard_01_f.p3d",[14604,16738.7,18.4303],[[0.99807,0.062107,0],[0,0,1]],0,0,2,[],{}],
		["Land_Bollard_01_F","a3\structures_f_exp\signs\traffic\bollard_01_f.p3d",[14603.2,16739.4,18.4303],[[0.99807,0.062107,0],[0,0,1]],0,0,2,[],{}],
		["Land_Bollard_01_F","a3\structures_f_exp\signs\traffic\bollard_01_f.p3d",[14602.5,16740,18.4303],[[0.99807,0.062107,0],[0,0,1]],0,0,2,[],{}],
		["Land_Bollard_01_F","a3\structures_f_exp\signs\traffic\bollard_01_f.p3d",[14601.6,16740.7,18.4303],[[0.99807,0.062107,0],[0,0,1]],0,0,2,[],{}],
		["Land_Bollard_01_F","a3\structures_f_exp\signs\traffic\bollard_01_f.p3d",[14655.4,16809.2,18.4303],[[0.99807,0.062107,0],[0,0,1]],0,0,2,[],{}],
		["Land_Bollard_01_F","a3\structures_f_exp\signs\traffic\bollard_01_f.p3d",[14656.4,16809.1,18.4303],[[0.99807,0.062107,0],[0,0,1]],0,0,2,[],{}],
		["Land_Bollard_01_F","a3\structures_f_exp\signs\traffic\bollard_01_f.p3d",[14606.6,16816.9,18.5553],[[0.99807,0.062107,0],[0,0,1]],0,0,2,[],{}],
		["Land_Bollard_01_F","a3\structures_f_exp\signs\traffic\bollard_01_f.p3d",[14605.8,16816.1,18.5553],[[0.99807,0.062107,0],[0,0,1]],0,0,2,[],{}],
		["Land_Bollard_01_F","a3\structures_f_exp\signs\traffic\bollard_01_f.p3d",[14578.9,16789.4,18.5553],[[0.99807,0.062107,0],[0,0,1]],0,0,2,[],{}],
		["Land_Bollard_01_F","a3\structures_f_exp\signs\traffic\bollard_01_f.p3d",[14579.6,16790.2,18.5553],[[0.99807,0.062107,0],[0,0,1]],0,0,2,[],{}],
		["Land_Bollard_01_F","a3\structures_f_exp\signs\traffic\bollard_01_f.p3d",[14586.7,16752.8,18.5553],[[0.99807,0.062107,0],[0,0,1]],0,0,2,[],{}],
		["Land_Bollard_01_F","a3\structures_f_exp\signs\traffic\bollard_01_f.p3d",[14601.9,16767.3,18.5553],[[0.99807,0.062107,0],[0,0,1]],0,0,2,[],{}],
		["Land_Bollard_01_F","a3\structures_f_exp\signs\traffic\bollard_01_f.p3d",[14628.9,16793.9,18.5553],[[0.99807,0.062107,0],[0,0,1]],0,0,2,[],{}],
		["Land_cargo_addon02_V2_F","a3\structures_f\households\slum\cargo_addon02_v2_f.p3d",[14681.6,16782.1,19.5542],[[-0.707762,0.706451,0],[0,0,1]],0,0,2,[],{}],
		["Land_Stretcher_01_F","a3\props_f_orange\humanitarian\camps\stretcher_01_f.p3d",[14664.8,16800.7,18.1516],[[-0.704327,0.709876,0],[0,0,1]],0,0,2,[],{}],
		["Land_Stretcher_01_F","a3\props_f_orange\humanitarian\camps\stretcher_01_f.p3d",[14666.2,16802.2,18.1516],[[-0.704327,0.709876,0],[0,0,1]],0,0,2,[],{}],
		["Land_Stretcher_01_F","a3\props_f_orange\humanitarian\camps\stretcher_01_f.p3d",[14669.8,16798.9,18.1516],[[-0.704327,0.709876,0],[0,0,1]],0,0,2,[],{}],
		["Land_Stretcher_01_F","a3\props_f_orange\humanitarian\camps\stretcher_01_f.p3d",[14668,16797.1,18.1516],[[-0.704327,0.709876,0],[0,0,1]],0,0,2,[],{}],
		["Land_Stretcher_01_F","a3\props_f_orange\humanitarian\camps\stretcher_01_f.p3d",[14666.2,16795.3,18.1516],[[-0.704327,0.709876,0],[0,0,1]],0,0,2,[],{}],
		["Land_CampingChair_V2_white_F","a3\structures_f\civ\camping\campingchair_v2_f.p3d",[14663,16798.2,18.4165],[[0.996849,-0.0793248,0],[0,0,1]],0,0,2,[],{}],
		["Land_CampingTable_white_F","a3\structures_f\civ\camping\campingtable_f.p3d",[14661.4,16797.4,18.3216],[[0.721524,0.692389,0],[0,0,1]],0,0,2,[],{}],
		["Land_CampingTable_white_F","a3\structures_f\civ\camping\campingtable_f.p3d",[14662,16798.8,18.3216],[[0.708478,-0.705732,0],[0,0,1]],0,0,2,[],{}],
		["Land_IntravenStand_01_2bags_F","a3\props_f_orange\humanitarian\camps\intravenstand_01_f.p3d",[14665.2,16801.8,18.8414],[[-0.75306,-0.657952,0],[0,0,1]],0,0,2,[],{}],
		["Land_IntravenStand_01_2bags_F","a3\props_f_orange\humanitarian\camps\intravenstand_01_f.p3d",[14669.2,16797.7,18.8414],[[0.754821,0.655931,0],[0,0,1]],0,0,2,[],{}],
		["Land_IntravenStand_01_1bag_F","a3\props_f_orange\humanitarian\camps\intravenstand_01_f.p3d",[14667.3,16795.8,18.8414],[[0.786231,0.617932,0],[0,0,1]],0,0,2,[],{}],
		["Land_FirstAidKit_01_closed_F","a3\props_f_orange\humanitarian\camps\firstaidkit_01_closed_f.p3d",[14665.6,16799.9,18.0888],[[-0.683339,0.730102,0],[0,0,1]],0,0,2,[],{}],
		["Land_FirstAidKit_01_open_F","a3\props_f_orange\humanitarian\camps\firstaidkit_01_open_f.p3d",[14661.8,16797,18.7817],[[0.723768,-0.690044,0],[0,0,1]],0,0,2,[],{}],
		["Land_CampingTable_F","a3\structures_f\civ\camping\campingtable_f.p3d",[14668.6,16789.9,18.3216],[[0.722564,0.691304,0],[0,0,1]],0,0,2,[],{}],
		["Land_CampingTable_F","a3\structures_f\civ\camping\campingtable_f.p3d",[14669.1,16791.2,18.3216],[[0.702617,-0.711568,0],[0,0,1]],0,0,2,[],{}],
		["Land_OfficeChair_01_F","a3\structures_f_heli\furniture\officechair_01_f.p3d",[14669.8,16790.6,18.5844],[[0.989311,0.145823,0],[0,0,1]],0,0,2,[],{}],
		["Land_Portable_generator_F","a3\structures_f\items\electronics\portable_generator_f.p3d",[14670.1,16792.3,18.2692],[[-0.735493,-0.677533,0],[0,0,1]],0,0,2,[],{}],
		["Land_PCSet_01_keyboard_F","a3\structures_f_heli\items\electronics\pcset_01_keyboard_f.p3d",[14668.9,16790.7,18.7327],[[-0.889695,0.456555,0],[0,0,1]],0,0,2,[],{}],
		["Land_PCSet_01_mousepad_IDAP_F","a3\props_f_orange\items\electronics\pcset_01_mousepad_f.p3d",[14669.2,16791,18.7344],[[-0.724702,0.689062,0],[0,0,1]],0,0,2,[],{}],
		["Land_PCSet_01_mouse_F","a3\structures_f_heli\items\electronics\pcset_01_mouse_f.p3d",[14669.3,16791,18.7625],[[-0.944923,0.327292,0],[0,0,1]],0,0,2,[],{}],
		["Land_PCSet_01_case_F","a3\structures_f_heli\items\electronics\pcset_01_case_f.p3d",[14669.3,16791.3,18.167],[[-0.696907,0.717162,0],[0,0,1]],0,0,2,[],{}],
		["Land_PCSet_01_case_F","a3\structures_f_heli\items\electronics\pcset_01_case_f.p3d",[14669.5,16791.5,18.167],[[-0.696907,0.717162,0],[0,0,1]],0,0,2,[],{}],
		["Land_FlatTV_01_F","a3\structures_f_heli\items\electronics\flattv_01_f.p3d",[14669.1,16791.4,19.034],[[-0.694708,0.719292,0],[0,0,1]],0,0,2,[],{}],
		["Land_PCSet_01_screen_F","a3\structures_f_heli\items\electronics\pcset_01_screen_f.p3d",[14668.5,16790.8,18.9805],[[-0.955244,0.295818,0],[0,0,1]],0,0,2,[],{}],
		["Land_PCSet_01_screen_F","a3\structures_f_heli\items\electronics\pcset_01_screen_f.p3d",[14668.4,16790.2,18.978],[[-0.999889,-0.0149235,0],[0,0,1]],0,0,2,[],{}],
		["Land_Laptop_unfolded_F","a3\structures_f\items\electronics\laptop_unfolded_f.p3d",[14668.8,16789.6,18.8661],[[0.808736,0.588172,0],[0,0,1]],0,0,0,[],{
		
		}],
		["Land_TripodScreen_01_large_F","a3\props_f_exp\military\camps\tripodscreen_01_large_f.p3d",[14677.3,16791.8,18.9532],[[-0.998595,0.0529823,0],[0,0,1]],0,0,0,[],{
			(_this select 0) setObjectTextureGlobal [0,(selectRandom (missionNamespace getVariable ['QS_missionConfig_textures_billboard2',[]]))];
		}],
		["MapBoard_altis_F","a3\structures_f\civ\infoboards\mapboard_f.p3d",[14674,16794.6,18.8789],[[0.370583,0.928799,0],[0,0,1]],0,0,1,[],{}],
		["Land_CampingTable_F","a3\structures_f\civ\camping\campingtable_f.p3d",[14673.1,16791.1,18.3216],[[0.702617,-0.711568,0],[0,0,1]],0,0,2,[],{}],
		["Land_InfoStand_V1_F","a3\structures_f\civ\infoboards\infostand_v1_f.p3d",[14672.9,16767,18.4854],[[0.740234,-0.672349,0],[0,0,1]],0,0,0,[],{
			(_this select 0) setObjectTextureGlobal [0,(selectRandom (missionNamespace getVariable ['QS_missionConfig_textures_infostand1',[]]))];
		}],
		["Land_InfoStand_V2_F","a3\structures_f\civ\infoboards\infostand_v2_f.p3d",[14665.9,16760,18.4903],[[0.63422,-0.773153,0],[0,0,1]],0,0,0,[],{
			(_this select 0) setObjectTextureGlobal [0,(selectRandom (missionNamespace getVariable ['QS_missionConfig_textures_infostand2',[]]))];
		}],
		["Land_InfoStand_V2_F","a3\structures_f\civ\infoboards\infostand_v2_f.p3d",[14645.3,16738.8,18.4903],[[0.829437,-0.5586,0],[0,0,1]],0,0,0,[],{
			(_this select 0) setObjectTextureGlobal [0,(selectRandom (missionNamespace getVariable ['QS_missionConfig_textures_infostand2',[]]))];
		}],
		["Land_InfoStand_V1_F","a3\structures_f\civ\infoboards\infostand_v1_f.p3d",[14638.8,16732.3,18.4854],[[0.662886,-0.74872,0],[0,0,1]],0,0,0,[],{
			(_this select 0) setObjectTextureGlobal [0,(selectRandom (missionNamespace getVariable ['QS_missionConfig_textures_infostand1',[]]))];
		}],
		["Land_Map_altis_F","a3\structures_f_epb\items\documents\map_altis_f.p3d",[14672.8,16790.9,18.7349],[[0,1,0],[0,0,1]],0,0,2,[],{}],
		["Land_HBarrier_5_F","a3\structures_f\mil\fortification\hbarrier_5_f.p3d",[14654.5,16752.1,18.6505],[[0.692402,0.721512,0],[0,0,1]],0,0,2,[],{}],
		["Land_HBarrier_5_F","a3\structures_f\mil\fortification\hbarrier_5_f.p3d",[14647.5,16745.1,18.6505],[[0.692402,0.721512,0],[0,0,1]],0,0,2,[],{}],
		["Land_HBarrier_5_F","a3\structures_f\mil\fortification\hbarrier_5_f.p3d",[14658.4,16753.3,18.6505],[[-0.716593,0.697491,0],[0,0,1]],0,0,2,[],{}],
		["Land_HBarrier_3_F","a3\structures_f\mil\fortification\hbarrier_3_f.p3d",[14647.2,16741.9,18.7083],[[0.680451,-0.732793,0],[0,0,1]],0,0,2,[],{}],
		["Land_CampingChair_V2_F","a3\structures_f\civ\camping\campingchair_v2_f.p3d",[14617.7,16728.4,30.6044],[[-0.993399,-0.114711,0],[0,0,1]],0,0,2,[],{}],
		["Land_CampingTable_F","a3\structures_f\civ\camping\campingtable_f.p3d",[14649.2,16750.7,18.3216],[[0.663516,0.748162,0],[0,0,1]],0,0,2,[],{}],
		["Land_CampingTable_F","a3\structures_f\civ\camping\campingtable_f.p3d",[14648.6,16750.1,18.3216],[[-0.660758,-0.750599,0],[0,0,1]],0,0,2,[],{}],
		["Land_CampingChair_V2_F","a3\structures_f\civ\camping\campingchair_v2_f.p3d",[14648.3,16748.7,18.4165],[[-0.15729,-0.987553,0],[0,0,1]],0,0,2,[],{}],
		["Land_CampingChair_V2_F","a3\structures_f\civ\camping\campingchair_v2_f.p3d",[14646.8,16750.3,18.4165],[[-0.999255,0.0385813,0],[0,0,1]],0,0,2,[],{}],
		["Land_CampingChair_V2_F","a3\structures_f\civ\camping\campingchair_v2_f.p3d",[14647.3,16751.3,18.4165],[[-0.674269,0.738486,0],[0,0,1]],0,0,2,[],{}],
		["Land_CampingChair_V2_F","a3\structures_f\civ\camping\campingchair_v2_f.p3d",[14648.3,16752.2,18.4165],[[-0.468502,0.883462,0],[0,0,1]],0,0,2,[],{}],
		["Land_CampingChair_V2_F","a3\structures_f\civ\camping\campingchair_v2_f.p3d",[14650.4,16751.1,18.4165],[[0.810148,0.586225,0],[0,0,1]],0,0,2,[],{}],
		["Land_CampingChair_V2_F","a3\structures_f\civ\camping\campingchair_v2_f.p3d",[14649.5,16751.9,18.4165],[[0.351571,0.936161,0],[0,0,1]],0,0,2,[],{}],
		["Land_PortableGenerator_01_F","a3\props_f_exp\military\camps\portablegenerator_01_f.p3d",[14677,16790.9,18.2857],[[0.997869,-0.0652504,0],[0,0,1]],0,0,2,[],{}],
		["Land_PortableGenerator_01_F","a3\props_f_exp\military\camps\portablegenerator_01_f.p3d",[14650.4,16747.8,18.2857],[[0.70488,-0.709327,0],[0,0,1]],0,0,2,[],{}],
		["Land_TripodScreen_01_large_F","a3\props_f_exp\military\camps\tripodscreen_01_large_f.p3d",[14651.3,16748.1,18.9532],[[-0.737712,0.675115,0],[0,0,1]],0,0,0,[],{
			missionNamespace setVariable ['QS_Billboard_02',(_this select 0),TRUE];
			(_this select 0) setObjectTextureGlobal [0,(selectRandom (missionNamespace getVariable ['QS_missionConfig_textures_billboard1',[]]))];
		}],
		["Land_Orange_01_F","a3\props_f_orange\humanitarian\supplies\orange_01_f.p3d",[14648.7,16750.8,18.7559],[[0,1,0],[0,0,1]],0,0,2,[],{}],
		["Land_Can_V3_F","a3\structures_f\items\food\can_v3_f.p3d",[14648.3,16750.3,18.7652],[[0,1,0],[0,0,1]],0,0,2,[],{}],
		["Land_Can_V3_F","a3\structures_f\items\food\can_v3_f.p3d",[14649.6,16750.6,18.7648],[[0,1,0],[0,0,1]],0,0,2,[],{}],
		["Land_Shed_06_F","a3\structures_f_exp\civilian\sheds\shed_06_f.p3d",[14753.1,16856.8,19.4398],[[0.683928,0.72955,0],[0,0,1]],0,0,2,[],{}],
		["Land_Shed_06_F","a3\structures_f_exp\civilian\sheds\shed_06_f.p3d",[14649.8,16748.7,20.0133],[[0.683928,0.72955,0],[0,0,1]],0,0,2,[],{}],
		["Land_HBarrier_5_F","a3\structures_f\mil\fortification\hbarrier_5_f.p3d",[14750.1,16852.5,18.7794],[[-0.680233,-0.73291,0.0111668],[0.0479446,-0.0292864,0.998421]],0,0,2,[],{}],
		["Land_HBarrier_5_F","a3\structures_f\mil\fortification\hbarrier_5_f.p3d",[14751.1,16861.4,18.9105],[[-0.666454,0.743362,0.0570319],[0.031983,-0.0479201,0.998339]],0,0,2,[],{}],
		["Land_HBarrier_5_F","a3\structures_f\mil\fortification\hbarrier_5_f.p3d",[14755.2,16862.4,18.8607],[[-0.68088,-0.732079,-0.0215063],[0.0199975,-0.0479364,0.99865]],0,0,2,[],{}],
		["Land_HBarrier_3_F","a3\structures_f\mil\fortification\hbarrier_3_f.p3d",[14758.3,16859.2,18.7443],[[0.717204,0.696716,-0.0143452],[0.0199975,0,0.9998]],0,0,2,[],{}],
		["Land_HBarrier_3_F","a3\structures_f\mil\fortification\hbarrier_3_f.p3d",[14747,16855.7,19.0755],[[-0.756446,-0.653832,0.0171461],[0.0479446,-0.0292864,0.998421]],0,0,2,[],{}],
		["Land_HBarrier_5_F","a3\structures_f\mil\fortification\hbarrier_5_f.p3d",[14754.2,16851.5,18.6582],[[0.721361,-0.692559,-0.000931693],[0.00129158,0,0.999999]],0,0,2,[],{}],
		["Land_HBarrier_3_F","a3\structures_f\mil\fortification\hbarrier_3_f.p3d",[14759.4,16856.9,18.7213],[[0.700524,-0.713491,-0.0140115],[0.0199975,0,0.9998]],0,0,2,[],{}],
		["Land_CanvasCover_01_F","a3\props_f_exp\military\camps\irmaskingcover_01_f.p3d",[14617.5,16743.6,19.7458],[[0.659236,0.751936,0],[0,0,1]],0,0,1,[],{}],
		["Land_GymBench_01_F","a3\structures_f_bootcamp\civ\sportsgrounds\gymbench_01_f.p3d",[14613.6,16745.9,18.4993],[[-0.757807,-0.652478,0],[0,0,1]],0,0,2,[],{}],
		["Land_GymRack_01_F","a3\structures_f_bootcamp\civ\sportsgrounds\gymrack_01_f.p3d",[14615.8,16743.1,19.0042],[[-0.76978,-0.63831,0],[0,0,1]],0,0,2,[],{}],
		["Land_GymRack_01_F","a3\structures_f_bootcamp\civ\sportsgrounds\gymrack_01_f.p3d",[14619,16739.9,19.0042],[[-0.76978,-0.63831,0],[0,0,1]],0,0,2,[],{}],
		["Land_GymRack_02_F","a3\structures_f_bootcamp\civ\sportsgrounds\gymrack_02_f.p3d",[14614.6,16749.8,18.5432],[[-0.165703,0.986176,0],[0,0,1]],0,0,2,[],{}],
		["Land_GymRack_03_F","a3\structures_f_bootcamp\civ\sportsgrounds\gymrack_03_f.p3d",[14623.8,16742,18.4927],[[0.683811,-0.729659,0],[0,0,1]],0,0,2,[],{}],
		["Land_New_WiredFence_10m_F","a3\structures_f\walls\new_wiredfence_10m_f.p3d",[14684.4,16815.5,19.1239],[[0.724385,-0.689396,0],[0,0,1]],0,0,2,[],{}],
		["Land_New_WiredFence_10m_F","a3\structures_f\walls\new_wiredfence_10m_f.p3d",[14690.7,16815.3,19.1239],[[-0.736687,-0.676234,0],[0,0,1]],0,0,2,[],{}],
		["Land_New_WiredFence_10m_F","a3\structures_f\walls\new_wiredfence_10m_f.p3d",[14693.9,16805.1,19.1239],[[-0.682694,0.730704,0],[0,0,1]],0,0,2,[],{}],
		["Land_New_WiredFence_5m_F","a3\structures_f\walls\new_wiredfence_5m_f.p3d",[14695.8,16809.8,19.0025],[[-0.737048,-0.67584,0],[0,0,1]],0,0,2,[],{}],
		["Land_New_WiredFence_10m_F","a3\structures_f\walls\new_wiredfence_10m_f.p3d",[14680.2,16804.8,19.1239],[[-0.736687,-0.676234,0],[0,0,1]],0,0,2,[],{}],
		["Land_New_WiredFence_5m_F","a3\structures_f\walls\new_wiredfence_5m_f.p3d",[14688.4,16800.1,19.0025],[[-0.684237,0.729259,0],[0,0,1]],0,0,2,[],{}],
		["Land_New_WiredFence_5m_F","a3\structures_f\walls\new_wiredfence_5m_f.p3d",[14678.6,16810.6,19.0025],[[-0.708189,0.706023,0],[0,0,1]],0,0,2,[],{}],
		["Land_New_WiredFence_10m_F","a3\structures_f\walls\new_wiredfence_10m_f.p3d",[14685.5,16803.9,19.1239],[[0.73264,0.680616,0],[0,0,1]],0,0,2,[],{}],
		["Land_fs_roof_F","a3\structures_f\ind\fuelstation_small\fs_roof_f.p3d",[14569.9,16819.2,20.3347],[[0.719359,-0.694638,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14570.3,16820.6,18.2957],[[-0.729865,0.683591,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14568.6,16818.7,18.2957],[[-0.729865,0.683591,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14567.2,16816.7,18.2957],[[-0.937195,0.348806,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14572.4,16821.9,18.2957],[[-0.294768,0.955569,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14562.5,16826.8,18.2957],[[-0.717064,0.697007,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14560.6,16825,18.2957],[[-0.707107,0.707107,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14564.3,16828.7,18.2957],[[-0.707107,0.707107,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14566.1,16830.5,18.2957],[[-0.707107,0.707107,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14574.5,16823.3,18.2957],[[-0.707107,0.707107,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14565.9,16814.6,18.2957],[[-0.707107,0.707107,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14558.8,16823.1,18.2957],[[-0.707107,0.707107,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14556.7,16822.2,18.2957],[[0.0252794,-0.99968,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14567,16832.6,18.2957],[[0.999706,-0.0242487,0],[0,0,1]],0,0,2,[],{}],
		
		["Land_HBarrier_Big_F","a3\structures_f\mil\fortification\hbarrier_big_f.p3d",[14858.7,16702.5,18.12],[[-0.699825,0.714314,0],[0,0,1]],0,0,2,[],{}],
		["Land_HBarrier_Big_F","a3\structures_f\mil\fortification\hbarrier_big_f.p3d",[14852.6,16700.8,18.12],[[-0.690038,-0.723773,0],[0,0,1]],0,0,2,[],{}],
		["Land_HBarrier_Big_F","a3\structures_f\mil\fortification\hbarrier_big_f.p3d",[14859.9,16708.7,18.12],[[-0.690038,-0.723773,0],[0,0,1]],0,0,2,[],{}],
		["Land_HBarrier_Big_F","a3\structures_f\mil\fortification\hbarrier_big_f.p3d",[14853.5,16714.5,18.12],[[-0.690038,-0.723773,0],[0,0,1]],0,0,2,[],{}],
		["Land_HBarrier_Big_F","a3\structures_f\mil\fortification\hbarrier_big_f.p3d",[14846.2,16706.6,18.12],[[-0.690038,-0.723773,0],[0,0,1]],0,0,2,[],{}],
		["Land_New_WiredFence_10m_F","a3\structures_f\walls\new_wiredfence_10m_f.p3d",[14846.8,16713.5,18.1239],[[-0.714942,0.699184,0],[0,0,1]],0,0,2,[],{}],
		
		["Land_HBarrier_Big_F","a3\structures_f\mil\fortification\hbarrier_big_f.p3d",[14735.2,16574,19.12],[[-0.699825,0.714314,0],[0,0,1]],0,0,2,[],{}],
		["Land_HBarrier_Big_F","a3\structures_f\mil\fortification\hbarrier_big_f.p3d",[14729.1,16572.2,19.12],[[-0.690038,-0.723773,0],[0,0,1]],0,0,2,[],{}],
		["Land_HBarrier_Big_F","a3\structures_f\mil\fortification\hbarrier_big_f.p3d",[14736.4,16580.1,19.12],[[-0.690038,-0.723773,0],[0,0,1]],0,0,2,[],{}],
		["Land_HBarrier_Big_F","a3\structures_f\mil\fortification\hbarrier_big_f.p3d",[14730,16585.9,19.12],[[-0.690038,-0.723773,0],[0,0,1]],0,0,2,[],{}],
		["Land_HBarrier_Big_F","a3\structures_f\mil\fortification\hbarrier_big_f.p3d",[14722.7,16578,19.12],[[-0.690038,-0.723773,0],[0,0,1]],0,0,2,[],{}],
		["Land_HBarrier_5_F","a3\structures_f\mil\fortification\hbarrier_5_f.p3d",[14720.7,16582.6,18.6505],[[-0.750821,0.660505,0],[0,0,1]],0,0,2,[],{}],
		["Land_WoodenShelter_01_F","a3\structures_f_exp\commercial\market\woodenshelter_01_f.p3d",[15161.9,16801.1,19.3776],[[-0.881125,-0.472883,0],[0,0,1]],0,0,2,[],{}],
		["Land_CampingTable_small_F","a3\structures_f\civ\camping\campingtable_small_f.p3d",[15161.6,16801,18.3149],[[0.90476,0.425921,0],[0,0,1]],0,0,2,[],{}],
		["Land_FirstAidKit_01_closed_F","a3\props_f_orange\humanitarian\camps\firstaidkit_01_closed_f.p3d",[15161.7,16801.1,18.9015],[[-0.892633,-0.450784,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_stripes_F","a3\structures_f\walls\cncbarrier_stripes_f.p3d",[15164.6,16805,18.2957],[[0.908037,0.41889,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_stripes_F","a3\structures_f\walls\cncbarrier_stripes_f.p3d",[15163.5,16807.4,18.2957],[[0.908037,0.41889,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_stripes_F","a3\structures_f\walls\cncbarrier_stripes_f.p3d",[15162.4,16809.7,18.2957],[[0.908037,0.41889,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_stripes_F","a3\structures_f\walls\cncbarrier_stripes_f.p3d",[15161.3,16812.1,18.2957],[[0.908037,0.41889,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_stripes_F","a3\structures_f\walls\cncbarrier_stripes_f.p3d",[15169,16795.5,18.2939],[[0.907856,0.418443,0.0265318],[-0.0199977,-0.0199935,0.9996]],0,0,2,[],{}],
		["Land_CncBarrier_stripes_F","a3\structures_f\walls\cncbarrier_stripes_f.p3d",[15167.8,16797.9,18.3057],[[0.908037,0.41889,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_stripes_F","a3\structures_f\walls\cncbarrier_stripes_f.p3d",[15166.7,16800.3,18.2957],[[0.908037,0.41889,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_stripes_F","a3\structures_f\walls\cncbarrier_stripes_f.p3d",[15165.7,16802.6,18.2957],[[0.908037,0.41889,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_stripes_F","a3\structures_f\walls\cncbarrier_stripes_f.p3d",[15190.8,16817.6,18.2957],[[0.908037,0.41889,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_stripes_F","a3\structures_f\walls\cncbarrier_stripes_f.p3d",[15189.7,16819.9,18.2957],[[0.908037,0.41889,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_stripes_F","a3\structures_f\walls\cncbarrier_stripes_f.p3d",[15188.6,16822.3,18.2957],[[0.908037,0.41889,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_stripes_F","a3\structures_f\walls\cncbarrier_stripes_f.p3d",[15187.5,16824.7,18.2957],[[0.908037,0.41889,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_stripes_F","a3\structures_f\walls\cncbarrier_stripes_f.p3d",[15195.2,16808.1,18.3043],[[0.908037,0.41889,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_stripes_F","a3\structures_f\walls\cncbarrier_stripes_f.p3d",[15194.1,16810.5,18.3057],[[0.908037,0.41889,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_stripes_F","a3\structures_f\walls\cncbarrier_stripes_f.p3d",[15193,16812.9,18.2957],[[0.908037,0.41889,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_stripes_F","a3\structures_f\walls\cncbarrier_stripes_f.p3d",[15191.9,16815.2,18.2957],[[0.908037,0.41889,0],[0,0,1]],0,0,2,[],{}],
		["Land_WoodenShelter_01_F","a3\structures_f_exp\commercial\market\woodenshelter_01_f.p3d",[14588.5,16610.4,19.3776],[[-0.676749,-0.736214,0],[0,0,1]],0,0,2,[],{}],
		["Land_CampingTable_small_F","a3\structures_f\civ\camping\campingtable_small_f.p3d",[14588.2,16610.2,18.3152],[[0.714506,0.69963,0],[0,0,1]],0,0,2,[],{}],
		["Land_FirstAidKit_01_closed_F","a3\props_f_orange\humanitarian\camps\firstaidkit_01_closed_f.p3d",[14588.3,16610.3,18.9018],[[-0.69488,-0.719125,0],[0,0,1]],0,0,2,[],{}],
		["Land_SCF_01_chimney_F","a3\structures_f_exp\industrial\sugarcanefactory_01\scf_01_chimney_f.p3d",[14533.1,16710.9,48.1427],[[0,1,0],[0,0,1]],0,0,2,[],{
			_chimney = _this select 0;
			missionNamespace setVariable [
				'QS_setFeatureType',
				((missionNamespace getVariable 'QS_setFeatureType') + [[_chimney,2]]),
				TRUE
			];
			_fire = createVehicle ['test_EmptyObjectForFireBig',[0,0,0],[],0,'CAN_COLLIDE'];
			_fire allowDamage FALSE;
			missionNamespace setVariable [
				'QS_setFeatureType',
				((missionNamespace getVariable 'QS_setFeatureType') + [[_fire,2]]),
				TRUE
			];			
			missionNamespace setVariable ['QS_torch',_fire,TRUE];
			_fire enableDynamicSimulation FALSE;
			_fire setVariable ['QS_dynSim_ignore',TRUE,TRUE];
			_fire attachTo [_chimney,[0,0,0]];
			_fire spawn {
				uiSleep 0.1;
				detach _this;
			};
		}],
		["Land_HBarrier_5_F","a3\structures_f\mil\fortification\hbarrier_5_f.p3d",[14648.7,16772.5,18.6505],[[-0.723556,-0.690266,0],[0,0,1]],0,0,2,[],{}],
		["Land_HBarrier_5_F","a3\structures_f\mil\fortification\hbarrier_5_f.p3d",[14644.8,16776.5,18.6505],[[-0.723556,-0.690266,0],[0,0,1]],0,0,2,[],{}],
		["Land_HBarrier_5_F","a3\structures_f\mil\fortification\hbarrier_5_f.p3d",[14628.7,16741.5,18.6505],[[-0.954959,-0.296738,0],[0,0,1]],0,0,2,[],{}],
		["Land_HBarrier_5_F","a3\structures_f\mil\fortification\hbarrier_5_f.p3d",[14626.1,16745.8,18.6505],[[-0.682252,-0.731117,0],[0,0,1]],0,0,2,[],{}],
		["B_supplyCrate_F","a3\weapons_f\ammoboxes\supplydrop.p3d",[14753.8,16853.1,18.8227],[[-0.728816,0.684572,0.0137526],[0.00133688,-0.0186626,0.999825]],0,0,2,[],{
			(_this select 0) setVariable ['QS_arsenal_object',TRUE,TRUE];
			missionNamespace setVariable ['QS_arsenals',((missionNamespace getVariable 'QS_arsenals') + [(_this select 0)]),TRUE];
		}],
		["B_supplyCrate_F","a3\weapons_f\ammoboxes\supplydrop.p3d",[14655.9,16754.3,18.8024],[[-0.728816,0.684709,0],[0,0,1]],0,0,2,[],{
			(_this select 0) setVariable ['QS_arsenal_object',TRUE,TRUE];
			missionNamespace setVariable ['QS_arsenals',((missionNamespace getVariable 'QS_arsenals') + [(_this select 0)]),TRUE];
		}],
		["B_supplyCrate_F","a3\weapons_f\ammoboxes\supplydrop.p3d",[14682.6,16783,18.8024],[[-0.731402,-0.681947,0],[0,0,1]],0,0,2,[],{
			(_this select 0) setVariable ['QS_arsenal_object',TRUE,TRUE];
			missionNamespace setVariable ['QS_arsenals',((missionNamespace getVariable 'QS_arsenals') + [(_this select 0)]),TRUE];
		}],
		["B_supplyCrate_F","a3\weapons_f\ammoboxes\supplydrop.p3d",[14646.6,16771.9,18.8024],[[-0.706662,-0.707551,0],[0,0,1]],0,0,2,[],{
			(_this select 0) setVariable ['QS_arsenal_object',TRUE,TRUE];
			missionNamespace setVariable ['QS_arsenals',((missionNamespace getVariable 'QS_arsenals') + [(_this select 0)]),TRUE];
		}],
		["Land_HBarrier_1_F","a3\structures_f\mil\fortification\hbarrier_1_f.p3d",[14648.3,16770.6,18.6121],[[-0.724264,-0.689523,0],[0,0,1]],0,0,2,[],{}],
		["B_supplyCrate_F","a3\weapons_f\ammoboxes\supplydrop.p3d",[14649.2,16741.5,18.8024],[[0.724389,-0.689391,0],[0,0,1]],0,0,2,[],{
			(_this select 0) setVariable ['QS_arsenal_object',TRUE,TRUE];
			missionNamespace setVariable ['QS_arsenals',((missionNamespace getVariable 'QS_arsenals') + [(_this select 0)]),TRUE];
		}],
		["Land_CampingChair_V2_F","a3\structures_f\civ\camping\campingchair_v2_f.p3d",[14657.7,16750.4,18.4165],[[-0.977136,0.212614,0],[0,0,1]],0,0,2,[],{}],
		["Land_CampingChair_V2_F","a3\structures_f\civ\camping\campingchair_v2_f.p3d",[14659.9,16752.5,18.4165],[[-0.539053,0.842272,0],[0,0,1]],0,0,2,[],{}],
		["Land_Airport_01_hangar_F","a3\structures_f_exp\infrastructure\airports\airport_01_hangar_f.p3d",[14453.3,16278.6,21.3457],[[0.527407,0.849613,0],[0,0,1]],0,1,0,[],{}],
		["Land_CampingTable_small_F","a3\structures_f\civ\camping\campingtable_small_f.p3d",[14459.5,16266.5,19.0665],[[0.639519,-0.768776,0],[0,0,1]],0,0,2,[],{
			if (!((missionNamespace getVariable ['QS_missionConfig_carrierEnabled',0]) isEqualTo 0)) then {
				(_this select 0) hideObjectGlobal TRUE;
			};
		}],
		["Land_HBarrier_1_F","a3\structures_f\mil\fortification\hbarrier_1_f.p3d",[14645.2,16778.4,18.6121],[[-0.724264,-0.689523,0],[0,0,1]],0,0,2,[],{}],
		["B_supplyCrate_F","a3\weapons_f\ammoboxes\supplydrop.p3d",[14646.6,16777,18.8024],[[-0.706662,-0.707551,0],[0,0,1]],0,0,2,[],{
			(_this select 0) setVariable ['QS_arsenal_object',TRUE,TRUE];
			missionNamespace setVariable ['QS_arsenals',((missionNamespace getVariable 'QS_arsenals') + [(_this select 0)]),TRUE];
		}],
		["Land_Laptop_unfolded_F","a3\structures_f\items\electronics\laptop_unfolded_f.p3d",[14459.4,16266.4,19.6304],[[0.76795,-0.64051,0],[0,0,1]],0,0,0,[],{
			missionNamespace setVariable ['QS_cas_laptop',(_this select 0),TRUE];
			if (!((missionNamespace getVariable ['QS_missionConfig_carrierEnabled',0]) isEqualTo 0)) then {
				(_this select 0) enableDynamicSimulation FALSE;
				(_this select 0) setVariable ['QS_dynSim_ignore',TRUE,TRUE];
				(_this select 0) hideObjectGlobal TRUE;
			};
		}],
		["Land_Laptop_unfolded_F","a3\structures_f\items\electronics\laptop_unfolded_f.p3d",[14626.6,16722,31.7596],[[-0.995978,0.0896037,0],[0,0,1]],0,0,0,[],{
			missionNamespace setVariable ['QS_airdefense_laptop',(_this select 0),TRUE];
		}],
		["B_supplyCrate_F","a3\weapons_f\ammoboxes\supplydrop.p3d",[14597.4,16813.8,18.9274],[[-0.723569,0.690252,0],[0,0,1]],0,0,2,[],{
			(_this select 0) setVariable ['QS_arsenal_object',TRUE,TRUE];
			missionNamespace setVariable ['QS_arsenals',((missionNamespace getVariable 'QS_arsenals') + [(_this select 0)]),TRUE];
		}],
		["FlagPole_F","a3\structures_f\mil\flags\mast_f.p3d",[14656,16752.6,21.8868],[[0,1,0],[0,0,1]],0,1,0,[],{
			(_this select 0) setFlagTexture (missionNamespace getVariable ['QS_missionConfig_textures_communityFlag','a3\data_f\flags\flag_nato_co.paa']);
		}],
		["FlagPole_F","a3\structures_f\mil\flags\mast_f.p3d",[14668.3,16788.5,21.8868],[[0.600961,-0.799278,0],[0,0,1]],0,1,0,[],{
			(_this select 0) setFlagTexture (missionNamespace getVariable ['QS_missionConfig_textures_communityFlag','a3\data_f\flags\flag_nato_co.paa']);
		}],
		["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[14605.7,16772.9,23.8922],[[-0.957925,-0.28702,0],[0,0,1]],0,1,0,[],{(missionNamespace getVariable 'QS_lamps') pushBack (_this select 0);}],
		["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[14606.5,16773.6,23.8922],[[-0.116459,-0.993195,0],[0,0,1]],0,1,0,[],{(missionNamespace getVariable 'QS_lamps') pushBack (_this select 0);}],
		["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[14622.4,16789.2,23.8922],[[-0.957925,-0.28702,0],[0,0,1]],0,1,0,[],{(missionNamespace getVariable 'QS_lamps') pushBack (_this select 0);}],
		["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[14623.2,16789.9,23.8922],[[-0.116459,-0.993195,0],[0,0,1]],0,1,0,[],{(missionNamespace getVariable 'QS_lamps') pushBack (_this select 0);}],
		["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[14645.8,16810.8,24.0172],[[-0.957925,-0.28702,0],[0,0,1]],0,1,0,[],{(missionNamespace getVariable 'QS_lamps') pushBack (_this select 0);}],
		["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[14646.6,16811.5,24.0172],[[-0.116459,-0.993195,0],[0,0,1]],0,1,0,[],{(missionNamespace getVariable 'QS_lamps') pushBack (_this select 0);}],
		["Land_Bollard_01_F","a3\structures_f_exp\signs\traffic\bollard_01_f.p3d",[14643.3,16809.2,18.5553],[[0.99807,0.062107,0],[0,0,1]],0,0,2,[],{}],
		["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[14687.3,16822.3,23.8922],[[-0.994364,-0.106021,0],[0,0,1]],0,1,0,[],{(missionNamespace getVariable 'QS_lamps') pushBack (_this select 0);}],
		["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[14584.4,16749.3,24.0172],[[-0.70548,-0.708729,0],[0,0,1]],0,1,0,[],{(missionNamespace getVariable 'QS_lamps') pushBack (_this select 0);}],
		["Land_LampShabby_F","a3\structures_f\civ\lamps\lampshabby_f.p3d",[14721,16581.4,21.682],[[0.996658,0.0816856,0],[0,0,1]],0,1,0,[],{(missionNamespace getVariable 'QS_lamps') pushBack (_this select 0);}],
		["Land_LampShabby_F","a3\structures_f\civ\lamps\lampshabby_f.p3d",[14842.8,16709,21.682],[[0.998598,-0.0529343,0],[0,0,1]],0,1,0,[],{(missionNamespace getVariable 'QS_lamps') pushBack (_this select 0);}],
		["Land_LampShabby_F","a3\structures_f\civ\lamps\lampshabby_f.p3d",[14753.6,16864.6,22.0313],[[-0.0197558,-0.999805,0],[0,0,1]],0,1,0,[],{(missionNamespace getVariable 'QS_lamps') pushBack (_this select 0);}],
		["Land_LampShabby_F","a3\structures_f\civ\lamps\lampshabby_f.p3d",[14586,16610.6,21.682],[[0.870029,0.493001,0],[0,0,1]],0,1,0,[],{(missionNamespace getVariable 'QS_lamps') pushBack (_this select 0);}],
		["Land_PortableLight_double_F","a3\structures_f_epa\civ\constructions\portablelight_double_f.p3d",[15161.3,16798.5,18.9631],[[-0.647474,-0.762088,0],[0,0,1]],0,1,0,[],{(missionNamespace getVariable 'QS_lamps') pushBack (_this select 0);}],
		["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[14559.3,16829.6,23.8922],[[-0.707107,-0.707107,0],[0,0,1]],0,1,0,[],{(missionNamespace getVariable 'QS_lamps') pushBack (_this select 0);}],
		["Land_HBarrier_3_F","a3\structures_f\mil\fortification\hbarrier_3_f.p3d",[14680.1,16785.8,18.7083],[[0.680451,-0.732793,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14517.5,16779.9,18.2466],[[0.704695,-0.70942,0.0113175],[-0.00666818,0.00932829,0.999934]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14515.7,16778.1,18.2514],[[0.704695,-0.70942,0.0113175],[-0.00666818,0.00932829,0.999934]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14513.8,16776.3,18.2462],[[0.704695,-0.709488,0.00564787],[-0.00666818,0.00133718,0.999977]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14521.4,16776,18.2877],[[0.70471,-0.709494,0.000916576],[0,0.00129187,0.999999]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14519.6,16774.2,18.2873],[[0.704695,-0.709488,0.00564787],[-0.00666818,0.00133718,0.999977]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14517.7,16772.3,18.2774],[[0.704695,-0.709488,0.00564787],[-0.00666818,0.00133718,0.999977]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14515.9,16772.2,18.2784],[[0.689214,0.724535,-0.00579172],[0,0.00799344,0.999968]],0,0,2,[],{}],
		//["Land_TripodScreen_01_dual_v1_F","a3\props_f_exp\military\camps\tripodscreen_01_dual_v1_f.p3d",[14678.8,16775,18.7197],[[-0.999341,0.0363084,0],[0,0,1]],0,0,0,[],{missionNamespace setVariable ['QS_panel_support',(_this select 0),TRUE];}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[14513.6,16774.4,18.2606],[[0.732266,0.680997,-0.00544369],[0,0.00799344,0.999968]],0,0,2,[],{}]
	]
};
if (_worldName isEqualTo 'Tanoa') exitWith {
	[
		["Land_MedicalTent_01_white_generic_open_F","a3\structures_f_orange\humanitarian\camps\medicaltent_01_f.p3d",[6907.74,7426.37,4.03456],[[0.978856,0.20455,0],[0,0,1]],0,0,1,[],{
			(_this select 0) setObjectTextureGlobal [0,"a3\structures_f_orange\humanitarian\Camps\Data\MedicalTent_01_Tropic_F_CO.paa"];
		}],
		["Land_HBarrier_01_line_5_green_F","a3\structures_f_exp\military\fortifications\hbarrier_01_line_5_green_f.p3d",[6919.89,7375.43,3.40051],[[0.193828,-0.981035,0],[0,0,1]],0,0,2,[],{}],
		["Land_HBarrier_01_line_5_green_F","a3\structures_f_exp\military\fortifications\hbarrier_01_line_5_green_f.p3d",[6925.42,7376.46,3.40051],[[0.193828,-0.981035,0],[0,0,1]],0,0,2,[],{}],
		["Land_HBarrier_01_line_5_green_F","a3\structures_f_exp\military\fortifications\hbarrier_01_line_5_green_f.p3d",[6939.32,7381.49,3.40051],[[0.981951,0.189138,0],[0,0,1]],0,0,2,[],{}],
		["Land_HBarrier_01_line_5_green_F","a3\structures_f_exp\military\fortifications\hbarrier_01_line_5_green_f.p3d",[6938.28,7387.11,3.40051],[[0.981951,0.189138,0],[0,0,1]],0,0,2,[],{}],
		["Land_HBarrier_01_line_5_green_F","a3\structures_f_exp\military\fortifications\hbarrier_01_line_5_green_f.p3d",[6937.25,7392.73,3.40051],[[0.981951,0.189138,0],[0,0,1]],0,0,2,[],{}],
		["Land_HBarrier_01_line_5_green_F","a3\structures_f_exp\military\fortifications\hbarrier_01_line_5_green_f.p3d",[6936.25,7398.3,3.40051],[[0.981951,0.189138,0],[0,0,1]],0,0,2,[],{}],
		["Land_HBarrier_01_line_5_green_F","a3\structures_f_exp\military\fortifications\hbarrier_01_line_5_green_f.p3d",[6933.2,7414.57,3.40051],[[0.981951,0.189138,0],[0,0,1]],0,0,2,[],{}],
		["Land_HBarrier_01_line_5_green_F","a3\structures_f_exp\military\fortifications\hbarrier_01_line_5_green_f.p3d",[6932.17,7420.23,3.40051],[[0.981951,0.189138,0],[0,0,1]],0,0,2,[],{}],
		["Land_HBarrier_01_line_5_green_F","a3\structures_f_exp\military\fortifications\hbarrier_01_line_5_green_f.p3d",[6931.11,7425.85,3.40051],[[0.981951,0.189138,0],[0,0,1]],0,0,2,[],{}],
		["Land_HBarrier_01_line_5_green_F","a3\structures_f_exp\military\fortifications\hbarrier_01_line_5_green_f.p3d",[6928.95,7437.04,3.40051],[[0.981951,0.189138,0],[0,0,1]],0,0,2,[],{}],
		["Land_HBarrier_01_line_5_green_F","a3\structures_f_exp\military\fortifications\hbarrier_01_line_5_green_f.p3d",[6908.62,7435.66,3.40051],[[-0.168635,0.985679,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[6929.55,7438.72,3.04567],[[0.982633,0.185562,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[6930.02,7436.19,3.04567],[[0.982633,0.185562,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[6932.99,7420.97,3.04567],[[0.97954,0.201249,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[6932.49,7423.51,3.04567],[[0.982633,0.185562,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[6932,7426.05,3.04567],[[0.982633,0.185562,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[6934.45,7413.37,3.04567],[[0.982633,0.185562,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[6933.96,7415.91,3.04567],[[0.982633,0.185562,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[6933.49,7418.44,3.04567],[[0.982633,0.185562,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[6938.72,7390.16,3.04567],[[0.97954,0.201249,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[6938.24,7392.73,3.04567],[[0.982633,0.185562,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[6937.76,7395.31,3.04567],[[0.982633,0.185562,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[6937.27,7397.88,3.04567],[[0.982633,0.185562,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[6940.64,7379.89,3.04567],[[0.97954,0.201249,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[6940.15,7382.46,3.04567],[[0.982633,0.185562,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[6939.68,7385.03,3.04567],[[0.982633,0.185562,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[6939.21,7387.6,3.04567],[[0.982633,0.185562,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[6906.94,7436.33,3.04567],[[-0.171511,0.985182,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[6920.13,7374.55,3.04567],[[0.20816,-0.978095,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[6922.65,7374.99,3.04567],[[0.167572,-0.98586,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[6925.21,7375.43,3.04567],[[0.167572,-0.98586,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[6909.5,7436.79,3.04567],[[-0.171511,0.985182,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[6912.04,7437.29,3.04567],[[-0.171511,0.985182,0],[0,0,1]],0,0,2,[],{}],
		["Land_HBarrier_01_line_5_green_F","a3\structures_f_exp\military\fortifications\hbarrier_01_line_5_green_f.p3d",[6936.1,7378.75,3.40051],[[0.193828,-0.981035,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[6936.6,7377.9,3.04567],[[0.167572,-0.98586,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[6939.18,7378.35,3.04567],[[0.167572,-0.98586,0],[0,0,1]],0,0,2,[],{}],
		["Land_HBarrier_01_line_5_green_F","a3\structures_f_exp\military\fortifications\hbarrier_01_line_5_green_f.p3d",[6925.04,7438.4,3.40051],[[-0.178529,0.983935,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[6928.12,7439.93,3.04567],[[-0.162053,0.986782,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[6925.55,7439.53,3.04567],[[-0.158566,0.987348,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[6936.77,7400.47,3.04567],[[0.982633,0.185562,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[6936.24,7403.96,3.04567],[[0.982633,0.185562,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[6935.42,7408.29,3.04567],[[0.982633,0.185562,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[6934.75,7411.82,3.04567],[[0.982633,0.185562,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[6927.74,7375.9,3.04567],[[0.203656,-0.979043,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[6934.06,7377.4,3.04567],[[0.218245,-0.975894,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[6922.98,7439.12,3.04567],[[-0.153284,0.988182,0],[0,0,1]],0,0,2,[],{}],
		["Land_GarbageBin_02_F","a3\structures_f_exp\civilian\accessories\garbagebin_02_f.p3d",[6934.36,7411.48,3.1603],[[0,1,0],[0,0,1]],0,0,2,[],{}],
		["Land_WoodenShelter_01_F","a3\structures_f_exp\commercial\market\woodenshelter_01_f.p3d",[6934.59,7394.59,3.77381],[[0.984823,0.17356,0],[0,0,1]],0,0,2,[],{}],
		["Land_HBarrier_01_line_5_green_F","a3\structures_f_exp\military\fortifications\hbarrier_01_line_5_green_f.p3d",[6917.95,7393.67,3.40051],[[-0.232236,0.972659,0],[0,0,1]],0,0,2,[],{}],
		["Land_HBarrier_01_line_5_green_F","a3\structures_f_exp\military\fortifications\hbarrier_01_line_5_green_f.p3d",[6932.8,7396.99,3.40051],[[-0.203881,0.978996,0],[0,0,1]],0,0,2,[],{}],
		["Land_MetalShelter_01_F","a3\structures_f_exp\commercial\market\metalshelter_01_f.p3d",[6912.78,7413.33,4.21936],[[0.185851,-0.982578,0],[0,0,1]],0,0,2,[],{}],
		["Land_MedicalTent_01_white_generic_open_F","a3\structures_f_orange\humanitarian\camps\medicaltent_01_f.p3d",[6924.12,7430.1,4.03456],[[0.973652,0.228041,0],[0,0,1]],0,0,1,[],{
			(_this select 0) setObjectTextureGlobal [0,"a3\structures_f_orange\humanitarian\Camps\Data\MedicalTent_01_Tropic_F_CO.paa"];
		}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[6920.69,7392.23,3.04567],[[0.982633,0.185562,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[6921.16,7389.68,3.04567],[[0.982633,0.185562,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[6921.63,7387.12,3.04567],[[0.982633,0.185562,0],[0,0,1]],0,0,2,[],{}],
		["Land_GymBench_01_F","a3\structures_f_bootcamp\civ\sportsgrounds\gymbench_01_f.p3d",[6916.89,7390.84,3.24931],[[-0.982181,-0.187939,0],[0,0,1]],0,0,2,[],{}],
		["Land_GymRack_01_F","a3\structures_f_bootcamp\civ\sportsgrounds\gymrack_01_f.p3d",[6917.56,7387.64,3.75418],[[-0.980372,-0.197157,0],[0,0,1]],0,0,2,[],{}],
		["Land_GymRack_01_F","a3\structures_f_bootcamp\civ\sportsgrounds\gymrack_01_f.p3d",[6918.09,7384.78,3.75418],[[-0.980372,-0.197157,0],[0,0,1]],0,0,2,[],{}],
		["Land_GymRack_03_F","a3\structures_f_bootcamp\civ\sportsgrounds\gymrack_03_f.p3d",[6919.47,7392.64,3.2427],[[-0.185298,0.982682,0],[0,0,1]],0,0,2,[],{}],
		["Land_HBarrier_01_line_5_green_F","a3\structures_f_exp\military\fortifications\hbarrier_01_line_5_green_f.p3d",[6927.63,7424.95,3.40051],[[-0.203881,0.978996,0],[0,0,1]],0,0,2,[],{}],
		["Land_HBarrier_01_line_5_green_F","a3\structures_f_exp\military\fortifications\hbarrier_01_line_5_green_f.p3d",[6912.5,7421.71,3.40051],[[-0.203881,0.978996,0],[0,0,1]],0,0,2,[],{}],
		["Land_WoodenShelter_01_F","a3\structures_f_exp\commercial\market\woodenshelter_01_f.p3d",[6929.6,7422.64,3.77381],[[0.984823,0.17356,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[6929.97,7420.62,3.04567],[[0.16924,-0.985575,0],[0,0,1]],0,0,2,[],{}],
		["Land_TripodScreen_01_large_F","a3\props_f_exp\military\camps\tripodscreen_01_large_f.p3d",[6930.62,7419.71,3.70317],[[-0.542938,-0.839773,0],[0,0,1]],0,0,0,[],{
			missionNamespace setVariable ['QS_Billboard_02',(_this select 0),TRUE];
			(_this select 0) setObjectTextureGlobal [0,(selectRandom (missionNamespace getVariable ['QS_missionConfig_textures_billboard1',[]]))];
		}],
		["Land_TripodScreen_01_large_F","a3\props_f_exp\military\camps\tripodscreen_01_large_f.p3d",[6934.51,7398.82,3.70317],[[-0.726247,0.687434,0],[0,0,1]],0,0,0,[],{
			(_this select 0) setObjectTextureGlobal [0,(selectRandom (missionNamespace getVariable ['QS_missionConfig_textures_billboard2',[]]))];
		}],
		["Land_PortableGenerator_01_F","a3\props_f_exp\military\camps\portablegenerator_01_f.p3d",[6933.84,7398.51,3.03567],[[0.223653,-0.974669,0],[0,0,1]],0,0,2,[],{}],
		["Land_PortableGenerator_01_F","a3\props_f_exp\military\camps\portablegenerator_01_f.p3d",[6929.64,7419.89,3.03567],[[0.224184,-0.974547,0],[0,0,1]],0,0,2,[],{}],
		["B_supplyCrate_F","a3\weapons_f\ammoboxes\supplydrop.p3d",[6929.61,7422.65,3.55242],[[-0.986106,-0.166116,0],[0,0,1]],0,0,2,[],{
			(_this select 0) setVariable ['QS_arsenal_object',TRUE,TRUE];
			missionNamespace setVariable ['QS_arsenals',((missionNamespace getVariable 'QS_arsenals') + [(_this select 0)]),TRUE];
		}],
		["B_supplyCrate_F","a3\weapons_f\ammoboxes\supplydrop.p3d",[6934.57,7394.57,3.55242],[[-0.986106,-0.166116,0],[0,0,1]],0,0,2,[],{
			(_this select 0) setVariable ['QS_arsenal_object',TRUE,TRUE];
			missionNamespace setVariable ['QS_arsenals',((missionNamespace getVariable 'QS_arsenals') + [(_this select 0)]),TRUE];
		}],
		["B_supplyCrate_F","a3\weapons_f\ammoboxes\supplydrop.p3d",[6913.85,7408.68,3.55242],[[-0.986106,-0.166116,0],[0,0,1]],0,0,2,[],{
			(_this select 0) setVariable ['QS_arsenal_object',TRUE,TRUE];
			missionNamespace setVariable ['QS_arsenals',((missionNamespace getVariable 'QS_arsenals') + [(_this select 0)]),TRUE];
		}],
		["B_supplyCrate_F","a3\weapons_f\ammoboxes\supplydrop.p3d",[6912.19,7417.88,3.55242],[[-0.986106,-0.166116,0],[0,0,1]],0,0,2,[],{
			(_this select 0) setVariable ['QS_arsenal_object',TRUE,TRUE];
			missionNamespace setVariable ['QS_arsenals',((missionNamespace getVariable 'QS_arsenals') + [(_this select 0)]),TRUE];
		}],
		["Land_SatelliteAntenna_01_F","a3\props_f_exp\military\camps\satelliteantenna_01_f.p3d",[6929.88,7421.61,5.91977],[[0.891908,-0.448109,-0.0608109],[0.0633986,-0.00923933,0.997945]],0,0,2,[],{}],
		["Land_TTowerSmall_2_F","a3\structures_f\ind\transmitter_tower\ttowersmall_2_f.p3d",[6912,7430.25,11.1387],[[0,1,0],[0,0,1]],0,0,2,[],{}],
		["FlagPole_F","a3\structures_f\mil\flags\mast_f.p3d",[6938.05,7380.21,6.6368],[[-0.321516,-0.946904,0],[0,0,1]],0,1,0,[],{
			(_this select 0) setFlagTexture (missionNamespace getVariable ['QS_missionConfig_textures_communityFlag','a3\data_f\flags\flag_nato_co.paa']);
		}],
		["FlagPole_F","a3\structures_f\mil\flags\mast_f.p3d",[6914.02,7422.88,6.6368],[[-0.321516,-0.946904,0],[0,0,1]],0,1,0,[],{
			(_this select 0) setFlagTexture (missionNamespace getVariable ['QS_missionConfig_textures_communityFlag','a3\data_f\flags\flag_nato_co.paa']);
		}],
		["Land_HelipadSquare_F","a3\structures_f\mil\helipads\helipadsquare_f.p3d",[6982.85,7346.93,2.66],[[-0.985542,-0.169429,0],[0,0,1]],0,0,0,[],{}],
		["Land_HelipadSquare_F","a3\structures_f\mil\helipads\helipadsquare_f.p3d",[6974.68,7393.39,2.66],[[-0.985542,-0.169429,0],[0,0,1]],0,0,0,[],{}],
		["Land_HelipadSquare_F","a3\structures_f\mil\helipads\helipadsquare_f.p3d",[6966.91,7438.04,2.66],[[-0.985542,-0.169429,0],[0,0,1]],0,0,0,[],{}],
		["Land_HelipadRescue_F","a3\structures_f\mil\helipads\helipadrescue_f.p3d",[6929.38,7474.43,2.66],[[-0.170124,0.985423,0],[0,0,1]],0,0,0,[],{}],
		["Land_PaperBox_closed_F","a3\structures_f_epa\mil\scrapyard\paperbox_closed_f.p3d",[6913.06,7411.86,3.3032],[[0.984418,0.175845,0],[0,0,1]],0,0,2,[],{}],
		["Land_PaperBox_closed_F","a3\structures_f_epa\mil\scrapyard\paperbox_closed_f.p3d",[6912.65,7413.64,3.3032],[[0.857539,-0.514418,0],[0,0,1]],0,0,2,[],{}],
		["Land_PaperBox_closed_F","a3\structures_f_epa\mil\scrapyard\paperbox_closed_f.p3d",[6915.78,7395.64,3.3032],[[-0.194283,0.980945,0],[0,0,1]],0,0,2,[],{}],
		["Land_PaperBox_open_full_F","a3\structures_f_epa\mil\scrapyard\paperbox_open_full_f.p3d",[6918.06,7395.46,3.268],[[0,1,0],[0,0,1]],0,0,2,[],{}],
		["Land_CampingChair_V2_F","a3\structures_f\civ\camping\campingchair_v2_f.p3d",[6927.79,7417.55,3.16649],[[-0.689456,0.724328,0],[0,0,1]],0,0,2,[],{}],
		["Land_CampingChair_V2_F","a3\structures_f\civ\camping\campingchair_v2_f.p3d",[6927.11,7415,3.16649],[[-0.976918,-0.213616,0],[0,0,1]],0,0,2,[],{}],
		["Land_CampingChair_V2_F","a3\structures_f\civ\camping\campingchair_v2_f.p3d",[6930.19,7416.59,3.16649],[[0.991021,0.133709,0],[0,0,1]],0,0,2,[],{}],
		["Land_CampingChair_V2_F","a3\structures_f\civ\camping\campingchair_v2_f.p3d",[6930.36,7415.26,3.16649],[[0.990036,-0.140816,0],[0,0,1]],0,0,2,[],{}],
		["Land_CampingChair_V2_F","a3\structures_f\civ\camping\campingchair_v2_f.p3d",[6929.36,7414.06,3.16649],[[0.181825,-0.983331,0],[0,0,1]],0,0,2,[],{}],
		["Land_CampingChair_V2_F","a3\structures_f\civ\camping\campingchair_v2_f.p3d",[6927.85,7413.87,3.16649],[[-0.284276,-0.958743,0],[0,0,1]],0,0,2,[],{}],
		["Land_CampingTable_F","a3\structures_f\civ\camping\campingtable_f.p3d",[6928.95,7415.95,3.07155],[[0.981791,0.189963,0],[0,0,1]],0,0,2,[],{}],
		["Land_CampingTable_F","a3\structures_f\civ\camping\campingtable_f.p3d",[6928.17,7415.79,3.07155],[[-0.981375,-0.192101,0],[0,0,1]],0,0,2,[],{}],
		["Land_CampingChair_V2_F","a3\structures_f\civ\camping\campingchair_v2_f.p3d",[6926.8,7416.39,3.16649],[[-0.98288,0.184247,0],[0,0,1]],0,0,2,[],{}],
		["Land_InfoStand_V2_F","a3\structures_f\civ\infoboards\infostand_v2_f.p3d",[6935.1,7408.24,3.24026],[[0.98315,0.1828,0],[0,0,1]],0,0,0,[],{
			(_this select 0) setObjectTextureGlobal [0,(selectRandom (missionNamespace getVariable ['QS_missionConfig_textures_infostand2',[]]))];
		}],
		["Land_InfoStand_V1_F","a3\structures_f\civ\infoboards\infostand_v1_f.p3d",[6935.9,7403.89,3.23536],[[0.977008,0.213202,0],[0,0,1]],0,0,0,[],{
			(_this select 0) setObjectTextureGlobal [0,(selectRandom (missionNamespace getVariable ['QS_missionConfig_textures_infostand1',[]]))];
		}],
		["Land_Bollard_01_F","a3\structures_f_exp\signs\traffic\bollard_01_f.p3d",[6929.44,7431.39,3.18026],[[0,1,0],[0,0,1]],0,0,2,[],{}],
		["Land_Bollard_01_F","a3\structures_f_exp\signs\traffic\bollard_01_f.p3d",[6897.15,7397.75,3.2895],[[0,1,0],[0,0,1]],0,0,2,[],{}],
		["Land_Bollard_01_F","a3\structures_f_exp\signs\traffic\bollard_01_f.p3d",[6897.35,7396.65,3.2895],[[0,1,0],[0,0,1]],0,0,2,[],{}],
		["Land_Bollard_01_F","a3\structures_f_exp\signs\traffic\bollard_01_f.p3d",[6897.56,7395.68,3.2895],[[0,1,0],[0,0,1]],0,0,2,[],{}],
		["Land_Bollard_01_F","a3\structures_f_exp\signs\traffic\bollard_01_f.p3d",[6929.94,7376.34,3.18026],[[0,1,0],[0,0,1]],0,0,2,[],{}],
		["Land_Bollard_01_F","a3\structures_f_exp\signs\traffic\bollard_01_f.p3d",[6930.94,7376.5,3.18026],[[0,1,0],[0,0,1]],0,0,2,[],{}],
		["Land_Bollard_01_F","a3\structures_f_exp\signs\traffic\bollard_01_f.p3d",[6931.96,7376.76,3.18026],[[0,1,0],[0,0,1]],0,0,2,[],{}],
		["Land_Bollard_01_F","a3\structures_f_exp\signs\traffic\bollard_01_f.p3d",[6914.44,7437.74,3.18026],[[0,1,0],[0,0,1]],0,0,2,[],{}],
		["Land_Bollard_01_F","a3\structures_f_exp\signs\traffic\bollard_01_f.p3d",[6915.59,7437.94,3.18026],[[0,1,0],[0,0,1]],0,0,2,[],{}],
		["Land_Bollard_01_F","a3\structures_f_exp\signs\traffic\bollard_01_f.p3d",[6916.72,7438.1,3.18026],[[0,1,0],[0,0,1]],0,0,2,[],{}],
		["Land_Bollard_01_F","a3\structures_f_exp\signs\traffic\bollard_01_f.p3d",[6917.88,7438.22,3.18026],[[0,1,0],[0,0,1]],0,0,2,[],{}],
		["Land_Bollard_01_F","a3\structures_f_exp\signs\traffic\bollard_01_f.p3d",[6918.97,7438.35,3.18026],[[0,1,0],[0,0,1]],0,0,2,[],{}],
		["Land_Bollard_01_F","a3\structures_f_exp\signs\traffic\bollard_01_f.p3d",[6920.09,7438.51,3.18026],[[0,1,0],[0,0,1]],0,0,2,[],{}],
		["Land_Bollard_01_F","a3\structures_f_exp\signs\traffic\bollard_01_f.p3d",[6921.19,7438.73,3.18026],[[0,1,0],[0,0,1]],0,0,2,[],{}],
		["Land_CampingChair_V2_F","a3\structures_f\civ\camping\campingchair_v2_f.p3d",[6937.45,7399.94,3.16649],[[-0.981127,0.193365,0],[0,0,1]],0,0,2,[],{}],
		["Land_CampingChair_V2_F","a3\structures_f\civ\camping\campingchair_v2_f.p3d",[6937.8,7397.96,3.16649],[[-0.847929,-0.530109,0],[0,0,1]],0,0,2,[],{}],
		["Land_MedicalTent_01_floor_light_F","a3\structures_f_orange\humanitarian\camps\medicaltent_01_floor_light_f.p3d",[6924.14,7430.1,2.66],[[0.974558,0.224135,0],[0,0,1]],0,0,2,[],{}],
		["Land_MedicalTent_01_floor_dark_F","a3\structures_f_orange\humanitarian\camps\medicaltent_01_floor_dark_f.p3d",[6907.79,7426.39,2.66],[[0.974833,0.222935,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[6898.82,7428.87,3.15567],[[0.982043,0.188658,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[6897.36,7430.95,3.04567],[[0.983693,0.179854,0],[0,0,1]],0,0,2,[],{}],
		["Land_Stretcher_01_F","a3\props_f_orange\humanitarian\camps\stretcher_01_f.p3d",[6927.21,7428.42,2.90162],[[-0.278337,0.960484,0],[0,0,1]],0,0,2,[],{}],
		["Land_Stretcher_01_F","a3\props_f_orange\humanitarian\camps\stretcher_01_f.p3d",[6924.82,7427.68,2.90162],[[-0.278337,0.960484,0],[0,0,1]],0,0,2,[],{}],
		["Land_Stretcher_01_F","a3\props_f_orange\humanitarian\camps\stretcher_01_f.p3d",[6922.39,7427.08,2.90162],[[-0.278337,0.960484,0],[0,0,1]],0,0,2,[],{}],
		["Land_Stretcher_01_F","a3\props_f_orange\humanitarian\camps\stretcher_01_f.p3d",[6923.59,7432.47,2.90162],[[0.252447,-0.967611,0],[0,0,1]],0,0,2,[],{}],
		["Land_Stretcher_01_F","a3\props_f_orange\humanitarian\camps\stretcher_01_f.p3d",[6926.13,7433.02,2.90162],[[-0.278337,0.960484,0],[0,0,1]],0,0,2,[],{}],
		["Land_IntravenStand_01_empty_F","a3\props_f_orange\humanitarian\camps\intravenstand_01_f.p3d",[6924.68,7433.35,3.59139],[[0.977255,0.212069,0],[0,0,1]],0,0,2,[],{}],
		["Land_IntravenStand_01_2bags_F","a3\props_f_orange\humanitarian\camps\intravenstand_01_f.p3d",[6926.19,7427.62,3.59139],[[0.968304,0.249775,0],[0,0,1]],0,0,2,[],{}],
		["Land_IntravenStand_01_2bags_F","a3\props_f_orange\humanitarian\camps\intravenstand_01_f.p3d",[6923.72,7426.9,3.59139],[[0.968304,0.249775,0],[0,0,1]],0,0,2,[],{}],
		["Land_CampingChair_V2_white_F","a3\structures_f\civ\camping\campingchair_v2_f.p3d",[6921.16,7431.45,3.16649],[[0.830012,-0.557746,0],[0,0,1]],0,0,2,[],{}],
		["Land_CampingTable_white_F","a3\structures_f\civ\camping\campingtable_f.p3d",[6920.16,7432.35,3.07155],[[0.227297,-0.973826,0],[0,0,1]],0,0,2,[],{}],
		["Land_CampingTable_small_white_F","a3\structures_f\civ\camping\campingtable_small_f.p3d",[6919.8,7431.32,3.0652],[[0.979987,0.19906,0],[0,0,1]],0,0,2,[],{}],
		["Land_FirstAidKit_01_open_F","a3\props_f_orange\humanitarian\camps\firstaidkit_01_open_f.p3d",[6919.89,7431.08,3.53579],[[0.210456,-0.977603,0],[0,0,1]],0,0,2,[],{}],
		["Land_FirstAidKit_01_closed_F","a3\props_f_orange\humanitarian\camps\firstaidkit_01_closed_f.p3d",[6923.85,7431.27,2.83884],[[-0.244519,0.969645,0],[0,0,1]],0,0,2,[],{}],
		["Land_Shed_06_F","a3\structures_f_exp\civilian\sheds\shed_06_f.p3d",[7089.39,7300.47,4.0757],[[0.17884,-0.983878,0],[0,0,1]],0,0,2,[],{}],
		["Land_HBarrier_01_line_5_green_F","a3\structures_f_exp\military\fortifications\hbarrier_01_line_5_green_f.p3d",[7085.37,7296.63,3.40051],[[0.981951,0.189138,0],[0,0,1]],0,0,2,[],{}],
		["Land_HBarrier_01_line_5_green_F","a3\structures_f_exp\military\fortifications\hbarrier_01_line_5_green_f.p3d",[7084.26,7302.25,3.40051],[[0.981951,0.189138,0],[0,0,1]],0,0,2,[],{}],
		["Land_HBarrier_01_line_5_green_F","a3\structures_f_exp\military\fortifications\hbarrier_01_line_5_green_f.p3d",[7094.3,7298.6,3.40051],[[0.981951,0.189138,0],[0,0,1]],0,0,2,[],{}],
		["Land_HBarrier_01_line_5_green_F","a3\structures_f_exp\military\fortifications\hbarrier_01_line_5_green_f.p3d",[7093.34,7304.23,3.40051],[[0.981951,0.189138,0],[0,0,1]],0,0,2,[],{}],
		["Land_HBarrier_01_line_5_green_F","a3\structures_f_exp\military\fortifications\hbarrier_01_line_5_green_f.p3d",[7085.54,7306.25,3.40051],[[-0.180965,0.983489,0],[0,0,1]],0,0,2,[],{}],
		["Land_HBarrier_01_line_5_green_F","a3\structures_f_exp\military\fortifications\hbarrier_01_line_5_green_f.p3d",[7092.94,7294.7,3.40051],[[0.173402,-0.984851,0],[0,0,1]],0,0,2,[],{}],
		["B_supplyCrate_F","a3\weapons_f\ammoboxes\supplydrop.p3d",[7091.73,7302.61,3.55242],[[-0.986106,-0.166116,0],[0,0,1]],0,0,2,[],{
			(_this select 0) setVariable ['QS_arsenal_object',TRUE,TRUE];
			missionNamespace setVariable ['QS_arsenals',((missionNamespace getVariable 'QS_arsenals') + [(_this select 0)]),TRUE];
		}],
		["Land_HelipadCircle_F","a3\structures_f\mil\helipads\helipadcircle_f.p3d",[7117.43,7288.91,2.66],[[-0.164959,0.9863,0],[0,0,1]],0,0,0,[],{}],
		["Land_HelipadCircle_F","a3\structures_f\mil\helipads\helipadcircle_f.p3d",[7124.26,7249.16,2.75415],[[-0.164938,0.985516,-0.0394071],[0.0159977,0.0426222,0.998963]],0,0,0,[],{}],
		["Land_HelipadCircle_F","a3\structures_f\mil\helipads\helipadcircle_f.p3d",[7130.9,7208.01,2.66],[[-0.164959,0.9863,0],[0,0,1]],0,0,0,[],{}],
		["Land_HelipadCircle_F","a3\structures_f\mil\helipads\helipadcircle_f.p3d",[7082.07,7200.62,2.66],[[-0.164959,0.9863,0],[0,0,1]],0,0,0,[],{}],
		["Land_HelipadCircle_F","a3\structures_f\mil\helipads\helipadcircle_f.p3d",[7075.11,7241.29,2.66],[[-0.164959,0.9863,0],[0,0,1]],0,0,0,[],{}],
		["Land_HelipadCircle_F","a3\structures_f\mil\helipads\helipadcircle_f.p3d",[7066.66,7280.22,2.66],[[-0.164959,0.9863,0],[0,0,1]],0,0,0,[],{}],
		["Land_Bollard_01_F","a3\structures_f_exp\signs\traffic\bollard_01_f.p3d",[6935.93,7406.12,3.18026],[[0,1,0],[0,0,1]],0,0,2,[],{}],
		["Land_HelipadCircle_F","a3\structures_f\mil\helipads\helipadcircle_f.p3d",[7046.31,7555.68,2.66],[[-0.164959,0.9863,0],[0,0,1]],0,0,0,[],{}],
		["Land_CncBarrier_stripes_F","a3\structures_f\walls\cncbarrier_stripes_f.p3d",[7009.45,7565.18,3.04567],[[0.908821,-0.417186,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_stripes_F","a3\structures_f\walls\cncbarrier_stripes_f.p3d",[7010.56,7567.55,3.04567],[[0.908821,-0.417186,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_stripes_F","a3\structures_f\walls\cncbarrier_stripes_f.p3d",[7011.62,7569.91,3.04567],[[0.908821,-0.417186,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_stripes_F","a3\structures_f\walls\cncbarrier_stripes_f.p3d",[7012.71,7572.28,3.04567],[[0.908821,-0.417186,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_stripes_F","a3\structures_f\walls\cncbarrier_stripes_f.p3d",[7013.8,7574.66,3.04567],[[0.908821,-0.417186,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_stripes_F","a3\structures_f\walls\cncbarrier_stripes_f.p3d",[7008.41,7562.79,3.04567],[[0.919818,-0.392344,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_stripes_F","a3\structures_f\walls\cncbarrier_stripes_f.p3d",[7007.36,7560.4,3.04567],[[0.908821,-0.417186,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_stripes_F","a3\structures_f\walls\cncbarrier_stripes_f.p3d",[6995.49,7571.92,3.04567],[[0.911885,-0.410445,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_stripes_F","a3\structures_f\walls\cncbarrier_stripes_f.p3d",[6996.58,7574.29,3.04567],[[0.911885,-0.410445,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_stripes_F","a3\structures_f\walls\cncbarrier_stripes_f.p3d",[6997.63,7576.66,3.04701],[[0.911885,-0.410445,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_stripes_F","a3\structures_f\walls\cncbarrier_stripes_f.p3d",[6998.7,7579.04,3.05101],[[0.911885,-0.410445,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_stripes_F","a3\structures_f\walls\cncbarrier_stripes_f.p3d",[6999.77,7581.42,3.04567],[[0.911885,-0.410445,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_stripes_F","a3\structures_f\walls\cncbarrier_stripes_f.p3d",[6994.47,7569.51,3.04567],[[0.922698,-0.385523,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_stripes_F","a3\structures_f\walls\cncbarrier_stripes_f.p3d",[6993.44,7567.11,3.0415],[[0.911804,-0.410445,0.0121529],[-0.0133272,0,0.999911]],0,0,2,[],{}],
		["PortableHelipadLight_01_red_F","a3\structures_f_heli\items\airport\portablehelipadlight_01_f.p3d",[7006.63,7559.43,2.77068],[[-0.922993,0.384817,0],[0,0,1]],0,1,0,[],{}],
		["PortableHelipadLight_01_red_F","a3\structures_f_heli\items\airport\portablehelipadlight_01_f.p3d",[7014.05,7575.88,2.77068],[[-0.922993,0.384817,0],[0,0,1]],0,1,0,[],{}],
		["PortableHelipadLight_01_red_F","a3\structures_f_heli\items\airport\portablehelipadlight_01_f.p3d",[7000.5,7582.41,2.77068],[[-0.922993,0.384817,0],[0,0,1]],0,1,0,[],{}],
		["PortableHelipadLight_01_red_F","a3\structures_f_heli\items\airport\portablehelipadlight_01_f.p3d",[6993.2,7565.92,2.76331],[[-0.922911,0.384817,-0.0123009],[-0.0133272,0,0.999911]],0,1,0,[],{}],
		["Land_WoodenShelter_01_F","a3\structures_f_exp\commercial\market\woodenshelter_01_f.p3d",[7014.74,7565.61,3.77381],[[-0.921964,0.387275,0],[0,0,1]],0,0,2,[],{}],
		["Land_FirstAidKit_01_closed_F","a3\props_f_orange\humanitarian\camps\firstaidkit_01_closed_f.p3d",[7014.66,7565.6,3.65184],[[-0.92347,0.38367,0],[0,0,1]],0,0,2,[],{}],
		["Land_CampingTable_small_F","a3\structures_f\civ\camping\campingtable_small_f.p3d",[7014.72,7565.59,3.0652],[[0.925868,-0.377847,0],[0,0,1]],0,0,2,[],{}],
		["Land_HBarrier_01_big_4_green_F","a3\structures_f_exp\military\fortifications\hbarrier_01_big_4_green_f.p3d",[7053.94,7463.42,2.87],[[-0.986342,-0.164711,0],[0,0,1]],0,0,2,[],{}],
		["Land_HBarrier_01_big_4_green_F","a3\structures_f_exp\military\fortifications\hbarrier_01_big_4_green_f.p3d",[7049.8,7468.21,2.87],[[-0.170696,0.985324,0],[0,0,1]],0,0,2,[],{}],
		["Land_HBarrier_01_big_4_green_F","a3\structures_f_exp\military\fortifications\hbarrier_01_big_4_green_f.p3d",[7041.26,7466.72,2.87],[[-0.170696,0.985324,0],[0,0,1]],0,0,2,[],{}],
		["Land_HBarrier_01_big_4_green_F","a3\structures_f_exp\military\fortifications\hbarrier_01_big_4_green_f.p3d",[7051.59,7457.71,2.87],[[0.13414,-0.990962,0],[0,0,1]],0,0,2,[],{}],
		["Land_HBarrier_01_big_4_green_F","a3\structures_f_exp\military\fortifications\hbarrier_01_big_4_green_f.p3d",[7042.88,7456.4,2.87],[[-0.170696,0.985324,0],[0,0,1]],0,0,2,[],{}],
		["Land_New_WiredFence_10m_F","a3\structures_f\walls\new_wiredfence_10m_f.p3d",[7037.96,7460.8,2.87385],[[-0.990692,-0.136126,0],[0,0,1]],0,0,2,[],{}],
		["Land_HBarrier_01_big_4_green_F","a3\structures_f_exp\military\fortifications\hbarrier_01_big_4_green_f.p3d",[7076.09,7341.4,3.87],[[-0.986342,-0.164711,0],[0,0,1]],0,0,2,[],{}],
		["Land_HBarrier_01_big_4_green_F","a3\structures_f_exp\military\fortifications\hbarrier_01_big_4_green_f.p3d",[7071.95,7346.19,3.87],[[-0.170696,0.985324,0],[0,0,1]],0,0,2,[],{}],
		["Land_HBarrier_01_big_4_green_F","a3\structures_f_exp\military\fortifications\hbarrier_01_big_4_green_f.p3d",[7063.42,7344.69,3.87],[[-0.170696,0.985324,0],[0,0,1]],0,0,2,[],{}],
		["Land_HBarrier_01_big_4_green_F","a3\structures_f_exp\military\fortifications\hbarrier_01_big_4_green_f.p3d",[7073.74,7335.69,3.87],[[0.13414,-0.990962,0],[0,0,1]],0,0,2,[],{}],
		["Land_HBarrier_01_big_4_green_F","a3\structures_f_exp\military\fortifications\hbarrier_01_big_4_green_f.p3d",[7065.03,7334.37,3.87],[[-0.170696,0.985324,0],[0,0,1]],0,0,2,[],{}],
		["Land_HBarrier_01_line_5_green_F","a3\structures_f_exp\military\fortifications\hbarrier_01_line_5_green_f.p3d",[7060.19,7335.49,3.40051],[[-0.988083,-0.153922,0],[0,0,1]],0,0,2,[],{}],
		["Land_Laptop_unfolded_F","a3\structures_f\items\electronics\laptop_unfolded_f.p3d",[6900.87,7424.17,16.8384],[[-0.97679,-0.214197,0],[0,0,1]],0,0,0,[],{
			missionNamespace setVariable ['QS_airdefense_laptop',(_this select 0),TRUE];
		}],
		["Land_CampingTable_F","a3\structures_f\civ\camping\campingtable_f.p3d",[6908.14,7426.6,3.07155],[[-0.214971,0.97662,0],[0,0,1]],0,0,2,[],{}],
		["Land_CampingTable_F","a3\structures_f\civ\camping\campingtable_f.p3d",[6911.18,7424.03,3.07155],[[-0.214971,0.97662,0],[0,0,1]],0,0,2,[],{}],
		["Land_CampingTable_F","a3\structures_f\civ\camping\campingtable_f.p3d",[6912.38,7424.88,3.07155],[[-0.970426,-0.2414,0],[0,0,1]],0,0,2,[],{}],
		["Land_FlatTV_01_F","a3\structures_f_heli\items\electronics\flattv_01_f.p3d",[6911.2,7423.93,3.78612],[[0.159714,-0.987163,0],[0,0,1]],0,0,0,[],{}],
		["Land_PCSet_01_keyboard_F","a3\structures_f_heli\items\electronics\pcset_01_keyboard_f.p3d",[6911.85,7424.39,3.48353],[[0.522986,-0.852341,0],[0,0,1]],0,0,2,[],{}],
		["Land_PCSet_01_mousepad_F","a3\props_f_orange\items\electronics\pcset_01_mousepad_f.p3d",[6911.43,7424.28,3.47923],[[0,1,0],[0,0,1]],0,0,2,[],{}],
		["Land_PCSet_01_mouse_F","a3\structures_f_heli\items\electronics\pcset_01_mouse_f.p3d",[6911.42,7424.33,3.50807],[[0.5547,-0.83205,0],[0,0,1]],0,0,2,[],{}],
		["Land_PCSet_01_screen_F","a3\structures_f_heli\items\electronics\pcset_01_screen_f.p3d",[6912.02,7424.06,3.73028],[[0.534409,-0.845226,0],[0,0,1]],0,0,2,[],{}],
		["Land_PCSet_01_screen_F","a3\structures_f_heli\items\electronics\pcset_01_screen_f.p3d",[6912.42,7424.46,3.73028],[[0.845631,-0.533767,0],[0,0,1]],0,0,2,[],{}],
		["Land_Laptop_unfolded_F","a3\structures_f\items\electronics\laptop_unfolded_f.p3d",[6912.34,7425.09,3.63167],[[-0.995202,0.097839,0],[0,0,1]],0,0,0,[],{
		
		}],
		["Land_Portable_generator_F","a3\structures_f\items\electronics\portable_generator_f.p3d",[6909.72,7423.48,3.01918],[[0,1,0],[0,0,1]],0,0,2,[],{}],
		["Land_PCSet_01_case_F","a3\structures_f_heli\items\electronics\pcset_01_case_f.p3d",[6910.96,7424.08,2.91704],[[0.131496,-0.991317,0],[0,0,1]],0,0,2,[],{}],
		["Land_PCSet_01_case_F","a3\structures_f_heli\items\electronics\pcset_01_case_f.p3d",[6910.7,7424.04,2.91704],[[0.131496,-0.991317,0],[0,0,1]],0,0,2,[],{}],
		["Land_HDMICable_01_F","a3\structures_f_heli\items\electronics\hdmicable_01_f.p3d",[6911.96,7424.25,3.4807],[[0.971576,-0.236729,0],[0,0,1]],0,0,2,[],{}],
		["Land_Map_Tanoa_F","a3\structures_f_epb\items\documents\map_blank_f.p3d",[6908.74,7426.62,3.4806],[[0,1,0],[0,0,1]],0,0,1,[],{}],
		["Land_TripodScreen_01_large_F","a3\props_f_exp\military\camps\tripodscreen_01_large_f.p3d",[6903.91,7425.51,3.81316],[[0.976121,0.217226,0],[0,0,1]],0,0,0,[],{
			(_this select 0) setObjectTextureGlobal [0,(selectRandom (missionNamespace getVariable ['QS_missionConfig_textures_billboard2',[]]))];
		}],
		["Land_PortableGenerator_01_F","a3\props_f_exp\military\camps\portablegenerator_01_f.p3d",[6904.29,7426.49,3.14566],[[-0.999999,0.00160361,0],[0,0,1]],0,0,2,[],{}],
		["Land_Orange_01_F","a3\props_f_orange\humanitarian\supplies\orange_01_f.p3d",[6928.33,7415.33,3.5168],[[0,1,0],[0,0,1]],0,0,2,[],{}],
		["Land_Can_V3_F","a3\structures_f\items\food\can_v3_f.p3d",[6928.03,7415.44,3.51661],[[0,1,0],[0,0,1]],0,0,2,[],{}],
		["Land_Can_V3_F","a3\structures_f\items\food\can_v3_f.p3d",[6929.15,7416.38,3.51661],[[0,1,0],[0,0,1]],0,0,2,[],{}],
		["Land_New_WiredFence_10m_F","a3\structures_f\walls\new_wiredfence_10m_f.p3d",[6928.98,7371.04,3.87385],[[0.985049,0.172276,0],[0,0,1]],0,0,2,[],{}],
		["Land_New_WiredFence_5m_F","a3\structures_f\walls\new_wiredfence_5m_f.p3d",[6922.63,7366.57,3.75245],[[0.149797,-0.988717,0],[0,0,1]],0,0,2,[],{}],
		["Land_New_WiredFence_5m_F","a3\structures_f\walls\new_wiredfence_5m_f.p3d",[6927.21,7365.3,3.75245],[[0.149797,-0.988717,0],[0,0,1]],0,0,2,[],{}],
		["Land_New_WiredFence_5m_F","a3\structures_f\walls\new_wiredfence_5m_f.p3d",[6920.67,7373.98,3.75245],[[0.180347,-0.983603,0],[0,0,1]],0,0,2,[],{}],
		["Land_New_WiredFence_5m_F","a3\structures_f\walls\new_wiredfence_5m_f.p3d",[6925.49,7374.92,3.75245],[[0.149797,-0.988717,0],[0,0,1]],0,0,2,[],{}],
		["MapBoard_Tanoa_F","a3\structures_f\civ\infoboards\mapboard_f.p3d",[6905.82,7423.94,3.73887],[[-0.777897,-0.628392,0],[0,0,1]],0,0,1,[],{}],
		["Land_OfficeChair_01_F","a3\structures_f_heli\furniture\officechair_01_f.p3d",[6911.01,7424.84,3.33442],[[-0.981668,0.190601,0],[0,0,1]],0,0,2,[],{}],
		["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[6920.14,7363.42,12.9173],[[0.787361,-0.616492,0],[0,0,1]],0,1,0,[],{(missionNamespace getVariable 'QS_lamps') pushBack (_this select 0);}],
		["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[6920.6,7376.96,8.64218],[[0.801565,-0.597907,0],[0,0,1]],0,1,0,[],{(missionNamespace getVariable 'QS_lamps') pushBack (_this select 0);}],
		["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[6901.39,7432.42,8.64218],[[-0.57234,-0.820016,0],[0,0,1]],0,1,0,[],{(missionNamespace getVariable 'QS_lamps') pushBack (_this select 0);}],
		["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[6916.58,7394.74,8.64218],[[0.632402,-0.77464,0],[0,0,1]],0,1,0,[],{(missionNamespace getVariable 'QS_lamps') pushBack (_this select 0);}],
		["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[6911.68,7420.22,8.64218],[[-0.243465,-0.96991,0],[0,0,1]],0,1,0,[],{(missionNamespace getVariable 'QS_lamps') pushBack (_this select 0);}],
		["Land_LampShabby_F","a3\structures_f\civ\lamps\lampshabby_f.p3d",[7083.05,7303.88,6.43203],[[0.998709,0.0507962,0],[0,0,1]],0,1,0,[],{(missionNamespace getVariable 'QS_lamps') pushBack (_this select 0);}],
		["Land_LampShabby_F","a3\structures_f\civ\lamps\lampshabby_f.p3d",[7082.82,7304.37,6.43203],[[-0.848668,0.528925,0],[0,0,1]],0,1,0,[],{(missionNamespace getVariable 'QS_lamps') pushBack (_this select 0);}],
		["Land_LampShabby_F","a3\structures_f\civ\lamps\lampshabby_f.p3d",[7061.16,7335.15,6.43203],[[-0.113608,0.993526,0],[0,0,1]],0,1,0,[],{(missionNamespace getVariable 'QS_lamps') pushBack (_this select 0);}],
		["Land_CampingTable_small_F","a3\structures_f\civ\camping\campingtable_small_f.p3d",[6841.74,7276.2,3.0861],[[-0.488614,0.8725,0.000238581],[0.000488281,0,1]],0,0,2,[],{
			if (!((missionNamespace getVariable ['QS_missionConfig_carrierEnabled',0]) isEqualTo 0)) then {
				(_this select 0) hideObjectGlobal TRUE;
			};
		}],
		["Land_Laptop_unfolded_F","a3\structures_f\items\electronics\laptop_unfolded_f.p3d",[6841.68,7276.29,3.64628],[[-0.56136,0.827572,0.000274102],[0.000488281,0,1]],0,0,0,[],{
			missionNamespace setVariable ['QS_cas_laptop',(_this select 0),TRUE];
			if (!((missionNamespace getVariable ['QS_missionConfig_carrierEnabled',0]) isEqualTo 0)) then {
				(_this select 0) enableDynamicSimulation FALSE;
				(_this select 0) setVariable ['QS_dynSim_ignore',TRUE,TRUE];
				(_this select 0) hideObjectGlobal TRUE;
			};
		}],
		["Land_SCF_01_chimney_F","a3\structures_f_exp\industrial\sugarcanefactory_01\scf_01_chimney_f.p3d",[6876.81,7240.19,33.2707],[[-0.532993,-0.84612,0],[0,0,1]],0,0,2,[],{
			_chimney = _this select 0;
			missionNamespace setVariable [
				'QS_setFeatureType',
				((missionNamespace getVariable 'QS_setFeatureType') + [[_chimney,2]]),
				TRUE
			];
			_fire = createVehicle ['test_EmptyObjectForFireBig',[0,0,0],[],0,'CAN_COLLIDE'];
			_fire allowDamage FALSE;
			missionNamespace setVariable [
				'QS_setFeatureType',
				((missionNamespace getVariable 'QS_setFeatureType') + [[_fire,2]]),
				TRUE
			];			
			missionNamespace setVariable ['QS_torch',_fire,TRUE];
			_fire enableDynamicSimulation FALSE;
			_fire setVariable ['QS_dynSim_ignore',TRUE,TRUE];
			_fire attachTo [_chimney,[0,0,0]];
			_fire spawn {
				uiSleep 0.1;
				detach _this;
			};
		}],
		["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[6792.67,7423.99,8.64218],[[-0.881599,-0.472,0],[0,0,1]],0,1,0,[],{(missionNamespace getVariable 'QS_lamps') pushBack (_this select 0);}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[6805.47,7394.92,3.04567],[[-0.213697,0.9769,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[6802.93,7394.34,3.04567],[[-0.213697,0.9769,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[6800.41,7393.78,3.04567],[[-0.213697,0.9769,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[6799.14,7394.96,3.04567],[[0.984245,0.17681,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[6798.68,7397.56,3.04567],[[0.982623,0.185614,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[6799.51,7399.31,3.04567],[[0.219915,-0.975519,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[6802.04,7399.88,3.04567],[[0.219915,-0.975519,0],[0,0,1]],0,0,2,[],{}],
		["Land_FuelStation_02_roof_F","a3\structures_f_exp\commercial\fuelstation_02\fuelstation_02_roof_f.p3d",[6802.72,7413.93,5.08465],[[0.979967,0.199159,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[6801.46,7415.15,3.04567],[[-0.98382,-0.179157,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[6801.9,7412.66,3.04567],[[-0.979883,-0.199571,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[6801.77,7417.51,3.04567],[[-0.909051,0.416686,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[6803.1,7410.66,3.04567],[[-0.594134,-0.804366,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[6796.15,7410.46,3.04567],[[0.981938,0.189203,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[6795.66,7413.02,3.04567],[[0.981938,0.189203,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[6795.18,7415.56,3.04567],[[0.981938,0.189203,0],[0,0,1]],0,0,2,[],{}],
		["Land_PierWooden_02_16m_F","a3\structures_f_exp\naval\piers\pierwooden_02_16m_f.p3d",[6674.34,6980.42,-18.9063],[[0.651476,0.758669,0],[0,0,1]],0,0,2,[],{}],
		["Land_PierWooden_02_16m_F","a3\structures_f_exp\naval\piers\pierwooden_02_16m_f.p3d",[6664.07,6968.48,-18.9334],[[0.651476,0.758669,0],[0,0,1]],0,0,2,[],{}],
		["Land_PierWooden_02_16m_F","a3\structures_f_exp\naval\piers\pierwooden_02_16m_f.p3d",[6653.66,6956.49,-18.9334],[[0.651476,0.758669,0],[0,0,1]],0,0,2,[],{}],
		["Land_PierWooden_02_barrel_F","a3\structures_f_exp\naval\piers\pierwooden_02_barrel_f.p3d",[6571.87,6915.16,-19.1662],[[-0.960648,0.277767,0],[0,0,1]],0,0,2,[],{}],
		["Land_PierWooden_02_hut_F","a3\structures_f_exp\naval\piers\pierwooden_02_hut_f.p3d",[6578.31,6911.04,-16.9415],[[-0.95739,0.288798,0],[0,0,1]],0,0,2,[],{}],
		["Land_PierWooden_02_ladder_F","a3\structures_f_exp\naval\piers\pierwooden_02_ladder_f.p3d",[6572.29,6910.81,-19.0792],[[-0.958148,0.286274,0],[0,0,1]],0,0,2,[],{}],
		["Land_PierWooden_02_16m_F","a3\structures_f_exp\naval\piers\pierwooden_02_16m_f.p3d",[6643.33,6944.51,-18.9299],[[0.651476,0.758669,0],[0,0,1]],0,0,2,[],{}],
		["Land_PierWooden_02_16m_F","a3\structures_f_exp\naval\piers\pierwooden_02_16m_f.p3d",[6632.96,6932.45,-18.9605],[[0.651476,0.758669,0],[0,0,1]],0,0,2,[],{}],
		["Land_PierWooden_02_16m_F","a3\structures_f_exp\naval\piers\pierwooden_02_16m_f.p3d",[6622.59,6920.4,-18.9521],[[0.651476,0.758669,0],[0,0,1]],0,0,2,[],{}],
		["Land_PierWooden_02_30deg_F","a3\structures_f_exp\naval\piers\pierwooden_02_30deg_f.p3d",[6616.37,6913.4,-19.078],[[-0.665152,-0.746708,0],[0,0,1]],0,0,2,[],{}],
		["Land_PierWooden_02_16m_F","a3\structures_f_exp\naval\piers\pierwooden_02_16m_f.p3d",[6607.63,6910.4,-18.9939],[[0.957173,0.289516,0],[0,0,1]],0,0,2,[],{}],
		["Land_PierWooden_02_30deg_F","a3\structures_f_exp\naval\piers\pierwooden_02_30deg_f.p3d",[6598.65,6907.88,-19.1155],[[-0.961727,-0.27401,0],[0,0,1]],0,0,2,[],{}],
		["Land_PierWooden_02_16m_F","a3\structures_f_exp\naval\piers\pierwooden_02_16m_f.p3d",[6589.66,6910.02,-19.0445],[[0.963285,-0.268483,0],[0,0,1]],0,0,2,[],{}],
		["Land_LampShabby_F","a3\structures_f\civ\lamps\lampshabby_f.p3d",[6678.45,6983.47,4.63239],[[-0.958327,-0.285675,0],[0,0,1]],0,1,0,[],{(missionNamespace getVariable 'QS_lamps') pushBack (_this select 0);}],
		["Land_LampShabby_F","a3\structures_f\civ\lamps\lampshabby_f.p3d",[6615.72,6914.46,4.56615],[[0.376498,-0.926418,0],[0,0,1]],0,1,0,[],{(missionNamespace getVariable 'QS_lamps') pushBack (_this select 0);}],
		["Land_LampShabby_F","a3\structures_f\civ\lamps\lampshabby_f.p3d",[6598.46,6909.15,4.52859],[[-0.405813,-0.913956,0],[0,0,1]],0,1,0,[],{(missionNamespace getVariable 'QS_lamps') pushBack (_this select 0);}],
		["Land_LampShabby_F","a3\structures_f\civ\lamps\lampshabby_f.p3d",[6582.15,6913.38,4.43318],[[-0.656601,-0.754238,0],[0,0,1]],0,1,0,[],{(missionNamespace getVariable 'QS_lamps') pushBack (_this select 0);}],
		["Land_Bollard_01_F","a3\structures_f_exp\signs\traffic\bollard_01_f.p3d",[6677.69,6984.36,1.38062],[[0,1,0],[0,0,1]],0,0,2,[],{}],
		//["Land_TripodScreen_01_dual_v1_F","a3\props_f_exp\military\camps\tripodscreen_01_dual_v1_f.p3d",[6932.27,7397.99,3.46966],[[-0.272542,0.962144,0],[0,0,1]],0,0,0,[],{missionNamespace setVariable ['QS_panel_support',(_this select 0),TRUE];}],
		["Flag_RedCrystal_F","a3\structures_f\mil\flags\mast_f.p3d",[6929.94,7426.93,6.6368],[[0,1,0],[0,0,1]],0,1,0,[],{}]
	]
};
if (_worldName isEqualTo 'Malden') exitWith {
	[
		["B_supplyCrate_F","a3\weapons_f\ammoboxes\supplydrop.p3d",[8133.84,10135.8,30.5744],[[0,1,0],[0.000845728,0,1]],0,0,2,[],{
			(_this select 0) setVariable ['QS_arsenal_object',TRUE,TRUE];
			missionNamespace setVariable ['QS_arsenals',((missionNamespace getVariable 'QS_arsenals') + [(_this select 0)]),TRUE];
		}],
		["B_supplyCrate_F","a3\weapons_f\ammoboxes\supplydrop.p3d",[8143.63,10129.2,29.8759],[[-0.999831,-0.0103755,0.0152024],[0.0151952,0.000771951,0.999884]],0,0,2,[],{
			(_this select 0) setVariable ['QS_arsenal_object',TRUE,TRUE];
			missionNamespace setVariable ['QS_arsenals',((missionNamespace getVariable 'QS_arsenals') + [(_this select 0)]),TRUE];
		}],
		["B_supplyCrate_F","a3\weapons_f\ammoboxes\supplydrop.p3d",[8131.83,10106.5,30.5761],[[0.0103443,0.999946,-8.74844e-006],[0.000845728,0,1]],0,0,2,[],{
			(_this select 0) setVariable ['QS_arsenal_object',TRUE,TRUE];
			missionNamespace setVariable ['QS_arsenals',((missionNamespace getVariable 'QS_arsenals') + [(_this select 0)]),TRUE];
		}],
		["B_supplyCrate_F","a3\weapons_f\ammoboxes\supplydrop.p3d",[8123.24,10114,30.2935],[[-0.999886,0.00915611,0.0119995],[0.012,0,0.999928]],0,0,2,[],{
			(_this select 0) setVariable ['QS_arsenal_object',TRUE,TRUE];
			missionNamespace setVariable ['QS_arsenals',((missionNamespace getVariable 'QS_arsenals') + [(_this select 0)]),TRUE];
		}],
		["B_supplyCrate_F","a3\weapons_f\ammoboxes\supplydrop.p3d",[8127.85,10117.1,30.579],[[0.0299079,0.999553,-2.52939e-005],[0.000845728,0,1]],0,0,2,[],{
			(_this select 0) setVariable ['QS_arsenal_object',TRUE,TRUE];
			missionNamespace setVariable ['QS_arsenals',((missionNamespace getVariable 'QS_arsenals') + [(_this select 0)]),TRUE];
		}],
		["Land_PipeWall_concretel_8m_F","a3\structures_f\walls\pipewall_concretel_8m_f.p3d",[8106,10134.2,30.2865],[[-0.0434716,-0.999055,0],[0,0,1]],0,0,2,[],{}],
		["Land_PipeWall_concretel_8m_F","a3\structures_f\walls\pipewall_concretel_8m_f.p3d",[8117.23,10133.7,30.2348],[[-0.0434718,-0.999055,0],[0,0,1]],0,0,2,[],{}],
		["Land_PipeWall_concretel_8m_F","a3\structures_f\walls\pipewall_concretel_8m_f.p3d",[8120.83,10133.6,30.1974],[[-0.0434718,-0.999055,0],[0,0,1]],0,0,2,[],{}],
		["Land_PipeWall_concretel_8m_F","a3\structures_f\walls\pipewall_concretel_8m_f.p3d",[8102.12,10130.6,30.2906],[[-0.999296,0.0375107,0],[0,0,1]],0,0,2,[],{}],
		["Land_PipeWall_concretel_8m_F","a3\structures_f\walls\pipewall_concretel_8m_f.p3d",[8101.45,10119.3,30.2917],[[-0.999894,0.0145511,0],[0,0,1]],0,0,2,[],{}],
		["Land_PipeWall_concretel_8m_F","a3\structures_f\walls\pipewall_concretel_8m_f.p3d",[8101.38,10111.3,30.2899],[[-0.99996,0.00895632,0],[0,0,1]],0,0,2,[],{}],
		["Land_PipeWall_concretel_8m_F","a3\structures_f\walls\pipewall_concretel_8m_f.p3d",[8101.31,10103.4,30.2898],[[-0.99996,0.00895632,0],[0,0,1]],0,0,2,[],{}],
		["Land_PipeWall_concretel_8m_F","a3\structures_f\walls\pipewall_concretel_8m_f.p3d",[8105.05,10099.7,30.2769],[[0.0023852,0.999997,0],[0,0,1]],0,0,2,[],{}],
		["Land_PipeWall_concretel_8m_F","a3\structures_f\walls\pipewall_concretel_8m_f.p3d",[8113.01,10099.7,30.2449],[[0.0023852,0.999997,0],[0,0,1]],0,0,2,[],{}],
		["Land_PipeWall_concretel_8m_F","a3\structures_f\walls\pipewall_concretel_8m_f.p3d",[8120.99,10099.7,30.13],[[0.0023852,0.999997,0],[0,0,1]],0,0,2,[],{}],
		["Land_PipeWall_concretel_8m_F","a3\structures_f\walls\pipewall_concretel_8m_f.p3d",[8133.46,10101.4,29.8767],[[-0.999918,0.012777,0],[0,0,1]],0,0,2,[],{}],
		["Land_PipeWall_concretel_8m_F","a3\structures_f\walls\pipewall_concretel_8m_f.p3d",[8128.24,10097.8,29.9854],[[0.502683,0.864471,0],[0,0,1]],0,0,2,[],{}],
		["Land_Bollard_01_F","a3\structures_f_exp\signs\traffic\bollard_01_f.p3d",[8132.68,10096.5,29.6492],[[0,0.999988,0.00479659],[0.0239937,-0.00479521,0.999701]],0,0,2,[],{}],
		["Land_Bollard_01_F","a3\structures_f_exp\signs\traffic\bollard_01_f.p3d",[8101.61,10124.4,30.0677],[[0,1,0],[0.00154408,0,0.999999]],0,0,2,[],{}],
		["Land_Bollard_01_F","a3\structures_f_exp\signs\traffic\bollard_01_f.p3d",[8101.72,10125.6,30.0675],[[0,1,0],[0.00154408,0,0.999999]],0,0,2,[],{}],
		["Land_Bollard_01_F","a3\structures_f_exp\signs\traffic\bollard_01_f.p3d",[8111.16,10133.9,30.0584],[[0,1,0.00077204],[0.00077204,-0.00077204,0.999999]],0,0,2,[],{}],
		["Land_Bollard_01_F","a3\structures_f_exp\signs\traffic\bollard_01_f.p3d",[8112.23,10133.9,30.0576],[[0,1,0.00077204],[0.00077204,-0.00077204,0.999999]],0,0,2,[],{}],
		["Land_PipeWall_concretel_8m_F","a3\structures_f\walls\pipewall_concretel_8m_f.p3d",[8146.54,10124.8,29.6866],[[0.0289394,0.999581,0],[0,0,1]],0,0,2,[],{}],
		["Land_PipeWall_concretel_8m_F","a3\structures_f\walls\pipewall_concretel_8m_f.p3d",[8146.65,10138.4,29.6794],[[-0.0229533,-0.999737,0],[0,0,1]],0,0,2,[],{}],
		["Land_PipeWall_concretel_8m_F","a3\structures_f\walls\pipewall_concretel_8m_f.p3d",[8150.68,10134.5,29.634],[[0.999739,-0.0228512,0],[0,0,1]],0,0,2,[],{}],
		["Land_Bollard_01_F","a3\structures_f_exp\signs\traffic\bollard_01_f.p3d",[8150.71,10129.3,29.4103],[[0,1,0],[0,0,1]],0,0,2,[],{}],
		["Land_Bollard_01_F","a3\structures_f_exp\signs\traffic\bollard_01_f.p3d",[8150.74,10128.3,29.4103],[[0,1,0],[0,0,1]],0,0,2,[],{}],
		["Land_Bollard_01_F","a3\structures_f_exp\signs\traffic\bollard_01_f.p3d",[8150.74,10127.3,29.4103],[[0,1,0],[0,0,1]],0,0,2,[],{}],
		["Land_Bollard_01_F","a3\structures_f_exp\signs\traffic\bollard_01_f.p3d",[8150.76,10126.4,29.4103],[[0,1,0],[0,0,1]],0,0,2,[],{}],
		["Land_Bollard_01_F","a3\structures_f_exp\signs\traffic\bollard_01_f.p3d",[8150.67,10125.3,29.4103],[[0,1,0],[0,0,1]],0,0,2,[],{}],
		["Land_PipeWall_concretel_8m_F","a3\structures_f\walls\pipewall_concretel_8m_f.p3d",[8102.72,10138.6,30.2918],[[0.999528,-0.0307209,0],[0,0,1]],0,0,2,[],{}],
		["Land_PipeWall_concretel_8m_F","a3\structures_f\walls\pipewall_concretel_8m_f.p3d",[8102.68,10146.3,30.2918],[[0.997268,0.0738717,0],[0,0,1]],0,0,2,[],{}],
		["Land_Shed_06_F","a3\structures_f_exp\civilian\sheds\shed_06_f.p3d",[8057.4,10290.7,31.8147],[[0,1,0],[0,0,1]],0,0,2,[],{}],
		["Land_HBarrier_5_F","a3\structures_f\mil\fortification\hbarrier_5_f.p3d",[8053.36,10288.1,30.6671],[[-0.999585,0.000270834,0.028789],[0.028787,-0.00559695,0.99957]],0,0,2,[],{}],
		["Land_HBarrier_5_F","a3\structures_f\mil\fortification\hbarrier_5_f.p3d",[8053.44,10293.6,30.6959],[[-0.999585,0.000270834,0.028789],[0.028787,-0.00559695,0.99957]],0,0,2,[],{}],
		["Land_HBarrier_5_F","a3\structures_f\mil\fortification\hbarrier_5_f.p3d",[8061.82,10293.8,30.4734],[[-0.999672,0.00020693,0.0255924],[0.0255896,-0.00879288,0.999634]],0,0,2,[],{}],
		["Land_HBarrier_5_F","a3\structures_f\mil\fortification\hbarrier_5_f.p3d",[8061.69,10288.2,30.4278],[[-0.999585,0.000270834,0.028789],[0.028787,-0.00559695,0.99957]],0,0,2,[],{}],
		["Land_HBarrier_3_F","a3\structures_f\mil\fortification\hbarrier_3_f.p3d",[8054.41,10284.6,30.6797],[[0,0.999992,0.00399675],[0.028787,-0.00399509,0.999578]],0,0,2,[],{}],
		["Land_HBarrier_5_F","a3\structures_f\mil\fortification\hbarrier_5_f.p3d",[8059.89,10297.1,30.5521],[[0.00588032,0.999945,0.00864509],[0.0255896,-0.00879288,0.999634]],0,0,2,[],{}],
		["Land_HBarrier_3_F","a3\structures_f\mil\fortification\hbarrier_3_f.p3d",[8060.78,10284.9,30.4974],[[0,0.999992,0.00399675],[0.028787,-0.00399509,0.999578]],0,0,2,[],{}],
		["Land_Bollard_01_F","a3\structures_f_exp\signs\traffic\bollard_01_f.p3d",[8057.48,10284.4,30.3125],[[0,0.999992,0.00399675],[0.028787,-0.00399509,0.999578]],0,0,2,[],{}],
		["Land_Bollard_01_F","a3\structures_f_exp\signs\traffic\bollard_01_f.p3d",[8055.68,10296.8,30.4367],[[0,0.999961,0.00879576],[0.0255896,-0.00879288,0.999634]],0,0,2,[],{}],
		["B_supplyCrate_F","a3\weapons_f\ammoboxes\supplydrop.p3d",[8055.12,10288.7,30.7711],[[-0.999544,0.00899479,0.0288366],[0.028787,-0.00559695,0.99957]],0,0,2,[],{
			(_this select 0) setVariable ['QS_arsenal_object',TRUE,TRUE];
			missionNamespace setVariable ['QS_arsenals',((missionNamespace getVariable 'QS_arsenals') + [(_this select 0)]),TRUE];
		}],
		["Land_HelipadCircle_F","a3\structures_f\mil\helipads\helipadcircle_f.p3d",[8037.3,10365.7,30.2222],[[0.999952,0.00968839,0.00158962],[-0.00158221,-0.000772039,0.999998]],0,0,0,[],{}],
		["Land_HelipadCircle_F","a3\structures_f\mil\helipads\helipadcircle_f.p3d",[8038.49,10312.3,30.1562],[[0.999948,0.00969724,-0.00317853],[0.00320187,-0.00239207,0.999992]],0,0,0,[],{}],
		["Land_HelipadCircle_F","a3\structures_f\mil\helipads\helipadcircle_f.p3d",[8039.34,10265.6,29.7444],[[0.999945,0.00965409,0.00408163],[-0.00399675,-0.00879569,0.999953]],0,0,0,[],{}],
		["Land_HelipadCircle_F","a3\structures_f\mil\helipads\helipadcircle_f.p3d",[8098.12,10350.4,30.0221],[[-0.999958,-0.00917065,0.000757499],[0.00077204,-0.00158221,0.999998]],0,0,0,[],{}],
		["Land_HelipadCircle_F","a3\structures_f\mil\helipads\helipadcircle_f.p3d",[8099.4,10316.4,29.8068],[[-0.999957,-0.00915383,-0.00167009],[-0.00158221,-0.00959929,0.999953]],0,0,0,[],{}],
		["Land_HelipadCircle_F","a3\structures_f\mil\helipads\helipadcircle_f.p3d",[8100.01,10287.2,29.5571],[[-0.999957,-0.00915517,-0.00166274],[-0.00158221,-0.00879574,0.99996]],0,0,0,[],{}],
		["Land_PedestrianCrossing_01_6m_4str_F","a3\structures_f_argo\decals\horizontal\pedestriancrossing_01_6m_4str_f.p3d",[8096.35,10124.8,29.5558],[[-0.0086324,-0.999963,0],[0,0,1]],0,0,2,[],{}],
		["Land_Airport_02_controlTower_F","a3\structures_f_exp\infrastructure\airports\airport_02_controltower_f.p3d",[8110.43,10103.6,40.4159],[[-0.999982,0.00599668,0],[0,0,1]],0,1,0,[],{}],
		["Land_Laptop_unfolded_F","a3\structures_f\items\electronics\laptop_unfolded_f.p3d",[8103.9,10103.7,43.6637],[[0.999181,0.0404527,0],[0,0,1]],0,0,0,[],{
			missionNamespace setVariable ['QS_airdefense_laptop',(_this select 0),TRUE];
		}],
		["Land_TripodScreen_01_large_F","a3\props_f_exp\military\camps\tripodscreen_01_large_f.p3d",[8140.9,10106.5,30.7192],[[-0.354884,0.93491,0.000300135],[0.000845728,0,1]],0,0,0,[],{
			(_this select 0) setObjectTextureGlobal [0,(selectRandom (missionNamespace getVariable ['QS_missionConfig_textures_billboard2',[]]))];
		}],
		["Land_PortableGenerator_01_F","a3\props_f_exp\military\camps\portablegenerator_01_f.p3d",[8140,10106.7,30.0524],[[-0.00060114,-1,5.08401e-007],[0.000845728,0,1]],0,0,2,[],{}],
		["Land_MapBoard_01_Wall_Malden_F","a3\props_f_orange\civilian\infoboards\mapboard_01_wall_f.p3d",[8138.15,10105.8,31.6876],[[-0.0243173,-0.999704,0],[0,0,1]],0,0,1,[],{}],
		["Land_CampingTable_F","a3\structures_f\civ\camping\campingtable_f.p3d",[8136.6,10106.2,30.0912],[[0.00809035,0.999967,-6.84224e-006],[0.000845728,0,1]],0,0,2,[],{}],
		["Land_CampingTable_F","a3\structures_f\civ\camping\campingtable_f.p3d",[8135.22,10106.8,30.0923],[[0.999993,-0.00370363,-0.000845722],[0.000845728,0,1]],0,0,2,[],{}],
		["Land_OfficeChair_01_F","a3\structures_f_heli\furniture\officechair_01_f.p3d",[8136.88,10107.3,30.3538],[[0.804667,0.593725,-0.00068053],[0.000845728,0,1]],0,0,2,[],{}],
		["Land_Laptop_unfolded_F","a3\structures_f\items\electronics\laptop_unfolded_f.p3d",[8135.21,10107.4,30.6525],[[0.958359,-0.285566,-0.000810511],[0.000845728,0,1]],0,0,0,[],{
		
		}],
		["Land_FlatTV_01_F","a3\structures_f_heli\items\electronics\flattv_01_f.p3d",[8136.57,10105.9,30.8058],[[-0.127821,-0.991797,0.000108102],[0.000845728,0,1]],0,0,0,[],{}],
		["Land_PCSet_01_screen_F","a3\structures_f_heli\items\electronics\pcset_01_screen_f.p3d",[8135.64,10106.2,30.7507],[[-0.438452,-0.898754,0.000370811],[0.000845728,0,1]],0,0,2,[],{}],
		["Land_PCSet_01_screen_F","a3\structures_f_heli\items\electronics\pcset_01_screen_f.p3d",[8135.25,10106.6,30.751],[[-0.907051,-0.42102,0.000767119],[0.000845728,0,1]],0,0,2,[],{}],
		["Land_PCSet_01_keyboard_F","a3\structures_f_heli\items\electronics\pcset_01_keyboard_f.p3d",[8136.54,10106.4,30.5032],[[-0.218531,-0.97583,0.000184818],[0.000845728,0,1]],0,0,2,[],{}],
		["Land_PCSet_01_mousepad_IDAP_F","a3\props_f_orange\items\electronics\pcset_01_mousepad_f.p3d",[8136.08,10106.4,30.4993],[[-0.0672235,-0.997738,5.68528e-005],[0.000845728,0,1]],0,0,2,[],{}],
		["Land_PCSet_01_mouse_F","a3\structures_f_heli\items\electronics\pcset_01_mouse_f.p3d",[8136.06,10106.5,30.5282],[[-0.209172,-0.977879,0.000176903],[0.000845728,0,1]],0,0,2,[],{}],
		["Land_PCSet_01_case_F","a3\structures_f_heli\items\electronics\pcset_01_case_f.p3d",[8136.42,10106.2,29.9368],[[-0.0170109,-0.999855,1.43866e-005],[0.000845728,0,1]],0,0,2,[],{}],
		["Land_PCSet_01_case_F","a3\structures_f_heli\items\electronics\pcset_01_case_f.p3d",[8136.17,10106.2,29.937],[[-0.0279222,-0.99961,2.36146e-005],[0.000845728,0,1]],0,0,2,[],{}],
		["Land_Portable_generator_F","a3\structures_f\items\electronics\portable_generator_f.p3d",[8137.99,10106.2,30.0376],[[0,1,0],[0.000845728,0,1]],0,0,2,[],{}],
		["Land_CampingTable_F","a3\structures_f\civ\camping\campingtable_f.p3d",[8138.51,10111.1,30.0896],[[-0.999507,0.0313769,0.000845311],[0.000845728,0,1]],0,0,2,[],{}],
		["Land_CampingTable_F","a3\structures_f\civ\camping\campingtable_f.p3d",[8138.56,10113.1,30.0895],[[-0.999507,0.0313769,0.000845311],[0.000845728,0,1]],0,0,2,[],{}],
		["Land_CampingChair_V2_F","a3\structures_f\civ\camping\campingchair_v2_f.p3d",[8137.46,10110.6,30.1854],[[-0.981456,-0.191686,0.000830045],[0.000845728,0,1]],0,0,2,[],{}],
		["Land_CampingChair_V2_F","a3\structures_f\civ\camping\campingchair_v2_f.p3d",[8137.59,10112.6,30.1853],[[-0.994102,0.108448,0.00084074],[0.000845728,0,1]],0,0,2,[],{}],
		["Land_CampingChair_V2_F","a3\structures_f\civ\camping\campingchair_v2_f.p3d",[8139.39,10111.3,30.1835],[[0.862678,-0.505753,0],[0,0,1]],0,0,2,[],{}],
		["Land_CampingChair_V2_F","a3\structures_f\civ\camping\campingchair_v2_f.p3d",[8139.56,10112.8,30.1836],[[0.971258,0.238027,-0.00082142],[0.000845728,0,1]],0,0,2,[],{}],
		["Land_CampingChair_V2_F","a3\structures_f\civ\camping\campingchair_v2_f.p3d",[8138.66,10114.7,30.1844],[[-0.0102035,0.999948,8.62937e-006],[0.000845728,0,1]],0,0,2,[],{}],
		["Land_CampingChair_V2_F","a3\structures_f\civ\camping\campingchair_v2_f.p3d",[8138.43,10109.6,30.1844],[[-0.241674,-0.970358,0],[0,0,1]],0,0,2,[],{}],
		["Land_CampingTable_F","a3\structures_f\civ\camping\campingtable_f.p3d",[8117.81,10128.5,29.8934],[[0,1,0.00077204],[0.00959931,-0.000772005,0.999954]],0,0,2,[],{}],
		["Land_CampingTable_F","a3\structures_f\civ\camping\campingtable_f.p3d",[8117.81,10127.7,29.8927],[[-0.00246808,-0.999997,-0.000748345],[0.00959931,-0.000772005,0.999954]],0,0,2,[],{}],
		["Land_CampingChair_V2_F","a3\structures_f\civ\camping\campingchair_v2_f.p3d",[8118.33,10126.6,29.9818],[[0.0825703,-0.996584,-0.00156206],[0.00959931,-0.000772005,0.999954]],0,0,2,[],{}],
		["Land_CampingChair_V2_F","a3\structures_f\civ\camping\campingchair_v2_f.p3d",[8117.24,10126.6,29.9923],[[-0.438067,-0.898935,0.00351132],[0.00959931,-0.000772005,0.999954]],0,0,2,[],{}],
		["Land_CampingChair_V2_F","a3\structures_f\civ\camping\campingchair_v2_f.p3d",[8116.12,10127.6,30.0039],[[-0.929648,-0.368347,0.00864001],[0.00959931,-0.000772005,0.999954]],0,0,2,[],{}],
		["Land_CampingChair_V2_F","a3\structures_f\civ\camping\campingchair_v2_f.p3d",[8116.22,10128.8,30.0038],[[-0.872873,0.487869,0.00875602],[0.00959931,-0.000772005,0.999954]],0,0,2,[],{}],
		["Land_CampingChair_V2_F","a3\structures_f\civ\camping\campingchair_v2_f.p3d",[8117.21,10129.6,29.995],[[-0.112012,0.993705,0.00184247],[0.00959931,-0.000772005,0.999954]],0,0,2,[],{}],
		["Land_CampingChair_V2_F","a3\structures_f\civ\camping\campingchair_v2_f.p3d",[8118.6,10129.6,29.9794],[[0.399333,0.916801,-0.00312569],[0.00959931,-0.000772005,0.999954]],0,0,2,[],{}],
		["Land_CampingChair_V2_F","a3\structures_f\civ\camping\campingchair_v2_f.p3d",[8119.31,10128.6,29.9719],[[0.941127,0.337939,-0.00877368],[0.00959931,-0.000772005,0.999954]],0,0,2,[],{}],
		["Land_Orange_01_F","a3\props_f_orange\humanitarian\supplies\orange_01_f.p3d",[8117.24,10128.4,30.3441],[[0,1,0.00077204],[0.00959931,-0.000772005,0.999954]],0,0,2,[],{}],
		["Land_Can_V3_F","a3\structures_f\items\food\can_v3_f.p3d",[8118.24,10128.6,30.3344],[[0,1,0.00077204],[0.00959931,-0.000772005,0.999954]],0,0,2,[],{}],
		["Land_Can_V3_F","a3\structures_f\items\food\can_v3_f.p3d",[8117.15,10127.6,30.3441],[[0,1,0.00077204],[0.00959931,-0.000772005,0.999954]],0,0,2,[],{}],
		["Land_Shed_06_F","a3\structures_f_exp\civilian\sheds\shed_06_f.p3d",[8105.9,10131.2,31.5302],[[0,1,0],[0,0,1]],0,0,2,[],{}],
		["B_supplyCrate_F","a3\weapons_f\ammoboxes\supplydrop.p3d",[8103.59,10129.6,30.4367],[[-0.999957,0.00915611,0.00154402],[0.00154408,0,0.999999]],0,0,2,[],{
			(_this select 0) setVariable ['QS_arsenal_object',TRUE,TRUE];
			missionNamespace setVariable ['QS_arsenals',((missionNamespace getVariable 'QS_arsenals') + [(_this select 0)]),TRUE];
		}],
		["FlagPole_F","a3\structures_f\mil\flags\mast_f.p3d",[8101.72,10134.8,33.5241],[[0,1,0],[0,0,1]],0,1,0,[],{
			(_this select 0) setFlagTexture (missionNamespace getVariable ['QS_missionConfig_textures_communityFlag','a3\data_f\flags\flag_nato_co.paa']);
		}],
		["FlagPole_F","a3\structures_f\mil\flags\mast_f.p3d",[8123.6,10124.4,33.3987],[[0,1,0],[0,0,1]],0,1,0,[],{
			(_this select 0) setFlagTexture (missionNamespace getVariable ['QS_missionConfig_textures_communityFlag','a3\data_f\flags\flag_nato_co.paa']);
		}],
		["Land_PedestrianCrossing_01_6m_4str_F","a3\structures_f_argo\decals\horizontal\pedestriancrossing_01_6m_4str_f.p3d",[8090.54,10124.9,29.5651],[[-0.0086324,-0.999963,0],[0,0,1]],0,0,2,[],{}],
		["Land_InfoStand_V1_F","a3\structures_f\civ\infoboards\infostand_v1_f.p3d",[8102.17,10122.7,30.1219],[[-0.964404,-0.264428,0.00148912],[0.00154408,0,0.999999]],0,0,0,[],{
			(_this select 0) setObjectTextureGlobal [0,(selectRandom (missionNamespace getVariable ['QS_missionConfig_textures_infostand1',[]]))];
		}],
		["Land_InfoStand_V2_F","a3\structures_f\civ\infoboards\infostand_v2_f.p3d",[8102.73,10127.6,30.1259],[[-0.960836,0.277115,0.00148361],[0.00154408,0,0.999999]],0,0,0,[],{
			(_this select 0) setObjectTextureGlobal [0,(selectRandom (missionNamespace getVariable ['QS_missionConfig_textures_infostand2',[]]))];
		}],
		["Land_CampingChair_V2_F","a3\structures_f\civ\camping\campingchair_v2_f.p3d",[8101.35,10132.5,30.0543],[[0.938186,0.346127,-0.00144864],[0.00154408,0,0.999999]],0,0,2,[],{}],
		["Land_CampingChair_V2_F","a3\structures_f\civ\camping\campingchair_v2_f.p3d",[8101.37,10129.6,30.0543],[[0.968077,-0.250648,-0.00149479],[0.00154408,0,0.999999]],0,0,2,[],{}],
		["Land_HelipadSquare_F","a3\structures_f\mil\helipads\helipadsquare_f.p3d",[8039.3,10187.1,29.5989],[[0.999476,-0.0323447,-0.000746665],[0.00077204,0.00077204,0.999999]],0,0,0,[],{}],
		["Land_HelipadSquare_F","a3\structures_f\mil\helipads\helipadsquare_f.p3d",[8038.4,10147.9,29.6109],[[0.999476,-0.0323447,-0.000746665],[0.00077204,0.00077204,0.999999]],0,0,0,[],{}],
		["Land_HelipadSquare_F","a3\structures_f\mil\helipads\helipadsquare_f.p3d",[8037.38,10107.6,29.6522],[[0.999474,-0.0323497,-0.00231345],[0.00239208,0.00239207,0.999994]],0,0,0,[],{}],
		["Land_HelipadRescue_F","a3\structures_f\mil\helipads\helipadrescue_f.p3d",[8073.9,10061.9,29.6258],[[-0.999472,0.0321453,0.00476929],[0.00479659,0.000772031,0.999988]],0,0,0,[],{}],
		["Land_fs_roof_F","a3\structures_f\ind\fuelstation_small\fs_roof_f.p3d",[8248.33,10148.5,31.3146],[[0,1,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[8249.48,10149.3,29.2757],[[0,1,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[8246.9,10149.3,29.2757],[[0,1,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[8244.49,10148.8,29.2757],[[-0.442153,0.89694,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[8251.92,10148.8,29.2757],[[0.396327,0.91811,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[8243.6,10155,29.2757],[[0,1,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[8246.2,10155,29.2757],[[0,1,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[8248.79,10155,29.2757],[[0,1,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_F","a3\structures_f\walls\cncbarrier_f.p3d",[8251.4,10155,29.2757],[[0,1,0],[0,0,1]],0,0,2,[],{}],
		["Land_SCF_01_chimney_F","a3\structures_f_exp\industrial\sugarcanefactory_01\scf_01_chimney_f.p3d",[8164.7,10080.4,59.1227],[[0,1,0],[0,0,1]],0,0,2,[],{
			_chimney = _this select 0;
			missionNamespace setVariable [
				'QS_setFeatureType',
				((missionNamespace getVariable 'QS_setFeatureType') + [[_chimney,2]]),
				TRUE
			];
			_fire = createVehicle ['test_EmptyObjectForFireBig',[0,0,0],[],0,'CAN_COLLIDE'];
			_fire allowDamage FALSE;
			missionNamespace setVariable [
				'QS_setFeatureType',
				((missionNamespace getVariable 'QS_setFeatureType') + [[_fire,2]]),
				TRUE
			];			
			missionNamespace setVariable ['QS_torch',_fire,TRUE];
			_fire enableDynamicSimulation FALSE;
			_fire setVariable ['QS_dynSim_ignore',TRUE,TRUE];
			_fire attachTo [_chimney,[0,0,0]];
			_fire spawn {
				uiSleep 0.1;
				detach _this;
			};
		}],
		["Land_WoodenShelter_01_F","a3\structures_f_exp\commercial\market\woodenshelter_01_f.p3d",[7964.41,9622.5,32.0698],[[-0.404211,0.914666,0],[0,0,1]],0,0,2,[],{}],
		["Land_CampingTable_small_F","a3\structures_f\civ\camping\campingtable_small_f.p3d",[7964.46,9622.49,31.3613],[[0.400129,-0.91644,0.00586021],[0,0.0063944,0.99998]],0,0,2,[],{}],
		["Land_FirstAidKit_01_closed_F","a3\props_f_orange\humanitarian\camps\firstaidkit_01_closed_f.p3d",[7964.46,9622.46,31.9481],[[-0.421875,0.906636,-0.00578905],[0,0.00638507,0.99998]],0,0,2,[],{}],
		["Land_HBarrier_Big_F","a3\structures_f\mil\fortification\hbarrier_big_f.p3d",[7950.15,10180,30.83],[[0.998986,-0.0450114,0],[0,0,1]],0,0,2,[],{}],
		["Land_HBarrier_Big_F","a3\structures_f\mil\fortification\hbarrier_big_f.p3d",[7953.59,10185.4,30.83],[[0.0243486,0.999704,0],[0,0,1]],0,0,2,[],{}],
		["Land_HBarrier_Big_F","a3\structures_f\mil\fortification\hbarrier_big_f.p3d",[7953.49,10174.6,30.8303],[[0.00965472,0.999953,-0.000690502],[0,0.000690534,1]],0,0,2,[],{}],
		["Land_HBarrier_Big_F","a3\structures_f\mil\fortification\hbarrier_big_f.p3d",[7962.14,10174.6,30.8303],[[0.0332453,0.999447,-0.000690152],[0,0.000690534,1]],0,0,2,[],{}],
		["Land_HBarrier_Big_F","a3\structures_f\mil\fortification\hbarrier_big_f.p3d",[7962.12,10185.4,30.83],[[0.0249526,0.999689,0],[0,0,1]],0,0,2,[],{}],
		["Land_HBarrier_5_F","a3\structures_f\mil\fortification\hbarrier_5_f.p3d",[7966.84,10183.4,30.3603],[[0.999798,-0.0200858,-0.000756378],[0.00077204,0.00077204,0.999999]],0,0,2,[],{}],
		
		["Land_HBarrier_Big_F","a3\structures_f\mil\fortification\hbarrier_big_f.p3d",[7949.76,10025.9,30.18],[[0.999887,-0.0150096,0],[0,0,1]],0,0,2,[],{}],
		["Land_HBarrier_Big_F","a3\structures_f\mil\fortification\hbarrier_big_f.p3d",[7953.04,10031.4,30.18],[[-0.00566539,0.999984,0],[0,0,1]],0,0,2,[],{}],
		["Land_HBarrier_Big_F","a3\structures_f\mil\fortification\hbarrier_big_f.p3d",[7953.27,10020.6,30.18],[[-0.0203601,0.999793,0],[0,0,1]],0,0,2,[],{}],
		["Land_HBarrier_Big_F","a3\structures_f\mil\fortification\hbarrier_big_f.p3d",[7961.92,10020.8,30.18],[[0.00323498,0.999995,0],[0,0,1]],0,0,2,[],{}],
		["Land_HBarrier_Big_F","a3\structures_f\mil\fortification\hbarrier_big_f.p3d",[7961.57,10031.6,30.18],[[-0.00506125,0.999987,0],[0,0,1]],0,0,2,[],{}],
		["Land_New_WiredFence_10m_F","a3\structures_f\walls\new_wiredfence_10m_f.p3d",[7965.86,10026.3,30.1839],[[0.999785,-0.0207503,0],[0,0,1]],0,0,2,[],{}],
		
		["Land_LampShabby_F","a3\structures_f\civ\lamps\lampshabby_f.p3d",[7965.87,10184.2,33.392],[[-0.816656,-0.577124,0],[0,0,1]],0,1,0,[],{(missionNamespace getVariable 'QS_lamps') pushBack (_this select 0);}],
		["Land_LampShabby_F","a3\structures_f\civ\lamps\lampshabby_f.p3d",[7964.9,10030.4,33.742],[[-0.816656,-0.577124,0],[0,0,1]],0,1,0,[],{(missionNamespace getVariable 'QS_lamps') pushBack (_this select 0);}],
		["Land_LampShabby_F","a3\structures_f\civ\lamps\lampshabby_f.p3d",[8061.91,10284.3,33.436],[[-0.737302,0.675564,0],[0,0,1]],0,1,0,[],{(missionNamespace getVariable 'QS_lamps') pushBack (_this select 0);}],
		["Land_LampShabby_F","a3\structures_f\civ\lamps\lampshabby_f.p3d",[8061.11,10297.9,33.559],[[-0.938446,-0.345427,0],[0,0,1]],0,1,0,[],{(missionNamespace getVariable 'QS_lamps') pushBack (_this select 0);}],
		["Land_CncBarrier_stripes_F","a3\structures_f\walls\cncbarrier_stripes_f.p3d",[7967.36,9620.22,31.3562],[[0.405883,-0.913903,0.00626788],[0.00077204,0.00720106,0.999974]],0,0,2,[],{}],
		["Land_CncBarrier_stripes_F","a3\structures_f\walls\cncbarrier_stripes_f.p3d",[7969.73,9621.31,31.3464],[[0.405883,-0.913903,0.00626788],[0.00077204,0.00720106,0.999974]],0,0,2,[],{}],
		["Land_CncBarrier_stripes_F","a3\structures_f\walls\cncbarrier_stripes_f.p3d",[7972.11,9622.39,31.3368],[[0.405883,-0.913903,0.00626788],[0.00077204,0.00720106,0.999974]],0,0,2,[],{}],
		["Land_CncBarrier_stripes_F","a3\structures_f\walls\cncbarrier_stripes_f.p3d",[7974.48,9623.45,31.3273],[[0.405883,-0.913903,0.00626788],[0.00077204,0.00720106,0.999974]],0,0,2,[],{}],
		["Land_CncBarrier_stripes_F","a3\structures_f\walls\cncbarrier_stripes_f.p3d",[7976.83,9624.49,31.3168],[[0.405883,-0.913901,0.00667005],[0.00158221,0.00800089,0.999967]],0,0,2,[],{}],
		["Land_CncBarrier_stripes_F","a3\structures_f\walls\cncbarrier_stripes_f.p3d",[7954.46,9614.33,31.394],[[0.405883,-0.913906,0.005844],[0,0.0063944,0.99998]],0,0,2,[],{}],
		["Land_CncBarrier_stripes_F","a3\structures_f\walls\cncbarrier_stripes_f.p3d",[7956.83,9615.42,31.387],[[0.405883,-0.913906,0.005844],[0,0.0063944,0.99998]],0,0,2,[],{}],
		["Land_CncBarrier_stripes_F","a3\structures_f\walls\cncbarrier_stripes_f.p3d",[7959.21,9616.49,31.3801],[[0.405883,-0.913906,0.005844],[0,0.0063944,0.99998]],0,0,2,[],{}],
		["Land_CncBarrier_stripes_F","a3\structures_f\walls\cncbarrier_stripes_f.p3d",[7961.58,9617.55,31.3734],[[0.405883,-0.913906,0.005844],[0,0.0063944,0.99998]],0,0,2,[],{}],
		["Land_CncBarrier_stripes_F","a3\structures_f\walls\cncbarrier_stripes_f.p3d",[7963.93,9618.59,31.3667],[[0.405883,-0.913906,0.005844],[0,0.0063944,0.99998]],0,0,2,[],{}],
		["Land_CncBarrier_stripes_F","a3\structures_f\walls\cncbarrier_stripes_f.p3d",[7963.21,9596.45,31.4261],[[0.405883,-0.913925,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_stripes_F","a3\structures_f\walls\cncbarrier_stripes_f.p3d",[7965.58,9597.54,31.4257],[[0.405883,-0.913925,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_stripes_F","a3\structures_f\walls\cncbarrier_stripes_f.p3d",[7967.96,9598.62,31.4257],[[0.405883,-0.913925,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_stripes_F","a3\structures_f\walls\cncbarrier_stripes_f.p3d",[7970.33,9599.68,31.4257],[[0.405883,-0.913925,0],[0,0,1]],0,0,2,[],{}],
		["Land_CncBarrier_stripes_F","a3\structures_f\walls\cncbarrier_stripes_f.p3d",[7972.68,9600.72,31.4245],[[0.405883,-0.913924,0.00141117],[0,0.00154408,0.999999]],0,0,2,[],{}],
		["Land_CncBarrier_stripes_F","a3\structures_f\walls\cncbarrier_stripes_f.p3d",[7975.05,9601.81,31.4228],[[0.405883,-0.913924,0.00141117],[0,0.00154408,0.999999]],0,0,2,[],{}],
		["Land_CncBarrier_stripes_F","a3\structures_f\walls\cncbarrier_stripes_f.p3d",[7977.41,9602.9,31.421],[[0.405883,-0.913924,0.00141117],[0,0.00154408,0.999999]],0,0,2,[],{}],
		["Land_CncBarrier_stripes_F","a3\structures_f\walls\cncbarrier_stripes_f.p3d",[7979.8,9603.98,31.4193],[[0.405883,-0.913924,0.00141117],[0,0.00154408,0.999999]],0,0,2,[],{}],
		["Land_CncBarrier_stripes_F","a3\structures_f\walls\cncbarrier_stripes_f.p3d",[7982.17,9605.03,31.4176],[[0.405883,-0.913924,0.00141117],[0,0.00154408,0.999999]],0,0,2,[],{}],
		["Land_CncBarrier_stripes_F","a3\structures_f\walls\cncbarrier_stripes_f.p3d",[7984.52,9606.08,31.4135],[[0.405883,-0.913923,0.00187282],[0.00077204,0.00239208,0.999997]],0,0,2,[],{}],
		["PortableHelipadLight_01_red_F","a3\structures_f_heli\items\airport\portablehelipadlight_01_f.p3d",[7977.92,9624.49,31.0401],[[0,0.999968,-0.0080009],[0.00158221,0.00800089,0.999967]],0,1,0,[],{}],
		["PortableHelipadLight_01_red_F","a3\structures_f_heli\items\airport\portablehelipadlight_01_f.p3d",[7953.77,9613.3,31.1248],[[0,0.99998,-0.0063944],[0,0.0063944,0.99998]],0,1,0,[],{}],
		["PortableHelipadLight_01_red_F","a3\structures_f_heli\items\airport\portablehelipadlight_01_f.p3d",[7961.58,9596.58,31.1507],[[0,1,0],[0,0,1]],0,1,0,[],{}],
		["PortableHelipadLight_01_red_F","a3\structures_f_heli\items\airport\portablehelipadlight_01_f.p3d",[7985.23,9607.2,31.1349],[[0,0.999997,-0.00239208],[0.00077204,0.00239208,0.999997]],0,1,0,[],{}],
		["Land_PortableLight_double_F","a3\structures_f_epa\civ\constructions\portablelight_double_f.p3d",[7965.7,9625.17,32.0195],[[0,1,0],[0,0,1]],0,1,0,[],{(missionNamespace getVariable 'QS_lamps') pushBack (_this select 0);}],
		["Land_MedicalTent_01_white_IDAP_open_F","a3\structures_f_orange\humanitarian\camps\medicaltent_01_f.p3d",[8111.62,10075.3,30.7928],[[-0.99973,-0.0215362,0.00875965],[0.00879576,-0.00158215,0.99996]],0,0,1,[],{
		
		}],
		["Land_MedicalTent_01_floor_light_F","a3\structures_f_orange\humanitarian\camps\medicaltent_01_floor_light_f.p3d",[8111.71,10075.3,29.4174],[[-0.999528,-0.02944,0.00874538],[0.00879576,-0.00158215,0.99996]],0,0,2,[],{}],
		["Land_Stretcher_01_F","a3\props_f_orange\humanitarian\camps\stretcher_01_f.p3d",[8114.4,10073,29.5912],[[-0.0475992,0.998818,0.0098519],[0.0223931,-0.00879355,0.999711]],0,0,2,[],{}],
		["Land_Stretcher_01_F","a3\props_f_orange\humanitarian\camps\stretcher_01_f.p3d",[8112.19,10072.8,29.6348],[[-0.0476093,0.998824,0.00920454],[0.00879576,-0.00879542,0.999923]],0,0,2,[],{}],
		["Land_Stretcher_01_F","a3\props_f_orange\humanitarian\camps\stretcher_01_f.p3d",[8110.06,10072.7,29.6532],[[-0.0476093,0.998824,0.00920454],[0.00879576,-0.00879542,0.999923]],0,0,2,[],{}],
		["Land_Stretcher_01_F","a3\props_f_orange\humanitarian\camps\stretcher_01_f.p3d",[8111.7,10077.6,29.6683],[[-0.0476104,0.998853,0.00505773],[0.00559927,-0.00479651,0.999973]],0,0,2,[],{}],
		["Land_Stretcher_01_F","a3\props_f_orange\humanitarian\camps\stretcher_01_f.p3d",[8114.29,10077.5,29.6243],[[-0.0476017,0.99885,0.00574311],[0.0199947,-0.00479563,0.999789]],0,0,2,[],{}],
		["Land_FirstAidKit_01_closed_F","a3\props_f_orange\humanitarian\camps\firstaidkit_01_closed_f.p3d",[8111.77,10076.4,29.5994],[[0,0.999988,0.00479659],[0.00559927,-0.00479651,0.999973]],0,0,2,[],{}],
		["Land_FirstAidKit_01_open_F","a3\props_f_orange\humanitarian\camps\firstaidkit_01_open_f.p3d",[8107.45,10077.1,30.3362],[[0,0.999999,0.00158221],[0.00879576,-0.00158215,0.99996]],0,0,2,[],{}],
		["Land_CampingChair_V2_white_F","a3\structures_f\civ\camping\campingchair_v2_f.p3d",[8109.18,10076.8,29.9486],[[0.782703,-0.622345,-0.00786943],[0.00879576,-0.00158215,0.99996]],0,0,2,[],{}],
		["Land_CampingTable_white_F","a3\structures_f\civ\camping\campingtable_f.p3d",[8107.38,10077.7,29.871],[[0.999798,0.0181014,-0.00876569],[0.00879576,-0.00158215,0.99996]],0,0,2,[],{}],
		["Land_CampingTable_white_F","a3\structures_f\civ\camping\campingtable_f.p3d",[8108.74,10078.3,29.86],[[0.0183359,-0.99983,-0.00174323],[0.00879576,-0.00158215,0.99996]],0,0,2,[],{}],
		["Flag_IDAP_F","a3\structures_f\mil\flags\mast_asym_f.p3d",[8106.36,10071.6,33.4109],[[0,1,0],[0,0,1]],0,1,0,[],{}],
		["Land_LampShabby_F","a3\structures_f\civ\lamps\lampshabby_f.p3d",[8116.89,10079.9,33.1179],[[-0.859647,-0.510889,0],[0,0,1]],0,1,0,[],{(missionNamespace getVariable 'QS_lamps') pushBack (_this select 0);}],
		["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[8124.3,10132.9,35.3994],[[-0.475633,0.879644,0],[0,0,1]],0,1,0,[],{(missionNamespace getVariable 'QS_lamps') pushBack (_this select 0);}],
		["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[8123.94,10106,35.3488],[[0.756497,0.653997,0],[0,0,1]],0,1,0,[],{(missionNamespace getVariable 'QS_lamps') pushBack (_this select 0);}],
		["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[8142.85,10116.1,34.9779],[[0.71908,-0.694928,0],[0,0,1]],0,1,0,[],{(missionNamespace getVariable 'QS_lamps') pushBack (_this select 0);}],
		["Land_Hangar_F","a3\structures_f\ind\airport\hangar_f.p3d",[8068.54,9997.13,35.2021],[[-0.00282081,-0.999996,0],[0,0,1]],0,0,2,[],{}],
		["Land_CampingTable_small_F","a3\structures_f\civ\camping\campingtable_small_f.p3d",[8058.26,10015.4,30.4647],[[-0.973136,0.230231,0],[0,0,1]],0,0,2,[],{
			if (!((missionNamespace getVariable ['QS_missionConfig_carrierEnabled',0]) isEqualTo 0)) then {
				(_this select 0) hideObjectGlobal TRUE;
			};
		}],
		["Land_Laptop_unfolded_F","a3\structures_f\items\electronics\laptop_unfolded_f.p3d",[8058.24,10015.4,31.0285],[[-0.9131,0.407736,0],[0,0,1]],0,0,0,[],{
			missionNamespace setVariable ['QS_cas_laptop',(_this select 0),TRUE];
			if (!((missionNamespace getVariable ['QS_missionConfig_carrierEnabled',0]) isEqualTo 0)) then {
				(_this select 0) enableDynamicSimulation FALSE;
				(_this select 0) setVariable ['QS_dynSim_ignore',TRUE,TRUE];
				(_this select 0) hideObjectGlobal TRUE;
			};
		}],
		["Land_PortableGenerator_01_F","a3\props_f_exp\military\camps\portablegenerator_01_f.p3d",[8106.05,10133.1,29.9173],[[0,1,0.00077204],[0.00077204,-0.00077204,0.999999]],0,0,2,[],{}],
		["Land_TripodScreen_01_large_F","a3\props_f_exp\military\camps\tripodscreen_01_large_f.p3d",[8105.14,10133.3,30.5857],[[0.485414,-0.874284,-0.00104974],[0.00077204,-0.00077204,0.999999]],0,0,0,[],{
			missionNamespace setVariable ['QS_Billboard_02',(_this select 0),TRUE];
			(_this select 0) setObjectTextureGlobal [0,(selectRandom (missionNamespace getVariable ['QS_missionConfig_textures_billboard1',[]]))];
		}],
		["Land_AirConditioner_01_F","a3\props_f_orange\humanitarian\camps\airconditioner_01_folded_f.p3d",[8106.21,10077.8,30.0005],[[0,0.999999,0.00158221],[0.00879576,-0.00158215,0.99996]],0,0,2,[],{}],
		["Land_HelipadSquare_F","a3\structures_f\mil\helipads\helipadsquare_f.p3d",[7997.52,10228.3,29.5894],[[1,-6.39758e-007,-0.00077204],[0.00077204,0.00077204,0.999999]],0,0,0,[],{}],
		["Land_WoodenShelter_01_F","a3\structures_f_exp\commercial\market\woodenshelter_01_f.p3d",[7996.69,10240.8,31.0595],[[-0.0392301,0.99923,0],[0,0,1]],0,0,2,[],{}],
		["Land_CampingTable_small_F","a3\structures_f\civ\camping\campingtable_small_f.p3d",[7996.74,10240.7,30.3469],[[0.0347521,-0.996666,-0.0738123],[0.0359782,-0.0725614,0.996715]],0,0,2,[],{}],
		["Land_FirstAidKit_01_closed_F","a3\props_f_orange\humanitarian\camps\firstaidkit_01_closed_f.p3d",[7996.72,10240.7,30.9406],[[-0.0585643,0.995493,0.0745921],[0.0360741,-0.0725611,0.996711]],0,0,2,[],{}],
		["Land_PortableLight_double_F","a3\structures_f_epa\civ\constructions\portablelight_double_f.p3d",[7994.31,10243,31.2624],[[-0.365129,0.930957,0],[0,0,1]],0,1,0,[],{(missionNamespace getVariable 'QS_lamps') pushBack (_this select 0);}],
		["Land_LampHalogen_F","a3\structures_f\civ\lamps\lamphalogen_f.p3d",[8101.49,10035.3,35.1328],[[0.760673,0.649135,0],[0,0,1]],0,1,0,[],{(missionNamespace getVariable 'QS_lamps') pushBack (_this select 0);}],
		["Land_IntravenStand_01_2bags_F","a3\props_f_orange\humanitarian\camps\intravenstand_01_f.p3d",[8113.31,10072.4,30.3006],[[0.994013,0.107158,-0.0213229],[0.0223931,-0.00879355,0.999711]],0,0,2,[],{}],
		["Land_IntravenStand_01_2bags_F","a3\props_f_orange\humanitarian\camps\intravenstand_01_f.p3d",[8111.11,10072.3,30.3297],[[0.994224,0.107039,-0.0078041],[0.00879576,-0.00879542,0.999923]],0,0,2,[],{}],
		["Land_IntravenStand_01_2bags_F","a3\props_f_orange\humanitarian\camps\intravenstand_01_f.p3d",[8112.99,10078.3,30.3475],[[0.994064,0.107061,-0.0193667],[0.0199947,-0.00479563,0.999789]],0,0,2,[],{}],
		["Land_Pier_small_F","a3\structures_f\naval\piers\pier_small_f.p3d",[8524.27,10131.9,-4.95848],[[-0.871029,0.491232,0],[0,0,1]],0,0,2,[],{}],
		["Land_Pier_small_F","a3\structures_f\naval\piers\pier_small_f.p3d",[8546.66,10116,-4.9693],[[-0.871029,0.491232,0],[0,0,1]],0,0,2,[],{}],
		["Land_New_WiredFence_10m_F","a3\structures_f\walls\new_wiredfence_10m_f.p3d",[8113.8,10054.8,30.3927],[[-0.999825,-0.01869,0],[0,0,1]],0,0,2,[],{}],
		["Land_New_WiredFence_10m_F","a3\structures_f\walls\new_wiredfence_10m_f.p3d",[8113.64,10044.9,30.2778],[[-0.999124,0.0418369,0],[0,0,1]],0,0,2,[],{}],
		["Land_New_WiredFence_10m_F","a3\structures_f\walls\new_wiredfence_10m_f.p3d",[8108.79,10040.6,30.2937],[[0.0365101,0.999333,0],[0,0,1]],0,0,2,[],{}],
		["Land_New_WiredFence_5m_F","a3\structures_f\walls\new_wiredfence_5m_f.p3d",[8101.35,10040.8,30.3128],[[0,1,0],[0,0,1]],0,0,2,[],{}],
		["Land_New_WiredFence_10m_F","a3\structures_f\walls\new_wiredfence_10m_f.p3d",[8099.25,10045.5,30.5349],[[0.999437,0.0335548,0],[0,0,1]],0,0,2,[],{}],
		["Land_New_WiredFence_10m_F","a3\structures_f\walls\new_wiredfence_10m_f.p3d",[8099.27,10055.4,30.632],[[0.999636,-0.0269759,0],[0,0,1]],0,0,2,[],{}],
		["Land_New_WiredFence_10m_F","a3\structures_f\walls\new_wiredfence_10m_f.p3d",[8104.05,10059.8,30.5957],[[-0.0216466,-0.999766,0],[0,0,1]],0,0,2,[],{}],
		//["Land_TripodScreen_01_dual_v1_F","a3\props_f_exp\military\camps\tripodscreen_01_dual_v1_f.p3d",[8102.88,10118.3,30.3551],[[0.810759,0.585378,-0.00125188],[0.00154408,0,0.999999]],0,0,0,[],{missionNamespace setVariable ['QS_panel_support',(_this select 0),TRUE];}],
		["Land_New_WiredFence_10m_F","a3\structures_f\walls\new_wiredfence_10m_f.p3d",[8109.12,10057.8,30.4996],[[0,1,0],[0,0,1]],0,0,2,[],{}]
	]
};