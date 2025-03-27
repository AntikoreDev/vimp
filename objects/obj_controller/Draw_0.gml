draw_set_font(fnt_main);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

if (sprite_exists(ship))
	draw_sprite_ext(ship, 0, room_width / 2, room_height / 2, 5, 5, current_time / 60, c_white, 1);

var _timesprite_idx = is_nighttime(current_hour);
var _daymins = current_minute + (current_hour * 60);
draw_sprite(spr_timesprite, _timesprite_idx, 4, 4);
draw_text(16, 3, $"{secs_to_string(_daymins)}");
draw_text(4, 16, $"{get_weekday(current_weekday)} {current_day} · {get_month_name(current_month)} {current_year}");

draw_set_halign(fa_right);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_text(room_width - 4, 28, "TRACK LIST");
if (!hovering_up_buttons){
	draw_text(room_width - 4, 4, $"{array_length(original_list)} Tracks · {secs_to_string(total_duration)}");
}

render_track_list();

draw_set_halign(fa_center);
draw_set_valign(fa_bottom);
draw_text(room_width / 2, room_height - 12, (instance_exists(song) ? song.title : "< NO SONG SELECTED >"));

draw_sprite_ext(spr_pixel, 0, 8, room_height - 8, room_width - 16, 2, 0, c_gray, 1);
if (!is_undefined(playback) && audio_exists(playback)){
	var _current = lerp(0, room_width - 16, song_pos / audio_sound_length(playback));
	draw_sprite_ext(spr_pixel, 0, 8, room_height - 8, _current, 2, 0, c_white, 1);
}

draw_set_halign(fa_left);
draw_set_valign(fa_bottom);

draw_text(8, room_height - 10, (is_undefined(playback) ? "-:--" : secs_to_string(song_pos)));	
	
draw_set_halign(fa_right);
draw_set_valign(fa_bottom);

draw_text(room_width - 8, room_height - 10,  (is_undefined(playback) ? "-:--" : secs_to_string(audio_sound_length(playback))));	
	