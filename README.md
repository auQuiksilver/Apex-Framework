# Apex Framework 

Apex Framework 1.0.0 (Beta) by Quiksilver      (armacombatgroup@gmail.com)


Apex Framework step-by-step setup guide:

* Setup time: 5-10 minutes.
* Server must be a Dedicated server. Not configured for local client hosting.
* Server must be running x64.

_______________
1. Place mission PBO in your servers MPMissions folder.


_______________
2. Place @Apex folder in your servers ArmA3 directory. Reference: https://i.imgur.com/ijdXgg6.png


_______________
3. Place @Apex_cfg folder in your servers ArmA 3 directory. Reference: https://i.imgur.com/ijdXgg6.png


_______________
4. Place    real_date_x64.dll     file in your servers ArmA 3 directory. Reference: https://i.imgur.com/ijdXgg6.png


_______________
5. Copy the difficulty options from   server.Arma3Profile file into your servers .arma3profile file.  Reference:   https://i.imgur.com/X71jy3z.png
Ensure the difficulties are set correctly. Reference:   https://i.imgur.com/9NXqPnI.png


_______________
6a. In your "server.cfg" file, ensure your server will load the correct difficulty options. Example:


class Missions {
	class Annex {
		template="Apex_framework_beta_100.Altis";
		template="Apex_framework_beta_100.Tanoa";
		template="Apex_framework_beta_100.Malden";
		difficulty="Custom";
	};
};
missionWhitelist[] = {"Apex_framework_beta_100.Altis","Apex_framework_beta_100.Tanoa","Apex_framework_beta_100.Malden"};
forcedDifficulty = "Custom";


6b. Ensure that:    forcedDifficulty = "Custom";
6c. At this time, also double check to ensure the mission template matches the mission you are trying to run.
_______________
7. In your "server.cfg" file, ensure you have a serverCommandPassword set. Example:

serverCommandPassword = "ShVQArtpGdc5aDQq";

Make note of the password you have (or created), you will need it now. Copy it to your clipboard.
_______________
8a. Open the new @Apex_cfg folder which you placed in your arma 3 directory.
8b. Open the "parameters.sqf" file.
8c. Locate this:


_serverCommandPassword = "
	'ShVQArtpGdc5aDQq'
";


8d. Ignoring the " and ' quotations (do not touch them), copy your serverCommandPassword into that line as shown. See #7 to compare.
8e. Dont use that password!!!
_______________
9. In the "parameters.sqf" file, locate this:

_main_mission_type = 'NONE';

Using the notes and examples posted beneath that line, select the mission type you want to run. Reference:   https://i.imgur.com/FI8tWHZ.png
_______________
10. Enjoy!


Other notes:

- There are a few other options to choose inside that "parameters.sqf" file.
- Inside the "whitelist.sqf" file, you can set player UIDs to give them various permissions. Zeus and Developer permissions are located near the bottom. For Zeus you do not need to edit the mission file, the framework will generate a module on the fly as you log in.
- You can set custom chat messages inside the "chatMessages.sqf" file.
- Ingame admin tools are accessed with key-combo [Shift]+[F2]. For more info, view the map diary tab "Key bindings".
- This framework is currently in a short beta period (from 8/12/2017). In 7-10 days there will likely be another update.



