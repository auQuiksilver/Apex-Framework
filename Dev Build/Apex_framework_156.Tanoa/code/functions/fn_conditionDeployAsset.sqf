/*
File: fn_conditionDeployAsset.sqf
Author:

	Quiksilver
	
Last Modified:

	17/05/2023 A3 2.12 by Quiksilver
	
Description:

	Condition for user action to deploy asset
___________________________________________________*/

getCursorObjectParams params ['_cursorObject','','_cursorDistance'];
_text = [localize 'STR_QS_Interact_133',localize 'STR_QS_Interact_134'] select (_cursorObject getVariable ['QS_logistics_deployed',FALSE]);
QS_player setUserActionText [_actionId,_text,format ["<t size='3'>%1</t>",_text]];
((!isNull _cursorObject) && {(_cursorDistance < 10)})