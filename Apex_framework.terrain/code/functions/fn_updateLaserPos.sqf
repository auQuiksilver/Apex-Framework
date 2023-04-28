/*/
File: fn_updateLaserPos.sqf
Author:
	
	Credit to Leopard20!!
	
Last Modified:

	12/08/2023 A3 2.12
	
Description:

	Laser world positions for draw
__________________________________________/*/

(_this selectionVectorDirAndUp [(_this getVariable ['QS_unit_weaponProxy','']),5]) params ['_vy','_vz'];
[
	(_this modelToWorldVisualWorld ((selectionPosition [_this, (_this getVariable ['QS_unit_weaponProxy','']), 5]) vectorAdd (flatten ((matrixTranspose [(_vy vectorCrossProduct _vz), _vy, _vz]) matrixMultiply (_this getVariable ['QS_unit_laserOffset',[[0],[0],[0]]]) )))),
	(_this weaponDirection (currentWeapon _this))
]