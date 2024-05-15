/*/
File: security.hpp
Author:

	Quiksilver
	
Last Modified:

	25/10/2022 A3 2.10 by Quiksilver
	
Description:

	CfgDisabledCommands
	CfgRemoteExec
_____________________________________________________________/*/

class CfgDisabledCommands {
    class CREATEUNIT
    {
        class SYNTAX1
        {
            targets[] = {0,0,0};
            args[] = {{"STRING"},{"ARRAY"}};
        };

        class SYNTAX2
        {
            targets[] = {1,1,1};
            args[] = {{"GROUP"},{"ARRAY"}};
        };
    };
	
	
	/*/ Required for Zeus map markers.    RE-ENABLE THIS SECTION TO STRENGTHEN ANTICHEAT SECURITY. DISABLED FOR ZEUS MARKER FUNCTIONALITY.
    class SETMARKERTEXT
    {
        class SYNTAX1
        {
            targets[] = {1,0,0};
            args[] = {{"STRING"},{"STRING"}};
        };
    };
	/*/


    class ADDMPEVENTHANDLER
    {
        class SYNTAX1
        {
            targets[] = {1,0,0};
            args[] = {{"OBJECT"},{"ARRAY"}};
        };
    };
	
	
	/*/ Enabling this will cause some issues with vanilla UAV logic
    class SETWAYPOINTSTATEMENTS
    {
        class SYNTAX1
        {
            targets[] = {1,0,1};
            args[] = {{"ARRAY"},{"ARRAY"}};
        };
    };
	/*/
	
	
    class PUBLICVARIABLE
    {
        class SYNTAX1
        {
            targets[] = {1,0,1};
            args[] = {{},{"STRING"}};
        };
    };
    class ONMAPSINGLECLICK
    {
        class SYNTAX1
        {
            targets[] = {0,0,0};
            args[] = {{"ANY"},{"STRING","CODE"}};
        };

        class SYNTAX2
        {
            targets[] = {0,0,0};
            args[] = {{},{"STRING","CODE"}};
        };
    };
    class ALLVARIABLES
    {
        class SYNTAX1
        {
            targets[] = {1,1,1};
            args[] = {{},{"CONTROL"}};
        };

        class SYNTAX2
        {
            targets[] = {1,1,1};
            args[] = {{},{"TEAM_MEMBER"}};
        };

        class SYNTAX3
        {
            targets[] = {0,0,0};
            args[] = {{},{"NAMESPACE"}};
        };

        class SYNTAX4
        {
            targets[] = {1,1,1};
            args[] = {{},{"OBJECT"}};
        };

        class SYNTAX5
        {
            targets[] = {1,1,1};
            args[] = {{},{"GROUP"}};
        };

        class SYNTAX6
        {
            targets[] = {1,1,1};
            args[] = {{},{"TASK"}};
        };

        class SYNTAX7
        {
            targets[] = {1,1,1};
            args[] = {{},{"LOCATION"}};
        };
    };
    /*/
    class HINT
    {
        class SYNTAX1
        {
            targets[] = {0,0,0};
            args[] = {{},{"STRING","TEXT"}};
        };
    };
    class HINTSILENT
    {
        class SYNTAX1
        {
            targets[] = {0,0,0};
            args[] = {{},{"STRING","TEXT"}};
        };
    };
    /*/
    
    /*/
    class ONEACHFRAME
    {
        class SYNTAX1
        {
            targets[] = {0,0,0};
            args[] = {{},{"STRING","CODE"}};
        };
    };
    /*/
};
class CfgRemoteExec {
	class Commands {
		mode = 1;
		class lock {};			    // required for zeus
		class setFuel {};		    // required for zeus
		class lockturret {};		// required for "Global Mobilization" DLC
	};
	class Functions {
		mode = 1;
		jip = 0;
		allowedTargets = 0;
		class BIS_fnc_callScriptedEventHandler {};
		class BIS_fnc_curatorRespawn {};
		class BIS_fnc_deleteTask {jip = 1;}; 
		class BIS_fnc_dynamicGroups {};
		class BIS_fnc_effectKilled {};
		class BIS_fnc_effectKilledSecondaries {};
		class BIS_fnc_effectKilledAirDestruction {};
		class BIS_fnc_effectKilledAirDestructionStage2 {};
		class BIS_fnc_error {};
        class BIS_fnc_fire {};      // Required for T100X Futura tank
		class BIS_fnc_initIntelObject {jip = 1;};
		class BIS_fnc_objectVar {};
		class BIS_fnc_playSound {allowedTargets = 1;};
		class BIS_fnc_sayMessage {allowedTargets = 1;};
		class BIS_fnc_setCustomSoundController {};
		class BIS_fnc_setIdentity {};
		class BIS_fnc_setTask {jip = 1;};
		class BIS_fnc_setTaskLocal {jip = 1;};
		class BIS_fnc_sharedObjectives {};
		class BIS_fnc_showNotification {allowedTargets = 1;};
		class QS_fnc_remoteExec {allowedTargets = 0;};
		class QS_fnc_remoteExecCmd {allowedTargets = 0;};
	};
};