name = "";
asset = -1;
duration = 0;
path = "";

set_song = function(_path){
	path = _path;
	asset = audio_create_stream(path);
	name = filename_name(path);
	duration = audio_sound_length(asset);
}
