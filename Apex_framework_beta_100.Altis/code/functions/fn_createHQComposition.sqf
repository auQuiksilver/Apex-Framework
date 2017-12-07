/*
File: fn_createHQComposition.sqf
Author: 

	Quiksilver
	
Last modified:

	20/07/2015 A3 1.62 by Quiksilver
	
Description:

	Apply code to player when player is damaged
___________________________________________________________________*/

if (!isNil {missionNamespace getVariable 'QS_RD_initCSH'}) exitWith {};
missionNamespace setVariable ['QS_RD_initCSH',TRUE,FALSE];

private ['_hospital','_boardType','_agentTypes','_agentType','_objects','_medicType','_reconType','_soldierType','_officerType'];

_hospital = _this select 0;

/*/if (!((typeOf _hospital) in ['Land_Cargo_HQ_V1_F','Land_Cargo_HQ_V2_F','Land_Cargo_HQ_V3_F','Land_Cargo_HQ_V4_F'])) exitWith {};/*/

if (worldName isEqualTo 'Tanoa') then {
	_medicType = 'B_T_medic_F';
	_reconType = 'B_T_recon_F';
	_soldierType = 'B_T_soldier_F';
	_officerType = 'B_T_officer_F';
} else {
	_medicType = 'B_medic_F';
	_reconType = 'B_recon_F';
	_soldierType = 'B_soldier_F';
	_officerType = 'B_officer_F';
};

private _agent5 = objNull;
private _agent4 = objNull;
private _agent3 = objNull;

_objects = [];
_dataTerminal = createVehicle ['Land_DataTerminal_01_F',[0,0,0],[],0,'NONE'];
missionNamespace setVariable [
	'QS_analytics_entities_created',
	((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
	FALSE
];
_dataTerminal attachTo [_hospital,[1,1.75,-3.25]];
_dataTerminal setDir 90;
_dataTerminal allowDamage FALSE;
missionNamespace setVariable ['QS_module_fob_baseDataTerminal',_dataTerminal,FALSE];
_dataTerminal enableSimulationGlobal FALSE;
detach _dataTerminal;
_dataTerminal setDir 350;	/*/custom direction, change if composition location is changed/*/

_mat1 = createVehicle ['Land_Ground_sheet_blue_F',[0,0,0],[],0,'NONE'];
missionNamespace setVariable [
	'QS_analytics_entities_created',
	((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
	FALSE
];
_mat1 attachTo [_hospital,[3,3,-3.25]];
_mat1 allowDamage FALSE;
_mat1 enableSimulationGlobal FALSE;
_objects pushBack _mat1;
_mat2 = createVehicle ['Land_Ground_sheet_blue_F',[0,0,0],[],0,'NONE'];
missionNamespace setVariable [
	'QS_analytics_entities_created',
	((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
	FALSE
];
_mat2 attachTo [_hospital,[4.5,3,-3.25]];
_mat2 allowDamage FALSE;
_mat2 enableSimulationGlobal FALSE;
_objects pushBack _mat2;
_mat3 = createVehicle ['Land_Ground_sheet_blue_F',[0,0,0],[],0,'NONE'];
missionNamespace setVariable [
	'QS_analytics_entities_created',
	((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
	FALSE
];
_mat3 attachTo [_hospital,[6,3,-3.25]];
_mat3 allowDamage FALSE;
_mat3 enableSimulationGlobal FALSE;
_objects pushBack _mat3;

_table2 = createVehicle ['Land_CampingTable_F',[0,0,0],[],0,'NONE'];
missionNamespace setVariable [
	'QS_analytics_entities_created',
	((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
	FALSE
];
_table2 attachTo [_hospital,[-2.5,4,-2.875]];
_table2 setDir 180;
_table2 enableSimulationGlobal FALSE;
_objects pushBack _table2;

_table3 = createVehicle ['Land_CampingTable_F',[0,0,0],[],0,'NONE'];
missionNamespace setVariable [
	'QS_analytics_entities_created',
	((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
	FALSE
];
_table3 attachTo [_hospital,[-3.9,3.45,-2.875]];
_table3 setDir 90;
_table3 enableSimulationGlobal FALSE;
_objects pushBack _table3;

_pcCase = createVehicle ['Land_PCSet_01_case_F',(position player),[],0,'NONE'];
missionNamespace setVariable [
	'QS_analytics_entities_created',
	((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
	FALSE
];
_pcCase attachTo [_hospital,[-1.4,4,-3]];
_pcCase enableSimulationGlobal FALSE;
_objects pushBack _pcCase;

_pcScreen1 = createVehicle ['Land_PCSet_01_screen_F',[0,0,0],[],0,'NONE'];
missionNamespace setVariable [
	'QS_analytics_entities_created',
	((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
	FALSE
];
missionNamespace setVariable ['QS_RD_CSH_SCREEN_1',_pcScreen1,TRUE];
_pcScreen1 attachTo [_hospital,[-2.7,4.2,-2.21]];
/*/_pcScreen1 setObjectTextureGlobal [0,'data\client\predatorfeed.paa'];/*/
_pcScreen1 enableSimulationGlobal FALSE;
_objects pushBack _pcScreen1;

_pcScreen2 = createVehicle ['Land_PCSet_01_screen_F',[0,0,0],[],0,'NONE'];
missionNamespace setVariable [
	'QS_analytics_entities_created',
	((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
	FALSE
];
missionNamespace setVariable ['QS_RD_CSH_SCREEN_1',_pcScreen2,TRUE];
_pcScreen2 attachTo [_hospital,[-3.3,4.1,-2.21]];
_pcScreen2 setDir 345;
/*/_pcScreen2 setObjectTextureGlobal [0,'data\client\milscreen1.jpg'];/*/
_pcScreen2 enableSimulationGlobal FALSE;
_objects pushBack _pcScreen2;

_pcScreen3 = createVehicle ['Land_PCSet_01_screen_F',[0,0,0],[],0,'NONE'];
missionNamespace setVariable [
	'QS_analytics_entities_created',
	((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
	FALSE
];
missionNamespace setVariable ['QS_RD_CSH_SCREEN_1',_pcScreen3,TRUE];
_pcScreen3 attachTo [_hospital,[-2.1,4.1,-2.21]];
_pcScreen3 setDir 15;
/*/_pcScreen3 setObjectTextureGlobal [0,'data\client\tanoa1.jpg'];/*/
_pcScreen3 enableSimulationGlobal FALSE;
_objects pushBack _pcScreen3;

_pcKeyboard = createVehicle ['Land_PCSet_01_keyboard_F',[0,0,0],[],0,'NONE'];
missionNamespace setVariable [
	'QS_analytics_entities_created',
	((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
	FALSE
];
_pcKeyboard attachTo [_hospital,[-2.85,3.8,-2.44]];
_pcKeyboard setDir 340;
_pcKeyboard enableSimulationGlobal FALSE;
_objects pushBack _pcKeyboard;

_pcMouse= createVehicle ['Land_PCSet_01_mouse_F',[0,0,0],[],0,'NONE'];
missionNamespace setVariable [
	'QS_analytics_entities_created',
	((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
	FALSE
];
_pcMouse attachTo [_hospital,[-2.4,3.8,-2.44]];
_pcMouse enableSimulationGlobal FALSE;
_objects pushBack _pcMouse;

_speakers = createVehicle ['Land_PortableSpeakers_01_F',[0,0,0],[],0,'NONE'];
missionNamespace setVariable [
	'QS_analytics_entities_created',
	((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
	FALSE
];
_speakers attachTo [_hospital,[-2.7,4,-2.43]];
_speakers setDir 270;
missionNamespace setVariable ['QS_RD_CSHsoundSource',(getPosASL _speakers),FALSE];
_speakers enableSimulationGlobal FALSE;
_objects pushBack _speakers;

_tv = createVehicle ['Land_FlatTV_01_F',[0,0,0],[],0,'NONE'];
missionNamespace setVariable [
	'QS_analytics_entities_created',
	((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
	FALSE
];
_tv attachTo [_hospital,[-4,4,-1.15]];
_tv setDir 315;
missionNamespace setVariable ['QS_RD_CSH_TV_1',_tv,TRUE];
/*/_tv setObjectTextureGlobal [0,'data\client\nosignal.jpg'];/*/
_tv enableSimulationGlobal FALSE;
_objects pushBack _tv;

if ((toLower worldName) in ['altis','stratis','malden','tanoa']) then {
	_boardType = format ['MapBoard_%1_F',worldName];
} else {
	_boardType = 'Land_MapBoard_F';
};
_whiteMap = createVehicle [_boardType,[0,0,0],[],0,'NONE'];
missionNamespace setVariable [
	'QS_analytics_entities_created',
	((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
	FALSE
];
_whiteMap attachTo [_hospital,[1,3.9,-2.25]];
_whiteMap setDir 45;
_whiteMap enableSimulationGlobal FALSE;

_chair = createVehicle ['Land_CampingChair_V2_F',[0,0,0],[],0,'NONE'];
missionNamespace setVariable [
	'QS_analytics_entities_created',
	((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
	FALSE
];
_chair attachTo [_hospital,[-2.3,3,-2.78]];
_chair setDir 150;
_objects pushBack _chair;

_agent0 = createVehicle [_officerType,[0,0,0],[],0,'NONE'];	/*/createAgent/*/
missionNamespace setVariable [
	'QS_analytics_entities_created',
	((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
	FALSE
];
_agent0 disableAI 'ALL';
['switchMove',_agent0,'Crew'] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
_agent0 attachTo [_chair,[0,-0.1,-0.45]];
_agent0 setDir 180;
removeAllWeapons _agent0;
removeVest _agent0;
_agent0 unlinkItem 'NVGoggles';
removeHeadgear _agent0;
_agent0 addHeadgear 'H_Cap_oli_hs';
[_agent0,'QS_RD_Medevac_2'] call (missionNamespace getVariable 'BIS_fnc_setUnitInsignia');
_agent0 setCaptive TRUE;
_agent0 setVariable ['QS_curator_disableEditability',TRUE,FALSE];
_agent0 allowDamage FALSE;
_agent1 = createVehicle [_soldierType,[0,0,0],[],0,'NONE'];	/*/createAgent/*/
missionNamespace setVariable [
	'QS_analytics_entities_created',
	((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
	FALSE
];
sleep 1;
_agent1 disableAI 'ALL';
['switchMove',_agent1,'acts_injuredlyingrifle01'] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
removeVest _agent1;
if (sunOrMoon > 0.25) then {_agent1 unlinkItem 'NVGoggles';};
sleep 1;
_agent1 attachTo [_hospital,[3,3,-3.25]];
_agent1 setDir 180;
_agent1 allowDamage FALSE;
_agent1 setVariable ['QS_curator_disableEditability',TRUE,FALSE];
_agent1 setCaptive TRUE;
/*/detach _agent1;/*/			/*/ Can be slid around on the floor/*/
[_agent1,'TFAegis'] call (missionNamespace getVariable 'BIS_fnc_setUnitInsignia');
_agent2 = createVehicle [_reconType,[0,0,0],[],0,'NONE']; /*/createAgent/*/
missionNamespace setVariable [
	'QS_analytics_entities_created',
	((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
	FALSE
];
removeAllWeapons _agent1;
removeVest _agent2;
sleep 1;
_agent2 disableAI 'ALL';
_agent2 switchMove 'ainjppnemstpsnonwnondnon';
if (sunOrMoon > 0.25) then {_agent2 unlinkItem 'NVGoggles';};
sleep 1;
_agent2 attachTo [_hospital,[4.5,3,-3.25]];
_agent2 allowDamage FALSE;
_agent2 setCaptive TRUE;
_agent2 setVariable ['QS_curator_disableEditability',TRUE,FALSE];
detach _agent2;
[_agent2,'TFAegis'] call (missionNamespace getVariable 'BIS_fnc_setUnitInsignia');
_agent2 setDir ((getDir _agent2) + 180);
_agentTypes = [
	"C_man_p_beggar_F","C_man_1","C_man_polo_1_F","C_man_polo_2_F","C_man_polo_3_F","C_man_polo_4_F","C_man_polo_5_F",
	"C_man_polo_6_F","C_man_shorts_1_F","C_man_1_1_F","C_man_1_2_F","C_man_1_3_F","C_man_p_fugitive_F","C_man_p_shorts_1_F",
	"C_man_hunter_1_F","C_man_w_worker_F","C_man_shorts_2_F","C_man_shorts_3_F","C_man_shorts_4_F","C_man_p_beggar_F_afro",
	"C_man_polo_1_F_afro","C_man_polo_2_F_afro","C_man_polo_3_F_afro","C_man_polo_4_F_afro","C_man_polo_5_F_afro",
	"C_man_polo_6_F_afro","C_man_shorts_1_F_afro","C_man_p_shorts_1_F_afro","C_man_shorts_2_F_afro","C_man_shorts_3_F_afro",
	"C_man_shorts_4_F_afro","C_man_p_beggar_F","C_man_1","C_man_polo_1_F","C_man_polo_2_F","C_man_polo_3_F","C_man_polo_4_F",
	"C_man_polo_5_F","C_man_polo_6_F","C_man_shorts_1_F","C_man_1_1_F","C_man_1_2_F","C_man_1_3_F","C_man_p_shorts_1_F",
	"C_man_hunter_1_F","C_man_p_beggar_F_asia","C_man_polo_1_F_asia","C_man_polo_2_F_asia","C_man_polo_3_F_asia",
	"C_man_polo_4_F_asia","C_man_polo_5_F_asia","C_man_polo_6_F_asia","C_man_shorts_1_F_asia","C_man_p_shorts_1_F_asia",
	"C_man_shorts_2_F_asia","C_man_shorts_3_F_asia","C_man_shorts_4_F_asia","C_man_p_beggar_F_euro","C_man_polo_1_F_euro",
	"C_man_polo_2_F_euro","C_man_polo_3_F_euro","C_man_polo_4_F_euro","C_man_polo_5_F_euro","C_man_polo_6_F_euro",
	"C_man_shorts_1_F_euro","C_man_p_shorts_1_F_euro","C_man_shorts_2_F_euro","C_man_shorts_3_F_euro","C_man_shorts_4_F_euro"
];
_agentType = selectRandom _agentTypes;
_agent3 = createVehicle [_agentType,[0,0,0],[],0,'NONE'];	/*/createAgent/*/
missionNamespace setVariable [
	'QS_analytics_entities_created',
	((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
	FALSE
];
sleep 1;
_agent3 disableAI 'ALL';
_agent3 switchMove 'ainjppnemstpsnonwnondnon';
_agent3 setVariable ['QS_curator_disableEditability',TRUE,FALSE];
sleep 1;
_agent3 attachTo [_hospital,[6,3.2,-3.25]];
/*/_agent3 setDir 180;/*/
_agent3 allowDamage FALSE;
_agent3 setCaptive TRUE;
detach _agent3;
[_agent3,'TFAegis'] call (missionNamespace getVariable 'BIS_fnc_setUnitInsignia');

if ((random 1) > 0.5) then {
	_agent4 = createVehicle [_medicType,[0,0,0],[],0,'NONE'];	/*/createAgent/*/
	missionNamespace setVariable [
		'QS_analytics_entities_created',
		((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
		FALSE
	];
	removeAllWeapons _agent4;
	if (sunOrMoon > 0.25) then {_agent4 unlinkItem 'NVGoggles';};
	[_agent4,'QS_RD_Medevac_2'] call (missionNamespace getVariable 'BIS_fnc_setUnitInsignia');
	sleep 1;
	_agent4 disableAI 'ALL';
	_agent4 switchMove 'acts_treatingwounded05';
	removeVest _agent4;
	_agent4 addEventHandler [
		'AnimDone',
		{
			(_this select 0) playMoveNow 'acts_treatingwounded05';
			if (!isNil {(_this select 0) getVariable 'QS_RD_agent'}) then {
				if (((_this select 0) distance (((_this select 0) getVariable 'QS_RD_agent') select 0)) > 0.2) then {
					(_this select 0) setPos (((_this select 0) getVariable 'QS_RD_agent') select 0);
					(_this select 0) setDir (((_this select 0) getVariable 'QS_RD_agent') select 1);
				};
			};
		}
	];
	sleep 1;
	_agent4 attachTo [_hospital,[4,3,-3.25]];
	_agent4 setDir 120;
	_agent4 allowDamage FALSE;
	_agent4 setCaptive TRUE;
	detach _agent4;
	_agent4 setVariable ['QS_curator_disableEditability',TRUE,FALSE];
	_agent4 setDir ((getDir _agent4) + 100);
	_agent4 setVariable ['QS_RD_agent',[(getPosATL _agent4),(getDir _agent4)],FALSE];
	private ['_agent4Pos','_arr','_obj'];
	_agent4Pos = getPosATL _agent4;
	_arr = [];
	_maxCount = round (2 + (random 1));
	{
		if ((random 1) > 0.5) then {
			_obj = createVehicle [_x,[((_agent4Pos select 0) + (1.5 - (random 3))),((_agent4Pos select 1) + (1.5 - (random 3))),1],[],0,'CAN_COLLIDE'];
			missionNamespace setVariable [
				'QS_analytics_entities_created',
				((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
				FALSE
			];
		
			0 = _arr pushBack _obj;
			0 = _objects pushBack _obj;
			_obj setDir (random 360);
			if (_forEachIndex >= _maxCount) exitWith {};
		};
	} forEach [
		'MedicalGarbage_01_1x1_v1_F','MedicalGarbage_01_1x1_v2_F','MedicalGarbage_01_1x1_v3_F','MedicalGarbage_01_3x3_v1_F','MedicalGarbage_01_3x3_v2_F'
	];
	sleep 1;
	{
		_x allowDamage FALSE;
	} count _arr;
};
{
	[_x] call (missionNamespace getVariable 'QS_fnc_setSimpleObject');
} forEach _objects;
_hospital = [_hospital] call (missionNamespace getVariable 'QS_fnc_setSimpleObject');
{
	_hospital animate _x;
} forEach [
	['door_1_rot',1],
	['door_2_rot',1],
	['hatch_1_rot',1]
];
_hospital spawn {
	_this enableSimulationGlobal TRUE;
	sleep 1;
	_this enableSimulationGlobal FALSE;
};
[_agent4,_agent3] spawn {
	sleep 60;
	{
		if (!isNull _x) then {
			_x setPosATL [((getPosATL _x) select 0),((getPosATL _x) select 1),(((getPosATL _x) select 2) + 1.5)];
		};
	} forEach _this;
};