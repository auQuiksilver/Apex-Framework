/*
File: QS_staff.sqf
Author:

	Quiksilver
	
Last modified:

	29/05/2016 ArmA 3 1.58 by Quiksilver
	
Description:

	Staff UIDs
__________________________________________________________________________*/

_type = param [0,''];
private _return = [];
if (['SG',missionName,FALSE] call (missionNamespace getVariable 'BIS_fnc_inString')) then {
	if (_type isEqualTo 'ALL') then {
		/*/All staff UIDs (does not grant permissions/menus, that stuff is below). Robocop reports trolling events and hacking events to these people though./*/
		_return = [
			'76561198035458696',		/*/Rogmantosh/*/
			'76561197976546912',		/*/Dasweetdude/*/
			/*/'76561198052917550',/*/
			/*/'76561198067821515',/*/
			'76561198214984928',		/*/ J17/*/
			/*/'76561198065041656',/*/
			/*/'76561198065708974',/*/
			/*/'76561198135514318',/*/
			'76561198085917189',		/*/ Littleblacksheep/*/
			'76561198122393901',		/*/ Quantum/*/
			'76561198201113489',		/*/ Elliott/*/
			'76561198027166400',		/*/ Fitz/*/
			'76561198107403916',		/*/ Krow/*/
			'76561198000878718',		/*/ Shift/*/
			'76561198136794590',		/*/ Richard/*/
			'76561198038866456',		/*/ Lachlan/*/
			/*/'76561198016508515',/*/
			/*/'76561197967439725',/*/		/*/ Skyzzy/*/
			/*/'76561198135514319',/*/
			/*/'76561198188319837',/*/
			/*/'76561198068801694',/*/
			/*/'76561198052985563',/*/
			/*/'76561198093933447',/*/
			/*/'76561198174257701',/*/
			'76561198084065754',		/*/Quiksilver/*/
			'76561198063955650',		/*/ InfamousNova/*/
			'76561198053779030',		/*/ John Paul/*/
			'76561198063531934'			/*/ Tracuer/*/
		];
	};

	if (_type isEqualTo 'ADMIN') then {
		/*/Admin UIDs/*/
		_return = [
			/*/'76561197967439725',/*/		/*/ Skyzzy/*/
			'76561198085917189',		/*/Littleblacksheep/*/
			'76561198000878718',		/*/ Shift/*/
			'76561198053779030',		/*/ John Paul/*/
			'76561198214984928'			/*/J17/*/
		];
	};
	if (_type isEqualTo 'MODERATOR') then {
		/*/ Moderator UIDs/*/
		_return = [
			'76561198027166400',		/*/ Fitz/*/
			/*/'76561198107403916',/*/		/*/ Krow/*/
			'76561198136794590',		/*/ Richard/*/
			'76561198038866456',		/*/ Lachlan/*/
			'76561198063955650',		/*/ InfamousNova/*/
			'76561198201113489'			/*/Elliott/*/
		];
	};
	if (_type isEqualTo 'TRUSTED') then {
		/*/ Trusted non-staff members/*/
		_return = [
			''
		];
	};
	if (_type isEqualTo 'S1') then {
		/*/ F7 + F8 menu access ("super admins")/*/
		_return = [
			'76561198052917550',
			'76561198067821515',
			'76561198214984928',		/*/ J17/*/
			'76561197976546912',		/*/ Dasweetdude/*/
			'76561198065041656',
			'76561198065708974',
			'76561198135514318',
			'76561198085917189'			/*/ Littleblacksheep/*/
		];
	};
	if (_type isEqualTo 'S2') then {
		/*/ Spectator Slot access/*/
		_return = [
			'76561198214984928',			/*/ J17/*/
			'76561198107403916',			/*/ Krow/*/
			'76561197976546912',			/*/ Dasweetdude/*/
			'76561198027166400',			/*/Fitz/*/
			'76561198085917189',		/*/ Littleblacksheep/*/
			'76561197999436142'			/*/ Ezra/UltraNoob/*/
		];
	};

	/*/================================================= DONATORS BELOW/*/
	if (_type isEqualTo 'S3') then {
		/*/ Pilot/Medic Slot whitelist (incl donators)/*/
		_return = [
			'76561198214984928',			/*/ J17/*/
			'76561198107403916',			/*/ Krow/*/
			'76561197976546912',			/*/ Dasweetdude/*/
			'76561198027166400',			/*/Fitz/*/
			'76561198085917189',			/*/Littleblacksheep/*/
			'76561198010638484',			/*/Cassidy/*/
			'76561198018540405',			/*/ White Beast/*/
			'76561198154689454',			/*/ Pvt Parts/*/
			'76561198063955650',			/*/ InfamousNova/*/
			'76561197999436142',			/*/Ezra/UltraNoob   * /*/
			'76561198201496979',			/*/ Excellent26k/*/
			'76561198118446908',			/*/ cocane6/*/
			'76561198001601587',			/*/Suzaku/*/
			'76561198075406717',			/*/ Unemployment Benefit/*/
			'76561198004026295',			/*/ Aramius/*/
			'76561198000878718',			/*/ Shift597/*/
			'76561198114194315',           /*/ Sonaint/*/
			'76561198234337020',			/*/ black fox  /*/
			'76561198032126177',           /*/ AIR_RAIDER/*/
			'76561198160061047',            /*/ C.Whiskey/*/
			'76561198192272161',			/*/ Matsozetex/*/
			'76561198045641614',			/*/Bones/*/
			'76561197960797129',			/*/ VooKain/*/
			'76561198049308013',			/*/ dohdoh64    *  /*/
			'76561198063531934',			/*/ [ATC]Tracuer/*/
			'76561198150359668',			/*/ RiddimWise/*/
			'76561198048700779',			/*/22A/*/
			'76561198022690399',			/*/Spadge/*/
			'76561198036701061',			/*/vortex1018/*/
			'76561198137013603',			/*/ JMaverick/*/
			'76561198114739208',			/*/ SharpShooter/*/
			'76561198071103805',			/*/Whitts/*/
			'76561198088441620',           /*/ Marquez/*/
			'76561197982847025',			/*/ =S.N.A.F.U.=/*/
			'76561197970686483',			/*/ Zybisko/*/
			'76561198137918156',		/*/ shady/*/
			'76561198127637215'				/*/ Funky/*/
		];
	};

	/*/================================================= DONATORS ABOVE/*/
	if (_type isEqualTo 'S4') then {
		/*/Pilot Slot blacklist/*/
		_return = [];
	};
	if (_type isEqualTo 'CURATOR') then {
		/*/Zeus/*/
		_return = [
			'76561198035458696',			/*/ Rogmantosh/*/
			'76561197976546912',			/*/ Dasweetdude/*/
			'76561198084065754',			/*/ Quiksilver/*/
			'76561198214984928',			/*/ J17/*/
			'76561198085917189',			/*/Littleblacksheep/*/
			'76561198000878718',		/*/Shift/*/
			'76561198027166400',			/*/ Fitz/*/
			'76561198122393901'				/*/ Quantum/*/
		];
	};
	if (_type isEqualTo 'DEVELOPER') then {
		/*/ Developer UIDs/*/
		_return = [
			'76561197976546912',			/*/Dasweetdude/*/
			'76561198084065754',			/*/ Quiksilver/*/
			'76561198035458696'			/*/ Rogmantosh/*/
		];
	};
} else {
	if (_type isEqualTo 'ALL') then {
		/*/ All staff UIDs (does not grant permissions/menus, that stuff is below). Robocop reports trolling events and hacking events to these people though./*/
		_return = [
			'76561198035458696',		/*/ Rogmantosh/*/
			'76561197976546912',		/*/ Dasweetdude/*/
			'76561198085917189',		/*/ Littleblacksheep/*/
			'76561198027166400',		/*/ Fitz/*/
			'76561198000878718',		/*/ Shift/*/
			'76561198136794590',		/*/ Richard/*/
			'76561198084065754',		/*/ Quiksilver/*/
			'76561198063955650',		/*/ InfamousNova/*/
			'76561198063531934'			/*/ Tracuer/*/
		];
	};
	if (_type isEqualTo 'ADMIN') then {
		/*/ Admin UIDs/*/
		_return = [
			'76561198085917189',		/*/Littleblacksheep/*/
			'76561198000878718'			/*/ Shift/*/
		];
	};
	if (_type isEqualTo 'MODERATOR') then {
		/*/ Moderator UIDs/*/
		_return = [
			'76561198027166400',		/*/ Fitz/*/
			'76561198136794590',		/*/ Richard/*/
			'76561198063955650'		/*/InfamousNova/*/
		];
	};
	if (_type isEqualTo 'TRUSTED') then {
		/*/ Trusted non-staff members/*/
		_return = [''];
	};
	if (_type isEqualTo 'S1') then {
		_return = [''];
	};
	if (_type isEqualTo 'S2') then {
		/*/Spectator Slot access/*/
		_return = [''];
	};

	/*/================================================= DONATORS BELOW/*/
	if (_type isEqualTo 'S3') then {
		/*/ Pilot/Medic Slot whitelist (incl donators)/*/
		_return = [
			'76561197976546912',			/*/ Dasweetdude/*/
			'76561198027166400',			/*/ Fitz/*/
			'76561198085917189',			/*/Littleblacksheep/*/
			'76561198010638484',			/*/ Cassidy/*/
			'76561198063955650',		/*/ InfamousNova/*/
			'76561198000878718'				/*/ Shift597/*/
		];
	};

	/*/================================================= DONATORS ABOVE/*/
	if (_type isEqualTo 'S4') then {
		/*/ Pilot Slot blacklist/*/
		_return = [''];
	};
	if (_type isEqualTo 'CURATOR') then {
		/*/Zeus/*/
		_return = [
			/*/'76561198035458696',/*/			/*/ Rogmantosh/*/
			/*/'76561197976546912',/*/			/*/Dasweetdude/*/
			'76561198084065754',		/*/ Quiksilver/*/
			/*/'76561198085917189',/*/			/*/ Littleblacksheep/*/
			/*/'76561198000878718',	/*/		/*/Shift597/*/
			/*/'76561198027166400',/*/			/*/Fitz/*/
			/*/'76561198136794590',/*/				/*/ Richard/*/
			'76561198007169107'				/*/oukej  bb930f3a470290c90547a30ccae36f54   89.176.176.246/*/
		];
	};
	if (_type isEqualTo 'DEVELOPER') then {
		/*/ Developer UIDs/*/
		_return = [
			'76561197976546912',			/*/ Dasweetdude/*/
			'76561198084065754',		/*/ Quiksilver/*/
			'76561198035458696'				/*/ Rogmantosh/*/
		];
	};
};
_return;