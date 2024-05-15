/*
File: fn_aoAnimals.sqf
Author: 

	Quiksilver

Last Modified:

	5/05/2019 A3 1.92 by Quiksilver

Description:

	AO Animals
____________________________________________________*/
if ((count allPlayers) >= 50) exitwith {};
params ['_position','_type','_quantity'];
private ['_classes','_class','_animal','_animStart'];
if (_type isEqualTo 'DOG') then {
	_classes = ['Fin_random_F','Fin_random_F'];
	_animStart = 'Dog_Idle_Stop';
};
if (_type isEqualTo 'SHEEP') then {
	_classes = ['Sheep_random_F','Sheep_random_F'];
	_animStart = 'Sheep_Idle_Stop';
};
if (_type isEqualTo 'GOAT') then {
	_classes = ['Goat_random_F','Goat_random_F'];
	_animStart = 'Goat_Idle_Stop';
};
if (_type isEqualTo 'HEN') then {
	_classes = ['Hen_random_F','Hen_random_F'];
	_animStart = 'Hen_Idle_Stop';
};
for '_x' from 0 to (_quantity - 1) step 1 do {
	_class = selectRandom _classes;
	_animal = createAgent [_class,_position,[],15,'NONE'];
	/*/_animal setVariable ['BIS_fnc_animalBehaviour_disable',TRUE,TRUE];/*/
	_animal enableDynamicSimulation TRUE;
	['switchMove',_animal,[_animStart]] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
	_animal setSkill 0;
	_animal setVariable ['QS_animal_sitePosition',_position,(!isServer)];
	_animal setDir (random 360);
	_animal setVariable ['QS_AI_ENTITY',TRUE,QS_system_AI_owners];
	_animal setVariable ['QS_AI_ENTITY_TASK',['SITE_AMBIENT',_position,50,diag_tickTime],QS_system_AI_owners];
	_animal setVariable ['QS_AI_ENTITY_HC',[0,-1],QS_system_AI_owners];
	missionNamespace setVariable ['QS_aoAnimals',((missionNamespace getVariable 'QS_aoAnimals') + [_animal]),(!isServer)];
};