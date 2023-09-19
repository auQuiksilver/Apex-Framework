/*/
File: QS_data_siteMortar.sqf
Author:

	Quiksilver
	
Last modified:

	23/11/2017 A3 1.78 by Quiksilver
	
Description:

	Site Mortar
__________________________________________________________________________/*/

if (worldName isEqualTo 'Tanoa') exitWith {
	[
		["O_G_Mortar_01_F",[-0.165039,0.672363,-0.0384655],360,[],true,true,false,{
			_mortar = _this # 0;
			_mortar setVariable ['QS_dynSim_ignore',TRUE,FALSE];
			_mortar enableDynamicSimulation FALSE;
			_mortar addEventHandler [
				'GetOut',
				{
					(_this # 0) setDamage [1,TRUE];
					(_this # 2) setDamage [1,TRUE];
				}
			];
			_mortar;
		}], 
		["Land_WoodenCrate_01_F",[-0.0512695,-1.37256,-0.000999928],88.9824,[],false,false,true,{}], 
		["Land_BagFence_01_short_green_F",[-0.074707,-2.05176,-0.000999928],0,[],false,false,true,{}],
		["Land_BagFence_01_round_green_F",[1.76563,-1.32617,-0.00130129],310.323,[],false,false,true,{}],
		["Land_BagFence_01_round_green_F",[-2.03516,-1.33008,-0.00130129],46.8084,[],false,false,true,{}],
		["Land_BagFence_01_short_green_F",[2.38086,0.674805,-0.000999928],88.984,[],false,false,true,{}],
		["Land_BagFence_01_short_green_F",[-2.62891,0.745605,-0.000999928],267.851,[],false,false,true,{}],
		["Land_BagFence_01_round_green_F",[1.77441,2.69678,-0.00130129],224.927,[],false,false,true,{}], 
		["Land_BagFence_01_round_green_F",[-2.12451,2.75977,-0.00130129],128.493,[],false,false,true,{}],
		["Land_BagFence_01_short_green_F",[-0.169434,3.46826,-0.000999928],0,[],false,false,true,{}]
	]
};
[
	["O_G_Mortar_01_F",[-0.399414,0.508301,-0.038465],360,[],true,true,false,{
		_mortar = _this # 0;
		_mortar setVariable ['QS_dynSim_ignore',TRUE,FALSE];
		_mortar enableDynamicSimulation FALSE;
		_mortar addEventHandler [
			'GetOut',
			{
				(_this # 0) setDamage [1,TRUE];
				(_this # 2) setDamage [1,TRUE];
			}
		];
		_mortar;
	}],
	["Land_WoodenCrate_01_F",[-0.285645,-1.53662,0],88.9819,[],false,false,true,{}],
	["Land_BagFence_Round_F",[1.84766,-1.60352,-0.00130129],305.957,[],false,false,true,{}],
	["Land_BagFence_Short_F",[2.12158,0.490723,-0.000999928],87.6073,[],false,false,true,{}],
	["Land_BagFence_Short_F",[-0.276855,-2.22754,-0.000999928],0,[],false,false,true,{}],
	["Land_BagFence_Round_F",[-2.3999,-1.72705,-0.00130129],45.5733,[],false,false,true,{}],
	["Land_BagFence_Short_F",[-2.91064,0.452148,-0.000999928],87.6073,[],false,false,true,{}],
	["Land_BagFence_Round_F",[1.77051,2.74268,-0.00130129],226.995,[],false,false,true,{}],
	["Land_BagFence_Short_F",[-0.393066,3.28271,-0.000999928],0,[],false,false,true,{}],
	["Land_BagFence_Round_F",[-2.65332,2.73633,-0.00130129],125.987,[],false,false,true,{}]
]