event_inherited();

controller = instance_find(obj_controller, 0);
label_text = "Open List";

on_action = function(){
	var _path = get_open_filename_ext("VIPL Files (.vipl)|*.vipl", "", "C:\\", "Open List");
	if (string_trim(_path) != ""){
		controller.clear_song();
		controller.clear_list();
		controller.add_list(_path);
	}
}