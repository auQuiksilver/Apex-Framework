/*/
File: fn_eventOnUserSelectedPlayer.sqf
Author:
	
	Quiksilver
	
Last Modified:

	29/01/2024 A3 2.16 by Quiksilver
	
Description:

	Executes assigned code after player object is selected for user to take over control, 
	the ownership information is broadcast and request to sync is made but the object is still owned by previous owner for a short time.

	https://community.bistudio.com/wiki/getUserInfo

	//[playerID, owner, playerUID, soldierName, displayName, steamProfileName, 
	//clientStateNumber, isHeadless, adminState, networkInfo, playerObject]
______________________________________________________/*/

params ['_networkId','_playerObject'];
if (local _playerObject) then {
	_playerObject addEventHandler [
		'Local',
		{
			params ['_player'];
			_player removeEventHandler [_thisEvent,_thisEventHandler];
			[[FALSE,(getUserInfo (getPlayerID _player))],'qs_fnc_initplayerserver'] call QS_fnc_perFrameQueue;
		}
	];
} else {
	[[FALSE,(getUserInfo _networkId)],'qs_fnc_initplayerserver'] call QS_fnc_perFrameQueue;
};