event_inherited();

controller = instance_find(obj_controller, 0);
label_text = "Show List";

on_action = function(){
	controller.show_list = !controller.show_list;
}

get_label_text = function(){
	return (controller.show_list ? "Hide List" : "Show List");	
}

is_highlighted = function(){
	return controller.show_list;	
}