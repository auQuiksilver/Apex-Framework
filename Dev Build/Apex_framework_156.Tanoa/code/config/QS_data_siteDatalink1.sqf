/*/
File: QS_data_siteDatalink1.sqf
Author:

	Quiksilver
	
Last modified:

	6/08/2022 A3 2.10 by Quiksilver
	
Description:

	Datalink - Urban
	
_dir = getDir QS_building;
QS_array = [];
{
	QS_array pushBack [
		0,
		(typeOf _x),
		((getModelInfo _x) # 1),
		QS_building worldToModel (getPosASL _x),
		((getDir _x) - _dir),
		{}
	];
} forEach ((nearestObjects [QS_building,[],20,FALSE]) - [QS_building]);
copyToClipboard str QS_array;

_______________________________/*/

[
	[0,"Land_DeskChair_01_olive_F","a3\props_f_enoch\military\camps\deskchair_01_f.p3d",[0.138062,0.746582,12.2602],-0.147449,{}],
	[0,"Land_Router_01_olive_F","a3\props_f_enoch\military\equipment\router_01_f.p3d",[0.86853,0.902954,13.1635],181.114,{}],
	[0,"Land_PortableDesk_01_olive_F","a3\props_f_enoch\military\camps\portabledesk_01_f.p3d",[0.879272,0.729004,12.2662],181.022,{}],
	[0,"Land_PortableGenerator_01_F","a3\props_f_exp\military\camps\portablegenerator_01_f.p3d",[0.260376,1.26746,12.1251],269.169,{}],
	[1,"Land_Laptop_03_olive_F","a3\props_f_enoch\military\equipment\laptop_03_f.p3d",[1.67493,0.680542,13.1492],14.0455,{
		missionNamespace setVariable ['QS_virtualSectors_sub_1_obj',_this,TRUE];
		for '_x' from 0 to 2 step 1 do {
			_this setVariable ['QS_sc_subObj_1',TRUE,TRUE];
			_this setVariable ['QS_secureable',TRUE,TRUE];
		};
	}],
	[0,"Land_DeskChair_01_olive_F","a3\props_f_enoch\military\camps\deskchair_01_f.p3d",[1.64233,0.698853,12.2652],4.14555,{}],
	[0,"Fridge_01_closed_F","a3\structures_f_heli\items\electronics\fridge_01_f.p3d",[2.49792,0.742432,12.2923],-1.19044,{}],
	[0,"SatelliteAntenna_01_Olive_F","a3\props_f_enoch\military\camps\satelliteantenna_01_f.p3d",[-1.83862,-0.143311,14.7543],-61.8964,{}],
	[0,"Land_PortableCabinet_01_bookcase_olive_F","a3\props_f_enoch\military\camps\portablecabinet_01_bookcase_f.p3d",[2.88171,-0.868164,12.3037],89.9625,{}],
	[0,"OmniDirectionalAntenna_01_black_F","a3\props_f_enoch\military\equipment\omnidirectionalantenna_01_f.p3d",[1.58972,0.022583,14.7647],-61.8964,{}]
]