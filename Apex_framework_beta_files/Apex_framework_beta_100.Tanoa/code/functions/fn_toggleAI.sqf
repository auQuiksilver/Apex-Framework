/*/
File: fn_toggleAI.sqf
Author:

	Quiksilver
	
Last Modified:

	19/02/2017 A3 1.66 by Quiksilver
	
Description:

	Toggle on/off AI
	
Example:

	[(units _grp),FALSE,['AUTOCOMBAT','COVER']] call (missionNamespace getVariable 'QS_fnc_toggleAI');
	https://community.bistudio.com/wiki/disableAI
	https://community.bistudio.com/wiki/enableAI
	
	"TARGET" - stop the unit to watch the assigned target / group commander may not assign targets
	"AUTOTARGET" - prevent the unit from assigning a target independently and watching unknown objects / no automatic target selection
	"MOVE" - disable the AI's movement / do not move
	"ANIM" - disable ability of AI to change animation. Available only since ArmA: Cold War Assault (OFP 1.99).
	"TEAMSWITCH" - AI disabled because of Team Switch
	"FSM" - disable the execution of AI behavior scripts. Available only since Operation Arrowhead v1.60.
	"AIMINGERROR" - prevents AI's aiming from being distracted by its shooting, moving, turning, reloading, hit, injury, fatigue, suppression or concealed/lost target Available only since Arma 3 v1.42.
	"SUPPRESSION" - prevents AI from being suppressed Available only since Arma 3 v1.42.
	"CHECKVISIBLE" - disables visibility raycasts Available only since Arma 3 v1.54.
	"COVER" - disables usage of cover positions by the AI Available only since Arma 3 v1.56.
	"AUTOCOMBAT" - disables autonomous switching to COMBAT when in danger Available only since Arma 3 v1.56.
	"PATH" - stops the AI’s movement but not the target alignment Available only since Arma 3 v1.61.
	"ALL" - all of the above Available since Arma 3 v1.65
_________________________________________________/*/

params ['_units','_onOff','_ai'];
private _unit = objNull;
{
	if (local _x) then {
		_unit = _x;
		if (!(_ai isEqualTo [])) then {
			{
				if (_onOff) then {
					_unit enableAI _x;
				} else {
					_unit disableAI _x;
				};
			} forEach _ai;
		};
	};
} forEach _units;