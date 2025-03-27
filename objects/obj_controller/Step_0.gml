var _mouse_hover_bar = point_in_rectangle(mouse_x, mouse_y, 8, room_height - 10, room_width - 8, room_height - 4);
var _mouse_click = mouse_check_button_pressed(mb_left);
var _playing = (!is_undefined(playback) && audio_exists(playback));

run_list_move();

hovering_up_buttons = false;
with (obj_button){
	if (self.is_hovering && self.y < 32){
		other.hovering_up_buttons = true;
		break;
	}
}

if (_mouse_hover_bar && _mouse_click && _playing){
	var _xx = inverse_lerp(mouse_x, 8, room_width - 8);
	show_debug_message(_xx);
	var _pos = _xx * audio_sound_length(playback); 
	audio_sound_set_track_position(playback, _pos);
	song_pos = _pos;
}

if (_playing && !audio_is_paused(playback)){
	internal_song_pos = audio_sound_get_track_position(playback);
	if (internal_song_pos != prev_internal_song_pos){
		song_pos = internal_song_pos;
		prev_internal_song_pos = internal_song_pos;
	}
}

if (!is_undefined(playback) && !audio_is_playing(playback)){
	if (repeat_mode == RepeatMode.RepeatOne){
		select_song(track_index);	
		return;
	}
	
	var _last = array_length(track_list) - 1 == track_index;
	if (repeat_mode == RepeatMode.RepeatAll && _last){
		select_song(0);
		return;
	}
	
	if (_last){
		clear_song();
	}else{
		select_song(track_index + 1);
	}
}