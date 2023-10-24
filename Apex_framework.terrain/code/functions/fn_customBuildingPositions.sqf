/*/
File: fn_customBuildingPositions.sqf
Author:

	Quiksilver
	
Last Modified:

	24/10/2023 A3 2.14 by Quiksilver

Description:

	Custom Building Positions by type
	
Notes:

	Derive with worldToModel in the editor
	Generate (below) with modelToWorld
	QS_array = [];
	{
		QS_array pushBack (QS_building worldToModel _x);
	} forEach (QS_building buildingPos -1);
	copyToClipboard str QS_array;
___________________________________________________/*/

params ['_building','_buildingPositions'];
_type = toLowerANSI (typeOf _building);
_model = toLowerANSI ((getModelInfo _building) # 1);
if (isNil '_model') exitWith {
	[]
};
private _array = [];
if ((_type in ['land_cargo_hq_v1_f','land_cargo_hq_v2_f','land_cargo_hq_v3_f','land_cargo_hq_v4_f','land_medevac_hq_v1_f','land_research_hq_f']) || {(_model in [
	"a3\structures_f\mil\cargo\cargo_hq_v3_f.p3d",
	"a3\structures_f\mil\cargo\cargo_hq_v1_f.p3d",
	"a3\structures_f\mil\cargo\medevac_hq_v1_f.p3d",
	"a3\structures_f\mil\cargo\cargo_hq_v2_f.p3d",
	"a3\structures_f\research\research_hq_f.p3d",
	"a3\structures_f_exp\military\containerbases\cargo_hq_v4_f.p3d"
])}) exitWith {
	//comment 'Military Cargo HQ';
	_array = [
		[4.16016,1.31641,-0.747444],
		[-0.625,-1.65918,-0.747444],
		[0.173828,1.61084,-0.747444],
		[3.1582,-4.06543,-0.672279],
		[-2.79492,-2.16895,-3.27229],
		[2.56641,0.950195,-3.27228],
		[3.80859,5.54199,-3.15187],
		[1,3.57764,-3.27229]
	];
	{
		0 = _buildingPositions pushBack (_building modelToWorld _x);
	} count _array;
	_buildingPositions;
};
if ((_type in ['land_cargo_house_v1_f','land_cargo_house_v2_f','land_cargo_house_v3_f','land_cargo_house_v4_f','land_medevac_house_v1_f','land_research_house_v1_f']) || {(_model in [
	"a3\structures_f\mil\cargo\cargo_house_v1_f.p3d",
	"a3\structures_f\mil\cargo\cargo_house_v2_f.p3d",
	"a3\structures_f\mil\cargo\cargo_house_v3_f.p3d",
	"a3\structures_f_exp\military\containerbases\cargo_house_v4_f.p3d",
	"a3\structures_f\mil\cargo\medevac_house_v1_f.p3d",
	"a3\structures_f\research\research_house_v1_f.p3d"
])}) exitWith {
	//comment 'Military Cargo House';
	_array = [
		[-1.18359,2.7207,0.0402908],
		[1.06836,2.85547,0.0402832],
		[1.72461,1.16602,-0.0957489],
		[-0.199219,0.911133,-0.0957489]
	];
	{
		0 = _buildingPositions pushBack (_building modelToWorld _x);
	} count _array;
	_buildingPositions;
};
if ((_type in ['land_cargo_patrol_v1_f','land_cargo_patrol_v2_f','land_cargo_patrol_v3_f','land_cargo_patrol_v4_f']) || {(_model in [
	"a3\structures_f\mil\cargo\cargo_patrol_v1_f.p3d",
	"a3\structures_f\mil\cargo\cargo_patrol_v2_f.p3d",
	"a3\structures_f\mil\cargo\cargo_patrol_v3_f.p3d",
	"a3\structures_f_exp\military\containerbases\cargo_patrol_v4_f.p3d"
])}) exitWith {
	//comment 'Military Cargo Patrol';
	_array = [
		[1.16406,-0.665039,-0.559517],
		[-1.07617,-0.521484,-0.559525],
		[2.00977,0.941406,-0.763512],
		[-0.134766,-0.349609,-0.559517]
	];
	{
		0 = _buildingPositions pushBack (_building modelToWorld _x);
	} count _array;
	_buildingPositions;
};
if (_model in [
	"a3\structures_f\mil\cargo\cargo_tower_v1_f.p3d",
	"a3\structures_f\mil\cargo\cargo_tower_v2_f.p3d",
	"a3\structures_f\mil\cargo\cargo_tower_v3_f.p3d",
	"a3\structures_f_exp\military\containerbases\cargo_tower_v4_f.p3d",
	"a3\structures_f\mil\cargo\cargo_tower_v1_no1_f.p3d",
	"a3\structures_f\mil\cargo\cargo_tower_v1_no2_f.p3d",
	"a3\structures_f\mil\cargo\cargo_tower_v1_no3_f.p3d",
	"a3\structures_f\mil\cargo\cargo_tower_v1_no4_f.p3d",
	"a3\structures_f\mil\cargo\cargo_tower_v1_no5_f.p3d",
	"a3\structures_f\mil\cargo\cargo_tower_v1_no6_f.p3d",
	"a3\structures_f\mil\cargo\cargo_tower_v1_no7_f.p3d"
]) exitWith {
	if (!simulationEnabled _building) then {	/*/isSimpleObject/*/
		//comment 'Military Cargo Tower';
		_array = [
			[4.09033,1.19067,-7.79243],
			[-4.0459,2.32178,-3.74691],
			[-2.78857,4.94312,0.486113],
			[-4.73242,-0.895752,0.486113],
			[-4.44336,-4.62451,0.505337],
			[0.941895,-3.8042,3.1292],
			[6.38525,-0.653809,3.18517],
			[6.07178,4.13232,3.0979],
			[-6.22461,4.26807,3.19505],
			[-1.00195,-1.02295,3.1229],
			[2.54443,-3.65625,5.49744],
			[6.63037,-0.802734,5.49744],
			[1.56494,4.44653,5.60744],
			[-1.89453,5.64404,5.49744],
			[-4.57715,5.62402,5.49744],
			[-5.09229,-2.37524,5.49744],
			[-4.45752,-5.12988,5.55445],
			[-1.53174,-5.37207,5.49744]
		];
		_buildingPositions = [];
		{
			0 = _buildingPositions pushBack (_building modelToWorld _x);
		} count _array;
	};
	_buildingPositions;
};
if ((_type in ['land_hbarrier_01_wall_6_green_f']) || {(_model in [
	"a3\structures_f_exp\military\fortifications\hbarrier_01_wall_6_green_f.p3d"
])}) exitWith {
	//comment 'Hbarrier wall long green';
	_array = [
		[-2.1228,-0.0185547,1.299683],
		[-0.530273,0.0859375,1.261597],
		[0.804932,0.123047,1.241669],
		[2.17151,-0.32666,1.209991],
		[3.58435,-0.183594,1.266901]
	];
	{
		0 = _buildingPositions pushBack (_building modelToWorld _x);
	} count _array;
	_buildingPositions;
};
if ((_type in ['land_hbarrier_01_wall_corner_green_f']) || {(_model in [
	"a3\structures_f_exp\military\fortifications\hbarrier_01_wall_corner_green_f.p3d"
])}) exitWith {
	//comment 'Hbarrier wall corner green';
	_array = [
		[-0.837158,-0.185547,1.264481],
		[0.4375,-0.0874023,1.264359],
		[0.532959,-1.12207,1.203558]
	];
	{
		0 = _buildingPositions pushBack (_building modelToWorld _x);
	} count _array;
	_buildingPositions;
};
if ((_type in ['land_hbarrier_01_wall_4_green_f']) || {(_model in [
	"a3\structures_f_exp\military\fortifications\hbarrier_01_wall_4_green_f.p3d"
])}) exitWith {
	//comment 'Hbarrier wall short green';
	_array = [
		[-0.782227,-0.348633,1.276073],
		[0.551758,-0.201172,1.268616],
		[1.99414,-0.233398,1.268593]
	];
	{
		0 = _buildingPositions pushBack (_building modelToWorld _x);
	} count _array;
	_buildingPositions;
};
if ((_type in ['land_hbarrierwall6_f']) || {(_model in [
	"a3\structures_f\mil\fortification\hbarrierwall6_f.p3d"
])}) exitWith {
	//comment 'Hbarrier wall long brown';
	_array = [
		[-2.12573,-0.18457,1.270451],
		[-0.697021,0.0532227,1.259338],
		[0.603027,-0.00195313,1.260811],
		[2.09021,-0.15918,1.247463],
		[3.53076,-0.11084,1.259126]
	];
	{
		0 = _buildingPositions pushBack (_building modelToWorld _x);
	} count _array;
	_buildingPositions;
};
if ((_type in ['land_hbarrierwall_corner_f']) || {(_model in [
	"a3\structures_f\mil\fortification\hbarrierwall_corner_f.p3d"
])}) exitWith {
	//comment 'Hbarrier wall corner brown';
	_array = [
		[-0.805786,-0.28125,1.247017],
		[0.338989,0.0161133,1.265213],
		[0.381104,-1.13184,1.265305]
	];
	{
		0 = _buildingPositions pushBack (_building modelToWorld _x);
	} count _array;
	_buildingPositions;
};
if ((_type in ['land_hbarrierwall4_f']) || {(_model in [
	"a3\structures_f\mil\fortification\hbarrierwall4_f.p3d"
])}) exitWith {
	//comment 'Hbarrier wall short brown';
	_array = [
		[-0.799438,-0.300293,1.268677],
		[0.68689,0.00976563,1.26947],
		[2.00696,0.0830078,1.273712]
	];
	{
		0 = _buildingPositions pushBack (_building modelToWorld _x);
	} count _array;
	_buildingPositions;
};
if ((_type in ['land_hbarrier_01_big_tower_green_f']) || {(_model in [
	"a3\structures_f_exp\military\fortifications\hbarrier_01_big_tower_green_f.p3d"
])}) exitWith {
	//comment 'Hbarrier watchtower green';
	_array = [
		[0.493286,-1.5415,2.39154],
		[-0.590088,-1.88867,2.4043],
		[-0.0412598,1.19531,2.35095]
	];
	{
		0 = _buildingPositions pushBack (_building modelToWorld _x);
	} count _array;
	_buildingPositions;
};
if ((_type in ['land_hbarriertower_f']) || {(_model in [
	"a3\structures_f\mil\fortification\hbarriertower_f.p3d"
])}) exitWith {
	//comment 'Hbarrier watchtower brown';
	_array = [
		[0.87085,-1.77588,2.19548],
		[-0.746216,-1.89111,2.19724],
		[-0.324951,0.769531,2.18361]
	];
	{
		0 = _buildingPositions pushBack (_building modelToWorld _x);
	} count _array;
	_buildingPositions;
};
if ((_type in ['land_hbarrier_01_tower_green_f']) || {(_model in [
	"a3\structures_f_exp\military\fortifications\hbarrier_01_tower_green_f.p3d"
])}) exitWith {
	//comment 'Hbarrier bunker green';
	_array = [
		[-0.256714,-1.99414,-2.28195],
		[1.35254,1.3584,-2.37676],
		[-1.02039,1.66992,-2.34528],
		[-0.654663,-2.49219,-2.26217],
		[0.492676,-0.804199,-2.28545],
		[-1.05884,2.47852,-2.38037],
		[1.00623,2.35645,-2.41139]
	];
	{
		0 = _buildingPositions pushBack (_building modelToWorld _x);
	} count _array;
	_buildingPositions;
};
if ((_type in ['land_bagbunker_tower_f']) || {(_model in [
	"a3\structures_f\mil\bagbunker\bagbunker_tower_f.p3d"
])}) exitWith {
	//comment 'Hbarrier bunker brown';
	_array = [
		[0.429688,2.15332,-2.31577],
		[-0.80188,0.628418,-2.2505],
		[0.286987,-2.2085,-2.10625],
		[-0.777954,-2.5498,-2.14998],
		[0.601807,-1.53613,2.12022],
		[-1.25708,1.50537,2.30163],
		[1.2948,2.0249,2.26427],
		[0.136353,0.00830078,3.21541]
	];
	{
		0 = _buildingPositions pushBack (_building modelToWorld _x);
	} count _array;
	_buildingPositions;
};
if ((_type in ['land_pillboxbunker_01_big_f']) || {(_model in [
	"a3\structures_f_exp\military\pillboxes\pillboxbunker_01_big_f.p3d"
])}) exitWith {
	//comment 'Big pillbox';
	_array = [
		[-2.85889,6.88379,-0.636113],
		[2.68164,6.84692,-0.636113],
		[2.24316,-0.822266,-0.636113],
		[-1.771,-1.56836,1.15505],
		[0.0737305,1.43286,1.57259],
		[-1.92578,5.98413,2.20215]
	];
	{
		0 = _buildingPositions pushBack (_building modelToWorld _x);
	} count _array;
	_buildingPositions;
};
if ((_type in ['land_pillboxbunker_01_hex_f']) || {(_model in [
	"a3\structures_f_exp\military\pillboxes\pillboxbunker_01_hex_f.p3d"
])}) exitWith {
	//comment 'Hex pillbox';
	_array = [
		[-1.30615,-1.59546,-0.692594],
		[-2.96631,-1.45654,-0.692843],
		[-3.74805,-0.0439453,-0.693053],
		[-2.9248,1.44849,-0.692823],
		[-1.28662,1.41992,-0.693115]
	];
	{
		0 = _buildingPositions pushBack (_building modelToWorld _x);
	} count _array;
	_buildingPositions;
};
if ((_type in ['land_pillboxbunker_01_rectangle_f']) || {(_model in [
	"a3\structures_f_exp\military\pillboxes\pillboxbunker_01_rectangle_f.p3d"
])}) exitWith {
	//comment 'Hex pillbox';
	_array = [
		[-0.808105,-0.687012,0.318469],
		[-3.02246,-2.47461,0.370508],
		[-2.53955,2.4585,0.370508],
		[-0.99707,2.49658,0.370508]
	];
	{
		0 = _buildingPositions pushBack (_building modelToWorld _x);
	} count _array;
	_buildingPositions;
};
if ((_type in ['land_bagbunker_01_large_green_f']) || {(_model in [
	"a3\structures_f_exp\military\fortifications\bagbunker_01_large_green_f.p3d"
])}) exitWith {
	//comment 'Large green bunker';
	_array = [
		[-0.664551,3.20801,-0.787395],
		[-3.44629,0.798096,-0.787395],
		[-3.53613,3.1084,-0.787395],
		[-3.69482,-2.60596,-0.787395],
		[-2.08887,-0.0395508,-0.787395],
		[-3.5874,-3.93774,-0.787395],
		[-0.755371,-4.19507,-0.787395],
		[0.744629,-4.22437,-0.787395],
		[3.49561,-4.22314,-0.787395],
		[1.13818,0.77832,-0.787395],
		[3.61133,-2.12769,-0.787395],
		[3.3291,0.733643,-0.787395],
		[3.62939,2.73584,-0.787395]
	];
	{
		0 = _buildingPositions pushBack (_building modelToWorld _x);
	} count _array;
	_buildingPositions;
};
if ((_type in ['land_bagbunker_large_f']) || {(_model in [
	"a3\structures_f\mil\bagbunker\bagbunker_large_f.p3d"
])}) exitWith {
	//comment 'Large bunker';
	_array = [
		[-0.664551,3.20801,-0.655681],
		[-3.44629,0.798096,-0.655681],
		[-3.53613,3.1084,-0.655681],
		[-3.69482,-2.60596,-0.655681],
		[-2.08887,-0.0395508,-0.655681],
		[-3.5874,-3.93774,-0.655681],
		[-0.755371,-4.19507,-0.655681],
		[0.744629,-4.22437,-0.655681],
		[3.49561,-4.22314,-0.655681],
		[1.13818,0.77832,-0.655681],
		[3.61133,-2.12769,-0.655681],
		[3.3291,0.733643,-0.655681],
		[3.62939,2.73584,-0.655681]
	];
	{
		0 = _buildingPositions pushBack (_building modelToWorld _x);
	} count _array;
	_buildingPositions;
};
if ((_type in ['land_bagbunker_01_small_green_f']) || {(_model in [
	"a3\structures_f_exp\military\fortifications\bagbunker_01_small_green_f.p3d"
])}) exitWith {
	//comment 'Small green bunker';
	_array = [
		[-0.0742188,1.17383,-0.982835],
		[-0.857422,-1.17651,-0.982835],
		[0.878906,-1.15332,-0.982835]
	];
	{
		0 = _buildingPositions pushBack (_building modelToWorld _x);
	} count _array;
	_buildingPositions;
};
if ((_type in ['land_bagbunker_small_f']) || {(_model in [
	"a3\structures_f\mil\bagbunker\bagbunker_small_f.p3d"
])}) exitWith {
	//comment 'Small bunker';
	_array = [
		[-0.0742188,1.17383,-0.879961],
		[-0.857422,-1.17651,-0.879961],
		[0.878906,-1.15332,-0.879961]
	];
	{
		0 = _buildingPositions pushBack (_building modelToWorld _x);
	} count _array;
	_buildingPositions;
};
if ((_type in ['land_bunker_01_blocks_3_f']) || {(_model in [
	"a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d"
])}) exitWith {
	//comment 'Malden stone bunker wall';
	if (isSimpleObject _building) then {
		_array = [
			[-1.75586,-1.81006,-0.158836],
			[-0.132324,-1.7793,-0.158836],
			[1.62354,-1.70215,-0.158836]
		];
	} else {
		_array = [
			[-1.84375,-1.75293,-0.158836],
			[-0.108887,-1.67822,-0.158836],
			[1.71191,-1.57617,-0.158836]
		];
	};
	{
		0 = _buildingPositions pushBack (_building modelToWorld _x);
	} count _array;
	_buildingPositions;	
};
if ((_type in ['land_bunker_01_hq_f']) || {(_model in [
	"a3\structures_f_argo\military\bunkers\bunker_01_hq_f.p3d"
])}) exitWith {
	//comment 'Malden stone bunker hq';
	if (isSimpleObject _building) then {
		_array = [
			[4.07617,3.84473,-1.11057],
			[0.881348,4.08643,-1.11057],
			[-1.36621,4.10449,-1.11057],
			[-3.54834,4.23975,-1.11057],
			[-4.19678,1.29443,-1.11057],
			[-4.09717,-1.63379,-1.11057],
			[-4.11182,0.106445,-1.11057],
			[-1.82568,-1.7666,-1.11057],
			[-2.12158,0.923828,-1.11057],
			[1.54883,2.24219,-1.11057],
			[1.47021,-0.00683594,-1.11057],
			[2.15918,-1.771,-1.1102],
			[0.0141602,-2.40771,-1.11057],
			[4.2373,1.78809,-1.11057],
			[4.37939,-0.52002,-1.11057],
			[4.07617,-3.95361,-1.11057],
			[1.92041,-4.1377,-1.11057],
			[-4.08057,-3.48633,-1.11057],
			[-1.79346,-3.90674,-1.11057]
		];
	} else {
		_array = [
			[2.46924,4.104,-1.11057],
			[-0.114746,4.16016,-1.11057],
			[-1.7915,4.26953,-1.11057],
			[-3.75049,4.18506,-1.11057],
			[-4.18213,1.0918,-1.11057],
			[-4.27051,-1.03076,-1.11057],
			[-1.3208,-1.61523,-1.11057],
			[-1.37891,1.53027,-1.11057],
			[1.79395,1.88916,-1.11057],
			[2.03076,-1.67139,-1.11061],
			[1.81055,0.833008,-1.11057],
			[4.32959,2.12842,-1.11043],
			[4.4165,-0.428711,-1.11057],
			[4.06787,-3.92773,-1.11057],
			[1.56445,-4.14746,-1.11057],
			[-3.63428,-3.67969,-1.11057]
		];
	};
	{
		0 = _buildingPositions pushBack (_building modelToWorld _x);
	} count _array;
	_buildingPositions;	
};
if ((_type in ['land_bunker_01_big_f']) || {(_model in [
	"a3\structures_f_argo\military\bunkers\bunker_01_big_f.p3d"
])}) exitWith {
	//comment 'Malden stone bunker';
	if (isSimpleObject _building) then {
		_array = [
			[4.05322,1.35059,-0.102413],
			[1.63135,1.35547,-0.102427],
			[-0.660156,1.39209,-0.102427],
			[-3.36133,1.34375,-0.102427],
			[-1.35449,-1.39697,-0.102427],
			[-3.5127,-1.27246,-0.102427],
			[-3.69629,-3.46484,-0.102427],
			[-3.73584,-5.97119,-0.102427],
			[-1.99463,-6.05762,-0.102427],
			[1.17871,-6.2959,-0.102427],
			[3.70752,-6.12695,-0.102427],
			[3.94287,-3.3501,-0.102427],
			[3.97607,-1.25635,-0.102427],
			[1.7583,-1.16797,-0.102427],
			[1.56494,-2.67676,-0.102427],
			[-1.70996,-2.60059,-0.102427]
		];
	} else {
		_array = [
			[4.00781,1.01807,-0.102376],
			[1.00732,1.3374,-0.102427],
			[-2.06689,1.38184,-0.102427],
			[-3.9541,1.44336,-0.102427],
			[-3.67578,-1.21094,-0.102427],
			[-1.86475,-2.62207,-0.102427],
			[-3.80371,-5.85742,-0.102427],
			[-1.96924,-6.22461,-0.102427],
			[1.23486,-6.30908,-0.102427],
			[3.63037,-6.15869,-0.102427],
			[4.06787,-2.09277,-0.102427],
			[1.72412,-1.02246,-0.102427],
			[1.61865,-2.66846,-0.102427]
		];
	};
	{
		0 = _buildingPositions pushBack (_building modelToWorld _x);
	} count _array;
	_buildingPositions;	
};
if ((_type in ['land_sandbagbarricade_01_half_f']) || {(_model in [
	"a3\structures_f_argo\military\fortifications\sandbagbarricade_01_half_f.p3d"
])}) exitWith {
	//comment 'Malden stone bunker wall';
	_array = [
		[-0.140625,-1.94678,-0.667547]
	];
	{
		0 = _buildingPositions pushBack (_building modelToWorld _x);
	} count _array;
	_buildingPositions;	
};
if ((_type in ['land_sandbagbarricade_01_hole_f']) || {(_model in [
	"a3\structures_f_argo\military\fortifications\sandbagbarricade_01_hole_f.p3d"
])}) exitWith {
	//comment 'Malden stone bunker wall';
	_array = [
		[-0.0761719,-1.87988,-1.28429]
	];
	{
		0 = _buildingPositions pushBack (_building modelToWorld _x);
	} count _array;
	_buildingPositions;	
};
if ((_type in ['land_guardhouse_02_f','land_guardhouse_02_grey_f']) || {(_model in [
	"a3\structures_f_enoch\military\barracks\guardhouse_02_grey_f.p3d",
	"a3\structures_f_enoch\military\barracks\guardhouse_02_f.p3d"
])}) exitWith {
	//comment 'Livonia guard house';
	if (isSimpleObject _building) then {
		_array = [
			[-0.0488281,0.30011,-1.5513],
			[0.294922,-2.27106,-1.5513],
			[-0.975098,-3.35565,-1.5513],
			[3.91992,-1.75702,-1.5513],
			[2.85791,2.31146,-1.5513],
			[3.93262,3.36713,-1.5513],
			[-0.0361328,3.00732,-1.5513]
		];
	};
	{
		0 = _buildingPositions pushBack (_building modelToWorld _x);
	} count _array;
	_buildingPositions;	
};
if ((_type in ['land_barn_01_brown_f','land_barn_01_grey_f']) || {(_model in [
	'a3\structures_f_argo\industrial\agriculture\barn_01_brown_f.p3d',
	'a3\structures_f_argo\industrial\agriculture\barn_01_grey_f.p3d'
])}) exitWith {
	//comment 'Malden barn';
	if (isSimpleObject _building) then {
		_array = [
			[7.25488,-3.56445,-0.696281],
			[7.43262,3.59375,-0.696281],
			[4.84082,-3.96094,-0.696281],
			[4.85352,0.0507813,-0.696281],
			[-0.625,3.47266,-0.696281],
			[-1.26953,-3.50391,-0.696281],
			[-4.28711,-3.44922,-0.696281],
			[-3.03223,3.47266,-0.696281],
			[-7.34863,-2.39258,-0.715977],
			[-7.37598,0.695313,-0.734272],
			[4.99609,1.85938,-0.696281]
		];
	};
	{
		0 = _buildingPositions pushBack (_building modelToWorld _x);
	} count _array;
	_buildingPositions;	
};
if ((_type isKindOf 'cargoplatform_01_base_f') || {(_model in [
	'a3\structures_f_enoch\military\camps\cargoplatform_01_f.p3d'
])}) exitWith {
	_array = [
		[-1.48682,-1.68408,3.75333],
		[-1.59961,-0.0678711,3.75333],
		[-1.45264,1.60986,3.75333],
		[0.23877,1.5625,3.75333],
		[0.289795,-1.81055,3.75333],
		[1.78955,-1.93604,3.75333],
		[1.69263,-0.198242,3.75333],
		[1.67188,1.53906,3.75333]
	];
	{
		0 = _buildingPositions pushBack (_building modelToWorld _x);
	} count _array;
	_buildingPositions;
};
_buildingPositions;