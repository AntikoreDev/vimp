original_list = [];
track_list = [];
ships = [ 
	spr_skin01, spr_skin02, spr_skin03, spr_skin04, spr_skin05, spr_skin06, spr_skin07, spr_skin08, spr_skin09,
	spr_skin10, spr_skin11, spr_skin12, spr_skin13, spr_skin14, spr_skin15, spr_skin16, spr_skin17, spr_skin18,
	spr_skin19, spr_skin20, spr_skin21, spr_skin22, spr_skin23, spr_skin24, spr_skin25, spr_skin26, spr_skin27,
	spr_skin28, spr_skin29, spr_skin30, spr_skin31, spr_skin32
];

track_index = 0;
shuffling = false;
is_paused = false;
repeat_mode = RepeatMode.NoRepeat;
last_back = 0;
playback = undefined;
hovering_up_buttons = false;
total_duration = 0;
view_init = 0;
view_max = 24;
watch_track = false;
show_list = true;
selected_index = -1;

volume = 0.8;
ship = -1;
song = noone;
__pos = 0;
song_pos = 0;
internal_song_pos = 0;
prev_internal_song_pos = 0;
muted = false;
time_after_click = 0;

get_volume = function(){
	return (muted ? 0 : volume);	
}

update_volume = function(){
	if (!is_undefined(playback) && audio_exists(playback)){
		audio_sound_gain(playback, sqr(get_volume()), 500);	
	}
}


clear_list = function(){
	instance_destroy(obj_song);
	original_list = [];
	track_list = [];
	total_duration = 0;
	view_init = 0;
	selected_index = -1;
}

add_folder = function(_dir){
	var _file = file_find_first(_dir + "/*.ogg", fa_archive);
	while (string_trim(_file) != ""){
		try {
			add_song(_dir + "/" + _file);
		} catch (_e) {}
		_file = file_find_next();
	}
	file_find_close();
}

add_list = function(_path){
	var _content = file_compressed_load(_path, { list: [] });
	var _list = _content.list;
	for (var _i = 0; _i < array_length(_list); _i++){
		var _file = _list[_i];
		try {
			add_song(_file);
		} catch (_e) {}
	}
}

add_song = function(_path){
	var _prev_no_tracks = array_length(original_list) <= 0;
	var _inst = instance_create_layer(0, 0, layer, obj_song);
	_inst.set_song(_path);
	array_push(original_list, _inst);
	update_tracklist();
	
	if (_prev_no_tracks){
		select_song(0);
	}
}

select_song = function(_idx){
	clear_song();
	
	track_index = _idx;
	song = track_list[track_index];
	playback = audio_play_sound(song.asset, 10, false, sqr(get_volume()));
	ship = ships[assign_ship_index(song.hash)];
	is_paused = false;
	
	if (watch_track){
		move_to_track();
	}
}

move_to_track = function(){
	view_init = clamp(track_index - (view_max / 2), 0, max(0, array_length(track_list) - view_max));	
}

move_track = function(_idx, _change, _watch = true){
	__playing = (song.hash);
	var _song = track_list[_idx];
	
	array_delete(track_list, _idx, 1);
	array_insert(track_list, (_idx + _change), _song);

	selected_index += _change;
	
	var _new_idx = array_find_index(track_list, function(_val){
		return _val.hash == __playing;
	});
	
	track_index = _new_idx;
	song = track_list[_new_idx];
	
	if (!shuffling){
		array_copy(original_list, 0, track_list, 0, array_length(track_list));
	}

	if (_watch)
		move_to_track();
}

clear_song = function(){
	if (!is_undefined(playback) && audio_exists(playback)){
		audio_stop_sound(playback);
	}
	
	song = noone; 
	playback = undefined;
	ship = -1;

}

update_tracklist = function(_no_shuffle = false){
	track_list = [];
	array_copy(track_list, 0, original_list, 0, array_length(original_list));
	if (shuffling && !_no_shuffle)
		array_shuffle_ext(track_list);
		
	calculate_total_duration();
}

calculate_total_duration = function(){
	total_duration = array_reduce(original_list, function(_val, _track){
		return _val + _track.duration;
	}, 0);	
}

shuffle = function(_val = !shuffling){
	shuffling = _val;
	update_tracklist();
	selected_index = -1;
	
	var _current_hash = song.hash;
	var _idx = -1;
	for (var _i = 0; _i < array_length(track_list); _i++){
		var _track = track_list[_i];
		if (_track.hash == _current_hash){
			_idx = _i;
			break;
		}
	}
	
	if (_idx > -1){
		track_index = _idx
	}
}

pause = function(_val = !is_paused){
	if (is_undefined(playback))
		return false;
		
	is_paused = _val;
	if (is_paused)
		audio_pause_sound(playback);
	else
		audio_resume_sound(playback);
}

run_list_move = function(){
	if (array_length(track_list) <= 0) return;
	
	var _hovering = point_in_rectangle(mouse_x, mouse_y, room_width - 128, 36, room_width, room_height - 32);
	if (!_hovering) return;
	
	var _mouse = mouse_wheel_down() - mouse_wheel_up();
	var _kb	   = keyboard_check(vk_down) - keyboard_check(vk_up);
	if (_kb != 0 && keyboard_check(vk_alt)){
		view_init = (_kb == 1 ? max(0, array_length(track_list) - view_max) : 0);
		return;
	}
	
	if (keyboard_check(vk_control) || keyboard_check(vk_shift)) return;

	var _dir = (_mouse != 0 ? _mouse : _kb);
	if (_dir == 0) return;
	
	view_init = clamp(view_init + _dir, 0, max(0, array_length(track_list) - view_max));
}

delete_by_index = function(_idx){
	if (_idx < 0) return;
	if (_idx < 0 || _idx >= array_length(original_list)){
		return;	
	}
	
	var _moved_along = false;
	if (track_index > _idx){
		track_index -= 1;	
		_moved_along = true;
	}

	__hash = track_list[_idx].hash;
	var _find_on_original = array_find_index(original_list, function(_val){
		return _val.hash == __hash;
	});
	
	if (_find_on_original < 0) return;
	
	array_delete(original_list, _find_on_original, 1);
	array_delete(track_list, _idx, 1);
	
	calculate_total_duration();
	
	if (track_index == _idx && !_moved_along){
		if (track_index >= array_length(track_list)){
			select_song(_idx - 1);	
		}else{
			select_song(_idx);	
		}
	}
}

run_list_selectable = function(){
	if (!show_list) return;
	
	if (keyboard_check(vk_control)){
		var _vec = keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up);	
		var _after =  selected_index + _vec;
		if (_vec != 0 && !(_after < 0 || _after >= array_length(track_list))){
			move_track(selected_index, _vec, false);	
			follow_selection();
		}
		return;
	}
	else if (keyboard_check(vk_shift)){
		var _vec = keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up);	
		if (_vec != 0){
			selected_index = clamp(selected_index + _vec, 0, array_length(track_list) - 1);
			follow_selection();
		}
		return;
	}
	
	if (keyboard_check_pressed(vk_escape)){
		selected_index = -1;
	}
	
	if (keyboard_check_pressed(vk_delete)){
		delete_by_index(selected_index);
	}
	
	if (keyboard_check_pressed(vk_enter)){
		select_song(selected_index);
		time_after_click = 0;
	}
	
	var _hovering = point_in_rectangle(mouse_x, mouse_y, room_width - 144, 40, room_width, 340);
	if (!_hovering) return;
	
	var _mouse = mouse_check_button_pressed(mb_left);
	var _range = inverse_lerp(mouse_y, 40, 328);
	if (_range < 0 || _range > 1) return;
	
	var _idx = floor(_range * view_max) + view_init;
	if (_mouse && time_after_click > 0 && _idx == selected_index){
		select_song(_idx);
		time_after_click = 0;
	} else if (_mouse && _idx < array_length(track_list) && _idx >= 0){
		time_after_click = 0.3;
		selected_index = _idx;
	}
}

follow_selection = function(){
	if (selected_index < view_init){
		view_init = selected_index;
		return;
	}
	show_debug_message($"{selected_index}, {view_init}, {view_max}")
	if (selected_index >= (view_init + view_max)){
		view_init = clamp((selected_index - view_max) + 1, 0, array_length(track_list) - view_max);
	}	
}

render_track_list = function(){
	draw_set_font(fnt_main);
	draw_set_valign(fa_top);
	
	var _n = 0;
	for (var _i = view_init; _i < array_length(track_list); _i++){
		var _yy = 40 + (12 * _n);
		var _track = track_list[_i];
		
		var _current = (_i == track_index ? ">> " : "");
		var _pos = string_lappend(string(_i + 1), "0", 3);
		var _title = string_copy(_track.title, 1, min(16, string_length(_track.title))) + (string_length(_track.title) > 16 ? "..." : "");
		var _duration = secs_to_string(_track.duration);
		var _c = (selected_index == _i ? c_yellow : c_white);
		
		draw_set_halign(fa_right);
		draw_text_color(room_width - 4, _yy, $"{_current}{_pos} · {_title} · {_duration}", _c, _c, _c, _c, 1);
		
		_n++;
		if (_n >= view_max)
			break;
	}
}