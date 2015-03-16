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


/*
*	ZCR_Array_Reduce
*
*	Description:
*	Iteratively reduces an array to a single value.
*
*	Param 0 		ARRAY 		Array being reduced
*	Param 1 		CODE 		Code with 2 params to be called when reducing the array (Param 0 = Carry,Param 1=Item )
*	Param 2 		ANY 		Value to return if failed.
*/
ZCR_Array_Reduce ={
	private["_inputArray","_callback","_defaultValue"];
	_inputArray =_this select 0;
	_callback = _this select 1;
	_defaultValue =_this select 2;

	// Returned value
	_return = "";

	// Loop through the array
	{
		// Call the code given.
		_return = [_return,_x] call _callback;

	} forEach _inputArray;

	_return

};


/*
*	ZCR_Array_Shuffle
*
*	Description:
*	Shuffles a given array (pseudo-randomly calculated).
*	
*	Param 0 	ARRAY 		Array to shuffle.
*/
ZCR_Array_Shuffle ={
	private["_usedIndexes","_length","_usedIndexes","_calcIndex","_output"];
	if(typeName _this == "ARRAY") then
	{
		_length = (count _this)-1;
		_usedIndexes = [];
		_output =[];

		while 
		{
			(count _usedIndexes) <= _length
		} 
		do 
		{
			_calcIndex = (round random _length);
			if(not(_calcIndex in _usedIndexes)) then
			{
				_usedIndexes = _usedIndexes + [_calcIndex];
				_output = _output + [(_this select _calcIndex)];
			};
		};

		if(true) exitWith{_output};
	}
	else
	{
		if(true) exitWith{[]};
	};

};

/*
*	ZCR_Array_Unique
*
*	Description:
*	Removes duplicate items from an array.
*
*	Param 0 	ARRAY 		Item to remove duplicates from.
*/
ZCR_Array_Unique ={
	if(typeName _this == "ARRAY") then
	{
		_output =[];
		for [{_x=1},{_x<=(count _this-1)},{_x=_x+1}] do
		{
			if(not((_this select _x) in _output)) then
			{
				_output = _output + [(_this select _x)];
			};	
		};
		if(true) exitWith{_output};
	}
	else
	{
		if(true) exitWith{[]};
	};
};

/*
*	ZCR_Array_Pop
*
*	Description:
*	Extracts the last element from the given array.
*
*	Param 0 	ARRAY 		The array to shift the element from.
*/	
ZCR_Array_Pop ={
	if(typeName _this == "ARRAY") then
	{
		// Count the length of the array
		_length = count _this;

		// Prepare for output
		_output =[];

		// Loop through the array backwards..
		for [{_x=_length-2},{_x>=0},{_x=_x-1}] do
		{
			_output set[_x,(_this select _x)];
		};
		if(true) exitWith{_output};
	}
	else
	{
		if(true) exitWith{[]};
	};
};


/*
*	ZCR_Array_Shift
*
*	Description:
*	Extracts the first element from the given array.
*
*	Param 0 	ARRAY 		The array to shift the element from.
*/	
ZCR_Array_Shift ={
	if(typeName _this == "ARRAY") then
	{
		_output =[];
		for [{_x=1},{_x<=(count _this-1)},{_x=_x+1}] do
		{
			_output = _output + [(_this select _x)];
		};
		if(true) exitWith{_output};
	}
	else
	{
		if(true) exitWith{[]};
	};
};

/*
*	ZCR_Array_Slice
*
*	Description:
*	Extracts a set of array items based upon offset and length. 
*
*	Param 0 	ARRAY 		The array to be sliced.
*	Param 1 	NUMBER 		The offset to start the slice from.
*	Param 2 	NUMBER 		The length of the slice.
*/

ZCR_Array_Slice ={
	private["_thisArray","_offset","_length","_x","_output"];
	_thisArray = _this select 0;
	_offset = _this select 1;
	_length = _this select 2;

	_offset = if(_offset > count _thisArray || _offset <0) then { (count _thisArray)-1 } else {_offset};
	_output = [];

	diag_log(format["OFFSET %1, LENGTH %2",_offset,_length]);

	for [{_x=0},{_x<=(count _thisArray-1)},{_x=_x+1}] do
	{
		_offsetcalc = _offset + _length;

		if(_x >= _offset && _x <=(_offset + _length)) then
		{
			_output = _output + [(_thisArray select _x)];
		};
	};

	_output

};

/*
*	ZCR_Array_Intersect
*
*	Description:
*	Provides an array with common elements within given arrays. 
*
*	Param 0 		ARRAY 		The first array to check for common elements with another array
*	Param 1 		ARRAY 		The second array to check for common elements with the first..
*	Param N 		ARRAY 		Additional arrays.
*/
ZCR_Array_Intersect ={
	private["_inputArray","_return","_thisArray","_thisItem","_x"];
	_inputArray = _this select 0;

	if(typeName _this == "ARRAY") then
	{
		_return = [];

		if(count _this >1) then
		{
			// Loop the first array
			{
				for [{_y=1},{_y<=(count _this-1)},{_y=_y+1}] do
				{
					// Select the other arrays in the params..
					_thisArray = _this select _y;

					for [{_z=1},{_z<=(count _thisArray-1)},{_z=_z+1}] do
					{
						// Select the item from the individual array
						_thisItem = _thisArray select _z; 

						if(_thisItem == _x && not(_thisItem in _return)) then
						{
							_return = _return + [_thisItem];
						};
					};
				};

			} forEach _inputArray;
		};

		if(true) exitWith{_return};
	}
	else
	{
		if(true) exitWith{[]};
	};		
};

/*
*	ZCR_Array_Chunk
*
*	Description:
*	Splits an array into an array with chunks.
*
*	Param 0 		ARRAY 		The array to be split
*	Param 1 		NUMBER 		The size of each chunk in items.
*/
ZCR_Array_Chunk ={
	private["_inputArray","_chunkSize","_x","_c","_l","_o","_r","_z","_e"];
	_inputArray = _this select 0;
	_chunkSize	= _this select 1;

	if(typeName _inputArray == "ARRAY" && typeName _chunkSize == "SCALAR") then
	{
		_length = count _inputArray;
		_output=[];
		_chunk=[];
		_chunkSize = if(_chunkSize <1) then { 1 } else {_chunkSize};

		for [{_x=0},{_x<=_length-1},{_x=_x+1}] do
		{
			_r = _x % _chunkSize;

			if(_r == _chunkSize-1 || _x == _length-1) then {
				_chunk = _chunk + [(_inputArray select _x)];
				_output = _output + [_chunk];
				_chunk = [];
			}
			else
			{
				_chunk = _chunk + [(_inputArray select _x)];
			};
		};
		if(true) exitWith{_output};
	}
	else
	{
		if(true) exitWith{false};
	};
};

/*
*	ZCR_Array_Merge
*	
*	Description:
*	Merges multiple arrays
*
*	Param 0 		ARRAY
*	Param 1 		ARRAY
*	Param ..		ARRAY
*/
ZCR_Array_Merge ={
	private["_return"];
	if(typeName _this == "ARRAY") then
	{
		_return = [];
		{
			if(typeName _x == "ARRAY") then
			{
				{
					_return = _return + [_x];
				} forEach _x;
			};
		} forEach _this;

		if(true) exitWith{_return};
	}
	else
	{
		if(true) exitWith{[]};
	};
};

/*
*	ZCR_Array_Fill
*
*	Description:
*	Creates a filled array.
*
*	Param 0 		START_INDEX		Index to start at
*	Param 1 		END_INDEX		Index to end at
*	Param 2 		VALUE 			Value to fill
*/
ZCR_Array_Fill ={
	private["_startIndex","_endIndex","_fillValue","_generateArray","_x"];
	_startIndex = _this select 0;
	_endIndex = _this select 1;
	_fillValue = _this select 2;

	if(typeName _startIndex == "SCALAR" && typeName _endIndex == "SCALAR") then
	{
		_startIndex = if( _startIndex <= 1 ) then {
			1
		} else {
			_startIndex
		};	

		_endIndex = if( _endIndex <= _startIndex ) then {
			_startIndex
		} else {
			_endIndex
		};

		_generateArray = [];

		for [{_x=1},{_x<=_endIndex},{_x=_x+1}] do
		{
			if(_x < _startIndex) then
			{
				_generateArray = _generateArray + [""];
			};
			if(_x >=_startIndex) then
			{
				_fillWith = if(typeName _fillValue == "CODE") then { call _fillValue } else { _fillValue};
				_generateArray = _generateArray + [_fillValue];
			};
		};

		if(true) exitWith{_generateArray};
	}
	else
	{
		if(true) exitWith{[]};
	};
};