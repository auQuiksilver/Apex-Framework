/*/
File: QS_data_animationParams.sqf
Author:

	Quiksilver
	
Last modified:

	12/02/2023 A3 2.12 by Quiksilver
	
Description:

	Player should be able to actuate certain object animations with scroll wheel
	
Notes:

	WIP

	0 - animate
	1 - animateSource
	2 - animateDoor
________________________________________/*/

[
	['flag',[4,'','',0,1,0.05,1,'BIS_Disabled_Door_1',{
		_otherPlayers = allPlayers - [QS_player];
		(
			(!(_this getVariable ['QS_locked',FALSE])) && 
			{((currentWeapon cameraOn) isEqualTo '')} &&
			{(((_otherPlayers inAreaArray [getPos _this,5,5,0,FALSE]) select {((currentWeapon _x) isEqualTo '')}) isEqualTo [])}
		)
	}]],
	['hatch_1',[1,'Hatch_1_source','Hatch_1_source',0,1,0.1,1,'BIS_Disabled_Door_1',{(([cameraOn,getPosWorld cameraOn] call QS_fnc_inHouse) # 0)}]],
	['hatch_2',[1,'Hatch_2_source','Hatch_2_source',0,1,0.1,1,'BIS_Disabled_Door_2',{(([cameraOn,getPosWorld cameraOn] call QS_fnc_inHouse) # 0)}]],
	['hatch_3',[1,'Hatch_3_source','Hatch_3_source',0,1,0.1,1,'BIS_Disabled_Door_3',{(([cameraOn,getPosWorld cameraOn] call QS_fnc_inHouse) # 0)}]],
	['hatch_4',[1,'Hatch_4_source','Hatch_4_source',0,1,0.1,1,'BIS_Disabled_Door_4',{(([cameraOn,getPosWorld cameraOn] call QS_fnc_inHouse) # 0)}]],
	['hatch_5',[1,'Hatch_5_source','Hatch_5_source',0,1,0.1,1,'BIS_Disabled_Door_5',{(([cameraOn,getPosWorld cameraOn] call QS_fnc_inHouse) # 0)}]],
	['hatch_6',[1,'Hatch_6_source','Hatch_6_source',0,1,0.1,1,'BIS_Disabled_Door_6',{(([cameraOn,getPosWorld cameraOn] call QS_fnc_inHouse) # 0)}]],
	['panel1',[0,'panel_1_rotate','panel_1_rotate',0,3.15,0.1,1,'BIS_Disabled_Door_1',{((!(_this getVariable ['QS_locked',FALSE])) && ((currentWeapon cameraOn) isEqualTo ''))}]],
	['panel2',[0,'panel_2_rotate','panel_2_rotate',0,3.15,0.1,1,'BIS_Disabled_Door_2',{((!(_this getVariable ['QS_locked',FALSE])) && ((currentWeapon cameraOn) isEqualTo ''))}]],
	['panel3',[0,'panel_3_rotate','panel_3_rotate',0,3.15,0.1,1,'BIS_Disabled_Door_3',{((!(_this getVariable ['QS_locked',FALSE])) && ((currentWeapon cameraOn) isEqualTo ''))}]],
	['panel4',[0,'panel_4_rotate','panel_4_rotate',0,3.15,0.1,1,'BIS_Disabled_Door_4',{((!(_this getVariable ['QS_locked',FALSE])) && ((currentWeapon cameraOn) isEqualTo ''))}]],
	['door_1',[1,'door_1_sound_source','Door_1_noSound_source',0,1,0.1,1,'BIS_Disabled_Door_1',{(!(_this getVariable ['QS_locked',FALSE]))}]],
	['door_1a',[0,'door_1a_rot','door_1a_rot',0,1,0.1,1,'BIS_Disabled_Door_1',{(!(_this getVariable ['QS_locked',FALSE]))}]],
	['door_1b',[0,'door_1b_rot','door_1b_rot',0,1,0.1,1,'BIS_Disabled_Door_1',{(!(_this getVariable ['QS_locked',FALSE]))}]],
	['door_2',[1,'door_2_sound_source','Door_2_noSound_source',0,1,0.1,1,'BIS_Disabled_Door_2',{(!(_this getVariable ['QS_locked',FALSE]))}]],
	['door_2a',[0,'door_2a_rot','door_2a_rot',0,1,0.1,1,'BIS_Disabled_Door_2',{(!(_this getVariable ['QS_locked',FALSE]))}]],
	['door_2b',[0,'door_2b_rot','door_2b_rot',0,1,0.1,1,'BIS_Disabled_Door_2',{(!(_this getVariable ['QS_locked',FALSE]))}]],
	['door_3',[1,'door_3_sound_source','Door_3_noSound_source',0,1,0.1,1,'BIS_Disabled_Door_3',{(!(_this getVariable ['QS_locked',FALSE]))}]],
	['door_4',[1,'door_4_sound_source','Door_4_noSound_source',0,1,0.1,1,'BIS_Disabled_Door_4',{(!(_this getVariable ['QS_locked',FALSE]))}]],
	['door_5',[1,'door_5_sound_source','Door_5_noSound_source',0,1,0.1,1,'BIS_Disabled_Door_5',{(!(_this getVariable ['QS_locked',FALSE]))}]],
	['door_6',[1,'door_6_sound_source','Door_6_noSound_source',0,1,0.1,1,'BIS_Disabled_Door_6',{(!(_this getVariable ['QS_locked',FALSE]))}]],
	['door_7',[1,'door_7_sound_source','Door_7_noSound_source',0,1,0.1,1,'BIS_Disabled_Door_7',{(!(_this getVariable ['QS_locked',FALSE]))}]],
	['door_8',[1,'door_8_sound_source','Door_8_noSound_source',0,1,0.1,1,'BIS_Disabled_Door_8',{(!(_this getVariable ['QS_locked',FALSE]))}]],
	['door_9',[1,'door_9_sound_source','Door_9_noSound_source',0,1,0.1,1,'BIS_Disabled_Door_9',{(!(_this getVariable ['QS_locked',FALSE]))}]],
	['door_10',[1,'door_10_sound_source','Door_10_noSound_source',0,1,0.1,1,'BIS_Disabled_Door_10',{(!(_this getVariable ['QS_locked',FALSE]))}]],
	['door_11',[1,'door_11_sound_source','Door_11_noSound_source',0,1,0.1,1,'BIS_Disabled_Door_11',{(!(_this getVariable ['QS_locked',FALSE]))}]],
	['door_12',[1,'door_12_sound_source','Door_12_noSound_source',0,1,0.1,1,'BIS_Disabled_Door_12',{(!(_this getVariable ['QS_locked',FALSE]))}]],
	['door_13',[1,'door_13_sound_source','Door_13_noSound_source',0,1,0.1,1,'BIS_Disabled_Door_13',{(!(_this getVariable ['QS_locked',FALSE]))}]],
	['door_14',[1,'door_14_sound_source','Door_14_noSound_source',0,1,0.1,1,'BIS_Disabled_Door_14',{(!(_this getVariable ['QS_locked',FALSE]))}]],
	['door_15',[1,'door_15_sound_source','Door_15_noSound_source',0,1,0.1,1,'BIS_Disabled_Door_15',{(!(_this getVariable ['QS_locked',FALSE]))}]],
	['door_16',[1,'door_16_sound_source','Door_16_noSound_source',0,1,0.1,1,'BIS_Disabled_Door_16',{(!(_this getVariable ['QS_locked',FALSE]))}]],
	['door_17',[1,'door_17_sound_source','Door_17_noSound_source',0,1,0.1,1,'BIS_Disabled_Door_17',{(!(_this getVariable ['QS_locked',FALSE]))}]],
	['door_18',[1,'door_18_sound_source','Door_18_noSound_source',0,1,0.1,1,'BIS_Disabled_Door_18',{(!(_this getVariable ['QS_locked',FALSE]))}]],
	['door_19',[1,'door_19_sound_source','Door_19_noSound_source',0,1,0.1,1,'BIS_Disabled_Door_19',{(!(_this getVariable ['QS_locked',FALSE]))}]],
	['door_20',[1,'door_20_sound_source','Door_20_noSound_source',0,1,0.1,1,'BIS_Disabled_Door_20',{(!(_this getVariable ['QS_locked',FALSE]))}]],
	['door_21',[1,'door_21_sound_source','Door_21_noSound_source',0,1,0.1,1,'BIS_Disabled_Door_21',{(!(_this getVariable ['QS_locked',FALSE]))}]],
	['door_22',[1,'door_22_sound_source','Door_22_noSound_source',0,1,0.1,1,'BIS_Disabled_Door_22',{(!(_this getVariable ['QS_locked',FALSE]))}]]
]