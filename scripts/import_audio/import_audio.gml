function import_audio(_path){
	if (filename_ext(_path) != ".ogg"){
		var _title = filename_name(_path);
			_title = string_replace(_title, filename_ext(_path), "");
		
		if (!directory_exists(program_directory + "/temp"))
			directory_create(program_directory + "/temp");
			
		// convert the file to ogg
		var _target = $"{program_directory}temp\\{_title}.ogg";
		if (file_exists(_target)){
			file_delete(_target);	
		}
		
		var _n = convert_to_ogg(_path, _target);
		return audio_create_stream(_target);
	}
	
	return audio_create_stream(_path);
}