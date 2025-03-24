function assign_ship_index(_origin){
	var _hash = string_upper(_origin);
	var _n = 0;
	for (var _i = 0; _i < string_length(_hash); _i++){
		var _chr = string_char_at(_hash, _i + 1);
		var _val = get_hash_char_value(_chr);
		
		_n = (_n + _val) % 32;
	}
	return _n;
}

function get_hash_char_value(_chr){
	var _chars = "0123456789ABCDEF";
	return string_pos(_chr, _chars);
}