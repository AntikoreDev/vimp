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

volume = 0.8;
ship = -1;
song = noone;
__pos = 0;
song_pos = 0;
internal_song_pos = 0;
prev_internal_song_pos = 0;
muted = false;

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
}

clear_song = function(){
	if (!is_undefined(playback) && audio_exists(playback)){
		audio_stop_sound(playback);
	}
	
	song = noone; 
	playback = undefined;
	ship = -1;

}

update_tracklist = function(){
	track_list = [];
	array_copy(track_list, 0, original_list, 0, array_length(original_list));
	if (shuffling)
		array_shuffle_ext(track_list);
		
	total_duration = array_reduce(original_list, function(_val, _track){
		return _val + _track.duration;
	}, 0);
}

shuffle = function(_val = !shuffling){
	shuffling = _val;
	update_tracklist();
	
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

render_track_list = function(){
	draw_set_font(fnt_main);
	draw_set_valign(fa_top);
	
	for (var _i = 0; _i < array_length(track_list); _i++){
		var _yy = 40 + (12 * _i);
		var _track = track_list[_i];
		
		var _current = (_i == track_index ? ">> " : "");
		var _pos = string_lappend(string(_i + 1), "0", 3);
		var _title = string_copy(_track.title, 1, min(16, string_length(_track.title))) + (string_length(_track.title) > 16 ? "..." : "");
		var _duration = secs_to_string(_track.duration);
		
		draw_set_halign(fa_right);
		draw_text(room_width - 4, _yy, $"{_current} {_pos} · {_title} · {_duration}");
	}
}