/*/
File: QS_data_ao.sqf
Author:

	Quiksilver
	
Last modified:

	17/01/2018 A3 1.80 by Quiksilver
	
Description:

	AO Data
	
	[AO display name,AO location,custom function name,building coef,water coef,0,0,defendenabled,reinforceInfantry,reinforceVehicle]
__________________________________________________________________________/*/

_worldName = worldName;
if (_worldName isEqualTo 'Altis') exitWith {
	[
		[
			0,
			[
				['Frini',[14592.6,20862.2,0],'QS_fnc_aoCustomize',0,0,0,0,1,1,1],
				['Rodopoli',[18841.3,16647.1,0],'QS_fnc_aoCustomize',0,0,0,0,1,1,1],
				['Alikampos',[11131.3,14561.8,0],'QS_fnc_aoCustomize',0,0,0,0,1,1,1],
				['Neochori',[12366.6,14522.6,0],'QS_fnc_aoCustomize',0,1,0,0,1,1,1],
				['Agios Dionysios',[9225.12,15832.7,0],'QS_fnc_aoCustomize',0,0,0,0,1,1,1],
				['Orino',[10435.3,17240.1,0],'QS_fnc_aoCustomize',0,0,0,0,1,1,1],
				['Frini Woodlands',[14160.4,22125.2,0],'QS_fnc_aoCustomize',0,1,0,0,1,1,1],
				['Athira',[14061.2,18762,0],'QS_fnc_aoCustomize',0,0,0,0,1,1,1],
				['Lakka',[12311.6,15726.5,0],'QS_fnc_aoCustomize',0,0,0,0,1,1,1],
				['Anthrakia',[16678.8,16019.2,0],'QS_fnc_aoCustomize',0,1,0,0,1,1,1],
				['Koroni',[11777.2,18313.4,0],'QS_fnc_aoCustomize',0,0,0,0,1,1,1]
			]
		],
		[
			1,
			[
				['Pyrsos',[9210.46,19245.6,0],'QS_fnc_aoCustomize',0,0,0,0,1,1,1],
				['Factory',[6176.12,16244.4,0],'QS_fnc_aoCustomize',0,0,0,0,1,1,1],
				['Syrta',[8632.13,18284.7,0],'QS_fnc_aoCustomize',0,0,0,0,1,1,1],
				['Aristi Turbines',[7157.33,21537.8,0],'QS_fnc_aoCustomize',0,1,0,0,1,1,1],
				['Dump',[5857.38,20086.1,0],'QS_fnc_aoCustomize',0,0,0,0,1,1,1],
				['Negades',[4812.92,15981.8,0],'QS_fnc_aoCustomize',0,1,0,0,1,1,1],
				['Abdera',[9519.41,20316,0],'QS_fnc_aoCustomize',0,0,0,0,1,1,1],
				['Kore',[7215.03,16510.2,0],'QS_fnc_aoCustomize',0,0,0,0,1,1,1],
				['Oreokastro',[4658.99,21372.8,0],'QS_fnc_aoCustomize',0,0,0,0,1,1,1],
				['Galati Outpost',[9958.98,19353.6,0],'QS_fnc_aoCustomize',0,0,0,0,1,1,1],
				['Fotia Turbines',[4059.06,19228.8,0],'QS_fnc_aoCustomize',0,1,0,0,1,1,1],
				/*/['Gori Refinery',[5411.99,17913.7,0],'QS_fnc_aoCustomize',0,0,0,0,1,1,1],/*/
				['Krya Nera',[10135.1,21912.4,0],'QS_fnc_aoCustomize',0,1,0,0,1,1,1],
				['Faros Turbines',[8444,23073.6,0],'QS_fnc_aoCustomize',0,1,0,0,1,1,1]
			]
		],
		[
			2,
			[
				['Sofia Radar Station',[25133,21835.6,0],'QS_fnc_aoCustomize',0,0,0,0,1,1,1],
				['Research Facility',[20948.4,19258.8,0],'QS_fnc_aoCustomize',0,1,0,0,1,1,1],
				['Molos',[27006.6,23292.7,0],'QS_fnc_aoCustomize',0,1,0,0,1,1,1],
				['Nidasos Woodlands',[23926.2,22597.7,0],'QS_fnc_aoCustomize',0,1,0,0,1,1,1],
				['Limni',[20901.9,14626.3,0],'QS_fnc_aoCustomize',0,1,0,0,1,1,1],
				['Paros',[20966.4,16968.8,0],'QS_fnc_aoCustomize',0,0,0,0,1,1,1],
				['Gatolia Solar Farm',[27076.5,21451.1,0],'QS_fnc_aoCustomize',0,1,0,0,1,1,1],
				['Sofia Powerplant',[25425.5,20339,0],'QS_fnc_aoCustomize',0,1,0,0,1,1,1],
				['Delfinaki Outpost',[23572.4,21102.6,0],'QS_fnc_aoCustomize',0,0,0,0,1,1,1]
			]
		],
		[
			3,
			[
				['Feres',[21688.6,7616.58,0],'QS_fnc_aoCustomize',0,1,0,0,1,1,1],
				['Chalkeia',[20275.4,11711.9,0],'QS_fnc_aoCustomize',0,0,0,0,1,1,1],
				['Charkia',[18152.6,15324.9,0],'QS_fnc_aoCustomize',0,0,0,0,1,1,1],
				['Didymos Turbines',[18731.3,10203.4,0],'QS_fnc_aoCustomize',0,0,0,0,1,1,1],
				['Dorida',[19402.1,13250,0],'QS_fnc_aoCustomize',0,0,0,0,1,1,1],
				['Faronaki',[16558.3,10857.8,0],'QS_fnc_aoCustomize',0,1,0,0,1,1,1],
				['Selakano Outpost',[20085.9,6731.95,0],'QS_fnc_aoCustomize',0,0,0,0,1,1,1],
				['Panagia',[20517.3,8867.35,0],'QS_fnc_aoCustomize',0,0,0,0,1,1,1]
			]
		],
		[
			4,
			[
				['Skopos Castle',[11207.8,8715.31,0],'QS_fnc_aoCustomize',0,0,0,0,1,1,1],
				['Zaros Power Station',[8259.75,10925.2,0],'QS_fnc_aoCustomize',0,1,0,0,1,1,1],
				['Zaros',[9048.96,11961,0],'QS_fnc_aoCustomize',0,0,0,0,1,1,1],
				['Eginio',[11565.7,7049.68,0],'QS_fnc_aoCustomize',0,1,0,0,1,1,1],
				['Panochori',[5096.04,11247.4,0],'QS_fnc_aoCustomize',0,0,0,0,1,1,1],
				['The Stadium',[5479.61,14988.7,0],'QS_fnc_aoCustomize',0,0,0,0,1,1,1],
				['Vikos Outpost',[12300.2,8875.71,0],'QS_fnc_aoCustomize',0,1,0,0,1,1,1],
				['Athanos',[4238.88,10789.7,0],'QS_fnc_aoCustomize',0,1,0,0,1,1,1],
				['South Kavala',[3704.8,12198.2,0],'QS_fnc_aoCustomize',0,1,0,0,1,1,1],
				['North Kavala',[4030.79,14149.2,0],'QS_fnc_aoCustomize',0,1,0,0,1,1,1],
				['Topolia',[7361.48,15438.3,0],'QS_fnc_aoCustomize',0,0,0,0,1,1,1],
				['Therisa',[10505.5,12264.2,0],'QS_fnc_aoCustomize',0,1,0,0,1,1,1]
			]
		]
	]
};
if (_worldName isEqualTo 'Tanoa') exitWith {
	[
		[
			0,
			[
				['Regina',[5222.53,8711.61,0],'QS_fnc_aoCustomize',1,1,0,0,1,1,1],
				['Saint-Julien',[5675.88,11261.2,0],'QS_fnc_aoCustomize',2,1,0,0,1,1,1],
				['Nicolet',[6510.67,12645.5,0],'QS_fnc_aoCustomize',2,1,0,0,1,1,1],
				['Saint-Paul',[8257.41,13379.5,0],'QS_fnc_aoCustomize',2,1,0,0,1,1,1],
				['La Rochelle',[9623.4,13300.7,0],'QS_fnc_aoCustomize',3,1,0,0,1,1,1],
				['La Rochelle Aerodrome',[11768.5,12801.6,0],'QS_fnc_aoCustomize',1,1,0,0,1,1,1],
				['Ravi-ta Island',[12708.6,14145.8,0],'QS_fnc_aoCustomize',1,1,0,0,0,0,0],
				['Blue Pearl Industrial Port',[13767.8,11696.5,0],'QS_fnc_aoCustomize',1,1,0,0,1,1,1],
				['Mont Tanoa',[10096.7,11792.6,0],'QS_fnc_aoCustomize',0,0,0,0,1,1,1],
				['Red Spring Surface Mine',[12002.3,10364.3,0],'QS_fnc_aoCustomize',0,0,0,0,1,1,1],
				['Vatukoulo',[14084.3,9945.03,0],'QS_fnc_aoCustomize',0,0,0,0,1,1,1],
				['Vagalala',[11038.2,9778.26,0],'QS_fnc_aoCustomize',1,0,0,0,1,1,1],
				['Tanouka',[8905.85,10192.9,0],'QS_fnc_aoCustomize',3,0,0,0,1,1,1],
				/*/['Lifou Power Plant',[7465.83,8551.94,0],'QS_fnc_aoCustomize',1,0,0,0,0,1,1],/*/ /*/Too close to base/*/
				['Kotomo',[10935.4,6286.21,0],'QS_fnc_aoCustomize',2,1,0,0,1,1,1],
				['Oumere',[12798.9,7453.29,0],'QS_fnc_aoCustomize',2,1,0,0,1,1,1],
				['Luganville',[13921.9,8394.79,0],'QS_fnc_aoCustomize',2,1,0,0,1,1,1],
				['Lumberyard',[9301.31,7572.97,0],'QS_fnc_aoCustomize',0,0,0,0,1,1,1],
				['Plantation',[11042.8,7945.96,0],'QS_fnc_aoCustomize',0,0,0,0,1,1,1],
				['West Tanouka',[7805.6,10590.4,0],'QS_fnc_aoCustomize',1,0,0,0,1,1,1]
			]
		],
		[
			1,
			[
				['Harcourt',[11239,5214.64,0],'QS_fnc_aoCustomize',2,1,0,0,1,1,1],
				['Losi',[10187.5,5012.03,0],'QS_fnc_aoCustomize',0,1,0,0,1,1,1],
				['Moddergat',[9353.84,4039.24,0],'QS_fnc_aoCustomize',1,1,0,0,1,1,1],
				['Blerick',[10358.5,2664,0],'QS_fnc_aoCustomize',1,1,0,0,1,1,1],
				['Lijnhaven',[11647,2780.15,0],'QS_fnc_aoCustomize',2,1,0,0,1,1,1],
				/*/['Taga',[12317.7,1836.12,0],'QS_fnc_aoCustomize',0,1,0,0,1,1,1],	not enough flat space/*/
				/*/['Bua Bua',[13273.7,2945.84,0],'QS_fnc_aoCustomize',0,1,0,0,1,1,1],	not enough flat space/*/
				['Doodstil',[12816.4,4769.52,0],'QS_fnc_aoCustomize',1,1,0,0,1,1,1]
			]
		],
		[
			2,
			[
				['Savaka',[6872.22,4248.95,0],'QS_fnc_aoCustomize',0,1,0,0,1,1,1],
				['Katkoula',[5488.15,4071.88,0],'QS_fnc_aoCustomize',2,1,0,0,1,1,1],
				['Lailai',[3623.34,2167.6,0],'QS_fnc_aoCustomize',0,1,0,0,1,1,1],
				['Yanukka',[3158.66,3441,0],'QS_fnc_aoCustomize',1,1,0,0,1,1,1],
				['Imuri Island',[1670.42,881.739,0],'QS_fnc_aoCustomize',0,1,0,0,0,0,0],
				['Bala Airstrip',[2074.75,3912.15,0],'QS_fnc_aoCustomize',0,1,0,0,1,1,1],
				['Namuvaka',[2800.72,5813.06,0],'QS_fnc_aoCustomize',0,1,0,0,1,1,1],
				['Balavu',[2579.1,7268.67,0],'QS_fnc_aoCustomize',1,1,0,0,1,1,1],
				['Tavu',[1040.01,7664.4,0],'QS_fnc_aoCustomize',1,1,0,0,1,1,1],
				['Sosovu Island',[2845.26,9193.73,0],'QS_fnc_aoCustomize',0,1,0,0,0,0,0]
			]
		],
		[
			3,
			[
				['Belfort',[3034.46,11275.3,0],'QS_fnc_aoCustomize',2,1,0,0,1,1,1],
				['Tuvanaka',[1846.75,11989.1,0],'QS_fnc_aoCustomize',2,1,0,0,1,1,1],
				['Oua-Oue',[5724.45,12289.7,0],'QS_fnc_aoCustomize',1,1,0,0,1,1,1],
				['Tuvanaka Airbase',[2135.22,13181.4,0],'QS_fnc_aoCustomize',0,1,0,0,1,1,1],
				['Camp Remnants',[3842.23,13695.4,0],'QS_fnc_aoCustomize',0,1,0,0,1,1,1],
				['Galili',[8113.42,11957.1,0],'QS_fnc_aoCustomize',0,1,0,0,1,1,1]
			]
		]
	]
};
if (_worldName isEqualTo 'Malden') exitWith {
	[
		[
			0,
			[
				['Old military base',[6089.62,10793.2,0],'QS_fnc_aoCustomize',1,1,0,0,1,1,1],
				['Radio Station',[7042.5,10104.2,0],'QS_fnc_aoCustomize',1,1,0,0,1,1,1],
				['Moray',[933.491,12078.6,0],'QS_fnc_aoCustomize',1,1,0,0,0,0,0],
				['Lolisse',[5543.27,11193.7,0],'QS_fnc_aoCustomize',1,1,0,0,1,1,1],
				['Wooded Valley',[5530.5,10005.7,0],'QS_fnc_aoCustomize',1,1,0,0,1,1,1],
				['Saint Louis',[7134.15,8965.27,0],'QS_fnc_aoCustomize',1,1,0,0,1,1,1],
				['Larche',[6029.41,8630.36,0],'QS_fnc_aoCustomize',1,1,0,0,1,1,1],
				['Mont Chauve',[5047.87,9098.88,0],'QS_fnc_aoCustomize',1,1,0,0,1,1,1],
				['Goisse',[3611.05,8487.62,0],'QS_fnc_aoCustomize',1,1,0,0,1,1,1],
				['Saint Jean',[4735.55,8141.12,0],'QS_fnc_aoCustomize',1,1,0,0,1,1,1],
				['La Trinite',[7242.78,7930.1,0],'QS_fnc_aoCustomize',1,1,0,0,1,1,1],
				['Dourdan',[7042.66,7130.03,0],'QS_fnc_aoCustomize',1,1,0,0,1,1,1],
				['Arudy',[5548.68,7019.2,0],'QS_fnc_aoCustomize',1,1,0,0,1,1,1],
				['La Pessagne',[3111.23,6371.96,0],'QS_fnc_aoCustomize',1,1,0,0,1,1,1],
				['Feas',[4371.53,6898.66,0],'QS_fnc_aoCustomize',1,1,0,0,1,1,1],
				['Houdan',[7120.14,6069.77,0],'QS_fnc_aoCustomize',1,1,0,0,1,1,1]
			]
		],
		[
			1,
			[
				['Island military base',[9754.7,3949.39,0],'QS_fnc_aoCustomize',1,1,0,0,0,0,0],
				['Le Port',[8251.1,3145.07,0],'QS_fnc_aoCustomize',1,1,0,0,1,1,1],
				['Chapoi',[5867.74,3523.77,0],'QS_fnc_aoCustomize',1,1,0,0,1,1,1],
				['Cancon',[5398.12,2790.64,0],'QS_fnc_aoCustomize',1,1,0,0,1,1,1],
				['Crossroads',[7918.63,4091.98,0],'QS_fnc_aoCustomize',1,1,0,0,1,1,1],
				['La Riviere',[3842.72,3240.45,0],'QS_fnc_aoCustomize',1,1,0,0,1,1,1],
				['Sainte Marie',[5379.19,4353.86,0],'QS_fnc_aoCustomize',1,1,0,0,1,1,1],
				['Faro',[1902.01,2156.16,0],'QS_fnc_aoCustomize',1,1,0,0,1,1,1],
				['Corton Woodland',[3173.67,5535.26,0],'QS_fnc_aoCustomize',1,1,0,0,1,1,1],
				['Eperon Valley',[4700.29,5674.06,0],'QS_fnc_aoCustomize',1,1,0,0,1,1,1],
				['Plateau',[5825.52,6345.95,0],'QS_fnc_aoCustomize',1,1,0,0,1,1,1],
				['Point Lookout',[11425.1,4368.71,0],'QS_fnc_aoCustomize',1,1,0,0,0,0,0],
				['Midi Valley',[6371.65,5361.49,0],'QS_fnc_aoCustomize',1,1,0,0,1,1,1],
				['Arette Hills',[2459.02,4346.19,0],'QS_fnc_aoCustomize',1,1,0,0,1,1,1]
			]
		]
	]
};
if (_worldName isEqualTo 'Stratis') exitWith {};
if (_worldName isEqualTo 'Enoch') exitWith {
	[
		[
			0,
			[
				['Lukow',[3543.5,11956,0],'QS_fnc_aoCustomize',1,0,0,0,1,1,1],
				['Branzow Military Base',[2102.43,11010.3,0],'QS_fnc_aoCustomize',1,0,0,0,1,1,1],
				['Bielawa',[1634.77,9569.02,0],'QS_fnc_aoCustomize',1,0,0,0,1,1,1],
				['Gliniska',[5063.05,9999.29,0],'QS_fnc_aoCustomize',1,0,0,0,1,1,1],
				['Sobotka',[6297.63,10247.6,0],'QS_fnc_aoCustomize',1,0,0,0,1,1,1],
				['Brena',[6511.11,11293.7,0],'QS_fnc_aoCustomize',1,0,0,0,1,1,1],
				['Kolembrody',[8431.23,12018,0],'QS_fnc_aoCustomize',1,0,0,0,1,1,1],
				['Nidek',[6075.37,8169.23,0],'QS_fnc_aoCustomize',1,0,0,0,1,1,1],
				['Radacz',[4038.24,7967.7,0],'QS_fnc_aoCustomize',1,0,0,0,1,1,1],
				['Topolin Farms',[1341.16,7904.08,0],'QS_fnc_aoCustomize',1,0,0,0,1,1,1]
			]
		],
		[
			1,
			[
				['Zalesie',[900.4,5474.43,0],'QS_fnc_aoCustomize',1,0,0,0,1,1,1],
				['Topolin',[1859.42,7156.54,0],'QS_fnc_aoCustomize',1,0,0,0,1,1,1],
				['Adamow',[3150.43,6819.21,0],'QS_fnc_aoCustomize',1,0,0,0,1,1,1],
				['Muratyn',[4555.1,6487.41,0],'QS_fnc_aoCustomize',1,0,0,0,1,1,1],
				['Lipina',[5996.71,6828.78,0],'QS_fnc_aoCustomize',1,0,0,0,1,1,1],
				['Huta',[5159.8,5511.28,0],'QS_fnc_aoCustomize',1,0,0,0,1,1,1],
				['Nadbor',[6149.1,4130.38,0],'QS_fnc_aoCustomize',1,0,0,0,1,1,1],
				//['Polana',[3283.81,2140.41,0],'QS_fnc_aoCustomize',1,0,0,0,1,1,1],
				['Swarog',[5087.63,2164.47,0],'QS_fnc_aoCustomize',1,0,0,0,1,1,1]
			]
		],
		[
			2,
			[
				['Grabin',[10846.9,11121.7,0],'QS_fnc_aoCustomize',1,0,0,0,1,1,1],
				['Tarnow',[9372.92,10685.6,0],'QS_fnc_aoCustomize',1,0,0,0,1,1,1],
				['Sitnik',[11495.7,9598.7,0],'QS_fnc_aoCustomize',1,0,0,0,1,1,1],
				['Borek',[9851.51,8498.16,0],'QS_fnc_aoCustomize',1,0,0,0,1,1,1],
				['Zapadlisko',[8147.45,8725.8,0],'QS_fnc_aoCustomize',1,0,0,0,1,1,1],
				['Radunin',[7341.45,6271.45,0],'QS_fnc_aoCustomize',1,0,0,0,1,1,1],
				['Lembork',[8761.65,6640.22,0],'QS_fnc_aoCustomize',1,0,0,0,1,1,1],
				['Karlin',[10252.3,6821.98,0],'QS_fnc_aoCustomize',1,0,0,0,1,1,1],
				['Power Plant',[11567.9,7090.72,0],'QS_fnc_aoCustomize',1,0,0,0,1,1,1],
				['Roztoka',[7705.89,5223.32,0],'QS_fnc_aoCustomize',1,0,0,0,1,1,1],
				['Wrzeszcz',[9098.17,4396.06,0],'QS_fnc_aoCustomize',1,0,0,0,1,1,1],
				['Gieraltow',[11306.3,4377.55,0],'QS_fnc_aoCustomize',1,0,0,0,1,1,1],
				['Dolnik',[11400.3,593.375,0],'QS_fnc_aoCustomize',1,0,0,0,1,1,1]
			]
		]
	]
};