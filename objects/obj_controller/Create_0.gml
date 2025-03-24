original_list = [];
track_list = [];

track_index = 0;
shuffling = false;
is_paused = false;
repeat_mode = RepeatMode.NoRepeat;
last_back = 0;

volume = 0.8;
ship = -1;

clear_list = function(){
	instance_destroy(obj_song);
	original_list = [];
	track_list = [];
}