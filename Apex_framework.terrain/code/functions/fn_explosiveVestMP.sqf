/*
@filename: fn_explosiveVestMP.sqf
Author:

	Quiksilver
	
Last modified:

	30/08/2022 A3 2.10 by Quiksilver
	
Description:

	Explosive Vest MP
__________________________________________________*/

params ['_QS_unit','_QS_exp1','_QS_exp2','_QS_exp3'];
[1,_QS_exp1,[_QS_unit, [-0.1,0.1,0.15],'Pelvis']] call QS_fnc_eventAttach;
_QS_exp1 setVectorDirAndUp [[0.5,0.5,0],[-0.5,0.5,0]];
[1,_QS_exp2,[_QS_unit, [0,0.15,0.15],'Pelvis']] call QS_fnc_eventAttach;
_QS_exp2 setVectorDirAndUp [[1,0,0],[0,1,0]];
[1,_QS_exp3,[_QS_unit, [0.1,0.1,0.15],'Pelvis']] call QS_fnc_eventAttach;
_QS_exp3 setVectorDirAndUp [[0.5,-0.5,0],[0.5,0.5,0]];