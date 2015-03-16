/*
Zambino Common Runtime
A library of sane functions for SQF.
Copyright (C) 2014,2015 Jordan Ashley Craw

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
*/

ZCR_PseudoUniqueString ={
	private["_stringLength","_characters","_outputString","_x"];
	_stringLength = _this select 0;

	// Characters we can 
	_characters = [
		"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z",
		"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z",
		"0","1","2","3","4","5","6","7","8","9","!","_","-","&","$","*","(",")","<",">",".",",","{","}"
	];

	// Pre-create the output string
	_outputString = "";

	// Cache so we're not continually counting the array
	_charLength = count _characters;

	// Create the string
	for [{_x= 1},{_x <= _stringLength},{_x = _x + 1}] do
	{
		_outputString = _outputString + (_characters call BIS_fnc_selectRandom);
	};

	// Return it
	_outputString
};


/*
*	ZCR_StrReplaceFragment
*
*	Description:
*	Replaces text in a string.
*/
ZCR_StrReplaceFragment = {
	private["_searchFor","_searchForCache","_searchReplaceWith","_searchIn","_searchInStringArray","_searchInCount","_x","_output"];
	_searchForFrags = _this select 0;
	_searchIn = _this select 1;
	_searchReplaceWith = _this select 2;

	_searchInStringArray = toArray _searchIn;
	_searchInCount = (count _searchInStringArray)-1;

	_output = "";

	// Check the input
	if((typeName _searchForFrags == "STRING" || typeName _searchForFrags == "ARRAY") && typeName _searchReplaceWith == "STRING" && typeName _searchIn == "STRING") then
	{
		// The main scope
		scopeName "main";

		// Loop the SearchIn string
		{	
			// Select the item	
			_thisItem = toString [_x];	
			
			if(typeName _searchForFrags == "ARRAY") then
			{
				_searchForCache = _searchForFrags;
				_itemFound = false;

				{
					if(_x == _thisItem) then
					{
						if(_searchReplaceWith != "") then{
							// Add this replace item 
							_output = _output + _searchReplaceWith;
							_searchForCache = []; // Exit the forEach
							_itemFound = true;
						}
						else
						{
							_searchForCache =[];
							_itemFound = true;
						};	 
					};
				} forEach _searchForFrags;


				if(!_itemFound) then {
					_output = _output + _thisItem;
				};	

			};
		} forEach  _searchInStringArray;
	};

	// Give the string back.
	_output
};


/*
*	ZCR_StrpBrk
*
*	Description:
*	Search a string for the first point where any of the characters specified exist, then return the rest of the string from that point.
*
*	Param0 		STRING 		String to be searched in.
*	Param1 		STRING 		List of characters to search for the first pos of.
*/
ZCR_StrpBrk ={
	private["_searchIn","_searchFor","_beginAppend","_searchInStringArray","_searchForStringArray","_searchInCount","_searchForCount","_y","_x"];
	_searchIn = _this select 0;
	_charList = _this select 1;

	// Get string arrays
	_searchInStringArray = toArray _searchIn;
	_searchForStringArray = toArray _charList;
	_searchInCount = (count _searchInStringArray)-1;
	_searchForCount = (count _searchInStringArray)-1;

	_output = "";

	_beginAppend = false;

	// Loop the SearchIn string
	for "_y" from 0 to _searchInCount do
	{	
		scopeName "main";

		// Select the item	
		_thisItem = toString [(_searchInStringArray select _y)];

		// Search the char array
		if(not(_beginAppend)) then 
		{
			{
				if(toString[_x] == _thisItem) then
				{
					_beginAppend = true;
					_output = _output + _thisItem;
					breakTo "main";
				};

				diag_log(toString [_x]);
				diag_log(_thisItem);
			} forEach _searchForStringArray;
		}
		else
		{
			_output = _output + _thisItem;
		};
	};	

	_output

};


/*
*	ZCR_StrPos
*
*	Description:
*	Returns the first position of a string occurrence. 
*
*	Param0 		STRING 		String to look in
*	Param1 		STRING 		String to look for
*	Param2		SCALAR 		Position to start at 
*/
ZCR_StrPos ={
	private["_searchIn","_searchFor","_searchFrom","_stringArrayIn","_searchInLen","_stringArrayFor","_searchForLen","_stringArrayMatchStart","_thisItem","_thisSearchItem","_stringArrayForPos","_stringArrayIsMatch"];
	_searchIn = _this select 0;
	_searchFor = _this select 1;
	_searchFrom = if(count _this == 3) then {_this select 2} else { 0 };

	scopeName "main";

	_stringArrayIn = toArray _searchIn;
	_searchInLen = (count _stringArrayIn)-1;
	_stringArrayFor = toArray _searchFor;
	_searchForLen = (count _stringArrayFor)-1;
	_stringArrayMatchStart=-1;
	_stringArrayForPos=0;
	_stringArrayIsMatch = [];
	_searchFrom = if(_searchFrom > _searchInLen) then {0} else {_searchFrom};

	// Loop the string
	for "_x" from _searchFrom to _searchInLen do
	{
		// Get the array item
		_thisItem = _stringArrayIn select _x;

		// Get the search item
		_thisSearchItem = _stringArrayFor select _stringArrayForPos;

		if(_thisItem == _thisSearchItem) then
		{
			// Add to match
			_stringArrayIsMatch = _stringArrayIsMatch + [(toString [_thisItem])];

			// Advance pointer
			_stringArrayForPos = if((_stringArrayForPos+1) > _searchForLen) then {_stringArrayForPos} else {_stringArrayForPos +1};

			// No match found yet.
			if((count _stringArrayIsMatch)==1) then
			{	
				_stringArrayMatchStart = _x;
			};

			if((count _stringArrayIsMatch) == _searchForLen) then
			{
				diag_log("SEXPO");
				breakTo "main";
			};

		}
		else
		{
			if((count _stringArrayIsMatch) >0) then
			{
				// Reset -- this string doesn't match any more. i.e. (BAD matching to BAT and _thisItem = "T")
				_stringArrayIsMatch =[];
				_stringArrayForPos = 0;
				_stringArrayMatchStart = -1;
			};
		};
	};

	// Return the match
	_stringArrayMatchStart
};


/*
*	ZCR_Substring
*
*	Description:
*	Returns a part of a string
*
*	Param0 		STRING 		The string to get a substring from
*	Param1 		SCALAR 		Position to start at (0=beginning)
*	Param2		SCALAR 		Position to end at (if >len, will do len)
*/
ZCR_Substring ={
	private["_string","_stringArray","_start","_end","_x","_outArray"];
	_string = _this select 0;
	_start = _this select 1;
	_end = _this select 2;	

	// Convert it to a string
	_stringArray = toArray _string;

	// Default the values
	_start = if(_start <0 || _start > (count _stringArray-1)) then { 0 } else { _start };
	_end = if(_end > (count _stringArray-1) || _end == 0) then { (count _stringArray)-1 } else { _end };

	// Prepare output array
	_outArray = [];

	for "_x" from _start to _end do
	{
		if(_x >= _start && _x <= _end-1) then
		{
			_outArray = _outArray + [(_stringArray select _x)];
		};	
	};

	toString _outArray

};

/*
*	ZCR_Implode
*
*	Description:
*	Converts an array into a string delimited by the "glue" parameter
*
*	Param 0 		ARRAY 		Array to be imploded
*	Param 1 		STRING 		Delimiter to implode by 		
*	
*/
ZCR_Implode = {
	private["_inputArray","_glue","_output"];
	_inputArray = _this select 0;
	_glue = _this select 1;

	_output = "";

	{
		//Seeing is the output is string, we stringify values.
	  	_output = _output + (format["%1",_x] + _glue);
	} forEach _inputArray;

	// Return the output
	_output
};

/*
*	ZCR_StrLen
*
*	Description:
*	Gets the length of a string
*
*	Param 0 	STRING 		The string to check the length of
*	
*/
ZCR_StrLen ={
	(count (toArray _this))
};