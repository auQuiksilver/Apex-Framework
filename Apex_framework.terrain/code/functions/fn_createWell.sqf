/*/
File: fn_createWell.sqf
Author: 

	Quiksilver
	
Last modified:

	22/11/2017 A3 1.78 by Quiksilver
	
Description:

	Create well composition
___________________________________________________________________/*/

params ['_type','_position',''];
private _entities = [];
private _detectors = [];
_wellModel = 'A3\Structures_F_Exp\Industrial\Fields\ConcreteWell_01_F.p3d';
_sewerCoverModel = format ['A3\Structures_F_Exp\Infrastructure\Roads\SewerCover_0%1_F.p3d',(selectRandom [1,2,3])];
_position set [2,0.05];
_position = AGLToASL _position;
_sewerCover = createSimpleObject [_sewerCoverModel,_position];
_sewerCover setDir (random 360);
_sewerCover setVectorUp (surfaceNormal _position);
_entities pushBack _sewerCover;
_position = _position vectorAdd [0,0,0.86];
_wellCover = createSimpleObject [_wellModel,_position];
_wellCover setDir (random 360);
_wellCover setVariable ['QS_client_canAttachExp',TRUE,TRUE];
_wellCover setVariable ['QS_client_canAttachDetach',TRUE,TRUE];
_entities pushBack _wellCover;

private _detector = createVehicle ['Land_Balloon_01_water_F',(_position vectorAdd [0,0,10]),[],0,'NONE'];
_detector enableDynamicSimulation FALSE;
_detector setVariable ['QS_dynSim_ignore',TRUE,TRUE];
_detector enableSimulationGlobal FALSE;
_detector addEventHandler ['HandleDamage',{call (missionNamespace getVariable 'QS_fnc_wellHandleDamage')}];
_detector setVariable ['QS_entity_sumDmg',0,TRUE];
_detector setVariable ['QS_entity_reqDmg',1500,TRUE];
_detector setVariable ['QS_entity_assocObjects',[_sewerCover,_wellCover],FALSE];
[1,_detector,[_wellCover,[0,0.9,0.5]]] call QS_fnc_eventAttach;
_detector hideObjectGlobal TRUE;
_detector enableSimulationGlobal FALSE;
_entities pushBack _detector;
_detectors pushBack _detector;

_detector = createVehicle ['Land_Balloon_01_water_F',(_position vectorAdd [0,0,10]),[],0,'NONE'];
_detector enableDynamicSimulation FALSE;
_detector setVariable ['QS_dynSim_ignore',TRUE,TRUE];
_detector enableSimulationGlobal FALSE;
_detector addEventHandler ['HandleDamage',{call (missionNamespace getVariable 'QS_fnc_wellHandleDamage')}];
_detector setVariable ['QS_entity_sumDmg',0,TRUE];
_detector setVariable ['QS_entity_reqDmg',1500,TRUE];
_detector setVariable ['QS_entity_assocObjects',[_sewerCover,_wellCover],FALSE];
[1,_detector,[_wellCover,[-0.9,-0.9,0.5]]] call QS_fnc_eventAttach;
_detector hideObjectGlobal TRUE;
_detector enableSimulationGlobal FALSE;
_entities pushBack _detector;
_detectors pushBack _detector;

_detector = createVehicle ['Land_Balloon_01_water_F',(_position vectorAdd [0,0,10]),[],0,'NONE'];
_detector enableDynamicSimulation FALSE;
_detector setVariable ['QS_dynSim_ignore',TRUE,TRUE];
_detector enableSimulationGlobal FALSE;
_detector addEventHandler ['HandleDamage',{call (missionNamespace getVariable 'QS_fnc_wellHandleDamage')}];
_detector setVariable ['QS_entity_sumDmg',0,TRUE];
_detector setVariable ['QS_entity_reqDmg',1500,TRUE];
_detector setVariable ['QS_entity_assocObjects',[_sewerCover,_wellCover],FALSE];
[1,_detector,[_wellCover,[0.9,-0.9,0.5]]] call QS_fnc_eventAttach;
_detector hideObjectGlobal TRUE;
_detector enableSimulationGlobal FALSE;
_entities pushBack _detector;
_detectors pushBack _detector;
_position set [2,0];
private _structureTypes = [];								// To Do: DLC support
if (worldName in ['Altis','Stratis','Malden']) then {
	_structureTypes = [
		'Land_Slum_House03_F',
		'Land_Slum_House01_F',
		'Land_Metal_Shed_F'
	];
};
if (worldName in ['Tanoa','Enoch']) then {
	_structureTypes = [
		'Land_Shed_07_F',
		'Land_Shed_06_F',
		'Land_WoodenShelter_01_F'
	];
};
if ((random 1) > 0.5) then {
	if ((_position getEnvSoundController 'houses') < 1) then {
		if (_structureTypes isNotEqualTo []) then {
			_structure = createVehicle [(selectRandom _structureTypes),_position,[],0,'CAN_COLLIDE'];
			_structure setDir (random 360);
			_structure setVectorUp [0,0,1];
			_entities pushBack _structure;
		};
	};
};
(missionNamespace getVariable 'QS_grid_intelTargets') pushBack ['TUNNEL_ENTRANCE',_wellCover,_position,_detector];
{
	(missionNamespace getVariable 'QS_grid_aoProps') pushBack _x;
} forEach _entities;
_detector;