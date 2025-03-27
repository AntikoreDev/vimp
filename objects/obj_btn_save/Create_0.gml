event_inherited();

controller = instance_find(obj_controller, 0);
label_text = "Save Playlist";

on_action = function(){
	var _path = get_save_filename_ext("VIPL File|*.vipl", "my_playlist.vipl", "C:\\", "Save Playlist");
	if (string_trim(_path) != ""){
		var _final_list = [];
		var _track_list = controller.track_list;
		for (var _i = 0; _i < array_length(_track_list); _i++){
			var _track = _track_list[_i];
			array_push(_final_list, _track.path);
		}
		
		file_compressed_save(_path, {
			list: _final_list
		});
	}
}