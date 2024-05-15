/*/
File: fn_unloadCargoPlacementMode.sqf
Author:
	
	Quiksilver	(Credit: Sa-Matra for rotational vectoring)
	
Last Modified:

	22/05/2023 A3 2.12 by Quiksilver
	
Description:

	Placement System for unloading cargo
______________________________________________________/*/

params [
	['_vehicle',objNull],
	['_requestedObject',objNull,[objNull,'']],
	['_useHelper',TRUE],
	['_carryMode',FALSE],
	['_showPlacementText',TRUE],
	['_terrainEnabled',TRUE],
	['_sideShiftEnabled',FALSE],
	['_useCurrentPos',FALSE],
	['_oldParent',objNull],
	['_rotationEnabled',TRUE],
	['_frontPos',FALSE],
	['_memPoint',''],
	['_followRotation',FALSE],
	['_updateCOM',TRUE]
];
private _frontVehicleLift = FALSE;
if (dialog) then {closeDialog 2;};
0 spawn {
	while {dialog} do {
		closeDialog 2;
		uiSleep 0.1;
	};
};
private _bbox = [];
uiNamespace setVariable ['QS_localHelper',_useHelper];
if (_useHelper) then {
	if (_requestedObject isEqualType objNull) then {
		if (_requestedObject isKindOf 'CAManBase') then {
			missionNamespace setVariable ['QS_targetBoundingBox_helper',(createVehicleLocal [typeOf _requestedObject,[0,0,0]]),FALSE];
		} else {
			missionNamespace setVariable ['QS_targetBoundingBox_helper',createSimpleObject [typeOf _requestedObject,[0,0,0],TRUE],FALSE];
		};
	} else {
		if (_requestedObject isKindOf 'CAManBase') then {
			missionNamespace setVariable ['QS_targetBoundingBox_helper',(createVehicleLocal [_requestedObject,[0,0,0]]),FALSE];
		} else {
			missionNamespace setVariable ['QS_targetBoundingBox_helper',createSimpleObject [_requestedObject,[0,0,0],TRUE],FALSE];
		};
	};
	if (!isNull _oldParent) then {
		QS_targetBoundingBox_helper disableCollisionWith _oldParent;
	};
	if (_requestedObject isEqualType objNull) then {
		_textures = getObjectTextures _requestedObject;
		{
			QS_targetBoundingBox_helper setObjectTexture [_forEachIndex,_x];
		} forEach _textures;
	};
	uiNamespace setVariable ['QS_targetBoundingBox_target',QS_targetBoundingBox_helper];
} else {
	missionNamespace setVariable ['QS_targetBoundingBox_helper',_requestedObject,FALSE];
	uiNamespace setVariable ['QS_targetBoundingBox_target',_requestedObject];
	if (
		_carryMode &&
		{isObjectHidden _requestedObject}
	) then {
		[71,_requestedObject,FALSE] remoteExec ['QS_fnc_remoteExec',2,FALSE];
	};
};
if (
	(_oldParent isEqualType objNull) &&
	{(_requestedObject isEqualType objNull)}
) then {
	['disableCollisionWith',_requestedObject,_oldParent] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
};
_bbox = QS_hashmap_boundingBoxes getOrDefaultCall [
	toLowerANSI (typeOf QS_targetBoundingBox_helper),
	{0 boundingBoxReal QS_targetBoundingBox_helper},
	TRUE
];
_displayName = QS_hashmap_configfile getOrDefaultCall [
	format ['cfgvehicles_%1_displayname',toLowerANSI (typeOf QS_targetBoundingBox_helper)],
	{getText ((configOf QS_targetBoundingBox_helper) >> 'displayName')},
	TRUE
];
_simulation = QS_hashmap_configfile getOrDefaultCall [
	format ['cfgvehicles_%1_simulation',toLowerANSI (typeOf QS_targetBoundingBox_helper)],
	{toLowerANSI (getText ((configOf QS_targetBoundingBox_helper) >> 'simulation'))},
	TRUE
];
if (_showPlacementText) then {
	50 cutText [localize 'STR_QS_Text_387','PLAIN DOWN',0.333,TRUE,TRUE];
};
if (_bbox isEqualTo []) then {};
_bbox params ['_p1','_p2','_radius'];
_boundingLengths = [(abs ((_p2 # 0) - (_p1 # 0))),(abs ((_p2 # 1) - (_p1 # 1)))];
private _zOffset = abs (((_p2 # 2) - (_p1 # 2)) / 2);
if (_useCurrentPos && (!_useHelper)) then {
	_zOffset = (_vehicle worldToModel (QS_targetBoundingBox_helper modelToWorldVisual [0,0,0])) # 2;
};
_orient = [QS_targetBoundingBox_helper,_vehicle,TRUE] call (missionNamespace getVariable 'BIS_fnc_vectorDirAndUpRelative');
// DETACH
if (isNull _oldParent) then {
	_oldParent = attachedTo QS_targetBoundingBox_helper;
};
if (!isNull (isVehicleCargo QS_targetBoundingBox_helper)) then {
	objNull setVehicleCargo QS_targetBoundingBox_helper;
};
if (!isNull _oldParent) then {
	if (!isNull (attachedTo QS_targetBoundingBox_helper)) then {
		[0,QS_targetBoundingBox_helper] call QS_fnc_eventAttach;
	};
	if (
		(!_useHelper) &&
		(_updateCOM)
	) then {
		[_oldParent,TRUE,TRUE] call QS_fnc_updateCenterOfMass;
	};
};
private _buildRadius = 30;
if (!isNull _oldParent) then {
	_buildRadius = (_oldParent getVariable ['QS_logistics_deployParams',[30,30,30,30,100,30,500]]) # 5;
};
{
	uiNamespace setVariable _x;
} forEach [
	['QS_targetBoundingBox_this',[_vehicle,_requestedObject,_oldParent,_buildRadius]],
	['QS_targetBoundingBox_parent',_vehicle],
	['QS_targetBoundingBox_requestedObject',QS_targetBoundingBox_helper],
	['QS_targetBoundingBox_ASLPos',getPosASLVisual QS_targetBoundingBox_helper],
	['QS_targetBoundingBox_dir',getDirVisual QS_targetBoundingBox_helper],
	['QS_targetBoundingBox_azi',0],
	['QS_targetBoundingBox_vectors',_orient],
	['QS_targetBoundingBox_memPoint',_memPoint],
	['QS_targetBoundingBox_followRotation',_followRotation],
	['QS_targetBoundingBox_bbox',_bbox],
	['QS_targetBoundingBox_xOffset',0],
	['QS_targetBoundingBox_zOffset',_zOffset],
	['QS_targetBoundingBox_drawPos',_vehicle modelToWorldVisual (uiNamespace getVariable ['QS_targetBoundingBox_drawOffset',[0,10,0]])],
	['QS_targetBoundingBox_vectorUp',[0,0,1]],
	['QS_targetBoundingBox_attachTo',[]]
];
_bufferY = 0.1;
_frontModelPos = [0,_vehicle,QS_targetBoundingBox_helper,_bufferY,_rotationEnabled] call QS_fnc_getFrontModelPos;
_frontModelPos set [2,_zOffset];
uiNamespace setVariable ['QS_targetBoundingBox_drawOffset',_frontModelPos];
uiNamespace setVariable ['QS_targetBoundingBox_attachOffset',_frontModelPos];
uiNamespace setVariable ['QS_targetBoundingBox_yOffset',_frontModelPos # 1];
QS_targetBoundingBox_helper setVariable ['QS_attached_frontPos',_frontPos,FALSE];
if (_frontPos) then {
	[2,_vehicle,QS_targetBoundingBox_helper,_bufferY,_rotationEnabled,_memPoint,_followRotation,_zOffset] call QS_fnc_getFrontModelPos;
} else {
	uiNamespace setVariable ['QS_targetBoundingBox_attachTo',[_vehicle,_frontModelPos]];
	if (_memPoint isNotEqualTo '') then {
		uiNamespace setVariable ['QS_targetBoundingBox_attachTo',[_vehicle,_frontModelPos,_memPoint,_followRotation]];
	};
	QS_targetBoundingBox_helper attachTo (uiNamespace getVariable ['QS_targetBoundingBox_attachTo',[_vehicle,_frontModelPos]]);
};

0 spawn {
	sleep (diag_deltaTime * 2)
	call QS_fnc_clientInGameUIPrevAction;
};

_nearEntities = QS_targetBoundingBox_helper nearEntities 30;
['awake',_nearEntities,TRUE] remoteExec ['QS_fnc_remoteExecCmd',_nearEntities,FALSE];
if (
	(!_useHelper) &&
	(!(_vehicle isKindOf 'CAManBase'))
) then {
	_vehicle setVariable ['QS_logistics_child',_requestedObject,TRUE];
	if (_updateCOM) then {
		[_vehicle,TRUE,TRUE] call QS_fnc_updateCenterOfMass;
	};
};
if (local QS_targetBoundingBox_helper) then {
	QS_targetBoundingBox_helper setVectorDirAndUp _orient;
} else {
	['setVectorDirAndUp',QS_targetBoundingBox_helper,_orient] remoteExec ['QS_fnc_remoteExecCmd',QS_targetBoundingBox_helper,FALSE];
	QS_targetBoundingBox_helper addEventHandler [
		'Local',
		{
			params ['_entity','_isLocal'];
			_entity removeEventHandler [_thisEvent,_thisEventHandler];
			if (
				_isLocal &&
				(_entity in (attachedObjects cameraOn)) &&
				(!(_entity getVariable ['QS_attached_frontPos',FALSE]))
			) then {
				_entity setVectorDirAndUp (uiNamespace getVariable ['QS_targetBoundingBox_vectors',[vectorDirVisual QS_targetBoundingBox_helper,vectorUpVisual QS_targetBoundingBox_helper]]);
			};
		}
	];
	['setOwner',QS_targetBoundingBox_helper,clientOwner] remoteExec ['QS_fnc_remoteExecCmd',2,FALSE];
};
uiNamespace setVariable ['QS_targetBoundingBox_azi',(((getDirVisual _vehicle) + (getDirVisual QS_targetBoundingBox_helper)) mod 360)];
QS_EH_placementKeyDown = (findDisplay 46) displayAddEventHandler ['KeyDown',{call QS_fnc_clientEventKeyDown3}];
{
	uiNamespace setVariable _x;
} forEach [
	['QS_uiaction_alt',FALSE],
	['QS_uiaction_altEnabled',_terrainEnabled],
	['QS_uiaction_sideShiftEnabled',_sideShiftEnabled],
	['QS_uiaction_rotationEnabled',_rotationEnabled],
	['QS_targetBoundingBox_draw',TRUE]
];
{
	localNamespace setVariable _x;
} forEach [
	['QS_placementMode_carrier',objNull],
	['QS_placementMode_updateOwnerDelay',3]
];
{
	missionNamespace setVariable _x;
} forEach [
	['QS_targetBoundingBox_placementMode',TRUE,FALSE],
	['QS_targetBoundingBox_placementModeCancel',FALSE,FALSE],
	['QS_targetBoundingBox_placementStartTime',diag_tickTime + 1,FALSE],
	['QS_placementMode_carryMode',_carryMode,FALSE]
];
if ((currentWeapon QS_player) isNotEqualTo '') then {
	QS_player setVariable ['QS_RD_holsteredWeapon',(currentWeapon QS_player),FALSE];
	action ['SwitchWeapon',QS_player,QS_player,100];
};
QS_player forceWalk (QS_targetBoundingBox_helper getVariable ['QS_logistics_forcedWalk',TRUE]);
if (_showPlacementText) then {
	_text = format [
		'<t align="left">%1</t><t align="right">[%2]</t><br/><br/>
		<t align="left">%3</t> <t align="right">[%4] [%5]</t><br/><br/>
		<t align="left">%6</t> <t align="right">[%7] [%8] OR [%9] [%10]</t><br/><br/>
		<t align="left">%11</t> <t align="right">[%12]</t><br/><br/>
		<t align="left">%13</t> <t align="right">[%14]</t><br/><br/>
		<t align="left">%15</t> <t align="right">[%16]</t><br/><br/>
		<t align="left">%17</t> <t align="right">[%18]</t>
		',
		localize 'STR_QS_Interact_010',
		actionKeysNames ["defaultAction",1] trim ['"',0],
		localize 'STR_QS_Hints_176',
		actionKeysNames ["turretElevationUp",1] trim ['"',0],
		actionKeysNames ["turretElevationDown",1] trim ['"',0],
		localize 'STR_QS_Hints_177',
		actionKeysNames ["prevAction",1] trim ['"',0],
		actionKeysNames ["nextAction",1] trim ['"',0],
		actionKeysNames ["gunElevUp",1] trim ['"',0],
		actionKeysNames ["gunElevDown",1] trim ['"',0],
		localize 'STR_QS_Hints_178',
		actionKeysNames ["lookAround",1] trim ['"',0],
		localize 'STR_QS_Hints_179',
		localize 'STR_QS_Hints_180',
		localize 'STR_QS_Hints_149',
		actionKeysNames ["turbo",1] trim ['"',0],
		localize 'STR_QS_Menu_114',
		actionKeysNames ["ingamePause",1] trim ['"',0]
	];
	[
		_text,
		FALSE,
		TRUE,
		localize 'STR_QS_Hints_181',
		TRUE
	] call QS_fnc_hint;
};
QS_EH_placementMode = addMissionEventHandler ['Draw3D',{call QS_fnc_clientEventDraw3D2}];