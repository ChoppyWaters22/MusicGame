extends Label
var format_string = "%s was reluctant to learn %s, but now he enjoys it."
var actual_string = format_string % ["Estragon", "GDScript"]
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	set_text(String(get_node("/root/playerinfo").getHP()))	
	pass
	
