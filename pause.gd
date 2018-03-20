extends Panel

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	# set_process(true)
	pass



func _pause():
	if Input.is_action_pressed("ui_start"):
		
		get_tree().set_pause(true);
		get_parent().get_node("pause_popup").show();
		pass
	elif Input.is_action_pressed("ui_start"):
		
		get_tree().set_pause(false);
		get_parent().get_node("pause_popup").hide();
		pass
	
	
func _process(delta):