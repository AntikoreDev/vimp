name = "";
asset = -1;
duration = 0;
path = "";
hash = "";
title = "";

set_song = function(_path){
	path = _path;
	asset = audio_create_stream(path);
	name = filename_name(path);
	title = filename_change_ext(name, "");
	duration = audio_sound_length(asset);
	hash = sha1_file(path);
}
