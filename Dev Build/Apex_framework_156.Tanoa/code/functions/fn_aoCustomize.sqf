/*
File: fn_aoCustomize.sqf
Author: 

	Quiksilver

Last Modified:

	15/03/2016 A3 1.56 by Quiksilver

Description:

	AO Customizations
	
private _array = [];
{
	_array pushBack [(typeOf _x),((getModelInfo _x) # 1),(getPosWorld _x),[(vectorDir _x),(vectorUp _x)],0,0,2,[],{}];
} forEach (get3DENSelected 'object');
copyToClipboard str _array;



_array = [];
{
	_array pushBack (((get3DENSelected 'object') # 0) worldToModel _x);
} forEach (((get3DENSelected 'object') # 0) buildingPos -1);
copyToClipboard str _array;
____________________________________________________________________________*/

_aoName = toLower (_this # 0);
private _entities = [];
private _minefieldChance = 0.5;
if (worldName isEqualTo 'Altis') then {
	if (_aoName isEqualTo 'oreokastro') then {
		/*/ Scaffolding to get ontop of castle/*/
		private _composition = [
			["Land_Scaffolding_F","a3\structures_f\civ\constructions\scaffolding_f.p3d",[4875.92,21924.6,349.213],[[0.889129,-0.457657,0],[0,0,1]],0,0,2,[],{}]
		];
		_composition = [_composition] call (missionNamespace getVariable 'QS_fnc_createEntityComposition');
		{
			(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
		} forEach _composition;
		if ((random 1) > _minefieldChance) then {
			_entities = [[5308.09,21834.7,0],1,50,20,['APERSBoundingMine',0.25,'APERSMine',0.5,'ATMine',0],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
		if ((random 1) > _minefieldChance) then {
			_entities = [[5594.29,21042.9,0],1,50,20,['APERSBoundingMine',0.25,'APERSMine',0.5,'ATMine',0],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
	};
	if (_aoName isEqualTo 'research_facility') then {
		if ((random 1) > _minefieldChance) then {
			_entities = [[20353.3,18773,0],1,40,30,['APERSBoundingMine',0.25,'APERSMine',0.5,'ATMine',0.25],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
	};
	if (_aoName isEqualTo 'rodopoli') then {
		if ((random 1) > _minefieldChance) then {
			_entities = [[18293.7,16566.2,0],1,50,20,['APERSBoundingMine',0.25,'APERSMine',0.5,'ATMine',0],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
	};
	if (_aoName isEqualTo 'alikampos') then {
		if ((random 1) > _minefieldChance) then {
			_entities = [[10764.1,15007.7,0],1,30,15,['APERSBoundingMine',0.25,'APERSMine',0.5,'ATMine',0],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
			_entities = [[10655.8,14152.6,0],1,30,15,['APERSBoundingMine',0.25,'APERSMine',0.5,'ATMine',0],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
	};
	if (_aoName isEqualTo 'neochori') then {
		if ((random 1) > _minefieldChance) then {
			_entities = [[12441.3,15199.6,0],1,50,15,['APERSBoundingMine',0.25,'APERSMine',0.5,'ATMine',0],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
			_entities = [[12494.9,15194.5,0],1,40,20,['APERSBoundingMine',0.25,'APERSMine',0.5,'ATMine',0.25],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};	
	};
	if (_aoName isEqualTo 'agios_dionysios') then {
		if ((random 1) > _minefieldChance) then {
			_entities = [[9560.13,15741,0],1,50,20,['APERSBoundingMine',0.25,'APERSMine',0.5,'ATMine',0.25],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
	};
	if (_aoName isEqualTo 'orino') then {
		if ((random 1) > _minefieldChance) then {
			_entities = [[10811,17558.3,0],1,50,20,['APERSBoundingMine',0.25,'APERSMine',0.5,'ATMine',0.25],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
	};
	if (_aoName isEqualTo 'frini_woodlands') then {
		private _composition = [
			["Land_Barn_01_brown_F","a3\structures_f_argo\industrial\agriculture\barn_01_brown_f.p3d",[13889.5,21985.2,80.095],[[0.35138,-0.936233,0],[0,0,1]],0,0,2,[],{
				(_this # 0) animateSource ['Door_1_sound_source',1];
				(_this # 0) animateSource ['Door_2_sound_source',1];
			}],
			["Land_Barn_01_brown_F","a3\structures_f_argo\industrial\agriculture\barn_01_brown_f.p3d",[14294.5,22189,41.3312],[[-0.600543,-0.799592,0],[0,0,1]],0,0,2,[],{
				(_this # 0) animateSource ['Door_1_sound_source',1];
				(_this # 0) animateSource ['Door_2_sound_source',1];
			}],
			["Land_Cargo_Tower_V3_derelict_F","a3\structures_f_argo\military\containerbases\cargo_tower_v3_derelict_f.p3d",[14496.8,22165.7,91.7759],[[0,1,0],[0,0,1]],0,0,1,[],{
				(_this # 0) setVariable ['QS_cleanup_protected',TRUE,FALSE];
			}],
			["Land_Cargo_House_V3_derelict_F","a3\structures_f_argo\military\containerbases\cargo_house_v3_derelict_f.p3d",[14513.9,22183.1,86.7177],[[-0.479115,0.877752,0],[0,0,1]],0,0,1,[],{
				(_this # 0) setVariable ['QS_cleanup_protected',TRUE,FALSE];
			}],
			["Land_Cargo_House_V3_derelict_F","a3\structures_f_argo\military\containerbases\cargo_house_v3_derelict_f.p3d",[14528.5,22186.6,86.7993],[[0.00675863,0.999977,0],[0,0,1]],0,0,1,[],{
				(_this # 0) setVariable ['QS_cleanup_protected',TRUE,FALSE];
			}],
			["Land_Cargo_Patrol_V3_derelict_F","a3\structures_f_argo\military\containerbases\cargo_patrol_v3_derelict_f.p3d",[14540.4,22230.9,91.153],[[-0.970796,-0.239907,0],[0,0,1]],0,0,1,[],{
				(_this # 0) setVariable ['QS_cleanup_protected',TRUE,FALSE];
			}],
			["Land_Castle_01_tower_ruins_F","a3\structures_f\dominants\castle\castle_01_tower_ruins_f.p3d",[13756.9,22795.4,79.9172],[[0,1,0],[0,0,1]],0,0,1,[],{
				(_this # 0) setVariable ['QS_cleanup_protected',TRUE,FALSE];
			}]
		];
		_composition = [_composition] call (missionNamespace getVariable 'QS_fnc_createEntityComposition');
		{
			(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
		} forEach _composition;
	};
	if (_aoName isEqualTo 'lakka') then {
		if ((random 1) > _minefieldChance) then {
			_entities = [[12808,16632.1,0],1,50,25,['APERSBoundingMine',0.3,'APERSMine',0.3,'ATMine',0.3],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
	};
	if (_aoName isEqualTo 'anthrakia') then {
		if ((random 1) > _minefieldChance) then {
			_entities = [[17077.5,16346.5,0],1,50,20,['APERSBoundingMine',0.3,'APERSMine',0.3,'ATMine',0.3],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
		if ((random 1) > _minefieldChance) then {
			_entities = [[16519.7,16536.1,0],1,50,20,['APERSBoundingMine',0.25,'APERSMine',0.25,'ATMine',0.5],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
	};
	if (_aoName isEqualTo 'koroni') then {
		if ((random 1) > _minefieldChance) then {
			_entities = [[10815.3,17560,0],1,50,15,['APERSBoundingMine',0.5,'APERSMine',0.5,'ATMine',0],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
		if ((random 1) > _minefieldChance) then {
			_entities = [[10815.3,17560,0],1,50,25,['APERSBoundingMine',0.5,'APERSMine',0.5,'ATMine',0],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};	
	};
	if (_aoName isEqualTo 'factory') then {
		if ((random 1) > _minefieldChance) then {
			_entities = [[6906.87,15911.8,0],1,50,10,['APERSBoundingMine',0.25,'APERSMine',0.25,'ATMine',0.5],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
		if ((random 1) > 0) then {
			_entities = [[6673.27,16341.1,0],1,50,15,['APERSBoundingMine',0.333,'APERSMine',0.333,'ATMine',0.333],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
		if ((random 1) > 0) then {
			_entities = [[5441.72,15814.6,0],1,50,20,['APERSBoundingMine',0.5,'APERSMine',0.5,'ATMine',0],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
	};
	if (_aoName isEqualTo 'syrta') then {
		if ((random 1) > _minefieldChance) then {
			_entities = [[7853.57,18009.5,0],1,50,20,['APERSBoundingMine',0.5,'APERSMine',0.5,'ATMine',0],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
	};
	if (_aoName isEqualTo 'dump') then {
		private _composition = [
			["Land_Cargo_Tower_V3_derelict_F","a3\structures_f_argo\military\containerbases\cargo_tower_v3_derelict_f.p3d",[5977.24,20413.2,243.507],[[-0.989608,0.14379,0],[0,0,1]],0,0,2,[],{
				(_this # 0) setVariable ['QS_cleanup_protected',TRUE,FALSE];
			}],
			["Land_Barn_01_brown_F","a3\structures_f_argo\industrial\agriculture\barn_01_brown_f.p3d",[5843.22,20073.1,227.478],[[0.18753,0.982259,0],[0,0,1]],0,0,2,[],{
				(_this # 0) animateSource ['Door_1_sound_source',1];
				(_this # 0) animateSource ['Door_2_sound_source',1];
			}]
		];
		_composition = [_composition] call (missionNamespace getVariable 'QS_fnc_createEntityComposition');
		{
			(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
		} forEach _composition;
		if ((random 1) > _minefieldChance) then {
			_entities = [[5976.48,20410.9,0],1,30,25,['APERSBoundingMine',0,'APERSMine',1,'ATMine',0],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
	};
	if (_aoName isEqualTo 'kore') then {
		if ((random 1) > _minefieldChance) then {
			_entities = [[8156.98,16169.5,0],1,50,15,['APERSBoundingMine',0.5,'APERSMine',0.5,'ATMine',0],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
		if ((random 1) > _minefieldChance) then {
			_entities = [[7867.61,16660.2,0],1,50,15,['APERSBoundingMine',0.5,'APERSMine',0.5,'ATMine',0],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
	};
	if (_aoName isEqualTo 'fotia_turbines') then {
		private _composition = [
			["Land_i_Stone_House_Big_01_b_clay_F","a3\structures_f_argo\civilian\stone_house_big_01\i_stone_house_big_01_b_clay_f.p3d",[4163.37,19490.8,312.268],[[-0.613796,-0.789465,0],[0,0,1]],0,0,2,[],{}],
			["Land_Shed_08_brown_F","a3\structures_f_argo\industrial\agriculture\shed_08_brown_f.p3d",[4180.88,19466.8,311.907],[[0.586601,-0.809876,0],[0,0,1]],0,0,2,[],{}],
			["Land_Stone_Shed_01_b_clay_ruins_F","a3\structures_f_argo\civilian\stone_shed_01\stone_shed_01_b_clay_ruins_f.p3d",[4149.83,19424.1,303.216],[[-0.411329,-0.911487,0],[0,0,1]],0,0,2,[],{
				(_this # 0) setVariable ['QS_cleanup_protected',TRUE,FALSE];
			}]
		];
		_composition = [_composition] call (missionNamespace getVariable 'QS_fnc_createEntityComposition');
		{
			(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
		} forEach _composition;
		if ((random 1) > _minefieldChance) then {
			_entities = [[4167.48,19465.6,0],1,35,25,['APERSBoundingMine',0.25,'APERSMine',0.5,'ATMine',0],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};	
	};
	if (_aoName isEqualTo 'molos') then {
		if ((random 1) > _minefieldChance) then {
			_entities = [[26437.3,22576,0],1,50,25,['APERSBoundingMine',0.25,'APERSMine',0.5,'ATMine',0],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
		if ((random 1) > _minefieldChance) then {
			_entities = [[26271,23172.4,0],1,35,15,['APERSBoundingMine',0.25,'APERSMine',0.5,'ATMine',0],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};	
	};
	if (_aoName isEqualTo 'nidasos_woodlands') then {
		private _composition = [
			["Land_HBarrier_5_F","a3\structures_f\mil\fortification\hbarrier_5_f.p3d",[23980.9,22347,97.1982],[[0.490032,-0.837551,0.241612],[-0.170787,0.179553,0.96881]],0,0,2,[],{}],
			["Land_HBarrier_5_F","a3\structures_f\mil\fortification\hbarrier_5_f.p3d",[23977,22343.6,97.2246],[[0.779252,-0.545083,0.309277],[-0.24436,0.19017,0.950854]],0,0,2,[],{}],
			["Land_HBarrier_5_F","a3\structures_f\mil\fortification\hbarrier_5_f.p3d",[23976.6,22339,97.207],[[0.963221,0.124692,0.238028],[-0.235822,-0.0323736,0.971257]],0,0,2,[],{}],
			["Land_HBarrier_5_F","a3\structures_f\mil\fortification\hbarrier_5_f.p3d",[23990.1,22349.2,97.4868],[[-0.257747,-0.951958,0.165356],[0.00133721,0.170787,0.985307]],0,0,2,[],{}],
			["Land_HBarrier_5_F","a3\structures_f\mil\fortification\hbarrier_5_f.p3d",[23995,22347.1,97.6259],[[-0.469428,-0.862261,0.190114],[0.0850241,0.170169,0.98174]],0,0,2,[],{}],
			["Land_HBarrier_5_F","a3\structures_f\mil\fortification\hbarrier_5_f.p3d",[24000.6,22339.1,98.0552],[[-0.974183,-0.160106,0.159164],[0.154135,0.0434311,0.987095]],0,0,2,[],{}],
			["Land_HBarrier_5_F","a3\structures_f\mil\fortification\hbarrier_5_f.p3d",[24000.7,22334.1,98.0703],[[-0.977562,0.10392,0.183231],[0.166956,-0.148165,0.974768]],0,0,2,[],{}],
			["Land_HBarrier_5_F","a3\structures_f\mil\fortification\hbarrier_5_f.p3d",[23997.7,22325.8,97.204],[[0.93523,-0.304278,-0.180998],[0.133462,-0.170522,0.976274]],0,0,2,[],{}],
			["Land_HBarrier_5_F","a3\structures_f\mil\fortification\hbarrier_5_f.p3d",[23982.8,22318.4,98.767],[[0.254345,0.960345,0.114216],[-0.0159977,-0.113906,0.993363]],0,0,2,[],{}],
			["Land_HBarrier_5_F","a3\structures_f\mil\fortification\hbarrier_5_f.p3d",[23978.8,22321.1,98.715],[[0.794311,0.602079,-0.0810594],[-0.0160014,0.154117,0.987923]],0,0,2,[],{}],
			["Land_HBarrier_5_F","a3\structures_f\mil\fortification\hbarrier_5_f.p3d",[23977.4,22325.4,98.0171],[[0.987643,-0.0955775,0.124199],[-0.108686,0.153223,0.982197]],0,0,2,[],{}],
			["Land_HBarrier_Big_F","a3\structures_f\mil\fortification\hbarrier_big_f.p3d",[23986.3,22337.8,98.9649],[[0.934589,-0.354599,0.0283461],[-0.0559135,-0.0677373,0.996135]],0,0,2,[],{}],
			["Land_HBarrier_Big_F","a3\structures_f\mil\fortification\hbarrier_big_f.p3d",[23986.2,22329.1,98.5644],[[0.973193,-0.229363,0.0169441],[-0.0239937,-0.0279814,0.99932]],0,0,2,[],{}],
			["Land_HBarrier_5_F","a3\structures_f\mil\fortification\hbarrier_5_f.p3d",[23991.9,22315.6,97.186],[[0.376968,-0.89938,-0.221382],[0.141237,-0.180403,0.9734]],0,0,2,[],{}],
			["Land_HBarrier_3_F","a3\structures_f\mil\fortification\hbarrier_3_f.p3d",[23994.6,22317.8,96.9978],[[0.89646,-0.32427,-0.302009],[0.256459,-0.176135,0.950371]],0,0,2,[],{}],
			["Land_Mil_WallBig_4m_battered_F","a3\structures_f_argo\walls\military\mil_wallbig_4m_battered_f.p3d",[23992.5,22348.1,98.6224],[[-0.394112,-0.919062,0],[0,0,1]],0,0,2,[],{}],
			["Land_Mil_WallBig_4m_battered_F","a3\structures_f_argo\walls\military\mil_wallbig_4m_battered_f.p3d",[23978.6,22345.1,98.1594],[[0.676663,-0.736293,0],[0,0,1]],0,0,2,[],{}],
			["Land_Mil_WallBig_4m_battered_F","a3\structures_f_argo\walls\military\mil_wallbig_4m_battered_f.p3d",[23976.5,22340.4,98.1919],[[0.999626,0.0273335,0],[0,0,1]],0,0,2,[],{}],
			["Land_Mil_WallBig_4m_battered_F","a3\structures_f_argo\walls\military\mil_wallbig_4m_battered_f.p3d",[23978.7,22321,99.6852],[[0.844354,0.535786,0],[0,0,1]],0,0,2,[],{}],
			["Land_Mil_WallBig_4m_battered_F","a3\structures_f_argo\walls\military\mil_wallbig_4m_battered_f.p3d",[23997.6,22325.8,98.1739],[[-0.925764,0.378102,0],[0,0,1]],0,0,2,[],{}],
			["Land_Mil_WallBig_4m_battered_F","a3\structures_f_argo\walls\military\mil_wallbig_4m_battered_f.p3d",[24000.7,22337.5,99.066],[[-0.999964,-0.00853432,0],[0,0,1]],0,0,2,[],{}],
			["Land_HBarrier_3_F","a3\structures_f\mil\fortification\hbarrier_3_f.p3d",[23977.5,22334.8,97.3648],[[-0.915192,-0.388589,-0.106872],[-0.137353,0.0514378,0.989186]],0,0,2,[],{}],
			["Land_Mil_WallBig_4m_battered_F","a3\structures_f_argo\walls\military\mil_wallbig_4m_battered_f.p3d",[23977.1,22336.6,98.2258],[[0.946527,0.322626,0],[0,0,1]],0,0,2,[],{}],
			["Land_HBarrier_Big_F","a3\structures_f\mil\fortification\hbarrier_big_f.p3d",[23989.6,22333.7,98.8748],[[-0.124454,-0.990002,-0.0663825],[-0.0559135,-0.0597989,0.996643]],0,0,2,[],{}],
			["Land_HBarrier_Big_F","a3\structures_f\mil\fortification\hbarrier_big_f.p3d",[23991.2,22340,99.1311],[[-0.153324,-0.98817,0.00336564],[0.0133317,0.00133709,0.99991]],0,0,2,[],{}],
			["Land_Mil_WallBig_4m_battered_F","a3\structures_f_argo\walls\military\mil_wallbig_4m_battered_f.p3d",[24000.8,22333.7,98.9511],[[0.994553,-0.104233,0],[0,0,1]],0,0,2,[],{}],
			["Land_Barn_01_brown_F","a3\structures_f_argo\industrial\agriculture\barn_01_brown_f.p3d",[23582.6,22491.6,92.3842],[[0.904471,-0.426535,0],[0,0,1]],0,0,2,[],{
				(_this # 0) animateSource ['Door_1_sound_source',1];
				(_this # 0) animateSource ['Door_2_sound_source',1];			
			}],
			["Land_Barn_01_brown_F","a3\structures_f_argo\industrial\agriculture\barn_01_brown_f.p3d",[23967.4,22595.5,42.107],[[-0.844673,0.535283,0],[0,0,1]],0,0,2,[],{
				(_this # 0) animateSource ['Door_1_sound_source',1];
				(_this # 0) animateSource ['Door_2_sound_source',1];			
			}]
		];
		_composition = [_composition] call (missionNamespace getVariable 'QS_fnc_createEntityComposition');
		{
			(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
		} forEach _composition;
		if ((random 1) > _minefieldChance) then {
			_entities = [[23988.6,22331.8,0],1,15,25,['APERSBoundingMine',0,'APERSMine',0.333,'ATMine',0],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
	};
	if (_aoName isEqualTo 'limni') then {
		private _composition = [
			["Land_Barn_01_brown_F","a3\structures_f_argo\industrial\agriculture\barn_01_brown_f.p3d",[20658.5,14709.6,3.74639],[[-0.927484,0.373862,0],[0,0,1]],0,0,2,[],{
				(_this # 0) animateSource ['Door_1_sound_source',1];
				(_this # 0) animateSource ['Door_2_sound_source',1];			
			}],
			["Land_Barn_01_brown_F","a3\structures_f_argo\industrial\agriculture\barn_01_brown_f.p3d",[20904.1,14994,3.46615],[[-0.421271,0.906935,0],[0,0,1]],0,0,2,[],{
				(_this # 0) animateSource ['Door_1_sound_source',1];
				(_this # 0) animateSource ['Door_2_sound_source',1];			
			}],
			["Land_Barn_01_brown_F","a3\structures_f_argo\industrial\agriculture\barn_01_brown_f.p3d",[20975,14669.6,2.90874],[[-0.272384,0.962189,0],[0,0,1]],0,0,2,[],{
				(_this # 0) animateSource ['Door_1_sound_source',1];
				(_this # 0) animateSource ['Door_2_sound_source',1];			
			}]
		];
		_composition = [_composition] call (missionNamespace getVariable 'QS_fnc_createEntityComposition');
		{
			(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
		} forEach _composition;
		if ((random 1) > _minefieldChance) then {
			_entities = [[20029.1,14790.6,0],1,20,15,['APERSBoundingMine',0.333,'APERSMine',0.333,'ATMine',0.333],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
		if ((random 1) > _minefieldChance) then {
			_entities = [[19975.8,14770.5,0],1,35,15,['APERSBoundingMine',0.333,'APERSMine',0.333,'ATMine',0.333],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
		if ((random 1) > _minefieldChance) then {
			_entities = [[19939.8,14764.3,0],1,35,15,['APERSBoundingMine',0.333,'APERSMine',0.333,'ATMine',0.333],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
	};
	if (_aoName isEqualTo 'paros') then {
		if ((random 1) > _minefieldChance) then {
			_entities = [[20710.8,17192.4,0],1,30,15,['APERSBoundingMine',0.333,'APERSMine',0.333,'ATMine',0],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
	};
	if (_aoName isEqualTo 'gatolia_solar_farm') then {
		if ((random 1) > _minefieldChance) then {
			_entities = [[26578.7,21765.9,0],1,40,25,['APERSBoundingMine',0.333,'APERSMine',0.333,'ATMine',0],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
		if ((random 1) > _minefieldChance) then {
			_entities = [[26294.2,21722.4,0],1,30,15,['APERSBoundingMine',0.333,'APERSMine',0.333,'ATMine',0],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
	};
	if (_aoName isEqualTo 'sofia_powerplant') then {
		private _composition = [
			["Land_BagFence_Long_F","a3\structures_f\mil\bagfence\bagfence_long_f.p3d",[25398.3,20346.6,21.8939],[[0.567438,-0.823416,0],[0,0,1]],0,0,2,[],{}],
			["Land_BagFence_Long_F","a3\structures_f\mil\bagfence\bagfence_long_f.p3d",[25398.5,20348.7,21.8939],[[-0.806896,-0.590694,0],[0,0,1]],0,0,2,[],{}],
			["Land_BagFence_Long_F","a3\structures_f\mil\bagfence\bagfence_long_f.p3d",[25391.3,20358.7,21.8939],[[0.840597,0.541661,0],[0,0,1]],0,0,2,[],{}],
			["Land_BagFence_Long_F","a3\structures_f\mil\bagfence\bagfence_long_f.p3d",[25389.2,20358.9,21.8921],[[0.565417,-0.824805,0],[0,0,1]],0,0,2,[],{}],
			["Land_BagFence_Long_F","a3\structures_f\mil\bagfence\bagfence_long_f.p3d",[25376.4,20332.7,21.8453],[[-0.823815,-0.566859,0],[0,0,1]],0,0,2,[],{}],
			["Land_BagFence_Long_F","a3\structures_f\mil\bagfence\bagfence_long_f.p3d",[25378.5,20332.5,21.8939],[[-0.590126,0.807311,0],[0,0,1]],0,0,2,[],{}],
			["Land_BagFence_Long_F","a3\structures_f\mil\bagfence\bagfence_long_f.p3d",[25369.3,20344.9,21.9424],[[-0.60313,0.797643,0],[0,0,1]],0,0,2,[],{}],
			["Land_BagFence_Long_F","a3\structures_f\mil\bagfence\bagfence_long_f.p3d",[25369.3,20342.8,21.8939],[[0.780115,0.625637,0],[0,0,1]],0,0,2,[],{}],
			["Land_BagFence_Long_F","a3\structures_f\mil\bagfence\bagfence_long_f.p3d",[25372.8,20337.7,21.8939],[[-0.818492,-0.574518,0],[0,0,1]],0,0,2,[],{}],
			["Land_BagFence_Long_F","a3\structures_f\mil\bagfence\bagfence_long_f.p3d",[25394.9,20353.7,21.8939],[[-0.806896,-0.590694,0],[0,0,1]],0,0,2,[],{}],
			["Land_BagFence_Long_F","a3\structures_f\mil\bagfence\bagfence_long_f.p3d",[25388.8,20339.8,21.8939],[[-0.58904,0.808104,0],[0,0,1]],0,0,2,[],{}],
			["Land_BagFence_Long_F","a3\structures_f\mil\bagfence\bagfence_long_f.p3d",[25386.4,20338.2,21.8939],[[0.554254,-0.832347,0],[0,0,1]],0,0,2,[],{}]
		];
		_composition = [_composition] call (missionNamespace getVariable 'QS_fnc_createEntityComposition');
		{
			(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
		} forEach _composition;
		if ((random 1) > _minefieldChance) then {
			_entities = [[25437.3,19307.9,0],1,35,15,['APERSBoundingMine',0.333,'APERSMine',0.333,'ATMine',0],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
		if ((random 1) > _minefieldChance) then {
			_entities = [[26294.2,21722.4,0],1,20,20,['APERSBoundingMine',0,'APERSMine',0.333,'ATMine',0],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
	};
	if (_aoName isEqualTo 'delfinaki_outpost') then {
		if ((random 1) > _minefieldChance) then {
			_entities = [[22347.3,20782.8,0],1,20,20,['APERSBoundingMine',0.5,'APERSMine',0.5,'ATMine',0],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
	};
	if (_aoName isEqualTo 'feres') then {
		if ((random 1) > _minefieldChance) then {
			_entities = [[22377.8,8194.26,0],1,20,20,['APERSBoundingMine',0.5,'APERSMine',0.5,'ATMine',0],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};	
	};
	if (_aoName isEqualTo 'chalkeia') then {
		if ((random 1) > _minefieldChance) then {
			_entities = [[19669.1,11527.8,0],1,30,15,['APERSBoundingMine',0.5,'APERSMine',0.5,'ATMine',0],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
		if ((random 1) > _minefieldChance) then {
			_entities = [[20072.2,11982.5,0],1,30,15,['APERSBoundingMine',0.5,'APERSMine',0.5,'ATMine',0],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};	
	};
	if (_aoName isEqualTo 'charkia') then {
		if ((random 1) > _minefieldChance) then {
			_entities = [[17587.8,15351.6,0],1,15,10,['APERSBoundingMine',0.5,'APERSMine',0.5,'ATMine',0],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
	};
	if (_aoName isEqualTo 'didymos_turbines') then {
		private _composition = [
			["Land_Cargo_Tower_V3_derelict_F","a3\structures_f_argo\military\containerbases\cargo_tower_v3_derelict_f.p3d",[18698.1,10221.3,215.242],[[0.0380395,-0.999276,0],[0,0,1]],0,0,2,[],{
				(_this # 0) setVariable ['QS_cleanup_protected',TRUE,FALSE];
			}]
		];
		_composition = [_composition] call (missionNamespace getVariable 'QS_fnc_createEntityComposition');
		{
			(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
		} forEach _composition;
		_entities = [[18700.4,10220.2,0],1,15,10,['APERSBoundingMine',0.5,'APERSMine',0.5,'ATMine',0],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
		{
			(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
		} forEach _entities;
	};
	if (_aoName isEqualTo 'dorida') then {
		if ((random 1) > _minefieldChance) then {
			_entities = [[19322.3,12775.2,0],1,25,10,['APERSBoundingMine',0.5,'APERSMine',0.5,'ATMine',0],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
		if ((random 1) > _minefieldChance) then {
			_entities = [[18879.4,13990.7,0],1,25,10,['APERSBoundingMine',0.333,'APERSMine',0.333,'ATMine',0.333],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
		if ((random 1) > _minefieldChance) then {
			_entities = [[18796.5,13908.1,0],1,25,10,['APERSBoundingMine',0.333,'APERSMine',0.333,'ATMine',0.333],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
	};
	if (_aoName isEqualTo 'faronaki') then {
		private _composition = [
			["Land_Cargo_Patrol_V3_derelict_F","a3\structures_f_argo\military\containerbases\cargo_patrol_v3_derelict_f.p3d",[17034.8,10778.4,95.5676],[[0.162598,-0.986692,0],[0,0,1]],0,0,2,[],{
				(_this # 0) setVariable ['QS_cleanup_protected',TRUE,FALSE];
			}],
			["Land_Barn_01_brown_F","a3\structures_f_argo\industrial\agriculture\barn_01_brown_f.p3d",[16621.8,10905.7,105.398],[[0.903222,0.429175,0],[0,0,1]],0,0,2,[],{
				(_this # 0) animateSource ['Door_1_sound_source',1];
				(_this # 0) animateSource ['Door_2_sound_source',1];
			}],
			["Land_Cargo_Tower_V3_derelict_F","a3\structures_f_argo\military\containerbases\cargo_tower_v3_derelict_f.p3d",[16552.5,10867.6,114.356],[[-0.738486,-0.674269,0],[0,0,1]],0,0,2,[],{
				(_this # 0) setVariable ['QS_cleanup_protected',TRUE,FALSE];
			}],
			["Land_Barn_01_brown_F","a3\structures_f_argo\industrial\agriculture\barn_01_brown_f.p3d",[16512.9,10753.2,101.658],[[0.576021,0.817435,0],[0,0,1]],0,0,2,[],{
				(_this # 0) animateSource ['Door_1_sound_source',1];
				(_this # 0) animateSource ['Door_2_sound_source',1];			
			}]
		];
		_composition = [_composition] call (missionNamespace getVariable 'QS_fnc_createEntityComposition');
		{
			(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
		} forEach _composition;
		if ((random 1) > _minefieldChance) then {
			_entities = [[17037.8,10779.1,0],1,15,10,['APERSBoundingMine',0,'APERSMine',0.333,'ATMine',0],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
		if ((random 1) > _minefieldChance) then {
			_entities = [[16552.7,10866.7,0],1,15,10,['APERSBoundingMine',0,'APERSMine',0.333,'ATMine',0],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
	};
	if (_aoName isEqualTo 'panagia') then {
		if ((random 1) > _minefieldChance) then {
			_entities = [[20566.7,9412.42,0],1,50,25,['APERSBoundingMine',0.333,'APERSMine',0.333,'ATMine',0],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
	};
	if (_aoName isEqualTo 'skopos_castle') then {
		if ((random 1) > _minefieldChance) then {
			_entities = [[10397.7,8753.36,0],1,25,10,['APERSBoundingMine',0,'APERSMine',0.333,'ATMine',0],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
		if ((random 1) > _minefieldChance) then {
			_entities = [[10987.5,7677.47,0],1,25,10,['APERSBoundingMine',0,'APERSMine',0.333,'ATMine',0],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
	};
	if (_aoName isEqualTo 'zaros_power_station') then {
		if ((random 1) > _minefieldChance) then {
			_entities = [[8304.95,10085,0],1,50,25,['APERSBoundingMine',0.333,'APERSMine',0.333,'ATMine',0],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
		if ((random 1) > _minefieldChance) then {
			_entities = [[9185.25,11447.5,0],1,35,15,['APERSBoundingMine',0.333,'APERSMine',0.333,'ATMine',0],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
	};
	if (_aoName isEqualTo 'zaros') then {
		if ((random 1) > _minefieldChance) then {
			_entities = [[9212.33,11473.4,0],1,50,25,['APERSBoundingMine',0.333,'APERSMine',0.333,'ATMine',0],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
	};
	if (_aoName isEqualTo 'eginio') then {
		private _composition = [
			["Land_Barn_01_brown_F","a3\structures_f_argo\industrial\agriculture\barn_01_brown_f.p3d",[11361,7165.2,106.75],[[0.408313,0.912842,0],[0,0,1]],0,0,2,[],{
				(_this # 0) animateSource ['Door_1_sound_source',1];
				(_this # 0) animateSource ['Door_2_sound_source',1];			
			}],
			["Land_Barn_01_brown_F","a3\structures_f_argo\industrial\agriculture\barn_01_brown_f.p3d",[11537.1,7037.75,78.7984],[[0.133199,0.991089,0],[0,0,1]],0,0,2,[],{
				(_this # 0) animateSource ['Door_1_sound_source',1];
				(_this # 0) animateSource ['Door_2_sound_source',1];
			}],
			["Land_Barn_01_brown_F","a3\structures_f_argo\industrial\agriculture\barn_01_brown_f.p3d",[11813.6,7191.11,174.731],[[-0.962948,-0.269687,0],[0,0,1]],0,0,2,[],{
				(_this # 0) animateSource ['Door_1_sound_source',1];
				(_this # 0) animateSource ['Door_2_sound_source',1];
			}],
			["Land_Barn_01_brown_F","a3\structures_f_argo\industrial\agriculture\barn_01_brown_f.p3d",[11689.4,6866.43,58.1425],[[-0.556006,0.831178,0],[0,0,1]],0,0,2,[],{
				(_this # 0) animateSource ['Door_1_sound_source',1];
				(_this # 0) animateSource ['Door_2_sound_source',1];
			}]
		];
		_composition = [_composition] call (missionNamespace getVariable 'QS_fnc_createEntityComposition');
		{
			(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
		} forEach _composition;
		if ((random 1) > _minefieldChance) then {
			_entities = [[11659.7,7581.22,0],1,30,15,['APERSBoundingMine',0,'APERSMine',0.333,'ATMine',0],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
		if ((random 1) > _minefieldChance) then {
			_entities = [[11090.2,7323.96,0],1,30,15,['APERSBoundingMine',0,'APERSMine',0.333,'ATMine',0],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};		
	};
	if (_aoName isEqualTo 'the_stadium') then {
		private _composition = [
			["Land_i_Stone_House_Big_01_b_clay_F","a3\structures_f_argo\civilian\stone_house_big_01\i_stone_house_big_01_b_clay_f.p3d",[5227.72,15132.4,106.847],[[0.999781,0.0209175,0],[0,0,1]],0,0,2,[],{}]
		];
		_composition = [_composition] call (missionNamespace getVariable 'QS_fnc_createEntityComposition');
		{
			(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
		} forEach _composition;
		if ((random 1) > _minefieldChance) then {
			_entities = [[5751.89,14376.6,0],1,50,20,['APERSBoundingMine',0.333,'APERSMine',0.333,'ATMine',0],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
	};
	if (_aoName isEqualTo 'vikos_outpost') then {
		private _composition = [
			["Land_Castle_01_tower_ruins_F","a3\structures_f\dominants\castle\castle_01_tower_ruins_f.p3d",[11221.3,8684.63,186.034],[[-0.0836444,-0.996496,0],[0,0,1]],0,0,2,[],{
				(_this # 0) setVariable ['QS_cleanup_protected',TRUE,FALSE];
			}]
		];
		_composition = [_composition] call (missionNamespace getVariable 'QS_fnc_createEntityComposition');
		{
			(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
		} forEach _composition;
		if ((random 1) > _minefieldChance) then {
			_entities = [[12396.8,9302.64,0],1,50,20,['APERSBoundingMine',0.333,'APERSMine',0.333,'ATMine',0],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
		if ((random 1) > _minefieldChance) then {
			_entities = [[11207.7,8723.29,0],1,50,20,['APERSBoundingMine',0.333,'APERSMine',0.333,'ATMine',0],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
	};
	if (_aoName isEqualTo 'athanos') then {
		private _composition = [
			["Land_Cargo_Patrol_V3_derelict_F","a3\structures_f_argo\military\containerbases\cargo_patrol_v3_derelict_f.p3d",[4152.78,10829.3,162.611],[[-0.0481283,-0.998841,0],[0,0,1]],0,0,2,[],{
				(_this # 0) setVariable ['QS_cleanup_protected',TRUE,FALSE];
			}],
			["Land_Cargo_Patrol_V3_derelict_F","a3\structures_f_argo\military\containerbases\cargo_patrol_v3_derelict_f.p3d",[4250.96,10882.3,161.595],[[-0.992071,0.125676,0],[0,0,1]],0,0,2,[],{
				(_this # 0) setVariable ['QS_cleanup_protected',TRUE,FALSE];
			}],
			["Land_Cargo_Patrol_V3_derelict_F","a3\structures_f_argo\military\containerbases\cargo_patrol_v3_derelict_f.p3d",[4334.58,10742.2,150.867],[[0.505462,0.862849,0],[0,0,1]],0,0,2,[],{
				(_this # 0) setVariable ['QS_cleanup_protected',TRUE,FALSE];
			}]
		];
		_composition = [_composition] call (missionNamespace getVariable 'QS_fnc_createEntityComposition');
		{
			(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
		} forEach _composition;
		if ((random 1) > _minefieldChance) then {
			_entities = [[4551.58,11422.9,0],1,25,20,['APERSBoundingMine',0.333,'APERSMine',0.333,'ATMine',0],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
	};
	if (_aoName isEqualTo 'south_kavala') then {
		if ((random 1) > _minefieldChance) then {
			_entities = [[4548.91,12300.7,0],1,50,20,['APERSBoundingMine',0.333,'APERSMine',0.333,'ATMine',0],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
	};
	if (_aoName isEqualTo 'north_kavala') then {
		if ((random 1) > _minefieldChance) then {
			_entities = [[4516.16,13470.5,0],1,30,15,['APERSBoundingMine',0.333,'APERSMine',0.333,'ATMine',0],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
		if ((random 1) > _minefieldChance) then {
			_entities = [[4595.79,14386,0],1,15,15,['APERSBoundingMine',0.333,'APERSMine',0.333,'ATMine',0],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
	};
	if (_aoName isEqualTo 'topolia') then {
		if ((random 1) > _minefieldChance) then {
			_entities = [[7895.87,14621.7,0],1,20,20,['APERSBoundingMine',0.333,'APERSMine',0.333,'ATMine',0],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
		if ((random 1) > _minefieldChance) then {
			_entities = [[7018.47,15008.9,0],1,20,15,['APERSBoundingMine',0.333,'APERSMine',0.333,'ATMine',0],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
	};
	if (_aoName isEqualTo 'therisa') then {
		if ((random 1) > _minefieldChance) then {
			_entities = [[10341.7,12851.4,0],1,20,15,['APERSBoundingMine',0.25,'APERSMine',0.5,'ATMine',0.25],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};	
	};
};
if (worldName isEqualTo 'Tanoa') then {

};
if (worldName isEqualTo 'Malden') then {

};
if (worldName isEqualTo 'Enoch') then {

};
if (worldName isEqualTo 'Stratis') then {
	if (_aoName isEqualTo 'xiros_coastline') then {
		if ((random 1) > _minefieldChance) then {
			_entities = [[4445.92,6563.23,0],1,25,15,['APERSBoundingMine',0.125,'APERSMine',0.5,'ATMine',0.125],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
		if ((random 1) > _minefieldChance) then {
			_entities = [[4506.43,6604.23,0],1,25,15,['APERSBoundingMine',0.125,'APERSMine',0.5,'ATMine',0.125],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
		if ((random 1) > _minefieldChance) then {
			_entities = [[3980.5,6348.28,0],1,35,15,['APERSBoundingMine',0.125,'APERSMine',0.5,'ATMine',0],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
	};
	if (_aoName isEqualTo 'camp_rogain') then {
		if ((random 1) > _minefieldChance) then {
			_entities = [[4838.37,6340.96,0],1,25,15,['APERSBoundingMine',0,'APERSMine',1,'ATMine',0],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
		if ((random 1) > 0.25) then {
			_entities = [[4566.73,5824.52,0],1,45,30,['APERSBoundingMine',0.25,'APERSMine',1,'ATMine',0.1],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
		if ((random 1) > _minefieldChance) then {
			_entities = [[4962.16,5415.82,0],1,25,15,['APERSBoundingMine',0,'APERSMine',1,'ATMine',0],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
	};
	if (_aoName isEqualTo 'agia_marina') then {
		if ((random 1) > _minefieldChance) then {
			_entities = [[2495.99,5695.56,0],1,25,15,['APERSBoundingMine',0.25,'APERSMine',1,'ATMine',0.25],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
		if ((random 1) > _minefieldChance) then {
			_entities = [[2514,5860.24,0],1,25,15,['APERSBoundingMine',0,'APERSMine',0.2,'ATMine',1],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
		if ((random 1) > _minefieldChance) then {
			_entities = [[2582.58,5841.34,0],1,25,15,['APERSBoundingMine',0,'APERSMine',0.2,'ATMine',1],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
		if ((random 1) > _minefieldChance) then {
			_entities = [[2534.07,5794.75,0],1,25,15,['APERSBoundingMine',0,'APERSMine',0.2,'ATMine',1],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
	};
	if (_aoName isEqualTo 'lz_baldy') then {
		if ((random 1) > _minefieldChance) then {
			_entities = [[4118.12,5734.61,0],1,25,15,['APERSBoundingMine',0.25,'APERSMine',0.25,'ATMine',0.25],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
	};
	if (_aoName isEqualTo 'kamino_firing_range') then {
		_minefieldChance = 0.75;
		if ((random 1) > _minefieldChance) then {
			_entities = [[6054,5622.39,0],1,25,15,['APERSBoundingMine',0.25,'APERSMine',1,'ATMine',0.1],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
		if ((random 1) > _minefieldChance) then {
			_entities = [[5455.51,5268.73,0],1,25,15,['APERSBoundingMine',0.25,'APERSMine',0.25,'ATMine',0.25],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
		if ((random 1) > _minefieldChance) then {
			_entities = [[5596.44,5142.61,0],1,25,15,['APERSBoundingMine',0.25,'APERSMine',0.25,'ATMine',0.25],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
		if ((random 1) > _minefieldChance) then {
			_entities = [[5724.67,5037.89,0],1,25,15,['APERSBoundingMine',0.25,'APERSMine',0.25,'ATMine',0.25],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
		if ((random 1) > _minefieldChance) then {
			_entities = [[5346.65,5573.01,0],1,25,15,['APERSBoundingMine',0.25,'APERSMine',0.25,'ATMine',0.25],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
	};
	if (_aoName isEqualTo 'kamino_valley') then {
		if ((random 1) > _minefieldChance) then {
			_entities = [[5368.63,5203.39,0],1,25,15,['APERSBoundingMine',0.1,'APERSMine',0.5,'ATMine',0.5],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
		if ((random 1) > _minefieldChance) then {
			_entities = [[5385.27,4981.21,0],1,35,15,['APERSBoundingMine',0.25,'APERSMine',0.25,'ATMine',0.25],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
	};
	if (_aoName isEqualTo 'air_station_mike26') then {
		if ((random 1) > _minefieldChance) then {
			_entities = [[4467.59,4477.56,0],1,25,15,['APERSBoundingMine',0.1,'APERSMine',0.5,'ATMine',0.1],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
		if ((random 1) > _minefieldChance) then {
			_entities = [[4059.88,3521.41,0],1,35,15,['APERSBoundingMine',0.1,'APERSMine',0.5,'ATMine',0.1],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
		if ((random 1) > _minefieldChance) then {
			_entities = [[3829.82,4672.42,0],1,50,20,['APERSBoundingMine',0,'APERSMine',0,'ATMine',1],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
	};
	if (_aoName isEqualTo 'camp_tempest') then {
		if ((random 1) > _minefieldChance) then {
			_entities = [[2133.95,4281.5,0],1,25,15,['APERSBoundingMine',0.1,'APERSMine',0.5,'ATMine',0.25],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
		if ((random 1) > _minefieldChance) then {
			_entities = [[2063.34,4305.88,0],1,35,15,['APERSBoundingMine',0.1,'APERSMine',0.5,'ATMine',0.25],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
		if ((random 1) > _minefieldChance) then {
			_entities = [[2323.68,3843.41,0],1,35,20,['APERSBoundingMine',0,'APERSMine',1,'ATMine',0.1],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
	};
	if (_aoName isEqualTo 'camp_maxwell') then {
		if ((random 1) > _minefieldChance) then {
			_entities = [[3671.36,3120.98,0],1,25,15,['APERSBoundingMine',0.1,'APERSMine',0.5,'ATMine',0.1],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
		if ((random 1) > _minefieldChance) then {
			_entities = [[3652.48,3736.93,0],1,35,15,['APERSBoundingMine',0.1,'APERSMine',0.5,'ATMine',0.25],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
		if ((random 1) > _minefieldChance) then {
			_entities = [[3931.14,3540.32,0],1,50,20,['APERSBoundingMine',0.1,'APERSMine',0.5,'ATMine',0.5],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
	};
	if (_aoName isEqualTo 'girna') then {
		if ((random 1) > _minefieldChance) then {
			_entities = [[2133.23,3279.44,0],1,25,15,['APERSBoundingMine',0.1,'APERSMine',0.5,'ATMine',0.1],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
		if ((random 1) > _minefieldChance) then {
			_entities = [[2064.51,3273.85,0],1,35,15,['APERSBoundingMine',0.1,'APERSMine',0.5,'ATMine',0.1],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
		if ((random 1) > _minefieldChance) then {
			_entities = [[2629.84,2995.34,0],1,50,15,['APERSBoundingMine',0.1,'APERSMine',0.5,'ATMine',0.1],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
	};
	if (_aoName isEqualTo 'lz_connor') then {
		if ((random 1) > _minefieldChance) then {
			_entities = [[3198.11,2736.7,0],1,25,15,['APERSBoundingMine',0.1,'APERSMine',0.5,'ATMine',0.5],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
		if ((random 1) > _minefieldChance) then {
			_entities = [[2891.15,2525.12,0],1,35,15,['APERSBoundingMine',0.1,'APERSMine',0.5,'ATMine',0.1],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
		if ((random 1) > _minefieldChance) then {
			_entities = [[3406.46,2421.78,0],1,35,15,['APERSBoundingMine',0.1,'APERSMine',0.5,'ATMine',0.25],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
	};
	if (_aoName isEqualTo 'spartan_coastline') then {
		if ((random 1) > _minefieldChance) then {
			_entities = [[2624.12,1607.04,0],1,25,15,['APERSBoundingMine',0.1,'APERSMine',0.5,'ATMine',0.1],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
		if ((random 1) > _minefieldChance) then {
			_entities = [[2660.73,1636.79,0],1,35,15,['APERSBoundingMine',0.1,'APERSMine',0.5,'ATMine',0.1],false,false] call (missionNamespace getVariable 'QS_fnc_createMinefield');
			{
				(missionNamespace getVariable 'QS_entities_ao_customEntities') pushBack _x;
			} forEach _entities;
		};
	};
};
_entities;