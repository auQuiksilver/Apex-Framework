/*
	Function: ALiVE_fnc_crypt
	Author(s): Naught
	Version: 1.0
	Description:
		Encrypts or decrypts a string with a specified encryption key.
	Parameters:
		0 - Decrypt (0) or encrypt (1) [number]
		1 - Encryption method name [string]
		2 - Encrypted or plain data [string]
		3 - Encryption key [string]
	Returns:
		Encrypted or decrypted data or nothing on failure [string:nil]
	Note(s):
		1. Current encryption method names:
			- "rc4" // Rivest Cipher 4 Stream Encryption Algorithm
	License:
		Copyright (c) 2014 Dylan Plecki. All Right Reserved.
		Licensed under Creative Commons (CC BY-NC 4.0).
		http://creativecommons.org/licenses/by-nc/4.0/
		
#define CRYPT_KEY "my_secret_key"

*/

/*/ Settings/*/
#define DEBUG_MODE_FULL

/*/Constants/*/
#define MAX_CHAR_SIZE 8    /*/bits/*/
#define CHAR_ZERO_REP 256

private ["_flow", "_method", "_key"];
_flow = _this select 0;
_method = _this select 1;
_key = _this select 3;

#ifdef DEBUG_MODE_FULL
	private ["_startTime"];
	_startTime = diag_tickTime;
#endif

private ["_fnc_intToBin"];
_fnc_intToBin = {
	private ["_int", "_bin", "_pwr", "_bool"];
	_int = _this select 0;
	_bin = if ((count _this) > 1) then {_this select 1} else {[]};
	
	for "_i" from (MAX_CHAR_SIZE - 1) to 0 step (-1) do
	{
		_pwr = 2^(_i);
		_bool = _pwr <= _int;
		
		_bin set [(count _bin), _bool];
		
		if (_bool) then {_int = _int - _pwr};
	};
	
	_bin
};

private ["_bin"];
_bin = [];

/*/ Convert string to UTF-8 binary/*/
{/*/ count (faster than forEach)/*/
	[(if (_x == CHAR_ZERO_REP) then {0} else {_x}), _bin] call _fnc_intToBin;
	false;
} count toArray(_this select 2);

#ifdef DEBUG_MODE_FULL
	diag_log text format["[%1] ALiVE_fnc_crypt <info>: Trace: Line #%2. Benchmark: %3 sec.", round(diag_tickTime), __LINE__, (diag_tickTime - _startTime)];
#endif

/*/ Encrypt & decrypt methods/*/
switch (_method) do
{
	case "rc4":
	{
		_key = toArray(_key);
		
		private ["_keyLen", "_state", "_temp", "_j"];
		_keyLen = count _key;
		_state = [];
		_temp = 0;
		_j = 0;
		
		/*/ Key-Scheduling Algorithm/*/
		for "_i" from 0 to 255 do {_state set [_i,_i]}; 
		for "_i" from 0 to 255 do
		{
			_temp = _state select _i;
			
			_j = (_j + _temp + (_key select (_i mod _keyLen))) mod 256;
			
			_state set [_i, (_state select _j)];
			_state set [_j, _temp];
		};
		
		#ifdef DEBUG_MODE_FULL
			diag_log text format["[%1] ALiVE_fnc_crypt <info>: Trace: Line #%2. Benchmark: %3 sec.", round(diag_tickTime), __LINE__, (diag_tickTime - _startTime)];
		#endif
		
		private ["_temp1", "_temp2", "_rand", "_i", "_mod", "_rbit"];
		_temp1 = 0;
		_temp2 = 0;
		_rand = [];
		_i = 0;
		_j = 0;
		
		/*/ Pseudo-Random Generation Algorithm/*/
		{ /*/ forEach/*/
			_mod = _forEachIndex % MAX_CHAR_SIZE;
			
			if (_mod == 0) then
			{
				_i = (_i + 1) mod 256;
				_j = (_j + (_state select _i)) mod 256;
				
				_temp1 = _state select _i;
				_temp2 = _state select _j;
				
				_state set [_i, _temp2];
				_state set [_j, _temp1];
				
				_rand = [(_state select ((_temp1 + _temp2) mod 256))] call _fnc_intToBin;
			};
			
			_rbit = _rand select _mod;
			_bin set [_forEachIndex, (_x && !_rbit) || {!_x && _rbit}];/*/ XOR/*/
			
		} forEach _bin;
		
		#ifdef DEBUG_MODE_FULL
			diag_log text format["[%1] ALiVE_fnc_crypt <info>: Trace: Line #%2. Benchmark: %3 sec.", round(diag_tickTime), __LINE__, (diag_tickTime - _startTime)];
		#endif
	};
};

private ["_dec", "_buf", "_mod"];
_dec = 0;
_buf = [];

/*/ Convert binary array to UTF-8 string/*/
{ /*/forEach/*/
	_mod = _forEachIndex % MAX_CHAR_SIZE;
	
	if (_x) then {_dec = _dec + 2^((MAX_CHAR_SIZE - 1) - _mod)};
	
	if (_mod == 7) then
	{
		if (_dec == 0) then {_dec = CHAR_ZERO_REP};
		_buf set [(count _buf), _dec];
		_dec = 0;
	};
} forEach _bin;

#ifdef DEBUG_MODE_FULL
	diag_log text format["[%1] ALiVE_fnc_crypt <info>: Processed: %2 bits. Benchmark: %3 sec.", round(diag_tickTime), (count _bin), (diag_tickTime - _startTime)];
#endif

toString(_buf)