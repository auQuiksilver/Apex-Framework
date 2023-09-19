/*
File: fn_getDoorAnimations.sqf
Author:

	commy2 from ACE3 mod
	
Last Modified:
	
	3/04/2017 A3 1.68 by Quiksilver
	
Description:

	Get Door Animations
____________________________________________________*/

params ['_house','_door'];
private ['_index','_animations','_lockedVariable'];
_index = [
	"door_1",
	"door_1a",
	"door_1b",
	"door_2",
	"door_3",
	"door_4",
	"door_5",
	"door_6",
	"door_7",
	"door_8",
	"door_9",
	"door_10",
	"door_11",
	"door_12",
	"door_13",
	"door_14",
	"door_15",
	"door_16",
	"door_17",
	"door_18",
	"door_19",
	"door_20",
	"door_21",
	"door_22",
	"hatch_1",
	"hatch_2",
	"hatch_3",
	"hatch_4",
	"hatch_5",
	"hatch_6"
] find (toLowerANSI _door);
if (_index isEqualTo -1) exitWith {[[],""]};
_animations = [
	["Door_1_sound_source","Door_1_noSound_source"],
	["door_1a_rot"],
	["door_1b_rot"],
	["Door_2_sound_source","Door_2_noSound_source"],
	["Door_3_sound_source","Door_3_noSound_source"],
	["Door_4_sound_source","Door_4_noSound_source"],
	["Door_5_sound_source","Door_5_noSound_source"],
	["Door_6_sound_source","Door_6_noSound_source"],
	["Door_7_sound_source","Door_7_noSound_source"],
	["Door_8_sound_source","Door_8_noSound_source"],
	["Door_9_sound_source","Door_9_noSound_source"],
	["Door_10_sound_source","Door_10_noSound_source"],
	["Door_11_sound_source","Door_11_noSound_source"],
	["Door_12_sound_source","Door_12_noSound_source"],
	["Door_13_sound_source","Door_13_noSound_source"],
	["Door_14_sound_source","Door_14_noSound_source"],
	["Door_15_sound_source","Door_15_noSound_source"],
	["Door_16_sound_source","Door_16_noSound_source"],
	["Door_17_sound_source","Door_17_noSound_source"],
	["Door_18_sound_source","Door_18_noSound_source"],
	["Door_19_sound_source","Door_19_noSound_source"],
	["Door_20_sound_source","Door_20_noSound_source"],
	["Door_21_sound_source","Door_21_noSound_source"],
	["Door_22_sound_source","Door_22_noSound_source"],
	["Hatch_1_sound_source","Hatch_1_noSound_source"],
	["Hatch_2_sound_source","Hatch_2_noSound_source"],
	["Hatch_3_sound_source","Hatch_3_noSound_source"],
	["Hatch_4_sound_source","Hatch_4_noSound_source"],
	["Hatch_5_sound_source","Hatch_5_noSound_source"],
	["Hatch_6_sound_source","Hatch_6_noSound_source"]
] # _index;
_lockedVariable = [
	["BIS_Disabled_Door_1",  "Door_Handle_1_rot_1",  "Door_Locked_1_rot"],
	["BIS_Disabled_Door_2",  "Door_Handle_2_rot_1",  "Door_Locked_2_rot"],
	["BIS_Disabled_Door_3",  "Door_Handle_3_rot_1",  "Door_Locked_3_rot"],
	["BIS_Disabled_Door_4",  "Door_Handle_4_rot_1",  "Door_Locked_4_rot"],
	["BIS_Disabled_Door_5",  "Door_Handle_5_rot_1",  "Door_Locked_5_rot"],
	["BIS_Disabled_Door_6",  "Door_Handle_6_rot_1",  "Door_Locked_6_rot"],
	["BIS_Disabled_Door_7",  "Door_Handle_7_rot_1",  "Door_Locked_7_rot"],
	["BIS_Disabled_Door_8",  "Door_Handle_8_rot_1",  "Door_Locked_8_rot"],
	["BIS_Disabled_Door_9",  "Door_Handle_9_rot_1",  "Door_Locked_9_rot"],
	["BIS_Disabled_Door_10", "Door_Handle_10_rot_1", "Door_Locked_10_rot"],
	["BIS_Disabled_Door_11", "Door_Handle_11_rot_1", "Door_Locked_11_rot"],
	["BIS_Disabled_Door_12", "Door_Handle_12_rot_1", "Door_Locked_12_rot"],
	["BIS_Disabled_Door_13", "Door_Handle_13_rot_1", "Door_Locked_13_rot"],
	["BIS_Disabled_Door_14", "Door_Handle_14_rot_1", "Door_Locked_14_rot"],
	["BIS_Disabled_Door_15", "Door_Handle_15_rot_1", "Door_Locked_15_rot"],
	["BIS_Disabled_Door_16", "Door_Handle_16_rot_1", "Door_Locked_16_rot"],
	["BIS_Disabled_Door_17", "Door_Handle_17_rot_1", "Door_Locked_17_rot"],
	["BIS_Disabled_Door_18", "Door_Handle_18_rot_1", "Door_Locked_18_rot"],
	["BIS_Disabled_Door_19", "Door_Handle_19_rot_1", "Door_Locked_19_rot"],
	["BIS_Disabled_Door_20", "Door_Handle_20_rot_1", "Door_Locked_20_rot"],
	["BIS_Disabled_Door_21", "Door_Handle_21_rot_1", "Door_Locked_21_rot"],
	["BIS_Disabled_Door_22", "Door_Handle_22_rot_1", "Door_Locked_22_rot"],
	["", ""],
	["", ""],
	["", ""],
	["", ""],
	["", ""],
	["", ""]
] # _index;
[_animations, _lockedVariable];