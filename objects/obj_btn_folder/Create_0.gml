event_inherited();

controller = instance_find(obj_controller, 0);
label_text = "Add Folder";

image_index = 1;

on_action = function(){
	var _path = get_open_filename_ext("Any files|*.*", "", "C:\\", "Open Folder");
	if (string_trim(_path) != ""){
		controller.add_folder(filename_dir(_path));
	}
}

accelerator = function(){
	return keyboard_check_pressed(ord("O"));	
}