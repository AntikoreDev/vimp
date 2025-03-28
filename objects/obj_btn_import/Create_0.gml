event_inherited();

controller = instance_find(obj_controller, 0);
label_text = "Add File";

on_action = function(){
	var _path = get_open_filename_ext("Audio Files(.ogg, .mp3, .wav)|*.ogg;*.mp3;*.wav|VIPL Files (.vipl)|*.vipl", "", "C:\\", "Open File");
	if (string_trim(_path) != ""){
		var _is_playlist = filename_ext(_path) == ".vipl";
		if (_is_playlist)
			controller.add_list(_path);
		else
			controller.add_song(_path);
	}
}

accelerator = function(){
	return keyboard_check_pressed(ord("I"));	
}