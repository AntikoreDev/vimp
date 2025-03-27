event_inherited();

controller = instance_find(obj_controller, 0);
label_text = "Clear List";

on_action = function(){
	controller.clear_song();
	controller.clear_list();
}