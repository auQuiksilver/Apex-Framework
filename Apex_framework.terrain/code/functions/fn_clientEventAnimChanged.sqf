/*/
File: fn_clientEventAnimChanged.sqf
Author: 

	Quiksilver
	
Last modified:

	16/09/2022 A3 2.10 by Quiksilver
	
Description:

	Anim Changed Event
___________________________________________________________________/*/
params ['_unit','_anim'];
if (_anim in ['acinpknlmstpsraswrfldnon','acinpknlmstpsnonwpstdnon','acinpknlmstpsnonwnondnon']) then {
	//comment 'Dragging';
	if (scriptDone QS_anim_script) then {
		QS_anim_script = _this spawn {
			params ['_unit','_anim'];
			scriptName 'QS Anim Handler - Dragging';
			private _startTime = diag_tickTime + 300;
			for '_x' from 0 to 1 step 0 do {
				if (
					(diag_tickTime > _startTime) ||
					{(!((lifeState player) in ['HEALTHY','INJURED']))} ||
					{(!isNull (objectParent player))} ||
					{(!(player call QS_fnc_isBusyAttached))}
				) exitWith {
					if (!(player call QS_fnc_isBusyAttached)) then {
						player playActionNow 'released';
					};
				};
				uiSleep 1;
			};
		};
	};
};
if (_anim in ['ainjppnemrunsnonwnondb_still','ainjppnemrunsnonwrfldb_still','ainjppnemrunsnonwpstdb_still']) then {
	//comment 'Dragged';
	if (scriptDone QS_anim_script) then {
		QS_anim_script = _this spawn {
			params ['_unit','_anim'];
			scriptName 'QS Anim Handler - Dragged';
			uiSleep 3;
			private _attachedTo = attachedTo _unit;
			for '_x' from 0 to 1 step 0 do {
				_attachedTo = attachedTo _unit;
				if (isNull _attachedTo) exitWith {_unit playActionNow 'released';};
				if (!alive _unit) exitWith {};
				if (!alive _attachedTo) exitWith {_unit playActionNow 'released';};
				if (!isNull (objectParent _unit)) exitWith {};
				if (!((lifeState _unit) in ['HEALTHY','INJURED'])) exitWith {};
				if (!((lifeState _attachedTo) in ['HEALTHY','INJURED'])) exitWith {[0,_unit] call QS_fnc_eventAttach;_unit playActionNow 'released';};
				if (!isNull (objectParent _attachedTo)) exitWith {[0,_unit] call QS_fnc_eventAttach;_unit playActionNow 'released';};
				uiSleep 1;
			};	
		};
	};
};
if (_anim in ['acinpercmstpsraswrfldnon','acinpercmstpsraswnondnon','acinpercmstpsraswpstdnon','acinpercmstpsnonwnondnon']) then {
	//comment 'Carrying';
	if (scriptDone QS_anim_script) then {
		QS_anim_script = _this spawn {
			params ['_unit','_anim'];
			scriptName 'QS Anim Handler - Carrying';
			uiSleep 3;
			private _carried = objNull;
			{
				if (_x isKindOf 'CAManBase') then {
					_carried = _x;
				};
			} forEach (attachedObjects player);
			private _startTime = diag_tickTime + 300;
			private _putDown = FALSE;
			if (!alive _carried) exitWith {
				if (isForcedWalk player) then {
					player forceWalk FALSE;
					['switchMove',player,['']] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
				};
			};
			for '_x' from 0 to 1 step 0 do {
				if (diag_tickTime > _startTime) exitWith {};
				if (!alive player) exitWith {_putDown = TRUE;};
				if (!isNull (objectParent player)) exitWith {_putDown = TRUE;};
				if (!alive _carried) exitWith {_putDown = TRUE;};
				if (!((lifeState player) in ['HEALTHY','INJURED'])) exitWith {};
				if (!(player call QS_fnc_isBusyAttached)) exitWith {
					player playActionNow 'released';
				};
				if (((attachedObjects player) findIf {((_x isKindOf 'CAManBase') && ((lifeState _x) isNotEqualTo 'INCAPACITATED'))}) isNotEqualTo -1) exitWith {
					{
						[0,_x] call QS_fnc_eventAttach;
					} count attachedObjects player;
					player playActionNow 'released';
				};
				uiSleep 1;
			};
			if (isForcedWalk player) then {
				player forceWalk FALSE;
				['switchMove',player,['']] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
			};
			if (_putDown) then {
			
			};
		};
	};
};
if (_anim in ['ainjpfalmstpsnonwrfldnon_carried_still','ainjpfalmstpsnonwnondnon_carried_still','ainjpfalmstpsnonwnondf_carried_dead','ainjpfalmstpsnonwnondnon_carried_up']) then {
	//comment 'Carried';
	if (scriptDone QS_anim_script) then {
		QS_anim_script = _this spawn {
			params ['_unit','_anim'];
			scriptName 'QS Anim Handler - Carried';
			uiSleep 3;
			private _attachedTo = attachedTo _unit;
			private _putDown = FALSE;
			for '_x' from 0 to 1 step 0 do {
				_attachedTo = attachedTo _unit;
				if (isNull _attachedTo) exitWith {_putDown = TRUE;};
				if (!alive _unit) exitWith {};
				if (!alive _attachedTo) exitWith {_putDown = TRUE;};
				if (!isNull (objectParent _unit)) exitWith {};
				if ((lifeState _unit) in ['HEALTHY','INJURED']) exitWith {_putDown = TRUE;};
				if (!((lifeState _attachedTo) in ['HEALTHY','INJURED'])) exitWith {_putDown = TRUE;};
				if (!isNull (objectParent _attachedTo)) exitWith {_putDown = TRUE;};
				uiSleep 1;
			};
			if (_putDown) then {
				if (!(_unit getVariable ['QS_RD_loaded',FALSE])) then {
					[0,_unit] call QS_fnc_eventAttach;
				};
			};
		};
	};
};