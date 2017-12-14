/*
@filename: fn_explosiveVestMP.sqf
Author:

	Quiksilver
	
Last modified:

	26/05/2015 ArmA 3 1.44 by Quiksilver
	
Description:

	Explosive Vest MP
__________________________________________________*/

private ['_QS_unit','_QS_exp1','_QS_exp2','_QS_exp3','_QS_expArr'];
_QS_unit = _this select 0;
_QS_exp1 = _this select 1;
_QS_exp2 = _this select 2;
_QS_exp3 = _this select 3;
_QS_exp1 attachTo [_QS_unit, [-0.1,0.1,0.15],'Pelvis'];
_QS_exp1 setVectorDirAndUp [[0.5,0.5,0],[-0.5,0.5,0]];
_QS_exp2 attachTo [_QS_unit, [0,0.15,0.15],'Pelvis'];
_QS_exp2 setVectorDirAndUp [[1,0,0],[0,1,0]];
_QS_exp3 attachTo [_QS_unit, [0.1,0.1,0.15],'Pelvis'];
_QS_exp3 setVectorDirAndUp [[0.5,-0.5,0],[0.5,0.5,0]];