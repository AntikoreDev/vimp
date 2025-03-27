function string_rappend(_str, _chr, _count){
	var _new_str = _str;
	var _len = string_length(_str);
	var _diff = _count - _len;
	
	repeat (_diff)
		_new_str += _chr;
		
	return _new_str;

}

function string_lappend(_str, _chr, _count){
	var _new_str = _str;
	var _len = string_length(_str);
	var _diff = _count - _len;
	
	repeat (_diff)
		_new_str = _chr + _new_str;
		
	return _new_str;

}