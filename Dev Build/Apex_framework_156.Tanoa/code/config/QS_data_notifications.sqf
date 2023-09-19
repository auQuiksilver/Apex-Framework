/*/
File: QS_data_notifications.sqf
Author:

	Quiksilver
	
Last modified:

	15/05/2017 A3 1.70 by Quiksilver
	
Description:

	Notifications Config
__________________________________________________________________________/*/

_case = _this # 0;
_return = [];
if (_case isEqualType '') then {
	if (_case isEqualTo 'Default') then {
		_return = [
			/*/color array/*/ 				[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/colorIconPicture array/*/	[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/colorIconText array/*/ 		[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/description string/*/ 		'%2',
			/*/difficulties array/*/ 		[],
			/*/duration number/*/ 			5,
			/*/iconPicture string/*/ 		'',
			/*/iconText string/*/ 			'',
			/*/iconSize number/*/			1,
			/*/priority number/*/ 			0,
			/*/sound string/*/ 				'QS_audio_notification_2',
			/*/soundClose string/*/ 		'QS_audio_notification_2Close',
			/*/soundRadio string/*/ 		'',
			/*/title string/*/ 				''
		];
	};
	if (_case isEqualTo 'TaskAssigned') then {
		_return = [
			/*/color array/*/ 				[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/colorIconPicture array/*/	[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/colorIconText array/*/ 		[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/description string/*/ 		'%2',
			/*/difficulties array/*/ 		[],
			/*/duration number/*/ 			5,
			/*/iconPicture string/*/ 		'\A3\ui_f\data\map\mapcontrol\taskIcon_ca.paa',
			/*/iconText string/*/ 			'',
			/*/iconSize number/*/			1,
			/*/priority number/*/ 			5,
			/*/sound string/*/ 				'QS_audio_notification_2',
			/*/soundClose string/*/ 		'QS_audio_notification_2Close',
			/*/soundRadio string/*/ 		'',
			/*/title string/*/ 				(localize 'STR_QS_Notif_117')
		];	
	};
	if (_case isEqualTo 'TaskCanceled') then {
		_return = [
			/*/color array/*/ 				[0.7,0.7,0.7,1],
			/*/colorIconPicture array/*/	[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/colorIconText array/*/ 		[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/description string/*/ 		'%2',
			/*/difficulties array/*/ 		[],
			/*/duration number/*/ 			5,
			/*/iconPicture string/*/ 		'\A3\ui_f\data\map\mapcontrol\taskIconCanceled_ca.paa',
			/*/iconText string/*/ 			'',
			/*/iconSize number/*/			1,
			/*/priority number/*/ 			6,
			/*/sound string/*/ 				'QS_audio_notification_2',
			/*/soundClose string/*/ 		'QS_audio_notification_2Close',
			/*/soundRadio string/*/ 		'',
			/*/title string/*/ 				(localize 'STR_QS_Notif_118')
		];	
	};
	if (_case isEqualTo 'TaskCreated') then {
		_return = [
			/*/color array/*/ 				[1,1,1,1],
			/*/colorIconPicture array/*/	[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/colorIconText array/*/ 		[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/description string/*/ 		'%2',
			/*/difficulties array/*/ 		[],
			/*/duration number/*/ 			5,
			/*/iconPicture string/*/ 		'\A3\ui_f\data\map\mapcontrol\taskIconCreated_ca.paa',
			/*/iconText string/*/ 			'',
			/*/iconSize number/*/			1,
			/*/priority number/*/ 			5,
			/*/sound string/*/ 				'QS_audio_notification_2',
			/*/soundClose string/*/ 		'QS_audio_notification_2Close',
			/*/soundRadio string/*/ 		'',
			/*/title string/*/ 				(localize 'STR_QS_Notif_119')
		];	
	};	
	if (_case isEqualTo 'TaskFailed') then {
		_return = [
			/*/color array/*/ 				[1,0.3,0.2,1],
			/*/colorIconPicture array/*/	[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/colorIconText array/*/ 		[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/description string/*/ 		'%2',
			/*/difficulties array/*/ 		[],
			/*/duration number/*/ 			5,
			/*/iconPicture string/*/ 		'\A3\ui_f\data\map\mapcontrol\taskIconCreated_ca.paa',
			/*/iconText string/*/ 			'',
			/*/iconSize number/*/			1,
			/*/priority number/*/ 			5,
			/*/sound string/*/ 				'QS_audio_notification_2',
			/*/soundClose string/*/ 		'QS_audio_notification_2Close',
			/*/soundRadio string/*/ 		'',
			/*/title string/*/ 				(localize 'STR_QS_Notif_120')
		];	
	};
	if (_case isEqualTo 'TaskSucceeded') then {
		_return = [
			/*/color array/*/ 				[0.7,1,0.3,1],
			/*/colorIconPicture array/*/	[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/colorIconText array/*/ 		[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/description string/*/ 		'%2',
			/*/difficulties array/*/ 		[],
			/*/duration number/*/ 			5,
			/*/iconPicture string/*/ 		'\A3\ui_f\data\map\mapcontrol\taskIconDone_ca.paa',
			/*/iconText string/*/ 			'',
			/*/iconSize number/*/			1,
			/*/priority number/*/ 			6,
			/*/sound string/*/ 				'QS_audio_notification_2',
			/*/soundClose string/*/ 		'QS_audio_notification_2Close',
			/*/soundRadio string/*/ 		'',
			/*/title string/*/ 				(localize 'STR_QS_Notif_121')
		];	
	};
	if (_case isEqualTo 'TaskUpdated') then {
		_return = [
			/*/color array/*/ 				[0.7,1,0.3,1],
			/*/colorIconPicture array/*/	[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/colorIconText array/*/ 		[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/description string/*/ 		'%2',
			/*/difficulties array/*/ 		[],
			/*/duration number/*/ 			5,
			/*/iconPicture string/*/ 		'\A3\ui_f\data\map\mapcontrol\taskIcon_ca.paa',
			/*/iconText string/*/ 			'',
			/*/iconSize number/*/			1,
			/*/priority number/*/ 			6,
			/*/sound string/*/ 				'QS_audio_notification_2',
			/*/soundClose string/*/ 		'QS_audio_notification_2Close',
			/*/soundRadio string/*/ 		'',
			/*/title string/*/ 				(localize 'STR_QS_Notif_122')
		];	
	};
	if (_case isEqualTo 'NewMain') then {
		_return = [
			/*/color array/*/ 				[1,0.81,0.06,1],
			/*/colorIconPicture array/*/	[1,0.81,0.06,1],
			/*/colorIconText array/*/ 		[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/description string/*/ 		(localize 'STR_QS_Notif_123') + ' %1',
			/*/difficulties array/*/ 		[],
			/*/duration number/*/ 			5,
			/*/iconPicture string/*/ 		'media\images\notificons\main_objective.paa',
			/*/iconText string/*/ 			'',
			/*/iconSize number/*/			1,
			/*/priority number/*/ 			9,
			/*/sound string/*/ 				'QS_audio_notification_2',
			/*/soundClose string/*/ 		'QS_audio_notification_2Close',
			/*/soundRadio string/*/ 		'',
			/*/title string/*/ 				(localize 'STR_QS_Notif_126')
		];
	};
	if (_case isEqualTo 'CompletedMain') then {
		_return = [
			/*/color array/*/ 				[1,0.81,0.06,1],
			/*/colorIconPicture array/*/	[1,0.81,0.06,1],
			/*/colorIconText array/*/ 		[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/description string/*/ 		(localize 'STR_QS_Notif_124') + ' %1',
			/*/difficulties array/*/ 		[],
			/*/duration number/*/ 			5,
			/*/iconPicture string/*/ 		'media\images\notificons\main_objective_completed.paa',
			/*/iconText string/*/ 			'',
			/*/iconSize number/*/			1,
			/*/priority number/*/ 			9,
			/*/sound string/*/ 				'QS_audio_notification_2',
			/*/soundClose string/*/ 		'QS_audio_notification_2Close',
			/*/soundRadio string/*/ 		'',
			/*/title string/*/ 				(localize 'STR_QS_Notif_125')
		];
	};
	if (_case isEqualTo 'NewMainDefend') then {
		_return = [
			/*/color array/*/ 				[1,0.81,0.06,1],
			/*/colorIconPicture array/*/	[1,0.81,0.06,1],
			/*/colorIconText array/*/ 		[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/description string/*/ 		(localize 'STR_QS_Notif_003') + ' %1',
			/*/difficulties array/*/ 		[],
			/*/duration number/*/ 			5,
			/*/iconPicture string/*/ 		'media\images\notificons\defendtarget.paa',
			/*/iconText string/*/ 			'',
			/*/iconSize number/*/			1,
			/*/priority number/*/ 			9,
			/*/sound string/*/ 				'QS_audio_notification_2',
			/*/soundClose string/*/ 		'QS_audio_notification_2Close',
			/*/soundRadio string/*/ 		'',
			/*/title string/*/ 				(localize 'STR_QS_Notif_127')
		];
	};
	if (_case isEqualTo 'CompletedMainDefended') then {
		_return = [
			/*/color array/*/ 				[1,0.81,0.06,1],
			/*/colorIconPicture array/*/	[1,0.81,0.06,1],
			/*/colorIconText array/*/ 		[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/description string/*/ 		(localize 'STR_QS_Notif_128') + ' %1',
			/*/difficulties array/*/ 		[],
			/*/duration number/*/ 			5,
			/*/iconPicture string/*/ 		'media\images\notificons\main_objective_completed.paa',
			/*/iconText string/*/ 			'',
			/*/iconSize number/*/			1,
			/*/priority number/*/ 			9,
			/*/sound string/*/ 				'QS_audio_notification_2',
			/*/soundClose string/*/ 		'QS_audio_notification_2Close',
			/*/soundRadio string/*/ 		'',
			/*/title string/*/ 				(localize 'STR_QS_Notif_129')
		];
	};
	if (_case isEqualTo 'NewSub') then {
		_return = [
			/*/color array/*/ 				[1,0.81,0.06,1],
			/*/colorIconPicture array/*/	[1,0.81,0.06,1],
			/*/colorIconText array/*/ 		[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/description string/*/ 		'%1',
			/*/difficulties array/*/ 		[],
			/*/duration number/*/ 			5,
			/*/iconPicture string/*/ 		'media\images\notificons\sub_objective.paa',
			/*/iconText string/*/ 			'',
			/*/iconSize number/*/			1,
			/*/priority number/*/ 			8,
			/*/sound string/*/ 				'QS_audio_notification_2',
			/*/soundClose string/*/ 		'QS_audio_notification_2Close',
			/*/soundRadio string/*/ 		'',
			/*/title string/*/ 				(localize 'STR_QS_Notif_130')
		];
	};
	if (_case isEqualTo 'CompletedSub') then {
		_return = [
			/*/color array/*/ 				[1,0.81,0.06,1],
			/*/colorIconPicture array/*/	[1,0.81,0.06,1],
			/*/colorIconText array/*/ 		[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/description string/*/ 		'%1',
			/*/difficulties array/*/ 		[],
			/*/duration number/*/ 			5,
			/*/iconPicture string/*/ 		'media\images\notificons\sub_objective_completed.paa',
			/*/iconText string/*/ 			'',
			/*/iconSize number/*/			1,
			/*/priority number/*/ 			8,
			/*/sound string/*/ 				'QS_audio_notification_2',
			/*/soundClose string/*/ 		'QS_audio_notification_2Close',
			/*/soundRadio string/*/ 		'',
			/*/title string/*/ 				(localize 'STR_QS_Notif_131')
		];
	};
	if (_case isEqualTo 'NewSideMission') then {
		_return = [
			/*/color array/*/ 				[0,0.7,0.93,1],
			/*/colorIconPicture array/*/	[0,0.7,0.93,1],
			/*/colorIconText array/*/ 		[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/description string/*/ 		'%1',
			/*/difficulties array/*/ 		[],
			/*/duration number/*/ 			5,
			/*/iconPicture string/*/ 		'media\images\notificons\side_mission.paa',
			/*/iconText string/*/ 			'',
			/*/iconSize number/*/			1,
			/*/priority number/*/ 			7,
			/*/sound string/*/ 				'QS_audio_notification_2',
			/*/soundClose string/*/ 		'QS_audio_notification_2Close',
			/*/soundRadio string/*/ 		'',
			/*/title string/*/ 				localize 'STR_QS_Notif_132'
		];
	};
	if (_case isEqualTo 'NewSideMissionFileData') then {
		_return = [
			/*/color array/*/ 				[0,0.7,0.93,1],
			/*/colorIconPicture array/*/	[0,0.7,0.93,1],
			/*/colorIconText array/*/ 		[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/description string/*/ 		'%1',
			/*/difficulties array/*/ 		[],
			/*/duration number/*/ 			5,
			/*/iconPicture string/*/ 		'media\images\notificons\laptop.paa',
			/*/iconText string/*/ 			'',
			/*/iconSize number/*/			1,
			/*/priority number/*/ 			7,
			/*/sound string/*/ 				'QS_audio_notification_2',
			/*/soundClose string/*/ 		'QS_audio_notification_2Close',
			/*/soundRadio string/*/ 		'',
			/*/title string/*/ 				localize 'STR_QS_Notif_132'
		];
	};
	if (_case isEqualTo 'NewSideMissionFileDataComplete') then {
		_return = [
			/*/color array/*/ 				[0.38,0.81,0.16,1],
			/*/colorIconPicture array/*/	[0.38,0.81,0.16,1],
			/*/colorIconText array/*/ 		[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/description string/*/ 		'%1',
			/*/difficulties array/*/ 		[],
			/*/duration number/*/ 			5,
			/*/iconPicture string/*/ 		'media\images\notificons\laptop.paa',
			/*/iconText string/*/ 			'',
			/*/iconSize number/*/			1,
			/*/priority number/*/ 			6,
			/*/sound string/*/ 				'QS_audio_notification_2',
			/*/soundClose string/*/ 		'QS_audio_notification_2Close',
			/*/soundRadio string/*/ 		'',
			/*/title string/*/ 				localize 'STR_QS_Notif_133'
		];
	};
	if (_case isEqualTo 'NewSideMissionRadar') then {
		_return = [
			/*/color array/*/ 				[0,0.7,0.93,1],
			/*/colorIconPicture array/*/	[0,0.7,0.93,1],
			/*/colorIconText array/*/ 		[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/description string/*/ 		'%1',
			/*/difficulties array/*/ 		[],
			/*/duration number/*/ 			5,
			/*/iconPicture string/*/ 		'media\images\notificons\smdestroyradar.paa',
			/*/iconText string/*/ 			'',
			/*/iconSize number/*/			1,
			/*/priority number/*/ 			7,
			/*/sound string/*/ 				'QS_audio_notification_2',
			/*/soundClose string/*/ 		'QS_audio_notification_2Close',
			/*/soundRadio string/*/ 		'',
			/*/title string/*/ 				localize 'STR_QS_Notif_132'
		];
	};
	if (_case isEqualTo 'CompletedSideMission') then {
		_return = [
			/*/color array/*/ 				[0,0.7,0.93,1],
			/*/colorIconPicture array/*/	[0,0.7,0.93,1],
			/*/colorIconText array/*/ 		[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/description string/*/ 		'%1',
			/*/difficulties array/*/ 		[],
			/*/duration number/*/ 			5,
			/*/iconPicture string/*/ 		'media\images\notificons\side_mission_completed.paa',
			/*/iconText string/*/ 			'',
			/*/iconSize number/*/			1,
			/*/priority number/*/ 			8,
			/*/sound string/*/ 				'QS_audio_notification_2',
			/*/soundClose string/*/ 		'QS_audio_notification_2Close',
			/*/soundRadio string/*/ 		'',
			/*/title string/*/ 				localize 'STR_QS_Notif_134'
		];
	};
	if (_case isEqualTo 'NewPriorityTarget') then {
		_return = [
			/*/color array/*/ 				[0.8,0.13,0.14,1],
			/*/colorIconPicture array/*/	[0.8,0.13,0.14,1],
			/*/colorIconText array/*/ 		[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/description string/*/ 		'%1',
			/*/difficulties array/*/ 		[],
			/*/duration number/*/ 			5,
			/*/iconPicture string/*/ 		'media\images\notificons\priority_target.paa',
			/*/iconText string/*/ 			'',
			/*/iconSize number/*/			1,
			/*/priority number/*/ 			10,
			/*/sound string/*/ 				'QS_audio_notification_2',
			/*/soundClose string/*/ 		'QS_audio_notification_2Close',
			/*/soundRadio string/*/ 		'',
			/*/title string/*/ 				localize 'STR_QS_Notif_135'
		];
	};
	if (_case isEqualTo 'CompletedPriorityTarget') then {
		_return = [
			/*/color array/*/ 				[0.8,0.13,0.14,1],
			/*/colorIconPicture array/*/	[0.8,0.13,0.14,1],
			/*/colorIconText array/*/ 		[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/description string/*/ 		'%1',
			/*/difficulties array/*/ 		[],
			/*/duration number/*/ 			5,
			/*/iconPicture string/*/ 		'media\images\notificons\priority_target_neutralised.paa',
			/*/iconText string/*/ 			'',
			/*/iconSize number/*/			1,
			/*/priority number/*/ 			10,
			/*/sound string/*/ 				'QS_audio_notification_2',
			/*/soundClose string/*/ 		'QS_audio_notification_2Close',
			/*/soundRadio string/*/ 		'',
			/*/title string/*/ 				localize 'STR_QS_Notif_136'
		];
	};
	if (_case isEqualTo 'EnemyJetDown') then {
		_return = [
			/*/color array/*/ 				[1,0.81,0.06,1],
			/*/colorIconPicture array/*/	[1,0.81,0.06,1],
			/*/colorIconText array/*/ 		[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/description string/*/ 		'%1',
			/*/difficulties array/*/ 		[],
			/*/duration number/*/ 			5,
			/*/iconPicture string/*/ 		'media\images\icons\iconPlane_ca.paa',
			/*/iconText string/*/ 			'',
			/*/iconSize number/*/			1,
			/*/priority number/*/ 			8,
			/*/sound string/*/ 				'QS_audio_notification_2',
			/*/soundClose string/*/ 		'QS_audio_notification_2Close',
			/*/soundRadio string/*/ 		'',
			/*/title string/*/ 				localize 'STR_QS_Notif_137'
		];
	};
	if (_case isEqualTo 'EnemyJet') then {
		_return = [
			/*/color array/*/ 				[0.8,0.13,0.14,1],
			/*/colorIconPicture array/*/	[0.8,0.13,0.14,1],
			/*/colorIconText array/*/ 		[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/description string/*/ 		'%1',
			/*/difficulties array/*/ 		[],
			/*/duration number/*/ 			5,
			/*/iconPicture string/*/ 		'media\images\icons\iconPlane_ca.paa',
			/*/iconText string/*/ 			'',
			/*/iconSize number/*/			1,
			/*/priority number/*/ 			8,
			/*/sound string/*/ 				'QS_audio_notification_2',
			/*/soundClose string/*/ 		'QS_audio_notification_2Close',
			/*/soundRadio string/*/ 		'',
			/*/title string/*/ 				localize 'STR_QS_Notif_138'
		];
	};
	if (_case isEqualTo 'NewSideMissionJet') then {
		_return = [
			/*/color array/*/ 				[0.8,0.13,0.14,1],
			/*/colorIconPicture array/*/	[0.8,0.13,0.14,1],
			/*/colorIconText array/*/ 		[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/description string/*/ 		'%1',
			/*/difficulties array/*/ 		[],
			/*/duration number/*/ 			5,
			/*/iconPicture string/*/ 		'media\images\notificons\enemyJetinbound.paa',
			/*/iconText string/*/ 			'',
			/*/iconSize number/*/			1,
			/*/priority number/*/ 			8,
			/*/sound string/*/ 				'QS_audio_notification_2',
			/*/soundClose string/*/ 		'QS_audio_notification_2Close',
			/*/soundRadio string/*/ 		'',
			/*/title string/*/ 				localize 'STR_QS_Notif_132'
		];
	};
	if (_case isEqualTo 'Reward') then {
		_return = [
			/*/color array/*/ 				[0.38,0.81,0.16,1],
			/*/colorIconPicture array/*/	[0.38,0.81,0.16,1],
			/*/colorIconText array/*/ 		[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/description string/*/ 		'%1',
			/*/difficulties array/*/ 		[],
			/*/duration number/*/ 			5,
			/*/iconPicture string/*/ 		'media\images\notificons\reward.paa',
			/*/iconText string/*/ 			'',
			/*/iconSize number/*/			1,
			/*/priority number/*/ 			4,
			/*/sound string/*/ 				'QS_audio_notification_2',
			/*/soundClose string/*/ 		'QS_audio_notification_2Close',
			/*/soundRadio string/*/ 		'',
			/*/title string/*/ 				localize 'STR_QS_Notif_139'
		];
	};
	if (_case isEqualTo 'Reward2') then {
		_return = [
			/*/color array/*/ 				[0.38,0.81,0.16,1],
			/*/colorIconPicture array/*/	[0.38,0.81,0.16,1],
			/*/colorIconText array/*/ 		[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/description string/*/ 		'%1',
			/*/difficulties array/*/ 		[],
			/*/duration number/*/ 			5,
			/*/iconPicture string/*/ 		'media\images\notificons\reward.paa',
			/*/iconText string/*/ 			'',
			/*/iconSize number/*/			1,
			/*/priority number/*/ 			4,
			/*/sound string/*/ 				'QS_audio_notification_2',
			/*/soundClose string/*/ 		'QS_audio_notification_2Close',
			/*/soundRadio string/*/ 		'',
			/*/title string/*/ 				localize 'STR_QS_Notif_139'
		];
	};
	if (_case isEqualTo 'ScoreBonus') then {
		_return = [
			/*/color array/*/ 				[0.38,0.81,0.16,1],
			/*/colorIconPicture array/*/	[0.38,0.81,0.16,1],
			/*/colorIconText array/*/ 		[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/description string/*/ 		'%1',
			/*/difficulties array/*/ 		[],
			/*/duration number/*/ 			5,
			/*/iconPicture string/*/ 		'media\images\notificons\score_bonus.paa',
			/*/iconText string/*/ 			'+%2',
			/*/iconSize number/*/			1,
			/*/priority number/*/ 			5,
			/*/sound string/*/ 				'QS_audio_notification_2',
			/*/soundClose string/*/ 		'QS_audio_notification_2Close',
			/*/soundRadio string/*/ 		'',
			/*/title string/*/ 				localize 'STR_QS_Notif_140'
		];
	};
	if (_case isEqualTo 'aoSmallTaskCreated') then {
		_return = [
			/*/color array/*/ 				[1,1,1,1],
			/*/colorIconPicture array/*/	[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/colorIconText array/*/ 		[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/description string/*/ 		'%2',
			/*/difficulties array/*/ 		[],
			/*/duration number/*/ 			5,
			/*/iconPicture string/*/ 		'\A3\ui_f\data\map\mapcontrol\taskIconCreated_ca.paa',
			/*/iconText string/*/ 			'',
			/*/iconSize number/*/			1,
			/*/priority number/*/ 			5,
			/*/sound string/*/ 				'QS_audio_notification_2',
			/*/soundClose string/*/ 		'QS_audio_notification_2Close',
			/*/soundRadio string/*/ 		'',
			/*/title string/*/ 				localize 'STR_QS_Notif_141'
		];	
	};
	if (_case isEqualTo 'aoSmallTaskSucceeded') then {
		_return = [
			/*/color array/*/ 				[0.7,1,0.3,1],
			/*/colorIconPicture array/*/	[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/colorIconText array/*/ 		[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/description string/*/ 		'%2',
			/*/difficulties array/*/ 		[],
			/*/duration number/*/ 			5,
			/*/iconPicture string/*/ 		'\A3\ui_f\data\map\mapcontrol\taskIconDone_ca.paa',
			/*/iconText string/*/ 			'',
			/*/iconSize number/*/			1,
			/*/priority number/*/ 			6,
			/*/sound string/*/ 				'QS_audio_notification_2',
			/*/soundClose string/*/ 		'QS_audio_notification_2Close',
			/*/soundRadio string/*/ 		'',
			/*/title string/*/ 				localize 'STR_QS_Notif_142'
		];	
	};
	if (_case isEqualTo 'aoSmallTaskFailed') then {
		_return = [
			/*/color array/*/ 				[1,0.3,0.2,1],
			/*/colorIconPicture array/*/	[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/colorIconText array/*/ 		[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/description string/*/ 		'%2',
			/*/difficulties array/*/ 		[],
			/*/duration number/*/ 			5,
			/*/iconPicture string/*/ 		'\A3\ui_f\data\map\mapcontrol\taskIconCreated_ca.paa',
			/*/iconText string/*/ 			'',
			/*/iconSize number/*/			1,
			/*/priority number/*/ 			5,
			/*/sound string/*/ 				'QS_audio_notification_2',
			/*/soundClose string/*/ 		'QS_audio_notification_2Close',
			/*/soundRadio string/*/ 		'',
			/*/title string/*/ 				localize 'STR_QS_Notif_143'
		];	
	};
	if (_case isEqualTo 'hcTaskCreated') then {
		_return = [
			/*/color array/*/ 				[1,1,1,1],
			/*/colorIconPicture array/*/	[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/colorIconText array/*/ 		[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/description string/*/ 		'%2',
			/*/difficulties array/*/ 		[],
			/*/duration number/*/ 			5,
			/*/iconPicture string/*/ 		'a3\ui_f\data\gui\cfg\ranks\colonel_pr.paa',
			/*/iconText string/*/ 			'',
			/*/iconSize number/*/			1,
			/*/priority number/*/ 			5,
			/*/sound string/*/ 				'QS_audio_notification_2',
			/*/soundClose string/*/ 		'QS_audio_notification_2Close',
			/*/soundRadio string/*/ 		'',
			/*/title string/*/ 				localize 'STR_QS_Notif_144'
		];	
	};
	if (_case isEqualTo 'hcTaskSucceeded') then {
		_return = [
			/*/color array/*/ 				[0.7,1,0.3,1],
			/*/colorIconPicture array/*/	[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/colorIconText array/*/ 		[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/description string/*/ 		'%2',
			/*/difficulties array/*/ 		[],
			/*/duration number/*/ 			5,
			/*/iconPicture string/*/ 		'a3\ui_f\data\gui\cfg\ranks\colonel_pr.paa',
			/*/iconText string/*/ 			'',
			/*/iconSize number/*/			1,
			/*/priority number/*/ 			6,
			/*/sound string/*/ 				'QS_audio_notification_2',
			/*/soundClose string/*/ 		'QS_audio_notification_2Close',
			/*/soundRadio string/*/ 		'',
			/*/title string/*/ 				localize 'STR_QS_Notif_144'
		];	
	};
	if (_case isEqualTo 'hcTaskFailed') then {
		_return = [
			/*/color array/*/ 				[1,0.3,0.2,1],
			/*/colorIconPicture array/*/	[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/colorIconText array/*/ 		[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/description string/*/ 		'%2',
			/*/difficulties array/*/ 		[],
			/*/duration number/*/ 			5,
			/*/iconPicture string/*/ 		'a3\ui_f\data\gui\cfg\ranks\colonel_pr.paa',
			/*/iconText string/*/ 			'',
			/*/iconSize number/*/			1,
			/*/priority number/*/ 			5,
			/*/sound string/*/ 				'QS_audio_notification_2',
			/*/soundClose string/*/ 		'QS_audio_notification_2Close',
			/*/soundRadio string/*/ 		'',
			/*/title string/*/ 				localize 'STR_QS_Notif_144'
		];	
	};
	if (_case isEqualTo 'System') then {
		_return = [
			/*/color array/*/ 				[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/colorIconPicture array/*/	[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/colorIconText array/*/ 		[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/description string/*/ 		'%2',
			/*/difficulties array/*/ 		[],
			/*/duration number/*/ 			10,
			/*/iconPicture string/*/ 		'media\images\insignia\comm_patch.paa',
			/*/iconText string/*/ 			'',
			/*/iconSize number/*/			1,
			/*/priority number/*/ 			10,
			/*/sound string/*/ 				'QS_audio_notification_2',
			/*/soundClose string/*/ 		'QS_audio_notification_2Close',
			/*/soundRadio string/*/ 		'',
			/*/title string/*/ 				localize 'STR_QS_Notif_145'
		];
	};
	if (_case isEqualTo 'CUSTOM_GEORGETOWN') then {
		_return = [
			/*/color array/*/ 				[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/colorIconPicture array/*/	[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/colorIconText array/*/ 		[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/description string/*/ 		'%2',
			/*/difficulties array/*/ 		[],
			/*/duration number/*/ 			10,
			/*/iconPicture string/*/ 		'media\images\insignia\comm_patch.paa',
			/*/iconText string/*/ 			'',
			/*/iconSize number/*/			1,
			/*/priority number/*/ 			10,
			/*/sound string/*/ 				'QS_audio_notification_2',
			/*/soundClose string/*/ 		'QS_audio_notification_2Close',
			/*/soundRadio string/*/ 		'',
			/*/title string/*/ 				([localize 'STR_QS_Notif_146',localize 'STR_QS_Notif_147'] select (worldName isEqualTo 'Tanoa'))
		];
	};
	if (_case isEqualTo 'CUSTOM_GEORGETOWN_SUCCESS') then {
		_return = [
			/*/color array/*/ 				[1,0.81,0.06,1],
			/*/colorIconPicture array/*/	[1,0.81,0.06,1],
			/*/colorIconText array/*/ 		[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/description string/*/ 		localize 'STR_QS_Notif_148',
			/*/difficulties array/*/ 		[],
			/*/duration number/*/ 			5,
			/*/iconPicture string/*/ 		'media\images\notificons\main_objective_completed.paa',
			/*/iconText string/*/ 			'',
			/*/iconSize number/*/			1,
			/*/priority number/*/ 			9,
			/*/sound string/*/ 				'QS_audio_notification_2',
			/*/soundClose string/*/ 		'QS_audio_notification_2Close',
			/*/soundRadio string/*/ 		'',
			/*/title string/*/ 				([localize 'STR_QS_Notif_146',localize 'STR_QS_Notif_147'] select (worldName isEqualTo 'Tanoa'))
		];
	};
	if (_case isEqualTo 'CUSTOM_GEORGETOWN_FAILED') then {
		_return = [
			/*/color array/*/ 				[1,0.81,0.06,1],
			/*/colorIconPicture array/*/	[1,0.81,0.06,1],
			/*/colorIconText array/*/ 		[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/description string/*/ 		localize 'STR_QS_Notif_149',
			/*/difficulties array/*/ 		[],
			/*/duration number/*/ 			5,
			/*/iconPicture string/*/ 		'media\images\notificons\main_objective_completed.paa',
			/*/iconText string/*/ 			'',
			/*/iconSize number/*/			1,
			/*/priority number/*/ 			9,
			/*/sound string/*/ 				'QS_audio_notification_2',
			/*/soundClose string/*/ 		'QS_audio_notification_2Close',
			/*/soundRadio string/*/ 		'',
			/*/title string/*/ 				([localize 'STR_QS_Notif_146',localize 'STR_QS_Notif_147'] select (worldName isEqualTo 'Tanoa'))
		];
	};
	if (_case isEqualTo 'SC_INIT') then {
		_return = [
			/*/color array/*/ 				[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/colorIconPicture array/*/	[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/colorIconText array/*/ 		[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/description string/*/ 		'%2',
			/*/difficulties array/*/ 		[],
			/*/duration number/*/ 			10,
			/*/iconPicture string/*/ 		'media\images\notificons\main_objective.paa',
			/*/iconText string/*/ 			'',
			/*/iconSize number/*/			1,
			/*/priority number/*/ 			10,
			/*/sound string/*/ 				'QS_audio_notification_2',
			/*/soundClose string/*/ 		'QS_audio_notification_2Close',
			/*/soundRadio string/*/ 		'',
			/*/title string/*/ 				localize 'STR_QS_Notif_008'
		];
	};
	if (_case isEqualTo 'SC_UPDATE_GOOD') then {
		_return = [
			/*/color array/*/ 				[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/colorIconPicture array/*/	[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/colorIconText array/*/ 		[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/description string/*/ 		'%2',
			/*/difficulties array/*/ 		[],
			/*/duration number/*/ 			5,
			/*/iconPicture string/*/ 		'%1',
			/*/iconText string/*/ 			'',
			/*/iconSize number/*/			1,
			/*/priority number/*/ 			6,
			/*/sound string/*/ 				'QS_audio_notification_2',
			/*/soundClose string/*/ 		'QS_audio_notification_2Close',
			/*/soundRadio string/*/ 		'',
			/*/title string/*/ 				localize 'STR_QS_Notif_008'
		];
	};
	if (_case isEqualTo 'SC_UPDATE_BAD') then {
		_return = [
			/*/color array/*/ 				[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/colorIconPicture array/*/	[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/colorIconText array/*/ 		[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/description string/*/ 		'%2',
			/*/difficulties array/*/ 		[],
			/*/duration number/*/ 			5,
			/*/iconPicture string/*/ 		'%1',
			/*/iconText string/*/ 			'',
			/*/iconSize number/*/			1,
			/*/priority number/*/ 			6,
			/*/sound string/*/ 				'QS_audio_notification_2',
			/*/soundClose string/*/ 		'QS_audio_notification_2Close',
			/*/soundRadio string/*/ 		'',
			/*/title string/*/ 				localize 'STR_QS_Notif_008'
		];
	};
	if (_case isEqualTo 'SC_EXIT_GOOD') then {
		_return = [
			/*/color array/*/ 				[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/colorIconPicture array/*/	[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/colorIconText array/*/ 		[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/description string/*/ 		'%2',
			/*/difficulties array/*/ 		[],
			/*/duration number/*/ 			10,
			/*/iconPicture string/*/ 		'media\images\notificons\main_objective_completed.paa',
			/*/iconText string/*/ 			'',
			/*/iconSize number/*/			1,
			/*/priority number/*/ 			10,
			/*/sound string/*/ 				'QS_audio_notification_2',
			/*/soundClose string/*/ 		'QS_audio_notification_2Close',
			/*/soundRadio string/*/ 		'',
			/*/title string/*/ 				localize 'STR_QS_Notif_008'
		];
	};
	if (_case isEqualTo 'SC_EXIT_BAD') then {
		_return = [
			/*/color array/*/ 				[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/colorIconPicture array/*/	[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/colorIconText array/*/ 		[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/description string/*/ 		'%2',
			/*/difficulties array/*/ 		[],
			/*/duration number/*/ 			10,
			/*/iconPicture string/*/ 		'media\images\icons\endDefault_ca.paa',
			/*/iconText string/*/ 			'',
			/*/iconSize number/*/			1,
			/*/priority number/*/ 			10,
			/*/sound string/*/ 				'QS_audio_notification_2',
			/*/soundClose string/*/ 		'QS_audio_notification_2Close',
			/*/soundRadio string/*/ 		'',
			/*/title string/*/ 				localize 'STR_QS_Notif_008'
		];
	};
	if (_case isEqualTo 'SC_SUB_COMPLETED') then {
		_return = [
			/*/color array/*/ 				[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/colorIconPicture array/*/	[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/colorIconText array/*/ 		[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/description string/*/ 		'%2',
			/*/difficulties array/*/ 		[],
			/*/duration number/*/ 			5,
			/*/iconPicture string/*/ 		'media\images\notificons\sub_objective_completed.paa',
			/*/iconText string/*/ 			'',
			/*/iconSize number/*/			1,
			/*/priority number/*/ 			10,
			/*/sound string/*/ 				'QS_audio_notification_2',
			/*/soundClose string/*/ 		'QS_audio_notification_2Close',
			/*/soundRadio string/*/ 		'',
			/*/title string/*/ 				localize 'STR_QS_Notif_008'
		];
	};
	if (_case isEqualTo 'CAS_1') then {
		_return = [
			/*/color array/*/ 				[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/colorIconPicture array/*/	[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/colorIconText array/*/ 		[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/description string/*/ 		'%2',
			/*/difficulties array/*/ 		[],
			/*/duration number/*/ 			5,
			/*/iconPicture string/*/ 		'\a3\UI_F_Jets\Data\CfgUnitInsignia\jets_patch_01.paa',
			/*/iconText string/*/ 			'',
			/*/iconSize number/*/			1,
			/*/priority number/*/ 			10,
			/*/sound string/*/ 				'QS_audio_notification_2',
			/*/soundClose string/*/ 		'QS_audio_notification_2Close',
			/*/soundRadio string/*/ 		'',
			/*/title string/*/ 				localize 'STR_QS_Notif_150'
		];
	};
	if (_case isEqualTo 'FIRESUPPORT_1') then {
		_return = [
			/*/color array/*/ 				[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/colorIconPicture array/*/	[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/colorIconText array/*/ 		[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/description string/*/ 		'%2',
			/*/difficulties array/*/ 		[],
			/*/duration number/*/ 			5,
			/*/iconPicture string/*/ 		'\A3\Ui_f\data\GUI\Cfg\UnitInsignia\111thID_ca.paa',
			/*/iconText string/*/ 			'',
			/*/iconSize number/*/			1,
			/*/priority number/*/ 			10,
			/*/sound string/*/ 				'QS_audio_notification_2',
			/*/soundClose string/*/ 		'QS_audio_notification_2Close',
			/*/soundRadio string/*/ 		'',
			/*/title string/*/ 				localize 'STR_QS_Notif_152'
		];
	};
	if (_case isEqualTo 'FOB_INIT') then {
		_return = [
			/*/color array/*/ 				[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/colorIconPicture array/*/	[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/colorIconText array/*/ 		[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/description string/*/ 		'%2',
			/*/difficulties array/*/ 		[],
			/*/duration number/*/ 			10,
			/*/iconPicture string/*/ 		'\A3\Data_F_Tacops\Logos\arma3_tacops_icon_ca.paa',
			/*/iconText string/*/ 			'',
			/*/iconSize number/*/			1,
			/*/priority number/*/ 			10,
			/*/sound string/*/ 				'QS_audio_notification_2',
			/*/soundClose string/*/ 		'QS_audio_notification_2Close',
			/*/soundRadio string/*/ 		'',
			/*/title string/*/ 				localize 'STR_QS_Notif_151'
		];
	};
	if (_case isEqualTo 'FOB_UPDATE') then {
		_return = [
			/*/color array/*/ 				[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/colorIconPicture array/*/	[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/colorIconText array/*/ 		[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/description string/*/ 		'%2',
			/*/difficulties array/*/ 		[],
			/*/duration number/*/ 			5,
			/*/iconPicture string/*/ 		'\A3\Data_F_Tacops\Logos\arma3_tacops_icon_ca.paa',
			/*/iconText string/*/ 			'',
			/*/iconSize number/*/			1,
			/*/priority number/*/ 			5,
			/*/sound string/*/ 				'QS_audio_notification_2',
			/*/soundClose string/*/ 		'QS_audio_notification_2Close',
			/*/soundRadio string/*/ 		'',
			/*/title string/*/ 				localize 'STR_QS_Notif_151'
		];
	};
	if (_case isEqualTo 'SM_UPDATE') then {
		_return = [
			/*/color array/*/ 				[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/colorIconPicture array/*/	[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/colorIconText array/*/ 		[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/description string/*/ 		'%2',
			/*/difficulties array/*/ 		[],
			/*/duration number/*/ 			10,
			/*/iconPicture string/*/ 		'media\images\notificons\side_mission.paa',
			/*/iconText string/*/ 			'',
			/*/iconSize number/*/			1,
			/*/priority number/*/ 			10,
			/*/sound string/*/ 				'QS_audio_notification_2',
			/*/soundClose string/*/ 		'QS_audio_notification_2Close',
			/*/soundRadio string/*/ 		'',
			/*/title string/*/ 				localize 'STR_QS_Notif_091'
		];
	};
	if (_case isEqualTo 'SM_IDAP_UPDATE') then {
		_return = [
			/*/color array/*/ 				[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/colorIconPicture array/*/	[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/colorIconText array/*/ 		[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/description string/*/ 		'%2',
			/*/difficulties array/*/ 		[],
			/*/duration number/*/ 			10,
			/*/iconPicture string/*/ 		'\A3\Data_F_Orange\Logos\arma3_orange_picture_ca.paa',
			/*/iconText string/*/ 			'',
			/*/iconSize number/*/			1,
			/*/priority number/*/ 			10,
			/*/sound string/*/ 				'QS_audio_notification_2',
			/*/soundClose string/*/ 		'QS_audio_notification_2Close',
			/*/soundRadio string/*/ 		'',
			/*/title string/*/ 				'%1'
		];
	};
	if (_case isEqualTo 'SM_IDAP_BRIEF') then {
		_return = [
			/*/color array/*/ 				[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/colorIconPicture array/*/	[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/colorIconText array/*/ 		[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/description string/*/ 		'%2',
			/*/difficulties array/*/ 		[],
			/*/duration number/*/ 			10,
			/*/iconPicture string/*/ 		'\A3\Data_F_Orange\Logos\arma3_orange_picture_ca.paa',
			/*/iconText string/*/ 			'',
			/*/iconSize number/*/			1,
			/*/priority number/*/ 			10,
			/*/sound string/*/ 				'QS_audio_notification_2',
			/*/soundClose string/*/ 		'QS_audio_notification_2Close',
			/*/soundRadio string/*/ 		'',
			/*/title string/*/ 				'%1'
		];
	};
	if (_case isEqualTo 'SM_IDAP_DEBRIEF') then {
		_return = [
			/*/color array/*/ 				[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/colorIconPicture array/*/	[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/colorIconText array/*/ 		[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/description string/*/ 		'%2',
			/*/difficulties array/*/ 		[],
			/*/duration number/*/ 			10,
			/*/iconPicture string/*/ 		'\A3\Data_F_Orange\Logos\arma3_orange_picture_ca.paa',
			/*/iconText string/*/ 			'',
			/*/iconSize number/*/			1,
			/*/priority number/*/ 			10,
			/*/sound string/*/ 				'QS_audio_notification_2',
			/*/soundClose string/*/ 		'QS_audio_notification_2Close',
			/*/soundRadio string/*/ 		'',
			/*/title string/*/ 				'%1'
		];
	};
	if (_case isEqualTo 'GRID_BRIEF') then {
		_return = [
			/*/color array/*/ 				[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/colorIconPicture array/*/	[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/colorIconText array/*/ 		[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/description string/*/ 		'%2',
			/*/difficulties array/*/ 		[],
			/*/duration number/*/ 			10,
			/*/iconPicture string/*/ 		'\a3\missions_f_patrol\data\img\CombatPatrol.paa',
			/*/iconText string/*/ 			'',
			/*/iconSize number/*/			1,
			/*/priority number/*/ 			10,
			/*/sound string/*/ 				'QS_audio_notification_2',
			/*/soundClose string/*/ 		'QS_audio_notification_2Close',
			/*/soundRadio string/*/ 		'',
			/*/title string/*/ 				'%1'
		];
	};
	if (_case isEqualTo 'GRID_UPDATE') then {
		_return = [
			/*/color array/*/ 				[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/colorIconPicture array/*/	[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/colorIconText array/*/ 		[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/description string/*/ 		'%2',
			/*/difficulties array/*/ 		[],
			/*/duration number/*/ 			10,
			/*/iconPicture string/*/ 		'\a3\missions_f_patrol\data\img\CombatPatrol.paa',
			/*/iconText string/*/ 			'',
			/*/iconSize number/*/			1,
			/*/priority number/*/ 			10,
			/*/sound string/*/ 				'QS_audio_notification_2',
			/*/soundClose string/*/ 		'QS_audio_notification_2Close',
			/*/soundRadio string/*/ 		'',
			/*/title string/*/ 				'%1'
		];
	};
	if (_case isEqualTo 'GRID_IDAP_UPDATE') then {
		_return = [
			/*/color array/*/ 				[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/colorIconPicture array/*/	[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/colorIconText array/*/ 		[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/description string/*/ 		'%2',
			/*/difficulties array/*/ 		[],
			/*/duration number/*/ 			10,
			/*/iconPicture string/*/ 		'\A3\Data_F_Orange\Logos\arma3_orange_picture_ca.paa',
			/*/iconText string/*/ 			'',
			/*/iconSize number/*/			1,
			/*/priority number/*/ 			10,
			/*/sound string/*/ 				'QS_audio_notification_2',
			/*/soundClose string/*/ 		'QS_audio_notification_2Close',
			/*/soundRadio string/*/ 		'',
			/*/title string/*/ 				'%1'
		];
	};
	if (_case isEqualTo 'GRID_IG_UPDATE') then {
		_return = [
			/*/color array/*/ 				[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/colorIconPicture array/*/	[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/colorIconText array/*/ 		[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/description string/*/ 		'%2',
			/*/difficulties array/*/ 		[],
			/*/duration number/*/ 			10,
			/*/iconPicture string/*/ 		'\a3\UI_F_TacOps\Data\CfgUnitInsignia\csat_scimitarRegiment_ca.paa',
			/*/iconText string/*/ 			'',
			/*/iconSize number/*/			1,
			/*/priority number/*/ 			10,
			/*/sound string/*/ 				'QS_audio_notification_2',
			/*/soundClose string/*/ 		'QS_audio_notification_2Close',
			/*/soundRadio string/*/ 		'',
			/*/title string/*/ 				'%1'
		];
	};
	if (_case isEqualTo 'DEFEND_HQ') then {
		_return = [
			/*/color array/*/ 				[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/colorIconPicture array/*/	[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/colorIconText array/*/ 		[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/description string/*/ 		'%2',
			/*/difficulties array/*/ 		[],
			/*/duration number/*/ 			10,
			/*/iconPicture string/*/ 		'\a3\UI_F_TacOps\Data\CfgUnitInsignia\csat_scimitarRegiment_ca.paa',
			/*/iconText string/*/ 			'',
			/*/iconSize number/*/			1,
			/*/priority number/*/ 			10,
			/*/sound string/*/ 				'QS_audio_notification_2',
			/*/soundClose string/*/ 		'QS_audio_notification_2Close',
			/*/soundRadio string/*/ 		'',
			/*/title string/*/ 				'%1'
		];
	};
	if (_case isEqualTo 'DEFEND_FAIL') then {
		_return = [
			/*/color array/*/ 				[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/colorIconPicture array/*/	[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/colorIconText array/*/ 		[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/description string/*/ 		'%2',
			/*/difficulties array/*/ 		[],
			/*/duration number/*/ 			10,
			/*/iconPicture string/*/ 		'\a3\UI_F_TacOps\Data\CfgUnitInsignia\csat_scimitarRegiment_ca.paa',
			/*/iconText string/*/ 			'',
			/*/iconSize number/*/			1,
			/*/priority number/*/ 			10,
			/*/sound string/*/ 				'QS_audio_notification_2',
			/*/soundClose string/*/ 		'QS_audio_notification_2Close',
			/*/soundRadio string/*/ 		'',
			/*/title string/*/ 				'%1'
		];
	};
	if (_case isEqualTo 'DEFEND_SUCCESS') then {
		_return = [
			/*/color array/*/ 				[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/colorIconPicture array/*/	[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/colorIconText array/*/ 		[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/description string/*/ 		'%2',
			/*/difficulties array/*/ 		[],
			/*/duration number/*/ 			10,
			/*/iconPicture string/*/ 		(missionNamespace getVariable ['QS_missionConfig_textures_defaultFlag','a3\data_f\flags\flag_nato_co.paa']),
			/*/iconText string/*/ 			'',
			/*/iconSize number/*/			1,
			/*/priority number/*/ 			10,
			/*/sound string/*/ 				'QS_audio_notification_2',
			/*/soundClose string/*/ 		'QS_audio_notification_2Close',
			/*/soundRadio string/*/ 		'',
			/*/title string/*/ 				'%1'
		];
	};
	if (_case isEqualTo 'ST_DESTROY_VEHICLE') then {
		_return = [
			/*/color array/*/ 				[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/colorIconPicture array/*/	[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/colorIconText array/*/ 		[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/description string/*/ 		'%2',
			/*/difficulties array/*/ 		[],
			/*/duration number/*/ 			10,
			/*/iconPicture string/*/ 		'\A3\ui_f\data\igui\cfg\simpleTasks\types\destroy_ca.paa',
			/*/iconText string/*/ 			'',
			/*/iconSize number/*/			1,
			/*/priority number/*/ 			10,
			/*/sound string/*/ 				'QS_audio_notification_2',
			/*/soundClose string/*/ 		'QS_audio_notification_2Close',
			/*/soundRadio string/*/ 		'',
			/*/title string/*/ 				'%1'
		];
	};
	if (_case isEqualTo 'ST_HVT') then {
		_return = [
			/*/color array/*/ 				[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/colorIconPicture array/*/	[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/colorIconText array/*/ 		[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/description string/*/ 		'%2',
			/*/difficulties array/*/ 		[],
			/*/duration number/*/ 			10,
			/*/iconPicture string/*/ 		'\A3\ui_f\data\igui\cfg\simpleTasks\types\intel_ca.paa',
			/*/iconText string/*/ 			'',
			/*/iconSize number/*/			1,
			/*/priority number/*/ 			10,
			/*/sound string/*/ 				'QS_audio_notification_2',
			/*/soundClose string/*/ 		'QS_audio_notification_2Close',
			/*/soundRadio string/*/ 		'',
			/*/title string/*/ 				'%1'
		];
	};
	if (_case isEqualTo 'ST_MEDEVAC') then {
		_return = [
			/*/color array/*/ 				[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/colorIconPicture array/*/	[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/colorIconText array/*/ 		[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/description string/*/ 		'%2',
			/*/difficulties array/*/ 		[],
			/*/duration number/*/ 			5,
			/*/iconPicture string/*/ 		'\A3\ui_f\data\igui\cfg\simpleTasks\types\heal_ca.paa',
			/*/iconText string/*/ 			'',
			/*/iconSize number/*/			1,
			/*/priority number/*/ 			10,
			/*/sound string/*/ 				'QS_audio_notification_2',
			/*/soundClose string/*/ 		'QS_audio_notification_2Close',
			/*/soundRadio string/*/ 		'',
			/*/title string/*/ 				'%1'
		];
	};
	if (_case isEqualTo 'ST_URBAN') then {
		_return = [
			/*/color array/*/ 				[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/colorIconPicture array/*/	[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/colorIconText array/*/ 		[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/description string/*/ 		'%2',
			/*/difficulties array/*/ 		[],
			/*/duration number/*/ 			5,
			/*/iconPicture string/*/ 		'\A3\ui_f\data\igui\cfg\simpleTasks\types\container_ca.paa',
			/*/iconText string/*/ 			'',
			/*/iconSize number/*/			1,
			/*/priority number/*/ 			10,
			/*/sound string/*/ 				'QS_audio_notification_2',
			/*/soundClose string/*/ 		'QS_audio_notification_2Close',
			/*/soundRadio string/*/ 		'',
			/*/title string/*/ 				'%1'
		];
	};
	if (_case isEqualTo 'SM_TRUCK') then {
		_return = [
			/*/color array/*/ 				[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/colorIconPicture array/*/	[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/colorIconText array/*/ 		[(profileNamespace getVariable ['IGUI_TEXT_RGB_R',0]),(profileNamespace getVariable ['IGUI_TEXT_RGB_G',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_B',1]),(profileNamespace getVariable ['IGUI_TEXT_RGB_A',0.8])],
			/*/description string/*/ 		'%2',
			/*/difficulties array/*/ 		[],
			/*/duration number/*/ 			5,
			/*/iconPicture string/*/ 		'\A3\ui_f\data\igui\cfg\simpleTasks\types\truck_ca.paa',
			/*/iconText string/*/ 			'',
			/*/iconSize number/*/			1,
			/*/priority number/*/ 			10,
			/*/sound string/*/ 				'QS_audio_notification_2',
			/*/soundClose string/*/ 		'QS_audio_notification_2Close',
			/*/soundRadio string/*/ 		'',
			/*/title string/*/ 				'%1'
		];
	};
};
_return;