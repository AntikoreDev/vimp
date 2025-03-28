name = "";
asset = -1;
duration = 0;
path = "";
hash = "";
title = "";

set_song = function(_path){
	path = _path;
	name = filename_name(path);
	title = filename_change_ext(name, "");
	asset = import_audio(path);
	hash = sha1_file(path);
	duration = audio_sound_length(asset);
	return 1;
}
